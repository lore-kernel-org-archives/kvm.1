Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F1834F247
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384232; cv=none; b=nxfphnM7v1zjzHOrbeqZ/suWCmuuGZQtJwIeH7A3ptnycfMSTQRG9Sg3KiHJI829mFX4+qQ+DTqRIAbMhibBWxsNaRnd/95M/wcS4HBV1v/3hzlaIpbmBbVmhCAocAgN8buUg42rDUSwvYNt1lu+M7gGcr+iwfklKzonozDTTQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384232; c=relaxed/simple;
	bh=Tey6SVYpWtryUf49rWPG/gjXRb3iJqKZf+I/nXWKq3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hkt9dxm9Uza76wfNNZ48N3zsTvScDfZe/Q+q38MLP2uL9e9aaG14rcujdHmEP18t/sawc3vJyz7/fswIFEfjj5+JaTVLGHaHf5M+fzQvcVJ1U33SUoAdV3No6qCqDDEs9EqfQ2HA2TmFZQOYKMoHZtGpnK+yMsWGauG/CYmbvAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GlzBCp7V; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GlzBCp7V"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b052562254so27965ad.0
        for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 13:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774384231; x=1774989031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4GyQVsw9WUXq0Tx/o/WK9RzM8Q6jgQHyNgH4GZL/eMM=;
        b=GlzBCp7VhEaSUTMEWeHQB2SRwYEbds+t8ADwD+sRmPNCFiND8+FSrLzfmWr1UszKZ5
         nzad9ksgGx0Nu9czsUDcY5ku26boW7m8E0ul3Xjuam4I+b7k2HjWqPWz3Fkl8ohEH4+W
         0c4KEu0ETACnUIWqO8MYBO6OzS6g5vQc0HNr2KPu69Sve4yT8TrCZ1PqYf0nHVYJ8ofS
         yo/LFxkKdNP7RTIEjs1Wu2acdyyeEr1dCO8wlQ3Z9aA1w5jusCiAlJzjb2yqL4zhshUb
         e3PGQvq1qxDNsT6QbkgErLcPj3AgR7gKjR7oFdGWETP/rC6+X5T1iHELLkB0ncxX0bY5
         zE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774384231; x=1774989031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GyQVsw9WUXq0Tx/o/WK9RzM8Q6jgQHyNgH4GZL/eMM=;
        b=fkVIlCzHB/yftDMKxNExIjk/grxONoZiEBDoToZx5B51NZPgJ16A0kqOoOtaILzFCG
         KiWYu6LQRNu/SNkHi4KQ9wHx7FqgPUUkwJfwWNPQ1wmd0HFPZiZZAgDnSe52d4lFuyg1
         4dqH50sFX6TnLv+kqFn/AZvyhM7g+lyn0UwKSCIgTg5FwP6E763ixBkdTAwN3oeWATfQ
         RP1vVFhskCVog5hzMfu2F5BE/RlcYlKtsxSpsYAe+Zm88u0T5apYkp6mi6c+X4f93YPn
         BVmZg95h4M8yL4c5cZ0N+JYu98Jr5eQ8RQX6pQSV2BF2JXdvv8kccoUuwmzYKffLik+Y
         aiKw==
X-Forwarded-Encrypted: i=1; AJvYcCW5gnJnXc/09Ntbkc9/wEMdMFqlaEsfpqfgdRLPixtYuuA/rrTm97MlXDcGB15Ayhj1nSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDmPgvrUvbfYZSTgMxyFbv++rFx83Srz5pDUY30OOVjVS3Q80i
	etcOhZVilBzxhI/cV9BBm9kdQ8CwICRdAeIfGw1bzyY7ntJJQYG1OCBUBpkEtQIHAA==
X-Gm-Gg: ATEYQzyKpuid2l6umLmzcdQ+XSBlkFs2Ip3dPRqwMJ+VUPpCxLDLdi5aqvJMBc/izj1
	KfJOyLAZ5kAgQUX50V4b+uX+0lp8EBdi3ySzuVm4kf9WWGD29+xvi83HL4O3Z/hWt0/0qpUqTb3
	DVlVXACuYvs9zySOaa4kFwTWhIeMaGDfk7xGodCJpgX9suptIlp4jZKhZgR3Xsj42dJ5LmPeBYf
	BczGnaP46a8KIHWVk7f1VKrpZGGjFA7P9b6aOJM1cFIn4uSY2tRY05ORSYI5L1PT2NbMAQHoxEL
	pE2Jmbu9HtSbrdnQ6nDp82FKmgfNycT337pdyqCl2ynjyWBZRaKq5fNy9hqQK7zypDHo472ayYP
	9SY8t7dZbUNenr9OZguPnPFIVJPnJSUiIrVI6jq7wfi1Evb09tB8lW6e+Clk6SOAM7yQER77FZA
	IYd0yXPS1PRG5aS+3o1V04L2r6JR6qMj+T98bj13l5ag4a4XmW4pSvtHW3bg==
X-Received: by 2002:a17:903:32c5:b0:2b0:95a2:f84e with SMTP id d9443c01a7336-2b0b2ad9dbamr141655ad.19.1774384230665;
        Tue, 24 Mar 2026 13:30:30 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aa960csm16439526b3a.12.2026.03.24.13.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:30:28 -0700 (PDT)
Date: Tue, 24 Mar 2026 13:30:24 -0700
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
Subject: Re: [PATCH 13/14] vfio/pci: Preserve the iommufd state of the vfio
 cdev
Message-ID: <20260324202859.GF190066.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-14-skhawaja@google.com>
 <20260323210111.GB2571566.vipinsh@google.com>
 <acG3M41Ho96FyJ8V@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acG3M41Ho96FyJ8V@google.com>

On Mon, Mar 23, 2026 at 10:07:31PM +0000, Samiullah Khawaja wrote:
> On Mon, Mar 23, 2026 at 02:17:29PM -0700, Vipin Sharma wrote:
> > On Tue, Feb 03, 2026 at 10:09:47PM +0000, Samiullah Khawaja wrote:
> > > diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> > > @@ -49,15 +51,32 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
> > >  	if (vfio_pci_is_intel_display(pdev))
> > >  		return -EINVAL;
> > > 
> > > +#if CONFIG_IOMMU_LIVEUPDATE
> > > +	/* If iommufd is attached, preserve the underlying domain */
> > > +	if (device->iommufd_attached) {
> > > +		int err = iommufd_device_preserve(args->session,
> > > +						  device->iommufd_device,
> > > +						  &token);
> > > +		if (err < 0)
> > > +			return err;
> > > +	}
> > > +#endif
> > > +
> > >  	ser = kho_alloc_preserve(sizeof(*ser));
> > > -	if (IS_ERR(ser))
> > > +	if (IS_ERR(ser)) {
> > > +		if (device->iommufd_attached)
> > > +			iommufd_device_unpreserve(args->session,
> > > +						  device->iommufd_device, token);
> > > +
> > >  		return PTR_ERR(ser);
> > > +	}
> > 
> > driver/vfio/pci/iommufd.c has all of the code which interacts with
> > iommufd in VFIO, I think we should follow the convention and add a
> > function there which can be called from here.
> 
> I am assuming you meant driver/vfio/iommufd.c as
> drivers/vfio/pci/iommufd.c doens't exist.
> 
> I see iommufd_ctx and other iommufd_ functions being used directly in
> various places outside drivers/vfio/iommufd.c, so there is not a hard
> split I think. This will introduce unnecessary indirection I think.

Yes. sorry, for the wrong path. Sounds good, I misunderstood things.

