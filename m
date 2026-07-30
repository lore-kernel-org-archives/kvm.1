Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD5C3D7D72
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 21:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447995; cv=none; b=GCejiqXdpIPKa3Q7c6fPWsZ8IZWMZH7q0zEab3hpZyZUoe8rzshmkSv0XipvTYyj12aOWv0GjCHtQFZ4BCkyvM0zOCNRaPp4gTen4iVYB/4ZYLJQCl9JSbt1NZf7oveQyj3cheulHXwOspPOTEeyKuDLJcbh8rX1w8wjGo1FRAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447995; c=relaxed/simple;
	bh=3dGuOtRuc7vDNnA6Xn+2Xxz1vdKxTTykCtGHwjG52jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdE0qlFKHgujH2HDXS47NRU1gKlWm69qEXn/XKvGZ/mljALOL7VuYYcOkl3zs2J0i2wEaSDAKevtbQGNn3pH1pAMli3i9M13YmIjTaFdqktGdNAzyQtiaE9CIU2XCSYHNokLPtHLuHlP2AP7J94HuetcKm2OYBQpbQHGe1QN5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E34+cDT2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E34+cDT2"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso309882a91.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 14:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785447991; x=1786052791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1/LZ3k1OCAQIJqEM26gNRTliKG7NkCB9s3f2/fI53JY=;
        b=E34+cDT2tXQERqEySwSBmlJcQ04jS+EVvJg3lldDe7AE1wdYVPDSORyD/ztNh3cfuD
         QXcp1SORhwXky/y7l9Iep957AFwmP/dK4Dug/ABhlzoUj9SBJ9TQyxwXY0G7DE5y81ra
         K0ZMPfGMCFWqqhys43QaQYIo0TDsh/45tGXEVUTD9PRxTMPlmQbtYBkPrkIU+NAhH6sS
         PR3GPF7F1vkjznVpRyFjHKLNLtXBEesl7giUtP85aDUqqMC5l/AjCHwERizDmMyVhIAo
         3d8y5BEl1+8paSL/iWFxn1gK8G3rDOcmxH0nhNhN1vIC+UmxfLUTkF2NQQBUKIi7jV4k
         55Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785447991; x=1786052791;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/LZ3k1OCAQIJqEM26gNRTliKG7NkCB9s3f2/fI53JY=;
        b=Vxtn2GORogIzHk7RaSK5c6pbkRLPTCc7IhXp2zK6NPABOOTYz4vxzNaCbXx1eu16wY
         Y/BFGbFB2YRp+uNCL9viy0SHP+Ec7rvdGdnRrNmNpSSluOqM9aqfxjI6X5p4XATd2ION
         +G7Erz4sIlf8uXZqpabKAqLKBYHMx4Fis0kdbAf7jAaF1jb4wRetJPj6spLei/skCT0H
         3ET7Kn/i4gG6rBGEHWadmtLynhyYblPz1FtdMaDD7cr0eDYQhRj3nHoHzVyuANUDNwbQ
         VvIbCFvEE5LnfowcWyNxu2oYZj3hxwE2LjTU9BReWAE8XUyPGidmBgMY/2PYjkMt95pL
         PTnQ==
X-Forwarded-Encrypted: i=1; AHgh+RpnVPGwXifvF1gHjnfhTG0ZolwSLkeYHspEmMpTViryK9R6muF2PRjO/DL702WhCA0K1hM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgn5R3uLIQ+JTOSAt4bSeUZ9Q2V3p3VDEtlSu7/TVIYCE7/NJr
	+apMtPRya7+GramGylhOqZzPED0v1QhswEQNn6wHSgaTAVPmNMD8E7Oo
X-Gm-Gg: AR+sD12zeH5tkMt0LZ1iZSf0VeRPDlA9lKgkJfTjZraU/UKC+I/aVBG5bej2zA8Jqxy
	DdT59UIPsqZX6w91dhU3EciVP3k9DIATkeq+xdtRYzYpIcwmWAGUS84qrUD4jz7U/CI+X3EQQ5n
	z0JJfzkb+6bLvLbbBpXmPy4e78VzE606/vJgVJhttTQ1xLfm9vNUMqowRs+H1XvLUPERfpguXEz
	UD7vhz+2nki58J/Oo8yTYprMVMnWFjhQrLVFwdJ3tKzTPnTkKOZYDAOgB0TRAhrx1YTL7fq7vtN
	+3bb52K1Bc6rOpLE18xWDVMUdbMlbVqDBqrXRgJgiKKdM06AVNn6cNmgchfQhevBynEesIPuLFc
	5nzVhff96nI/Txg7BN7KKJxLU8UeNCzFT+1cvC8TLFWQiKGNbsO4C0llitvtTqvO13GkRg6dXII
	Koov/LkT9sDfymDF5dxLwCSkWLbpH2ejcSxpmumUeEtdvS2CXroLE3zJpvr6oUZ3q0+GNqFB5O4
	adAAoo+yFY=
X-Received: by 2002:a17:90b:55cb:b0:38e:c0f5:7c4 with SMTP id 98e67ed59e1d1-38f9c00dfc6mr3834752a91.30.1785447991438;
        Thu, 30 Jul 2026 14:46:31 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9baeb56dsm1576842a91.17.2026.07.30.14.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:46:30 -0700 (PDT)
Date: Thu, 30 Jul 2026 14:46:28 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH v3 2/2] vsock/virtio: avoid refilling the RX queue after
 teardown
Message-ID: <amvGNBmggisFqA0k@devvm29614.prn0.facebook.com>
References: <20260729185831.3247971-1-bestswngs@gmail.com>
 <cover.1785352330.git.bestswngs@gmail.com>
 <f9c8c1d64cad9d262f305d02ffe164c2f900fadf.1785352330.git.bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9c8c1d64cad9d262f305d02ffe164c2f900fadf.1785352330.git.bestswngs@gmail.com>

On Wed, Jul 29, 2026 at 12:16:55PM -0700, Weiming Shi wrote:
> Commit b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
> made the RX worker jump to its common exit when rx_run is clear.  That
> exit still refills the RX queue when the buffer count is low, so work
> queued across virtio_vsock_vqs_del() can add buffers after the virtqueues
> have been deleted.
> 
> BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
> Read of size 4 by task kworker/0:1
> Workqueue: virtio_vsock virtio_transport_rx_work
> Call Trace:
>  virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
>  virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
>  virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
>  process_one_work (kernel/workqueue.c:3314)
>  worker_thread (kernel/workqueue.c:3478)
>  kthread (kernel/kthread.c:436)
>  ret_from_fork (arch/x86/kernel/process.c:158)
>  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> ...
> Freed by task 141:
>  kfree (mm/slub.c:6566)
>  vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
>  vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
>  virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
>  virtio_device_freeze (drivers/virtio/virtio.c:658)
>  virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
>  pci_pm_freeze (drivers/pci/pci-driver.c:1098)
>  device_suspend (drivers/base/power/main.c:1968)
> Kernel panic - not syncing: KASAN: panic_on_warn set ...
> 
> Jump to a no-refill exit when rx_run is clear, leaving the normal exit
> to replenish a running queue.
> 
> Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
> Cc: stable@vger.kernel.org
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Link: https://lore.kernel.org/r/20260727035804.1860862-1-bestswngs@gmail.com
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Assisted-by: OpenAI-Codex:gpt-5
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index a8e1dd95ba8c..96c9fe8d357c 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -638,7 +638,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  	mutex_lock(&vsock->rx_lock);
>  
>  	if (!vsock->rx_run)
> -		goto out;
> +		goto out_nofill;
>  
>  	vq = vsock->vqs[VSOCK_VQ_RX];
>  
> @@ -692,6 +692,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  out:
>  	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
>  		virtio_vsock_rx_fill(vsock);
> +out_nofill:
>  	mutex_unlock(&vsock->rx_lock);
>  }
>  
> -- 
> 2.55.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
