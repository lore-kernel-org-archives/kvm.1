Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C6C30D41C
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 03:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788319580; cv=none; b=Zwe6A5tIvEk3izxvQZWHogv4e+bDRYYl8eSKrCfMa3+mH3DSkBtlu78fGBv6jgtf6faV7pbDht5InxuzBRnqMn94mGyLfwM3Q+vf31aOy5FeIaU4K2TzZydDtQ3u71AG35y8Bd3gwrh6hsWkrEfTEQs6IvQABfGazXXu/WfY+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788319580; c=relaxed/simple;
	bh=drsrORB2aaYMt7PdVCtHE/FS1A9fjTFvIpw03Dx7VC4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hli0dtbOyEbI0BcBVG95yosfv1ST3OPMVXTx4y513g3GPRYkF5BhSRL2nJDjmGdrmZtx7/nZ0d9CxEjzTOPh9dfiRezYpL52aKBtKpbyfZ4ukY4w7iYRmG2jCW8TYTvtuIRlFlDQ4j0U1fQikO24yTt2qqkALXQKZKL0RlSHCKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crJHGL2B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crJHGL2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76FC1F000E9;
	Wed,  2 Sep 2026 03:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788319578;
	bh=KFbEThnWxhW00b+oZSbHsimW2fVREGWVwX0n/pGE43A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=crJHGL2BP7p7JssxzETRncNSBfXX8g0s/mV3Agj7JWkfQSH91GS6vDzRX/zHOasHk
	 vygMldfod+5kTuwRgxnpUpDJdtOiv3HbxTBodoGAoDts5xanBQKpAX5ViRF3PABbWn
	 qeU98QAFsehZhuswhNTyDtPEerrCurJ3qaF7a+TzwJW4XZuodImM3zYyqDg0pahuek
	 eNagrOMxvH1/jCcWiQ1HpM6yLMOVOIKczH19jU59Q1BreSJNiE4fqA5piAq/74XpIb
	 vtJzOh9pONFhmWvSATUJ8ESG7pe/Kf/mpc1N7PRRTau/kJs80+aGYmO5u+HxsvoHzU
	 maTL61JNjJQ0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/20] KVM: VMX: Save guest EGPRs in VCPU cache
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902021804.718676-3-chang.seok.bae@intel.com>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
 <20260902021804.718676-3-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 03:26:18 +0000
Message-Id: <20260902032618.A76FC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Host kernel data in Extended General Purpose Registers (EGPRs) is =
leaked to a malicious guest via speculative execution when the guest operat=
es with APX disabled.
--

commit 70442dd137e1b61dbdd5b674afc21cfb7948b2b6
Author: Chang S. Bae <chang.seok.bae@intel.com>
KVM: VMX: Save guest EGPRs in VCPU cache

This commit saves and restores the guest EGPRs on VM exit/entry if the
system supports Advanced Performance Extensions (APX). It skips loading the
EGPR state for guests that do not set XCR0[APX], and places the register
saving path after SPEC_CTRL is restored.

Link: https://lore.kernel.org/adPRA4ZhnvbaXSn0@google.com

> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> index 00d807505fc88..02308fb36f0f5 100644
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S

[ ... ]

> @@ -46,6 +47,16 @@ SYM_FUNC_START(__vmx_vcpu_run)
>  	/* Reload @vmx, _ASM_ARG1 may be modified by vmx_update_host_rsp().  */
>  	mov WORD_SIZE(%_ASM_SP), %_ASM_DI
> =20
> +#ifdef CONFIG_KVM_APX
> +	ALTERNATIVE "jmp .Lload_egprs_done", "", X86_FEATURE_APX
> +	testl	$KVM_ENTER_EGPR_SWITCH, (%_ASM_SP)
> +	jz	.Lload_egprs_done
> +	LOAD_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
> +		  %r16, %r17, %r18, %r19, %r20, %r21, %r22, %r23, \
> +		  %r24, %r25, %r26, %r27, %r28, %r29, %r30, %r31
> +.Lload_egprs_done:
> +#endif

[Severity: High]
In __vmx_vcpu_run(), when a guest runs with APX disabled,
KVM_ENTER_EGPR_SWITCH is clear and this branch skips loading the guest's
EGPRs. Are the host's physical %r16 through %r31 register values left
intact upon entering the guest when this happens?

If so, could a malicious guest with APX disabled speculatively execute APX
instructions before the architectural #UD exception retires, allowing it to
read the host's %r16 through %r31 values and leak them via a cache
side-channel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902021804.7186=
76-1-chang.seok.bae@intel.com?part=3D2
