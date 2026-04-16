Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3350C38C438;
	Thu, 16 Apr 2026 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327104; cv=none; b=eLwkpvoC+le1i9NqVVvmrru97KgzQl8MATzE3itfwxK2NaS66ie0bVLVtqOJ3S3F9/wdu3MbCnbbWJMBLxKEUMqiAOHv6sfgkztSkFnr8fgUCr/BI5KvCWxGJfGtazv9d00PWnGVgwJiIaY2tv58nBlnYyKJrwWfdNAsi4o+cCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327104; c=relaxed/simple;
	bh=tXyz13WeeW3uQcW29849BhJ5uoo6XkupaeU5Z11PdAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMIkFzr2QLuvafK+6wUqKWgP8AESpGE9stBUpa86G08PY1b/AOnSTRF2OfqutZcDOcUrnLV1MrVie071/8SzBMCSTJx0TnxW4bPuv25sPop/vDGWU/PjM2ZiKPoIFDqeUH59gV6qDHWMQEDi8njAk+HvIemlZnnsgLFM7jvDmNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzGLCCUC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzGLCCUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC41C2BCAF;
	Thu, 16 Apr 2026 08:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776327103;
	bh=tXyz13WeeW3uQcW29849BhJ5uoo6XkupaeU5Z11PdAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AzGLCCUCRADOVk7quL71ySNbY1Am+s1GEadSXEFH8v0xXcwOzqfYFQpKrkfnMEwjM
	 A6iUpjZ14f1xdOSiDFHUNG51qIrgSx7DYfoONSVZohrtQ2KTH5AwXTKu8n0mXIguqf
	 BxeZ0Gn1PjZubzLVyr4GvpQzAvI0HxOWu9xRkSXFaVFBpm+8gS2n+N/6gbVv4+A7Rq
	 X+RJjrhwhG0edICsDDjzv3C2b04vv+3x/hx6ef+GWtBXuWPeAGmsxPajefy6b1HEaa
	 4cS5RV63SPM8tQixGEeAIveuTDA1rP03huYLx6yIh5/Ryk4Rblv2r2j96YDhaf3xA9
	 /J3G1G9BA3xJw==
Date: Thu, 16 Apr 2026 11:11:38 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matt Evans <mattev@meta.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: Don't export DMABUFs for unmappable BARs
Message-ID: <20260416081138.GE361495@unreal>
References: <20260415181623.1021090-1-mattev@meta.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415181623.1021090-1-mattev@meta.com>

On Wed, Apr 15, 2026 at 11:16:23AM -0700, Matt Evans wrote:
> Although vfio_pci_core_feature_dma_buf() validates that both requested
> DMABUF ranges and the PCI resources being referenced are page-aligned,
> there may be reasons other than alignment that cause a BAR to be
> unmappable.
> 
> Add a check for vdev->bar_mmap_supported[index], similar to the VFIO
> mmap path.
> 
> Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO regions")
> Signed-off-by: Matt Evans <mattev@meta.com>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index f87fd32e4a01..4ccaf3531e02 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -249,6 +249,9 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX)
>  		return -ENODEV;
>  
> +	if (!vdev->bar_mmap_supported[get_dma_buf.region_index])
> +		return -EINVAL;
> +

And it looks like AI has valid concern about this line too.
https://sashiko.dev/#/patchset/20260415181623.1021090-1-mattev@meta.com

Thanks

>  	dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
>  				       sizeof(*dma_ranges));
>  	if (IS_ERR(dma_ranges))
> -- 
> 2.47.3
> 
