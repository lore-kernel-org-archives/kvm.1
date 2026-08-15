Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0362931F1
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786790817; cv=none; b=iVEPuetOftltJRWqipVpSMtc/Pkx2oWFUBaTNZ6OPRD0rHIMe05iAKZCVpu4Sk4rt2/bxqhVrY34iPeI5/KXGeNDG06XaA0ZUZSYUzdMg2YxKOXmoTyyAX9remm/Nlf1LihenL7Af0Zh56rDiOM+kCQ27s2vd++rkbcwvRIcIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786790817; c=relaxed/simple;
	bh=q0mWBmciDLDn/DbyavIzG6BiGLXmbG05apcp1+eeYts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GU9v47cJPNzFHQXorcLl3/0vxtS+CGL/KxbgXGQP1JBES8ni51DBMeYF/2wZ42e+M28q4NTCXguTxmpRQqeHEeLjk6ASuCBWKA+WDpcyiy+OcnqZ8gSXGZk9YajdjpKks1WxBOj0kRN7Vz1N+XCBCoXG9to9MgW4FFAc3wNxtNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4pYe6lr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4pYe6lr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D091F000E9;
	Sat, 15 Aug 2026 10:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786790816;
	bh=52fhOS7UaUHZSs2npuzjbMkzO7satOKE/EEmOeYKfZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K4pYe6lr2YgdaDbn41WePNlTvlhEdG1p5BpkXzXIWmbTavVbMcozi7Pf+GEha/X59
	 AMWMrEJsxx4LjIfXmakrwFWehmt/C1bbN7Y3l4DDCzizpSRB379fNurKHivTpnwMaI
	 GEbrNODADqQhGa0gG3tnaBnJyU/1vhO02sXMAgiUrLAFFVvnSSVRmkTnHKQSzU5BaS
	 wr1ON0au73jFJmu2msgN3QvRpikQco7BjGTMCEQ5mXx5lHThpJUfb7AtPR6tasmafX
	 1idTCQFJ6kDRnV6jgBKKIpQHThbumZotW34FOMrimVnTp1e/ESszPLnRdTdyszGD/S
	 Hzu+R0zfKf63w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 RESEND 2/5] KVM: riscv: Avoid THP adjustment for
 existing 4K G-stage leaves
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinyu Tang" <jinyu.tang@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260815103245.864925-1-jinyu.tang@linux.dev>
References: <20260815102833.864330-1-jinyu.tang@linux.dev>
 <20260815103245.864925-1-jinyu.tang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 10:46:55 +0000
Message-Id: <20260815104656.21D091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch's fix for an infinite page fault livelock is incomplete.=
 It fails to detect a split THP when the specific faulting GPA lacks a vali=
d 4K leaf, leading to an incorrect PMD alignment and a continuing infinite =
loop.
--

--- Patch [2]: [PATCH v4 RESEND 2/5] KVM: riscv: Avoid THP adjustment for e=
xisting 4K G-stage leaves ---
commit e6651e4debdd3eb4a9adeb5c1e519831130009d2
Author: Jinyu Tang <jinyu.tang@linux.dev>
KVM: riscv: Avoid THP adjustment for existing 4K G-stage leaves

This commit attempts to fix a page fault handling issue where
transparent_hugepage_adjust() rewrites the fault GPA to the PMD base,
causing the wrong 4K leaf to be updated. It checks if the original fault
GPA already has a 4K G-stage leaf, and if so, skips THP adjustment.

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index bfd6168ebe308..2fabcd4099919 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
[ ... ]
> @@ -500,10 +500,21 @@ static int get_hva_mapping_size(struct kvm *kvm,
> =20
>  static unsigned long transparent_hugepage_adjust(struct kvm *kvm,
>  						 struct kvm_memory_slot *memslot,
> +						 struct kvm_gstage *gstage,
>  						 unsigned long hva,
>  						 kvm_pfn_t *hfnp, gpa_t *gpa)
>  {
>  	kvm_pfn_t hfn =3D *hfnp;
> +	u32 ptep_level;
> +	pte_t *ptep;
> +
> +	/*
> +	 * Keep the existing split G-stage leaf and update the original
> +	 * faulting 4K page in the vCPU fault path.
> +	 */
> +	if (kvm_riscv_gstage_get_leaf(gstage, *gpa, &ptep, &ptep_level) &&
> +	    !ptep_level)
> +		return PAGE_SIZE;

[Severity: High]
This is a pre-existing issue, but does the fix remain incomplete when the
specific faulting GPA lacks a valid 4K leaf?

If the guest accesses a 4K page within a THP-backed region during dirty
logging, it gets faulted in. If another page in that same split PMD directo=
ry
remains unmapped when dirty logging is disabled, what happens when the guest
eventually faults on the unmapped offset?

In that scenario, kvm_riscv_gstage_get_leaf() for the unmapped GPA returns
false. This allows transparent_hugepage_adjust() to fall through and align =
the
GPA to the PMD base.

When kvm_riscv_gstage_map_page() is subsequently called with the PMD-aligned
GPA and PMD_SIZE, it finds the existing 4K leaf at the PMD base. Because the
PFNs match, it updates the protection of the base leaf and returns success,
without mapping the originally faulting GPA or replacing the split table.

Can this result in an infinite page fault loop since the faulted page is
never actually mapped?

> =20
>  	/*
>  	 * Make sure the adjustment is done only for THP pages. Also make

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815102833.8643=
30-1-jinyu.tang@linux.dev?part=3D2
