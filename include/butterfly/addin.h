#ifndef __BUTTERFLY_addin_H
#define __BUTTERFLY_addin_H

#include <cstddef>
#include "arith.h"

namespace Butterfly
{
	// (Possibly vectorized) in-place add from K to (N - N%LANE - 1)	
	template <template <class, class> class Ops, class SimdType, class Field, class Element>
	__BUTTERFLY_INLINE size_t addinFrom(const Field& F, const Element* x, Element* y, size_t k, size_t n)
	{
		const Ops<Field, SimdType> ops(F);
		typedef typename Ops<Field, SimdType>::Simd Simd; // FieldCallsOps is always Scalar
		while (k + Simd::lanes <= n) {
			typename Simd::Vec r = Simd::load(y + k);
			ops.addin(r, Simd::load(x + k));
			Simd::store(y + k, r);
			k += Simd::lanes;
		}
		return k; // return last index
	}

	// y[k] = x[k] + y[k] mod p
	template <template <class, class> class Ops, class Field>
	void addin(const Field& F, const typename Field::Element* x, typename Field::Element* y, size_t n)
	{
		typedef typename Field::Element Element;
		size_t k = addinFrom<Ops, Default<Element>>(F, x, y, 0, n);
		addinFrom<Ops, Scalar<Element>>(F, x, y, k, n); // the last n mod lanes elements
	}
}

#endif // __BUTTERFLY_addin_H
