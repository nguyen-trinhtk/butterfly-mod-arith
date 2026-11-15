#ifndef __BUTTERFLY_arith_H
#define __BUTTERFLY_arith_H

#include <cstdint>
#include <givaro/modular.h>
#include "simd/simd.h"

// y = a x + y mod p, for coefficients a known ahead of time.
// BarrettShoupOps and MontgomeryRedcOps need Field = Givaro::Modular<uint32_t or uint64_t>
// with an odd p < 2^(W-1), and keep every value in [0, p).

namespace Butterfly
{
	// Shared by the fast ops: p in every lane and the branchless reductions
	template <class Field, class SimdType>
	struct FastOps {
		typedef SimdType Simd;
		typedef typename Field::Element Element;
		typedef typename Simd::Vec Vec;
		typedef typename WideOf<Element>::type Wide;
		static constexpr unsigned W = 8 * sizeof(Element);

		static Element prime(const Field& F) {
			return Element(F.characteristic());
		}

		static bool supports(const Field& F) {
			const Element p = prime(F);
			return p % 2 == 1 && p < (Element(1) << (W - 1));
		}

		explicit FastOps(const Field& F) : p(Simd::set1(prime(F))) {}

		// [0, 2p) -> [0, p)
		__BUTTERFLY_INLINE Vec reduce(Vec r) const {
			return Simd::min(r, Simd::sub(r, p));
		}

		// (-p, p) -> [0, p), negative values wrapped around 2^W
		__BUTTERFLY_INLINE Vec lift(Vec r) const {
			return Simd::min(r, Simd::add(r, p));
		}

		// y = x + y, with x and y in [0, p)
		__BUTTERFLY_INLINE void addin(Vec& y, Vec x) const
		{
			y = reduce(Simd::add(y, x));
		}

		Vec p;
	};

	// Shoup's Barrett: store a and a' = floor(a 2^W / p)
	template <class Field, class SimdType>
	struct BarrettShoupOps : FastOps<Field, SimdType> {
		typedef FastOps<Field, SimdType> Base;
		typedef SimdType Simd;
		typedef typename Base::Element Element;
		typedef typename Base::Vec Vec;
		typedef typename Base::Wide Wide;

		struct Coeff {
			Vec a, ap;
		};

		static void prepare(const Field& F, Element a, Element& w0, Element& w1) {
			w0 = a;
			w1 = Element((Wide(a) << Base::W) / Base::prime(F));
		}

		explicit BarrettShoupOps(const Field& F) : Base(F) {}

		__BUTTERFLY_INLINE Coeff coeff(const Element* const bank[2], size_t k) const {
			return {Simd::load(bank[0] + k), Simd::load(bank[1] + k)};
		}

		__BUTTERFLY_INLINE Vec mul(const Coeff& c, Vec x) const {
			Vec q = Simd::mulhi(c.ap, x);
			Vec r = Simd::sub(Simd::mullo(c.a, x), Simd::mullo(q, this->p));
			return this->reduce(r);
		}

		__BUTTERFLY_INLINE void axpyin(Vec& y, const Coeff& c, Vec x) const {
			this->addin(y, mul(c, x));
		}
	};

	// Montgomery: store a*2^W mod p 
	// Field need not be Montgomery
	template <class Field, class SimdType>
	struct MontgomeryRedcOps : FastOps<Field, SimdType> {
		typedef FastOps<Field, SimdType> Base;
		typedef SimdType Simd;
		typedef typename Base::Element Element;
		typedef typename Base::Vec Vec;
		typedef typename Base::Wide Wide;
		typedef Vec Coeff;

		static void prepare(const Field& F, Element a, Element& w0, Element& w1) {
			w0 = Element((Wide(a) << Base::W) % Base::prime(F));
			w1 = 0;
		}

		explicit MontgomeryRedcOps(const Field& F) : Base(F), pinv(Simd::set1(inverse(Base::prime(F)))) {}

		__BUTTERFLY_INLINE Coeff coeff(const Element* const bank[2], size_t k) const {
			return Simd::load(bank[0] + k);
		}

		__BUTTERFLY_INLINE Vec mul(const Coeff& c, Vec x) const {
			Vec lo, hi;
			Simd::mulwide(lo, hi, c, x);
			Vec m = Simd::mullo(lo, pinv);
			return this->lift(Simd::sub(hi, Simd::mulhi(m, this->p)));
		}

		__BUTTERFLY_INLINE void axpyin(Vec& y, const Coeff& c, Vec x) const {
			this->addin(y, mul(c, x));
		}

		// p^-1 mod 2^W via iterative Newton-Raphson
		static Element inverse(Element p) {
			Element v = p;
			for (int i = 0; i < 5; i++)
				v = Element(v * Element(2 - p * v));
			return v;
		}

		Vec pinv;
	};

	// Wrapper for Givaro's (or NTL's) own field operations
	template <class Field, class UnusedSimd>
	struct FieldCallsOps {
		typedef typename Field::Element Element;
		typedef Scalar<Element> Simd;
		typedef Element Vec;
		typedef Element Coeff;

		static bool supports(const Field&) {
			return true;
		}

		static void prepare(const Field&, Element a, Element& w0, Element& w1) {
			w0 = a;
			w1 = 0;
		}

		explicit FieldCallsOps(const Field& F) : field(F) {}

		__BUTTERFLY_INLINE Coeff coeff(const Element* const bank[2], size_t k) const {
			return bank[0][k];
		}

		__BUTTERFLY_INLINE void addin(Vec& y, Vec x) const {
			field.addin(y, x);
		}

		__BUTTERFLY_INLINE void axpyin(Vec& y, Coeff a, Vec x) const {
			field.axpyin(y, a, x);
		}

		const Field& field;
	};
}

#endif // __BUTTERFLY_arith_H
