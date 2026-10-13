Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78934B0E42
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873098; cv=none; b=THbcjryptzV8tJVKtqMYvCnVa1K9WgBGfLCpInHLPlz0njzYPrzdxgAJ/MYYT4dfPlGQPFoDSaUG9IyUT57TrUCCPKpYCjTyvrmzH4sCseeV6+O62CZvaOc+1ywC9IMwGdPjKeRp0JCf9O+CsYrPydggh6z8nW7VOXmXjADrsjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873098; c=relaxed/simple;
	bh=Zg458LzF07n4Bhy5KiIU/3ZzL6a1HDj9LM2QCnTima8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ua0ofR3+UpCe6WtOsITOAT6HU9sr2BbUW+bahO9YkuioyKAMSS8S0XD78u6ZfHobJoleSnpS9NSEfsAulP24fyPoiUbDaPKyk9GN9jBv1bDL/iOiykI5FRdT6axxfgWUo13iaTDabtSvOvWg9NhkFK2g63TGqOa+bwMeOfsk4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9JCFlgB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9JCFlgB"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso1228055a91.0
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 23:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791873096; x=1792477896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=okzwzxdxUbrp2znit6I2Xx1ZmvtO45qgM4jYMaoK7Ts=;
        b=Q9JCFlgB12j6ww+rxSu0MRQft9NT5TsWX5JmD/RPROnttp7Bl2di/uKAr4R2ryi0RN
         CFyYUy+vHOU6Ph1BYKvDymYZB7SaozD5/y8BcFRpyI08v2jkop7mxpe3ufdakeAapV5l
         MIbjVXSP2GFFBo8i+qYhkkjTvavq8b7sAO3HPPoMQcuOVsw5elf1b0oEr0+e8NWSU7Sc
         nzXCtjwIXnibq3D+/8DmevVncQ+R0dvKfzRPf3HoSFtAFNEkNYfHEjCelzgiD4+PN/7I
         GmtVdjud5U2hW79KpjnBsU+RH0JcAI22eV6cS9+9VyjKZ6Yc7AB7gYTVOhw65N267wzN
         WLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791873096; x=1792477896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=okzwzxdxUbrp2znit6I2Xx1ZmvtO45qgM4jYMaoK7Ts=;
        b=XYhH2ASx7u54lRlVGXQjPXtzqKvz8nmyaNA7vGvF5b7q89tSdu+LtgblIVtJxlR3EV
         0o1PszI3X/Qs0NVdcCv7db2bVeF4w8kED4f4V0qgIna1TrGimln2xK1YTZLe+T2dGJhs
         t2uuGfvR0DfYwloNrOdEk3vDQuoikN/KyqB4uP35xd7EqhQgntxuGn2wcYbnEjONnKGp
         QwtZtvLan7NAPSm/Vlc/sqMZDwe+vvc7Fe7gW0TN72399XYFMDg1PMtOQddVxogO1yU1
         mW1wa2eseMYg15qACR/3qtXfezaO/5qTH2BgqgrYTvawxU3L5nediEyUtN4N/jhvnS3u
         QnKg==
X-Forwarded-Encrypted: i=1; AKwUvByetb98jh2Shv4PnNJtpyrKZ2wx2298gB+qejyr2N3WnXvpy/B+lo29T54UAy6sWKjCj/Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYIA4XW6V/V4BhyVwnUSQJKKX66DxEJ8NI171GBi7q37rSzZmQTA
	dSTXnJAHU2ItHr3La7TcqdrdhBZJpUwgo3zu9jDPzonJTWP2jtULaLC/
X-Gm-Gg: AYBFou2LrFGlwV+AYptcXhi5AGSGC6LjXTUecAfy10+tfow+FdkZiDvWN9xmEnXvTpr
	nNr+8cSrZN/NC+hdnGze1nRPkFoii2SyKgtJT9rXc5bW++FEyc+n4QTZqXjKZStNGsIe2YoWYG5
	jtwXjbtWTmH0uQj77EXeOUzFWbzZvLmEG3Nh9n5pj/RKUjASiYwj/HQY620PCS+ouPMr+W+NWYV
	vl0F0jJF4dgWOl49UnPmxYAGUh/6Rnkb6Oy+czUAVDPD6UKWk2ErAF/1lcwb03x73zfviQ9Vo/K
	CMkzdRN8G29a6GR82HWx6hOxUHc1ZMfUR46+sHSrLkBrUalBJnnVGpp2kJP/XZAW2h+0XkDQPUz
	NL99JGWKd++8aC4unvk7UQWynup+k97NhbeY3JvBX0y8xa1xNDfdS+TxokY7zWazQXTM3kAhJiS
	bjauI74hvACxyOrUuAUes9xFxFS1GdX6x3cKDY95BzqZ2pQfjuSCoZEvHYt3To7ranKbUWDg==
X-Received: by 2002:a17:90b:1d03:b0:3a8:181a:2bfb with SMTP id 98e67ed59e1d1-3ab3a949a69mr7602301a91.23.1791873095636;
        Mon, 12 Oct 2026 23:31:35 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3abdd5adaadsm8875770a91.0.2026.10.12.23.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 23:31:35 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/4] vsock/virtio: split socket lookup from locked RX processing
Date: Tue, 13 Oct 2026 14:31:09 +0800
Message-Id: <20261013063112.168321-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013063112.168321-1-physicalmtea@gmail.com>
References: <20261013063112.168321-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split virtio_transport_recv_pkt() so socket lookup is separate from the
receive state machine that runs under the socket lock. This prepares the
receive path for keeping a looked-up socket across multiple packets in a
later change.

Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
Pass the network namespace and decoded address tuple directly to the locked
receive path, preserving source validation and failure handling.

No functional change intended.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 153 ++++++++++++++----------
 1 file changed, 87 insertions(+), 66 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f225f53ed4bab..8a930bc42fdc3 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1774,6 +1774,87 @@ static bool virtio_transport_valid_type(u16 type)
 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
 }
 
+static struct sock *
+virtio_transport_find_socket(struct sk_buff *skb, struct sockaddr_vm *src,
+			     struct sockaddr_vm *dst, struct net *net)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct sock *sk;
+
+	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type)))
+		return NULL;
+
+	sk = vsock_find_connected_socket_net(src, dst, net);
+	if (!sk)
+		sk = vsock_find_bound_socket_net(dst, net);
+	if (!sk)
+		return NULL;
+
+	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
+		sock_put(sk);
+		return NULL;
+	}
+
+	return sk;
+}
+
+/*
+ * The caller holds sk's socket lock and must free skb if this returns true.
+ */
+static bool
+virtio_transport_recv_pkt_locked(struct virtio_transport *t,
+				 struct sk_buff *skb, struct sock *sk,
+				 const struct sockaddr_vm *src,
+				 const struct sockaddr_vm *dst,
+				 struct net *net)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+	bool space_available;
+
+	/* Listener sockets accept packets from any source and are not assigned to
+	 * a transport.
+	 */
+	if (sock_flag(sk, SOCK_DONE) ||
+	    (sk->sk_state != TCP_LISTEN &&
+	     !vsock_check_source(vsk, &t->transport, src))) {
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		return true;
+	}
+
+	space_available = virtio_transport_space_update(sk, skb);
+
+	/* Update CID in case it has changed after a transport reset event */
+	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
+		vsk->local_addr.svm_cid = dst->svm_cid;
+
+	if (space_available)
+		sk->sk_write_space(sk);
+
+	switch (sk->sk_state) {
+	case TCP_LISTEN:
+		virtio_transport_recv_listen(sk, skb, t);
+		kfree_skb(skb);
+		break;
+	case TCP_SYN_SENT:
+		virtio_transport_recv_connecting(sk, skb);
+		kfree_skb(skb);
+		break;
+	case TCP_ESTABLISHED:
+		virtio_transport_recv_connected(sk, skb);
+		break;
+	case TCP_CLOSING:
+		virtio_transport_recv_disconnecting(sk, skb);
+		kfree_skb(skb);
+		break;
+	default:
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		kfree_skb(skb);
+		break;
+	}
+
+	return false;
+}
+
 /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
  * lock.
  */
@@ -1782,9 +1863,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct sockaddr_vm src, dst;
-	struct vsock_sock *vsk;
 	struct sock *sk;
-	bool space_available;
+	bool free_pkt;
 
 	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
 			le32_to_cpu(hdr->src_port));
@@ -1800,26 +1880,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 					le32_to_cpu(hdr->buf_alloc),
 					le32_to_cpu(hdr->fwd_cnt));
 
-	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
-		(void)virtio_transport_reset_no_sock(t, skb, net);
-		goto free_pkt;
-	}
-
-	/* The socket must be in connected or bound table
-	 * otherwise send reset back
-	 */
-	sk = vsock_find_connected_socket_net(&src, &dst, net);
+	sk = virtio_transport_find_socket(skb, &src, &dst, net);
 	if (!sk) {
-		sk = vsock_find_bound_socket_net(&dst, net);
-		if (!sk) {
-			(void)virtio_transport_reset_no_sock(t, skb, net);
-			goto free_pkt;
-		}
-	}
-
-	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
 		(void)virtio_transport_reset_no_sock(t, skb, net);
-		sock_put(sk);
 		goto free_pkt;
 	}
 
@@ -1828,59 +1891,17 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		goto free_pkt;
 	}
 
-	vsk = vsock_sk(sk);
-
 	lock_sock(sk);
-
-	/* Check if sk has been closed or assigned to another transport before
-	 * lock_sock (note: listener sockets are not assigned to any transport)
-	 */
-	if (sock_flag(sk, SOCK_DONE) ||
-	    (sk->sk_state != TCP_LISTEN &&
-	     !vsock_check_source(vsk, &t->transport, &src))) {
-		(void)virtio_transport_reset_no_sock(t, skb, net);
-		release_sock(sk);
-		sock_put(sk);
-		goto free_pkt;
-	}
-
-	space_available = virtio_transport_space_update(sk, skb);
-
-	/* Update CID in case it has changed after a transport reset event */
-	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
-		vsk->local_addr.svm_cid = dst.svm_cid;
-
-	if (space_available)
-		sk->sk_write_space(sk);
-
-	switch (sk->sk_state) {
-	case TCP_LISTEN:
-		virtio_transport_recv_listen(sk, skb, t);
-		kfree_skb(skb);
-		break;
-	case TCP_SYN_SENT:
-		virtio_transport_recv_connecting(sk, skb);
-		kfree_skb(skb);
-		break;
-	case TCP_ESTABLISHED:
-		virtio_transport_recv_connected(sk, skb);
-		break;
-	case TCP_CLOSING:
-		virtio_transport_recv_disconnecting(sk, skb);
-		kfree_skb(skb);
-		break;
-	default:
-		(void)virtio_transport_reset_no_sock(t, skb, net);
-		kfree_skb(skb);
-		break;
-	}
-
+	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &src, &dst,
+						    net);
 	release_sock(sk);
 
 	/* Release refcnt obtained when we fetched this socket out of the
 	 * bound or connected list.
 	 */
 	sock_put(sk);
+	if (free_pkt)
+		kfree_skb(skb);
 	return;
 
 free_pkt:
-- 
2.53.0

