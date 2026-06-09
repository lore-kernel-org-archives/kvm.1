Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC1B3FDBE7
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003414; cv=none; b=uwz+WoYdQH5GC67cyASm4QZDAxJgKT/Kr+PuYtf3TYUWudxOGAk+MbpIAKkY5gH0ADzPeOsYq6J+D01m2/DT9XPnOYLPHXeZZ3uXdXTx4YJl5DsWubbG/UoYd2yfYVemU7XiaPlbk/DYVOM9VX6nkFmuyoJ4Yb+K+decV3uMZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003414; c=relaxed/simple;
	bh=XxR77+goy7o218aTD2lsuF8kSz0ytT3pDsFi99NsT4s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n5RKGG8D18CkkqPUWS0XD6+agJI/ZhxbZvFOVOJlwF+eg1VaEkqzfYpcE2CB75a0DKJoIjVVN6rAhYsYe8ckZRbvRJPmA2faijbYwzC5HecWygoSYOf0QY5WT9f24fi8c81/6QFEODG92sJeRAW2baDcCninCWuoPkOenYYVEoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSXrkcHq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSXrkcHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1111F00899;
	Tue,  9 Jun 2026 11:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781003412;
	bh=ft2SwOszfFgHDcwDkp7GdCgoqVf02m9iwL93YZ88ovc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OSXrkcHq2N16dSgRDeHI4EWZjsmTZduLMdHxSBS3R5QgKYQ/77aWiD6EIRH4HCV30
	 FT7CmIwlzlBh32Zb53NemrE3wg1904zik8hE/fvFvw6YJP9Onufg79A4jIO0oeD4Yz
	 xhPfMZIQcOig2YA4FBR0/CJtvret9BdUQn8rs2V3BytpMjd1fn75EDETUN5rLXkRC1
	 YlO5b6DdRSE8uGXreUVfEiBcVh35Hfl920cFO2GjZ/McY2LOnpWuVHmZETx9Wuw6QE
	 diQxO72fG1Z3FVJ4zTcQJG0l7SR/YY3JIRHCkhabTJHG3HdKVJLLY1pl5GNsIrRJz7
	 8DcJ6m+QmnwOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] KVM: x86: Do not gate MCE logging based on
 IA32_MCi_CTL
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2FybG9zIEzDs3Bleg==?= <clopez@suse.de>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260609105525.2545638-4-clopez@suse.de>
References: <20260609105525.2545638-4-clopez@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 11:10:12 +0000
Message-Id: <20260609111012.8B1111F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch incorrectly overwrites the MCE banks when a double/tripl=
e fault occurs (MCIP flag already set).

Pre-existing issues:
- [High] The patch fails to apply the MCE logging fix to the global control=
 register IA32_MCG_CTL, leaving MCE emulation architecturally broken.
--

commit 146247f45f3a8d3f982b364bba19a51f76828ce0
Author: Carlos L=C3=B3pez <clopez@suse.de>

KVM: x86: Do not gate MCE logging based on IA32_MCi_CTL

This patch hoists the MCE logging logic above the IA32_MCi_CTL check.
This ensures that KVM logs uncorrectable machine check errors even if
reporting is disabled for that specific bank, conforming to the Intel SDM.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5486,24 +5486,31 @@ static int kvm_vcpu_ioctl_x86_set_mce(struct kvm_=
vcpu *vcpu,
>  	if ((mce->status & MCI_STATUS_UC) && (mcg_cap & MCG_CTL_P) &&
>  	    vcpu->arch.mcg_ctl !=3D ~(u64)0)
>  		return 0;

[Severity: High]
This isn't a bug introduced by this patch, but does this global control
register check also need to be adjusted?

Just like IA32_MCi_CTL, the Intel SDM states that error logging happens
regardless of the setting of the IA32_MCG_CTL bits. By returning early
here, KVM skips logging the uncorrectable error to the bank if the global
reporting is disabled.

Additionally, KVM currently suppresses generation and logging for all
banks if any bit in IA32_MCG_CTL is 0, rather than checking the specific
bit for the bank. Should the logging logic be hoisted above this check
as well?

> -	/*
> -	 * if IA32_MCi_CTL is not all 1s, the uncorrected error
> -	 * reporting is disabled for the bank
> -	 */
> -	if ((mce->status & MCI_STATUS_UC) && banks[0] !=3D ~(u64)0)
> -		return 0;
> +
>  	if (mce->status & MCI_STATUS_UC) {
> +		/*
> +		 * Per the SDM, error logging always happens independently of
> +		 * IA32_MCi_CTL
> +		 */
> +		if (banks[1] & MCI_STATUS_VAL)
> +			mce->status |=3D MCI_STATUS_OVER;
> +		banks[2] =3D mce->addr;
> +		banks[3] =3D mce->misc;
> +		banks[1] =3D mce->status;
> +
> +		/*
> +		 * if IA32_MCi_CTL is not all 1s, the uncorrected error
> +		 * reporting is disabled for the bank
> +		 */
> +		if (banks[0] !=3D ~(u64)0)
> +			return 0;
> +
>  		if ((vcpu->arch.mcg_status & MCG_STATUS_MCIP) ||
>  		    !kvm_is_cr4_bit_set(vcpu, X86_CR4_MCE)) {
>  			kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
>  			return 0;
>  		}

[Severity: High]
By hoisting the error logging block above the IA32_MCi_CTL check, does
this now incorrectly overwrite the MCE banks when a double or triple fault
occurs?

According to the SDM, if the processor encounters another machine-check
error while the MCIP flag is already set, it causes a triple fault and
does not update the status registers for the second error.

Since the logging block in kvm_vcpu_ioctl_x86_set_mce() now executes
before checking for MCG_STATUS_MCIP, it looks like it will overwrite the
original addr, misc, and status of the first error before requesting the
triple fault.

> -		if (banks[1] & MCI_STATUS_VAL)
> -			mce->status |=3D MCI_STATUS_OVER;
> -		banks[2] =3D mce->addr;
> -		banks[3] =3D mce->misc;
>  		vcpu->arch.mcg_status =3D mce->mcg_status;
> -		banks[1] =3D mce->status;
>  		kvm_queue_exception(vcpu, MC_VECTOR);
>  	} else if (!(banks[1] & MCI_STATUS_VAL)
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609105525.2545=
638-2-clopez@suse.de?part=3D2
