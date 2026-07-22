Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5F042125C
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784748315; cv=none; b=AwmZ/y0PKbUAx7Wc3M33a4CW5T4w33Okp3edGH9Gms1DQgODjTOhwsKsEhMGPeGNhaGLhMDXhuk4xqCeig4uKt7QXgwWuofYkcxJRnWtxWlIw8olG7jX/Pd++8wsDOsADmXsHSrj8X8blIW7k5YUf8LuarLfXnbOUFRxk/wttTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784748315; c=relaxed/simple;
	bh=CPuceKWfgGNJgqttWzDqUCDnco6cd7XDcQJGowdF+T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTA/iqchSlPSNht05zf+QGDJZxDo8TDnKe2cIb1UOsfTchn2RcsSUiS+IfNfhh+HJMy4gku6RoXDV595sbX81bsY2c+cieRUUUJwLlGGOT+iJOhcq01/SHyxBiAB9ssstr2SXt5yrRKoNYMAoiISLY1VKVlrC4CNwacD4yUtW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rZ/C/d+I; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rZ/C/d+I"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1910B1595;
	Wed, 22 Jul 2026 12:25:07 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA55C3F66F;
	Wed, 22 Jul 2026 12:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784748311; bh=CPuceKWfgGNJgqttWzDqUCDnco6cd7XDcQJGowdF+T8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZ/C/d+IbM/egFYM8mcJe3pPOKYTU+XQXOjD7snfwnAkKWr/CImXnUlytLtQx19fC
	 u4Pk2DEgw7hdq3xrUfeqb3+uSAhwPHW07Dg1XoZ/rf9rPNKnPRLxlMCPUBkGILJGjq
	 LjnVaqgLgJqTsKT9hsGzE8WpZuUY5tAuzUrITICI=
Date: Wed, 22 Jul 2026 20:25:08 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH RFC v2 07/20] mm/pgtable: define
 (pgd|p4d|pud)_offset_lockless() for folded page tables
Message-ID: <amEZFECJbtQfoXOo@e129823.arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <20260722-dummy_ptxp3-v2-7-d9e4bad31e0a@arm.com>
 <20260722155849.85FF41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722155849.85FF41F00A3A@smtp.kernel.org>

On Wed, Jul 22, 2026 at 03:58:49PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Use-After-Free in GUP-fast on dynamically folded architectures (RISC-V SV39) due to flawed generic lockless page table offset macros.
> --
> 
> --- Patch [7]: [PATCH RFC v2 07/20] mm/pgtable: define (pgd|p4d|pud)_offset_lockless() for folded page tables ---
> commit 235a6b06e94a41ff4c56118e36e869516151cea9
> Author: David Hildenbrand (Arm) <david@kernel.org>
> 
> mm/pgtable: define (pgd|p4d|pud)_offset_lockless() for folded page tables
> 
> The patch provides p4d_offset_lockless(), pmd_offset_lockless(), and
> pud_offset_lockless() for static folded page tables to ignore the passed
> value and return the pointer. This avoids returning a pointer to the stack
> value like the default handlers do.
> 
> > diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
> > index 6c9bca78047c4..5a2b0a81ae197 100644
> > --- a/include/asm-generic/pgtable-nopud.h
> > +++ b/include/asm-generic/pgtable-nopud.h
> [ ... ]
> > @@ -47,6 +47,13 @@ static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
> >  }
> >  #define pud_offset pud_offset
> >  
> > +static inline pud_t *pud_offset_lockless(p4d_t *p4dp, p4d_t p4d,
> > +		unsigned long address)
> > +{
> > +	return (pud_t *)p4dp;
> > +}
> > +#define pud_offset_lockless pud_offset_lockless
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this fix leave dynamically folded
> architectures like RISC-V SV39 vulnerable to a use-after-free?
> 
> The generic fallback macro in include/linux/pgtable.h still passes the address
> of a local stack variable:
> 
> #define pud_offset_lockless(p4dp, p4d, address) pud_offset(&(p4d), address)
> 
> On RISC-V SV39, PUD is folded dynamically in arch/riscv/mm/pgtable.c:
> 
> pud_t *pud_offset(p4d_t *p4d, unsigned long address)
> {
> 	if (pgtable_l4_enabled)
> 		return p4d_pgtable(p4dp_get(p4d)) + pud_index(address);
> 
> 	return (pud_t *)p4d;
> }
> 
> Since pgtable_l4_enabled is false on SV39, pud_offset() returns the pointer it
> was passed, which is the stack pointer from the generic pud_offset_lockless()
> macro.
> 
> When gup_fast_pud_leaf() in mm/gup.c executes its concurrent modification
> check, it reads the stale stack variable instead of the actual page table:
> 
> 	if (unlikely(pud_val(orig) != pud_val(pudp_get(pudp)))) {
> 		gup_put_folio(folio, refs, flags);
> 		return 0;
> 	}
> 
> Because it reads the isolated stack variable, the check trivially passes,
> allowing GUP-fast to pin and return a concurrently freed 1GB huge page.
> 
> Could a similar lockless override be applied for dynamically folded
> architectures to prevent this?

concurrent modification check doesn't lose the meaning since pudp is read
again and compare with orig and isolated stack variable doesn't connect
to trivially passes. So, this is ignorable.

-- 
Sincerely,
Yeoreum Yun
