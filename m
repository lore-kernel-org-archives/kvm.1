Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F171434F483
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711540; cv=none; b=Yvka3w+7BpVXGgw3LrsNmR8ivPp/4LsnPy8HBQJC1WUZjMWJNy3CwtXXStFL4hz88Us7gTpB2sUsBKSTCVdiaB/P0CzNA46xB7FWu9H+aYOvenDZP3+vHNnzAg5/4JPlfp6+mzjSZkTAD6liBJY6WoC4PNnPk7Z4ZLkF8bWJ6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711540; c=relaxed/simple;
	bh=rLiL/8+8+6vY1ilTNkrxefwj/UKlvOUYwuTwwOTGHho=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y/vCIelZHrZvYIH0k29BGHhgESNUeqIwa1zIVogeTh8fDcFxWUng0RGrgNYXveQUoJjROR20zskbx1QIzxAuYXjuOwHxEX0gwGBVmo2i0dxLdIfN/HNVoaTTo0aRxMhrvxKtoRhZubSV/ZJMITcj3HnHvEYJ/AcSYCVhf1AWaUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjT07NBo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjT07NBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D0B1F000E9
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779711538;
	bh=nMDuZDq7bGLYvLkOPONtcEIpAlpiYraOhlL3kslbMQY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=RjT07NBo81n8WZrcdKicdyNvrBLoSByHahcKFZMmcNTI026m6JzOYISHPZYNcvuZV
	 aLBXh851vUC/kIFKs1re9pDwaBL7AgDpeOAF5sAQbCQotzubTm//JgUXvKF4sYAQza
	 ePU8c0EaClf2V2tzfc1aq3xxYc1fq8lAMD5jmfCDI9qezmX3JtiFa4V+4p99VibrmQ
	 MVs70MCEi+z5soXolIhMKb4mItE2mRk3up6QbXdVnyFyF/G+iC6oGFoXlF/2L5H1oT
	 WlNtvoYAmRenfWdGUbl9V7xA+TWrJxbU2+eGGVm4FKC4vf6NBt0GgtuLWv6mWsC+n0
	 GMnuEFJbZmuSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/14] mm/userfaultfd: add RWP fault delivery and
 expose UFFDIO_REGISTER_MODE_RWP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525113737.1942478-10-kas@kernel.org>
References: <20260525113737.1942478-10-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 12:18:57 +0000
Message-Id: <20260525121858.57D0B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] UFFD RWP tracking is bypassed or causes an infinite loop during GU=
P FOLL_FORCE accesses on PROT_NONE VMAs.
- [High] Orphaned RWP-protected PTEs cause an unrecoverable infinite page f=
ault loop in hugetlb_fault().
- [High] NUMA balancing silently strips userfaultfd RWP protection from adj=
acent PTEs within a large folio.
- [Medium] Missing feature capability check in userfaultfd_register allows =
enabling RWP without negotiating the feature.

Pre-existing issues:
- [High] Calling present-PTE accessors on potentially non-present swap or m=
igration entries in must_wait() handlers.
--

commit 0e07f627a7171ce12ad9ac2a38e2b76f7df096a7
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP

This commit introduces read-write protection (RWP) tracking for userfaultfd.
It wires the fault side of RWP tracking and turns on the userspace interfac=
e,
exposing UFFDIO_REGISTER_MODE_RWP.

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8555810cd42ec..f63718296cc20 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c

> [ ... ]

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

[Severity: High]
When a Hugetlb VMA is registered with UFFD RWP, its PTEs are marked
pte_protnone().

If the VMA is unregistered (UFFDIO_UNREGISTER) or the process forks and the
child drops __VM_UFFD_FLAGS, userfaultfd_rwp(vma) becomes false, but the
page tables retain the PROT_NONE PTEs.

When a thread accesses these orphaned pages, does the handler skip the
hugetlb_handle_userfault() block, fall through, and update access flags
without clearing _PAGE_PROTNONE?

Since Hugetlb does not support NUMA hinting, could this cause an
unrecoverable infinite page fault loop when the CPU retries the
instruction and hits the same PROT_NONE PTE?

> +		return hugetlb_handle_userfault(&vmf, mapping, VM_UFFD_RWP);
> +	}
> +
>  	/*
>  	 * If we are going to COW/unshare the mapping later, we examine the

> diff --git a/mm/memory.c b/mm/memory.c
> index e4ae5350db416..3e393881031d2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c

> [ ... ]

> @@ -6410,8 +6416,16 @@ static vm_fault_t handle_pte_fault(struct vm_fault=
 *vmf)
>  	if (!pte_present(vmf->orig_pte))
>  		return do_swap_page(vmf);
> =20
> -	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
> +	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma)) {

[Severity: High]
If a VMA is marked PROT_NONE but has UFFD RWP registered, GUP accesses
using FOLL_FORCE will bypass this check because vma_is_accessible(vma)
evaluates to false.

Does this cause GUP's follow_page_mask() to retry the read, see the PROT_NO=
NE
PTE again, and fault indefinitely, creating an infinite loop?

For writes, does it fall through to do_wp_page() and bypass userfaultfd RWP
tracking entirely?

> +		/*
> +		 * RWP-protected PTEs are protnone plus the uffd bit. On a
> +		 * VM_UFFD_RWP VMA, a protnone PTE without the uffd bit is
> +		 * NUMA hinting and must still fall through to do_numa_page().
> +		 */
> +		if (userfaultfd_pte_rwp(vmf->vma, vmf->orig_pte))
> +			return do_uffd_rwp(vmf);
>  		return do_numa_page(vmf);

[Severity: High]
When a page fault occurs on a pure NUMA hinting PTE within a large folio,
do_numa_page() calls numa_rebuild_large_mapping().

This function iterates over all adjacent PTEs and rebuilds any PTE where
pte_protnone() is true by unconditionally calling pte_modify().

Since RWP-protected PTEs are also marked pte_protnone(), will
numa_rebuild_large_mapping() indiscriminately clear the PROT_NONE protection
from any RWP-protected PTEs in the same large folio, silently bypassing
userfaultfd RWP tracking?

> +	}
> =20
>  	spin_lock(vmf->ptl);

> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 78eb63702649e..b966df47800c1 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c

> [ ... ]

> @@ -2736,6 +2748,13 @@ static inline bool userfaultfd_must_wait(struct us=
erfaultfd_ctx *ctx,
>  	 */
>  	if (!pte_write(ptent) && (reason & VM_UFFD_WP))
>  		goto out;
> +	/*
> +	 * PTE is still RW-protected (protnone with uffd bit), wait for
> +	 * userspace to resolve. Plain PROT_NONE without the marker is not
> +	 * an RWP fault.
> +	 */
> +	if (pte_protnone(ptent) && pte_uffd(ptent) && (reason & VM_UFFD_RWP))

[Severity: High]
This is a pre-existing issue, but userfaultfd_must_wait() and
userfaultfd_huge_must_wait() fetch the PTE locklessly and check pte_none().

If the page was concurrently swapped out or migrated, it will be a non-pres=
ent
entry (which is not pte_none()).

Since swap entries encode bits differently than present PTEs, does calling
present-PTE accessors like pte_write() (and now pte_protnone() and pte_uffd=
())
on potentially non-present entries produce undefined results?

> +		goto out;
> =20
>  	ret =3D false;

> [ ... ]

> @@ -4477,6 +4496,15 @@ static int userfaultfd_api(struct userfaultfd_ctx =
*ctx,
>  		uffdio_api.features &=3D ~UFFD_FEATURE_WP_UNPOPULATED;
>  		uffdio_api.features &=3D ~UFFD_FEATURE_WP_ASYNC;
>  	}
> +	/*
> +	 * RWP needs both PROT_NONE support and the uffd-wp PTE bit. The
> +	 * VM_UFFD_RWP check covers compile-time unavailability; the
> +	 * pgtable_supports_uffd() check covers runtime (e.g. riscv
> +	 * without the SVRSW60T59B extension) where the PTE bit is declared
> +	 * but not actually usable.
> +	 */
> +	if (VM_UFFD_RWP =3D=3D VM_NONE || !pgtable_supports_uffd())
> +		uffdio_api.features &=3D ~UFFD_FEATURE_RWP;

[Severity: Medium]
This patch exposes UFFDIO_REGISTER_MODE_RWP, allowing userspace to register
VMAs with RWP mode.

If the architecture does not support the required PTE bits, userfaultfd_api=
()
masks out UFFD_FEATURE_RWP.

Since userfaultfd_register() lacks a strict feature verification for RWP
(like the one existing for WP), will the registration falsely succeed and
apply VM_UFFD_RWP to the VMA even when the feature was not successfully
negotiated?

> =20
>  	ret =3D -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525113737.1942=
478-1-kas@kernel.org?part=3D9
