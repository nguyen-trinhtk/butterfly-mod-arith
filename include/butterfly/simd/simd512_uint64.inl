namespace Butterfly
{
	// u64: 8 lanes
	template <>
	struct Avx512<uint64_t> : Avx512Base {
		static constexpr size_t lanes = 8;

		static __BUTTERFLY_INLINE Vec set1(uint64_t a) { 
			return _mm512_set1_epi64((long long)a); 
		}
		static __BUTTERFLY_INLINE Vec load(const uint64_t* p) { 
			return _mm512_loadu_si512(p); 
		}

		static __BUTTERFLY_INLINE Vec add(Vec a, Vec b) { 
			return _mm512_add_epi64(a, b); 
		}
		static __BUTTERFLY_INLINE Vec sub(Vec a, Vec b) { 
			return _mm512_sub_epi64(a, b); 
		}
		static __BUTTERFLY_INLINE Vec min(Vec a, Vec b) { 
			return _mm512_min_epu64(a, b); 
		}
		static __BUTTERFLY_INLINE Vec mullo(Vec a, Vec b) { 
			return _mm512_mullo_epi64(a, b); 
		}
		static __BUTTERFLY_INLINE void mulwide(Vec& lo, Vec& hi, Vec a, Vec b)
		{
			// Four 32-bit products: no 64-bit high multiply without IFMA (not on Cascade Lake)
			const Vec m32 = _mm512_set1_epi64(0xffffffff);
			// High bits
			const Vec ah = _mm512_srli_epi64(a, 32);
			const Vec bh = _mm512_srli_epi64(b, 32);
			
			// a b = al_bl + 2^32 (al_bh + ah_bl) + 2^64 ah_bh
			const Vec al_bl = _mm512_mul_epu32(a, b);
			const Vec al_bh = _mm512_mul_epu32(a, bh);
			const Vec ah_bl = _mm512_mul_epu32(ah, b);
			const Vec ah_bh = _mm512_mul_epu32(ah, bh);

			// Bits 32 ... 63 of the product
			// mid is stored as a 64-bit number
			// With hi32 being the carry 
			// and lo32 being the sum
			const Vec mid = _mm512_add_epi64(
				_mm512_add_epi64(
					_mm512_srli_epi64(al_bl, 32), 
					_mm512_and_si512(al_bh, m32)
				),
			    _mm512_and_si512(ah_bl, m32)
			);

			// Low 64-bits = [lo32 mid][low32 al_bl]
			lo = _mm512_or_si512(
				_mm512_and_si512(al_bl, m32), 
				_mm512_slli_epi64(mid, 32)
			);

			// High 64-bits
			hi = _mm512_add_epi64(
					// ah_bh + (hi32 al_bh)
					_mm512_add_epi64(
						ah_bh, 
						_mm512_srli_epi64(al_bh, 32)
					),
					// (hi32 ah_bl) + (carry of mid)
			        _mm512_add_epi64(
						_mm512_srli_epi64(ah_bl, 32), 
						_mm512_srli_epi64(mid, 32)
					)
				);
		}
		static __BUTTERFLY_INLINE Vec mulhi(Vec a, Vec b) { 
			Vec lo, hi; 
			mulwide(lo, hi, a, b); 
			return hi; 
		}
	};
}
