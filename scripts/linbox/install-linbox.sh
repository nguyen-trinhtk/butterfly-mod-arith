#!/bin/bash
set -euo pipefail

NTL_REF=v11.5.1
GIVARO_REF=d6177a25
FFLAS_REF=06aec3f8
LINBOX_REF=60d7d0b

JOBS=${JOBS:-8}
CHECK=${CHECK:-0}
GMP_PREFIX=${GMP_PREFIX:-/usr}
MIRROR=${MIRROR:-}
OPENBLAS=/ifs/opt/openblas/dynamic/0.3.20
if [[ -z ${BLAS_LIBS:-} && -d $OPENBLAS ]]; then
    BLAS_LIBS="-L$OPENBLAS/lib -Wl,-rpath,$OPENBLAS/lib -lopenblas"
    BLAS_CFLAGS="-I$OPENBLAS/include"
fi
BLAS_LIBS=${BLAS_LIBS:--lopenblas}
BLAS_CFLAGS=${BLAS_CFLAGS:-}

root=$(cd "$(dirname "$0")/../.." && pwd)
src=$root/external/src
build=$root/external/build
prefix=$root/external/install
all=(ntl givaro fflas-ffpack linbox)
pkgs=("$@")
if [[ ${#pkgs[@]} -eq 0 ]]; then
    pkgs=("${all[@]}")
fi

die() {
    echo "install-linbox: $*" >&2
    exit 1
}

ref_of() {
    case $1 in
        ntl) echo "$NTL_REF" ;;
        givaro) echo "$GIVARO_REF" ;;
        fflas-ffpack) echo "$FFLAS_REF" ;;
        linbox) echo "$LINBOX_REF" ;;
        *) die "unknown package '$1' (one of: ${all[*]})" ;;
    esac
}

url_of() {
    case $1 in
        ntl) echo "https://github.com/libntl/ntl.git" ;;
        *) echo "https://github.com/linbox-team/$1.git" ;;
    esac
}

for pkg in "${pkgs[@]}"; do
    ref_of "$pkg" >/dev/null
done

export PKG_CONFIG_PATH=$prefix/lib/pkgconfig
export LD_LIBRARY_PATH=$prefix/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
export CC=gcc CXX=g++

if [[ $# -eq 0 ]]; then
    rm -rf "$prefix" "$build"
fi
mkdir -p "$src" "$build" "$prefix/share/stack-info"

fetch() {
    local ref=$1
    if [[ ! -d $src/$pkg/.git ]]; then
        local from
        from=$(url_of "$pkg")
        if [[ -n $MIRROR ]]; then
            from=$MIRROR/$pkg
        fi
        echo "[$(date +%T)] clone $from"
        git clone -q "$from" "$src/$pkg"
    fi
    if ! git -C "$src/$pkg" rev-parse -q --verify "$ref^{commit}" >/dev/null; then
        git -C "$src/$pkg" fetch -q --tags origin
    fi
    git -C "$src/$pkg" rev-parse -q --verify "$ref^{commit}" >/dev/null || die "$pkg: ref $ref not found"
    rm -rf "${build:?}/$pkg"
    mkdir -p "$build/$pkg"
    git -C "$src/$pkg" archive "$ref" | tar -x -C "$build/$pkg"
}

run() {
    local dir=$1
    shift
    echo "+ ($dir) $*" >>"$log"
    if ! (cd "$build/$pkg/$dir" && "$@") >>"$log" 2>&1; then
        tail -n 30 "$log" >&2
        die "$pkg: '$*' failed, full log: $log"
    fi
}

make_install() {
    run "$1" make -j"$JOBS"
    if [[ $CHECK == 1 ]]; then
        run "$1" make check
    fi
    run "$1" make install
}

for pkg in "${pkgs[@]}"; do
    ref=$(ref_of "$pkg")
    log=$build/$pkg.log
    : >"$log"
    echo "[$(date +%T)] $pkg @ $ref"
    fetch "$ref"
    case $pkg in
        ntl)
            run src ./configure PREFIX="$prefix" GMP_PREFIX="$GMP_PREFIX" NTL_GMP_LIP=on \
                NTL_THREADS=on NTL_GF2X_LIB=off SHARED=on TUNE=x86
            make_install src
            ;;
        givaro)
            run . ./autogen.sh --prefix="$prefix"
            make_install .
            ;;
        fflas-ffpack)
            run . ./autogen.sh --prefix="$prefix" --with-givaro="$prefix" \
                --with-blas-libs="$BLAS_LIBS" --with-blas-cflags="$BLAS_CFLAGS"
            make_install .
            ;;
        linbox)
            run . ./autogen.sh --prefix="$prefix" --with-ntl="$prefix" --enable-optimization
            make_install .
            grep -Eq "define +__LINBOX_HAVE_NTL +1" "$prefix/include/linbox/config.h" \
                || die "linbox: configured without NTL, see $log"
            ;;
    esac
    {
        echo "package $pkg"
        echo "ref $ref $(git -C "$src/$pkg" rev-parse "$ref^{commit}")"
        echo "built $(date -Is) on $(hostname), $(g++ --version | awk 'NR == 1')"
    } >"$prefix/share/stack-info/$pkg"
done
echo "[$(date +%T)] done: $prefix (linbox $(pkg-config --modversion linbox 2>/dev/null || echo 'not installed yet'))"
