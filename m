Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256C73955F5;
	Tue, 25 Aug 2026 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672377; cv=none; b=GtUDwpagVnPQCsUT+/mnCueEZE1gcP295PwswmdkjoISVGm50u24RrQJsTSgHYI8yUoeTct8+JwB1uDusfFyRoEwTZ3slEj8gT0ZenmfIHWYrs5NgzO+Qkw+xtclRyKOKnFmU+0snNp7/ozcsKJmLP+CO7+vuWd4L3kIsZhjocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672377; c=relaxed/simple;
	bh=MvjycQF2X0VQ9vlSBp2XajaO6rhcCe+5Hx2UF3SIMqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1H/d/nNq7O3ZjkX0s4/vNwAI4VCdDOX2TPhS1D/8rQwQrQZLWUaw0o1KgJsE7tdEMgkmpAtieCxZm5SB5w4RJribS1OwJ2ODfJ+ODK7cUolFRb+thlW++zKi8RNE8gZ8z49Ju8363uIsuQyJCJY/hXlcYloDjuRPVoj95jRIdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7MjvG9I; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7MjvG9I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787672376; x=1819208376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MvjycQF2X0VQ9vlSBp2XajaO6rhcCe+5Hx2UF3SIMqU=;
  b=h7MjvG9IjxfSdOnV549NUDmCid+1EFcACCtIvfjDtgtKf6CWdPKchNJz
   NOXS2/hLQRzRDKo3dZ+eSqfPNHey4tpVf7XLHkra+w2FEzktOaXbiyV3I
   VXp56vopNbtoSo1TWP5/0ilc3YUQe2n/lJuBBZvwztSLxhyIbvceFV5CT
   Zp/0Cqp9DmU1FIjtd8sy6Xgl1pZFr1UgwmdjK5anciB/2mmlYs7Y0RAOB
   swHzHuOLu8m2i50SuCKFaMHvckrkHD6lYnFq+Z1z7ZPhpnawlVhvWdp6h
   IOpq2Ix7yGLRww1LVWr9S8jgwl1tNfhfGGVtg0Tl25uRYfeteIfbKFNY5
   Q==;
X-CSE-ConnectionGUID: 4OgsNKzqSj+6GIKLmBMbVw==
X-CSE-MsgGUID: Jk53/eWVQXyiWvZWkgEjiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88272879"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="88272879"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 08:39:35 -0700
X-CSE-ConnectionGUID: zVqpX1gUSsyp9ilI4W+wGg==
X-CSE-MsgGUID: MFEjIPmOTw6F7Wwt8naJHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="261190001"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa009.fm.intel.com with ESMTP; 25 Aug 2026 08:39:31 -0700
Date: Tue, 25 Aug 2026 23:39:31 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH 6/6] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Message-ID: <ao23M9LG9paVfKsT@yilunxu-OptiPlex-7050>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-7-yilun.xu@linux.intel.com>
 <2d1d8e9a5fd342583998625ca38776058764d8ac.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d1d8e9a5fd342583998625ca38776058764d8ac.camel@intel.com>

On Sat, Aug 22, 2026 at 12:01:08AM +0000, Edgecombe, Rick P wrote:
> On Fri, 2026-08-21 at 11:29 +0800, Xu Yilun wrote:
> > Runtime TDX module update introduces a mechanism to update the module
> > firmware while preserving and restoring TDX operations. As part of the
> > restoration process, the host must re-initialize the extensions to
> > restore their functionality.
> > 
> > Linux runs the updates in stop_machine() context, which prevents memory
> > allocation. This introduces a hard restriction that the updated TDX
> > environment must not consume more memory for the extensions.
> > 
> > The impact of the memory allocation restriction can be mitigated by
> > another requirement. Runtime updates should keep the add-on features
> > unchanged across updates, so that existing TDX users can continue to
> > operate without disruption. This requirement minimizes the chance of
> > increased memory demand.
> > 
> 
> Above it says it's a "hard restriction that the updated TDX environment must not
> consume more memory", but here it says if everything is left the same, it only
> minimizes the chances. Can it be consistent?

I made a new version:

  Linux runs the updates in stop_machine() context, which prevents memory
  allocation. This introduces a hard restriction that the compatible
  update must not consume more memory for the extensions.

  This restriction has no additional impact on the kernel. Recall that
  runtime updates should keep the add-on features unchanged across
  updates, so that existing TDX users can continue to operate without
  disruption. This guarantees that the kernel will never introduce
  additional memory requirement for the extensions.

[...]

> > +static int update_tdx_module_extensions(void)
> > +{
> > +	if (!tdx_sysinfo.ext.ext_required)
> > +		return 0;
> > +
> > +	return tdx_ext_init();
> > +}
> > +
> >  static __init int init_tdx_module(void)
> >  {
> >  	int ret;
> > @@ -1532,6 +1545,10 @@ int tdx_module_run_update(void)
> >  	 */
> >  	WARN_ON_ONCE(ret);
> >  
> > +	ret = update_tdx_module_extensions();
> > +	if (ret)
> > +		return ret;
> > +
> 
> Above it has:
> 	/*
> 	 * Only fails if there is something unexpected
> 	 * and severely wrong with the module.
> 	 */
> 	WARN_ON_ONCE(ret);
> 
> Is the tdx_ext_init() possible to fail here?

Yes. E.g. when more memory is required.

> Otherwise it seems unclear why to
> only not handle get_tdx_sys_info_version() failure. Maybe at least group it with
> the other ones that are allowed to fail.

Yes, I can move it right under tdh_sys_update().

> 
> >  	tdx_module_state.initialized = true;
> >  	return 0;
> >  }
> 
