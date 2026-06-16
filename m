Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE4C30AD0A
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599635; cv=none; b=i6LULQdZo0/fGWaJU9DBgh7IUIWR678m7bvANG7q0ovm4rQxyFYo67ZNPKHbTMq6v8wBMs1xchMmWIY9lcudFL/er8k2eWzOaewGSO+ttsGUvpGX4DrzMJUuC5MSn8samjSDLUNQVj2UcdQjMyZsOiD+fsn4wD4bIBROqG1U2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599635; c=relaxed/simple;
	bh=BnJwSd7RECcx3D1OGlALN3XdkO1Bexr15k/yfmWPTjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lj8uUrft7tBl3cEabdEnWqzKJ6APBGeQ/ejwyVlIfrPLSRb6IhT3JGroP94Wn94XY0+cIZEMFjUOvQ37wojjM82iZ9NXS3RNqijkcgL5avsMobGlkgAEnEoTapfvLz74UIXUBSvbDbqAIIMi4NChUPokWRe3o144s+gmIiqn8F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JREkhH/G; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JREkhH/G"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf22c18ad3so41245ad.0
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781599633; x=1782204433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aaTfOOhj7DmWaDCSdXoWZe8eYeEqWjLH4eK4JZJxdgM=;
        b=JREkhH/GYaGp3SK3puEdr3YP5mZ4fsUcGqySUj8lOOWD2mfyxtlvTXlcjCQDDQnF1Q
         zP6s2+X3kfTLWeaoS8//Bp4PArYjRB8wnFtFUTdDHiNjMQ6n7GQ5kjc6XJ1mOutarmkd
         VBRQx11LKSpjnKl3f3jqYdgfCo30L0J8c9qLn60uujswgAh1u0Y0o0q1yAi/hJyF93jh
         7FWoN5kvrkFokzQ0FlK32TEKfEMOZ5pm59t6kLj7j4Kp/HOvFL5S5wZbOLrdoGRJIRTP
         dvJodgeFx1B78D98oudTQC9VfT4ai970NVigsaI+Q+n/5ghN8jHmIyP5bvzRY+hS7Scr
         Io7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781599633; x=1782204433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaTfOOhj7DmWaDCSdXoWZe8eYeEqWjLH4eK4JZJxdgM=;
        b=KgjYuGjzgW49OWDA6IVlaqKq9IDIyUjWtyYLBiLP9io89RQ5AK/0WNRjK5eFrUrsIk
         f9uGby+1XbCe9V83y8NWra+uhQ+gkEpcpa+IkppYykLOi8nEzReaNym92L1LjRWB91qt
         t7VHjTHqYbkUWovhqzUt6VFCXobUvDgDgMms2L4hOYX2ZHGQn2HTYGXs8F9FGhJDfXpr
         TuKGExh2G7O8N1wG5hwGauSaw7YqhDMjwNClZk0H4L3K00d5UpAGJ1CDNr8Tzejoe/PQ
         OxbPz6JF51O59QeaFOXltEx9a8ss9pN3jP+D0/joAIUaEFMp0kPZ6/k9UvAOJIG1mF0V
         92pA==
X-Forwarded-Encrypted: i=1; AFNElJ9+UbjLjtOMjJNSO02z73YTUoWe6fdyOTc+br/DeinXnVAYIQx+mvVdd/yiKvnhNY4e8Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3QobJ/RUegYUBnjqU7FDPuKh7O/sSScsHJexvW1HmMyRQnKV5
	rXasHK+s+h2KWZ27CmTcte/Gvyg2he47pwtmJJoLpE9gzkLkC0yqri5Y2MYPcZ9cuw==
X-Gm-Gg: Acq92OHx/m22QK44ulQt/Fhljk7foCNFMWxrA5IXqJFyQ2S/YND5OxhhW2d6E2PV3aa
	3Og6zN1W6neYdoOTK1W1pplCaz145aQl0rv13jD4ljNHebw8WZryLK3XFck2tjeVEQvG8WKasSh
	AdWtEl57OWGIEMCeKm9DCj9Heu9kRO7qHF8ROe3xRiRstlGSeBoqMM7VUQ9qx7hNBH2dTcPxfW6
	/uZtwB8bFkjMcq6XEA6TLmznuPw9EX5sWXrBYVrI3y9Fn4H1y2sQgXYH9PZiQctFudX9T6PLBTQ
	KW/QvVdVnuUmdSqQB2NHTSVbgiy1DDs2AxCsOTwooNSW4c0geqpxz/52mTbMsKS8L1EiB0YKzqn
	OsOrrAOJPBVUGLHBKsayTImBq/3BSlYt0v/YliE/3yN/pHkJ338dqYO3XTDn+irxr/ZjxI15W4O
	xjSzMPFOAQYTrwmF7nuYL8Hn9akNcgMl2AFX4WuGPpNEOpZSYn1McMijzIiIcm
X-Received: by 2002:a17:903:3c4d:b0:2c1:ee6e:4e4c with SMTP id d9443c01a7336-2c69c30f5a8mr1709625ad.29.1781599632758;
        Tue, 16 Jun 2026 01:47:12 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb50bfsm125397885ad.33.2026.06.16.01.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 01:47:12 -0700 (PDT)
Date: Tue, 16 Jun 2026 08:47:04 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 9/9] vfio/pci: Add mmap() attributes to DMABUF feature
Message-ID: <ajENiAQkzXjbxgRX@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-10-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610154327.37758-10-matt@ozlabs.org>

On Wed, Jun 10, 2026 at 04:43:23PM +0100, Matt Evans wrote:
> A new VFIO feature, VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR, is added to
> set CPU-facing memory type attributes for a DMABUF exported from
> vfio-pci.  These are used for subsequent mmap()s of the buffer.
> 
> There are two attributes supported:
>  - The default, VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC
>  - VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC, which results in WC
>    PTEs for the DMABUF's BAR region.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/vfio/pci/vfio_pci_core.c   |  2 ++
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 57 +++++++++++++++++++++++++++++-
>  drivers/vfio/pci/vfio_pci_priv.h   | 14 ++++++++
>  include/uapi/linux/vfio.h          | 27 ++++++++++++++
>  4 files changed, 99 insertions(+), 1 deletion(-)
> 

> +int vfio_pci_core_feature_dma_buf_memattr(
> +	struct vfio_pci_core_device *vdev, u32 flags,
> +	struct vfio_device_feature_dma_buf_memattr __user *arg,
> +	size_t argsz)
> +{
> +	struct vfio_device_feature_dma_buf_memattr db_attr;
> +	struct vfio_pci_dma_buf *priv;
> +	struct dma_buf *dmabuf;
> +	int ret;
> +
> +	if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
> +		return -EOPNOTSUPP;
> +
> +	ret = vfio_check_feature(flags, argsz,
> +				 VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(db_attr));
> +	if (ret != 1)
> +		return ret;
> +
> +	if (copy_from_user(&db_attr, arg, sizeof(db_attr)))
> +		return -EFAULT;
> +
> +	dmabuf = dma_buf_get(db_attr.dmabuf_fd);
> +	if (IS_ERR(dmabuf))
> +		return PTR_ERR(dmabuf);
> +
> +	/* Verify DMABUF: see comments in vfio_pci_dma_buf_revoke() */
> +	priv = dmabuf->priv;
> +	if (dmabuf->ops != &vfio_pci_dmabuf_ops ||
> +	    READ_ONCE(priv->vdev) != vdev) {
> +		ret = -ENODEV;
> +		goto out_put_buf;
> +	}
> +
> +	switch (db_attr.memattr) {
> +	case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC:
> +	case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC:
> +		WRITE_ONCE(priv->memattr, db_attr.memattr);
> +		ret = 0;
> +		break;
> +
> +	default:
> +		ret = -ENOENT;

Nit: Looks like the agreement [1] was on -EOPNOTSUPP / -EINVAL but we 
took -ENOENT here and in the doc string? Was that intentional?

I tend to agree with Alex's suggestion here, we'd prefer one of those 
two (-EINVAL / -EOPNOTSUPP) since it clearly communicates to the user
that "You sent a wrong arg" or "We don't support this"

-ENOENT means no such file or directory [2] to the user. Users may not
be kernel engineers who'd wanna peek into the code and they may simply
look at the uAPI files which doesn't give them an answer as to what went
wrong.

> +	}
> +
>  out_put_buf:
>  	dma_buf_put(dmabuf);
>  

Apart from that, 
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

[1] https://lore.kernel.org/all/20260602131417.41366391@shazbot.org/
[2] https://elixir.bootlin.com/linux/v7.1-rc6/source/include/uapi/asm-generic/errno-base.h#L6
