Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F7E253958
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782478643; cv=none; b=WsXVGe/AUpOXwy6T4Kwwf9KmrvdK/C/HZwaL+CNtN5ESW3kkZfjMF6jGFU4hiQWc1vWu+t6P5EsQPtNfSdoop53Y3SdHV1i9XSpVTkEYyOm9jn6dK0NTnF/BbXzsaoxx/sMIm/rymAnjnNMjULhDC16ico5/y6A8p8Y3qF53IlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782478643; c=relaxed/simple;
	bh=J4OJyfWdGUdxvQateK5fktqc0zsIXkLYWgjJLeyGN4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jVuYy2U2ZnRNl+z3q5AiidbHQJiWPSzXkrT5+k3An7EQeg8p5gIY42X44rNmVeQJm6H4r8kk+G/2C/bHNzQRT+tqDVpkAkEyeYTX2aI1UwADvO26orfftgTHi49iFuSG8P9T/fcxP3tkRbaTxdxWjkW4/KntDP8wXRejLnqWVik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvVGT0Uw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvVGT0Uw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812201F000E9;
	Fri, 26 Jun 2026 12:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782478642;
	bh=KztJzRKLR++EUQFynaFD85LuTG775fmEb0h4eckAXSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GvVGT0UwR2hD3qIFqs/Z1ZLewrDItrvuQ/l75V8+MNO0qJr1vAqkkG1Vi6Dfs9v4W
	 37keykHKsmO2EQohhsVDY7/xjLrhln7bDFtnBsLSjwFYX7gVkQ74na4f5QlVTG2uZe
	 6MtWhNVES1V5nusKWqB5xlBij4btBTWZnb5gI/5l4ceuQOz9B9iinF3xdXHndqm9J+
	 J+SQ6SI8czVyBN+s3A5v8J8i0CEWI/TonM8xuGLJgRQHm2LNWyRf80fVfPcXUa5cvc
	 O3z0qnYO5dyrQvDcjmetBe4eAXTLnDgwKQd2WrhOkJg151MaOn4EJ0iP+PMOw58SxL
	 BXlJHCAsD1rfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y 8/8] KVM: x86/mmu: Ensure hugepage is in by slot
 before checking max mapping level
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626112606.1778248-9-pbonzini@redhat.com>
References: <20260626112606.1778248-1-pbonzini@redhat.com>
 <20260626112606.1778248-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:57:22 +0000
Message-Id: <20260626125722.812201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The patch accidentally removes the `!kvm_is_reserved_pfn(pfn)`=
 check while adding the `is_gfn_in_memslot(slot, sp->gfn)` bounds check. Th=
is allows reserved PFNs (e.g., from VM_PFNMAP device memory mappings) to be=
 processed for hugepage collapsing, resulting in a host kernel panic.
--

commit 2d19b4db9edc2ca668a2a822466a8d07744d71f3
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping lev=
el

This patch adds a bounds check in the shadow MMU to verify the base gfn of
a shadow page is within the target memslot before querying the max mapping
level. This prevents out-of-bounds access to the slot's lpage_info when
guest hugepage mappings extend below the bounds of a memslot.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index e9dbe3e7ec622..9a3020648c8be 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
[ ... ]
> @@ -5883,13 +5883,19 @@ static bool kvm_mmu_zap_collapsible_spte(struct k=
vm *kvm,
[ ... ]
> -		if (sp->role.direct && !kvm_is_reserved_pfn(pfn) &&
> +		if (sp->role.direct && is_gfn_in_memslot(slot, sp->gfn) &&
>  		    sp->role.level < kvm_mmu_max_mapping_level(kvm, slot, sp->gfn,
>  							       pfn, PG_LEVEL_NUM)) {

[Severity: Critical]
Does this code accidentally drop the check for reserved PFNs?

If a memslot maps device memory (VM_PFNMAP), the SPTE contains a reserved
PFN with no backing struct page. Since the !kvm_is_reserved_pfn(pfn) check
was removed, this loop can now pass these reserved PFNs down into
kvm_mmu_max_mapping_level(), which takes the following path:

kvm_mmu_zap_collapsible_spte()
  kvm_mmu_max_mapping_level()
    host_pfn_mapping_level()

Inside host_pfn_mapping_level(), the code executes:

    if (!PageCompound(pfn_to_page(pfn)) && !kvm_is_zone_device_pfn(pfn))

Could calling pfn_to_page() on a reserved PFN here result in dereferencing
an unmapped vmemmap pointer, causing a host kernel panic?

>  			pte_list_remove(kvm, rmap_head, sptep);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626112606.1778=
248-1-pbonzini@redhat.com?part=3D8
