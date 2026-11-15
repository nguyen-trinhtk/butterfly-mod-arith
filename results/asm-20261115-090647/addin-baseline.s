0000000000401df0 <void addinKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)>:
/home/nt636/butterfly-arith/include/butterfly/addin.h:15
  401df0:	test   %rcx,%rcx
  401df3:	je     401f50 <void addinKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x160>
  401df9:	lea    0x0(,%rcx,8),%r10
  401e01:	lea    (%rdx,%r10,1),%r8
  401e05:	lea    0x20(%rdi),%rax
  401e09:	cmp    %rax,%r8
  401e0c:	lea    0x28(%rdi),%r8
  401e10:	setbe  %al
  401e13:	cmp    %r8,%rdx
  401e16:	setae  %r8b
  401e1a:	or     %r8d,%eax
  401e1d:	lea    0x1f(%rsi),%r8
  401e21:	sub    %rdx,%r8
  401e24:	cmp    $0x3e,%r8
  401e28:	seta   %r8b
  401e2c:	test   %r8b,%al
  401e2f:	je     401f60 <void addinKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x170>
  401e35:	lea    -0x1(%rcx),%rax
  401e39:	cmp    $0x2,%rax
  401e3d:	jbe    401f60 <void addinKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x170>
  401e43:	mov    %rcx,%r9
  401e46:	shr    $0x2,%r9
  401e4a:	vpbroadcastq 0x20(%rdi),%ymm2
  401e50:	shl    $0x5,%r9
  401e54:	xor    %r8d,%r8d
  401e57:	nopw   0x0(%rax,%rax,1)
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:39
  401e60:	vmovdqu64 (%rsi,%r8,1),%ymm1
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:240
  401e67:	vpaddq (%rdx,%r8,1),%ymm1,%ymm0
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:241
  401e6d:	vpcmpnleuq %ymm0,%ymm1,%k0
  401e74:	vpcmpnltuq %ymm2,%ymm0,%k2
  401e7b:	kmovb  %k0,%eax
  401e7f:	kmovb  %k2,%r10d
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:42
  401e83:	or     %r10d,%eax
  401e86:	kmovb  %eax,%k1
  401e8a:	vpsubq %ymm2,%ymm0,%ymm0{%k1}
  401e90:	vmovdqu64 %ymm0,(%rdx,%r8,1)
/home/nt636/butterfly-arith/include/butterfly/addin.h:15
  401e97:	add    $0x20,%r8
  401e9b:	cmp    %r9,%r8
  401e9e:	jne    401e60 <void addinKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x70>
  401ea0:	mov    %rcx,%rax
  401ea3:	and    $0xfffffffffffffffc,%rax
  401ea7:	lea    0x1(%rax),%r11
  401eab:	cmp    %rax,%rcx
  401eae:	je     401f58 <void addinKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x168>
_Z11addinKernelIN9Butterfly13FieldCallsOpsEEvRKN6Givaro7ModularImovEEPKmPmm():
/home/nt636/butterfly-arith/bench/profile.cpp:34
  401eb4:	push   %rbp
/home/nt636/butterfly-arith/include/butterfly/addin.h:16
  401eb5:	lea    (%rdx,%rax,8),%r9
/home/nt636/butterfly-arith/bench/profile.cpp:34
  401eb9:	mov    %rsp,%rbp
  401ebc:	push   %r12
  401ebe:	push   %rbx
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:241
  401ebf:	mov    0x20(%rdi),%rbx
  401ec3:	mov    (%rsi,%rax,8),%r8
  401ec7:	add    (%r9),%r8
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:240
  401eca:	mov    %r8,%r10
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:241
  401ecd:	jb     401ed4 <void addinKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0xe4>
  401ecf:	cmp    %rbx,%r8
  401ed2:	jb     401eda <void addinKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0xea>
  401ed4:	mov    %r8,%r10
  401ed7:	sub    %rbx,%r10
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:42
  401eda:	mov    %r10,(%r9)
/home/nt636/butterfly-arith/include/butterfly/addin.h:15
  401edd:	lea    0x2(%rax),%r10
  401ee1:	cmp    %r10,%rcx
  401ee4:	jb     401f98 <void addinKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x1a8>
  401eea:	mov    (%rsi,%r11,8),%r8
/home/nt636/butterfly-arith/include/butterfly/addin.h:16
  401eee:	lea    (%rdx,%r11,8),%r9
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:241
  401ef2:	mov    0x20(%rdi),%rbx
  401ef6:	xor    %r12d,%r12d
  401ef9:	add    (%r9),%r8
  401efc:	setb   %r12b
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:240
  401f00:	mov    %r8,%r11
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:241
  401f03:	cmp    %r8,%rbx
  401f06:	jbe    401f0d <void addinKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x11d>
  401f08:	test   %r12,%r12
  401f0b:	je     401f13 <void addinKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x123>
  401f0d:	mov    %r8,%r11
  401f10:	sub    %rbx,%r11
/home/nt636/butterfly-arith/include/butterfly/addin.h:15
  401f13:	add    $0x3,%rax
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:42
  401f17:	mov    %r11,(%r9)
/home/nt636/butterfly-arith/include/butterfly/addin.h:15
  401f1a:	cmp    %rax,%rcx
  401f1d:	jb     401f98 <void addinKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x1a8>
  401f1f:	mov    (%rsi,%r10,8),%rax
/home/nt636/butterfly-arith/include/butterfly/addin.h:16
  401f23:	lea    (%rdx,%r10,8),%rdx
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:238
  401f27:	add    (%rdx),%rax
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:241
  401f2a:	mov    0x20(%rdi),%rsi
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:240
  401f2e:	mov    %rax,%rcx
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:241
  401f31:	jb     401f38 <void addinKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x148>
  401f33:	cmp    %rsi,%rax
  401f36:	jb     401f3e <void addinKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x14e>
  401f38:	sub    %rsi,%rax
  401f3b:	mov    %rax,%rcx
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:42
  401f3e:	mov    %rcx,(%rdx)
/home/nt636/butterfly-arith/include/butterfly/addin.h:15
  401f41:	vzeroupper 
/home/nt636/butterfly-arith/bench/profile.cpp:36
  401f44:	pop    %rbx
  401f45:	pop    %r12
  401f47:	pop    %rbp
  401f48:	retq   
  401f49:	nopl   0x0(%rax)
  401f50:	retq   
  401f51:	nopl   0x0(%rax)
  401f58:	vzeroupper 
  401f5b:	retq   
  401f5c:	nopl   0x0(%rax)
/home/nt636/butterfly-arith/include/butterfly/addin.h:15
  401f60:	xor    %eax,%eax
  401f62:	nopw   0x0(%rax,%rax,1)
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:238
  401f68:	mov    (%rsi,%rax,1),%rcx
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:241
  401f6c:	mov    0x20(%rdi),%r9
  401f70:	add    (%rdx,%rax,1),%rcx
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:240
  401f74:	mov    %rcx,%r8
/home/nt636/butterfly-arith/external/install/include/givaro/modular-integral.inl:241
  401f77:	jb     401f7e <void addinKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x18e>
  401f79:	cmp    %r9,%rcx
  401f7c:	jb     401f84 <void addinKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x194>
  401f7e:	sub    %r9,%rcx
  401f81:	mov    %rcx,%r8
/home/nt636/butterfly-arith/include/butterfly/simd/simd.h:42
  401f84:	mov    %r8,(%rdx,%rax,1)
/home/nt636/butterfly-arith/include/butterfly/addin.h:15
  401f88:	add    $0x8,%rax
  401f8c:	cmp    %r10,%rax
  401f8f:	jne    401f68 <void addinKernel<Butterfly::FieldCallsOps>(Givaro::Modular<unsigned long, unsigned __int128, void> const&, unsigned long const*, unsigned long*, unsigned long)+0x178>
  401f91:	retq   
  401f92:	nopw   0x0(%rax,%rax,1)
  401f98:	vzeroupper 
/home/nt636/butterfly-arith/bench/profile.cpp:36
  401f9b:	pop    %rbx
  401f9c:	pop    %r12
  401f9e:	pop    %rbp
  401f9f:	retq   

