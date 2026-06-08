Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0AD352012
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940369; cv=none; b=oBgjHeyRZEYtgp+m34gcvT9nlx8fwFYd1czaZ/vXmN3s7eIYYRXyhdqDAZSbS6XP95ubO6nEuLWN4nWojfDeQmeqjqgzPN0vxhZyQzr79GFXKtT4oMlcpCHl6cSuDaOZTsZAeSdA1ISJ7NbOyIQ7XWH9JkoNFPT7j0xrAO3F96M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940369; c=relaxed/simple;
	bh=jWWHHyYetXEkFQQEm3xvETAf67xgM3lTCp9cHR5yC4Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hZBTNR7DDkDL4l+bKcCnl0LwtTCcPY8drCDmV3EMX05sJ82IyCFBVLvPuQn0JWXZrH+tQHtvnSbGc/mWnY7CJM6+uS60kCrZLt4VGbXADgrZ++NVMRFOZ/ek6SdIb7PI1hbsRjrCH7MqIKsrM24SJkmLt14sIXZZVUe4bjaqwFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHXcUaRt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHXcUaRt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7CE1F00893;
	Mon,  8 Jun 2026 17:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780940367;
	bh=JP6pLxylTXMhJx/t9pJfPAUsjAVO75aYmPQwZKWFwZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mHXcUaRtoGkkFOSvYDvESs1r+4w4tkmvX3Wb3Yyn+485ST2oYQX5hsxO8V7tP4x2n
	 E4EifJ9OPm9D4PX5CoJ+sOkWs+I2ffmsqOG3LWDo+NIl5jwpRnIT8b71NsbPUPSL5S
	 llIeRywdXBedeeyOF7VsEym1eA2X5srrFuiN+hWOhhVqTbAOPhzXz4qBZnOoEGSx20
	 ItUo1yMkN0vAvN9trPKHeGyQgZzDQLK23/u/28g5VLpbiyS4f12UWKmDNc/7r3q/n5
	 mrknX4MOQeWHur7RR+Z1ZPiB0q3guuW1V2+XztfR4qgq78a9H3ZSxr5/1xCFOTnzeM
	 3k/uzWlb9p+LA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/34] KVM: x86: Fix KVM clock precision in
 get_kvmclock() with TSC scaling
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608145455.89187-13-dwmw2@infradead.org>
References: <20260608145455.89187-13-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 17:39:27 +0000
Message-Id: <20260608173927.7F7CE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Precision loss discrepancy between master clock and vCPU pvclock c=
auses monotonic time jumps on live migration.
--

commit 47c298cb974d0bc994c9dfd80ba585010b2ad459
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Fix KVM clock precision in get_kvmclock() with TSC scaling

This patch fixes a systemic drift in the KVM clock when using TSC scaling.
It precomputes the guest-TSC-based multiplier and shift in
pvclock_update_vm_gtod_copy() and applies them in get_kvmclock() to correct=
ly
scale the host TSC delta to the guest TSC before converting to nanoseconds.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6983a7494fcdd..7ae6a77053530 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -3132,9 +3135,30 @@ static void pvclock_update_vm_gtod_copy(struct kvm=
 *kvm)
>  				&& !ka->backwards_tsc_observed
>  				&& !ka->boot_vcpu_runs_old_kvmclock;
> =20
> -	if (ka->use_master_clock)
> +	if (ka->use_master_clock) {
> +		u64 tsc_hz;
> +
>  		atomic_set(&kvm_guest_has_master_clock, 1);
> =20
> +		/*
> +		 * Copy the scaling ratio and precompute the mul/shift for
> +		 * converting guest TSC to nanoseconds. These are used by
> +		 * get_kvmclock() to compute kvmclock from the host TSC
> +		 * without needing a vCPU reference.
> +		 */
> +		ka->master_tsc_scaling_ratio =3D ka->last_tsc_scaling_ratio;
> +		tsc_hz =3D (u64)get_cpu_tsc_khz() * 1000;
> +		if (tsc_hz && kvm_caps.has_tsc_control)
> +			tsc_hz =3D kvm_scale_tsc(tsc_hz,
> +					       ka->master_tsc_scaling_ratio);

[Severity: High]
Does calculating tsc_hz by multiplying by 1000 before scaling create a
precision discrepancy with the guest's pvclock?

In kvm_guest_time_update(), the guest's pvclock frequency is calculated
by first scaling the host frequency in kHz and then multiplying by 1000 to
get Hz:

    tgt_tsc_khz =3D kvm_scale_tsc(tgt_tsc_khz, v->arch.l1_tsc_scaling_ratio=
);
    tgt_tsc_khz =3D tgt_tsc_khz ? : 1;
    ...
    kvm_get_time_scale(NSEC_PER_SEC, tgt_tsc_khz * 1000LL, ...);

This truncates up to 999 Hz of precision. The new calculation here scales
the Hz directly, resulting in a slightly larger tsc_hz and correspondingly
smaller multiplier than the vCPU's pvclock_tsc_mul.

Because the host uses this smaller multiplier in get_kvmclock(), it will
calculate a slightly smaller elapsed time than the guest has internally
observed. Upon live migration, reading this lagging clock via KVM_GET_CLOCK
could cause the guest's monotonic time to jump backwards when it resumes.

Would it be better to match the guest's exact computation, or update the
guest's calculation to match this higher precision?

> +		if (tsc_hz)
> +			kvm_get_time_scale(NSEC_PER_SEC, tsc_hz,
> +					   &ka->master_tsc_shift,
> +					   &ka->master_tsc_mul);
> +		else
> +			ka->use_master_clock =3D false;
> +	}
> +
>  	vclock_mode =3D pvclock_gtod_data.clock.vclock_mode;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145455.8918=
7-1-dwmw2@infradead.org?part=3D12
