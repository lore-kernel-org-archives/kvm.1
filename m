Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D8C41E6B6
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251288; cv=none; b=U9tQr3C/8GMOZKXGcliGqJHMzZhlyDtiuLOftruM+b1lBwJzC3JLFvmSEXMA7x7HSoWCm8VhG2Ir3MOkfEiJcKVXqGkGMJRqdSKg52b5o1NtF+pLEvJVjyBoK5hesH1fOqwYq3e8bu2PvTuQkqsMSoXbKQczOkrCYJxtpy9B97I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251288; c=relaxed/simple;
	bh=p9cFdH5405zX7GJPjZVqMWv8IxERvoteM40qKh01Gdw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HpNoscygqkb8+udLquj/BSTPptMbo/Ju0yM5UKd/t6osCugiXxMNPpEEMZVPYVOWmKUdXh8gtUOTX26PyqSxO3o39MXLaG+xHtV+SRGezPi1ODiMTvY82FT9Xq5SYi2vS5cyo7YU3S6wF5JqMQvfdfGLWUdEgZWa1ppqfO6mcuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iANd9g91; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iANd9g91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68BE1F00A3D;
	Tue, 28 Jul 2026 15:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785251287;
	bh=u+KaUB1WViZTxTSd6IRpwOiv1xXb9HffoZK1nXXo6Wk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iANd9g91lhVPAcb0+zNNg1wFZzEfXBcllCnvlQBYFfDErkjf8yHT+c07P9QHQ2mrb
	 J/ZpX63Vm1DXjw/TxtOvPod1zz9jKz70J1tfNxxMEBipss8wYd368w8+jhASVP8Lvp
	 o99Syamsx9OqnljVNfTFgCmQgd0QLzhh3spi7U072a+4Hssfjj5VIroaaIKZzzOudR
	 MZk1FfhYYBrHcmIslGe9mpmnWSyNkNhGbEvVXdEL0oUUm2V6zRqJnc0vXbhLlQbaF9
	 D7G2wNCn4RSScz+jzv/4xq9up1Ubu7Ho+Lb0uum8hI8R02BQSH6JIuKrdrcIzprtfn
	 +RQzxFcPNxdFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/36] KVM: x86: Improve synchronization in
 kvm_synchronize_tsc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728144954.355376-15-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
 <20260728144954.355376-15-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:08:06 +0000
Message-Id: <20260728150806.C68BE1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect TSC calculation during synchronization mixes different t=
ime bases (generation base vs. relative elapsed time), causing the guest TS=
C to drift backwards for 3rd and subsequent vCPUs.
- [Medium] The commit message claims to reset {data, ns} to previous values=
, but the code actively advances the reference point instead.
--

--- Patch [14]: [PATCH v7 14/36] KVM: x86: Improve synchronization in kvm_s=
ynchronize_tsc() ---
commit 19537539a4f15d4647e8e8b2f7465c1412098ea0
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Improve synchronization in kvm_synchronize_tsc()

This commit addresses issues with how last_tsc_write and last_tsc_nsec were
recorded, which caused subsequent writes to fail synchronization. It also
unifies the TSC reads used for calculating current time by using
kvm_get_time_and_clockread() where possible.

> Fix that by resetting {data, ns} to the previous values before passing
> them to __kvm_synchronize_tsc() when synchronization is detected.
> Except in the case where the TSC is unstable and *has* to be synthesised
> from the host clock, in which case attempt to create a nsec/tsc pair
> which is on the correct line.

[Severity: Medium]
The commit message states that it fixes the issue by resetting data and ns
to the previous values, but the code appears to actively advance the
reference point instead.

Could the commit message be updated to more accurately reflect the implemen=
ted
logic?

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 083ab2ca6282f..a1265d1f5c3fe 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -1347,13 +1360,18 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u=
64 *user_value)
>           */
>  	if (synchronizing &&
>  	    vcpu->arch.virtual_tsc_khz =3D=3D kvm->arch.last_tsc_khz) {
> -		if (!kvm_check_tsc_unstable()) {
> +		/*
> +		 * If synchronizing, advance the reference point to "now"
> +		 * so the matching window slides forward with each vCPU.
> +		 */
> +		u64 delta =3D nsec_to_cycles(vcpu, elapsed);
> +
> +		data =3D kvm->arch.cur_tsc_write + delta;

[Severity: High]
Does this calculate an incorrect TSC value by mixing different time bases?

It appears that elapsed is computed as the time since the previous vCPU,
but delta is added to kvm->arch.cur_tsc_write, which is the absolute base
TSC of the first vCPU in the generation.

If a VM is created with 3 or more vCPUs, wouldn't the time elapsed between
the 1st and 2nd vCPUs be lost when calculating for the 3rd vCPU? This seems
like it could cause the guest TSC to drift backwards across vCPUs.

> +
> +		if (!kvm_check_tsc_unstable())
>  			offset =3D kvm->arch.cur_tsc_offset;
> -		} else {
> -			u64 delta =3D nsec_to_cycles(vcpu, elapsed);
> -			data +=3D delta;
> -			offset =3D kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
> -		}
> +		else
> +			offset =3D kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
>  		matched =3D true;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144954.3553=
76-1-dwmw2@infradead.org?part=3D14
