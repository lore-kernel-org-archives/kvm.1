Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCEC48A2A0
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 12:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352704; cv=none; b=fhU/WyAXJ5+SRkHuDUP3hxWEybTuCy99vPEW9jeA708p4lN9ZjTxZ50O5cJjLbUKtDvDgxvPhCHD3ZzaveWKwccqMg5gAAG/srkrBij7iMu5ccAXQAGBPaw5uAqBBHzAUAyUPWOCFQvKbTT8NVIwgPSZI93b0fc5uFjAXpwtATY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352704; c=relaxed/simple;
	bh=+KtcP51bt2puyj4IaCAqFSxq2jDN920XHLDvA2hG6x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obzmpxcDPIRCy3jLfwSeoTBFB4iZgdP1kbLanNyMmyNmNTmXAVcjKRTgmTkp58WJ1CsjMFwZnRK/bj5DzfTewMyR37J5Vyw7v2QLSZliv0/uTESmoy35SSE5gWiCRnNiAiDk8DvpG2DKZE/8Qq6Wip9nKXx938nimm8JGq6TotQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=reNiMHDD; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="reNiMHDD"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A6D6165C;
	Wed,  2 Sep 2026 05:38:13 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4343D3F882;
	Wed,  2 Sep 2026 05:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788352696; bh=+KtcP51bt2puyj4IaCAqFSxq2jDN920XHLDvA2hG6x4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=reNiMHDDHVK+DlEsDqgOpb3cq3KUa78KmBh8IUwLDwiqH86ZaVXyKa1etVQatXOr4
	 38XftIj/Eyw0u41FnbVSqaKHnQHpxx00IPUHNo5pWasYAzCD7tozBvBXqh/qKzEiNb
	 Fi+BnGGKywGYOc3bs08tUz4gWJooNtjCrBw8VCyk=
Date: Wed, 2 Sep 2026 13:38:13 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH RFC v3 09/21] loongarch: kvm: remove stack copy address
 of pXd in pXd_offset()
Message-ID: <apgYtdl_DjBIqikK@e129823.arm.com>
References: <20260902-dummy_ptxp3-v3-0-5d8f5b17c25c@arm.com>
 <20260902-dummy_ptxp3-v3-9-5d8f5b17c25c@arm.com>
 <20260902121912.CF9161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902121912.CF9161F000E9@smtp.kernel.org>

On Wed, Sep 02, 2026 at 12:19:12PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing `pud_leaf()` / huge page check before traversing to PMD level, causing invalid memory dereference on 1GB huge pages.
> --
> 
> commit 7df2ea4ead6f791e1840ca23d67765ca06e93e1b
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> loongarch: kvm: remove stack copy address of pXd in pXd_offset()
> 
> This commit refactors host_pfn_mapping_level() to prepare for generic
> compile-time folded page tables. It replaces direct uses of stack-based pXd
> values with pXd_offset_lockless(), passing the pointers directly.
> 
> > diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
> > index e104897aa5328..837b40bb694f4 100644
> > --- a/arch/loongarch/kvm/mmu.c
> > +++ b/arch/loongarch/kvm/mmu.c
> [ ... ]
> > @@ -698,19 +698,23 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
> [ ... ]
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
> [Severity: High]
> This is a pre-existing issue, but does this code need a check to see if the
> PUD is a leaf entry before stepping down to the PMD level?
> 
> In arch/loongarch/kvm/mmu.c:host_pfn_mapping_level(), the code reads the PUD
> entry and verifies that it is present, but it does not check if it is a 1GB
> huge page leaf entry before traversing to the PMD level.
> 
> If a guest memory region is backed by a 1GB huge page on the host, the PUD
> entry will contain a PFN-encoded value and metadata flags. By unconditionally
> passing this to pmd_offset_lockless(), the macro may interpret the PFN encoded
> value as a kernel virtual address directory pointer. This produces a bogus
> pointer that pmdp_get() will then dereference, causing an invalid memory
> dereference and potentially crashing the host.
> 
> Could a pud_leaf() or kvm_pte_huge(pud_val(pud)) check be added before the
> pmd_offset_lockless() call to prevent this crash when 1GB huge pages are
> used?
> 
> >  	if (pmd_none(pmd) || !pmd_present(pmd))
> >  		goto out;

AFAIK, loongarch doesn't create the pud block mapping. so it seems
ignoralbe.

-- 
Sincerely,
Yeoreum Yun
