Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC7038331C
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095924; cv=none; b=M28GR8YxCxfZU6xpt+jAIDoC0pMM9KmuCtGv832Ip7o0d0x4gV+dR4HAc7nyl8Q8H7wEMwuVjVnK/x9pgazLKREHnxkKwJRu0u1e3rszc4MAAiCDVDQSEzpSYePvozLsfqy+6GCaOoxPKguAEq+omVZV9JA6l6PTj4zk+udy/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095924; c=relaxed/simple;
	bh=+8/VJhhwAWRz5iKAyGx7YnwI1nUcMidMBg/lFGhMB3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCpI2XGbfCTAw9eHFkHH97wk+wPtFpaUDwIU2viE0Z+btxX7orSoCeWsTaD6R/Ye1Sihkwf4bkyR5wfHFhWTpmGEd4g+RGmYD4HSvy1RhUHbbU+NdbUO6T9gaUqKrLPB/2aj+QZN1MCUeQDKtRNflvQlR8cM+QIVBjBkKqfhfck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AEEFJLxY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j4DJWna1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEEFJLxY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j4DJWna1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779095920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EqKUKOs8Xdi2Db46H+lGN1qYJFfdvrNsugQmOuQMj5w=;
	b=AEEFJLxYqWbcDlSkJ1sJyyJu16UNm91CgVlS0cY7I9np0EJF26wEgdP56SyRMYxyICeCu7
	k4zB9VbxZjXNqZBuubZzfV20eyyHNiijJsi+8eBSHUAz+wi+3H0s1btzTcMGsldVpxMdLq
	LTDNN2wcw5LD9pEG+WgLM+VXCl8vaAM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-U03fSGK0M6mev_7lvkSc1g-1; Mon, 18 May 2026 05:18:35 -0400
X-MC-Unique: U03fSGK0M6mev_7lvkSc1g-1
X-Mimecast-MFC-AGG-ID: U03fSGK0M6mev_7lvkSc1g_1779095911
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4411a2c034fso2085475f8f.3
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 02:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779095911; x=1779700711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EqKUKOs8Xdi2Db46H+lGN1qYJFfdvrNsugQmOuQMj5w=;
        b=j4DJWna1nBgLrdDHyJNOjFOHl7e8JIDK5vmGQlc9uMAvpVYxyGxP9bx5ChGQFv3NOJ
         9qFBWjQQ8FBtiS6WSTjvnXuv04bPQ46tZ3mOTckgv9LTHOuNkrey1ms4ZN8x96hnnjws
         6PRK1wg+XOOybxDBHmA8hk7+hPrMGyMQKR4VALSHEak+Hl1cs3yNFR6Kvj+IjT18wQzn
         7qDcYLiRIY4v7qW1NtZPDlA4yUevTsohxmjZF1pp3DxnUNTIJrQ6dbXH6Zt2lzd8w+FX
         xWy25K63cwocn5gIxeXTjEwnbuluicODI0kRI69yvrlbrqW7GnPVdpSjpiP+UvQy9t3c
         ZUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095911; x=1779700711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqKUKOs8Xdi2Db46H+lGN1qYJFfdvrNsugQmOuQMj5w=;
        b=jKGkq/9IgfFrAQ/wyUCJfbnwDgxh+ho6CHVsHZpCIsqxTGgBL2c2oHHPfKoUYq1QPd
         r16iFgSriYgt5JwiZTyZy5q6FRbmH8th3Q6TAV+COmqRgIe6b/OsNrJGqEpoeBPwzWdz
         ZwK3eEXFKaTM1PaAoCXpkfsS1UsXgXXFb1/yQqj3HnFirmpGKL0HVOzs36hH598q1di7
         2AlFYqi55c6BbTYP3YBM1pV+MHlghTt0DXq8V+kgDYtFXzVecxftIH41m//rmIUHex/e
         iLxgysqarHqSAWDDVpad42VPnyRRA2hDHggKoS3PYbRHREfCHCxV4vTkRML1X1W37DVJ
         DnCw==
X-Forwarded-Encrypted: i=1; AFNElJ9ebw+4ApyP/Lt2sZLANjh31QV4pRFgpQag8ryDSKs4aWi1PRBpGNX5As7DeeKUBsHauRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFp+M5ykCPww+QvnHC9oiN96KXUuEbTTEVNizEgNBFfopTINfq
	eCeHivMc6iMSIhKnC+KV11YdsDwFNvZSIDppUkgNZ3gMS+R6xsQpooC/VS/+AvYeVlNr18ZHF4O
	wVF83+d70NU9yOSsSnTbP309IlhnELRAOKO+YjbrlGWOQLucCjE3Nvg==
X-Gm-Gg: Acq92OG86xQKAq8tUShisi0rc2Gbe/Ow0t94x/3wgQz0raUp1SWm8gZKRoJXWuMXRuU
	kh2X4gtlTgsMQco0mnmqWHQfmnSoysObuygxdpuLE2Ev5yXr9ooLPhUSq1CJ1p+bugLuWAkfDqC
	podJMPUD1o3GSzQ4zUNmY2ClSkdwgJOPRsnOalvrcNvJN2WQpO7mmP1PaVMJzikqkwoHe74IrAW
	A/UtGU3MpMfQVG578ixNS4S6FwaRjiXtKrRV1HcvzPAc2ghOSQOaY3FGWhmExRkbESv25yqB02I
	BB1IwhxgdfnbHToQLjGPkjUXJPeGXgaX71x6LQRAqbBja2BrRQFqp8Y4i2lqv58b4ztT3CF6ddE
	KXv5K5+LpqLs42AMnpbNQYPb+42UYCGM7ENrkP0Y1cwjxKrEMuNN1hrx5Sj1zic4d7Kk16Wb26g
	==
X-Received: by 2002:a05:600c:35cc:b0:48f:fe2a:107b with SMTP id 5b1f17b1804b1-48ffe2a1125mr137667135e9.7.1779095910530;
        Mon, 18 May 2026 02:18:30 -0700 (PDT)
X-Received: by 2002:a05:600c:35cc:b0:48f:fe2a:107b with SMTP id 5b1f17b1804b1-48ffe2a1125mr137666435e9.7.1779095910029;
        Mon, 18 May 2026 02:18:30 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57944c1sm263396765e9.7.2026.05.18.02.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:18:29 -0700 (PDT)
Date: Mon, 18 May 2026 11:18:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, 
	Maher Azzouzi <maherazz04@gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb
 sends
Message-ID: <agrXvCtNRlySlwgx@sgarzare-redhat>
References: <20260514092948.268720-1-sgarzare@redhat.com>
 <20260516125329.7b699c6f@pumpkin>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260516125329.7b699c6f@pumpkin>

On Sat, May 16, 2026 at 12:53:29PM +0100, David Laight wrote:
>On Thu, 14 May 2026 11:29:48 +0200
>Stefano Garzarella <sgarzare@redhat.com> wrote:
>
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> When a large message is fragmented into multiple skbs, the zerocopy
>> uarg is only allocated and attached to the last skb in the loop.
>> Non-final skbs carry pinned user pages with no completion tracking,
>> so the kernel has no way to notify userspace when those pages are safe
>> to reuse. If the loop breaks early the uarg is never allocated at all,
>> leaking pinned pages with no completion notification.
>>
>> Fix this by following the approach used by TCP: allocate the zerocopy
>> uarg (if not provided by the caller) before the send loop and attach
>> it to every skb via skb_zcopy_set(), which takes a reference per skb.
>> Each skb's completion properly decrements the refcount, and the
>> notification only fires after the last skb is freed.
>> On failure, if no data was sent, the uarg is cleanly aborted via
>> net_zcopy_put_abort().
>>
>> This issue was initially discovered by sashiko while reviewing commit
>> 1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting")
>> but was pre-existing.
>>
>> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>> Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%40redhat.com
>> Reported-by: Maher Azzouzi <maherazz04@gmail.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  net/vmw_vsock/virtio_transport_common.c | 83 ++++++++++---------------
>>  1 file changed, 34 insertions(+), 49 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 989cc252d3d3..1e3409d28164 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -70,34 +70,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>>  	return true;
>>  }
>>
>> -static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
>> -					   struct sk_buff *skb,
>> -					   struct msghdr *msg,
>> -					   size_t pkt_len,
>> -					   bool zerocopy)
>> -{
>> -	struct ubuf_info *uarg;
>> -
>> -	if (msg->msg_ubuf) {
>> -		uarg = msg->msg_ubuf;
>> -		net_zcopy_get(uarg);
>> -	} else {
>> -		struct ubuf_info_msgzc *uarg_zc;
>> -
>> -		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>> -					    pkt_len, NULL, false);
>> -		if (!uarg)
>> -			return -1;
>> -
>> -		uarg_zc = uarg_to_msgzc(uarg);
>> -		uarg_zc->zerocopy = zerocopy ? 1 : 0;
>> -	}
>> -
>> -	skb_zcopy_init(skb, uarg);
>> -
>> -	return 0;
>> -}
>> -
>>  static int virtio_transport_fill_skb(struct sk_buff *skb,
>>  				     struct virtio_vsock_pkt_info *info,
>>  				     size_t len,
>> @@ -317,8 +289,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>  	u32 src_cid, src_port, dst_cid, dst_port;
>>  	const struct virtio_transport *t_ops;
>>  	struct virtio_vsock_sock *vvs;
>> +	struct ubuf_info *uarg = NULL;
>>  	u32 pkt_len = info->pkt_len;
>>  	bool can_zcopy = false;
>> +	bool have_uref = false;
>>  	u32 rest_len;
>>  	int ret;
>>
>> @@ -360,6 +334,25 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>  		if (can_zcopy)
>>  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
>> +
>> +		if (info->msg->msg_flags & MSG_ZEROCOPY &&
>> +		    info->op == VIRTIO_VSOCK_OP_RW) {
>> +			uarg = info->msg->msg_ubuf;
>> +
>> +			if (!uarg) {
>> +				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>> +							    pkt_len, NULL, false);
>> +				if (!uarg) {
>> +					virtio_transport_put_credit(vvs, pkt_len);
>> +					return -ENOMEM;
>> +				}
>> +
>> +				if (!can_zcopy)
>> +					uarg_to_msgzc(uarg)->zerocopy = 0;
>> +
>> +				have_uref = true;
>> +			}
>> +		}
>
>Surely that block should only be done if can_zcopy is true?
>And shouldn't something unset it if info->op != VIRTIO_VSOCK_OP_RW ?
>If the msg_zerocopy_realloc() fails then can't you just set can_zcopy to false.
>
>It info->msg->msg_buf is already set then I think you have to disable zero-copy.
>The caller has already requested a callback - and you can't add another.
>
>In any case by the end of this can_zcopy and have_uref are really the same flag.

I kept the same approach we had before, trying to make as few changes as 
possible.

All these potential issues seem to be pre-existing and should be 
eventually  addressed in other patches IMHO. This patch one only 
resolves the main issue of calling `skb_zcopy_set()` for every skb to 
avoid leaking pages, etc.

@Arseniy can you help on this?

>
>>  	}
>>
>>  	rest_len = pkt_len;
>> @@ -378,27 +371,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>  			break;
>>  		}
>>
>> -		/* We process buffer part by part, allocating skb on
>> -		 * each iteration. If this is last skb for this buffer
>> -		 * and MSG_ZEROCOPY mode is in use - we must allocate
>> -		 * completion for the current syscall.
>> -		 *
>> -		 * Pass pkt_len because msg iter is already consumed
>> -		 * by virtio_transport_fill_skb(), so iter->count
>> -		 * can not be used for RLIMIT_MEMLOCK pinned-pages
>> -		 * accounting done by msg_zerocopy_realloc().
>> -		 */
>> -		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
>> -		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
>> -			if (virtio_transport_init_zcopy_skb(vsk, skb,
>> -							    info->msg,
>> -							    pkt_len,
>> -							    can_zcopy)) {
>> -				kfree_skb(skb);
>> -				ret = -ENOMEM;
>> -				break;
>> -			}
>> -		}
>> +		skb_zcopy_set(skb, uarg, NULL);
>>
>>  		virtio_transport_inc_tx_pkt(vvs, skb);
>>
>> @@ -422,6 +395,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>
>>  	virtio_transport_put_credit(vvs, rest_len);
>>
>> +	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
>> +	 * skb_zcopy_set() increases it for each skb, so we can drop that
>                                                            ^ must
>
>> +	 * initial reference to keep it balanced.
>> +	 */
>> +	if (have_uref) {
>> +		if (rest_len == pkt_len)
>> +			/* No data sent, abort the notification. */
>> +			net_zcopy_put_abort(uarg, true);
>
>Is it worth optimising for the 'nothing sent' case ?

What do you suggest doing?

I followed what TCP does.

Thanks,
Stefano

>
>-- David
>
>> +		else
>> +			net_zcopy_put(uarg);
>> +	}
>> +
>>  	/* Return number of bytes, if any data has been sent. */
>>  	if (rest_len != pkt_len)
>>  		ret = pkt_len - rest_len;
>

