Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF0D352021
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942422; cv=none; b=adr1UMxghhQplTagq0Ayo0Fs5cuQ8X3608FoH13+beoI5+4P8fBgB9wWZ98IqWMdqNEEXqKA9ugSmCYnjJQQRdTVb4VW6fYp0JrrE09+1ywLjMuGy3I+zzQF3DAlRzGr4hUFGbYGy696Vx48msAf4XXmXws3YZtcyZflEMXHI/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942422; c=relaxed/simple;
	bh=7z5w2c4IF3zLKzZn7LkK75a0IwUPxLl/LKpIP97efWM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h8RrZf6f8dqcFCcvi/pjXG3uUh5ncZ84+gEJGafOglmJcfYQSzB2dilvzF9mTXBo8l+iuhZi8RtDx/bBe4jsF6fRMUsMcDzUDtRUqwqpFUQfLC3SvLTYS3aPNIE+kKqSp6juyj94uGx7C4CN0L30tqNNzYLboFW0GmMRf+snnJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/v6gQFZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/v6gQFZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A508D1F00893;
	Mon,  8 Jun 2026 18:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780942420;
	bh=WS0htAmPzyer+yiXeBCxgx+b5zSr38kf8CgdgMTZiA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G/v6gQFZrkvw2+2N9foWQhpInHCMJddqE7D4J64oULIeFr4n3b456RrzogGtwIK38
	 g78qOxhstPsR1nxXHPTXXfxKHQB23l9B8EzPfNla35R33AbdJUZPQ41rEe4aY4QynW
	 oi2nPmfPrGXXV/UXahua5hwwuSnK+D/kLn2dW4KbXI9f/kkxla68M4Nhbj/6ivOCvd
	 ipzkV9NK3pOUuuBoE6cda75yWNweXsZYwWDFR30uAKf99nT6tYh3MtBvpmBkQ8paJu
	 ad/3BFXe72u/6Dp93qANPOe1n0Aesb30v/u57FcHA0raObM26/S/35g1REEA5VmH2U
	 YXaYPUJ1DXLxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/34] KVM: x86: Restructure kvm_guest_time_update()
 for TSC upscaling
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608145455.89187-16-dwmw2@infradead.org>
References: <20260608145455.89187-16-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 18:13:40 +0000
Message-Id: <20260608181340.A508D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Dropping the `local_irq_save()` protection around the TSC catchup =
calculation exposes an unprotected Read-Modify-Write (RMW) of `l1_tsc_offse=
t`, leading to guest TSC corruption on systems with unstable TSC.
- [Medium] The commit message claims a WARN is added for `kvm_get_time_and_=
clockread()` unexpected failures, but the implementation silently handles i=
t.
--

commit f05935e83e34b920673a8039b5e1b6c7443ffe07
Author: David Woodhouse <dwmw@amazon.co.uk>

Restructure kvm_guest_time_update() so that kernel_ns/host_tsc are
always "now" when doing TSC catchup, then swap in the master clock
reference values afterward for the hv_clock.

This makes the TSC upscaling code considerably simpler: the catchup
adjustment is computed as the delta between what the guest TSC *should*
be at "now" and what it actually is, rather than mixing "now" and
"master clock reference" timestamps.

> The seqcount loop now also contains the kvm_get_time_and_clockread()
> call (matching get_kvmclock's pattern), with the same WARN for
> unexpected failure.

[Severity: Medium]
The commit message mentions that a WARN is added for unexpected failures of
kvm_get_time_and_clockread(), but the implementation inside the
CONFIG_X86_64 block seems to silently handle the failure by clearing
use_master_clock. Was the WARN intentionally omitted from the patch?

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 8aae22401046..92e32d720523 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -3363,46 +3363,63 @@ static void kvm_setup_guest_pvclock(struct pvcloc=
k_vcpu_time_info *ref_hv_clock,
[ ... ]
> -	/* Keep irq disabled to prevent changes to the clock */
> -	local_irq_save(flags);
> -	tgt_tsc_hz =3D (u64)get_cpu_tsc_khz() * 1000;
>  	if (unlikely(tgt_tsc_hz =3D=3D 0)) {
> -		local_irq_restore(flags);
>  		kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
>  		return 1;
>  	}
> +
>  	if (!use_master_clock) {
> +		unsigned long flags;
> +
> +		local_irq_save(flags);
>  		host_tsc =3D rdtsc();
>  		kernel_ns =3D get_kvmclock_base_ns();
> +		local_irq_restore(flags);
>  	}
> =20
> -	tsc_timestamp =3D kvm_read_l1_tsc(v, host_tsc);
> -
>  	/*
>  	 * We may have to catch up the TSC to match elapsed wall clock
>  	 * time for two reasons, even if kvmclock is used.
> @@ -3411,17 +3428,32 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
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
> +		if (adjustment > 0)
> +			adjust_tsc_offset_guest(v, adjustment);

[Severity: High]
Does dropping the local_irq_save() protection around the TSC catchup calcul=
ation
expose an unprotected read-modify-write of l1_tsc_offset?

If preemption occurs inside adjust_tsc_offset_guest() after reading the off=
set:

arch/x86/kvm/x86.c:adjust_tsc_offset_guest() {
    u64 tsc_offset =3D vcpu->arch.l1_tsc_offset;
    /* <--- preemption here */
    kvm_vcpu_write_tsc_offset(vcpu, tsc_offset + adjustment);
}

And the vCPU migrates to a new CPU with an unstable TSC, KVM's preempt
notifiers would call kvm_arch_vcpu_load() and write a new compensation
offset. When this thread resumes, wouldn't it write back the stale base
offset and overwrite the preempt notifier's compensation?

Since the code only corrects positive adjustments, the corrupted offset
would remain, potentially causing the guest TSC to leap forward.

>  	}
> =20
> -	local_irq_restore(flags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145455.8918=
7-1-dwmw2@infradead.org?part=3D15
