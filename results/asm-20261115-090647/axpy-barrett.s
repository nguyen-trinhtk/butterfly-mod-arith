00000000004021f0 <void Butterfly::axpy<Butterfly::BarrettShoupOps, Givaro::Modular<unsigned long, unsigned __int128, void> >(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<Givaro::Modular<unsigned long, unsigned __int128, void>::Element, std::allocator<Givaro::Modular<unsigned long, unsigned __int128, void>::Element> > const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element*, unsigned long)>:
_ZN9Butterfly4axpyINS_15BarrettShoupOpsEN6Givaro7ModularImovEEEEvRKT0_PKSt6vectorINS5_7ElementESaIS9_EEPKS9_PS9_m():
/home/nt636/butterfly-arith/include/butterfly/axpy.h:40
  4021f0:	push   %rbp
  4021f1:	mov    %rsp,%rbp
  4021f4:	push   %r14
  4021f6:	mov    %rdx,%r14
  4021f9:	push   %r13
  4021fb:	push   %r12
  4021fd:	push   %rbx
/home/nt636/butterfly-arith/include/butterfly/axpy.h:44
  4021fe:	mov    (%rsi),%rbx
  402201:	mov    0x18(%rsi),%r12
/home/nt636/butterfly-arith/include/butterfly/arith.h:24
  402205:	mov    0x20(%rdi),%r10
/home/nt636/butterfly-arith/include/butterfly/axpy.h:29
  402209:	cmp    $0x7,%r8
  40220d:	jbe    402378 <void Butterfly::axpy<Butterfly::BarrettShoupOps, Givaro::Modular<unsigned long, unsigned __int128, void> >(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<Givaro::Modular<unsigned long, unsigned __int128, void>::Element, std::allocator<Givaro::Modular<unsigned long, unsigned __int128, void>::Element> > const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element*, unsigned long)+0x188>
_Z17_mm512_set1_epi64x():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:4131
  402213:	mov    $0xffffffff,%esi
  402218:	vpbroadcastq %r10,%zmm6
/home/nt636/butterfly-arith/include/butterfly/axpy.h:29
  40221e:	mov    $0x8,%eax
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:4131
  402223:	vpbroadcastq %rsi,%zmm7
  402229:	nopl   0x0(%rax)
_Z18_mm512_loadu_si512PKv():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:6384
  402230:	vmovdqu64 -0x40(%r14,%rax,8),%zmm0
  402238:	vmovdqu64 -0x40(%r12,%rax,8),%zmm2
_Z17_mm512_srli_epi64Dv8_xj():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:1089
  402240:	vpsrlq $0x20,%zmm0,%zmm5
  402247:	vpsrlq $0x20,%zmm2,%zmm4
_Z16_mm512_mul_epu32Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:978
  40224e:	vpmuludq %zmm0,%zmm2,%zmm3
  402254:	vpmuludq %zmm0,%zmm4,%zmm1
  40225a:	vpmuludq %zmm5,%zmm2,%zmm2
  402260:	vpmuludq %zmm5,%zmm4,%zmm4
_Z17_mm512_srli_epi64Dv8_xj():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:1089
  402266:	vpsrlq $0x20,%zmm3,%zmm5
_Z16_mm512_and_si512Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:7661
  40226d:	vpandd %zmm1,%zmm7,%zmm8
  402273:	vpandd %zmm2,%zmm7,%zmm3
_Z16_mm512_add_epi64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:739
  402279:	vpaddq %zmm8,%zmm3,%zmm3
  40227f:	vpaddq %zmm5,%zmm3,%zmm3
_Z17_mm512_srli_epi64Dv8_xj():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:1089
  402285:	vpsrlq $0x20,%zmm3,%zmm3
  40228c:	vpsrlq $0x20,%zmm1,%zmm1
  402293:	vpsrlq $0x20,%zmm2,%zmm2
_Z18_mm512_mullo_epi64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512dqintrin.h:375
  40229a:	vmovdqu64 -0x40(%rbx,%rax,8),%zmm5
_Z16_mm512_add_epi64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:739
  4022a2:	vpaddq %zmm3,%zmm1,%zmm1
  4022a8:	vpaddq %zmm2,%zmm4,%zmm2
  4022ae:	vpaddq %zmm2,%zmm1,%zmm1
_Z18_mm512_mullo_epi64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512dqintrin.h:375
  4022b4:	vpmullq %zmm6,%zmm1,%zmm1
  4022ba:	vpmullq %zmm0,%zmm5,%zmm0
_Z16_mm512_sub_epi64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:767
  4022c0:	vpsubq %zmm1,%zmm0,%zmm0
  4022c6:	vpsubq %zmm6,%zmm0,%zmm1
_Z16_mm512_min_epu64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:11072
  4022cc:	vpminuq %zmm1,%zmm0,%zmm0
_Z16_mm512_add_epi64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:739
  4022d2:	vpaddq -0x40(%rcx,%rax,8),%zmm0,%zmm0
_Z16_mm512_sub_epi64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:767
  4022da:	vpsubq %zmm6,%zmm0,%zmm1
_Z16_mm512_min_epu64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:11072
  4022e0:	vpminuq %zmm1,%zmm0,%zmm0
_Z19_mm512_storeu_si512PvDv8_x():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:6410
  4022e6:	vmovdqu64 %zmm0,-0x40(%rcx,%rax,8)
/home/nt636/butterfly-arith/include/butterfly/axpy.h:29
  4022ee:	add    $0x8,%rax
  4022f2:	cmp    %r8,%rax
  4022f5:	jbe    402230 <void Butterfly::axpy<Butterfly::BarrettShoupOps, Givaro::Modular<unsigned long, unsigned __int128, void> >(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<Givaro::Modular<unsigned long, unsigned __int128, void>::Element, std::allocator<Givaro::Modular<unsigned long, unsigned __int128, void>::Element> > const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element*, unsigned long)+0x40>
  4022fb:	lea    -0x8(%r8),%r9
  4022ff:	and    $0xfffffffffffffff8,%r9
  402303:	lea    0x8(%r9),%r13
  402307:	mov    0x20(%rdi),%r10
  40230b:	add    $0x9,%r9
  40230f:	jmp    402361 <void Butterfly::axpy<Butterfly::BarrettShoupOps, Givaro::Modular<unsigned long, unsigned __int128, void> >(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<Givaro::Modular<unsigned long, unsigned __int128, void>::Element, std::allocator<Givaro::Modular<unsigned long, unsigned __int128, void>::Element> > const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element*, unsigned long)+0x171>
  402311:	nopl   0x0(%rax)
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:39
  402318:	mov    (%r14,%r13,8),%rsi
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:64
  40231c:	mov    (%rbx,%r13,8),%rax
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:67
  402320:	mov    %rsi,%rdx
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:64
  402323:	imul   %rsi,%rax
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:67
  402327:	mulx   (%r12,%r13,8),%rsi,%rdi
/home/nt636/butterfly-arith/include/butterfly/axpy.h:30
  40232d:	lea    (%rcx,%r13,8),%r11
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:47
  402331:	mov    %r9,%r13
  402334:	inc    %r9
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:67
  402337:	mov    %rdi,%rsi
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:64
  40233a:	imul   %r10,%rsi
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:48
  40233e:	sub    %rsi,%rax
  402341:	mov    %rax,%rsi
  402344:	sub    %r10,%rsi
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:56
  402347:	cmp    %rsi,%rax
  40234a:	cmovae %rsi,%rax
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:45
  40234e:	add    (%r11),%rax
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:48
  402351:	mov    %rax,%rsi
  402354:	sub    %r10,%rsi
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:56
  402357:	cmp    %rsi,%rax
  40235a:	cmovae %rsi,%rax
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:42
  40235e:	mov    %rax,(%r11)
/home/nt636/butterfly-arith/include/butterfly/axpy.h:29
  402361:	cmp    %r9,%r8
  402364:	jae    402318 <void Butterfly::axpy<Butterfly::BarrettShoupOps, Givaro::Modular<unsigned long, unsigned __int128, void> >(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<Givaro::Modular<unsigned long, unsigned __int128, void>::Element, std::allocator<Givaro::Modular<unsigned long, unsigned __int128, void>::Element> > const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element*, unsigned long)+0x128>
  402366:	vzeroupper 
_ZN9Butterfly4axpyINS_15BarrettShoupOpsEN6Givaro7ModularImovEEEEvRKT0_PKSt6vectorINS5_7ElementESaIS9_EEPKS9_PS9_m():
/home/nt636/butterfly-arith/include/butterfly/axpy.h:47
  402369:	pop    %rbx
  40236a:	pop    %r12
  40236c:	pop    %r13
  40236e:	pop    %r14
  402370:	pop    %rbp
  402371:	retq   
  402372:	nopw   0x0(%rax,%rax,1)
/home/nt636/butterfly-arith/include/butterfly/axpy.h:29
  402378:	mov    $0x1,%r9d
  40237e:	xor    %r13d,%r13d
  402381:	jmp    402361 <void Butterfly::axpy<Butterfly::BarrettShoupOps, Givaro::Modular<unsigned long, unsigned __int128, void> >(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<Givaro::Modular<unsigned long, unsigned __int128, void>::Element, std::allocator<Givaro::Modular<unsigned long, unsigned __int128, void>::Element> > const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element*, unsigned long)+0x171>
  402383:	nopw   %cs:0x0(%rax,%rax,1)
  40238d:	nopl   (%rax)

0000000000402390 <void axpyKernel<Butterfly::BarrettShoupOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<unsigned long, std::allocator<unsigned long> > const*, unsigned long const*, unsigned long*, unsigned long)>:
_Z10axpyKernelIN9Butterfly15BarrettShoupOpsEEvRKN6Givaro7ModularImovEEPKSt6vectorImSaImEEPKmPmm():
/home/nt636/butterfly-arith/bench/profile.cpp:30
  402390:	jmpq   4021f0 <void Butterfly::axpy<Butterfly::BarrettShoupOps, Givaro::Modular<unsigned long, unsigned __int128, void> >(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<Givaro::Modular<unsigned long, unsigned __int128, void>::Element, std::allocator<Givaro::Modular<unsigned long, unsigned __int128, void>::Element> > const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element*, unsigned long)>
  402395:	nopw   %cs:0x0(%rax,%rax,1)
  40239f:	nop

