Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA64738656D
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781597153; cv=none; b=OjpjjtzQhjP8bPv6QTGxkovhuhMcgsZ0BFWSZN4yTUmMKH/fjOCp8fjeXUTeKpkpWE5ltD2cZSZbMmQNy04KMewMvQkJsF6buIHbYQRdSNJAdPKXZZtGQCJYKoOnBYSecJIHn2zGSkhOOwvSGxOLYW0swssIa1TFwpwRYzhUqTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781597153; c=relaxed/simple;
	bh=82cTAyW+sZXW13gP4ib75YclIp3CSrYl7g+tdMUCv3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBSSreWKZa5sXOVXWzBGYrSiOntYt2hgJ890zvH1WyhEbI/JAkkHbonz31ggRto+o0bh6zxgIszMjugijlL32Dk8nklMN6assOv3NCLuE3L8g3V0TZlm1Lf/3DWcjz5ExbcEWW9DMYx6RTXXYFYnuTloSuIzb1SgdPJ9uIQ5h/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jMFV0eqh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jMFV0eqh"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf2d865383so29015ad.1
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 01:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781597151; x=1782201951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dOsiBDHauJNUL/mHLBlXDW8Xe2gvOcwU/fMCh1N6uL8=;
        b=jMFV0eqh6/zz9XTZeBSPAGCpdF2pouVCsfKBKgAUmQ5ODxYi6nC9pkFUQJEUc/xDNm
         0aPtGTlHR6NFlBLKUF5ZRpax/F6sjPVCgc3xkCJZOdAWx1tROAJQRjC2S/+5qZV2Krq4
         iz3fVngb9KU6ybAqWt/KhPnK1WpomcEspJofFBbQNLjlc2be+eh3xtLzPLmitoS4qqVP
         b5g6/WKw5t3xuQDsWmZiNq7cNILfmKVtintn7c695vvWdpVw18NWOy2Yzrf0LY61bDoR
         VQ1LpgNio6okg62mJkFO48PMQ5cwWKgRyFnJ6MA1jpOq3yzjsZEMt1Q9RhQQsh6LK0tO
         TeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781597151; x=1782201951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOsiBDHauJNUL/mHLBlXDW8Xe2gvOcwU/fMCh1N6uL8=;
        b=T/2Oi/AB74p/hITBX5Fjdy3QXuL8v6fuh+z5WmmtEhxodY2tZB8y/iZYP+jP3hdyAB
         We0OJF8cOZ6O9m1UOUBoHZHLiOEsGJt9IhPeZTqEZEyZLxfkkfaVOOQx9NKXU5uMNqi2
         K4gWW1f7ysrecub7n2gS8XeR1rbE1XFxXTqz5T4733c9aFqtu0+dls/w50o2yXLSXQGG
         Bj9nT16QcjgLNWOElEofSeyJN0OVYOI9acwvSwbmFOH0+pmORTEXSByy5D2YrfTEhIfU
         nY8gAJck0O0m2UHLDx5cZmnHq4NqF+saWy4S9L0wtNUGAXz6U/9+OXWBjV6p5DBgN+QA
         U6EA==
X-Forwarded-Encrypted: i=1; AFNElJ+pI9PKQveF1UJRC3ZIhECJk2o8Y6ur5KzVj+4cbGKmyX2pOZSKUhGrlXTgtvaYvYhih1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx63ei55FZi7fRmKGZu4lcu6pRS4JgutASaZmGyqHXEtZAVZPsi
	+bzDBhOxe7YvTPPSn1k0tWCa8hWxtxq0csF4mNhF1lh4gmgvfkLsayG2ShNDyUmhVg==
X-Gm-Gg: Acq92OG3xJNH99ioyo9wKMDP6TVjj+KgoxrhmIXTw5iT0Uz3hbqGXz4rBC0XIVOHK8K
	ig2Act5VP6ro3fRErHv5Clc9woinsiA4RWyLgOJA6dEJQ+3uBPZx6+hBGR4UwaiqW03nhrrwQ08
	3GtsUYUV+WQX4s2ilaFkYLl7BWTc5ME3IQ6Z1z0pOTqEoI6me9amiwI9/3aGkqPn6WK2P1XrTVd
	J+icaxy0l9UbgprYkr7qXJa496UifW50xc6fmPZRrJXYlIEu4z119kDnSiXB7d7eVLhsZGRMmvZ
	CtPXMZTp7g8mzlVSltkAkwJWrmYrVViezJE99lfRYGbCPxvSKYpq9iff7MeAvrAjjJ14Ho+H0bt
	gPTMw0zvCHnIQO7c9Emd/cERddkGBJnKZHU1Kqg2KCyQpyZHoqgYwKqouPzyRBKwaMldX0ugdnD
	3yuJhfKtxZJbSrGsEyhSQ603KB7xLmTvHKuWIz//onQKO5TRE6UFmfrsAtFAXh
X-Received: by 2002:a17:903:1b0e:b0:2bd:6dad:7cca with SMTP id d9443c01a7336-2c69a357a8cmr1809945ad.22.1781597150664;
        Tue, 16 Jun 2026 01:05:50 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9c016sm12271540b3a.8.2026.06.16.01.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 01:05:50 -0700 (PDT)
Date: Tue, 16 Jun 2026 08:05:42 +0000
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
Subject: Re: [PATCH v3 8/9] vfio/pci: Permanently revoke a DMABUF on request
Message-ID: <ajED1v846hZkyq9z@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-9-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610154327.37758-9-matt@ozlabs.org>

On Wed, Jun 10, 2026 at 04:43:22PM +0100, Matt Evans wrote:
> Expand the VFIO DMABUF revocation state to three states:
> Not revoked, temporarily revoked, and permanently revoked.
> 
> The first two are for existing transient revocation, e.g. across a
> function reset, and the DMABUF is put into the last in response to a
> new VFIO feature VFIO_DEVICE_FEATURE_DMA_BUF.
> 
> VFIO_DEVICE_FEATURE_DMA_BUF passes a DMABUF by fd and requests that
> the DMABUF is permanently revoked.  On success, it's guaranteed that
> the buffer can never be imported/attached/mmap()ed in future, that
> dynamic imports have been cleanly detached, and that all mappings have
> been made inaccessible/PTEs zapped.
> 
> This is useful for lifecycle management, to reclaim VFIO PCI BAR
> ranges previously delegated to a subordinate client process: The
> driver process can ensure that the loaned resources are revoked when
> the client is deemed "done", and exported ranges can be safely re-used
> elsewhere.
> 
> Refactor the revocation code out of vfio_pci_dma_buf_move() to a
> function common to move and the new feature request path.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/vfio/pci/vfio_pci_core.c   |   6 +-
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 169 ++++++++++++++++++++++-------
>  drivers/vfio/pci/vfio_pci_priv.h   |  19 +++-
>  include/uapi/linux/vfio.h          |  20 ++++
>  4 files changed, 173 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 508a5eca910a..064906b25467 100644

[...]

>  
> +/* Set the DMABUF's revocation status (OK or temporarily/permanently revoked) */
> +static void vfio_pci_dma_buf_set_status(struct vfio_pci_dma_buf *priv,
> +					enum vfio_pci_dma_buf_status new_status)
> +{
> +	bool was_revoked;
> +
> +	lockdep_assert_held_write(&priv->vdev->memory_lock);
> +
> +	if (priv->status == VFIO_PCI_DMABUF_PERM_REVOKED ||
> +	    priv->status == new_status) {
> +		return;
> +	}
> +
> +	dma_resv_lock(priv->dmabuf->resv, NULL);
> +	was_revoked = (priv->status == VFIO_PCI_DMABUF_TEMP_REVOKED);
> +
> +	if (new_status != VFIO_PCI_DMABUF_OK) {
> +		priv->status = new_status; /* Temp or permanently revoked */
> +
> +		if (was_revoked) {
> +			/*
> +			 * TEMP_REVOKED is being upgraded to
> +			 * PERM_REVOKED.  The buffer is already gone,
> +			 * don't wait on it again.
> +			 */
> +			dma_resv_unlock(priv->dmabuf->resv);
> +			return;
> +		}
> +	}
> +
> +	dma_buf_invalidate_mappings(priv->dmabuf);

Nit: We seem to be calling this even if new_status == OK, while it works
as importers (like IOMMUFD and RDMA core) are immune to a double 
invalidate / revoke. I'm wondering if we could move this within the 
if (new_status != VFIO_PCI_DMABUF_OK) block? 

Since this is only needed to be called when we TEMP/PERM _REVOKE?

I'm just worried that this may overload the dma_buf_invalidate_mappings 
to be a state-change notification instead of a revoke / invalidate
notification.

> +	dma_resv_wait_timeout(priv->dmabuf->resv,
> +			      DMA_RESV_USAGE_BOOKKEEP, false,
> +			      MAX_SCHEDULE_TIMEOUT);
> +	dma_resv_unlock(priv->dmabuf->resv);
> +	if (new_status != VFIO_PCI_DMABUF_OK) {
> +		kref_put(&priv->kref, vfio_pci_dma_buf_done);
> +		wait_for_completion(&priv->comp);
> +		unmap_mapping_range(priv->dmabuf->file->f_mapping,
> +				    0, priv->size, 1);
> +		/*
> +		 * Re-arm the registered kref reference and the
> +		 * completion so the post-revoke state matches the
> +		 * post-creation state.	 An un-revoke followed by a
> +		 * new mapping needs the kref to be non-zero before
> +		 * kref_get(), and vfio_pci_dma_buf_cleanup()
> +		 * delegates its drain back through this revoke
> +		 * path on a possibly-already-revoked dma-buf.
> +		 */
> +		kref_init(&priv->kref);
> +		reinit_completion(&priv->comp);
> +	} else {
> +		dma_resv_lock(priv->dmabuf->resv, NULL);
> +		priv->status = VFIO_PCI_DMABUF_OK;
> +		dma_resv_unlock(priv->dmabuf->resv);
> +	}
> +}
> +

Otherwise, 
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
