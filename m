Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48965470EB5
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 19:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784747328; cv=none; b=VPbaI83aurd+hzHt/0kMlPAJOPSjHJxW9WFrrtQEJE0EKVnebwLxKlixMY3FOYbMR0u8RD8uQtqrYtqO0gCALcmW7urkOfrBicgZAis3X43HMdpG7jF7fL1Vzdz/Kq/zT6+etgl4WKewuMfLokC/BSoj0VqIsl86yeTGF/cakGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784747328; c=relaxed/simple;
	bh=LP4BZ1xH4Racyt5SSGYBDHtODFnnQ/3L6f5sJj1f6cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu2y8pxl55DTF0yQ1FT1N+r2xP8W9kC8qgHnIK6PRGA9yf1XtnPlJm1kzH5atYlKaCawIh8V1Ium/cmODYTIeLuLiIRWeaRRzIimklwNylgEwvw/mSRwb9MqTcGTs/cF2G3KFK7RKYLKuHz0x2e/NMO/kTpgicg6vyRUroKcQhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GcbVii5x; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GcbVii5x"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 542A11595;
	Wed, 22 Jul 2026 12:08:41 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E57D63F66F;
	Wed, 22 Jul 2026 12:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784747325; bh=LP4BZ1xH4Racyt5SSGYBDHtODFnnQ/3L6f5sJj1f6cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GcbVii5xMTYDfP7vIStojxAh21fbSv5Ye5qwQO1JAKRfehAinlx52CsFZuWkQBZQZ
	 jPcoN0B29HTmZXlAEx2y3rTCG/1OsCtgNq4o35ArErW35oqYVmDtoHlRcIQsWv0qmP
	 b45WG+iczRKrtDDCSDRNfmKyOjwVDuXFyr/n6iRA=
Date: Wed, 22 Jul 2026 20:08:42 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH RFC v2 14/20] x86: mm: skip pud setup when using generic
 compile-time folded pagetable
Message-ID: <amEVOhGbosvBDIQ2@e129823.arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <20260722-dummy_ptxp3-v2-14-d9e4bad31e0a@arm.com>
 <20260722161828.22F9F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722161828.22F9F1F000E9@smtp.kernel.org>

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Incomplete `CONFIG_PGTABLE_LEVELS` check in `collapse_pud_page()` fails to skip x86 3-level PAE configurations, exposing them to latent compile-time errors and potential runtime hardware exceptions (RSVD #PF).
> 
> Pre-existing issues:
> - [High] In `populate_pud()`, an error path during the 'trailing leftover' phase silently masks resource allocation failures, skipping necessary cleanup and causing a system crash (`BUG_ON`) instead of gracefully propagating the error.
> --
> 
> --- Patch [14]: [PATCH RFC v2 14/20] x86: mm: skip pud setup when using generic compile-time folded pagetable ---
> commit 163a3c6228e774c7dcf45c2630763c72ef0ffe3a
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> x86: mm: skip pud setup when using generic compile-time folded pagetable
> 
> We want to rework how set_pXd() behaves for generic compile-time folded
> page tables by disallowing its use and triggering a compile-time error
> when it is used improperly, ensuring that the actual first-level set_pXd()
> function is used instead.
> 
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index 078689aa7206f..91b33a265a431 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -1346,7 +1346,7 @@ static int collapse_pud_page(pud_t *pud, unsigned long addr,
> >  	pmd_t *pmd, first;
> >  	int i;
> >  
> > -	if (!direct_gbpages)
> > +	if (CONFIG_PGTABLE_LEVELS == 2 || !direct_gbpages)
> 
> [Severity: High]
> Does this check skip 3-level PAE configurations correctly?
> 
> If a user boots a 32-bit PAE kernel on a CPU with 1GB page support and
> gbpages is enabled, direct_gbpages becomes 1. collapse_pud_page() would then
> execute on a folded PUD (PDPTE in PAE) and write a PDPTE entry with the
> _PAGE_PSE (bit 7) flag copied from the PMD.
> 
> In PAE, bit 7 of the PDPTE is strictly reserved, and setting it causes a
> hardware exception (kernel panic).
> 
> Should this condition be checking if CONFIG_PGTABLE_LEVELS <= 3 to match
> the logic added to populate_pud() below?
> 
> >  		return 0;
> >  
> >  	addr &= PUD_MASK;

This will be changed with CONFIG_X86_DIRECT_GBPAGES.

> 
> [ ... ]
> 
> > @@ -1730,7 +1730,8 @@ static int populate_pud(struct cpa_data *cpa, unsigned long start, p4d_t *p4d,
> >  	/*
> >  	 * Map everything starting from the Gb boundary, possibly with 1G pages
> >  	 */
> > -	while (boot_cpu_has(X86_FEATURE_GBPAGES) && end - start >= PUD_SIZE) {
> > +	while (CONFIG_PGTABLE_LEVELS > 3 && boot_cpu_has(X86_FEATURE_GBPAGES) &&
> > +	       end - start >= PUD_SIZE) {
> >  		set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
> >  				   canon_pgprot(pud_pgprot))));
> >  
> 
> [Severity: High]
> This is a pre-existing issue, but further down in populate_pud() under the
> "Map trailing leftover" section, does the error handler silently mask
> allocation failures?
> 
> arch/x86/mm/pat/set_memory.c:populate_pud() {
>     ...
> 		tmp = populate_pmd(cpa, start, end, cpa->numpages - cur_pages,
> 				   pud, pgprot);
> 		if (tmp < 0)
> 			return cur_pages;
>     ...
> }
> 
> If populate_pmd() fails (e.g., due to OOM) while mapping trailing leftovers,
> it returns a negative error code in tmp. Returning cur_pages (which can be 0)
> instead of the error code causes populate_pgd() to assume success.
> 
> This skips unmap_pud_range() cleanup, and returns 0 to __change_page_attr().
> The top-level __change_page_attr_set_clr() loop updates cpa->numpages = 0
> and hits BUG_ON(!cpa->numpages), causing a kernel panic.
> 
> Should this return tmp instead to properly propagate the error code?

I don't believe this since current populate_pgd() will be called against
EFI virtual memory map. so It can be ignored.

-- 
Sincerely,
Yeoreum Yun
