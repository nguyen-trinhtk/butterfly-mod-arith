#!/bin/bash
# <dir>/summary.csv -> <dir>/summary.md: one markdown table per op, with speedup over baseline at the same n.
# Run by profile.sh; also by hand on an existing result:
#   scripts/profile/profile-table.sh results/profile-<date>-<job>

set -euo pipefail

dir=${1:?usage: scripts/profile/profile-table.sh results/profile-<date>-<job>}

awk -F, '
    NR == 1 { for (i = 1; i <= NF; i++) header[i] = $i; cols = NF; next }
    {
        row[NR] = $0
        if ($2 == "baseline") base[$1 "," $3] = $4
        if (!($1 in seen)) { seen[$1] = 1; order[++ops] = $1 }
    }
    END {
        for (o = 1; o <= ops; o++) {
            op = order[o]
            printf "%s## %s\n\n| n | arith | ns | speedup", (o > 1 ? "\n" : ""), op
            for (i = 5; i <= cols; i++) printf " | %s", header[i]
            printf " |\n|--:|---|--:|--:"
            for (i = 5; i <= cols; i++) printf "|--:"
            printf "|\n"
            for (r = 2; r <= NR; r++) {
                split(row[r], f, ",")
                if (f[1] != op) continue
                key = f[1] "," f[3]
                speedup = (key in base) && f[4] > 0 ? sprintf("%.2f", base[key] / f[4]) : "-"
                printf "| 2^%d | %s | %s | %s", int(log(f[3]) / log(2) + 0.5), f[2], f[4], speedup
                for (i = 5; i <= cols; i++) printf " | %s", f[i]
                printf " |\n"
            }
        }
    }' "$dir/summary.csv" >"$dir/summary.md"
