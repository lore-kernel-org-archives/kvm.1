Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E4F32B113
	for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642221; cv=none; b=nbcWaZ+QNl16NXb6CdAk2Q41xQ5HQUv9VAK+4Et3YFFe2knA9P+CWPDpWbIBD9dW+bJRlPjpnRbVq4vz370rCJqnN3mxx0ajBvlUeoHfh+xZ6CWxZfL7LhQTkGPfXerg+j5RVUtfSgkBjhLzhJmckGzKjjghxRH4IVLWaBU7qLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642221; c=relaxed/simple;
	bh=SR265Jmv9EOllUtmFjO77CtNsAfQryl1UbcAKyqIvXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DS9lq/ZcAc8Htc01NvfCt/GsVLnzZSEhvkTWMdavH9dSYJcP2fLG3CGEVjMsKDuv2JjlAHpq8Eqd/M18o5CXY48Hklr4OPVUksG4IcOmJ0coKp7fXFuDLAV/j6OGmpvLGZLc9X7KiIfC47COvT80zj1NZd7rZsVAJQ7Ll7umoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6FWYlZp; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6FWYlZp"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ab2bf5e75bso267419a91.3
        for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791642220; x=1792247020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O1x0phht5NvvvSb25eom8J7EmXbou4YWYoQ1p3enTUo=;
        b=b6FWYlZpeOw2AkpFm30bLDPWOZnHarjo/92yhsI3gJXF7wRKadRQgySt86V3Ewucb+
         TzfQJ8H4eqPuDAAFBWgOpdwuPtx8cpIX4aYw9AzlkX4w7x2HBQeewGAVUUcOz1Dxpjyk
         A/puvD+rzH5zrHduqrrR74OqSjED8hEXwymazhe/ye3DbfNio3245+mvmJbk4arfEinp
         HQvM5RBbhYhTvnbkNvUtai4+OGmmolA53r9Xr1yNVq4oHtqm2yGRAR2WcBtP3G5bFmGr
         eouaNLWd5mwB7B9+2KwuS4WJKCCYkcVaaH4AsUe41KqPnbd+Yaknis9gGArr19EV2JFa
         YpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791642220; x=1792247020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O1x0phht5NvvvSb25eom8J7EmXbou4YWYoQ1p3enTUo=;
        b=nMeDGy+XZI33i6ukeTjY9Pyz52hP88h6bpSXsEKvqgbwK3IV9eTJ30RQjRe/F7HakO
         gfPLJ82EXmG49zvJ6EbMQS0vOeMnfuKt/UZ61kg1deSEXZG61qLfVRQDiOU0vJoIdX3o
         0gFLPrHKljZD8hDeVSpBG/Q3vefgaNP0nmYd8GzzArc2a1T49dKNFqNrrnHtKB6jublH
         9pbrKpzMnuUsV9Nu/VeX3YrDpE7oGQt9QGX88FWmfQLHvyh4ts7se8UnDLSqAZKFwApw
         /yNe2aTgukeNwHfrsAGv/zHaxDi0h2QHVJ0yAimmupS/NuSDHsxBI10RNSi2IclI8I6n
         C1og==
X-Forwarded-Encrypted: i=1; AKwUvBxsGCiZhYY7zSd4FqkEwQfm/pyE9qxdcpTfqljyS0ptWnzJorS99w8jYKYUaAxDTxWaIso=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlRLipvc6Mq0UbfaazRXO7ye29AGwN1p/lALry5ffPTsNJdzeK
	CPRCwaV5gpxGiTorsHaFzeC7CWyk59v2Sn93bVvZHsXXo6Q3M4heqT7W
X-Gm-Gg: AYBFou0qYpWtZ6IZQR2m1Spb2oSxDWgbTIwwNREUvulDagbYQbBU5BpQD4NAgSsq0R2
	OhAGdQewEIpXLV7aQWAGKfxg8bWoAuryiDG9+En3kSpjJ1FRBXmuwTtu3IN1FLFjq2XZvazOn09
	wlKVILL1PGBuN8A+VyVmNg4WN3YfeNVjnDJj+VOF3qvNc+vGYQ+fFaKlfXYaFcKGYv+Mi87MG6Y
	EDMRgOc1AzKR7uFIAhv0lhKIz0bY9ltyvtj4OdxByu1ItXw1uyg41uLtRfrRvIdCaByYm0oF2LI
	AK85HMJ6yl7xvjV16LURkpIvoFcPPg9BB9SD8P+eUZ7148Xa7Dv+9NrvkZ0zHnlPifO78Tv3aBf
	qUZKWJQI4E4wzU4y3BpzdGT1JBWhX+IsqcxRwceqAYIy+ssXkWH0xUh7z9srm0qL7snf3Cr7qNB
	UjwhJBN13kghfSYpbWLyMiOQEXHV6aI8Z7koMWcJIzVVMsfEXMkoMii+kmxKQCviWu77qFGAgae
	zuESkUK
X-Received: by 2002:a17:90b:48c1:b0:3aa:f4af:1e0b with SMTP id 98e67ed59e1d1-3ab3a32f599mr3976782a91.8.1791642219863;
        Sat, 10 Oct 2026 07:23:39 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a0401esm23676615ad.4.2026.10.10.07.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:23:38 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH net-next v2 3/5] vsock/virtio: reuse same-flow socket lookup in RX batches
Date: Sat, 10 Oct 2026 22:22:45 +0800
Message-Id: <20261010142247.99223-4-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261010142247.99223-1-physicalmtea@gmail.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An RX lock batch still looks up the socket for every packet and takes a
temporary lookup reference, even though the batch already holds a reference
to the locked socket.

Record the network namespace and packet address tuple when a batch starts.
Reuse the batch socket for later STREAM/RW packets with the same tuple, and
release the batch before looking up a different flow.

The cached path still traces every packet, takes an skb owner reference,
validates socket state, source and transport, updates credit, and runs the
receive state machine. Only the socket table lookup and its temporary
reference are skipped.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |  3 ++
 net/vmw_vsock/virtio_transport_common.c | 58 +++++++++++++++----------
 2 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 26dde6909c4e..d6528681e052 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -287,6 +287,9 @@ struct virtio_transport_rx_batch {
 	struct sock *sk;
 	unsigned int pkts;
 	size_t bytes;
+	struct net *net;
+	struct sockaddr_vm src;
+	struct sockaddr_vm dst;
 };
 
 void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index e67dfcaa279c..73e5c7dfe8b4 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1977,6 +1977,7 @@ void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
 	batch->sk = NULL;
 	batch->pkts = 0;
 	batch->bytes = 0;
+	batch->net = NULL;
 
 	if (!sk)
 		return;
@@ -2008,6 +2009,37 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 	virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
 	virtio_transport_trace_recv_pkt(skb, &src, &dst);
 
+	if (batch->sk) {
+		if (batch->net == net &&
+		    vsock_addr_equals_addr(&batch->src, &src) &&
+		    vsock_addr_equals_addr(&batch->dst, &dst) &&
+		    virtio_transport_recv_pkt_batchable(t, batch->sk)) {
+			sk = batch->sk;
+			if (!skb_set_owner_sk_safe(skb, sk)) {
+				WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
+				virtio_transport_rx_batch_finish(batch);
+				kfree_skb(skb);
+				return;
+			}
+
+			ctx = (struct virtio_transport_rx_pkt_ctx) {
+				.net = net,
+				.src = &src,
+				.dst = &dst,
+				.batchable = &batchable,
+			};
+			free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
+
+			if (!batchable)
+				virtio_transport_rx_batch_finish(batch);
+			if (free_pkt)
+				kfree_skb(skb);
+			return;
+		}
+
+		virtio_transport_rx_batch_finish(batch);
+	}
+
 	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
 	if (!sk) {
 		virtio_transport_rx_batch_finish(batch);
@@ -2018,33 +2050,10 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 
 	if (!skb_set_owner_sk_safe(skb, sk)) {
 		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
-		virtio_transport_rx_batch_finish(batch);
 		kfree_skb(skb);
 		return;
 	}
 
-	if (batch->sk && batch->sk != sk) {
-		/* Never acquire a second socket lock. */
-		virtio_transport_rx_batch_finish(batch);
-	}
-
-	if (batch->sk == sk) {
-		/* Keep the batch reference; drop this packet's lookup reference. */
-		sock_put(sk);
-		ctx = (struct virtio_transport_rx_pkt_ctx) {
-			.net = net,
-			.src = &src,
-			.dst = &dst,
-			.batchable = &batchable,
-		};
-		free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
-		if (!batchable)
-			virtio_transport_rx_batch_finish(batch);
-		if (free_pkt)
-			kfree_skb(skb);
-		return;
-	}
-
 	lock_sock(sk);
 	/*
 	 * Sockmap removal restores the native protocol under sk_callback_lock.
@@ -2063,6 +2072,9 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
 	if (start_batch && batchable) {
 		/* Keep the lookup reference until the batch is released. */
+		batch->net = net;
+		batch->src = src;
+		batch->dst = dst;
 		batch->sk = sk;
 		return;
 	}
-- 
2.34.1

