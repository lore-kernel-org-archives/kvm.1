Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741928;
	b=PfJzRAcQYk0SrCSEv5HGMflOIE1YAZIYpEfJRITxMdfiqsoZZPJ5lIE2mpXdyVdWpR3s
	 8C0nX8G2TvJTmyJCCyzMAsBrkxNxMDRHhyvFsWL1U1fL8jsChGVugKp+2BY/oEWOzoOQD
	 4C+tw2izO2iExlorZCwgG/bDUaGVUUjrfq74loKrMGZb17N7yjJ+Kj5BqBK2Vu6k4xWvR
	 z0kaLzzTQRJvDQAexbGjQ3bJYVxDiL3vAY4ccPP7YJZkTi/up3A40XSJMh+C9hsmOZEus
	 yspTqJqrmKhkZuP6KMizvzteSDArlUIe/OOqp8YduhttPMuPO5B4uGB/ZmzReKhIATw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AoK1tSvrGC/yGpo34e5d7pEB1O9R0LQE99Bs7YS2fkw=;
	b=dDqSL/0yTKJPaRdBHGBWf+a2RPq1h1LjJZ8A/Z3eGtgcm8umnyV5k2iABJJ0MqVa61eN
	 nZuUVJOO3xlimSn/bFNo9YhJHc576vpdN1foEGhKKTgzziikzmWqzONPeGLtOS9IV6ahp
	 ZuHn2XURSHxN+oOfWsN7m8w8PW0ECEQ65RuXzLmSvLT9AjRBaeEFuh/GaAxT0thIW5b47
	 jeL8sJchR9M5xIs3hgOnvhgN7s05DNIiON6DoIaPX4fdMRdTLEQaKCVa7uYPjojyuH/46
	 pl5oZOeTwVQpjYUmKsY2JBgdFueN2Q94YhBna4Gjg3VKvfAOctuLuQR6L7LKuLhS+3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TYIiVFYz;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73807606A321
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 07:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73807606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TYIiVFYz
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ea7987517aso2933355ad.0
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 00:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792741928; x=1793346728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AoK1tSvrGC/yGpo34e5d7pEB1O9R0LQE99Bs7YS2fkw=;
        b=TYIiVFYzaJA9+SQrPIwVd3iFqEY1ecXoGOrH5wMMEaOoZXa59KIdVe134ob7y6/brd
         UjbN163Mc60CgDQ0l9diuUkK3z2ZM6UgCgGm93QSTul80Z/0OeUO1bBAXyKsxOJ945I6
         KPZfqOsmv0pE4lPtA52pAqU2Y2N9Q8BHnhUXgWQeSCNq6JTIaYXlUsQtzHhqx9cIIAzh
         5fEPs1XoSlejQOdJtQiHt9jY202mdv9EMjsmDjPqz0vI/dT6oVflonJz8OVloPQo73Fc
         iVyZuaq80WqEIWrJIvD2EcMU3Xk4irD3w/w7iKpjgYnKrVorYnBPUU9xTN04uq6EUQhm
         dYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741928; x=1793346728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AoK1tSvrGC/yGpo34e5d7pEB1O9R0LQE99Bs7YS2fkw=;
        b=s21n75bKwNACiSNIoUzKmFf/k4mOo+kO0gl+kXBI5pZo5WRxcjiHxq31vapJkkTkgi
         LX4RJAIMahVcUFH174yWyI3eKZaLKfg3I7S1oZiCHnIVPWuKIDsdu2yHDTuiS+ebKWct
         SqbFfAmenvZ6QjHVmDCSrL3gF+dSmrL1eHus5c36650gL4/kO/qu4WKMTtVT+P3CMx2O
         de+FbsqJ5sWW4TJHoJttYCzjuybhosKEpGVCTedn3+w0iDZb1qDvPRIHWkznnzFO36SN
         O8/dOjpawmL5wQnqLteQRwkCi3HRlI3VuxwuZQy0Y/jPOE406JbL2RiKBWMNbIv8+uNV
         DkPg==
X-Forwarded-Encrypted: i=1; AKwUvBwoiFvP8iSZ+XF+X0bl+bln3Vaa19c1V39pJx9xOKjNfS7LDvw6IW/1rhJfooCSVEYSnBc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIel0/EAaLp6eOCgiRPzgd8nhO7VKopOA9Py8q1giButvRsHfSF
	kLxMa3uwSC10fvFOYle3fgpb5wkppi7JG201JrWuvzm7Cq8stgYdh0Lx
X-Gm-Gg: AYBFou12Rb3M+lsm92kNuFkFkSaWXMUsaQ8uMAXl2w4MgyCfWDUG+dYWdVOgoDCpXCN
	/V9erTWpr2RUGdp1EFZsS3mA+aD42eFuxNVHSW5hrLRoaVaKY3dCUmVU9ByXNZ3pbHARcTrGPR+
	f7C/vGPTRIAKGwhcqqZgn/uwaysVKXw11Kny6hT3eltDEdp5MpsjSvA6JRnZLlWZOAqZf7PxuHA
	Q9PBM5E5WZCqGMftOAoNBrTy9O0YIP40YZ1HeaXQBEJLrJXHfc+7nPy0Fc+VkAqufl8MzJfR2Iq
	87hx49+ik/241LHnjZJn9PRaC9B+54KYE+l9jxb5E9Bc4fJZdxrAcufR5FcWkVMGwvs+c9NnP+w
	kkm4WwP2rcySxijbYA5w5Eol9VUNyKmmRdghA2pNXbfayHlJkKbAR9ajgqoobNYcQ3w2Q8CVzBj
	zJsi1arrXHHbkh/7XwGNZFc8EMdC4u2FOITZeFHCLFSqM68NjK5E0TsC/GmCYuKAusbcLbFu9dG
	GGuTHUJuSr48GWKoSeR0OwlwFbLxM2y3lk+UZmSfuzc8YLEyfhzgNFJbA==
X-Received: by 2002:a17:902:e948:b0:2dd:9b53:f9ba with SMTP id d9443c01a7336-2ea7cf5c3d5mr16703675ad.1.1792741927509;
        Fri, 23 Oct 2026 00:52:07 -0700 (PDT)
Received: from gmail.com ([185.220.236.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b368c90sm7208265ad.29.2026.10.23.00.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:52:07 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: netdev@vger.kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	bobbyeshleman@meta.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 4/5] vsock/virtio: coalesce native RX write-space notifications
Date: Fri, 23 Oct 2026 15:51:39 +0800
Message-Id: <20261023075140.9613-5-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023075140.9613-1-physicalmtea@gmail.com>
References: <20261023075140.9613-1-physicalmtea@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each received packet can update peer credit and call sk_write_space(). A
writer cannot consume that credit while the virtio RX worker retains the
socket lock, so repeated native write-space notifications in one RX batch
are unnecessary.

This patch coalesces write-space notifications on the native AF_VSOCK path;
data-ready remains per-packet here.

The batching patch establishes batch ownership before its first packet.
This lets this patch record a pending notification for that packet and
flush it even if the packet immediately ends the batch. Deliver it while
holding the socket lock to preserve the callback context of the existing
receive path. A following patch changes that timing together with
data-ready handling.

Capture the native write-space callback before socket publication and
access it through AF_VSOCK helpers. Sockmap can change the protocol,
write-space callback, and psock marker without the socket lock. Serialize
each batch eligibility check with sk_callback_lock; if a packet boundary
observes a replacement, finish the batch and use the regular per-packet
path.

Packets admitted on the native path use the saved native callback at batch
finish. Reloading a current sockmap callback would not synchronize its
invocation with teardown; a wrapper seen before teardown need not forward
the native wakeup after its psock is gone.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |  4 +-
 include/net/af_vsock.h                  |  7 +++
 net/vmw_vsock/af_vsock.c                | 16 +++++
 net/vmw_vsock/virtio_transport_common.c | 78 +++++++++++++++++--------
 4 files changed, 81 insertions(+), 24 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 748633aa0cc81..bf28e8e32e280 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -287,12 +287,14 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
  * Initialize a batch to zero before use. A non-empty batch owns @sk's socket
  * lock and the reference returned by vsock_find_connected_socket_net(). The
  * caller retains both until it calls virtio_transport_rx_batch_finish(). An
- * empty batch owns neither.
+ * empty batch owns neither. A pending native write-space notification belongs
+ * to the lock holder and is delivered by virtio_transport_rx_batch_finish().
  */
 struct virtio_transport_rx_batch {
 	struct sock *sk;
 	unsigned int pkts;
 	size_t bytes;
+	bool write_space_pending;
 };
 
 static inline bool
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 5549298c1ec6b..b76ab565ea58b 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -63,6 +63,11 @@ struct vsock_sock {
 	u32 peer_shutdown;
 	bool sent_request;
 	bool ignore_connecting_rst;
+	/*
+	 * Captured before the socket is published. This identifies AF_VSOCK's
+	 * native write-space callback after a consumer has replaced it.
+	 */
+	void (*native_write_space)(struct sock *sk);
 
 	/* Protected by lock_sock(sk) */
 	u64 buffer_size;
@@ -78,6 +83,8 @@ s64 vsock_stream_has_data(struct vsock_sock *vsk);
 s64 vsock_stream_has_space(struct vsock_sock *vsk);
 struct sock *vsock_create_connected(struct sock *parent);
 void vsock_data_ready(struct sock *sk);
+bool vsock_write_space_is_native(const struct sock *sk);
+void vsock_call_native_write_space(struct sock *sk);
 
 /**** TRANSPORT ****/
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 44cee74519555..e39567990539f 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
 		sk->sk_type = type;
 
 	vsk = vsock_sk(sk);
+	vsk->native_write_space = sk->sk_write_space;
 	vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
 	vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
 
@@ -1122,6 +1123,21 @@ void vsock_data_ready(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(vsock_data_ready);
 
+bool vsock_write_space_is_native(const struct sock *sk)
+{
+	const struct vsock_sock *vsk = vsock_sk(sk);
+
+	return READ_ONCE(sk->sk_write_space) ==
+	       READ_ONCE(vsk->native_write_space);
+}
+EXPORT_SYMBOL_GPL(vsock_write_space_is_native);
+
+void vsock_call_native_write_space(struct sock *sk)
+{
+	vsock_sk(sk)->native_write_space(sk);
+}
+EXPORT_SYMBOL_GPL(vsock_call_native_write_space);
+
 /* Dummy callback required by sockmap.
  * See unconditional call of saved_close() in sock_map_close().
  */
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f83e5b2edce35..af26344678e41 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1865,31 +1865,55 @@ virtio_transport_rx_batch_can_continue(struct virtio_transport *t,
 	       !virtio_transport_rx_buf_full(vvs);
 }
 
-/* The caller holds sk's socket lock. */
+/* The caller holds sk's socket and callback locks. */
 static bool
-virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
-				      struct sock *sk, u32 len)
+__virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
+					struct sock *sk, u32 len)
 {
 	if (!virtio_transport_rx_batch_can_continue(t, sk, len))
 		return false;
 
 	/*
-	 * Sockmap can replace sk_prot and publish a psock without the socket lock.
-	 * Check both at each packet boundary; a boundary that sees a replacement
-	 * returns to the existing per-packet path.
+	 * Sockmap can replace sk_prot or sk_write_space, and publish a psock,
+	 * without the socket lock. Coalescing is safe only for the native
+	 * write-space callback, so a boundary that sees a replacement returns to
+	 * the existing per-packet path.
 	 */
 	return READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
+	       vsock_write_space_is_native(sk) &&
 	       !virtio_transport_sock_has_psock(sk);
 }
 
+/*
+ * Sockmap teardown restores the native protocol and write-space callback
+ * under sk_callback_lock. Serialize each packet admission check with those
+ * updates.
+ */
+static bool
+virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
+				      struct sock *sk, u32 len)
+{
+	bool batchable;
+
+	read_lock_bh(&sk->sk_callback_lock);
+	batchable = __virtio_transport_rx_batch_can_receive(t, sk, len);
+	read_unlock_bh(&sk->sk_callback_lock);
+
+	return batchable;
+}
+
 /*
  * The caller holds sk's socket lock. If @batchable is non-NULL, update it
  * after processing @skb to say whether a native STREAM/RW batch can continue.
+ * When @batch is non-NULL, record a native write-space notification for batch
+ * finish. A writer cannot consume the updated credit until this lock is
+ * released.
  */
 static void
 virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 				 struct sk_buff *skb, struct sock *sk,
-				 struct net *net, bool *batchable)
+				 struct net *net, bool *batchable,
+				 struct virtio_transport_rx_batch *batch)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vsock_sock *vsk = vsock_sk(sk);
@@ -1921,8 +1945,12 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
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
@@ -1947,7 +1975,7 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 	}
 
 	if (batchable)
-		*batchable = virtio_transport_rx_batch_can_receive(t, sk, 0);
+		*batchable = virtio_transport_rx_batch_can_continue(t, sk, 0);
 }
 
 /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
@@ -1991,7 +2019,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		goto free_pkt;
 
 	lock_sock(sk);
-	virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL);
+	virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL, NULL);
 
 	release_sock(sk);
 
@@ -2008,20 +2036,31 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
 
 /*
  * Release an active RX batch. A non-empty batch holds the socket lock and the
- * reference returned by vsock_find_connected_socket_net(). An empty batch
- * holds neither.
+ * reference returned by vsock_find_connected_socket_net(). Deliver any
+ * deferred native write-space notification while holding the lock, preserving
+ * the callback context of the regular receive path. An empty batch holds
+ * neither.
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
 
+	/*
+	 * The packet was admitted with the native callback. Do not reload a current
+	 * callback here: sockmap can replace or remove its wrapper independently.
+	 */
+	if (write_space_pending)
+		vsock_call_native_write_space(sk);
+
 	release_sock(sk);
 	sock_put(sk);
 }
@@ -2080,7 +2119,8 @@ virtio_transport_rx_batch_process(struct virtio_transport *t,
 		return;
 	}
 
-	virtio_transport_recv_pkt_locked(t, skb, batch->sk, net, &batchable);
+	virtio_transport_recv_pkt_locked(t, skb, batch->sk, net, &batchable,
+					 batch);
 	if (!batchable) {
 		virtio_transport_rx_batch_finish(batch);
 		return;
@@ -2158,16 +2198,8 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 	}
 
 	lock_sock(sk);
-	/*
-	 * Serialize initial admission with sockmap's callback updates. Later
-	 * packet boundaries recheck native state and end a batch when they
-	 * observe a replacement.
-	 */
-	read_lock_bh(&sk->sk_callback_lock);
 	batchable = virtio_transport_rx_batch_can_receive(t, sk, len);
-	read_unlock_bh(&sk->sk_callback_lock);
 	if (!batchable) {
-		/* State or receive-buffer failures keep the regular lookup path. */
 		if (!virtio_transport_rx_batch_can_continue(t, sk, len)) {
 			release_sock(sk);
 			sock_put(sk);
@@ -2176,7 +2208,7 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 
 		virtio_transport_trace_recv_pkt(hdr, &src, &dst);
 		if (virtio_transport_recv_pkt_set_owner(skb, sk))
-			virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL);
+			virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL, NULL);
 		else
 			kfree_skb(skb);
 
-- 
2.53.0
