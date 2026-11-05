Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908296;
	b=Np8LfZ1To+qW8hNwZLvLk87Rolw0f82gq8lomQvv9puSJ680371RpINGsKMq9A6iNxvW
	 h3c6VCdpgB3bd+3BDr+RFYLtBZOn0lftp0x7gBbucXaG6+eSewCXuB0HtP0JI1OmrbsBe
	 jpkr3GiVAiZa/droF3hWxbV9QqUeEbwlgN7xH9WKE29WVJeCl0VNu4NsimaY5EnFq6Aa+
	 Axz2L5jubRe+RyV4tipFe2Os89hfitO744YlqWbjmPDLltCY9LLr1vJzi/k8Nrr6ik0Rg
	 sxM3T6DK/x21mRcqjBFKVal6k7pVMd0vDQBNwmVipFcFBlU8mFlF3s59tD7ge0cGIDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908296;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DCoQNGZJH+g7ZYuZDzfy+0y6UL2XBDSJsPDzUp8mlVo=;
	b=te+6VWgTPdaMpkMTiAJAFjrx3n2/cvUXxaKXcdoNT3cs9+nMlIwD5tttTVXWGVuV8MU9
	 5iXiPBmru00Ly4P08XBQkuToSebFYdq7j4Anhyf62k++yYMCRJpxR+7SJSkKOjlgh+01B
	 VDtq0S6gIKINQvP8xhWkRvKb5XvViVLHmzMEUgyxKZSuG26smQkh0hws1A7yDzCAGh0aM
	 NhVOiraUsVnnNFrxataZGgdEJ890Ym/vPy8GWU1kN+WTFRykuz/HUyoVnEVB2kK04vZ7d
	 +tK9uMDDcOSoFr+llWh/xHYmIygDJKRyBAFNElPRPbYxvjgJZtuZXAYoH5ZvLgGe0lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m0xRP6TN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6D3606A33E
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m0xRP6TN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0001F008A6;
	Thu,  5 Nov 2026 19:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908296;
	bh=DCoQNGZJH+g7ZYuZDzfy+0y6UL2XBDSJsPDzUp8mlVo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=m0xRP6TNxUPVNhVXD9CQdN1RmUoilqqjXqcOAQRKhy2N1HwAenQWAHyfK2pus6Yu0
	 cFTG53Ljk4Kvp8CYBwZ5zcST8dMTBydccAth/ujftyMkHl+2HORIWV6PmLt6V6K/GJ
	 C/qQDHJo1+ruFGxgPMFavKUUvpXrAPFcPW83jjQNLlgsU7zJEfFmSRbvOxSU1uH1Em
	 ZKRxPizd9WxV9YPj0DdkF2cJffdjYpP+sbhGddZWKOFYgCVCpbGD1DflbNd+Vw9Fkw
	 g89GbmLj0y/3BMUI0CsMOac709RefqieL0NIu1q2c6P0g3M9cWQjqCEkjyv6qGA4pt
	 DaUH07yDGatww==
Message-ID: <sashiko-outbox-200022@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 14/23] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for
 accurate KVM clock migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261105154955.2525419-15-dwmw2@infradead.org>
References: <20261105154955.2525419-1-dwmw2@infradead.org>
 <20261105154955.2525419-15-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:51:35 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] KVM: x86: stale masterclock state in kvm_vcpu_ioctl_get_clock_gues=
t()
- [High] KVM: x86: u64 underflow and overflow in kvm_vcpu_ioctl_set_clock_g=
uest()
- [High] KVM: x86: unsigned TSC wraparound check in kvm_vcpu_ioctl_set_cloc=
k_guest()
- [High] KVM: x86: premature all_vcpus_matched_freq in kvm_track_tsc_matchi=
ng()
- [Medium] KVM: x86: unreachable -EBUSY path in kvm_vcpu_ioctl_set_clock_gu=
est()
- [Medium] KVM: x86: early return inside pvclock_sc seqcount read section i=
n kvm_vcpu_ioctl_get_clock_guest()
--

commit a2ceb951545e5e2e7837aa6b7c533b2b547ba201
Author: Jack Allister <jalliste@amazon.com>

KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate KVM clock migration

This commit adds the per-vCPU KVM_GET_CLOCK_GUEST and KVM_SET_CLOCK_GUEST
ioctls (advertised via KVM_CAP_CLOCK_GUEST) to save and restore the
pvclock_vcpu_time_info structure in terms of the guest vCPU TSC when the VM
is using the master clock.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6dbdb60962fe7..bdc838b12fdc0 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -3541,6 +3544,168 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_v=
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
> +	 */
> +	do {
> +		seq =3D read_seqcount_begin(&ka->pvclock_sc);
> +
> +		if (!ka->use_master_clock)
> +			return -ENODATA;

[Severity: Medium]
Is it safe to return directly from inside the read_seqcount_begin() loop
when !ka->use_master_clock without calling read_seqcount_retry()?

Returning early here skips the pairing smp_rmb() and sequence validation on
ka->use_master_clock (which pvclock_update_vm_gtod_copy() updates inside
write_seqcount_begin/end and may transiently set to true before clearing it
if tsc_hz is 0), and leaves KCSAN's seqlock atomic region state active on
current because do___read_seqcount_retry() -> kcsan_atomic_next(0) is never
reached.

For comparison, kvm_guest_time_update() in arch/x86/kvm/x86.c completes the
seqcount loop before checking use_master_clock:

	do {
		seq =3D read_seqcount_begin(&ka->pvclock_sc);
		use_master_clock =3D ka->use_master_clock;
		if (!use_master_clock)
			continue;
		...
	} while (read_seqcount_retry(&ka->pvclock_sc, seq));

> +
> +		hv_clock.tsc_timestamp =3D kvm_read_l1_tsc(v, ka->master_cycle_now);
> +		hv_clock.system_time =3D ka->master_kernel_ns + ka->kvmclock_offset;
> +		hv_clock.tsc_shift =3D ka->master_tsc_shift;
> +		hv_clock.tsc_to_system_mul =3D ka->master_tsc_mul;
> +		hv_clock.flags =3D READ_ONCE(ka->all_vcpus_matched_tsc) ?
> +				 PVCLOCK_TSC_STABLE_BIT : 0;
> +	} while (read_seqcount_retry(&ka->pvclock_sc, seq));

[Severity: High]
Can kvm_vcpu_ioctl_get_clock_guest() return a corrupt pvclock_vcpu_time_info
structure when KVM_REQ_MASTERCLOCK_UPDATE is pending?

Operations that change vCPU TSC frequency, TSC offset, or masterclock
eligibility =E2=80=94 such as KVM_SET_TSC_KHZ via kvm_set_tsc_khz() ->
kvm_synchronize_tsc() -> __kvm_synchronize_tsc() -> kvm_track_tsc_matching(=
),
host-initiated MSR_IA32_TSC writes, KVM_VCPU_TSC_OFFSET via
kvm_arch_tsc_set_attr(), host clocksource updates via
pvclock_gtod_update_fn(), or backwards TSC detection =E2=80=94 immediately =
update
v->arch.l1_tsc_scaling_ratio, v->arch.l1_tsc_offset,
ka->cur_tsc_scaling_ratio, and ka->all_vcpus_matched_freq, but defer
refreshing ka->use_master_clock, ka->master_tsc_shift, ka->master_tsc_mul,
ka->master_cycle_now, and ka->master_kernel_ns by queuing
KVM_REQ_MASTERCLOCK_UPDATE:

arch/x86/kvm/x86.c:kvm_track_tsc_matching() {
	...
	if ((ka->use_master_clock && update_mclock) ||
	    (ka->use_master_clock !=3D use_master_clock))
		kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
}

Because KVM_REQ_MASTERCLOCK_UPDATE is only serviced in vcpu_enter_guest()
during KVM_RUN (and kvm_track_tsc_matching() only queues it on the single
vCPU being updated rather than VM-wide), invoking KVM_GET_CLOCK_GUEST while
vCPUs are stopped in userspace reads stale ka->use_master_clock,
ka->master_tsc_shift, and ka->master_tsc_mul while combining them with the
updated v->arch.l1_tsc_scaling_ratio and v->arch.l1_tsc_offset in
kvm_read_l1_tsc(v, ka->master_cycle_now). This either mixes a newly scaled
tsc_timestamp with old master_tsc_mul/shift (causing KVM_SET_CLOCK_GUEST to
fail with -ERANGE) or returns 0 with stale clock data instead of -ENODATA
after masterclock eligibility was lost.

[Severity: High]
Also on this read path in kvm_vcpu_ioctl_get_clock_guest(), can
ka->use_master_clock remain true even when vCPUs have mismatched TSC
frequencies?

If userspace creates vCPU 0 (online_vcpus =3D=3D 1) and sets its TSC freque=
ncy
via KVM_SET_TSC_KHZ to F1 !=3D ka->default_tsc_khz, ka->cur_tsc_khz is F1 a=
nd
ka->all_vcpus_matched_freq is true.

When vCPU 1 is subsequently created in kvm_vm_ioctl_create_vcpu(),
kvm_arch_vcpu_create() runs before atomic_inc(&kvm->online_vcpus) (while
online_vcpus is still 1) and calls kvm_set_tsc_khz(vcpu1, default_tsc_khz) =
->
kvm_synchronize_tsc() -> __kvm_synchronize_tsc():

	if (vcpu->arch.virtual_tsc_khz !=3D kvm->arch.cur_tsc_khz) {
		kvm->arch.cur_tsc_freq_generation++;
		kvm->arch.all_vcpus_matched_freq =3D false;
		kvm->arch.nr_vcpus_matched_freq =3D 0;
	}

	/* Count each vCPU once per freq generation */
	if (vcpu->arch.this_tsc_freq_generation !=3D kvm->arch.cur_tsc_freq_genera=
tion) {
		vcpu->arch.this_tsc_freq_generation =3D kvm->arch.cur_tsc_freq_generation;
		kvm->arch.nr_vcpus_matched_freq++;
	}

	kvm->arch.cur_tsc_khz =3D vcpu->arch.virtual_tsc_khz;

__kvm_synchronize_tsc() sees default_tsc_khz !=3D F1, resets
nr_vcpus_matched_freq to 1, updates ka->cur_tsc_khz to default_tsc_khz, and
calls kvm_track_tsc_matching():

	if (ka->all_vcpus_matched_tsc ||
	    ka->nr_vcpus_matched_freq >=3D online)
		ka->all_vcpus_matched_freq =3D true;

Because online is still 1 during kvm_arch_vcpu_create(), 1 >=3D 1 is true a=
nd
ka->all_vcpus_matched_freq is latched back to true. When
kvm_arch_vcpu_postcreate() later runs after online_vcpus is incremented to =
2,
vcpu1->arch.virtual_tsc_khz already matches ka->cur_tsc_khz
(default_tsc_khz), and kvm_track_tsc_matching() never clears
ka->all_vcpus_matched_freq when nr_vcpus_matched_freq < online.

As a result, ka->all_vcpus_matched_freq and ka->use_master_clock stay true
while vCPU 0 is at F1 and vCPU 1 is at default_tsc_khz, causing
kvm_vcpu_ioctl_get_clock_guest() on vCPU 0 to return a pvclock structure wi=
th
tsc_timestamp scaled for F1 and tsc_to_system_mul/tsc_shift computed for
default_tsc_khz instead of returning -ENODATA.

> +
> +	if (copy_to_user(argp, &hv_clock, sizeof(hv_clock)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +/*
> + * Reverse the calculation in the hv_clock definition.
> + *
> + * time_ns =3D ( (cycles << shift) * mul ) >> 32;
> + * (although shift can be negative, so that's bad C)
> + *
> + * So for a single second,
> + * NSEC_PER_SEC =3D ( ( FREQ_HZ << shift) * mul ) >> 32
> + * NSEC_PER_SEC << 32 =3D ( FREQ_HZ << shift ) * mul
> + * ( NSEC_PER_SEC << 32 ) / mul =3D FREQ_HZ << shift
> + * ( NSEC_PER_SEC << 32 ) / mul ) >> shift =3D FREQ_HZ
> + */
> +static u64 hvclock_to_hz(u32 mul, s8 shift)
> +{
> +	u64 tm =3D NSEC_PER_SEC << 32;
> +
> +	/* Maximise precision. Shift left until the top bit is set */
> +	tm <<=3D 2;
> +	shift +=3D 2;
> +
> +	/* While 'mul' is even, increase the shift *after* the division */
> +	while (!(mul & 1)) {
> +		shift++;
> +		mul >>=3D 1;
> +	}
> +
> +	tm /=3D mul;
> +
> +	if (shift >=3D 64)
> +		return 0;
> +	if (shift > 0)
> +		return tm >> shift;
> +	if (shift <=3D -64)
> +		return 0;
> +	return tm << -shift;
> +}
> +
> +static int kvm_vcpu_ioctl_set_clock_guest(struct kvm_vcpu *v, void __use=
r *argp)
> +{
> +	struct pvclock_vcpu_time_info user_hv_clock;
> +	struct kvm *kvm =3D v->kvm;
> +	struct kvm_arch *ka =3D &kvm->arch;
> +	u64 curr_tsc_hz, user_tsc_hz;
> +	u64 user_clk_ns;
> +	u64 guest_tsc;
> +	int rc =3D 0;
> +
> +	if (copy_from_user(&user_hv_clock, argp, sizeof(user_hv_clock)))
> +		return -EFAULT;
> +
> +	if (user_hv_clock.pad0 || user_hv_clock.pad[0] || user_hv_clock.pad[1])
> +		return -EINVAL;
> +
> +	if (!user_hv_clock.tsc_to_system_mul)
> +		return -EINVAL;
> +
> +	if (user_hv_clock.tsc_shift < -31 || user_hv_clock.tsc_shift > 31)
> +		return -EINVAL;
> +
> +	user_tsc_hz =3D hvclock_to_hz(user_hv_clock.tsc_to_system_mul,
> +				    user_hv_clock.tsc_shift);
> +
> +	kvm_hv_request_tsc_page_update(kvm);
> +
> +	/*
> +	 * kvm_start_pvclock_update() takes tsc_write_lock and opens
> +	 * the pvclock seqcount; kvm_end_pvclock_update() closes both.
> +	 * All clock state modifications between them are atomic with
> +	 * respect to readers in kvm_guest_time_update().
> +	 */
> +	kvm_start_pvclock_update(kvm);
> +	pvclock_update_vm_gtod_copy(kvm);
> +
> +	if (!ka->use_master_clock) {
> +		rc =3D -ENODATA;
> +		goto out;
> +	}
> +
> +	curr_tsc_hz =3D (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
> +	if (unlikely(curr_tsc_hz =3D=3D 0)) {
> +		rc =3D -EBUSY;
> +		goto out;
> +	}

[Severity: Medium]
Can this curr_tsc_hz =3D=3D 0 (-EBUSY) branch ever be reached?

kvm_start_pvclock_update() acquires raw_spin_lock_irq(&ka->tsc_write_lock),
disabling interrupts and preemption on the local CPU. Immediately before the
!ka->use_master_clock check, pvclock_update_vm_gtod_copy() reads
get_cpu_tsc_khz() on the same CPU and clears ka->use_master_clock if tsc_hz
is 0:

arch/x86/kvm/x86.c:pvclock_update_vm_gtod_copy() {
	...
		tsc_hz =3D (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
		if (tsc_hz && kvm_caps.has_tsc_control)
			tsc_hz =3D kvm_scale_tsc(tsc_hz,
					       ka->master_tsc_scaling_ratio);
		if (tsc_hz)
			kvm_get_time_scale(NSEC_PER_SEC, tsc_hz,
					   &ka->master_tsc_shift,
					   &ka->master_tsc_mul);
		else
			ka->use_master_clock =3D false;
}

Because IRQs remain disabled across both calls, get_cpu_tsc_khz() =3D=3D 0 =
will
always set ka->use_master_clock =3D false in pvclock_update_vm_gtod_copy(),
causing kvm_vcpu_ioctl_set_clock_guest() to take the !ka->use_master_clock
path and return -ENODATA rather than the documented -EBUSY.

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
> +	 * same nominal frequency.
> +	 */
> +	if (user_tsc_hz < curr_tsc_hz - 1000 ||
> +	    user_tsc_hz > curr_tsc_hz + 1000) {
> +		rc =3D -ERANGE;
> +		goto out;
> +	}

[Severity: High]
Are there three boundary and overflow issues in the frequency calculation a=
nd
comparison between hvclock_to_hz() and kvm_vcpu_ioctl_set_clock_guest()?

First, if a vCPU's guest TSC frequency is set to 1 kHz via KVM_SET_TSC_KHZ,
set_tsc_khz() computes ratio =3D mul_u64_u32_div(1ULL << frac_bits, 1,
tsc_khz), which truncates down. Scaling the host TSC frequency in Hz via
kvm_scale_tsc() then yields curr_tsc_hz =3D=3D 999 Hz (non-zero, so
ka->use_master_clock stays true). Because curr_tsc_hz is u64, evaluating
curr_tsc_hz - 1000 underflows to U64_MAX, making user_tsc_hz < curr_tsc_hz -
1000 unconditionally true and failing with -ERANGE.

Second, host tsc_khz is measured in whole kHz (1000 Hz steps), so a 1 kHz
calibration difference between two hosts is already 1000 Hz. Because
kvm_get_time_scale() floors tsc_to_system_mul via div_frac(), hvclock_to_hz=
()
rounds user_tsc_hz up by 1 to 3 Hz (for example, 2100001 kHz becomes
2100001001 Hz) while kvm_scale_tsc() can floor curr_tsc_hz by 1 Hz. Doesn't=
 a
1 kHz host calibration difference therefore exceed +/- 1000 Hz by 1 to 3 Hz
and get rejected with -ERANGE?

Third, in hvclock_to_hz(), tm =3D (NSEC_PER_SEC << 34) / mul always has at
least bit 31 set (and bit 63 set when mul =3D=3D 1). When shift < 0 (for ex=
ample,
user_hv_clock.tsc_shift in [-31, -3]), won't tm << -shift overflow 64 bits
and wrap around modulo 2^64?

> +
> +	/*
> +	 * Calculate the guest TSC at the new reference point, and the
> +	 * corresponding KVM clock value according to user_hv_clock.
> +	 * Adjust kvmclock_offset so both definitions agree.
> +	 */
> +	guest_tsc =3D kvm_read_l1_tsc(v, ka->master_cycle_now);
> +	if (guest_tsc < user_hv_clock.tsc_timestamp) {
> +		rc =3D -EINVAL;
> +		goto out;
> +	}

[Severity: High]
Does the unsigned comparison guest_tsc < user_hv_clock.tsc_timestamp mishan=
dle
64-bit modular TSC wraparound?

Guest TSC values from kvm_read_l1_tsc() and pvclock deltas in
__pvclock_read_cycles() (u64 delta =3D tsc - src->tsc_timestamp) use 64-bit
modular arithmetic. When a vCPU has a negative TSC offset, its guest TSC can
start near U64_MAX and wrap across 0 into small positive values as time
advances.

If user_hv_clock.tsc_timestamp was captured just before wrapping across 0
(near U64_MAX) and guest_tsc on the destination is just after 0, guest_tsc =
is
ahead of tsc_timestamp, but guest_tsc < user_hv_clock.tsc_timestamp evaluat=
es
to true and rejects the call with -EINVAL. Conversely, if tsc_timestamp is a
small value just above 0 and guest_tsc is slightly behind it (wrapped below=
 0
to near U64_MAX), the unsigned check evaluates to false and passes a huge
delta (~U64_MAX) into __pvclock_read_cycles().

Should this check (s64)(guest_tsc - user_hv_clock.tsc_timestamp) < 0 instea=
d?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105154955.2525=
419-1-dwmw2@infradead.org?part=3D14
