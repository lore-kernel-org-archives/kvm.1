Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF98483BF4
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352155; cv=none; b=uRii7NfcfYDRIMVQsF8ACrYGodoxCJrKsxbJPPWdWzu9U81omvXT1/+eKOws1VA2AeEQCfuS5gKUvj/LWhD9Z+vrTc5D46VjSb7PAXNcWvPbc9yFA5JB2AtOskeMhg7s/r3U6JFyl8jQJPgduYHgpEuoiSYJ2uPCgpDxk2Lfh4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352155; c=relaxed/simple;
	bh=LGAL9YftWcmFJ8L3ntQbbDzmCUkKhkp8pke+48cobO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8OmF1JTzimyq/dwuSeGp4h6QfWd5yDDRUBtrG1r4ia2PthfzKL3YtWRaFT453jq7v8YIDuA8UdPyYvRTwSfzIWu8wJQSQM3gj+MDOYSrZXi6SdEKxgd5ku2yvX9+GJcc5P6rSeUou937FGzyYobibFdRKmBFbu5n12rfJcs2nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DtKn3qgM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DtKn3qgM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EF931682;
	Wed,  2 Sep 2026 05:29:09 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C1233F882;
	Wed,  2 Sep 2026 05:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788352152; bh=LGAL9YftWcmFJ8L3ntQbbDzmCUkKhkp8pke+48cobO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DtKn3qgMeXD8A4W+/dPPSO5wac8VZYu+QezoJ7OhvpGWWzOgEf+8myVvqpBmBUb5R
	 JQzYvvNKUt18o8RpYNUTj0w+pFbnaPKMKHMMgso0wAkaXlKDUgG+wASjmi0RhlLyyD
	 V8bazawkbOWuim7hj0KKw077Q1LydDbrbl86tKww=
Date: Wed, 2 Sep 2026 13:29:09 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH RFC v3 15/21] x86: mm: skip collapse_pud_page() when
 CONFIG_X86_DIRECT_GBPAGES disabled
Message-ID: <apgWlRtcGwZhKMFO@e129823.arm.com>
References: <20260902-dummy_ptxp3-v3-0-5d8f5b17c25c@arm.com>
 <20260902-dummy_ptxp3-v3-15-5d8f5b17c25c@arm.com>
 <20260902121721.9A2FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902121721.9A2FD1F000E9@smtp.kernel.org>

On Wed, Sep 02, 2026 at 12:17:21PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Incorrect Kconfig macro name `CONFIG_X86_FEATURE_GBPAGES` unconditionally disables PUD page collapsing on x86.
> --
> 
> commit e72cd2f328b1fab1c51fad6dcdfc5273b0764f4b
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> x86: mm: skip collapse_pud_page() when CONFIG_X86_DIRECT_GBPAGES disabled
> 
> This commit skips collapse_pud_page() when gbpages are disabled to prepare 
> for compile-time folded page table changes.
> 
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index a1a061d995b31..07a873775279f 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -1315,7 +1315,7 @@ static int collapse_pud_page(pud_t *pud, unsigned long addr,
> >  	pmd_t *pmd, first;
> >  	int i;
> >  
> > -	if (!direct_gbpages)
> > +	if (!IS_ENABLED(CONFIG_X86_FEATURE_GBPAGES) || !direct_gbpages)
> 
> [Severity: High]
> Does CONFIG_X86_FEATURE_GBPAGES exist as a Kconfig option? The commit
> message mentions CONFIG_X86_DIRECT_GBPAGES, so it looks like the Kconfig
> macro might have been mixed up with the CPU feature flag X86_FEATURE_GBPAGES.
> 
> Because this Kconfig option does not exist, IS_ENABLED() will resolve to 0,
> making the condition unconditionally true. Will this completely disable PUD
> page collapsing on x86, preventing 1GB huge pages from being collapsed in
> the kernel direct map?

Sorry for typo. I'll change into CONFIG_X86_DIRECT_GBPAGES in next
round.

-- 
Sincerely,
Yeoreum Yun
