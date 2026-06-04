Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B034F24E
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780606325; cv=none; b=W6WSIIpaXYHOZ2AUJPX5AZaVkW82g7d+L2GmcI8nAeZM7T9xcAzwnZg7KeQbkWJHRvvpbsbJJS9PRyx843CmsqH64NzCmZnrl4bIQFDjWIAQ2nE/1pi8FcZqgPNmvrKwCv90H0GGPGeIDpFj++DYAtECKQ3wZVHGzF/PQo7NmGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780606325; c=relaxed/simple;
	bh=LVCcjp939+Xjs5u+4QIk53umM4/vPz2FWfVTkryAJr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lNi0Skn0cl7fYYKZZi48GJqz44ETNVdbex14+rlQpDyMuw7MM8pJHhV3g2oJOPqEW3/Oc20dCqNHwG7s37pw/sKR9Al7tgbKBDSG5/6nmJiDpiVB1cLdb0YsLl6mtpsCfrh00WqBUCt5og893kPaw1JzEdDT2E3caYzCQEmR2Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLfJidvY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLfJidvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09181F00893;
	Thu,  4 Jun 2026 20:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780606324;
	bh=wiFzUkPSPl+abt20Pj38RiOLeTAuWlzDDJjhDEK1CcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CLfJidvYdhcqwADpY0WcB7jLObYdG+3U62KKqXpRiztFd3ww5HeBwhcltxAuA8PgZ
	 o7UqXLHi6MfQYL4YIx0x/i8bpPMhb+V/gojdP1RJuUqqbCmKWUu+ff1YFgIp1jKsNq
	 a0ED0mLrQm2pdOxixmpk5u88PcKyAgRThJ3R16cs6sj6yRI/ADb+grqlq57k4/pw7u
	 bHV6GlFeY+D5rbh0uqi2sLcUvG9KI9SxfcFmcU7X/cakz60LaM6Z63ra5DmLagcNcr
	 QP2ulAg8LHceLWYP5m28Ks7WjaqKc1i8uyFuAgz9D4nDSnQIi+tEs33Gf1rKwE1Mn6
	 oorSrjE3qbfWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/10] KVM: selftests: Reuse GPR switching logic for
 nVMX
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604203546.365658-6-yosry@kernel.org>
References: <20260604203546.365658-6-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:52:03 +0000
Message-Id: <20260604205203.F09181F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `guest_regs` array is sized for 15 elements, but 16 elements a=
re accessed, causing an out-of-bounds read/write to the `.bss` section.
- [Medium] `vmlaunch()` and `vmresume()` behavior for guest GPRs diverges b=
ased on the `enable_evmcs` flag, silently failing tests that rely on the ne=
w GPR switching logic under Enlightened VMCS.
--

commit 496a5916183241f499c38e4f427dd5cbecd4dc37
Author: Yosry Ahmed <yosry@kernel.org>

    KVM: selftests: Reuse GPR switching logic for nVMX
   =20
    Reuse the GPR switching logic for nVMX by defining VMX_SWITCH_GPRS_ASM,
    which is essentially the same as SVM_SWITCH_GPRS_ASM but also switches
    RAX, replacing the push/pop of a subset of the registers.
   =20
    The long clobber list of registers is no longer needed as registers are
    saved and restored appropriately (and not clobbered by L2).

> diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testin=
g/selftests/kvm/include/x86/vmx.h
> index 90fffaf915958..64996c310fe4c 100644
> --- a/tools/testing/selftests/kvm/include/x86/vmx.h
> +++ b/tools/testing/selftests/kvm/include/x86/vmx.h
> @@ -363,9 +363,23 @@ static inline u64 vmptrstz(void)
>  	return value;
>  }
> =20
> -/*
> - * No guest state (e.g. GPRs) is established by this vmlaunch.
> - */
> +#define VMX_SWITCH_GPRS_ASM \
> +	GUEST_SWITCH_GPR_ASM(rax, GUEST_REGS_RAX) \
> +	GUEST_SWITCH_GPR_ASM(rbx, GUEST_REGS_RBX) \
> +	GUEST_SWITCH_GPR_ASM(rcx, GUEST_REGS_RCX) \
> +	GUEST_SWITCH_GPR_ASM(rdx, GUEST_REGS_RDX) \
> +	GUEST_SWITCH_GPR_ASM(rbp, GUEST_REGS_RBP) \
> +	GUEST_SWITCH_GPR_ASM(rsi, GUEST_REGS_RSI) \
> +	GUEST_SWITCH_GPR_ASM(rdi, GUEST_REGS_RDI) \
> +	GUEST_SWITCH_GPR_ASM(r8,  GUEST_REGS_R8)  \
> +	GUEST_SWITCH_GPR_ASM(r9,  GUEST_REGS_R9)  \
> +	GUEST_SWITCH_GPR_ASM(r10, GUEST_REGS_R10) \
> +	GUEST_SWITCH_GPR_ASM(r11, GUEST_REGS_R11) \
> +	GUEST_SWITCH_GPR_ASM(r12, GUEST_REGS_R12) \
> +	GUEST_SWITCH_GPR_ASM(r13, GUEST_REGS_R13) \
> +	GUEST_SWITCH_GPR_ASM(r14, GUEST_REGS_R14) \
> +	GUEST_SWITCH_GPR_ASM(r15, GUEST_REGS_R15)

[Severity: High]
Does this access past the end of the guest_regs array?

GUEST_REGS_R15 evaluates to 15, and the array is defined in
tools/testing/selftests/kvm/include/x86/processor.h as:

#define NR_GUEST_REGS	GUEST_REGS_R15
extern u64 guest_regs[NR_GUEST_REGS];

Since NR_GUEST_REGS is 15, the array only holds 15 elements (indices 0 to 1=
4).
Calling GUEST_SWITCH_GPR_ASM(r15, GUEST_REGS_R15) will read and write the 1=
6th
element at index 15, resulting in an out-of-bounds access that corrupts mem=
ory
in the .bss section.

> +
>  static inline int vmlaunch(void)
>  {
>  	int ret;
> @@ -373,34 +387,23 @@ static inline int vmlaunch(void)
>  	if (enable_evmcs)
>  		return evmcs_vmlaunch();

[Severity: Medium]
Will this break EVMCS test configurations?

If enable_evmcs is true, the code redirects to evmcs_vmlaunch() which wasn't
updated to use VMX_SWITCH_GPRS_ASM.  It still uses the old inline assembly
that completely ignores guest_regs:

tools/testing/selftests/kvm/include/x86/evmcs.h:evmcs_vmlaunch() {
    ...
    __asm__ __volatile__("push %%rbp;"
                 "push %%rcx;"
                 "push %%rdx;"
                 "push %%rsi;"
                 "push %%rdi;"
                 "push $0;"
    ...
}

Any KVM selftest that relies on guest_regs to establish L2 state before VM
entry will now silently execute with uninitialized L2 GPRs when run with EV=
MCS
enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604203546.3656=
58-1-yosry@kernel.org?part=3D5
