Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF4633B966
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784748718; cv=none; b=GV99wGWxZjeYKZL5/lyZwZhRdSsBJY4CzQZd+/j+TXhqMksyv9ZPqXtRyaN8QyCgYKIwRAJOBtbdhcWvm3o1pCZ1q62ZDTHoQ8wIbpqDONtMah56AvhkJX+KMbmOSbmyi7xkMD4U2Js7enMQCGPj34oOklmEJr93KVzt0Xmszlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784748718; c=relaxed/simple;
	bh=mJ7xrKkarp10E7G5ES7Ha96ohxO1lRE1Ze2UX4reP38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2117sxWDQ5ur48+U29CCZCE2W12YLJ/97K5B3WKcONZPDAMDyCet7NgOxs3O16DD46zkddSPVQRK8+dsXD/zbKdIUWqoipeh0GECrc57tKi6/C6jFHsQVa76qKPWNNVEISLc2sQnpkd4SGQsbWvDGvuNLQfpGR2OyMhobiyXxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lSLHFvu1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lSLHFvu1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 024831595;
	Wed, 22 Jul 2026 12:31:43 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9DF53F66F;
	Wed, 22 Jul 2026 12:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784748707; bh=mJ7xrKkarp10E7G5ES7Ha96ohxO1lRE1Ze2UX4reP38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lSLHFvu1T09TDc8kk2rp+0Ue47Z7pNeDxpfOovqm55PUnVRIdBAD108Ned4cI16z8
	 IusYpayQi8mfyCye+dLMrs7Fez68iFDtRzZEbePXydHQdI4PbN4iLgVcck+nBQNe+W
	 8orot0yCJ/yEMkBYEJZlk/v6/pI/IYY4Jg0nwFxo=
Date: Wed, 22 Jul 2026 20:31:44 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH RFC v2 08/20] mm: vmscan: remove stack copy address of
 pud pass in wallk_pud_range()
Message-ID: <amEaoDLZE5juUuD0@e129823.arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <20260722-dummy_ptxp3-v2-8-d9e4bad31e0a@arm.com>
 <20260722155619.51D071F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722155619.51D071F00A3A@smtp.kernel.org>

On Wed, Jul 22, 2026 at 03:56:18PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The `pmd_same` concurrency check in `walk_pte_range` is bypassed because it receives a pointer to a stack variable (`&val`) instead of the actual PMD entry.
> --
> 
> --- Patch [8]: [PATCH RFC v2 08/20] mm: vmscan: remove stack copy address of pud pass in wallk_pud_range() ---
> commit 509a7a22f2cecb4a110a42ba30c39b2954f718fe
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> mm: vmscan: remove stack copy address of pud pass in wallk_pud_range()
> 
> This commit replaces passing the address of a stack copy of a pXd to
> walk_pmd_range() with passing the pud pointer directly. This change prepares
> the codebase for generic compile-time folded page tables.
> 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3727,7 +3727,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
> >  		if (!pud_present(val) || WARN_ON_ONCE(pud_leaf(val)))
> >  			continue;
> >  
> > -		walk_pmd_range(&val, addr, next, args);
> > +		walk_pmd_range(pud + i, addr, next, args);
> 
> [Severity: High]
> This is a pre-existing issue, but should walk_pmd_range() in mm/vmscan.c
> also be updated to avoid passing a stack copy to walk_pte_range()?
> 
> In walk_pmd_range(), a stack copy of the PMD entry is created and its
> address is passed to walk_pte_range():
> 
>     if (!walk_pte_range(&val, addr, next, args))
> 
> Inside walk_pte_range(), this pointer is used for a concurrency check:
> 
>     if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
> 
> Because pmd points to the unchanging stack variable, pmdp_get_lockless(pmd)
> reads the frozen value, causing the pmd_same() check to always succeed.

This is valid and need to be changed with pmd + i instead of &val.
I'll send with another patch.

Thanks.

-- 
Sincerely,
Yeoreum Yun
