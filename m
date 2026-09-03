Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C32144065A;
	Thu,  3 Sep 2026 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432013; cv=none; b=HF2eZmM2aGzadWCg6Mk/I6kwHQ9MeGwfj5cqBh+WPEYxKKITrgvzxDAVrUMFRs838ttT3wLipkFxbl38/9PuRuuOz6nmV3wPmCj6xop1FL+yu2C3axFZ13iy4c5qtDmx5vD09wdNyZEFsz+BR1+9o4iiSlxWmBwTbL4a2Dpeizg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432013; c=relaxed/simple;
	bh=BYVJynyohII4KtOhdVCwIs7zjy1IbgGwaJjNCx9gEDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzf2H15BhONuiaPt/2CFTxK1VTJsf6qlJd8MPqLWKJpkIHukEsaTJq2+zWe6YXZ3IZCw64SLvmRFQArdNA9qOe83csvRBUvjHF4k0FrW2oFol+4Nb2fSdeC98Gzbf0rQw66SNgAHKCPR9DSZ84RHZLMSq8YRfj4eLZNSLczfpxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpHCXVTb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpHCXVTb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788432010; x=1819968010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BYVJynyohII4KtOhdVCwIs7zjy1IbgGwaJjNCx9gEDs=;
  b=IpHCXVTbWa/cV2I3bv2jF4xZNqFTOV7Wl/vlu8kICN8YPFG+xzlRZWbF
   FeHL1p+UO04gQOlXRQ78BOOHMYn4sxfLSe+YWMd3v/3+HK+eWX14mSpqf
   7xJBuVFOV1F/bvlVo4uNyJTBgO+wuG2hOF8vGKsGHNct2DWd8BobgN7kO
   FcCUKfSWer24WaqJZgLJRqiXmgcrZUunhY4/Ehn38BwC3aLUq3G1LzCx5
   ASayFEaDnUNnwrW50MCl3oNwmYmiAcAVDRR5M5uWTYyLN29Mzt3bHnT3A
   /zyDGEqRdrDoResGWxzU3UDUW+rb+KbkEFv02WW/g7lolX2mOcO2ONrpW
   Q==;
X-CSE-ConnectionGUID: KxQKp8R/RYadVNy2Ltf60g==
X-CSE-MsgGUID: Vloz23RlTAKENujIS5tByA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="106430689"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="106430689"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 03:40:09 -0700
X-CSE-ConnectionGUID: 3+W4Vo7IQim3ma8iAFHTfw==
X-CSE-MsgGUID: 0CWgmwMFQYekpaJG+/3VSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="269153261"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa008.jf.intel.com with ESMTP; 03 Sep 2026 03:40:05 -0700
Date: Thu, 3 Sep 2026 18:40:04 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: david@kernel.org, linux-mm@kvack.org, x86@kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com, peter.fang@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	chao.gao@intel.com, artem.bityutskiy@linux.intel.com,
	kvm@vger.kernel.org
Subject: Re: [PATCH 4/6] x86/virt/tdx: Add extra memory to TDX module for the
 extensions
Message-ID: <aplOhHWvaxqUJDqu@yilunxu-OptiPlex-7050>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-5-yilun.xu@linux.intel.com>
 <aohvlMO7ehqcVW96@thinkstation>
 <aowMYbHKK4b0O5P6@yilunxu-OptiPlex-7050>
 <apE8yHrGx/bfifV9@yilunxu-OptiPlex-7050>
 <apf6WFKun8z4ejG8@thinkstation>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apf6WFKun8z4ejG8@thinkstation>

On Wed, Sep 02, 2026 at 11:54:25AM +0100, Kiryl Shutsemau wrote:
> On Fri, Aug 28, 2026 at 03:46:16PM +0800, Xu Yilun wrote:
> > > > > +	page = alloc_contig_pages(required_pages, GFP_KERNEL, numa_mem_id(),
> > > > > +				  &node_online_map);
> > > > 
> > > > Why contiguous? TDH.EXT.MEM.ADD takes a list of page addresses and the loop
> > > > below writes every one of them out separately.
> > > > 
> > > > alloc_pages_bulk() fits the chunking that is already here, and a short
> > > > return can be handled per chunk. alloc_contig_pages() isolates and migrates
> > > > to get its range and fails TDX init outright when it cannot find one. PAMT
> > > 
> > > Yeah, this is not the ABI requirement, but the kernel's consideration. A
> > > brief reasoning in the commit log: avoiding permanent memory fragmentation
> > > and buddy allocator efficiency loss.
> > > 
> > > Also there is some discussion:
> > > 
> > > https://lore.kernel.org/all/167d9540-2d9a-4367-bc68-b96494bc4044@intel.com/
> > > 
> > > TL;DR
> > >   - The memory will never return to the kernel.
> > >   - There is chance that this tens of megabytes will fragment tens of
> > >     gigabytes of memory forever.
> > >   - The chance of fragmentation is actually low since at boot up, but
> > >     let the buddy allocator take care of these never-returned memory
> > >     is not necessary and lowers its efficiency.
> > 
> > Hi Kiryl & David:
> > 
> > I see there is another suggestion that the whole memory adding process
> > could be a little simpler if we allocate & add pages 4k by 4k [1],
> > rather than one-time pre-allocation. The concern of this alternative is,
> > as said above, memory fragmentation.
> > 
> > [1] https://lore.kernel.org/lkml/f48b83feb2ee1d3c88b5a1627cf35b4b282d3f90.camel@intel.com/
> > 
> > And I've realized the memory fragmentation discussion is not actually
> > closed in previous thread [2]. We need more input.
> > 
> > [2] https://lore.kernel.org/all/167d9540-2d9a-4367-bc68-b96494bc4044@intel.com/
> > 
> > Let me give a brief overview of the problem:
> > 
> > Intel TDX (Trust Domain Extensions) is a feature for confidential
> > computing. A secure firmware called "TDX module" runs in an isolated
> > environment to provide services about security.
> > 
> > In Linux, the host initializes TDX module at boot up time
> > (subsys_initcall()). During the initialization, the host must donate
> > tens of mega bytes physical memory (35M ~ 110M in the forseeable
> > future) to the TDX module. These memory will *never be revoked* cause
> > the TDX Module initialization is a one way path.
> > 
> > The TDX Module doesn't require this memory be physically contiguous. But
> > the kernel side concern is if we do PAGE_SIZE allocation, it may
> > permanently fragment memory regions, stop them from allocating 2M huge
> > pages. In worst case, ~50G (110M * 512) memory regions affacted.
> > 
> > So is the physically contiguous allocation really a better choice here?
> > We appreciate inputs from mm folks. Thanks!
> 
> What matters for fragmentation is not contiguity, it is how many
> pageblocks are left partially occupied by unmovable pages that are never
> freed.
> 
> So you can ask one pageblock at a time with
> 
> 	page = alloc_pages(GFP_KERNEL | __GFP_NOWARN, order);
> 
> with fallback to lower order if you must.
> 
> It also fits the ABI: pageblock_order is 9 on x86, i.e. 512 pages, which
> is exactly TDX_HPA_LIST_MAX_NR_PAGES. One allocation is one full HPA list
> is one TDH.EXT.MEM.ADD, so the allocation loop and the chunking loop
> become the same loop.
> 
> But alloc_contig_pages() might be a good enough approximation for
> per-pageblock allocation if we do it during the boot when fragmentation
> is low.

IIUC, you mean alloc_contig_pages() also gives good de-fragmentation
that we need. But it would be slightly easier to fail cause it requires
extra contiguity that we don't need.

Multiple alloc_pages(order-9) meets our requirement exactly but the
falling back to lower order may create more fragments. And we can do
this because of the ABI definition - an HPA_LIST could happen to hold
an entire pageblock.

If I have to choose, I prefer alloc_contig_pages(). It doesn't have to
depend on HPA_LIST ABI details.

> 
> My alloc_pages_bulk() suggestion is wrong. It doesn't get any control
> over allocation placement. It will tap in the per-CPU cache first.
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
