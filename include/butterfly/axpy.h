#ifndef __BUTTERFLY_axpy_H
#define __BUTTERFLY_axpy_H

#include <cstddef>
#include <vector>
#include "arith.h"

namespace Butterfly
{
	// Prepare coefficients in bank
	// Bank stores coeff in a SoA manner: 
	// [ a0 a1 ... aD ][ a'0 a'1 ... a'D ]
	template <template <class, class> class Ops, class Field>
	void prepare(const Field& F, const std::vector<typename Field::Element>& a, std::vector<typename Field::Element> bank[2])
	{
		typedef typename Field::Element Element;
		bank[0].resize(a.size());
		bank[1].resize(a.size());
		for (size_t k = 0; k < a.size(); k++)
			Ops<Field, Scalar<Element>>::prepare(F, a[k], bank[0][k], bank[1][k]);
	}

	// (Possibly vectorized) in-place axpy from K to (N - N%LANE - 1)	
	template <template <class, class> class Ops, class SimdType, class Field, class Element>
	__BUTTERFLY_INLINE size_t axpyFrom(const Field& F, const Element* const bank[2], const Element* x, Element* y, size_t k, size_t n)
	{
		const Ops<Field, SimdType> ops(F);
		typedef typename Ops<Field, SimdType>::Simd Simd; // FieldCallsOps is always Scalar
		while (k + Simd::lanes <= n) {
			typename Simd::Vec r = Simd::load(y + k);
			ops.axpyin(r, ops.coeff(bank, k), Simd::load(x + k));
			Simd::store(y + k, r);
			k += Simd::lanes;
		}
		return k;
	}

	// y[k] := a[k] x[k] + y[k] mod p
	template <template <class, class> class Ops, class Field>
	void axpy(const Field& F, const std::vector<typename Field::Element> bank[2],
	          const typename Field::Element* x, typename Field::Element* y, size_t n)
	{
		typedef typename Field::Element Element;
		const Element* const words[2] = {bank[0].data(), bank[1].data()};
		size_t k = axpyFrom<Ops, Default<Element>>(F, words, x, y, 0, n);
		axpyFrom<Ops, Scalar<Element>>(F, words, x, y, k, n); // the last n mod lanes elements
	}
}

#endif // __BUTTERFLY_axpy_H
