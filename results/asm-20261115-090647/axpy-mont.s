0000000000402470 <void Butterfly::axpy<Butterfly::MontgomeryRedcOps, Givaro::Modular<unsigned long, unsigned __int128, void> >(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<Givaro::Modular<unsigned long, unsigned __int128, void>::Element, std::allocator<Givaro::Modular<unsigned long, unsigned __int128, void>::Element> > const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element*, unsigned long)>:
_ZN9Butterfly4axpyINS_17MontgomeryRedcOpsEN6Givaro7ModularImovEEEEvRKT0_PKSt6vectorINS5_7ElementESaIS9_EEPKS9_PS9_m():
/home/nt636/butterfly-arith/include/butterfly/axpy.h:40
  402470:	push   %rbp
/home/nt636/butterfly-arith/include/butterfly/arith.h:125
  402471:	mov    $0x2,%eax
  402476:	mov    %rax,%r10
/home/nt636/butterfly-arith/include/butterfly/axpy.h:40
  402479:	mov    %rsp,%rbp
  40247c:	push   %r14
  40247e:	mov    %rdx,%r14
/home/nt636/butterfly-arith/include/butterfly/arith.h:125
  402481:	mov    %rax,%rdx
/home/nt636/butterfly-arith/include/butterfly/axpy.h:40
  402484:	push   %r12
  402486:	push   %rbx
/home/nt636/butterfly-arith/include/butterfly/arith.h:24
  402487:	mov    0x20(%rdi),%r9
/home/nt636/butterfly-arith/include/butterfly/axpy.h:44
  40248b:	mov    (%rsi),%rbx
/home/nt636/butterfly-arith/include/butterfly/arith.h:125
  40248e:	mov    %r9,%rsi
  402491:	imul   %r9,%rsi
  402495:	sub    %rsi,%r10
  402498:	mov    %r10,%rsi
  40249b:	imul   %r9,%rsi
  40249f:	mov    %r9,%r10
  4024a2:	imul   %rsi,%r10
  4024a6:	sub    %r10,%rdx
  4024a9:	mov    %rdx,%r10
  4024ac:	imul   %rsi,%r10
  4024b0:	mov    %r9,%rsi
  4024b3:	mov    %rax,%rdx
  4024b6:	imul   %r10,%rsi
  4024ba:	sub    %rsi,%rdx
  4024bd:	imul   %rdx,%r10
  4024c1:	mov    %r9,%rsi
  4024c4:	mov    %rax,%rdx
  4024c7:	imul   %r10,%rsi
  4024cb:	sub    %rsi,%rdx
  4024ce:	mov    %rdx,%rsi
  4024d1:	imul   %r10,%rsi
  4024d5:	mov    %r9,%r10
  4024d8:	imul   %rsi,%r10
  4024dc:	sub    %r10,%rax
  4024df:	imul   %rsi,%rax
/home/nt636/butterfly-arith/include/butterfly/axpy.h:29
  4024e3:	cmp    $0x7,%r8
  4024e7:	jbe    402730 <void Butterfly::axpy<Butterfly::MontgomeryRedcOps, Givaro::Modular<unsigned long, unsigned __int128, void> >(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<Givaro::Modular<unsigned long, unsigned __int128, void>::Element, std::allocator<Givaro::Modular<unsigned long, unsigned __int128, void>::Element> > const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element*, unsigned long)+0x2c0>
  4024ed:	vpbroadcastq %r9,%zmm7
_Z17_mm512_set1_epi64x():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:4131
  4024f3:	mov    $0xffffffff,%esi
  4024f8:	vpbroadcastq %rax,%zmm6
  4024fe:	vmovdqa64 %zmm7,%zmm9
/home/nt636/butterfly-arith/include/butterfly/axpy.h:29
  402504:	mov    $0x8,%eax
  402509:	vpsrlq $0x20,%zmm7,%zmm8
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:4131
  402510:	vpbroadcastq %rsi,%zmm5
  402516:	nopw   %cs:0x0(%rax,%rax,1)
_Z18_mm512_loadu_si512PKv():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:6384
  402520:	vmovdqu64 -0x40(%r14,%rax,8),%zmm0
  402528:	vmovdqu64 -0x40(%rbx,%rax,8),%zmm1
_Z17_mm512_srli_epi64Dv8_xj():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:1089
  402530:	vpsrlq $0x20,%zmm0,%zmm3
  402537:	vpsrlq $0x20,%zmm1,%zmm4
_Z16_mm512_mul_epu32Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:978
  40253e:	vpmuludq %zmm0,%zmm1,%zmm2
  402544:	vpmuludq %zmm3,%zmm1,%zmm1
  40254a:	vpmuludq %zmm0,%zmm4,%zmm0
  402550:	vpmuludq %zmm3,%zmm4,%zmm13
_Z17_mm512_srli_epi64Dv8_xj():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:1089
  402556:	vpsrlq $0x20,%zmm2,%zmm3
_Z16_mm512_and_si512Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:7661
  40255d:	vpandd %zmm1,%zmm5,%zmm4
  402563:	vpandd %zmm0,%zmm5,%zmm10
_Z16_mm512_add_epi64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:739
  402569:	vpaddq %zmm10,%zmm4,%zmm4
  40256f:	vpaddq %zmm3,%zmm4,%zmm4
_Z17_mm512_slli_epi64Dv8_xj():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:1010
  402575:	vpsllq $0x20,%zmm4,%zmm10
_Z17_mm512_srli_epi64Dv8_xj():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:1089
  40257c:	vpsrlq $0x20,%zmm1,%zmm3
_Z16_mm512_and_si512Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:7661
  402583:	vpandd %zmm2,%zmm5,%zmm1
_Z15_mm512_or_si512Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:7354
  402589:	vpord  %zmm10,%zmm1,%zmm1
_Z18_mm512_mullo_epi64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512dqintrin.h:375
  40258f:	vpmullq %zmm1,%zmm6,%zmm1
_Z17_mm512_srli_epi64Dv8_xj():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:1089
  402595:	vpsrlq $0x20,%zmm4,%zmm4
  40259c:	vpsrlq $0x20,%zmm0,%zmm0
_Z16_mm512_sub_epi64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:767
  4025a3:	vpaddq %zmm4,%zmm0,%zmm0
  4025a9:	vpaddq %zmm3,%zmm13,%zmm3
_Z17_mm512_srli_epi64Dv8_xj():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:1089
  4025af:	vpsrlq $0x20,%zmm1,%zmm10
_Z16_mm512_mul_epu32Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:978
  4025b6:	vpmuludq %zmm9,%zmm1,%zmm2
  4025bc:	vpmuludq %zmm9,%zmm10,%zmm11
  4025c2:	vpmuludq %zmm8,%zmm1,%zmm1
  4025c8:	vpmuludq %zmm8,%zmm10,%zmm10
_Z16_mm512_sub_epi64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:767
  4025ce:	vpaddq %zmm3,%zmm0,%zmm0
_Z17_mm512_srli_epi64Dv8_xj():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:1089
  4025d4:	vpsrlq $0x20,%zmm2,%zmm12
_Z16_mm512_and_si512Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:7661
  4025db:	vpandd %zmm11,%zmm5,%zmm14
  4025e1:	vpandd %zmm1,%zmm5,%zmm2
_Z16_mm512_add_epi64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:739
  4025e7:	vpaddq %zmm14,%zmm2,%zmm2
  4025ed:	vpaddq %zmm12,%zmm2,%zmm2
_Z17_mm512_srli_epi64Dv8_xj():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:1089
  4025f3:	vpsrlq $0x20,%zmm2,%zmm2
  4025fa:	vpsrlq $0x20,%zmm11,%zmm11
  402601:	vpsrlq $0x20,%zmm1,%zmm1
_Z16_mm512_sub_epi64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:767
  402608:	vpaddq %zmm2,%zmm11,%zmm2
  40260e:	vpaddq %zmm1,%zmm10,%zmm1
  402614:	vpsubq %zmm2,%zmm0,%zmm0
  40261a:	vpsubq %zmm1,%zmm0,%zmm0
_Z16_mm512_add_epi64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:739
  402620:	vpaddq %zmm7,%zmm0,%zmm1
_Z16_mm512_min_epu64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:11072
  402626:	vpminuq %zmm1,%zmm0,%zmm0
_Z16_mm512_add_epi64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:739
  40262c:	vpaddq -0x40(%rcx,%rax,8),%zmm0,%zmm0
_Z16_mm512_sub_epi64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:767
  402634:	vpsubq %zmm7,%zmm0,%zmm1
_Z16_mm512_min_epu64Dv8_xS_():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:11072
  40263a:	vpminuq %zmm1,%zmm0,%zmm0
_Z19_mm512_storeu_si512PvDv8_x():
/cm/local/apps/gcc/9.2.0/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/avx512fintrin.h:6410
  402640:	vmovdqu64 %zmm0,-0x40(%rcx,%rax,8)
/home/nt636/butterfly-arith/include/butterfly/axpy.h:29
  402648:	add    $0x8,%rax
  40264c:	cmp    %r8,%rax
  40264f:	jbe    402520 <void Butterfly::axpy<Butterfly::MontgomeryRedcOps, Givaro::Modular<unsigned long, unsigned __int128, void> >(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<Givaro::Modular<unsigned long, unsigned __int128, void>::Element, std::allocator<Givaro::Modular<unsigned long, unsigned __int128, void>::Element> > const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element*, unsigned long)+0xb0>
  402655:	lea    -0x8(%r8),%r10
  402659:	and    $0xfffffffffffffff8,%r10
  40265d:	mov    0x20(%rdi),%r9
  402661:	lea    0x8(%r10),%rsi
  402665:	add    $0x9,%r10
/home/nt636/butterfly-arith/include/butterfly/arith.h:125
  402669:	mov    %r9,%rdi
  40266c:	imul   %r9,%rdi
  402670:	mov    $0x2,%eax
  402675:	mov    %rax,%rdx
  402678:	sub    %rdi,%rdx
  40267b:	mov    %rdx,%rdi
  40267e:	imul   %r9,%rdi
  402682:	mov    %rax,%rdx
  402685:	mov    %rdi,%r12
  402688:	mov    %r9,%rdi
  40268b:	imul   %r12,%rdi
  40268f:	sub    %rdi,%rdx
  402692:	mov    %rdx,%rdi
  402695:	imul   %r12,%rdi
  402699:	mov    %rax,%r12
  40269c:	mov    %rdi,%r11
  40269f:	imul   %r9,%r11
  4026a3:	sub    %r11,%r12
  4026a6:	imul   %r12,%rdi
  4026aa:	mov    %rax,%r12
  4026ad:	mov    %rdi,%r11
  4026b0:	imul   %r9,%r11
  4026b4:	sub    %r11,%r12
  4026b7:	imul   %rdi,%r12
  4026bb:	mov    %r12,%rdi
  4026be:	imul   %r9,%rdi
  4026c2:	sub    %rdi,%rax
  4026c5:	imul   %rax,%r12
/home/nt636/butterfly-arith/include/butterfly/axpy.h:29
  4026c9:	cmp    %r10,%r8
  4026cc:	jb     40271c <void Butterfly::axpy<Butterfly::MontgomeryRedcOps, Givaro::Modular<unsigned long, unsigned __int128, void> >(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<Givaro::Modular<unsigned long, unsigned __int128, void>::Element, std::allocator<Givaro::Modular<unsigned long, unsigned __int128, void>::Element> > const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element*, unsigned long)+0x2ac>
  4026ce:	xchg   %ax,%ax
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:70
  4026d0:	mov    (%r14,%rsi,8),%rax
/home/nt636/butterfly-arith/include/butterfly/axpy.h:30
  4026d4:	lea    (%rcx,%rsi,8),%r11
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:70
  4026d8:	mov    %rax,%rdx
  4026db:	mulx   (%rbx,%rsi,8),%rsi,%rdi
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:64
  4026e1:	imul   %r12,%rsi
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:72
  4026e5:	mov    %rdi,%rax
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:67
  4026e8:	mov    %rsi,%rdx
  4026eb:	mulx   %r9,%rsi,%rdi
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:48
  4026f0:	sub    %rdi,%rax
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:45
  4026f3:	lea    (%rax,%r9,1),%rsi
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:56
  4026f7:	cmp    %rsi,%rax
  4026fa:	cmovae %rsi,%rax
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:45
  4026fe:	add    (%r11),%rax
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:48
  402701:	mov    %rax,%rsi
  402704:	sub    %r9,%rsi
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:56
  402707:	cmp    %rsi,%rax
  40270a:	cmovae %rsi,%rax
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:41
  40270e:	mov    %r10,%rsi
  402711:	inc    %r10
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:42
  402714:	mov    %rax,(%r11)
/home/nt636/butterfly-arith/include/butterfly/axpy.h:29
  402717:	cmp    %r10,%r8
  40271a:	jae    4026d0 <void Butterfly::axpy<Butterfly::MontgomeryRedcOps, Givaro::Modular<unsigned long, unsigned __int128, void> >(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<Givaro::Modular<unsigned long, unsigned __int128, void>::Element, std::allocator<Givaro::Modular<unsigned long, unsigned __int128, void>::Element> > const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element*, unsigned long)+0x260>
  40271c:	vzeroupper 
_ZN9Butterfly4axpyINS_17MontgomeryRedcOpsEN6Givaro7ModularImovEEEEvRKT0_PKSt6vectorINS5_7ElementESaIS9_EEPKS9_PS9_m():
/home/nt636/butterfly-arith/include/butterfly/axpy.h:47
  40271f:	pop    %rbx
  402720:	pop    %r12
  402722:	pop    %r14
  402724:	pop    %rbp
  402725:	retq   
  402726:	nopw   %cs:0x0(%rax,%rax,1)
/home/nt636/butterfly-arith/include/butterfly/axpy.h:29
  402730:	mov    $0x1,%r10d
  402736:	xor    %esi,%esi
  402738:	jmpq   402669 <void Butterfly::axpy<Butterfly::MontgomeryRedcOps, Givaro::Modular<unsigned long, unsigned __int128, void> >(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<Givaro::Modular<unsigned long, unsigned __int128, void>::Element, std::allocator<Givaro::Modular<unsigned long, unsigned __int128, void>::Element> > const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element*, unsigned long)+0x1f9>
  40273d:	nopl   (%rax)

0000000000402740 <void axpyKernel<Butterfly::MontgomeryRedcOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<unsigned long, std::allocator<unsigned long> > const*, unsigned long const*, unsigned long*, unsigned long)>:
_Z10axpyKernelIN9Butterfly17MontgomeryRedcOpsEEvRKN6Givaro7ModularImovEEPKSt6vectorImSaImEEPKmPmm():
/home/nt636/butterfly-arith/bench/profile.cpp:30
  402740:	jmpq   402470 <void Butterfly::axpy<Butterfly::MontgomeryRedcOps, Givaro::Modular<unsigned long, unsigned __int128, void> >(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<Givaro::Modular<unsigned long, unsigned __int128, void>::Element, std::allocator<Givaro::Modular<unsigned long, unsigned __int128, void>::Element> > const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element const*, Givaro::Modular<unsigned long, unsigned __int128, void>::Element*, unsigned long)>
  402745:	nopw   %cs:0x0(%rax,%rax,1)
  40274f:	nop

