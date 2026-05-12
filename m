Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B0480DEE
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573266; cv=none; b=W8RzGdqjtokFK0lSQdqT9vAmKYmIu0lQIGYNfqVNji7NX/nbExP699zSHVr63RZpbtd+HaV014OBDsD53rBb71HZyaAsiaiWKzmPTEeGXh4J0WdjgH+GF1bxKnxgR8Y79uDmmgrV4PpwmmS1PC0fdoRiSBbWUA2vjhfgWUcGjis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573266; c=relaxed/simple;
	bh=sDobT2Y3suLHnIc3YUUU79mcvRr9manOsYeGpx1/XLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bxbwhU6FBmZvScB9pKsRPAugD9maoIxngxn7XqB0QMRMh/vbz+Y4oztxSbKCLQT/YC+OX/bj71Ai98JJ66i9mNCS3u1MeWzirZBDAVpbJCPYOfjelyRcyI0muTPf1uJf8M+c5Q1pC9kyykNMCK4zXCB+x5kRNvZlPQNCo6WCEvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/jGe/Jv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s/8bvbAi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/jGe/Jv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s/8bvbAi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778573264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aAlloYEZDF1UlqHHhoebVA5d4jsXxGoTRkEIcdVVNEs=;
	b=B/jGe/Jvz2N+KdyNQqYdlDMCUqtBJgiqS1Y0MhPOReGCl1syduBXR9S/ozurKeImILj+MK
	Fl9Vq97kT1NjpiPQnfQevb60yISPJM7gvCganj1iK+xoDYmPF4PKZ+EBqBu0HiUwHXHxj+
	gHgPKl2SekKnoer39gj88Fii7JeWXw4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-CT_rNiF3PNGsQh_oQPe1UQ-1; Tue, 12 May 2026 04:07:42 -0400
X-MC-Unique: CT_rNiF3PNGsQh_oQPe1UQ-1
X-Mimecast-MFC-AGG-ID: CT_rNiF3PNGsQh_oQPe1UQ_1778573261
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48e79219704so15096715e9.1
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 01:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778573261; x=1779178061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aAlloYEZDF1UlqHHhoebVA5d4jsXxGoTRkEIcdVVNEs=;
        b=s/8bvbAiTgWHzqMFzO5LCTsm4ttElr/944xDpNhCjj+PW1zi31G2o6J/esr5RcvYH7
         rJVR9yEHwd5cukHjZe97Xykb8aw9UPIAjB68EjhGH0H8+lxZHG4ZfPIZM6ZGG9ZRE0+d
         /f5DOzcR9xFFWHeCoMJM4Pi4Td95ezD7uE6QRahUaZQhpIZxouTZQG6z9DTAVsl7Mihz
         qDOs7kOBUvRAsk8sS8mIYOsuSzGCVcDM7fGVJXjfgWtA7bbySdkID9zXRo8jOv5vRhGB
         rqZQ78AjVCjAZBOhJeY6CZsswQmg5g7P/RN/aD3KGFt7kXd1gD2B35NqAfnT0TvP5/At
         JjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778573261; x=1779178061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAlloYEZDF1UlqHHhoebVA5d4jsXxGoTRkEIcdVVNEs=;
        b=c2mMpHMgVeebmlULXnHfPjBGFT2XczHgJZRZ9D5x4SFJ7PShvlMijHHP0QS3IfBkbE
         2ZTj8VASarigH27yY/SvyA2ooimsHI+tzvAKMJzltqH43tmWoPpiZ+lmTa3gwEy9casQ
         w/ozO4Qxommg7Oy0P82Q/v/tQWG07otXabH4xAvrccXFAF8Gq/Qquv/qBYGXTb8CAWAE
         KNyYKsYEgHXC0jM1Y/QrbrkRJ1Z482uAfu33Ac6soAEby41/mz2iWXxMqim6jH/ZmZX6
         CysdbB6fXONupdXAN5AYDweoVvbQvA7xxHeP8KKHIBXeQbZwjq+NxABhBsZ9K/xlVOAD
         IPAA==
X-Forwarded-Encrypted: i=1; AFNElJ8fDDy5iJCI8kuzABHydcrTbG9PJK4uFmS7Gi2SHf2VB9vhGoyuYjklCbtfKDUTXGvOowQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8w5PaOmMCH6ITHnySu8YKg60mjpghqUysOXMWwKqJ2cNb3Gto
	dexkluUOLU+2pSUSwZ8qW8yUcF0F0qhxhsvt/0NanFYBVnl18AUCjRiDOtUjrMwquGBAUw8alkL
	teCGp/gHFnqVzcG4XiffxU2pOlqim2Bd7MPiOfpEYUlgKtJI2IW3rgQ==
X-Gm-Gg: Acq92OElcmjgHGuo1iI40bp/hupqhNxEnIH+roCDNShdahZql4iwJRt5FnPdPrlGGXJ
	S1UrggAIPS+CcB0LpmAB/boXT/ZHKQslid1Ae1oKpL3yc4YsPDbOiLXIwgtT68l5NnpM4lc1Pii
	1ezRLRnocwXsgzz8eUChGiu8Om45ymANvC1v95bakxla2IJbTt4/BaS3yQaSKl64kc/G1thd4B9
	QEhTOZBnY9v2IAn5Yo8e5W7CnxyB35ErsUqyhWTJntQWCI3UeRN65aWLIUzC6qqUBxN/ST8UskC
	OdqjYdBrhPatra321i8dVP1T7OD7O13GKhL1o490EmqlbiB6Pp60zDnc6AaOEZ+jFicpkR3dp7h
	acpTKqsbs9FAktmh4nOB49EDen2aGStXQI3VfptbJK6WhH4NFCFF9Ij/VJVjN
X-Received: by 2002:a05:600c:83c5:b0:488:9fb7:376d with SMTP id 5b1f17b1804b1-48e8fe834f0mr28133935e9.28.1778573260825;
        Tue, 12 May 2026 01:07:40 -0700 (PDT)
X-Received: by 2002:a05:600c:83c5:b0:488:9fb7:376d with SMTP id 5b1f17b1804b1-48e8fe834f0mr28133145e9.28.1778573260301;
        Tue, 12 May 2026 01:07:40 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e90677b04sm26948005e9.11.2026.05.12.01.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:07:39 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	kvm@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH net v2] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Tue, 12 May 2026 10:07:37 +0200
Message-ID: <20260512080737.36787-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
buf_alloc when checking whether a new packet fits. This reduces the
effective receive buffer below what the user configured via
SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
silently dropped and applications that rely on the full buffer size
to deadlock.

Also, the reduced space is not communicated to the remote peer, so
its credit calculation accounts more credit than the receiver will
actually accept, causing data loss (there is no retransmission).

With this approach we currently have failures in
tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
test 22 always fails in this way:
    18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch

    22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
    Resource temporarily unavailable

Fix this by using `buf_alloc * 2` as the total budget for payload plus
skb overhead in virtio_transport_inc_rx_pkt(), similar to how SO_RCVBUF
is doubled to reserve space for sk_buff metadata. This preserves the
full buf_alloc for payload under normal operation, while still bounding
the skb queue growth.

When the total budget (buf_alloc * 2) is exceeded (e.g. under small-packet
flooding where overhead dominates), the connection is reset and local
socket error set to ENOBUFS, so both peers are explicitly notified of
the failure rather than silently losing data.

With this patch, all tests in tools/testing/vsock/vsock_test.c are
now passing again.

A solution to handle small-packet overhead efficiently also for
SEQPACKET (we already do that for STREAM) is planned as follow-up work.
This patch is needed in any case to prevent silent data loss, because
even if we reduce the overhead, we can't eliminate it entirely.

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- Close the connection when we can no longer queue new packets instead
  of losing data.
- No longer announce the reduced buf_alloc to avoid violating the
  spec. [MST]

v1: https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/
---
 net/vmw_vsock/virtio_transport_common.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9b8014516f4f..f23bf8a11319 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -449,7 +449,10 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 {
 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
-	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
+	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
+	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
+	 */
+	if (skb_overhead + vvs->buf_used + len > (u64)vvs->buf_alloc * 2)
 		return false;
 
 	vvs->rx_bytes += len;
@@ -1365,7 +1368,7 @@ virtio_transport_recv_connecting(struct sock *sk,
 	return err;
 }
 
-static void
+static bool
 virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 			      struct sk_buff *skb)
 {
@@ -1380,10 +1383,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_lock_bh(&vvs->rx_lock);
 
 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
-	if (!can_enqueue) {
-		free_pkt = true;
+	if (!can_enqueue)
 		goto out;
-	}
 
 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
 		vvs->msg_count++;
@@ -1423,6 +1424,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_unlock_bh(&vvs->rx_lock);
 	if (free_pkt)
 		kfree_skb(skb);
+
+	return can_enqueue;
 }
 
 static int
@@ -1435,7 +1438,16 @@ virtio_transport_recv_connected(struct sock *sk,
 
 	switch (le16_to_cpu(hdr->op)) {
 	case VIRTIO_VSOCK_OP_RW:
-		virtio_transport_recv_enqueue(vsk, skb);
+		if (!virtio_transport_recv_enqueue(vsk, skb)) {
+			/* There is no more space to queue the packet, so let's
+			 * close the connection; otherwise, we'll lose data.
+			 */
+			(void)virtio_transport_reset(vsk, skb);
+			sk->sk_state = TCP_CLOSE;
+			sk->sk_err = ENOBUFS;
+			sk_error_report(sk);
+			break;
+		}
 		vsock_data_ready(sk);
 		return err;
 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
-- 
2.54.0

