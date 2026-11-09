Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189418;
	b=XmVzJinaE12hC3rPJYLOtkEsnMzh796VGSgBlOy4Y021pKPe/sZSJRgxF1XC/S04Hpji
	 gURjuOuAKH/aA5T1QJBiRZKYRDzD2T78RiQ3GfqBn1L/yGj9NPP70stA+8cEfda9rK84y
	 qbnk+hzee3NX0zNDO1QDA1nna3yWmEsOOC3bCib60lTysDdZ/QkF1Yyi9z487d+EVkOGA
	 5/YNdSSQ++gb9wadN+3PtNWnYdJZlv5QybkJJ4ZsBy77kTseaRSzo2NwSiJtUjAO8yIio
	 iQ/Yj44D/tw7rihEbypA+bgvjLptJaRFYHDzJQQfzVUxdYpUjDgwFB+kHs7xRnQFivg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189418;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HIXxxckU8X7ioBFfK2a7B6Yf5TAwcsSz+VVZm9Bydsg=;
	b=o4C7GLTk0ocMRAcUk6SS+ORkx4F0gsPh5qrCW4bk3QMsdAbYO74kFVAhqwHyeledqgmI
	 /4gZj9btoTTnkF3umTU9sISzZ3HymhJb1rpWSkrTJLTcmsjGC70MJS0d+iyI9Tokiyu8B
	 KDn9D7FVXkfnjueg5+xLJPhU1Y16sB3oXQ9SXZOt7cuQEUfoZapUXRxV4dTCjNs/+TipN
	 TZFjnDSfPfjnI6q32dDxOVRsMzizZy3BWZyCg6tMMRr821oe70THAR87162krwM6WZCr7
	 16V2AnXsHO9umf969asXKUW6T14duv0HEpE5jcSIbEfxND7gaVh9k8kie45pfPVifrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgeThdc3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7468606A320
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgeThdc3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303071F0089F;
	Mon,  9 Nov 2026 01:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794189417;
	bh=HIXxxckU8X7ioBFfK2a7B6Yf5TAwcsSz+VVZm9Bydsg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dgeThdc3RppR/+rqZkJxOmIerd+Xw8bSAA6M62w56ew1vtI0NraeH6dy2UGGd+doI
	 gpaP4UA4jOU5uzu/vkCTTpAzLKFpAVGU5mrAOCqShrKhZtDnNgykWoUP0x9HMpOOAI
	 C2ibMhk0NISKt+ux84f/S6r5JyKWGgJ3+KqnVqc8OVR5E8lxcULe4kJxkN+O+AAwva
	 IOzoD/jTSVLpg3+6fdR9lUJ7NqAdBcw/hKnHy3bjW0Hg63oTUtzk0RS7vqNbhU2jh5
	 hf436KHV9FhojbTZJkTRLZPH6iH0p0nxoNyMG/+k3V1QZvF8FU9zTHNGaYGmrQ6EBm
	 XAxEjD2RZYQgw==
Message-ID: <sashiko-outbox-204336@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 11/24] KVM: x86: Activate master clock from
 kvm_arch_init_vm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261109012112.3415328-12-dwmw2@infradead.org>
References: <20261109012112.3415328-1-dwmw2@infradead.org>
 <20261109012112.3415328-12-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 01:56:56 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] KVM: x86: host-guest clock divergence in
  __get_kvmclock_master_clock()
- [Low] KVM: x86: dead initial TSC generation stores in
  kvm_arch_init_vm()
--

commit 862c03c2a3fcfa08f8c8dedc05fb896a0f4d58c9
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Activate master clock from kvm_arch_init_vm()

This commit initializes the master clock snapshot in kvm_arch_init_vm(),
adds a sanity check against raw clock divergence in
__get_kvmclock_master_clock(), and refreshes the master clock when the
first vCPU is created.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a357efbf1d941..4afafe7ed8b8a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -1927,13 +1932,34 @@ static bool __get_kvmclock_master_clock(struct kv=
m *kvm,
>  		u64 tsc_delta =3D data->host_tsc - ka->master_cycle_now;
> =20
>  		tsc_delta =3D kvm_scale_tsc(tsc_delta, ka->master_tsc_scaling_ratio);
> -		data->clock =3D hv_clock.system_time +
> -			      pvclock_scale_delta(tsc_delta,
> -						  hv_clock.tsc_to_system_mul,
> -						  hv_clock.tsc_shift);
> +		clock =3D hv_clock.system_time +
> +			pvclock_scale_delta(tsc_delta,
> +					    hv_clock.tsc_to_system_mul,
> +					    hv_clock.tsc_shift);
>  	} else {
> -		data->clock =3D __pvclock_read_cycles(&hv_clock, data->host_tsc);
> +		clock =3D __pvclock_read_cycles(&hv_clock, data->host_tsc);
>  	}
> +
> +	/*
> +	 * Sanity-check the snapshot: if the elapsed time it computes from
> +	 * the host TSC disagrees with the raw clock by more than a second,
> +	 * the TSC was reset (suspend/resume =E2=80=94 possibly re-inited by
> +	 * firmware to an arbitrary value, including an underflowing one
> +	 * below master_cycle_now) while nothing refreshed the snapshot.
> +	 * That can happen while the VM has no vCPUs, since both the
> +	 * resume compensation and the clocksource notifier work through
> +	 * vCPUs. Use the fallback clock rather than returning a
> +	 * discontinuity flagged KVM_CLOCK_TSC_STABLE.
> +	 */
> +	if (unlikely(abs((s64)(clock - hv_clock.system_time) -
> +			 (get_kvmclock_base_ns() - ka->master_kernel_ns)) >
> +		     NSEC_PER_SEC))
> +		return false;

[Severity: Medium]
Can this sanity check trigger while vCPUs are active and cause a 1-second
divergence between host-side get_kvmclock() and guest pvclock?

Although the comment describes the no-vCPU window, this check runs even
when vCPUs exist and ka->use_master_clock remains true.  While the master
clock is active, ka->master_cycle_now and ka->master_kernel_ns are not
re-anchored.  Because tk_core.timekeeper.tkr_raw uses a 22- or 23-bit
multiplier from clocks_calc_mult_shift() whereas ka->master_tsc_mul uses a
32-bit multiplier from kvm_get_time_scale() (plus intermediate rounding in
kvm_scale_tsc() when TSC scaling is active), the two elapsed times drift
apart over long uninterrupted uptime until their difference exceeds
NSEC_PER_SEC.

Once that threshold is crossed, __get_kvmclock_master_clock() returns
false, causing get_kvmclock() (and KVM_GET_CLOCK) to jump by at least a
second to get_kvmclock_base_ns() + ka->kvmclock_offset and drop
KVM_CLOCK_TSC_STABLE, KVM_CLOCK_REALTIME, and KVM_CLOCK_HOST_TSC, while
leaving data->host_tsc modified from the earlier
kvm_get_walltime_and_clockread() call.  Meanwhile, kvm_guest_time_update()
continues populating the guest's pvclock from the master clock snapshot
with PVCLOCK_TSC_STABLE_BIT set.

Should this check be gated on having no online/created vCPUs, or should
ka->master_cycle_now and ka->master_kernel_ns be refreshed when the first
vCPU is created so no fallback check is needed in
__get_kvmclock_master_clock()?

[ ... ]

> @@ -10271,14 +10314,46 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned =
long type)
>  	kvm->arch.cur_tsc_scaling_ratio =3D kvm_caps.default_tsc_scaling_ratio;
> =20
>  	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
> +
> +	/*
> +	 * Establish an initial TSC generation so that the master clock
> +	 * snapshot taken below is immediately valid and KVM_GET_CLOCK
> +	 * works before any vCPU exists. The snapshot is refreshed again
> +	 * when the first vCPU is created, in case the host clocksource
> +	 * changed (and changed back) in between: pvclock_gtod_update_fn()
> +	 * does not notify a VM with no vCPUs.
> +	 *
> +	 * This generation is deliberately not matchable: cur_tsc_khz is
> +	 * left at zero, which no vCPU frequency ever equals, so the first
> +	 * vCPU opens its own generation with its TSC starting at zero,
> +	 * exactly as it always has. Letting it match would make the first
> +	 * vCPU's TSC start at the cycles elapsed since KVM_CREATE_VM =E2=80=94=
 a
> +	 * silent guest-visible change over an unbounded window =E2=80=94 and
> +	 * would hand it this offset verbatim even when a host suspend
> +	 * reset the TSC in between, since the backwards-TSC compensation
> +	 * in kvm_arch_enable_virtualization_cpu() detects the jump only
> +	 * through existing vCPUs.
> +	 */
> +#ifdef CONFIG_X86_64
> +	if (!kvm_get_time_and_clockread(&kvmclock_ns, &kvmclock_host_tsc))
> +#endif
> +	{
> +		/*
> +		 * If not simultaneous, we want the TSC to be zero slightly
> +		 * *after* the kvmclock is zero.
> +		 */
> +		kvmclock_ns =3D get_kvmclock_base_ns();
> +		kvmclock_host_tsc =3D rdtsc();
> +	}
> +	kvm->arch.cur_tsc_write =3D 0;
> +	kvm->arch.cur_tsc_offset =3D -(s64)kvmclock_host_tsc;
> +	kvm->arch.cur_tsc_nsec =3D kvmclock_ns;
> +	kvm->arch.cur_tsc_generation =3D 1;
> +	kvm->arch.kvmclock_offset =3D -kvmclock_ns;
> +
>  	pvclock_update_vm_gtod_copy(kvm);
>  	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);

[Severity: Low]
Are the stores to cur_tsc_write, cur_tsc_offset, cur_tsc_nsec, and
cur_tsc_generation (along with the kvmclock_host_tsc read) dead code?

pvclock_update_vm_gtod_copy() takes its own snapshot into master_kernel_ns
and master_cycle_now and does not read any of the cur_tsc_* fields.
Because cur_tsc_khz is left at 0 and user_set_tsc is false, no caller can
match or consume this initial generation before the first vCPU's
__kvm_synchronize_tsc() call runs with matched =3D=3D false and overwrites
cur_tsc_generation, cur_tsc_nsec, cur_tsc_write, and cur_tsc_offset.

Also, the commit message states that this patch makes
pvclock_update_vm_gtod_copy() succeed in kvm_arch_init_vm(), but earlier
commits in the series (commit "KVM: x86: Replace nr_vcpus_matched_tsc
count with all_vcpus_matched_tsc bool" and commit "KVM: x86: Allow KVM
master clock mode when TSCs are offset from each other") already
initialized all_vcpus_matched_tsc, cur_tsc_scaling_ratio, and
all_vcpus_matched_freq in kvm_arch_init_vm().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109012112.3415=
328-1-dwmw2@infradead.org?part=3D11
