Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32693EEAD9
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902528; cv=none; b=lEB/sgZA/aYetPvWGoVPn9zUN56j00rXpDnm1TkDcIQtLAgJNecgB+R4wXhN61L2ZCgHMdtgDz5EcZ/uaK9f6IejF2E69xrNmiMZK48g3YXppmPNXHmtUDXnBVBM18bjcJguPy83HCNMwUaFg8SuIV9lb6zePkcb+EL5FOe6QjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902528; c=relaxed/simple;
	bh=CPbqDF454Z+Ji6GvjieOLoul6JPLkeDeLkJZd8vBXK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVvxswYqDi5z0pfWyfQDPutQl/iXuN7OnMtzgeVpvZjhvyZ+oUVIXvHLEhPJFE6kLbuxP/cXnVyD+h3R8iLtEdVpMx7hQSu1fg/OyCgSwQa2G7NOnWNNt5URX/lKz99Spv8Ne2XP+b+zkr0HdSSvJDVpku9Z0G4+MgI7UDK3YLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IR+r2IQY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOEM50Ys; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IR+r2IQY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOEM50Ys"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779902525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O0yXQEHNKQkMY2wBw+4QDVrKj1M+JOLPnqN2RUokaPw=;
	b=IR+r2IQY9doGUnw0e89EkVnyLEUeI1xkb9DZ3csG05y5CjmDjZxj5UYbQA1+qn5aSobPjS
	qnf2NFzbmhYbxdTSYJJJWsS3leOFQYpfTS6Ejhjn5GNbn2u7HAIeyKZ8nrD6lfL25BhMmQ
	wBKL4Y5ViYVOGX/vnb7D9W6yWiHU33o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-7_rvSe_XPJq2wj4oDQ7bUQ-1; Wed, 27 May 2026 13:22:03 -0400
X-MC-Unique: 7_rvSe_XPJq2wj4oDQ7bUQ-1
X-Mimecast-MFC-AGG-ID: 7_rvSe_XPJq2wj4oDQ7bUQ_1779902522
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49081106196so10084195e9.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779902522; x=1780507322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O0yXQEHNKQkMY2wBw+4QDVrKj1M+JOLPnqN2RUokaPw=;
        b=eOEM50YsFf+tfxXTQ7WjxZDb37lhfZHvWuJlqo0Wf20yS8b3qx49e0DMDxSPtKizdX
         s7qBh1XOpGTcNOWBnRhesTo/1RbEaOHHj5L8eYO/e5Yw99wl6DySlWffm7KCfZReH/A1
         PXzjbywddZeEHLIrX6EOylX0WDukVUPbqJjiggRH7RS9YGh0wEGFuCMtc9ugYgrQ+Ndv
         hXds6frC6eFoOr7R2Pqm954M4E6ipiT2BmNOqja62Q18vg4E/BJI2ikJHDvsZLT9qhF7
         Xysrrkxq3OkrrP/n6tBx89utVptf8WmdvHfklhJeSeP4nu1rHSyKl3XT4C4vS+DgjN1c
         QRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779902522; x=1780507322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0yXQEHNKQkMY2wBw+4QDVrKj1M+JOLPnqN2RUokaPw=;
        b=BfwDoKQPuNP8l7SdgwGTtFZJcykK/qeiRieTzeJmQOgXK70e/MIgHNwBpKTtK5zWuw
         tJwo7R1k2d36yzeDnrkMWtahJThmcGIKVkk6FD4swcyHVIg3dRkv2MoN6aqT2zwuOqcK
         axWlW8djqSBHWnR92DT6H0xglmjrvGPR6exWV4t+wY94DM/1IamFD/qv8eRwJ5oA9wAO
         tNYAeNL/7JQttM+wo6AHnM2hPIRkOXPGfI8l1dtMbXS4amD5iYpSUOiIo7s1GN2raVvP
         EbRb1OqbcIfScuWH08aB/JXWDZxmU6Y5yx9WR8pEAo5rfuXFFgD1pjPPP4sabnbkeqNO
         zfZg==
X-Forwarded-Encrypted: i=1; AFNElJ+CjymR92YOn0kEH10Zuu6Ieo9/GLAFIvOQuxtuyUJUi5KyfP28XZ6C68jJ/WTDpn6uITw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvmkbmKADB6oPMHbDqidIDqLUFiME/3QwNPLZx64COQqX0FuYA
	DbUM34AvbYAbCMMZ8M49HgQGFUHYzC6yKuGkfJlB2ev+ZdCe2Dsn7bEDovTwZ/0pGR+yOKwzj6o
	VNVY2AWEH73ZHHUZR4u41iDOVkCEkyJ2zxxsssJKU9pJjsFUUM4lRng==
X-Gm-Gg: Acq92OEwL2BOp4eLczBLCk7F1+OqXGwHdU0lNlAda1Yj0p3X8qt+pxO3DtklnjNwNwX
	6HQkxf8koqnengN6JkNxQ7d9KDX4SSM7LWgP+7C/58o9KcH2E66yg2FvG3bYlVkv19KCI2KeC8R
	QHojgMnaYKx4VKhIfOHFLU6j+pbKiJ//hXAGfs2KG3iVMSrQ22CrFwOxcdOhNE++IWaPsvjDF1B
	di5i3BfuxHr1c2FQdDRfHeuLD6+S2Je3T848IRRoWwf07Sgq6rPz3yQ/ILMP8Kb9Q11Rk+NLRsy
	mouLOZiB9xsolm44MTP6hu0j2eEM1xTWkEzBOFsM6Be8fOjku+MggqqdipuSZ5GPj118XKZcT4S
	mArdpgfEDzHoq
X-Received: by 2002:a05:600c:35c8:b0:48f:f7cc:f703 with SMTP id 5b1f17b1804b1-490428e2d58mr447993385e9.30.1779902522053;
        Wed, 27 May 2026 10:22:02 -0700 (PDT)
X-Received: by 2002:a05:600c:35c8:b0:48f:f7cc:f703 with SMTP id 5b1f17b1804b1-490428e2d58mr447992735e9.30.1779902521535;
        Wed, 27 May 2026 10:22:01 -0700 (PDT)
Received: from redhat.com ([31.187.78.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ee2a12a69sm315565f8f.16.2026.05.27.10.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:22:00 -0700 (PDT)
Date: Wed, 27 May 2026 13:21:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH RESEND net] Revert "vsock/virtio: fix skb overhead
 overflow on 32-bit builds"
Message-ID: <20260527132150-mutt-send-email-mst@kernel.org>
References: <20260527171046.130211-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527171046.130211-1-sgarzare@redhat.com>

On Wed, May 27, 2026 at 07:10:46PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> This reverts commit 4157501b9a8f ("vsock/virtio: fix skb overhead
> overflow on 32-bit builds"). The fix was semantically correct (although
> it would have been better to use mul_u32_u32(), as David pointed out),
> but in practice we are estimating the memory used to allocate the SKBs,
> and this will never cause a 32-bit variable to overflow on a 32-bit
> system, since the memory would have run out long before that. On 64-bit,
> SKB_TRUESIZE() already evaluates to size_t, so the multiplication is
> already in 64-bit arithmetic without the cast.
> 
> Let's revert this to avoid unnecessary 64-bit multiplies on the
> per-packet receive path on 32-bit systems.
> 
> Reported-by: David Laight <david.laight.linux@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260523173557.5cc4f4f6@pumpkin
> Suggested-by: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index b143290a311d..d4d26fba9e37 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> -	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> +	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>  
>  	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
>  	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
> -- 
> 2.54.0

