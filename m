Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D5339363;
	Thu, 24 Sep 2026 01:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790213691; cv=none; b=dr4xm5BqwzB1fpr4IdhzXXf33t/KglxR+nyhrvlbGS6yfjOWi4q7WLLfN0wEyReHy7RSfzFttWsqhV3wGkdQhXenDiTR50MqCYXpVsJv4OZ4nG+2vO1qggiVAMa3Zfkl2AVZupKUoW5Lm5KDJSU27OqszoYFnDvNqOsLr+3Ff/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790213691; c=relaxed/simple;
	bh=FfF54ZUBc7946Xqa5diHmOO3E7Zp3pwB4IlWQgStZVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z26UY5ypZ/840s0SCdZd+EPYpoQ0LJJ2PkYxDZvdTLcGLLNTb6jBZmfWtf0qHWbg75t2fPpxZ06Jeh6p+vCc1U65y7TyEDMdFZdeqnf+KB0jmjJQJnzSh/C+URpKuDRaaBRwouo9IU0GhCDBhh5LaFqtIM8rAbLY+dhrp6l/USE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9/iSqeB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9/iSqeB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790213687; x=1821749687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FfF54ZUBc7946Xqa5diHmOO3E7Zp3pwB4IlWQgStZVY=;
  b=f9/iSqeBO+A3Oz59qeiMWoVb5xJdOkBBGgjxq/KJkaCEpE9L+fqusE8A
   Mp5UYM+5tgYRvUuiYX/R+b79lveXpdrRULeApkiomjRekN59jtspoLMjS
   eTCoJI3AHLyxtWiESpgGESHHrefMONkBEOaLNE6FtKewIKK75Sq7QX0la
   ySjlWIRq0bZu1SFrM8o9S8MYUCW0SZw2zf7Bjc00ZMD7Ur2S0dwQpIUSL
   MBPqWMjYsYoWkr/RJKpBBzw+0e66mo8RgpLPTz2tgtMIcwiBgbnnm79mm
   FDeW+1rLjiOGrhRVRm3TKtCpS6R7GgowBWZCldDqa1OYKVrUlup41MJfQ
   g==;
X-CSE-ConnectionGUID: ll/AsDGPR7OEgvm2HtqX9A==
X-CSE-MsgGUID: aWrQns4LQseT4+Y2XLSlxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="101545814"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="101545814"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 18:34:45 -0700
X-CSE-ConnectionGUID: qknp7SOLTiihXN8jSY14Pg==
X-CSE-MsgGUID: +TclqIg1Qq++45vXccFjlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="273337574"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa007.fm.intel.com with ESMTP; 23 Sep 2026 18:34:42 -0700
Date: Thu, 24 Sep 2026 09:33:31 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	peter.fang@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, chao.gao@intel.com,
	artem.bityutskiy@linux.intel.com, kvm@vger.kernel.org,
	nik.borisov@suse.com
Subject: Re: [PATCH v2 2/5] x86/virt/tdx: Configure add-on features on TDX
 module init
Message-ID: <arR96/Tpz4cQpfYZ@yilunxu-OptiPlex-7050>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-3-yilun.xu@linux.intel.com>
 <arIqtGbSRHGw8fiT@tlindgre-MOBL1>
 <arOAL2Klu+L91JiI@yilunxu-OptiPlex-7050>
 <arOG2s3VZMQjLWey@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arOG2s3VZMQjLWey@tlindgre-MOBL1>

On Wed, Sep 23, 2026 at 10:59:22AM +0300, Tony Lindgren wrote:
> On Wed, Sep 23, 2026 at 03:30:55PM +0800, Xu Yilun wrote:
> > On Tue, Sep 22, 2026 at 10:13:56AM +0300, Tony Lindgren wrote:
> > > On Tue, Sep 15, 2026 at 06:26:55PM +0800, Xu Yilun wrote:
> > > > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > > > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > > > @@ -998,6 +998,15 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +/* List all kernel supported add-on features0 bits here */
> > > > +#define TDX_KERNEL_SUPPORTED_ADDON_FEATURES0	(0)
> > > > +
> > > > +static __init u64 get_tdx_addon_features0(void)
> > > > +{
> > > > +	return tdx_sysinfo.features.tdx_features0 &
> > > > +		TDX_KERNEL_SUPPORTED_ADDON_FEATURES0;
> > > > +}
> > > 
> > > How about get_tdx_supported_addon_features() for the above? It makes the
> > 
> > mm.. I think this would make a bit confusion. "tdx_supported" reads like
> > the module supported features, which is just .tdx_features0. But here we
> > want both the module & kernel support. I'm thinking of:
> > 
> >  get_tdx_addon_features0(), just as is
> > 
> >  or
> > 
> >  tdx_get_supported_addon_features0(), maybe this is better?
> 
> Something to describe it's masked with Linux supported features would be
> nicest.
> 
> Maybe something like get_tdx_masked_features0() or just
> get_tdx_usable_features0()?

I like "usable", and I want to keep "addon", not all usable features are
listed here:

  get_tdx_usable_addon_features0()
