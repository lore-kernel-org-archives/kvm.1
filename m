Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537692;
	b=W9c9JVLy9/eq9ROemens9gwnmeYBf0P/ZvyESgzMGdazkUwqFZrxnmzu/bPskP7awVGG
	 ryeX2eztjlmqPDop1M3fricXvyXyyKctAw63ijQB6xx0hZIws73eNQ770t/9ZoO4qBznb
	 e7Ko0zKpEMZ/et3DkRN4pRFLsbCpAqJRqxdySaO0dbIpfr+rIPjktal5yGU5/zMbre92L
	 5Mt66QGWZ2wgC86NjokR/tYE8cs9D/DeX7FHx0Rq9A0tfBzl/fR3WFwZmy+1fghgemqCX
	 GWbvr/AyL+nfH62RoVrlq75NImWpubEEzql78qdoyu2QDII0KfitiQH1vgMZP0zpyNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537692;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=gBLRbdIh+LOD0PevJaJe8TSF6KckpKn/iVBrS7ZcSAc=;
	b=aqApRRcQhLI8lujHu/RYOS4nFMzRdP0qVsVbpxA9PLrQceUtRJiw1RDoksTE5w5+UhHk
	 hhxCaIMnQzv8G3MM9DnBhzDSK711wCcSczapvfmO6S4oGx4d8WWBDqVPx6oZksxydcFZk
	 wqYlyc4JP4EG2kINfWPRBo5ulkZdfLxApGHwRlQihzqUpGY4afDHp0Ju50FljD/TNAw3y
	 W5mjQgLAyxqzlm5sGalZ+7VIcglssBRv9cPiRub1PpVHsDixSbmal08ErOkHk8eD6Zzao
	 yNd4TCBjMikbduXWXCCm4T12t9f0+rxnPKb5AyKGE7xAadCuutwKv6fSjB/K0Y9P98Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mn1Qeguw;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491E606A88C;
	Fri, 13 Nov 2026 02:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8491E606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mn1Qeguw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794537691; x=1826073691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4V2SgnKTNwhI09clxRTUJWfBPyNHYEtlXfaPtxpTjKY=;
  b=mn1QeguweeCN7YXRr8opbSbxKl4TrEBZJ0EM5MXpc2y/ffyT8/2if9Xf
   AZwV7nYQOajHFhW1i3xuprikZ9Wc1BU4wabhw3Ztn4rpXZavu3G5zkjGv
   rKlZYhS76d4LMm0yo5ciXVObK2VDjVKciv2ljSoC/MkQJITf/Io+1i1hL
   Cdo+RhF8bEcI16AeLN4VDpx5UMQCqSM+rpG7LV35kuLb8o72RDPJ4x9Z3
   LgWO0Njgl4TOsOLIF0LkY62uxAQTy2y+Z0T1yfFha6PCAA3BwMdAv6qhx
   RXOYlaEqjIGroLqSZIMIUU/7e3gbPNDury7vC7lj19WuQATeg51D90JAh
   A==;
X-CSE-ConnectionGUID: Ow1A5ymQTqi83yA+qizpgA==
X-CSE-MsgGUID: RWnPuqpFSMGY9Kc4ky5vDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3340170"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3340170"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 18:41:30 -0800
X-CSE-ConnectionGUID: tO8JdJuiTsGKI3SvsSQqUw==
X-CSE-MsgGUID: XXgC8xDFQTWS89ZR9B0tJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8887034"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2026 18:41:28 -0800
Date: Fri, 13 Nov 2026 10:33:15 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, yilun.xu@intel.com, arjan.van.de.ven@intel.com,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [RFC PATCH v2 1/2] x86/virt/seamldr: Support large TDX module
 binaries
Message-ID: <avZ266oL0cvea157@yilunxu-OptiPlex-7050>
References: <20261106132159.1551365-1-chao.gao@intel.com>
 <20261106132159.1551365-2-chao.gao@intel.com>
 <avShYPmuMItx/tsJ@yilunxu-OptiPlex-7050>
 <avU7Dz3IFylm7Tae@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avU7Dz3IFylm7Tae@intel.com>

On Thu, Nov 12, 2026 at 12:05:35PM +0800, Chao Gao wrote:
> On Thu, Nov 12, 2026 at 01:09:52AM +0800, Xu Yilun wrote:
> >On Fri, Nov 06, 2026 at 05:21:55AM -0800, Chao Gao wrote:
> >> The module binary is handed to P-SEAMLDR as a list of page physical
> >> addresses in 'struct seamldr_params'. The list has 496 entries, which
> >
> >Is it better we specify why 496 entries?
> >
> >  The struct seamldr_params is contained in a 4KB page, the first 128
> >  bytes of the page are the metadata, the rests are the list of page
> >  phsical addresses for the module binary.
> 
> ...
> 
> >
> >
> >> caps a module at 496 pages.
> >> 
> >> TDX modules are gaining features and are about to outgrow that limit.
> >> 
> >> The P-SEAMLDR ABI was extended to chain the list across 4KB pages. For
> >
> >With the knowledge of the first 4KB page, it is nature to say the ABI
> >extends the list to more 4KB pages.
> >
> >> a module over 495 pages, the last of the 496 entries points to another
> >> page of entries instead of to a module page. The last entry of that
> >
> >Maybe we don't have to emphasize the 495/496? The last entry of each
> >page points to the next page.
> 
> I would rather drop 496 and 495 from these paragraphs. Readers do not
> need the exact limit here, since the code has the numbers. How about:
> 
> 
> The module binary is handed to P-SEAMLDR as a list of page physical
> addresses in 'struct seamldr_params'. The list must fit in a single 4KB
> page along with a few other fields, which caps a module at just under
> 2MB.
> 
> TDX modules are gaining features and are about to outgrow that limit.
> 
> The P-SEAMLDR ABI was extended to continue the list on more chained 4KB
> pages. The last u64 of each page holds the physical address of the next
> page in the chain.

Yes, this flow is what I expect.

> 
> >
> >> page can point to yet another page, and so on, until every module page
> >> is listed.
> >> 
> >
> >[...]
> >
> >> -#define SEAMLDR_MAX_NR_MODULE_PAGES	496
> >> +/*
> >> + * module_pages_pa_list[] spans multiple pages. The last entry of each
> >> + * page points to the next page and does not hold a module page, so the
> >> + * maximum number of module pages is the array size minus one entry per
> >> + * page.
> >> + *
> >> + * SEAMLDR_PARAMS_NR_PAGES is somewhat arbitrary. It allows modules of
> >> + * up to about 32MB. Increase it if modules outgrow that.
> >> + */
> >> +#define SEAMLDR_PARAMS_NR_PAGES		16
> >> +#define SEAMLDR_NR_MODULE_PA_ENTRIES	(496 + 512 * (SEAMLDR_PARAMS_NR_PAGES - 1))
> >
> >The number 496 is not meaningful when the seamldr_params is no longer
> >one page size. We need comments to explain how it is derivee. But instead
> >of text explanation, is it better:
> >
> >#define SEAMLDR_NR_MODULE_PA_ENTRIES	(SEAMLDR_PARAMS_NR_PAGES * 512 - 16)
> 
> The 16 here would still need explaining. It would also be confusing,
> because the macro right below subtracts a different 16
> (SEAMLDR_PARAMS_NR_PAGES) to get SEAMLDR_MAX_NR_MODULE_PAGES.
> 
> >
> >Or:
> >
> >#define SEAMLDR_NR_MODULE_PA_ENTRIES	\
> >	((SEAMLDR_PARAMS_NR_PAGES * PAGE_SIZE -	\
> >	  offsetof(struct seamldr_params, module_pages_pa_list)) / \
> >	 sizeof(u64))
> 
> offsetof() does not work here. The macro sizes module_pages_pa_list[]
> inside 'struct seamldr_params', where the struct is still incomplete. The
> compiler reports:
> 
> 	error: invalid use of undefined type 'struct seamldr_params
> 
> How about:
> 
> /*
>  * module_pages_pa_list[] fills the rest of 'struct seamldr_params' after
>  * its first 128 bytes. The last entry of each page is reserved to point
>  * to the next page and cannot hold a module address. The last entry of
>  * the final page is never used.
>  */
> #define SEAMLDR_NR_MODULE_PA_ENTRIES	(((SEAMLDR_PARAMS_NR_PAGES * PAGE_SIZE - 128)) / sizeof(u64))

Yes, that's good to me. Though 128 still needs explaination, but much
easier than one 496 + (n-1) * 512.

> #define SEAMLDR_MAX_NR_MODULE_PAGES	(SEAMLDR_NR_MODULE_PA_ENTRIES - SEAMLDR_PARAMS_NR_PAGES)
> 
> >
> >> +#define SEAMLDR_MAX_NR_MODULE_PAGES	(SEAMLDR_NR_MODULE_PA_ENTRIES - SEAMLDR_PARAMS_NR_PAGES)
> >>  #define SEAMLDR_MAX_NR_SIG_PAGES	1
> >>  
> >>  /*
> >> @@ -48,10 +59,10 @@ struct seamldr_params {
> >>  	u64	sigstruct_pages_pa_list[SEAMLDR_MAX_NR_SIG_PAGES];
> >>  	u8	reserved[104];
> >>  	u64	module_nr_pages;
> >> -	u64	module_pages_pa_list[SEAMLDR_MAX_NR_MODULE_PAGES];
> >> +	u64	module_pages_pa_list[SEAMLDR_NR_MODULE_PA_ENTRIES];
> >>  } __packed;
> >>  
> >> -static_assert(sizeof(struct seamldr_params) == 4096);
> >> +static_assert(sizeof(struct seamldr_params) == SEAMLDR_PARAMS_NR_PAGES * PAGE_SIZE);
