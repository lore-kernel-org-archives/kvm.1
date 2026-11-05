Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869505;
	b=whiTm5Cv07pQ1X7F9wnVu+aaZXJSdZ6NrF2yCZQq72lKVGaY55YjhqvtkXCJl9qDo5Lj
	 Jxq/oMoPGkcGh4TTfgxO5P6UjafUYWbpmmC38isbmVx0k9mgXduy2bjdL/BYdJ3+8rGqD
	 MeMRcx2onrtPmoyKiev0Q+3ZvQA9XprU3oVHP85d1xfp9Bg/Q22UzPWrSes8XrhpkuUkc
	 YNbXlIoZW8sHcHXPFyKv+9J6kPCUo9u9hOxKaEHCSOnHf6Yar3CanO+4mRdV/AHNSWa4S
	 SfnjxDl7ipMo0QU1H1bCdGLAU02xt5MYTTP3VhTtx1OrbW68iuuyakHIezdupUVtPfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869505;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OKDdMZ8wV3aSy4GLecm7p1foBFtioFQmSifyw+llv2w=;
	b=urzoAKZJp87m5UNxIK1gdvsvsdoILULUAzOFb/gvwci3XPtMSP49SK/+y1TVhgmz3AWC
	 l5hSC18lRwNOITozsLfgFbyU6BrTyqU5ZZ/K82hTc/0hZdZsVe2aArWSTi2FAelcps0CG
	 PgZjcWfRUCc7vYDw2onPGoeWWZSzbwaAt2imLQqyX8lnK6rpuCdYwTiCPynNHvT19yL4E
	 cP+Ax0+d+ugfLvNfBaa7k/DClRdutIrMoVRs1vsVwWXMbxz2g8EL80gp//ZY+dzTTf0EI
	 o9A/CVcCh7+zxoMJG1eJoE/DUEJv8bMbFIiywTEhtu31NC0FMEZjaBCZDArxlYPJI8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LsIBHgXB;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Zjkqfzi1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2F1606A31B
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 09:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD2F1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LsIBHgXB;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Zjkqfzi1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793869503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OKDdMZ8wV3aSy4GLecm7p1foBFtioFQmSifyw+llv2w=;
	b=LsIBHgXBPJRdeSB1uVo1H/u5pO9njuM4Y5dk3TuHuAKZH5uWTJmVxTDrpyDvLHHPMFLoyZ
	h3hnbpuiaa0vqkmvg5tTczauPhhrAkFYecflZoq8nQ4yDHbCsIaN5rxWlR9ArN0FQpOJgZ
	SUjUbDA1FvzCH1RG+CrdwjBdWL1V21g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-ciIATWuOPhCWs14NR_hDww-1; Thu, 05 Nov 2026 04:05:01 -0500
X-MC-Unique: ciIATWuOPhCWs14NR_hDww-1
X-Mimecast-MFC-AGG-ID: ciIATWuOPhCWs14NR_hDww_1793869501
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c49df8fe86eso79114066b.2
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 01:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793869500; x=1794474300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OKDdMZ8wV3aSy4GLecm7p1foBFtioFQmSifyw+llv2w=;
        b=Zjkqfzi1MWta00GniQ2T3iaOq7QaWrGWHBrjm3wGbwf+Omg7xAfKv6IWRHFNWLn81C
         yoizp/7IxrrSAvhCIylo4riHR6BOmgb2dhc9emTSyjtO/7t8stsIr1ScnrSaxSmGbluR
         qZU1uhwoJsk7JaKEq3VrskbTQbJK+hpMFf2DxND9NenV7MIw7ekaxqn7G+1fRdqA/wsl
         DvWTfOm14x1vSDODySng+rZcUPuQnrTlxBa6KM+HpwOh5vB0PwyPPkHi18DndTMXzROS
         1zMgUL/MNX3vxnyyw6T3fsUtclzECAtIUWpPqHTP5AA/zmJP5SD0yOyBYacqj01xvFc/
         L3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793869500; x=1794474300;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OKDdMZ8wV3aSy4GLecm7p1foBFtioFQmSifyw+llv2w=;
        b=A5IjtK+LgLfnT4/Oi0ItTVj7nrd6VNGx+Yplzm2ykDdAE1kL3h4eF2043lJ2fTau6F
         63puMevVl9t8NrGZbmXaJfZtkB7FHn9EJoMwfaX/ZWwk/wJJvQ86VUUmf5cYf5NV7Fu1
         AYcTa5IMIByVlrkIB2JKmh9/n5f5kPYTbvVq1xoB5iwmnKr5u5jNYLBhaD1iCtfECf65
         Wj5koDM1HaLkmg6kg4kNhkZXzoU0q7HS2ypX5sKwfqDQ1Cz4IIOOsxchDRLRex0sRdcc
         KIamfwy8jJc7xAUehZuHKv/cbIyPyTs0jHh2u7oQdFHVIg6eg/DPlI8v/VWLKSXrrcXH
         rLEg==
X-Forwarded-Encrypted: i=1; AKwUvByrxW3Q0kGilIZKEYnhNiSZruO8vI5naYbmtaAGFFpqcXOWWiL8RBWpBVEiGok5ais6kRk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+6geDvxnOV9uI3aVQrVnB0YRE1JonrZVNq7pt5Tk2vTQdDDsU
	v1x2XBfX+ttIj/I/LJMTAVuDKwlUoqjaD6NuYTVrJ5NoGnKweNhrVww1x66GFhe2gakjGSnjskO
	WiXiomjXxXMENaz3EGCblH88R0Hwi9vedDNdDu/r8Y5ynTLiXhpax6A==
X-Gm-Gg: AYBFou12iwXanFtm7nUXHDCc/8c0U+yihJ2Z7ngTIF+fdl0leinMOiUB4i6A8CO6Iqq
	B6hBDK8G01CLwxYvW+Jm7q7Y+1FIdGmrYL4rgS1zwr7ZFPgA6Y2oxFUX6IUIhJAemwPQNtLQuP6
	fhy4umFlx8760i3jKjzhdosf8NS9itgiCInRtuROzbA40IcbRoNf/kY537Gm4jydbCR46ne+1Op
	m6XLIh3tBxOAVq1zv6L11PRptNuqIAzy3LKrzz+gl/0sRJCMCbYqPQXp5/l2gVY8aL+XJFS01UY
	Cifsrp+u+0FzFHeM3B7jm8CZdLYGa/f4nOpk5NwEUTiktFo2BOZMtcGowwCChagRvMs5x4Djvbm
	MSRiCZJBDHcM+I7EnsEnIVzvnOSItSkdwGi61tgcpX5KttsND+azZ
X-Received: by 2002:a17:907:86a7:b0:c2e:6a4f:a88b with SMTP id a640c23a62f3a-c4ca73f6a56mr1619384266b.0.1793869500497;
        Thu, 05 Nov 2026 01:05:00 -0800 (PST)
X-Received: by 2002:a17:907:86a7:b0:c2e:6a4f:a88b with SMTP id a640c23a62f3a-c4ca73f6a56mr1619380866b.0.1793869499953;
        Thu, 05 Nov 2026 01:04:59 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec9cd43bsm8597436f8f.14.2026.11.05.01.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 01:04:58 -0800 (PST)
Date: Thu, 5 Nov 2026 10:04:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, bobbyeshleman@gmail.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/5] vsock/virtio: split socket lookup from
 locked RX processing
Message-ID: <auxGc7T-7vCsGWlE@sgarzare-redhat>
References: <20261103041134.33310-1-physicalmtea@gmail.com>
 <20261103041134.33310-2-physicalmtea@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261103041134.33310-2-physicalmtea@gmail.com>

On Tue, Nov 03, 2026 at 12:11:30PM +0800, Jia Jia wrote:
>Split virtio_transport_recv_pkt() so socket lookup is separate from
>processing that occurs while holding the socket lock. This prepares the
>receive path to retain a looked-up socket across multiple packets in a
>later change.
>
>Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
>Pass the caller-provided network namespace to the locked helper so reset
>handling retains its existing semantics. Preserve source validation and
>failure handling.
>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 131 ++++++++++++++----------
> 1 file changed, 78 insertions(+), 53 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index f225f53ed4bab..43325d7aebbb1 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1774,6 +1774,80 @@ static bool virtio_transport_valid_type(u16 type)
> 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
> }
>
>+static struct sock *
>+virtio_transport_find_socket(struct sockaddr_vm *src,
>+			     struct sockaddr_vm *dst, struct net *net)
>+{
>+	struct sock *sk;
>+
>+	sk = vsock_find_connected_socket_net(src, dst, net);
>+	if (!sk)
>+		sk = vsock_find_bound_socket_net(dst, net);
>+
>+	return sk;
>+}
>+
>+/*
>+ * The caller holds sk's socket lock.
>+ */
>+static void
>+virtio_transport_recv_pkt_locked(struct virtio_transport *t,
>+				 struct sk_buff *skb, struct sock *sk,
>+				 struct net *net)
>+{
>+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+	struct sockaddr_vm src;
>+	bool space_available;
>+
>+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
>+			le32_to_cpu(hdr->src_port));
>+
>+	/*
>+	 * The socket may have been closed or reassigned after lookup but before
>+	 * its socket lock was acquired. Listener sockets have no assigned
>+	 * transport.
>+	 */
>+	if (sock_flag(sk, SOCK_DONE) ||
>+	    (sk->sk_state != TCP_LISTEN &&
>+	     !vsock_check_source(vsk, &t->transport, &src))) {
>+		(void)virtio_transport_reset_no_sock(t, skb, net);
>+		kfree_skb(skb);
>+		return;
>+	}
>+
>+	space_available = virtio_transport_space_update(sk, skb);
>+
>+	/* Update CID in case it has changed after a transport reset event */
>+	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
>+		vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
>+
>+	if (space_available)
>+		sk->sk_write_space(sk);
>+
>+	switch (sk->sk_state) {
>+	case TCP_LISTEN:
>+		virtio_transport_recv_listen(sk, skb, t);
>+		kfree_skb(skb);
>+		break;
>+	case TCP_SYN_SENT:
>+		virtio_transport_recv_connecting(sk, skb);
>+		kfree_skb(skb);
>+		break;
>+	case TCP_ESTABLISHED:
>+		virtio_transport_recv_connected(sk, skb);
>+		break;
>+	case TCP_CLOSING:
>+		virtio_transport_recv_disconnecting(sk, skb);
>+		kfree_skb(skb);
>+		break;
>+	default:
>+		(void)virtio_transport_reset_no_sock(t, skb, net);
>+		kfree_skb(skb);
>+		break;
>+	}
>+}
>+
> /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
>  * lock.
>  */
>@@ -1782,9 +1856,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> 	struct sockaddr_vm src, dst;
>-	struct vsock_sock *vsk;
> 	struct sock *sk;
>-	bool space_available;
>
> 	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> 			le32_to_cpu(hdr->src_port));
>@@ -1808,13 +1880,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 	/* The socket must be in connected or bound table
> 	 * otherwise send reset back
> 	 */
>-	sk = vsock_find_connected_socket_net(&src, &dst, net);
>+	sk = virtio_transport_find_socket(&src, &dst, net);
> 	if (!sk) {
>-		sk = vsock_find_bound_socket_net(&dst, net);
>-		if (!sk) {
>-			(void)virtio_transport_reset_no_sock(t, skb, net);
>-			goto free_pkt;
>-		}
>+		(void)virtio_transport_reset_no_sock(t, skb, net);
>+		goto free_pkt;
> 	}
>
> 	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
>@@ -1828,52 +1897,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 		goto free_pkt;
> 	}
>
>-	vsk = vsock_sk(sk);
>-
> 	lock_sock(sk);
>-
>-	/* Check if sk has been closed or assigned to another transport before
>-	 * lock_sock (note: listener sockets are not assigned to any transport)
>-	 */
>-	if (sock_flag(sk, SOCK_DONE) ||
>-	    (sk->sk_state != TCP_LISTEN &&
>-	     !vsock_check_source(vsk, &t->transport, &src))) {
>-		(void)virtio_transport_reset_no_sock(t, skb, net);
>-		release_sock(sk);
>-		sock_put(sk);
>-		goto free_pkt;
>-	}
>-
>-	space_available = virtio_transport_space_update(sk, skb);
>-
>-	/* Update CID in case it has changed after a transport reset event */
>-	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
>-		vsk->local_addr.svm_cid = dst.svm_cid;
>-
>-	if (space_available)
>-		sk->sk_write_space(sk);
>-
>-	switch (sk->sk_state) {
>-	case TCP_LISTEN:
>-		virtio_transport_recv_listen(sk, skb, t);
>-		kfree_skb(skb);
>-		break;
>-	case TCP_SYN_SENT:
>-		virtio_transport_recv_connecting(sk, skb);
>-		kfree_skb(skb);
>-		break;
>-	case TCP_ESTABLISHED:
>-		virtio_transport_recv_connected(sk, skb);
>-		break;
>-	case TCP_CLOSING:
>-		virtio_transport_recv_disconnecting(sk, skb);
>-		kfree_skb(skb);
>-		break;
>-	default:
>-		(void)virtio_transport_reset_no_sock(t, skb, net);
>-		kfree_skb(skb);
>-		break;
>-	}
>+	virtio_transport_recv_pkt_locked(t, skb, sk, net);
>

nit: if you need to resend, please remove this blank line or add a blank 
line after lock_sock().

The rest LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


> 	release_sock(sk);
>
>-- 
>2.53.0
>

