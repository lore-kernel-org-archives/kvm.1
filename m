Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780682EEE65
	for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791600024; cv=none; b=RNbvON47hNRD0cKbd4DxCDQWVjVDuYP0ZWL6yoDCEg1H6qjf6+leK8vkj8uFaId/hBS+CFgRh/1CyXk8pj+ZC8EZ+4VCuZaHe9gWXC53Vv97vp/UYRKUwvL7QOvCsBJuIpAODc4auIVvONc7CQJd21pDXMI+UZv1qR205q0Ht2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791600024; c=relaxed/simple;
	bh=DAv2lGZNEYyEmpJIp6O+QJPNTHRxuMSTPeIp2pd6j8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSnIQw33fSR5CB8lrReZq7l1XKWuilmrbT9CQ03rHubU2RTLKa5hihAGxNZ6EUmAcA8MoaFnwAwJ1eYXbzGvGn6TMKKQD9HIY3elbFnStQkFE3o7iIALXDrWzrjJMIwtg+JBd52OASJ0Uvdh+pbEVgRenwpxyNT+gDUV+sXnURE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k8jjfIqj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8jjfIqj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791600023; x=1823136023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DAv2lGZNEYyEmpJIp6O+QJPNTHRxuMSTPeIp2pd6j8E=;
  b=k8jjfIqj9zyo84HtFRo1xo11Vba5ZUaA5zy/nNj5D4gGTCow64XkqwGD
   rCZdisxY6sXxoL/dPvuosuHWmsd7k4QqCFVnapfTWl9oQGAPvvwkaPrbX
   jURQEBzvpQgdggrE5YNyxh7UGNeyh4BOdREx8RV0lXzwuqxzAt5NitqFV
   FhpOjVFFYEF4R1a169wmbOkr6s0+PzkBayVbl5IOIASohe+yG4T+JR6cx
   ZinNKghFTAMpT7ATJTZMLGzxsUkyyPC1YGALSdrq/pLhmYRcU0LsFGG2c
   8GG7/vg9ZdtI+S1b4ywehojZLrbsbgeh0ZO1veDc+bOhatw4/O7Q3jOF4
   Q==;
X-CSE-ConnectionGUID: i+2m2eOdQHGZu0vLBj+mrQ==
X-CSE-MsgGUID: b2b8k1FvT6mTQXvSyaUhlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="497216"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="497216"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 19:40:23 -0700
X-CSE-ConnectionGUID: daDIJ8W4SeOo5ZQuLgWpow==
X-CSE-MsgGUID: ktuPim/LRNCxI4Pvc0CJVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="389019"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa007.jf.intel.com with ESMTP; 09 Oct 2026 19:40:23 -0700
Date: Sat, 10 Oct 2026 10:36:56 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v3 3/6] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Message-ID: <asmkyPf3VKXZn4QZ@yilunxu-OptiPlex-7050>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-3-db52cb05b918@linux.intel.com>
 <20261005175653.03C341F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005175653.03C341F000FF@smtp.kernel.org>

On Mon, Oct 05, 2026 at 05:56:52PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] x86/virt/tdx: kzalloc() breaks page alignment for hardware-facing struct under debug
> --
> 
> commit b27e647d007dabaa3a6b0eda05701af51bffc99e
> Author: Xu Yilun <yilun.xu@linux.intel.com>
> 
> x86/virt/tdx: Add extra memory to TDX module for the extensions
> 
> This commit introduces a new SEAMCALL leaf TDH.EXT.MEM.ADD to allocate and
> add execution environment memory to the TDX module for extensions. It allocates
> a page-sized structure tdx_hpa_list to pass the physical addresses of the
> allocated memory to the hardware.
> 
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > index f08278a47affc..c445359335516 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> 
> [ ... ]
> 
> > +static __init u64 to_hpa_list_info(struct tdx_hpa_list *hpa_list,
> > +				   unsigned int nr_pages)
> > +{
> > +	return FIELD_PREP(HPA_LIST_INFO_FIRST_ENTRY, 0) |
> > +	       FIELD_PREP(HPA_LIST_INFO_PFN, PFN_DOWN(__pa(hpa_list))) |
> 
> [Severity: High]
> If the hpa_list pointer is unaligned due to slab redzones, does this

The size of struct tdx_hpa_list is guaranteed to be page aligned by:

  static_assert(sizeof(struct tdx_hpa_list) == PAGE_SIZE);

So the allocated pointer must be page aligned, see below...

> PFN_DOWN() truncation cause the TDX module to read the redzone metadata
> instead of the actual array?
> 
> > +	       FIELD_PREP(HPA_LIST_INFO_LAST_ENTRY, nr_pages - 1);
> > +}
> 
> [ ... ]
> 
> > +static __init int tdx_ext_mem_setup(void)
> > +{
> > +	unsigned int required_pages, added_pages;
> > +	struct tdx_sys_info_ext sysinfo_ext;
> > +	struct tdx_hpa_list *hpa_list;
> > +	struct page *page;
> > +	int ret;
> 
> [ ... ]
> 
> > +	/*
> > +	 * Allocate the container page for the HPA_LIST. tdx_hpa_list is
> > +	 * guaranteed to be page-sized by static_assert(), so kzalloc()
> > +	 * guarantees the page alignment.
> > +	 */
> > +	hpa_list = kzalloc_obj(*hpa_list);
> 
> [Severity: High]
> Does kzalloc_obj() actually guarantee page alignment when CONFIG_KASAN or
> CONFIG_SLUB_DEBUG are enabled?
> 
> Since slab redzones offset the object within the page, a PAGE_SIZE allocation
> through the slab allocator might not return a page-aligned address under
> these debug configurations.

This is false positive. The following commit guarantees "the kmalloc()
alignment to size explicitly guaranteed for power-of-two sizes under all
configurations."

 59bb47985c1d ("mm, sl[aou]b: guarantee natural alignment for kmalloc(power-of-two)")

> 
> Would it be safer to use the page allocator (e.g. alloc_page() or
> get_zeroed_page()) instead of the slab allocator for a structure that requires
> strict page alignment when passed to hardware?
> 
> > +	if (!hpa_list)
> > +		return -ENOMEM;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com?part=3
