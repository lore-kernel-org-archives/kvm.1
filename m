Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B722459CF;
	Sun, 26 Apr 2026 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777200739; cv=none; b=NPlinDPKBITR5LPg1vLymsKNRiwlkQ6S3bKXLxfJLkWf93bqk5tZx/oQ4vurnOaOD8yPNbhCNXfXTgl88tpf1OmLdVI7MaXJEiilsaPTbPq7YgqRaO4qChBorRk/VdHCMdgqY6PiuQ5a9Wrk6ZOQ7Xe+uwKCi6YGns5W5PW2xSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777200739; c=relaxed/simple;
	bh=lNdbI4/apg1ysSsy83oxwfPftRF4Br9c6ZIns4MKmcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHWAdcDyaF3Fesxp4tN20MlQ3V6wIhUT5LzPjxCBmIjLn4tl7PmluA5vMW2zdfcHtQPX6KkkiCOWfFnoi99Qo6sa/BZaDbex/sb4q3Sz5S1CLPJaIKTt58/uS3S1vEtG22682Dd7AFcfJnynFP5A6gv1Zc+huiYN20cVHlbDtBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hfr9xNcU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hfr9xNcU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79468C2BCAF;
	Sun, 26 Apr 2026 10:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777200739;
	bh=lNdbI4/apg1ysSsy83oxwfPftRF4Br9c6ZIns4MKmcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hfr9xNcUqlk+qH6bcnj9WFdahdi/+KDiSesUiqrA8reL0MzFxy0++syvclaIlpz3P
	 B8JxvylaHT3Xwx9AAhk46IY+t1DMqQv18H4w7NWye3zArUgg6BCSRVoMcntzSOxaiA
	 Dg9omC+3ngGzS9FO+aSVbeQ6hlT+J9WVSjMq2JKe7+mXjrRewm+ElgvrIqcp0fQonr
	 +VVM/PhE+swJE0L4nVj+Im+kuXQhA7Y3W8xjI3yQ3nEx1QtWstvFCugOTpxwQpx4gw
	 BEiEZookIYZUJY2DMvc/slD1qTrSsiUImb3TM9yQfeUekDqstZiXi4xnxbNuk1Tgmj
	 2bZ/ygwh33E8g==
Date: Sun, 26 Apr 2026 13:52:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>
Cc: Matt Evans <mattev@meta.com>, Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH 9/9] vfio/pci: Add mmap() attributes to DMABUF feature
Message-ID: <20260426105215.GA440345@unreal>
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-10-mattev@meta.com>
 <20260424183153.GJ3444440@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424183153.GJ3444440@nvidia.com>

On Fri, Apr 24, 2026 at 03:31:53PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 16, 2026 at 06:17:52AM -0700, Matt Evans wrote:
> > A new field is reserved in vfio_device_feature_dma_buf.flags to
> > request CPU-facing memory type attributes for mmap()s of the buffer.
> > Add a flag VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC, which results in WC
> > PTEs for the DMABUF's BAR region.
> > 
> > Signed-off-by: Matt Evans <mattev@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 15 +++++++++++++--
> >  drivers/vfio/pci/vfio_pci_priv.h   |  1 +
> >  include/uapi/linux/vfio.h          | 12 +++++++++---
> >  3 files changed, 23 insertions(+), 5 deletions(-)
> 
> Nice and simple
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> > @@ -1549,8 +1551,12 @@ struct vfio_region_dma_range {
> >  struct vfio_device_feature_dma_buf {
> >  	__u32	region_index;
> >  	__u32	open_flags;
> > -	__u32   flags;
> > -	__u32   nr_ranges;
> > +	__u32	flags;
> > +	/* Flags sub-field reserved for attribute enum */
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_MASK		(0xfU << 28)
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_UC		(0 << 28)
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC		(1 << 28)
> > +	__u32	nr_ranges;

Alex,

The TPH proposal extends the flags field in a similar way, but I suggested
a different approach to conserve bits. At the moment, we spend three bits
on a single feature, which feels wasteful.

What do you think?
https://lore.kernel.org/all/20260409120415.GF86584@unreal/

Thanks
