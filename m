Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E26489894
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355544; cv=none; b=hGNY4Qj1qhMwRGc9S4U3UKoCEoKsvJyARc6YUkAXpnXqXfuj85E2FmLjMJJLE9P2jqEomfBwhrnpYUTsFU+CatRRKB3S3PMl4p0aPdp2K5/LrDA1ExvInWtmCeOAoYQ9sg3aI3H6SqeRFVUfz4fF1qvaHhejDnxiAiZVJMclvP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355544; c=relaxed/simple;
	bh=nIjWIVxqIOlUpAKsgdhjyvI+nBtmYidCK/yhk1/bLLs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nfcbWND5cqppszcEvf9nX2833ntSKP0Ht7PDtGZxLi6+igTTzg2RsIbzx5Nvw5OxTEu6WYTe5T0zU0uQucEwJTfRbHwtf5T3tp4qO3FUCQCPMv79cqC/d1P1OBgmNbpGtUYk9q4uGH1rExY4UT4eAAms7cZPQzucuUsV78TD2OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYyceabS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYyceabS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5868C1F000E9;
	Wed, 29 Jul 2026 20:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785355543;
	bh=A3CfPtR0/iMMDZSCAFVmxMa5lIcQ9dB2azc5h0q0Jyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NYyceabSynfbin+VmdKMkoY7kyj4/kRcte9Xcc1/RVi+8gNXjN89IRmF2mtBV6/bq
	 a8b2Alo9Hur0NSD/6FCK94mx2uOD/N7IBZwTd9GDOzTr3quYNS+Zi8nVE5SAfL6LDs
	 CjxBh2EYGJCwQvrcPrkPwbkbv8ThnMEW4xILSAH+ukCLNMnOjDbFnT9q33Oq4xkFvx
	 i6rmaj8+tC8SoN+8S9RSBjrV345wLqhFK7cqwkPdyxDbcXOlrPVvKpKD5iU8X/MgxS
	 AhfxB+lPnTm8+gTobVNi+Lq1OnT/ne12EuKle+eg/7GYXsqI9wuZnycUv5a+NRCgUT
	 g51NV7uOtSIoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/20] KVM: VMX: Save guest EGPRs in VCPU cache
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729191656.598771-3-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
 <20260729191656.598771-3-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 20:05:42 +0000
Message-Id: <20260729200543.5868C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Live migration of APX-enabled guests results in silent guest state=
 corruption (loss of EGPRs) due to a conflict between manual VCPU register =
caching and XSAVE state management.
--

--- Patch [2]: [PATCH v6 02/20] KVM: VMX: Save guest EGPRs in VCPU cache ---
commit 8d65deb78b6fe07e8687f8aa1c29bd4e028cfac7
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: VMX: Save guest EGPRs in VCPU cache
   =20
This patch saves and restores the guest EGPRs on VM exit/entry if the system
supports Advanced Performance Extensions (APX). It saves the EGPR state into
vcpu->arch.regs and clears the hardware registers on exit.

Link: https://lore.kernel.org/adPRA4ZhnvbaXSn0@google.com

> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> index 00d807505fc88..702d86ade6b1d 100644
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S

[ ... ]

> @@ -193,8 +204,24 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
>  	mov %_ASM_BX, %_ASM_AX
> =20
>  	/* Pop our saved arguments from the stack */
> -	pop %_ASM_BX
> -	pop %_ASM_BX
> +	pop %_ASM_BX	/* @flags */
> +	pop %_ASM_DI	/* @vmx */
> +
> +#ifdef CONFIG_KVM_APX
> +	ALTERNATIVE "jmp .Lclear_egprs_done", "", X86_FEATURE_APX
> +	test	$KVM_ENTER_EGPR_SWITCH, %_ASM_BX
> +	jz	.Lclear_egprs_done
> +	/*
> +	 * Unlike legacy GPRs, saving could be conditional here on VM-Fail,
> +	 * which however isn't in fastpath. Instead, simply saving EGPRs always.
> +	 */
> +	STORE_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
> +		   %r16, %r17, %r18, %r19, %r20, %r21, %r22, %r23, \
> +		   %r24, %r25, %r26, %r27, %r28, %r29, %r30, %r31
> +	CLEAR_REGS %r16d, %r17d, %r18d, %r19d, %r20d, %r21d, %r22d, %r23d, \
> +		   %r24d, %r25d, %r26d, %r27d, %r28d, %r29d, %r30d, %r31d

[Severity: High]
Does clearing the hardware EGPRs here cause state loss during live migratio=
n?

When KVM later unloads the vCPU and calls kvm_put_guest_fpu(), it uses the
hardware XSAVES instruction to capture the guest's FPU/extended state into
vcpu->arch.guest_fpu. Because the hardware EGPRs were zeroed here, XSAVES
populates the APX component of the XSAVE buffer with zeros.

When userspace subsequently calls KVM_GET_XSAVE2 to serialize the state for
migration, it exports the zeroed guest_fpu without synchronizing the true
register values from vcpu->arch.regs.

Additionally, userspace cannot fallback to KVM_GET_REGS because the UAPI
struct kvm_regs hasn't been updated to include R16-R31.

Could this lead to APX-enabled guests resuming with zeroed EGPRs after a
migration?

> +.Lclear_egprs_done:
> +#endif
> =20
>  	/* ... and then the callee-save registers */
>  	pop %_ASM_BX

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729191656.5987=
71-1-chang.seok.bae@intel.com?part=3D2
