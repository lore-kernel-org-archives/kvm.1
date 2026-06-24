Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D5522D792
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 01:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782266014; cv=none; b=rg/RRvy/eJeF+9qg1OYqw+diMjQ9pzfCSQFJTtJlZRuuoxKOU0N4S9ybd0nBmBM0Kky8YMZAIJ9XPXi0UVfemuvRvtywOoml17zyo45mx8CZk0Oo66YumCtqK8fJOaokPVZAW6ilTGjA3sKk8Xdo9p1M2qD5lWKdOad84ww/c40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782266014; c=relaxed/simple;
	bh=bz/Vkij1MaCN9MtWvj8x8a7EKFIW3H7YE0XMZlCqssk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZM0D9ElT6yagQ++Z5FDOnTq9ioeAGYlq6F0WJaOroVEb/peAXzvNq0R+iKDXV2KHZ5P/V2Qngxc5gnUqkp8m8Zz+/axJTw9F/2lkgiA3vxQUVruBeiXjeRGGpV5YGeI8jn9HWgVaCHy317OffaqCyDVjRDh8veuO48i3CA9fyVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfAmfd73; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfAmfd73"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782266013; x=1813802013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bz/Vkij1MaCN9MtWvj8x8a7EKFIW3H7YE0XMZlCqssk=;
  b=bfAmfd737iDJnWOnxStx436XgmEL4Eve46ruM5uRmGMbsk9KJiSOG1U0
   fIXm6bzt9PRuKMlVcJjxENGtJLEh4bsV1AltierkzJn2GVc3JOMj5QxMU
   QWWdWFUrYRqjeTq3/ccYlsnZq+2nr95j52y6HjgZI4haufk4VnuRsfiU0
   Frt58ntEoqrjwrFEWD0yeKouB9Sf9FfTgZcm5HWm4gGiM2SNPTiRNa4QN
   ZuDxBcQavUHW3fg7xV+nvZzo7qKRrb6/E6I1i0nn8Buw8kqYhhRGLU4aa
   ZnxsaRP0vaPw27PhU3qw6cWDkgmXwhPhveebaH6vY48Jo7hRVYVp6oR93
   g==;
X-CSE-ConnectionGUID: xLzsbnspTju7DakyQYOvKQ==
X-CSE-MsgGUID: 6LLOD08pRkWruN4qXUjHgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93670482"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="93670482"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 18:53:32 -0700
X-CSE-ConnectionGUID: Biwh9WE2Sjax52jTQp36Cg==
X-CSE-MsgGUID: I58BWev5TMiDVsv3U8YozA==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 23 Jun 2026 18:53:29 -0700
Date: Wed, 24 Jun 2026 09:53:28 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, djbw@kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@linux.intel.com,
	yilun.xu@intel.com, xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com, peter.fang@intel.com,
	dave.hansen@intel.com, dave.hansen@linux.intel.com,
	chao.gao@intel.com
Subject: Re: [PATCH v2 04/17] x86/virt/tdx: Add extra memory to TDX module
 for the extensions
Message-ID: <ajs4mH/I+ZHigJZB@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-5-yilun.xu@linux.intel.com>
 <20260618085458.8787A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618085458.8787A1F000E9@smtp.kernel.org>

On Thu, Jun 18, 2026 at 08:54:58AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] Hardware PFN mismatch due to unaligned slab allocation for `hpa_list` with debugging enabled.
> - [Medium] Resource leak of un-added contiguous host memory on TDX module error path.
> - [Medium] Improper use of node_online_map instead of N_MEMORY node states for allocation.
> - [Low] Unnecessary early boot memory allocation error handling returning -ENOMEM.
> --
> 
> commit e910725d57b782da4b05f3bb30b4df0fa4da1da3
> Author: Xu Yilun <yilun.xu@linux.intel.com>
> 
> x86/virt/tdx: Add extra memory to TDX module for the extensions
> 
> This patch introduces a memory feeding process via SEAMCALL TDH.EXT.MEM.ADD
> to allocate one-time memory for TDX module extensions during initialization.
> It allocates contiguous memory and passes it to the module using a newly
> defined HPA_LIST_INFO format.
> 
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > index 6f3596f11d250..dab17822c1c69 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> 
> [ ... ]
> 
> > +static __init int tdx_ext_mem_setup(unsigned int required_pages)
> > +{
> > +	struct tdx_hpa_list *hpa_list;
> > +	struct page *page;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	/*
> > +	 * memory_pool_required_pages == 0 means no need to add pages,
> > +	 * skip the memory setup.
> > +	 */
> > +	if (!required_pages)
> > +		return 0;
> > +
> > +	hpa_list = kzalloc_obj(*hpa_list);
> 
> [Severity: High]
> Does this code pass unaligned physical pages to the hardware if slab
> debugging is enabled?
> 
> When CONFIG_SLUB_DEBUG or KASAN is enabled, slab objects are padded with
> metadata, causing the object to start at a non-zero offset within a physical
> page. The virt_to_page(hpa_list) call below will grab the base page frame
> which the hardware will read from offset 0, leading it to consume SLUB
> metadata instead of the valid hpa_list entries.

I think this is false positive. "For sizes which are a power of two, the
alignment is also guaranteed to be at least the respective size."
according to:

 59bb47985c1d ("mm, sl[aou]b: guarantee natural alignment for kmalloc(power-of-two)")

> 
> Should this allocation use the page allocator directly (e.g.,
> __get_free_page()) to guarantee strict page alignment?
> 
> > +	if (!hpa_list)
> > +		return -ENOMEM;
> > +
> > +	page = alloc_contig_pages(required_pages, GFP_KERNEL, numa_mem_id(),
> > +				  &node_online_map);
> 
> [Severity: Medium]
> Can this allocation fall back to memoryless nodes?
> 
> The node_online_map can include nodes without memory. The mm allocation

I think this is false positive, at least for x86. According to
Documentation/mm/numa.rst, "For some architectures, such as x86, Linux will
"hide" any node representing a physical cell that has no memory attached"

> guidelines require using the N_MEMORY state mask (e.g., node_states[N_MEMORY])
> to correctly constrain memory allocations to nodes that actually have memory.
> 
> > +	if (!page) {
> > +		ret = -ENOMEM;
> 
> [Severity: Low]
> Is this complex error handling necessary here?
> 
> Since tdx_ext_mem_setup() is only called from the __init path, physical memory
> should be available. If an allocation of this size fails during early boot,
> the system likely cannot boot anyway, making graceful error cleanup here
> largely dead code.

It executes at subsys_initcall(), the system can still go on booting.
Free a previously allocated page is not complex.

Actually the error handling would be complex when memory is partially
added for extensions but TDX error happens. In this case for simplicity
the below code leaks all the memory.

> 
> > +		goto out_free_hpa_list;
> > +	}
> > +
> > +	i = 0;
> > +	while (i < required_pages) {
> > +		unsigned int nents = min(required_pages - i,
> > +					 ARRAY_SIZE(hpa_list->phys));
> > +		unsigned int j;
> > +
> > +		for (j = 0; j < nents; j++)
> > +			hpa_list->phys[j] = page_to_phys(page + i + j);
> > +
> > +		ret = tdx_ext_mem_add(virt_to_page(hpa_list), nents);
> > +		/*
> > +		 * No SEAMCALLs to reclaim the added pages. For simple error
> > +		 * handling, leak all pages.
> > +		 */

Maybe the comment is not clear enough so sashiko raised the below
concern, I'll make it more clear:

		/*
		 * No SEAMCALLs to reclaim the added pages. For simple error
		 * handling, intentionally leak all pages, including un-added
		 * pages.
		 */

> > +		WARN(ret, "Fatal: TDX module rejected (%d) memory for extensions, stranded all pages\n",
> > +		     ret);
> > +		if (ret)
> > +			break;
> 
> [Severity: Medium]
> Does this intentionally leak un-added host memory on the error path?
> 
> While pages that have already been accepted by the hardware cannot be
> reclaimed, the remaining contiguous block of pages (from page + i to the end)
> are still entirely host-owned. Could these remaining un-added pages be safely
> freed via free_contig_range() instead of permanently leaking tens of megabytes?
> 
> > +
> > +		i += nents;
> > +	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260618081355.3253581-1-yilun.xu@linux.intel.com?part=4
