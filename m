Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81853793DC;
	Tue, 28 Jul 2026 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256172; cv=none; b=QCU3qn/Me6UnRbbaxLyybgSHd8Zcov5zCqTpzJ5iXDIdvggFe6yt3oStmMvKKgUNyGMyboPigEeRd3vdnhWcGzKjf/1FyOtELxTbcSUhQgbiXJw04dbIlFE5bK5/Z3vlSc9/WL4umfQl5p749ED56gjkP+kKTbvEAusL3+G8bdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256172; c=relaxed/simple;
	bh=MX0wJV+z6XrmccbfjJp7YafC0P4FALfhwuAFIt/qJyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlE3k1mgJNa//SYCx9bGLy1az+VLmB9IOwu/dze2FbDC1+wjYzvR5rpD/f+efoOaIur+jh2T84FsezXrI+lg5il39Eq/FLnW2JLgrI9O366RcFY9/N2aRtWQujHOtXxEBKO/72iFfQOHR8T9XsijWBgYKsUAZiyA8XsISrZIXQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R3XjuXcO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R3XjuXcO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785256170; x=1816792170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MX0wJV+z6XrmccbfjJp7YafC0P4FALfhwuAFIt/qJyk=;
  b=R3XjuXcOm+hG7ClgIA3YSu8AshO12mNKQbdEx2KCH2wcjyexOOMSkpNw
   w21wK6BU89pRHkVyxrRXaXJHqXZG3aWPSraHpYohGHBA0X/aA6cTMMjwi
   bzeKqCiky1LI2lyJLcjmL9f+LpHLBoT9ZuYCOsr23lQmsvKTU9CTyCeAy
   tINnKET4n+lPOGNfxYorz1AFZBIlVidJ9wiammkjlKG8QrTrzW3lbkGwF
   vqAuQP3Sy/HIap6lUZ6aoDqKMUVHMvPlz8TZKpIjaUSkCKxxBuNVWXDyF
   Ukd1QRBoxq7DILUgHcFgSQdnPlHlhNCEu5v4w38cB6gJGgLMkPXRLMwow
   A==;
X-CSE-ConnectionGUID: VEiwH3Z/TKiYa+c2WI7LEw==
X-CSE-MsgGUID: h8xYDlgkS5uDVb0aFxEsfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="96202436"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="96202436"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 09:29:29 -0700
X-CSE-ConnectionGUID: 2wTNV8oMRL2SmhKicAFurA==
X-CSE-MsgGUID: WXugfkNNSXqMvNzsilSfGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="255832189"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 28 Jul 2026 09:29:25 -0700
Date: Wed, 29 Jul 2026 00:29:23 +0800
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
Subject: Re: [PATCH v2 02/17] x86/virt/tdx: Configure add-on features on TDX
 module init and update
Message-ID: <amjY4970g2xCkls0@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-3-yilun.xu@linux.intel.com>
 <2d138a8acb685385016e0bb0535e7213952e44e5.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d138a8acb685385016e0bb0535e7213952e44e5.camel@intel.com>

> >  To adhere
> > to this, TDH.SYS.UPDATE must configure the same features as the
> > TDH.SYS.CONFIG. Record the kernel required add-on feature bitmap in a
> > global var so that both phases can use it.
> > 
> > TDX module advances the version of TDH.SYS.CONFIG and TDH.SYS.UPDATE for
> > the change, so use the latest version (v1) for add-on feature enabling.
> > But supporting existing modules which only support v0 is still necessary
> > until they are deprecated. In fact, it is unlikely that TDH.SYS.CONFIG
> > ever needs to change again and the code would stay in v1.
> 
> Ha, these are hard things to predict.
> 
> >  So there is
> > little value in worrying about deprecating v0 to save a couple lines of
> > code in 5-7 years when these original TDX platforms sunset.
> 
> We can't deprecate it today, so what is this saying exactly?

This paragraph is outdated, at that time the target is to always use the
latest SEAMCALL version. I'll remove it.

I updated the changelog according to these comments, appended at the
end.

[...]

> > +static __init void set_tdx_addon_features(void)
> > +{
> > +	/*
> > +	 * To add DICE-based TDX Quoting feature bit in tdx_addon_feature0
> > when
> > +	 * kernel is ready.
> > +	 */
> 
> Can we not make this DICE specific?

Yes.

> 
> > +}
> > +
> >  static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
> >  				    u64 global_keyid)
> >  {
> > +	u64 seamcall_fn = TDH_SYS_CONFIG_V0;
> >  	struct tdx_module_args args = {};
> >  	u64 *tdmr_pa_array;
> >  	size_t array_sz;
> > @@ -1032,7 +1042,15 @@ static __init int config_tdx_module(struct
> > tdmr_info_list *tdmr_list,
> >  	args.rcx = __pa(tdmr_pa_array);
> >  	args.rdx = tdmr_list->nr_consumed_tdmrs;
> >  	args.r8 = global_keyid;
> > -	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
> > +
> > +	set_tdx_addon_features();
> 
> This is a little opaque. Why not something like
> 
> tdx_addon_feature0 = TDX_KERNEL_SUPPORTED_ADDONS &
> tdx_sysinfo.features.tdx_features0;

Good to me.

> 
> tdx_addon_feature0 could probably be named better too. It means the features
> that the kernel has decided to use. HMm, any ideas?

How about tdx_supported_features0?

BTW: I'm going to take Chao's advice [1] to remove the global var
tdx_addon_feature0, and use a "static u64 get_tdx_supported_features0(void)"
for TDH.SYS.CONFIG/UPDATE.

> 
> > +
> > +	if (tdx_addon_feature0) {
> > +		args.r9 = tdx_addon_feature0;
> > +		seamcall_fn = TDH_SYS_CONFIG;
> > +	}
> 
> This kind of feels hacky to me. tdx_addon_feature0 is zero if there are none
> supported. It shouldn't interfere with the v0 call to set it unconditionally?
> 
> I think the connection between tdx_addon_feature0 and TDH_SYS_CONFIG is a bit
> tenuous too. It is set if a extension is found that the kernel supports.
> 
> What do you think about wrapping TDH_SYS_CONFIG. Have the wrapper take all the
> args including tdx_addon_feature0. Then have the wrapper decide which seamcall
> to use. Have a nice comment that says "Use version of seamcall that supports add
> ons if we have any, use the old one if none are supported for backward
> compatibility".

I'm good to add the wrapping for TDH_SYS_CONFIG and TDH_SYS_UPDATE.

> 
> BTW, looking at the tdx module, if I'm reading this right, r9 used to be
> ignored. So did it need a new seamcall version? Some other VMM was passing
> garbage?

Yes, I think it prevents possible garbage inputs suddenly take effect.

The updated changelog:

----8<----

    x86/virt/tdx: Set configurable features on TDX module init and update

    TDX module identifies some configurable features that must be
    explicitly enabled as the kernel supports them. These features affect
    existing TDX systems: they may change the behaviors of the existing
    features, reserve more memory, or impact the TDX initialization
    performance. The kernel needs to explicitly enable these features at
    boot or post-update initialization time.

    Features such as TDISP, DICE-based quoting and TD migration are among
    those configurable features. They use preemptible SEAMCALLs so require
    extra memory and setup time to build a global service environment - the
    TDX module extensions. Add support for the configurable feature setting
    as the prerequisite for initializing TDX module extensions.

    TDX module extends TDH.SYS.CONFIG and TDH.SYS.UPDATE with new bitmap
    input parameters to specify which features to enable. The bitmap uses
    the same definitions as TDX_FEATURES0. TDX module advances the version
    of TDH.SYS.CONFIG and TDH.SYS.UPDATE for the enhancement. A previous
    change [1] adds the 'version' field to struct tdx_module_args to support
    versioned SEAMCALLs. Assign the version field to 1 if any configurable
    feature is required.

    Add a get_tdx_addon_features0() helper to return the bitmap of the
    configurable features that the module & kernel both support. Initially,
    this helper returns 0. It will be updated to return specific feature
    bits as full kernel support lands. TDH.SYS.CONFIG consumes this bitmap
    during TDX initialization.

    Runtime updates keep the reported features unchanged across updates, so
    that existing TDX users can continue to operate without disruption. To
    adhere to this, provide TDH.SYS.UPDATE with the same bitmap returned by
    get_tdx_addon_features0(). The bitmap is guaranteed to match the initial
    TDH.SYS.CONFIG input because tdx_sysinfo.features.tdx_features0 is
    cached and not refreshed after update.

    Link: https://lore.kernel.org/all/20260722084634.131020-1-yilun.xu@linux.intel.com/ # [1]
