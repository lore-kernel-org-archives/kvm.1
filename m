Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.87.85
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836930;
	b=MHQqJtDMoxar1nFY6JUikxoPJiIccxP1fQ5ItCkxavNIzlBVeXFGcMpcinibKn9jCHd9
	 nuESJjcgi6Wyn2wC2gCfIg1fi39I+7jtcrR8GzjsgT9cIOjD8DRieEumOmV8RXReap3fL
	 QXPuR8EihBTJW4od0McBqRVuVpfNtxdmudAF/5DfGskHvkVXS84bI14kSPRGXDXxNa/os
	 237p0ByIpIZskR/+3RyZeLYxgayXB0ffdBhBq7vg4+pj+Sd2/n7zJPSwiYAqI5F8V3rL3
	 eE/hBVAAWA32fYghqUrUCyijmip05YIemzxHuo6FYxWNab4KGcW6v4/o4TWAkJH0jfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836930;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=Ql92w/EiEUHh3ETzdYT66p95Yh+dSsK+3cUt8nG9sDg=;
	b=GfgBMV9BT2aMau05YEI/z4flJosfCt0cMNcPae+1DZz+xIjFMn+30WYaRNLp5lq11mNO
	 Dhza0YlQPodtCYK6fwGeOmfiS4QAvroZIGjjKORKGdPWEpN6mNHcxmLssGf3AlD10zQjS
	 irM9jIB7ugy3n026ECfB/ZUm7zoxVzxwW95V3jD2hhq6lu5TpSVSNiACsm7++t0Ooohub
	 N9fS7GSzeBv5nZyoDMlB0Mwi1LmaH7QLqZmjTWj/gIv07dsyFnoaBI3Dhi3tUwV9NFlYL
	 N0GipdisulC/Mvl5Wn5Siw5YanrbVUQsI/Ll28vDW0dZ77h3EJia5E3VkXaII3X5ElQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linuxhacker.ru;
	spf=none smtp.mailfrom=linuxhacker.ru;
	arc=none smtp.remote-ip=159.69.87.85
Received: from eagle.linuxhacker.ru (linuxhacker.ru [159.69.87.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A110606D829;
	Thu,  5 Nov 2026 00:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A110606D829
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linuxhacker.ru
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linuxhacker.ru
Received: from intelbox1.virtnet (unknown [162.81.204.199])
	by eagle.linuxhacker.ru (Postfix) with ESMTPSA id 09E13BEE67;
	Thu,  5 Nov 2026 00:02:00 +0000 (UTC)
From: Oleg Drokin <green@linuxhacker.ru>
To: sgarzare@redhat.com,
	stefanha@redhat.com,
	mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	bobbyeshleman@meta.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] vhost/vsock: release the accounting of packets dropped on rx errors
Date: Wed,  4 Nov 2026 19:01:39 -0500
Message-ID: <20261105000141.3617241-2-green@linuxhacker.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105000141.3617241-1-green@linuxhacker.ru>
References: <20261105000141.3617241-1-green@linuxhacker.ru>
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

When vhost_transport_do_send_pkt() fails to deliver a packet to the guest
(unexpected output buffers, a buffer smaller than the header, a fault
while copying the header or the payload) it frees the skb with
kfree_skb() and gives up. The success path does more:
virtio_transport_consume_skb_sent() subtracts the payload from the
socket's bytes_unsent (SIOCOUTQ), and for a reply the queued_replies
counter is decremented, restarting the guest's tx queue once it drops
below the ring size.

The error paths skip both. Every such drop leaves SIOCOUTQ too high for
the life of the socket, and every dropped reply permanently takes one
slot of the queued_replies budget, so that after a ring's worth of them
vhost stops processing the guest's tx queue for good.

Release both on the error paths, as the success path does.

Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
Fixes: e6ab45005772 ("vsock/virtio: add SIOCOUTQ support for all virtio based transports")
Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
---
 drivers/vhost/vsock.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 88a310390eb0..b0004cb48999 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -104,6 +104,21 @@ static bool vhost_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
 	return found;
 }
 
+/* Undo the send accounting of an undelivered skb; true if tx may restart. */
+static bool vhost_vsock_drop_skb(struct vhost_vsock *vsock, struct sk_buff *skb)
+{
+	bool restart_tx = false;
+
+	if (virtio_vsock_skb_reply(skb)) {
+		int val = atomic_dec_return(&vsock->queued_replies);
+
+		restart_tx = val + 1 == vsock->vqs[VSOCK_VQ_TX].num;
+	}
+	virtio_transport_consume_skb_sent(skb, false);
+	kfree_skb(skb);
+	return restart_tx;
+}
+
 static void
 vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			    struct vhost_virtqueue *vq)
@@ -162,14 +177,14 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		}
 
 		if (out) {
-			kfree_skb(skb);
+			restart_tx |= vhost_vsock_drop_skb(vsock, skb);
 			vq_err(vq, "Expected 0 output buffers, got %u\n", out);
 			break;
 		}
 
 		iov_len = iov_length(&vq->iov[out], in);
 		if (iov_len < sizeof(*hdr)) {
-			kfree_skb(skb);
+			restart_tx |= vhost_vsock_drop_skb(vsock, skb);
 			vq_err(vq, "Buffer len [%zu] too small\n", iov_len);
 			break;
 		}
@@ -212,7 +227,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 
 		nbytes = copy_to_iter(hdr, sizeof(*hdr), &iov_iter);
 		if (nbytes != sizeof(*hdr)) {
-			kfree_skb(skb);
+			restart_tx |= vhost_vsock_drop_skb(vsock, skb);
 			vq_err(vq, "Faulted on copying pkt hdr\n");
 			break;
 		}
@@ -221,7 +236,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 					   offset,
 					   &iov_iter,
 					   payload_len)) {
-			kfree_skb(skb);
+			restart_tx |= vhost_vsock_drop_skb(vsock, skb);
 			vq_err(vq, "Faulted on copying pkt buf\n");
 			break;
 		}
-- 
2.56.0

