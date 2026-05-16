Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD073D649F
	for <kvm@vger.kernel.org>; Sat, 16 May 2026 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778932415; cv=none; b=h3MXb756DfGAk1v70HoOT0cXeC/gnAO3ynnCFmhecQDWtTkXOJlBQYABfQ3DHokhZOLB8QJ99n029Q94SvvojZH3sWUgylRIPpt1afhGn55W58M70geGVUN54PmR6vseICUiM/xhEZ17WFNPUYSG8koR0a9hxEeuT60IJyAXeiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778932415; c=relaxed/simple;
	bh=F7j14MGWg5MpaTs46ixVgM5+KDomqLpuWcEipt69nvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNwlwEpWKDuZIcTpM7pcmmy1KZJdh6HXBdLSJVg8mfN01nnscrQrqm+aQaawOrE/M8AfcJ/p2syrxzbqBj+EHg6KxI7V8QWSCFCVpPHCcsfr0577wBldQhqxMb9SEGyZXWIQXBY3XjG2olxlyWo1cBSJguOt2owrhyzA8xXctTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTwzhsR5; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTwzhsR5"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ae6a0e523so302154f8f.1
        for <kvm@vger.kernel.org>; Sat, 16 May 2026 04:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778932412; x=1779537212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMsYPxsGdmOZu2bUf9upWSruFK/hZRv7KGPN8jXsIdE=;
        b=TTwzhsR5nBzuTE33a4WAvIiwr/EV+I1TVkybF8WTUoYUierI7qMv6v9zrehsSQ6eIS
         d5J7nnW80F8TPiYRlB5IG4XsvHMyNuAK4pL00yBRNxIrAtHgkCK0foHx1jqkDCKmQ9Fd
         O7faNAbFNfs/TBuMmiIfnSixME52ODqs2ofPDOSn645g0Mn9fnUV+qkNlilsig2TMYC+
         VpXjTRaJXZKGPkEntwW+XZGUYb7x0UESFJlrCY0jdA74Kvt/qZ0EpHz5e+RNp3Ec5cMW
         ZIiS7nf/w0Ks9GI2EsN9wn8Hbr7UBgOslrM7Yfyh1qTf/IYHk6lAP0pKdgklS7VlZ3di
         u9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778932412; x=1779537212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GMsYPxsGdmOZu2bUf9upWSruFK/hZRv7KGPN8jXsIdE=;
        b=iDooY+7YkUVrED+lmqLmuU2k4bezuE9QvtgLjZVKV5bTKXzoF8rBaRo8HKdi43Vymu
         c9F0P+PLmjBX1dbsayCsW84Otfsm+zqBntVdfSl1AQcGLVpk4BrMCQwvRJ7tv5psF4qr
         N1sQVHx15dOuoKa/ybfiu7XSuEL0XRTZ6onF38gzrdqkpJzT1OeZ0FGFbLE1NjNwixng
         b5X2SWmDkybx9kMPt8V6w48xMy/xLwL5F+4eJwlpkVPYOUuaqY3t0MyNo+b3OcYS3LoQ
         KwdEXQzl/+Orhqn3nMxqn4SCUKNjkSJT9B63c1rvDlu+oYSQlnFKZYSJqrLKeD+KkcEm
         u4RQ==
X-Forwarded-Encrypted: i=1; AFNElJ+FFyOc89hFJZVW7vaIpGdd+fp0ocQlFVwgE/mrHe9GMO+dpWyF6IG2QtiHwOKx7nJ+F/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6SkRN9aglSlVxIFbi5sw3PhksG4Vab/QXPG7XtseYL0mPY4pq
	Xeyyq4KaF4INun+2sNh2knJh0m1OCIRSqaJty5GAojPCOLJv5VW8XOUV
X-Gm-Gg: Acq92OEKCcEjppG4GlfaUoCoqNc7/RcMmhJv6h7Qo1fcmh7ijz4LgvcPqXicmS7OyiM
	QXMOtxuLjKShejVuwAiwVI74gNcHTtgskdWPryzDiPfgCqCCyLJsGhqF2jSAqRMiflnqqf4lP2+
	bkZb8iG1kwQa0yhfcaHDBbHYkhL/hwwUNeM2mMdBy9HoTv355XBpxae3/5pa8TJhwLugSbfo4K/
	wiGa5XpxG/QXOWWKvf9UTCMdW/5x1W62MzWHVHEQloiR0tBU/WV3WSUFEaFAH0u43PB4MOrTP/o
	Zvkuv2gZxoczJj7r4dvUsZbeSI8tHeJWNC3zQHytL83ufQstjP04WZtRgohoDLl4mUfXdBMENTR
	nLOrWgF3UFP042dEIzuu5JvLydFH7r9h66LlMXaHcSuVI6NoGKL2YjPJjamhC9WtUMsAkH/X3pU
	hg8pCq9BknOTS/NE3DLz7ePZ+naBWfe7GeipUT1IGHelabSlorReb1l/gHyBmN
X-Received: by 2002:a05:6000:288e:b0:45d:7bf0:c7d3 with SMTP id ffacd0b85a97d-45e5c37122emr10808299f8f.19.1778932411691;
        Sat, 16 May 2026 04:53:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm22250671f8f.34.2026.05.16.04.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 04:53:31 -0700 (PDT)
Date: Sat, 16 May 2026 12:53:29 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Arseniy Krasnov
 <avkrasnov@salutedevices.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
 Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, Maher
 Azzouzi <maherazz04@gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb
 sends
Message-ID: <20260516125329.7b699c6f@pumpkin>
In-Reply-To: <20260514092948.268720-1-sgarzare@redhat.com>
References: <20260514092948.268720-1-sgarzare@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 11:29:48 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

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

Surely that block should only be done if can_zcopy is true?
And shouldn't something unset it if info->op != VIRTIO_VSOCK_OP_RW ?
If the msg_zerocopy_realloc() fails then can't you just set can_zcopy to false.

It info->msg->msg_buf is already set then I think you have to disable zero-copy.
The caller has already requested a callback - and you can't add another.

In any case by the end of this can_zcopy and have_uref are really the same flag.

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
                                                            ^ must

> +	 * initial reference to keep it balanced.
> +	 */
> +	if (have_uref) {
> +		if (rest_len == pkt_len)
> +			/* No data sent, abort the notification. */
> +			net_zcopy_put_abort(uarg, true);

Is it worth optimising for the 'nothing sent' case ?

-- David

> +		else
> +			net_zcopy_put(uarg);
> +	}
> +
>  	/* Return number of bytes, if any data has been sent. */
>  	if (rest_len != pkt_len)
>  		ret = pkt_len - rest_len;

