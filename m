Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996F8199FAB;
	Wed, 15 Apr 2026 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277444; cv=none; b=uPKV1DLeH93bde+3ESA+ZM0LOoYeje9EURdt/ZQNESrJ4/BiKm92EpGTpfQuwdhG0S3n0ufIDT6TN8RYwZszNrR5A+VD53hnjKqj+L6CwvX7fTgkS6XZN0JLA3W9e96x6vOagB5S5VwewHSujheGLjNtWSBaoT9s8ufgf01nIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277444; c=relaxed/simple;
	bh=toz3JdrFqywdQ1N1YW6RdFzMCnDjkLzxlrNd6YI/f4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHMw5BAap2d7WkXQrCVNFLYbJW7cl3osYQVcZjfSNB/lMAct0UQhaQWlJf7nMmb07PGl3Kwjv1bTFy41Kf11GCewaABeuwlEfEDsSM3NemH7EdHhTK2GEPulWTTLLMAorxbednSmJSo+ZV7XaYCxNLmmqIU4ABsrsBGgz8RhoGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZjDMZmG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZjDMZmG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2499C19424;
	Wed, 15 Apr 2026 18:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776277444;
	bh=toz3JdrFqywdQ1N1YW6RdFzMCnDjkLzxlrNd6YI/f4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZjDMZmG9Tv5XNzNODl/4eBvz0K87GeLOCUOjAKBNFkdQGaCxlglToNBr/O3nRt1U
	 kW8gHJJFo4bY5eLtHljzoJiB/h5q7XP3m4glZo2yyysUrLtl2xBleCDhqLw10iiPqM
	 7O0PyjAFzxvofjdsGZg9FmvoyMztV+21HT9s8dAzR5rbAYh3Cqp7x7Zlr/hyg9ly/+
	 nQHgtcBxltryV/JH3XgwVCbrOCWQY/aSDCzskrmoLvP2id/8RKp/ytOaveGsQdtOT7
	 Ic7SColmb7LIviu/UDMkv+ynO0gZIlS1XLgXwET8bOqYR3OBt3VqCutHNEItd578CV
	 VZwe+h9e5hK9Q==
Date: Wed, 15 Apr 2026 21:23:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matt Evans <mattev@meta.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: Don't export DMABUFs for unmappable BARs
Message-ID: <20260415182359.GC361495@unreal>
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

I noticed this check in vfio_pci_core_mmap(). Isn't that sufficient?

Thanks

> +
>  	dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
>  				       sizeof(*dma_ranges));
>  	if (IS_ERR(dma_ranges))
> -- 
> 2.47.3
> 
