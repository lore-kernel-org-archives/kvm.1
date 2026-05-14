Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585AF3FBEB1
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767690; cv=none; b=bz9xffN3YxnP6fOD1hMziyfgoz7xmol13I4+tVxAGng4YlI6lH+ffNskXGc4fILOGrpgioKqmnlCq0v28fPrFcgB4RT91kHWuMODEGoepEamJzr1POHZ2XN9BncsUs1/z+HLzjrszaILRTgRvXhouD1Rdx80broy4kb9J2V3Qz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767690; c=relaxed/simple;
	bh=zmu7aRd64dS4ZKw6Wk+/frG+xsLmxSMAdItjKBGOrdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7Z9QqfdwVs03vLimtH7VyCm7ltOebc9Jcei+B7MCIIDOH0qz8LzhWkZ7jQS0x8ImZW2SpbmnaWGnr3EzjjVjB4zV3H76qKePY4XVhFE8gMx2ls0P1tV5sqNdGavgzIpfeXkrYalabkqujvduaz/gzR6PF88hc5f7s6si07xxm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KoTZtSQu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tPxPaDw7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoTZtSQu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tPxPaDw7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778767682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8A0YZSg/W/8L4/eAOnDT46SJMA7wk53CPNNj0OoZovs=;
	b=KoTZtSQuwvttzEj7KMTle0V5ZKAu3CLJa1Xg6PJtpk9t4H1fz2+1bXDenuPKJ95jGJvz7W
	lUb8rVbW18OtkgZVNxixuQipEmQWE4yLLqmGoME+5ELYiIUBDp/vvnIutLDyvFKICTPPNi
	okwkW10BwwT+8bOCJ3xwNZYQTd/Q2GQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-F1vtNMXkPRC7Zvfej4aFNg-1; Thu, 14 May 2026 10:08:01 -0400
X-MC-Unique: F1vtNMXkPRC7Zvfej4aFNg-1
X-Mimecast-MFC-AGG-ID: F1vtNMXkPRC7Zvfej4aFNg_1778767680
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43ff19e54beso5624993f8f.2
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 07:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778767680; x=1779372480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8A0YZSg/W/8L4/eAOnDT46SJMA7wk53CPNNj0OoZovs=;
        b=tPxPaDw76R7Jdi/7J194lnT//uEjlYQw2oEK4n8a7DeX/1WxIBI16GX2IVBnba72fX
         /D3p3f0lgQOgiUZe9caX7dUQhDS03xSYHXUpvpkgt4gAxkHLP1bVto2AYujsBTDoSYS+
         hxYOB/c8TbJH0KZVMo+iLZAF5iTf+xzPpE/lo+YVlbVeaDPJ3DwvTcG7iRJ67Oya5d3r
         K7j1gtNlTIP0t5A+xVuKs3newsyFhDGHneG3fihxhEyjcmifIWJrgq2JerV61VwrzJ/d
         Z7MMdM1kCNTrulka678246jzU4Ri3tP1JjGz4XCgFErqDj+fpWXw2B1OW3Flbfp8b/CG
         wcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778767680; x=1779372480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A0YZSg/W/8L4/eAOnDT46SJMA7wk53CPNNj0OoZovs=;
        b=jWmrf/GwwMSULsEuZUGVjq9+2eOm/Dshpzo5of6ZODB7xDo4QMI14EJH/9hB0D+K6E
         W1m9weajBtCrMu55s6YwpuoSRHnD4DSuONr0AtpdrnRFCPrnKMVm9gIPK4INvAdZt3by
         A4w2wtsTjsI74D3FsJZ6IKrlrFoLn7fmzyw9a/baD8Va/FLVo0dU/F5cEF96aBgyxBuj
         /Ofd8mkPPVPHbO6EKXsjpGyOXc9D+2eCRNWRFtaj59jFfePx59YgrPRy5hZqwBUU7XkP
         OopqhZHz/eGJtUDnlfQyaGQtuc2xuPPd2VB7Tu/WWtm4DRo5+u91eaSeD3av16mPcJCF
         Zc6g==
X-Forwarded-Encrypted: i=1; AFNElJ+gfKzk2tmhDxwB7SePGWQ0DuOZo03Kn79eGQ+Vf5fi2JNFa6lUxJ4mhcfryXMTxA+mMw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw01zCrSZOb02WK70CJuA5BG99He8nnqR48qly9vWUeS+TZh4/A
	EpM3oCDtYygwIYYcowRPvcK4B0G2yTtVP7tQ/zeHmgXNF234xw8gFqdNiUu8QfZCe8eY3bAsjiu
	95PAyFlkxlanIX7uH1RyJTnOzT0OxstyEKQjl6qHL5o52x7kjgXLqlw==
X-Gm-Gg: Acq92OGPnNRYAS5LAbrGsL4o4CW5E+HlVd2wE7iSkyIFywa5aEF0EMa8YvBmwZc98ME
	lTIgkppDYtjkHy3ke17UdRkzO6vibdYyDPvL6g3J1DUdQojMU8oKY24U3cBnqnlvkBq4GRX7+7e
	i76F5CIng/XxRpMlAZBqhHqZiCuR8To/INj+mkIDLUfUkCVfU/ayYdDpEU9bVgQXtJt8jNMgmZS
	EvsXcthybAgE5a17AoLM+QO6gI/0LhgFMSGW6pKqGplHkO5dTnPm0kE+diDr6CDoXcbu62/6J7n
	EsYQESePyBNWjxLBNjV0HBgzIM370mllB8qfcMh67EspvHZZAca5znFsTRuiaEeo9e/aga7x9SW
	NhO00jsxVt1DlX0tvRDzHbwC8YPCzCWsJe+gCx1iz
X-Received: by 2002:a05:6000:2486:b0:451:bee9:17c8 with SMTP id ffacd0b85a97d-45c580ce320mr12909342f8f.6.1778767680091;
        Thu, 14 May 2026 07:08:00 -0700 (PDT)
X-Received: by 2002:a05:6000:2486:b0:451:bee9:17c8 with SMTP id ffacd0b85a97d-45c580ce320mr12909290f8f.6.1778767679530;
        Thu, 14 May 2026 07:07:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19b1dsm6741686f8f.17.2026.05.14.07.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:07:58 -0700 (PDT)
Date: Thu, 14 May 2026 10:07:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
	Maher Azzouzi <maherazz04@gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb
 sends
Message-ID: <20260514100747-mutt-send-email-mst@kernel.org>
References: <20260514092948.268720-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514092948.268720-1-sgarzare@redhat.com>

On Thu, May 14, 2026 at 11:29:48AM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> When a large message is fragmented into multiple skbs, the zerocopy
> uarg is only allocated and attached to the last skb in the loop.
> Non-final skbs carry pinned user pages with no completion tracking,
> so the kernel has no way to notify userspace when those pages are safe
> to reuse. If the loop breaks early the uarg is never allocated at all,
> leaking pinned pages with no completion notification.
> 
> Fix this by following the approach used by TCP: allocate the zerocopy
> uarg (if not provided by the caller) before the send loop and attach
> it to every skb via skb_zcopy_set(), which takes a reference per skb.
> Each skb's completion properly decrements the refcount, and the
> notification only fires after the last skb is freed.
> On failure, if no data was sent, the uarg is cleanly aborted via
> net_zcopy_put_abort().
> 
> This issue was initially discovered by sashiko while reviewing commit
> 1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting")
> but was pre-existing.
> 
> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%40redhat.com
> Reported-by: Maher Azzouzi <maherazz04@gmail.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  net/vmw_vsock/virtio_transport_common.c | 83 ++++++++++---------------
>  1 file changed, 34 insertions(+), 49 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 989cc252d3d3..1e3409d28164 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -70,34 +70,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>  	return true;
>  }
>  
> -static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
> -					   struct sk_buff *skb,
> -					   struct msghdr *msg,
> -					   size_t pkt_len,
> -					   bool zerocopy)
> -{
> -	struct ubuf_info *uarg;
> -
> -	if (msg->msg_ubuf) {
> -		uarg = msg->msg_ubuf;
> -		net_zcopy_get(uarg);
> -	} else {
> -		struct ubuf_info_msgzc *uarg_zc;
> -
> -		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> -					    pkt_len, NULL, false);
> -		if (!uarg)
> -			return -1;
> -
> -		uarg_zc = uarg_to_msgzc(uarg);
> -		uarg_zc->zerocopy = zerocopy ? 1 : 0;
> -	}
> -
> -	skb_zcopy_init(skb, uarg);
> -
> -	return 0;
> -}
> -
>  static int virtio_transport_fill_skb(struct sk_buff *skb,
>  				     struct virtio_vsock_pkt_info *info,
>  				     size_t len,
> @@ -317,8 +289,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	u32 src_cid, src_port, dst_cid, dst_port;
>  	const struct virtio_transport *t_ops;
>  	struct virtio_vsock_sock *vvs;
> +	struct ubuf_info *uarg = NULL;
>  	u32 pkt_len = info->pkt_len;
>  	bool can_zcopy = false;
> +	bool have_uref = false;
>  	u32 rest_len;
>  	int ret;
>  
> @@ -360,6 +334,25 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  		if (can_zcopy)
>  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> +
> +		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> +		    info->op == VIRTIO_VSOCK_OP_RW) {
> +			uarg = info->msg->msg_ubuf;
> +
> +			if (!uarg) {
> +				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> +							    pkt_len, NULL, false);
> +				if (!uarg) {
> +					virtio_transport_put_credit(vvs, pkt_len);
> +					return -ENOMEM;
> +				}
> +
> +				if (!can_zcopy)
> +					uarg_to_msgzc(uarg)->zerocopy = 0;
> +
> +				have_uref = true;
> +			}
> +		}
>  	}
>  
>  	rest_len = pkt_len;
> @@ -378,27 +371,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  			break;
>  		}
>  
> -		/* We process buffer part by part, allocating skb on
> -		 * each iteration. If this is last skb for this buffer
> -		 * and MSG_ZEROCOPY mode is in use - we must allocate
> -		 * completion for the current syscall.
> -		 *
> -		 * Pass pkt_len because msg iter is already consumed
> -		 * by virtio_transport_fill_skb(), so iter->count
> -		 * can not be used for RLIMIT_MEMLOCK pinned-pages
> -		 * accounting done by msg_zerocopy_realloc().
> -		 */
> -		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
> -		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
> -			if (virtio_transport_init_zcopy_skb(vsk, skb,
> -							    info->msg,
> -							    pkt_len,
> -							    can_zcopy)) {
> -				kfree_skb(skb);
> -				ret = -ENOMEM;
> -				break;
> -			}
> -		}
> +		skb_zcopy_set(skb, uarg, NULL);
>  
>  		virtio_transport_inc_tx_pkt(vvs, skb);
>  
> @@ -422,6 +395,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  
>  	virtio_transport_put_credit(vvs, rest_len);
>  
> +	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
> +	 * skb_zcopy_set() increases it for each skb, so we can drop that
> +	 * initial reference to keep it balanced.
> +	 */
> +	if (have_uref) {
> +		if (rest_len == pkt_len)
> +			/* No data sent, abort the notification. */
> +			net_zcopy_put_abort(uarg, true);
> +		else
> +			net_zcopy_put(uarg);
> +	}
> +
>  	/* Return number of bytes, if any data has been sent. */
>  	if (rest_len != pkt_len)
>  		ret = pkt_len - rest_len;
> -- 
> 2.54.0

