Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AED636B920
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787729032; cv=none; b=A+8Hj5Xk+uWTW3+iU+Ere9Kho38Z9+wasiRYX9kcFcPXRlBj+USUgrVdp9gAHbmb1EScd5Nd75YMiGZFzOopTxo2D3tb98xyYx4wKj3ETYaPfZDyAfLcwd5hj8rRV/Eyw18CkCPWMZ/LeVYRu9FoCFMLleDxcvjrEqiG/KJpxME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787729032; c=relaxed/simple;
	bh=LsBxgrTeXjx27yTW8HiNLfgfrrhl9TjF8HF9Octczdk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XFvkssev8p7rZa0CGi0VzSejZxphzvepGZHxTgiM6QyDCdRdvCMI0B4jNa8wLcI3UXB1HKwI1LdaOFCysxlNdag8W+fHSnnxZtHufE/YrT1Z2968Znn8hAl3ls5AoC6B+mbI8HULV3ocY8ggOIO2+h8OIUHo/85wHsGeDXladK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/AJ07G+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/AJ07G+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6991F000E9;
	Wed, 26 Aug 2026 07:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787729030;
	bh=tloopXKb1QPCXC3djixW6kd2NPsQrSWzbExQ3LhTi3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E/AJ07G+RSDeDskLdjIhN+h/X3G1kQ7eDuMJfbHJzNlxlNhF9kCS0wkiQ583VGWkm
	 /muIz+iA03B0nKhIFprbEgJgW+IKnoNrKGl7TNv5pdUn20Ex1eBPxC/3VWBQFJsUwA
	 SpW6rOidG1kQOHhMfaq+o0pBf1d2o0jcDNS1YX6jz+lEGL56qLFCT48seteHVu8LHL
	 rducM4L0yE9dJ+N19NlL9NiUUH2aZuI/yJVgaCgAMJdGL6iy43NpAmaehdZTPUZRMn
	 w5hyz4vUPD2XDLQm3F6tc2XwTWggg1DSsJUMWbQNcTKMs25qs2i2vKEgTrP9n75VLz
	 yyls1Flt1sVWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] x86/uaccess: Extend CMPXCHG user helpers to
 128-bit operands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260826070004.8100-2-sarunkod@amd.com>
References: <20260826070004.8100-1-sarunkod@amd.com>
 <20260826070004.8100-2-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 07:23:50 +0000
Message-Id: <20260826072350.8D6991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The inline assembly for 128-bit cmpxchg uses the unreliable `+A` c=
onstraint on x86-64, risking silent memory corruption or build failures.
- [Medium] The 32-bit stub for `__try_cmpxchg128_user_asm` relies on `BUILD=
_BUG_ON(1)`, which will break the 32-bit build for all callers of `unsafe_t=
ry_cmpxchg_user`.
--

commit 778924f40bf568ddfaeffc09239d3c0e2a09bba6
Author: Sairaj Kodilkar <sarunkod@amd.com>

x86/uaccess: Extend CMPXCHG user helpers to 128-bit operands

This commit extends the existing user CMPXCHG helpers to support 16-byte
operands on x86-64 using the "cmpxchg16b" instruction. On 32-bit kernels,
it stubs the helper to fail, as cmpxchg16b requires 64-bit registers. KVM
uses this to atomically emulate guest cmpxchg16b on guest RAM mapped via
userspace addresses.

> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uacces=
s.h
> index 3a0dd3c2b233e..39bcf327664ea 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -407,6 +407,25 @@ do {									\
[ ... ]
> +#else // !CONFIG_X86_32
> +#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label)	({	\
> +	bool success;							\
> +	__typeof__(_ptr) _old =3D (__typeof__(_ptr))(_pold);		\
> +	__typeof__(*(_ptr)) __old =3D *_old;				\
> +	__typeof__(*(_ptr)) __new =3D (_new);				\
> +	asm_goto_output("\n"						\
> +		     "1: " LOCK_PREFIX "cmpxchg16b %[ptr]\n"		\
> +		     _ASM_EXTABLE_UA(1b, %l[label])			\
> +		     : "=3D@ccz" (success),				\
> +		       "+A" (__old),					\

[Severity: High]
Does using the "+A" constraint for a 128-bit value provide the strict
rdx:rax register ordering required by the cmpxchg16b instruction?

The kernel documents in arch/x86/include/asm/asm.h that the "A" constraint
on x86-64 means rax or rdx, rather than the rdx:rax pair. If the compiler
does not guarantee the rdx:rax ordering for __int128/u128 with "+A", could
this lead to silent memory corruption with swapped operands, or outright
build failures on compilers like Clang?

The standard pattern used elsewhere (like __arch_cmpxchg128 in
arch/x86/include/asm/cmpxchg_64.h) splits the 128-bit value into a union
of two 64-bit halves and explicitly binds them to "+a" (rax) and "+d" (rdx).
Would it be safer to use that pattern here?

> +		       [ptr] "+m" (*_ptr)				\
> +		     : "b" ((u64)__new),				\
> +		       "c" ((u64)((u128)__new >> 64))			\
> +		     : "memory"						\
> +		     : label);						\
> +	if (unlikely(!success))						\
> +		*_old =3D __old;						\
> +	likely(success);					})
>  #endif // CONFIG_X86_32
>  #else  // !CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT
[ ... ]
> +#else //!CONFIG_X86_32
> +#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label)	({	\
> +	int __result;							\
> +	__typeof__(_ptr) _old =3D (__typeof__(_ptr))(_pold);		\
> +	__typeof__(*(_ptr)) __old =3D *_old;				\
> +	__typeof__(*(_ptr)) __new =3D (_new);				\
> +	asm volatile("\n"						\
> +		     "1: " LOCK_PREFIX "cmpxchg16b %[ptr]\n"		\
> +		     "mov $0, %[result]\n\t"				\
> +		     "setz %b[result]\n"				\
> +		     "2:\n"						\
> +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
> +					   %[result])			\
> +		     : [result] "=3Dq" (__result),			\
> +		       "+A" (__old),					\

[Severity: High]
Similar to the asm_goto_output block above, this fallback path also binds
the 128-bit __old variable to the "+A" constraint.

> +		       [ptr] "+m" (*_ptr)				\
> +		     : "b" ((u64)__new),				\
> +		       "c" ((u64)((u128)__new >> 64))			\
> +		     : "memory", "cc");					\
> +	if (unlikely(__result < 0))					\
> +		goto label;						\
> +	if (unlikely(!__result))					\
> +		*_old =3D __old;						\
> +	likely(__result);					})
>  #endif // CONFIG_X86_32
>  #endif // CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT
[ ... ]
> @@ -551,11 +594,18 @@ do {										\
> =20
>  extern void __try_cmpxchg_user_wrong_size(void);
> =20
> -#ifndef CONFIG_X86_32
> +#ifdef CONFIG_X86_32
> +/* Always fail on 32 bit arch as it do not support 128 cmpxchg (i.e. cmp=
xchg16b
> + * instruction).
> + */
> +#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label) ({ BUILD_BUG=
_ON(1); 0; })

[Severity: Medium]
Will this BUILD_BUG_ON(1) break 32-bit x86 builds that call the
unsafe_try_cmpxchg_user() macro for perfectly valid 32-bit or 64-bit sizes?

Because unsafe_try_cmpxchg_user() dispatches via a switch(sizeof(*(_ptr)))
statement, compilers like Clang/LLVM eagerly evaluate all branches during
semantic analysis, including the 16-byte branch. If evaluated on 32-bit
builds, BUILD_BUG_ON(1) will trigger a compile-time error regardless of
whether the 16-byte path is actually reachable.

Since the commit message says "stub the helper to always return failure",
would it be better to return a runtime error code here instead of using
a build bug?

> +#else
>  #define __try_cmpxchg64_user_asm(_ptr, _oldp, _nval, _label)		\
>  	__try_cmpxchg_user_asm("q", "r", (_ptr), (_oldp), (_nval), _label)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826070004.8100=
-1-sarunkod@amd.com?part=3D1
