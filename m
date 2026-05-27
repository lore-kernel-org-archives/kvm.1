Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4B93CE080;
	Wed, 27 May 2026 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868586; cv=none; b=A4WKCFvZcCKyo/HtXm/Aoy1Ds8xvXfZyY1Z26T3GG5UhSXf+uxmqQbgGkOp9a4N5dwj0Eg2buEYEMk1/mAe6pk64PhddnvdNYqXsItsiqapNZIksK4KMI8JbTVLH+a2le0fQEKKSwTHh3Pi+CHxQBjSMHqUz77BiqIVmh35z4Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868586; c=relaxed/simple;
	bh=8rHGBIQPMCTcqx6jR56j1kHsM2oLZhWmpIttoHrS7lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQv3+8A1xUap6C+E7Bx7cnWgvkJetZCCCQPchOdxOsWCTu8BY584272MBVr+cADJXi3nwpY8oFUiYtclDEkPduxOCq+mGCxJb8xIeY1NRJbysNbEAqo3e+YYmdrfHu9L+ob5xlwSci40PtCsnrPOoZHuhWncncx28OM1NlPUHfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TaxLajx4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TaxLajx4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779868585; x=1811404585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8rHGBIQPMCTcqx6jR56j1kHsM2oLZhWmpIttoHrS7lc=;
  b=TaxLajx4/5lTA4NP5AUAfGr7llH4z+BmV/hvEI5Hrv2H4jtc1jivK0hZ
   QPskfKN2dYLQyTibPjFwfs4ZODlOXWxdddYwMfbeSZkukpIuZn7PFzD/N
   tORltaPTB55QZPDlQSxFTA2gOLV9hjPIVrcmV6zzGTv29tmHJV8CxiWdy
   flICbf8LE43O865EPeCFDBzl1bsxCQ1zXovauUOHJ+TzcbGGXZmjSbAtk
   wFo3XuHGxCocWpSkt0IBzfv6nM8WQPVzxuVG6sndbojc1OUwzPjFzDTRY
   QiEOTuYBmwbOCaQedlGu2CHPdblSNsmddUUyUiWixifF4Iu4LKfRkK3k6
   Q==;
X-CSE-ConnectionGUID: Bu/lWU2ARNKXF5DPR20LgQ==
X-CSE-MsgGUID: z8rLYtcmQzGBbFqP56SQUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80676089"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="80676089"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 00:56:23 -0700
X-CSE-ConnectionGUID: 87OoO+63S+S9k2vgZnRz4A==
X-CSE-MsgGUID: tkb4X4nAS3acuLTotvlgwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="272495460"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 27 May 2026 00:56:19 -0700
Date: Wed, 27 May 2026 15:32:24 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com
Subject: Re: [PATCH 02/15] x86/virt/tdx: Add extra memory to TDX Module for
 Extensions
Message-ID: <ahaeCGLPEfmYNFtC@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-3-yilun.xu@linux.intel.com>
 <7139c55b-b949-415d-ab82-fca1b1cc3880@intel.com>
 <ahZpUA62NRdNrkvZ@yilunxu-OptiPlex-7050>
 <9073ac91-3aa4-41e2-bb81-8878409498e5@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9073ac91-3aa4-41e2-bb81-8878409498e5@intel.com>

On Wed, May 27, 2026 at 02:38:27PM +0800, Xiaoyao Li wrote:
> On 5/27/2026 11:47 AM, Xu Yilun wrote:
> > > > +static void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
> > > > +{
> > > > +	u64 *entries = page_to_virt(root);
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < nr_pages; i++)
> > > > +		clflush_cache_range(__va(entries[i]), PAGE_SIZE);
> > > 
> > > Is the page flush only needed when CLFLUSH_BEFORE_ALLOC is true?
> > > 
> > > If so, it inherits the same decision to always flush as what
> > 
> > Yes it is basically the same as tdx_clflush_page().
> > 
> > > tdx_clflush_page() did. Then, any chance we can use tdx_clflush_page() here
> > 
> > But I don't think we should convert hpa/page/va back and forth just for
> > re-using one line of code.
> 
> Because we want/need to flush page as late as possible so that the page
> flush needs to happen right before SEAMCALL?

I think so. Let the flushing be part of the tdh call semantic.

> 
> How about we pass in the struct page * and number into tdx_ext_mem_add() and
> construct the root page inside it?

I assume you don't suggest allocate root page inside the call, then we
need 3 parameters for the HPA_LIST_INFO:

  struct page *, unsigned int nr_pages, struct page *root

which I think too much.

I think your concern is to try not to introduce another tdx_clflush_
variant, but I believe this will happen, pfn based memory description is
on the way:

https://lore.kernel.org/all/20260430014929.24210-1-yan.y.zhao@intel.com/
