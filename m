Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B61548A2CA
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112900; cv=none; b=FD/hAMGPb8J3TSIUgtRPMD+YaKoqtvk23pDVZD8VeDCUnAuUbGcVvXYBCjd6NyAPdtXrhJxS+wug3jRhAS4rhDdOb/cT77r+V7vZFLs0to8J6Ld6e8oh5tI0SnliARggdzE9PrlzvjDn0GgPCpVHnuobyWIAvKqLpDRKjSi0/80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112900; c=relaxed/simple;
	bh=pDXXz1TH87s1IivcdxWzN8kqNDaLaW3x0g7egMGT/II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuKhXUbtlzMBTqtd6N29tW0ODjsAhSFXLNOjcl1v7wZsAN3ozbZts4CUM6Z2QfgQHuafEWYUOEvW0McZFUQJPLJHk//PO+Fh4MCaQIRH+vuXyxGECKoc524wF3Dkcgd7CRmNQx3fyJ7mWqItVXO6KbLI//hdtWQqpkdusaVZwcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kk5GTAF8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kk5GTAF8"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba180a022dso1295ad.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 07:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779112898; x=1779717698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J/DDwNmydnZ95awbzSL1/xD68dz5V6Sw49Abl3+3NpU=;
        b=Kk5GTAF8yZbICqo34orGOy7kAHN/xjMcb6DHedlQsj3x1cofzUCsDLw318LfVZWlNN
         0jdbMplSr59a21y0H+Xp/l/A5q7Ecj6QR5rpUw3RlZ7W8qq8hT0UUlo8P6UatE/cTLXD
         F+09V2EiXFiEN7EeppU5C06mHn9pmazd2mr9Q29itqEu72QdMt6beugOPYPZ8k65dNqD
         U0OpQ82RZWeJTSfwIm7suEqZY0ODtpaiPPS/dlBKnVmNgb4xdKJDmmDGexkZ9ru0mqL3
         P5auiMXerMLsE6TXd83qHzjVYfSKUArsWDvYlzG1I9F+j2LoRrjyW6f8hIeaf3UPB/wM
         mC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112898; x=1779717698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/DDwNmydnZ95awbzSL1/xD68dz5V6Sw49Abl3+3NpU=;
        b=N4Kh1fukpf+8r7EBXWESCjyZPwDKMfKc6SgpV5LIcW94cJEU09XYQ1oqW9+3Jva2TZ
         m8Q2Zwi25/aqioaABIDB5tWSSq62ITf4v+1a09h6OPYnH8tfUT49dgtVONVrwBJeuzTf
         vJWl+TPSjDCUAN4C52YndFQM1G+Bp2p80Mr1AEkzoSI2BQGaNl/HB0FvhI6d9jndY8ie
         G/HZ34xQXvxWAlxZIpgNqVDEgIqikxwtVHtIqwKzAE2coZJYPlcdrzhfQRX4bx7MSUwM
         ZOopKUfp7F9UOG1pg94Vwa1F4bIdhfl13xk+S/9zAsEsMhu18cxyoHedu0LLOtoUqt85
         tvNQ==
X-Forwarded-Encrypted: i=1; AFNElJ+y+CkQsx69E4J8fqFVisC0hRd9fk5v6NdZ3Y3R+LldSyLaZgRUAveZ/oMjdQzm0NPwqGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCZ7fKPeQ+vV1ApV136UJL4aEK6VfjRbstx0jleytONndFGqSK
	6fV8fPj9WGcvMlQhkQjVvM5eCuDy0BGvnRQ+3Mkval39sUrzUVxIk1z3meEjdSLNcQ==
X-Gm-Gg: Acq92OH/bmRkOKfcsSFxTF+gKRchKEG/d7EjMSf2mQh02OeI1nx+bNvqAZrPeKBDXO9
	AFCVl/Ode+/bnTf/zaekI4GUI+i1S1Tc0hamGXYkIRCAo70hC+iwW8Bu9lHhZ6z/1SWgvPwJYWB
	lyZr3WOZlYu6GJtdojVxDseWUeP+CzQl/2AtoH1DkJpaBxL7MybaoJVfqzXEh96dZamZQV9kpLG
	/UCuhd41BDMeAmt6Wwg/LilGNR1Hu7T28KdaWe9Ineg5c87yaSu6/m6utndKBKnO7fMwc8neR74
	hl7i6u7O8HniZEhbPgQhJL1ofLVmWgrImJpP986ZMDITjYBOSGd84XoiXDCFlQcZm3lAUrNMtCN
	Za0RY5tc5ZQh0RMe+Fjqi/MSgECIzOeG3ZTGjG94wH2q/e4qoEaGGo2yvWjwJLF3hT+xswKncvF
	FaS8LXcCvCBogCpSUsFB6dyjM0m4GOTUP47lpdaeStyJwYl2nwRw8j3Dns3zRnJGEMvQ8/
X-Received: by 2002:a17:903:fa6:b0:2bd:a61:8536 with SMTP id d9443c01a7336-2bdb03a448amr2847385ad.6.1779112895495;
        Mon, 18 May 2026 07:01:35 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11b495sm159037515ad.69.2026.05.18.07.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:01:34 -0700 (PDT)
Date: Mon, 18 May 2026 14:01:25 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 04/16] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <agsbtV4oargwX45d@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-5-skhawaja@google.com>
 <3874a086-98ae-4b94-8c1b-20e13f5a92fb@linux.intel.com>
 <afzcqWa8iVqrhJLs@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afzcqWa8iVqrhJLs@google.com>

On Thu, May 07, 2026 at 06:47:07PM +0000, Samiullah Khawaja wrote:
> On Thu, May 07, 2026 at 10:07:43AM +0800, Baolu Lu wrote:
> > On 4/28/26 01:56, Samiullah Khawaja wrote:
> > > Add IOMMU ops to preserve/unpreserve a device. These can be implemented
> > > by the IOMMU drivers that support preservation of devices that have
> > > their IOMMU domains preserved. During device preservation the state of
> > > the associated IOMMU is also preserved as dependency.
> > > 
> > > Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> > > ---
> > >  drivers/iommu/liveupdate.c       | 162 +++++++++++++++++++++++++++++++
> > >  include/linux/iommu-liveupdate.h |  33 +++++++
> > >  include/linux/iommu.h            |  20 ++++
> > >  3 files changed, 215 insertions(+)
> > > 
> 
> [snip]
> > > +
> > > +int iommu_preserve_device(struct iommu_domain *domain,
> > > +			  struct device *dev, u64 *preserved_state)
> > > +{
> > > +	struct iommu_flb_obj *flb_obj;
> > > +	struct iommu_device_ser *device_ser;
> > > +	struct dev_iommu *iommu;
> > > +	struct pci_dev *pdev;
> > > +	int ret;
> > > +
> > > +	if (!dev_is_pci(dev))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	if (!domain->preserved_state)
> > > +		return -EINVAL;
> > > +
> > > +	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
> > > +		return -EINVAL;
> > > +
> > > +	pdev = to_pci_dev(dev);
> > > +	iommu = dev->iommu;
> > > +	if (!iommu->iommu_dev->ops->preserve_device ||
> > > +	    !iommu->iommu_dev->ops->preserve)
> > > +		return -EOPNOTSUPP;
> 
> I will check for unpreserve ops here also.

[snip]

> > > +	pdev = to_pci_dev(dev);
> > > +	iommu = dev->iommu;
> > > +	if (!iommu->iommu_dev->ops->unpreserve_device ||
> > > +	    !iommu->iommu_dev->ops->unpreserve)
> > > +		return;
> > 
> > Is it considered a driver bug if it implements the preserve hooks but
> > not unpreserve ones? This would at least cause a silent memory leak. How
> > about adding a WARN like this?
> 
> I think the preservation should not be done if the unpreserve ops are
> not implemented by the driver. I will add these checks in the _preserve
> functions and return EOPNOTSUPP if it is not implemented by the driver.
> > 
> >    if (WARN_ON_ONCE(!iommu->iommu_dev->ops->unpreserve_device ||
> >                     !iommu->iommu_dev->ops->unpreserve))
> >        return;
> 
> We can add this warning here also.

I'd rather have the iommu device registration fail instead of solely
relying on these WARN_ONs here. We can simply add a snippet inside
iommu_device_register():

#ifdef CONFIG_IOMMU_LIVEUPDATE
if ((iommu->ops->preserve && !iommu->ops->unpreserve) ||
    (!iommu->ops->preserve && iommu->ops->unpreserve)) {
        pr_err("IOMMU: %s: Asymmetric live-update operations detected\n",
               dev_name(iommu->dev));
        return -EINVAL;
}
#endif

This prevents a half-baked iommu driver from ever spinning up, completely
eliminating the need to check for it inside the live-update session paths.
We anyway don't support hot-pluggable liveupdate ops atm.

Thanks,
Praan
