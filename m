Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449199;
	b=XPb3PCjcCFoDOROy2POAX25suiC+Z3KpTFQijdCxtW7n5AQkMw3mlDFKifDWZu9MNoG4
	 6zMDKHLq7Q9as5TvhTFkC9ihxCmzCF0AMkCxFyWiUyrJzkD2LCobLUlyMHZzN1H4pq/g+
	 TRz6e9kh3qrAjYcUUUmKkO/AMgYBG3C+5xY33/dL/VxBhq0DFadjaIN7hZFXo77fM7Omr
	 evHRLmuPtpzvvtC+XhotP405i0LSIEIv7coMZuyo5lVFr7u1CrugjhgAs2DJjq4kHaPFs
	 X+7pK8gMXGoIu8MIcAaN/Sirp9JLekzNjiGBzz3GqGYdvRtUuEeGF51ZBQWPRHbVpiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449199;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2p/B/tDeGRhIHo3PpPUcctpXsWm0ZDpkAFpHkG5DAqM=;
	b=XYJ9mPEOTnvEnr87Fz0+8vQpxlgjy11f4MLPa/MMMFn9Ff6k+WAFtMRC8yy56y6wWaX9
	 Ti9ftariADC6zdF+A/IQITaIu/y442uZmxjjosgfAjFzPKRp2+WhZfSanfLPCz1ppgOvQ
	 ss0/fVOYjkiS7cGISZuLTRGExFAwsjW6kKQod9YfmFAf6rIwbdrDMzE3Qzl3/WYblqxtH
	 Kks1I/ltoaYUmfSg0oHisqzQjOiwNyjeBydp5mX3oe0aezPlDNusxOhxgQfLa51uC7A7Z
	 wbLfkz4ThBNAogjXjZVsgLi9Z6sv+cOk8/mhqtERifjFdSROjcq+ds5kanqQt2qSTGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hm9AFgWY;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE91606A333;
	Mon, 23 Nov 2026 15:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EE91606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hm9AFgWY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795449199; x=1826985199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/5CxvQlHei5C8QPMGIb9LL2Jgw4T6fH+WUJa2t/y+IE=;
  b=hm9AFgWYJcKdTxFFfqprhoKdiA/RUQwf4Qe89ga7jqkZQTHA5gQsG6L/
   qmRbM4fs8XYqKo3IDBglOXrz7jIZqwq2rhnLUiuwtqbN6F804CyvRz92j
   0S6QLUF0c75FuJeGIRQOTbKYeD12IHuDkUweDgAgM/zEbQhI1SUmqYwcX
   EhHHvwiz2mJoi9nj040LYbhQKzLOE0b7m5JeY9+RlC4CjYUMf/7KFRZTl
   P7W2nwg4Lu9gC//3FBDA5rw9lk/4VlvZkJX9P5C3kSVH+7EbT403DQL98
   3q5Q40OKz63MlBdIO6hwFa9wBlRNU2OaHVSItuBldVARR74rNumrLvS1C
   w==;
X-CSE-ConnectionGUID: NtZWAFwPTEmImp7uCoB8lw==
X-CSE-MsgGUID: KrDbr12fRaqPaRxndk3zxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4152510"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4152510"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 07:53:18 -0800
X-CSE-ConnectionGUID: D7CUMNcXRtan+HEKGskbOg==
X-CSE-MsgGUID: 6oxWOKaWQ+KpV3pJZrseAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11488037"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa003.fm.intel.com with ESMTP; 23 Nov 2026 07:53:14 -0800
Date: Mon, 23 Nov 2026 23:43:33 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, iommu@lists.linux.dev,
	x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] coco/tdx-host: Add skeleton to support PCI link
 encryption
Message-ID: <awRfJZgno2OBDNJm@yilunxu-OptiPlex-7050>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-8-baolu.lu@linux.intel.com>
 <de1011bc-1cc0-4409-af76-4e90dcef6cf4@linux.intel.com>
 <d77bab15-3e35-4185-b328-99712f607435@linux.intel.com>
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
In-Reply-To: <d77bab15-3e35-4185-b328-99712f607435@linux.intel.com>

On Mon, Nov 23, 2026 at 12:18:32PM +0800, Baolu Lu wrote:
> On 11/19/2026 10:52 AM, Binbin Wu wrote:
> > On 11/12/2026 12:30 PM, Lu Baolu wrote:
> > > Register a Link TSM instance to support host side TSM operations for
> > > TDISP, when the TDX Connect support bit is set by TDX Module in
> > > tdx_feature0.
> > > 
> > > This is the main purpose of an independent tdx-host module out of TDX
> > > core. Recall that a TEE Security Manager (TSM) is a platform agent that
> > > speaks the TEE Device Interface Security Protocol (TDISP) to PCIe
> > > devices and manages private memory resources for the platform. An
> > > independent tdx-host module allows for device-security enumeration and
> > > initialization flows to be deferred from other TDX Module initialization
> > > requirements. Crucially, when / if TDX Module init moves earlier in x86
> > > initialization flow this driver is still guaranteed to run after IOMMU
> > > and PCI init (i.e. subsys_initcall() vs device_initcall()).
> > > 
> > > The ability to unload the module, or unbind the driver is also useful
> > > for debug and coarse grained transitioning between PCI TSM operation and
> > > PCI CMA operation (native kernel PCI device authentication).
> > > 
> > > For now only check for TDX Connect support in the TDX Module and
> > > register the Link TSM. The TSM support is basic boilerplate with
> > > operation flows to be added later.
> > > 
> > > Based on work by Yilun and Dan.
> > > 
> > > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > [...]
> > 
> > >   static int tdx_host_probe(struct faux_device *fdev)
> > >   {
> > > -	return seamldr_init(&fdev->dev);
> > > +	int ret;
> > > +
> > > +	ret = seamldr_init(&fdev->dev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return tdx_tdisp_init(&fdev->dev);
> > If tdx_tdisp_init() fails, it will also disable TDX module update and the
> > version sysfs attributes.  If this is intended, could you add some description
> > in the change log about it?
> 
> You are right. That side effect is unnecessary. Module update and the
> version attributes don't depend on TDISP. How about fixing this by
> making the TDISP failure non-fatal so tdx-host still provides module
> update?

Now we see all features are necessary by default, if any feature fails
to enable then the TDX module is broken.

We can have exceptions but that need well justification. Currently I
don't see the need to surpress the error.

> 
> Something like:
> 
> -static int tdx_tdisp_init(struct device *dev)
> +static void tdx_tdisp_init(struct device *dev)
>  {
>      const struct tdx_sys_info *sysinfo = tdx_get_sysinfo();
>      struct tsm_dev *link;
> 
>      if (!sysinfo || !tdx_supports_tdisp(sysinfo))
> -		return 0;
> +		return;
> 
>      link = tsm_register(dev, &tdx_tsm_link_ops);
> -	if (IS_ERR(link))
> -		return dev_err_probe(dev, PTR_ERR(link),
> -				     "failed to register TSM\n");
> +	if (IS_ERR(link)) {
> +		dev_warn(dev, "failed to register TSM: %pe\n", link);
> +		return;
> +	}
> 
> -	return devm_add_action_or_reset(dev, unregister_link_tsm, link);
> +	if (devm_add_action_or_reset(dev, unregister_link_tsm, link))
> +		dev_warn(dev, "failed to register TSM cleanup\n");
>  }
> @@
>  static int tdx_host_probe(struct faux_device *fdev)
>  {
>      int ret;
> 
>      ret = seamldr_init(&fdev->dev);
>      if (ret)
>          return ret;
> 
> -	return tdx_tdisp_init(&fdev->dev);
> +	tdx_tdisp_init(&fdev->dev);
> +
> +	return 0;
>  }
> 
> Thanks,
> baolu
