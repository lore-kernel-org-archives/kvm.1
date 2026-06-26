Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3F42EEE65
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485627; cv=none; b=N1sHo9wzxB4C2TSkPwBSyOzNt+yqVRBdWlC6ONqfNyk251S9VsKJRHDw2rjw4s0A/P15EFusJLGhcWySn6+xf/B6cYC9g8YB8mWP5Ysr7om8eLMeT/hxItpAhZ+T9KDPGkd4Y7mpGFJbE6BZTp0iZ/R9mf+xcy/tRmI9+8ERyZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485627; c=relaxed/simple;
	bh=ACURjVc4GwHsF4S1+yjPVRxbz6jJtk/aisM8jHpP5gQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X0Y2sgFDiSa9kX27HVdAM9bi+EjbUwSB/X2Q/EPMLLQN+Fgzc+mSN17eA0zAIA/eHPonX8PcRdXjMjzhYI1nDvnkjZvnqkZAj6OWSCxxbxrYQyeINfPKOmK+IiXVO+GhVes+N/67Pjx7ltbB7s4KnM6fbP+L966x1b4NOTQfb50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0raK/Jp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0raK/Jp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223E61F00A3D;
	Fri, 26 Jun 2026 14:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782485626;
	bh=wpfCuK7N5bKAhr3jyM6cWPXXUQ2TTl1xSU29IPv+jvc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F0raK/Jp7l2MxQYXxQ9aPyXo0FxuRuckdmP8kreSVzt6gLZvqZ0Jt0YgpfNXxFUQA
	 1cvCtb7TwBeXzSb5yavjJTZMjLqkkzfCvPDwfxd8q6xWYWKMZm+rKwCNmyw8UEohdJ
	 ewPxt9F8A8jA8gZG3/XMuwkNCMV5FcqHDB4as1cAn01h0UuuWsAeruCI5ou1j5vUSe
	 O2+zAdfxonTkY75hCt98VQN2Cga0EJJpWPR6dd9egiq/dcprxdsn7CQFm7MMdbpd0c
	 0Q4D/B9FqT3Wae//aTbtz4B5MmvZdCoogpa5CUoSrgLj97cyKCgCUTRy0+lrOn5vZm
	 P2sKdchRGW+5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.10.y 17/17] KVM: x86/mmu: Ensure hugepage is in by
 slot before checking max mapping level
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626112634.1778506-18-pbonzini@redhat.com>
References: <20260626112634.1778506-1-pbonzini@redhat.com>
 <20260626112634.1778506-18-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:53:45 +0000
Message-Id: <20260626145346.223E61F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The patch backports a fix for an out-of-bounds array access to a=
 kernel version where the buggy function does not exist, introducing dead l=
ogic.

Pre-existing issues:
- [Critical] KVM flushes the wrong GFN when zapping SPTEs, leaving stale EP=
T/TLB entries for the actual guest memory.
--

commit 1fc28b2436d7c174304f3fc391cd3180566514b7
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping lev=
el

This patch adds a bounds check to verify that a shadow page's base GFN is
within the target memslot when checking for collapsible SPTEs. This is inte=
nded
to prevent out-of-bounds accesses to the slot's lpage_info during hugepage
recovery.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 39186d6952696..b7e8618d3df52 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5659,13 +5659,20 @@ static bool kvm_mmu_zap_collapsible_spte(struct k=
vm *kvm,
>  		pfn =3D spte_to_pfn(*sptep);
> =20
>  		/*
> -		 * We cannot do huge page mapping for indirect shadow pages,
[ ... ]
> +		 * Direct shadow page can be replaced by a hugepage if the host
> +		 * mapping level allows it and the memslot maps all of the host
> +		 * hugepage.  Note!  If the memslot maps only part of the
> +		 * hugepage, sp->gfn may be below slot->base_gfn, and querying
> +		 * the max mapping level would cause an out-of-bounds lpage_info
> +		 * access.  So the gfn bounds check *must* be done first.
> +		 *
> +		 * Indirect shadow pages are created when the guest page tables
> +		 * are using 4K pages.  Since the host mapping is always
> +		 * constrained by the page size in the guest, indirect shadow
> +		 * pages are never collapsible.
>  		 */
> -		if (sp->role.direct && !kvm_is_reserved_pfn(pfn) &&
> +		if (sp->role.direct && is_gfn_in_memslot(slot, sp->gfn) &&
> +		    !kvm_is_reserved_pfn(pfn) &&
> +		    (kvm_is_zone_device_pfn(pfn) ||
> +		     PageCompound(pfn_to_page(pfn)))) {
>  			pte_list_remove(rmap_head, sptep);

[Severity: Medium]
The commit message mentions that querying the max mapping level causes an
out-of-bounds lpage_info access, but looking at kvm_mmu_zap_collapsible_spt=
e()
in this kernel version, neither kvm_mmu_max_mapping_level() nor lpage_info =
are
accessed here.

Does this added check just prevent KVM from collapsing 4KB pages into a 2MB
hugepage if the 2MB region crosses the memslot boundary, without actually f=
ixing
an out-of-bounds access in this code path?

[Severity: Critical]
This is a pre-existing issue, but does this code flush the correct GFN?

In kvm_mmu_zap_collapsible_spte(), just below this change, the flush uses
sp->gfn:

			if (kvm_available_flush_tlb_with_range())
				kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
					KVM_PAGES_PER_HPAGE(sp->role.level));

sp->gfn is the base GFN of the shadow page, not the actual data page GFN ma=
pped
by the zapped SPTE. If KVM_PAGES_PER_HPAGE(sp->role.level) is 1 (for a leve=
l-1
shadow page), wouldn't this flush only the base GFN and leave stale TLB ent=
ries
for the actual guest memory?

(Similar pre-existing issues appear to exist in rmap_recycle() and
FNAME(sync_page)() which also flush sp->gfn instead of the actual data page=
 GFN.)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626112634.1778=
506-1-pbonzini@redhat.com?part=3D17
