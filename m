Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899627;
	b=4tyuV7hmWSzt8p+gngB3JfE0GczLlLVcLlHZA+Vp/AgqNIY/8T96OAZ17Al0zw0t3E09
	 Po6f1awF/wd6tMDnqPJdgJPTxJsQZwBl4rHPDXnpCMvgeOocvDkg/ZYo6/lpJ1Vj282AU
	 voYQ1gK9R12bzwWbZhIg8jk9bYNTt7pZhssNmCblSjZtwudgKuQCOs1D7lTFAPD+5ykT+
	 IUahe7KrYdhjxT+27aQ4AI6nO39hLucOb0psw2ZOOXWI7qsXK1XzCkCJOZV9HDltBPqk2
	 yVuZ0PDPAvYzxqah+462WQOJg2/jN/VHMAOHtrF9VobZ7JZs6Gf0ytu8wXNU1GYV73Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899627;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qacvKjP99rkI5QjtScxzbu3CA+oQcDeZAeADtp1ehck=;
	b=PEIFf2zpusTUbqA893k3j6YX6DuvS/El3KDyOPR+AsKJBw4fIcOu8/Vx2OM1q0MVE2EK
	 rf5Yd0IiqlQEqf8ZiqFCqFRsd4FHyKt51WSuHNf7KU4Y/teRySdKukxi2hRv3gi7Y2sxV
	 mA7ASSFaLnYifhjyTMPHkfllRquOBXgaYpZ3srrmss/2V5B0qfjFPEefQw3PVNZOHuyab
	 CZckllptHsRSAHsKmu1A0DKIxXFmO3x3lcj/zS+x7IdxwVTIgxhEH7YTGQ6KxJ6p0/jlP
	 CLyjJzaqlphwI3bTCKxYe1SW6JIV4Y6tMBg0ix4Bf2rc++xyKCYhqhSXkJsbtHDQxPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Dzs/Ai88";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64896606D803
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dzs/Ai88
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF30B1F000C1;
	Thu,  5 Nov 2026 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793899627;
	bh=qacvKjP99rkI5QjtScxzbu3CA+oQcDeZAeADtp1ehck=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Dzs/Ai88HE8e6/5k0kNJBzgzh4R3FH4WutNqkntXtA5gAQ1RiZA6srVe9Xk//ijwI
	 Y/IvxC885tBL03gTAAAJzmqoqRNr4NDKMMHc2itDZ6yN6YZc/S7YWt29P+3IzG+f8L
	 ZKCFBKX8FxO1PxWsmJ7BRJBVkKKitidRhATxcj5fky1eQDys+dTFq1qdiUjiCa7yYP
	 FKzTTtPToeagHBP9MUqp7CGoBAbFsz1+8ku50m4sphNINamTxdmUePsfw7LvJIEYH4
	 4/JyJ978kfRgxuyvZlxSnhijyRjrjWI3BXsKm63N/6eZX8BeDpiMPX7z+EFKcq+qI6
	 W4gzJ6BfWhXMw==
Message-ID: <sashiko-outbox-199616@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 04/23] KVM: x86: Allow KVM master clock mode when
 TSCs are offset from each other
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261105154955.2525419-5-dwmw2@infradead.org>
References: <20261105154955.2525419-1-dwmw2@infradead.org>
 <20261105154955.2525419-5-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:27:06 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] KVM: x86: stale pvclock tsc_timestamp after __kvm_synchronize_tsc()
- [Medium] KVM: x86: missing masterclock update in kvm_track_tsc_matching()
--

commit e48b3906906a2154ee31b39c2d8cc74f2ed71a9f
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Allow KVM master clock mode when TSCs are offset from each other

This commit decouples master clock eligibility from TSC offset matching so
that KVM remains in master clock mode as long as all vCPUs share the same T=
SC
frequency. Per-vCPU TSC offset matching is tracked separately and used only
to gate PVCLOCK_TSC_STABLE_BIT.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ec8693f4827fc..38fcb1d756611 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1114,30 +1114,63 @@ static inline bool gtod_is_based_on_tsc(int mode)
>  }
>  #endif
> =20
> -static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool new_gener=
ation)
> +static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool update_mc=
lock)
>  {
>  #ifdef CONFIG_X86_64
>  	struct kvm_arch *ka =3D &vcpu->kvm->arch;
>  	struct pvclock_gtod_data *gtod =3D &pvclock_gtod_data;
> +	bool prev_matched_tsc =3D ka->all_vcpus_matched_tsc;
> =20
>  	/*
> -	 * To use the masterclock, the host clocksource must be based on TSC
> -	 * and all vCPUs must have matching TSCs.  Note, the count for matching
> -	 * vCPUs doesn't include the reference vCPU, hence "+1".
> +	 * Track whether all vCPUs have matching TSC offsets (for
> +	 * PVCLOCK_TSC_STABLE_BIT) and matching frequencies (for
> +	 * master clock eligibility).
> +	 */
> +
> +	/*
> +	 * A new vCPU might already have incremented ->online_vcpus
> +	 * and cause a temporary false negative here. But will then
> +	 * call kvm_synchronize_tsc() from kvm_arch_vcpu_postcreate()
> +	 * and finish the job.
> +	 */
> +	int online =3D atomic_read(&vcpu->kvm->online_vcpus);
> +	/*
> +	 * WRITE_ONCE() pairs with the READ_ONCE() in kvm_guest_time_update(),
> +	 * which samples the flag locklessly (outside both tsc_write_lock and
> +	 * its pvclock seqcount read section); the race is benign (a stale
> +	 * value merely delays the PVCLOCK_TSC_STABLE_BIT broadcast to the
> +	 * masterclock update which is requested below).
>  	 */
> -	ka->all_vcpus_matched_tsc =3D (ka->nr_vcpus_matched_tsc + 1 =3D=3D
> -				     atomic_read(&vcpu->kvm->online_vcpus));
> +	WRITE_ONCE(ka->all_vcpus_matched_tsc,
> +		   ka->nr_vcpus_matched_tsc >=3D online);
> =20
> -	bool use_master_clock =3D ka->all_vcpus_matched_tsc &&
> +	update_mclock |=3D (prev_matched_tsc !=3D ka->all_vcpus_matched_tsc);
> +
> +	/*
> +	 * all_vcpus_matched_freq starts true and is cleared when
> +	 * __kvm_synchronize_tsc() detects a frequency mismatch.
> +	 * Re-enable when all vCPUs have synced with matching frequency.
> +	 * If all offsets also match, that implies frequencies match too.
> +	 */
> +	if (ka->all_vcpus_matched_tsc ||
> +	    ka->nr_vcpus_matched_freq >=3D online)
> +		ka->all_vcpus_matched_freq =3D true;
> +
> +	/*
> +	 * To use the masterclock, the host clocksource must be based on TSC
> +	 * and all vCPUs must have matching TSC *frequency*. Different offsets
> +	 * are fine =E2=80=94 each vCPU's pvclock has its own tsc_timestamp that
> +	 * accounts for its offset.
> +	 */
> +	bool use_master_clock =3D ka->all_vcpus_matched_freq &&
>  				gtod_is_based_on_tsc(gtod->clock.vclock_mode);
> =20
>  	/*
> -	 * Request a masterclock update if the masterclock needs to be toggled
> -	 * on/off, or when starting a new generation and the masterclock is
> -	 * enabled (compute_guest_tsc() requires the masterclock snapshot to be
> -	 * taken _after_ the new generation is created).
> +	 * Request a masterclock update if needed: toggling master clock,
> +	 * new generation requiring a fresh snapshot, or a change in
> +	 * all_vcpus_matched_tsc (to broadcast PVCLOCK_TSC_STABLE_BIT).
>  	 */
> -	if ((ka->use_master_clock && new_generation) ||
> +	if ((ka->use_master_clock && update_mclock) ||
>  	    (ka->use_master_clock !=3D use_master_clock))
>  		kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);

[Severity: Medium]
In arch/x86/kvm/x86.c, when ka->all_vcpus_matched_freq transitions from fal=
se
to true in kvm_track_tsc_matching(), should that also set update_mclock?

Suppose a VM with 3 online vCPUs already has ka->use_master_clock set to tr=
ue
from vCPU creation, and userspace updates the TSC frequency on all vCPUs
before entering KVM_RUN:

1. vCPU 0 and vCPU 1 call __kvm_synchronize_tsc() at the new frequency with
   divergent offsets (matched =3D=3D false). ka->all_vcpus_matched_freq bec=
omes
   false and KVM_REQ_MASTERCLOCK_UPDATE is queued on vCPU 0 and vCPU 1, but
   ka->use_master_clock remains true until a vCPU enters the guest and
   services the request.

2. vCPU 2 then calls __kvm_synchronize_tsc() at the new frequency with an
   offset matching vCPU 1 (matched =3D=3D true). ka->nr_vcpus_matched_freq
   reaches online (3), so ka->all_vcpus_matched_freq transitions from false
   to true and local use_master_clock is true. However, ka->nr_vcpus_matche=
d_tsc
   is 2 (< 3), so ka->all_vcpus_matched_tsc stays false and update_mclock
   remains false.

Because ka->use_master_clock is still true and local use_master_clock is al=
so
true, both (ka->use_master_clock && update_mclock) and
(ka->use_master_clock !=3D use_master_clock) evaluate to false. Could vCPU 2
then enter KVM_RUN without KVM_REQ_MASTERCLOCK_UPDATE set and use stale
master_tsc_scaling_ratio, master_tsc_mul, and master_tsc_shift values from =
the
old frequency?

[ ... ]

> @@ -1365,17 +1413,18 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu=
 *vcpu, u64 offset, u64 tsc,
>  		 * exact software computation in compute_guest_tsc()
>  		 */
>  		kvm->arch.cur_tsc_generation++;
> +		WRITE_ONCE(kvm->arch.all_vcpus_matched_tsc, false);
> +		kvm->arch.nr_vcpus_matched_tsc =3D 0;
>  		kvm->arch.cur_tsc_nsec =3D ns;
>  		kvm->arch.cur_tsc_write =3D tsc;
>  		kvm->arch.cur_tsc_offset =3D offset;
> -		kvm->arch.nr_vcpus_matched_tsc =3D 0;
> -		kvm->arch.all_vcpus_matched_tsc =3D false;
> -	} else if (vcpu->arch.this_tsc_generation !=3D kvm->arch.cur_tsc_genera=
tion) {
> +	}
> +
> +	if (vcpu->arch.this_tsc_generation !=3D kvm->arch.cur_tsc_generation) {
> +		vcpu->arch.this_tsc_generation =3D kvm->arch.cur_tsc_generation;
>  		kvm->arch.nr_vcpus_matched_tsc++;
>  	}
> =20
> -	/* Keep track of which generation this VCPU has synchronized to */
> -	vcpu->arch.this_tsc_generation =3D kvm->arch.cur_tsc_generation;
>  	vcpu->arch.this_tsc_nsec =3D kvm->arch.cur_tsc_nsec;
>  	vcpu->arch.this_tsc_write =3D kvm->arch.cur_tsc_write;
> =20
>  	kvm_track_tsc_matching(vcpu, !matched);
>  }

[Severity: High]
Can __kvm_synchronize_tsc() in arch/x86/kvm/x86.c leave a vCPU's guest
pvclock tsc_timestamp stale when matched is true?

In kvm_guest_time_update(), master clock mode populates each vCPU's
hv_clock.tsc_timestamp using its own l1_tsc_offset:

	if (use_master_clock) {
		hv_clock.tsc_timestamp =3D kvm_read_l1_tsc(v, master_tsc);
		hv_clock.system_time =3D master_ns + v->kvm->arch.kvmclock_offset;
	}

When __kvm_synchronize_tsc() is called via kvm_synchronize_tsc() or
kvm_arch_tsc_set_attr(), it updates vcpu->arch.l1_tsc_offset through
kvm_vcpu_write_tsc_offset(vcpu, offset) without requesting
KVM_REQ_CLOCK_UPDATE on vcpu, and then calls:

	kvm_track_tsc_matching(vcpu, !matched);

With this change, ka->use_master_clock remains true even when vCPUs have
different TSC offsets. If matched is true and ka->all_vcpus_matched_tsc does
not change its boolean value in kvm_track_tsc_matching(), update_mclock sta=
ys
false and neither KVM_REQ_MASTERCLOCK_UPDATE nor KVM_REQ_CLOCK_UPDATE is
requested.

For example, this can happen when:

1. A VM has 3 or more online vCPUs with divergent offsets: vCPU 0 sets a new
   offset (matched =3D=3D false), vCPU 1 synchronizes to vCPU 0's offset
   (matched =3D=3D true, nr_vcpus_matched_tsc becomes 2 < 3 so
   all_vcpus_matched_tsc remains false), while vCPU 2 stays at a different
   offset.

2. A vCPU whose l1_tsc_offset was modified by the guest via
   MSR_IA32_TSC_ADJUST or MSR_IA32_TSC (which do not clear
   ka->all_vcpus_matched_tsc) is later synchronized back to cur_tsc_offset =
by
   host userspace (matched =3D=3D true, while all_vcpus_matched_tsc was alr=
eady
   true).

Since kvm_arch_vcpu_load() also skips requesting KVM_REQ_CLOCK_UPDATE when
ka->use_master_clock is true and vcpu->cpu !=3D -1, wouldn't the vCPU re-en=
ter
the guest with the new hardware l1_tsc_offset in rdtsc while its pvclock
struct in guest memory still holds the old tsc_timestamp?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105154955.2525=
419-1-dwmw2@infradead.org?part=3D4
