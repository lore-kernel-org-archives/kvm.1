Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7559B3F2101;
	Mon, 24 Aug 2026 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563121; cv=none; b=RnPHsdqYAX+0MHvBXG8Tv14whs/wjxcEFAHyA0LCk2HUYLDRA2N66nZLiUd6NVRA7CZqizTAMAWqoox5oEIAXO95kRr2w+/mc+IbanDqg7RQgXguC0QAGDofqWH8WNSSe3f9Z73R51fOohSpqUWpEwocWU3vUOclhPWbQprBbMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563121; c=relaxed/simple;
	bh=6BmFy5jb3jLUCgM6DtkO/km+Rgo/GycIWhXxFsToEN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkrs0S/r2lKEP+dPFF25MSZUCo9uuDb1SeS6kca/Cah7UcTuV6aK4dSZHT/8IM0roOJvZ8eYlxdsmaswvh/USEzrAF5BGweu31deqf+/TqclV48vf6i/AntaMBWKezele3xVe4EH532HZSABx0llzvgs4h5tacKAEI1aKce7G6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpsPTujk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpsPTujk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787563117; x=1819099117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6BmFy5jb3jLUCgM6DtkO/km+Rgo/GycIWhXxFsToEN8=;
  b=FpsPTujkrZR2PvqOr94ehv95Q6MfrkhXPwbKH0SLZbHxCm79+K+HxYLB
   AvU9GO9tSmTy4MzSy8VtrWf5NaqlNlb9kb2pqC5gEeUZGzifvu+G5rqqA
   UQjKixXVrfuE5v4QMcw0Hz4B43VpCr6mu58cQTUiNUWbmDcSVxnzzmupP
   MIIdGiS9376mIaOtU2ZAFZJ5OCvwPc9OTCS+X+aHq3EanSXa+jX9nyJ+8
   g+xmjkvo00TP7vnA6Y7H7wEMcjDQtUgzcKXMH4EUVpRy6qKvfsMW7b5Df
   SF5ow19bbl8oKgC85bFzBdsucor5IJMfJqL/bks1t+IDUjsxyk+KU5/lZ
   g==;
X-CSE-ConnectionGUID: D67xrZXwQGu2celo6t7Vgw==
X-CSE-MsgGUID: 1NoqaFMMROKAL2BdZTYYmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="88135214"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="88135214"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 02:18:30 -0700
X-CSE-ConnectionGUID: tzE7G8ZvQ5CtpN3ASW/G8Q==
X-CSE-MsgGUID: yoLLhoXySwOwiI6xTI0OMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="290467966"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa002.fm.intel.com with ESMTP; 24 Aug 2026 02:18:27 -0700
Date: Mon, 24 Aug 2026 17:18:25 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
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
Message-ID: <aowMYbHKK4b0O5P6@yilunxu-OptiPlex-7050>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-5-yilun.xu@linux.intel.com>
 <aohvlMO7ehqcVW96@thinkstation>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aohvlMO7ehqcVW96@thinkstation>

> > The TDX module accepts the memory in the form of a PFN array. This array
> > is passed via a single 64-bit SEAMCALL leaf parameter, which encodes two
> > values: the PFN of the container page holding the array, and the number
> > of entries in the array. Create a helper to encode this format and name
> > it after the TDX module term: HPA_LIST_INFO.
> 
> The array entries are physical addresses, not PFNs. HPA_LIST_INFO encodes
> a PFN, the array does not.

OK. I'll change PFN array => HPA array

[...]

> > +#define TDX_HPA_LIST_MAX_NR_PAGES	(PAGE_SIZE / sizeof(u64))
> > +
> > +struct tdx_hpa_list {
> > +	u64 phys[TDX_HPA_LIST_MAX_NR_PAGES];
> > +};
> > +
> > +static_assert(sizeof(struct tdx_hpa_list) == PAGE_SIZE);

[...]

> > +	hpa_list = kzalloc_obj(*hpa_list);
> > +	if (!hpa_list)
> > +		return -ENOMEM;
> 
> to_hpa_list_info() expects hpa_list to be page-aligned. It happens to
> work with kmalloc for PAGE_SIZE allocation.

The struct tdx_hpa_list definition follows the TDX ABI and is guarenteed
to be PAGE_SIZE by:

	static_assert(sizeof(struct tdx_hpa_list) == PAGE_SIZE);

and kmalloc guarentees the page alignment.

	59bb47985c1d ("mm, sl[aou]b: guarantee natural alignment for kmalloc(power-of-two)")

So I think it's OK, not "happen to work".

> 
> Maybe it is better to allocate it with buddy allocator instead?

It can be, but then we need an extra variable to record the
struct page *, which seems redundant?

> 
> > +
> > +	page = alloc_contig_pages(required_pages, GFP_KERNEL, numa_mem_id(),
> > +				  &node_online_map);
> 
> Why contiguous? TDH.EXT.MEM.ADD takes a list of page addresses and the loop
> below writes every one of them out separately.
> 
> alloc_pages_bulk() fits the chunking that is already here, and a short
> return can be handled per chunk. alloc_contig_pages() isolates and migrates
> to get its range and fails TDX init outright when it cannot find one. PAMT

Yeah, this is not the ABI requirement, but the kernel's consideration. A
brief reasoning in the commit log: avoiding permanent memory fragmentation
and buddy allocator efficiency loss.

Also there is some discussion:

https://lore.kernel.org/all/167d9540-2d9a-4367-bc68-b96494bc4044@intel.com/

TL;DR
  - The memory will never return to the kernel.
  - There is chance that this tens of megabytes will fragment tens of
    gigabytes of memory forever.
  - The chance of fragmentation is actually low since at boot up, but
    let the buddy allocator take care of these never-returned memory
    is not necessary and lowers its efficiency.

> needs it because the TDMR ABI describes each PAMT as base+size. This does
> not.
> 
> > +	if (!page) {
> > +		ret = -ENOMEM;
> > +		goto out_free_hpa_list;
> > +	}
> > +
> > +	added_pages = 0;
> > +	while (added_pages < required_pages) {
> > +		unsigned int chunk_pages = min(required_pages - added_pages,
> > +					       TDX_HPA_LIST_MAX_NR_PAGES);
> > +		struct page *chunk = page + added_pages;
> > +		unsigned int i;
> > +
> > +		for (i = 0; i < chunk_pages; i++)
> > +			hpa_list->phys[i] = page_to_phys(chunk + i);
> > +
> > +		ret = tdx_ext_mem_add(hpa_list, chunk_pages);
> > +		if (ret) {
> > +			/*
> > +			 * This SEAMCALL leaf shouldn't fail, and if it does,
> > +			 * things are broken enough that complex error handling
> > +			 * isn't worth it. Intentionally leak all pages,
> > +			 * including un-added pages.
> > +			 */
> > +			WARN(1, "Fatal: TDX module rejected memory for extensions, stranded all pages\n");
> > +			break;
> 
> It supposed to be
> 			goto out_free_hpa_list;
> 
> No?

The difference is to print the memory amount or not. For simple error
handling, we stranded all pages, we let users know the cost even if the
initialization fails.

> 
> 
> > +		}
> > +
> > +		added_pages += chunk_pages;
> > +	}
> > +
> > +	/*
> > +	 * Memory for TDX module extensions is never reclaimed and can be tens
> > +	 * of megabytes. Print the amount so users know the cost.
> > +	 */
> > +	pr_info("%lu KB consumed for TDX module extensions\n",
> > +		required_pages * PAGE_SIZE / 1024);
> > +
> > +out_free_hpa_list:
> > +	kfree(hpa_list);
> > +
> > +	return ret;
> > +}
> > +

[...]

> > --- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> > @@ -137,6 +137,12 @@ static __init int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
> >  	int ret;
> >  	u64 val;
> >  
> > +	ret = read_sys_metadata_field(0x3100000200000000, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	sysinfo_ext->memory_pool_required_pages = val;
> > +
> 
> Why above ext_required read?

I want to sort them in ascending order of the field ID, so reviewers can
seach them more easily.

> Is it even valid to read it in such case?

It is OK. The two ext metadata are both valid after TDX feature
configurations.

The ext_required == 0 && memory_pool_required_pages > 0 is highly
suspicious based on our current understanding, but that's more of a
module BUG, not caused by metadata reading order.

> 
> >  	ret = read_sys_metadata_field(0x3100000000000001, &val);
> >  	if (ret)
> >  		return ret;
> > -- 
> > 2.25.1
> > 
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
