namespace Butterfly
{
	// u32: 8 lanes
	template <>
	struct Avx2<uint32_t> : Avx2Base {
		static constexpr size_t lanes = 8;

		static __BUTTERFLY_INLINE Vec set1(uint32_t a) { 
			return _mm256_set1_epi32(int(a)); 
		}
		static __BUTTERFLY_INLINE Vec load(const uint32_t* p) { 
			return _mm256_loadu_si256(reinterpret_cast<const __m256i*>(p)); 
		}

		static __BUTTERFLY_INLINE Vec add(Vec a, Vec b) { 
			return _mm256_add_epi32(a, b); 
		}
		static __BUTTERFLY_INLINE Vec sub(Vec a, Vec b) { 
			return _mm256_sub_epi32(a, b); 
		}
		static __BUTTERFLY_INLINE Vec min(Vec a, Vec b) { 
			return _mm256_min_epu32(a, b); 
		}
		static __BUTTERFLY_INLINE Vec mullo(Vec a, Vec b) { 
			return _mm256_mullo_epi32(a, b); 
		}
		static __BUTTERFLY_INLINE void mulwide(Vec& lo, Vec& hi, Vec a, Vec b)
		{
			const Vec e = _mm256_mul_epu32(a, b); 
			const Vec o = _mm256_mul_epu32(
					_mm256_srli_epi64(a, 32), 
					_mm256_srli_epi64(b, 32)
				);
			lo = _mm256_blend_epi32(
					e, 
					_mm256_slli_epi64(o, 32), 
					0xAA
				);
			hi = _mm256_blend_epi32(
					_mm256_srli_epi64(e, 32), 
					o, 
					0xAA
				);
		}
		static __BUTTERFLY_INLINE Vec mulhi(Vec a, Vec b)
		{
			const Vec e = _mm256_mul_epu32(a, b); 
			const Vec o = _mm256_mul_epu32(
				_mm256_srli_epi64(a, 32), 
				_mm256_srli_epi64(b, 32)
			);
			return _mm256_blend_epi32(
				_mm256_srli_epi64(e, 32), 
				o, 
				0xAA
			);
		}
	};
}
