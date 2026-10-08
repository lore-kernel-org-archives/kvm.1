Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B56A28F5;
	Thu,  8 Oct 2026 04:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791433310; cv=none; b=fZEcuejhC0X/PlX9ZZeYzHNriXN7a7aoxVN+0M9aOMEJrtZPMbEZBcr1+Cd4Gi2RcHL+IpWpIyAOkhJ01qlIMUhvhPQdpSgB2xvL9o6CO3EIsQYjqMbCnqx4w3JjImoy0YbNlxx6c3Z9lBy6y2+CnLVmZ3+qsIxRqkEWl3s0x4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791433310; c=relaxed/simple;
	bh=72t8kjnmtlHayJXabWx7qkj7uN9CNyIrQorr5EX/XD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpZTLBN8DrEet4gBKvzfwrY+YdF7g291vTS0mY4cfxtvSMxRblkvVLnm5XhKYQhMLc+WoIjUj9cZAK6RQvrLZoQNvUwzzNlvZbJ9nz6tugXo0w9xsx1TayEcgdC8sF/0bNmABcCoDIFPqMuGlYfqVtBBgQo1gse74D/5uujbV4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bI18DeG9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bI18DeG9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791433308; x=1822969308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=72t8kjnmtlHayJXabWx7qkj7uN9CNyIrQorr5EX/XD4=;
  b=bI18DeG935pvf2gmg7b6+7pV+Qz1cO7ks7kQAqieXuM3pZMGYzMth3vl
   tuQ22CwqDSN3aApUH1BWr9DokCUacUucJBpJvzddH2p8rZKUo4YMA0QSl
   ju4hWQhkeuw6dK5Gz16nyDjknSJFTzG9ICAZb7sqtdvZlhyZG/CH4BzGx
   BD5PuijIcOU5M7VyQiF+41ExbfACfeffbPkTj9krd5J2xsPtiLVUuSVMY
   ojp1mqbsjvd0Ckec+FyxzLfcyF0oNRF73qtVrwYmjmHBOGBrrFYK29szO
   Xo7VH4ywuSAztx336XVL/2exCLpE+73wy7TMyjRgDe0QUSc5KzEvNRg7Z
   A==;
X-CSE-ConnectionGUID: R3Td3kqASf+ko6n+8RFrwg==
X-CSE-MsgGUID: J8Jwrby8RpWNzo/BTMxiag==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="89787"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="89787"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 21:21:48 -0700
X-CSE-ConnectionGUID: ijIX/gW5Q9+QS8t15kW+Mg==
X-CSE-MsgGUID: ZMwSeSVDTranw+w5fx6dCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="4524"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa001.fm.intel.com with ESMTP; 07 Oct 2026 21:21:43 -0700
Date: Thu, 8 Oct 2026 12:18:33 +0800
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
Subject: Re: [PATCH v3 2/6] x86/virt/tdx: Configure add-on features on TDX
 module init
Message-ID: <ascZmXRuxiiAAv2+@yilunxu-OptiPlex-7050>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-2-db52cb05b918@linux.intel.com>
 <51a0f0e33d523fa652b3c664ea1083a9459bd323.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51a0f0e33d523fa652b3c664ea1083a9459bd323.camel@intel.com>

On Tue, Oct 06, 2026 at 11:56:23PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2026-10-06 at 01:41 +0800, Xu Yilun wrote:
> > The TDX architecture identifies some features that are off by default
> > but can be enabled by the host during TDX module initialization. They
> > are classified as add-on features because enabling them affects existing
> > TDX systems: they may change existing feature behavior, or reserve more
> > memory.
> > 
> > The TDX module extends TDH.SYS.CONFIG with a new register argument to
> > specify which add-on features to enable. This new argument is a bitmap
> > that uses the same feature bits as TDX_FEATURES0. Note that Dynamic PAMT
> > is an exception: although it is an add-on feature, it is controlled via
> > a legacy, dedicated register argument [1].
> > 
> > The kernel needs to enable these add-on features when it supports them.
> 
> I made a similar comment on v1:
> https://lore.kernel.org/lkml/41f5a558ca67e2895fcb114c418f0e453e933974.camel@intel.com/
> 
> It is up to the kernel to decide if it wants to enable these features, when it
> supports them. The sentence sounds like there is some hard requirement to enable
> them when possible. I think the reasons to enable them based solely on available
> support could be:
>  1. They don't take significantly more memory or CPU resources, and limiting
> possible configs reduces kernel complexity.
>  2. It would be rare that people don't want them on.
> 
> Maybe we tweak this to be?
> 
> Despite that these features can be add-ons due to introducing some overhead to
> TDX runtime, the impact of the first features will be low enough to pursue a
> simple approach of just enabling them when supported. If a feature with a very
> high overhead appears in the future, this can be revisited.

Good to me. I'll include it in v4.

[...]

> > @@ -1056,6 +1066,15 @@ static __init int tdx_sys_config(struct tdmr_info_pa_array *tdmr_pa_array,
> >  		args.r8 |= TDX_SYS_CONFIG_DYNAMIC_PAMT;
> >  	}
> >  
> > +	/*
> > +	 * Use SEAMCALL version 1 that supports add-on features if any are
> > +	 * requested. Otherwise use version 0 for backward compatibility.
> > +	 */
> > +	if (addon_features0) {
> > +		args.r9 = addon_features0;
> > +		args.version = 1;
> 
> This is a slightly silly pattern:
> args.r9 = 0;
> if (addon_features0 != 0)
> 	args.r9 = addon_features0;
> 
> ...could just be:
> args.r9 = addon_features0;

Yes, that's workable.

> 
> It could actually set args.version a similar branchless way.

Not sure how?

I don't think just "args.version = 1" can work. It will fail older
modules which doesn't support add-on features & doesn't recognize
TDH.SYS.CONFIG v1.

How about:

	struct tdx_module_args args = {
		.rcx = __pa(tdmr_pa_array),
		.rdx = nr_tdmr_pa,
		.r8 = global_keyid,
		.r9 = addon_features0,
	};

	...

	if (args.r9)
		args.version = 1;

> 
> But I think the version in this patch is super obvious about what is happening
> and has a nice place for the comment. And this is extremely far from a
> performance critical path.
> 
> 
> > +	}
> > +
> >  	return seamcall_prerr(TDH_SYS_CONFIG, &args);
> >  }
> >  
> > 
> 
