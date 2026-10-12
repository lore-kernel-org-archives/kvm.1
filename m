Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CB846EF8D
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842579; cv=none; b=rrrDLDGxo/0AVzEUpPGATdmP4wpEHHxFd4A0fYYc7s9YAB35YhBTeFZi/xzwhnY0H43A+nVkRjMWNBuopd9/4ru65MTiUNLFVkDiBMptNSJGHVGMn35f6vUzwuiVDuS2iHLl/VpIlSWLUxMMMMXCuB/YrgydEFM2ERI0ZN0dEvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842579; c=relaxed/simple;
	bh=xrEfK09sOgKPL8tRakdgdLoY5A4I63z1FJ2ZQnHI7pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuU1lCcb+wVLfDD06d0bwA7V77mnddshru+McxfMP4a7LqQ7tdn66MTjLxW4fREcelwmK4DvoagAKYFcc37O+ZSObjalWez7hLH5bUXJnL4Wx2vk0W1EYRrNtzFfL8s6Y7S5EPQBgNMd9EdHybGipLUEjtBKe2ZYKUpBLQhvZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRiydYkw; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRiydYkw"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-82478760557so2107576a34.3
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 15:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791842575; x=1792447375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I34AgC3qXFsIWry2eO2C25CSCiy4N0N7n6VOFiD93pA=;
        b=kRiydYkwm255TVNGaaXvWy0gF4ej5bPf3TqHDwP3qKW0UQGyjZQ780kY3RNVw4HJup
         7FWZPEJde/7aULp3ql+ntkK990fXm/oUCr0HaTgLyKms9PnoQVCl2iG/tULiR4UBQFnq
         ylW+eb1e+rPaNKFkzqApVWG2dHMFnNBsxACTFeCYL0KpzlLT4Qt4jSlpm7i0kcJTWW5B
         OcOJt6mQwDfU3fUU6Lq/UqZRaBmRZl1o7GcaHzUh6ADz16dTNwoWs8tjvtByTesE2+3L
         yK8SWpsslmB23wVOL8Y2F4wAyUyFKBBd9gkkuvveLznuZwf6OJLWdIS5W9WXbmvbfrtt
         SKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791842575; x=1792447375;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I34AgC3qXFsIWry2eO2C25CSCiy4N0N7n6VOFiD93pA=;
        b=pdaWN7g4zDkopWhuB0UT2e1N47hIGLoSKc5uet6KTLfeqdJaLvSi27i+cZ4kPhZK0P
         T/8GbBSXXqOggS6la0myyK2xHYvGyT2dGPSgC23T91M7CIv5mBs35Frm+ikjXfuumIv/
         3lvfBoxTskZT6//UV8s7akAH5nG6HBZG2fc6/NnrBUTA8hHsmdo4C7nNLB1oFtSER7HT
         F9725UMz6LeFflOEst0+g37wZ3ld8f9EV3tUuyxo5QVyqPYTuhpUDKixc+k/oXB0rYow
         ajUgEWEK+yTOL1G5DiqLFn9Regdn9L4np8Gudp6wGmLkM3oywr9NXEghseYjdi9/NLv9
         /lLA==
X-Forwarded-Encrypted: i=1; AKwUvBz5QdqulbTISnngQk/TinRRfaZ+1tZrIl3kTgxfuSzcSsSC2LD5JOBo1xG6JPgjKYWakpY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfcqOE5HCEggB4O9uXZ1Qo43uUR94lieyeET5lhkRDBHjMeqr0
	jyBB94HHopGP+PLBsBUNHLEfk7SZjCgjlDdQjfJkUbtyvrcqeZDCr2tA
X-Gm-Gg: AYBFou3JFHKyPBCpP2JuOnI09zWpcnNyT7nVCFa+y1sP36JaCXfuVxIfg4AGFZIZiPN
	9JCB6BRwbcaFY9u1U6xZlF1C3ps7FZNK2gcgvK7Lq9FG3JozF8B13ykWFFAGM1LUEcXBxBQrngJ
	XOVe1AQC+MdKB2aFSJ+gP8HcHcwuG4W+iGLlHQBY2Yxs4D2r0qZyEMp1FK2HrkVrfS1nKlb8MuN
	1UcfcjugybYGbi81WSkfO4TT7KN+1wb9Dw6vwdI7pcACTm27315afhMwn63BuCWlhB/69eNkZ1v
	pVyKUbMDULwmkKpCDJ5A95T+1SZbou+gbRW8I3uygdnWYvMLtpsGSrFyZ2WtomwfdN4quxXcUrc
	Pv/YS0DdfTcrApZFo+vi+pX6W41qap4ecUNz3spt7pVAJKJm1lLRg/ejH/LhpRSCpEWn7fRTEJi
	3uwBRN3DMd1prG6nqVBmeR7LDsAeMBrNDgGi56cIHkgjRF8WQ6ZHe0T44cvee27sAuhyTH4KBz1
	q+F32AyA6JV3CbhrhArmZEqUkLpnA==
X-Received: by 2002:a05:6830:43a0:b0:81c:4784:a5e2 with SMTP id 46e09a7af769-83094e738d8mr9929561a34.6.1791842575557;
        Mon, 12 Oct 2026 15:02:55 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303494f64csm10655830a34.3.2026.10.12.15.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 15:02:53 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:02:50 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/5] vsock/virtio: split socket lookup from
 locked RX processing
Message-ID: <as1ZCkbya2jn72ip@devvm29614.prn0.facebook.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010142247.99223-2-physicalmtea@gmail.com>

On Sat, Oct 10, 2026 at 10:22:43PM +0800, Jia Jia wrote:
> Split virtio_transport_recv_pkt() so socket lookup is separate from the
> receive state machine that runs under the socket lock.
> 
> Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> Pass the source and destination addresses used for lookup to the locked
> receive path so they are decoded only once.
> 
> Pass the network namespace and decoded address tuple through a packet
> context to the locked receive path.
> 
> Preserve source validation and failure handling. Keep the lookup reference
> separate from the skb owner reference so the locked receive path can manage
> the two lifetimes independently.
> 
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++--------
>  1 file changed, 96 insertions(+), 43 deletions(-)
> 

[...]

> +/*
> + * The caller holds sk's socket lock and must free skb if this returns true.
> + */
> +static bool
> +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> +				 struct sk_buff *skb, struct sock *sk,
> +				 const struct virtio_transport_rx_pkt_ctx *ctx)
> +{
> +	const struct sockaddr_vm *src = ctx->src;
> +	const struct sockaddr_vm *dst = ctx->dst;
> +	struct vsock_sock *vsk = vsock_sk(sk);
> +	struct net *net = ctx->net;
> +	bool space_available;
>  
> -	/* Check if sk has been closed or assigned to another transport before
> -	 * lock_sock (note: listener sockets are not assigned to any transport)
> +	/* Check after acquiring the socket lock. Listener sockets accept packets
> +	 * from any source and are not assigned to a transport.
>  	 */
>  	if (sock_flag(sk, SOCK_DONE) ||
>  	    (sk->sk_state != TCP_LISTEN &&
> -	     !vsock_check_source(vsk, &t->transport, &src))) {
> +	     !vsock_check_source(vsk, &t->transport, src))) {
>  		(void)virtio_transport_reset_no_sock(t, skb, net);
> -		release_sock(sk);
> -		sock_put(sk);
> -		goto free_pkt;
> +		return true;
>  	}
>  
>  	space_available = virtio_transport_space_update(sk, skb);
>  
>  	/* Update CID in case it has changed after a transport reset event */
>  	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> -		vsk->local_addr.svm_cid = dst.svm_cid;
> +		vsk->local_addr.svm_cid = dst->svm_cid;
>  
>  	if (space_available)
>  		sk->sk_write_space(sk);
> @@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  		break;
>  	}
>  
> +	return false;
> +}
> +
> +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> + * lock.
> + */
> +void virtio_transport_recv_pkt(struct virtio_transport *t,
> +			       struct sk_buff *skb, struct net *net)
> +{
> +	struct virtio_transport_rx_pkt_ctx ctx;
> +	struct sockaddr_vm src, dst;
> +	struct sock *sk;
> +	bool free_pkt;
> +
> +	virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> +	virtio_transport_trace_recv_pkt(skb, &src, &dst);
> +
> +	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
> +	if (!sk) {
> +		(void)virtio_transport_reset_no_sock(t, skb, net);
> +		goto free_pkt;
> +	}
> +
> +	if (!skb_set_owner_sk_safe(skb, sk)) {
> +		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> +		goto free_pkt;
> +	}
> +
> +	lock_sock(sk);
> +	ctx = (struct virtio_transport_rx_pkt_ctx) {
> +		.net = net,
> +		.src = &src,
> +		.dst = &dst,
> +	};
> +	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);

At this point the socket lookup succeeded with src/dst/net, why not just
pass sk which already has all of them?

Best,
Bobby
