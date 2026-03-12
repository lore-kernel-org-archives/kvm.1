Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ECD347BD7
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323701; cv=none; b=r+1skBBKq7yPeMi6ZICJzI8tLzbZ6anO6Bo9IyHwxKb6+qe4rRMWrebc53VvfcSGMaLZKw++HdCveODZ8TlY+cj1UqG8wkrjgBN5tqAAoSRreR/0RRNJG7BELv2fG5lg5bSQOoP0o0I84f16ClaryL+Fm36Bhow7cc31dqOZz5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323701; c=relaxed/simple;
	bh=SpNehQ1QB2agnleumLY4gSLmRt7ah7+esaG/GMysUtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdYNAlNq03Xn/lNMWit7H9quoRTn29SddTXrXWff3smQva2zR+zQEXPFEkQPZWSPajeS9as7iZGywq2FTag7UbwdpthcgPAsN7dEFh9Wwe1jNgwc49UXSAAZnGSF6Jok2F9oWTc/MXNCr6egRRx4WQNHL4txG3ugbGatFDB9HOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dx/VhrYD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mot1zpvR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dx/VhrYD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mot1zpvR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773323698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iz0EqyWTioqt5QKyYbfa8QuFQclbTzyA/mBVntajMyE=;
	b=Dx/VhrYDdaKFnj3ex906otzBg3BV/+QyTLpiM89lmZ+Pgat+j0eWmGlV124uAunhV/I3+Y
	vJCApbzMJGPz+Zo98IbRgOGKSbJnJSVx9rYHK0IvSzb0ITn9DAv+BC/CxqMj3ULpPC1rEB
	fLSMaaktQTVwjzwPMV7wGypWR9SmclM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619--kJJeh-RNuuPAULbfY54hg-1; Thu, 12 Mar 2026 09:54:55 -0400
X-MC-Unique: -kJJeh-RNuuPAULbfY54hg-1
X-Mimecast-MFC-AGG-ID: -kJJeh-RNuuPAULbfY54hg_1773323694
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439c794ec8eso1205191f8f.1
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 06:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773323694; x=1773928494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iz0EqyWTioqt5QKyYbfa8QuFQclbTzyA/mBVntajMyE=;
        b=Mot1zpvRI5BvN0arffYqIahGxGrUbQJeKSmXTyKapgRCy74Z0x/3sf+L0g8Oa1XwC8
         vbHHkWBiOjh3IhTmXePAFjPnGrMvPMBtYMwBFQutyMaTOL8ll+UEycV4PL98Y1x0mZko
         uxv7YWfQVGcMqXipitd8nHYIQxCNQoM2c/yNCXh6VOFehaIChx6RDF1P1AmSCbwYsBK7
         40WjBCGQoCu/CRKg75prf5Q0Ysczpr5bAXr9Tv9WUSis881nw0OB3ithV/sQee2DoClC
         hIUTpkkx6gGMEUqRoyeOFVsMAflRQKEo/LxLj8YjE5uHKkxghnQh8RUomaTiADXGTf70
         BbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773323694; x=1773928494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iz0EqyWTioqt5QKyYbfa8QuFQclbTzyA/mBVntajMyE=;
        b=ksaDDa0wX0w2xBghywmafMHlBKr3xCWlqeKyzkrBhIETEF/mhnvGcdoIZr8KUb8DU+
         KXKRxfJ8K0j4vgXPsFxOcx7DUlstjYxaS5OUkbWD/zrsL+Ocfw8HgRfJyRzYF1qlkjWL
         3CPF5cSFjGp6QCesFNGVXjikNTYTSDHII990kHohCE5CrGYtNUvlRTGj4ft/u02p1Lk0
         DOSsMVdWIlPnRJ5dm6nJ6R4JTSOd2g3OGaYkY9VruPWMP+hoxHBB3ukP7bbMIO5S+dQc
         Vkebiw16b017WsP/ThtjHIKfIpZV3KNFV1alTgNHR+EjjCuNVKErPwZ2lyWSNuxgWEw/
         cD5g==
X-Forwarded-Encrypted: i=1; AJvYcCUfNxdNLmAOHu1mmoN3pWWRJ4yLJFvrcg7lcjJB5pK1FIRPAcIL7az0SFQ6no9iDo6gYyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7AacaxKzJB/tBghdTIKOtcFyhLHdA3FPqFmHxX1ccLl1KPwiQ
	VZhnOx+4R05RsiVNcKz5iWxyc/Y1TUELpAPzcl/tvyelWFpq6acQF+sPMqus37/I2UsxkvbwYs+
	KKSy8CXpFyfFjuzgNtzSecJNI7JQv5C7euXpnJ5YcqvtwtsWaQD6Srg==
X-Gm-Gg: ATEYQzwG9DAbWmviM3U4r9udj0iO+9/M8kWFFIya9hNh2RJhRLBJLW5fDs0YeRxJLmx
	PBfWDheQ73ZoeqTP1xrl9b37p8o8GqbVxMs2Tf0NjhPJZsxRctcKJGpmhZOKAspcFbMMUrDhQB1
	Jr4azpn7xmYDoE4aK2H4tBZPwBVzlVWoXF10MGvpHa8vYYplZ17mODMBKNb7XLREG8wcnJbrqwJ
	qt5bHuiU341ODpEZ7ihrDq00VVwwin561XBU73vSEKoY2a9vRnSkNKmLggYbxpFESwknI/K2mfJ
	oBN1jOz+gpIkP2nI1haIvYLZY6nBVVkLXiTIDvDZPgNm/tsg2lUIzpOElgimZBPi3+LOmmk/2qp
	fdqL1x/982kjsvLO0lQcvX9Kl9kDBOTpezKjchTPujLURxw==
X-Received: by 2002:a05:6000:2f86:b0:439:abfb:6d34 with SMTP id ffacd0b85a97d-439f84359d8mr11303240f8f.50.1773323694247;
        Thu, 12 Mar 2026 06:54:54 -0700 (PDT)
X-Received: by 2002:a05:6000:2f86:b0:439:abfb:6d34 with SMTP id ffacd0b85a97d-439f84359d8mr11303176f8f.50.1773323693676;
        Thu, 12 Mar 2026 06:54:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm7866593f8f.31.2026.03.12.06.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:54:53 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:54:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v8 2/4] vhost-net: wake queue of tun/tap after
 ptr_ring consume
Message-ID: <20260312095227-mutt-send-email-mst@kernel.org>
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312130639.138988-3-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312130639.138988-3-simon.schippers@tu-dortmund.de>

On Thu, Mar 12, 2026 at 02:06:37PM +0100, Simon Schippers wrote:
> Add tun_wake_queue() to tun.c and export it for use by vhost-net. The
> function validates that the file belongs to a tun/tap device,
> dereferences the tun_struct under RCU, and delegates to
> __tun_wake_queue().
> 
> vhost_net_buf_produce() now calls tun_wake_queue() after a successful
> batched consume of the ring to allow the netdev subqueue to be woken up.

A sentence missing here:
the point is to allow queue to be stopped when it gets full,
which is required for traffic shaping - implemented
by the following
"avoid ptr_ring tail-drop when a qdisc is present"




> Without the corresponding queue stopping (introduced in a subsequent
> commit), this patch alone causes a slight throughput regression for a
> tap+vhost-net setup sending to a qemu VM:
> 3.948 Mpps to 3.888 Mpps (-1.5%).
> 
> Details: AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU
> threads, XDP drop program active in VM, pktgen sender; Avg over
> 20 runs @ 100,000,000 packets. SRSO and spectre v2 mitigations disabled.
>


 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c      | 21 +++++++++++++++++++++
>  drivers/vhost/net.c    | 15 +++++++++++----
>  include/linux/if_tun.h |  3 +++
>  3 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index a82d665dab5f..b86582cc6cb6 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3760,6 +3760,27 @@ struct ptr_ring *tun_get_tx_ring(struct file *file)
>  }
>  EXPORT_SYMBOL_GPL(tun_get_tx_ring);
>  
> +void tun_wake_queue(struct file *file)
> +{
> +	struct tun_file *tfile;
> +	struct tun_struct *tun;
> +
> +	if (file->f_op != &tun_fops)
> +		return;
> +	tfile = file->private_data;
> +	if (!tfile)
> +		return;
> +
> +	rcu_read_lock();
> +
> +	tun = rcu_dereference(tfile->tun);
> +	if (tun)
> +		__tun_wake_queue(tun, tfile);
> +
> +	rcu_read_unlock();
> +}
> +EXPORT_SYMBOL_GPL(tun_wake_queue);
> +
>  module_init(tun_init);
>  module_exit(tun_cleanup);
>  MODULE_DESCRIPTION(DRV_DESCRIPTION);
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 80965181920c..c8ef804ef28c 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -176,13 +176,19 @@ static void *vhost_net_buf_consume(struct vhost_net_buf *rxq)
>  	return ret;
>  }
>  
> -static int vhost_net_buf_produce(struct vhost_net_virtqueue *nvq)
> +static int vhost_net_buf_produce(struct sock *sk,
> +				 struct vhost_net_virtqueue *nvq)
>  {
> +	struct file *file = sk->sk_socket->file;
>  	struct vhost_net_buf *rxq = &nvq->rxq;
>  
>  	rxq->head = 0;
>  	rxq->tail = ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
>  					      VHOST_NET_BATCH);
> +
> +	if (rxq->tail)
> +		tun_wake_queue(file);
> +
>  	return rxq->tail;
>  }
>  
> @@ -209,14 +215,15 @@ static int vhost_net_buf_peek_len(void *ptr)
>  	return __skb_array_len_with_tag(ptr);
>  }
>  
> -static int vhost_net_buf_peek(struct vhost_net_virtqueue *nvq)
> +static int vhost_net_buf_peek(struct sock *sk,
> +			      struct vhost_net_virtqueue *nvq)
>  {
>  	struct vhost_net_buf *rxq = &nvq->rxq;
>  
>  	if (!vhost_net_buf_is_empty(rxq))
>  		goto out;
>  
> -	if (!vhost_net_buf_produce(nvq))
> +	if (!vhost_net_buf_produce(sk, nvq))
>  		return 0;
>  
>  out:
> @@ -995,7 +1002,7 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
>  	unsigned long flags;
>  
>  	if (rvq->rx_ring)
> -		return vhost_net_buf_peek(rvq);
> +		return vhost_net_buf_peek(sk, rvq);
>  
>  	spin_lock_irqsave(&sk->sk_receive_queue.lock, flags);
>  	head = skb_peek(&sk->sk_receive_queue);
> diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
> index 80166eb62f41..ab3b4ebca059 100644
> --- a/include/linux/if_tun.h
> +++ b/include/linux/if_tun.h
> @@ -22,6 +22,7 @@ struct tun_msg_ctl {
>  #if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
>  struct socket *tun_get_socket(struct file *);
>  struct ptr_ring *tun_get_tx_ring(struct file *file);
> +void tun_wake_queue(struct file *file);
>  
>  static inline bool tun_is_xdp_frame(void *ptr)
>  {
> @@ -55,6 +56,8 @@ static inline struct ptr_ring *tun_get_tx_ring(struct file *f)
>  	return ERR_PTR(-EINVAL);
>  }
>  
> +static inline void tun_wake_queue(struct file *f) {}
> +
>  static inline bool tun_is_xdp_frame(void *ptr)
>  {
>  	return false;
> -- 
> 2.43.0

