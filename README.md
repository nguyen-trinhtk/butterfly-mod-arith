# butterfly-arith


## Example results

- Profile: [results/profile-20261115-091544-26771382/summary.md](results/profile-20261115-091544-26771382/summary.md)
- Benchmark: [results/bench-20261115-090642-26771380/plots/bench.png](results/bench-20261115-090642-26771380/plots/bench.png)
- Disassembly: [results/asm-20261115-090647/](results/asm-20261115-090647/)

## Repo structure

```
.
├── Makefile
├── include/butterfly/
│   ├── arith.h
│   ├── axpy.h
│   ├── addin.h
│   └── simd/
│       ├── simd.h
│       ├── simd256_uint32.inl
│       ├── simd256_uint64.inl
│       ├── simd512_uint32.inl
│       └── simd512_uint64.inl
├── tests/
│   └── check.cpp
├── bench/
│   ├── bench.cpp
│   └── profile.cpp
├── scripts/
│   ├── linbox/
│   │   ├── env.sh
│   │   └── install-linbox.sh
│   ├── bench/
│   │   ├── bench.sh
│   │   └── plot_benchmark.py
│   └── profile/
│       ├── profile.sh
│       ├── profile-table.sh
│       └── asm.sh
└── results/
```


## Code

| File | Contents |
|---|---|
| `arith.h` | Modular arithmetic ops:<br>• `FastOps` (base class: branchless reduction, modular add)<br>&emsp;◦ `BarrettShoupOps`<br>&emsp;◦ `MontgomeryRedcOps`<br>• `FieldCallsOps` (Givaro baseline) |
| `axpy.h` | `prepare()` (precomputes coefficients), `axpy()`: `y[k] = a[k] x[k] + y[k] mod p` |
| `addin.h` | `addin()`: `y[k] = x[k] + y[k] mod p` |
| `simd/simd.h` | SIMD backend selection (AVX-512, AVX2, or scalar) |
| `simd/simd{256,512}_uint{32,64}.inl` | AVX2 / AVX-512 intrinsic wrappers for `uint32_t` / `uint64_t` |

## Build

#### Installing dependencies

```bash
scripts/linbox/install-linbox.sh [package ...]
scripts/linbox/install-linbox.sh givaro    # example
```
package: `ntl`, `givaro`, `fflas-ffpack`, `linbox` (default: all)

#### Building binaries
Binaries: `build/check`, `build/bench`, `build/profile`

```bash
make [variables] [target]
make MARCH=cascadelake SIMD=none build/bench    # example
```
Variables:
- `MARCH`: arch (default: `native`)
- `SIMD=none`: no SIMD (default: AVX-512 or AVX2, whichever `MARCH` supports)
- `CXX`: compiler (default: `g++`)
- `OPT`: optimization flags

## Benchmark

```bash
bash scripts/bench/bench.sh
python3 scripts/bench/plot_benchmark.py [bench.csv] [-o out.png]
python3 scripts/bench/plot_benchmark.py results/bench-20261115-090642-26771380/bench.csv    # example
```
Output: `results/bench-<date>-<job>/`

## Profile

Requires Linux `perf`

```bash
[variables] bash scripts/profile/profile.sh
KERNELS="axpy:barrett addin:fast" LOGNS="12 22" bash scripts/profile/profile.sh    # example
```
Variables:
- `KERNELS`: space-separated `op:variant` pairs (default: `axpy:baseline axpy:barrett axpy:mont addin:baseline addin:fast`)
- `LOGNS`: space-separated log2 of vector length (default: `12 22`)
- `EVENTS`: comma-separated `perf stat` events (default: memory-stall and cache events)

Output: `results/profile-<date>-<job>/`

#### Disassembly generation

```bash
[variables] scripts/profile/asm.sh [op] [variant]
PERF_LOGN=12 MARCH=haswell scripts/profile/asm.sh axpy barrett    # example
```
op (variants): `axpy` (`baseline`, `barrett`, `mont`) or `addin` (`baseline`, `fast`)

Variables:
- `PERF_LOGN`: log2 of vector length, setting this will run `perf record` + `perf annotate` instead of `objdump`
- `MARCH`, `SIMD`, `CXX`, `OPT`: passed to `make`
