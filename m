Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97DD2DB785
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927205; cv=none; b=bKEIG5Iv16ZuTJYA4E7UvOpI/xg5mXq7Vc/nWcjBuEhRSazsQVDtpN0BvtnUdNEyngjJpABqMP0sqjiUglgXWX5bV2ydfS1Ur+HOZvnDGy7xXSSvVSYoYYipTrXUHVhSU0QZCvRpauHBv+exjp1QjLWvOug4J+ESgyDLPFzw12E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927205; c=relaxed/simple;
	bh=Gi+4nfEvuXQGlo0g5mXVBj1pECSfFNUb6sc20UM6ULY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mM3zdQOABrYk1IL2kXQsbRGWNadSfgFJ3eH0ro+B/i9IbkpWhxTtwe0k48kdY62Sn0SWrAStYJIgeXh0WAjPpaZ0nMEy6VZFtPYVqulHEzAQS3C5iILqrCasPYhY/i6i6nj3LdL5o6U7k4v1UFs3/+ZhFrfC9zE1NJQrz8iOSAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcdGXZGR; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcdGXZGR"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1460bcc512eso4511052c88.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 00:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790927202; x=1791532002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xcvM+ew7yM+UK9bAQwqe/0F9zFjnDuHgdGa2U9rD4LU=;
        b=PcdGXZGR3Y8SwYoY/KEEELjbUPqpAU64qQ1KnBqM7YopwR19pRB6oSEwrMLBl/KYMm
         MLNMOE2PPoMT/vxUTaEoDvy5nKKsQwSPiLslyusOkbLjpKz6cBglQ1/Wlx7mM09JAvJI
         21vmmzoG6PF4uEdGHzsH2HYjs1jg3V5Inj1HdovXJpvPRLExOuUjBXWTKi+10L+ar2U4
         EdkNUJKgFX8m6/vFaX3312L7uRZNvS0y3ZW73kkJ5WTwzhdh/uL37BWjC3etmVBPKfJb
         yehXVLO2+6pRDZovQGjtZFdnzuqUigzQor9BQk0KOqL4EuE9eMu7EjCi7/Ir1T/IvabB
         /NRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790927202; x=1791532002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xcvM+ew7yM+UK9bAQwqe/0F9zFjnDuHgdGa2U9rD4LU=;
        b=ubFsfwyp2Gkx5BWHChsioTToLeqHK90+nm1zhBYVII+QymPfkmocqxXqNDgO36szAR
         FSculzyt9+FQDQxKLSu3M85KAJ1cm5BnNj3YGlp+6ZE/WOiItXAK1hwhO93sGKtnPzs+
         UFUwV0111y7ny4K0huPyoD4YtATXmVta44Sgb8eXUJFOFFnStcdihTJY8/uLVBM5HWuG
         QjXQ1vjtgVTASU1LY5jRJ9kRPM2bPBOg1O7BTyOQb6iVmNbqETxngXXHf+f5cWMDI2be
         d5co1Hx8pvWtfGIRA7rNrUo95feTA9c0tjjFFhl8FwHfqSE03Ah88Brcf0IQ2rVgWhXH
         MbZg==
X-Forwarded-Encrypted: i=1; AKwUvBwPryZmN82jxUgPrJGEuJASfznvIeYwspIh9BrnpqEKa2pXWHCCBI2tLxH7VlMpo9lTwWg=@vger.kernel.org
X-Gm-Message-State: AFuF++mEL7EK23zR+JL70KjPWhyPcuiK3WHsPmbGEEL/PzaPrus5lnoS
	y8S6SMVNvH63YIUvRAKI6tSedsRC5PgxfK2NI/m4QDzkDmsdrPx+ijEf
X-Gm-Gg: AYBFou1/P9hbZWWZzHkdEEDsS8tjZUEYPfeXljtHIrZ+3b7uflxdsT94phrdRZ2lM63
	gMxP9OKDSVXZeQM1A3OM88Gzxy44TtOOHBQxSvSFZ14Lozb0zH30bImtZ347Fd2CFYh6ZY6wUx1
	dv3/eJ7EW/8XRewy9ix9ZUhE0dATeYdriIy5NQKx2IlRh4sUwpr4pRHXs/fTqXkAOAxGkwxYxZ5
	vjxeg+clSqByeiVPSOyGoVtXBu/ztU5n30JmCkouSIBmIvcGF/GCWAOK7u5Mmtt3Ydw8REc81Az
	3bP75HL4mFkizM30WlaCpybIrX+AZzoMY2VRsvjT0qJbhEKqKm7AkKWROibI37ovLepxL1WGbTQ
	pem8FDiXEXbEHy3YQeW1lVnFnwFHyZHLk0za6QYa7F19w9t9PtMH7SvOqL/G6+aU/T36iEUOB7a
	QYi3BJjg0OL8LPcbFZhdhvcgB4YRrBF7TQ00N1On9Z/TrSTvZDZD6Pp4tycKhvD+RZUGfax77YE
	BJcwLo=
X-Received: by 2002:a05:701b:2096:10b0:143:2719:566e with SMTP id a92af1059eb24-14f5d3b9a1fmr1967596c88.42.1790927201379;
        Fri, 02 Oct 2026 00:46:41 -0700 (PDT)
Received: from dbg-srv ([123.118.75.63])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f0672c2d1sm5871618eec.4.2026.10.02.00.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:46:40 -0700 (PDT)
From: physicalmtea@gmail.com
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com
Cc: jasowangio@gmail.com,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] vsock: reuse same-flow socket lookup in RX batches
Date: Fri,  2 Oct 2026 07:45:49 +0000
Message-ID: <20261002074551.318789-4-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jia Jia <physicalmtea@gmail.com>

An RX lock batch still looks up the socket for every packet and takes a
temporary lookup reference, even though the batch already holds a
reference to the locked socket.

Record the network namespace and packet address tuple when a batch
starts. Reuse the batch socket for later STREAM/RW packets with the same
tuple, and release the batch before looking up a different flow.

The cached path still traces every packet, takes an skb owner reference,
validates socket state, source and transport, updates credit, and runs
the receive state machine. Only the socket table lookup and its temporary
reference are skipped.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |  3 ++
 net/vmw_vsock/virtio_transport_common.c | 58 +++++++++++++++----------
 2 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 95ab1a75f..4369adc07 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -285,6 +285,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 struct virtio_transport_rx_batch {
 	struct sock *sk;
+	struct net *net;
+	struct sockaddr_vm src;
+	struct sockaddr_vm dst;
 };
 
 void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index ad1e99689..d8c9c90c0 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1965,6 +1965,7 @@ void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
 	struct sock *sk = batch->sk;
 
 	batch->sk = NULL;
+	batch->net = NULL;
 
 	if (!sk)
 		return;
@@ -1996,9 +1997,38 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
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
-		virtio_transport_rx_batch_finish(batch);
 		(void)virtio_transport_reset_no_sock(t, skb, net);
 		kfree_skb(skb);
 		return;
@@ -2006,33 +2036,10 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 
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
 	 * Sockmap insertion takes the socket lock, but removal only holds
@@ -2051,6 +2058,9 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
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
2.53.0
