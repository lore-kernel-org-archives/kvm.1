Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7E8394EB7;
	Thu, 24 Sep 2026 01:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214764; cv=none; b=ls1nG5wDV3HlY/ks2eoiLSC7sJ2fM6xSs+aWU5A1mVZvFDpt2+0qPuHfNon2hQZEu85zopRxpEqvRaTrW4Dpvyv/uuIARygl1RxBXa8KPZCahGo4VzJPvV67jbollXZ4apJ5r66CJ/4/I03hqSdgYIgrF3b38DU3nNnvgmAgOY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214764; c=relaxed/simple;
	bh=5wjKolRkOj1eM6tQhXMmGAq+yZ6O5IWDpFid/YcLe5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hr+JjeEkctUMrq3T4EdhV+YSBCQ+Omi8QgkIGsf4lfRau9qf1zsPR+VJZsMteAiFOGgLGNPoVNpn0i9/G038BI+OyOIoPPqQFjQdBJx/FAM2ETm53YCQ9qtnzCamE5ircIR8XvitakEifCYo7WDc9QZMeA+5/48XEpWoOUM4wtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H40OSsWn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H40OSsWn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790214762; x=1821750762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5wjKolRkOj1eM6tQhXMmGAq+yZ6O5IWDpFid/YcLe5Y=;
  b=H40OSsWnx7584Ll8USzJeWn0s7dpiWyXrVThuZRIpydWlubcGMXQPjFH
   bo/Qx7EfpGf06NGb8WjEssxeCMmt6Z2scxDvs8xHGYnYUwrKwfXwtzMh0
   7dyP+MLXgRnVqQXNCIcY9TgF11WYe0iiFEKKceDho+bRl3orxcNuKN//F
   kO9SFDKI69/eII7fsbJCo33pnzB+Ap4u4DUHMYil6PkjaPO5f1kmk8svt
   SOJexc1Q5SKpXorUdCwwHaKX2pKabNrLLR5bFqpTw/S7jc4NTVvhVaDpX
   lzqKrqaRmd2ZCa0dYFGQbzym25NgvKOER9/4afzbcHdTQWhVssDtTeX4R
   g==;
X-CSE-ConnectionGUID: c3scD4IWSHWsuKiATXR5Tg==
X-CSE-MsgGUID: CK/e03XVSYicrXSZeB78Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93469019"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="93469019"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 18:52:41 -0700
X-CSE-ConnectionGUID: evZScJL4Sqm+7L+p/NbmgA==
X-CSE-MsgGUID: UscXWhvFTpS1/iSTbCkr/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="273051153"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa010.fm.intel.com with ESMTP; 23 Sep 2026 18:52:36 -0700
Date: Thu, 24 Sep 2026 09:51:26 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 2/5] x86/virt/tdx: Configure add-on features on TDX
 module init
Message-ID: <arSCHompqC1OTWbA@yilunxu-OptiPlex-7050>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-3-yilun.xu@linux.intel.com>
 <2f6ac9afef52386fc491145222ea46e54c24a73f.camel@intel.com>
 <arEYMCfdvmiqE4aR@yilunxu-OptiPlex-7050>
 <9cbc8edd0a2f21e69521a7f2dd9f1a1114f2362d.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cbc8edd0a2f21e69521a7f2dd9f1a1114f2362d.camel@intel.com>

On Tue, Sep 22, 2026 at 02:48:58PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2026-09-21 at 19:42 +0800, Xu Yilun wrote:
> > > It seems inconsistent that global_keyid is passed in even though it is
> > > basically global state, while addon_features0 is retrieved from the global
> > > state. Passing the result of get_tdx_addon_features0() in from the caller
> > > doesn't make a ton of sense. And we already reference tdx_global_keyid
> > > globally from another seamcall wrapper. So I'd think dropping the arg when
> > > you create the wrapper would be best in the end.
> > > 
> > > The smallest change to stay consistent would be go add an addon_features0
> > > arg to tdx_sys_config(), but it's hard to justify as good code. I'd maybe go
> > > with the global_keyid change and it probably is a separate patch, but we are
> > > brushing up against mixing cleanup and feature enabling... thoughts?
> > 
> > I'm not sure. My thought would be removing "u64 global_keyid" argument
> > for the new added tdx_sys_config(), to make this patch reasonable.
> 
> Ok.
> 
> > 
> > And the cleaning up of its caller - config_tdx_module() - could be in a
> > separate cleanup patch out of this series, make sense?
> 
> Hmm, I'm not sure about that. I'd think you would need one patch to remove
> global_keyid arg and use the global reference. That stands on its own.
> 
> Another patch to extract the helper. BTW, since the goal of this series is to
> get acked, I'd think the cleanup patches could still go ahead.

Per the discussion [1], I'll leave the global_keyid unchanged. It's good
to pass the value of a global var around, to show we are not modifying it.

Thanks for connecting the 2 discussions.

[1]: https://lore.kernel.org/lkml/199d392a-02da-430b-95ee-b176ed0f43de@intel.com/

> 
> > 
> > make W=1 doesn't complain, but maybe shashiko will.
> 
> 
