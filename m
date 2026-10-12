Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AED4756D2
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791843474; cv=none; b=YgIJZDxm2kp7vajjkJRfJD5QUT+s+sl/RwQ47MYg3LOOWgdPByRcfOGRBjlqxK1VV1+z2QlqbCc4ZiUP1MtlS3lXMDZoFQhzgWXnvm6F1WlBIwbL2EcejY5kXnCUumIkp45t/2NiJQVJwDlHrZYkBAVJtKZYJpyqChOXnIkdgtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791843474; c=relaxed/simple;
	bh=gtoYvpUKjEumvZ9NZ4lgt37kt3RngiiSW4yRL0iX9gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WurRSSBNQkC/stULM6ZXqQGEMLtGFoLGGhlnGqAprX0lRiyvu9WpHSeeREcHVuRwntwKrbHNr4XGy+JhSqRdE5rM0sGQw+kLIueZdWbYUrmltZCGGUNAJk2dS9jb3FC9xQYO7qgIpo61y33y/e7X4IizSz57GO1S3IeafXsEBVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWCc2IaL; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWCc2IaL"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-49e09a20082so1278033fac.2
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791843470; x=1792448270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F68EtWrkn2Wfb2ayNm/k6SKK8v3U+BQEExnVnz6byuA=;
        b=bWCc2IaLK/o6qI6vwYEcjeSWIN/rJxd/dA8grzptulSuyQkLJPWLsEq2PVfJXYkzff
         4/WXVFnxjeAqHjMhBdISQmi/XpbC7vOX4VzgH+4u9+YCYXwRc04/MLsi+gBYyp47zQ9p
         8aSOH85jehAI4xJ794cE+yZdI73PzLMg8WYugz1QRb3sXzSmQ7o/3GNJuqF8qWmxggSH
         oGzI6aAkXxYliEdgDY4Ad4DlmjD1M0ZNQLTc0ARnaxxdTAEREMo3m1e0jITD8ZIkXGnd
         KeOLu53fZKqNbmQ8eVfzhDfvgLkRlky//SB8K7aMsfjEfu3Sd054dIjM4sJZ3mZ1tQGo
         iEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791843470; x=1792448270;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F68EtWrkn2Wfb2ayNm/k6SKK8v3U+BQEExnVnz6byuA=;
        b=p/vodzeObSEwXUM5XwbycUmk3dcM0uJNJFdRYjrLtRoooND8+rlih+hWGZAUIRaneZ
         9JP47rzZn5mCK5j0Ih5nol7sZNjAAi0YqO/k3sRs7wvQ0yswavcef3wQ8gZS+Asw/w1x
         9d+jeY8s9SkGoatPtyWraP2LB3B3dYoVw6a9qrY55W0BgJeJSApbTLLocjJygHdfGiLP
         CY0b+9NPvEd3mxT/tCxmygbXs2MKO0GUqCcUL4PRCT5f3Cj1qhwzRLDu3zOs/9acMTXK
         42EEa7WxR3jOchz8L8mZdTcZf0X3/CZmUBvOdxrf83G0n0yuf1I+9G67hgrUuXk6dby7
         FyVQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4Wgj7RwZL2K4JyWN0R72HJP/BTcE/VA181j+56tTkQeaxKZZASI8hFkR3p7LUT4GdZQ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQSZptmHtRsQwFl6V1ciBQOdLaXBatYfliJ290DQF/3+tJ2i/t
	4H+bn20vP29cIk8h848B4SvlyN16gdEQpXsXyLHz3sVlXjOt/Hnr8QWN
X-Gm-Gg: AYBFou0DjVj1Nd4XW+g8u/n6AQUOlRmCWQlULERf1rUtoeJ/apmcyHNgpBdBaPSetnz
	3vZX8noP8Z0q1zSA6z/HDCvuNGNRy/397RtT1ysl/22WbTomrD56NLZGLa3QtMPJh3jaRTUtEq8
	f1Ttyw3bu3gI6Lmpw2UeVP9avjBrjapNfgxhWIYyiScnZCWqUf2e6IRbsY7l7OAMzg5V7L/mmZO
	Wp+aTFoWpAu5HjpVCVcE3tfTCJ226BG1o6VfMMlyZ+pnnzxHHeDGyt6uKPTHa7Wl532+lpBhwRn
	ElRlY5sYcMX3F19JFb95c3Y57HDf6alOAMQ6iE1IP5LV6D+Hx8H64Rl4khJRAtjS+tRxho1f3Kx
	mD0jklSHnhAlymyXD8KfB4qAk3XoAzWgVC18kmAq4CQxDrcMwYsDcUeEGEoPxCqMLtuQ84u3kuq
	0JF+t+AXBvMGCBlZgg7s9u6Ps/tBJm+1YzH0FDWpZb3Y0+f34hUYOdnVG7Dr48ibT4l19LToSGW
	4gDyVIgKAsEFNx71fO0
X-Received: by 2002:a05:6870:c213:b0:448:a3d6:c2d2 with SMTP id 586e51a60fabf-4a2a8955927mr10013926fac.10.1791843470199;
        Mon, 12 Oct 2026 15:17:50 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a85edf81sm10977018fac.15.2026.10.12.15.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 15:17:48 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:17:45 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/5] vsock/virtio: reuse same-flow socket
 lookup in RX batches
Message-ID: <as1ciTHT2O40E/Uq@devvm29614.prn0.facebook.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-4-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010142247.99223-4-physicalmtea@gmail.com>

On Sat, Oct 10, 2026 at 10:22:45PM +0800, Jia Jia wrote:
> An RX lock batch still looks up the socket for every packet and takes a
> temporary lookup reference, even though the batch already holds a reference
> to the locked socket.
> 
> Record the network namespace and packet address tuple when a batch starts.
> Reuse the batch socket for later STREAM/RW packets with the same tuple, and
> release the batch before looking up a different flow.
> 
> The cached path still traces every packet, takes an skb owner reference,
> validates socket state, source and transport, updates credit, and runs the
> receive state machine. Only the socket table lookup and its temporary
> reference are skipped.
> 
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  include/linux/virtio_vsock.h            |  3 ++
>  net/vmw_vsock/virtio_transport_common.c | 58 +++++++++++++++----------
>  2 files changed, 38 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index 26dde6909c4e..d6528681e052 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -287,6 +287,9 @@ struct virtio_transport_rx_batch {
>  	struct sock *sk;
>  	unsigned int pkts;
>  	size_t bytes;
> +	struct net *net;
> +	struct sockaddr_vm src;
> +	struct sockaddr_vm dst;
>  };
>  
>  void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index e67dfcaa279c..73e5c7dfe8b4 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1977,6 +1977,7 @@ void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
>  	batch->sk = NULL;
>  	batch->pkts = 0;
>  	batch->bytes = 0;
> +	batch->net = NULL;
>  
>  	if (!sk)
>  		return;
> @@ -2008,6 +2009,37 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>  	virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
>  	virtio_transport_trace_recv_pkt(skb, &src, &dst);
>  
> +	if (batch->sk) {
> +		if (batch->net == net &&
> +		    vsock_addr_equals_addr(&batch->src, &src) &&
> +		    vsock_addr_equals_addr(&batch->dst, &dst) &&
> +		    virtio_transport_recv_pkt_batchable(t, batch->sk)) {
> +			sk = batch->sk;
> +			if (!skb_set_owner_sk_safe(skb, sk)) {
> +				WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> +				virtio_transport_rx_batch_finish(batch);
> +				kfree_skb(skb);
> +				return;
> +			}
> +
> +			ctx = (struct virtio_transport_rx_pkt_ctx) {
> +				.net = net,
> +				.src = &src,
> +				.dst = &dst,
> +				.batchable = &batchable,
> +			};
> +			free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> +
> +			if (!batchable)
> +				virtio_transport_rx_batch_finish(batch);
> +			if (free_pkt)
> +				kfree_skb(skb);
> +			return;
> +		}
> +
> +		virtio_transport_rx_batch_finish(batch);
> +	}
> +
>  	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
>  	if (!sk) {
>  		virtio_transport_rx_batch_finish(batch);
> @@ -2018,33 +2050,10 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>  
>  	if (!skb_set_owner_sk_safe(skb, sk)) {
>  		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> -		virtio_transport_rx_batch_finish(batch);
>  		kfree_skb(skb);
>  		return;
>  	}
>  
> -	if (batch->sk && batch->sk != sk) {
> -		/* Never acquire a second socket lock. */
> -		virtio_transport_rx_batch_finish(batch);
> -	}
> -
> -	if (batch->sk == sk) {
> -		/* Keep the batch reference; drop this packet's lookup reference. */
> -		sock_put(sk);
> -		ctx = (struct virtio_transport_rx_pkt_ctx) {
> -			.net = net,
> -			.src = &src,
> -			.dst = &dst,
> -			.batchable = &batchable,
> -		};
> -		free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> -		if (!batchable)
> -			virtio_transport_rx_batch_finish(batch);
> -		if (free_pkt)
> -			kfree_skb(skb);
> -		return;
> -	}
> -

Not sure I love adding code and then removing it in the same series.
Seems like these are asking to be squashed?

>  	lock_sock(sk);
>  	/*
>  	 * Sockmap removal restores the native protocol under sk_callback_lock.
> @@ -2063,6 +2072,9 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>  	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
>  	if (start_batch && batchable) {
>  		/* Keep the lookup reference until the batch is released. */
> +		batch->net = net;
> +		batch->src = src;
> +		batch->dst = dst;

Similar to my comment in the other patch, seems these are all in sk
already?

Best,
Bobby
