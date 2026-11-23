Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448203;
	b=zAYEIZXNJMai67mKEFlnIrK8RqMclCfYOqsBui4zajxipUFUzEri+E/kQT6/NXYb4Rq3
	 b81x0PWWwHsLtAeWo8bWdYT5iXORsBG/HEcw9ZQ9C8h6ZogG3W5tY7r1LKGZrLj2zRYcl
	 0uFAGPD0uchfcV5GsYt4RbJxH8AL+IgFtE6u0wiXtC1skkYeorN6ES6aT6pm/gfnRh3uI
	 aN610nxxyMbJxM5kR4c+Q4tFozL2vcMz2VdeFSDXzGKxgWOI0HasT/KnWHHufj1MyzZm5
	 GzA599adzZUZfmycxK8Zc5pSc/KRSfPuBr2gaKfBk2xAFlMgyHrhrXsVU/dtPlDHPCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448203;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=iH9Osx1WH1Y/KQi30hi+nTRPfYUPETmiCdl6TuZB0IY=;
	b=v8z6n1yZOwbDQ6UXCaYBW7rMh/ttN/US7lFKyfx+53KK9P+HGbsn5avYf5qxrHPJdQzR
	 tx8BKRrnvUDJQ6oX7TGu/+oOebsbX4ix8asaG3nz1fvEENz4GH2TLX/bk5aDkN4/FceQM
	 kNuuQ1om8fT6L1dGVvBisRcc75nD+ZDGkPqYhr89JeJ9AtT8vyV87CNqcTgJ9EJdMo5Hc
	 HGwEw3CUDgG6DNoxBMl8sfIY/jxoSfQHylWrpLTbJxreUrIqAdIfvOJUAN42/ehWSUWM7
	 vjdWdpHNqkEJEHvskUbSQkGlt7nuhXYwOeWAUBtALQKQI6HzHTr4LtBpdIKIZLGle4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="LWoxj+/P";
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF14606A337;
	Mon, 23 Nov 2026 15:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDF14606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LWoxj+/P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795448203; x=1826984203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WhGM7Q5iFOyHC9FRsJORCHpMZE6hReH187ed9xveTVU=;
  b=LWoxj+/PZgqkqoAGQygDUL+kwEzoqo5FS/dZbTL8iDbjZB2FIqtHAezN
   WoEyfxBT9K/5/uO8XUy6It163QFfBpyJwqeeLLGub0E+DemetkF78raqs
   m4JiSZL3AYQfWQxgeu9RWPaP/11P5VKILpAIbfW1Cw3dSgCNMWOGQqkm1
   KFWNGA1VggMPGJBuLBP9UaqxRQCUovqQMEDNCuckMKXAAaXVvrUFn19FM
   lp99Bb4WrjRutTChREiJoGDL7+1Gh4VGI6usilH64NI5uzo/UovxKTTfi
   vVSUiAea04dE1808+qlT4tBblfqLD9/3IbZZK6dSmO2/oxov98jt2q059
   A==;
X-CSE-ConnectionGUID: mpP014XzQ9OATmruIjUZRA==
X-CSE-MsgGUID: /NWiMtYoRymz/uE4XkGyog==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4302208"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4302208"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 07:36:43 -0800
X-CSE-ConnectionGUID: 7k4dpiovR3GnGfD99An42Q==
X-CSE-MsgGUID: 95HMssZDQvyPyiyiMzxrIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11684225"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa009.fm.intel.com with ESMTP; 23 Nov 2026 07:36:40 -0800
Date: Mon, 23 Nov 2026 23:26:58 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Chao Gao <chao.gao@intel.com>, iommu@lists.linux.dev, x86@kernel.org,
	linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
	Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] coco/tdx-host: Add skeleton to support PCI link
 encryption
Message-ID: <awRbQhb3HBfulvfC@yilunxu-OptiPlex-7050>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-8-baolu.lu@linux.intel.com>
 <av1QxRYY9sXtC--P@intel.com>
 <d9f3eecf-5655-4779-9e8a-b3ff4cbdb667@linux.intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9f3eecf-5655-4779-9e8a-b3ff4cbdb667@linux.intel.com>

> > > +static inline bool tdx_supports_tdisp(const struct tdx_sys_info *sysinfo)
> > > +{
> > > +	if (!(sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT))
> > > +		return false;
> > > +
> > > +	return false; /* To be enabled when kernel is ready */
> > > +}
> > 
> > Patch 2 open-codes the same TDX_FEATURES0_TDXCONNECT check. Can this
> > helper be moved to patch 2 and used there?
> 
> These checks serve different purposes: the metadata patch checks whether
> the TDX module supports TDX Connect; tdx_supports_tdisp() decides
> whether the kernel is ready to register the link tsm. The latter may
> include additional checks, such as quirks, so I would like to keep the

But I don't see the need to distinguish them. Any case the kernel is not
ready to handle TDX Trusted I/O, but must read its metadata?

> helper for the tsm registration.
