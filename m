Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E37E4FB9D8
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979025; cv=none; b=u5/0OYZ57g8D38lXak82BjG8FJNX+kEFlSfMrPPIKyQFRpbBl76aAT79KQzr0LdBbJONegWITFLNZXMsd5525TsJhCw55yFEW1P1noaJ40qmgX5JRLQu+ey5BK8eykMB3v9/kK0HsD5wWnvjGA9eoCqlGyYmi188yciCWVHVaUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979025; c=relaxed/simple;
	bh=hbtnE8W7pRRMU/4pmxjsxU1MHonesorrNXzdBRBb6sE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sgICIMTxQBxQJJ0/wwHY+Ox7mDaYV+5nsQBMMT7CQPyGmOXORO3nNQK3oJceDxEBdyWLIq3ztVGdbtNvCVYiW2D56euhEz9GesNOSr4i8WiV/21j54BJ51g7fXKZnRfnJuAqCrllQgOIQaN3ZIPWXv4j4UxFkdR52CrbGAMMM2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHl4vUuZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHl4vUuZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so3316611a91.0
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 04:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791979021; x=1792583821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w7y+RyZF/0euqEMjj6lXHC52QPFtTJhGKHy9NrMHBD0=;
        b=YHl4vUuZmTW4zy/+P2E9D+pr7RYKa54zK0Q4UCPou40cMoVCv2lFIwRNvu8XirSIEJ
         QAt25qdgo8u39nrR811BR+wQ5UcpkYR+9lL9aba/fksHCwSGs5WCf2Xomr9GF5Hkj7b6
         Em5/0AIjZpVElhC1xOCvpibS6mkFRYRWp5+hrXhIk34ESpwE68pfudqUhj6di0oZUasp
         bY5BvlcZ/uT6JsxNhIzKdQc3ITk20Q51pjN4/rlJiDTsWMAlqwipeIwtFpZcRZ4SDd3M
         F7WvoaSaDCt9zQvtbpSKYEoGqlUqB+puOZ/68sr1PFtr1aS/76Ia2iOsIImvtCRTocIj
         KxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791979021; x=1792583821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w7y+RyZF/0euqEMjj6lXHC52QPFtTJhGKHy9NrMHBD0=;
        b=o8w1l6bdbi2xhc7lS6N4SPu0r8+ZMffyk3Z3jiB0iAY0HZuft7QSuquN/yUFvReRbW
         7slJi5IY8w1FIayAC3DxzaWqtdAnb5J1fzp9qFNIYMQUOyaF5gcYRB7kI38C7VrLN7kQ
         TQwcqi3aSDj8araMGgMcOjIeWtCz007M9ckH5XkEqMyMpI1htlgVoUWsTuItcD0ylc7j
         jE5jjtzQsxZiGLNTdz9YRg2ih3upoPeKNahRXRtYjB7J96FIRFVwdjC+3/5Bq4o9YbtA
         35gzBnhMRK8rtZOyxvvxFICnOw7YILqN/4r+9dzHQrrX9P0+oFFPl6zf+rAo2pWS8g05
         2CNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwf8vX01YFAyg99k7O4qz5b675wFRmwEC3Q0KWjJj16gvp4wFugrotOxu8sXDkEer66pW8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIO6DeB2HkBrIYiGsklB/TXVjD7f6OZUY7SG7SxpRAm+kqtT/HG
	3O3P4vsHtfecRy4L/fq9uAi2ePzoroLXfe4XrRS8YwlpFdKZNtbtKAuH
X-Gm-Gg: AYBFou2AzjyapDATn7ssNdjVO0J+cp5avhJ1Y2IXHzGtZRkKeF1Qrz+SG18Gye+nFNb
	5ySMKapLIClq3++unO6mk63AyinBh7UHu3637WzPcGXaBbMu6w4LQJCeLfM9ueRLGZstbWiJTEK
	MpR8lpzBTqIjZDeAURpDCaC0ATNPWxjCWSAH/b8LVVa4/YD8Y6stDbEHYWIQNABP4s/ec7+ZKx7
	vDBItI3UtFIwHVHh02Y/aBYXilSxL8Pqgs6JlYZUiel3u66PwgIP90EEB80FEWefkFBP7aQAF8T
	41BIJy+tMpjiHnG8FgvON5rD8Gk0bFJZ8RsBgEG3+9HCyT4S9rXCjbtiA937erzHgepgNbI2uq9
	8j3tKxldcBNIJjmAWCiTx4xHpZjt9iInQLemJpyZ9oDDgFcZd+nOcLE60Y+6CPl5Sxp+7+h9+Ui
	G2MFgaXrFHgJXALZWWG3+zZr/2y0SScUmgx0iH6ziGsJ+ZhQ0HikPNmGaJqZhms+hJsZOPwg==
X-Received: by 2002:a17:90b:2e0e:b0:3ac:7556:8ee6 with SMTP id 98e67ed59e1d1-3ac7556a46bmr1378653a91.16.1791979021010;
        Wed, 14 Oct 2026 04:57:01 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f24b74csm4795691a91.7.2026.10.14.04.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:57:00 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bobbyeshleman@gmail.com
Subject: [PATCH net-next v4 1/4] vsock/virtio: split socket lookup from locked RX processing
Date: Wed, 14 Oct 2026 19:56:37 +0800
Message-Id: <20261014115640.184286-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014115640.184286-1-physicalmtea@gmail.com>
References: <20261014115640.184286-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split virtio_transport_recv_pkt() so socket lookup is separate from
receive state machine processing under the socket lock. This prepares the
receive path to keep a looked-up socket across multiple packets in a later
change.

Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
The locked helper obtains packet-specific addresses from the skb and uses
the matched socket namespace for reset replies. Preserve source validation
and failure handling.

No functional change intended.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 128 ++++++++++++++----------
 1 file changed, 75 insertions(+), 53 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f225f53ed4bab..61ee3bc205d5d 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1774,81 +1774,60 @@ static bool virtio_transport_valid_type(u16 type)
 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
 }
 
-/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
- * lock.
- */
-void virtio_transport_recv_pkt(struct virtio_transport *t,
-			       struct sk_buff *skb, struct net *net)
+static struct sock *
+virtio_transport_find_socket(struct sk_buff *skb, struct sockaddr_vm *src,
+			     struct sockaddr_vm *dst, struct net *net)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
-	struct sockaddr_vm src, dst;
-	struct vsock_sock *vsk;
 	struct sock *sk;
-	bool space_available;
-
-	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
-			le32_to_cpu(hdr->src_port));
-	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
-			le32_to_cpu(hdr->dst_port));
-
-	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
-					dst.svm_cid, dst.svm_port,
-					le32_to_cpu(hdr->len),
-					le16_to_cpu(hdr->type),
-					le16_to_cpu(hdr->op),
-					le32_to_cpu(hdr->flags),
-					le32_to_cpu(hdr->buf_alloc),
-					le32_to_cpu(hdr->fwd_cnt));
 
-	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
-		(void)virtio_transport_reset_no_sock(t, skb, net);
-		goto free_pkt;
-	}
+	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type)))
+		return NULL;
 
-	/* The socket must be in connected or bound table
-	 * otherwise send reset back
-	 */
-	sk = vsock_find_connected_socket_net(&src, &dst, net);
-	if (!sk) {
-		sk = vsock_find_bound_socket_net(&dst, net);
-		if (!sk) {
-			(void)virtio_transport_reset_no_sock(t, skb, net);
-			goto free_pkt;
-		}
-	}
+	sk = vsock_find_connected_socket_net(src, dst, net);
+	if (!sk)
+		sk = vsock_find_bound_socket_net(dst, net);
+	if (!sk)
+		return NULL;
 
 	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
-		(void)virtio_transport_reset_no_sock(t, skb, net);
 		sock_put(sk);
-		goto free_pkt;
+		return NULL;
 	}
 
-	if (!skb_set_owner_sk_safe(skb, sk)) {
-		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
-		goto free_pkt;
-	}
+	return sk;
+}
 
-	vsk = vsock_sk(sk);
+/*
+ * The caller holds sk's socket lock and must free skb if this returns true.
+ */
+static bool
+virtio_transport_recv_pkt_locked(struct virtio_transport *t,
+				 struct sk_buff *skb, struct sock *sk)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct sockaddr_vm src;
+	struct vsock_sock *vsk = vsock_sk(sk);
+	bool space_available;
 
-	lock_sock(sk);
+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
+			le32_to_cpu(hdr->src_port));
 
-	/* Check if sk has been closed or assigned to another transport before
-	 * lock_sock (note: listener sockets are not assigned to any transport)
+	/* Listener sockets accept packets from any source and are not assigned to
+	 * a transport.
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
 	    (sk->sk_state != TCP_LISTEN &&
 	     !vsock_check_source(vsk, &t->transport, &src))) {
-		(void)virtio_transport_reset_no_sock(t, skb, net);
-		release_sock(sk);
-		sock_put(sk);
-		goto free_pkt;
+		(void)virtio_transport_reset_no_sock(t, skb, sock_net(sk));
+		return true;
 	}
 
 	space_available = virtio_transport_space_update(sk, skb);
 
 	/* Update CID in case it has changed after a transport reset event */
 	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
-		vsk->local_addr.svm_cid = dst.svm_cid;
+		vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
 
 	if (space_available)
 		sk->sk_write_space(sk);
@@ -1870,17 +1849,60 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		kfree_skb(skb);
 		break;
 	default:
-		(void)virtio_transport_reset_no_sock(t, skb, net);
+		(void)virtio_transport_reset_no_sock(t, skb, sock_net(sk));
 		kfree_skb(skb);
 		break;
 	}
 
+	return false;
+}
+
+/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
+ * lock.
+ */
+void virtio_transport_recv_pkt(struct virtio_transport *t,
+			       struct sk_buff *skb, struct net *net)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct sockaddr_vm src, dst;
+	struct sock *sk;
+	bool free_pkt;
+
+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
+			le32_to_cpu(hdr->src_port));
+	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
+			le32_to_cpu(hdr->dst_port));
+
+	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
+					dst.svm_cid, dst.svm_port,
+					le32_to_cpu(hdr->len),
+					le16_to_cpu(hdr->type),
+					le16_to_cpu(hdr->op),
+					le32_to_cpu(hdr->flags),
+					le32_to_cpu(hdr->buf_alloc),
+					le32_to_cpu(hdr->fwd_cnt));
+
+	sk = virtio_transport_find_socket(skb, &src, &dst, net);
+	if (!sk) {
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		goto free_pkt;
+	}
+
+	if (!skb_set_owner_sk_safe(skb, sk)) {
+		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
+		goto free_pkt;
+	}
+
+	lock_sock(sk);
+	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk);
 	release_sock(sk);
 
 	/* Release refcnt obtained when we fetched this socket out of the
 	 * bound or connected list.
 	 */
 	sock_put(sk);
+	if (free_pkt)
+		kfree_skb(skb);
 	return;
 
 free_pkt:
-- 
2.53.0

