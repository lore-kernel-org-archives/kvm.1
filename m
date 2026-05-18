Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62B33C18E
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102544; cv=none; b=Srd8Tzu1RQpmIB2zhKEpq1bk08igfF2z9Xc6ek73o3r8qjoGy6lfyJx45nOuDG90FmicXAcnY92/C/BJ5Zkd7u2y5ofRXwFFkW4Ej1mQMjsIVy6LUIJKunXBt6MpfMRhs+h548J25kJ9yCZIaOmSdBNGWtcNMtzxCAj4VEbwWPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102544; c=relaxed/simple;
	bh=y3lQJ8hKleP3cpjvWx4c1dbbB/MQsDLBh2c1U+YqGYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MG5QGkcuABjoirCI3215NqRfRwdm68mNSoo8Akzey7tBzQ2VLjuSvy65v14ZK9f+X8hV9eyHaqmX03If5ycEVk/DAfr9IjczNR3SQx3rpTtqpjsE/OPcmwtz2gb/HnfenJIEfI1A7FgQot7q49FkI1b9jSnh+SI0gi75ksZmMkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVus2D0u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tLI3bJtI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVus2D0u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tLI3bJtI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779102541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EdVqpBql5Gqkrx4EFtfutWcr864h1ZHzOOzFvQJojI=;
	b=AVus2D0ug6l87TdrTm831FbGxLjK/za8T2Reh6HGEI57RySZZCP4olP+Vzv7vFgHjZVuvD
	j5hXo6PoTEDSR8s6uRW/LchtZ2XvThD/yFQM7HmcI/RMVGQN0JoMtI5sdj+G74at/1Dz5X
	vKCRztHDa/KZ88+S+EuIBc0h4JhDgsw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-8FVOPompNeGG1bpq1GZ7qA-1; Mon, 18 May 2026 07:09:00 -0400
X-MC-Unique: 8FVOPompNeGG1bpq1GZ7qA-1
X-Mimecast-MFC-AGG-ID: 8FVOPompNeGG1bpq1GZ7qA_1779102539
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fd33b4921so17364655e9.2
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 04:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779102539; x=1779707339; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3EdVqpBql5Gqkrx4EFtfutWcr864h1ZHzOOzFvQJojI=;
        b=tLI3bJtI6RMtoDHDZv9yUDgLY4wKuVNL9cwt6FP5t33/3CHBICxtGlnfbqjKOUwZgy
         PCwYUv2zWxxKFkXbqcdLK89CzTXz8dZ1LHGaIxffQCynRxxEghmVKnDJolCZKJQIHpX8
         9mZI8pUmP+eK4qCeC+D6jju+OYf0bTUGG/glkgE9CUFggdWtsPIBuwy2VzFdnMQiZF93
         lPD7QAkbcNrYgHyDqz36ZDAeOBUnHA9RtLKgGQuH2fk1D/BE3CMDJivtbEWufyUGjhBv
         iXcMUDWU3ws79AkJvKfMK/RbUBnrSvmWmrkjlzEqLxLkc3POeijCwqs3vLTdnLOPzXqz
         BcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779102539; x=1779707339;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EdVqpBql5Gqkrx4EFtfutWcr864h1ZHzOOzFvQJojI=;
        b=gLLi4nh9ROvcpivJQQs5ZUXf80bWkfnFjuvfW+RktK4z3KBj2RIrdLSjnmWa8pgUfE
         dvfiz5x2qpvTY2Utk4iq5dXsr3wFSXubeT+iLnD158RmXLQR0CZOWSoSzbG1PoHsaeQA
         fGxMo6fsxPVrO+eH89PgqefdsdQBk8K3p3wQoZEMcI6gCFp6QdkueAFnfLJ7McYuaGy7
         bvE1ab5zOlwRpSPHlmi4nBlnS8p+dmD/ZCp9ns1kMyFASgfUo5rXwkKvp7bkqBA+ErLs
         nWTl3tWuD4VVcnNAUPj4qEW5LlL/hdHuxMvp08SUJaEzbV42NcNg5WLC5s08uRAdBlft
         Dp2A==
X-Forwarded-Encrypted: i=1; AFNElJ/uAMh6bdePLz7dP6cPIivq5DiPHXCCtgZnWdUquxLff2q/It1GvaYvzzbdxOVSuGZESyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynnIEBPsAV/neA1Otgcei5xL7/6qr9oXFTmX51sLSa/waPA6jN
	syxyvxxMDAp8eYGif9bmaakPg7j6Za/+fHF1TcnCJIQ/mZjTu/MaFeWKGpflLdITJ+tNs/DBu0U
	f0LMCTy7ovzYRCWPyCLNezfno6GTb6q8VUKmx4afr9Y4aHokC+4Lb+Q==
X-Gm-Gg: Acq92OEUbz0nIj/+C0ZIAIk9GP9e3PjsLuKyheBALmIKzH2BEj6fn0QBXWKVzmPV18l
	+E7B4gTPG9+Kt4T0P6zQJCI9+hI/ReZsMKSvzkIr/uWKVEJZoDbIokgp2F58wniklw8bUK9zC6F
	5/t7tCTMhzYCoxrC6fIdPiKiH0e/L+kXdFV/8pbZYtg2NE90nAPZN8e76+SR1C1Edbe9H/rVgpz
	SEZBLGCC9yHDMXVZW5uy6efVLGS4MPJ9uqABtKdniV+ph9xyGpktEOBhIT5YiKx6CCZz+xOCstB
	IEYsalOdHEIm7fmP3vUlV/Aeu6gowcZEQfNFqSab5rBAu3imF7WWpwPpv1w0mPDjCYMkPN6BI0C
	Bhic7pKP6RMdEOZ1pc5JjBzfTtL5CQpwOqqS5Pb+ys7EMw/ZzMIYiL4AqDmwpkUdrHXxjVCy6yQ
	==
X-Received: by 2002:a05:600c:848c:b0:487:2439:b7c8 with SMTP id 5b1f17b1804b1-48fe60e54cbmr219184875e9.1.1779102538863;
        Mon, 18 May 2026 04:08:58 -0700 (PDT)
X-Received: by 2002:a05:600c:848c:b0:487:2439:b7c8 with SMTP id 5b1f17b1804b1-48fe60e54cbmr219184145e9.1.1779102538164;
        Mon, 18 May 2026 04:08:58 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feb029180sm117425235e9.4.2026.05.18.04.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:08:57 -0700 (PDT)
Date: Mon, 18 May 2026 13:08:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, 
	Maher Azzouzi <maherazz04@gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb
 sends
Message-ID: <agrxFFkyvyB-kbvr@sgarzare-redhat>
References: <20260514092948.268720-1-sgarzare@redhat.com>
 <20260516125329.7b699c6f@pumpkin>
 <agrXvCtNRlySlwgx@sgarzare-redhat>
 <20260518053223-mutt-send-email-mst@kernel.org>
 <agrg1GVzoJWtNuSd@sgarzare-redhat>
 <20260518115005.5f13bd2b@pumpkin>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518115005.5f13bd2b@pumpkin>

On Mon, May 18, 2026 at 11:50:05AM +0100, David Laight wrote:
>On Mon, 18 May 2026 11:54:19 +0200
>Stefano Garzarella <sgarzare@redhat.com> wrote:
>
>> On Mon, May 18, 2026 at 05:33:08AM -0400, Michael S. Tsirkin wrote:
>> >On Mon, May 18, 2026 at 11:18:24AM +0200, Stefano Garzarella wrote:
>> >> On Sat, May 16, 2026 at 12:53:29PM +0100, David Laight wrote:
>> >> > On Thu, 14 May 2026 11:29:48 +0200
>> >> > Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >> >
>> >> > > From: Stefano Garzarella <sgarzare@redhat.com>
>> >> > >
>> >> > > When a large message is fragmented into multiple skbs, the zerocopy
>> >> > > uarg is only allocated and attached to the last skb in the loop.
>> >> > > Non-final skbs carry pinned user pages with no completion tracking,
>> >> > > so the kernel has no way to notify userspace when those pages are safe
>> >> > > to reuse. If the loop breaks early the uarg is never allocated at all,
>> >> > > leaking pinned pages with no completion notification.
>> >> > >
>> >> > > Fix this by following the approach used by TCP: allocate the zerocopy
>> >> > > uarg (if not provided by the caller) before the send loop and attach
>> >> > > it to every skb via skb_zcopy_set(), which takes a reference per skb.
>> >> > > Each skb's completion properly decrements the refcount, and the
>> >> > > notification only fires after the last skb is freed.
>> >> > > On failure, if no data was sent, the uarg is cleanly aborted via
>> >> > > net_zcopy_put_abort().
>> >> > >
>> >> > > This issue was initially discovered by sashiko while reviewing commit
>> >> > > 1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting")
>> >> > > but was pre-existing.
>> >> > >
>> >> > > Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>> >> > > Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> >> > > Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%40redhat.com
>> >> > > Reported-by: Maher Azzouzi <maherazz04@gmail.com>
>> >> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> >> > > ---
>> >> > >  net/vmw_vsock/virtio_transport_common.c | 83 ++++++++++---------------
>> >> > >  1 file changed, 34 insertions(+), 49 deletions(-)
>> >> > >
>> >> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> >> > > index 989cc252d3d3..1e3409d28164 100644
>> >> > > --- a/net/vmw_vsock/virtio_transport_common.c
>> >> > > +++ b/net/vmw_vsock/virtio_transport_common.c
>> >> > > @@ -70,34 +70,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>> >> > >  	return true;
>> >> > >  }
>> >> > >
>> >> > > -static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
>> >> > > -					   struct sk_buff *skb,
>> >> > > -					   struct msghdr *msg,
>> >> > > -					   size_t pkt_len,
>> >> > > -					   bool zerocopy)
>> >> > > -{
>> >> > > -	struct ubuf_info *uarg;
>> >> > > -
>> >> > > -	if (msg->msg_ubuf) {
>> >> > > -		uarg = msg->msg_ubuf;
>> >> > > -		net_zcopy_get(uarg);
>> >> > > -	} else {
>> >> > > -		struct ubuf_info_msgzc *uarg_zc;
>> >> > > -
>> >> > > -		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>> >> > > -					    pkt_len, NULL, false);
>> >> > > -		if (!uarg)
>> >> > > -			return -1;
>> >> > > -
>> >> > > -		uarg_zc = uarg_to_msgzc(uarg);
>> >> > > -		uarg_zc->zerocopy = zerocopy ? 1 : 0;
>> >> > > -	}
>> >> > > -
>> >> > > -	skb_zcopy_init(skb, uarg);
>> >> > > -
>> >> > > -	return 0;
>> >> > > -}
>> >> > > -
>> >> > >  static int virtio_transport_fill_skb(struct sk_buff *skb,
>> >> > >  				     struct virtio_vsock_pkt_info *info,
>> >> > >  				     size_t len,
>> >> > > @@ -317,8 +289,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>> >> > >  	u32 src_cid, src_port, dst_cid, dst_port;
>> >> > >  	const struct virtio_transport *t_ops;
>> >> > >  	struct virtio_vsock_sock *vvs;
>> >> > > +	struct ubuf_info *uarg = NULL;
>> >> > >  	u32 pkt_len = info->pkt_len;
>> >> > >  	bool can_zcopy = false;
>> >> > > +	bool have_uref = false;
>> >> > >  	u32 rest_len;
>> >> > >  	int ret;
>> >> > >
>> >> > > @@ -360,6 +334,25 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>> >> > >  		if (can_zcopy)
>> >> > >  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>> >> > >  					    (MAX_SKB_FRAGS * PAGE_SIZE));
>> >> > > +
>> >> > > +		if (info->msg->msg_flags & MSG_ZEROCOPY &&
>> >> > > +		    info->op == VIRTIO_VSOCK_OP_RW) {
>> >> > > +			uarg = info->msg->msg_ubuf;
>> >> > > +
>> >> > > +			if (!uarg) {
>> >> > > +				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>> >> > > +							    pkt_len, NULL, false);
>> >> > > +				if (!uarg) {
>> >> > > +					virtio_transport_put_credit(vvs, pkt_len);
>> >> > > +					return -ENOMEM;
>> >> > > +				}
>> >> > > +
>> >> > > +				if (!can_zcopy)
>> >> > > +					uarg_to_msgzc(uarg)->zerocopy = 0;
>> >> > > +
>> >> > > +				have_uref = true;
>> >> > > +			}
>> >> > > +		}
>> >> >
>> >> > Surely that block should only be done if can_zcopy is true?
>> >> > And shouldn't something unset it if info->op != VIRTIO_VSOCK_OP_RW ?
>> >> > If the msg_zerocopy_realloc() fails then can't you just set can_zcopy to false.
>> >> >
>> >> > It info->msg->msg_buf is already set then I think you have to disable zero-copy.
>> >> > The caller has already requested a callback - and you can't add another.
>> >> >
>> >> > In any case by the end of this can_zcopy and have_uref are really the same flag.
>> >>
>> >> I kept the same approach we had before, trying to make as few changes as
>> >> possible.
>> >>
>> >> All these potential issues seem to be pre-existing and should be eventually
>> >> addressed in other patches IMHO. This patch one only resolves the main issue
>> >> of calling `skb_zcopy_set()` for every skb to avoid leaking pages, etc.
>> >
>> >the patch is upstream now, right? So pretty much have to be patches on
>> >top.
>>
>> If those are actual issues, then yes. TBH, I didn’t look into that
>> aspect and left it as it was before. We should take a closer look at how
>> MSG_ZEROCOPY is handled.
>>
>> David, if you think it needs fixing and you have time, feel free to send
>> patches on top.
>
>I'm not fully sure how it all works.

Same here, so I pinged Arseniy who worked on that, since it seemed 
deliberate to have `can_zcopy` (and set `uarg->zerocopy` accordingly) 
only when it was supported by the transport.

>Especially the paths where msg->msg_ubuf is non-NULL, I suspect it should
>be added to all the skb even if the ZEROCOPY flag isn't set.
>I was just reading the one function.
>But there did look like some very dodgy conditionals.

I see, let's wait for Arseniy's feedback; otherwise, I'll try to fix it 
next week. As mentioned, this issue existed before this patch, so it 
shouldn't be a regression.

Thanks,
Stefano

