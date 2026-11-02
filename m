Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624966;
	b=VolMRugl91eNPP4bPcoTn1wZ5WrmE/5oOm0FTumeIU80cUYaoqur+mJOoIhKBBSZqZe2
	 hCxUy5N+QjIrGFiNmUQyGsqwm6rK41LtM8oMp/qVAQd6h5DJqJJ6lMFOFVsZ6cb2TZdoH
	 fFv14gjIeQSJuMqLIapUsr/4cQSMkNG57L2Pb5hhtk1L5cBzq3cjFRZxFS6l4OmPq0A2g
	 lMby1MkYp5g/GZujIbb+vXqa/x9dS+pCDSZ554rPf7C//g+gLOWkqYWEHdUvLKl9uVtp2
	 t+BSgWydvUPl+0Cmt6eXArybyMF5l01DtcbFAnbf3mAaNBmHOSHDgB2ROxvrk8OsJQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624966;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=lPg1Z+kih2x3BmRrSyzS6hP0pvAD1UHy/E1nPZhrbok=;
	b=UgOViwDajlwSuQz/kEVc9am4+4b1P4oGOa3UWwKuOU0y+epteRIjuqjlJjSBcn45WYCf
	 zmUkTqXdOiV2C9Ah6ZIo+i/ZQAN2tclv2L/j8lhYXGDLeGzMkiRZn70glfEmxfgVfwBqJ
	 mP39sDxFW9hpICMDoxTuWZ/87oEYsKcD+fahKN/QhcRayUPcLxgynIAqTiiIBnpvtXFe/
	 cdl8rZLzqMmOybCHyRlxaV1d72fSO0U0mbAS/PPqnRTqmoxdqgKI0rbK9sKD8r3/aYi+l
	 Zn9xbWTooyOwKA87kMSA0ZdQJLysQkjsqyQvL8qsTqF6g2GAWTXjSwaLIWwdLoilaPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="GCCN/p9x";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cL3RR7GZ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6F6606A327
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 13:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E6F6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GCCN/p9x;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cL3RR7GZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793624964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPg1Z+kih2x3BmRrSyzS6hP0pvAD1UHy/E1nPZhrbok=;
	b=GCCN/p9xZAmK6nPfCFIltd1frP7ardok2eVaA0wPEuOQ65oV/WMABkv8nDursqkt0AzdgS
	X+tGm3OeEnyWhpTfnXrLMM5FIPvzT2xweEOpiKCiskinY7JQCdKDtHm2Zz94RU2n2BhOxN
	AZYVnS+JLqk2X7N1zRUOcu6z+l6UdjU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-Gw12V_X0P0G04d9hK_oltw-1; Mon, 02 Nov 2026 08:09:23 -0500
X-MC-Unique: Gw12V_X0P0G04d9hK_oltw-1
X-Mimecast-MFC-AGG-ID: Gw12V_X0P0G04d9hK_oltw_1793624962
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e00f3929bso2482070f8f.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 05:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793624962; x=1794229762; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lPg1Z+kih2x3BmRrSyzS6hP0pvAD1UHy/E1nPZhrbok=;
        b=cL3RR7GZBRF6RxRO5aA8KKOgpPdRhYdFFBnb4dctlIcD+KreV6GFg3g03oX3+FRBD6
         ksSc1cAgMnSVc969CRkchN72goHDtzU3x5azAcE/g61/9FjN6jIzkImyi6aWzFxb+Zpn
         FnKE1H0uqoyMb3eH2a/b6P5FzSCrti17GbL4Wa3E+VjKO9tcKW5zlxrw5CUWyRwdk5g8
         ozYLh7OQ5tijJ7kLpxJ6demb5AU1VLByziEzOGiknX4rz/TpdTbF2jOuzXNmNsCiPRYq
         /bY7NIIAIdCpALH6YVf126irtz8uRkWEnxUoQlAgLaCGGIgcWC+wrTRnMzWc2CV7mgVU
         zg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793624962; x=1794229762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lPg1Z+kih2x3BmRrSyzS6hP0pvAD1UHy/E1nPZhrbok=;
        b=Kf5/E+RAXfp/aUtTJr8tWnNcOqtdt/J5QkEmHPk+EeIs+p4Rczllh93Ftj2whZZszk
         7feLfDElsuH5fBppkUAu4VfzhSCIEqdt4vEmWDdt4eDnlCwE+QdBuY2SiMO9VMRxM/5S
         mznYQLjl1OXS7oPJwlbxBvZATI/db4h0x/7FPdcCJv5fXnia0L/4GIeIIJcEZE09qoI/
         qGfWAD4aMd7ELwCsq8WxFlenC9+fuVtuUlVK/frFifLIh6EEZctZnwlvm11x9H08VnKK
         +t+B51YUacX8WvQmU/oYUFb8KNpZjJG5rfM2n+uA0awo4X4zZFRYg8/ckHYq+mS3Spio
         dsIg==
X-Forwarded-Encrypted: i=1; AKwUvBwLEWB38/jQDRsWs3GTJDNw6KcUd2lscCxBi2+bxY/ledGGvp+FkQ4HIP/z2XAHkJza8oc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUzmvsgSFRIukgOt01nfvMciTrRxHhzgdvZrNfEvUQToHN0Tgb
	/AJ6i1efsWFstyVwkY8ywsGZ28cpjVYrYywp49w6XokAIxsK0mONAutc/A2V4APiqtlf3BW6pkC
	9AUI1hmCW602KX4hdwuwDiLqJWnTi4LDJ048uwxSIDbMm0oFnAcnBGA==
X-Gm-Gg: AYBFou3iYvjmqUrEF1hCK6ZgyJCtY5ziIugl3kFOowHKsRiY5GD7yv6NGFoKyaf+bIA
	CnMaWbbEkzToxwOATSdnUfVb0EvJye6sSv1odgmVXZVmtz5XZBpZoJxgNQiAtkVmI+uo+Mb+Dp/
	z//mPbtYWFZS0QdiMA0EI38678F5CTmZ0kvPBxHhGf6RyspVkjiYvsfIe+cLjz5ZFmQPN3l+IRS
	ywtFPYyTAHZouvTzofmQeHhZWMknsJFVgcc/N1Y+4wFM3kp3yBomhZ75p8tRzUzPRrkHXzQPuDR
	2M4Izoc/o2tdQ22YBqmE2PR8wV/m/63yUhaEu86QJi1Qd2qiHfJqMP5w+ekcJiXKmcoHNY5lMkW
	mE4BmGRtUbOL/+KWOj1OnPBgkTcFuFSPLn1NMbBJSLA==
X-Received: by 2002:a05:600d:1a:b0:4a1:d49e:9ce with SMTP id 5b1f17b1804b1-4aa86e16223mr303262845e9.2.1793624961755;
        Mon, 02 Nov 2026 05:09:21 -0800 (PST)
X-Received: by 2002:a05:600d:1a:b0:4a1:d49e:9ce with SMTP id 5b1f17b1804b1-4aa86e16223mr303261555e9.2.1793624961001;
        Mon, 02 Nov 2026 05:09:21 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71bae25dsm18089160f8f.59.2026.11.02.05.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:09:20 -0800 (PST)
Date: Mon, 2 Nov 2026 08:09:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?Q?Bart=C5=82omiej?= Dmitruk <bartlomiej.dmitruk@isec.pl>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vsock: keep SOCK_SEQPACKET message boundaries on
 interrupted send
Message-ID: <20261102080902-mutt-send-email-mst@kernel.org>
References: <20260919122916.28226-1-bartlomiej.dmitruk@isec.pl>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260919122916.28226-1-bartlomiej.dmitruk@isec.pl>

On Sat, Sep 19, 2026 at 02:29:15PM +0200, Bartłomiej Dmitruk wrote:
> A credit-limited SOCK_SEQPACKET send transmits fragments as credit becomes
> available, and the VIRTIO_VSOCK_SEQ_EOM flag is set only on the fragment
> where msg_data_left() reaches 0. If vsock_connectible_sendmsg() exits via
> out_err after a partial send -- notably the non-terminal -EINTR path
> (signal_pending while blocked for credit), but also sk_err / peer
> RCV_SHUTDOWN -- the already-transmitted fragments carry no EOM. The receiver
> only advances msg_count / sets msg_ready on an EOM skb, so the orphaned
> fragments are silently merged into the next message, violating SOCK_SEQPACKET
> atomicity.
> 
> Wait until the whole remaining SEQPACKET message fits before enqueuing, so a
> message is committed atomically (with its EOM) or not started; an error while
> waiting then leaves nothing on the wire. SOCK_STREAM behaviour is unchanged
> (min_space == 1 reproduces the old "wait while space == 0").
> 
> To avoid blocking forever on a message that can never fit -- a peer can
> advertise a small buf_alloc, or the message can simply exceed the transmit
> buffer -- reject such a message up front with -EMSGSIZE (the same error the
> transport already returns for an oversized message) instead of waiting. This
> needs the transport's maximum message size, added as a new optional
> seqpacket_max_size() transport op implemented by the virtio/loopback
> transports.
> 
> Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
> Assisted-by: Claude (Anthropic)

Do you want to address the bot review?



> ---
> Changes in v2:
>  - Fix an indefinite wait the v1 approach introduced for oversized
>    SOCK_SEQPACKET messages (reported by the Sashiko AI review on v1): the
>    atomic-wait could never be satisfied when len > the transport's max
>    message size (e.g. a peer advertising a small peer_buf_alloc), so the
>    sender blocked instead of returning -EMSGSIZE. v2 checks this up front via
>    the new seqpacket_max_size() op and returns -EMSGSIZE without waiting.
>  - v1: https://lore.kernel.org/netdev/20260917220101.55744-1-bartlomiej.dmitruk@isec.pl/
> 
> Testing (vsock_loopback, unprivileged):
>  - Interrupted partial send (-EINTR) no longer leaks orphan bytes into the
>    next message (recv() returns only the next message).
>  - Oversized message and small-peer_buf_alloc cases return -EMSGSIZE promptly
>    instead of blocking.
>  - Normal SEQPACKET send/recv unaffected.
> 
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index f91704731..e96790c03 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -219,6 +219,7 @@ virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>  s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
>  s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>  u32 virtio_transport_seqpacket_has_data(struct vsock_sock *vsk);
> +u32 virtio_transport_seqpacket_max_size(struct vsock_sock *vsk);
>  
>  ssize_t virtio_transport_unsent_bytes(struct vsock_sock *vsk);
>  
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index 5549298c1..d94c613ef 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -143,6 +143,7 @@ struct vsock_transport {
>  				 size_t len);
>  	bool (*seqpacket_allow)(struct vsock_sock *vsk, u32 remote_cid);
>  	u32 (*seqpacket_has_data)(struct vsock_sock *vsk);
> +	u32 (*seqpacket_max_size)(struct vsock_sock *vsk);
>  
>  	/* Notification. */
>  	int (*notify_poll_in)(struct vsock_sock *, size_t, bool *);
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index f840498b5..ac64cb957 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2250,9 +2250,32 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
>  
>  	while (total_written < len) {
>  		ssize_t written;
> +		s64 min_space;
> +
> +		if (sk->sk_type == SOCK_SEQPACKET) {
> +			/* A SEQPACKET message must be delivered atomically, so
> +			 * wait until the whole remaining message fits before
> +			 * enqueuing.  Otherwise a credit-limited partial send that
> +			 * later errors out (e.g. -EINTR) leaves EOM-less fragments
> +			 * that the peer merges into the next message.
> +			 *
> +			 * Reject a message that can never fit up front so the wait
> +			 * below cannot block forever (a peer may advertise a small
> +			 * buf_alloc); this mirrors the -EMSGSIZE the transport
> +			 * returns for an oversized message.
> +			 */
> +			if (transport->seqpacket_max_size &&
> +			    len > transport->seqpacket_max_size(vsk)) {
> +				err = -EMSGSIZE;
> +				goto out_err;
> +			}
> +			min_space = len - total_written;
> +		} else {
> +			min_space = 1;
> +		}
>  
>  		add_wait_queue(sk_sleep(sk), &wait);
> -		while (vsock_stream_has_space(vsk) == 0 &&
> +		while (vsock_stream_has_space(vsk) < min_space &&
>  		       sk->sk_err == 0 &&
>  		       !(sk->sk_shutdown & SEND_SHUTDOWN) &&
>  		       !(vsk->peer_shutdown & RCV_SHUTDOWN)) {
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 4f9aa9c4c..b7d587a20 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -585,6 +585,7 @@ static struct virtio_transport virtio_transport = {
>  		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
>  		.seqpacket_allow          = virtio_transport_seqpacket_allow,
>  		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
> +		.seqpacket_max_size       = virtio_transport_seqpacket_max_size,
>  
>  		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,
>  
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index f225f53ed..e10e7b958 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -994,6 +994,19 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>  }
>  EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_enqueue);
>  
> +u32 virtio_transport_seqpacket_max_size(struct vsock_sock *vsk)
> +{
> +	struct virtio_vsock_sock *vvs = vsk->trans;
> +	u32 max_size;
> +
> +	spin_lock_bh(&vvs->tx_lock);
> +	max_size = virtio_transport_tx_buf_size(vvs);
> +	spin_unlock_bh(&vvs->tx_lock);
> +
> +	return max_size;
> +}
> +EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_max_size);
> +
>  int
>  virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
>  			       struct msghdr *msg,
> diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
> index 8068d1b6e..b9a0cc861 100644
> --- a/net/vmw_vsock/vsock_loopback.c
> +++ b/net/vmw_vsock/vsock_loopback.c
> @@ -90,6 +90,7 @@ static struct virtio_transport loopback_transport = {
>  		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
>  		.seqpacket_allow          = vsock_loopback_seqpacket_allow,
>  		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
> +		.seqpacket_max_size       = virtio_transport_seqpacket_max_size,
>  
>  		.msgzerocopy_allow        = vsock_loopback_msgzerocopy_allow,
>  

