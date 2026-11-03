Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793679158;
	b=MAC/CnmsUCO2Y14LNvf3nlsGvfhfwrRmyhv1i6Hr49etQ+qh3IexeFFrdDGjSJyQc0Ry
	 oeNU6PlubPSEs7T4PbPdL4wGCAmdsTi7YOPKluA6dihb8oTtX3xTuSFLSQvEEgZaL13Ri
	 +k88nvyvO/m3PAZJYB8lLzUfWOKHk+PfZVj5nJdfi4+tZRBPuPNVhiJk+g7V1wbXjkiAf
	 FToGGxpU75BEXG20VxobmFpCxC7SjaeGghndf40HPTk3Vrg1jLlcTTBupJwidro0MOuLh
	 xG0iwKdV/PfAsOxKj6n+4kLa50MOK2ttrEJIc3a6oQ37YjxPWxNrIfevl12whbQN4fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793679158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rPw7FVQQb55NWDv1ECpivZUbEpxMXe57ZeNyV7jgnK8=;
	b=i0qtrT7vfiAPQeCs9nkDDm1tPoE9rLdU/Fw3klcssOyIEVEVAL0wGKh/j0DXLKAFPty8
	 NAymgJbNx2Bs1KCfg5viQOTcybzO86pPNcI1BS03kpoqXFWMgUvzl3TJ6bbGcsL0zjUkA
	 DavNOvYbYzU/UzfBKFeUVnSPjDLJDr8LrLofPledhI131r0oElIlQdJYnm/k3EwpZ8dpb
	 BLDuApQjUNmf8o5VtukTdA4Dx+GlzldnNBjF2qT3wd0W+goCIziryeStC0bvwMaDT2eUZ
	 NcPrRELHLCF6go1mFSjO16N/bJSJTdRo+lexxn7RCdHwqOJjOI8YeXWr/0d/y9DR5Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yodvlzDT;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE3F606A326
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 04:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FE3F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yodvlzDT
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so2319200a91.1
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 20:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793679157; x=1794283957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rPw7FVQQb55NWDv1ECpivZUbEpxMXe57ZeNyV7jgnK8=;
        b=yodvlzDTCEsqdiGMpwo5m4PJfJljPJYo90R4CS8fBrIUlAVyMfHgZFueg6BokZZslF
         7Ytt8Vx0g0EAWJL2p7slSQlRs7RPfs2D8w9Tp3mplUfj9qgpzEizRg3cmHGpK9nrGyo2
         dWZnl8M9orQP/QkHM/NoDY9miG0JV3+w4PoEFDS+KS7XLAk6sRsfCyIE1FiPoqLu4z9k
         9eTl7NFcCUp3//fPxK/ifIae9drOD7nJPwwWTxvqnH1CSyRM0eeFWYJL31x8oKXJ13Rc
         kcbjPEU0cAzSswSdWigWMJg+/tpQYY0fcpsHdx/xnHr8QjW+3tz0rW0npozGWImNQmEB
         8fuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793679157; x=1794283957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rPw7FVQQb55NWDv1ECpivZUbEpxMXe57ZeNyV7jgnK8=;
        b=0id4dC4uHAjCIz2iKwrEnhJT9V/7WOwB9sIb0ogj/oU8E5ijzbNATABl7YWJAJbD6J
         w8dD/JYAN0fr8nimFDXn2tdyYnV+y7+dQ8NRcvrwngDHAhBZf1RGG0J6ZmWpR1PMvqzS
         7L8mPbFSmqlMZEOxO/KCZExlo5z3L0Srqi85Zk4XaVm6q2317C42Yly+a5OVasCTI/2e
         Gg5dyzARz/HzF/kBfZH8IN0D+OS7fiES7Jp91yqFXeDAIHbteYTDX/XdEkK14joa0OE/
         jyZoshn6qDv4S7ovFl8NQRLsF75MNCbmqzt2OnYHo5O9JVHmsqT+w2Bl9YRgMQrHx6rx
         JpbQ==
X-Forwarded-Encrypted: i=1; AKwUvBycuISNfWtGFMahHIvKsJmTFnrbxo8MX8yf7ZpHpwk5SWudQcOTSb6duYRoMcmmBFvGoj4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9oaanj/AjBKJzphHTLaG9nY1XBMTxaXVQP1GZ1k/lWD65yB5cL
	+OOYwCvX16zIW3Mm5tV0JRaAR0iC5URUwxfry4vf6/FSj9zAeQevcSzN
X-Gm-Gg: AYBFou2lx2QQe/CYaMYJ90qZPIrD5IuVAiK41niiC5W8ZLqd0O/b/faF98Ll9KNhXXY
	/GstHocIXSXEH6W/p9fx/t4b75le6aBgf1wbeG3qKdL2IIDSJ65gnJ1+o59UV+XQMZRWUwRK+3m
	fNITTT4JETJk1uGgtwWeagpbR2vmRL0BFbG94lRGIu5zYkLHpn4QNwTccgI8PD25nFlYNSfn+Rz
	EDYuSUD3OsMvsJC9fOdFsVbGQT3QEyV26fivYzS4yt7umgKGH6YPjNdxWLeCZ0hTSkr516tCNVB
	/8hMwJaLi50eU1/0g+ax+vGvINHtq+cpZc+uz61QR8u2WmPmp9VKNQcPZQb0BqLMb2J9GoZZPU7
	C5QdC0CQKSGSgUH6D3NH0OH3QBcgeE4fDZsN6xElMzq2Dp+DKB9x5zT718/NkP40fKZdvW0CLa9
	emy9WKyPhBxs4Tase2wfnFcoZyuY3jJTgZD+Ja01CAxo4pGGJaXt7CrAnyLcDRuQXOvMHtzgZHD
	FRBQTR9Ds2JGPbvDR2RtDiDeEgoH8QY4Lq19evWpcs8/9GWe9Jg1qozYdVrKxW+fDpIR7WRuHto
	ZZSPu4k=
X-Received: by 2002:a17:90b:2b47:b0:3a2:b16d:928b with SMTP id 98e67ed59e1d1-3ae897a5c58mr9740533a91.46.1793679156506;
        Mon, 02 Nov 2026 20:12:36 -0800 (PST)
Received: from gmail.com ([2407:cdc0:f00f::117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6f010asm1941708a91.15.2026.11.02.20.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:12:36 -0800 (PST)
From: Jia Jia <physicalmtea@gmail.com>
To: netdev@vger.kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 3/5] vsock/virtio: amortize RX socket locking for stream packets
Date: Tue,  3 Nov 2026 12:11:32 +0800
Message-Id: <20261103041134.33310-4-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103041134.33310-1-physicalmtea@gmail.com>
References: <20261103041134.33310-1-physicalmtea@gmail.com>
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

The virtio-vsock RX worker looks up a socket and takes its lock for every
packet. Retain the connected lookup reference and socket lock across a
bounded run of STREAM/RW packets for one established native socket.

Reuse the locked socket while packets match the same flow. Finish the
batch on a malformed packet, flow change, non-RW traffic, or a change to
the socket state, transport, protocol, sockmap state, or receive buffer
limits. A connected lookup miss falls back to the existing receive path,
which can still find a bound socket.

Limit an uninterrupted socket-lock ownership interval to 64 packets and
64 KiB of payload. The payload limit is one
VIRTIO_VSOCK_MAX_PKT_BUF_SIZE. Small or zero-length packets still incur
per-packet work, so an independent packet limit is needed. The 64-packet
limit uses VHOST_NET_BATCH as a reference; it is a policy choice rather
than a protocol limit.

Beyond these limits, a larger batch would only further amortize socket
lookup and lock/unlock operations, while virtqueue work, validation,
tracing, skb ownership, credit update, and queueing remain per-packet. I
therefore expect diminishing returns while the uninterrupted socket-lock
interval continues to grow, but I have not measured larger limits yet.

Only the guest virtio RX worker is changed. The benchmark exercises the
host-sender-to-guest-receiver direction, where this worker is on the
receive path. I have not measured the corresponding worker and socket-lock
overhead in vhost-vsock or vsock_loopback, and they use different worker
and locking models. Leave those paths unchanged pending separate policy
and validation. I plan to evaluate vhost-vsock separately as follow-up
work.

Performance:

These results cover P1-P3, before the notification changes in P4 and P5.

Tested on a single-stream vsock connection (one Guest receiver thread on
CPU0, virtio-vsock IRQ on Guest CPU1, fresh QEMU Guest per state). The host
uses vhost-vsock.

For throughput, vsock_perf runs on the host as the
sender, with a custom single-threaded Guest receiver pinned to Guest CPU0
using blocking recv(). The fixed-64K table uses a 64K buffer; the matched
table uses the sender's request size. The virtio-vsock IRQ/RX worker is
pinned to Guest CPU1. To normalize run times across payloads into a
bounded, deterministic window and avoid long runs being skewed by host
background noise or virtualization scheduling jitter, transfer sizes scale
proportionally with the request size (64B/64M, 256B/256M, etc.), capped at
2G for 4K-64K. The custom receiver keeps the recv() size and count
explicit; vsock_perf's receiver uses poll()+read().

End-to-end RX throughput (fixed-64K receiver; Gbit/s):

  payload  baseline RX  PATCH RX  throughput change (95% CI)
           (Gbit/s)      (Gbit/s)
  64B        0.1285       0.2462    +91.59% [+79.74%, +104.22%]
  256B       0.5909       0.9666    +63.59% [+61.03%, +66.19%]
  512B       1.1817       1.8350    +55.29% [+46.76%, +64.32%]
  1K         2.3252       3.3600    +44.50% [+38.93%, +50.30%]
  4K         3.8436       5.5661    +44.82% [+40.30%, +49.47%]
  8K         4.6609       5.4115    +16.10% [ +8.91%, +23.77%]
  16K        5.1196       5.6399    +10.16% [ +4.07%, +16.61%]
  64K        5.6095       5.7062     +1.72% [-3.19%, +6.89%]

Fixed-syscall stress test (receiver recv() size = sender write size;
no perf; Gbit/s):

  payload  baseline RX  PATCH RX  throughput change (95% CI)
  64B        0.1446       0.2540   +75.71% [+63.67%, +88.62%]
       recv() calls (baseline/PATCH): 1048577/1048577
  256B       0.4211       0.9061  +115.18% [+72.13%, +169.00%]
       recv() calls (baseline/PATCH): 1048577/1048577
  512B       0.7980       1.6112  +101.90% [+95.30%, +108.72%]
       recv() calls (baseline/PATCH): 1048577/1048577
  1K         1.4965       2.6986   +80.33% [+68.93%, +92.49%]
       recv() calls (baseline/PATCH): 1048577/1048577
  4K         2.9384       4.8590   +65.36% [+60.17%, +70.72%]
       recv() calls (baseline/PATCH): 539544/524982
  8K         3.8170       5.1887   +35.94% [+27.66%, +44.75%]
       recv() calls (baseline/PATCH): 274857/262991
  16K        4.6856       5.5996   +19.51% [+15.36%, +23.81%]
       recv() calls (baseline/PATCH): 147518/131351
  64K        5.5182       5.8800    +6.56% [-0.83%, +14.49%]
       recv() calls (baseline/PATCH): 48492/32910

Guest CPU1 aggregate cycles per received byte
(fixed 64K receiver, with perf):

  Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
  64B        66.728    61.220  -8.25% [-18.99%, +3.91%]
  256B       14.363    14.515  +1.06% [ -4.22%, +6.64%]
  512B        7.792     7.578  -2.74% [ -6.55%, +1.23%]
  1K          3.988     4.032  +1.09% [ -1.64%, +3.88%]
  4K          2.063     1.973  -4.38% [ -8.23%, -0.37%]
  8K          1.702     1.667  -2.06% [ -7.99%, +4.25%]
  16K         1.473     1.475  +0.17% [ -5.06%, +5.68%]
  64K         1.385     1.358  -1.96% [-10.61%, +7.53%]

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |  23 ++
 net/vmw_vsock/virtio_transport.c        |   7 +-
 net/vmw_vsock/virtio_transport_common.c | 303 ++++++++++++++++++++++--
 3 files changed, 318 insertions(+), 15 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731057e..748633aa0cc81 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -282,6 +282,29 @@ void virtio_transport_destruct(struct vsock_sock *vsk);
 
 void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb, struct net *net);
+
+/*
+ * Initialize a batch to zero before use. A non-empty batch owns @sk's socket
+ * lock and the reference returned by vsock_find_connected_socket_net(). The
+ * caller retains both until it calls virtio_transport_rx_batch_finish(). An
+ * empty batch owns neither.
+ */
+struct virtio_transport_rx_batch {
+	struct sock *sk;
+	unsigned int pkts;
+	size_t bytes;
+};
+
+static inline bool
+virtio_transport_rx_batch_empty(const struct virtio_transport_rx_batch *batch)
+{
+	return !batch->sk;
+}
+
+void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
+				     struct sk_buff *skb, struct net *net,
+				     struct virtio_transport_rx_batch *batch);
+void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch);
 void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
 void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c3aa5..9af85712bd387 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -631,6 +631,7 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 
 static void virtio_transport_rx_work(struct work_struct *work)
 {
 	struct virtio_vsock *vsock =
 		container_of(work, struct virtio_vsock, rx_work);
+	struct virtio_transport_rx_batch batch = {};
 	struct virtqueue *vq;
@@ -666,6 +667,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			/* Drop short/long packets */
 			if (unlikely(len < sizeof(*hdr) ||
 				     len > virtio_vsock_skb_len(skb))) {
+				virtio_transport_rx_batch_finish(&batch);
 				kfree_skb(skb);
 				continue;
 			}
@@ -673,6 +675,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			hdr = virtio_vsock_hdr(skb);
 			payload_len = le32_to_cpu(hdr->len);
 			if (unlikely(payload_len > len - sizeof(*hdr))) {
+				virtio_transport_rx_batch_finish(&batch);
 				kfree_skb(skb);
 				continue;
 			}
@@ -685,11 +688,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			/* Force virtio-transport into global mode since it
 			 * does not yet support local-mode namespacing.
 			 */
-			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
+			virtio_transport_recv_pkt_batch(&virtio_transport, skb,
+							NULL, &batch);
 		}
 	} while (!virtqueue_enable_cb(vq));
 
 out:
+	virtio_transport_rx_batch_finish(&batch);
 	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
 		virtio_vsock_rx_fill(vsock);
 out_nofill:
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 2a9cfed085515..f83e5b2edce35 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -33,6 +33,15 @@
 #define MAX_COLLAPSE_LEN \
 	SKB_MAX_ORDER(VIRTIO_VSOCK_SKB_HEADROOM, PAGE_ALLOC_COSTLY_ORDER)
 
+/*
+ * Bound the interval that an RX worker owns a socket lock. One maximum packet
+ * buffer (64 KiB) bounds payload in one uninterrupted ownership interval.
+ * Small and zero-length packets need a packet limit to bound per-packet work;
+ * the 64-packet policy uses VHOST_NET_BATCH as a reference.
+ */
+#define VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS	64
+#define VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES	VIRTIO_VSOCK_MAX_PKT_BUF_SIZE
+
 static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
 					       bool cancel_timeout);
 static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs);
@@ -1793,13 +1802,94 @@ virtio_transport_find_socket(struct sockaddr_vm *src,
 	return sk;
 }
 
+static void
+virtio_transport_trace_recv_pkt(const struct virtio_vsock_hdr *hdr,
+				const struct sockaddr_vm *src,
+				const struct sockaddr_vm *dst)
+{
+	trace_virtio_transport_recv_pkt(src->svm_cid, src->svm_port,
+					dst->svm_cid, dst->svm_port,
+					le32_to_cpu(hdr->len),
+					le16_to_cpu(hdr->type),
+					le16_to_cpu(hdr->op),
+					le32_to_cpu(hdr->flags),
+					le32_to_cpu(hdr->buf_alloc),
+					le32_to_cpu(hdr->fwd_cnt));
+}
+
+static bool
+virtio_transport_recv_pkt_set_owner(struct sk_buff *skb, struct sock *sk)
+{
+	if (skb_set_owner_sk_safe(skb, sk))
+		return true;
+
+	WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
+	return false;
+}
+
+static bool
+virtio_transport_sock_has_psock(const struct sock *sk)
+{
+	return (uintptr_t)rcu_access_pointer(__sk_user_data(sk)) &
+	       SK_USER_DATA_PSOCK;
+}
+
+/* The caller holds sk's socket lock. */
+static bool
+virtio_transport_rx_batch_can_continue(struct virtio_transport *t,
+				       struct sock *sk, u32 len)
+{
+	struct virtio_vsock_sock *vvs;
+	struct vsock_sock *vsk;
+
+	vsk = vsock_sk(sk);
+	vvs = vsk->trans;
+
+	/*
+	 * Keep a connected lookup reference only for the native, established
+	 * STREAM path. Sockets outside ESTABLISHED can change table membership;
+	 * a completed or reassigned socket must resume the per-packet path.
+	 */
+	if (sk->sk_state != TCP_ESTABLISHED ||
+	    sk->sk_type != SOCK_STREAM ||
+	    sock_flag(sk, SOCK_DONE) ||
+	    vsk->transport != &t->transport || !vvs)
+		return false;
+
+	/*
+	 * Do not admit a packet that would hit an existing RX limit while the
+	 * worker owns the socket lock. The caller holds that lock, so no reader can
+	 * dequeue until the batch is released.
+	 */
+	return (u64)vvs->buf_used + len <= vvs->buf_alloc &&
+	       !virtio_transport_rx_buf_full(vvs);
+}
+
+/* The caller holds sk's socket lock. */
+static bool
+virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
+				      struct sock *sk, u32 len)
+{
+	if (!virtio_transport_rx_batch_can_continue(t, sk, len))
+		return false;
+
+	/*
+	 * Sockmap can replace sk_prot and publish a psock without the socket lock.
+	 * Check both at each packet boundary; a boundary that sees a replacement
+	 * returns to the existing per-packet path.
+	 */
+	return READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
+	       !virtio_transport_sock_has_psock(sk);
+}
+
 /*
- * The caller holds sk's socket lock.
+ * The caller holds sk's socket lock. If @batchable is non-NULL, update it
+ * after processing @skb to say whether a native STREAM/RW batch can continue.
  */
 static void
 virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 				 struct sk_buff *skb, struct sock *sk,
-				 struct net *net)
+				 struct net *net, bool *batchable)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vsock_sock *vsk = vsock_sk(sk);
@@ -1809,6 +1899,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
 			le32_to_cpu(hdr->src_port));
 
+	if (batchable)
+		*batchable = false;
+
 	/*
 	 * The socket may have been closed or reassigned after lookup but before
 	 * its socket lock was acquired. Listener sockets have no assigned
@@ -1852,6 +1945,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 		kfree_skb(skb);
 		break;
 	}
+
+	if (batchable)
+		*batchable = virtio_transport_rx_batch_can_receive(t, sk, 0);
 }
 
 /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
@@ -1869,14 +1965,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
 			le32_to_cpu(hdr->dst_port));
 
-	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
-					dst.svm_cid, dst.svm_port,
-					le32_to_cpu(hdr->len),
-					le16_to_cpu(hdr->type),
-					le16_to_cpu(hdr->op),
-					le32_to_cpu(hdr->flags),
-					le32_to_cpu(hdr->buf_alloc),
-					le32_to_cpu(hdr->fwd_cnt));
+	virtio_transport_trace_recv_pkt(hdr, &src, &dst);
 
 	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
 		(void)virtio_transport_reset_no_sock(t, skb, net);
@@ -1898,13 +1987,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		goto free_pkt;
 	}
 
-	if (!skb_set_owner_sk_safe(skb, sk)) {
-		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
+	if (!virtio_transport_recv_pkt_set_owner(skb, sk))
 		goto free_pkt;
-	}
 
 	lock_sock(sk);
-	virtio_transport_recv_pkt_locked(t, skb, sk, net);
+	virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL);
 
 	release_sock(sk);
 
@@ -1919,6 +2006,194 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 }
 EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
 
+/*
+ * Release an active RX batch. A non-empty batch holds the socket lock and the
+ * reference returned by vsock_find_connected_socket_net(). An empty batch
+ * holds neither.
+ */
+void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
+{
+	struct sock *sk = batch->sk;
+
+	batch->sk = NULL;
+	batch->pkts = 0;
+	batch->bytes = 0;
+
+	if (!sk)
+		return;
+
+	release_sock(sk);
+	sock_put(sk);
+}
+EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
+
+static bool
+virtio_transport_rx_batch_matches(const struct virtio_transport_rx_batch *batch,
+				  const struct sockaddr_vm *src,
+				  const struct sockaddr_vm *dst,
+				  struct net *net)
+{
+	struct vsock_sock *vsk = vsock_sk(batch->sk);
+
+	/* The connected table is keyed by peer address and local port. */
+	return vsock_addr_equals_addr(src, &vsk->remote_addr) &&
+	       dst->svm_port == vsk->local_addr.svm_port &&
+	       vsock_net_check_mode(sock_net(batch->sk), net);
+}
+
+static bool
+virtio_transport_rx_batch_can_add(const struct virtio_transport_rx_batch *batch,
+				  u32 len)
+{
+	if (batch->pkts >= VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS ||
+	    batch->bytes >= VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES)
+		return false;
+
+	return len <= VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES - batch->bytes;
+}
+
+static void
+virtio_transport_rx_batch_account(struct virtio_transport_rx_batch *batch,
+				  u32 len)
+{
+	batch->pkts++;
+	batch->bytes += len;
+}
+
+static void
+virtio_transport_rx_batch_process(struct virtio_transport *t,
+				  struct sk_buff *skb, struct net *net,
+				  struct virtio_transport_rx_batch *batch,
+				  const struct sockaddr_vm *src,
+				  const struct sockaddr_vm *dst)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	bool batchable;
+	u32 len;
+
+	len = le32_to_cpu(hdr->len);
+	virtio_transport_trace_recv_pkt(hdr, src, dst);
+
+	if (!virtio_transport_recv_pkt_set_owner(skb, batch->sk)) {
+		virtio_transport_rx_batch_finish(batch);
+		kfree_skb(skb);
+		return;
+	}
+
+	virtio_transport_recv_pkt_locked(t, skb, batch->sk, net, &batchable);
+	if (!batchable) {
+		virtio_transport_rx_batch_finish(batch);
+		return;
+	}
+
+	virtio_transport_rx_batch_account(batch, len);
+	if (!virtio_transport_rx_batch_can_add(batch, 0))
+		virtio_transport_rx_batch_finish(batch);
+}
+
+void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
+				     struct sk_buff *skb, struct net *net,
+				     struct virtio_transport_rx_batch *batch)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct sockaddr_vm src, dst;
+	struct sock *sk;
+	bool batchable;
+	u32 len;
+
+	/*
+	 * Batch only STREAM data packets. Control packets can change connection
+	 * state or send a reply. Keep SEQPACKET on its existing path: its EOM/EOR
+	 * record-boundary semantics have not been separately evaluated for batching.
+	 */
+	if (le16_to_cpu(hdr->type) != VIRTIO_VSOCK_TYPE_STREAM ||
+	    le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW) {
+		virtio_transport_rx_batch_finish(batch);
+		goto recv_pkt;
+	}
+
+	len = le32_to_cpu(hdr->len);
+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
+			le32_to_cpu(hdr->src_port));
+	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
+			le32_to_cpu(hdr->dst_port));
+
+	if (!virtio_transport_rx_batch_empty(batch)) {
+		/* A post-processing check cannot bound a packet already admitted. */
+		if (!virtio_transport_rx_batch_can_add(batch, len) ||
+		    !virtio_transport_rx_batch_matches(batch, &src, &dst, net)) {
+			virtio_transport_rx_batch_finish(batch);
+		} else if (!virtio_transport_rx_batch_can_receive(t, batch->sk,
+							   len)) {
+			virtio_transport_rx_batch_finish(batch);
+			goto recv_pkt;
+		}
+	}
+
+	if (!virtio_transport_rx_batch_empty(batch)) {
+		virtio_transport_rx_batch_process(t, skb, net, batch, &src, &dst);
+		return;
+	}
+
+	/*
+	 * A packet larger than the byte cap must take the regular path. Starting a
+	 * one-packet batch would already exceed the bound on socket-lock ownership.
+	 */
+	if (!virtio_transport_rx_batch_can_add(batch, len))
+		goto recv_pkt;
+
+	sk = vsock_find_connected_socket_net(&src, &dst, net);
+	if (!sk) {
+		/*
+		 * A connected lookup miss can still match a bound socket in
+		 * virtio_transport_recv_pkt().
+		 */
+		goto recv_pkt;
+	}
+
+	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
+		/* Let the regular receive path send the type-mismatch reset. */
+		sock_put(sk);
+		goto recv_pkt;
+	}
+
+	lock_sock(sk);
+	/*
+	 * Serialize initial admission with sockmap's callback updates. Later
+	 * packet boundaries recheck native state and end a batch when they
+	 * observe a replacement.
+	 */
+	read_lock_bh(&sk->sk_callback_lock);
+	batchable = virtio_transport_rx_batch_can_receive(t, sk, len);
+	read_unlock_bh(&sk->sk_callback_lock);
+	if (!batchable) {
+		/* State or receive-buffer failures keep the regular lookup path. */
+		if (!virtio_transport_rx_batch_can_continue(t, sk, len)) {
+			release_sock(sk);
+			sock_put(sk);
+			goto recv_pkt;
+		}
+
+		virtio_transport_trace_recv_pkt(hdr, &src, &dst);
+		if (virtio_transport_recv_pkt_set_owner(skb, sk))
+			virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL);
+		else
+			kfree_skb(skb);
+
+		release_sock(sk);
+		sock_put(sk);
+		return;
+	}
+
+	batch->sk = sk;
+	virtio_transport_rx_batch_process(t, skb, net, batch, &src, &dst);
+	return;
+
+recv_pkt:
+	virtio_transport_recv_pkt(t, skb, net);
+}
+EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt_batch);
+
 /* Remove skbs found in a queue that have a vsk that matches.
  *
  * Each skb is freed.
-- 
2.53.0
