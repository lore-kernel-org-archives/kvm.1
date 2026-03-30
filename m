Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953673DEADF;
	Mon, 30 Mar 2026 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909190; cv=none; b=oaoXnTazJBcX9xnUDZ7vuTpqC8bxBhzuH4KB/sbnoYmy6w33K4JiRrupR2Y120TZpC083FyeACo0fK6cApELCkAiVqTn8EVkx+D8R5dEGSeuKfADo+i7DVBKwwu57rcU8R0b1iekVK9+8XAjops6q6er1jdWHy+1naAsyM4QJIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909190; c=relaxed/simple;
	bh=JnqD3TyeRpoIZtONomIeXGLdtj9GythGM2M0IEDzOHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzSJa06CwE1bTcNcZjZRFV8Q+5o8l2CiWTAFfZuloO5FCEHSgqNOFqqlmfZKFEpFBt5L7OC4NMXiJ1b5z/joNiG06uYVqDZJhznCyv2n1DtUmM4sKJdBRD45aEuytuTgvd7jQvUbeBvGYfYWr2aTEhlzYCV5UK/SFAZSSog7ipg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=rsMDelTK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uw23/BER; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="rsMDelTK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uw23/BER"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A34571400236;
	Mon, 30 Mar 2026 18:19:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 30 Mar 2026 18:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774909175;
	 x=1774995575; bh=KC7yQsjEhXBnsf9FMpaaJaCC82chs8zFL/gXSJLxi9E=; b=
	rsMDelTKjUOtps85fyCwciCwrhsEZRaJeLLPC1xzRUM1MA1FPPq0TgUNkDRDZXAO
	Vctc87CcmrabRVOQ4Tf273hTccJeuqG4ZDNHlXKB+spuHl/HWYqhQaaN7MbP9fKJ
	SF76/criD00FzDJ87r30ko5Z0i+QfCGMETxKXEEWNbIHxe7ALZnmIkuCQ9yavhcI
	qzCESEAJXzSqJi5knf9ZpHJyeWaH3sNO5olARxe+0tVUfY9+s3raAjfSlWdaw9Rv
	+0owSTg4GHBUg8AZoBEv8cjBGFozJbMto9MJbRGIcXCemz3ZH82sSwXRhuuSHSc0
	T8OvPhE5duzEmgpv68Yg5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774909175; x=
	1774995575; bh=KC7yQsjEhXBnsf9FMpaaJaCC82chs8zFL/gXSJLxi9E=; b=U
	w23/BERkzzcwlsh4WH1Xs+QYpJTrqlfYCHWGiAx+qtSrqJobvpO81iVv3R9nCH7Y
	Pf1LzRd9gJU9Lm6zeHNYZfvEhz9QAaAF9rDxYUQk2+zNSzG3zDaeRQQEMVrnpL/H
	Z9Cb06pQ1fbajbbj0s4dXHhQvFiUHGVvHJ7J5xkzD9+bfPxGfXaKvhX6pUbomZ94
	armodre+frmYICv0ejpQVcTbt2m8pc6vBTvERIyqMHV44gsqlpOI5JiI6nTtWkiF
	JPeuRZR8k/p3/fcOpMXEjNEGSxDC6c0ML8Sogq1+qdV56zCC9KCT+pOsOe8VEy+f
	/2u2kCy/9PgfbpETaStkA==
X-ME-Sender: <xms:9_bKabkc3dpjrtQAnKkuVjHxE1R_iFwY1GKsortez2ee5vF9AreLLQ>
    <xme:9_bKaVnBQkMSoeP5D2iq-cJKxTwN_aUnRNH-MviyQU6LE8cFYli_G9q20ciwM2B-E
    XpZWQRa0M6RNhJ4FLDouJONxrLXwyb7bb8zwZZlm0JmZJJ0bqq6sg>
X-ME-Received: <xmr:9_bKaTYp4juNpEsp7XMxMBUqMqTCOtC3pCXxaBgzFL9kJ18bfZbCW1CL4SM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedtudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhoshgvnhhpsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvggvshes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhushhtrghvohgrrhhssehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhhrghruggvnhhinhhgsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigsehshhgriigsohhtrdhorhhgpdhr
    tghpthhtoheplhgvohhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9_bKafTkNwlnUcq_IgCXAGRCCNidkuumwzg0fCKMRuoIQMam7o9nQw>
    <xmx:9_bKaVtp_No0rgSUUCcqBvtqHnpS_b-F7s9Xxa_S3SRw6VKdLsSN5w>
    <xmx:9_bKaZHNhI_jdvb9s6k7S8gaw9KnqS8XV23VC0WHyx0QIMrSQNlaOg>
    <xmx:9_bKaeyCib2l4_7XgjZZ_AdgwMW8w1ZkVztL1gFrQG1ZCBQkBpevaw>
    <xmx:9_bKafnkmGLDis_p3tmuzKDCNAAcv6D7_NwVSytkq-eoCkhw8_ceRsBo>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 18:19:34 -0400 (EDT)
Date: Mon, 30 Mar 2026 16:19:33 -0600
From: Alex Williamson <alex@shazbot.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: kvm@vger.kernel.org, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, linux-kernel@vger.kernel.org (open list),
 linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by
 other areas):Keyword:\b__counted_by(_le|_be)?\b), alex@shazbot.org, Leon
 Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] vfio: pci: use kzalloc_flex
Message-ID: <20260330161933.6471d473@shazbot.org>
In-Reply-To: <20260326023747.54485-1-rosenp@gmail.com>
References: <20260326023747.54485-1-rosenp@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[Cc +Leon]

On Wed, 25 Mar 2026 19:37:47 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> Simplify allocation by using a flexible array member and kzalloc_flex.
> Less memory management needed.
> 
> Use __counted_by for extra runtime analysis. Move assignment to after
> allocation as required by __counted_by.

I don't understand this statement, nr_ranges was previously set after
the allocation of phys_vec.  The only reordering was relative to
setting vdev, but that appears arbitrary.

In fact, we don't need to explicitly set the __counted_by variable at
all, kzalloc_flex() handles that.  So if anything, it's now redundant.

Leon, any other comments?  This should have a v2 removing the
redundancy and fixing the commit log.

NB. This will be a bit messy to merge since kref and completion exist in
linux-next via drm, but maybe Linus will consolidate the hole in the
structure when he resolves it.  Thanks,

Alex

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index 3a803923141b..40e7e035a720 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -14,12 +14,12 @@ struct vfio_pci_dma_buf {
>  	struct vfio_pci_core_device *vdev;
>  	struct list_head dmabufs_elm;
>  	size_t size;
> -	struct phys_vec *phys_vec;
>  	struct p2pdma_provider *provider;
>  	u32 nr_ranges;
>  	struct kref kref;
>  	struct completion comp;
>  	u8 revoked : 1;
> +	struct phys_vec phys_vec[] __counted_by(nr_ranges);
>  };
>  
>  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> @@ -95,7 +95,6 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
>  		up_write(&priv->vdev->memory_lock);
>  		vfio_device_put_registration(&priv->vdev->vdev);
>  	}
> -	kfree(priv->phys_vec);
>  	kfree(priv);
>  }
>  
> @@ -258,33 +257,28 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  	if (ret)
>  		goto err_free_ranges;
>  
> -	priv = kzalloc_obj(*priv);
> +	priv = kzalloc_flex(*priv, phys_vec, get_dma_buf.nr_ranges);
>  	if (!priv) {
>  		ret = -ENOMEM;
>  		goto err_free_ranges;
>  	}
> -	priv->phys_vec = kzalloc_objs(*priv->phys_vec, get_dma_buf.nr_ranges);
> -	if (!priv->phys_vec) {
> -		ret = -ENOMEM;
> -		goto err_free_priv;
> -	}
>  
> -	priv->vdev = vdev;
>  	priv->nr_ranges = get_dma_buf.nr_ranges;
> +	priv->vdev = vdev;
>  	priv->size = length;
>  	ret = vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
>  					     get_dma_buf.region_index,
>  					     priv->phys_vec, dma_ranges,
>  					     priv->nr_ranges);
>  	if (ret)
> -		goto err_free_phys;
> +		goto err_free_priv;
>  
>  	kfree(dma_ranges);
>  	dma_ranges = NULL;
>  
>  	if (!vfio_device_try_get_registration(&vdev->vdev)) {
>  		ret = -ENODEV;
> -		goto err_free_phys;
> +		goto err_free_priv;
>  	}
>  
>  	exp_info.ops = &vfio_pci_dmabuf_ops;
> @@ -323,8 +317,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  	dma_buf_put(priv->dmabuf);
>  err_dev_put:
>  	vfio_device_put_registration(&vdev->vdev);
> -err_free_phys:
> -	kfree(priv->phys_vec);
>  err_free_priv:
>  	kfree(priv);
>  err_free_ranges:

