Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3033B7A8
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785197138; cv=none; b=pFrR2WbSLqTClR2tVwV24AOnrmF+cI172rVnjO+xlCJlNPYuPs24OMnJ0iWiLPWb14P+cCl5tajXvXro6MSuttygOpetDEWav+KylBqiCBGBdXQHT2cVKW1ikmlNRQJv2g6uXQZD+tS18UWmhdAyryNnMu6H8gd1B5XsOiSpJw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785197138; c=relaxed/simple;
	bh=wCaMgmbgUmwPw+f9tgGduVxUJNSqb+HbNI6pzHFh9vU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=btWWQDorfLSFrjLPRWB4qRvkxLCCh6mWurgZNa3B2loof+teiZOuBtij0qskRR5RgpNTbizajcWhDJFtiUSyxN00P6+B0crRgcjGkJfKD49TK/az4hjK3Wenm/sVlWhrV457Cqw1R3z1+jd2+SmUMbTg46TtE4TqjxRsIhAvBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wz/1Ek3q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wz/1Ek3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205D81F000E9;
	Tue, 28 Jul 2026 00:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785197137;
	bh=0gljHzV86zGHLKxnkyt89iUrmbUMFUdkyohQE+PWIY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wz/1Ek3qHwklhHCWm+Sg6agHgIL10XnFsT0e0pqQwOjIQ78t+jaM9wjUmXB1RrbRc
	 anxsMvQX4MUnr/aKvUqWavgnKqBskLqRTUNEeRrBwBCzUW4b66bn66FRsTo2w8dq/Y
	 9fmN9miJcGNElHPPe6RxGSzFGRgQHVRmtC46jetgtnOgDTVBahc4PVOnesUe/7bLlw
	 jUevh7io/Z2BIop6oFhfpCOUKlEh3TmpHj7ChEZ/arVHBkouKaVbdtSdoOzh3ReDWu
	 seWIbf6PA0R1ywAwGM9LdSUaVucIBVqaeBHrBuhlfZBI9A8K7hnUkbFQ758HCp4R7c
	 qORfHKC4LYzJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/12] KVM: selftests: Reuse GPR switching logic for
 nVMX
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260727235228.1007324-6-yosry@kernel.org>
References: <20260727235228.1007324-1-yosry@kernel.org>
 <20260727235228.1007324-6-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 00:05:36 +0000
Message-Id: <20260728000537.205D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit introduces a severe data race by switching VMX nested=
 tests to use a global `guest_regs` structure for GPR switching, intentiona=
lly breaking multi-vCPU tests.
--

--- Patch [5]: [PATCH v4 05/12] KVM: selftests: Reuse GPR switching logic f=
or nVMX ---
commit 685ecb766edbf0f5d0df447d92a4e818914eeff2
Author: Yosry Ahmed <yosry@kernel.org>

KVM: selftests: Reuse GPR switching logic for nVMX

This commit replaces the stack-based thread-safe GPR switching in nVMX tests
with a global GPR switching logic used by SVM. It adds VMX_SWITCH_GPRS_ASM
which switches registers into a global guest_regs structure during vmlaunch
and vmresume.

> diff --git a/tools/testing/selftests/kvm/include/x86/evmcs.h b/tools/test=
ing/selftests/kvm/include/x86/evmcs.h
> index be79bda024bf1..82a8ea6b661f0 100644
> --- a/tools/testing/selftests/kvm/include/x86/evmcs.h
> +++ b/tools/testing/selftests/kvm/include/x86/evmcs.h
[ ... ]
> @@ -1207,30 +1207,23 @@ static inline int evmcs_vmlaunch(void)
> =20
>  	current_evmcs->hv_clean_fields =3D 0;
> =20
> -	__asm__ __volatile__("push %%rbp;"
> -			     "push %%rcx;"
> -			     "push %%rdx;"
> -			     "push %%rsi;"
> -			     "push %%rdi;"
> -			     "push $0;"
> +	__asm__ __volatile__("push $0;"
>  			     "mov %%rsp, (%[host_rsp]);"
>  			     "lea 1f(%%rip), %%rax;"
>  			     "mov %%rax, (%[host_rip]);"
> +			     VMX_SWITCH_GPRS_ASM

[Severity: Medium]
Will this corrupt register state in multi-vCPU nested tests?

By moving from a thread-safe stack push/pop sequence to using
VMX_SWITCH_GPRS_ASM, concurrent tests that execute evmcs_vmlaunch()
could overwrite each other's saved GPRs.

This happens because the registers are swapped into a global guest_regs
structure rather than being pushed to each thread's local stack.

>  			     "vmlaunch;"
>  			     "incq (%%rsp);"
[ ... ]
> diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testin=
g/selftests/kvm/include/x86/vmx.h
> index 4bcfd60e3aecb..04f5e34dea3ae 100644
> --- a/tools/testing/selftests/kvm/include/x86/vmx.h
> +++ b/tools/testing/selftests/kvm/include/x86/vmx.h
[ ... ]
> @@ -290,6 +290,23 @@ struct vmx_msr_entry {
>  	u64 value;
>  } __attribute__ ((aligned(16)));
> =20
> +#define VMX_SWITCH_GPRS_ASM \
> +	GUEST_SWITCH_GPR_ASM(rax) \
> +	GUEST_SWITCH_GPR_ASM(rbx) \
> +	GUEST_SWITCH_GPR_ASM(rcx) \
> +	GUEST_SWITCH_GPR_ASM(rdx) \
> +	GUEST_SWITCH_GPR_ASM(rbp) \
> +	GUEST_SWITCH_GPR_ASM(rsi) \
> +	GUEST_SWITCH_GPR_ASM(rdi) \
> +	GUEST_SWITCH_GPR_ASM(r8)  \
> +	GUEST_SWITCH_GPR_ASM(r9)  \
> +	GUEST_SWITCH_GPR_ASM(r10) \
> +	GUEST_SWITCH_GPR_ASM(r11) \
> +	GUEST_SWITCH_GPR_ASM(r12) \
> +	GUEST_SWITCH_GPR_ASM(r13) \
> +	GUEST_SWITCH_GPR_ASM(r14) \
> +	GUEST_SWITCH_GPR_ASM(r15)
> +

[Severity: Medium]
Could this macro introduce data races during GPR switching?

Since VMX_SWITCH_GPRS_ASM generates instructions that rely on a shared
global guest_regs structure, any multi-vCPU nested tests (like the memstress
framework) running concurrent operations might crash due to host threads=20
clobbering the global state.

>  #include "evmcs.h"
> =20
>  static inline int vmxon(u64 phys)
[ ... ]
> @@ -373,34 +387,24 @@ static inline int vmlaunch(void)
>  	if (enable_evmcs)
>  		return evmcs_vmlaunch();
> =20
> -	__asm__ __volatile__("push %%rbp;"
> -			     "push %%rcx;"
> -			     "push %%rdx;"
> -			     "push %%rsi;"
> -			     "push %%rdi;"
> -			     "push $0;"
> +	__asm__ __volatile__("push $0;"
>  			     "vmwrite %%rsp, %[host_rsp];"
>  			     "lea 1f(%%rip), %%rax;"
>  			     "vmwrite %%rax, %[host_rip];"
> +			     VMX_SWITCH_GPRS_ASM
>  			     "vmlaunch;"

[Severity: Medium]
Does this change similarly break vmlaunch() for multi-vCPU tests?

Just like evmcs_vmlaunch(), replacing the previously thread-safe stack
pushes here with VMX_SWITCH_GPRS_ASM will cause register data corruption
when multiple threads execute vmlaunch() concurrently.

>  			     "incq (%%rsp);"
> -			     "1: pop %%rax;"
> -			     "pop %%rdi;"
> -			     "pop %%rsi;"
> -			     "pop %%rdx;"
> -			     "pop %%rcx;"
> -			     "pop %%rbp;"
> +			     "1: ;"
> +			     VMX_SWITCH_GPRS_ASM
> +			     "pop %%rax;"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727235228.1007=
324-1-yosry@kernel.org?part=3D5
