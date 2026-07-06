Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A833F3BE16F
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329356; cv=none; b=BMDDdRJF8ff4ieSUtJ4JgOVp1pqJvUPVBGdYQ0f4S4eHqOw+ztVYbi0EAdqYHJQwv/NdF5kebNz8bYXrhoRrPHepLmmsowLE4iH/HT2NOiApDdwvl0wk2n0VrRmNUzQDhqQVD9QeHcCi3r52MbMWPptK0B/IJzf6DZGy9wEysOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329356; c=relaxed/simple;
	bh=AIW4Cloo4hV+SOi1ykE8Pn0YPf9Iu4eBe9WWoa34IVw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uOYnQmhOkdByYSsUX5G2d2fdVWqEJhAuJKMV3EQuSNDyhydRWwWJZL7BfManoz2LjRzMOtrHvEP/TcXk1KsT35EtTU46ZrB6T9d7vYPBkth7jW8u5R41DwI2jQtjz7k66NGXn0TkeA7v6a9m+6OC7YLtariRDmLcKBcfSLji/5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8lbIlLV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8lbIlLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435BA1F00A3F;
	Mon,  6 Jul 2026 09:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783329344;
	bh=KX8xZjSRngHWJv33odlL0qJkFGFFOM88N/NjTUBy1PA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a8lbIlLVAnmPuR7RaVgVxkyKMyUoorP6/eSSLSVlxPNRV6mLMFJtP1aCkdFsedzEp
	 sM+/SS1YtBvUisu5a0m7OExMC+Pj45TYIJWcfBBUsldJn+vfG+t2OqPIcGC6x4iBUc
	 adZfUvmdt34cIm1mfoZ5lnHmISmC49MU3wxUXmbWMSgyUBMgGj83RblU1N1HChHiLm
	 70PeJ9c8qgMsxLduHO2d8fJDO4OhdP/kBFu6Dv+mQYto2ACTroKW/Ruy66V7M4jfi7
	 5AXVDYZkPS0NsL34Ol93rl+7Ey0qLKqk6vdhUfqZxCPEIbXv7DQfXtIYes2u175EIF
	 6ntTQxrPAC2yQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 11/15] mm/pagemap: add PAGE_IS_ACCESSED for RWP
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260706084805.8400-12-kirill@shutemov.name>
References: <20260706084805.8400-1-kirill@shutemov.name>
 <20260706084805.8400-12-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:15:43 +0000
Message-Id: <20260706091544.435BA1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] PAGEMAP_SCAN handles unpopulated pages (pte_none and pmd_none) inc=
onsistently, violating UFFD-WP asynchronous tracking semantics and creating=
 diverging behavior between fast-path, slow-path, and PMD-hole execution fl=
ows.
--

commit 6140b14d4a73c9f85a7063bce04ca47dbbf1e064
Author: Kiryl Shutsemau <kas@kernel.org>

mm/pagemap: add PAGE_IS_ACCESSED for RWP tracking

This commit introduces PAGE_IS_ACCESSED for VM_UFFD_RWP VMAs, separating=20
read-write protection tracking from the existing PAGE_IS_WRITTEN flag.=20
PAGE_IS_WRITTEN is now properly scoped to only report within VM_UFFD_WP VMA=
s.

> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 5b55c59573a3c..2d724156763d2 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
[ ... ]
> @@ -2863,7 +2888,8 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsig=
ned long start,
>  		goto flush_and_return;
>  	}
> =20
> -	if (!p->arg.category_anyof_mask && !p->arg.category_inverted &&
> +	if (userfaultfd_wp(vma) && !p->arg.category_anyof_mask &&
> +	    !p->arg.category_inverted &&
>  	    p->arg.category_mask =3D=3D PAGE_IS_WRITTEN &&
>  	    p->arg.return_mask =3D=3D PAGE_IS_WRITTEN) {
>  		for (addr =3D start; addr < end; pte++, addr +=3D PAGE_SIZE) {

[Severity: High]
This is a pre-existing issue, but since this condition is being modified,
does PAGEMAP_SCAN handle unpopulated pages inconsistently depending on
the execution path?

When a process uses UFFD-WP asynchronous tracking and calls the ioctl with
category_mask =3D=3D PAGE_IS_WRITTEN and PM_SCAN_WP_MATCHING, the behavior
seems to diverge.

For a completely unpopulated 2MB range, pagemap_scan_pte_hole() evaluates
against cur_vma_category (which lacks PAGE_IS_WRITTEN) and skips the hole:

fs/proc/task_mmu.c:pagemap_scan_pte_hole() {
	if (!vma || !pagemap_scan_is_interesting_page(p->cur_vma_category, p))
		return 0;
	...
}

However, in a partially populated PMD, this fast-path loop is taken. Since
pte_present() and pte_swp_uffd_any() are false for pte_none, it appears to
output the unpopulated PTE as PAGE_IS_WRITTEN and installs a WP marker.

If the slow path is forced instead, pagemap_page_category() returns 0 for
pte_none, silently skipping it:

fs/proc/task_mmu.c:pagemap_scan_pmd_entry() {
	...
	for (addr =3D start; addr !=3D end; pte++, addr +=3D PAGE_SIZE) {
		pte_t ptent =3D ptep_get(pte);
		unsigned long categories =3D p->cur_vma_category |
					   pagemap_page_category(p, vma, addr, ptent);
	...
}

Could this inconsistency cause data loss during live migration? If an entire
PMD is zapped, the PMD hole path skips it without reporting it as written
or protecting it. Would this result in the migration process not sending
zero pages for the zapped range, retaining stale data on the destination,
and failing to trigger WP faults on future writes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706084805.8400=
-1-kirill@shutemov.name?part=3D11
