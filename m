Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125791;
	b=tSQeiLWs1iLnE5pVg76IAWC59ZO3kaFmPoN3WANSbyE5KV3Sq8z1S1+EbAJ6s90JBneP
	 R8+D14gUVPhxp7oulxuwFPMTIQ6h7XsD5R7eO+S/aRwKxD2NqbikQW6ZdKMCoUWy8DZPg
	 QOuRyam51H/CwpFac8M6uqLhfol3JlUeSji1TZWsu5Cv2xFTikaFnSU967Zf0eFn91MJ/
	 4njQrRZ8i/t2hBzvfGRY33cgxcLOwGbPOd576EhFa3OOW0MdycXy4uX608e/VxAAmxvZ9
	 k8SyJrF/+x6NGBx4dq3hpYly4jlz3c0K5ldkFdgCckSOnzWHMeoEtVdd2gXeSPltfdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=65AOdH+KgJ7resuIkk0VLKCd0Hg6dbezaVp42JhIP6w=;
	b=NW4948ir9cckVaPw1LSRQhpB9HgOjTIN9lrBqKqQQPzCzRbfwby48quDw5gzU5t6gClw
	 AzvrfpZknCBCDufXRNohZZN9q0wG/dRq/gn1i4xUMokf12nGpm8oAtHjY0d/CQ5X2Wm4X
	 RMu9YhGT3r+xH6Tulo8YZNU3FZFpeZtRzOfuZ3Rg567EGwHA3ldz6N5PBqaaqMFpNPnpc
	 v6zLBB757f5QOQsblUqSL2F7oOje0dP0ZhuIOIs2d5PIEu5E1q5gzgeuF8QQCRHDKLayB
	 rOxrlaIcZl2x4CXWfMj6AqPQDCpa44pX+oRXsPSCtSDQ6Xy7PRVUSNqchaq+r7+Eq7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=SDf8V7lB;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E3D606A327
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43E3D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=SDf8V7lB
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f3c616c84so5406485a.1
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793125789; x=1793730589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=65AOdH+KgJ7resuIkk0VLKCd0Hg6dbezaVp42JhIP6w=;
        b=SDf8V7lBjv388ciVxF8uawdikbXUurMY3QTcrM/wcAZ1ed7iS37PQd3b8hqO2kCFRx
         gb01WAvT/GWqjH2M3gvp5nTNPCdjqqbhamh82v5BqHlkHZ5tX4RxpCPwN2S4eUTG5rVF
         nIdZZZGD4xKmj4PuO/zIngGRg22kMAXrxt/v8LL8XDjWsrsGlv79HYheSxhWI3VNKxID
         XDKOc6PzG3HNgjgHvM7g9tfMAy3iHn90923OHajXdDxFRJMsWg+n/gS+difaZDQuJM6Q
         mCREG7y1/geLjkqkzCE3n+m53JskTRCmddX2n4uYmhS8wHPszgiRnJhqvNsRxFtnRK3f
         RK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793125789; x=1793730589;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=65AOdH+KgJ7resuIkk0VLKCd0Hg6dbezaVp42JhIP6w=;
        b=hTjdjLhoW/+o7eXTqGgFnue8ZWLyIhhTga8OtYMrJgRBWNcAYUKBzLx/1bQCHxC6di
         egJctrbneRbzXM5sk2NWqgOB2xtXMvABQ8PlApPclfvcfWpq2+XOE8eJxxbPWSQCrYxt
         AaJrX1lkPKj51Q/x6jp9peFfxc1tdQhHzNnifZOn4dZfjNYLpeuhRfIROhlG82jO8aKr
         S+/MKtbC6ckWSVuvLNO+MUw/+WVADKIsR7O8JlQRZJSXt3nBf1Zqn48Z/83bxxs5Msjl
         t5pEiH8o/16psSWdVxa3cncS3wx6GNN4X7lZdq8+2n6HTsqXTKL2H8Cg241GCCUTlXv1
         QZSg==
X-Forwarded-Encrypted: i=1; AKwUvBxGnNSPl4UBouWGEjfw+MYiXUcUmmH3FZdLvq4nSXcG40ZdDWSPL/19hldjJbkM/B93eQc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/6SEJzLXEEV1qewh/u8n4cBo8VkxaEtOclgR5fzEFiIPjBNL+
	7gF9zfAnBLsEE7Bj0n6lj+/URBHEwDZ4A7az8tb0DdAyfeBraC5UwA561Bu6AeFVebI=
X-Gm-Gg: AYBFou2fiDSeBKhnUowAdNtAHUAnznWRRKPztLguiFkYi8O2MLikfipWoC/Kvjuh33W
	IpqIJdUgtq0WfDL4K8mHyiECRUUhuiyGAZOVYatN9FtGCCREx8kSAevTSmyh2aL6xTND6knwyJP
	/SwxLKfLSoy/LKGSwxzYhc1xbkL5SlReOEQ91+GTMuJOzYTf8AXaoXkmOG6C2E346ZcxgqrhENP
	zDrUhTsLYSDVRpxy0z5w5xMMQ8+2Z8dhCxAj+uVOu7S/I7Hkvpa802A+Lu/PQ19qle2OJOrzBlP
	nkiFxG5X9mxjEA3Ekv1LYtJBHVH+G+ZGJEzC1Dz2Dlb97hNfkmRuhd5/1Jj2/BGRNO36Y0rWWtr
	YcJdL40DbMmx0uy0QMx9rrNcHCfRO0pxs6ZXO6oRvnoCxa8mQ8Ge6h+mn1ebFNi/SUKL7Zkw7NB
	4yhHBggios33yoKw4OKsl7eH50HrF0+hYfuTpfxBW72uO2169R0UyOQIFx8KulQOIvcMI4fAe/w
	AzwGc3aSrdIPFKb+iul0w5g3zaFuDMUh9L9X0D4hvv6bqdlo4Ie5/NNiFviuHpGfQ8YP89Yp+C2
	nyrh6eeIm2AJpT3pOz+/3l5nLalUYUvBrkqFnA==
X-Received: by 2002:a05:620a:2a03:b0:93e:c12c:9dc6 with SMTP id af79cd13be357-940ef9c39f3mr1650841185a.70.1793125789315;
        Tue, 27 Oct 2026 11:29:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f06690c0sm1051945485a.11.2026.10.27.11.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 11:29:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xLlvf-0000000AgNQ-0B8b;
	Tue, 27 Oct 2026 15:29:47 -0300
Date: Tue, 27 Oct 2026 15:29:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: alex@shazbot.org, iommu@lists.linux.dev, joro@8bytes.org,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v4 1/2] iommu: Add iommu_for_each_pci_mmio_window()
 iterator
Message-ID: <20261027182947.GI1685504@ziepe.ca>
References: <20261022193359.GF3381610@ziepe.ca>
 <20261025133000.205508-1-guanghuifeng@linux.alibaba.com>
 <20261025133000.205508-2-guanghuifeng@linux.alibaba.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261025133000.205508-2-guanghuifeng@linux.alibaba.com>

On Sun, Oct 25, 2026 at 09:29:59PM +0800, Guanghui Feng wrote:
> Add a callback-based iterator that walks a PCI device's host bridge
> MMIO windows and invokes a caller-supplied function with each window's
> bus address range.  This consolidates the bridge window enumeration
> logic into a single shared algorithm in the IOMMU core.
> 
> Refactor iova_reserve_pci_windows() to use the new iterator, replacing
> its open-coded resource_list_for_each_entry loop.  The callback approach
> avoids intermediate allocations: the DMA path's callback directly calls
> reserve_iova() with the computed PFN range, maintaining the same
> zero-allocation overhead as the original open-coded loop.
> 
> Using a callback rather than returning a linked list of iommu_resv_region
> entries eliminates size_t truncation risk on 32-bit PAE systems (the
> callback receives phys_addr_t start/end directly) and removes the need
> for allocation failure cleanup paths.
> 
> Note: commit cd2c9fcf5c66 ("iommu/dma: Move PCI window region reservation back into dma specific path.")
> intentionally keeps PCI window reservation out of the IOMMU group-level
> reserved region API.  This iterator respects that boundary: it does not
> inject windows into iommu_get_group_resv_regions().
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> ---
>  drivers/iommu/dma-iommu.c  | 29 ++++++++++++++++------
>  drivers/iommu/iommu-priv.h | 25 +++++++++++++++++++
>  drivers/iommu/iommu.c      | 51 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 97 insertions(+), 8 deletions(-)

Seems OK enough

> @@ -504,6 +505,20 @@ static int iommu_dma_ranges_sort(void *priv, const struct list_head *a,
>  	return res_a->res->start > res_b->res->start;
>  }
>  
> +struct iova_pci_resv_data {
> +	struct iova_domain *iovad;
> +};

We don't need a struct to pass a single pointer

> +struct pci_dev;
> +
> +/**
> + * iommu_pci_mmio_window_fn_t - callback for host bridge MMIO window iteration
> + * @start: First PCI bus address of the window (inclusive)
> + * @end: Last PCI bus address of the window (inclusive)
> + * @data: Opaque pointer from iommu_for_each_pci_mmio_window() caller
> + *
> + * Return: 0 to continue iteration, negative errno to stop and propagate.
> + */
> +typedef int (*iommu_pci_mmio_window_fn_t)(phys_addr_t start, phys_addr_t end,
> +					  void *data);

Don't really need a comment here

> +#ifdef CONFIG_PCI
> +/**
> + * iommu_for_each_pci_mmio_window - iterate over PCI host bridge MMIO windows
> + * @dev: PCI device whose host bridge to scan
> + * @fn: callback invoked with each window's bus address range
> + * @data: opaque pointer passed to @fn
> + *
> + * Walks the MEM windows of @dev's PCI host bridge and invokes
> + * @fn(start, end, data) for each one, where start and end are PCI bus
> + * addresses (inclusive).  Iteration stops early if @fn returns non-zero,
> + * and that value is propagated to the caller.
> + *
> + * This provides a zero-allocation way for both the DMA IOVA layer and
> + * iommufd to enumerate the same host bridge window information using a
> + * shared algorithm.
> + *
> + * Note: commit cd2c9fcf5c66 ("iommu/dma: Move PCI window region reservation back into dma specific path.")
> + * intentionally keeps PCI window reservation out of the IOMMU group-level
> + * reserved region API.  This iterator respects that boundary: it does not
> + * inject windows into iommu_get_group_resv_regions().

The last two pargraphs are not very useful

> + *
> + * Return: 0 on success, negative errno on failure (including from @fn).
> + */
> +int iommu_for_each_pci_mmio_window(struct pci_dev *dev,
> +				   iommu_pci_mmio_window_fn_t fn, void *data)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> +	struct resource_entry *window;
> +
> +	if (!bridge)
> +		return -ENODEV;

Can it fail? The existing code doesn't check it so I guess not. Stick
a WARN_ON there if you want to keep it.

> +
> +	resource_list_for_each_entry(window, &bridge->windows) {
> +		phys_addr_t start, end;
> +		int ret;
> +
> +		if (resource_type(window->res) != IORESOURCE_MEM)
> +			continue;
> +
> +		start = window->res->start - window->offset;
> +		end = window->res->end - window->offset;
> +
> +		ret = fn(start, end, data);

Don't think we need the start/end variable either

Jason
