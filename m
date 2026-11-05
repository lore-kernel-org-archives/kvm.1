Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906149;
	b=Ohte6AntgT5jBUQsapx3o6oQrLRtqXsvx3ovO7wyzk4nKouRVK5BFZtizzAQiiRUeHay
	 tbZtKRCN5Q9mhn+1TbizD7Gt+vjgs568avrgz+O+wtcXY4igmAeMMd2Vrs6784rY/cNr3
	 W8njdneyxmzQYVJjChb0ESiKuDk9eaHcEvfzvJYNOPsgpNifrvNBJb9kX8BHhmTFfkNBX
	 SsmNkrAjxaMsWn9pjTXDRTmkz0NLR3R2w2O0TbOj1JjqOpyRf0wid0dxZ5OgQsQFxVJil
	 ZuCr2a9V2vThnADDGCnyKnq4717gWHG4utuE2aqcYOXaGpZBR3nA4bORAyWSSlqYG+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906149;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jWLFFJ/Hvbs6hlpI8QhMyfWXIRyQD2jWJqvsJ+wsDNc=;
	b=LcF4BsVAb5xbnDzbXvRBxwGUSO9aRnQG2/tkxIJO9ik/y+/BcnXKheJBl6coCxyghwdG
	 he7ACpBJICQNjaS5FCqwxDWMRfKUyXcCiz0lY3tuhFCML3dhPA0MzJX87ba7os0daCv/f
	 xjebqLqkXEMCjxsyhR8lpCxlPrvN06nkQOAgJRGc5gTn3skaWrVRJ+0C1AYXGOPpoW34n
	 B9VkrWHGbhvOW1aRKdQs8hZQd38XEg3yLsArSTDzxOPjjys9UoZ33TRSY8uJDt+JR/Cn2
	 XnK5hkEpW4+GFaiD0uudkggRPPRD7EkcfSSJpXb6fe9ZGuFRh5dW9PqQGNhsXdafGNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Atxj1Hfb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE0A606A31B
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 19:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Atxj1Hfb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927581F000C1;
	Thu,  5 Nov 2026 19:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906148;
	bh=jWLFFJ/Hvbs6hlpI8QhMyfWXIRyQD2jWJqvsJ+wsDNc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Atxj1HfboS0cIPz3t2ToNl6czr0HdEsh3y1aPDjPoZxlKvfinpGalzonYTrX1qAPL
	 Gf6agJEMeGFjGndZNrSXa27AywOBC6d32/LVLgpfYFZPa6uUWtLtIy5pVnf0LMqkz/
	 Xww/cd01lYcGuv8WyHMBwfkkZQKFapsPAeVBTF07RHbRaGLoHC7JZ945J6sp5O1bGB
	 UflurqNibHuML6W1E5p+vkijERBulj8h9iK7sY5KdxLhr6RIuxbjF6yLH9Ap5vZOq0
	 IjWDjZUrPG88XSUarm0ewsieEGK/iQYU4alyS6DIEtHkaKqdwB5ObWW3lB4BGNlLyf
	 cnbJCuCX0RMTA==
Message-ID: <sashiko-outbox-199830@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 11/23] KVM: x86: Activate master clock from
 kvm_arch_init_vm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261105154955.2525419-12-dwmw2@infradead.org>
References: <20261105154955.2525419-1-dwmw2@infradead.org>
 <20261105154955.2525419-12-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:15:48 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] KVM: x86: unreachable scaling check in kvm_synchronize_tsc()
- [Medium] KVM: x86: premature TSC sync in kvm_arch_vcpu_create() corrupts =
freq match
- [Medium] KVM: x86: unserviced masterclock request in kvm_arch_vcpu_postcr=
eate()
--

commit e32eb6058695cc6d79a22be2b503c0c26e852ace
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Activate master clock from kvm_arch_init_vm()

This commit initializes the initial TSC generation and master clock state in
kvm_arch_init_vm() from an atomic ktime/TSC snapshot, and updates
kvm_synchronize_tsc() and kvm_arch_vcpu_postcreate() to synchronize vCPUs a=
nd
refresh the master clock against that initial generation.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9401685287215..6dbdb60962fe7 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1500,11 +1500,25 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u=
64 *value, bool user_initiated)
> =20
>  		data =3D kvm->arch.cur_tsc_write + delta;
> =20
> -		if (!kvm_check_tsc_unstable())
> -			offset =3D kvm->arch.cur_tsc_offset;
> -		else
> +		/*
> +		 * The generation's offset can only be joined by a vCPU which
> +		 * scales the TSC by the same ratio it was recorded with; the
> +		 * initial generation's offset is recorded at VM creation
> +		 * with the default ratio, before any vCPU exists. With a
> +		 * different ratio, open a new generation (recording this
> +		 * vCPU's own offset) rather than leave the generation's
> +		 * ratio and offset describing different scaling domains.
> +		 */
> +		if (vcpu->arch.l1_tsc_scaling_ratio !=3D
> +		    kvm->arch.cur_tsc_scaling_ratio) {
>  			offset =3D kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
> -		matched =3D true;
> +		} else {
> +			if (!kvm_check_tsc_unstable())
> +				offset =3D kvm->arch.cur_tsc_offset;
> +			else
> +				offset =3D kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
> +			matched =3D true;
> +		}
>  	}
> =20
>  	__kvm_synchronize_tsc(vcpu, offset, data, ns, matched, user_initiated);

[Severity: Medium]
Can this scaling ratio check in kvm_synchronize_tsc() ever be reached?

The enclosing block in kvm_synchronize_tsc() is gated on matching
virtual_tsc_khz:

	if (synchronizing &&
	    vcpu->arch.virtual_tsc_khz =3D=3D kvm->arch.cur_tsc_khz) {
		u64 delta =3D nsec_to_cycles(vcpu, elapsed);

		data =3D kvm->arch.cur_tsc_write + delta;
		...
		if (vcpu->arch.l1_tsc_scaling_ratio !=3D
		    kvm->arch.cur_tsc_scaling_ratio) {

In set_tsc_khz(), vcpu->arch.l1_tsc_scaling_ratio is derived deterministica=
lly
from vcpu->arch.virtual_tsc_khz, and __kvm_synchronize_tsc() updates
kvm->arch.cur_tsc_khz and kvm->arch.cur_tsc_scaling_ratio together.

Meanwhile, kvm_arch_init_vm() initializes:

	kvm->arch.cur_tsc_scaling_ratio =3D kvm_caps.default_tsc_scaling_ratio;
	kvm->arch.cur_tsc_khz =3D kvm->arch.default_tsc_khz;

When userspace configures a non-default guest TSC frequency via the VM-scop=
ed
KVM_SET_TSC_KHZ ioctl in kvm_arch_vm_ioctl():

	mutex_lock(&kvm->lock);
	if (!kvm->created_vcpus) {
		WRITE_ONCE(kvm->arch.default_tsc_khz, user_tsc_khz);
		r =3D 0;
	}
	mutex_unlock(&kvm->lock);

only kvm->arch.default_tsc_khz is updated, leaving kvm->arch.cur_tsc_khz at
the initial host frequency. Or, if userspace instead invokes the vCPU-scoped
KVM_SET_TSC_KHZ ioctl after creating the first vCPU, virtual_tsc_khz also
differs from kvm->arch.cur_tsc_khz.

In both cases, vcpu->arch.virtual_tsc_khz =3D=3D kvm->arch.cur_tsc_khz is f=
alse in
kvm_synchronize_tsc(), so the outer if block is skipped entirely. That leav=
es
data at 0 instead of extrapolating data =3D kvm->arch.cur_tsc_write + delta=
 from
the VM-creation epoch (while kvmclock_offset remains anchored at VM creation
time), and on VMs where vcpu->arch.guest_tsc_protected causes
__kvm_synchronize_tsc() to return early, kvm->arch.cur_tsc_scaling_ratio and
kvm->arch.master_tsc_scaling_ratio remain stuck at
kvm_caps.default_tsc_scaling_ratio.

> @@ -9645,8 +9659,15 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcp=
u)
>  		return;
>  	vcpu_load(vcpu);
>  	kvm_synchronize_tsc(vcpu, NULL, false);
> -	if (kvm_check_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu))
> +
> +	/*
> +	 * Refresh the VM-creation masterclock snapshot (see
> +	 * kvm_arch_init_vm), synchronously so that it is valid even for
> +	 * userspace which queries the clock before ever running a vCPU.
> +	 */
> +	if (vcpu->vcpu_idx =3D=3D 0)
>  		kvm_update_masterclock(vcpu->kvm, NULL);
> +
>  	vcpu_put(vcpu);
> =20
>  	/* poll control enabled by default */

[Severity: Medium]
What happens if creating a secondary vCPU (vcpu->vcpu_idx > 0) queues
KVM_REQ_MASTERCLOCK_UPDATE on that vCPU?

During vCPU creation, kvm_synchronize_tsc() -> __kvm_synchronize_tsc() ->
kvm_track_tsc_matching() checks whether a masterclock update is needed:

	if ((ka->use_master_clock && update_mclock) ||
	    (ka->use_master_clock !=3D use_master_clock))
		kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);

When vcpu->vcpu_idx > 0 and its synchronization opens a new TSC generation,
changes ka->all_vcpus_matched_tsc, or changes masterclock eligibility,
KVM_REQ_MASTERCLOCK_UPDATE is queued only on the newly created vCPU.

With kvm_arch_vcpu_postcreate() only calling kvm_update_masterclock() when
vcpu->vcpu_idx =3D=3D 0, won't that request remain unserviced until the sec=
ondary
vCPU enters vcpu_enter_guest(), leaving ka->use_master_clock and the
masterclock state stale for host-side KVM_GET_CLOCK / KVM_GET_CLOCK_GUEST /
KVM_SET_CLOCK_GUEST calls and delaying KVM_REQ_CLOCK_UPDATE for already
running sibling vCPUs?

> @@ -10106,16 +10133,41 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned =
long type)
>  	 * returns early =E2=80=94 is still eligible for PVCLOCK_TSC_STABLE_BIT.
>  	 */
>  	kvm->arch.all_vcpus_matched_tsc =3D true;
> +	kvm->arch.cur_tsc_scaling_ratio =3D kvm_caps.default_tsc_scaling_ratio;
> +	kvm->arch.cur_tsc_khz =3D kvm->arch.default_tsc_khz;
> =20
>  	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
> +
> +	/*
> +	 * Establish the initial TSC generation for synchronization logic.
> +	 * The first vCPU will sync to this, starting its guest TSC at the
> +	 * number of cycles elapsed since VM creation rather than at zero.
> +	 * This ensures coherence with the kvmclock epoch (also set here),
> +	 * and the master clock snapshot taken below is immediately valid.
> +	 * It is refreshed again when the first vCPU is created, in case
> +	 * the host clocksource changed (and changed back) in between:
> +	 * pvclock_gtod_update_fn() does not notify a VM with no vCPUs.
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

[Severity: Medium]
Now that cur_tsc_khz and cur_tsc_generation are initialized from
kvm_arch_init_vm() with all_vcpus_matched_freq =3D true and
all_vcpus_matched_tsc =3D true, does the initial kvm_set_tsc_khz() call in
kvm_arch_vcpu_create() corrupt frequency and TSC matching when userspace us=
es
per-vCPU KVM_SET_TSC_KHZ?

In kvm_vm_ioctl_create_vcpu(), kvm_arch_vcpu_create() runs before
atomic_inc(&kvm->online_vcpus):

	kvm_arch_vcpu_create(vcpu)
		kvm_set_tsc_khz(vcpu, vcpu->kvm->arch.default_tsc_khz)
			set_tsc_khz(vcpu, user_tsc_khz, false)
				kvm_synchronize_tsc(vcpu, NULL, false)

Consider creating vCPU 0 and setting its frequency to F !=3D default_tsc_kh=
z via
the vCPU-scoped KVM_SET_TSC_KHZ ioctl (so cur_tsc_khz =3D F,
cur_tsc_freq_generation =3D 1, and nr_vcpus_matched_freq =3D 1), and then c=
reating
vCPU 1:

1. In kvm_arch_vcpu_create(vcpu 1), kvm_set_tsc_khz() syncs vCPU 1 at
   default_tsc_khz while online_vcpus is still 1. Because default_tsc_khz !=
=3D F,
   __kvm_synchronize_tsc() increments cur_tsc_freq_generation to 2, clears
   all_vcpus_matched_freq, sets nr_vcpus_matched_freq =3D 1, and overwrites
   cur_tsc_khz =3D default_tsc_khz.

2. Immediately afterwards, kvm_track_tsc_matching() reads online =3D 1, sees
   nr_vcpus_matched_freq (1) >=3D online (1), and sets
   ka->all_vcpus_matched_freq =3D true.

3. After online_vcpus is incremented to 2, kvm_arch_vcpu_postcreate(vcpu 1)
   calls kvm_synchronize_tsc(vcpu 1, NULL, false). Because vCPU 1's
   virtual_tsc_khz already matches cur_tsc_khz (default_tsc_khz),
   __kvm_synchronize_tsc() does not clear all_vcpus_matched_freq.

If vCPU 1 is left at default_tsc_khz, all_vcpus_matched_freq remains true e=
ven
though vCPU 0 is at F and vCPU 1 is at default_tsc_khz. Conversely, if
userspace then sets vCPU 1's frequency to F via KVM_SET_TSC_KHZ, the
intermediate sync at default_tsc_khz has already bumped
cur_tsc_freq_generation and cur_tsc_generation, so setting vCPU 1 to F bumps
both generations again with nr_vcpus_matched_freq =3D 1 and
nr_vcpus_matched_tsc =3D 1 (for 2 online vCPUs), leaving all_vcpus_matched_=
freq
and all_vcpus_matched_tsc permanently false even though both vCPUs are
configured to F.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105154955.2525=
419-1-dwmw2@infradead.org?part=3D11
