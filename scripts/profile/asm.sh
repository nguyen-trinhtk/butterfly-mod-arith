#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/../.."
source scripts/linbox/env.sh

op=${1:-axpy}
arith=${2:-barrett}
PERF_LOGN=${PERF_LOGN:-}
declare -A OPS=([baseline]=FieldCallsOps [barrett]=BarrettShoupOps [mont]=MontgomeryRedcOps [fast]=FastOps)
if [[ -z ${OPS[$arith]:-} ]]; then
    echo "asm.sh: unknown arith '$arith' (baseline, barrett, mont, fast)" >&2
    exit 1
fi

make -s build/profile

if [[ -z $PERF_LOGN ]]; then
    objdump -d -C -l --no-show-raw-insn build/profile | awk -v pattern="(${op}Kernel|Butterfly::${op}|Butterfly::${op}From)<Butterfly::${OPS[$arith]}[,>]" '
        /^[0-9a-f]+ </ { show = ($0 ~ pattern) }
        show'
else
    data=build/asm-$op-$arith.data
    perf record -q -e cycles:u -o "$data" build/profile "$op" "$arith" "$PERF_LOGN" >&2
    perf annotate -i "$data" --stdio 2>/dev/null | awk '/Source code & Disassembly of/ { sections++ } sections == 1'
fi
