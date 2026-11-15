0000000000401c80 <void axpyKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<unsigned long, std::allocator<unsigned long> > const*, unsigned long const*, unsigned long*, unsigned long)>:
_Z10axpyKernelIN9Butterfly13FieldCallsOpsEEvRKN6Givaro7ModularImovEEPKSt6vectorImSaImEEPKmPmm():
/home/nt636/butterfly-arith/bench/profile.cpp:29
  401c80:	push   %r15
  401c82:	push   %r14
  401c84:	push   %r13
  401c86:	push   %r12
  401c88:	push   %rbp
  401c89:	push   %rbx
  401c8a:	sub    $0x28,%rsp
/home/nt636/butterfly-arith/include/butterfly/axpy.h:44
  401c8e:	mov    (%rsi),%rbp
/home/nt636/butterfly-arith/include/butterfly/axpy.h:29
  401c91:	test   %r8,%r8
  401c94:	je     401d02 <void axpyKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<unsigned long, std::allocator<unsigned long> > const*, unsigned long const*, unsigned long*, unsigned long)+0x82>
  401c96:	lea    0x0(,%r8,8),%rax
  401c9e:	mov    %rax,0x18(%rsp)
/home/nt636/butterfly-arith/include/butterfly/arith.h:160
  401ca3:	mov    0x30(%rdi),%r14
  401ca7:	mov    0x38(%rdi),%r15
  401cab:	mov    %rdx,%r10
  401cae:	mov    %rcx,%r9
  401cb1:	xor    %ebx,%ebx
  401cb3:	nopl   0x0(%rax,%rax,1)
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:305
  401cb8:	mov    (%r10,%rbx,1),%rax
/home/nt636/butterfly-arith/external/install/include/givaro/givcaster.h:22
  401cbc:	mov    (%r9,%rbx,1),%r12
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:305
  401cc0:	mulq   0x0(%rbp,%rbx,1)
/home/nt636/butterfly-arith/external/install/include/givaro/givcaster.h:22
  401cc5:	xor    %r13d,%r13d
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:306
  401cc8:	mov    %r15,%rcx
  401ccb:	add    %r12,%rax
  401cce:	adc    %r13,%rdx
  401cd1:	mov    %rdx,%rsi
  401cd4:	mov    %rax,%rdi
  401cd7:	mov    %r14,%rdx
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:305
  401cda:	mov    %r10,0x10(%rsp)
/home/nt636/butterfly-arith/external/install/include/givaro/givcaster.h:22
  401cdf:	mov    %r9,0x8(%rsp)
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:306
  401ce4:	callq  401000 <__umodti3@plt>
/home/nt636/butterfly-arith/external/install/include/givaro/givcaster.h:22
  401ce9:	mov    0x8(%rsp),%r9
/home/nt636/butterfly-arith/include/butterfly/axpy.h:29
  401cee:	mov    0x10(%rsp),%r10
/home/nt636/butterfly-arith/external/install/include/givaro/givcaster.h:22
  401cf3:	mov    %rax,(%r9,%rbx,1)
/home/nt636/butterfly-arith/include/butterfly/axpy.h:29
  401cf7:	add    $0x8,%rbx
  401cfb:	cmp    %rbx,0x18(%rsp)
  401d00:	jne    401cb8 <void axpyKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, std::vector<unsigned long, std::allocator<unsigned long> > const*, unsigned long const*, unsigned long*, unsigned long)+0x38>
/home/nt636/butterfly-arith/bench/profile.cpp:31
  401d02:	add    $0x28,%rsp
  401d06:	pop    %rbx
  401d07:	pop    %rbp
  401d08:	pop    %r12
  401d0a:	pop    %r13
  401d0c:	pop    %r14
  401d0e:	pop    %r15
  401d10:	retq   
  401d11:	nopw   %cs:0x0(%rax,%rax,1)
  401d1b:	nopl   0x0(%rax,%rax,1)

