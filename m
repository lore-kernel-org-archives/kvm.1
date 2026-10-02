Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com [74.125.229.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D35447806
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927209; cv=none; b=gjcVVOwoAzWIMzzJppuFyH/6E20v6MokJ0HKk7kCuqT+oHlQVfnM81FrqQf85csQPNmVTuetGNMtztJnFAV6eUye8P7BHEtCyUdQHqbtd+wrLFd2/61SRgvFgkTnHW74kMtSNrR6nkB91L7TSvBUe8xPrrmaSgpj4eeKmqX034w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927209; c=relaxed/simple;
	bh=ECpIudvOKViun3w1C4dI/OFASlX7Xin37YE6bclQwPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WJuu3tGjmsIHYR0lcJSmSv5zlzKPuHaPrKYYNmjfG4C+wIZ9M+C2XBaUGu7J0/Qm1UWaqwEeDwtGPQcCrx0ZynmuFT7BcGJehGvLbT/bNpyJgACWC4V+e/mhvu6iuUTIEMb3LvGBoA60Z1PL+Ktk4pym7xdaJjbn7rWAQLXBez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5mwyeiU; arc=none smtp.client-ip=74.125.229.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5mwyeiU"
Received: by mail-dl2-f40.google.com with SMTP id a92af1059eb24-14ce76ce216so1953257c88.2
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790927207; x=1791532007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RwfN6fhmeAce3p9lwv6MLbjMM6fjV9W6UusRuCutcrU=;
        b=j5mwyeiUws4fjEb/ft/dgfhTu4vbDfFZrhD1LM1X8/PfjPnLILVr50YF/Yb8XYAbbh
         9X9Iil0UamBs0HdnZJc7uOXjz8mDYcSZXhMSueS6QbBTL0SwNIrsT2O11l/4ZUsFgWPX
         GgiRNh+cvu9tKfU/k4/laNhUFGdmkmaesjuiYag+3jm4YZFzpU6aMLK0uEABJvJU29EV
         bUA33UugdvY/kbfPRDjk89VhmF+fP5WAvRrWbYpqyPdPSkfD3wvmh14joAo2kwnQmrDa
         u9KFu8e2QkdDXZJTt1OGwa2GZhqnvXkAcwtaJtg0yDTwoadCMcKYruV7uRkJHdurG0mv
         gKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790927207; x=1791532007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RwfN6fhmeAce3p9lwv6MLbjMM6fjV9W6UusRuCutcrU=;
        b=WMuDZKDQb7QNmIR0Ao9JZtkQ+YEkJCEjXvcZuYbFsJ7mkbiwjqx+aXNeqNjQEyN7y+
         OgWokViTQCnYxU0qVPICZlkJISQYkSKPiOn4q8Fp0Kf+8dGGET6vE03JP+2xF5YxMHNX
         8yPfvjfUgQe3jPoDa52kVbnitn+r665sLTwAOKBmsSbDm4UMxrib99Qj7kU+5KAyLbaG
         CWELsott2bv+0n8Twlo7z7104W5l2FUzgN+VdGqdh8bzMbymoFhR6PEgj9tTFk89up5G
         dL6eMwajc7dBGWTh2MyJhYbmOwIdOhTgbgJR3+Bvfb8bTscFvHmxkHXcwoO4NyalIpzY
         OPcQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbhZkIpeIGlq+VB+13g87dWM9ELu9WSAhTXansbP/bjD2CQdx3m/I3rpSCabzd6AbSMP8=@vger.kernel.org
X-Gm-Message-State: AFuF++mvXBJIT46n8UoiZNUlEwQSBVNk6zAYxwY2od4i1MKCgbPNhPLc
	LsCA7JkrzOKMhYLKww4wfWn9A7dp9FXP3rc2KjMQlzXuSVef8l1M3BmA
X-Gm-Gg: AYBFou3TjSACEcd4UFv3wzerU1wBj7ODqV3i83szdM+XN0QaF2DabDB6H0Sti+ECHlm
	cQD0152GreSyGgaTdFM8X5Tyttv7Gn1knjX9K5MUiPIc1bm28mrEv5eHAqpbYyiiCzpHYJk6A+I
	PRn97LawSAojV1dJdf1GGMER/8vxwdM0wVb0Ml8Or97NQcwfPVKwzwUOnBx5H36wNibp+eiDmVm
	Rb5LJJ1mqiYdlWKkQVz7FFsqyLFCq4pjdiEknlv3DG377GrzAPBsHRaSgeuSus749ubZOZlvLZM
	lM2NoidJAfCPp9JpsvZaak5+BFy2XyAwWOVBdk0qOf4XPeWGoUDeaqEUwzYpdk/jOAlRICQ8o49
	GLkIDs0xDHnulxJi7a6jilEMKrbT4l4koEQ+ZFbGrSpQvJlTduQ6Znrmod0IL8G4hRbBiZ3ue4+
	P6UFhRPpWuq/DRKR0bXTpo699SqZIDKsgl274dFopnnwg//Iy8zhx12ZA1heyxpT3yR1E58Q==
X-Received: by 2002:a05:701b:4656:b0:14a:a6dc:9cd7 with SMTP id a92af1059eb24-14f592c2992mr1858635c88.2.1790927206407;
        Fri, 02 Oct 2026 00:46:46 -0700 (PDT)
Received: from dbg-srv ([123.118.75.63])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f0672c2d1sm5871618eec.4.2026.10.02.00.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:46:45 -0700 (PDT)
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
Subject: [PATCH 4/5] vsock: coalesce RX write-space notifications in lock batches
Date: Fri,  2 Oct 2026 07:45:50 +0000
Message-ID: <20261002074551.318789-5-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jia Jia <physicalmtea@gmail.com>

Each received packet updates peer credit and calls sk_write_space() when
send space is available. A writer cannot use the newly advertised credit
until the socket lock is released, so repeated callbacks within one lock
batch cannot let it make progress sooner.

For the callback installed by sock_init_data(), record one pending
write-space notification and deliver it immediately before release_sock().
Save the initial sock_def_write_space() callback when the AF_VSOCK socket
is created because it is not visible to virtio_transport_common when built
as a module. Custom write-space callbacks retain per-packet notification
behavior.

Set the batch socket before processing its first packet so a batch
ending on that packet cannot lose the notification.

Packets outside the eligible STREAM/RW batch path retain per-packet
notification behavior. The 64-packet and 64K limits cap the packets whose
notifications can be coalesced.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |  1 +
 include/net/af_vsock.h                  |  2 ++
 net/vmw_vsock/af_vsock.c                |  1 +
 net/vmw_vsock/virtio_transport_common.c | 30 +++++++++++++++++++++++++-----
 4 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 4369adc07..f67fa99ec 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -288,6 +288,7 @@ struct virtio_transport_rx_batch {
 	struct net *net;
 	struct sockaddr_vm src;
 	struct sockaddr_vm dst;
+	bool write_space_pending;
 };
 
 void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 5549298c1..9d8ae6220 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -63,6 +63,8 @@ struct vsock_sock {
 	u32 peer_shutdown;
 	bool sent_request;
 	bool ignore_connecting_rst;
+	/* Initial callback, used to identify replacements. */
+	void (*default_write_space)(struct sock *sk);
 
 	/* Protected by lock_sock(sk) */
 	u64 buffer_size;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 9b71479a2..e5290a3bb 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
 		sk->sk_type = type;
 
 	vsk = vsock_sk(sk);
+	vsk->default_write_space = sk->sk_write_space;
 	vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
 	vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index d8c9c90c0..78c4e2f9e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1835,6 +1835,7 @@ struct virtio_transport_rx_pkt_ctx {
 	const struct sockaddr_vm *src;
 	const struct sockaddr_vm *dst;
 	bool *batchable;
+	struct virtio_transport_rx_batch *batch;
 };
 
 static bool
@@ -1882,8 +1883,14 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
 		vsk->local_addr.svm_cid = ctx->dst->svm_cid;
 
-	if (space_available)
-		sk->sk_write_space(sk);
+	if (space_available) {
+		if (ctx->batch &&
+		    READ_ONCE(sk->sk_write_space) == vsk->default_write_space &&
+		    virtio_transport_recv_pkt_batchable(t, sk))
+			ctx->batch->write_space_pending = true;
+		else
+			sk->sk_write_space(sk);
+	}
 
 	switch (sk->sk_state) {
 	case TCP_LISTEN:
@@ -1963,13 +1970,18 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
 void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
 {
 	struct sock *sk = batch->sk;
+	bool write_space_pending = batch->write_space_pending;
 
 	batch->sk = NULL;
 	batch->net = NULL;
+	batch->write_space_pending = false;
 
 	if (!sk)
 		return;
 
+	/* Notify before release_sock() to order it before a sockmap attachment. */
+	if (write_space_pending)
+		vsock_sk(sk)->default_write_space(sk);
 	release_sock(sk);
 	sock_put(sk);
 }
@@ -2015,6 +2027,7 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 				.src = &src,
 				.dst = &dst,
 				.batchable = &batchable,
+				.batch = batch,
 			};
 			free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
 			if (!batchable)
@@ -2049,11 +2062,14 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 	start_batch = virtio_transport_recv_pkt_batchable(t, sk);
 	read_unlock_bh(&sk->sk_callback_lock);
 
+	if (start_batch)
+		batch->sk = sk;
 	ctx = (struct virtio_transport_rx_pkt_ctx) {
 		.net = net,
 		.src = &src,
 		.dst = &dst,
 		.batchable = start_batch ? &batchable : NULL,
+		.batch = start_batch ? batch : NULL,
 	};
 	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
 	if (start_batch && batchable) {
@@ -2061,12 +2077,16 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 		batch->net = net;
 		batch->src = src;
 		batch->dst = dst;
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
