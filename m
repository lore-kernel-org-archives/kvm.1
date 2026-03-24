Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E063126DA
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381520; cv=none; b=SzxRq+BoDPNQQg/ArDqtHMdtaIeYgohBlRBSeYe7xnJDRkIeclbcPomoXnegRTYTuBm7+fITjzUzY4m76X7sh4XYgL1tkwf8iPPLNUFunbvFcwhuMEELRxFUgCb5UIwhqmY8vzbBlXxD+eeTxNURBwsJfzS2MbyCMXwKQgRK4EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381520; c=relaxed/simple;
	bh=cElslhTE6m9W0YImaAUJVkSxCsiQPpNOSWv/SF1fcSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmwsE6smDPHHuzZk4WVKqN6e7+ONOT6fMgjaENLWD4Kf31YgONqDypnkSld/gAFQEBE9AVgnoKFUbxsYx7HjTJAxOAhPEd1VJ5zy3OcCxfCPaGNs7NXtMXxvgMzGk0Lci2BVdQyrFg6YI2J+hqcyS0XeyIFpXSR8QoBRJiWJDug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aHaP9fVl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHaP9fVl"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b0b260d309so2475ad.1
        for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 12:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774381518; x=1774986318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lk/w0o7W4j7sim/BVALDWnCOxHkFQz3/Bh51qF9Rkjg=;
        b=aHaP9fVlze1m8JrFGgfYGWJQ5c4QkDWo6NQKUSM+H4HXzymIHwTVJwF2pBuQq5+GKA
         26AHws3sOSHnJrK+2rVPfupjOFEM3n+MBwc44tO3SwhmuqQz/0IC4AZNBEVNVIhD7Gux
         ArNdpgR5cqikh18c2a8/g8Xfxk5cXY35uH33GYJEisjByLKN8xUEAILICAToXec4pJKN
         zu/wTH/2l17C74YNhMVJPze7+NsFB3EW7fwlL8uFIcPtrxgRrYhuf8mXyFQS+lGi3fJT
         7bMSW1hm7mAvSLhJtIVevM5AbTmQweMBylgAM3O9X3WIbTMVwDtV2VoGGE78VMRMpT3d
         Uhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774381518; x=1774986318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lk/w0o7W4j7sim/BVALDWnCOxHkFQz3/Bh51qF9Rkjg=;
        b=gQEBsLyju+LGuIsmwC+5HnS7t3QTUFL8MJFPVyADpheFou5iYFez9KaqN2PrO+EbCc
         3iq5FDQ6NPCjdIG04ZoWLTGpAFXKIVS4L9tBumnLDhBBJwAgujLwQ4//cJs0Q/fHz0pc
         avx6ugFy3YV60+EJt/Y/J6Lj5seslRzfEGfXJ25oD9IqdgAdFkcGx7MTR5ZbFpkit6hH
         SMDRvYNTOnXfgkmozixCA+SiwRu7S9VVC4neJsnSLn0nYEQM/KGawOGock6NDo2OuYj5
         /SuCVrDFAq5ILd0PvduMAB1j4HYsRenxKpdIvvhsa2nGFbivpARh2cEHsGOwWJcLFIuN
         4WZg==
X-Forwarded-Encrypted: i=1; AJvYcCVkYIh2qoUmRC1mgibWa8z9KsPc2ZHzwoL4Idf5bdCza0e0yhJMnQ7AhF/PZj7kCdoVJ60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpkJE4cjz3tDX4R6MRMf3gPmN/+VIMmLFYxNsDjVXsNBy9yNGD
	qhSQc6CgPeJMBSaNbuGS3wvbbJ7xJ57EnVZ/CHENPSmOQB8y18I1JXaxT0E+h3SF9Q==
X-Gm-Gg: ATEYQzw9aEoAvg5zB+qRoJ+C0TrW4uKwk1JgW2/Yjut5st81tYPiRJ31Tw90Q06Lcsk
	b2bLHhl6EbSJI7hufMcqIdr84xrakWf4OfuaBDM5QsfsxxpFlDHs27Bj2NT+rOtz5xBzw2EQhA8
	i6whnAqWGxTT4TZB1yPA7zEJtlJvT5F+kBfCdBv7Q+9whW0vQSGftDVj5e8huLmVJFsaZ6arE9a
	9qWn9OTvYpInUDlxQE8Thqu3iWUY78mFxzgSzu7E86/qj9YCiaphIRQT8KmHGUdrkaPbk4vh75E
	lmuCtoWcNgit7A+68XETB2f0/e3WWBPyNE0+Yq8crgviLyNGwV7zl3wiUY+EkW1Q5xWCLxiFrGD
	QgrUOscnRCvXgpZvMs46YnJc5H+6cU0OHzKsi6NesC7b2GY2Y+bZV8HdEX5/AVr87/2JOFgM5uk
	aZsAmy0n2+0vRXHGptqG5nF3nw6IotxFnezCInPBRDborRBqx16Skps0N4SUMC+g==
X-Received: by 2002:a17:903:b47:b0:2b0:aee4:afe7 with SMTP id d9443c01a7336-2b0b1568b56mr739105ad.10.1774381515550;
        Tue, 24 Mar 2026 12:45:15 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aa5aa7sm13255806b3a.1.2026.03.24.12.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:45:14 -0700 (PDT)
Date: Tue, 24 Mar 2026 19:45:11 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 02/14] iommu: Implement IOMMU core liveupdate skeleton
Message-ID: <acLiWVezdOKY4qO0@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-3-skhawaja@google.com>
 <20260316221854.GC1768676.vipinsh@google.com>
 <abm2C-8xRstbuzIe@google.com>
 <20260324184809.GA190066.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260324184809.GA190066.vipinsh@google.com>

On Tue, Mar 24, 2026 at 12:06:10PM -0700, Vipin Sharma wrote:
>On Tue, Mar 17, 2026 at 08:33:39PM +0000, Samiullah Khawaja wrote:
>> On Tue, Mar 17, 2026 at 12:58:27PM -0700, Vipin Sharma wrote:
>> > On Tue, Feb 03, 2026 at 10:09:36PM +0000, Samiullah Khawaja wrote:
>> > > diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>> > > +int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
>> > > +				    void *arg)
>> > > +{
>> > > +	struct iommu_lu_flb_obj *obj;
>> > > +	struct devices_ser *devices;
>> > > +	int ret, i, idx;
>> > > +
>> > > +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&obj);
>> > > +	if (ret)
>> > > +		return -ENOENT;
>> > > +
>> > > +	devices = __va(obj->ser->devices_phys);
>> > > +	for (i = 0, idx = 0; i < obj->ser->nr_devices; ++i, ++idx) {
>> > > +		if (idx >= MAX_DEVICE_SERS) {
>> > > +			devices = __va(devices->objs.next_objs);
>> > > +			idx = 0;
>> > > +		}
>> > > +
>> > > +		if (devices->devices[idx].obj.deleted)
>> > > +			continue;
>> > > +
>> > > +		ret = fn(&devices->devices[idx], arg);
>> > > +		if (ret)
>> > > +			return ret;
>> > > +	}
>> > > +
>> > > +	return 0;
>> > > +}
>> > > +EXPORT_SYMBOL(iommu_for_each_preserved_device);
>> > Also, should this function be introduced in the patch where it is
>> > getting used? Other changes in this patch are already big and complex.
>> > Same for iommu_get_device_preserved_data() and
>> > iommu_get_preserved_data().
>>
>> These are used by the drivers, but part of core. So need to be in
>> this patch :(.
>
>Sorry, I am not understanding why it has to be in this patch? Can it be
>its own patch?

I will move it to a separate patch as per discussion in other thread.

See:
https://lore.kernel.org/all/abrk39_M8k45myXJ@google.com/
>>
>> Note that this patch is adding core skeleton only, focusing on helpers
>> for the serialized state. This patch is not preserving any real state of
>> iommu, domain or devices. For example, the domains are saved through
>> generic page table in a separate patch, and the drivers preserve the
>> state of devices and associated iommu in separate patches.
>>
>> I will add this text in the commit message to clarify the purpose of
>> this patch.
>> >
>> > I think this patch can be split in three.
>> > Patch 1: Preserve iommu_domain
>> > Patch 2: Preserve pci device and iommu device
>> > Patch 3: The helper functions I mentioned above.
>
>I understand that this patch is adding some helper functions and not
>doing any actual preservation. I am suggesting to split this helper
>function patch into three for easier review based on the above suggestion.
>If I am not wrong this is biggest patch in series of approx 500 line
>changes.

After moving the getter helpers out to the separate patch as mentioned
above, the size of this patch should significantly reduce. I will split
the remaining into domain and device + iommu preservation helper patches
as you suggested.
>
>> > > +static void iommu_unpreserve_locked(struct iommu_device *iommu)
>> > > +{
>> > > +	struct iommu_ser *iommu_ser = iommu->outgoing_preserved_state;
>> > > +
>> > > +	iommu_ser->obj.ref_count--;
>> >
>> > Should there be a null check?
>>
>> Hmm.. There is a dependency of unpreservation of iommus with devices, so
>> this should never be NULL unless used independently.
>>
>> But I think I will add it here to protect against that.
>
>Okay. Since, it is a static function, I am fine either way.
>
>> > > +void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
>> > > +{
>> > > +	struct iommu_lu_flb_obj *flb_obj;
>> > > +	struct device_ser *device_ser;
>> > > +	struct dev_iommu *iommu;
>> > > +	struct pci_dev *pdev;
>> > > +	int ret;
>> > > +
>> > > +	if (!dev_is_pci(dev))
>> > > +		return;
>> > > +
>> > > +	pdev = to_pci_dev(dev);
>> > > +	iommu = dev->iommu;
>> > > +	if (!iommu->iommu_dev->ops->unpreserve_device ||
>> > > +	    !iommu->iommu_dev->ops->unpreserve)
>> > > +		return;
>> > > +
>> > > +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
>> > > +	if (WARN_ON(ret))
>> >
>> > Why WARN_ON here and not other places? Do we need it?
>>
>> Basically this means that the upper layer (iommufd/vfio) is asking to
>> unpreserve a device, but there is no FLB found. This should not happen
>> and should generate a warning.
>
>Yeah, but other places iommu_domain_[preserve|unpreserve](),
>iommu_presreve_locked(), and iommu_preserve_device() are also using this
>function. I am having a confusion on why it is important in his
>function and not others. Those functions are also called by upper layer.

Ah yes.. That makes sense. I will add it to the unpreserve variants of
functions you listed, as during preservation the FLB obj should have
been created.
>
