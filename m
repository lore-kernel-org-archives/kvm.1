Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE12485CE7;
	Tue,  4 Aug 2026 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871674; cv=none; b=ir+ZbK0IPtleyI+97sSdNuO06Tu/hh+6VLpbVtm2xt2s99R8yRRKwTZhfCersOtiELaoQJyIpu9OQzDcJzTdpZvQmQ2r0DSS9OagbKN/a0K+gE68TTRUMXUwTrw1NjhSqffAfHVy7lUkz4ArvZ69K07igw4f0OYYAbZrvGeKC50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871674; c=relaxed/simple;
	bh=AZikyL524L8HVN8ioF7Xgnyfhd0VWzNT3PkYMofSnNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctrlIWkI+IZpy9OAGV+VD7KaGUNB0VNFlixAg+vfheNcvlUF2YRQP+/w7FglsYetJy0jZxBidkys8L2hzuXBumC26mwKlo7WQGo+kg/lYtwUkxClaASHQD5seWAZGJupMCDR0Su/VAMU2nMk6Y7jYB6TSOxsU213hjPsEKQoEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=fRUM/r5b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jRgYn62T; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="fRUM/r5b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jRgYn62T"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A30ECEC010C;
	Tue,  4 Aug 2026 15:27:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 04 Aug 2026 15:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785871669;
	 x=1785958069; bh=Q2ndbIxStg2G8ysKZY2SMTE0UaVR81PEOatqDsjoOLw=; b=
	fRUM/r5b+XYZ9fEKHpRNneeBVyVT0FDRhx//4ueMdlpBItJdX61Ue0DfFWvBWLx0
	1iW+SNRyGMlmj3KPGQif6EO1rLtwEVzVlINPOc6z5m1eQ0IJx5DJqAiGU+X7CcpB
	AACoKnkh0Xs13Khegy58NAb1wZZ1SnN7YpLPIqOnur5bxhh83G/kxBuApW3IwKW6
	pknsTHrPowoTzXQ+++80UDh/UWW0l6XDLS4VCe9stc9HzryyjF7uK+bS+GqtWu04
	610AVQSlXkeEE5cOhnPRNq88fLSxpzRChYFklOV73WQqmhjjDY33L18mBneukkpS
	WiB7wd/EDvROns858VTcmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785871669; x=
	1785958069; bh=Q2ndbIxStg2G8ysKZY2SMTE0UaVR81PEOatqDsjoOLw=; b=j
	RgYn62TulMOs21nRwu442dEjp+UdYaoSBXJx+CfrqVLM82pxrVnxEFBlWeMGmOsX
	WQmPZ4+bd8aDYh1CzKIq0IeTDkKFjIZ2d1POoz0kmtzSYF3VZ0DPw9OegmmU0bvc
	LIlHW76T8bVjnatU+pqxvTSwuoSLT+35h3SXMDaN5qQlHFL7g3y+Q21EpiNHDhEs
	AsigUst3HmQ9s0ceOmGDU3T2cB/UCf/VN3Ef6dJvOtQJXaOSzKFwiuD6Ft1AMmJC
	o/v3dEJpBi/j12sefIoRLwo95e9ySAZG+/8bJAL8Cl7sQLGW06fNVxXZ4MNkuJHR
	n6UdwIxNsFTrWSt4+BmAg==
X-ME-Sender: <xms:ND1yauGWJ6A-kIti99f_W5cFLC3SbBG8Ulbya_xk71QmKGkfR_XeKg>
    <xme:ND1yaorTwttinEXpUzENbUiZeZddqpDAEaYJjvuwZUAbxjcw4ayn1KGcoWmA5gQwD
    xZpsgthpxzQCOQqT5b3r0PEwppdgeu_hIH34n83MphZl89BAAewElM>
X-ME-Received: <xmr:ND1yavbcr7F9q1EXUth3Hp4S4O9IXbxCKijLg24dHqqLTLlMrighK8KbKcELnA>
X-ME-Proxy-Cause: dmFkZTE27WQxm8iGxfAFFUEwq2ylm6DYMQNwBiTxFGcsGILXGopQmV9WyF+yS5fm/iW2yV
    HdtKvOj80o8zg1HZ9YBPnD2eUSKJ9B3+eUVcPrtKrKEfvS19bA4szxIDC3aS65Y8B/TjJN
    8awqKchy9FHr0S4xgFm6J+JPSGg6QoQ2fx3VbIF/y8HiSEDs1IOMADDRK7EHcske27ki5n
    rW/m85FCL9d1A5/U0L8eB8XxXzEFTgQSW9Itu7z3x+hNTq93PI3D2wqbCG++GfOPZXC41+
    GrUiU9FaBN+xx04+XBSTRmcHcAh/I9H+CQbqH3rSPF9jfVFbBKOz/J5yVjFlir6UgE99C/
    w3O1H+NfHROynZzzOFq9DTlroUGMgYCsKSK+IIrciTx0W2519932ZtSctdWgceFTouo3lp
    xKZE0QUPo8Wc6KfR2A2lWLit+ckNfu5BqV7qeW9fnzeFCihHG+yOvKQmrOof11K028rRbW
    FYlTtkc6BfOQBJT+ue/WGwUg3ObOmk70+xiJIA6+cj35OtPp+bQi3b6v0a4NLrEjnNbpIT
    jRGoTOTThhol7uJJtFWb5iWuASLft67OhZHk2CuN0hjuWUd9BAw0afFYG5A7KnleXhQFBd
    4JZy4df0lfKfL6Uz6dZcSJ6Fu4bLzK7mx2J/avrq7+QTFutDhl/pA1D60Log
X-ME-Proxy: <xmx:ND1yapU3Xj6IXwoKYVPtl4PKX4EhoZvR5IF4BgJbj3B4dHe3SjfNYw>
    <xmx:ND1yag__cbXnfDOuddn4wmKxdoH9y0mLmRCpmikdVHg_XvCOdj-Vzw>
    <xmx:ND1yaq8XU8-slHx1o9Tvfw9XbWgVY9o9_OcP9HJsYjFXHRNxcPL9dQ>
    <xmx:ND1yaoQrQHA8OjIkliAuAEd_ZwhqqVUiGZkGFGmCTvrTEGTDDAvLRg>
    <xmx:NT1yaqI-lWC8RX1_C9n5bn2TT107y-YXHnG7GEnSXCqJrZwKZE3SSBeO>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 15:27:48 -0400 (EDT)
Date: Tue, 4 Aug 2026 13:27:45 -0600
From: Alex Williamson <alex@shazbot.org>
To: Longfang Liu <liulongfang@huawei.com>
Cc: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH 2/2] hisi_acc_vfio_pci: fix VF BAR2 mmap on 64KB page
 size
Message-ID: <20260804132745.2db9c897@shazbot.org>
In-Reply-To: <20260803021857.2370179-3-liulongfang@huawei.com>
References: <20260803021857.2370179-1-liulongfang@huawei.com>
	<20260803021857.2370179-3-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Aug 2026 10:18:57 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

>     On HW_ACC_MIG_VF_CTRL hardware, VF BAR2 is split into functional
> and migration register regions. When kernel page size exceeds the
> functional region size (e.g. 64KB pages vs 32KB functional region),
> guest mmap operations get rounded up to page size, causing the VMA
> to exceed functional boundaries and fail validation.
>     The solution aligns mmap boundaries to page size while maintaining
> byte-granularity access control through hisi_acc_pci_rw_access_check()
> for read/write operations and accurate region size reporting via
> hisi_acc_vfio_ioctl_get_region(), ensuring migration registers remain
> protected from non-mmap access while resolving compatibility issues.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index 36490be7a61a..44b3e7d8fef5 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -1355,14 +1355,21 @@ static int hisi_acc_vfio_pci_mmap(struct vfio_device *core_vdev,
>  	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
>  	if (index == VFIO_PCI_BAR2_REGION_INDEX) {
>  		u64 req_len, pgoff, req_start;
> -		resource_size_t end;
> +		resource_size_t end, dev_len;
>  
> -		end = hisi_acc_get_resource_len(vdev, index);
> +		dev_len = hisi_acc_get_resource_len(vdev, index);
>  		req_len = vma->vm_end - vma->vm_start;
>  		pgoff = vma->vm_pgoff &
>  			((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
>  		req_start = pgoff << PAGE_SHIFT;
> -
> +		/*
> +		 * The BAR2 functional region (dev_len) may be smaller than the
> +		 * kernel page size. Align it to PAGE_SIZE so a page-rounded
> +		 * guest mmap is not rejected, which would make the VF unusable.
> +		 * The read/write path still truncates at the real functional
> +		 * boundary, keeping the migration registers inaccessible.
> +		 */
> +		end = PAGE_ALIGN(dev_len);
>  		if (req_start + req_len > end)
>  			return -EINVAL;
>  	}

You may still be restricting read/write access into the migration
range of the BAR, but doesn't this give the user full access to that
extended range through the mmap?  It seems they only need to access
beyond the advertised region length through the mmap to bypass
hisi_acc_pci_rw_access_check().

If they can do that, what are we even still protecting?

Alex
