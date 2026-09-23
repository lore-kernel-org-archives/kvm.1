Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7A84508E0;
	Wed, 23 Sep 2026 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148728; cv=none; b=QImRx4tppkHVu+ahXyjtufk4BcCEGCyIVvvd3OHcIHB1auOXA9mi3Q0w6lB1vr0uZrPCDnXDBfs4nbA47m8gPKzLkXXxr/whZ/9ghdj3FPyMpnTk+9OlMSiwfmzhGh0954YONXuoclz2yTYcfhL5aF41sCVXqSSOblTMqSTp9tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148728; c=relaxed/simple;
	bh=SHoV46IGp0r1Mgw9p20NaWVqyYQSQSikZbfLmgAsLa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jH/uhj2nNZ+zTcsuZl/zjRLfS1TrQNFrJ/GNmmsfM53Cjew/WDg6av/gU2mcM/LrCVKX/4SdGxGzm59e/KPWEDH0mKP89YPJxF8oXmSdFuEeRuHymP6Pa6VhK9AvDJ4zIDRw73PTQS/EntcffcP9r5rkkeg2DIyDuX6ORXXsQ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SogCKDo8; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SogCKDo8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790148725; x=1821684725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SHoV46IGp0r1Mgw9p20NaWVqyYQSQSikZbfLmgAsLa4=;
  b=SogCKDo8Gfr6qUMOnKcqit1XA/9cgECEvFF+Xyl5NXradzz4GqQesfD7
   Ixp399yTNb+bI/9AyJAjIpq+BK+dl1O/Ll8F3g/tiomyUy9N9m6H1zLJI
   jCimPGZlEn2m5KzNdPx/BwYInQne1hpvVNRLGfZsbBghQ5+t0u/iZImLC
   S1iP3kvjX/ARsp2ewoUVgdjXYUyLwERhhxpgxWLK9EwMipAHFGJcDhVcT
   e2haSnVXu2f4UbciFCtJBRuExdRnNb7AP0puR+pe1X91qui4n0iGi7NXu
   GQq3byqTbyFKoxY78VZQJvmbXknExKuwfrsV+iXEtCxuJ89uzomjhJ4kF
   g==;
X-CSE-ConnectionGUID: Q9PATbWXRMudQQSMs0Ix+Q==
X-CSE-MsgGUID: xR2N23XYT5qw75P2RvwTQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1320714"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="1320714"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 00:32:05 -0700
X-CSE-ConnectionGUID: 4DfhbtCoSZeiI95kED0xJA==
X-CSE-MsgGUID: TJSv5C3BQleQTGNgnnwlOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="272978551"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa007.fm.intel.com with ESMTP; 23 Sep 2026 00:31:59 -0700
Date: Wed, 23 Sep 2026 15:30:55 +0800
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
Message-ID: <arOAL2Klu+L91JiI@yilunxu-OptiPlex-7050>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-3-yilun.xu@linux.intel.com>
 <arIqtGbSRHGw8fiT@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arIqtGbSRHGw8fiT@tlindgre-MOBL1>

On Tue, Sep 22, 2026 at 10:13:56AM +0300, Tony Lindgren wrote:
> On Tue, Sep 15, 2026 at 06:26:55PM +0800, Xu Yilun wrote:
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > @@ -998,6 +998,15 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
> >  	return ret;
> >  }
> >  
> > +/* List all kernel supported add-on features0 bits here */
> > +#define TDX_KERNEL_SUPPORTED_ADDON_FEATURES0	(0)
> > +
> > +static __init u64 get_tdx_addon_features0(void)
> > +{
> > +	return tdx_sysinfo.features.tdx_features0 &
> > +		TDX_KERNEL_SUPPORTED_ADDON_FEATURES0;
> > +}
> 
> How about get_tdx_supported_addon_features() for the above? It makes the

mm.. I think this would make a bit confusion. "tdx_supported" reads like
the module supported features, which is just .tdx_features0. But here we
want both the module & kernel support. I'm thinking of:

 get_tdx_addon_features0(), just as is

 or

 tdx_get_supported_addon_features0(), maybe this is better?

> calling code a bit more readable without having to figure out what it
> returns.
> 
> Other than that:
> 
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
