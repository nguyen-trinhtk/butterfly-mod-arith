// Usage:
//   profile axpy baseline|barrett|mont LOGN
//   profile addin baseline|fast LOGN

#include <chrono>
#include <cstdint>
#include <cstdio>
#include <random>
#include <string>
#include <vector>

#include <givaro/modular.h>

#include "butterfly/addin.h"
#include "butterfly/axpy.h"

typedef Givaro::Modular<uint64_t, unsigned __int128> Field;
const uint64_t prime = (uint64_t(1) << 60) - 93;

// typedef Givaro::Modular<uint32_t, uint64_t> Field;
// const uint32_t prime = (uint64_t(1) << 30) + 3;

typedef Field::Element Element;

const double seconds = 3;

// The kernels, out of line so that perf and objdump show each under its own name
template <template <class, class> class Ops>
__attribute__((noinline)) void axpyKernel(const Field& F, const std::vector<Element> bank[2], const Element* x, Element* y, size_t n) {
	Butterfly::axpy<Ops>(F, bank, x, y, n);
}

template <template <class, class> class Ops>
__attribute__((noinline)) void addinKernel(const Field& F, const Element* x, Element* y, size_t n) {
	Butterfly::addin<Ops>(F, x, y, n);
}

double since(std::chrono::steady_clock::time_point start) {
	return std::chrono::duration<double>(std::chrono::steady_clock::now() - start).count();
}

// Calls run() until `seconds` have passed
template <class Op>
void loop(size_t n, double setupSeconds, Op run) {
	size_t calls = 0;
	auto start = std::chrono::steady_clock::now();
	while (since(start) < seconds) {
		run();
		calls++;
	}
	double loopSeconds = since(start);
	double elements = double(calls) * double(n);
	printf("setup %.3f s, loop %.3f s, %zu calls, elements %.0f, %.3f ns per element\n",
	       setupSeconds, loopSeconds, calls, elements, loopSeconds * 1e9 / elements);
}

template <template <class, class> class Ops>
void profileAxpy(const Field& F, const std::vector<Element>& a, const std::vector<Element>& x, std::vector<Element>& y,
                 std::chrono::steady_clock::time_point setupStart) {
	std::vector<Element> bank[2];
	Butterfly::prepare<Ops>(F, a, bank);
	loop(x.size(), since(setupStart), [&] {
		axpyKernel<Ops>(F, bank, x.data(), y.data(), x.size());
	});
}

template <template <class, class> class Ops>
void profileAddin(const Field& F, const std::vector<Element>& x, std::vector<Element>& y,
                  std::chrono::steady_clock::time_point setupStart) {
	loop(x.size(), since(setupStart), [&] {
		addinKernel<Ops>(F, x.data(), y.data(), x.size());
	});
}

int main(int argc, char** argv) {
	if (argc != 4) {
		fprintf(stderr, "usage: profile axpy baseline|barrett|mont LOGN, or profile addin baseline|fast LOGN\n");
		return 1;
	}
	const std::string op = argv[1];
	const std::string arith = argv[2];
	const size_t n = size_t(1) << std::stoi(argv[3]);

	auto setupStart = std::chrono::steady_clock::now();
	const Field F(prime);
	std::mt19937_64 random(42);
	std::vector<Element> a(n), x(n), y(n);
	for (size_t k = 0; k < n; k++) {
		a[k] = random() % prime;
		x[k] = random() % prime;
		y[k] = random() % prime;
	}

	if (op == "axpy" && arith == "baseline")
		profileAxpy<Butterfly::FieldCallsOps>(F, a, x, y, setupStart);
	else if (op == "axpy" && arith == "barrett")
		profileAxpy<Butterfly::BarrettShoupOps>(F, a, x, y, setupStart);
	else if (op == "axpy" && arith == "mont")
		profileAxpy<Butterfly::MontgomeryRedcOps>(F, a, x, y, setupStart);
	else if (op == "addin" && arith == "baseline")
		profileAddin<Butterfly::FieldCallsOps>(F, x, y, setupStart);
	else if (op == "addin" && arith == "fast")
		profileAddin<Butterfly::FastOps>(F, x, y, setupStart);
	else {
		fprintf(stderr, "profile: no kernel '%s %s'\n", op.c_str(), arith.c_str());
		return 1;
	}
	return 0;
}
