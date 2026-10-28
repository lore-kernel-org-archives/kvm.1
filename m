Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203505;
	b=e8hy7kAf8h4ps1BU+sAH7yXpE54I013Cy4tTEyvgxrxaOiZ5ANnQExE1bEfjJ46W2jAM
	 eHF0Twzt6KhEGvcJWJXe02X/5TjZiXj8bhLYrHZMRPGRJ11VSKOthD6wQr4CmLk+CiYsr
	 tdOPxv3r3WnPlQuO/vbZt89V4ko/7gqP8nfDiJDwd6tYJA3DM2zrVJZI4bBXZ6R2KQ+1O
	 6WgVPW+R09lKy050MvVglQLCLadFIoPVCpVS1VX9PO5MUcxZkpA3d0R0ngP5+yEQZXlXl
	 MTP8hCITI2gYb15YdIzscWZiIsooRA36hBlKRiQ1q53H9uUHOfcM6x59COR9lSvZIKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203505;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/NDQKX+0pUZ8dCzJ7P3zYiQzdIpJo7qVKKEaS6oMD8Q=;
	b=ZNOSq7DOQjaMYhwrf9h55CNY9Beysl13fovbsivHey/cujK7YOIFA1RPN4Hhh0V9s9ar
	 7ZrUPUUraDK1iJY3XQmYH1JO1oH71ZwQ9piFVeFDKfENabQZ65DKuJDFSG5pQtNf3TbsB
	 jYRI++MGm8RFZrmm9zi2Wk84Ygh1v/AptEaG+Di1BPSV1TgFQXJ1ETHlUJYVwEbXGA3T8
	 y2KV7m0wPTV36d1XxUSjLh9M6yJGrZAU6Z278bpJX2c5Df8dU8xk/uerevKsSzY9HTVEr
	 OJNnjLibYGUEb5CHtgvbuefbz1Mv2mJC04iLxHqv6kVaboqXh6sBY4sUYwNx88ghjmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FmCoJtu5;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=A1Hl0Zel;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2724F60A381B
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 16:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2724F60A381B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FmCoJtu5;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=A1Hl0Zel
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793203503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/NDQKX+0pUZ8dCzJ7P3zYiQzdIpJo7qVKKEaS6oMD8Q=;
	b=FmCoJtu5yZeisJH0k7USfst4f8FC0NEZXBNX69vB5Xnuye0aeRbA/9iPYXx1NAgqbcquEF
	jEuujrTOQztWFbf1agW0I6aNpEjyrW3b2/QAW+VPZ4gG/CdgTgwNtkJeWsZA66m7EJPopc
	CoWMNVVNKlGlXa13EjqzxuvGc13hSgY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-W0ZEB9V-NPu7qhQDzRb8bA-1; Wed, 28 Oct 2026 12:05:01 -0400
X-MC-Unique: W0ZEB9V-NPu7qhQDzRb8bA-1
X-Mimecast-MFC-AGG-ID: W0ZEB9V-NPu7qhQDzRb8bA_1793203500
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1d1f26a63so10410825e9.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 09:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793203500; x=1793808300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/NDQKX+0pUZ8dCzJ7P3zYiQzdIpJo7qVKKEaS6oMD8Q=;
        b=A1Hl0ZelyYhVuROqmr5LoBthsluF9Rmocxnno545d7OBshL7xo4tJnbtSXquJ/ywQc
         3b1aSYPO53ZdnnpXsfy7qJ3m8ZRaUW+1l9xjjvYykh4oQ3gwjT28Re0Bn4o0F8NenpmK
         cbJ06oIDXAjTYAjNC1Meye82e4F2mkyeclTwd9O3MEp3D+hb5I7p5PHivRo8BOYMp9+8
         lU9GPi8CyGvCBZkERmnxAxYzBR0Sze+ySUjrDKw8Q6KBUUO9XD0JUHSTfrT6QSRiwc48
         iAWd2to9Uh8SyO/jHV67f62ADQwrxVRBQb/mCVv5W+01VuofIYGuZUuMhevBNzlTg85u
         D7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203500; x=1793808300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/NDQKX+0pUZ8dCzJ7P3zYiQzdIpJo7qVKKEaS6oMD8Q=;
        b=WoG8yK5dnIfY3/pMwKoNmgjIZWq/4vmFQ6WRyVoQJCqcTuem9XcRRGBuGC1dTjtCdY
         D7jFpEgIBzD6I3ny0rgusIARH9g8XeB6cioB4fqFsf4eBEbI2D21mBhTBmTxBKv9yZLG
         6uQjI0rpeU3k0uEqDgTeK9Yc7rmq3u5vvp00xp3KnivHJ2oGptZuHyKMFSF4jNSiDdFp
         0XMOxFCeKDW5Iwo1omQx2vTS5mZqHtxi4JoTn1mFjL5E/ft5rp236UwDcI6/46eIH7JW
         0lcrXsYvuLltzasbuHZMCmXb05czrTljSWP103caEn/fVzDnBPUpUL+4aqil3Uj/RA4d
         CIFQ==
X-Forwarded-Encrypted: i=1; AKwUvByMQILDo051mhstY+uXM9S8McpTm5iYR6/jCgap3QUQ42B3xU6Vt937+3rxzVCBeQzLXvM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8k8GHwN1Ds6sPLG+OY3Ds6PjVKLHrBTleKwGmxEhY8v0TNvA5
	V9pETr/GndwpbRJgt5szGuE55MZ1lMHP539wPtf9pbH9DnlrF21cB2znHHKRqfJLDa9Qn36xYIe
	N5VTzSnq2DHBmNyGxn0G1BgTjb/smziycVc/Uo1ZvwESuJt4lHwCC1g==
X-Gm-Gg: AYBFou0sfmV6O6dW6nLVqVjdta6vnQJjeeBj0LKNTkcnGE34bjODJBkdfiiFzjqM+po
	tnv7SMejsHYBi9pR8xjz+qOFmyUrt1JP0ivPCXmi072SgvSiaV0sWdRk9UEtnRlS/6haDffEkP7
	gcvQT2OXjXbvjBpAeBYb0YNH5mcvpK4KTcBRv8ObWU+RiAwP9nHglMb6Emv3uXa6rvyZ4IDlaYx
	R2aSdgFyGzf7XqtONoPeZqxC1kn2hSb8WaDyeG5SXlKb7QbDN0wFKT2CpiFPw3pXfPggowl6GHh
	H1pfIJVh8afqb0HWJqMW/cRbNKHd7giGdUCw1/Gn2MO3X3WfNriIoiGL+BWW9rPek3Mx5YghHNB
	EkWEVth6Z1dUjyZa1SkW3mVIBMGDFdHrWq7Wn57/Rc22L4Qj8tN4jtzsewlO2P7QFWakGJC6Fxm
	GB+rVKFIi3Xpw=
X-Received: by 2002:a05:600c:3516:b0:4a1:fb01:13 with SMTP id 5b1f17b1804b1-4a966a56974mr60856645e9.18.1793203500057;
        Wed, 28 Oct 2026 09:05:00 -0700 (PDT)
X-Received: by 2002:a05:600c:3516:b0:4a1:fb01:13 with SMTP id 5b1f17b1804b1-4a966a56974mr60856015e9.18.1793203499544;
        Wed, 28 Oct 2026 09:04:59 -0700 (PDT)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm31898410f8f.32.2026.10.28.09.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:04:58 -0700 (PDT)
From: Sergio Lopez <slp@redhat.com>
Date: Wed, 28 Oct 2026 17:04:32 +0100
Subject: [PATCH RFC 3/8] vsock/virtio: implement the datagram data path
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
Message-Id: <20261028-vsock-dgram-support-v1-3-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
In-Reply-To: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
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
 Dexuan Cui <decui@microsoft.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11008; i=slp@sinrega.org;
 h=from:subject:message-id; bh=2s1omMpVu71TczRqOdlyG3N3goKIkmMx8d7/0woGC8E=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq4h0dkB7en5W9wYnuKb478hOyMcWfDRePH2lfG
 WEALSgkofqJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCauIdHQAKCRD0aSeNLwwC
 Nf7BD/sEJgQqf5tYnZDelctQWr02ptNl4W4PxnOQQ8n4YxE/ClpJGqwceWv4PcqioH2nWGJ8y0a
 3T/pQqT9qnqD+c3/iEF+FlFKz9Kyn7KSZ625DZFWrwGNCwlMXaFFDFhY/Um04TpKHrfYROvcwA8
 XPwBRAIX++sqGD1veaJBI8ts/U1TF8fVfL0xMVxHtExRIApVjSp7Bh57RKdshMyQ4lwywb8D0b+
 FNpUW6iBT6/vxJb9cdUySU8ocLQXlA+sOcRTEl/zXPVSo16Z0s4aRNnCDgjF4auPtem5zc63Ed0
 58Cp+dxXMs5VEtWf7TGbiw9ToblJ/VpLNLnpactpHzhUFrygsVUiuoDRfqsC+zMGpJZwdEKhFyl
 KPmXjNm3gBPCMZ/eAve678By4WC2mbqkPpjJSB5w92f/SlyLsvgYmsGzl7GZtCCY8wT/bMB0RM+
 HbmG8DmRSsgR9RzGlqPA9998xmyCweUOQuTJT9m9zR3yjXu4xukDX4OHFk0deWDTBeu9yycZ9Qb
 3zV1knHrwt0HnITgDZa61dIP5XBDE4jC3mlWxwvGjrBPMne1989NsGDUnMMqaypbImw2t2LLWSO
 bgHUIPdYo9kqCwIrRLi4DY1Tw1XptcMXszMTa6hOPJjDqySXnixUJVGXLqG+n6o9AZVuUHt6nYZ
 Of5qIl5flqNUlLQ==
X-Developer-Key: i=slp@sinrega.org; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Add the datagram feature bit and packet type, and implement the common
virtio transport operations needed to bind, send, and receive
datagrams.

Send each message as an OP_RW packet with a maximum 64 KiB payload,
including support for empty messages. Bound pending sends by the
socket send buffer instead of connection-oriented peer credits. Charge
pending payload bytes before handing the skb to the backend and
release that charge exactly once on completion, rejection, or queued
drops.

Deliver incoming datagrams through the bound table without entering
the connection state machine. Validate the transport and connected
peer under the socket lock, including after shutdown, and silently
discard undeliverable messages. Use the socket datagram queue for
recvmsg(), including source addresses, peeking, and truncation
reporting based on the payload length after socket filtering.  Reject
MSG_OOB and MSG_ERRQUEUE before accessing the receive queue.  Reject
datagram sockmap admission until its receive callbacks support it.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 include/linux/virtio_vsock.h            |   2 +
 include/uapi/linux/virtio_vsock.h       |   2 +
 net/vmw_vsock/virtio_transport_common.c | 150 +++++++++++++++++++++++++++++---
 net/vmw_vsock/vsock_bpf.c               |   3 +-
 4 files changed, 142 insertions(+), 15 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731057..0bccae661221 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -12,6 +12,8 @@
 struct virtio_vsock_skb_cb {
 	bool reply;
 	bool tap_delivered;
+	/* Datagram payload is still charged to bytes_unsent. */
+	bool tx_accounted;
 	u32 offset;
 };
 
diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
index 64738838bee5..27b4b2b8bf13 100644
--- a/include/uapi/linux/virtio_vsock.h
+++ b/include/uapi/linux/virtio_vsock.h
@@ -40,6 +40,7 @@
 
 /* The feature bitmap for virtio vsock */
 #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
+#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
 
 struct virtio_vsock_config {
 	__le64 guest_cid;
@@ -69,6 +70,7 @@ struct virtio_vsock_hdr {
 enum virtio_vsock_type {
 	VIRTIO_VSOCK_TYPE_STREAM = 1,
 	VIRTIO_VSOCK_TYPE_SEQPACKET = 2,
+	VIRTIO_VSOCK_TYPE_DGRAM = 3,
 };
 
 enum virtio_vsock_op {
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1e762a480df4..ae33630d99e7 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -204,10 +204,18 @@ static u16 virtio_transport_get_type(struct sock *sk)
 {
 	if (sk->sk_type == SOCK_STREAM)
 		return VIRTIO_VSOCK_TYPE_STREAM;
+	else if (sk->sk_type == SOCK_DGRAM)
+		return VIRTIO_VSOCK_TYPE_DGRAM;
 	else
 		return VIRTIO_VSOCK_TYPE_SEQPACKET;
 }
 
+static void virtio_transport_dgram_skb_destructor(struct sk_buff *skb)
+{
+	virtio_transport_consume_skb_sent(skb, false);
+	sock_wfree(skb);
+}
+
 /* Returns new sk_buff on success, otherwise returns NULL. */
 static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
 						  size_t payload_len,
@@ -303,6 +311,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	u32 src_cid, src_port, dst_cid, dst_port;
 	const struct virtio_transport *t_ops;
 	struct iov_iter_state msg_iter_state;
+	struct sock *sk = sk_vsock(vsk);
 	struct virtio_vsock_sock *vvs;
 	struct ubuf_info *uarg = NULL;
 	u32 pkt_len = info->pkt_len;
@@ -329,12 +338,24 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 
 	vvs = vsk->trans;
 
-	/* virtio_transport_get_credit might return less than pkt_len credit */
-	pkt_len = virtio_transport_get_credit(vvs, pkt_len);
+	if (info->type == VIRTIO_VSOCK_TYPE_DGRAM) {
+		if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
+			return -EMSGSIZE;
 
-	/* Do not send zero length OP_RW pkt */
-	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
-		return pkt_len;
+		/* Datagram sends are serialized by the socket lock. */
+		if (sk_wmem_alloc_get(sk) >= READ_ONCE(sk->sk_sndbuf)) {
+			sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
+			set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+			return -EAGAIN;
+		}
+	} else {
+		/* virtio_transport_get_credit might return less than pkt_len credit */
+		pkt_len = virtio_transport_get_credit(vvs, pkt_len);
+
+		/* Do not send zero length OP_RW pkt */
+		if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
+			return pkt_len;
+	}
 
 	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
 		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
@@ -348,7 +369,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
 						    NULL, false);
 			if (!uarg) {
-				virtio_transport_put_credit(vvs, pkt_len);
+				if (info->type != VIRTIO_VSOCK_TYPE_DGRAM)
+					virtio_transport_put_credit(vvs, pkt_len);
 				return -ENOMEM;
 			}
 
@@ -393,7 +415,15 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 			break;
 		}
 
-		virtio_transport_inc_tx_pkt(vvs, skb);
+		if (info->type == VIRTIO_VSOCK_TYPE_DGRAM) {
+			spin_lock_bh(&vvs->tx_lock);
+			vvs->bytes_unsent += skb_len;
+			spin_unlock_bh(&vvs->tx_lock);
+			VIRTIO_VSOCK_SKB_CB(skb)->tx_accounted = true;
+			skb->destructor = virtio_transport_dgram_skb_destructor;
+		} else {
+			virtio_transport_inc_tx_pkt(vvs, skb);
+		}
 
 		ret = t_ops->send_pkt(skb, info->net);
 		if (ret < 0)
@@ -416,7 +446,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	if (info->msg && ret < 0)
 		iov_iter_restore(&info->msg->msg_iter, &msg_iter_state);
 
-	virtio_transport_put_credit(vvs, rest_len);
+	if (info->type != VIRTIO_VSOCK_TYPE_DGRAM)
+		virtio_transport_put_credit(vvs, rest_len);
 
 	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
 	 * skb_zcopy_set() increases it for each skb, so we can drop that
@@ -620,7 +651,9 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
 {
 	struct sock *s = skb->sk;
 
-	if (s && skb->len) {
+	if (s && skb->len &&
+	    (s->sk_type != SOCK_DGRAM ||
+	     VIRTIO_VSOCK_SKB_CB(skb)->tx_accounted)) {
 		struct vsock_sock *vs = vsock_sk(s);
 		struct virtio_vsock_sock *vvs;
 
@@ -631,6 +664,9 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
 		spin_unlock_bh(&vvs->tx_lock);
 	}
 
+	if (s && s->sk_type == SOCK_DGRAM)
+		VIRTIO_VSOCK_SKB_CB(skb)->tx_accounted = false;
+
 	if (consume)
 		consume_skb(skb);
 }
@@ -999,7 +1035,47 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
 			       struct msghdr *msg,
 			       size_t len, int flags)
 {
-	return -EOPNOTSUPP;
+	struct sock *sk = sk_vsock(vsk);
+	struct virtio_vsock_hdr *hdr;
+	struct sk_buff *skb;
+	size_t payload_len;
+	int err;
+
+	if (flags & (MSG_OOB | MSG_ERRQUEUE))
+		return -EOPNOTSUPP;
+
+	skb = skb_recv_datagram(sk, flags, &err);
+	if (!skb)
+		return err;
+
+	hdr = virtio_vsock_hdr(skb);
+	payload_len = skb->len;
+
+	if (payload_len > len) {
+		payload_len = len;
+		msg->msg_flags |= MSG_TRUNC;
+	}
+
+	err = skb_copy_datagram_iter(skb, 0, &msg->msg_iter, payload_len);
+	if (err)
+		goto out;
+
+	if (msg->msg_name) {
+		DECLARE_SOCKADDR(struct sockaddr_vm *, vm_addr, msg->msg_name);
+
+		vsock_addr_init(vm_addr, le64_to_cpu(hdr->src_cid),
+				le32_to_cpu(hdr->src_port));
+		msg->msg_namelen = sizeof(*vm_addr);
+	}
+
+	if (flags & MSG_TRUNC)
+		err = skb->len;
+	else
+		err = payload_len;
+
+out:
+	skb_free_datagram(sk, skb);
+	return err;
 }
 EXPORT_SYMBOL_GPL(virtio_transport_dgram_dequeue);
 
@@ -1202,13 +1278,13 @@ EXPORT_SYMBOL_GPL(virtio_transport_stream_is_active);
 int virtio_transport_dgram_bind(struct vsock_sock *vsk,
 				struct sockaddr_vm *addr)
 {
-	return -EOPNOTSUPP;
+	return vsock_bind_common(vsk, addr);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_dgram_bind);
 
 bool virtio_transport_dgram_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 {
-	return false;
+	return true;
 }
 EXPORT_SYMBOL_GPL(virtio_transport_dgram_allow);
 
@@ -1246,7 +1322,17 @@ virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
 			       struct msghdr *msg,
 			       size_t dgram_len)
 {
-	return -EOPNOTSUPP;
+	struct virtio_vsock_pkt_info info = {
+		.op = VIRTIO_VSOCK_OP_RW,
+		.msg = msg,
+		.pkt_len = dgram_len,
+		.vsk = vsk,
+		.remote_cid = remote_addr->svm_cid,
+		.remote_port = remote_addr->svm_port,
+		.net = sock_net(sk_vsock(vsk)),
+	};
+
+	return virtio_transport_send_pkt_info(vsk, &info);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_dgram_enqueue);
 
@@ -1771,7 +1857,8 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 static bool virtio_transport_valid_type(u16 type)
 {
 	return (type == VIRTIO_VSOCK_TYPE_STREAM) ||
-	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
+	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET) ||
+	       (type == VIRTIO_VSOCK_TYPE_DGRAM);
 }
 
 /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
@@ -1805,6 +1892,41 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		goto free_pkt;
 	}
 
+	/* Dgram packets are delivered directly to bound sockets without
+	 * going through the connection state machine. Undeliverable
+	 * datagrams are silently dropped (no RST).
+	 */
+	if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM) {
+		if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW)
+			goto free_pkt;
+
+		sk = vsock_find_bound_socket_net(&dst, net);
+
+		if (!sk || sk->sk_type != SOCK_DGRAM) {
+			if (sk)
+				sock_put(sk);
+			goto free_pkt;
+		}
+
+		vsk = vsock_sk(sk);
+		lock_sock(sk);
+		if (sock_flag(sk, SOCK_DEAD) ||
+		    vsk->transport != &t->transport ||
+		    (sk->sk_socket->state != SS_UNCONNECTED &&
+		     !vsock_check_source(vsk, &t->transport, &src))) {
+			release_sock(sk);
+			sock_put(sk);
+			goto free_pkt;
+		}
+
+		if (sock_queue_rcv_skb(sk, skb))
+			kfree_skb(skb);
+
+		release_sock(sk);
+		sock_put(sk);
+		return;
+	}
+
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 9049d2648646..296e1fa7970b 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -161,7 +161,8 @@ int vsock_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore
 	if (!vsk->transport)
 		return -ENODEV;
 
-	if (!vsk->transport->read_skb)
+	/* Datagram receive is not implemented by the sockmap callbacks. */
+	if (sk->sk_type == SOCK_DGRAM || !vsk->transport->read_skb)
 		return -EOPNOTSUPP;
 
 	vsock_bpf_check_needs_rebuild(psock->sk_proto);

-- 
2.56.0

