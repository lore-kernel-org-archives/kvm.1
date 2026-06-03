Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33723ACF1C
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485870; cv=none; b=b+u75NEPhC9X3P2p2+GvLMQR61hkpi6K4FlCTl6qcxIA+kr5VgPV4Rz7kGxfUKHnVasB7uOfqV9rYjwmG4KuWcB5pQfPwdYyfFn6fROE9t/ziBWi5H9a4oeWxbRJ/FIhE0IMI9yCLbq+Z0kVvBsKOm+FNcn+/d+Cse0dkOh4vfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485870; c=relaxed/simple;
	bh=rg3Qjejuq7wbZYFheU8RIBSJUbHNMZJKmxuqdTO7kaE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y+WajWl1uTbVNG4+5fZU3vhpUnNicOy9YCTTp4/9GoyG5xXobQ5v5WSTEUvFanzCwcW1FXeI9JfucRjSN6d8Dyw7DL9sEKsy3i6vDImNn1cQ8xttf1ZbyBYBvqcSUOIm56D5aUvEbrK693WfJcAc+/oaVYM+B8+LgdbLyOThKao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un+kLI8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un+kLI8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E35F1F00898;
	Wed,  3 Jun 2026 11:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780485869;
	bh=fG9p1QOc9s5+aUB7sQZgsD7e2VhdukutIzkoaKLEEMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Un+kLI8/3Us8VpJl65y4ViXt7HngG0iQ3EbsAHFXjWprFPQpM3mBnweoKTD1qiVxe
	 hlqQ48Nxu69dkx9IDvP1MhaCMTUis0p4LckSBQeYpH2hg7izmJAGM8KWCRib2/567h
	 W2tRGThGhFHk1UP74Y990eAtNxAQXy4CB3yVmlVYqt5KwIxKc2pShmCqhJzxUOFokb
	 D/moREP0R93LSk4aMZRtG/VAEpanlagmcS9tLLx2IrzI4Y2VhxE+pnnQwapeG6xUmf
	 VPXCApA+hbvtAZ5ZgD0/CFnUSxiewgIobWk/i6H1+BNqPGNTJ/4hJn2qRm0wCpCCoJ
	 W3t3a25VNC6iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/24] KVM: x86/mmu: make gva_walk a value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603105814.10236-19-pbonzini@redhat.com>
References: <20260603105814.10236-19-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 11:24:28 +0000
Message-Id: <20260603112429.6E35F1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Decoupling `gva_walk` into an embedded struct breaks pointer equal=
ity checks, classifying L1 shadow page faults as nested and completely bypa=
ssing TLB flushes and shadow page invalidations.
--

commit e0579a768a48ab33f8084b00e1f9e241b8879e43
Author: Paolo Bonzini <pbonzini@redhat.com>

    KVM: x86/mmu: make gva_walk a value

This commit changes gva_walk from a pointer to an embedded struct in
kvm_vcpu_arch. It aims to use a single instance of kvm_pagewalk for GVA
to GPA translations instead of flipping the gva_walk pointer back and
forth.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 386fdbc34b025..2fe4d53590064 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c

[ ... ]

> @@ -6598,17 +6588,22 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcp=
u, struct kvm_pagewalk *w,
>  	WARN_ON_ONCE(roots & ~KVM_MMU_ROOTS_ALL);
> =20
>  	/* It's actually a GPA for vcpu->arch.guest_mmu.  */
> -	if (w !=3D &vcpu->arch.guest_mmu.w) {
> +	if (w =3D=3D &vcpu->arch.gva_walk) {
>  		/* INVLPG on a non-canonical address is a NOP according to the SDM.  */
>  		if (is_noncanonical_invlpg_address(addr, vcpu))
>  			return;
> =20
>  		kvm_x86_call(flush_tlb_gva)(vcpu, addr);
> -		if (w =3D=3D &vcpu->arch.ngva_walk)
> +
> +		if (tdp_enabled)
>  			return;
> +
> +		mmu =3D &vcpu->arch.root_mmu;
> +	} else {
> +		mmu =3D &vcpu->arch.guest_mmu;
>  	}

[Severity: High]
If kvm_mmu_invalidate_addr() is called with w pointing to
&vcpu->arch.root_mmu.w, this pointer check will fail and fall through to the
else block, assigning mmu =3D &vcpu->arch.guest_mmu.

Since guest_mmu is inactive when not nested, mmu->sync_spte would be NULL,
causing an early return. Does this silently skip both the hardware TLB flush
and the root_mmu shadow page invalidation, potentially creating an infinite
page fault loop?

I noticed this behavior can be triggered due to the changes in paging_tmpl.h
and x86.c, which I've commented on below. I also see this is fixed later in
the series by commit 9a1a629159ef9003 ("KVM: x86/mmu: pull struct
kvm_pagewalk out of struct kvm_mmu"), but it seems this intermediate commit
breaks bisection.

> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index 6b21778e83404..b12c6b5e4a2fb 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h

[ ... ]

> @@ -541,7 +541,7 @@ static int FNAME(walk_addr_generic)(struct guest_walk=
er *walker,
>  	}
>  #endif
>  	walker->fault.address =3D addr;
> -	walker->fault.nested_page_fault =3D w !=3D vcpu->arch.gva_walk;
> +	walker->fault.nested_page_fault =3D w !=3D &vcpu->arch.gva_walk;

[Severity: High]
Does this break the pointer equality check for shadow paging?

When w points to &vcpu->arch.root_mmu.w (for L1 shadow page faults),
w !=3D &vcpu->arch.gva_walk will now evaluate to true since they are distin=
ct
struct instances in memory. Would this incorrectly flag L1 shadow page faul=
ts
as nested?

>  	walker->fault.async_page_fault =3D false;

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 147cef7b23b60..14af0f4d010ed 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -995,7 +995,7 @@ void kvm_inject_emulated_page_fault(struct kvm_vcpu *=
vcpu,
>  	WARN_ON_ONCE(fault->vector !=3D PF_VECTOR);
> =20
>  	fault_walk =3D fault->nested_page_fault ? &vcpu->arch.mmu->w :
> -						vcpu->arch.gva_walk;
> +						&vcpu->arch.gva_walk;

[Severity: High]
If nested_page_fault is incorrectly set to true by walk_addr_generic(),
doesn't this select &vcpu->arch.mmu->w instead of &vcpu->arch.gva_walk?

This results in kvm_mmu_invalidate_addr() being called with root_mmu.w,
leading to the skipped invalidation mentioned above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603105814.1023=
6-1-pbonzini@redhat.com?part=3D18
