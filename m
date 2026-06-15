Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC320409601;
	Mon, 15 Jun 2026 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540400; cv=none; b=iG+yubVLw/mAGgX7EqjDwA9/Ymvyk683znTFB9bsK3h/xDK9Yv0ggoUshj5l783SwhoSwGNEASdNFfPaYrWaBjXqhsLFnspDqHOHJjyZHW9KpUcBkruNQEPWEphj9y8m1jSvNxwRlMG6dIf6ZnaTmC9dS6MtEczv84Tv3/+W+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540400; c=relaxed/simple;
	bh=v+GlP93c2gOOWA0G1d+CAuYo07g+93rnM6Sk2lU9G9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocM5rZd1VvSFhSU0/8rOLI/6CqwJh6Re5B/+qPAFWKI16wK33pDEWJ1QRdcUCSqRH5gKV9TA9Ol55bgixtBJr8Rzywd/2eBQlHfyc/bjQH6eyYOH2q+F6xO22ujGiB1b3EPhUeHfdp/VYgmZQOBvKtd36EHv7RjcNjSTBJFUsKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O48lS74E; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O48lS74E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781540399; x=1813076399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v+GlP93c2gOOWA0G1d+CAuYo07g+93rnM6Sk2lU9G9c=;
  b=O48lS74EAxdq6rFWvhjywH4ERtPkjDsJsZCkKB6QO/W+j99wMuv3XVUD
   IDntoT5kpGwZRZaCYJZb2/Ff9StmWN+jz1Nb8DK9QNcuDyHaiwcMkj42A
   rueZHIoS3c97kAr1CEiG3OTCf3orDmKCDS5lJzbwJn02Ms5xFWtFXMXqM
   Dn23HSVUH4TixNBdolzACfLDCNbvN8bHE432sSZG2nD7ym57AFznoMYOe
   hp+5Kto2T4L5W6qWbAwdZquaPwp+ZnSjFYL0XsXZKjkWphThyKhnjMBWH
   O/ctJxTibLKfQxAM7Sdm0/xnRoPt+XlSwZwNOX3jrUhGTEFJ4IuRJWrCa
   A==;
X-CSE-ConnectionGUID: 82bI42orQdmzsIPxUcQIbA==
X-CSE-MsgGUID: 3HoThqWHS4OcS9AjnQeQyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="84850660"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="84850660"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 09:19:58 -0700
X-CSE-ConnectionGUID: NL9yBQEmRlepxMkEJtIe3g==
X-CSE-MsgGUID: +AaJ1TCjSuKCqWcSkGoBsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="271591183"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 15 Jun 2026 09:19:55 -0700
Date: Mon, 15 Jun 2026 23:55:03 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: kas@kernel.org, rick.p.edgecombe@intel.com, x86@kernel.org,
	peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 02/15] x86/virt/tdx: Add extra memory to TDX Module for
 Extensions
Message-ID: <ajAgV+aXsYIJyT6+@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-3-yilun.xu@linux.intel.com>
 <6a2c9b10574ce_9b8551005d@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a2c9b10574ce_9b8551005d@djbw-dev.notmuch>

On Fri, Jun 12, 2026 at 04:49:36PM -0700, Dan Williams (nvidia) wrote:
> Xu Yilun wrote:
> > TDX Module introduces a new concept called "TDX Module Extensions" to
> > support long running / hard-irq preemptible flows inside. This makes TDX
> > Module capable of handling complex tasks through "Extension SEAMCALLs".
> > Adding more memory to TDX Module is the first step to enable Extensions.
> 
> Like I said on the cover, I think "long running hard-irq preemptible"
> invites more questions that it answers. The service calls are not "long
> running" on their own. I think it is sufficient to say they are
> resumable unlike typical calls that run to completion while monopolizing
> the CPU.

Yes, I'll drop long running, keep preemptible and resumable.

> 
> > Currently, TDX Module memory use is relatively static. But, the
> > Extensions need to use memory more dynamically. While 'static' here
> > means the kernel provides necessary amount of memory to TDX Module for
> > its basic functionalities, 'dynamic' means extra memory is needed only
> > if new add-on features are to be enabled. So add a new memory feeding
> > process backed by a new SEAMCALL TDH.EXT.MEM.ADD.
> 
> Rick commented on this as well, but a simpler way to say it is
> extensions receive a one time memory pool allocation at init time.  The
> extension uses that pool as its baseline for its own internal state and
> data for the service APIs it offers.

Good to me.

> > For now, TDX Module Extensions consumes relatively large amount of
> > memory (~50MB). Use contiguous page allocation to avoid permanently
> > fragment too much memory. Print the allocation amount on TDX Module
> > Extensions initialization for visibility.
> 
> To be clear I believe there is a low chance of fragmentation given this
> allocation happening early. However, at 10s of MB the benefit of
> isolating blocks of PFNs that will never be returned, it makes to not
> use the buddy allocator for that.

Agree. I'll change it as:

For now, TDX module extensions consume tens of megabytes memory that
will never be returned to host. Use contiguous page allocation to
isolate these large blocks entirely, avoiding permanent memory
fragmentation and reducing buddy allocator efficiency. Print ...


> > +	u64 *root;

...

> > +	root = kzalloc(PAGE_SIZE, GFP_KERNEL);
> > +	if (!root)
> > +		return -ENOMEM;
> 
> I think this "root" term is a holdover from the complicated TDX Connect

Agree. I really don't have to introduce a new "root" page term. The SPEC
says "The HPA_LIST is a 4KB page which contains a list of HPAs", so
hpa_list page is a good name.

> case where it might sometimes be this odd "singleton" object? You could
> just make it this for actual type safety.
> 
> struct tdx_hpa_list {
> 	u64 phys[PAGE_SIZE/sizeof(u64)];
> }
> 
> > +
> > +	page = alloc_contig_pages(nr_pages, GFP_KERNEL, numa_mem_id(),
> > +				  &node_online_map);
> > +	if (!page) {
> > +		ret = -ENOMEM;
> > +		goto out_free_root;
> > +	}
> > +
> > +	for (i = 0; i < nr_pages;) {
> > +		unsigned int nents = min(nr_pages - i,
> > +					 PAGE_SIZE / sizeof(*root));
> 
> This looks wrong, sizeof(struct page)?, or size of physical address?
> 
> Becomes less error prone if you do:
> 
> min(nr_pages - i, ARRAY_SIZE(hpa_list->phys))

OK, let me try.

> > +		ret = tdx_ext_mem_add(virt_to_page(root), nents);
> > +		/*
> > +		 * No SEAMCALLs to reclaim the added pages. For simple error
> > +		 * handling, leak all pages.
> > +		 */
> > +		WARN_ON_ONCE(ret);
> 
> Perhaps to be friendlier to folks without the source code in front of
> them drop the comment and do:
> 
> WARN(ret, "Fatal: TDX Module failed (%d) to accept memory, stranded %ld pages\n", ret, nr_pages)
> 
> ...the once flavor not needed, right? It's toast at this point.

Yes no need the 'once'.

Since I'll print all memory for the extensions anyway below. I'll use:

	WARN(ret, "Fatal: TDX Module rejected (%d) memory for extensions, stranded all pages\n",
	     ret);

Thanks,
Yilun
