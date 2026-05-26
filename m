Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B375B3B2D18
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806024; cv=none; b=X7eaQtv586bQQzjKwI1TuYf+4ohggJ57c2OQmbRIBJ7haivIPVSA914QebQ6SvY3nm2Ycc/OV5TjDKfpRlnvLoTlynXXr/xKvDONx5YggyYmeh4vPIVfQdiDbV+ye9coYifBlPFwDpFDS6/08StfXbAYFBuXH4jxfXQYZUqQHRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806024; c=relaxed/simple;
	bh=Qt2zS51RD3aBd6EEt5QFSj0qeN8yWEWttbJ/MAAlBvk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TCVfvW6afAFsXg+osda9SwxTc38qVsQcmPCbjKQROzMCvlSeUlmCg7vkq2rtXcwtaMt8D/XLmRY0A+KQgdXaYoO4RH8rVNTGeBs6D7WCyiujyWcpW5ud9tBv7VH/Yj/xSWM6odKjdBSuRHx84J53aAuMCLglbS0K1DVAd4VTaWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6kYCgGr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6kYCgGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D661F00A3A;
	Tue, 26 May 2026 14:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779806023;
	bh=7C36IAbN9iBb/4fzQo5ywpSq3rFh1m6L5HTe/kyO6Ss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a6kYCgGr/wvVvAwAPOaqFKZ2JHnCZU37lu3fdVB1O5apOX4xDWjt664TJeorwsgoV
	 EDoO6b08qKCXwCYx2Mp3oeSl7Ufj6EcEHowpF5j9U8nq1JcIluURAx/mmaLLlO63bJ
	 /e6w+AUJJ5VnM8SsiPSHhZ8+sEDrJ6+f6oiLffH2LVkCS3a5cgVifhgsR36ACEYADj
	 9j6YM5Bc8KsuE2otzg2lsSd+/4AxqwSIHgp3vLV4JOr+dVEwy1OBK/sn3Q4RXZl0Pv
	 rUQMzMcMBo59zVQtdGqXa7yG2FpBijuofMmMxTjo7HFVkwRymOzvKsAKiE3Noo7kVt
	 AM9qd0252ddWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/18] mm/userfaultfd: add RWP fault delivery and
 expose UFFDIO_REGISTER_MODE_RWP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526130509.2748441-14-kirill@shutemov.name>
References: <20260526130509.2748441-14-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 14:33:42 +0000
Message-Id: <20260526143342.C6D661F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The RWP marker (`PROT_NONE` with the `_PAGE_UFFD` bit) is phys=
ically indistinguishable from a UFFD-WP protected PTE that has been scanned=
 by NUMA balancing. This causes spurious RWP faults and infinite page fault=
 loops.
- [High] Orphaned RWP markers on hugetlb VMAs (e.g., remaining after fork) =
cause infinite page fault loops because fallback handlers cannot resolve PR=
OT_NONE PTEs.
--

commit a9cbf618ba30a3b9b6fa493754de9420693632a9
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP

Wire the fault side of read-write protection tracking and turn the
userspace interface on.

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 0d8d39cd88885..d4da39d698b82 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6062,6 +6062,17 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, str=
uct vm_area_struct *vma,
>  		goto out_mutex;
>  	}
> =20
> +	/*
> +	 * Protnone hugetlb PTEs with the uffd bit are used by
> +	 * userfaultfd RWP for access tracking. Plain PROT_NONE (without the
> +	 * marker) is not an RWP fault and is not expected on hugetlb (no
> +	 * NUMA hinting), so let normal hugetlb fault handling proceed.
> +	 */
> +	if (pte_protnone(vmf.orig_pte) && vma_is_accessible(vma) &&
> +	    userfaultfd_rwp(vma) && huge_pte_uffd(vmf.orig_pte)) {
> +		return hugetlb_handle_userfault(&vmf, mapping, VM_UFFD_RWP);
> +	}

[Severity: High]
Does this code handle orphaned RWP markers correctly after a fork?

When a process forks, dup_mmap() clears __VM_UFFD_FLAGS on the child VMA,
and the _PAGE_UFFD bit is stripped from the PTEs. The child receives plain
PROT_NONE PTEs instead of RWP markers.

Since hugetlb does not support NUMA hinting, hugetlb_fault() lacks the logic
to upgrade a PROT_NONE PTE back to the permissions in vma->vm_page_prot. It
simply updates the young/dirty flags and leaves the PTE as PROT_NONE. Could
this result in the child infinitely looping on page faults when trying to
access these orphaned pages?

> diff --git a/mm/memory.c b/mm/memory.c
> index 06473285c0dcc..111fdae141203 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6122,6 +6122,14 @@ static void numa_rebuild_large_mapping(struct vm_f=
ault *vmf, struct vm_area_stru
>  		if (!pte_present(ptent) || !pte_protnone(ptent))
>  			continue;
> =20
> +		/*
> +		 * RWP-armed PTEs are also protnone but carry _PAGE_UFFD as a
> +		 * marker. Leave them alone -- rewriting to vm_page_prot would
> +		 * stop the RWP trap.
> +		 */
> +		if (pte_uffd(ptent))
> +			continue;

[Severity: Critical]
Can this check cause a livelock when UFFD-WP interacts with NUMA balancing?

When NUMA balancing scans a VMA, it converts present PTEs to PROT_NONE but
preserves the _PAGE_UFFD bit if they were protected by UFFD-WP. This creates
a PTE signature that is identical to an RWP marker (PROT_NONE + _PAGE_UFFD).

If the VMA only has UFFD-WP enabled, the fault correctly falls through to
do_numa_page(). However, this check in numa_rebuild_large_mapping() will
unconditionally skip rebuilding the PTE, leaving it as PROT_NONE. Does this
cause the CPU to indefinitely retry the faulting instruction?

> @@ -6412,8 +6426,16 @@ static vm_fault_t handle_pte_fault(struct vm_fault=
 *vmf)
>  	if (!pte_present(vmf->orig_pte))
>  		return do_swap_page(vmf);
> =20
> -	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
> +	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma)) {
> +		/*
> +		 * RWP-protected PTEs are protnone plus the uffd bit. On a
> +		 * VM_UFFD_RWP VMA, a protnone PTE without the uffd bit is
> +		 * NUMA hinting and must still fall through to do_numa_page().
> +		 */
> +		if (userfaultfd_pte_rwp(vmf->vma, vmf->orig_pte))
> +			return do_uffd_rwp(vmf);

[Severity: Critical]
Furthermore, if the VMA has both UFFD-WP and UFFD-RWP enabled,
userfaultfd_pte_rwp() will evaluate to true. Does this cause a spurious RWP
fault to be delivered?

Once userspace resolves this spurious fault and clears the UFFD bit, it wou=
ld
silently destroy the UFFD-WP protection, potentially allowing unauthorized
writes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526130509.2748=
441-1-kirill@shutemov.name?part=3D13
