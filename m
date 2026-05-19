Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C134409115
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209849; cv=none; b=aA49x8TtF8Ay9BXkddwSPfgLzsq+YH7qUyzGWvQ8PxfSkZUTemjW9+h4nmSlbMZBwKhY5ksJAHOD2wRvlQkKVUxUZ2M8+OJdbfjCR8Y4qTKMu1zyxgZdQQDfWANBKFdNiENI5XGzRn9aDmXQLYjpiixmUwe8W8tdjkmyYftQPqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209849; c=relaxed/simple;
	bh=/dxqY7vF83zqkB9TeiJY/hUNAh4ZjWZkHbYyxtAuPwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RD0AoeqhilUrYNnY3bJ7F3F/skfpESvPwT38w1eYNvbmSpu6J9v5fH2YsjGW2mAFCusoVfUdBANTkhDygJBp4RZGZPgDkepN81StwegP7bfi4WkpYZvLjlSONAl0pYsMDT9ATLF7YFnw3ydx3RkTc0GgY46juN6JOl01GJxGSHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/ZdmZSn; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/ZdmZSn"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c7963df896fso128753a12.3
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 09:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779209846; x=1779814646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TXSSb+QnSoLncqTyl5C1Wf9KSszK/YhT+NIcZleisWI=;
        b=O/ZdmZSnxyCIZCAjLM7bxtrDB1QqLs+7cV6vMMKosq5UsUbTXgB9Rfoi+T9fwVXUCc
         quWxqeqNaiz5XQcYHqOqLo+IXqVjPRxPZHvYC6e8PSy45Hjovd/6svCg36YSVvAX8+80
         ZxBY1yuREZNpsp0adbai4ewHsJoC0uqnrEZ5uc2s2z6eX2d5yQUZBB87fPirmRQNG8Bn
         MrXbhp0eLJH2IcdGexbQ6MWRs45e+b6yvtX7fyWvs/B3QGBmUGas4jYVv1IGqt0Qi7Ha
         i0fysplSrsBs1VW7guG73hARhF1ioLdAODpA6K16LfJpaVkG1nkwo3Vx3uf4MkpmX72I
         GY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779209846; x=1779814646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXSSb+QnSoLncqTyl5C1Wf9KSszK/YhT+NIcZleisWI=;
        b=rhWKARFtaYp+ze4YN7qsHenLPf6yrBbU4iPoqe8Qv4gGurDV/VF4dUUqsavsR2022G
         bcC0CcvEmO4RZQtCORI4sR++EUsZQpk+blCeMZcG5W+XAu/B7b+AKwWjVhnxWOFT9TqX
         gri5rgLCU5p2qtP9JLTt9h5NxoIKyinrCbpbmmDKDncbp3lqNvz+ALHGIDD9oQ1P+Bqh
         4bPotOaYs2EsvbOER5ot9f6T5GHjrccol6w9hhHuhjeQ9zZTauQVQgdDza8J8IqFl5bb
         Z4R56tUophp6xp1WjuayU57gNr/x7lOK6qezdAeDCuLWWMLjB85S6glv/zncGkBwBC9g
         C/tA==
X-Forwarded-Encrypted: i=1; AFNElJ9g73FfFgo7rQzLhkNpgb4+hcHYpjSk/kwrpD9LI9/dRP6P5RH5jBH8oXxBp/xLLRXCx28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwTJJIz/TCKVVt8y0kJx7+bPsD9E6aYOtq6Thvwv1hT7NaJOz2
	BpRGamDSxTxSRVJ8t2H/5W7IehoTXuh4Q9s+1f4oQJtdTmG2sOR2igTr
X-Gm-Gg: Acq92OFAukIxUhssk2JCI/qeO+/QuqrGwi4mLb+OqmQxpgP4ZgeiBmhcOdpAWVlW8q4
	mjTxtYfdwNw+DHkNxVG/Ag2LoM0QimoZDyqHDyfHcSIS9BztpNXXnGiFid6nP1ZinEoahBwIMj5
	PlsPetkMN5jv3g2LCK9qlAUfyBVZGtaAKSVp4KlDHpG6CzW+r1RtNADOxhC1dXWg1xV6xP4JIST
	EW4hXLLgrPYxLSe4jxY5uXvKwG5Kw6cC0oMNMc3CzgAG/Tf5aduDLtSjvzHr271dkU3jETetxS6
	ya+64VpBkJJnhLH6IiZ7NJYsF0WSUk/JXXKN5MWAZ+3IKsSIJed74OEKIvjkDmaBWUaeS6Os+vr
	JQFwq75xX/7QFjGRqBpLCdKIGsT+mEJLRMao59VfmHqCAfGpiluKDV4MAbb2RuA0Of8Ga/5CJmU
	hVnYv8J1Bmccfd6JzramjGYHlgYpHFuf3rd3DNm7+QchJN
X-Received: by 2002:a17:903:2ec7:b0:2bd:9875:d457 with SMTP id d9443c01a7336-2bd9875d4fdmr109091215ad.8.1779209846248;
        Tue, 19 May 2026 09:57:26 -0700 (PDT)
Received: from gmail.com ([117.133.78.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fe67sm204597705ad.3.2026.05.19.09.57.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 May 2026 09:57:25 -0700 (PDT)
From: Ziyu Zhang <ziyuzhang201@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Andy King <acking@vmware.com>,
	George Zhang <georgezhang@vmware.com>,
	Dmitry Torokhov <dtor@vmware.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	gality369@gmail.com,
	zhenghaoran154@gmail.com,
	hanguidong02@gmail.com,
	zzzccc427@gmail.com,
	Ziyu Zhang <ziyuzhang201@gmail.com>
Subject: [PATCH net v2] vsock: keep poll shutdown state consistent
Date: Wed, 20 May 2026 00:56:36 +0800
Message-Id: <20260519165636.62542-1-ziyuzhang201@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vsock_poll() reads vsk->peer_shutdown before taking the socket lock
to set EPOLLHUP and EPOLLRDHUP, then reads it again after taking
the lock to report EOF readability. A shutdown packet can update
peer_shutdown while poll is waiting for the lock, so one poll invocation
can report EOF readability without the corresponding HUP/RDHUP bits.

For connectible sockets, take one peer_shutdown snapshot after
lock_sock() and use it for all peer-shutdown-derived poll bits. For
datagram sockets, which do not take lock_sock() in poll(), take one
lockless READ_ONCE() snapshot and pair it with WRITE_ONCE() on the
writer side.

This keeps the peer-shutdown-derived bits internally consistent for each
poll pass.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
---
Link: https://lore.kernel.org/netdev/20260516034745.260442-1-ziyuzhang201@gmail.com/

v2:
- Pair lockless READ_ONCE() users with WRITE_ONCE() on peer_shutdown writers.
- Move datagram shutdown handling into the SOCK_DGRAM branch and add a comment.
- Keep one connectible peer_shutdown snapshot after lock_sock() and
  restore the previous shutdown-derived mask ordering.

 net/vmw_vsock/af_vsock.c                | 49 ++++++++++++++++---------
 net/vmw_vsock/hyperv_transport.c        |  9 +++--
 net/vmw_vsock/virtio_transport_common.c | 14 ++++---
 net/vmw_vsock/vmci_transport.c          |  8 ++--
 4 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index adcba1b7b..789b00f6e 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -523,7 +523,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		 */
 		sock_reset_flag(sk, SOCK_DONE);
 		sk->sk_state = TCP_CLOSE;
-		vsk->peer_shutdown = 0;
+		WRITE_ONCE(vsk->peer_shutdown, 0);
 	}
 
 	if (sk->sk_type == SOCK_SEQPACKET) {
@@ -814,7 +814,7 @@ static struct sock *__vsock_create(struct net *net,
 	vsk->rejected = false;
 	vsk->sent_request = false;
 	vsk->ignore_connecting_rst = false;
-	vsk->peer_shutdown = 0;
+	WRITE_ONCE(vsk->peer_shutdown, 0);
 	INIT_DELAYED_WORK(&vsk->connect_work, vsock_connect_timeout);
 	INIT_DELAYED_WORK(&vsk->pending_work, vsock_pending_work);
 
@@ -1122,6 +1122,25 @@ static int vsock_shutdown(struct socket *sock, int mode)
 	return err;
 }
 
+static __poll_t vsock_poll_shutdown(struct sock *sk, u32 peer_shutdown)
+{
+	__poll_t mask = 0;
+
+	/* INET sockets treat local write shutdown and peer write shutdown as a
+	 * case of EPOLLHUP set.
+	 */
+	if (sk->sk_shutdown == SHUTDOWN_MASK ||
+	    ((sk->sk_shutdown & SEND_SHUTDOWN) &&
+	     (peer_shutdown & SEND_SHUTDOWN)))
+		mask |= EPOLLHUP;
+
+	if (sk->sk_shutdown & RCV_SHUTDOWN ||
+	    peer_shutdown & SEND_SHUTDOWN)
+		mask |= EPOLLRDHUP;
+
+	return mask;
+}
+
 static __poll_t vsock_poll(struct file *file, struct socket *sock,
 			       poll_table *wait)
 {
@@ -1139,24 +1158,17 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 		/* Signify that there has been an error on this socket. */
 		mask |= EPOLLERR;
 
-	/* INET sockets treat local write shutdown and peer write shutdown as a
-	 * case of EPOLLHUP set.
-	 */
-	if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
-	    ((sk->sk_shutdown & SEND_SHUTDOWN) &&
-	     (vsk->peer_shutdown & SEND_SHUTDOWN))) {
-		mask |= EPOLLHUP;
-	}
-
-	if (sk->sk_shutdown & RCV_SHUTDOWN ||
-	    vsk->peer_shutdown & SEND_SHUTDOWN) {
-		mask |= EPOLLRDHUP;
-	}
-
 	if (sk_is_readable(sk))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
 	if (sock->type == SOCK_DGRAM) {
+		u32 peer_shutdown = READ_ONCE(vsk->peer_shutdown);
+
+		/* DGRAM sockets do not take lock_sock() in poll(), so use one
+		 * lockless snapshot for all shutdown-derived mask bits.
+		 */
+		mask |= vsock_poll_shutdown(sk, peer_shutdown);
+
 		/* For datagram sockets we can read if there is something in
 		 * the queue and write as long as the socket isn't shutdown for
 		 * sending.
@@ -1171,6 +1183,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 
 	} else if (sock_type_connectible(sk->sk_type)) {
 		const struct vsock_transport *transport;
+		u32 peer_shutdown;
 
 		lock_sock(sk);
 
@@ -1203,8 +1216,10 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 		 * terminated should also be considered read, and we check the
 		 * shutdown flag for that.
 		 */
+		peer_shutdown = READ_ONCE(vsk->peer_shutdown);
+		mask |= vsock_poll_shutdown(sk, peer_shutdown);
 		if (sk->sk_shutdown & RCV_SHUTDOWN ||
-		    vsk->peer_shutdown & SEND_SHUTDOWN) {
+		    peer_shutdown & SEND_SHUTDOWN) {
 			mask |= EPOLLIN | EPOLLRDNORM;
 		}
 
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 432fcbbd1..16b981566 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -264,7 +264,7 @@ static void hvs_do_close_lock_held(struct vsock_sock *vsk,
 	struct sock *sk = sk_vsock(vsk);
 
 	sock_set_flag(sk, SOCK_DONE);
-	vsk->peer_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
 	if (vsock_stream_has_data(vsk) <= 0)
 		sk->sk_state = TCP_CLOSING;
 	sk->sk_state_change(sk);
@@ -593,7 +593,9 @@ static int hvs_update_recv_data(struct hvsock *hvs)
 		return -EIO;
 
 	if (payload_len == 0)
-		hvs->vsk->peer_shutdown |= SEND_SHUTDOWN;
+		WRITE_ONCE(hvs->vsk->peer_shutdown,
+			   READ_ONCE(hvs->vsk->peer_shutdown) |
+			   SEND_SHUTDOWN);
 
 	hvs->recv_data_len = payload_len;
 	hvs->recv_data_off = 0;
@@ -715,7 +717,8 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 			return ret;
 		return hvs->recv_data_len;
 	case 0:
-		vsk->peer_shutdown |= SEND_SHUTDOWN;
+		WRITE_ONCE(vsk->peer_shutdown,
+			   READ_ONCE(vsk->peer_shutdown) | SEND_SHUTDOWN);
 		ret = 0;
 		break;
 	default: /* -1 */
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d58..71d8eac82 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1220,7 +1220,7 @@ static void virtio_transport_do_close(struct vsock_sock *vsk,
 	struct sock *sk = sk_vsock(vsk);
 
 	sock_set_flag(sk, SOCK_DONE);
-	vsk->peer_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
 	if (vsock_stream_has_data(vsk) <= 0)
 		sk->sk_state = TCP_CLOSING;
 	sk->sk_state_change(sk);
@@ -1411,12 +1411,15 @@ virtio_transport_recv_connected(struct sock *sk,
 	case VIRTIO_VSOCK_OP_CREDIT_UPDATE:
 		sk->sk_write_space(sk);
 		break;
-	case VIRTIO_VSOCK_OP_SHUTDOWN:
+	case VIRTIO_VSOCK_OP_SHUTDOWN: {
+		u32 peer_shutdown = READ_ONCE(vsk->peer_shutdown);
+
 		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SHUTDOWN_RCV)
-			vsk->peer_shutdown |= RCV_SHUTDOWN;
+			peer_shutdown |= RCV_SHUTDOWN;
 		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SHUTDOWN_SEND)
-			vsk->peer_shutdown |= SEND_SHUTDOWN;
-		if (vsk->peer_shutdown == SHUTDOWN_MASK) {
+			peer_shutdown |= SEND_SHUTDOWN;
+		WRITE_ONCE(vsk->peer_shutdown, peer_shutdown);
+		if (peer_shutdown == SHUTDOWN_MASK) {
 			if (vsock_stream_has_data(vsk) <= 0 && !sock_flag(sk, SOCK_DONE)) {
 				(void)virtio_transport_reset(vsk, NULL);
 				virtio_transport_do_close(vsk, true);
@@ -1431,6 +1434,7 @@ virtio_transport_recv_connected(struct sock *sk,
 		if (le32_to_cpu(virtio_vsock_hdr(skb)->flags))
 			sk->sk_state_change(sk);
 		break;
+	}
 	case VIRTIO_VSOCK_OP_RST:
 		virtio_transport_do_close(vsk, true);
 		break;
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 7eccd6708..c2231c402 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -811,7 +811,7 @@ static void vmci_transport_handle_detach(struct sock *sk)
 		/* On a detach the peer will not be sending or receiving
 		 * anymore.
 		 */
-		vsk->peer_shutdown = SHUTDOWN_MASK;
+		WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
 
 		/* We should not be sending anymore since the peer won't be
 		 * there to receive, but we can still receive if there is data
@@ -1534,7 +1534,9 @@ static int vmci_transport_recv_connected(struct sock *sk,
 		if (pkt->u.mode) {
 			vsk = vsock_sk(sk);
 
-			vsk->peer_shutdown |= pkt->u.mode;
+			WRITE_ONCE(vsk->peer_shutdown,
+				   READ_ONCE(vsk->peer_shutdown) |
+				   pkt->u.mode);
 			sk->sk_state_change(sk);
 		}
 		break;
@@ -1551,7 +1553,7 @@ static int vmci_transport_recv_connected(struct sock *sk,
 		 * a clean shutdown.
 		 */
 		sock_set_flag(sk, SOCK_DONE);
-		vsk->peer_shutdown = SHUTDOWN_MASK;
+		WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
 		if (vsock_stream_has_data(vsk) <= 0)
 			sk->sk_state = TCP_CLOSING;
 
-- 
2.43.0

