Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9843D75B5;
	Fri, 28 Aug 2026 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903183; cv=none; b=gzky0Wmy0MTcIkDa7UMkDbIlq+3ppC3GAcN10l5zhG7cU09G1WfD/vnbkGCI34joB6QWgmif70urTUnZNG0fca1k9Zimgbx38+gydu1s0G8o6qQeeWADgyj21aK11YRZR/dWjdkLqKXjE+IrWBmmSEPtSkbEO/7cQTSgtbEJQhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903183; c=relaxed/simple;
	bh=FGipmyMz958iY6A+TN8aB96juz7DcHiErilOO3Ic4+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YH/MLADvHAihaOflxnbKZBKVIv7kHyJakbH5hEUmxncTXDvIBIEu4D8IPda3S5lWdpaclbWyLbT2ztdmLpOB9n2BiCakAyaw1wZJhMhEoleTWMZOzXpcwrvBZKVc03qRlavCKL74L7r3OCWyBszKfhwwqv/Oyc62hF2RQf5A7fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xh9gNG7b; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xh9gNG7b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787903182; x=1819439182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FGipmyMz958iY6A+TN8aB96juz7DcHiErilOO3Ic4+Y=;
  b=Xh9gNG7bLHk1ZuMMCoezwnPrJSkgYAD3c1n9kjUyOQgsa24vCxLtR3oa
   0D75EDa0ygbj6l5FkoXC8ADoi1E8J11f1RAKcdm6+tMhyj8OSLBYkozkW
   RV7K0bYATb94lBI17LewzvKNc3arAl+WPdOTtc4co8KwML0xJgczxnUq1
   YgCeGPf9L8p/bGQDsZR0iuHEaz0S2JZEG+0RXkc2yi45p0kA44PC+rK7n
   wor2QVTmGdIr6KyH8lp0BtSRLFOS7U4cKSNFXU/9Xvs11L5tZxiYw2jwN
   v+IcBRr8pkc4BVqG8XspSRUKM450kB2BQxR2D8+7Jkg6BbgaTHO71HJBB
   A==;
X-CSE-ConnectionGUID: aZkcx93uSVi3Z6znVeOfCA==
X-CSE-MsgGUID: duPJhEjXSFKCFUkAhQsRUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99569637"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="99569637"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 00:46:21 -0700
X-CSE-ConnectionGUID: McO27ZScT52UaVA+WBVg0g==
X-CSE-MsgGUID: O/t3SgKfRBOFjbMLE7p+sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="267498472"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa008.jf.intel.com with ESMTP; 28 Aug 2026 00:46:17 -0700
Date: Fri, 28 Aug 2026 15:46:16 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Kiryl Shutsemau <kas@kernel.org>, david@kernel.org, linux-mm@kvack.org
Cc: x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com,
	yilun.xu@intel.com, xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com, peter.fang@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	chao.gao@intel.com, artem.bityutskiy@linux.intel.com,
	kvm@vger.kernel.org
Subject: Re: [PATCH 4/6] x86/virt/tdx: Add extra memory to TDX module for the
 extensions
Message-ID: <apE8yHrGx/bfifV9@yilunxu-OptiPlex-7050>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-5-yilun.xu@linux.intel.com>
 <aohvlMO7ehqcVW96@thinkstation>
 <aowMYbHKK4b0O5P6@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aowMYbHKK4b0O5P6@yilunxu-OptiPlex-7050>

> > > +	page = alloc_contig_pages(required_pages, GFP_KERNEL, numa_mem_id(),
> > > +				  &node_online_map);
> > 
> > Why contiguous? TDH.EXT.MEM.ADD takes a list of page addresses and the loop
> > below writes every one of them out separately.
> > 
> > alloc_pages_bulk() fits the chunking that is already here, and a short
> > return can be handled per chunk. alloc_contig_pages() isolates and migrates
> > to get its range and fails TDX init outright when it cannot find one. PAMT
> 
> Yeah, this is not the ABI requirement, but the kernel's consideration. A
> brief reasoning in the commit log: avoiding permanent memory fragmentation
> and buddy allocator efficiency loss.
> 
> Also there is some discussion:
> 
> https://lore.kernel.org/all/167d9540-2d9a-4367-bc68-b96494bc4044@intel.com/
> 
> TL;DR
>   - The memory will never return to the kernel.
>   - There is chance that this tens of megabytes will fragment tens of
>     gigabytes of memory forever.
>   - The chance of fragmentation is actually low since at boot up, but
>     let the buddy allocator take care of these never-returned memory
>     is not necessary and lowers its efficiency.

Hi Kiryl & David:

I see there is another suggestion that the whole memory adding process
could be a little simpler if we allocate & add pages 4k by 4k [1],
rather than one-time pre-allocation. The concern of this alternative is,
as said above, memory fragmentation.

[1] https://lore.kernel.org/lkml/f48b83feb2ee1d3c88b5a1627cf35b4b282d3f90.camel@intel.com/

And I've realized the memory fragmentation discussion is not actually
closed in previous thread [2]. We need more input.

[2] https://lore.kernel.org/all/167d9540-2d9a-4367-bc68-b96494bc4044@intel.com/

Let me give a brief overview of the problem:

Intel TDX (Trust Domain Extensions) is a feature for confidential
computing. A secure firmware called "TDX module" runs in an isolated
environment to provide services about security.

In Linux, the host initializes TDX module at boot up time
(subsys_initcall()). During the initialization, the host must donate
tens of mega bytes physical memory (35M ~ 110M in the forseeable
future) to the TDX module. These memory will *never be revoked* cause
the TDX Module initialization is a one way path.

The TDX Module doesn't require this memory be physically contiguous. But
the kernel side concern is if we do PAGE_SIZE allocation, it may
permanently fragment memory regions, stop them from allocating 2M huge
pages. In worst case, ~50G (110M * 512) memory regions affacted.

So is the physically contiguous allocation really a better choice here?
We appreciate inputs from mm folks. Thanks!

Yilun

> 
> > needs it because the TDMR ABI describes each PAMT as base+size. This does
> > not.
> > 
> > > +	if (!page) {
> > > +		ret = -ENOMEM;
> > > +		goto out_free_hpa_list;
> > > +	}
> > > +
> > > +	added_pages = 0;
> > > +	while (added_pages < required_pages) {
> > > +		unsigned int chunk_pages = min(required_pages - added_pages,
> > > +					       TDX_HPA_LIST_MAX_NR_PAGES);
> > > +		struct page *chunk = page + added_pages;
> > > +		unsigned int i;
> > > +
> > > +		for (i = 0; i < chunk_pages; i++)
> > > +			hpa_list->phys[i] = page_to_phys(chunk + i);
> > > +
> > > +		ret = tdx_ext_mem_add(hpa_list, chunk_pages);
> > > +		if (ret) {
