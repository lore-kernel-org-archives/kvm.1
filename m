Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21D93E49CA
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749885; cv=none; b=LG9F1jFiT+LkdpzlL2z8gaLwiZfQzGd+qPDJkHkPQgMFqCpabQz2prZ10/fh8IRo/1FB3osS8e2ZgjplpCFVoizlcWakz8lAZ4WvcGla61Hvyh8Tb9sRKWmUf9vAlHuv7F1GVRklOBM2GXfElMUPcSsFKZro/vWYF+ias1JQ72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749885; c=relaxed/simple;
	bh=gEgqzwToGfbqIVhtcBOqQJG/Xqnfgh7MwmzF5i8eh3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otJRGM0m6E0bcHgGRvAGJAXXFBeqmmnXGccalrOXVUKv7/kpn8Uz7b3a7VAm11p005k6S8A3GiBID506uWjgTRgW1vRCNjXSrBfJVh9roIMipUlWe2zwr/E2sumAof57FCBP1y2z7DN/js9Mim1+DNqh5wkQPaiVbeL6+K3wf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OT/0cQ27; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OT/0cQ27"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 857B61595;
	Wed, 22 Jul 2026 12:51:17 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C60F3F66F;
	Wed, 22 Jul 2026 12:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784749881; bh=gEgqzwToGfbqIVhtcBOqQJG/Xqnfgh7MwmzF5i8eh3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OT/0cQ270Ghbn4bnNDMC+jf9cIz6BGQhwTzh4U1LXZYIRNc7ch9tJPt1+XE4O9Fjy
	 Wac4UwjP+yPUw9oaCxsCEzCLcx9/N+6xr7iOeRwZ57/Koe86EvIrAohMLiNxDRE642
	 EtjmSQMRsWK5NXqqvt8aAwM+hBX3TRbiRGyj+O7Y=
Date: Wed, 22 Jul 2026 20:51:18 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH RFC v2 09/20] loongarch: kvm: remove stack copy address
 of pXd in pXd_offset()
Message-ID: <amEfNn3OsxU4VYAC@e129823.arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <20260722-dummy_ptxp3-v2-9-d9e4bad31e0a@arm.com>
 <20260722155325.EDECD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722155325.EDECD1F000E9@smtp.kernel.org>

On Wed, Jul 22, 2026 at 03:53:25PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] host_pfn_mapping_level() does not check if the PUD entry is a huge page (leaf) before traversing to the PMD level, leading to an unmapped/unaligned address dereference (Host Kernel Panic).
> --
> 
> --- Patch [9]: [PATCH RFC v2 09/20] loongarch: kvm: remove stack copy address of pXd in pXd_offset() ---
> commit 2f6da9236b45d60a4f233dc4f7a63b29a762f060
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> loongarch: kvm: remove stack copy address of pXd in pXd_offset()
> 
> This commit reworks host_pfn_mapping_level() to avoid using a stack copy
> of a pXd and passes it as an argument to pXd_offset_lockless(). This
> prepares the code for generic compile-time folded page tables.
> 
> > diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
> > index e104897aa5328..837b40bb694f4 100644
> > --- a/arch/loongarch/kvm/mmu.c
> > +++ b/arch/loongarch/kvm/mmu.c
> 
> [ ... ]
> 
> > @@ -698,19 +698,23 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
> >  	 * value) and then p*d_offset() walks into the target huge page instead
> >  	 * of the old page table (sees the new value).
> >  	 */
> > -	pgd = pgdp_get(pgd_offset(kvm->mm, hva));
> > +	pgdp = pgd_offset(kvm->mm, hva);
> > +	pgd = pgdp_get(pgdp);
> >  	if (pgd_none(pgd))
> >  		goto out;
> >  
> > -	p4d = p4dp_get(p4d_offset(&pgd, hva));
> > +	p4dp = p4d_offset_lockless(pgdp, pgd, hva);
> > +	p4d = p4dp_get(p4dp);
> >  	if (p4d_none(p4d) || !p4d_present(p4d))
> >  		goto out;
> >  
> > -	pud = pudp_get(pud_offset(&p4d, hva));
> > +	pudp = pud_offset_lockless(p4dp, p4d, hva);
> > +	pud = pudp_get(pudp);
> >  	if (pud_none(pud) || !pud_present(pud))
> >  		goto out;
> >  
> > -	pmd = pmdp_get(pmd_offset(&pud, hva));
> > +	pmdp = pmd_offset_lockless(pudp, pud, hva);
> > +	pmd = pmdp_get(pmdp);
> 
> [Severity: Critical]
> This is a pre-existing issue, but could this cause a host kernel panic if the
> VM is backed by 1GB huge pages (PUD level)?
> 
> In host_pfn_mapping_level(), there does not appear to be a check to see if the
> PUD entry is already a leaf before descending to the PMD level.
> 
> If KVM walks the host page tables and reaches a PUD leaf entry, it seems it
> would pass the PUD leaf directly into pmd_offset_lockless() since there is no
> check similar to kvm_pte_huge() for the PUD. 
> 
> Because the raw PUD entry still contains flag bits like _PAGE_PRESENT and
> _PAGE_HUGE, converting it to a pointer and dereferencing it in pmdp_get() might
> result in an unaligned address dereference, leading to a crash.
> 
> Would it make sense to check if the PUD is a huge page and return the mapping
> level early before trying to resolve the PMD?
> 
> >  	if (pmd_none(pmd) || !pmd_present(pmd))
> >  		goto out;

AFAIK, loongarch doesn't support CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD.
So, the pud_leaf() checking is meaningless.

Therefore, this comment seems ignorable.

-- 
Sincerely,
Yeoreum Yun
