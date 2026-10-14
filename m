Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7D34F4733
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979036; cv=none; b=tyf/4wWS4zkABuHuWI42wv1osnW9IMOqe2mBTeQhWI3P7TnOQ416ybDST96m5dNyxvuljgUm2TzxkbaoY0A7z3zZ2JqMRVrlemE8UIDMLeccnHwsyIZwzJfT++4uqedbg4unX3attMAbaGgVwD9PWUmxfVRXNByZxbhCZrpH5vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979036; c=relaxed/simple;
	bh=Ii/X+chNJfGjatAYchqezl2UT8097M7y61scdJ+6EkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tZqpQcl5lhQGkU16x6Se9XkrL39zkCLV9KBoq4VIWof9Z3ZOHljdyZWm6Vy7TvB52L3+4260QcMzJ9or8bW8z9MXBdO0ksjywnF/IuDaf6Ky7Pusqk6CQ8ycYqReieD3G2LlV6mvUS/K0QFEX4Qe8UAxGQQI7zWoJ0U2ngeFiFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKDpbipF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKDpbipF"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ab4178ee33so2207418a91.3
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 04:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791979033; x=1792583833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DU9VRTVVHisnR4qqMDs4QPe70x7No5nZA8MkKh62WMQ=;
        b=fKDpbipFS9DCswBkDTZMaJpGMBnYxKrBSkkfV8p1UYzIB+QMJIOG0ZdoQ7OeNBHc8Y
         Dr18afKAH8KhHQCP0phwKn/i7knmyPXXMAUp096LYgJ35L5Vm+tRyk1+Ulyt4XSdgadI
         yGxihJxuAbuQbq5nm+FbTv1MNqClXO/GOcAUQDE4LK14RS6HzYMTWFBa2i7WrzLwb5Gi
         QUdVMG7hu4FnJluEcupjWwNytmhoNuuna4dBaDEaOGsvety3vIPX9E5hcZzzBkE9lnfY
         kKahLJo3NKonbHkcIhdY9SyQgBFdsKcoo48p3nKfjWzVbHSqOQ+2ny9xZVvhpSGbNXbZ
         gQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791979033; x=1792583833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DU9VRTVVHisnR4qqMDs4QPe70x7No5nZA8MkKh62WMQ=;
        b=fM9o+AmhaotzR1WsruAGcKXOJewnAzgJhJkbqq2M/DqBCL3lcoKepyShAewYk718Po
         YxI2OQBKyybLAgr0NKpe9j2ySEQzjEO7AGsd1xohIMPjW5kadd+8UCMQ2C5ml7K9WOn2
         2Pd9v7WHT+p94jSJIGDL9TUsEunLz6hZje0gN/BZrQhQqOU0AGrnoRaHVT03pDC6T2MK
         pW3yE9+me88Yk7vYLS5Z2cq5AkTtbgtVtlF3riYs0BSsDFW1EYC6IoGlp6QJLEXRA02O
         El4N/OofIZ7AgtU8n5x9WppBO/C7p0cbgiutCMvJFEpE9IN6Qoz0H1GpX1ZfyK6FKZPp
         nC4A==
X-Forwarded-Encrypted: i=1; AKwUvBw2X6FFTxoZHgvwJCmNhAwMXGpl1FBSBlYCoqTHb+W+Ivd9Eoovs/ns+iX1QxNS66Lc+eY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIwOdbaB/6jdsY96m0qmleMFCmnu0/qLxP7bGo7wQNzGqGKtil
	OpArzD7R4vOH1WnD5JL8LC+22saRl4j9A97oU7N5jFLptAe+bByChVF1
X-Gm-Gg: AYBFou1oh59rYOBb2Il5VIuLceVLp0mGhuj1lTuKSXowaYfEZ89cuSioqn77pf2xHBj
	km8Fzl4RiW7jvoOC2xDyFD5JXUiUobh6tg1zwtzW3ADmo7RNW4H0HeL0jJAdI4LRWZgX49LEqBi
	e9g9HAw/XL0CCiI8aB2M5Zq4WsPZ5sqHvibNwRfRmKlCARohLI+bjWVMVkInK5f8x21FgKUYMgl
	IWbvrt2eAvbDcEpKho4DCaCeIGpxP/v7Uo+aJPlHlI/7X8fcejqA3vPODXsq2ry2lkB8tByO3fG
	3lnfUF7l4p8r8hpPiKdmTLTzVfGproQ+OYzDQLRW1Tvyz89q3CVsjU0FDKAN1RilrktMCZQf8Lc
	vKMREWyfVGsMC/ytkUdTKbkf19MaTRKC9KwPbtCcGL2ct94HY0DSCwrn7nGM619DhD+Aegq3TTQ
	UriPD+7WdRD92AEeLueascwhQfkJ1QkneC6Auis8KIxg3Q1jtlzeoH7rOUqqWV1Bhr6nBxCAaiy
	RcDckEU
X-Received: by 2002:a17:90b:4cca:b0:3ac:8dfe:8ec9 with SMTP id 98e67ed59e1d1-3ac8dfea063mr35156a91.47.1791979032516;
        Wed, 14 Oct 2026 04:57:12 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f24b74csm4795691a91.7.2026.10.14.04.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:57:12 -0700 (PDT)
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
Subject: [PATCH net-next v4 3/4] vsock/virtio: coalesce RX write-space notifications in lock batches
Date: Wed, 14 Oct 2026 19:56:39 +0800
Message-Id: <20261014115640.184286-4-physicalmtea@gmail.com>
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

Each received packet updates peer credit and may call sk_write_space().
A writer cannot use that credit until the batch releases the socket lock,
so one notification at batch finish is sufficient.

Save the initial sk_write_space callback when the AF_VSOCK socket is
created and require it to remain installed for batching. This lets the
transport module deliver the deferred notification without referring to
the unexported default callback. Sockets with replaced callbacks retain
their per-packet behavior.

Record the batch socket before processing its first packet so a batch that
ends on that packet cannot lose the pending notification.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |  1 +
 include/net/af_vsock.h                  |  5 +++
 net/vmw_vsock/af_vsock.c                |  1 +
 net/vmw_vsock/virtio_transport_common.c | 53 +++++++++++++++++--------
 4 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 26dde6909c4ed..bf077ee0ded88 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -287,6 +287,7 @@ struct virtio_transport_rx_batch {
 	struct sock *sk;
 	unsigned int pkts;
 	size_t bytes;
+	bool write_space_pending;
 };
 
 void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 5549298c1ec6b..9a40960d10cbe 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -63,6 +63,11 @@ struct vsock_sock {
 	u32 peer_shutdown;
 	bool sent_request;
 	bool ignore_connecting_rst;
+	/*
+	 * Initial callback, used to identify replacements and deliver deferred
+	 * write-space notifications.
+	 */
+	void (*default_write_space)(struct sock *sk);
 
 	/* Protected by lock_sock(sk) */
 	u64 buffer_size;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 44cee74519555..fe7f49da6c4bc 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
 		sk->sk_type = type;
 
 	vsk = vsock_sk(sk);
+	vsk->default_write_space = sk->sk_write_space;
 	vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
 	vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index ff74e805527a5..f4b5f0230493e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1820,6 +1820,7 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
 	return sk->sk_state == TCP_ESTABLISHED &&
 	       sk->sk_type == SOCK_STREAM &&
 	       READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
+	       READ_ONCE(sk->sk_write_space) == vsk->default_write_space &&
 	       !sock_flag(sk, SOCK_DONE) &&
 	       vsk->transport == &t->transport &&
 	       vvs && virtio_transport_rx_skb_has_headroom(vvs) &&
@@ -1828,13 +1829,15 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
 
 /*
  * The caller holds sk's socket lock.  Set @batchable if the socket can remain
- * locked for another ordinary STREAM/RW packet.  Return true if the caller
- * must free @skb.
+ * locked for another ordinary STREAM/RW packet.  When @batch is non-NULL,
+ * record a default write-space notification for batch finish instead of
+ * delivering it immediately.  Return true if the caller must free @skb.
  */
 static bool
 virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 				 struct sk_buff *skb, struct sock *sk,
-				 bool *batchable)
+				 bool *batchable,
+				 struct virtio_transport_rx_batch *batch)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct sockaddr_vm src;
@@ -1863,8 +1866,12 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
 		vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
 
-	if (space_available)
-		sk->sk_write_space(sk);
+	if (space_available) {
+		if (batch)
+			batch->write_space_pending = true;
+		else
+			sk->sk_write_space(sk);
+	}
 
 	switch (sk->sk_state) {
 	case TCP_LISTEN:
@@ -1931,7 +1938,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	}
 
 	lock_sock(sk);
-	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, NULL);
+	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, NULL, NULL);
 	release_sock(sk);
 
 	/* Release refcnt obtained when we fetched this socket out of the
@@ -1949,22 +1956,27 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
 
 /*
  * Finish the RX batch.
- * For a non-empty batch, the caller must hold the socket lock acquired with
- * lock_sock(). This function releases the lock and the batch's lookup
- * reference.
+ * For a non-empty batch, the caller holds the socket lock acquired with
+ * lock_sock(). Deliver any deferred write-space notification while the lock
+ * is held, then release the lock and the batch's lookup reference.
  * An empty batch is a no-op.
  */
 void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
 {
+	bool write_space_pending = batch->write_space_pending;
 	struct sock *sk = batch->sk;
 
 	batch->sk = NULL;
 	batch->pkts = 0;
 	batch->bytes = 0;
+	batch->write_space_pending = false;
 
 	if (!sk)
 		return;
 
+	if (write_space_pending)
+		vsock_sk(sk)->default_write_space(sk);
+
 	release_sock(sk);
 	sock_put(sk);
 }
@@ -2019,7 +2031,8 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 			}
 
 			free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk,
-								    &batchable);
+								    &batchable,
+								    batch);
 			if (!batchable)
 				virtio_transport_rx_batch_finish(batch);
 			if (free_pkt)
@@ -2059,23 +2072,31 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 
 	lock_sock(sk);
 	/*
-	 * Sockmap removal restores the native protocol under sk_callback_lock.
-	 * Serialize this initial eligibility check with that update.
+	 * Sockmap teardown restores callbacks under sk_callback_lock. Keep the
+	 * initial eligibility check consistent with that update.
 	 */
 	read_lock_bh(&sk->sk_callback_lock);
 	start_batch = virtio_transport_recv_pkt_batchable(t, sk);
 	read_unlock_bh(&sk->sk_callback_lock);
 
+	if (start_batch)
+		batch->sk = sk;
+
 	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk,
-						    start_batch ? &batchable : NULL);
+						    start_batch ? &batchable : NULL,
+						    start_batch ? batch : NULL);
 	if (start_batch && batchable) {
 		/* Keep the lookup reference until the batch is released. */
-		batch->sk = sk;
 		return;
 	}
 
-	release_sock(sk);
-	sock_put(sk);
+	if (start_batch) {
+		virtio_transport_rx_batch_finish(batch);
+	} else {
+		release_sock(sk);
+		sock_put(sk);
+	}
+
 	if (free_pkt)
 		kfree_skb(skb);
 }
-- 
2.53.0

