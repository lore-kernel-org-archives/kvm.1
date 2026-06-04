Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1853323A562
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584771; cv=none; b=tDgym9Gjww5SmKVmBopkCXI7HhEMmBxxPDKklOCKdaqChe672kmgJsCAStmw+7DyvzqpcJ+Kg3miXRFEcxlO10SuH7L3/hZB9IMN4z/lg7oxqm1/+teizINDbBwZ5ZMyfzWwfv2FeslqR49qSCwKGFM7nmphcDOSVXX3XanSBL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584771; c=relaxed/simple;
	bh=p+01FXerTYAuHMsyxBXsuo3iLlNoew97g8w6nXY0iuo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JmO29nf0UC+OxvjhGrNyXsAq/yT3+Qrm3Fx0Wxm+AXHEdTi60JkvlkcPAGX6f1CWCAhj79nDuoY2Dwl2xhaf1Lp1h26tWJA6vXbHLsMeewU3je39dp+WlsEj4HHtGtRuT8lDWS3KugyUqb9x2J8fzVZJRUwKrPwNudxFurnZ4Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbYj8SKp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbYj8SKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EDC1F00893;
	Thu,  4 Jun 2026 14:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780584769;
	bh=0wKG1FUWP1/KOA2bZtZ4IZOVHO0hCNC4CwXEkzAZ2TM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dbYj8SKprmTtq7NknjYXuY7DlgHFRz9AZtSU7lSK9mEJ3ERMC8ZtjMFtNZP8mFWpE
	 RzoAsR7gRGGGyAzmDd8iXmpFF2oZvBXohn4qfVLlEjC2vA0OrQ8lJhdg/CPB/znXFQ
	 bR406uMIhF2YzEqciUHtpZBRhikBec75Uv6+5NhkEel67YF88phpAGDFIMcOi60aCH
	 27IEKd/aCLVjfWoGfmqu9owfsZp+brbgOzJtWCRlo9hWOhnv9L4eLoBZyjtheB8RUE
	 X+cj/Ez11T3iHRZUAlv9IX/yL61kUn1LsTa8IFCN7oT3aIVS/4MZRPp4itLu5u3PjL
	 /z3Q45rByENUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] KVM: riscv: Check hugetlb block mappings against
 memslot bounds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinyu Tang" <tjytimi@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604142602.3582602-2-tjytimi@163.com>
References: <20260604142602.3582602-2-tjytimi@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 14:52:49 +0000
Message-Id: <20260604145249.81EDC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Duplicate case value in `hugetlb_mapping_size` switch statement bre=
aks compilation on 32-bit RISC-V.

Pre-existing issues:
- [Critical] Missing dirty page tracking for writes to huge pages when KVM =
dirty ring is enabled.
- [High] Infinite page fault loop during THP stage-2 mapping update when a =
4KB mapping already exists.
--

commit 1677f7a5702904834be9a413dad018d5713ace8a
Author: Jinyu Tang <tjytimi@163.com>

KVM: riscv: Check hugetlb block mappings against memslot bounds

This commit fixes an issue where KVM on RISC-V could install hugetlb block
mappings that exceed memslot boundaries or map the wrong host pages. It
introduces a helper to check mapping alignments and sizes, falling back to
smaller page sizes when necessary. It also prevents hugetlb mappings from
being incorrectly promoted back to huge pages by the THP path.

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 2d3def024270c..0adf017a2fa4a 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
[ ... ]
> @@ -404,7 +406,7 @@ static unsigned long transparent_hugepage_adjust(stru=
ct kvm *kvm,
>  	 * sure that the HVA and GPA are sufficiently aligned and that the
>  	 * block map is contained within the memslot.
>  	 */
> -	if (fault_supports_gstage_huge_mapping(memslot, hva)) {
> +	if (fault_supports_gstage_huge_mapping(memslot, hva, PMD_SIZE)) {
>  		int sz;
> =20
>  		sz =3D get_hva_mapping_size(kvm, hva);

[Severity: High]
This is a pre-existing issue, but does aligning the faulting gpa down to the
PMD boundary cause an infinite page fault loop if a 4KB mapping already
exists?

In transparent_hugepage_adjust(), the gpa is aligned down further along in
this block:
    *gpa &=3D PMD_MASK;

When this aligned gpa is passed to kvm_riscv_gstage_map_page(), the fast
path matches the aligned address:

arch/riscv/kvm/gstage.c:kvm_riscv_gstage_map_page() {
    ...
    } else if (ALIGN_DOWN(PFN_PHYS(pte_pfn(ptep_get(ptep))), page_size)
               =3D=3D hpa) {
        kvm_riscv_gstage_update_pte_prot(gstage, ptep_level, gpa,
                                         ptep, prot);
        return 0;
    }

This updates the protection of the 0th 4KB PTE in the 2MB block instead of
the actual faulting 4KB PTE at the unaligned offset. Does this leave the
faulting PTE unmodified, causing the guest to infinitely retry and hang the
vCPU?

[ ... ]
> @@ -421,12 +423,33 @@ static unsigned long transparent_hugepage_adjust(st=
ruct kvm *kvm,
>  	return PAGE_SIZE;
>  }
> =20
> +static unsigned long hugetlb_mapping_size(struct kvm_memory_slot *memslo=
t,
> +					  unsigned long hva,
> +					  unsigned long map_size)
> +{
> +	switch (map_size) {
> +	case PUD_SIZE:
> +		if (fault_supports_gstage_huge_mapping(memslot, hva, PUD_SIZE))
> +			return PUD_SIZE;
> +		fallthrough;
> +	case PMD_SIZE:

[Severity: Low]
Will this switch statement break the build on 32-bit RISC-V?

On 32-bit RISC-V, PMD is folded into PUD, which makes PUD_SIZE exactly equal
to PMD_SIZE (both are 4MB). Since C requires all case values in a switch
block to be unique constants, evaluating both macros without
#ifndef __PAGETABLE_PMD_FOLDED guards will trigger a duplicate case value
compiler error.

> +		if (fault_supports_gstage_huge_mapping(memslot, hva, PMD_SIZE))
> +			return PMD_SIZE;
> +		fallthrough;
> +	case PAGE_SIZE:
> +		return PAGE_SIZE;
> +	default:
> +		return map_size;
> +	}
> +}
[ ... ]
> @@ -511,8 +541,12 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct =
kvm_memory_slot *memslot,
>  	if (mmu_invalidate_retry(kvm, mmu_seq))
>  		goto out_unlock;
> =20
> -	/* Check if we are backed by a THP and thus use block mapping if possib=
le */
> -	if (!logging && (vma_pagesize =3D=3D PAGE_SIZE))
> +	/*
> +	 * Check if we are backed by a THP and thus use block mapping if
> +	 * possible. Hugetlb mappings already selected their target size above,
> +	 * so do not promote them through the THP helper.
> +	 */
> +	if (!logging && !is_hugetlb && vma_pagesize =3D=3D PAGE_SIZE)
>  		vma_pagesize =3D transparent_hugepage_adjust(kvm, memslot, hva, &hfn, =
&gpa);
> =20
>  	if (writable) {

[Severity: Critical]
This is a pre-existing issue, but does checking memslot->dirty_bitmap to
determine logging status miss dirty pages when the KVM dirty ring is enable=
d?

In kvm_riscv_mmu_map(), the logging flag is set like this:
    bool logging =3D (memslot->dirty_bitmap &&
                    !(memslot->flags & KVM_MEM_READONLY)) ? true : false;

If the dirty ring is used without a backup bitmap, memslot->dirty_bitmap
is NULL, making logging false. This allows transparent_hugepage_adjust()
to run and potentially install a writable huge page mapping.

If a fault occurs on a huge page, KVM maps the entire block as writable but
only logs the single faulting 4K gfn:

arch/riscv/kvm/mmu.c:kvm_riscv_mmu_map() {
    ...
    if (writable) {
        mark_page_dirty_in_slot(kvm, memslot, gfn);
        ret =3D kvm_riscv_gstage_map_page(..., vma_pagesize, ...);
    }
    ...
}

Would subsequent guest writes to any other pages in the 2MB block bypass the
dirty ring entirely since the hardware stage-2 PTE is already writable,
resulting in stale memory during live migration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604142602.3582=
602-1-tjytimi@163.com?part=3D1
