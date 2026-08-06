Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54004A35
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983461; cv=none; b=AEnFn6aF9OfLy88fZdB45DOmIHuxZnv60qLMk3S5h4pXXFT1EnWu8GOc0ZFzYDjBsK+pr2NpN5vUI1W11kXUl8LH13CplYdOAluc2i9LeqXh22PMR2b/RD8iEH9FK9Lk+zBkOCMYj5UmH6ReG208SmZT8lRRAXCqU+x5fmDV8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983461; c=relaxed/simple;
	bh=tkbe/yUUqzRKpSmFlu+ZTAS4sYDyY4usbVHeMiB7AXM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tip8UYJuvUfFuBF9Oy/InN8PhiRA7VdxCwax0dtczoz4JWqvYE2KrhVbqaczfuZuPsqGD4amNzhTNXP0o1JUcfD+ZMZhHzA/bYUT89k7nApQh0CRdaBbQx4pJBDu8scUebiE/pAVotQbNzsdGoRnZhu72h2lDA079zM37NeVDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G11GmUYw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G11GmUYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F791F000E9;
	Thu,  6 Aug 2026 02:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785983460;
	bh=N1UXZtGOsEe5BH77RDrSpPKOsdEGaa+kSsl8wX12eM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G11GmUYwzj/CTM2kjA1YfMEUVdIWhM+rDvdiNK3xufKiQLbzn9qr1JNaI5pZfJd7s
	 omH3f7jeaKLQ6Caejq5leudSnc97fpOb266q+xyd4fQL9CJInFPBkZKQHzHMCH6e5I
	 oKPYMy+7T4D4aowUmAqXGoDwEHXcvR0mGz6FXhdehoCcKDnT4icEULZmBnTn7TgLiJ
	 SFFgJ4Tp5sfDdoMDKYQjFde9+h7uc7x+3IJK8eblM8wqEuSm22Tj+BQBadrb1gUfTQ
	 PKzbp/upuprZnSgWuPcrJbCWnhGWu7R7Gngh77N013sDsxhVRetPwceGzEwM+/jclY
	 NRPS3HbVBGOxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] LoongArch: KVM: Add separate vmid feature
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260806020739.2149268-4-maobibo@loongson.cn>
References: <20260806020739.2149268-1-maobibo@loongson.cn>
 <20260806020739.2149268-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 02:30:59 +0000
Message-Id: <20260806023100.61F791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The patch introduces `if (!cpu_has_guestid)` feature gates to =
bypass existing VPID and TLB flush mechanisms, but completely omits the alt=
ernative logic for when the feature is enabled, introducing severe latent v=
ulnerabilities (broken VM isolation, skipped TLB flushes).
--

--- Patch [3]: [PATCH v2 3/5] LoongArch: KVM: Add separate vmid feature sup=
port ---
commit 6bfee108dace797d9e6015bf026032adaef591e9
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Add separate vmid feature support

Feature cpu_has_guestid is used to check whether separate vmid/vpid
is supported or not. It is disabled by default, add this feature
checking, there is no function change.

> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index ac804e77e844f..c36e62ab0d917 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -218,7 +218,8 @@ static void kvm_update_vpid(struct kvm_vcpu *vcpu, in=
t cpu)
>  		++vpid; /* vpid 0 reserved for root */
> =20
>  		/* start new vpid cycle */
> -		kvm_flush_tlb_all();
> +		if (!cpu_has_guestid)
> +			kvm_flush_tlb_all();

[Severity: Critical]
If cpu_has_guestid is true, this skips the global TLB flush on VPID
wrap-around. Is there an alternative flush mechanism that should be
implemented here when the feature is enabled?

>  	}
> =20
>  	context->vpid_cache =3D vpid;
> @@ -282,10 +283,13 @@ static void __kvm_check_vmid(struct kvm_vcpu *vcpu)
>  {
>  	unsigned long vmid;
> =20
> -	vmid =3D vcpu->arch.vpid & vpid_mask;
> -	if (vcpu->arch.hw_vmid !=3D vmid) {
> -		vcpu->arch.hw_vmid =3D vcpu->arch.vpid & vpid_mask;
> -		kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
> +	/* On some machines like 3A5000, vmid needs the same with vpid */
> +	if (!cpu_has_guestid) {
> +		vmid =3D vcpu->arch.vpid & vpid_mask;
> +		if (vcpu->arch.hw_vmid !=3D vmid) {
> +			vcpu->arch.hw_vmid =3D vcpu->arch.vpid & vpid_mask;
> +			kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
> +		}
>  	}
>  }

[Severity: Critical]
When cpu_has_guestid is true, the hw_vmid update is skipped entirely without
alternative logic, leaving hw_vmid uninitialized (0).

When kvm_switch_to_guest() in arch/loongarch/kvm/switch.S loads hw_vmid into
the hardware Guest ID register (LOONGARCH_CSR_GTLBC), will all VMs share
VMID 0, breaking stage-2 VM isolation?

> diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
> index e104897aa5328..714640a2e6142 100644
> --- a/arch/loongarch/kvm/mmu.c
> +++ b/arch/loongarch/kvm/mmu.c
> @@ -929,8 +929,10 @@ int kvm_handle_mm_fault(struct kvm_vcpu *vcpu, unsig=
ned long gpa, bool write, in
>  		 *
>  		 * With SW PTW, invalid TLB is added in TLB refill exception.
>  		 */
> -		vcpu->arch.flush_gpa =3D gpa;
> -		kvm_make_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
> +		if (!cpu_has_guestid) {
> +			vcpu->arch.flush_gpa =3D gpa;
> +			kvm_make_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
> +		}
>  	}
> =20
>  	return 0;

[Severity: Critical]
Are we missing a TLB flush request for stale translation entries when
cpu_has_guestid is enabled?

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 20c207d80e31a..0b2355aec9322 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -210,7 +210,8 @@ static int kvm_check_requests(struct kvm_vcpu *vcpu)
>  		return RESUME_GUEST;
> =20
>  	if (kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu))
> -		vcpu->arch.vpid =3D 0;  /* Drop vpid for this vCPU */
> +		if (!cpu_has_guestid)
> +			vcpu->arch.vpid =3D 0;  /* Drop vpid for this vCPU */
> =20
>  	if (kvm_dirty_ring_check_request(vcpu))
>  		return RESUME_HOST;

[Severity: Critical]
This consumes the KVM_REQ_TLB_FLUSH request but skips dropping the VPID when
cpu_has_guestid is true. Could this effectively swallow the request without
performing the actual flush logic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806020739.2149=
268-1-maobibo@loongson.cn?part=3D3
