#!/bin/bash
#SBATCH --job-name=arith-bench
#SBATCH --partition=def-sm
#SBATCH --exclude=node019,node028,node036
#SBATCH --account=spiralfreeprj
#SBATCH --qos=free
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --output=slurm-logs/%x-%j.out

set -euo pipefail
trap 'echo "bench.sh: FAILED at line $LINENO: $BASH_COMMAND" >&2' ERR
cd "${SLURM_SUBMIT_DIR:-$(dirname "$0")/../..}"
source scripts/linbox/env.sh

if [[ ! -x build/check || ! -x build/bench ]]; then
    echo "bench.sh: no build/check or build/bench, run make first" >&2
    exit 1
fi

cpu=$(taskset -cp $$ | sed 's/.*: //; s/[,-].*//')
node=$(lscpu -p=CPU,NODE | awk -F, -v c="$cpu" '$1 == c { print $2 }')
pin=(numactl --physcpubind="$cpu" --membind="$node")

id=$(date +%Y%m%d-%H%M%S)-${SLURM_JOB_ID:-local}
out=results/bench-$id
mkdir -p "$out"
{
    echo "$id on $(hostname), $(date -Is), cpu $cpu (numa node $node)"
    echo "units: ns, cycles, instructions per element: one y[k] update (axpy: y[k] += a[k] x[k], addin: y[k] += x[k]), not per switch; a switch is one axpy + one addin"
    echo "commit $(git rev-parse --short HEAD 2>/dev/null || echo none)"
    git status --short 2>/dev/null | awk 'NR <= 20'
    echo "build: $(cat build/flags 2>/dev/null || echo unknown)"
    lscpu | grep -E "Model name|Thread|L1d|L2|L3"
} >"$out/info.txt"

build/check
echo "[$(date +%T)] bench -> $out/bench.csv (per element: one y[k] update (axpy: y[k] += a[k] x[k], addin: y[k] += x[k]), not per switch; a switch is one axpy + one addin)"
"${pin[@]}" build/bench >"$out/bench.csv"
echo "[$(date +%T)] done"
