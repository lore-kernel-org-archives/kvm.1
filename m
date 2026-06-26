Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8633F4DFB
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476893; cv=none; b=cKtKyV5gXsoqclEnijHg+rA6+Hs5UCfG0dLg6AikHOcSWyDrKQoBaYlTl0TLC6TG1woJGL+aZB85kElMc1N/FEZhFRGY6Oo5apC2i/z1kylyYTBwegUDHZhtS91lcLrHPZF5hxnsaoP7I69SFymxp05o8C/boccnY4ouHxV4YsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476893; c=relaxed/simple;
	bh=no/wPJgtP6DbZQPWAjIf9H3kDQn9r/tDbohV0v6hrjY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C4wuRLJJTOCOF+sA/y6bsGVyrAC9WWJYDQ/++T0nSOuDED0eea2ZriwG5n8geT4r1Agxr3GTdxjs9wMpT0sbFdwx216MVulhXDuqIoagYm34nUPbzD1y5AufIoMx9gajHOymcH17qbq2fkSkTunx/GKPlb3bvpmHKI80N0NPkdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7Ks+voi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7Ks+voi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3284C1F000E9;
	Fri, 26 Jun 2026 12:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782476892;
	bh=XcsdblN8q6gUOWlYXWFShihXczvynERKHRxpaiiYcqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f7Ks+voiuUZT2SXMdvFQpmESN94kcF1D1oByMMro2laH2dwAEP2g4QzepCkZl7Jih
	 scD4U0lHl9D8G0elSI6DkrjjHLpLhjeqf29+EGMGnX3wHdsOHWWbMNYD5cp0xI65nm
	 ZJTRxnSjb0KUXx+vqs+NnohdgOgU+R0MnNpuPV5pVVdN3Ux5qtOxqKHiD+5UqMY6K2
	 E8gokUpB+13ipzJai4dJOTM7fMSBPuGYS1Hj6ZmGzmNV3slt/wuigeglSjXwVkymZk
	 qUNJ+O7Kctq0BfaaWM9TtjGOT5l2Ec3QivuP8m97dVMXHCJ/6lui7JPchtf7JlYnTW
	 5IbCc36DK9Qqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y 5/8] KVM: x86/mmu: pull call to drop_large_spte()
 into __link_shadow_page()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626112606.1778248-6-pbonzini@redhat.com>
References: <20260626112606.1778248-1-pbonzini@redhat.com>
 <20260626112606.1778248-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:28:11 +0000
Message-Id: <20260626122812.3284C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The newly introduced `__link_shadow_page` function declares a `cach=
e` parameter that is never used.

Pre-existing issues:
- [High] `drop_large_spte` flushes the wrong guest physical address range w=
hen dropping a large SPTE, potentially leaving stale hardware TLB entries f=
or the unmapped guest memory.
--

commit 9820244be6c2ac65ed2abfdc79a98053af6c7970
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86/mmu: pull call to drop_large_spte() into __link_shadow_page()

This patch consolidates the removal of existing large SPTEs by moving the
drop_large_spte() call from multiple caller sites directly into
__link_shadow_page(). It also updates kvm_mmu_get_child_sp() to return
-EEXIST if a non-large shadow page is already present, avoiding double
linking.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
[ ... ]
> -static void drop_large_spte(struct kvm_vcpu *vcpu, u64 *sptep)
> +static void drop_large_spte(struct kvm *kvm, u64 *sptep)
>  {
> -	if (__drop_large_spte(vcpu->kvm, sptep)) {
> -		struct kvm_mmu_page *sp =3D sptep_to_sp(sptep);
> +	struct kvm_mmu_page *sp;
> =20
> -		kvm_flush_remote_tlbs_with_address(vcpu->kvm, sp->gfn,
> +	sp =3D sptep_to_sp(sptep);
> +	WARN_ON(sp->role.level =3D=3D PG_LEVEL_4K);
> =20
> -	}
> +	drop_spte(kvm, sptep);
> +	kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
> +			KVM_PAGES_PER_HPAGE(sp->role.level));
>  }

[Severity: High]
This is a pre-existing issue, but does drop_large_spte() flush the wrong
guest physical address range here?

By using sp->gfn, the flush targets the base GFN of the entire parent page
table, or the guest page directory itself for indirect mappings.

If the dropped SPTE is at an index greater than 0, wouldn't this flush the
0th index instead of the actual memory mapped by the dropped SPTE?

Could this leave stale hardware TLB entries for the unmapped guest memory
on environments supporting precise range-based TLB flushes? Should this
retrieve the exact GFN using the offset of sptep within sp->spt instead?

[ ... ]
> -static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
> -			     struct kvm_mmu_page *sp)
> +static void __link_shadow_page(struct kvm_vcpu *vcpu,
> +			       struct kvm_mmu_memory_cache *cache, u64 *sptep,
> +			       struct kvm_mmu_page *sp)

[Severity: Low]
Is the new cache parameter actually used in this function?

It appears the cache parameter is passed in but never referenced. The
underlying code seems to use the cache from the vcpu struct directly
when adding a parent PTE.

Could this parameter be removed to keep the signature clean?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626112606.1778=
248-1-pbonzini@redhat.com?part=3D5
