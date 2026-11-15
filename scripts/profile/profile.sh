#!/bin/bash
#SBATCH --job-name=arith-profile
#SBATCH --partition=def-sm
#SBATCH --exclude=node019,node028,node036
#SBATCH --account=spiralfreeprj
#SBATCH --qos=free
#SBATCH --time=00:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --output=slurm-logs/%x-%j.out

set -euo pipefail
trap 'echo "profile.sh: FAILED at line $LINENO: $BASH_COMMAND" >&2' ERR
cd "${SLURM_SUBMIT_DIR:-$(dirname "$0")/../..}"
source scripts/linbox/env.sh

KERNELS=${KERNELS:-"axpy:baseline axpy:barrett axpy:mont addin:baseline addin:fast"}
LOGNS=${LOGNS:-"12 22"}
if [[ -z ${EVENTS:-} ]]; then
    EVENTS="cycles:u,instructions:u,L1-dcache-load-misses:u,LLC-load-misses:u"
    if perf list 2>/dev/null | grep cycle_activity.stalls_mem_any >/dev/null; then # not grep -q: pipefail + SIGPIPE
        EVENTS="cycles:u,instructions:u,cycle_activity.stalls_mem_any:u,cycle_activity.stalls_l3_miss:u,l1d.replacement:u,l2_rqsts.miss:u"
    fi
fi

if [[ ! -x build/profile ]]; then
    echo "profile.sh: no build/profile, run make first" >&2
    exit 1
fi

# One core: the first CPU this job may use, with the memory of its NUMA node
cpu=$(taskset -cp $$ | sed 's/.*: //; s/[,-].*//')
node=$(lscpu -p=CPU,NODE | awk -F, -v c="$cpu" '$1 == c { print $2 }')
pin=(numactl --physcpubind="$cpu" --membind="$node")

id=$(date +%Y%m%d-%H%M%S)-${SLURM_JOB_ID:-local}
out=results/profile-$id
mkdir -p "$out"
{
    echo "$id on $(hostname), $(date -Is), cpu $cpu (numa node $node)"
    echo "kernels $KERNELS, logns $LOGNS"
    echo "events $EVENTS"
    echo "units: ns and counters per element: one y[k] update (axpy: y[k] += a[k] x[k], addin: y[k] += x[k]), not per switch; a switch is one axpy + one addin"
    echo "build: $(cat build/flags 2>/dev/null || echo unknown)"
    lscpu | grep -E "Model name|Thread|L1d|L2|L3"
} >"$out/info.txt"

echo "op,arith,n,ns,ipc,${EVENTS//:u/}" >"$out/summary.csv"
ops=$(for kernel in $KERNELS; do echo "${kernel%%:*}"; done | awk '!seen[$0]++')
for op in $ops; do
  for logn in $LOGNS; do
    for kernel in $KERNELS; do
        if [[ ${kernel%%:*} != "$op" ]]; then
            continue
        fi
        arith=${kernel##*:}
        name=$op-$arith-n$logn
        echo "[$(date +%T)] $name"
        perf stat -x, -o "$out/$name.stat.csv" -e "$EVENTS" "${pin[@]}" build/profile "$op" "$arith" "$logn" >"$out/$name.out"
        perf record -q -e cycles:u -o "$out/$name.data" "${pin[@]}" build/profile "$op" "$arith" "$logn" >/dev/null
        perf report -i "$out/$name.data" --stdio --sort symbol 2>/dev/null | awk '!/^#/ && NF && ++k <= 10' >"$out/$name.report.txt"  # not head: pipefail + SIGPIPE
        perf annotate -i "$out/$name.data" --stdio 2>/dev/null \
            | awk '/Source code & Disassembly of/ { sections++ } sections == 1' >"$out/$name.annotate.txt"

        awk -F, -v op="$op" -v arith="$arith" -v n=$((1 << logn)) -v events="$EVENTS" '
            FNR == NR {
                match($0, /elements [0-9]+/)
                split(substr($0, RSTART, RLENGTH), words, " ")
                elements = words[2]
                match($0, /[0-9.]+ ns per element/)
                split(substr($0, RSTART, RLENGTH), words, " ")
                ns = words[1]
                next
            }
            /^[0-9]/ { count[$3] = $1 }
            END {
                split(events, names, ",")
                ipc = count["cycles:u"] > 0 ? count["instructions:u"] / count["cycles:u"] : 0
                line = op "," arith "," n "," ns "," sprintf("%.2f", ipc)
                for (i = 1; i in names; i++)
                    line = line "," sprintf("%.4f", count[names[i]] / elements)
                print line
            }' "$out/$name.out" "$out/$name.stat.csv" >>"$out/summary.csv"
    done
  done
done
scripts/profile/profile-table.sh "$out"  # summary.md

echo "[$(date +%T)] done: $out (summary.csv, summary.md)"
echo "ns and counters per element: one y[k] update (axpy: y[k] += a[k] x[k], addin: y[k] += x[k]), not per switch; a switch is one axpy + one addin"
column -t -s, "$out/summary.csv"
