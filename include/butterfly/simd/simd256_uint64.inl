namespace Butterfly
{
	// u64: 4 lanes
	template <>
	struct Avx2<uint64_t> : Avx2Base {
		static constexpr size_t lanes = 4;

		static __BUTTERFLY_INLINE Vec set1(uint64_t a) { 
			return _mm256_set1_epi64x((long long)a); 
		}
		static __BUTTERFLY_INLINE Vec load(const uint64_t* p) { 
			return _mm256_loadu_si256(reinterpret_cast<const __m256i*>(p)); 
		}

		static __BUTTERFLY_INLINE Vec add(Vec a, Vec b) { 
			return _mm256_add_epi64(a, b); 
		}
		static __BUTTERFLY_INLINE Vec sub(Vec a, Vec b) { 
			return _mm256_sub_epi64(a, b); 
		}
		
		// No hardware min u64 instructions
		static __BUTTERFLY_INLINE Vec min(Vec a, Vec b)
		{
			// Mask for MSB
			const Vec s = _mm256_set1_epi64x((long long)(uint64_t(1) << 63));
			// Pick a if cond = 0, else pick b
			return _mm256_blendv_epi8(
				a, b, 
				// (a > b) ? b : a
				_mm256_cmpgt_epi64(
					// flip MSB for correct signed compare
					_mm256_xor_si256(a, s),
					_mm256_xor_si256(b, s)
				)
			);
		}
		static __BUTTERFLY_INLINE Vec mullo(Vec a, Vec b)
		{
			// Not all extensions have 64-bit mullo
			const Vec cross = _mm256_add_epi64(
				// al_bh + ah_bl all lanes
				_mm256_mul_epu32(
					a, 
					_mm256_srli_epi64(b, 32)
				), 
				_mm256_mul_epu32(
					_mm256_srli_epi64(a, 32), 
					b
				)
			);
			return _mm256_add_epi64(
				_mm256_mul_epu32(a, b), // al_bl
				_mm256_slli_epi64(cross, 32) // lo32(al_bh + ah_bl)
			);
		}
		static __BUTTERFLY_INLINE void mulwide(Vec& lo, Vec& hi, Vec a, Vec b)
		{
			// Four 32-bit products: no 64-bit high multiply without IFMA (not on Cascade Lake)
			const Vec m32 = _mm256_set1_epi64x(0xffffffff);
			// High bits
			const Vec ah = _mm256_srli_epi64(a, 32);
			const Vec bh = _mm256_srli_epi64(b, 32);
			
			// a b = al_bl + 2^32 (al_bh + ah_bl) + 2^64 ah_bh
			const Vec al_bl = _mm256_mul_epu32(a, b);
			const Vec al_bh = _mm256_mul_epu32(a, bh);
			const Vec ah_bl = _mm256_mul_epu32(ah, b);
			const Vec ah_bh = _mm256_mul_epu32(ah, bh);

			// Bits 32 ... 63 of the product
			// mid is stored as a 64-bit number
			// With hi32 being the carry 
			// and lo32 being the sum
			const Vec mid = _mm256_add_epi64(
				_mm256_add_epi64(
					_mm256_srli_epi64(al_bl, 32), 
					_mm256_and_si256(al_bh, m32)
				),
			    _mm256_and_si256(ah_bl, m32)
			);

			// Low 64-bits = [lo32 mid][low32 al_bl]
			lo = _mm256_or_si256(
				_mm256_and_si256(al_bl, m32), 
				_mm256_slli_epi64(mid, 32)
			);

			// High 64-bits
			hi = _mm256_add_epi64(
					// ah_bh + (hi32 al_bh)
					_mm256_add_epi64(
						ah_bh, 
						_mm256_srli_epi64(al_bh, 32)
					),
					// (hi32 ah_bl) + (carry of mid)
			        _mm256_add_epi64(
						_mm256_srli_epi64(ah_bl, 32), 
						_mm256_srli_epi64(mid, 32)
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
