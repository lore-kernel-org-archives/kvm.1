Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA9E456E00;
	Wed, 29 Jul 2026 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323267; cv=none; b=MeBajxrrFYWhqMx75oAbbvj6d7/yHmiFiiptgKuuh/Fr2IhCLdMUO8s1FrsLkcoXYHWTrRVL61PxmKVohwujY/6HPanGKj/bN3SQQCitewf6yAxpPOelUvFm+R/RGoMpoMhFHOcJ6alMeIFLZJFv1AMPEmocNAqeVKYNKxXcdH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323267; c=relaxed/simple;
	bh=C6k8P7gpW7co/5WMrPa1FIUhudJWsyxTbvgvV44jdjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LARnromYet6tsO+Xw7a6iqXg//Mva4wakdzVVtOKfAEK57xgB9gG3plbL4+n/ZKYsT/ccga/9T2PTJO9C8hjb9l1nRo7d+uFrr5XKhY0oV3BG627SYhQCuHBMYyHEYAdqogBstTqMiyePsxLx1a7tNs7Xj3FjKPa1dNFfffmdXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3Pdkfun; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3Pdkfun"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785323265; x=1816859265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=C6k8P7gpW7co/5WMrPa1FIUhudJWsyxTbvgvV44jdjQ=;
  b=D3Pdkfun9pev7VGHJVoVWUjyqSNeaRJ4N4rd9yt1k94rIzqEnVV2BnhC
   qndpulfcTltWzL/q77K4HdJ5MSnEgTZhQERkW6tzSuobN6lXQyAI7F7dl
   dZgybIaliUhIXHHe9+RuSQxUPTYHpZiwyTrQysq3CYnsoIc/cQ4DZgH2h
   +6k2U6XFPM5UcoyUoujIlFskG7K8hc6IstQXDDgqthhdKq2uglcmiZEaS
   BBAa+GSL0fh3qnWrDSsBOiJP+HNCqcHndsG9D3xLjmfT+qVJvtAcxFfoZ
   YPu1KiWJztS72vOmKfpp4fCzD7XZf9ibOr2Ky4VSuXpHhSTNXgJvlUauy
   Q==;
X-CSE-ConnectionGUID: x52ssaNXQbOLTMmBP7jpwQ==
X-CSE-MsgGUID: L+QIdi/BSWqS6Ji52e7V0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85049960"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="85049960"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 04:07:44 -0700
X-CSE-ConnectionGUID: BLHQ9rCzS76c3vZpzjKRCw==
X-CSE-MsgGUID: +PW3ZyRRRTGMSnbNIOwY7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="298197946"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 29 Jul 2026 04:07:41 -0700
Date: Wed, 29 Jul 2026 19:07:39 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>,
	"djbw@kernel.org" <djbw@kernel.org>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCH v2 04/17] x86/virt/tdx: Add extra memory to TDX module
 for the extensions
Message-ID: <amne+/6eIDdp0RZk@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-5-yilun.xu@linux.intel.com>
 <36d0108950e80c8ac769534fea2d8a6c0907c431.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36d0108950e80c8ac769534fea2d8a6c0907c431.camel@intel.com>

> > TDH.EXT.MEM.ADD uses a new parameter type, HPA_LIST_INFO, to provide
> > this memory. This type represents a list of pages for TDX module to
> > access. It references an 'hpa_list page' which contains the list of
> > target HPAs. It collapses the HPA of the hpa_list page and the number
> > of valid target HPAs into a 64 bit raw value for SEAMCALL parameters.
> > The hpa_list page is always a medium, TDX module never keeps the
> > hpa_list page.
> 
> I think you are going to need to put the basic concepts up front. Don't lead
> with the acronyms. The TDX module needs to get a list of pages. It takes them in
> a PFN array that is encoded like (...). Create a helper for this, and name it
> the same after the TDX module term for this format, HPA_LIST_INFO.
> 
> Basically there are no exotic concepts here. So you can explain it in normal
> kernel terms.

OK. My refactored version:

    When adding the memory, the TDX module needs to get a list of pages.
    It accepts these target pages in a PFN array that is encoded into a
    single 64-bit SEAMCALL parameter: the PFN of a container page that
    holds the PFN array, and the number of the pages packed into a single
    value. Create a helper to encode this format and name it after the TDX
    module term: HPA_LIST_INFO.

[...]

> >  TDX module extensions consume tens of megabytes memory that
> > will never be returned to host. Use contiguous page allocation to
> > isolate these large blocks entirely, avoiding permanent memory
> > fragmentation and reducing buddy allocator efficiency. Print the
> > allocation amount on TDX module extensions initialization for
> > visibility.
> 
> Hmm. I'm not sure the user will care about the specific category of extension
> used memory.

Not sure if you suggest removing the print, but this is suggested by Dave:

https://lore.kernel.org/all/62bec236-4716-4326-8342-1863ad8a3f24@intel.com/

[...]

> > +struct tdx_hpa_list {
> > +	u64 phys[PAGE_SIZE / sizeof(u64)];
> > +};
> > +
> > +static_assert(sizeof(struct tdx_hpa_list) == PAGE_SIZE);
> 
> What kind of change are we guarding against here?

I don't expect changes of the format, but this is to ensure the
container of the PFN array is a page, and also serves as the
documentation.

[...]

> > +	i = 0;
> > +	while (i < required_pages) {
> > +		unsigned int nents = min(required_pages - i,
> > +					 ARRAY_SIZE(hpa_list->phys));
> 
> I think this whole loop could be made clearer. nents is the number of pages we
> will add for an execution of the seamcall. That is not clear enough either.
> 
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
> > +		WARN(ret, "Fatal: TDX module rejected (%d) memory for
> > extensions, stranded all pages\n",
> > +		     ret);
> > +		if (ret)
> > +			break;
> 
> Can we combine the ret checks?

Yes.

> 
> > +
> > +		i += nents;
> 
> Maybe a full name for i?

Yes, I changed the name of i & nents.
