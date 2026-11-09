Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189240;
	b=KAtvmNsjmJ9WEFS6f8Gm3W9aK3JeEvNAzaSnXZZJLCjNgRoxJeAUq00k0VKqsN7byfEA
	 k4rzrleZdzmA3+/l+WprtagRHvcGJyGivRzOqbkaUp+fYgWPm6YYXyF8YUwXCJyr2XC8W
	 jyzA8nE8tdVuUxIlj+scNVBMSElCqyWkeWX6UBmFmOksuoyAtZXA/IaNhJEu1l7ZeMVVn
	 Pgqp8pWqxbeFRcL+n7NStRUoIR4vVD9ujcOX/Y+cbPfn6WwuEr1G0ttSz80NCH88Oxxb5
	 csUQXYJQk60Xn4j98moJhBoaUAjqUKE/xOJwpYDe7KzV3bQQ/AP2j6jzW/hr8S9e5oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189240;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ySl1AnKA+JF6gSxVbDhkhZJT4cQ1VJZfOZ3MEEMia94=;
	b=t4Mk8p0OEHqK26zRVTKVmvhmzDw3OEoTaTU8nucXtIkY9C057khyjkdetiQux+FUVXFr
	 rjnRVjP7ahx9Rhs9ihu9u+pQ/66kS+S+n2zi4R6nXDTfnbHWv3azzQ324kWuJ2EVM094d
	 ux21klJPPjK3zbL1yb1GD7sn7UJe++PDjanfHTV0+m8VFZDYAixSuM+oWoMO6ysn5DF0j
	 2DB90/+6aNWGUarw9zsOZzi/hqPvSPBWSD6rhvtZGjdO7mvdOwYDZhR5iLLIo9Z5lMO9c
	 oqqgASNWQ43MAgkEDy4uIHQcWr+r1umRiclymDWZ/CE0Nl0lbaoD7Kj0uO96tFFJReA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2onIWyI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA4F606A331
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 01:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2onIWyI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF481F008A4;
	Mon,  9 Nov 2026 01:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794189240;
	bh=ySl1AnKA+JF6gSxVbDhkhZJT4cQ1VJZfOZ3MEEMia94=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=c2onIWyI3GVWRD6Ek1lE1cmyyckbXDVArSnpYVk6Xayc4Jhqi6uclwMuvDExliu3j
	 fHsU5zmRNiwEjiREF3zab1pgHNIWKPPkj/6DLHKWBsT9QPJdHwqSajFhKW1VdAtAr+
	 g8vfnRLCtW0F8OgWffvGX5PSc3X3+7h/hiw0NQrMU2Y1NyoZDTM+xd+Sozb+xEpELB
	 qLf5FmimpND/CRMefrVI43oJQNStrN1c2tUGq//EPPiICso/3GO8+TMbr9dDA9who4
	 uOzGoJJTT/kaFZJY+KR3Es48QJCPDq+YVcB7YBiSWZcWsslTr9Hg4Ru5oylp67h/kh
	 v1F9Op+Q0DOWg==
Message-ID: <sashiko-outbox-204333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 14/24] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for
 accurate KVM clock migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261109012112.3415328-15-dwmw2@infradead.org>
References: <20261109012112.3415328-1-dwmw2@infradead.org>
 <20261109012112.3415328-15-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 01:53:59 +0000
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
- [High] KVM: x86: stale masterclock state read in
  kvm_vcpu_ioctl_get_clock_guest()
- [Medium] KVM: x86: mismatched TSC scaling in KVM_[GS]ET_CLOCK_GUEST
  for protected TSC
--

commit c242a430a092692493307282dff57c9d0a945477
Author: Jack Allister <jalliste@amazon.com>

KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate KVM clock migration

This commit adds the KVM_GET_CLOCK_GUEST and KVM_SET_CLOCK_GUEST vCPU ioctls
and KVM_CAP_CLOCK_GUEST capability to save and restore the guest pvclock
relationship to the guest TSC across migration.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 4afafe7ed8b8a..00e6b2bdaffb5 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -3674,6 +3677,197 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_v=
cpu *vcpu,
>  	}
>  }
> =20
> +#ifdef CONFIG_X86_64
> +static int kvm_vcpu_ioctl_get_clock_guest(struct kvm_vcpu *v, void __use=
r *argp)
> +{
> +	struct pvclock_vcpu_time_info hv_clock =3D {};
> +	struct kvm_arch *ka =3D &v->kvm->arch;
> +	bool use_master_clock;
> +	unsigned int seq;
> +
> +	/*
> +	 * Construct the pvclock purely from the master clock state. The
> +	 * master mul/shift are computed for the guest TSC frequency, which
> +	 * in master clock mode is the frequency of every vCPU; only the
> +	 * tsc_timestamp is per-vCPU, translating the master snapshot into
> +	 * this vCPU's TSC domain via its scaling ratio and offset.
> +	 *
> +	 * Note, this deliberately does NOT invoke kvm_guest_time_update(),
> +	 * which would write the guest's pvclock pages: dirtying guest
> +	 * memory after the final KVM_RUN would break post-copy migration
> +	 * flows. The pvclock returned here describes the same clock as the
> +	 * guest-visible copy (the same linear function of the guest TSC),
> +	 * anchored at the current master clock snapshot.
> +	 *
> +	 * Translating the snapshot through the vCPU's *current* scaling
> +	 * ratio and offset is correct even if they changed after the
> +	 * snapshot was taken: the snapshot anchors a host TSC value, not
> +	 * a guest one. A frequency change whose masterclock update is
> +	 * still pending does leave stale mul/shift here, but that is the
> +	 * paused-VM migration path reading a frequency userspace itself
> +	 * has just changed =E2=80=94 and the result fails safe, as the same-vC=
PU
> +	 * KVM_SET_CLOCK_GUEST on the destination rejects a mul/shift
> +	 * inconsistent with the vCPU's frequency with -ERANGE.
> +	 */
> +	do {
> +		seq =3D read_seqcount_begin(&ka->pvclock_sc);
> +
> +		use_master_clock =3D ka->use_master_clock;
> +		if (!use_master_clock)
> +			continue;
> +
> +		hv_clock.tsc_timestamp =3D kvm_read_l1_tsc(v, ka->master_cycle_now);
> +		hv_clock.system_time =3D ka->master_kernel_ns + ka->kvmclock_offset;
> +		hv_clock.tsc_shift =3D ka->master_tsc_shift;
> +		hv_clock.tsc_to_system_mul =3D ka->master_tsc_mul;
> +		hv_clock.flags =3D READ_ONCE(ka->all_vcpus_matched_tsc) ?
> +				 PVCLOCK_TSC_STABLE_BIT : 0;
> +	} while (read_seqcount_retry(&ka->pvclock_sc, seq));

[Severity: High]
Can kvm_vcpu_ioctl_get_clock_guest() return stale or corrupted pvclock data
when a KVM_REQ_MASTERCLOCK_UPDATE is pending?

Events that invalidate or change the master clock (such as a host suspend
and resume with a backwards TSC, a host clocksource change away from TSC, or
a per-vCPU KVM_SET_TSC_KHZ) only queue KVM_REQ_MASTERCLOCK_UPDATE on vCPUs
without updating ka->use_master_clock, ka->master_cycle_now, or
ka->master_tsc_mul and ka->master_tsc_shift until vcpu_enter_guest() runs.

If the host suspends and resumes while the VM is paused,
kvm_arch_enable_virtualization_cpu() sets ka->backwards_tsc_observed, adds
vcpu->arch.tsc_offset_adjustment, and requests KVM_REQ_MASTERCLOCK_UPDATE.
When userspace then calls KVM_GET_CLOCK_GUEST, vcpu_load() ->
kvm_arch_vcpu_load() applies tsc_offset_adjustment to v->arch.l1_tsc_offset
before kvm_vcpu_ioctl_get_clock_guest() runs:

arch/x86/kvm/x86.c:kvm_arch_vcpu_load() {
	...
	if (unlikely(vcpu->arch.tsc_offset_adjustment)) {
		adjust_tsc_offset_host(vcpu, vcpu->arch.tsc_offset_adjustment);
		vcpu->arch.tsc_offset_adjustment =3D 0;
		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
	}
	...
}

kvm_vcpu_ioctl_get_clock_guest() still sees ka->use_master_clock =3D=3D tru=
e,
combines the post-resume l1_tsc_offset with the pre-suspend
ka->master_cycle_now, and succeeds instead of returning -ENODATA.  Because
ka->master_tsc_mul and ka->master_tsc_shift still match the vCPU's TSC
frequency, KVM_SET_CLOCK_GUEST does not reject the state with -ERANGE and
instead corrupts ka->kvmclock_offset.  Similarly, if KVM_SET_TSC_KHZ changes
one vCPU's frequency in a multi-vCPU VM, ka->all_vcpus_matched_freq becomes
false, but calling KVM_GET_CLOCK_GUEST on an unmodified vCPU sees stale
ka->use_master_clock =3D=3D true with a mul/shift that still matches that v=
CPU.

Calling kvm_update_masterclock() when needed would refresh the host-side
master clock state in struct kvm_arch without calling
kvm_guest_time_update() or dirtying guest pvclock pages.

[ ... ]

> +	/*
> +	 * Nonzero, or pvclock_update_vm_gtod_copy() =E2=80=94 which read it on
> +	 * this CPU, with interrupts still disabled =E2=80=94 would have cleared
> +	 * use_master_clock above.
> +	 */
> +	curr_tsc_hz =3D (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
> +
> +	if (kvm_caps.has_tsc_control)
> +		curr_tsc_hz =3D kvm_scale_tsc(curr_tsc_hz,
> +					    v->arch.l1_tsc_scaling_ratio);
> +
> +	/*
> +	 * The mul/shift in the provided pvclock structure encode the guest
> +	 * TSC frequency at which it was generated. Sanity-check that it is
> +	 * consistent with this vCPU's effective TSC frequency, allowing a
> +	 * discrepancy of 1 kHz either way since independently calibrated
> +	 * hosts will not measure precisely the same value even for the
> +	 * same nominal frequency. Compare in kHz: the reconstruction of
> +	 * each side's frequency in Hz carries a few Hz of rounding, which
> +	 * must not push two hosts calibrated exactly 1 kHz apart over the
> +	 * line.
> +	 */
> +	user_tsc_khz =3D DIV_ROUND_CLOSEST_ULL(user_tsc_hz, HZ_PER_KHZ);
> +	curr_tsc_khz =3D DIV_ROUND_CLOSEST_ULL(curr_tsc_hz, HZ_PER_KHZ);
> +	if (user_tsc_khz + 1 < curr_tsc_khz ||
> +	    user_tsc_khz > curr_tsc_khz + 1) {
> +		rc =3D -ERANGE;
> +		goto out;
> +	}

[Severity: Medium]
Does KVM_GET_CLOCK_GUEST return an unscaled mul/shift that
KVM_SET_CLOCK_GUEST rejects with -ERANGE when a protected-TSC guest uses a
non-default TSC frequency?

For guests with vcpu->arch.guest_tsc_protected set (such as TDX or SEV-SNP
with Secure TSC), userspace configures the guest TSC frequency via the VM
KVM_SET_TSC_KHZ ioctl before creating vCPUs, which sets
kvm->arch.default_tsc_khz without updating kvm->arch.cur_tsc_scaling_ratio.
During KVM_CREATE_VCPU, kvm_arch_vcpu_create() sets
vcpu->arch.l1_tsc_scaling_ratio from default_tsc_khz, but
kvm_arch_vcpu_postcreate() -> kvm_synchronize_tsc() ->
__kvm_synchronize_tsc() returns early before updating
kvm->arch.cur_tsc_scaling_ratio:

arch/x86/kvm/x86.c:__kvm_synchronize_tsc() {
	...
	if (vcpu->arch.guest_tsc_protected)
		return;
	...
	kvm->arch.cur_tsc_scaling_ratio =3D vcpu->arch.l1_tsc_scaling_ratio;
	...
}

pvclock_update_vm_gtod_copy() then computes ka->master_tsc_shift and
ka->master_tsc_mul from ka->cur_tsc_scaling_ratio, which is still
kvm_caps.default_tsc_scaling_ratio.  As a result,
kvm_vcpu_ioctl_get_clock_guest() scales hv_clock.tsc_timestamp with
v->arch.l1_tsc_scaling_ratio via kvm_read_l1_tsc(), but copies the unscaled
ka->master_tsc_shift and ka->master_tsc_mul, and
kvm_vcpu_ioctl_set_clock_guest() rejects that structure with -ERANGE when
comparing against curr_tsc_hz scaled by v->arch.l1_tsc_scaling_ratio.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109012112.3415=
328-1-dwmw2@infradead.org?part=3D14
