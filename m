Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8417233933;
	Fri, 18 Sep 2026 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725313; cv=none; b=fBpfi3wgYQqCPSNE4MEShQoNNywRIEDoYsl1S4C0sg1zE794NWFawFQb9NADSd3jPZUXXp1uNfaI6djrWfOkl0PlGjyzt5CroO1KXxl+hLWw0+RX2k9Ug5ZizIpbXe06fOi6PXsvc+WX6GhOB4MxF8TGfFlh081OXIZjgsy6gXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725313; c=relaxed/simple;
	bh=IGcNG9V6vpEAmGJWRLXEzH9r5ld2oVhwqzI1320opF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyxgxlZyauGYqepeIQRCdnBzitrCpBtELVN2FXYMaGYgiH+NjWYvvVdSr+AHHeeKGUC1OJoMTdMrJTal+wzCnZMZkpbe0sEES1grNIu2nPQvcgec8bG3RI42k78YUprVtJCy1QNG3IW279vmCPQn4LhG/nbrWbFai+yfAX8oq3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FLbnAawq; arc=none smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLbnAawq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789725312; x=1821261312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IGcNG9V6vpEAmGJWRLXEzH9r5ld2oVhwqzI1320opF0=;
  b=FLbnAawqVtwQ922jow9hBwPCrCKA4K1IWjri0oYOMrx6uxft4957paj7
   6TJMvv7KY4inh0MEZ44Y6Q+X5w5q6GPpmLPV4nAqkrzzFxEZKnJegccXo
   NbPUXBDdksCmFkd8eUSH0iyH0HfsPfQtIfRg0zfZ0DlcooHH+mRbFq1Z4
   n4M/HstftqOgGD3BuFXdKNh44S67TntkcqjUEkpukSm0l7+wW8MMuto0B
   unBakCSNRbfT4A+IRp+oBiAFep6fHishvtYrCguBI8VYONYdCmQ/USQzd
   IlVNlkzbI87sqYccCHYushNMXVuFVrS1+nNabujB/BseTTWXhS6+DdnRq
   A==;
X-CSE-ConnectionGUID: nSZr639oQnW+3beefS1w3w==
X-CSE-MsgGUID: DR7R809vQHijZsb4VB2AEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="736020"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="736020"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:55:11 -0700
X-CSE-ConnectionGUID: PvOJQpnTRqOixLSWVMnakg==
X-CSE-MsgGUID: dbSDKyMPSN+YV/pwLgT2yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270999672"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa007.fm.intel.com with ESMTP; 18 Sep 2026 02:55:07 -0700
Date: Fri, 18 Sep 2026 17:54:44 +0800
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
	"nik.borisov@suse.com" <nik.borisov@suse.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH v2 1/5] x86/virt/tdx: Move TDH.SYS.CONFIG operations into
 a wrapper
Message-ID: <aq0KZNuDmTeUDn9T@yilunxu-OptiPlex-7050>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-2-yilun.xu@linux.intel.com>
 <8b5b577cdad5e81c5166349e13541989f2facf53.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b5b577cdad5e81c5166349e13541989f2facf53.camel@intel.com>

On Tue, Sep 15, 2026 at 08:45:04PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2026-09-15 at 18:26 +0800, Xu Yilun wrote:
> > In Linux, SEAMCALL wrappers are introduced to avoid broad SEAMCALL
> > access by exposing only a selection of SEAMCALL leafs, but also to
> > abstract the SEAMCALL register ABIs.
> > 
> 
> 
> > The latter improves readability and
> > reuse for SEAMCALL leafs that are called multiple times.
> 
> I'm trying to adjust to not using former/latter. The feedback I've seen is that
> it is too much to remember as you read along. How about:
> The abstraction improves...

Yes.

> 
> > 
> > Some SEAMCALL leafs are not explicitly wrapped because the level of TDX
> > ABI details needed to perform the call is low enough to flow well with
>                                          ^are

the level ... is low enough, seems "is" is the right one? AI also
prefers "is".

> > the calling code.
> > 
> > For some of the currently unwrapped SEAMCALL leafs, TDX architecture
> > adjusts the ABI and adds SEAMCALL version selection for backward
> > compatibility.
> > 
> 
> Reads a little weird to me. Like I'm not sure when this adjusting is happening.
> How about:
> 
> ..., the TDX architecture has evolved the ABI to introduce new versions of
> existing SEAMCALLs. VMM code can select the version to call based on what is
> supported by the loaded TDX module.

good to me.

> 
> >  Future kernel will need to support the changes. 
> > 
> 
> ?? I guess you mean selecting between SEAMCALL versions?

Yes. I refactored the whole paragraph:

    For some of the currently unwrapped SEAMCALL leafs, the TDX architecture
    has evolved the ABI to introduce new leaf versions. The host can select
    the version to call based on what is supported by the loaded TDX module.
    When future kernel implements this version selection, more ABI details
    will leak into the surrounding caller code, which decreases the
    readability of the caller logic. To keep the ABI details contained, move
    the SEAMCALL leaf that will need version selection into a wrapper.

> 
> > This will
> > leak more ABI details into the surrounding caller code and decrease
> > readability of the other logic. To keep the ABI details contained, move
> > the SEAMCALL leafs that will need version selection into wrappers.
> > 
> > The cleanest separation would be to have kernel data types for the
> > SEAMCALL wrapper arguments,
> > 
> 
> This is now talking about general seamcall wrapper design. It could read like
> it's instead talking about clean separation of SEAMCALL versions?

OK, the transition is not good here.

    When defining the wrapper, the cleanest separation would be...

[...]

> Outside the diff it has:
> array_sz = tdmr_list->nr_consumed_tdmrs * sizeof(u64);
> 
> Could be now changed to:
> array_sz = tdmr_list->nr_consumed_tdmrs * sizeof(*tdmr_pa_array->phys);

Good to me. I tweaked it a bit on my preference:

	array_sz = tdmr_list->nr_consumed_tdmrs *
		sizeof(tdmr_pa_array->phys[0]);

> 
> A bit of existing cleanup, but the u64 is especially tucked away compared to
> before, so I'd argue its maintaining readability of the existing code.
