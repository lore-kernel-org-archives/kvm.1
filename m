Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189209;
	b=s55qRn3PKqtXDtGV7lidKKSNxj6GTiWKaDPcvBVFemXlnGkaiD1k5TvIse5kB3y7eDA2
	 5PV9ctwTlmXgMK+7bRBTgsEs7ysAog7iXfmXkpHwB3RHHERmBtIVQmDxiV0POfdTbzZU2
	 lLW41LWAJ8WyQg2rRkli5R+XlWljZiu3IyPLzS0RzUkGNEQgZp9uKCF0lTo4f/hAb1+rF
	 14rR6QCDNFAaCFp60n6tIaGAMMnKMsXmonrw8LC9YQeGPk59v9OtPRiF2AlvTwZok9N42
	 P1ssNBE8ostlqmHUlZ+z8MrqQq33Zksiy2Dq2D8yjx8WPdyh+C0YhMHs5+Llv7fETXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189209;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IKSg3hB6Ci41Mbma5iTt2mrBf54vRce1X4jX6LGtk0U=;
	b=nb+kfB0JXhPGlLytWHeNZeRdE52HlcK8Xr+61qsYJ/eU5midUsBw6D3qZR9OkHyL0vpP
	 r64xhMLezpVVgNyMc7G2ZVdyhh1LCZPPXOY5eiVpxJ9Bnw7hWO83LmNqvNFfHWohwryzq
	 oVvmpb+N7pIoM9RUk1XG6AGUKDGoeyxp0Hmcolt/clGGR2IrS/GvTFzEqgBatefOAdo+p
	 nnFTp/JWqBnWg7xUWX4PaBjn9isx1hlEmSDPD7gY7uZOd7ZurNfVUR3Vzj0oZJyOr/Ng8
	 bYZ3Xk4mIzptwfwU7b7shAMQDO6mP2MtdrSfOE3T3cY0iydaL423uLM+C2vg/jmmimg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Af2RptFP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BC9606A320
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 01:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Af2RptFP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBC81F008A1;
	Mon,  9 Nov 2026 01:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794189208;
	bh=IKSg3hB6Ci41Mbma5iTt2mrBf54vRce1X4jX6LGtk0U=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Af2RptFPej9uT6AdNWvIv0Gyyz3ssgrr6zChCBUPvriMe/yl7JwPkBvQYs1M/oEmg
	 5yLTT2zesM4VyxWojk5s/vOWU7y+KG9g7GfN/nf35i7/bWs2uM25nRKRTw6PCtQu2Z
	 i8Cf1tLm9WBtYm9YSXo777zW685w39wWgE3nYyRaF7FkCYTD+eZyu+6JAzanacXce2
	 P8rzptwW1mF6ijAKDoafRxzFK14J3wMycdDUgnDm1UILImPM4WDmGPa3ANyudDZEaQ
	 uucvKzRM12DEION5lfY3Fd63jiYRfP0OMfYIuHH5H9/gJe4bIZbT5f8v+w+BZct8Fe
	 m8FosBUSYyPEw==
Message-ID: <sashiko-outbox-204331@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 03/24] KVM: x86: Replace nr_vcpus_matched_tsc count
 with all_vcpus_matched_tsc bool
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261109012112.3415328-4-dwmw2@infradead.org>
References: <20261109012112.3415328-1-dwmw2@infradead.org>
 <20261109012112.3415328-4-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 01:53:28 +0000
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
- [Medium] KVM: x86: incomplete TSC match invalidation in
  kvm_arch_vcpu_postcreate()
- [Medium] KVM: x86: stale cur_tsc_scaling_ratio for scaled
  protected-TSC guests
--

commit 496cc2fbe510de0a04aff77a0441a50fcb8f4d44
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Replace nr_vcpus_matched_tsc count with all_vcpus_matched_tsc bool

This commit replaces the read-time comparison of nr_vcpus_matched_tsc
against kvm->online_vcpus with a cached all_vcpus_matched_tsc boolean
updated under tsc_write_lock and initialized to true at VM creation.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 20b84b2e44243..d29e5bc75f7a5 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -9552,8 +9554,23 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
> =20
>  void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  {
> -	if (mutex_lock_killable(&vcpu->mutex))
> +	if (mutex_lock_killable(&vcpu->mutex)) {
> +		/*
> +		 * The new vCPU is already counted in online_vcpus but has
> +		 * not been synchronized. Nothing recomputes the cached
> +		 * matched state against the raised count until the next
> +		 * synchronization, so clear it here rather than leave the
> +		 * clock advertised as matched while an unmatched vCPU is
> +		 * runnable. It heals when this vCPU first synchronizes.
> +		 */
> +		struct kvm_arch *ka =3D &vcpu->kvm->arch;
> +		unsigned long flags;
> +
> +		raw_spin_lock_irqsave(&ka->tsc_write_lock, flags);
> +		WRITE_ONCE(ka->all_vcpus_matched_tsc, false);
> +		raw_spin_unlock_irqrestore(&ka->tsc_write_lock, flags);
>  		return;
> +	}

[Severity: Medium]
Does clearing ka->all_vcpus_matched_tsc here without calling
kvm_update_masterclock() leave ka->use_master_clock stale?

ka->all_vcpus_matched_tsc is consumed by pvclock_update_vm_gtod_copy(), so
returning without triggering a masterclock update leaves
ka->use_master_clock enabled (initially set in kvm_arch_init_vm()) and does
not request KVM_REQ_CLOCK_UPDATE on existing vCPUs.  Even after commit "KVM:
x86: Allow KVM master clock mode when TSCs are offset from each other"
checks ka->all_vcpus_matched_tsc in kvm_guest_time_update() and clears
ka->all_vcpus_matched_freq here, ka->use_master_clock remains true and
KVM_GET_CLOCK still reports KVM_CLOCK_TSC_STABLE.

Also, __kvm_synchronize_tsc() returns early when
vcpu->arch.guest_tsc_protected is true, and KVM_RUN does not call
kvm_synchronize_tsc(), so clearing the flag on this path will not heal for
protected-TSC guests or on normal vCPU entry; conversely, if the thread
holding vcpu->mutex already synchronized the vCPU via a host-initiated TSC
write, this error path overwrites the matched state back to false.

>  	vcpu_load(vcpu);
>  	kvm_synchronize_tsc(vcpu, NULL);
>  	if (kvm_check_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu))
> @@ -10029,6 +10046,20 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned l=
ong type)
>  	ratelimit_set_flags(&kvm->arch.kvmclock_update_rs, RATELIMIT_MSG_ON_REL=
EASE);
>  	kvm->arch.kvmclock_offset =3D -get_kvmclock_base_ns();
> =20
> +	/*
> +	 * Start with all (zero) vCPUs considered matched, so that a VM whose
> +	 * vCPUs never reach kvm_track_tsc_matching() =E2=80=94 notably when th=
e guest
> +	 * TSC is protected (TDX, SNP Secure TSC) and __kvm_synchronize_tsc()
> +	 * returns early =E2=80=94 is still eligible for PVCLOCK_TSC_STABLE_BIT=
. The
> +	 * scaling ratio must then also be initialized: with vcpus_matched
> +	 * now true here, pvclock_update_vm_gtod_copy() reaches the scaling
> +	 * path, and a zero ratio would zero tsc_hz and turn the master
> +	 * clock straight back off (permanently so for protected-TSC guests,
> +	 * which never write the ratio in __kvm_synchronize_tsc()).
> +	 */
> +	kvm->arch.all_vcpus_matched_tsc =3D true;
> +	kvm->arch.cur_tsc_scaling_ratio =3D kvm_caps.default_tsc_scaling_ratio;
> +
>  	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
>  	pvclock_update_vm_gtod_copy(kvm);
>  	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);

[Severity: Medium]
Does initializing kvm->arch.cur_tsc_scaling_ratio to
kvm_caps.default_tsc_scaling_ratio here leave the masterclock unscaled for
protected-TSC guests configured with a scaled TSC frequency?

Protected-TSC guests configure their TSC frequency before vCPU creation via
the VM-level KVM_SET_TSC_KHZ ioctl, which only updates
kvm->arch.default_tsc_khz.  When kvm_arch_vcpu_create() later calls
kvm_set_tsc_khz(), the scaled ratio is stored in
vcpu->arch.l1_tsc_scaling_ratio, but __kvm_synchronize_tsc() returns early
on vcpu->arch.guest_tsc_protected before copying l1_tsc_scaling_ratio into
kvm->arch.cur_tsc_scaling_ratio or requesting KVM_REQ_MASTERCLOCK_UPDATE:

arch/x86/kvm/x86.c:__kvm_synchronize_tsc() {
	if (vcpu->arch.guest_tsc_protected)
		return;
...
	kvm->arch.cur_tsc_khz =3D vcpu->arch.virtual_tsc_khz;
	kvm->arch.cur_tsc_scaling_ratio =3D vcpu->arch.l1_tsc_scaling_ratio;
}

As a result, kvm->arch.master_tsc_scaling_ratio, master_tsc_shift, and
master_tsc_mul remain computed for the 1:1 host TSC frequency, so
__get_kvmclock_master_clock() (and KVM_GET_CLOCK_GUEST in commit "KVM: x86:
Add KVM_[GS]ET_CLOCK_GUEST for accurate KVM clock migration") computes
kvmclock with unscaled host parameters that drift from the scaled pvclock
time info exposed to the guest.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109012112.3415=
328-1-dwmw2@infradead.org?part=3D3
