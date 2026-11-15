namespace Butterfly
{
	// u32: 16 lanes
	template <>
	struct Avx512<uint32_t> : Avx512Base {
		static constexpr size_t lanes = 16;

		static __BUTTERFLY_INLINE Vec set1(uint32_t a) { 
			return _mm512_set1_epi32(int(a)); // broadcast
		}
		static __BUTTERFLY_INLINE Vec load(const uint32_t* p) { 
			return _mm512_loadu_si512(p); 
		}

		static __BUTTERFLY_INLINE Vec add(Vec a, Vec b) { 
			return _mm512_add_epi32(a, b); 
		}
		static __BUTTERFLY_INLINE Vec sub(Vec a, Vec b) { 
			return _mm512_sub_epi32(a, b); 
		}
		static __BUTTERFLY_INLINE Vec min(Vec a, Vec b) { 
			return _mm512_min_epu32(a, b); 
		}
		static __BUTTERFLY_INLINE Vec mullo(Vec a, Vec b) { 
			return _mm512_mullo_epi32(a, b); 
		}

		// 64-bit products of the even and of the odd lanes
		static __BUTTERFLY_INLINE void mulwide(Vec& lo, Vec& hi, Vec a, Vec b)
		{
			const Vec e = _mm512_mul_epu32(a, b); 
			const Vec o = _mm512_mul_epu32(
				// right shift one lane
				_mm512_srli_epi64(a, 32), 
				_mm512_srli_epi64(b, 32)
			);
			lo = _mm512_mask_blend_epi32(
				0xAAAA, // 16-bit mask
				e, 
				_mm512_slli_epi64(o, 32) // left shift to interleave
			);
			hi = _mm512_mask_blend_epi32(
				0xAAAA, // 16-bit mask
				_mm512_srli_epi64(e, 32), // right shift to interleave
				o
			);
		}
		static __BUTTERFLY_INLINE Vec mulhi(Vec a, Vec b)
		{
			// Unsigned wide multiplication
			const Vec e = _mm512_mul_epu32(a, b); 
			const Vec o = _mm512_mul_epu32(
				_mm512_srli_epi64(a, 32), 
				_mm512_srli_epi64(b, 32)
			);
			// Extract high bits only
			return _mm512_mask_blend_epi32(
				0xAAAA,
				_mm512_srli_epi64(e, 32), 
				o
			);
		}
	};
}
