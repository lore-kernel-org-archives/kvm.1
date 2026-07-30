Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECC13E556C
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785452136; cv=none; b=pBM0P1vjVvaCXXqWhC2T5s9EaHZMlF21E//QOh5aZ/WOYxMhZ4FHn46eF9E+a0jw4Klj1OAi6s7KVUferowvjlxHoUDCc4ax2t6rYKGUWCfQWdc4ZxpWDHIpieFekzOR0kqWxW3S/sP1E5zzQLk8I4FJgM/7oNoQioguPBgCrGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785452136; c=relaxed/simple;
	bh=6yC+aYDaiVvucEeJuv9ttiHtFPowCOdaom4mtrRN5FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2+an8JNj6zpFfdG/1hfCQmqtPM0RhJ7WlHm6GDELPns6l5UNhGyO+A/cNvHZp2rpjutQ223Lvgxo57hDcE8drOgDnjwN12kn8hZJOlG9dcAN68ySIagUEYtnZsGjxivcj6FHTRYaoLSQSLG4LQWy/jMD+s0vZKhKGmNLPc37ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jKx/lxX1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKx/lxX1"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccdf36f63dso55145ad.0
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 15:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785452133; x=1786056933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JGa8csySGObADLk+2HBSpvepwrbFTkNknaylr539um4=;
        b=jKx/lxX1tyKmvVhcYERq6+KdCUIDs6/X8kTSsYMlRRHvU8lsciTbyt1EaXmd8uJr/c
         OzikpzrXgkq03NwXlmMnr8gNVav0KpmCEko+S3IlmzA1P3UifsnYi+lvnSmvpgQrNd+p
         4sTJT4jP444Jjgc3Vpj/x44JwnAIvPFFCR55TxTxr2o2GTiUoKYS7GygNPFGYzhZorNh
         S9WEaznPnVLsxmaDNBNRr54aj5QVmAEDV9FVjtGjdqkYTp4WcKyAcOxNBvqL7qD0Iogu
         UasrdnAsn7xSm4NkbvzR0WyTzZGRxZIq5EgpuxSiSP1fUOXIOWjyEZofMRhwU7Pv3Yk/
         58RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785452133; x=1786056933;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JGa8csySGObADLk+2HBSpvepwrbFTkNknaylr539um4=;
        b=r2QmnrOrYppGPYRMgiIQAlGzcRecH6XCZBu3IQJdqCLe5ysHAuZ6yksyluyX8yXsSL
         6XgXAtl0kfKMb+LGg0Lwupqx57LdtRY73pjvxJKJT2DC4BuqHklFJ2R51eiUWDY2igM0
         zHZoh4nWymAvx4DooTeMASckabSLGlNczt352xIKkm10FPCrxR/rJ77wGNHF448JXkHs
         XmdGo2Z9GJUzxixrI+5//Cpefy/VjXYS1d1US0vkem7kdlVtv25Fguq57SqS1mMZxNI8
         /fDJ8zakNBil4VM3NMg6pQW0rB570SpWs26HUipQ839DtKWnH86r2RZlAQdzQSsT83ja
         C3JQ==
X-Forwarded-Encrypted: i=1; AHgh+RrcbtsJPp0w1YK3Kssh57kDj5/v4zXLqsYh7NE4AG9JME/7hNPV8bRlSBS1shCOZlwj/A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznNIXA1pMbOJ5GVwfTqvi1Z2lX6JxAKbFcUjaCq9YKIZ2/VeFb
	hBAErxKq2K5yOrtHDq9dnA6E1QulhGw7EoiIo6ZDZchNu+zgmzMRJa5mdoryp6OP5A==
X-Gm-Gg: AR+sD12HjRwuNgQvwaKSftyrxnV9yDsODHDmRoa3aav082M1poDeatMGP1Fbe00lG7v
	0bDnOFm9G2a1OzptE61HUlqPHygbG69tLO4Ak6lJKdKdA0UlDzQ+ePhxqSU2+14hdjOqcJ7yjh8
	g/0Vh+lCtwOUdH70T5aBBD+uu4ZkVE1horuOIbEiYwmJawlN+7Hx6WiolLnxpVsB3iWE+TxkqzM
	JZuJBNIGeVNB6aYzIpFPO8AKCQ9CvRGS7K5QWauboXRo8eL7buvqM6k3o/MFcOV3VQCpAMz67bN
	QegkZUq03h8VVmrwblO9QfzLfZks2sDjTa+8s202XFyuF1bMWaJ0ccN/yvnqRhBtcqVEfDK6BtA
	ywk/DlOKfnS7G7OYT7svq7VVdtBbVO9fNLuF8rfodK2wh8xKRlCsAWigy2SM8+IdwiHAiJa0d3j
	P19IqpYNOG2UbGs07iSAUN0SZRrktq75ENw7ovFaoZCimKWQHxznv4+IEvjpQvMFa3ZbG/NI2je
	UEEEpa3RrEDzSPAI5XKE7lOR+ovTaZUoLgP3I43c3JJig==
X-Received: by 2002:a17:902:f541:b0:2b9:e831:5e5c with SMTP id d9443c01a7336-2d04113beb1mr4399455ad.4.1785452132956;
        Thu, 30 Jul 2026 15:55:32 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d2ec2asm29148088eec.21.2026.07.30.15.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 15:55:32 -0700 (PDT)
Date: Thu, 30 Jul 2026 22:55:24 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 3/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Message-ID: <amvWXNRtviKEuUoV@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-4-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715174737.15287-4-matt@ozlabs.org>

On Wed, Jul 15, 2026 at 06:47:26PM +0100, Matt Evans wrote:
> Add vfio_pci_dma_buf_find_pfn(), which a VMA fault handler can use to
> find a PFN.
> 
> This supports multi-range DMABUFs, which typically would be used to
> represent scattered spans but might even represent overlapping or
> aliasing spans of PFNs.
> 
> Because this is intended to be used in vfio_pci_core.c, we also need
> to expose the struct vfio_pci_dma_buf in the vfio_pci_priv.h header.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 153 ++++++++++++++++++++++++++---
>  drivers/vfio/pci/vfio_pci_priv.h   |  20 ++++
>  2 files changed, 160 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index c16f460c01d6..7c047400dfd1 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -9,19 +9,6 @@
>  
>  MODULE_IMPORT_NS("DMA_BUF");
>  
> -struct vfio_pci_dma_buf {
> -	struct dma_buf *dmabuf;
> -	struct vfio_pci_core_device *vdev;
> -	struct list_head dmabufs_elm;
> -	size_t size;
> -	struct phys_vec *phys_vec;
> -	struct p2pdma_provider *provider;
> -	u32 nr_ranges;
> -	struct kref kref;
> -	struct completion comp;
> -	u8 revoked : 1;
> -};
> -
>  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>  				   struct dma_buf_attachment *attachment)
>  {
> @@ -106,6 +93,146 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>  	.release = vfio_pci_dma_buf_release,
>  };
>  
> +int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *priv,
> +			      struct vm_area_struct *vma,
> +			      unsigned long fault_addr,
> +			      unsigned int order,
> +			      unsigned long *out_pfn)
> +{
> +	/*
> +	 * Given a VMA (start, end, pgoffs) and a fault address,
> +	 * search the corresponding DMABUF's phys_vec[] to find the
> +	 * range representing the address's offset into the VMA, and
> +	 * its PFN.
> +	 *
> +	 * The phys_vec[] ranges represent contiguous spans of VAs
> +	 * upwards from the buffer offset 0; the actual PFNs might be
> +	 * in any order, overlap/alias, etc.  Calculate an offset of
> +	 * the desired page given VMA start/pgoff and address, then
> +	 * search upwards from 0 to find which span contains it.
> +	 *
> +	 * On success, a valid PFN for a page sized by 'order' is
> +	 * returned into out_pfn.
> +	 *
> +	 * Failure occurs if:
> +	 * - A hugepage would cross the edge of the VMA,
> +	 * - A hugepage isn't entirely contained within a range
> +	 *   (including where it straddles the boundary between
> +	 *   ranges),
> +	 * - We find a range, but the final PFN isn't aligned to the
> +	 *   requested order.
> +	 *
> +	 * Upon failure, -EAGAIN is returned and the caller is
> +	 * expected to try again with a smaller order, which will
> +	 * eventually succeed (order=0 will always work).
> +	 *
> +	 * It's suboptimal if DMABUFs are created with neighbouring
> +	 * ranges that are physically contiguous, since hugepages
> +	 * can't straddle range boundaries.  (The construction of the
> +	 * ranges should merge them in this case.)
> +	 *
> +	 * Finally, vma_pgoff_adjust is used with a DMABUF created for
> +	 * a VFIO BAR mmap: a BAR mapped with vm_pgoff > 0 creates a
> +	 * DMABUF such that byte 0 of the VMA corresponds to byte 0 of
> +	 * the DMABUF and byte 'vm_pgoff << PAGE_SHIFT' into the BAR.
> +	 * To avoid double-offsetting in this scenario, subtracting
> +	 * vma_pgoff_adjust from this (non-zero) vm_pgoff generates
> +	 * the effective offset.
> +	 */
> +
> +	const unsigned long pagesize = PAGE_SIZE << order;
> +	unsigned long vma_off = ((vma->vm_pgoff - priv->vma_pgoff_adjust) <<
> +				 PAGE_SHIFT) & VFIO_PCI_OFFSET_MASK;

Maybe I'm getting ahead of myself here.. but it seems like this
restricts us to only mapping DMABUFs at offsets < 1TB due to the 
VFIO_PCI_OFFSET_MASK (since we have HBMs on PCI devices now, hitting 1TB
may not be a very distant future).

While I understand this mask is needed to drop the BAR encoding in the
high bits. 

My worry is, if in the future a user were to export a massive
contiguous DMABUF (e.g., >1TB of aggregated HBM) and tried to mmap deep
into it (passing an offset >= 1TB), this bitwise AND would silently drop
the high bits, leading to silent data corruption.

I think we should explicitly reject such an mmap with -EINVAL like:

+const unsigned long pagesize = PAGE_SIZE << order;
+unsigned long vma_off = (vma->vm_pgoff - priv->vma_pgoff_adjust) << PAGE_SHIFT;

+/*
+ * Prevent silent wrap-around if the user mmaps a DMABUF at an
+ * offset greater than the VFIO index mask allows.
+ */
+if (unlikely(vma_off > VFIO_PCI_OFFSET_MASK))
+    return -EINVAL;

+vma_off &= VFIO_PCI_OFFSET_MASK;

> +	unsigned long rounded_page_addr = ALIGN_DOWN(fault_addr, pagesize);
> +	unsigned long rounded_page_end = rounded_page_addr + pagesize;
> +	unsigned long fault_offset;
> +	unsigned long fault_offset_end;
> +	unsigned long range_start_offset = 0;
> +	unsigned int i;
> +	int ret;
> +


Thanks,
Praan
