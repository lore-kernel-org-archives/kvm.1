Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768B63F484E
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476804; cv=none; b=j2+w3LopwTQGDKCel86T8qbhPCQBoVtC6iThfjerOVxqNQfsDf4toZW5nqMC+WUnHPPsoEkJDPD3zVvPQSbJ96zhUV+BSMw8ltb7Ml2WR7lNPO4lILctbamePggrH8eE04IwIR2UTBlXX3H0oUm23g9bt0VCgH73ruJzaik1VeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476804; c=relaxed/simple;
	bh=Vk0WiV0sz49WlfIpLKOTpBS51K/SM+9Qi6j8USZ1iMQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m4rDSd6azB1PcRzdzJWqDd3F8musilhCODyL/7klbZqytYHl8/IiWckFhiLDdyjW1XHg8fMOf1YPKput0oH9VMklQcb8bsM5Ys+WDXqGb8+6VDOEZNGQYscTX9YJWjtAmJT+pkyWpdlEhCLlh3w6A90OyrzLdSdMq1ZgcjQctI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPrbRz/F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPrbRz/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68001F000E9;
	Fri, 26 Jun 2026 12:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782476803;
	bh=u/J/MSWyFEIa1fu3JMdjpI5N/IMlgpka0uozHyNrs+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VPrbRz/FpurnddTzFstxzoNnaoQ0axrfZKXcmoC5qWWIoObx5EQqmEItGhgTN+FwY
	 xVxeucvgYnMx+WED1BWFHABuamUWsANIIPcXI4ao1nAWTxgcQI2qJU+6I1SSIAYcb2
	 boPif8KjczHEREof6gvOL1AfY7XDE+sgdPku0QAFbWNVLlzohEPkbxXiCKDR56R7/P
	 QkeAcNoga3Yg6Zt2YRrcjL64mBFwfQ6shc6Ggj7BziPNnrgJi40LdhQm7/7AlBClrR
	 sdKss8b3G0xNyUkaheXVWiZ3JRwZAH+1MD3QJWxLE7gDP0EnUy9yKjPy2gOv5SfW14
	 Jz6O7LyzpRwgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.10.y 04/17] KVM: x86/mmu: Ensure MMU pages are
 available when allocating roots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626112634.1778506-5-pbonzini@redhat.com>
References: <20260626112634.1778506-1-pbonzini@redhat.com>
 <20260626112634.1778506-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:26:41 +0000
Message-Id: <20260626122642.D68001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch introduces a sleep-in-atomic bug by holding `mmu_lock` (=
a spinlock) while reading guest PDPTRs, which can sleep.
--

commit 2d0be26b413397b6f1a85adc0319fa2727427ab6
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/mmu: Ensure MMU pages are available when allocating roots

This patch modifies the root allocation flow to hold the mmu_lock for write
for the entire duration of allocating and initializing an MMU's roots. This
prevents root allocations from failing by ensuring MMU pages are available.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index a506c0818e77a..9b1f63b5e86ec 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c

[ ... ]

> @@ -3315,6 +3306,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *=
vcpu)
> =20
>  	for (i =3D 0; i < 4; ++i) {
>  		MMU_WARN_ON(VALID_PAGE(mmu->pae_root[i]));
> +
>  		if (mmu->root_level =3D=3D PT32E_ROOT_LEVEL) {
>  			pdptr =3D mmu->get_pdptr(vcpu, i);

[Severity: High]
Does this code sleep while holding a spinlock?

Since kvm_mmu_load() now holds vcpu->kvm->mmu_lock when calling
mmu_alloc_shadow_roots(), this ends up calling mmu->get_pdptr()
under a spinlock.

On SVM, this resolves to kvm_pdptr_read(), which can sleep:

arch/x86/kvm/kvm_cache_regs.h:kvm_pdptr_read() {
    might_sleep();
    ...
}

Could this lead to a "scheduling while atomic" panic?

>  			if (!(pdptr & PT_PRESENT_MASK)) {

[ ... ]

> @@ -4872,7 +4854,15 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
>  	r =3D mmu_alloc_special_roots(vcpu);
>  	if (r)
>  		goto out;
> -	r =3D mmu_alloc_roots(vcpu);
> +	spin_lock(&vcpu->kvm->mmu_lock);
> +	if (make_mmu_pages_available(vcpu))
> +		r =3D -ENOSPC;
> +	else if (vcpu->arch.mmu->direct_map)
> +		r =3D mmu_alloc_direct_roots(vcpu);
> +	else
> +		r =3D mmu_alloc_shadow_roots(vcpu);
> +	spin_unlock(&vcpu->kvm->mmu_lock);
> +
>  	kvm_mmu_sync_roots(vcpu);
>  	if (r)
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626112634.1778=
506-1-pbonzini@redhat.com?part=3D4
