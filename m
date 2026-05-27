Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6036C2F3C0A;
	Wed, 27 May 2026 04:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779855087; cv=none; b=rmtxX0z105xyQfcGcshEpzvv9PCYY+92PxjqJ5RFuNFM8Br2LTavqsQC0JoCoYmBuDz9uWKgeRwKWmMfTAk4HhJ5RU3Bp3qN8ZguaS5wXWtD1/N4aowUDzILGsq0yJ7i91UnaNW/1/akjGaEy0axJ4n0tFC9/cmhSSg025dbXyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779855087; c=relaxed/simple;
	bh=QzY0L5uyGC0TEUhedlSvQpQTcy/l2fYgahH0LB0MsIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3/PBgZkIHUms4BrYKqdZpPIwANoGgier/MJpFEFBsUmcqYuUFXaKErDSiRi+gPYhZu+3V9h05NSHHw8XJpFdq1OyB+tnZdHrNnV1zHPR7/Ci/RWRkdu7TTR3pV5QdlqyaooUhneF5b3Za88peHtW0gvP629+zw40zvbRdQIH20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cESN+k6t; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cESN+k6t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779855087; x=1811391087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QzY0L5uyGC0TEUhedlSvQpQTcy/l2fYgahH0LB0MsIk=;
  b=cESN+k6tTKDH2ANP0ByS5l+yepPIDSn1FZDXHAKLNRFI91wT7UPTY3Jv
   Fx+4mBPVY02J+y7Ksdfn0QysioYSuzg48M6QJvlI7P8UrKLgTjNzgyG2w
   arFGpPJ2+F9at7Zx4SWPVVfnjs0x+/NCcOmRTbzqCkJT2Z4pinKGRqZ8X
   EXmas2wCUKaIphnRTG5ZkVxcoJY74JiBSRorYkHgmH8IUQhlu7PGO+br0
   8dcER9Zt9783T12cXFtgvmp11AyallhBbH9LQv4PLqZStmiaBv3h00y/S
   PASFUI+KG8wND923n1kmonkcCU5zpD4UG3GKwnpcbBf/8uOjzSL+wV775
   w==;
X-CSE-ConnectionGUID: JGVeFydZTaecIkkk5ZYR6Q==
X-CSE-MsgGUID: z3iVEZw3QVyoQ06vQgizlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="91783985"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="91783985"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 21:11:27 -0700
X-CSE-ConnectionGUID: EpK096U0S6ORoQqNH1GfqQ==
X-CSE-MsgGUID: +EL2mAYESfeaTgCkztmC4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="243946041"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa004.fm.intel.com with ESMTP; 26 May 2026 21:11:23 -0700
Date: Wed, 27 May 2026 11:47:28 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com
Subject: Re: [PATCH 02/15] x86/virt/tdx: Add extra memory to TDX Module for
 Extensions
Message-ID: <ahZpUA62NRdNrkvZ@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-3-yilun.xu@linux.intel.com>
 <7139c55b-b949-415d-ab82-fca1b1cc3880@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7139c55b-b949-415d-ab82-fca1b1cc3880@intel.com>

> > +static void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
> > +{
> > +	u64 *entries = page_to_virt(root);
> > +	int i;
> > +
> > +	for (i = 0; i < nr_pages; i++)
> > +		clflush_cache_range(__va(entries[i]), PAGE_SIZE);
> 
> Is the page flush only needed when CLFLUSH_BEFORE_ALLOC is true?
> 
> If so, it inherits the same decision to always flush as what

Yes it is basically the same as tdx_clflush_page().

> tdx_clflush_page() did. Then, any chance we can use tdx_clflush_page() here

But I don't think we should convert hpa/page/va back and forth just for
re-using one line of code.

> so that we have a single central place of the comment to explain the kernel
> design decision.

How about I add a comment here to connect this wrapper to
tdx_clflush_page():

/*
 * Unconditionally flush the pages regardless of CLFLUSH_BEFORE_ALLOC. Inherit
 * the same decision as tdx_clflush_page().
 */
static void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
...
