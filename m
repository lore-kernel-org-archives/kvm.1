Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BEB492532
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711813; cv=none; b=tI0TvXCwuSUvEQzxjpPQZLwFst8+3ib0pw/R5Yrf+aLkpF5sdXHoM3HifrC1CzRaRlwdkImSgVZze1fdIG1zl31X5ELusoOaGKKL6DWT3m8Vfz7J5DvIcqc1Tf6GNieQ66VK0C+ryZ+0o9gBLKziBCMgBCfIpx1MLHO41i7+e4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711813; c=relaxed/simple;
	bh=dxNfyEKRiRFwyQqRe6lndMsY6Unz13+C61p8/6Ex0g0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d18k4rue3fLaLYMnbpFBXHNLE2N9pLz6kOMXpkMyCWC1SLkNRSEFREKY/2VJ9yFaCTvusnpNdV5kOR17SidN++3rJ83WDGNkjy05rc3ZG0GnBpOcGZWniPOKLiG51VZd6ARczxsIg3q0rdJK9YrqfKGQ0bJ0TxI3GgUCEeLtiXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt5HJBue; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt5HJBue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FC51F000E9;
	Wed, 22 Jul 2026 09:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784711809;
	bh=Qj4bo9yMxBNl6pUC1191fy5Zl48h1/FJ7+7zb3yn1VM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mt5HJBue2zqPoS+1sosPO1oJGChElo/a3haZB7knmsnzsae+MRQaUpt/mOHiveu6o
	 bYkJRw3uAuk4bk4uiX9tseau0oY48SdVbtW1Tr6FpkZzZcWv+L+REacCuX0qOtWNmi
	 CPAHpX4n9lmyOSudQpDqdkDe09iWkob+HnSk8ppZrSaopfNFU87NlDOjVpeGGwQg0o
	 JBC55ezvJ6bTfUFQR3M7gQ1/pzvjSQvfSPro+0lxxu4qglQfTQHWarzy+N1hIp4tdt
	 oGVTQzQiO40TvcmQfVNwEE3hzY/pIspuhEibgz8N056G7dovfygcuSUmnKTfKNFSOB
	 rkwRxP5Vbw1gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86: bound the composed nested TSC multiplier to
 the max ratio
Reply-To: sashiko-reviews@lists.linux.dev
To: amirmohammad.eftekhar@cispa.de
Cc: kvm@vger.kernel.org
In-Reply-To: <20260722084702.1028983-1-amirmohammad.eftekhar@cispa.de>
References: <20260722084702.1028983-1-amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 09:16:48 +0000
Message-Id: <20260722091649.40FC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] kvm_calc_nested_tsc_multiplier prevents overflow truncations but f=
ails to prevent the composed multiplier from underflowing to 0, which leads=
 to hardware VM-entry failures or unhandled host #GPs.
--

--- Patch [1]: [PATCH] KVM: x86: bound the composed nested TSC multiplier t=
o the max ratio ---
commit d48c3d3ad18139611ae5e395e3b21cd0a088ff37
Author: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>

KVM: x86: bound the composed nested TSC multiplier to the max ratio

This patch limits the composed nested TSC multiplier to the hardware maximum
ratio to prevent truncation or reserved bit exceptions. It calculates the
product of L1 and L2 multipliers as a 128-bit value and saturates it to the
advertised maximum if it overflows. This ensures the guest remains alive at=
 a
representable ratio rather than failing.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ff8812f3a1293..ad9372e6f55df 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -2684,11 +2684,31 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_calc_nested_ts=
c_offset);
> =20
>  u64 kvm_calc_nested_tsc_multiplier(u64 l1_multiplier, u64 l2_multiplier)
>  {
[ ... ]
> +	nested_multiplier =3D mul_u64_u64_shr(l1_multiplier, l2_multiplier, fra=
c);
> +	if (nested_multiplier > kvm_caps.max_tsc_scaling_ratio)
> +		return kvm_caps.max_tsc_scaling_ratio;
> +
> +	return nested_multiplier;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does this composed multiplier
need to be clamped to prevent underflowing to 0?

While this patch successfully caps the multiplier at
kvm_caps.max_tsc_scaling_ratio, if the L0 guest runs significantly slower t=
han
the host (M1 < 2^frac) and L1 configures a valid L2 multiplier (e.g., M2=3D=
1),
the product (M1 * 1) >> frac naturally evaluates to 0.

When the multiplier evaluates to 0, it can lead to a hardware VM-entry
failure on VMX, destroying L1.

Additionally, looking at svm_set_msr() in arch/x86/kvm/svm/svm.c:

	case MSR_AMD64_TSC_RATIO:
		if (data & SVM_TSC_RATIO_RSVD)
			return 1;

		svm->tsc_ratio_msr =3D data;

Since 0 & SVM_TSC_RATIO_RSVD evaluates to 0, this check fails to reject
data =3D=3D 0. This allows L1 to directly trigger the zero-multiplier path =
on
SVM without KVM injecting the architecturally required #GP, which can result
in an unhandled host #GP.

Could the result be clamped to a valid minimum (such as 1) to prevent the
composed multiplier from evaluating to 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722084702.1028=
983-1-amirmohammad.eftekhar@cispa.de?part=3D1
