Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58126366816;
	Mon,  8 Jun 2026 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913189; cv=none; b=UpPkmGje16rJah3PDV3f45q1+vsfatbukmMJ8V2weHSaVofa9lH3esCWYExP6GxZeutwK7s7Kkp6BRjH5M068OjZGqXfTU9RrBHwSczO5qR1r69ptw4d+qSrvEYfoUmF5pHg/rtPsHNgdLRU0ynxI7gXEhe2SNUmJLql4yXyKHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913189; c=relaxed/simple;
	bh=xdhG/ioRhAMR/g7wNYlodNkn4+4Mop5CuoSu7LEokY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYxC6ywDoIPk7M6gaUDlabFkaiapnM81or9wWubODj1347bJeUDNbxf7QJrL1C0pG8GSKemRWbe0M9QFi1dg8+X6DZV1tKnnPSrgf9NI67EyUopTYSQYE9uBiIPL2zU5j7YgPO+Z39lnF6U7TNNiTjJAo6/KO3vroKKWxVR+1H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AN9ZWUJZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AN9ZWUJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780913187; x=1812449187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xdhG/ioRhAMR/g7wNYlodNkn4+4Mop5CuoSu7LEokY8=;
  b=AN9ZWUJZraePhIwcrZtSlbOuUMF+9bkzl1QNlcoxsAA4w4vjtwWebjnS
   jOvArP+DyO449zpaYmCoFFGCjimqK6+rzDgItNuESttItV2o2GmfYqb1Q
   SYoCXNPWbmZNDbS9MqwmUdQpe7lmg+xMazpyey7/PmFsT6UYLfFFRVFuM
   dmCcawDDWOid3SM907tcJJ5eAifS8gaprKYj02iD59nMPKYgYJv3bSNNT
   j/izGxoXpL5o2UaFG5D60TXNtsqg/ZWfVScbS1A8cGOa3ZEuNCbJaotnf
   Tx83y6rxNFCz8rig33Uq1TgLBxk5/kmXhu5hZ1aTVpriuQfYtXCCtrW1K
   Q==;
X-CSE-ConnectionGUID: j5snsPM/RXK9a1vkBKUVxQ==
X-CSE-MsgGUID: wwhQwlK8RXmZpRw+1FtHIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="80778652"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="80778652"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 03:06:27 -0700
X-CSE-ConnectionGUID: a7GXfx0HRJ65XibKJ8VhCw==
X-CSE-MsgGUID: fAgt/Ha0R/Sv7FfZ2yjXmA==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 08 Jun 2026 03:06:23 -0700
Date: Mon, 8 Jun 2026 17:41:52 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 02/15] x86/virt/tdx: Add extra memory to TDX Module for
 Extensions
Message-ID: <aiaOYOlVlz6g1eIT@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-3-yilun.xu@linux.intel.com>
 <f44d997e-49fe-4d48-84e3-e260bb9d3164@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f44d997e-49fe-4d48-84e3-e260bb9d3164@intel.com>

> > +static int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
> > +{
> > +	struct tdx_module_args args = {
> > +		.rcx = to_hpa_list_info(root, nr_pages),
> > +	};
> > +	u64 r;
> > +
> > +	tdx_clflush_hpa_list(root, nr_pages);
> > +
> > +	do {
> > +		/*
> > +		 * TDH_EXT_MEM_ADD is designed to use output parameter RCX to
> > +		 * override/update input parameter RCX, so the caller doesn't
> > +		 * have to do manual parameter update on retry call.
> > +		 */
> > +		r = seamcall_ret(TDH_EXT_MEM_ADD, &args);
> > +	} while (r == TDX_INTERRUPTED_RESUMABLE);
> 
> The retry loop compares the full return value against TDX_INTERRUPTED_RESUMABLE. Should
> it mask with TDX_SEAMCALL_STATUS_MASK first, in case the module sets any
> lower detail bits?

mm.. there is an existing case for TDX_INTERRUPTED_RESUMABLE which
doesn't do the mask:

  err = tdh_phymem_cache_wb(resume);
  switch (err) {
	case TDX_INTERRUPTED_RESUMABLE:
		continue;

I believe we don't mask it. TDX_INTERRUPTED_RESUMABLE should not carry
any lower bits according to its bit definition, if it does it's a
problem we should not skip.

> 
> Ditto for TDH.EXT.INIT in patch 3.
> 
> > +
> > +	if (r != TDX_SUCCESS)
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> > +static int tdx_ext_mem_setup(void)
> > +{
> > +	unsigned int nr_pages;
> > +	struct page *page;
> > +	u64 *root;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	nr_pages = tdx_sysinfo.ext.memory_pool_required_pages;
> > +	/*
> > +	 * memory_pool_required_pages == 0 means no need to add pages,
> > +	 * skip the memory setup.
> > +	 */
> > +	if (!nr_pages)
> > +		return 0;
> > +
> > +	root = kzalloc(PAGE_SIZE, GFP_KERNEL);
> > +	if (!root)
> > +		return -ENOMEM;
> > +
> > +	page = alloc_contig_pages(nr_pages, GFP_KERNEL, numa_mem_id(),
> > +				  &node_online_map);
> 
> The SEAMCALL takes a scatter list (HPA_LIST_INFO), so the module
> doesn't require contiguity. If the goal is just to avoid scattering
> pages across many 2MB regions, maybe dense, 2MB-aligned allocations should
> achieve that without a single pool-wide contiguous block.
> 
> > +	if (!page) {
> > +		ret = -ENOMEM;
> > +		goto out_free_root;
> > +	}
> > +
> > +	for (i = 0; i < nr_pages;) {
> > +		unsigned int nents = min(nr_pages - i,
> > +					 PAGE_SIZE / sizeof(*root));
> > +		int j;
> > +
> > +		for (j = 0; j < nents; j++)
> > +			root[j] = page_to_phys(page + i + j);
> 
> Would it be better to allocate per-batch (i.e. one root page's worth
> at a time) rather than the whole pool up front?
> 
> That way an intermediate TDH.EXT.MEM.ADD failure wouldn't leak
> all nr_pages. Also, a batch is up to 512 pages (= 2MB) and its allocation
> could be 2MB-aligned, addressing your fragmentation concern.

So IIUC allocating 2MB by 2MB has the pros:

  - Larger chance to get the memory.
  - Less memory waste when TDH.EXT.MEM.ADD failed.

and the cons:

  - Still fragment 4M & 1G memory region.


I think first of all we should focus on the normal path when Extension is
successfully initialized and memory is added, note these memory can
never be reclaimed in this case, so memory fragmentation becomes the
primary considration.

And in TDX platform, the TDH.EXT.MEM.ADD failure is not expected to
happen, which means the TDX module is buggy and from Confidential
Computing POV we should not continue, we should change to a new module
and reboot. So less memory waste doesn't matter much actually.

Then, the Extension initialization is done at bootup time. We can get
the memory in big chance. If we really can't, it is a signal that the
system is not well configured for TDX, and failing earlier isn't such
a bad thing to me.

So for now I still think alloc_contig_pages() is better than 2M-by-2M
allocation.

> 
> > +
> > +		ret = tdx_ext_mem_add(virt_to_page(root), nents);
> > +		/*
> > +		 * No SEAMCALLs to reclaim the added pages. For simple error
> > +		 * handling, leak all pages.
> > +		 */
> > +		WARN_ON_ONCE(ret);
> > +		if (ret)
> > +			break;
> > +
> > +		i += nents;
> > +	}
> > +
> > +	/*
> > +	 * Extensions memory can't be reclaimed once added, print out the
> > +	 * amount, stop tracking it and free the root page, no matter success
> > +	 * or failure.
> > +	 */
> > +	pr_info("%lu KB allocated for TDX Module Extensions\n",
> > +		nr_pages * PAGE_SIZE / 1024);
> > +
> > +out_free_root:
> > +	kfree(root);
> > +
> > +	return ret;
> > +}
> > +
> > +static int __maybe_unused init_tdx_ext(void)
> 
> Could this be named init_tdx_extensions() instead to disambiguate
> from tdx_ext_init() in patch 3?

Yes, good to me.

I'm changing all Extensions to Extension, cause the SPEC says "TDX
Module Extension". So I'll use init_tdx_extension().

Thanks,
Yilun
