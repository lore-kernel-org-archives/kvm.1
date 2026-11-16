Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862883;
	b=dyb4B6ddVHr/cVZsD9tN72W5BEXGiNdMfxhBj3rc3rHP67x2K74imP956e8qMfcFvWeW
	 Qkfe6dtma0uKqlN3UMlomCZTMjEwVm8gF9acbq0AMxbySA3pcZbtBqBcN+jBkzvClwhAa
	 eLZ75ctpBFvUFeP4usLOpZJicrODXCm3NoUY+8VeDNHhCX45PM7QheP39+l/p487yzbol
	 AJ4qSWJJToECrgVBFDuj84p7BDaNSPwyPnV40U9BqhYwqHx0kIoi8M0dyTNPOWuEoLB0s
	 QvTifaQLp12ujW8gJsFRUhYheFJYRov9ewHw9wizWz4IoIixNDOpQx1nTlAizwLtqVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862883;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SZoIL09apRESCSVy9LvCJwT2nl+8SSwpAsQe0tMlFOU=;
	b=ULgWxBPyBMo7r5WvsrYGhc77EAVLp4kiT7xW+SnBFAJWR6kj9Q74PofjrKv8lTJ9bupl
	 ucATz0JaDHYMXSGLSRUZKvN9JJStDzyDg1TGwMbYdOlgX5Rl54j2N0Hu4GxrWzOiQHdGi
	 W8K6vMtAXGz1hCBWgulT7OnyUu/TwPsg7GiZDSKL/D1dfFDciZXk7P8/dy59CFbb4ilMT
	 3tAgRaxxJTRFA04kWcmghupEe/qc+E4dF/z1GX9fnEfhmXP9IDPlSO8RxSUx3MYGDXwsg
	 UjAp6R9gQZEGaOE91tJP4YFwjVLl3LXIH6MpSvCUQDKIaflZPx3rxqYyL6j3u/W/ocQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L6uUzIuu;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UWmCt+L1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD414606A885
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 21:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD414606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L6uUzIuu;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UWmCt+L1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794862881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SZoIL09apRESCSVy9LvCJwT2nl+8SSwpAsQe0tMlFOU=;
	b=L6uUzIuu9sGhWZiaXdVNhmWShvxtQC9UDHSuU/qCHzS0corWiFXBXbybYvNUI9qDheRkPF
	R6EVj4NCJrY2qUO7YG8bWn9LWTbaSzdBmi2BTlOeIyQxHQtOz2bevupKBQbaszHX6VrPCD
	UKlk/aTPNJYakgZ3hLi/CwIi+TUV0Tw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-0MEb6LwxNI-pvT6QUvkc4w-1; Mon, 16 Nov 2026 16:01:18 -0500
X-MC-Unique: 0MEb6LwxNI-pvT6QUvkc4w-1
X-Mimecast-MFC-AGG-ID: 0MEb6LwxNI-pvT6QUvkc4w_1794862877
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4b764ffc014so29090205e9.0
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 13:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794862877; x=1795467677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SZoIL09apRESCSVy9LvCJwT2nl+8SSwpAsQe0tMlFOU=;
        b=UWmCt+L1yLojGLi1JJPb1er1CIug5BOIcWzK9D6Ki1BKVE5blUkly6BNf8C/uhOpPn
         OeRlOd0MItNECGd4XYpI9Xhq7vpEE+XXYjG4Q4OQ9xuusdVvzgWsiKzgmwh53AzNbb4k
         4SkvDtvRNqySsS3I9KoQVuqlf+35Jltx1PqUQySH46UOVT3C20wD3OAXVKvFKXxe6sWh
         PS/fRs9lniuiBEcaLoflMIvKXU8K6y8HV92M+MBhgu0qgFvifZIG4EEn9qokPEbFXnMh
         8bHHzTVNSZWTIn377zoLSKga96oDcjGBWFWDXMe3FUPVawEV79s+/uAJHzCy1pAgZkmu
         lZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862877; x=1795467677;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SZoIL09apRESCSVy9LvCJwT2nl+8SSwpAsQe0tMlFOU=;
        b=JLNn86m3rQrv2YcaCEcf8mes0eNNiO1OwjC5PwhdUHYKh2j06APaEBmX2d54m7hX2i
         XXZYs4BdZfBPb9GiW48XbUVm8IgXLxS0xJWPUUGDJvqulEnZWAnBkd+YY04kWwffI3Gw
         CAanuYmBpBsgDKhFP47DRDSa7kYKSJseHljw9a2DF79X6R/V5JXe2/aUv9P7pkLbDDEr
         lOGWC4CCobP8UCPi9sVlGmxjEYedd+LmSrtGMNHfbg5tr+CYF1rrxojBxRhcRusxg11Q
         sKeu9C6kZNcPbJi3u7tFFW9Htlwk54UpXkw1/x47A+5FC5DPKBLpeuBlT+gnrFScMmCG
         Wjhg==
X-Forwarded-Encrypted: i=1; AL+hErFkIqdSYUKgGSN6qO4bhwVXVlKy4gqwIFqR2GZPzvL61snRKtnGTVCu/I4/dQTKo7vUeAk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Z4wtdXeb1TYFizjJ6lJl5hfYFnrwjBNRW2d6PZNjbaUSJmlUZ
	qfwY565EtdXQPyj9sj7p8r9hn8EJ3Zz1ye+ikscvljYtmsXSrK6KaUbPvg7RBwVAZ1XHf7sduck
	C76ITH8szGzhOR00IqnLgwSxJxKu+wIOl+eW3BYMNo07gWO4J85Fx4Q==
X-Gm-Gg: AYBFou1O54rp4SdfojhJBg8b0cI0cLbAFPgq2iYX00/mSOtTPavxe18TZohayOzXK01
	jSzAUWX8RaIJqSP2jRvn+SzffOLX4DVNXCOcTtChzv9Hpu93vijYy3o6GAtm2n57l5a70wATlyc
	bM6lUqm2DGmfRdyFWTEksw/LM/j4LhXPeudoo5C8tyYpn3/eSz805ERF7ADfp/JXvk9zJrqRe5y
	56UnGJxCFEL2on+QDP8RsROvXHs1mItTrXHLAPitqy0IdWa9fL3Q2bFaPtEgJ7aDsW4TYOXgtJ/
	ivHhrlhk0YsgW3ud1cffNaz23Z7uV0vmE/7VVhZ8Bj8JKiMZXdTCTi/OGyz8ZCQFXQQybhQMZnR
	w21zjWAudoHkhaH4PRxTV6gKhtKXOiodVNm+39RQAEg==
X-Received: by 2002:a05:600c:e555:20b0:4ba:761:97a1 with SMTP id 5b1f17b1804b1-4bb55a50f1cmr166278275e9.14.1794862877119;
        Mon, 16 Nov 2026 13:01:17 -0800 (PST)
X-Received: by 2002:a05:600c:e555:20b0:4ba:761:97a1 with SMTP id 5b1f17b1804b1-4bb55a50f1cmr166277685e9.14.1794862876566;
        Mon, 16 Nov 2026 13:01:16 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:151e:a200:7a96:1b15:81f:ebed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7813fa23sm22454295e9.2.2026.11.16.13.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:01:15 -0800 (PST)
Date: Mon, 16 Nov 2026 16:01:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eric Dumazet <edumazet@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kvm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next v5 6/9] virtio-net: assert header sizes
Message-ID: <20261116160026-mutt-send-email-mst@kernel.org>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
 <20261112-v6-7-topic-virtio-net-ptp-v5-6-7ab67b572f4f@pengutronix.de>
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
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-6-7ab67b572f4f@pengutronix.de>

On Thu, Nov 12, 2026 at 12:19:38PM +0100, Steffen Trumtrar wrote:
> The header is cast from skb->cb and from device buffers, so its layout
> must not change silently. Add static_asserts for the offset of tstamp,
> the total size, the alignment, and that the header fits into skb->cb.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  include/linux/virtio_net.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 2abd8a614a23f..e7776a37a486b 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -29,6 +29,17 @@ struct virtio_net_common_hdr {
>  	__le16 tstamp[4];	/* le64 TAI receive time in ns, 0 if none */
>  };
>  
> +/*
> + * The header is cast from skb->cb and from device buffers, the layout must not
> + * change silently.
> + */
> +static_assert(offsetof(struct virtio_net_common_hdr, tstamp) == 32);
> +static_assert(sizeof(struct virtio_net_common_hdr) ==
> +	      offsetofend(struct virtio_net_common_hdr, tstamp));
> +static_assert(__alignof__(struct virtio_net_common_hdr) == 2);
> +/* virtio_net_common_hdr must fit into skb->cb */
> +static_assert(sizeof(struct virtio_net_common_hdr) <= sizeof_field(struct sk_buff, cb));
> +
>  static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
>  {
>  	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {


Waste of time. We know how to maintain stable UAPIs without this
kind of stuff.

> -- 
> 2.56.0

