// Check against Givaro's implementation

#include <cstdint>
#include <iostream>
#include <random>
#include <vector>

#include <givaro/modular.h>

#include "butterfly/addin.h"
#include "butterfly/axpy.h"

template <class Word>
using WordField = Givaro::Modular<Word, typename std::conditional<sizeof(Word) == 4, uint64_t, unsigned __int128>::type>;

template <class Field>
std::vector<typename Field::Element> randomVector(const Field& F, size_t n, uint64_t seed)
{
    std::mt19937_64 generator(seed);
    std::vector<typename Field::Element> x(n);
    for (size_t k = 0; k < n; k++)
        x[k] = typename Field::Element(generator() % uint64_t(F.characteristic()));
    return x;
}

size_t numChecks = 0;
size_t numFails = 0;

template <class Field>
void compare(const Field& F, const char* name, const std::vector<typename Field::Element>& y,
             const std::vector<typename Field::Element>& expected)
{
    numChecks++;
    for (size_t k = 0; k < y.size(); k++) {
        if (y[k] != expected[k]) {
            std::cerr << "FAIL " << name << " p=" << uint64_t(F.characteristic()) << " n=" << y.size() << " k=" << k
                      << ": got " << uint64_t(y[k]) << ", expected " << uint64_t(expected[k]) << std::endl;
            numFails++;
            return;
        }
    }
}

template <template <class, class> class Ops, class Field>
void checkAxpy(const Field& F, const char* name)
{
    typedef typename Field::Element Element;
    if (!Ops<Field, Butterfly::Scalar<Element>>::supports(F))
        return;

    for (size_t n : {1, 7, 64, 1000, 4099}) {
        std::vector<Element> a = randomVector(F, n, 1);
        std::vector<Element> x = randomVector(F, n, 2);
        std::vector<Element> y = randomVector(F, n, 3);

        std::vector<Element> expected = y;
        for (size_t k = 0; k < n; k++)
            F.axpyin(expected[k], a[k], x[k]);

        std::vector<Element> bank[2];
        Butterfly::prepare<Ops>(F, a, bank);
        Butterfly::axpy<Ops>(F, bank, x.data(), y.data(), n);
        compare(F, name, y, expected);
    }
}

template <template <class, class> class Ops, class Field>
void checkAddin(const Field& F, const char* name)
{
    typedef typename Field::Element Element;
    if (!Ops<Field, Butterfly::Scalar<Element>>::supports(F))
        return;

    for (size_t n : {1, 7, 64, 1000, 4099}) {
        std::vector<Element> x = randomVector(F, n, 2);
        std::vector<Element> y = randomVector(F, n, 3);

        std::vector<Element> expected = y;
        for (size_t k = 0; k < n; k++)
            F.addin(expected[k], x[k]);

        Butterfly::addin<Ops>(F, x.data(), y.data(), n);
        compare(F, name, y, expected);
    }
}

template <class Word>
void checkPrime(uint64_t p)
{
    const WordField<Word> F(static_cast<Word>(p));
    checkAxpy<Butterfly::FieldCallsOps>(F, "axpy baseline");
    checkAxpy<Butterfly::BarrettShoupOps>(F, "axpy barrett");
    checkAxpy<Butterfly::MontgomeryRedcOps>(F, "axpy mont");
    checkAddin<Butterfly::FieldCallsOps>(F, "addin baseline");
    checkAddin<Butterfly::FastOps>(F, "addin fast");
}

int main()
{
    for (uint64_t p : {uint64_t(3), uint64_t(65521), (uint64_t(1) << 30) + 3, (uint64_t(1) << 31) - 1})
        checkPrime<uint32_t>(p);
    for (uint64_t p : {uint64_t(3), (uint64_t(1) << 31) - 1, (uint64_t(1) << 60) - 93, (uint64_t(1) << 62) + 135, (uint64_t(1) << 63) - 25})
        checkPrime<uint64_t>(p);

    std::cout << numChecks << " checks, " << numFails << " failed" << std::endl;
    if (numFails > 0)
        return 1;
    return 0;
}
