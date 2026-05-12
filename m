Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B264E39D6CF
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576095; cv=none; b=OrDmfbIY6EWUQomjbjG/ete2Y0Jlu8uqeSr/5JFAfjJQbxfAP4n3VtqYKBTN8fj+joj0yeEmgB+rcdWmf25rOwmz0smcMaNSS+IbEJVnGlvTh3sld8NArCLpyOEGlDd6eL3Ab/p0d0TvS56xXbzGDYveibgExGyLOK8i7lfUiZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576095; c=relaxed/simple;
	bh=0qkr1rENvV+pyeBAMi1jVWzvQVzUp0uGCFQaBamt9gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebidIC8F6T+zJ1GyP/CwSkTcDtp9qIE0H5rqUIR3BO/cB0hhQEvb4y/HXbLGdv0AuyGWu8OgE/1V7q620J0NLzFjie4JZ02rvhpHpZFXJ85aGH5zWveZcZDuEyy8ZSfAoJWE+8PO/jxuimHicjtSR17n6OaFpC5QXzZSn4VfcCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxCalScg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7PnG48F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxCalScg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7PnG48F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778576082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AIHT9Ne++vEWAmZTxjWDyan9tOz+k8p02hVxW6y8cts=;
	b=DxCalScgWiRvmb40mx6Lscdhj/3cysDhKfSJ0/VJnCoXpxu5Q6ssWvVohjuGunvfeX633g
	/kuLZDFiBFFOreeEe95vr3n4iqZcOd5USwOcIvVFHvtC/9GjJY6qGzNUg/6vFindGhl52F
	JBlgngjtfKQMqh/QqWGZqSvfrz1UyBc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-PYQ0T6qdMXuE2haKqQCIKw-1; Tue, 12 May 2026 04:54:39 -0400
X-MC-Unique: PYQ0T6qdMXuE2haKqQCIKw-1
X-Mimecast-MFC-AGG-ID: PYQ0T6qdMXuE2haKqQCIKw_1778576079
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48e86e6c6b7so15522155e9.1
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 01:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778576079; x=1779180879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AIHT9Ne++vEWAmZTxjWDyan9tOz+k8p02hVxW6y8cts=;
        b=g7PnG48F81BT6HxjDPES0uJdUtP3QLzm2kowjr99azBSGR9w9P3LifjjyVo2VWoWVL
         +H6ten1CtlZvcoZmAzIg5pFefukGNh6eo6LpUah4iq/5pIrmnZvGHykH+eZDRaZqA6qN
         r7acbQj5kvjZ2UsnE4ZChSfQXjB3LfSkNUgwu3G/aZEsvJZmTm+QisTCoJYZJB9bZ1oJ
         dLzCakVvPJ1ZHl2O67tamkSObTvKdUaJFwHZ315VzAXboO4z7iTgLFgnmZTLZ81A29ek
         hBusK0zI3vEbvggOt9Xo4SbZeUB/LYxfuztct5rnED5ghdD7dpXa2z5aiIMmF7trn1+g
         c+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778576079; x=1779180879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIHT9Ne++vEWAmZTxjWDyan9tOz+k8p02hVxW6y8cts=;
        b=EkCYJD3LKPxJbtLQvb3bNFFrSy0x4GLWopX72skLTz+AC08yCOdBHzgxhnceGMbdp+
         9rG9W/TVIDoiMPaF3FwY4pnLv30eG/7VF5fM6Nctz08TySKHMSXv9NPy4/7TwbmooCI4
         feMqkYi4PCke1Rk7lIv4ITgaXq1rcG42w70RHkRyRuCl6YwhPwt3uavtv3cGr6Dwx7gc
         tzk7IzIUWGcb9uLC6L32KsMd4H3BlVmnDONe03XG32+BD+J6BUvIehTObANH9PTNxdea
         EK5DMcAJUVc4WwzQ/sgnsM+I6IH8gTQZtg3BD4RRlhXRrw/z302p+COYetDzwYA5Vsot
         2vLg==
X-Forwarded-Encrypted: i=1; AFNElJ+LAWXtWwI5IfoUnM4IpuJBhU+Kz5GoN+ybC5K0/2T1DmCQ8jOWPWsB9Nd16P9LuXd6jeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyFZS8ioAMj1fI4oq63A0UItPV7InPQPI36MHAwQtKzPkz393E
	Dl+nyM4tMwRVc2SoSFGfDMawcN3oeDgjvdv7bjAdGCSbOaDW9P1Mp+0eD1vkKKlmZCOyd5gZ3PZ
	9fxgZymji8Q+vOddtVhfzauG4xZHWjLW4sjZUF4B1HNijTcUP9AJo/g==
X-Gm-Gg: Acq92OE2MiV4y6OfAqaO1VXQnK1oiGh2kFALIsgpvg31/GLkYi3RaW+f+YcGdWmPfLl
	WCBIJKrL7FlnApFqYbPLmlGkLR5TZK6MIRo9hbG1yRJ/gN2i9hHrby3S0wj3CsuvPX2juMEnrRR
	DsV1dqa5kjG8T5oh4N6DP+UNwZPSfQ0eAaSEp7jpZebWU59jczhlHIBhFCeHO0Ajsab8nFCURJS
	zgnvp+AY6MJG0EXSmP6cxoOk5wO2gRqwO6fhb/nukXc+AWdmt9czOmgUS9/b61iw+pxh+BIImRX
	6BgTun1MIRG/gkU6YTmSFQXFyxUrBDb0bHvvGyd9F+hjJGgVkJFinK8p4YvcELGB7JhGr13wI/V
	pgpsgOGVfYKGJ1cTL4iMNQNyykdG+G59P+F+TEwLT
X-Received: by 2002:a05:600c:26c8:b0:48a:9562:7a30 with SMTP id 5b1f17b1804b1-48e51f4934cmr277143115e9.24.1778576078365;
        Tue, 12 May 2026 01:54:38 -0700 (PDT)
X-Received: by 2002:a05:600c:26c8:b0:48a:9562:7a30 with SMTP id 5b1f17b1804b1-48e51f4934cmr277142775e9.24.1778576077739;
        Tue, 12 May 2026 01:54:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f410d9fsm17755735e9.6.2026.05.12.01.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:54:37 -0700 (PDT)
Date: Tue, 12 May 2026 04:54:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net v2] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <20260512044008-mutt-send-email-mst@kernel.org>
References: <20260512080737.36787-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512080737.36787-1-sgarzare@redhat.com>

On Tue, May 12, 2026 at 10:07:37AM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
> queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
> buf_alloc when checking whether a new packet fits. This reduces the
> effective receive buffer below what the user configured via
> SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
> silently dropped and applications that rely on the full buffer size
> to deadlock.
> 
> Also, the reduced space is not communicated to the remote peer, so
> its credit calculation accounts more credit than the receiver will
> actually accept, causing data loss (there is no retransmission).
> 
> With this approach we currently have failures in
> tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
> test 22 always fails in this way:
>     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
> 
>     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
>     Resource temporarily unavailable
> 
> Fix this by using `buf_alloc * 2` as the total budget for payload plus
> skb overhead in virtio_transport_inc_rx_pkt(), similar to how SO_RCVBUF
> is doubled to reserve space for sk_buff metadata. This preserves the
> full buf_alloc for payload under normal operation, while still bounding
> the skb queue growth.
> 
> When the total budget (buf_alloc * 2) is exceeded (e.g. under small-packet
> flooding where overhead dominates), the connection is reset and local
> socket error set to ENOBUFS, so both peers are explicitly notified of
> the failure rather than silently losing data.
> 
> With this patch, all tests in tools/testing/vsock/vsock_test.c are
> now passing again.
> 
> A solution to handle small-packet overhead efficiently also for
> SEQPACKET (we already do that for STREAM) is planned as follow-up work.
> This patch is needed in any case to prevent silent data loss, because
> even if we reduce the overhead, we can't eliminate it entirely.
> 
> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks for the patch!  I'd like to split this: 
1. buf alloc boost
2. reset when out of credits

this way we can revert 2 easier later.


> ---
> v2:
> - Close the connection when we can no longer queue new packets instead
>   of losing data.
> - No longer announce the reduced buf_alloc to avoid violating the
>   spec. [MST]
> 
> v1: https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/
> ---
>  net/vmw_vsock/virtio_transport_common.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 9b8014516f4f..f23bf8a11319 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -449,7 +449,10 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  {
>  	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>  
> -	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> +	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
> +	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
> +	 */
> +	if (skb_overhead + vvs->buf_used + len > (u64)vvs->buf_alloc * 2)
>  		return false;
>  
>  	vvs->rx_bytes += len;
> @@ -1365,7 +1368,7 @@ virtio_transport_recv_connecting(struct sock *sk,
>  	return err;
>  }
>  
> -static void
> +static bool
>  virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>  			      struct sk_buff *skb)
>  {
> @@ -1380,10 +1383,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>  	spin_lock_bh(&vvs->rx_lock);
>  
>  	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> -	if (!can_enqueue) {
> -		free_pkt = true;
> +	if (!can_enqueue)
>  		goto out;
> -	}
>  
>  	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
>  		vvs->msg_count++;
> @@ -1423,6 +1424,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>  	spin_unlock_bh(&vvs->rx_lock);
>  	if (free_pkt)
>  		kfree_skb(skb);
> +
> +	return can_enqueue;
>  }
>  
>  static int
> @@ -1435,7 +1438,16 @@ virtio_transport_recv_connected(struct sock *sk,
>  
>  	switch (le16_to_cpu(hdr->op)) {
>  	case VIRTIO_VSOCK_OP_RW:
> -		virtio_transport_recv_enqueue(vsk, skb);
> +		if (!virtio_transport_recv_enqueue(vsk, skb)) {
> +			/* There is no more space to queue the packet, so let's
> +			 * close the connection; otherwise, we'll lose data.
> +			 */
> +			(void)virtio_transport_reset(vsk, skb);
> +			sk->sk_state = TCP_CLOSE;
> +			sk->sk_err = ENOBUFS;
> +			sk_error_report(sk);
> +			break;
> +		}
>  		vsock_data_ready(sk);
>  		return err;
>  	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> -- 
> 2.54.0

