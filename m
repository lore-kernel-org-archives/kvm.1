Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794983614;
	b=0Oi0y7SjctcV1MKgi1AFtVqGGwCq1cALfiFglvks1hHT5PPrgozsJ+xXwqhSIKpKV/7A
	 Dwki3lv0QhWKLmc3vtt9bHX9i2+Ds+CMZQmPv0qbO5tq20fajQ+j7Pnm7HeAUI9LjOcrH
	 v+Hc1VUULEua2tgyU5u9FosXtO7bp3xlEFz8PlliGmQjSrrW3o6034EZr0eTjGqZA9iPa
	 xxAF5+oR6fILXZQNwDK1Bc/m8MmZsIXhcnlK+H0bBbNYT4be48zFgp/IIfi5f8hJAsivV
	 XA6LDfX920mCEEUQ6dw6rMcJkx/XVdnCN62pcVz2x+0pi7kM2iob83Iwg6EuZ9uK3Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794983614;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jm9UtSkj5qTjc2aQp3GV2uLJyBITV/apzUIo7FVG7gI=;
	b=eQz0r0Ecqo+61fvOIX/BW1WQFdFAqW7dOfkZphCacUBnxLC8pkjTucu0LtwM7OnwRkIc
	 S4HTrrhJ8/dvGNPmppKJuVIoBU8wf4uumzhkeTe002retbR10o1hern9RCmxDNZMiAtsm
	 monUe1dkJYOQ2AHcv060aktn+jT6HZcNo9/iDRtdV8cG8QwIehcwsejSlQfe5FS9J2Pbb
	 /+aPOfLvkbVE3i+7KZpsQZCxiJSf4OfL3lko77JJToleoTctSdUwH91R3UQuUoOfTesX4
	 c36+4GnC1K5G1ACITi2SBOenT/G3YeJ0Stwct1kgUD4IL0MWXamGgO0Oo0mj7/bCchw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g+9SqRhd;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Fp4fJ3jX;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC3606A31C
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 06:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6CC3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g+9SqRhd;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Fp4fJ3jX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794983612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jm9UtSkj5qTjc2aQp3GV2uLJyBITV/apzUIo7FVG7gI=;
	b=g+9SqRhdcc8PtGN7J4iIX12LRnrT0ZjmcOYm70Bix8sdhfpJi1IXCSSbBCFirrLMFjKBEQ
	+XbSkyuHI7w8UxbIJwyDmaaQsTqs/5BvkGpLrYVrF9l050i6sSiAV7RYJmuqdBaZmzWIk5
	sJybfFVBTeWXBS3KB97t6avykbf1m2I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-FjpFOTAMMpW3rZ91yNTeZA-1; Wed, 18 Nov 2026 01:33:31 -0500
X-MC-Unique: FjpFOTAMMpW3rZ91yNTeZA-1
X-Mimecast-MFC-AGG-ID: FjpFOTAMMpW3rZ91yNTeZA_1794983610
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4901562b819so439940f8f.3
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 22:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794983610; x=1795588410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jm9UtSkj5qTjc2aQp3GV2uLJyBITV/apzUIo7FVG7gI=;
        b=Fp4fJ3jX8fL3RkP2MYtSO/q5wVOjCaqut2mwdt3VSNCGIWBmalQYnQEsH/v/Wp7w36
         ppoCCpu6jqoQWcmpIKe6gsQnZUMBvAzBMk+W71ojaWP9ncG6lGw10PhcK8nDDi9gcukU
         8Xce9Ujz27J7Nr2MYnUTyRls4WOCxuIfejnwF+RLNtpsMWAjeDrWOXEfombtByHcmuAc
         O52cL4ND9OMyLIYVc5jvbt1NjWIeAjHn2noPkhTb+vstAcWbNJypjGOPXDNkxhVCbL4I
         /OU8BKWNVeCeLR44YJJsrBPcx7A7FoNv+frcRCsKviZfdVJBvdyooV1r7cUcUUNE/ycW
         7zHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794983610; x=1795588410;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jm9UtSkj5qTjc2aQp3GV2uLJyBITV/apzUIo7FVG7gI=;
        b=QdrbYlu3Z4io4+ePI0xuI6s/T9iNPmkfy+cnzIoGqcmKUP9Fkw0UhbMrr+o7WHWUjx
         UDDKvrzs48UvzVI+ItpcOF3PoB6Nh1eBYgmH6n7mXKZC2pOm7q8gwoNCc08HA2pdeHM9
         Ea61Wrxxdr0VHjjUyZyoexrTW+Cn14AJHaoZECiFdc4oLXKZFygn7kNEWIYLuAlQFtkY
         u2xwYZiEwZR9+83WFf3QPWNIoK6m+o9S5NpkfIYOKqmpJM46n0HXm9y7Xx2f71cpcCHe
         YiHRSLt3NV3OMphHn4CwCSTzOLvc44iqBs+DjXfWcd4hWrjaQEODpLnwXHmBsWMcqaYy
         xXjQ==
X-Forwarded-Encrypted: i=1; AL+hErFnlASGvisL6us39N0D2jbGwxOBAqY0SZ1TCutlQmGzXPZ+gvwdwA8gt0d3h5o2y6eyagc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Wt6nDD7MOghBgNRjV0aqJELRmL458hOPx03XE/2A7FvBVoBPI
	fKdGlu5cKgrFF+iIsE33nBJoBzTUEltaWGYL72Mu+0E81ND6crLaVIPkVmThBqd7XWgiu+GjGSF
	qziOZX8P8A3VxzrXigaPbf4snx7WEVrb4ENeJetJZM8hp+p5cvDIYlQ==
X-Gm-Gg: AZFdTZcQtZw9Rz+kFwGDKC5Y9N3bGPdaGdMBQXsIugDW8Qsiu+VIg+OD3S0rPGcTSnl
	+c0uYpMpxqpGQhBm37It+t1vCyaZtVFb/XnQoRuZXkuP7mSlgRhAAOvyQy1D1uRGTrEVPMVy6BV
	BQ+No2DfbJOQ7Hzd205fEThxFhvL/OOUfx7O7DbBrVgvjLCrD1iwwmfrk5uJL7IcjSOQ8spvM9i
	LP6p9xzX/GtPSy+a/CB8Pmbgsgtnmp2JgRkA/aVrBTR6bXe7iN97pxbe/OdP84NVDXEVPgP8aMm
	Ine9cpyKgW/W7z8MbgaNLJ3KW8acF4rtBKzFLyka62ijljVvxyFIQeGgHUlAYVu9RLo+sjWry/X
	NAUA1Tzx1Idzao/u8zUZjNyGk64VJPumOLEkrjABk3aY=
X-Received: by 2002:a5d:5d0d:0:b0:4a7:9630:7b5a with SMTP id ffacd0b85a97d-4a7963080e7mr331949f8f.47.1794983610313;
        Tue, 17 Nov 2026 22:33:30 -0800 (PST)
X-Received: by 2002:a5d:5d0d:0:b0:4a7:9630:7b5a with SMTP id ffacd0b85a97d-4a7963080e7mr331922f8f.47.1794983609777;
        Tue, 17 Nov 2026 22:33:29 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65560b5f1sm2935743f8f.21.2026.11.17.22.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:33:28 -0800 (PST)
Date: Wed, 18 Nov 2026 01:33:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Asias He <asias@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost/vsock: annotate lockless accesses to guest_cid
Message-ID: <20261118012321-mutt-send-email-mst@kernel.org>
References: <20261117164916.2332953-1-phind.uet@gmail.com>
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
In-Reply-To: <20261117164916.2332953-1-phind.uet@gmail.com>

On Wed, Nov 18, 2026 at 12:48:43AM +0800, Nguyen Dinh Phi wrote:
> vhost_vsock.guest_cid is written by vhost_vsock_set_cid() under
> vhost_vsock_mutex, but It is also read without that mutex in
> vhost_vsock_handle_tx_kick(), and vhost_vsock_get().
> 
> KCSAN will report data-race if we issue VHOST_VSOCK_SET_GUEST_CID
> ioctl while the device has TX traffic. For example:
> 
>  write to 0xffff88810f1596ac of 4 bytes by task 7914 on cpu 1:
>    vhost_vsock_dev_ioctl+0x25f/0x720
>    __x64_sys_ioctl+0xc2/0x110
>    x64_sys_call+0x299/0x20a0
>    do_syscall_64+0xc9/0x510
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>   read to 0xffff88810f1596ac of 4 bytes by task 7910 on cpu 3:
>    vhost_vsock_handle_tx_kick+0x41b/0x740
>    vhost_run_work_list+0x97/0xc0
>    vhost_task_fn+0x98/0x1f0
>    ret_from_fork+0x2e2/0x3c0
>    ret_from_fork_asm+0x1a/0x30
> 
>   value changed: 0x0000004d -> 0x00000032
> 
> Both readers load the CID once and works correctly with either the
> old or the new value.
> 
> Mark the store with WRITE_ONCE() and the two lockless loads with
> READ_ONCE(), so KCSAN knows the race is intentional.

You make it sounds like it is just KCSAN false positive.
Is it?
if yes, this should be data_race. If no, document why.



> 
> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>  drivers/vhost/vsock.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 88a310390eb0..f26c59013075 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -78,7 +78,7 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
>  
>  	hash_for_each_possible_rcu(vhost_vsock_hash, vsock, hash, guest_cid,
>  				   lockdep_is_held(&vhost_vsock_mutex)) {
> -		u32 other_cid = vsock->guest_cid;
> +		u32 other_cid = READ_ONCE(vsock->guest_cid);
>  
>  		/* Skip instances that have no CID yet */
>  		if (other_cid == 0)
> @@ -572,7 +572,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
>  		hdr = virtio_vsock_hdr(skb);
>  
>  		/* Only accept correctly addressed packets */
> -		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
> +		if (le64_to_cpu(hdr->src_cid) == READ_ONCE(vsock->guest_cid) &&
>  		    le64_to_cpu(hdr->dst_cid) ==
>  		    vhost_transport_get_local_cid())
>  			virtio_transport_recv_pkt(&vhost_transport, skb,

Will prevent compiler from hoisting the reads out of the loops.
Does it matter?


> @@ -859,7 +859,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
>  	if (vsock->guest_cid)
>  		hash_del_rcu(&vsock->hash);
>  
> -	vsock->guest_cid = guest_cid;
> +	WRITE_ONCE(vsock->guest_cid, guest_cid);
>  	hash_add_rcu(vhost_vsock_hash, &vsock->hash, vsock->guest_cid);
>  	mutex_unlock(&vhost_vsock_mutex);
>  
> -- 
> 2.53.0

