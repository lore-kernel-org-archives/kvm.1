Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA145DF61;
	Wed, 23 Sep 2026 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150387; cv=none; b=ZAPLh7nrPEnsoc7VKIcDmhfAbKfiIf6HD/xHEOUynooz1TZHUIfCQ7GE01MhKMt3XCUDR3ADSnGfKAGr8UoXDkvI6YEDFUt+zKmaF7wKiozkSh83byERPj3kzxZZ0asz4mQzrau89plEOUNgHcRUa1wOLCGMD70nCkIb7yaDnhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150387; c=relaxed/simple;
	bh=8rw3+c4kPtR72QWHxMWMRr1gNJlZjyztVlhL0rhpLDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fs+OXcEZ0AUaSSXBWONB7oodvLcp0mvLnnwqZ+2yxRj6nC9cqmH6WjBwnugr2LtRSiQBMgrJmJOsKxZw/b1PKmS/9QJ846I8LpKC6+42o/AqRg9ZxM/1LxH0il9J1S2kCQXyGuMP76AIjRyUqkBi7vQL+2Lf+anmGgVD1jDVYfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ps+1welo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ps+1welo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790150384; x=1821686384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8rw3+c4kPtR72QWHxMWMRr1gNJlZjyztVlhL0rhpLDA=;
  b=Ps+1welokkG32YHbQc4GmkjXqDqa7JfENsGUErot4ijq5jeTzWGfJioJ
   NfnEMvCJ+rZhzuP58ALONk00Dk/j002EZYo0E9zO5Pg7RdgNbqJ1IE6MF
   ZKhtHsCDnUZ+9wRcjOcJ4dKFtr4QDi+WT+o1yOcpZ/uW/XPt5D2o74cxA
   f5y8s66GFQRHGnbTiN7C3Y6P31yierzkECT9eGA+7KOPIq/kV9ex3arHN
   JmKCvm5TNlw8yGYm653YMeratU9aVs8Ogcj36zjCtXE3g+kvbJCW49N5Y
   lDAHJ0GypohfvKitDNqkLA8iNaW2GwbZJNk8EUxnWivdUMMPyDZVoS91O
   A==;
X-CSE-ConnectionGUID: MdhoCvdMQweOfsG+096ZRg==
X-CSE-MsgGUID: Wo1PjFTZQmmt+PARcWsbPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="94639989"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="94639989"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 00:59:31 -0700
X-CSE-ConnectionGUID: Po7jkFkVSc2JkQTQNtzy6A==
X-CSE-MsgGUID: Ahay1OAaSNGIRt0bt+dd4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="270023355"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.235])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 00:59:25 -0700
Date: Wed, 23 Sep 2026 10:59:22 +0300
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
Message-ID: <arOG2s3VZMQjLWey@tlindgre-MOBL1>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-3-yilun.xu@linux.intel.com>
 <arIqtGbSRHGw8fiT@tlindgre-MOBL1>
 <arOAL2Klu+L91JiI@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arOAL2Klu+L91JiI@yilunxu-OptiPlex-7050>

On Wed, Sep 23, 2026 at 03:30:55PM +0800, Xu Yilun wrote:
> On Tue, Sep 22, 2026 at 10:13:56AM +0300, Tony Lindgren wrote:
> > On Tue, Sep 15, 2026 at 06:26:55PM +0800, Xu Yilun wrote:
> > > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > > @@ -998,6 +998,15 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
> > >  	return ret;
> > >  }
> > >  
> > > +/* List all kernel supported add-on features0 bits here */
> > > +#define TDX_KERNEL_SUPPORTED_ADDON_FEATURES0	(0)
> > > +
> > > +static __init u64 get_tdx_addon_features0(void)
> > > +{
> > > +	return tdx_sysinfo.features.tdx_features0 &
> > > +		TDX_KERNEL_SUPPORTED_ADDON_FEATURES0;
> > > +}
> > 
> > How about get_tdx_supported_addon_features() for the above? It makes the
> 
> mm.. I think this would make a bit confusion. "tdx_supported" reads like
> the module supported features, which is just .tdx_features0. But here we
> want both the module & kernel support. I'm thinking of:
> 
>  get_tdx_addon_features0(), just as is
> 
>  or
> 
>  tdx_get_supported_addon_features0(), maybe this is better?

Something to describe it's masked with Linux supported features would be
nicest.

Maybe something like get_tdx_masked_features0() or just
get_tdx_usable_features0()?
