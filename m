Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40E2369D75
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 23:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390090; cv=none; b=dxyau/Cq3GlxubwMmmNYVK5IN53sU2RMQ3+gER5Z1AYTWCSDkLldZQQcmZc4i3/zhTT0AmEMFDE2AzTdpBuRK2dAvapnsrFKVCLOv6Nmaxs6328CTzojFIJ4klVJaBvGvoK5mWew044eu9ONaDtn2EJU0mzF1pcqvOG1UaEcwfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390090; c=relaxed/simple;
	bh=5V1mBK4+6n/Zucyqo2XDfm7ZN3GwgggVQjapNBOVBBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NaMS1Vs9+HzXPMNIBgWxyoxPNEvUF4wVp0b12QAjQqjg3gkKKibBGWXOhxdJDOoLPQCIvU9YUsicXDzrxgnTodJVYzf/pnNFUVaW+PDwBPkxqmqgmvswaqM/43acXpw6+w0kfMLa94hdEcFLGHYPEywn6W/Ne6zlq3+XukrjlLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pgomh2cv; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgomh2cv"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-467cefc56d2so1249038fac.0
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 16:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788390078; x=1788994878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=64gotFInHj04XMQZ+QbhT+/KY6QtyB9D0mjA1FukM2E=;
        b=pgomh2cvCEW8S6vbOWL2tHCAxRU0uzU/qvGdbmqBlfxjyMN4wynU+sxMAffjTYBW+c
         fD6+mTGb9gE0BjGtGU0IpaGtgViXwOOQsEuM3xvg1ndyShefVzrwpr2W+O1r0Pjs3ax8
         bDz2OlsU3bxoEV4EU8bwIVWYW5xz2D71LmVUZR7R2OIkJ0ySloJwbJ3Ie/gnM4mld/n9
         U0EeJFTlXqPr74Rq/vPsKRDSYcqVokFTRcOhJmZWnvbWcGSCOwuHnLZX0xrIdXvnPcSr
         5POcleCRingDR0565+s2PsGo7ghDdByqBrkhlR6DfgxK+248nRqa7RsjtOdDK1hw5BJI
         lXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390078; x=1788994878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=64gotFInHj04XMQZ+QbhT+/KY6QtyB9D0mjA1FukM2E=;
        b=iN4llQiFCGCaH5zBcS1x9GvAp90Tax8cUjzKZmmA5V97lO/J7L1WD5Feyys3lEQcgA
         Xriwp/yzdGQtox3dl1ERzaa2CDxxi2Rk5pGRRMJ7PzZy/HzMVPokifLBTTtz3i9UWfgB
         IvSlp8uJ05EsyIhcrtip9DuzsIRJz0GgUqNIqeIt8/HzavYO954zhHhjtuYnUJNYG0gL
         YCNUEzKHBXssQBti6MgMY/oW5XoGc85W4Tp2cGOdllM9ve9xm64WfuaI6ZqslITmolF1
         R2dToxlf6EkN5Pc3oq8dD6o3UVHrgPTMXWP5dZLJRp7IZiQQYyBjN9lyFsKyOc9HnujC
         ADDQ==
X-Forwarded-Encrypted: i=1; AKwUvByC+f6jr9pjYmzQSr6dx+rwty46AEWbP27jVwCcDRsB3IaUWZyVQ4wi5TWtB3BS+bwAB6g=@vger.kernel.org
X-Gm-Message-State: AFuF++mgvyLluA+rLDuJtTo51G7OG85iX+Qfm4H0W7jIR7P7mL3zvxim
	ypfstQzl8/IupL4Hy4dBgij711BXU93ghXDYgbSh1i0Y1eB+C1XK2UBp
X-Gm-Gg: AYBFou3kfhNtLs69j+kQ+fJvLaGY0O9HworfjXiSaTZ9cviiRC76mxLpO2TBGD+d4L6
	jAUXieJlqE9GMdr3x93BJuHx6+O1vWzZgwgMuwDhC84ZKwk0KTTxmnDem7QX7KTuawwR6BmL12O
	nnux8W/73ZmQCZs+fdoKN6DrjlvAoBmNSD0z927N0LlEnXeBBZR54GqtwiSCCKmfU0luTag0yeL
	0/OvtLMqCUsxMLlJG+z8WXyaLSqbKZ3z1OoQDDcU8bXPn/j1l1ILIpjI++CbY0YeOWS8IPwrkZq
	ZWakGhjGxD7eM09PUBM8a0fzLYU1Unj9xQOkgs+xZrRpBndWgR+2kqKy+z/XhW+apw+EmqcG0QI
	ksWj4qAeoBSCINw1itUTWGOzX8D4NJNNr4wAgDynXguZBCmK1aX+a427TQ9IjZOZJKmxuOTlQof
	sOI/dBE1zrZDDzk+3hKVnJ7t0oXPsmaqpg9OdMf5THeUT8pbPdsTDA6kDIzu1fBR6ReIqIYg==
X-Received: by 2002:a05:6870:1b8b:b0:448:a3d6:c2d2 with SMTP id 586e51a60fabf-46f8a4343eemr7642312fac.10.1788390077649;
        Wed, 02 Sep 2026 16:01:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46f30baa0d4sm5546944fac.6.2026.09.02.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:01:15 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 02 Sep 2026 16:00:49 -0700
Subject: [PATCH net-next 3/6] vsock/virtio: support guest device network
 namespace
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-vsock-guest-ns-v1-3-9995383e9a8b@meta.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
In-Reply-To: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

virtio-vsock did not have namespace support (the device was always
accessible to any global namespace).

Make the virtio-vsock device assignable to a namespace and initialize it
to init_net. Because virtio-vsock and init_net are both hardcoded to
global mode, nothing changes until the assign ioctl is issued.

When the device's local-mode namespace is being destroyed, received
packets are reset until new valid a namespace has been assigned and/or
automatically returned to, and the next RX batch begins (in
virtio_transport_rx_work). They are reset rather than dropped because
vsock does not retransmit, so a silent drop would leave the host waiting
for a timeout, and a connection request arriving in that window has no
socket whose teardown would tell it otherwise. This requires making
virtio_transport_reset_no_sock() available outside of the common code.

When a device is assigned to a namespace, every already established
vsock socket that is no longer able to reach the device is forcibly
reset. For that reason, adding new sockets to the connected table must
be performed atomically with regards to namespace assignment. This
ensures that when the socket is added to the connected table that it
actually passes the new reachability conditions set by ns assignment. If
it wins the race to the table and does NOT pass the reachability tests,
then the reset sweep will correctly catch it. This is the purpose
of the new helper 'vsock_maybe_set_connected()'.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/linux/virtio_vsock.h            |  2 ++
 net/vmw_vsock/virtio_transport.c        | 28 ++++++++++++++++++++++------
 net/vmw_vsock/virtio_transport_common.c | 28 +++++++++++++++++++++-------
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731057..9c68ce1d7fb4 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -286,6 +286,8 @@ void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
 void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
 void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
+int virtio_transport_reset_no_sock(const struct virtio_transport *t,
+				   struct sk_buff *skb, struct net *net);
 int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
 int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
 int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c3aa..a453a4f828dc 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -540,9 +540,14 @@ static bool virtio_transport_msgzerocopy_allow(void)
 	return true;
 }
 
+static bool virtio_transport_netns_assign_allow(void)
+{
+	return true;
+}
+
 bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 {
-	return vsock_net_mode_global(vsk);
+	return vsock_g2h_net_reachable(sock_net(sk_vsock(vsk)));
 }
 
 static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
@@ -587,6 +592,7 @@ static struct virtio_transport virtio_transport = {
 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
 
 		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,
+		.netns_assign_allow       = virtio_transport_netns_assign_allow,
 
 		.notify_poll_in           = virtio_transport_notify_poll_in,
 		.notify_poll_out          = virtio_transport_notify_poll_out,
@@ -616,7 +622,7 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 	struct virtio_vsock *vsock;
 	bool seqpacket_allow;
 
-	if (!vsock_net_mode_global(vsk))
+	if (!vsock_g2h_net_reachable(sock_net(sk_vsock(vsk))))
 		return false;
 
 	seqpacket_allow = false;
@@ -634,6 +640,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
 	struct virtio_vsock *vsock =
 		container_of(work, struct virtio_vsock, rx_work);
 	struct virtqueue *vq;
+	struct net *net;
+
+	net = vsock_g2h_net_get();
 
 	mutex_lock(&vsock->rx_lock);
 
@@ -682,10 +691,14 @@ static void virtio_transport_rx_work(struct work_struct *work)
 
 			virtio_transport_deliver_tap_pkt(skb);
 
-			/* Force virtio-transport into global mode since it
-			 * does not yet support local-mode namespacing.
-			 */
-			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
+			if (unlikely(!net)) {
+				virtio_transport_reset_no_sock(
+					&virtio_transport, skb, &init_net);
+				kfree_skb(skb);
+				continue;
+			}
+
+			virtio_transport_recv_pkt(&virtio_transport, skb, net);
 		}
 	} while (!virtqueue_enable_cb(vq));
 
@@ -694,6 +707,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
 		virtio_vsock_rx_fill(vsock);
 out_nofill:
 	mutex_unlock(&vsock->rx_lock);
+
+	if (net)
+		put_net(net);
 }
 
 static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 88df82364f77..313ef263fd2d 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1315,8 +1315,8 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
  * loopback, this is the namespace of the socket. For vhost, this is the
  * namespace of the VM (i.e., vhost_vsock).
  */
-static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
-					  struct sk_buff *skb, struct net *net)
+int virtio_transport_reset_no_sock(const struct virtio_transport *t,
+				   struct sk_buff *skb, struct net *net)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct virtio_vsock_pkt_info info = {
@@ -1355,6 +1355,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 
 	return t->send_pkt(reply, net);
 }
+EXPORT_SYMBOL_GPL(virtio_transport_reset_no_sock);
 
 /* This function should be called with sk_lock held and SOCK_DONE set */
 static void virtio_transport_remove_sock(struct vsock_sock *vsk)
@@ -1478,9 +1479,14 @@ virtio_transport_recv_connecting(struct sock *sk,
 
 	switch (le16_to_cpu(hdr->op)) {
 	case VIRTIO_VSOCK_OP_RESPONSE:
-		sk->sk_state = TCP_ESTABLISHED;
+		/* An assign cannot see a socket that is not connected yet. */
+		if (!vsock_maybe_set_connected(vsk)) {
+			skerr = ECONNRESET;
+			err = -ENETUNREACH;
+			goto destroy;
+		}
+
 		sk->sk_socket->state = SS_CONNECTED;
-		vsock_insert_connected(vsk);
 		sk->sk_state_change(sk);
 		break;
 	case VIRTIO_VSOCK_OP_INVALID:
@@ -1736,8 +1742,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 
 	lock_sock_nested(child, SINGLE_DEPTH_NESTING);
 
-	child->sk_state = TCP_ESTABLISHED;
-
 	vchild = vsock_sk(child);
 	vsock_addr_init(&vchild->local_addr, le64_to_cpu(hdr->dst_cid),
 			le32_to_cpu(hdr->dst_port));
@@ -1758,7 +1762,17 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	if (virtio_transport_space_update(child, skb))
 		child->sk_write_space(child);
 
-	vsock_insert_connected(vchild);
+	/* An assign cannot see a socket that is not connected yet, and the
+	 * check in vsock_assign_transport() above has since dropped
+	 * vsock_register_mutex.
+	 */
+	if (!vsock_maybe_set_connected(vchild)) {
+		release_sock(child);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
+		sock_put(child);
+		return -ENETUNREACH;
+	}
+
 	vsock_enqueue_accept(sk, child);
 	virtio_transport_send_response(vchild, skb);
 

-- 
2.53.0-Meta

