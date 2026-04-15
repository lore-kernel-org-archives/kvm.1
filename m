Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD02E212566;
	Wed, 15 Apr 2026 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277944; cv=none; b=h44aEHvzMtweP3bG9Cy0pWlw/mZ6EFEqrk2JS8lXF0pib3o9kalIi2ssQfuOcW7yaf65kC44aApJ+Xq/mN7CBqOmbkN0TinuIRzOot6WLUaOFXfs50yq+gbbAVkP41NAQizccCnjalWBWsxUQlx12jt/QzDjApjbFSMYvtOOSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277944; c=relaxed/simple;
	bh=NJkfQmKK91UFvG40kpmcktur/+wOmjcT4Od0pkA+2ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP9+uz344CyxtPxTxy/6RhCtSe2XySNfXDe1H21/+Gx3PFrqDm3N3jK9+lOjwx4SdikvFbZ1Nlg8PeyuyF1Oe967LLUm7lkMekqLnOuBoGIKJXHJT9kRZWovH4n9EvcDMK/+0RdIb/5+vocrIMnyNJeIhGCW4AMnwOx2cOHGJjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXdHXC5O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXdHXC5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11616C19424;
	Wed, 15 Apr 2026 18:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776277944;
	bh=NJkfQmKK91UFvG40kpmcktur/+wOmjcT4Od0pkA+2ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pXdHXC5OS7wtv5ZeYasJ3din3Oz3s1yiMq2e1I3SgteJNtOBpN1WFzWWxHduySjGw
	 cl0190/XPuGhpa0ZI8ow13h42bic5Gh+GV/ZikfWI7rlb6RVLn8KPHdZU6tRfjDEC/
	 EZq8LSbbL9YdM7c78Uj3X9sjHZcqRb+RxWVU+TfaeY+8Gkl+0bAzujhy673wxYzUh7
	 wZ2BXpCPW9iIauIrlvRXkfCOyftnaewDlagzi3/BsyVNEcoHiJ7WQiA7lcTAUDL4Dx
	 v99ry+B0M5h30h6e65RN35HXSxQP2k8ze5qLJbECZrkg0q/kdWvb/MWwT1ltScuf9f
	 BqnvVf8ozjS5g==
Date: Wed, 15 Apr 2026 21:32:20 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matt Evans <mattev@meta.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] vfio/pci: Clean up DMABUFs before disabling function
Message-ID: <20260415183220.GD361495@unreal>
References: <20260415181752.1027604-1-mattev@meta.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415181752.1027604-1-mattev@meta.com>

On Wed, Apr 15, 2026 at 11:17:52AM -0700, Matt Evans wrote:
> On device shutdown, make vfio_pci_core_close_device() call
> vfio_pci_dma_buf_cleanup() before the function is disabled via
> vfio_pci_core_disable().  This ensures that all access via DMABUFs is
> revoked before the function's BARs become inaccessible.
> 
> This fixes an issue where, if the function is disabled first, a tiny
> window exists in which the function's MSE is cleared and yet BARs
> could still be accessed via the DMABUF.  The resources would also be
> freed and up for grabs by a different driver.
> 
> Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO regions")
> Signed-off-by: Matt Evans <mattev@meta.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
> 
> Jason,
> 
> Added your R-B from https://lore.kernel.org/kvm/20260330132952.GS310919@nvidia.com/
> 
> Thanks, Matt
> 
> drivers/vfio/pci/vfio_pci_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
