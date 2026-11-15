0000000000402070 <void addinKernel<Butterfly::FastOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)>:
/home/nt636/butterfly-arith/include/butterfly/arith.h:24
  402070:	mov    0x20(%rdi),%r9
_Z17_mm512_set1_epi64x():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:4131
  402074:	vpbroadcastq %r9,%zmm1
/home/nt636/butterfly-arith/include/butterfly/addin.h:15
  40207a:	cmp    $0x7,%rcx
  40207e:	jbe    402108 <void addinKernel<Butterfly::FastOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x98>
  402084:	mov    $0x8,%eax
  402089:	nopl   0x0(%rax)
_Z16_mm512_add_epi64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:739
  402090:	vmovdqu64 -0x40(%rdx,%rax,8),%zmm3
  402098:	vpaddq -0x40(%rsi,%rax,8),%zmm3,%zmm0
_Z16_mm512_sub_epi64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:767
  4020a0:	vpsubq %zmm1,%zmm0,%zmm2
_Z16_mm512_min_epu64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:11072
  4020a6:	vpminuq %zmm2,%zmm0,%zmm0
_Z19_mm512_storeu_si512PvDv8_x():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:6410
  4020ac:	vmovdqu64 %zmm0,-0x40(%rdx,%rax,8)
/home/nt636/butterfly-arith/include/butterfly/addin.h:15
  4020b4:	add    $0x8,%rax
  4020b8:	cmp    %rax,%rcx
  4020bb:	jae    402090 <void addinKernel<Butterfly::FastOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x20>
  4020bd:	lea    -0x8(%rcx),%rax
  4020c1:	and    $0xfffffffffffffff8,%rax
  4020c5:	lea    0x8(%rax),%r8
  4020c9:	mov    0x20(%rdi),%r9
  4020cd:	add    $0x9,%rax
  4020d1:	jmp    4020f9 <void addinKernel<Butterfly::FastOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x89>
  4020d3:	nopl   0x0(%rax,%rax,1)
/home/nt636/butterfly-arith/include/butterfly/addin.h:16
  4020d8:	lea    (%rdx,%r8,8),%r10
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:45
  4020dc:	mov    (%r10),%rdi
  4020df:	add    (%rsi,%r8,8),%rdi
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:48
  4020e3:	mov    %rdi,%r8
  4020e6:	sub    %r9,%r8
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:56
  4020e9:	cmp    %r8,%rdi
  4020ec:	cmovae %r8,%rdi
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:42
  4020f0:	mov    %rdi,(%r10)
/home/nt636/butterfly-arith/include/butterfly/addin.h:15
  4020f3:	mov    %rax,%r8
  4020f6:	inc    %rax
  4020f9:	cmp    %rax,%rcx
  4020fc:	jae    4020d8 <void addinKernel<Butterfly::FastOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x68>
  4020fe:	vzeroupper 
_Z11addinKernelIN9Butterfly7FastOpsEEvRKN6Givaro7ModularImovEEPKmPmm():
/home/nt636/butterfly-arith/bench/profile.cpp:36
  402101:	retq   
  402102:	nopw   0x0(%rax,%rax,1)
/home/nt636/butterfly-arith/include/butterfly/addin.h:15
  402108:	mov    $0x1,%eax
  40210d:	xor    %r8d,%r8d
  402110:	jmp    4020f9 <void addinKernel<Butterfly::FastOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x89>
  402112:	nopw   %cs:0x0(%rax,%rax,1)
  40211c:	nopl   0x0(%rax)

