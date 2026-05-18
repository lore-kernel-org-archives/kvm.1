Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250C41DC1AB
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129230; cv=none; b=nUBikKmFK2XSJCsWUAdrnLSZeOiw+qTNA2PzVO0NQtbYLediX1B2n131LazgUI6Av52vXP2aqcG/365JWXDqpBv4SngV+gKiugWx8tF8qhVfiAWcC32rs42oYnZxwE9ODqB7DUlxaLagxm8d70ls81wsG1p0zsy7EhvfPWE9u+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129230; c=relaxed/simple;
	bh=TyOWWPWoGocXqSwMD+MG/Lr0Gd5wpTyR5wdZ+yXhOuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjGNZ1csfDIie1f7REQVp/ZV1Vtfr5lB1GDHvannhVXNwqMJt9gxs8QbxWtfcJW8mqw++nfNwVXkZDdHb71n1dXKf1rLW57hZJPJG72WvRrk0hGTmvWQjjAJAivwiGsyxe4wHNnwIMCVbnqbwbUMlWfUT2tCwSKk+gkYykD9dUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dM7DWiBy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dM7DWiBy"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso165ad.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 11:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779129228; x=1779734028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KANnHv0swkPJJWZfqLe5jM5UVpVbFidl0DzMhA68oc=;
        b=dM7DWiByYe8lKa/W5HffJEzRb8QQ2J6ehvri9xzEccfN5lahVqt7CZbogLJXCQmc6n
         PTpZDSVLqrurzy4WnJFB4yCD5/iU+V8JYaHB8Dy1scEddTLDKR6pRn87L6W5K0iKV1Zz
         N6ujjO7q0T/4fYyHsFBS9xADZEinsc3s7jLBWZvTQZGjaQ774BN5MECKSxJ7efx0g3zH
         BDXThMFyYrN7bU2lzREOCFXasWXPbeVgxRFcXSZdpb34t/+//+IUnSl8aInrMxlHI9V1
         dUuu+55gzxyTgsV/ef/ZaI5tDL9tedQGJp+clsdDGgl7x+SjNFfnM6cfDuL9RTORj0mx
         +bMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779129228; x=1779734028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KANnHv0swkPJJWZfqLe5jM5UVpVbFidl0DzMhA68oc=;
        b=ZMB8QKDI3XPC8vgxm2tyYIOyHCAerxF+4zqrKPnKY4osLMMfv0idzqybr0pCYUYYDB
         NTI49Wly+AY1TDMGYuYb71hiC2SqdGCNrO09wioKR7NK/azlCj0esmlpszwbNbkTM//1
         BdD2njpwkaEnuGFFF+TXanGQDQkU4UkZGIrd8iQ28irl3HWQPvrjAwBX7AZkTgzbXRBl
         pwEGskENkCPh99d4xVYjvd+9i80UDegA5N9D91KqFGDBGB2UHEB9QwQHApFF9kqjxDp8
         1UfH14brB8W67OGGIGOqyUp3VX3tCnbipbkfc9mJ9vdKI4iaV0MuMCc9Zbhw8obUHdu0
         TYPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8xl1oUQJl8VTSqKB6Cf1wrk22ZULQS7otKDS5oX6ej5Uc2unF84F49bkXx9SCa7/pLaCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk/MBVNrQeu9aA698fp2rUtEz910C/f0NpFeX1M3H+WN73lUcl
	k7SnEzZ4GhiX1SCrt3e71Gf7LBKYZ9XZplBeo8KkwOofbMOCnKo/yHSiwUiHv0Vdmg==
X-Gm-Gg: Acq92OFPmxUUmkJxtH86hSh+NaDycttBjTdBHDcEcP4+La4hohOW08mK5v88Liq3+or
	n+p1od9yUpwkL9zpfqmq3EIOrfjggzyTz6brQ7XneF9zgljBA7IyTz2lwjYu/8c2eBnjkXHrVhK
	Ae0aqHq82Wo1NZZZZd5yj0tSrfona+DUqfboFFjVtq3l5hyDjYsXAHtF/NLYbWrEM0mj2qRCMfU
	jARXG8G4zGhvpLQVdIsuNn5FsFZL+dKdHK+ues2Yuip0kIAiEPY5dawFReDKBowomzybRIEMDj0
	hxv3VWuwI865zgVKkb5jmonKOZVCpu4qQmnXUcs4Rf40FDNpRWSL7XiskB9XmGSsFTQZFH4NJZw
	jx6MF5v18t4SrtKtFQRe6WjFECOBR12GO3dZilSnz1U/MxkrKUzl9cZDrx587WILDnBMhcsaRIc
	CxOUw9GzWCNvcaqLnBEhhkqBi1e94TMtGs53H1UywBxpQNaD6XZUf5+N2BmWCyUVy3SqcRyA==
X-Received: by 2002:a17:903:32c5:b0:2b9:e831:5e5c with SMTP id d9443c01a7336-2bdb03a42c2mr3898675ad.4.1779129227834;
        Mon, 18 May 2026 11:33:47 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe6487sm156913305ad.54.2026.05.18.11.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:33:47 -0700 (PDT)
Date: Mon, 18 May 2026 18:33:44 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 04/16] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <agtMUUYyc1qx6GG7@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-5-skhawaja@google.com>
 <3874a086-98ae-4b94-8c1b-20e13f5a92fb@linux.intel.com>
 <afzcqWa8iVqrhJLs@google.com>
 <agsbtV4oargwX45d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agsbtV4oargwX45d@google.com>

On Mon, May 18, 2026 at 02:01:25PM +0000, Pranjal Shrivastava wrote:
>On Thu, May 07, 2026 at 06:47:07PM +0000, Samiullah Khawaja wrote:
>> On Thu, May 07, 2026 at 10:07:43AM +0800, Baolu Lu wrote:
>> > On 4/28/26 01:56, Samiullah Khawaja wrote:
>> > > Add IOMMU ops to preserve/unpreserve a device. These can be implemented
>> > > by the IOMMU drivers that support preservation of devices that have
>> > > their IOMMU domains preserved. During device preservation the state of
>> > > the associated IOMMU is also preserved as dependency.
>> > >
>> > > Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>> > > ---
>> > >  drivers/iommu/liveupdate.c       | 162 +++++++++++++++++++++++++++++++
>> > >  include/linux/iommu-liveupdate.h |  33 +++++++
>> > >  include/linux/iommu.h            |  20 ++++
>> > >  3 files changed, 215 insertions(+)
>> > >
>>
>> [snip]
>> > > +
>> > > +int iommu_preserve_device(struct iommu_domain *domain,
>> > > +			  struct device *dev, u64 *preserved_state)
>> > > +{
>> > > +	struct iommu_flb_obj *flb_obj;
>> > > +	struct iommu_device_ser *device_ser;
>> > > +	struct dev_iommu *iommu;
>> > > +	struct pci_dev *pdev;
>> > > +	int ret;
>> > > +
>> > > +	if (!dev_is_pci(dev))
>> > > +		return -EOPNOTSUPP;
>> > > +
>> > > +	if (!domain->preserved_state)
>> > > +		return -EINVAL;
>> > > +
>> > > +	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
>> > > +		return -EINVAL;
>> > > +
>> > > +	pdev = to_pci_dev(dev);
>> > > +	iommu = dev->iommu;
>> > > +	if (!iommu->iommu_dev->ops->preserve_device ||
>> > > +	    !iommu->iommu_dev->ops->preserve)
>> > > +		return -EOPNOTSUPP;
>>
>> I will check for unpreserve ops here also.
>
>[snip]
>
>> > > +	pdev = to_pci_dev(dev);
>> > > +	iommu = dev->iommu;
>> > > +	if (!iommu->iommu_dev->ops->unpreserve_device ||
>> > > +	    !iommu->iommu_dev->ops->unpreserve)
>> > > +		return;
>> >
>> > Is it considered a driver bug if it implements the preserve hooks but
>> > not unpreserve ones? This would at least cause a silent memory leak. How
>> > about adding a WARN like this?
>>
>> I think the preservation should not be done if the unpreserve ops are
>> not implemented by the driver. I will add these checks in the _preserve
>> functions and return EOPNOTSUPP if it is not implemented by the driver.
>> >
>> >    if (WARN_ON_ONCE(!iommu->iommu_dev->ops->unpreserve_device ||
>> >                     !iommu->iommu_dev->ops->unpreserve))
>> >        return;
>>
>> We can add this warning here also.
>
>I'd rather have the iommu device registration fail instead of solely
>relying on these WARN_ONs here. We can simply add a snippet inside
>iommu_device_register():
>
>#ifdef CONFIG_IOMMU_LIVEUPDATE
>if ((iommu->ops->preserve && !iommu->ops->unpreserve) ||
>    (!iommu->ops->preserve && iommu->ops->unpreserve)) {
>        pr_err("IOMMU: %s: Asymmetric live-update operations detected\n",
>               dev_name(iommu->dev));
>        return -EINVAL;
>}
>#endif
>
>This prevents a half-baked iommu driver from ever spinning up, completely
>eliminating the need to check for it inside the live-update session paths.
>We anyway don't support hot-pluggable liveupdate ops atm.

Hmm.. I understand your point, But I think we should let the
registration go through so the IOMMU can be used. Its just that the
liveupdate preservation will not be supported. Failing the registration
would be a big hammer that I think is not really needed.
>
>Thanks,
>Praan

Sami
