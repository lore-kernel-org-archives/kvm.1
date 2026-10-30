Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399106;
	b=Lj2PV3BNlJ+ovI73/agpIkH4ZtWt5eo6Whdyk8BMoLahU8zyr2cUt9vhGZ28zu0mMS2s
	 sVjMRmW1ByY5/5x/x27CSfhwJJvDNG+u/lzt/8cg+dWzy1H0hXyQQybFh42FWLCTI95rP
	 ArzEbvlEDDlBZIMMtm+s7Kce08uslIYF9l7ZbCx8WbHqMOMXdxVvRQNvWnIiULV8NsD0x
	 0kJhlr0P9bbwS3yY/r/XtypLpELHZunvDpkoIGY+7qhJIT9N8DCC79DfXajfPQuTSSKzB
	 357pn+p7STg3nb56aL/w///+LlwgicWuNj+QSodaMhdt715GE2k358xnZ66HK0E1AwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/+KneAP5j4JycW2Osy6h4oU9OQtsTeRD6BdS9+k/6qE=;
	b=F0ilhbkF6ZayklCH416zSxw3HMtej/kAPF0k2+cX3UmBP4WivZgyIJiqYfD1LWwkGsgD
	 MHn1J1WBP4kl0Srou3ze6s2i2BHqw6V6Rw+s7IiSCUizF9vwRHSkQLEPJOldgPFs7HLbE
	 N385GD7izWRt88x5eqRo7YIkGd5kzqkxrrzRjAwtACjjE2c4C1Hc/Iv1dTlMtxqdB6aeF
	 RL2wy+6ZX5rQOJ2vHCv2+6CYoC19LYZc4IJqIVLO1Qh44VuwaeWiekRaS7S22qb9Q/88R
	 L+GGNX2Xi193E3hlgt8Xca151zbagw59LXcxHk7x7vznzckNPhRUNmHkqFBE5LDAKjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fON+oxNo;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86400606A31F
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 22:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86400606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fON+oxNo
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8ac8a2ac52bso15372887b3.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 15:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399104; x=1794003904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/+KneAP5j4JycW2Osy6h4oU9OQtsTeRD6BdS9+k/6qE=;
        b=fON+oxNodYAgFJVlp9NMyimkvkAqRKgDVxsc7oPe5/oKL+jFJcDMbJD7JyAAlKDN6X
         Ulrgfg5oRZHZvrJt1/wumsGGM6hnegz6txsFgooLxk17khHW2ooVi/Ebs0ftClD4SO5k
         n87A+Wy9KTW+fTdyYvj8B78qf8da4YbMqPpTFvdhHzQbqLrSLrSxEbLO9sF5YhJ5aLZH
         YzEujhIVn4WLLXO+6Is1F/CV7tGZSvmR9kqFIziZ6PFOz+Ezxqzc11v/PzKOrWmTKfIJ
         HvRSkgc7fXxGW5Y1gE7/dvg5HajVlh5gjWdFt2sz6g7JoT2qcYV/r5PoHimftmTExgD9
         ApVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399104; x=1794003904;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+KneAP5j4JycW2Osy6h4oU9OQtsTeRD6BdS9+k/6qE=;
        b=P2QjJCmcR3Wmz2tNgFsrkXIw3ljyqsnTB5/hJ6nH58O2rZlw0AhbwEtzh3kPcTDFv3
         gqIBBEHTbYlcJ66YC5EueDGb6iH03V0PzB0pQ25bUW8xzBQPHj83e+vAkQbe2tUeD3Kg
         phjWXRjKRSSfZQ3Hb5XsZ/udDa2oWbvC2i9aBi9kmrpfak/R3OE2geoqmpJ1LeaoqDNO
         DE971FqDeSBr0+O4bFJVn0OHua2GFnsopVj/zBCdvG4RBhuAGXMu4RJjN2Dc8qTJAZoG
         7YO7tmxeRsaBBhuq9NDxalyFyqq3JPCpPDEO7Q6RW6Am6FEI017Nzdr/IHx1YCbwZk87
         q/Ww==
X-Forwarded-Encrypted: i=1; AKwUvBz7z4p1g8kmz741mxDilRH+oL8qrWvb75a2S+yJkPc9a5lcVUBu13oNJrqhDOAVPZzMRsU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFS2Xy4agf75Ewa5fID2E6nyoJmNJ/h7EvVhEQ14TEQ6Wg0j3u
	t/MpJI7rsNAFccDZqDsaJrAmn6OSMIDO2b3zq3PFeautjHbVsKmF3Iza
X-Gm-Gg: AYBFou1iUXNKI4ZqWG3MzdNw64sjJkA/QCUfBte0kshvC0OwsEx7akboz7882TisWEJ
	snXrtCJSwMIoDtDPEoCw6Hkz1D1kl7ZhJlpqPJTOPDjZxF2nLguYxr8/KUA2NMo6zRQtQXe2q7F
	tlXGtm0++qsSKplLjyEmQulDKvx1mdcFgZ+ZCbd9H89tNKr9sCN5vPXWijBQUhFm3KY6ANnNiTU
	PenmrOdphMR7KCG45vECZxK4fTx2Dhjdib9wGXeAAQA3zW/PW5zDmyWkeifJCgYg+qK/r+XZ+tD
	5ca259jy30h0AYsYT7jQ7OQE1xjkKwGQZGf1z9By15YgmPK2RQidgbh9OGepCRWhJ5m0Z42njr7
	qt3m7sQWIJwMyoZvG5zFvyiGCP8FvHx8sTzDituwahAhxgmuE+en5TUvxO+xJApH1xR0+s4ruoe
	L64QJ3PvrVPV29NM5SKFWsOBhu5r7GT6XHSe2YmeajCccGjoNC17SLGrqs2eLRrTMWWTlrkFgDp
	yjeGUEDeQw6oAwY1Bbpnx9xISh+BRYaiAqCdAXfOsjcfehDQSog/A0s6MMU6kU2dPednFn76ukW
	cj0gSFauNbmt9AhJDimVaSK0kg==
X-Received: by 2002:a05:690c:92:b0:8a9:8744:c07d with SMTP id 00721157ae682-8b1c67060e0mr55008757b3.18.1793399104308;
        Fri, 30 Oct 2026 15:25:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf147246sm730246d50.1.2026.10.30.15.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:25:03 -0700 (PDT)
Date: Fri, 30 Oct 2026 15:25:02 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: jrmmhm.kernel@eldare.de
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: clear vqs[] to avoid a UAF on a failed
 PM restore
Message-ID: <auUZPiXDIPpQ2/vK@devvm29614.prn0.facebook.com>
References: <20261001-vsock-restore-uaf-send-v1-1-5da60f707506@eldare.de>
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
In-Reply-To: <20261001-vsock-restore-uaf-send-v1-1-5da60f707506@eldare.de>

On Thu, Oct 01, 2026 at 07:13:29PM +0200, Jerome Mohm via B4 Relay wrote:
> From: Jerome Mohm <jrmmhm.kernel@eldare.de>
> 
> virtio_vsock_vqs_del() frees the virtqueues via del_vqs() but never
> clears vsock->vqs[]. If a later virtio_vsock_restore() fails to
> reallocate them (its error path is a bare "goto out" that only unlocks
> and returns), the driver is left bound with a dangling vqs[]. The next
> virtio_vsock_vqs_del() - on a second freeze or on remove/unbind - then
> passes a freed vring_virtqueue to virtqueue_detach_unused_buf(), a slab
> use-after-free. KASAN on a guest with a virtio-vsock device, after a
> restore made to fail by fault injection:
> 
>   BUG: KASAN: slab-use-after-free in virtqueue_detach_unused_buf
>   Read of size 4 at addr ... by task repro
>    virtqueue_detach_unused_buf
>    virtio_vsock_vqs_del (net/vmw_vsock/virtio_transport.c:785)
>    virtio_vsock_remove
>    virtio_dev_remove
>    ... unbind_store
>   Freed by task ...:
>    kfree
>    vp_del_vqs
>    virtio_vsock_freeze          <- the preceding freeze freed the vq
>   Allocated by task 1:
>    vring_create_virtqueue
>    virtio_vsock_vqs_init
>    virtio_vsock_probe           <- original allocation at probe
> 
> The object is the RX vring_virtqueue freed during the freeze;
> vsock->vqs[RX] still points at it. virtqueue_detach_unused_buf() does
> not guard a NULL vq, so a bare NULL-out is not enough on its own.
> 
> Clear vsock->vqs[] after del_vqs() in virtio_vsock_vqs_del(), skip the
> detach loops when a vq pointer is NULL, and also clear the array when
> virtio_find_vqs() fails partway in virtio_vsock_vqs_init() (which can
> leave freed pointers behind). This mirrors virtio_blk
> commit 0739c2c6a015 ("virtio_blk: NULL out vqs to avoid double free on
> failed resume") and virtio_rtc commit 548d2208455f ("virtio: rtc: tear
> down old virtqueues before restore"); virtio_console carries the same
> stale-pointers-after-failed-restore fix.
> 
> Testing: reproduced on a private VM with a KASAN fuzz kernel based on
> v7.3-rc5. The restore allocation failure was forced with CONFIG_FAILSLAB
> steered by the fault-injection stacktrace filter to the virtio-vsock
> restore path only; a guest-root program drives a pm_test=devices
> freeze/restore cycle (so .restore returns -ENOMEM) and then unbinds the
> device. The unfixed kernel reports the slab-use-after-free above; with
> this patch the same run makes restore fail identically yet produces no
> KASAN report. checkpatch.pl --strict is clean and the build is
> warning-free. The reproducer is available on request.
> 
> Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
> ---
>  net/vmw_vsock/virtio_transport.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 4f9aa9c4c3aa..0553c0641fd2 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -714,8 +714,15 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
>  	atomic_set(&vsock->queued_replies, 0);
>  
>  	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info, NULL);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		/*
> +		 * On a partial failure virtio_find_vqs() can leave freed
> +		 * virtqueue pointers in vsock->vqs[]; clear them so a later
> +		 * virtio_vsock_vqs_del() does not detach a freed virtqueue.
> +		 */

IMHO we can drop this comment. Clearing after failure is common enough.

> +		memset(vsock->vqs, 0, sizeof(vsock->vqs));
>  		return ret;
> +	}
>  
>  	virtio_vsock_update_guest_cid(vsock);
>  
> @@ -782,19 +789,30 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>  	virtio_reset_device(vdev);
>  
>  	mutex_lock(&vsock->rx_lock);
> -	while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
> -		kfree_skb(skb);
> +	if (vsock->vqs[VSOCK_VQ_RX])
> +		while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
> +			kfree_skb(skb);
>  	mutex_unlock(&vsock->rx_lock);
>  
>  	mutex_lock(&vsock->tx_lock);
> -	while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_TX])))
> -		kfree_skb(skb);
> +	if (vsock->vqs[VSOCK_VQ_TX])
> +		while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_TX])))
> +			kfree_skb(skb);
>  	mutex_unlock(&vsock->tx_lock);
>  
>  	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>  
>  	/* Delete virtqueues and flush outstanding callbacks if any */
>  	vdev->config->del_vqs(vdev);
> +
> +	/*
> +	 * del_vqs() has freed the virtqueues. Clear the stale pointers: if a
> +	 * later virtio_vsock_restore() fails to allocate new ones, the driver
> +	 * stays bound with a dangling vqs[] and the next virtio_vsock_vqs_del()
> +	 * would detach a freed virtqueue (use-after-free). Mirrors virtio_blk
> +	 * commit 0739c2c6a015.
> +	 */

Ditto here.

> +	memset(vsock->vqs, 0, sizeof(vsock->vqs));
>  }
>  
>  static int virtio_vsock_probe(struct virtio_device *vdev)
> 
> ---
> base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
> change-id: 20261001-vsock-restore-uaf-send-1fc7396fa1bd
> 
> Best regards,
> --  
> Jerome Mohm <jrmmhm.kernel@eldare.de>
> 
> 

The rest LGTM.

Best,
Bobby
