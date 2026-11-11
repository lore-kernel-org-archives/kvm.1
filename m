Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794432155;
	b=yRjaC52SUfIPjzv6KUZ5Wwg7zk+9wIzo39P9JyV8yp4L9Xwj/twdRHBHDs2eFck+ctB/
	 MvVgrRed4FtG+Dv3zIYDo1pZAtnewnKGSTqvrGTN3tjn/hm4uI2dA2DsEE5nIBj9ZVCyQ
	 XkZ3jtNk8+81MqI6QUMN8aiLviVHEvopsenkRB1XsVhMh99cyQBXljar+Ah7gEIAMzyrw
	 lMsM4bjYPaFVZQ72n67WOVnqaZuvJhbAduBeTTHaYjsCO7XoY+4EwnMq/OrTUYy9KRlpa
	 NKOrC0KMZk7NQqCXJq0xmW7qDhT0O+FGYIDCmfKIO0CDuomqSeoUvMJup/05x4992oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794432155;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+oAf0BkbRu+vNfrOyA/+J4KnB3Q8SHhNdpONYGE1NDY=;
	b=osWXU8LuxP4Iyc0z0ew8X7lcITyxTiDWTSHLUWlNwJqOoiNmQ/3sQ0Sd7R0HK23/sH1G
	 2hKr4VcalW3h367kQGk1Trm5KKK5RzT6nfLkz38/ZDmEutDDlAtC1juyHTy3poTWTKp9U
	 sUjn1OqrrB7Se1VsOlLQIS0ReoXVJQrygqoqh2HOd5EyWAJyGjRYf51m0skVWJliBJhEo
	 x319bsJuRr8HW6Nn3Qjm4xg7gSGH3eJ3f6TCRJqP8plW2g+VVM38Cv/ugdbTn/ZaMKOoD
	 j0O9saEXqNqXjwfSYYn6gWbSnNC+x18j6+ExFub5qtDAEbFSZNoNh/wt5vU9bYrV0pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8wigrzi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F2A606A31C
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8wigrzi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AA11F00A05;
	Wed, 11 Nov 2026 21:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794432154;
	bh=+oAf0BkbRu+vNfrOyA/+J4KnB3Q8SHhNdpONYGE1NDY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=a8wigrzii32IeBquFlWwhnbttOuP/bJRreFfID0omezDExcNdf695FpvPVkc+n5KM
	 qxP4UT4A7hBLXi9bbpv2tx0VmFH3v3aAvHNkgYOpm0uB/hTplpFOyna7j/gVDWemvA
	 Qn22upHNRfQ0KHUjA45OvxyKvopJDUJBhQ8LC0dSyAemYQ00ceBrZztWsWir1Q3EF1
	 Hp26N/JA/93TX0CD1vFTLIt4ZT6O3DsWzLTsAJrL+xqsCIsCcjFTNPYIpXiAJVNiAd
	 MCYj7pEBDSUz+1iTaRKS5uTJXbMopbQfOyloU30Mrr7q5YSj0G/wtIHdhkKo2gkyAm
	 BZhn8iWqznHhA==
Message-ID: <sashiko-outbox-209699@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 10/26] KVM: x86: Re-synchronize TSC after
 KVM_SET_TSC_KHZ
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261111180922.4177927-11-dwmw2@infradead.org>
References: <20261111180922.4177927-1-dwmw2@infradead.org>
 <20261111180922.4177927-11-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 21:22:34 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] KVM: x86: wrong scaling of tsc_offset_adjustment in
  __kvm_synchronize_tsc_at()
- [Medium] KVM: x86: uninitialized l1_tsc_scaling_ratio in
  kvm_set_tsc_khz()
- [Medium] KVM: x86: kvm_set_tsc_khz() sync breaks per-vCPU init and
  restore
--

commit 28669172288cdaaabe3c3f647bfb5b2ebfc1d816
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Re-synchronize TSC after KVM_SET_TSC_KHZ

This commit re-synchronizes a vCPU's TSC when its frequency is changed via
KVM_SET_TSC_KHZ, sampling the current guest TSC and host clock before
updating the scaling ratio and computing the new offset against that
reference point.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 1d4b66257b35f..cf35363366f14 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1073,10 +1073,20 @@ static int set_tsc_khz(struct kvm_vcpu *vcpu, u32=
 user_tsc_khz, bool scale)
>  	return 0;
>  }
> =20
> -static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
> +static void __kvm_synchronize_tsc_at(struct kvm_vcpu *vcpu, u64 *value,
> +				     u64 host_tsc, s64 ns,
> +				     bool user_initiated);
> +
> +static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz, bool=
 init)
>  {
> +	bool freq_changed =3D (vcpu->arch.virtual_tsc_khz !=3D user_tsc_khz);
>  	u32 thresh_lo, thresh_hi;
> +	u32 tsc_mult;
> +	s8 tsc_shift;
>  	int use_scaling =3D 0;
> +	u64 tsc, host_tsc;
> +	unsigned long flags;
> +	s64 ns;
> =20
>  	/* tsc_khz can be zero if TSC calibration fails */
>  	if (user_tsc_khz =3D=3D 0) {
> @@ -1085,11 +1095,19 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu,=
 u32 user_tsc_khz)
>  		return -1;
>  	}
> =20
> +	/*
> +	 * Setting the current frequency again is a no-op, as documented
> +	 * =E2=80=94 unconditionally, including a frequency the hardware could
> +	 * not honour at vCPU creation (which commits it regardless):
> +	 * re-running set_tsc_khz() would turn the documented no-op into
> +	 * -EINVAL.
> +	 */
> +	if (!init && !freq_changed)
> +		return 0;
> +
>  	/* Compute a scale to convert nanoseconds in TSC cycles */
>  	kvm_get_time_scale(user_tsc_khz * 1000LL, NSEC_PER_SEC,
> -			   &vcpu->arch.virtual_tsc_shift,
> -			   &vcpu->arch.virtual_tsc_mult);
> -	vcpu->arch.virtual_tsc_khz =3D user_tsc_khz;
> +			   &tsc_shift, &tsc_mult);
> =20
>  	/*
>  	 * Compute the variation in TSC rate which is acceptable
> @@ -1104,7 +1122,92 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, =
u32 user_tsc_khz)
>  			 user_tsc_khz, thresh_lo, thresh_hi);
>  		use_scaling =3D 1;
>  	}
> -	return set_tsc_khz(vcpu, user_tsc_khz, use_scaling);
> +
> +	/*
> +	 * Sample the guest TSC before changing the ratio, so continuity
> +	 * can be preserved across the change =E2=80=94 as a {guest TSC, host
> +	 * clock} tuple, not a bare value: the synchronization below
> +	 * computes the new offset against the tuple's own reference
> +	 * point, so the guest TSC keeps counting through this function.
> +	 * Preemption stays disabled from the sample until tsc_write_lock
> +	 * is held =E2=80=94 not for timing, but because this task's own preempt
> +	 * notifier (kvm_sched_in -> kvm_arch_vcpu_load) is the one
> +	 * writer which could apply a pending backwards-TSC compensation
> +	 * to the offset the sample was read through; a compensation
> +	 * still pending when the lock is taken is folded in there.
> +	 */
> +	if (!init) {
> +		preempt_disable();
> +#ifdef CONFIG_X86_64
> +		if (!kvm_get_time_and_clockread(&ns, &host_tsc))
> +#endif
> +		{
> +			unsigned long irqflags;
> +
> +			/*
> +			 * The two reads must form one coherent reference
> +			 * point.
> +			 */
> +			local_irq_save(irqflags);
> +			host_tsc =3D rdtsc();
> +			ns =3D get_kvmclock_base_ns();
> +			local_irq_restore(irqflags);
> +		}
> +		tsc =3D kvm_read_l1_tsc(vcpu, host_tsc);
> +	}
> +
> +	/*
> +	 * Commit the new frequency only once set_tsc_khz() can no longer
> +	 * fail: a failed ioctl must leave no trace, or a retry with the
> +	 * still-active frequency would wrongly look like a change. The
> +	 * exception is vCPU creation (@init), whose caller ignores the
> +	 * return value: commit the requested frequency even when the
> +	 * hardware cannot scale to it, as creation always has, rather
> +	 * than leave the vCPU with the zeroed frequency from allocation
> +	 * (KVM_GET_TSC_KHZ would report 0, and the catchup path would
> +	 * compute with a zero mult).
> +	 */
> +	if (set_tsc_khz(vcpu, user_tsc_khz, use_scaling) && !init) {
> +		preempt_enable();
> +		return -1;
> +	}
> +
> +	vcpu->arch.virtual_tsc_shift =3D tsc_shift;
> +	vcpu->arch.virtual_tsc_mult =3D tsc_mult;
> +	vcpu->arch.virtual_tsc_khz =3D user_tsc_khz;

[Severity: Medium]
When init is true and set_tsc_khz() fails or enables catchup mode, does
this leave vcpu->arch.l1_tsc_scaling_ratio and vcpu->arch.tsc_scaling_ratio
at 0 instead of kvm_caps.default_tsc_scaling_ratio?

arch/x86/kvm/x86.c:set_tsc_khz() {
	...
	/* TSC scaling supported? */
	if (!kvm_caps.has_tsc_control) {
		if (user_tsc_khz > tsc_khz) {
			vcpu->arch.tsc_catchup =3D 1;
			vcpu->arch.tsc_always_catchup =3D 1;
			return 0;
		} else {
			pr_warn_ratelimited("user requested TSC rate below hardware speed\n");
			return -1;
		}
	}

	/* TSC scaling required  - calculate ratio */
	ratio =3D mul_u64_u32_div(1ULL << kvm_caps.tsc_scaling_ratio_frac_bits,
				user_tsc_khz, tsc_khz);

	if (ratio =3D=3D 0 || ratio >=3D kvm_caps.max_tsc_scaling_ratio) {
		pr_warn_ratelimited("Invalid TSC scaling ratio - virtual-tsc-khz=3D%u\n",
			            user_tsc_khz);
		return -1;
	}
}

Because a newly allocated vCPU starts with a zeroed arch struct, neither
the !kvm_caps.has_tsc_control path nor the invalid ratio path calls
kvm_vcpu_write_tsc_multiplier().  A zero ratio causes kvm_scale_tsc() to
scale host_tsc by 0, sets kvm->arch.cur_tsc_scaling_ratio to 0 in
kvm_arch_vcpu_postcreate() (disabling the masterclock), and leaves VMX's
TSC_MULTIPLIER VMCS field at 0 (causing KVM_EXIT_FAIL_ENTRY on VM-Entry).
In addition, because virtual_tsc_khz is committed on creation even when
set_tsc_khz() failed, the new "!init && !freq_changed" early return above
causes a later vCPU KVM_SET_TSC_KHZ ioctl with that same unsupported
default_tsc_khz to return 0 instead of -EINVAL.

> +
> +	/*
> +	 * At vCPU creation (@init) the vCPU is not yet counted in
> +	 * online_vcpus, so synchronizing here would corrupt the VM-wide
> +	 * matching state (and leave it corrupted if creation subsequently
> +	 * fails). The initial synchronization happens in
> +	 * kvm_arch_vcpu_postcreate() instead.
> +	 */
> +	if (init)
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
> +	raw_spin_lock_irqsave(&vcpu->kvm->arch.tsc_write_lock, flags);
> +	preempt_enable();
> +	if (vcpu->arch.last_vmentry_cpu !=3D -1 || vcpu->arch.user_set_tsc)
> +		__kvm_synchronize_tsc_at(vcpu, &tsc, host_tsc, ns, false);
> +	else
> +		__kvm_synchronize_tsc_at(vcpu, NULL, host_tsc, ns, false);
> +	raw_spin_unlock_irqrestore(&vcpu->kvm->arch.tsc_write_lock, flags);
> +	return 0;
>  }

[Severity: Medium]
Does synchronizing in kvm_set_tsc_khz() break TSC and frequency matching
when userspace initializes or restores vCPUs one by one?

If a VMM creates and configures each vCPU in a loop (KVM_CREATE_VCPU
followed by KVM_SET_TSC_KHZ(F_new) per vCPU), vCPU 0's KVM_SET_TSC_KHZ sets
kvm->arch.cur_tsc_khz to F_new in generation 2.  Creating vCPU 1 then runs
kvm_arch_vcpu_postcreate() -> kvm_synchronize_tsc() at default_tsc_khz,
which sees virtual_tsc_khz !=3D cur_tsc_khz, bumps cur_tsc_freq_generation
and cur_tsc_generation to 3, and resets cur_tsc_khz back to
default_tsc_khz.  When KVM_SET_TSC_KHZ(F_new) then runs on vCPU 1,
virtual_tsc_khz =3D=3D cur_tsc_khz is false in __kvm_synchronize_tsc_at(), =
so
vCPU 1 opens generation 4 at data =3D 0 with a new offset and leaves vCPU 0
permanently orphaned in generation 2 with all_vcpus_matched_freq and
all_vcpus_matched_tsc both false (disabling the masterclock and
PVCLOCK_TSC_STABLE_BIT).  The same generation ping-pong happens when all
vCPUs are created first at default_tsc_khz and userspace restores each vCPU
in turn by writing MSR_IA32_TSC followed by KVM_SET_TSC_KHZ(F_new),
Despite commit "KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the documentation
on TSC migration" later in the series documenting that userspace should
create all vCPUs before setting their frequency, existing VMMs already
perform per-vCPU setup and restore in a loop.

[ ... ]

> @@ -1511,40 +1616,84 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu=
 *vcpu, u64 offset, u64 tsc,
>  	kvm_track_tsc_matching(vcpu, !matched);
>  }
> =20
> -void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
> +/*
> + * Synchronize the vCPU's TSC against an explicit {host_tsc, ns} referen=
ce
> + * point: @value (when non-NULL) is the guest TSC *at* @host_tsc, not at
> + * some unspecified "now". The offset is computed against that reference,
> + * so a sampled value stays valid however much time passes between the
> + * sampling and this call.
> + */
> +static void __kvm_synchronize_tsc_at(struct kvm_vcpu *vcpu, u64 *value,
> +				     u64 host_tsc, s64 ns,
> +				     bool user_initiated)
>  {
> -	u64 data =3D user_value ? *user_value : 0;
> +	u64 data =3D value ? *value : 0;
>  	struct kvm *kvm =3D vcpu->kvm;
> -	u64 offset, host_tsc, elapsed;
> -	s64 ns;
> -	unsigned long flags;
> +	u64 elapsed_cycles =3D 0;
> +	s64 elapsed;
> +	u64 offset;
>  	bool matched =3D false;
>  	bool synchronizing =3D false;
> =20
> -	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
> +	lockdep_assert_held(&kvm->arch.tsc_write_lock);
> =20
> -#ifdef CONFIG_X86_64
> -	if (!kvm_get_time_and_clockread(&ns, &host_tsc))
> -#endif
> -	{
> -		host_tsc =3D rdtsc();
> -		ns =3D get_kvmclock_base_ns();
> -	}
> +	/*
> +	 * A backwards-TSC compensation pending now was not in a sampled
> +	 * @value: it is applied to the vCPU's offset only at vcpu_load,
> +	 * and the sample was read through the uncompensated offset. Fold
> +	 * it in (scaled as adjust_tsc_offset_host() would), since
> +	 * __kvm_synchronize_tsc() clears the pending adjustment as
> +	 * superseded by the absolute offset installed here. A
> +	 * user-initiated value is the desired guest TSC *now*, and needs
> +	 * no correction.
> +	 */
> +	if (unlikely(vcpu->arch.tsc_offset_adjustment) &&
> +	    value && !user_initiated)
> +		data +=3D kvm_scale_tsc(vcpu->arch.tsc_offset_adjustment,
> +				      vcpu->arch.l1_tsc_scaling_ratio);

[Severity: Medium]
Doesn't this scale vcpu->arch.tsc_offset_adjustment with the new scaling
ratio instead of the old one?

In kvm_set_tsc_khz(), tsc is sampled via kvm_read_l1_tsc() before
set_tsc_khz() runs, so the sample reflects the uncompensated offset under
the old l1_tsc_scaling_ratio.  set_tsc_khz() then overwrites
vcpu->arch.l1_tsc_scaling_ratio with the new ratio before calling
__kvm_synchronize_tsc_at().  If kvm_arch_enable_virtualization_cpu() queued
a backwards-TSC adjustment before tsc_write_lock was taken, scaling
tsc_offset_adjustment by the new l1_tsc_scaling_ratio here introduces a
step jump of kvm_scale_tsc(adj, R_new) - kvm_scale_tsc(adj, R_old) into the
preserved guest TSC and desynchronizes the vCPU from its siblings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111180922.4177=
927-1-dwmw2@infradead.org?part=3D10
