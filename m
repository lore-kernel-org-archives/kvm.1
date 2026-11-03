Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793679148;
	b=pe0n/T8cw+xjwV5VwMAk3ZGMWrKLLXO2FtR10HA3Qscy6B/CgmsiForqJATzyFJvGZmJ
	 m/afOUfbFdGUfG/GEZwWR+iKf3WMFwber3veNzBscxO/9d/HK8w1RYF4d17u1vQ6J1qhW
	 qUHhIBp0r4UgPlFRYGr8E+wYcpAX1JZF6GaLeFE12TrHvVyZtzGbz85QP8L6kGgK6WBAN
	 HRxgNsiXHQvPz41at/cwnzcV6y+lbI9vP6Bes6ErOdvfuJt9q8zdSG3sTy5XFUZs2Cu/o
	 75Nst7emxxvQSBTtEdY9Ch/3vR1cW0AASC/suyPOursZDR6fzBnJ6R82tVPKFfkLJBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793679148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=muNE5kIzhzmSy9zy/DQorm6Ec+5hmWxUkOFZe0Ib8VE=;
	b=q3UBNR0Dgud4Tn03BOruJi13yLe8GHIbwz587g5mCX3k93JIPW8BXXAbcYvvDcIb4edG
	 2iFiV3N6RYjy++AY/t7A0pIPBfFr15KIPjFPDhFWXag5TcZLKbtC+AbOQPgtpXn2JjhQm
	 ORiF+Z4bJ/Jrfb7CpkqxBbbunNRDZdmDRylk6Eq3wyohjHGZ3X3nb+3iSpFJU8EEIlj3V
	 e3Ia1oEWII7bY7LwmibYKeLqvLqaW/1/Xb9MYWu537jzH32dN5ve9astEYnO+J4BGPLQt
	 1XqdFOyZrId2Ks3169FQnujm6Fb9FgpbmgKNft1c4lAEkngNuUUqf8n7hbF6g8ab0Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gNEHX1JC;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C3C606A330
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 04:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98C3C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gNEHX1JC
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so1623376a91.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 20:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793679147; x=1794283947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=muNE5kIzhzmSy9zy/DQorm6Ec+5hmWxUkOFZe0Ib8VE=;
        b=gNEHX1JCiFF60qj4wmZeZFrogcP2KBfERRy81C+qP7fhO00AyS/P3H87XfjjaAnY3a
         NsHu7zMQ7UxrnyGJ/SAn/JfPZ2O4G3ftckyAeyEJX9odi/VCKHtX53Sor/JakK8TiK3w
         3A/fFmiWRjXW8cfZmPXsQ6aNrOC3/cg+begWzi8N2mwf7iatkoGXdJ113hYCltF/0H2U
         DZ4WaNQWGo09VwLw/5uKAthmDr0U6JOhkws2rf5/p9+XaWJOyw40fA2THL3qrt0vprJu
         OovvJ54WlZR3PWLhztGREEys9gC7z2MzzX0DQClX764qO5a0dt47JuAAEoatLE9QPrlG
         yLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793679147; x=1794283947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=muNE5kIzhzmSy9zy/DQorm6Ec+5hmWxUkOFZe0Ib8VE=;
        b=UidJbGUkaIiB3J62K8Cn/+hqMXcnALxS3mLhUlnrhXgIsL9HNvrup3iLoKDBTwz8gf
         9r6L+P5zJ6U2EcbggbLxjVjkQh7WQadunLIy2lEqaEYzpzIJO4Wd0s1ubrbfns6L7/ux
         9fXX9d7jrp5eufa+E3b0HzYdx7mBBmkjejm+PDj/KJxy9XE5+zNMtOTy+1VAK2DcLjjr
         Q60w+92TzhCFcWS6T/8Cx+NnQJBezUz/ZpIzbnbQJyxu3dnv4aQv/xWU2wLp9ncXA2a0
         7c6AZshqm7RAzaq4AM/J3B+k0XjDkL3rYVpWfJLEvJtEsQIqT4kR7DSltaT8vd4JUBSU
         AftQ==
X-Forwarded-Encrypted: i=1; AKwUvBxyy1qZt/leS+rSApzObSNRVSD+OdehMHwXu8zY3pNeXTcrlhonLd+Oj3MCrZc5MIQ+u4A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8esLEU5ptHtxm5iAuZmiQul8r26ycPEwzzIcrubWIGyZuiy4G9
	AgLW3HaGQSKGwbpIBq7CiN7wcx/TbKs5Z97V0nI/VxM5cxd0jChw/RaQ
X-Gm-Gg: AYBFou1IvdBityqvkWsVDa1k5FVo0RSnJxwFiJfnq4YYvVg3T6DSxyWsgGCewDa225y
	F24d9uCjR82s2POBK6r9h6FD1bezoSnanvthho6I0KX4brLCNpT4jw6maxBj2RLX/GJmxn2Pkb4
	Al495ZOxiAqXvR3mYTpHqpURKpD5zvo78SlcTOsOJmBguvdSvPGJ0LoYWu4lOIhnCxFLCSV8V9/
	Nc3JLsu+UV5S9cl3fjIwjRDhaP7vpNunIbScMPnmO5RP20H9XyB2iXEKWjCbkS30Cv0a5kSBGju
	aavA7siundHbJSBLjhosaby1820/jsXgUlx0I80AXp2C4LFOHHhIaKPz4khywmND1WOlqm6H//N
	IuDrJF4OHSyoCO58DqKfnAGmav2T2lI75tSdBo/gv8vvx1d0DATD7daqB6+ZnuaqTxjMOK7KNCS
	V/qaFipj6AL8Apsx7oWHJXqvaDTlZSj4gvinR+J7DSRnVlHWDdfrDY9Z5Q/upO1+a0GYraxhU+f
	y6q/2/vjRpINrX+6w9dfY4ZAhplDnE+aK29flg6wAczDro/Ke/PqZ9BTWMBn7dQXasOFcClqwXs
	BDLJWB4=
X-Received: by 2002:a17:90b:2888:b0:3aa:fc22:8aa7 with SMTP id 98e67ed59e1d1-3ae89853f54mr10262747a91.53.1793679146575;
        Mon, 02 Nov 2026 20:12:26 -0800 (PST)
Received: from gmail.com ([2407:cdc0:f00f::117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6f010asm1941708a91.15.2026.11.02.20.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:12:26 -0800 (PST)
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
Subject: [PATCH net-next v5 1/5] vsock/virtio: split socket lookup from locked RX processing
Date: Tue,  3 Nov 2026 12:11:30 +0800
Message-Id: <20261103041134.33310-2-physicalmtea@gmail.com>
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

Split virtio_transport_recv_pkt() so socket lookup is separate from
processing that occurs while holding the socket lock. This prepares the
receive path to retain a looked-up socket across multiple packets in a
later change.

Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
Pass the caller-provided network namespace to the locked helper so reset
handling retains its existing semantics. Preserve source validation and
failure handling.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 131 ++++++++++++++----------
 1 file changed, 78 insertions(+), 53 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f225f53ed4bab..43325d7aebbb1 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1774,6 +1774,80 @@ static bool virtio_transport_valid_type(u16 type)
 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
 }
 
+static struct sock *
+virtio_transport_find_socket(struct sockaddr_vm *src,
+			     struct sockaddr_vm *dst, struct net *net)
+{
+	struct sock *sk;
+
+	sk = vsock_find_connected_socket_net(src, dst, net);
+	if (!sk)
+		sk = vsock_find_bound_socket_net(dst, net);
+
+	return sk;
+}
+
+/*
+ * The caller holds sk's socket lock.
+ */
+static void
+virtio_transport_recv_pkt_locked(struct virtio_transport *t,
+				 struct sk_buff *skb, struct sock *sk,
+				 struct net *net)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct vsock_sock *vsk = vsock_sk(sk);
+	struct sockaddr_vm src;
+	bool space_available;
+
+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
+			le32_to_cpu(hdr->src_port));
+
+	/*
+	 * The socket may have been closed or reassigned after lookup but before
+	 * its socket lock was acquired. Listener sockets have no assigned
+	 * transport.
+	 */
+	if (sock_flag(sk, SOCK_DONE) ||
+	    (sk->sk_state != TCP_LISTEN &&
+	     !vsock_check_source(vsk, &t->transport, &src))) {
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		kfree_skb(skb);
+		return;
+	}
+
+	space_available = virtio_transport_space_update(sk, skb);
+
+	/* Update CID in case it has changed after a transport reset event */
+	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
+		vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
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
+}
+
 /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
  * lock.
  */
@@ -1782,9 +1856,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct sockaddr_vm src, dst;
-	struct vsock_sock *vsk;
 	struct sock *sk;
-	bool space_available;
 
 	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
 			le32_to_cpu(hdr->src_port));
@@ -1808,13 +1880,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket_net(&src, &dst, net);
+	sk = virtio_transport_find_socket(&src, &dst, net);
 	if (!sk) {
-		sk = vsock_find_bound_socket_net(&dst, net);
-		if (!sk) {
-			(void)virtio_transport_reset_no_sock(t, skb, net);
-			goto free_pkt;
-		}
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		goto free_pkt;
 	}
 
 	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
@@ -1828,52 +1897,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
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
+	virtio_transport_recv_pkt_locked(t, skb, sk, net);
 
 	release_sock(sk);
 
-- 
2.53.0

