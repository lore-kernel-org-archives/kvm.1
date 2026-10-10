Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08973C0621;
	Sat, 10 Oct 2026 03:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791602622; cv=none; b=WMnlB5npZcGdSwl+n9jQE18EbodsTsi6JtagQcIiiCC3sTn4Ul46iQUIKirVjXR7YixfYjisoHKm3xAXAi8VQfOs7jQhYhtsqu+Y2Kgu1HkIwC7Gv+NPnCCh3o+Mtyn46fOiYn3O6I46WU4Wt5Kmtr4iJCB40Z/FutJNjDZEuc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791602622; c=relaxed/simple;
	bh=boeBybVkHR4ylIABwK1fJFz3P6gqUYTFRsppyS7PUio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enpLmlSMCN7xenCQ64Kn45uTdhTTh21KApwnUPycbAmd63QacgYVsA5NBNsmnAY9PrC82Hb9Eg2A9ew5j//ihipGyqjkp6Pk28tp13g+yxZaYL4PgUtZggOTqwFdcm3K+DiFYvHt8O7z4iw2G7+JsVQjtoR3qRW8IEjhwflobu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUDr5lkZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUDr5lkZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791602622; x=1823138622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=boeBybVkHR4ylIABwK1fJFz3P6gqUYTFRsppyS7PUio=;
  b=cUDr5lkZFTRpvB8R4UPawiTVuzUjfl3lp8xcPlhBzBCEcSsyQaGekk1E
   jDgCPoRSLpalLsXcglUJDr0BnSShge0c0qfMWB+a6MKaijt+FHoaWwZgn
   xCAu+IBab7NdOTub/6vQFeyirVcyOJ2vWi8h9/S2/1ckDcxrFjU5I7Rn9
   9+m7sRP2vOqGuxyiZ9YxuExwfD7KLXxhAqG9m+5So5mmNjYFkyk/YaPdg
   brEMxHm0lUsYV8qoq/XRzlDv3V9yYlE96ocv1PScWr0bKIRHxdHmBVvui
   X2GY2mhNYEkNx+EjlLwYbeDvmX9N5siRgCNdW4TcWlsihi+0GlSbRhFbA
   g==;
X-CSE-ConnectionGUID: yoNwdjv0Qoqg0VjV13QvvQ==
X-CSE-MsgGUID: 4Hqys/m3RXalWOi4tt4gFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="395596"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="395596"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 20:23:41 -0700
X-CSE-ConnectionGUID: wXLdcWPOR7OcB45omJPC5A==
X-CSE-MsgGUID: Ws8vEc+cRGWOER0ondcQhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="640160"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa001.fm.intel.com with ESMTP; 09 Oct 2026 20:23:36 -0700
Date: Sat, 10 Oct 2026 11:20:10 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>
Subject: Re: [PATCH v3 3/6] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Message-ID: <asmu6nwPYKPnZ3jC@yilunxu-OptiPlex-7050>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-3-db52cb05b918@linux.intel.com>
 <e6207c3e0443be4ee120ad4ce2b10359f7769964.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6207c3e0443be4ee120ad4ce2b10359f7769964.camel@intel.com>

On Fri, Oct 09, 2026 at 06:58:44PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2026-10-06 at 01:41 +0800, Xu Yilun wrote:
> > +static __init int tdx_ext_mem_setup(void)
> > +{
> > +	unsigned int required_pages, added_pages;
> > +	struct tdx_sys_info_ext sysinfo_ext;
> > +	struct tdx_hpa_list *hpa_list;
> > +	struct page *page;
> > +	int ret;
> > +
> > +	ret = get_tdx_sys_info_ext(&sysinfo_ext);
> > +	if (ret)
> > +		return ret;
> > +
> > +	required_pages = sysinfo_ext.memory_pool_required_pages;
> > +
> > +	/*
> > +	 * Skip the memory setup if no memory is required. This may happen when
> > +	 * no add-on features requiring TDX module extensions are configured
> > +	 * via TDH.SYS.CONFIG.
> > +	 */
> > +	if (!required_pages)
> > +		return 0;
> 
> Marshaling this through the struct just to get a set it to required_pages seems
> a bit silly. But I see required_pages is needed for line length.
> 
> Two options:
> 
> Make the get_tdx_sys_info_ext() just take an unsigned int pointer arg. When
> Chao's metadata reading stuff lands, we can keep the struct internal to the
> helper, to still re-use the macro struct mapper stuff.

struct tdx_sys_info_handoff is an existing example so I don't want to
make it different.

> 
> Rename memory_pool_required_pages to required_pages to shorten the lines to
> something manageable and use it directly below.

I prefer the 2nd one. I also want to rename the sysinfo_ext to ext, to
make the field short enough for direct usage everywhere.

  struct tdx_sys_info ext ext;

  ret = get_tdx_sys_info_ext(&ext);
  if (ret)
	return ret;

  if (!ext.required_pages)
	return 0;

  ...
