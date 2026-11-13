Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574205;
	b=vnFft3Ex0FNED80HlRqqLS8MUmmr+J5Bb9K62l5Bhsl/WLPfdpRENw24N7wWNlu9kLIf
	 4knbnJlAJmRCSdH+aoeMW6MqhCvxFRspRwKAWHMoYHby+KsF5+T+9JNOx4kcvtDRpmWqO
	 3oDdhoC6rNs6beS2pcqjVm3niK2z5nCjFntn+IPA8WFdGfn07h/ylK/UchnCRvdi+vesR
	 yU4GddcS6Fpi3B5nRl6vfndT2Mh/QR5/6viLdMITW79M9HKWToGWqavhzZDEymfH9sxaE
	 OzbZ+nS/LyuKEOr3meMG/4IVx8Ov/JGFMigCA/Nl+LvHmfZ8Ada3y6mOj6e6BoAOYDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574205;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=aY36T3cH0rWh+PvZgaudWg0gqz4B7hI+VDUtSo7Tk6I=;
	b=uxt68HKhv17gcZW/yRL1GQR40RQUX887kELQLsbfa9yA0E7uoKUyKPrXvdTdm2kb7bNw
	 tZfXL9ExnkOG3TJ7lGCVoQN0APj7l4B2+7biEA8klHYS3MdigXvcZlgN52FobRMarC92N
	 Eo3MVtNLuq6pcqSA5L07aNk6usndf6tYixBhNRAHp+eDmjn8E9r4aJCx8Oouv1ga9lYIP
	 tOB66CJELwHRKNwThS52D6PyfqUjRN4ivavXqkFtfsx4hfXQWl4JOJ+p9oh2uC5ucMvVv
	 K92ODp2OIwmR+RpWXDYmZMOXa7B9WIqygaxMUgqiCIam+uz1rGB+gGcfzX4BO109yzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XPBnOpXx;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QVGxbQfR;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A8660A6F6F
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 12:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4A8660A6F6F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XPBnOpXx;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QVGxbQfR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794574203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aY36T3cH0rWh+PvZgaudWg0gqz4B7hI+VDUtSo7Tk6I=;
	b=XPBnOpXxXfQtViwJcQh4K5EHn0nRAnGEycO8zgVdrkPrUKUWGi+el9lvpgbn+O0QAMH89a
	+EI04RCCicIKjziH4aiHiujKpA1SVsXVdgi+kHu1aTkBm8q0bo9UYg730dg/ieVc0jfkfy
	yl6B2AzKAziH6MGteftjGgHiY6Jmi+E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-U_6_OWmrN2mLZnkQ2sdlPQ-1; Fri, 13 Nov 2026 07:50:02 -0500
X-MC-Unique: U_6_OWmrN2mLZnkQ2sdlPQ-1
X-Mimecast-MFC-AGG-ID: U_6_OWmrN2mLZnkQ2sdlPQ_1794574201
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4afef353dd2so7699805e9.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 04:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794574201; x=1795179001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aY36T3cH0rWh+PvZgaudWg0gqz4B7hI+VDUtSo7Tk6I=;
        b=QVGxbQfRCG2hzqSkMZOGq2chWhGxbkCPslBh3chHIV0x0vAYFHgwEyTjLE/4KyPtCj
         OsXRF7Xp0OiMfECacgLDc+9emnL55tPVVgWNuz0uNYpRhZkOzYAY1CZ8H5tPOqZGfOaH
         0bpYN/Cc7JVf4ksg5BChZoFAMkwys19Yn8FKXlzJUXGjeVPuhAOdVsnbNN1VlVb4uOWf
         v7kfcbtZyn8+dZoK+K2i6TX5DmxSK+54EfrfUdMsb5AUNKDRury4Dg4sCk0cCmMfU7ii
         /Rc+nhxf40xtBCAcY9GbHjUjoVr+9cg97HBwEintRLhBVb684/gCM9T6E/iuux2m+kNr
         KKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574201; x=1795179001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aY36T3cH0rWh+PvZgaudWg0gqz4B7hI+VDUtSo7Tk6I=;
        b=jiIaTdXw64IgaUr0zBYR+Ln66XD+k0ADmQC5+kF28h28sC3/6Zm7+wr0YNzrT05lQD
         1/LB1yuMAh/914UPgkzyTP5h93bwb8zR/xxEAoBMRQSKO4AmUnGpuoDHwlEUkn/ugXlL
         TI0zOy7Quz5vZQW3zvt/Gx9keROYOk9Ka9mr1Zed/N1dXY7ndes7wmyFk9x1Ih5c99+W
         ZBl3SYANQDkkYprIW5rLZ7ZtL7MCwYn7JcVcB5KuPIbI4rwYkN05CfPKwqY4TYIw6Zka
         n3PHFEmupMdrykG1HhYEakllZF+DQvCrnycovOgumVzFcjtL8CJFG7OYHS76BvEe3pCV
         1wHg==
X-Forwarded-Encrypted: i=1; AL+hErFNpP20hWoIYXmyswnIVTNf8axdEHh1R3AdC96bFU8CK8WTzTcFc9+NwR1lGPD1yRWM++4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8A/zSdu5UNU/E2N8JSwdp0ihLDuQIbW+bnXO+Y4eGtXYEtwQLA
	jCfWJkE3jOPl8UbwCKUCRz3xnlekTHbkM2WH7yeWkXycwIWCcLQbD9X+2uQlsFkKuuQrRvj0AzI
	+hpBsY33Xfbc1o8GnQowA8MgiUIfEVb2nYJ/0H5pbBJUFxA3IwUKEJg==
X-Gm-Gg: AYBFou119Wngjku/6kIiIc3Wpm6ZcScDUBbQm5++bOYINGt8QdgizDmKV3yOL+H27NP
	EoTX/v/SI3t9BlM4fCA85w31gNdwqQtjd6EKYjmwAecKc4ckQf4b3y22/e2Eq3e5J6VNdARerc8
	bR3sGfPKUcq92GigOuz5r/c3+FgN8cQA17dXhsw0FYu166JVdvaLgmrQLnlB0SY7vOJ0Hw+mp+t
	3/yf2cobKD4Y749q1XTErt8MOvSVK00AZ3qiNoFCS3R0IkJjo3QZlv/ctvl5iN5ymm/LjlmHYrQ
	y9RxsjEI/sR41W+fW5Qltea9KpddRZHmvSq1vErgE9DA6nkHv/ooUQn1/VWifYvA9uXeLdkZKBl
	u10X7uAmZgvi9Dlu7uyPEl03tF784ZZGKW4pILTtlfAo1nbSqqRkMtpA5KZu7ca7zggz8I0MSDT
	nKe0qQILdpOv0=
X-Received: by 2002:a05:600c:1d03:b0:4b1:4017:c4f4 with SMTP id 5b1f17b1804b1-4bb55a58e1amr56412535e9.20.1794574201226;
        Fri, 13 Nov 2026 04:50:01 -0800 (PST)
X-Received: by 2002:a05:600c:1d03:b0:4b1:4017:c4f4 with SMTP id 5b1f17b1804b1-4bb55a58e1amr56411685e9.20.1794574200696;
        Fri, 13 Nov 2026 04:50:00 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm151135805e9.15.2026.11.13.04.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:49:59 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 13 Nov 2026 13:47:40 +0100
Subject: [PATCH RFC v2 7/8] vsock: fragment datagrams across receive
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
Message-Id: <20261113-vsock-dgram-support-v2-7-bacfc85b71ce@redhat.com>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
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
 linux-doc@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11596; i=slp@redhat.com;
 h=from:subject:message-id; bh=vGFItuFortLrlZd5k60a24RVN2SDfiFbQWLuY7wF+bI=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq9wdgMYYGDr5JBn/P5QPUVxuPLwGE9SHRwDjz/
 RvgPZo1YVGJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavcHYAAKCRD0aSeNLwwC
 NR+XD/41ZuMcXCrGquadBdL+5V+HYg8/JHcpoZKACR9NTfRc3oasmx4/UQ6ir9FwjNhhE3IqO9e
 XtPrZKSjpJGVAwRoAFBgbxZYGLDU/9qREPnNfWyM2Z3RmJA1KQwQEjHr1rO2/c1ad4+2vtDZZQu
 VuZitKS3lthFvLpcAwQKJ/Py+fEl9S5rEe4Yhi5IIDqzvQNEEGQyK0GB5SApzNP+Lrv1QPrdwJo
 E9D50ACohlYj8ReMihiyeXXF/qxuAqQttaDJdaQ6/jujc7rq5l4VMbT61FyUP0eyK2YtvwEahkE
 Zzw7t50cD4o5YRiug9WKcxTOyw2nHnuLZ/5eVieeJbdkgJuQZZ7LqU8ZpoqqOh6TuReWrlBWZBA
 vAE6x8YbOxIf4GZNPaeJlbD/Fpj6s+0t7gRVAQLl5ckRzdk2usy6CE8GB+fV+/18PVYveVFuuj9
 s38I33z7RTPnqKKfYQ/YYbT8ql8EFjFa0z0IjdTqWlkDYciJXFR/UI8pPx6W2+sD9uOPXTth2M8
 4uh8PSbND2zqb4O+Xx19ivhU1ehHejPl7svuT3jIN3YNhSye5uL1PegfK33FGOYrcoPGXXg2rJU
 YtL1wwjLyCpflGMU/FpdO4QbQ6ML5O+hTsUSe+ZNqXWmsp0td6dvF4MvpjudAQwVWp2E3mwreIH
 AfI5O4zZIfi1lWQ==
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
index f4fb2ac732f5..1ff4a9aff907 100644
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
index 3ef86f5eaf36..d52b5663ed01 100644
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
@@ -1876,7 +1883,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
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

