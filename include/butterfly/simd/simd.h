
#ifndef __BUTTERFLY_simd_H
#define __BUTTERFLY_simd_H

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <immintrin.h>

#define __BUTTERFLY_INLINE inline __attribute__((always_inline))

#if !defined(BUTTERFLY_SIMD_NONE)
#if defined(__AVX512F__) && defined(__AVX512DQ__) && defined(__AVX512VL__)
#define __BUTTERFLY_AVX512 1
#elif defined(__AVX2__)
#define __BUTTERFLY_AVX2 1
#endif
#endif

namespace Butterfly
{
	// Double-width type
	template <class Element> struct WideOf { typedef void type; };
	template <> struct WideOf<uint32_t> { typedef uint64_t type; };
	template <> struct WideOf<uint64_t> { typedef unsigned __int128 type; };

	// Scalar (no SIMD)
	template <class Element>
	struct Scalar {
		typedef Element Vec; // one-element vector
		static constexpr size_t lanes = 1;
		static constexpr unsigned W = 8 * sizeof(Element); // word size, in bits
		typedef typename WideOf<Element>::type Wide;

		static __BUTTERFLY_INLINE Vec set1(Element a) { 
			return a; 
		}
		static __BUTTERFLY_INLINE Vec load(const Element* p) { 
			return *p; 
		}
		static __BUTTERFLY_INLINE void store(Element* p, Vec v) { 
			*p = v; 
		}
		static __BUTTERFLY_INLINE Vec add(Vec a, Vec b) { 
			return Element(a + b); 
		}
		static __BUTTERFLY_INLINE Vec sub(Vec a, Vec b) { 
			return Element(a - b); 
		}

		// enforce cmovae
		// since gcc 9.2.0 emits cmovbe / cmova
		static __BUTTERFLY_INLINE Vec min(Vec a, Vec b)
		{
#if defined(__x86_64__) && defined(__GNUC__)
			__asm__("cmp %1, %0\n\tcmovae %1, %0" : "+r"(a) : "r"(b) : "cc");
			return a;
#else
			return std::min(a, b);
#endif
		}

		static __BUTTERFLY_INLINE Vec mullo(Vec a, Vec b) { 
			return Element(a * b); 
		}
		static __BUTTERFLY_INLINE Vec mulhi(Vec a, Vec b) { 
			return Element((Wide(a) * b) >> W); 
		}
		static __BUTTERFLY_INLINE void mulwide(Vec& lo, Vec& hi, Vec a, Vec b) {
			const Wide t = Wide(a) * b;
			lo = Element(t);
			hi = Element(t >> W);
		}
	};

// AVX-512
#if defined(__BUTTERFLY_AVX512)
	template <class Element> struct Avx512;

	struct Avx512Base {
		typedef __m512i Vec;
		static __BUTTERFLY_INLINE void store(void* p, Vec v) { 
			_mm512_storeu_si512(p, v); 
		}
	};

	template <class Element> using Default = Avx512<Element>;

// AVX2 is analogous to AVX-512, except for u64 min and muls
#elif defined(__BUTTERFLY_AVX2)
	template <class Element> struct Avx2;

	struct Avx2Base {
		typedef __m256i Vec;
		static __BUTTERFLY_INLINE void store(void* p, Vec v) { 
			_mm256_storeu_si256(reinterpret_cast<Vec*>(p), v); 
		}
	};

	template <class Element> using Default = Avx2<Element>;
#else
	template <class Element> using Default = Scalar<Element>;
#endif
}

#if defined(__BUTTERFLY_AVX512)
#include "simd512_uint32.inl"
#include "simd512_uint64.inl"
#elif defined(__BUTTERFLY_AVX2)
#include "simd256_uint32.inl"
#include "simd256_uint64.inl"
#endif

#endif // __BUTTERFLY_simd_H
