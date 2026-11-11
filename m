Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417477;
	b=pkHDSCBxkiFPIP0pBAJ1fKH4B3hPmx0xBBi9AKfDUVOp9abCms/h6IVRQto4WvaZT6Z6
	 EReJe+22efujT0B90+iNeqac4a/FhnOlRcZEJEJ0EmBxXBD4Tm6wW1+pTsdIKrqe0mq8d
	 1zc+jApntS7phUGfFH6HR9eyNJRSoNORUszo3dAQQk7EwzLBYn32UlqscsODJVgVK1GI/
	 M3Nfo/iIcT3g+MEdrcTjBpndUOPRumaanL73RYqH0Hlxa7yDf/4tmqkEJmKwewKBWxOSO
	 +7uHTrP/+I7Agdw2wEM8oaZ8IH9KhPGhUs2nZg+s9X9L70gWCbm0K0qsnKdkbnTwy7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417477;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=aYc6TQFiJmyshVr2VWxnAYpxH7I6QL5S37wt5PeFjLM=;
	b=x0eWUkxj8yxpv6pTVe8zCxQ3i8kQQWEwh66FCVpoRix2g2F7nwLPmdPJ+rX3bIhz7KNm
	 Bg/poXM2SkSfAfz5+4NZbjkLIkphZbfe2eRNpa7GuQfDrp9cBgkG661ZsngaPaiPW9a61
	 jfDAQPkuvRIzdroH43QyP0SC2Ic8ftDuoHSxGlz9gKGPbkJWf3FjfFh+cFz0DRmCXvFvO
	 cQ43+XST9yjlUIlPCEl9o6cdLdN9nIhfkOZxws6HF8DJGv5ECaS0UDwrV9wlgoSXpS0Y4
	 wlOjnbn0vXPutiJOiI4fJ+PV9sWoDJuGUEL65q2/9KaIWulleY7WkJyGyVGHtxf9ttQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mVSf5qWm;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7046606A324;
	Wed, 11 Nov 2026 17:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7046606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mVSf5qWm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794417477; x=1825953477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9h+SOuV2JorUEvU3zSn8GmfEBQ5z2NPxmYGV4bE90qw=;
  b=mVSf5qWmDZ4xDRgnP6/XRCCj0/gowX73pPJXLsexkgvzW6cD+a+j3pm9
   CqoHe5C0K1PEvkuszd4sTAvp2FYTxZASCAWTLF7WWOnNMdRRndjbZKAy/
   GsvXLZn87peIgcv9Vv46D7QZQTNBvt+elklTiSW2n60/siKZLBOc0p41A
   Hi7P1CmTWzUVDoXmMBI3juuRXy413I19F6vl45dLM2zmHNgKitYL3PAfX
   kv97zjAVQ53vRMqYs4GTDGDFLmB02CwXTfrR35nWOrn4eoKIsKScUBhmS
   BwoVO8y5uGIfxfDXXcqt9ZD0ADBuaBFIRbV4soDeFPjV8gdhFKosVCaO9
   Q==;
X-CSE-ConnectionGUID: pJmCDACTR4e2a7tQTNtALg==
X-CSE-MsgGUID: 0/htu46zQySX12Ps599AhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3237201"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3237201"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 09:17:56 -0800
X-CSE-ConnectionGUID: lFmZw9txTsqnb0hBWg7mpw==
X-CSE-MsgGUID: XMizP/EzSK+XFVQ/tWbM8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8803116"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa001.fm.intel.com with ESMTP; 11 Nov 2026 09:17:53 -0800
Date: Thu, 12 Nov 2026 01:09:52 +0800
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
Message-ID: <avShYPmuMItx/tsJ@yilunxu-OptiPlex-7050>
References: <20261106132159.1551365-1-chao.gao@intel.com>
 <20261106132159.1551365-2-chao.gao@intel.com>
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
In-Reply-To: <20261106132159.1551365-2-chao.gao@intel.com>

On Fri, Nov 06, 2026 at 05:21:55AM -0800, Chao Gao wrote:
> The module binary is handed to P-SEAMLDR as a list of page physical
> addresses in 'struct seamldr_params'. The list has 496 entries, which

Is it better we specify why 496 entries?

  The struct seamldr_params is contained in a 4KB page, the first 128
  bytes of the page are the metadata, the rests are the list of page
  phsical addresses for the module binary.


> caps a module at 496 pages.
> 
> TDX modules are gaining features and are about to outgrow that limit.
> 
> The P-SEAMLDR ABI was extended to chain the list across 4KB pages. For

With the knowledge of the first 4KB page, it is nature to say the ABI
extends the list to more 4KB pages.

> a module over 495 pages, the last of the 496 entries points to another
> page of entries instead of to a module page. The last entry of that

Maybe we don't have to emphasize the 495/496? The last entry of each
page points to the next page.

> page can point to yet another page, and so on, until every module page
> is listed.
> 

[...]

> -#define SEAMLDR_MAX_NR_MODULE_PAGES	496
> +/*
> + * module_pages_pa_list[] spans multiple pages. The last entry of each
> + * page points to the next page and does not hold a module page, so the
> + * maximum number of module pages is the array size minus one entry per
> + * page.
> + *
> + * SEAMLDR_PARAMS_NR_PAGES is somewhat arbitrary. It allows modules of
> + * up to about 32MB. Increase it if modules outgrow that.
> + */
> +#define SEAMLDR_PARAMS_NR_PAGES		16
> +#define SEAMLDR_NR_MODULE_PA_ENTRIES	(496 + 512 * (SEAMLDR_PARAMS_NR_PAGES - 1))

The number 496 is not meaningful when the seamldr_params is no longer
one page size. We need comments to explain how it is derivee. But instead
of text explanation, is it better:

#define SEAMLDR_NR_MODULE_PA_ENTRIES	(SEAMLDR_PARAMS_NR_PAGES * 512 - 16)

Or:

#define SEAMLDR_NR_MODULE_PA_ENTRIES	\
	((SEAMLDR_PARAMS_NR_PAGES * PAGE_SIZE -	\
	  offsetof(struct seamldr_params, module_pages_pa_list)) / \
	 sizeof(u64))

> +#define SEAMLDR_MAX_NR_MODULE_PAGES	(SEAMLDR_NR_MODULE_PA_ENTRIES - SEAMLDR_PARAMS_NR_PAGES)
>  #define SEAMLDR_MAX_NR_SIG_PAGES	1
>  
>  /*
> @@ -48,10 +59,10 @@ struct seamldr_params {
>  	u64	sigstruct_pages_pa_list[SEAMLDR_MAX_NR_SIG_PAGES];
>  	u8	reserved[104];
>  	u64	module_nr_pages;
> -	u64	module_pages_pa_list[SEAMLDR_MAX_NR_MODULE_PAGES];
> +	u64	module_pages_pa_list[SEAMLDR_NR_MODULE_PA_ENTRIES];
>  } __packed;
>  
> -static_assert(sizeof(struct seamldr_params) == 4096);
> +static_assert(sizeof(struct seamldr_params) == SEAMLDR_PARAMS_NR_PAGES * PAGE_SIZE);
