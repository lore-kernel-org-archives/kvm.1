Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522910;
	b=H/sYYvE7OUbbA2uycWJtV9NvPozGhnBN3bikkd7NagDKeBbEJszRLUYOuzHP5mvctyIz
	 6Ty2osYgDmUbSxROVGoe+osd3cCBRWlGbR3sywKjIxVEkoFVZzEKd1NdOCs98H1AlrGn0
	 PyMXuoGiVJKzQt3a4HnCfJFLpZCk9yNzcjmU2oo8U+ftaW5K0UZQFlRKQgngd/0Ivb5I9
	 MeCgUtADzmGlazBgdimB5WonuPXyeWxQy61UrO2Sy4V36CyCox36AWdov818RDOL7YPh5
	 Gaq0TgAPSQKzdc3TIhVnVQ2PvqWIBDhE+pdxBkaCGkor8uUKNpvJlxkv2nHfpsX7lrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522910;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=An4jSmGsGE4WjY8DUPQRbmmn/bQEfnKs/xvy7gJbYxw=;
	b=M3c/cflqRZItFJN2h4EE1DxRY/CHjdhXrmP8gGTt2ROP6wfzOpYneafudpN3w/iVBlFR
	 4hctjbDojMH/lfEEndUVokqNiR/YF/JorB2e8E6BwPYhH8u/ZUI7+l6voJljfsQowaALr
	 paplRr/wNIMT0qG/KotYxZhiBJgpXCgZV5LFXIZw5DmNgL2vLT7037GlP9Zd+3PwEfjha
	 IJ2fXLOV9oVTU5NEEBYejv0ozMOCd6PhL9wVO1DZ+458R/FxtuzRMNEIJSuZQBr+9FEMq
	 BocVHRharF3V2pQzsQSu4FLColnDYzMP22ZdAnloKaJJBv/rpSW9ZuvMeDXFUJkIW3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GQeLo2Dh;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ojXC+NO3;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F64760A260A
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 12:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F64760A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GQeLo2Dh;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ojXC+NO3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795522908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=An4jSmGsGE4WjY8DUPQRbmmn/bQEfnKs/xvy7gJbYxw=;
	b=GQeLo2DhVwV8djehcyKp8XxWwc6sy+OnEO06otHE8MlMZz4Qog4Od9vtUS24BcV6YDQrB9
	OLeYkt2mUNrCVXqdemDXqmJUr14zYgW1HYJIncW9QQ2CoLRpOuLg0Cd+DrJ3M8tBcJuREB
	5K/sCZd9/gm1VgL6ek+2Lakxtps+KPM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-pld3RPfePkms8upwvoW7AA-1; Tue, 24 Nov 2026 12:21:45 +0000
X-MC-Unique: pld3RPfePkms8upwvoW7AA-1
X-Mimecast-MFC-AGG-ID: pld3RPfePkms8upwvoW7AA_1795522905
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4bb8ae35aeaso37056075e9.3
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 04:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795522905; x=1796127705; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=An4jSmGsGE4WjY8DUPQRbmmn/bQEfnKs/xvy7gJbYxw=;
        b=ojXC+NO3qOFx2X7ethw4kx+G2JNne/8cktrbWBEqPuBiUwfDxHQNyhD0gxJYVHub7Z
         mFquBNTzvA+9saOI3R8rFRLZm4fCPeYcfAiPX6o7DJwuHHf1Z80MWaAv4obqOjvmV+U/
         0uE+W/OdnZhL42Dl8+CtZg7Rd99KzK3TNO/OJxPDtxZijGA9yCwoLhGBKWg6HVUMp42o
         Rp0U2C9HPDZ1O1LQo3Rof5/C75x/AebtTv6BbabPsd0Rwvh37Oh2OjOcrj0B8hDJj9tQ
         dk73TElXl/X48kRIjSP+CJf/ArCuSx83b+k3UQUHRVq1BDQOgytksYC1QXUY9VOgZIo3
         pu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522905; x=1796127705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=An4jSmGsGE4WjY8DUPQRbmmn/bQEfnKs/xvy7gJbYxw=;
        b=juIeJKUW/uqgKVEQ6l9+p0AiEZBCrfbOknDXXEibPLHfYdcr4PtOFml/7ttgFNdcRi
         iH+usLyNCR6Zetz7Gv75RvwvKwhKN/uOE/Z6XlZSIjEYnNxnS9rJGugCm6YYHN9X9gMZ
         up0+udRdS5nXLNwpFmzzphrBgRAubiEb9QiOHZH+lnyY2pjFsS/X/J8+wXiehB3WYenU
         aBuVuNeZUIz4wopNYnscTKfF/Q0BGUi69hYf5wbqOzSADL1Lpt+JvvTXxX6Nfkh9wcAI
         JRbpvFlQ9yvg4LSI7PKq45LcnziAQ0QO9O/7fvSLOuTiwBZ11eipymku/26NTONtNbFG
         Iu0w==
X-Forwarded-Encrypted: i=1; AL+hErFZk4ZhvQkX890xJz2VTqjf3lK6WF1/cBiDZtlADR8tWNc4MDxFTjLld5af9klLUmVj4KM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oOKt7SM3QPcAhrfcLmEVyWwC6FFh3FbxWP8Xr2n4V8JrepeRl
	h39tp0ByvYbyzHi/4LF5Edz6BsmMV/BZMzN67QdWBK6rfgH5kdtmc1QG8TM/gpgW3nZNgjj53c/
	IOsLIks6DHz3sAYFzodY1ZHki+GBT12MKC/3yT8QwPF0/rDJg0rRxYA==
X-Gm-Gg: AZFdTZf2yYBD1ekp9+J4WWbokrRjwYDlLDCXSkSQn5fno7WQ99aFZeKF601urhC1qXQ
	fxtUOvNU8NojuBupcGP5Z66zjdfL20HV9lkJWLnALRbd6mEbOd3hTVW/jKHvxCq4Mx9bRD0lUCU
	Qwl58q0ekuEL9ymRmFQ8giBey+0oWQ2i5DniKeH/4Fna/8aOZeXPuoxr4ayca/TItyGWMbwRE/w
	Hjoce/hV8bvLmZlQy+JbAkjQtkndqJ0RS6CtyoaF/hI2bnrnZ7gpBIo3jsaK/lpQn4Zuf0ip1xi
	qpbvZU5h7HtD7hiUIAzbcMVEkx6gy5hR2ex8uqMzQ5cXWxxklIuMDDUT3BDN6WjZrOse9tT7ed+
	grdDgyzGhzzUAjWZ6KuHPbofr41Zl2Ygtxh9tjwqTMx2fY2JjYPY8NFQfz6PofFb3pZcClfOUKm
	u02NMlIOI8kdg=
X-Received: by 2002:a05:600c:e40b:b0:4bb:9a6c:8712 with SMTP id 5b1f17b1804b1-4bb9a6c8724mr89331855e9.12.1795522904474;
        Tue, 24 Nov 2026 04:21:44 -0800 (PST)
X-Received: by 2002:a05:600c:e40b:b0:4bb:9a6c:8712 with SMTP id 5b1f17b1804b1-4bb9a6c8724mr89331255e9.12.1795522904011;
        Tue, 24 Nov 2026 04:21:44 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm22753198f8f.35.2026.11.24.04.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:21:43 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Tue, 24 Nov 2026 13:20:25 +0100
Subject: [PATCH RFC v4 7/8] vsock: fragment datagrams across receive
 buffers
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-vsock-dgram-support-v4-7-3607484e85e8@redhat.com>
References: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
In-Reply-To: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org, Sashiko AI bot <sashiko-bot@kernel.org>, 
 Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11596; i=slp@redhat.com;
 h=from:subject:message-id; bh=vM1P94iG9xHqAWI1O79rn6/GKJ4BHnh2w+8OVN/6oeA=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBrBYFIGnQgsnxvfMnzd4CRQYk/2fJ5zE2UsRh0b
 2PT5U8I++GJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCawWBSAAKCRD0aSeNLwwC
 NaT0EACgrLsUKrxOMdn6dPB7egrpmFB0hLP9XP3wtg6o7mVyEbf8k5jIy75TRkzRkEXjUgexDHt
 G1ftdhPzX+WNFlL4b02lCdNwoCvsF2S1UvOud0pV42T8t/DXvExdrfGiN1hTmlbPfaH6rfA670l
 4EFnyjpXLOCxFYk+8IXooRa18UnLfGBEzjHovXHTwk/cTTRi8rws0EL3vtbklfmTwlQVZmPG+Y5
 y+wAbdRs3siWCVBNwTKPNvD9JBcVWtlUQUL9Fame9qlx/QeeusdzEx8v24VE2yvZX3epswJqOM4
 5Hbma36/Lz8Fe8sUoqv2ZgMceYBCgcHTQ9mGDxjwlE3eP9ACNcUqNuh9dXc8ivNI0Q24lFLy4EL
 oUimV7fcfnqaQUdJZA7/+KOBigCMhgPRZlWjnFrYbNSxshxQpzj1vwAAGg0EVxKhU7Fk9uI1zMr
 na4jdqCZa0+8lAV9VM3yPFUiurbXU1E/aKmIq2gPx2Jm0NIQeG4pQnZoHu7aE28ZCNXQSzgUzzo
 WYck40CeMpG9dp3Icwv+m+IG82xmn+K1hA1SZIr9GFqQmUw0jOGGDjIFHT2Y9yuLwL2Lajgy9SQ
 3gNYVKGC3y7iztH4QGMMZQiIWQFO5hv6oogWyzSOau3oncHx3CDUmbD7bR3M9Dn4P47g0U9QAhG
 N/XqvegPB38oJWQ==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

The guest already uses page-sized RX allocations. A datagram can exceed
one RX buffer. Growing every posted buffer to hold a full datagram would
increase virtqueue memory use and make small queued datagrams retain large
backing allocations. With delayed reads, a bounded receive queue could
then fill after only a few messages.

Define START and EOM flags for datagram packets. Mark outgoing messages
with both flags, and let vhost split a message across guest RX buffers,
keeping START on the first fragment and EOM on the last. When a data
packet meets a descriptor with no payload space, vhost returns that
descriptor with zero used bytes. It drops datagrams but requeues stream
and seqpacket data for a later buffer.

Reassemble consecutive fragments in the guest before tap or socket
delivery. Bound a partial message to 64 fragments and 64 KiB. Discard
incomplete messages on malformed packets, a new START, a peer mismatch,
an intervening non-datagram packet, or virtqueue teardown. Require complete
framing for host and loopback ingress.

A QEMU reproducer now delivers a 9 KiB datagram as one message and all
16 messages of a delayed-read burst. Paired host/guest selftests cover
64 KiB messages and the burst through both a userspace backend and the
patched Linux vhost backend, with stream and seqpacket controls. A nested
vhost-vsock guest posting header-only RX buffers also passes stream and
seqpacket receive tests.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/vhost/vsock.c                   |  15 +++++
 include/uapi/linux/virtio_vsock.h       |   8 +++
 net/vmw_vsock/virtio_transport.c        | 115 ++++++++++++++++++++++++++++++--
 net/vmw_vsock/virtio_transport_common.c |  11 ++-
 4 files changed, 141 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 200dd454fecf..b596d64e9168 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -185,6 +185,19 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		 * buffer, we split it using multiple buffers.
 		 */
 		if (payload_len > iov_len - sizeof(*hdr)) {
+			if (iov_len == sizeof(*hdr)) {
+				/* Connected sockets must retry with the next buffer. */
+				if (le16_to_cpu(hdr->type) ==
+				    VIRTIO_VSOCK_TYPE_DGRAM)
+					kfree_skb(skb);
+				else
+					virtio_vsock_skb_queue_head(
+						&vsock->send_pkt_queue, skb);
+				vhost_add_used(vq, head, 0);
+				added = true;
+				continue;
+			}
+
 			payload_len = iov_len - sizeof(*hdr);
 
 			/* As we are copying pieces of large packet's buffer to
@@ -244,6 +257,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		 */
 		if (VIRTIO_VSOCK_SKB_CB(skb)->offset < skb->len) {
 			hdr->flags |= cpu_to_le32(flags_to_restore);
+			if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM)
+				hdr->flags &= ~cpu_to_le32(VIRTIO_VSOCK_DGRAM_START);
 
 			/* We are queueing the same skb to handle
 			 * the remaining bytes, and we want to deliver it
diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
index 27b4b2b8bf13..e1937f756eeb 100644
--- a/include/uapi/linux/virtio_vsock.h
+++ b/include/uapi/linux/virtio_vsock.h
@@ -101,6 +101,14 @@ enum virtio_vsock_shutdown {
 enum virtio_vsock_rw {
 	VIRTIO_VSOCK_SEQ_EOM = 1,
 	VIRTIO_VSOCK_SEQ_EOR = 2,
+	/*
+	 * With VIRTIO_VSOCK_F_DGRAM, START marks the first RW packet of a
+	 * datagram and EOM marks the last. Both are set for a datagram that
+	 * fits in one packet. Fragments must be consecutive on the receive
+	 * virtqueue. Each packet's len is its fragment length.
+	 */
+	VIRTIO_VSOCK_DGRAM_EOM = VIRTIO_VSOCK_SEQ_EOM,
+	VIRTIO_VSOCK_DGRAM_START = 4,
 };
 
 #endif /* _UAPI_LINUX_VIRTIO_VSOCK_H */
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 87a96e94c3c2..c8c58a7dcec4 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -54,6 +54,8 @@ struct virtio_vsock {
 	bool rx_run;
 	int rx_buf_nr;
 	int rx_buf_max_nr;
+	struct sk_buff_head dgram_rx_queue;
+	u32 dgram_rx_len;
 
 	u32 guest_cid;
 	bool seqpacket_allow;
@@ -312,7 +314,7 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
 static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
 {
 	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
-	struct scatterlist pkt, *p;
+	struct scatterlist pkt;
 	struct virtqueue *vq;
 	struct sk_buff *skb;
 	int ret;
@@ -325,9 +327,9 @@ static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
 			break;
 
 		memset(skb->head, 0, VIRTIO_VSOCK_SKB_HEADROOM);
+		virtio_vsock_skb_put(skb, total_len - VIRTIO_VSOCK_SKB_HEADROOM);
 		sg_init_one(&pkt, virtio_vsock_hdr(skb), total_len);
-		p = &pkt;
-		ret = virtqueue_add_sgs(vq, &p, 0, 1, skb, GFP_KERNEL);
+		ret = virtqueue_add_inbuf(vq, &pkt, 1, skb, GFP_KERNEL);
 		if (ret < 0) {
 			kfree_skb(skb);
 			break;
@@ -661,6 +663,93 @@ virtio_transport_dgram_allow_check(struct vsock_sock *vsk, u32 cid, u32 port)
 	return dgram_allow;
 }
 
+#define VIRTIO_VSOCK_DGRAM_MAX_FRAGS	64
+
+/* The RX worker holds rx_lock while assembling fragments from one virtqueue. */
+static void virtio_vsock_dgram_reset(struct virtio_vsock *vsock)
+{
+	skb_queue_purge(&vsock->dgram_rx_queue);
+	vsock->dgram_rx_len = 0;
+}
+
+static bool virtio_vsock_dgram_same_peer(struct sk_buff *first,
+					 struct sk_buff *next)
+{
+	const struct virtio_vsock_hdr *a = virtio_vsock_hdr(first);
+	const struct virtio_vsock_hdr *b = virtio_vsock_hdr(next);
+
+	return a->src_cid == b->src_cid && a->dst_cid == b->dst_cid &&
+	       a->src_port == b->src_port && a->dst_port == b->dst_port;
+}
+
+static struct sk_buff *
+virtio_vsock_dgram_reassemble(struct virtio_vsock *vsock, struct sk_buff *skb)
+{
+	struct sk_buff_head *queue = &vsock->dgram_rx_queue;
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct sk_buff *assembled, *fragment;
+	u32 flags = le32_to_cpu(hdr->flags);
+	int offset = 0;
+
+	if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW ||
+	    flags & ~(VIRTIO_VSOCK_DGRAM_START | VIRTIO_VSOCK_DGRAM_EOM))
+		goto drop_partial;
+
+	/* START also resynchronizes after an abandoned datagram. */
+	if (flags & VIRTIO_VSOCK_DGRAM_START)
+		virtio_vsock_dgram_reset(vsock);
+	else if (skb_queue_empty(queue))
+		goto drop_skb;
+
+	fragment = skb_peek(queue);
+	if (fragment && !virtio_vsock_dgram_same_peer(fragment, skb))
+		goto drop_partial;
+	if (skb->len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE - vsock->dgram_rx_len ||
+	    skb_queue_len(queue) >= VIRTIO_VSOCK_DGRAM_MAX_FRAGS ||
+	    (!(flags & VIRTIO_VSOCK_DGRAM_EOM) && !skb->len))
+		goto drop_partial;
+
+	if (flags & VIRTIO_VSOCK_DGRAM_EOM && skb_queue_empty(queue))
+		return skb;
+
+	vsock->dgram_rx_len += skb->len;
+	skb_queue_tail(queue, skb);
+	if (!(flags & VIRTIO_VSOCK_DGRAM_EOM))
+		return NULL;
+
+	assembled = virtio_vsock_alloc_skb(VIRTIO_VSOCK_SKB_HEADROOM +
+					     vsock->dgram_rx_len, GFP_KERNEL);
+	if (!assembled)
+		goto reset;
+	virtio_vsock_skb_put(assembled, vsock->dgram_rx_len);
+	fragment = skb_peek(queue);
+	memcpy(virtio_vsock_hdr(assembled), virtio_vsock_hdr(fragment),
+	       sizeof(*hdr));
+	hdr = virtio_vsock_hdr(assembled);
+	hdr->len = cpu_to_le32(vsock->dgram_rx_len);
+	hdr->flags = cpu_to_le32(VIRTIO_VSOCK_DGRAM_START |
+				  VIRTIO_VSOCK_DGRAM_EOM);
+	skb_queue_walk(queue, fragment) {
+		if (skb_store_bits(assembled, offset, fragment->data,
+				   fragment->len)) {
+			kfree_skb(assembled);
+			goto reset;
+		}
+		offset += fragment->len;
+	}
+	virtio_vsock_dgram_reset(vsock);
+	return assembled;
+
+drop_partial:
+	virtio_vsock_dgram_reset(vsock);
+drop_skb:
+	kfree_skb(skb);
+	return NULL;
+reset:
+	virtio_vsock_dgram_reset(vsock);
+	return NULL;
+}
+
 static void virtio_transport_rx_work(struct work_struct *work)
 {
 	struct virtio_vsock *vsock =
@@ -697,7 +786,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
 
 			/* Drop short/long packets */
 			if (unlikely(len < sizeof(*hdr) ||
-				     len > virtio_vsock_skb_len(skb))) {
+				     len > sizeof(*hdr) + skb->len)) {
+				virtio_vsock_dgram_reset(vsock);
 				kfree_skb(skb);
 				continue;
 			}
@@ -705,6 +795,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			hdr = virtio_vsock_hdr(skb);
 			payload_len = le32_to_cpu(hdr->len);
 			if (unlikely(payload_len > len - sizeof(*hdr))) {
+				virtio_vsock_dgram_reset(vsock);
 				kfree_skb(skb);
 				continue;
 			}
@@ -713,12 +804,19 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM &&
 			    (!vsock->dgram_allow ||
 			     le64_to_cpu(hdr->dst_cid) != vsock->guest_cid)) {
+				virtio_vsock_dgram_reset(vsock);
 				kfree_skb(skb);
 				continue;
 			}
 
-			if (payload_len)
-				virtio_vsock_skb_put(skb, payload_len);
+			pskb_trim_unique(skb, payload_len);
+			if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM) {
+				skb = virtio_vsock_dgram_reassemble(vsock, skb);
+				if (!skb)
+					continue;
+			} else if (!skb_queue_empty(&vsock->dgram_rx_queue)) {
+				virtio_vsock_dgram_reset(vsock);
+			}
 
 			virtio_transport_deliver_tap_pkt(skb);
 
@@ -730,7 +828,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
 	} while (!virtqueue_enable_cb(vq));
 
 out:
-	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
+	if (!vsock->rx_buf_nr ||
+	    vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
 		virtio_vsock_rx_fill(vsock);
 out_nofill:
 	mutex_unlock(&vsock->rx_lock);
@@ -824,6 +923,7 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
 	mutex_lock(&vsock->rx_lock);
 	while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
 		kfree_skb(skb);
+	virtio_vsock_dgram_reset(vsock);
 	mutex_unlock(&vsock->rx_lock);
 
 	mutex_lock(&vsock->tx_lock);
@@ -865,6 +965,7 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 
 	mutex_init(&vsock->tx_lock);
 	mutex_init(&vsock->rx_lock);
+	skb_queue_head_init(&vsock->dgram_rx_queue);
 	mutex_init(&vsock->event_lock);
 	skb_queue_head_init(&vsock->send_pkt_queue);
 	INIT_WORK(&vsock->rx_work, virtio_transport_rx_work);
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index c540bc40755a..23f141cd786a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -275,6 +275,13 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 				hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
 		}
 	}
+	if (info->type == VIRTIO_VSOCK_TYPE_DGRAM) {
+		struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+
+		/* Vhost may split this message across guest RX buffers. */
+		hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_DGRAM_START |
+					  VIRTIO_VSOCK_DGRAM_EOM);
+	}
 
 	if (info->reply)
 		virtio_vsock_skb_set_reply(skb);
@@ -1877,7 +1884,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	 * datagrams are silently dropped (no RST).
 	 */
 	if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM) {
-		if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW)
+		if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW ||
+		    le32_to_cpu(hdr->flags) !=
+		    (VIRTIO_VSOCK_DGRAM_START | VIRTIO_VSOCK_DGRAM_EOM))
 			goto free_pkt;
 
 		sk = vsock_find_bound_dgram_socket_net(&dst, net);

-- 
2.56.0

