Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C663E63BA
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096799; cv=none; b=Tc+Fj2dwPSnhEr8ojXsyR0BDxsn2Hc2SNY3Dp6sr7zWNA1msm1rS+wGaAG02w0bNWbmiXZk2Nz+UkMXqCyqum6G33kQZCOoKqaUOVAQNld9WhhhlONoDS9fHMFT2B6XeB6ZhHMLz2E2AGt4VHs9OlFR1X++dUPe/URFeILyYDsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096799; c=relaxed/simple;
	bh=jSlre+l4xv2u3lht0ewJ63vmV7qP+xbiV5kD+x9/9jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyUD0rTODWkGHup5vy3m/zWQB+WwzXarHCHa8nKYhid0UXK/tZhk9eSB94VKzVBV14vQnNFEyVgzU1eS6SuoUzcm6rNYOZh0eZ4wHNraCiz8vLNc1ob654lXVlSu5e9ZkJaf4wzAo7By/5VqoO4JtN3mdty0fw/YDC7yX9rnH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zf12pRr/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cJ9EzcEb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zf12pRr/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJ9EzcEb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779096796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/rMc/AxTWnfe6rPr4aOrLy+F5Zu/TWf0k5shSHIhIko=;
	b=Zf12pRr/E1fin2NIN3w/Xg376YkH7Lyd1dQkdvRCqyn+K+CXb7OgVmTCn8l0O56oPtuFfU
	jZ/SmfLwKPTa91FYgAt1maU8R4jMnST/Q4zmuAatKrx+oIohvrfgb9D3H1MfffK0jcCGGV
	RqiAWtkkgcOrxxROMkTmQwQsuwLH7E4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-EShOSTDCM6KObDgulQPGKg-1; Mon, 18 May 2026 05:33:14 -0400
X-MC-Unique: EShOSTDCM6KObDgulQPGKg-1
X-Mimecast-MFC-AGG-ID: EShOSTDCM6KObDgulQPGKg_1779096793
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d7a5b9678so1301976f8f.2
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 02:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779096793; x=1779701593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rMc/AxTWnfe6rPr4aOrLy+F5Zu/TWf0k5shSHIhIko=;
        b=cJ9EzcEbqft16LRCVOblEHlFhqd6dFMM0L00aCOKdX+l+fN6L1YT3ipc041q5f9gm5
         IIzcXTQHUrfOqyMWabOchDC/00Mdnes3DQoU2Sujp4/Gn23Q1z2eYtvNq/p/IkHIQcTH
         XYEWygRp5Cfytu9pHUyHJ1MVbG5pR8qV9gfnUHXcfyED/XGXtM+CDbD/wZAEJAXZlc9U
         sCGIZgAcJIBFHuRI+m6qeDaVvW3eX6h0DLN8zq54hlIDC1tYnpRO2ok1NFLJSBJ82E5w
         X67CbTOGYHbriz8T6kf5LfQNeB+yugk7QBmc/iuPAZSmBFZV8i7ILUKx6NHTnZJCGFU0
         cSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779096793; x=1779701593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rMc/AxTWnfe6rPr4aOrLy+F5Zu/TWf0k5shSHIhIko=;
        b=jdcwun+8fesDb1cv723IElXeeZaKZ91BNbc7jp2nHqMTRXwXYmPraR9HOLiTrVr/cx
         TmL89ytVFr+OVTIofNurMH3By88/K3Qh7J6cru1z+3x2VAKLxFoyoYm5Lo0PJg7TvrH8
         Id4hQ1DV9GkvZFNN8ejQGHWGzSMxd+IOEB8Dnl6AHaau2vDnfwnstuaQT9ji6SRSWqwB
         iIcCH4GPAjqsxOtE+g0qe8LGZQd9J66BbTL97Q/xoh1rUVMe2QcpRMmDSUl80/Cdd8Er
         xAGBrgzB3VQtxeRF9bT4hj3/5+UP9eM0xxR9DlZn3E3cb9uu+U1UyOYJE7/qpD/7lTjS
         B0lg==
X-Forwarded-Encrypted: i=1; AFNElJ9+wrnGhscR8R/zKlJNT7LA7CDqCT8R6s5wrOSa4K0lHFBcLAmPe8oddI5P6hPfC4LrO54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBT1I2PPfa4IJQTI73rWKVnsEUAklChfdw33RVq1lfYXo72sTw
	NUW/Hs38UaHwf0m7YZuh30ge0y+lq/hnrPBraola5omGrzg3mU23XS36i4q7OkvYLTisezBnYp1
	fQmm/ntFhjpq46MrtJ2QFg4fGk5NJTx+b98I4XDZ4johpAeW9Rm6sVA==
X-Gm-Gg: Acq92OHfqVW2wYulc+RC+8wOt/Uy30Pw1FxfkabDo6ysKqXcG4x/uQAAiJyGb9+296E
	fLrRnu7bf9BXGqSWQH+xpDXaicYE0jsWAcPHrTr46L89UtYbgW4bUntznIfcCG8g/JFhrReEPqN
	mtbKAS2XOidfSqvKbfjZlOcdqNBmWj3wBHmvOci6wj+1C62hGkFitaTEvLxprvL1OJmC03+jAgu
	ESviuB8oKrrflLMHZsII0gVg1Fxk1wC7gXnzQFiJhnVaivdaa9y/DgELDH1w36ysR1sH9a/6ZwC
	WLZJU4yNx77BvwONw1DK8Xr0k1kgVR99OnPF9uHhe69KQ9O3cO9FGueMnhpvBrkFOHLkzFSLUur
	ojIvLB8/wXUhkf/4obLDFzv3rQoS/EDCqmATiH0j8
X-Received: by 2002:a05:600c:a406:b0:48f:e230:1d12 with SMTP id 5b1f17b1804b1-48fe6329913mr173599005e9.31.1779096792665;
        Mon, 18 May 2026 02:33:12 -0700 (PDT)
X-Received: by 2002:a05:600c:a406:b0:48f:e230:1d12 with SMTP id 5b1f17b1804b1-48fe6329913mr173598345e9.31.1779096792146;
        Mon, 18 May 2026 02:33:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe5bc94sm140342335e9.4.2026.05.18.02.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:33:11 -0700 (PDT)
Date: Mon, 18 May 2026 05:33:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
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
Message-ID: <20260518053223-mutt-send-email-mst@kernel.org>
References: <20260514092948.268720-1-sgarzare@redhat.com>
 <20260516125329.7b699c6f@pumpkin>
 <agrXvCtNRlySlwgx@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agrXvCtNRlySlwgx@sgarzare-redhat>

On Mon, May 18, 2026 at 11:18:24AM +0200, Stefano Garzarella wrote:
> On Sat, May 16, 2026 at 12:53:29PM +0100, David Laight wrote:
> > On Thu, 14 May 2026 11:29:48 +0200
> > Stefano Garzarella <sgarzare@redhat.com> wrote:
> > 
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > 
> > > When a large message is fragmented into multiple skbs, the zerocopy
> > > uarg is only allocated and attached to the last skb in the loop.
> > > Non-final skbs carry pinned user pages with no completion tracking,
> > > so the kernel has no way to notify userspace when those pages are safe
> > > to reuse. If the loop breaks early the uarg is never allocated at all,
> > > leaking pinned pages with no completion notification.
> > > 
> > > Fix this by following the approach used by TCP: allocate the zerocopy
> > > uarg (if not provided by the caller) before the send loop and attach
> > > it to every skb via skb_zcopy_set(), which takes a reference per skb.
> > > Each skb's completion properly decrements the refcount, and the
> > > notification only fires after the last skb is freed.
> > > On failure, if no data was sent, the uarg is cleanly aborted via
> > > net_zcopy_put_abort().
> > > 
> > > This issue was initially discovered by sashiko while reviewing commit
> > > 1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting")
> > > but was pre-existing.
> > > 
> > > Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> > > Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>
> > > Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%40redhat.com
> > > Reported-by: Maher Azzouzi <maherazz04@gmail.com>
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > >  net/vmw_vsock/virtio_transport_common.c | 83 ++++++++++---------------
> > >  1 file changed, 34 insertions(+), 49 deletions(-)
> > > 
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index 989cc252d3d3..1e3409d28164 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -70,34 +70,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
> > >  	return true;
> > >  }
> > > 
> > > -static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
> > > -					   struct sk_buff *skb,
> > > -					   struct msghdr *msg,
> > > -					   size_t pkt_len,
> > > -					   bool zerocopy)
> > > -{
> > > -	struct ubuf_info *uarg;
> > > -
> > > -	if (msg->msg_ubuf) {
> > > -		uarg = msg->msg_ubuf;
> > > -		net_zcopy_get(uarg);
> > > -	} else {
> > > -		struct ubuf_info_msgzc *uarg_zc;
> > > -
> > > -		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> > > -					    pkt_len, NULL, false);
> > > -		if (!uarg)
> > > -			return -1;
> > > -
> > > -		uarg_zc = uarg_to_msgzc(uarg);
> > > -		uarg_zc->zerocopy = zerocopy ? 1 : 0;
> > > -	}
> > > -
> > > -	skb_zcopy_init(skb, uarg);
> > > -
> > > -	return 0;
> > > -}
> > > -
> > >  static int virtio_transport_fill_skb(struct sk_buff *skb,
> > >  				     struct virtio_vsock_pkt_info *info,
> > >  				     size_t len,
> > > @@ -317,8 +289,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > >  	u32 src_cid, src_port, dst_cid, dst_port;
> > >  	const struct virtio_transport *t_ops;
> > >  	struct virtio_vsock_sock *vvs;
> > > +	struct ubuf_info *uarg = NULL;
> > >  	u32 pkt_len = info->pkt_len;
> > >  	bool can_zcopy = false;
> > > +	bool have_uref = false;
> > >  	u32 rest_len;
> > >  	int ret;
> > > 
> > > @@ -360,6 +334,25 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > >  		if (can_zcopy)
> > >  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
> > >  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> > > +
> > > +		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> > > +		    info->op == VIRTIO_VSOCK_OP_RW) {
> > > +			uarg = info->msg->msg_ubuf;
> > > +
> > > +			if (!uarg) {
> > > +				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> > > +							    pkt_len, NULL, false);
> > > +				if (!uarg) {
> > > +					virtio_transport_put_credit(vvs, pkt_len);
> > > +					return -ENOMEM;
> > > +				}
> > > +
> > > +				if (!can_zcopy)
> > > +					uarg_to_msgzc(uarg)->zerocopy = 0;
> > > +
> > > +				have_uref = true;
> > > +			}
> > > +		}
> > 
> > Surely that block should only be done if can_zcopy is true?
> > And shouldn't something unset it if info->op != VIRTIO_VSOCK_OP_RW ?
> > If the msg_zerocopy_realloc() fails then can't you just set can_zcopy to false.
> > 
> > It info->msg->msg_buf is already set then I think you have to disable zero-copy.
> > The caller has already requested a callback - and you can't add another.
> > 
> > In any case by the end of this can_zcopy and have_uref are really the same flag.
> 
> I kept the same approach we had before, trying to make as few changes as
> possible.
> 
> All these potential issues seem to be pre-existing and should be eventually
> addressed in other patches IMHO. This patch one only resolves the main issue
> of calling `skb_zcopy_set()` for every skb to avoid leaking pages, etc.

the patch is upstream now, right? So pretty much have to be patches on
top.

> @Arseniy can you help on this?
> 
> > 
> > >  	}
> > > 
> > >  	rest_len = pkt_len;
> > > @@ -378,27 +371,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > >  			break;
> > >  		}
> > > 
> > > -		/* We process buffer part by part, allocating skb on
> > > -		 * each iteration. If this is last skb for this buffer
> > > -		 * and MSG_ZEROCOPY mode is in use - we must allocate
> > > -		 * completion for the current syscall.
> > > -		 *
> > > -		 * Pass pkt_len because msg iter is already consumed
> > > -		 * by virtio_transport_fill_skb(), so iter->count
> > > -		 * can not be used for RLIMIT_MEMLOCK pinned-pages
> > > -		 * accounting done by msg_zerocopy_realloc().
> > > -		 */
> > > -		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
> > > -		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
> > > -			if (virtio_transport_init_zcopy_skb(vsk, skb,
> > > -							    info->msg,
> > > -							    pkt_len,
> > > -							    can_zcopy)) {
> > > -				kfree_skb(skb);
> > > -				ret = -ENOMEM;
> > > -				break;
> > > -			}
> > > -		}
> > > +		skb_zcopy_set(skb, uarg, NULL);
> > > 
> > >  		virtio_transport_inc_tx_pkt(vvs, skb);
> > > 
> > > @@ -422,6 +395,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > > 
> > >  	virtio_transport_put_credit(vvs, rest_len);
> > > 
> > > +	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
> > > +	 * skb_zcopy_set() increases it for each skb, so we can drop that
> >                                                            ^ must
> > 
> > > +	 * initial reference to keep it balanced.
> > > +	 */
> > > +	if (have_uref) {
> > > +		if (rest_len == pkt_len)
> > > +			/* No data sent, abort the notification. */
> > > +			net_zcopy_put_abort(uarg, true);
> > 
> > Is it worth optimising for the 'nothing sent' case ?
> 
> What do you suggest doing?
> 
> I followed what TCP does.
> 
> Thanks,
> Stefano
> 
> > 
> > -- David
> > 
> > > +		else
> > > +			net_zcopy_put(uarg);
> > > +	}
> > > +
> > >  	/* Return number of bytes, if any data has been sent. */
> > >  	if (rest_len != pkt_len)
> > >  		ret = pkt_len - rest_len;
> > 

