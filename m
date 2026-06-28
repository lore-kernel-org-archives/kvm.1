Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1773823DE
	for <kvm@vger.kernel.org>; Sun, 28 Jun 2026 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782671739; cv=none; b=BUNxI2zWAGikvoarFUW41AjvMu2G3onWy6BR0BtrztDqMuudJMZNXtR+EkzASwe1mdsKVpgGHQiCZ7Lkl7YvhF3sZnfPWvS0mZjRdv1x+YlMQF21TeZfvJuP9FWPEdSKAa9SWwOutuiMZBAqh+cfXI9VlnOiLaDIVu8VnPu14Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782671739; c=relaxed/simple;
	bh=NpueuavD31w+JK7qclqaceH12pxs8f2Li/NN2onxLz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHYcFE5ZTkJZrzx3b5toM3rvcnKQShoWhlOuXnDpNRLWU+U8vnnmln5IWcpe9Sndi0lTSBIVmiA6Dgz02gMOgz0C71Lcn6hIhdoSVjavE7JYSv/NUVnVYktcboOjgQoubTAlWnlRzSrsnhsud/k4WmCOvN64xOjjtDNkBEpUnRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZFGP1kv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Al+06Iid; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZFGP1kv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Al+06Iid"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782671737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RVj3UQKFe+bbSeb5ta8T6W1dIgFOrixbGRGcLh+YeGQ=;
	b=TZFGP1kv/hwSGOwJS8GLC71uc0epPnIae7EaDdJUBHw5YxLALtq/nY1NT3QpCduFADHUme
	aMe7cCoKf6R+1OfaEpq2DHt2NU5VxoPyfQ3tS0u7+7xz0HQnnkXiqqcAhfg6Vgrt/EGjyX
	XyUJ7PFpNkQW4UJZhkV7XusfjytKUnY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-R6wYoKLTN1ueg0YKcb8b1g-1; Sun, 28 Jun 2026 14:35:35 -0400
X-MC-Unique: R6wYoKLTN1ueg0YKcb8b1g-1
X-Mimecast-MFC-AGG-ID: R6wYoKLTN1ueg0YKcb8b1g_1782671734
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4926fa2cb17so13549615e9.1
        for <kvm@vger.kernel.org>; Sun, 28 Jun 2026 11:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782671734; x=1783276534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RVj3UQKFe+bbSeb5ta8T6W1dIgFOrixbGRGcLh+YeGQ=;
        b=Al+06IidoHwVGV5GWkOJuz8/MzemOBKp94avYkB3yl1nj+Jvxo83M4FkaYHVnsZSQk
         Rd8tOguq+p5uJy2THZePasdpS3KFBpFoQ7q+sn6uMgnBihdWiyF6bN7I4V0dbUxgwZyH
         TiRFneVKcyK5aYEdbNNl8ANtwSEyYevoLx0Pv7cG/FnxoymLWw6O8v1zsm2FaR3xNL1b
         v2/ExmKAH6sHll6ziFKaak5J/3jPWRjJJCc2KRzH/p5w8DX6cvel1fxv3LuMGQOAVmI5
         dXrenkhpW/v+XUMePtHSAg3KHISivW47O52QIHoxEJmL8STQdGQTz9svoI/b3S5Pm3p5
         cANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782671734; x=1783276534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVj3UQKFe+bbSeb5ta8T6W1dIgFOrixbGRGcLh+YeGQ=;
        b=IFInKwrWjA7n/s3xv98ZUCbMc0IBSZdaH3VtIJszTkMBO1pkwvwyv9PLT9Ikz4O4Pr
         4zFy1UCgtuCjdiz/cPAijbtWGOwgaYPHcQ4sZvlsPxqHjsXYQ5hr2KHNh0pAdE4toGWG
         CQOIi+fAUIlRiAr4FfFFTscV2vEaKUgxDdgghs5T3+PGCPm30jr62q0l9qvtyhIm9YEI
         1BP+ZEHQUon1PBOYMjW/bI66wQGCQ7Xsv1laEsaTDPzYg+8bMf4p9bFCZAQ7Yz4Nsr/u
         TK5FnBSrUFHrp8ItTxMgiOHt3z6HTdL/nHhjufwFzXpbuDOFfnD/fEI2uN4bZfwxFW+l
         3Spw==
X-Forwarded-Encrypted: i=1; AFNElJ8CgNyZlyvgqLd6idGYxbLZqvTHg4Y+Rm3Q7wOYYoKogEgWlp5QhcPQQRGF16452cVtIzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoeECQxZyIkb5r/41iYdTN9OdID0VJUJnBdOCFAKbfqZ1CbjXE
	XncQ+g0NZ4GhTb8DPC//ifx2okHDy0HDJjRIQ8M9EmjbI2S/0RXXmDjyFH1LgYcMsv+YlMiLW8C
	+neeuzgcVCdU3DnR1EfBeNCyxLAlHvN2K5QIKQCAmkXBQbwMlBnCHrw==
X-Gm-Gg: AfdE7cm8GEi1OTBNbFyod7RnIayaYTQ8lBfo2uHwGG1HWL1HEStSjIt0c4NuuYj9YD8
	XDKQmz5BqLKTYOTVVIUm0clzs+byoTzsuyVYHXMJkJ7a0df7hO22jHu4foj+ngZpn6r8aSWxN6N
	QAcrmM+4P5wH2bykiviswgnR5PXhxPUMw9Nmrej3XPjZ1JcQvPve796hGYPCan61xJpb8FW129S
	qp+w7KK1DhtGxbCa9i8vv/jW7SOB4BqXscX/AzqeBCJnP3Ao3ADWyKQkGO0PXA0/6CDbMhdA4EF
	GbCiYxp1xSu4hbr0JeqkeKs+JgapcQRX8S04IFjWMs4OQmPATOWEaKTESCgJiks5rAriieGkqWo
	xswaST6rQa9615cdRnVswQCx1yeZxuOtu
X-Received: by 2002:a05:600c:4794:b0:490:d37c:78c7 with SMTP id 5b1f17b1804b1-4925a0fae98mr243218885e9.14.1782671734354;
        Sun, 28 Jun 2026 11:35:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4794:b0:490:d37c:78c7 with SMTP id 5b1f17b1804b1-4925a0fae98mr243218565e9.14.1782671733893;
        Sun, 28 Jun 2026 11:35:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47290ed4377sm9226894f8f.37.2026.06.28.11.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 11:35:33 -0700 (PDT)
Date: Sun, 28 Jun 2026 14:35:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, oxffffaa@gmail.com,
	rulkc@linuxtesting.org
Subject: Re: [PATCH net-next v4] vsock/virtio: rewrite MSG_ZEROCOPY flag
 handling
Message-ID: <20260628143523-mutt-send-email-mst@kernel.org>
References: <20260628182052.951760-1-avkrasnov@rulkc.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628182052.951760-1-avkrasnov@rulkc.org>

On Sun, Jun 28, 2026 at 09:20:52PM +0300, Arseniy Krasnov wrote:
> Logically it was based on TCP implementation, so to make further support
> easier, rewrite it in the TCP way (like in 'tcp_sendmsg_locked()'). By
> this way, patch also adds handling case when 'msg_ubuf' is already set.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  Changelog v1->v2:
>  * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
>    already added.
>  Changelog v2->v3:
>  * Update commit message.
>  * Remove one empty line.
>  Changelog v3->v4:
>  * Update commit message.
> 
>  net/vmw_vsock/virtio_transport_common.c | 47 ++++++++++++-------------
>  1 file changed, 22 insertions(+), 25 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 09475007165b..41c2a0b82a8e 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -328,38 +328,35 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
>  		return pkt_len;
>  
> -	if (info->msg) {
> -		/* If zerocopy is not enabled by 'setsockopt()', we behave as
> -		 * there is no MSG_ZEROCOPY flag set.
> +	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
> +		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
> +		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
> +		 * handling from 'tcp_sendmsg_locked()'.
>  		 */
> -		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
> -			info->msg->msg_flags &= ~MSG_ZEROCOPY;
> +		if (info->msg->msg_ubuf) {
> +			uarg = info->msg->msg_ubuf;
> +			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
> +		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
> +			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
> +						    NULL, false);
> +			if (!uarg) {
> +				virtio_transport_put_credit(vvs, pkt_len);
> +				return -ENOMEM;
> +			}
>  
> -		if (info->msg->msg_flags & MSG_ZEROCOPY)
>  			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
> +			if (!can_zcopy)
> +				uarg_to_msgzc(uarg)->zerocopy = 0;
>  
> +			have_uref = true;
> +		}
> +
> +		/* 'can_zcopy' means that this transmission will be
> +		 * in zerocopy way (e.g. using 'frags' array).
> +		 */
>  		if (can_zcopy)
>  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> -
> -		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> -		    info->op == VIRTIO_VSOCK_OP_RW) {
> -			uarg = info->msg->msg_ubuf;
> -
> -			if (!uarg) {
> -				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> -							    pkt_len, NULL, false);
> -				if (!uarg) {
> -					virtio_transport_put_credit(vvs, pkt_len);
> -					return -ENOMEM;
> -				}
> -
> -				if (!can_zcopy)
> -					uarg_to_msgzc(uarg)->zerocopy = 0;
> -
> -				have_uref = true;
> -			}
> -		}
>  	}
>  
>  	rest_len = pkt_len;
> -- 
> 2.25.1

