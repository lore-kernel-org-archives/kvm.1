Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809F4C6F1E
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158465; cv=none; b=BmIexOCYhPf6WgKpq7AxWziwXdtbT1VvcYF0NUvqp/RrFGux4wZV3+4dnl8hj7ae5VqlTPs2TTe8oO1YY/lRIVWiFCAf8fTeTGw1hi/3KkcatEplYjLbhpOK2O2hpDzHfY9zINc97z/LXo9WyxikbpwELwXO13CvmRAekOq7TtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158465; c=relaxed/simple;
	bh=CU3/MfdDC5CCAi2IBjM7GBTNHGS8rDLFUgIS668OelY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIsPhQOQfx7IpFAGk692buMVsWuVougQp6MtruNehdSvJE71FnhUcnArTmSMGIVKx/Q2k7XkK2FuDPahVoK7tzHhSrqkCwBVHfFHAx6Csi96Ym1YfZul+6ClmeHIwrWRoGQh64yJNux/88hAwC/A2lyegoXmilfYIqykmJS6p3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6eEmelc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VSIIcWM3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6eEmelc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSIIcWM3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792158463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5SSnXLe6871QixsCS+2sjMCeMY5DVo6y3bWbHQzmraY=;
	b=R6eEmelc/nSSYiH6hNP2/6C1XXf6hi8tz8SoHEGnjcfU/F0DUw2DR1Wp4pQArXLo0DYRnA
	N8gElkT7gJkhJ57vR+9wFbyISUY3sXRefXIasHHkdCPUD+9tbY5D9LNPNib+E5j3NAQSHV
	Gi23sV9eEUY3ic70huKq+QA50q9pF+o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-CB0pn6UrM_KUK1pTNARXAQ-1; Fri, 16 Oct 2026 13:47:41 +0000
X-MC-Unique: CB0pn6UrM_KUK1pTNARXAQ-1
X-Mimecast-MFC-AGG-ID: CB0pn6UrM_KUK1pTNARXAQ_1792158460
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48b02d63407so3938350f8f.0
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 06:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792158460; x=1792763260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5SSnXLe6871QixsCS+2sjMCeMY5DVo6y3bWbHQzmraY=;
        b=VSIIcWM3mOwCifFe2Rm6Xn4JtohvIDaCid8bS//QSuUyA9v7wXwOyyPHFUvKxYJ1dD
         7M2YzicKAa+HgqhwmwiCREx5HpHaSSQdZ3DDBTjpMbgUCpi3P4iYjc+EEOiAWs4p4A4f
         Ppa2y3XQDTWUVkuaFf2UQ2IVA+1CKgzfu0u5Ym0BZMvKjjGHmsZR1LAU8Zl6f8ZAq9qU
         uKpKsOSj6xqWdr+ki/h0EwzZzSVBFh1OdTf5dDl+BbX/qhE6jjx4g421YUH8RJE9h22A
         qXPTfvrtwSQXUuETu2YBJbeFskGhs6OUQ4jASpkrcQlfTEciW6ecEnI7gK6cek6LSUcX
         sAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792158460; x=1792763260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5SSnXLe6871QixsCS+2sjMCeMY5DVo6y3bWbHQzmraY=;
        b=l1rxz438CWIUnBlIJIwh45OL0z5q7ubjC5Bt52yjuW+zTDu5GhE798+U2TBgHfzzZ2
         ybTvuDSNRXRipfBP5DAv9oH8/0yWehxzOaNbIhWcDKkyl5Tp/BqaoHBNk3JfLShj9Gkc
         JnKLDfTexWHjQbqyBZVtJ+lzyIvfwlKq6AfK2f6iEexy4y/HIE0NPBpTFnYftOR5bWGF
         Fwbqc44kucJQJg6xEEW66Ab4bX+2wforTNDNhd4XIpppyoM/2oed8kxWfyw8JcQzPCpK
         BgosRxOG5hKbo1nn19+ZcD1DGihrDiineB3GtHlmde2tlIS5l0/kLzqBL3MHdUzNSrZF
         gT0A==
X-Forwarded-Encrypted: i=1; AKwUvBxN9kYLsNMeT+XYRMasOiixcBywr6SzCvGdCrnmVw75iErEEm518H3meQJX6xzrDKZbfRU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJx/lD6tXr6PG587+bdHSdjJd3bS8tZpVJKmAQuZmvgEJ3dFsbF
	VVdixUhhXsG+MBR2dsPGuhuIii9rloMhYuio7RYxVM0N/rFAwKQv8vpTAYAwmDKXbaPoDGjivTJ
	x/vTNj+n/95rLQZeJZBIz2fQPpVXuOABVthiI1gdhtC+pB4Ms9G4byA==
X-Gm-Gg: AYBFou2MYrFAL9K40FOyFzxYJ7xXUIyTQTP8dPkfduvzjAcn9bLVYH405GPSVY/skTh
	4/Xpn+TF6/7kL/XEM1jN1+BRxcTBxfwYlFHjjSbwBDWnBtardqW8PImI12EghOgo/jpL9nasGSP
	GpsFFItA9I6TR/8lTz2UXEtn7lJHsi8QTXKUlM8e6txl5qFhIJpONb0LTBk7RvmcQ95T179H5FU
	r7Urddz+vOGYgsc57uJfHmbZVrIu/M5n/VKRuEkDklwCDYEtCJcnEH51tJ9ELYP6SW32gCSFc+u
	kALnpd2NH7Tb5D+xtnfhZDkW8Av+oZMEr9ORIL18j/NnWSvKnCDVuY9sPDGhAYHzGovDW/pdKD+
	C9rdM
X-Received: by 2002:a05:6000:200c:b0:48c:55c1:fb50 with SMTP id ffacd0b85a97d-48dbace6841mr41485215f8f.40.1792158458832;
        Fri, 16 Oct 2026 06:47:38 -0700 (PDT)
X-Received: by 2002:a05:6000:200c:b0:48c:55c1:fb50 with SMTP id ffacd0b85a97d-48dbace6841mr41485142f8f.40.1792158458102;
        Fri, 16 Oct 2026 06:47:38 -0700 (PDT)
Received: from sgarzare-redhat ([80.116.137.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4d4dddsm5276537f8f.22.2026.10.16.06.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:47:35 -0700 (PDT)
Date: Fri, 16 Oct 2026 15:47:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v4 1/4] vsock/virtio: split socket lookup from
 locked RX processing
Message-ID: <atImp74JbTbEb0d_@sgarzare-redhat>
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261014115640.184286-2-physicalmtea@gmail.com>

On Wed, Oct 14, 2026 at 07:56:37PM +0800, Jia Jia wrote:
>Split virtio_transport_recv_pkt() so socket lookup is separate from
>receive state machine processing under the socket lock. This prepares the
>receive path to keep a looked-up socket across multiple packets in a later
>change.
>
>Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
>The locked helper obtains packet-specific addresses from the skb and uses
>the matched socket namespace for reset replies. Preserve source validation
>and failure handling.
>
>No functional change intended.
>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 128 ++++++++++++++----------
> 1 file changed, 75 insertions(+), 53 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index f225f53ed4bab..61ee3bc205d5d 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1774,81 +1774,60 @@ static bool virtio_transport_valid_type(u16 type)
> 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
> }
>
>-/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
>- * lock.
>- */
>-void virtio_transport_recv_pkt(struct virtio_transport *t,
>-			       struct sk_buff *skb, struct net *net)
>+static struct sock *
>+virtio_transport_find_socket(struct sk_buff *skb, struct sockaddr_vm *src,
>+			     struct sockaddr_vm *dst, struct net *net)
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>-	struct sockaddr_vm src, dst;
>-	struct vsock_sock *vsk;
> 	struct sock *sk;
>-	bool space_available;
>-
>-	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
>-			le32_to_cpu(hdr->src_port));
>-	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
>-			le32_to_cpu(hdr->dst_port));
>-
>-	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
>-					dst.svm_cid, dst.svm_port,
>-					le32_to_cpu(hdr->len),
>-					le16_to_cpu(hdr->type),
>-					le16_to_cpu(hdr->op),
>-					le32_to_cpu(hdr->flags),
>-					le32_to_cpu(hdr->buf_alloc),
>-					le32_to_cpu(hdr->fwd_cnt));
>
>-	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
>-		(void)virtio_transport_reset_no_sock(t, skb, net);
>-		goto free_pkt;
>-	}
>+	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type)))
>+		return NULL;
>
>-	/* The socket must be in connected or bound table
>-	 * otherwise send reset back
>-	 */
>-	sk = vsock_find_connected_socket_net(&src, &dst, net);
>-	if (!sk) {
>-		sk = vsock_find_bound_socket_net(&dst, net);
>-		if (!sk) {
>-			(void)virtio_transport_reset_no_sock(t, skb, net);
>-			goto free_pkt;
>-		}
>-	}
>+	sk = vsock_find_connected_socket_net(src, dst, net);
>+	if (!sk)
>+		sk = vsock_find_bound_socket_net(dst, net);
>+	if (!sk)
>+		return NULL;
>
> 	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
>-		(void)virtio_transport_reset_no_sock(t, skb, net);
> 		sock_put(sk);
>-		goto free_pkt;
>+		return NULL;
> 	}
>
>-	if (!skb_set_owner_sk_safe(skb, sk)) {
>-		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
>-		goto free_pkt;
>-	}
>+	return sk;
>+}
>
>-	vsk = vsock_sk(sk);
>+/*
>+ * The caller holds sk's socket lock and must free skb if this returns true.

Why the skb must be freed by the caller and not by this function itself?

>+ */
>+static bool
>+virtio_transport_recv_pkt_locked(struct virtio_transport *t,
>+				 struct sk_buff *skb, struct sock *sk)
>+{
>+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>+	struct sockaddr_vm src;
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+	bool space_available;

Please, follow the netdev convection for ordering local variables: 
https://www.kernel.org/doc/html/v7.2/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

>
>-	lock_sock(sk);
>+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
>+			le32_to_cpu(hdr->src_port));
>
>-	/* Check if sk has been closed or assigned to another transport before
>-	 * lock_sock (note: listener sockets are not assigned to any transport)
>+	/* Listener sockets accept packets from any source and are not assigned to
>+	 * a transport.
> 	 */

Why changing this comment in this commit?

Oh because we moved out lock_sock, right?

I think we should keep in some way the old info that was much more 
informative that the current comment that just say what the check is 
doing and not why.

> 	if (sock_flag(sk, SOCK_DONE) ||
> 	    (sk->sk_state != TCP_LISTEN &&
> 	     !vsock_check_source(vsk, &t->transport, &src))) {
>-		(void)virtio_transport_reset_no_sock(t, skb, net);
>-		release_sock(sk);
>-		sock_put(sk);
>-		goto free_pkt;
>+		(void)virtio_transport_reset_no_sock(t, skb, sock_net(sk));

We need to be careful here, IIRC Bobby used the net from the caller for 
a reason.

Are you sure it's fine this change? Why not passing net as parameter and 
minimize changes?

>+		return true;
> 	}
>
> 	space_available = virtio_transport_space_update(sk, skb);
>
> 	/* Update CID in case it has changed after a transport reset event */
> 	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
>-		vsk->local_addr.svm_cid = dst.svm_cid;
>+		vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
>
> 	if (space_available)
> 		sk->sk_write_space(sk);
>@@ -1870,17 +1849,60 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 		kfree_skb(skb);
> 		break;
> 	default:
>-		(void)virtio_transport_reset_no_sock(t, skb, net);
>+		(void)virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> 		kfree_skb(skb);
> 		break;
> 	}
>
>+	return false;
>+}
>+
>+/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
>+ * lock.
>+ */
>+void virtio_transport_recv_pkt(struct virtio_transport *t,
>+			       struct sk_buff *skb, struct net *net)
>+{
>+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>+	struct sockaddr_vm src, dst;
>+	struct sock *sk;
>+	bool free_pkt;
>+
>+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
>+			le32_to_cpu(hdr->src_port));
>+	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
>+			le32_to_cpu(hdr->dst_port));
>+
>+	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
>+					dst.svm_cid, dst.svm_port,
>+					le32_to_cpu(hdr->len),
>+					le16_to_cpu(hdr->type),
>+					le16_to_cpu(hdr->op),
>+					le32_to_cpu(hdr->flags),
>+					le32_to_cpu(hdr->buf_alloc),
>+					le32_to_cpu(hdr->fwd_cnt));
>+
>+	sk = virtio_transport_find_socket(skb, &src, &dst, net);
>+	if (!sk) {
>+		(void)virtio_transport_reset_no_sock(t, skb, net);
>+		goto free_pkt;
>+	}
>+
>+	if (!skb_set_owner_sk_safe(skb, sk)) {
>+		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
>+		goto free_pkt;
>+	}
>+
>+	lock_sock(sk);
>+	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk);
> 	release_sock(sk);
>
> 	/* Release refcnt obtained when we fetched this socket out of the
> 	 * bound or connected list.
> 	 */
> 	sock_put(sk);
>+	if (free_pkt)
>+		kfree_skb(skb);
> 	return;
>
> free_pkt:
>-- 
>2.53.0
>

