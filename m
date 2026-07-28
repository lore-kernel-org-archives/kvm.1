Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24E230B517
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251471; cv=none; b=uwS1tsbdjzUxSL7bbkIVrZ30TwtVk1lNqpBvdGY+IPriPGenpC90nR+VZtvA/ffoiTsP2pRZbY64mGJV047k15DP612GgHD3oGnU0RBScKiSZi9Td31FBYUeek4jp6itYO376GknU3NqWT9RZroqYwPmkU69qegx7zKffWt9/CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251471; c=relaxed/simple;
	bh=ChIOjVFa02XaYmwnURyjNen5m2xTAwYau+s7xPpkGZI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ekLKf7xFEjp0HuPqcomYCgnIZy5RItO7UF6QK2jjVXYEPIg2T3c6zwN2gZJpfB/sxoqlYBGcpcxJ7Cp3doj34CySy0jGVQS5dnBkXz9Ac89OvcnEeMcTgX399e9pRXsk0Do+OartOC6OtRNsECH90SaH5hn24RKfabYTdx5Jkz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfIk4rvu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfIk4rvu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DD21F000E9;
	Tue, 28 Jul 2026 15:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785251470;
	bh=pIDkggKadmuSiDT3bwdEE3LSmG0CNMDgiNaGKaFzOlI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JfIk4rvufESw+ZfR/6IjI9bLutlXLi14+UTFtSfkvkgdXJlsOPQBTFJwRbwTMwOnq
	 hiliuj0h/5gGRwdy86/loimIe60uFCb9Q7rr+s45f+4AWI8itBDrOO6P9gpSb+OtwI
	 2LNPOoO5/886SydsDywBsjCoWKfjzRA56hNO7q7Tqa9yziIEEU1IalI9aUD3E0sKbY
	 NNNvl1hoKa/B0GGu8AChw2gro/M+VspIfYjrd1M7jek0BnwvLnXt2zjJktbSWLrNTp
	 +cJE3lsLx6myKYCHe0wUuiJ48P4iqgfZmWyXyyUw2escGbYa+2fCPC7vkhRMYY8EHr
	 KdBOwbjQllwBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/36] KVM: x86: Restructure kvm_guest_time_update()
 for TSC upscaling
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728144954.355376-12-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
 <20260728144954.355376-12-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:11:09 +0000
Message-Id: <20260728151110.33DD21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Uninitialized kernel_ns and host_tsc variables are used on 32-=
bit builds if use_master_clock is true.
- [High] The fallback clock path reads rdtsc() after preemption is re-enabl=
ed, causing mismatched TSC frequency calculations and guest clock corruptio=
n.
--

--- Patch [11]: [PATCH v7 11/36] KVM: x86: Restructure kvm_guest_time_updat=
e() for TSC upscaling ---
commit a9ced800a4cffa309e689174fd612acf127799a3
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Restructure kvm_guest_time_update() for TSC upscaling

This commit restructures kvm_guest_time_update to simplify the TSC catchup
adjustment by ensuring kernel_ns and host_tsc are always now during catchup,
then swapping in the master clock reference values afterward.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 27f2f02bd5f40..faeb2d7b19a48 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1776,45 +1776,60 @@ static void kvm_setup_guest_pvclock(struct pvcloc=
k_vcpu_time_info *ref_hv_clock,
>  int kvm_guest_time_update(struct kvm_vcpu *v)
>  {
[ ... ]
> -	kernel_ns =3D 0;
> -	host_tsc =3D 0;
> -
>  	/*
>  	 * If the host uses TSC clock, then passthrough TSC as stable
>  	 * to the guest.
>  	 */
>  	do {
>  		seq =3D read_seqcount_begin(&ka->pvclock_sc);
> +
>  		use_master_clock =3D ka->use_master_clock;
> +
> +		/*
> +		 * The TSC read and the call to get_cpu_tsc_khz() must happen
> +		 * on the same CPU.
> +		 */
> +		get_cpu();
> +
> +		tgt_tsc_hz =3D (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
> +
> +#ifdef CONFIG_X86_64
> +		if (use_master_clock &&
> +		    !kvm_get_time_and_clockread(&kernel_ns, &host_tsc) &&
> +		    !read_seqcount_retry(&ka->pvclock_sc, seq))
> +			use_master_clock =3D false;
> +#endif
> +
> +		put_cpu();
> +
> +		if (use_master_clock) {
> -			host_tsc =3D ka->master_cycle_now;
> -			kernel_ns =3D ka->master_kernel_ns;
> +			master_host_tsc =3D ka->master_cycle_now;
> +			master_kernel_ns =3D ka->master_kernel_ns;
> +		} else {
> +			local_irq_disable();
> +			host_tsc =3D rdtsc();

[Severity: High]
Because put_cpu() re-enables preemption, could the vCPU thread be preempted
and migrated to another physical CPU before local_irq_disable() and rdtsc()
are called in this fallback path?

If migration occurs here, host_tsc might be read on a different CPU than
where tgt_tsc_hz was calculated.

> +			kernel_ns =3D get_kvmclock_base_ns();
> +			local_irq_enable();
>  		}

[ ... ]

> @@ -1824,17 +1839,32 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
>  	 *      entry to avoid unknown leaps of TSC even when running
>  	 *      again on the same CPU.  This may cause apparent elapsed
>  	 *      time to disappear, and the guest to stand still or run
> -	 *	very slowly.
> +	 *      very slowly.
>  	 */
>  	if (vcpu->tsc_catchup) {
> -		u64 tsc =3D compute_guest_tsc(v, kernel_ns);
> -		if (tsc > tsc_timestamp) {
> -			adjust_tsc_offset_guest(v, tsc - tsc_timestamp);
> -			tsc_timestamp =3D tsc;
> -		}
> +		s64 adjustment;
> +
> +		/*
> +		 * Calculate the delta between what the guest TSC *should* be
> +		 * and what it actually is according to kvm_read_l1_tsc().
> +		 */
> +		adjustment =3D compute_guest_tsc(v, kernel_ns) -
> +			     kvm_read_l1_tsc(v, host_tsc);

[Severity: Critical]
On 32-bit builds, will kernel_ns and host_tsc remain uninitialized when
use_master_clock is true?

The original 0-initializations for kernel_ns and host_tsc were removed by
this patch. Their new initialization via kvm_get_time_and_clockread() is
guarded by CONFIG_X86_64.

When vcpu->tsc_catchup is set on 32-bit builds, it seems this would pass
uninitialized stack variables to compute_guest_tsc() and kvm_read_l1_tsc()
for the adjustment calculation.

> +		if (adjustment > 0)
> +			adjust_tsc_offset_guest(v, adjustment);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144954.3553=
76-1-dwmw2@infradead.org?part=3D11
