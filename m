Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F96540B6E9;
	Thu, 24 Sep 2026 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230976; cv=none; b=CQQ7H3HJ6IYhU0o1XE0u/WaWYPy8AEB5U5Z+69vU4cLlhwenCBmNivZY8H0ddT0fdW+g5EHkVDt50LJP3gow+UNRduxiGCjGBDcomWcCnYUf1QRxrmAwdSNwD0gXtz6Y65pTX/e6affLFjzHoPCeuPx7sftyGCpooUFwScCpCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230976; c=relaxed/simple;
	bh=7gKXLqvPGhCYH5CgY5BJYuBxMlou+PHvMii1eSmIJhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqyO3qPj97uYou17Oc0KFiWdcKSfXzWfsOWmRQqtNxAaOnSXUdGUapp5/gZvYF2QGN5hLZkR4CdCcIvLzRz72svTPiS01zxRmUiEZXV/h7qUTn+tcnspaStVcJTNXmFtBL1Y+Nq64ISsQF84aeGMUDCMw9v9qMQ62dI6PaEPifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKepHUh+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKepHUh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790230973; x=1821766973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7gKXLqvPGhCYH5CgY5BJYuBxMlou+PHvMii1eSmIJhM=;
  b=PKepHUh+bAPX4uNCLO3qQWt1PYY41AiAxoqX2V5w/wx4EpHKAiY5OIGm
   vlkCwKouPwjdkob4UrfffuNzpsLMtn2ht3TkU/7ImAwJ0DtKSy/WIyMXo
   EVW+qJ/JEtYnh33wbri5dMP3BupO03K0J/LB/Y8deIo38h3AmFHCahIGL
   mRPA1ZBj8KbliALIzBqqA7ywq7SfgzR2HjKEZw7BxM6TBHL9Rzg4DWRTz
   fOmARoSgJmsfe0uw2ZQxSaz8vscdv86X4m3eY4Xcr5jzy5QY2GheOw76B
   DPVoQVGEVoDykIBs8Wd4Y3lTuaQYtsIlGe+iNFUe32IkiY2beBq8D1U8L
   A==;
X-CSE-ConnectionGUID: qRtPO7qzT56NDtCzegUSLQ==
X-CSE-MsgGUID: vnjo3cGkQQ+cD0QlxdguVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="101524923"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="101524923"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:22:52 -0700
X-CSE-ConnectionGUID: pT2swsmOQDuwLrqOgn46JA==
X-CSE-MsgGUID: 5EywObruTVCWO+2OonedHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="5051226"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.13])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:22:45 -0700
Date: Thu, 24 Sep 2026 09:22:42 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
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
Message-ID: <arTBssCBAody54ZF@tlindgre-MOBL1>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-3-yilun.xu@linux.intel.com>
 <arIqtGbSRHGw8fiT@tlindgre-MOBL1>
 <arOAL2Klu+L91JiI@yilunxu-OptiPlex-7050>
 <arOG2s3VZMQjLWey@tlindgre-MOBL1>
 <arR96/Tpz4cQpfYZ@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arR96/Tpz4cQpfYZ@yilunxu-OptiPlex-7050>

On Thu, Sep 24, 2026 at 09:33:31AM +0800, Xu Yilun wrote:
> On Wed, Sep 23, 2026 at 10:59:22AM +0300, Tony Lindgren wrote:
> > On Wed, Sep 23, 2026 at 03:30:55PM +0800, Xu Yilun wrote:
> > > On Tue, Sep 22, 2026 at 10:13:56AM +0300, Tony Lindgren wrote:
> > > > On Tue, Sep 15, 2026 at 06:26:55PM +0800, Xu Yilun wrote:
> > > > > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > > > > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > > > > @@ -998,6 +998,15 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
> > > > >  	return ret;
> > > > >  }
> > > > >  
> > > > > +/* List all kernel supported add-on features0 bits here */
> > > > > +#define TDX_KERNEL_SUPPORTED_ADDON_FEATURES0	(0)
> > > > > +
> > > > > +static __init u64 get_tdx_addon_features0(void)
> > > > > +{
> > > > > +	return tdx_sysinfo.features.tdx_features0 &
> > > > > +		TDX_KERNEL_SUPPORTED_ADDON_FEATURES0;
> > > > > +}
> > > > 
> > > > How about get_tdx_supported_addon_features() for the above? It makes the
> > > 
> > > mm.. I think this would make a bit confusion. "tdx_supported" reads like
> > > the module supported features, which is just .tdx_features0. But here we
> > > want both the module & kernel support. I'm thinking of:
> > > 
> > >  get_tdx_addon_features0(), just as is
> > > 
> > >  or
> > > 
> > >  tdx_get_supported_addon_features0(), maybe this is better?
> > 
> > Something to describe it's masked with Linux supported features would be
> > nicest.
> > 
> > Maybe something like get_tdx_masked_features0() or just
> > get_tdx_usable_features0()?
> 
> I like "usable", and I want to keep "addon", not all usable features are
> listed here:
> 
>   get_tdx_usable_addon_features0()

Sounds good to me.
