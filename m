Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C60A377EA2;
	Mon, 27 Jul 2026 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785156188; cv=none; b=RPz9iNWqZiaY9tmwG0S9pERutRWggZqsvieqPV9IR2aPV9jV0ALQGP2A/005Q33MHTKQB0RAgGu4aDugwqxB5HBhCsIx2zwuhn/LYDrPBWcu0QPceNA7wI1WmXDxeZiDmEShYD2jI3zxBqO+PLEABp2lkolgoaRZ2tAb9RUGvDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785156188; c=relaxed/simple;
	bh=kydFL+J2UCBGONfxOuHpVAhlPfO4ATIRdGb+0FS0EoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oe+lHmLEGeojNqqnIliPiYiXsUQ6GtQErFihzUoyV47Iw2fZO4KCcxofMq7pQuBmKdb/WBq17Cis1urunF8KCsCFdPoh3f3spUrUghTQaQVXUPbkqxpbBsN87QY4Z5YAnuRhNCFx6D0zruShIRTychDfHsASbcj5oinsFhuSwxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iYWxzosX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iYWxzosX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785156187; x=1816692187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kydFL+J2UCBGONfxOuHpVAhlPfO4ATIRdGb+0FS0EoI=;
  b=iYWxzosXZbtDqsRLVjWeMmDJJqVFT0/JzYhb78yqJQxqLYc2seGukMQW
   ln9FhqYd+pFW1sbFvwW3o6WCPxXabh4JEiMWAjrD0nW0RhstvCHadCb+n
   qoTJa1lgX7WL35B8wFPozmgc9PfAyJiV5JVZUga3nGnj70Oj4FDY2uikG
   eyjdp8mG8I1Ib1Fl4+U/pZeyIGGGB2iQZSZwXR8keB/qaw6sk8S4nkGPN
   y5mQrmq2PF4ywEqo5ofIgeqDEicwSx4qr0jkoglZMwWp9tERTLO06fp2f
   pyEWtsV1vmBHVhtlIwYyAtVJiXs3ohIOrOzU5Vnb0lYk/D9gAVkE+o/XK
   g==;
X-CSE-ConnectionGUID: lvDbeEE+RRiazcoOKjnlGQ==
X-CSE-MsgGUID: fSgARC00Rmec++NlPA2ggA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85573100"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="85573100"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 05:43:06 -0700
X-CSE-ConnectionGUID: FeOBN8S5QduQZGtL2sd9zg==
X-CSE-MsgGUID: L6WXOtp0TB2RkS/X7Kx4Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="253070638"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 27 Jul 2026 05:43:02 -0700
Date: Mon, 27 Jul 2026 20:43:01 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Chao Gao <chao.gao@intel.com>, x86@kernel.org, kvm@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	djbw@kernel.org, kas@kernel.org, rick.p.edgecombe@intel.com,
	yilun.xu@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com,
	kishen.maloor@intel.com, tony.lindgren@linux.intel.com,
	peter.fang@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, seanjc@google.com
Subject: Re: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions
 initialization is required
Message-ID: <amdSVcIL4AyMK1RA@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-4-yilun.xu@linux.intel.com>
 <akIR1ClnTs1bRsD9@intel.com>
 <akOkGqH6RQEs/RWN@yilunxu-OptiPlex-7050>
 <907d28d7-6355-43a8-b5bc-d61d5c640141@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <907d28d7-6355-43a8-b5bc-d61d5c640141@intel.com>

On Fri, Jul 24, 2026 at 04:44:15PM +0800, Xiaoyao Li wrote:
> On 6/30/2026 7:10 PM, Xu Yilun wrote:
> > On Mon, Jun 29, 2026 at 02:33:56PM +0800, Chao Gao wrote:
> > > > +static __init int init_tdx_module_extensions(void)
> > > > +{
> > > > +	struct tdx_sys_info_ext sysinfo_ext;
> > > > +	int ret;
> > > > +
> > > > +	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
> > > > +		return 0;
> > > > +
> > > > +	ret = get_tdx_sys_info_ext(&sysinfo_ext);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	/* Skip if no feature requires TDX module extensions. */
> > > > +	if (!sysinfo_ext.ext_required)
> > > > +		return 0;
> > > 
> > > What would happen if the kernel doesn't do this 'ext_required' check
> > > and always does the extension initialization?
> > > 
> > > If TDH.EXT.INIT returns success when no extension is configured, we
> > 
> > No, TDH.EXT.INIT fails when ext_required==false
> 
> What is the SEAMCALL return code in this case?

It will return TDX_EXT_MEMORY_POOL_NOT_READY, because TDX module's internal
state machine stays at the first step of extensions' initialization.

> 
> > > could drop this 'ext_required' from this series entirely.
> 
