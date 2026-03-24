Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC6736E46D
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379177; cv=none; b=NGGBA2CCIT8WOcvEdVYWZ781Fy1jFEAwZ3/c0SrPi1trlcljOfGmEpHAgDi47Vqg89GKDfklphxGNu/Cm/RkLwHhql6T4CfVKO3DVSAvwnl0Ryq3yTbonUNpqA0wQxYaKdR72Q6WOk4NbjpAXuwVhRKpu1aoCjdMCRnXCCkxkfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379177; c=relaxed/simple;
	bh=OY+JawPdefNIIKTRfcpNAmqcOgU1VaY4rXCsYqZ8eWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcnE9wCpTesnamMx88Bh1q8pL0QMXdE0CpM38rJBpYmig7Nou2LkSulMLx8FevUTGGMdu3Ykp06IFQ6Reuka902jdBn1GHLtOU2Bxsc3Ch4kg40X60MvDVIM6npixV5uJenc8BakPc7/K4W/WyqkqiUZgGG9lTZc5qRArN0/2dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wjkix6hi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wjkix6hi"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aeab6ff148so15565ad.1
        for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 12:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774379176; x=1774983976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOkQYaahmDwY69WFRWmgoTcg1m+mIiOkSe+Jk7lwxRg=;
        b=Wjkix6hiGdwv+yJ2xNyZhWUC9sZUYPfxz4+U66I8idOwHfrXzifkaoWrzWUxDbFQ9T
         Qpuxq/YfpYWP0QK862PGYuo3e4uK/z/K62atSxjpcRjUiTBAS+LJyU66SXhdosWWXYZc
         aYV6i1tu+XSzhc8c5/RQjYlTHynwg+5CYVYDVahmWnOqzJSQNV+Pjn5Df7xQVNnHBDN8
         zkslv2vM9GByuFYRu/O+MjTUtNAxnpK6WnuOwYjW4geTai17Z+BNVF3/1FzvyYz7pO5g
         ssRlnWsYLPEgfvU3MYDJUnNequ1F+hcSUZpXCy1dhlVqGgGz3N/qNT+BO/pj0pbM+Izc
         HLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379176; x=1774983976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOkQYaahmDwY69WFRWmgoTcg1m+mIiOkSe+Jk7lwxRg=;
        b=U5RozV2Fzrf+EnVnASJj5J5AQQcdqD3HkztcPyiOBMbwWsX2MdLg9aVH19X1dUW9HR
         XZc/g9JgYujdSDB7qXIWgOz4LoU0PGxddYFgUoEZB3v6o0MrqfVFJ9TiisgjySY8oAfM
         Sks/dXzLXp1GJW/thUM6Kj3xSmvCpOC0EV7/jR8t2lrPtDvXbUergMa9sts8gcQ3ZrBt
         w8rD68KlQ1JOgsKM+B3jGsDjPF4HD2+5/dyoOXYoagekI7jCdKRlQ2CWIP620E59yBPJ
         1ZfO/IEBUTXlkcjE+US4o671o9fdvf52PD+5TDlOiCfemXsE7TvKF5n8YOYrLgVli3oP
         9YcA==
X-Forwarded-Encrypted: i=1; AJvYcCX7SqyDwA9S/NmvgxK4VHFw6G53YWrw/ykxYZSkHvmRzMbmanQD4rgp02s7bEmclRUk7L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDUPp4e+UB9XqX2vLpoiXBGunznhMahnfh+uUVAEKIjn+AcS98
	XMTcsoHF3wQ+emdgCw/YOCNSlNppnmwdDLTeIqDFaPIXWL7nokt3JyuiDQV+PctdvA==
X-Gm-Gg: ATEYQzxDBDdxL+R5c0+QGQKEl/x+VxOzxuG865jvzp9WVmrvDe1W2p21c08Fue5ItHi
	vtr97eMBSWOYqpk1Ysv6fOdASiRHJTLQo9Cr6LNKIwXE1DBzM+wiHQk5dN9Gdp3IZpXh6AJ9xML
	T/AMT3MC6cdhEvAlHKjqVSa6P4or47savQMwFx012pJxJXxDsNlNsG7ACWnLhtK+8hYPWTE+A6n
	jVaF2LLdxsYT4UiP2e+kNdklAKWPMGyolzPZRnSdCTojNRVoZ4JaAvQ8+OtTOZ3SYHnaCO8//Qr
	MVTDD4H8Xc2aB8j/JY7iCwz0Q6X5Z4qfEpdz7O388IOf9arQ7WTU5UT6djWyKwLZKyM6QOXjsQE
	ULBHOKLBeLka2wqE7a9PoQCgfm40CXvzx8DJcqSCLTHXVsv6bNvEv5Dfob7COx3nPgAGEszhlzc
	M9sefNdlfl7VYmdAXV+xnaG+XI9LNXJ+UyCATecfkzgkx04h8qIbBpsAmnSQ==
X-Received: by 2002:a17:902:cf43:b0:2ae:4453:3674 with SMTP id d9443c01a7336-2b0b1535e1amr553415ad.4.1774379175146;
        Tue, 24 Mar 2026 12:06:15 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a801701sm11465577a12.4.2026.03.24.12.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:06:14 -0700 (PDT)
Date: Tue, 24 Mar 2026 12:06:10 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
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
Message-ID: <20260324184809.GA190066.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-3-skhawaja@google.com>
 <20260316221854.GC1768676.vipinsh@google.com>
 <abm2C-8xRstbuzIe@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abm2C-8xRstbuzIe@google.com>

On Tue, Mar 17, 2026 at 08:33:39PM +0000, Samiullah Khawaja wrote:
> On Tue, Mar 17, 2026 at 12:58:27PM -0700, Vipin Sharma wrote:
> > On Tue, Feb 03, 2026 at 10:09:36PM +0000, Samiullah Khawaja wrote:
> > > diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> > > +int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
> > > +				    void *arg)
> > > +{
> > > +	struct iommu_lu_flb_obj *obj;
> > > +	struct devices_ser *devices;
> > > +	int ret, i, idx;
> > > +
> > > +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&obj);
> > > +	if (ret)
> > > +		return -ENOENT;
> > > +
> > > +	devices = __va(obj->ser->devices_phys);
> > > +	for (i = 0, idx = 0; i < obj->ser->nr_devices; ++i, ++idx) {
> > > +		if (idx >= MAX_DEVICE_SERS) {
> > > +			devices = __va(devices->objs.next_objs);
> > > +			idx = 0;
> > > +		}
> > > +
> > > +		if (devices->devices[idx].obj.deleted)
> > > +			continue;
> > > +
> > > +		ret = fn(&devices->devices[idx], arg);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL(iommu_for_each_preserved_device);
> > Also, should this function be introduced in the patch where it is
> > getting used? Other changes in this patch are already big and complex.
> > Same for iommu_get_device_preserved_data() and
> > iommu_get_preserved_data().
> 
> These are used by the drivers, but part of core. So need to be in
> this patch :(.

Sorry, I am not understanding why it has to be in this patch? Can it be
its own patch?
> 
> Note that this patch is adding core skeleton only, focusing on helpers
> for the serialized state. This patch is not preserving any real state of
> iommu, domain or devices. For example, the domains are saved through
> generic page table in a separate patch, and the drivers preserve the
> state of devices and associated iommu in separate patches.
> 
> I will add this text in the commit message to clarify the purpose of
> this patch.
> > 
> > I think this patch can be split in three.
> > Patch 1: Preserve iommu_domain
> > Patch 2: Preserve pci device and iommu device
> > Patch 3: The helper functions I mentioned above.

I understand that this patch is adding some helper functions and not
doing any actual preservation. I am suggesting to split this helper
function patch into three for easier review based on the above suggestion.
If I am not wrong this is biggest patch in series of approx 500 line
changes.

> > > +static void iommu_unpreserve_locked(struct iommu_device *iommu)
> > > +{
> > > +	struct iommu_ser *iommu_ser = iommu->outgoing_preserved_state;
> > > +
> > > +	iommu_ser->obj.ref_count--;
> > 
> > Should there be a null check?
> 
> Hmm.. There is a dependency of unpreservation of iommus with devices, so
> this should never be NULL unless used independently.
> 
> But I think I will add it here to protect against that.

Okay. Since, it is a static function, I am fine either way.

> > > +void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
> > > +{
> > > +	struct iommu_lu_flb_obj *flb_obj;
> > > +	struct device_ser *device_ser;
> > > +	struct dev_iommu *iommu;
> > > +	struct pci_dev *pdev;
> > > +	int ret;
> > > +
> > > +	if (!dev_is_pci(dev))
> > > +		return;
> > > +
> > > +	pdev = to_pci_dev(dev);
> > > +	iommu = dev->iommu;
> > > +	if (!iommu->iommu_dev->ops->unpreserve_device ||
> > > +	    !iommu->iommu_dev->ops->unpreserve)
> > > +		return;
> > > +
> > > +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
> > > +	if (WARN_ON(ret))
> > 
> > Why WARN_ON here and not other places? Do we need it?
> 
> Basically this means that the upper layer (iommufd/vfio) is asking to
> unpreserve a device, but there is no FLB found. This should not happen
> and should generate a warning.

Yeah, but other places iommu_domain_[preserve|unpreserve](),
iommu_presreve_locked(), and iommu_preserve_device() are also using this
function. I am having a confusion on why it is important in this
function and not others. Those functions are also called by upper layer.

