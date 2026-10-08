Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE7C374A15
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 04:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791434067; cv=none; b=JuC9GmRj8RD5rMgRA4eYfruvQiLQ1FVeWzfFhnEFOfPf1JqBnOruVwvbfRmPYBbMrAnyzTLtOwuntWRWa/uMysC84t2dic7fsw0RbTG3kYHT998tjYoGhigv9eLVdnPwv6inDyt0reyMi4KeM4bWTwTg+2co7qIIxFcYw5MlgZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791434067; c=relaxed/simple;
	bh=KPbUuvqN+peSMnNqMhXRC3q6y860EcD/n4PjyZP7oVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8LJrC3u4eun3yB+JjY1yR2eKbi4+cEV42D+1kGyGB3+KNqUykG9m//yT4x8lbCHDIdx+9d89dSr0/gY51sgyVFBFROdAof3kq55PFqiJDNEf1sV6xkULOVWxpMpEKBiRjdh2dLdMug/d6SMO22HH7I7WWmp7ondKlvIifmIB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSxXkkSJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSxXkkSJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791434066; x=1822970066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KPbUuvqN+peSMnNqMhXRC3q6y860EcD/n4PjyZP7oVc=;
  b=TSxXkkSJ7qZwPjP50cg1rxGXCC8L43H/+BKTZrsIAVsE/LDD7RjGzT/d
   qNgNF3pGGUg7QQQPqKFI52ocO5y/uKdy/bOxOzaE4DK6d1lbHsaAS2J1W
   1JrlwnLvxflEaJClPpYLJ7JO1+YCpR41kCgJaRKYuDKNp3ZhSILevveXB
   F37ZfQXBi4F349oOBFP+Hmo85OzB765i6H9aKqs6ar1OYYEbLXO27HMRr
   vRnEMtG+1/PoEIoDzXFq858eM7BhGWxz7q/oSe4XrrF8hRPwF7uJxtyRn
   4KxhkupZpw0S3ulDYw7RLhKoEnFiCwkiUoiRpdKaCCw0vgcraxdk28qDB
   w==;
X-CSE-ConnectionGUID: cCoWBoo7TmW2G9aX9zTP4w==
X-CSE-MsgGUID: sHBREuOWQOaoBICnt6lFzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="210209"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="210209"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 21:34:26 -0700
X-CSE-ConnectionGUID: CJVdyR9jR9K/YAB/Tp0Jqg==
X-CSE-MsgGUID: J7jfd14sRcC1QmhA9NV4ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="234217"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa008.fm.intel.com with ESMTP; 07 Oct 2026 21:34:24 -0700
Date: Thu, 8 Oct 2026 12:31:15 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v3 6/6] x86/virt/tdx: Support DPAMT when adding memory
 for the extensions
Message-ID: <ascck27BOXu2QZPR@yilunxu-OptiPlex-7050>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-6-db52cb05b918@linux.intel.com>
 <20261005175713.8B8701F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005175713.8B8701F00893@smtp.kernel.org>

On Mon, Oct 05, 2026 at 05:57:13PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] tdx: allocator thrashing due to unconditional DPAMT allocations
> --
> 
> commit 02adad93d9f4243664b0cea8f1ad9c0b433e79a8
> Author: Xu Yilun <yilun.xu@linux.intel.com>
> 
> x86/virt/tdx: Support DPAMT when adding memory for the extensions
> 
> This commit updates the TDX module extension memory setup to install a 4K
> Dynamic PAMT (DPAMT) for each page before adding it. It calls tdx_pamt_get()
> for each page within the memory chunk.
> 
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > index 5d5f9da1ab028..27a7039ee443c 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > @@ -1330,8 +1330,15 @@ static __init int tdx_ext_mem_setup(void)
> >  		struct page *chunk = page + added_pages;
> >  		unsigned int i;
> >  
> > -		for (i = 0; i < chunk_pages; i++)
> > +		for (i = 0; i < chunk_pages; i++) {
> > +			ret = tdx_pamt_get(page_to_pfn(chunk + i), NULL);
> 
> [Severity: Medium]
> Will calling tdx_pamt_get() sequentially without a DPAMT cache cause severe
> allocator thrashing during boot?
> 
> Looking at tdx_pamt_get(), providing a NULL cache forces an unconditional 
> allocation of DPAMT backing pages before checking the reference count:
> 
> arch/x86/virt/vmx/tdx/tdx.c:tdx_pamt_get() {
>     ...
> 	ret = alloc_pamt_array(pamt_pages, cache);
> 	if (ret)
> 		return ret;
> 
> 	dpamt_refcount = tdx_find_dpamt_refcount(pfn);
> 
> 	spin_lock(&dpamt_lock);
> 
> 	/*
> 	 * If the DPAMT entry is already added (i.e. refcount >= 1),
> 	 * then just increment the refcount.
> 	 */
> 	if (atomic_inc_not_zero(dpamt_refcount))
> 		goto out_free;
>     ...
> out_free:
> 	spin_unlock(&dpamt_lock);
> 	free_pamt_array(pamt_pages);
>     ...
> }
> 
> Since 511 out of 512 pages in each 2MB block will find the entry already
> present, the newly allocated pages are immediately freed. For tens of
> megabytes of extensions, this results in thousands of unnecessary allocations
> and frees. Furthermore, free_pamt_array() performs expensive memory resets,
> leading to unnecessary boot delays.
> 
> Could a struct tdx_pamt_cache be allocated locally in tdx_ext_mem_setup() and
> passed into tdx_pamt_get() to avoid this thrashing?

tdx_pamt_cache is for cases where memory allocation is not possible when
adding DPAMT. I don't think it's good to use tdx_pamt_cache in normal
cases.

> 
> > +			if (ret) {
> > +				WARN(1, "DPAMT setup error for extensions, stranded all pages\n");
> > +				goto out_free_hpa_list;
> > +			}
> > +
> >  			hpa_list->phys[i] = page_to_phys(chunk + i);
> > +		}
> >  
> >  		ret = tdx_ext_mem_add(hpa_list, chunk_pages);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com?part=6
