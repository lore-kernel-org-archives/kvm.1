Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189235;
	b=PLciV64Jb4SYEm2Lt2sVQ3pSxVlY24RTRD1KFJNerJ34gRCWrF5QjJ6QfRu7RvkN8Thr
	 v3PlWRAwKsIPQmKxWCuTgNCxcPI6Ym1PqIntXGzAeOiy+PHGA1q7BfIlTb+sNDK1m1ULe
	 T5JBJInzGC5+QXO0zyRu0N0EuNAg0v6wLWha2e/PRKm/I4CZQVKLYumaUrbdVWbjcSbc+
	 yRLwI8okuiPgZcUC+tEQhA5JlU577du5DezM7VUPpclLaVtZ34PWQaXIsQX1LrLW3Bdc6
	 P2AiUppgd+2ZPeoM9twG8hu16U2opKmLDg4B2llETCCYoP6zxkLpPK6dyrECrDJS2EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189235;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Xnr0NN4PYkYSfDl9n3edoEQd3XI+4QRbHXDRaQDFNTA=;
	b=LGvjFKHd0xkG8sAAzdti85OMIhl2MRBgtdCJye+vq5rt1W5wg6xPJZwKoc6QlKNOe+dG
	 XoIEtYyFWK8lJOtnOD0q8rjb9OL9v/N2Ba2An68LOYOs8crYpxFHHeL77W2AGNXib1h9T
	 hdFrkPxgzfzp/XC4AQ0hbhRpG9cr8G7WT1ykw5omgE0bdDq7LS9v4hkfgiZiAfhVuRxhJ
	 jPwHsq4FC1dLtDBy9tEIUrZ7vKQkLcSTEk9nxH7wyetSwgPBTds301iy55PYZ7J3+8jAT
	 hliB58N83xAa1OdDsn5Cb2sNvqGgqtE9o8aOQ0xh5w0rU4dlMcyWI8Z0gkwT3Y0EpGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vx+T052G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D4606A323
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 01:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vx+T052G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF881F0089F;
	Mon,  9 Nov 2026 01:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794189234;
	bh=Xnr0NN4PYkYSfDl9n3edoEQd3XI+4QRbHXDRaQDFNTA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Vx+T052G9tykYcdlYkRLC1zMJlBKkHO2gctCY+hnAFlGDD+isHu7v7yJjZ/llxBCG
	 Q6SDabfrYGqiePxG2AppKLNKJug25p+8/6I/ozOx9kQrV4k+d836a6ld24VU2XLheY
	 BlKOVT1xJ16nAifCu3mnM5ZhITXjqgGUY/1lzVkXUJ4oR3t7mtWOFVXFFnRFS9jyOU
	 mCqOeWhgbbqA3T+wFUaCtLtV38tFZ29yZS9e3LOd9/DtitXXrQazkoSmmPuWX/MOG6
	 A7idkj+P0ezKS/HHCp/0JDE7/DZgcRHQy+pb424LK4JcmrOIchAccyuv/o1znhWcWv
	 MLguS0/r9UJgA==
Message-ID: <sashiko-outbox-204332@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 08/24] KVM: x86: Re-synchronize TSC after
 KVM_SET_TSC_KHZ
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261109012112.3415328-9-dwmw2@infradead.org>
References: <20261109012112.3415328-1-dwmw2@infradead.org>
 <20261109012112.3415328-9-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 01:53:54 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] KVM: x86: unreachable 1ms sync window in
  kvm_synchronize_tsc_at()
- [Medium] KVM: x86: unsigned elapsed underflow in
  kvm_synchronize_tsc_at()
- [Medium] KVM: x86: kvm_set_tsc_khz() sync breaks per-vCPU init and
  restore
- [Medium] KVM: x86: TSC sync in kvm_set_tsc_khz() skews across vCPUs by
  (F1 - F2) * dt
--

commit 7a8c0445d433604607064df4c153782c818355a7
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Re-synchronize TSC after KVM_SET_TSC_KHZ

This commit re-synchronizes the vCPU's TSC in kvm_set_tsc_khz() across
KVM_SET_TSC_KHZ frequency changes, preserving the current guest TSC value
when the vCPU has already run or had its TSC written by userspace.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 290a3c3bb44fc..b47c36265c2f2 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -1091,7 +1110,67 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, =
u32 user_tsc_khz)
[ ... ]
> +	if (init || !freq_changed)
> +		return 0;
> +
> +	/*
> +	 * Changing the frequency changes the vCPU's position on the
> +	 * generation's cycle timeline, so re-synchronize. For a vCPU
> +	 * which has run, preserve the guest TSC value read above across
> +	 * the change; likewise if userspace has written a TSC on this
> +	 * vCPU =E2=80=94 a zero write would discard it. Otherwise the vCPU hol=
ds
> +	 * only its creation-time synchronization, so synchronize as for
> +	 * a zero write. When the generation is already at the new
> +	 * frequency this places the vCPU on its timeline rather than
> +	 * opening a gratuitous new generation and orphaning the matched
> +	 * state of its siblings; the first vCPU to adopt a new frequency
> +	 * necessarily opens a new generation, starting at zero =E2=80=94 mixed
> +	 * frequencies within a VM forfeit the master clock anyway.
> +	 */
> +	if (vcpu->arch.last_vmentry_cpu !=3D -1 || vcpu->arch.user_set_tsc)
> +		kvm_synchronize_tsc_at(vcpu, &tsc, host_tsc, ns, false);
> +	else
> +		kvm_synchronize_tsc_at(vcpu, NULL, host_tsc, ns, false);
> +	return 0;
>  }

[Severity: Medium]
Does re-synchronizing in kvm_set_tsc_khz() break frequency and TSC
matching when userspace creates and configures vCPUs one at a time?

When a VMM runs KVM_CREATE_VCPU followed by KVM_SET_TSC_KHZ(F_new) for
vCPU 0, kvm->arch.cur_tsc_khz becomes F_new.  When vCPU 1 is then created,
kvm_arch_vcpu_postcreate() synchronizes it at default_tsc_khz, which sees
virtual_tsc_khz !=3D cur_tsc_khz, bumps cur_tsc_freq_generation and
cur_tsc_generation, resets nr_vcpus_matched_freq and nr_vcpus_matched_tsc,
and sets cur_tsc_khz back to default_tsc_khz.  When KVM_SET_TSC_KHZ(F_new)
then runs on vCPU 1, cur_tsc_khz is no longer F_new, so vCPU 1 opens
another new generation and orphans vCPU 0; the same ping-pong happens when
restoring vCPUs one by one in MSR_IA32_TSC-then-KVM_SET_TSC_KHZ order.
After all vCPUs are configured to F_new, all_vcpus_matched_freq and
all_vcpus_matched_tsc remain false (disabling masterclock and
PVCLOCK_TSC_STABLE_BIT), and repeating KVM_SET_TSC_KHZ on earlier vCPUs
cannot recover because !freq_changed returns early.

[ ... ]

> @@ -1506,6 +1586,7 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64=
 *user_value)
>  			u64 tsc_exp =3D kvm->arch.cur_tsc_write +
>  						nsec_to_cycles(vcpu, elapsed);
>  			u64 tsc_hz =3D vcpu->arch.virtual_tsc_khz * 1000LL;
> +			u64 window;
>  			/*
>  			 * Here lies UAPI baggage: when a user-initiated TSC write has
>  			 * a small delta (1 second) of virtual cycle time against the
> @@ -1520,9 +1601,18 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u6=
4 *user_value)
>  			 * to this 'correction' to make it sync up with values that only
>  			 * come from the kernel's default vCPU creation. Make the 1-second
>  			 * slop hack only trigger if the user_set_tsc flag is already set.
> +			 *
> +			 * A kernel-internal write (a frequency change preserving the
> +			 * guest TSC) carries an exact value sampled with its own
> +			 * reference point, not a racy userspace one; a vCPU on the
> +			 * generation's line still matches it to within arithmetic
> +			 * rounding, but one which genuinely diverged (e.g. by a guest
> +			 * TSC_ADJUST write) must not be snapped back by up to a
> +			 * second. Use a 1ms window for those.
>  			 */
> -			synchronizing =3D data < tsc_exp + tsc_hz &&
> -					data + tsc_hz > tsc_exp;
> +			window =3D user_initiated ? tsc_hz : tsc_hz / 1000;
> +			synchronizing =3D data < tsc_exp + window &&
> +					data + window > tsc_exp;
>  		}
>  	}

[Severity: Medium]
Is the 1ms window for !user_initiated unreachable when userspace has never
written the TSC?

The window check sits inside:

arch/x86/kvm/x86.c:kvm_synchronize_tsc_at() {
	if (vcpu->arch.virtual_tsc_khz) {
		if (data =3D=3D 0) {
			synchronizing =3D true;
		} else if (kvm->arch.user_set_tsc) {
			...
			window =3D user_initiated ? tsc_hz : tsc_hz / 1000;

When KVM_SET_TSC_KHZ is called across vCPUs that have already run
(last_vmentry_cpu !=3D -1) without userspace ever writing MSR_IA32_TSC or
KVM_VCPU_TSC_OFFSET, kvm_set_tsc_khz() passes a non-zero tsc and
user_initiated =3D false.  Because __kvm_synchronize_tsc() only sets
kvm->arch.user_set_tsc when user_initiated is true, kvm->arch.user_set_tsc
stays false and every subsequent vCPU skips the else-if branch, fails to
match the generation, and clears all_vcpus_matched_tsc.  Should the
condition be "else if (kvm->arch.user_set_tsc || !user_initiated)"?

[Severity: Medium]
Even when that branch is reached, doesn't comparing data against tsc_exp
within a 1ms window fail whenever the delay dt between vCPU 0's and a
sibling vCPU's KVM_SET_TSC_KHZ ioctls exceeds 1ms * F2 / |F1 - F2|?

When changing multiple vCPUs from frequency F1 to F2 while preserving
their TSCs, vCPU 0 anchors cur_tsc_nsec and cur_tsc_write at t0.  Over the
elapsed time dt before a sibling vCPU's KVM_SET_TSC_KHZ ioctl runs, that
sibling is still scaled at F1, so its sampled data =3D kvm_read_l1_tsc()
has advanced by F1 * dt cycles.  However, kvm_set_tsc_khz() updates
virtual_tsc_mult and virtual_tsc_shift to F2 before calling
kvm_synchronize_tsc_at(), so nsec_to_cycles(vcpu, elapsed) advances
tsc_exp by F2 * dt cycles.  The difference |data - tsc_exp| is therefore
|F1 - F2| * dt rather than arithmetic rounding, which exceeds the 1ms
window (tsc_hz / 1000) once dt >=3D 1ms * F2 / |F1 - F2| (for example 1ms
when halving the frequency), causing sibling vCPUs to miss the generation
and lose all_vcpus_matched_tsc.

> @@ -1552,10 +1642,26 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u=
64 *user_value)
>  		matched =3D true;
>  	}
> =20
> -	__kvm_synchronize_tsc(vcpu, offset, data, ns, matched, !!user_value);
> +	__kvm_synchronize_tsc(vcpu, offset, data, ns, matched, user_initiated);
>  	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
>  }
> =20
> +void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *value, bool user_in=
itiated)
> +{
> +	u64 host_tsc;
> +	s64 ns;
> +
> +#ifdef CONFIG_X86_64
> +	if (!kvm_get_time_and_clockread(&ns, &host_tsc))
> +#endif
> +	{
> +		host_tsc =3D rdtsc();
> +		ns =3D get_kvmclock_base_ns();
> +	}
> +
> +	kvm_synchronize_tsc_at(vcpu, value, host_tsc, ns, user_initiated);
> +}

[Severity: Medium]
Can sampling {ns, host_tsc} outside kvm->arch.tsc_write_lock in
kvm_set_tsc_khz() and kvm_synchronize_tsc() underflow elapsed in
kvm_synchronize_tsc_at()?

CPU0                              CPU1
kvm_set_tsc_khz(vcpu0)
  sample ns =3D 100
  <preempted>
                                  kvm_set_tsc_khz(vcpu1)
                                    sample ns =3D 200
                                    kvm_synchronize_tsc_at()
                                      lock(&kvm->arch.tsc_write_lock)
                                      kvm->arch.cur_tsc_nsec =3D 200
                                      unlock(&kvm->arch.tsc_write_lock)
  kvm_synchronize_tsc_at()
    lock(&kvm->arch.tsc_write_lock)
    elapsed =3D ns - cur_tsc_nsec   <-- wraps u64
    nsec_to_cycles(vcpu, elapsed)

In kvm_synchronize_tsc_at(), elapsed is a u64:

arch/x86/kvm/x86.c:kvm_synchronize_tsc_at() {
	offset =3D kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
	elapsed =3D ns - kvm->arch.cur_tsc_nsec;

When CPU0 acquires tsc_write_lock after CPU1 has already recorded a newer
cur_tsc_nsec, elapsed wraps around near U64_MAX and is passed to unsigned
nsec_to_cycles() (pvclock_scale_delta()).  For non-zero writes this
corrupts tsc_exp so CPU0 fails to match and overwrites cur_tsc_nsec with
the older timestamp; for zero-value syncs (synchronizing =3D=3D true) it
corrupts delta, data, vcpu->arch.last_guest_tsc, and (when
kvm_check_tsc_unstable() is true) offset.  In addition, the fallback
rdtsc() + get_kvmclock_base_ns() path now runs with preemption and
interrupts enabled, so preemption between the two reads can skew the
{host_tsc, ns} pair.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109012112.3415=
328-1-dwmw2@infradead.org?part=3D8
