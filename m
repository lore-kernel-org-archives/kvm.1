Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D654F3BED23
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803217; cv=none; b=IwhXiQe8kTK2oNOJguzYFF8kmDZVufewFiD+3dAk+TBLvq6HuDSbmPRbJFid29Jv/YiEkhets+o5O44RkzKqweBmCXSCJLV7bgfWPu8J4cLOFDJrnBwAhZU4osl+OEm8z1y2d1T/heaRD4/htIwNkToQdXV3AxT7Y8Py0j+8K4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803217; c=relaxed/simple;
	bh=YLWx51acZGW7XG7scrNA0Dsa4eZJkeDfI5ceQuxSxAY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xrpy4Ej7zRAWM04GF3dspJcjFa16pzTFTlrzJa1V2lDg1kg/Du732DZtZ1BqBJCZ12K0Rc2+QDItKkCZ3LyRRVeOBzHez+j5G5/NYPqY+wRWY+k+Re2Bl3l3uI5SJkLQOSZdPtsbt594k/cM1Pr9f1DvxVI/G6gpaazhiSxhPSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XppUcttq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XppUcttq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A281E1F000E9;
	Tue, 26 May 2026 13:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779803215;
	bh=5HQmyzXTnZv5pO5qY41DEvREOJv/7STVC9eu7mCjVjk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XppUcttqwCDaCQLF1/k33mOL42GjDwMz1OafIVpOd0/R2Rat8GfFsmKWYZ1hB85LQ
	 //NfCTXbCPP+6B7jRaRQD54I9BA6l+d6hni29JuzDtuUZ+olA3ei2UNOptKv7ra0Fx
	 MZRtRaznwrorvwoLQ1lkH6/wkZMdDToxo5unce7H9cPObX9iWad+nTMRyqwuU4Kt6E
	 gVrEfbVck7IcHiJvc+ng7BrN7qeo+ehGlMsmJzqy5/iEdDtLgVKZaSlV0BCzZWunk8
	 Va4fzM0Z3KFc9ANXUR+bgsd/D24R3+dwoChHDADQgh4gB+MPK6VFr+QyKcHIUBdulz
	 aInz6LGOXhinw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/18] fs/proc/task_mmu: fix make_uffd_wp_huge_pte()
 prot-update race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526130509.2748441-2-kirill@shutemov.name>
References: <20260526130509.2748441-2-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 13:46:55 +0000
Message-Id: <20260526134655.A281E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] `pagemap_scan_hugetlb_entry()` illegally modifies shared HugeT=
LB PMDs without unsharing, silently corrupting the memory protection of oth=
er processes.
- [High] `pagemap_scan_hugetlb_entry()` incorrectly uses the hardcoded `HPA=
GE_SIZE` macro to verify if the requested range covers the entire HugeTLB p=
age, breaking write-protection for gigantic huge pages.
- [High] Self-deadlock in `pagemap_scan_pte_hole()` when write-protecting u=
nallocated HugeTLB pages due to recursive `hugetlb_vma_lock` acquisition.
--

commit a2b7dff5e4a0bce48bb972dee8e0bb1bf34d50e4
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>
Subject: fs/proc/task_mmu: fix make_uffd_wp_huge_pte() prot-update race

This commit fixes a race condition in make_uffd_wp_huge_pte() where the
UFFD_WP bit is applied to a present HugeTLB PTE using a non-atomic snapshot.
It mirrors the ptep_modify_prot_start() and ptep_modify_prot_commit() patte=
rn
used for normal PTEs to prevent hardware updates from being lost.

> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c

[ ... ]

> @@ -2960,11 +2964,11 @@ static int pagemap_scan_hugetlb_entry(pte_t *ptep=
, unsigned long hmask,
>  	if (~categories & PAGE_IS_WRITTEN)
>  		goto out_unlock;
> =20
>  	if (end !=3D start + HPAGE_SIZE) {
                     ^^^^^^^^^^
[Severity: High]
This isn't a bug introduced by this patch, but could this hardcoded macro
cause gigantic huge pages to incorrectly back out of write-protection?

For gigantic HugeTLB pages (e.g., 1GB), the generic page walker provides
boundaries spanning the gigantic page size. Because HPAGE_SIZE is defined
as (1UL << HPAGE_SHIFT), checking against it will falsely mark the range as
partial.

Should this dynamically evaluate the size using
huge_page_size(hstate_vma(vma)) instead?

>  		/* Partial HugeTLB page WP isn't possible. */
>  		pagemap_scan_backout_range(p, start, end);
>  		p->arg.walk_end =3D start;
>  		ret =3D 0;
>  		goto out_unlock;
>  	}
> =20
>  	make_uffd_wp_huge_pte(vma, start, ptep, pte);
        ^^^^^^^^^^^^^^^^^^^^^
[Severity: Critical]
This isn't a bug introduced by this patch, but does modifying the HugeTLB
PTE/PMD here break the shared PMD protections for other processes?

HugeTLB supports PMD sharing across processes. When applying UFFD_WP marker=
s,
the kernel must normally break sharing via huge_pmd_unshare().

Because pagemap_scan_hugetlb_entry() modifies the shared page table
directly without unsharing, could this silently apply write protection to t=
he
mappings of all other processes sharing this PMD, leaving their TLB entries
desynchronized?

>  	flush_hugetlb_tlb_range(vma, start, end);
> =20
>  out_unlock:

[ ... ]

> @@ -2994,10 +2998,10 @@ static int pagemap_scan_pte_hole(unsigned long ad=
dr, unsigned long end,
>  	ret =3D pagemap_scan_output(p->cur_vma_category, p, addr, &end);
>  	if (addr =3D=3D end)
>  		return ret;
> =20
>  	if (~p->arg.flags & PM_SCAN_WP_MATCHING)
>  		return ret;
> =20
>  	err =3D uffd_wp_range(vma, addr, end - addr, true);
        ^^^^^^^^^^^^^^^^^^^
[Severity: High]
This isn't a bug introduced by this patch, but can this lead to a
self-deadlock when write-protecting unallocated HugeTLB pages?

When PAGEMAP_SCAN write-protects a HugeTLB VMA, walk_hugetlb_range()
acquires hugetlb_vma_lock_read(vma). If it encounters an unallocated HugeTLB
page, it calls .pte_hole (pagemap_scan_pte_hole()), which delegates
through uffd_wp_range() -> change_protection() ->
hugetlb_change_protection().

The latter unconditionally attempts to acquire hugetlb_vma_lock_write() for
shared mappings on the same VMA. Acquiring a write lock on an rw_semaphore
while already holding a read lock causes a guaranteed self-deadlock.

>  	if (err < 0)
>  		ret =3D err;
> =20
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526130509.2748=
441-1-kirill@shutemov.name?part=3D1
