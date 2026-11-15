#include <linux/perf_event.h>
#include <sys/syscall.h>
#include <unistd.h>

#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstring>
#include <random>
#include <vector>

#include <givaro/modular.h>

#include "butterfly/addin.h"
#include "butterfly/axpy.h"

typedef Givaro::Modular<uint64_t, unsigned __int128> Field;
const uint64_t prime = (uint64_t(1) << 60) - 93;

// typedef Givaro::Modular<uint32_t, uint64_t> Field;
// const uint32_t prime = (uint64_t(1) << 30) + 3;

typedef Field::Element Element;

const int logMin = 10; // 2^10
const int logMax = 24; // 2^24

const int numRuns = 5;

const int warmupIters = 10; 
const int numIters = 100;

// Hardware counter (user space only)
struct Counter {
	int fd;

	explicit Counter(uint64_t event) {
		perf_event_attr attr;
		memset(&attr, 0, sizeof attr);
		attr.size = sizeof attr;
		attr.type = PERF_TYPE_HARDWARE;
		attr.config = event;
		attr.exclude_kernel = 1;
		attr.exclude_hv = 1;
		fd = int(syscall(SYS_perf_event_open, &attr, 0, -1, -1, 0));
	}

	uint64_t read() const {
		uint64_t value = 0;
		if (fd < 0 || ::read(fd, &value, sizeof value) != ssize_t(sizeof value))
			return 0;
		return value;
	}
};

// Count clock cycles & instructions
Counter cycles(PERF_COUNT_HW_CPU_CYCLES);
Counter instructions(PERF_COUNT_HW_INSTRUCTIONS);

template <class Op>
void measure(const char* op, const char* arith, size_t n, Op run) {
	const double elements = double(numIters) * double(n);
	for (int i = 0; i < warmupIters; i++)
		run();

	double bestNs = 1e300;
	double bestCycles = 0;
	double bestInstructions = 0;

	for (int r = 0; r < numRuns; r++) {
		uint64_t cycles0 = cycles.read();
		uint64_t instructions0 = instructions.read();
		auto start = std::chrono::steady_clock::now();
		for (int i = 0; i < numIters; i++)
			run();
		auto stop = std::chrono::steady_clock::now();
		uint64_t cycles1 = cycles.read();
		uint64_t instructions1 = instructions.read();

		double ns = std::chrono::duration<double, std::nano>(stop - start).count() / elements;
		if (ns < bestNs) {
			bestNs = ns;
			bestCycles = double(cycles1 - cycles0) / elements;
			bestInstructions = double(instructions1 - instructions0) / elements;
		}
	}
	printf("%s,%s,%zu,%.3f,%.2f,%.2f\n", op, arith, n, bestNs, bestCycles, bestInstructions);
	fflush(stdout);
}

// Benchmark wrappers
template <template <class, class> class Ops>
void benchAxpy(const Field& F, const char* arith, const std::vector<Element>& a, const std::vector<Element>& x, std::vector<Element>& y) {
	std::vector<Element> bank[2];
	Butterfly::prepare<Ops>(F, a, bank); // not timed
	measure("axpy", arith, x.size(), [&] {
		Butterfly::axpy<Ops>(F, bank, x.data(), y.data(), x.size());
	});
}

template <template <class, class> class Ops>
void benchAddin(const Field& F, const char* arith, const std::vector<Element>& x, std::vector<Element>& y) {
	measure("addin", arith, x.size(), [&] {
		Butterfly::addin<Ops>(F, x.data(), y.data(), x.size());
	});
}

int main() {
	const Field F(prime);
	std::mt19937_64 random(42);

	printf("op,arith,n,ns,cycles,instructions\n");
	for (int logn = logMin; logn <= logMax; logn++) {
		const size_t n = size_t(1) << logn;
		std::vector<Element> a(n), x(n), y(n);
		for (size_t k = 0; k < n; k++) {
			a[k] = random() % prime;
			x[k] = random() % prime;
			y[k] = random() % prime;
		}

		benchAxpy<Butterfly::FieldCallsOps>(F, "baseline", a, x, y);
		benchAxpy<Butterfly::BarrettShoupOps>(F, "barrett", a, x, y);
		benchAxpy<Butterfly::MontgomeryRedcOps>(F, "mont", a, x, y);
		benchAddin<Butterfly::FieldCallsOps>(F, "baseline", x, y);
		benchAddin<Butterfly::FastOps>(F, "fast", x, y);
	}
	return 0;
}
