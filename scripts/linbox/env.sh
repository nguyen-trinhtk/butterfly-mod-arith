ARITH_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
LINBOX_PREFIX=${LINBOX_PREFIX:-$ARITH_ROOT/external/install}
export PKG_CONFIG_PATH="$LINBOX_PREFIX/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
export LD_LIBRARY_PATH="$LINBOX_PREFIX/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
export OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1
export OPENCILK_HOME="${OPENCILK_HOME:-$HOME/.local/opencilk}"

PERF_HOME=/ifs/opt/perf/4.18.0-147.8.1/usr
perf() {
    if [[ -x $PERF_HOME/bin/perf ]]; then
        LD_LIBRARY_PATH=$PERF_HOME/lib64:$LD_LIBRARY_PATH "$PERF_HOME/bin/perf" "$@"
    else
        command perf "$@"
    fi
}
