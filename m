Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEAC22D792
	for <kvm@vger.kernel.org>; Sat, 19 Sep 2026 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789821074; cv=none; b=sVbNDD+eCiASpc/OP/BjJigUuFrYHHqGxS43kVHQQavDB+qr9Kh6ftt17S38XREAO5Av8aCG8IObf5PNeqAYD9gfJScJyEaSpGJDu47kPsKIHImY0i+auwfEDPwL/fP2Z3vM69Wj5dRW1AzOJ5GAl3WhWZp4WMe2gFva1CUK4vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789821074; c=relaxed/simple;
	bh=lytjDLayUNUDBpDPcUBL5AnDhJHzKewxfovLvIYwRhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jhi846jgPsNyoNzksO3OQzlLk1pZYrziuaMdq1VemCCikkQFwmHqxHec5CCKDdoO1kk2R02suiUWgqFhYLCmf+5bZ6ou+kWkKcPpnkUZp2MueeQmeMJe2A+Tf/7TGszDPcYDNx9O9GFY3w9AYCivZ1T+Y7Fr/gY1zlONnKq0oH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl; spf=pass smtp.mailfrom=isec.pl; dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b=RSAc+wDI; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isec.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b="RSAc+wDI"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so15658425e9.0
        for <kvm@vger.kernel.org>; Sat, 19 Sep 2026 05:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isec.pl; s=google; t=1789821070; x=1790425870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3B7qZ6581fQFirlKUxdFcVbDhBsli8sdqN4dkTJZQ4I=;
        b=RSAc+wDIckJ5iBgmdQDh2F8oRGA1Fy/AMKLsWO6/Df9D/IQXtd2VLVJxOyJdl/H1Oi
         SVYsyKJoL3ffC6Dgg+gFYoQEubhvieDX63Ry2m1jK7Xl6X7ZhjuNBBxIjJUN9Uz7Q5l5
         eQzdevs1vjpGzfKOjGmIkXl75Lu41wfNBhI5No/2eM4Ww9GxG4CqEIyEBP5B+3EfcJoG
         1N4NhSsAq/HAlSp0dPwsjWfJiTdARwQU65jrIgrsBWGBF6WCxrWpBqzFfiDPAiTbV0ju
         2wQ92ukLAqifpTmfvNWp7Nqk6P1t1/V5A3fIKixhNVqlPAYcKgDx1w8wc5JuepRdJZmf
         4ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789821070; x=1790425870;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3B7qZ6581fQFirlKUxdFcVbDhBsli8sdqN4dkTJZQ4I=;
        b=x7w2wLk0J5ujwgMoRF7XK90CPvKJ9cSrW0Yx5GOeRefa2NtbDfF47wGfNWLfiD052P
         cw5KpCB4NG8TZkE4A31pyxzXTQ//ZLBnLafHCopK4KdMZOv0LQf2mHBYxZVk9vkM6Reg
         Jm+uljM8Q2sWUKhPMeauGWRLOgqWQnZERsztX1FrpSmF5oGmXPT8bWd210v4MFJQSWfI
         GgTWEuZ7dT2hl0x+wviOOJ2iNfO48HInQBhGhKeXUHQy6M8ACAEXh/hxvjSJAPJZsFEG
         W1YQhE0pKfGqRZKRS9Y+11XY82UM5MAq2pUO4zSoZKJsHQQXvEJ094tyMrOqyS0AHj6b
         bitg==
X-Forwarded-Encrypted: i=1; AKwUvByqWExxUkOmwcf2s02oKPOCP1L1HAJ4SXc8DvEGVpk67+hiPYDZColNywSlUPTDz3rB/Jo=@vger.kernel.org
X-Gm-Message-State: AFuF++lOHTrDzZM1QTyx0ksh02QxvEJBuK5bLTzR5xgUMtrXnl3JA5LH
	WvuB0RSrqMhFj4GHfzDoEAdQYI+uaRxPabmleL9o9ekLk+XMzyYd+tRa2l8CHcc+LWw=
X-Gm-Gg: AYBFou0+wsMaJuL5xjFsFWFl5wcy1qwIYdqp+k4eNf5CMkMSvnp2BzVjYPjx0ALymIv
	ovuoY1khRRyGR01tVoD73pOkirsY2no+JD9A/yDEwhcQnvb9pVxp+hr4hX3SZA3H9rrmGBtH2ul
	1GHHnKUCJgPbbKqZ11b8ciwJOLhwCENcr3wHMOZaiZxWnFCxAhJ+mT5LgHZS9itiXXUm+bNZKLu
	arxth2vyvc6ZShpHhGbpLHAzWU6TIUEWYlTxwnBEjtgud+/PO1lDO7SC8FH5Drzj1Tl1owhnLqV
	juTXig5Sp/PexmbiGR9IwUPjH8NW+wZwnyaFN1eMY+uJU8NKNQrXvD3G6ICFFVy1tzpRcYGQ3He
	/9JzduGYgOMnLvfmJ5Jb6q4uQelVaXin/oVk+gyGf8xPVNzyhlFPPq30qHRnaRxAxLe6uLaafk2
	JcpiX9zRwvgtNlS6GagCV/SAhOGxRiV7WYIAWyCNdZkFhUMkcxz89/cld9BaJ9dJ3M04Aexrwsd
	epEeW/CjwM5reupzhqnywA3n29amv1VM+PWqiMw36R8CB2Doy/cJ/K64w==
X-Received: by 2002:a05:600c:4505:b0:49e:84bf:6121 with SMTP id 5b1f17b1804b1-49fc56dac58mr79266535e9.13.1789821069646;
        Sat, 19 Sep 2026 05:31:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a318:80b3:9080:dcd8:ca10:f229:8aed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd07bc34sm69233775e9.10.2026.09.19.05.31.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 05:31:09 -0700 (PDT)
From: =?UTF-8?q?Bart=C5=82omiej=20Dmitruk?= <bartlomiej.dmitruk@isec.pl>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vsock: keep SOCK_SEQPACKET message boundaries on interrupted send
Date: Sat, 19 Sep 2026 14:29:15 +0200
Message-ID: <20260919122916.28226-1-bartlomiej.dmitruk@isec.pl>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A credit-limited SOCK_SEQPACKET send transmits fragments as credit becomes
available, and the VIRTIO_VSOCK_SEQ_EOM flag is set only on the fragment
where msg_data_left() reaches 0. If vsock_connectible_sendmsg() exits via
out_err after a partial send -- notably the non-terminal -EINTR path
(signal_pending while blocked for credit), but also sk_err / peer
RCV_SHUTDOWN -- the already-transmitted fragments carry no EOM. The receiver
only advances msg_count / sets msg_ready on an EOM skb, so the orphaned
fragments are silently merged into the next message, violating SOCK_SEQPACKET
atomicity.

Wait until the whole remaining SEQPACKET message fits before enqueuing, so a
message is committed atomically (with its EOM) or not started; an error while
waiting then leaves nothing on the wire. SOCK_STREAM behaviour is unchanged
(min_space == 1 reproduces the old "wait while space == 0").

To avoid blocking forever on a message that can never fit -- a peer can
advertise a small buf_alloc, or the message can simply exceed the transmit
buffer -- reject such a message up front with -EMSGSIZE (the same error the
transport already returns for an oversized message) instead of waiting. This
needs the transport's maximum message size, added as a new optional
seqpacket_max_size() transport op implemented by the virtio/loopback
transports.

Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
Assisted-by: Claude (Anthropic)
---
Changes in v2:
 - Fix an indefinite wait the v1 approach introduced for oversized
   SOCK_SEQPACKET messages (reported by the Sashiko AI review on v1): the
   atomic-wait could never be satisfied when len > the transport's max
   message size (e.g. a peer advertising a small peer_buf_alloc), so the
   sender blocked instead of returning -EMSGSIZE. v2 checks this up front via
   the new seqpacket_max_size() op and returns -EMSGSIZE without waiting.
 - v1: https://lore.kernel.org/netdev/20260917220101.55744-1-bartlomiej.dmitruk@isec.pl/

Testing (vsock_loopback, unprivileged):
 - Interrupted partial send (-EINTR) no longer leaks orphan bytes into the
   next message (recv() returns only the next message).
 - Oversized message and small-peer_buf_alloc cases return -EMSGSIZE promptly
   instead of blocking.
 - Normal SEQPACKET send/recv unaffected.

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731..e96790c03 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -219,6 +219,7 @@ virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
 s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
 s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
 u32 virtio_transport_seqpacket_has_data(struct vsock_sock *vsk);
+u32 virtio_transport_seqpacket_max_size(struct vsock_sock *vsk);
 
 ssize_t virtio_transport_unsent_bytes(struct vsock_sock *vsk);
 
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 5549298c1..d94c613ef 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -143,6 +143,7 @@ struct vsock_transport {
 				 size_t len);
 	bool (*seqpacket_allow)(struct vsock_sock *vsk, u32 remote_cid);
 	u32 (*seqpacket_has_data)(struct vsock_sock *vsk);
+	u32 (*seqpacket_max_size)(struct vsock_sock *vsk);
 
 	/* Notification. */
 	int (*notify_poll_in)(struct vsock_sock *, size_t, bool *);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index f840498b5..ac64cb957 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2250,9 +2250,32 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	while (total_written < len) {
 		ssize_t written;
+		s64 min_space;
+
+		if (sk->sk_type == SOCK_SEQPACKET) {
+			/* A SEQPACKET message must be delivered atomically, so
+			 * wait until the whole remaining message fits before
+			 * enqueuing.  Otherwise a credit-limited partial send that
+			 * later errors out (e.g. -EINTR) leaves EOM-less fragments
+			 * that the peer merges into the next message.
+			 *
+			 * Reject a message that can never fit up front so the wait
+			 * below cannot block forever (a peer may advertise a small
+			 * buf_alloc); this mirrors the -EMSGSIZE the transport
+			 * returns for an oversized message.
+			 */
+			if (transport->seqpacket_max_size &&
+			    len > transport->seqpacket_max_size(vsk)) {
+				err = -EMSGSIZE;
+				goto out_err;
+			}
+			min_space = len - total_written;
+		} else {
+			min_space = 1;
+		}
 
 		add_wait_queue(sk_sleep(sk), &wait);
-		while (vsock_stream_has_space(vsk) == 0 &&
+		while (vsock_stream_has_space(vsk) < min_space &&
 		       sk->sk_err == 0 &&
 		       !(sk->sk_shutdown & SEND_SHUTDOWN) &&
 		       !(vsk->peer_shutdown & RCV_SHUTDOWN)) {
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c..b7d587a20 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -585,6 +585,7 @@ static struct virtio_transport virtio_transport = {
 		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
 		.seqpacket_allow          = virtio_transport_seqpacket_allow,
 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
+		.seqpacket_max_size       = virtio_transport_seqpacket_max_size,
 
 		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f225f53ed..e10e7b958 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -994,6 +994,19 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
 }
 EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_enqueue);
 
+u32 virtio_transport_seqpacket_max_size(struct vsock_sock *vsk)
+{
+	struct virtio_vsock_sock *vvs = vsk->trans;
+	u32 max_size;
+
+	spin_lock_bh(&vvs->tx_lock);
+	max_size = virtio_transport_tx_buf_size(vvs);
+	spin_unlock_bh(&vvs->tx_lock);
+
+	return max_size;
+}
+EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_max_size);
+
 int
 virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
 			       struct msghdr *msg,
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 8068d1b6e..b9a0cc861 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -90,6 +90,7 @@ static struct virtio_transport loopback_transport = {
 		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
 		.seqpacket_allow          = vsock_loopback_seqpacket_allow,
 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
+		.seqpacket_max_size       = virtio_transport_seqpacket_max_size,
 
 		.msgzerocopy_allow        = vsock_loopback_msgzerocopy_allow,
 
