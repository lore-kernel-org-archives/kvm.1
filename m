Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006E2352026
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749486; cv=none; b=DIo3vpZPk0WdD2XBHOffo8p0u6W0t2pLofs2/yZuVMIVMB9RVg8tCxL0HwM9949uSgMhmLJJH9PRG8AhQwppectQSJmvq77aux+LbSh9pdqLjdZTXXd15l9V+BXLUIOIu5Bau2jOCDziVkL5Lg5oBefOXEwyP0+eixM4BFJhsCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749486; c=relaxed/simple;
	bh=uKJ12bVYQ+O4NPLYGEY1BXCSTRL8ak1VhXHr+h1r0g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATaHawQ/DCYAOPr8dVOYTvx7d105bBhCEO4TQ3pvS8vBe4EssHc32p1mUIbEDbZBvxKJtM8PgDEJ8bEgCcZDm/MyQg5fWon71iOOsPqZ4jBls8VeO3pLRVSmzbGkufNT469Nm3aRRP+RL61j9z0el7mKUMQ+E08Ze45QBsrQT3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=E7hb3o47; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="E7hb3o47"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CC1D1595;
	Wed, 22 Jul 2026 12:44:39 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE8C63F66F;
	Wed, 22 Jul 2026 12:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784749483; bh=uKJ12bVYQ+O4NPLYGEY1BXCSTRL8ak1VhXHr+h1r0g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E7hb3o47rR/X+8cgCVn9tqAMxd+VvBJ+6shL+xo966e5tFrDlrVsbaIXT4Y8cN0V1
	 FvYiZCDXqnua3MskiG4UJzwx6QiUgzLjp3mA+XnIchc8sA0e1gq8UU17Va/E2ReWm2
	 PFGb1WRYFYFOzm7gQiELIMU+821WaIiwH5O1Cwrs=
Date: Wed, 22 Jul 2026 20:44:40 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH RFC v2 15/20] mm/pgtable: optimize pmdp_get() and friends
 for folded pagetable levels
Message-ID: <amEdqMxwlxOkzL1X@e129823.arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <20260722-dummy_ptxp3-v2-15-d9e4bad31e0a@arm.com>
 <20260722161509.6CC951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722161509.6CC951F000E9@smtp.kernel.org>

On Wed, Jul 22, 2026 at 04:15:09PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Incorrect parameter name in the newly defined pgdp_get() function.
> --
> 
> --- Patch [15]: [PATCH RFC v2 15/20] mm/pgtable: optimize pmdp_get() and friends for folded pagetable levels ---
> commit 2c4b6d6a43469a09eb2dcdd35ef29b1bda716b3a
> Author: David Hildenbrand (Arm) <david@kernel.org>
> 
> mm/pgtable: optimize pmdp_get() and friends for folded pagetable levels
> 
> This commit optimizes pmdp_get() and related functions for configurations
> with folded page tables. It avoids unnecessary memory reads by returning a
> dummy value instead of forcing the compiler to read unused data.
> 
> Link: https://lore.kernel.org/all/0019d675-ce3d-4a5c-89ed-f126c45145c9@kernel.org/
> 
> > diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
> > index 019c3f074b771..ab4a826b34048 100644
> > --- a/include/asm-generic/pgtable-nop4d.h
> > +++ b/include/asm-generic/pgtable-nop4d.h
> > @@ -34,6 +34,14 @@ static inline bool pgd_leaf(pgd_t pgd)		{ return false; }
> >   */
> >  #define set_pgd(pgdptr, pgdval)	set_p4d((p4d_t *)(pgdptr), (p4d_t) { pgdval })
> >  
> > +static inline pgd_t pgdp_get(pgd_t *p4dp)
> 
> [Severity: Low]
> This isn't a bug, but should the parameter for pgdp_get() here be named pgdp
> instead of p4dp?

Yes. I'll change it in next version.

Thanks!

-- 
Sincerely,
Yeoreum Yun
