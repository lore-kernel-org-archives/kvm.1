Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.87.85
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941388;
	b=Rxg4cETTqgPqW4KI92xwvWmpwI5w+C9/vKRB0TiG5fSaQ6hXFkKoDTt0pal+5MwHLdQv
	 QjDiRXRjCAACiNrGT9DPvgFl6es08SdAk5lbrA4FRkUtBAa1DSYLR+pxico8b48/aoGuB
	 YjoeyvyTc7EJHmRcwGdunjHUJjDWonoiJh8R08fVwogUZ5W3/NQ7DDv07IOIiQ3KhPyf3
	 RD2XdXowyHTn1irf7L3/jGjAT2kQgXkQnkEjcVGDTI1OSMQENKjeqRp+Pder9ZSm2sS42
	 2UbYy3ZheMa8kOhjHXDXSilM4bYTjPA5+MCWzbTTHqqBs0sfZOukSHcxf9MFnmIyl6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941388;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=huvRpdQxu5unJL4IKJvJL3fCbaqo/nPWMO2++QsJFvI=;
	b=e6wbQ013+651cbHTUj57X4i97eO5cpTMWEe4hPHR14S6lyI94uK5Zu//op971uWubLhC
	 uZ7D/gwMhMS5GXDE1bVn9hDkNHJ1ay3fdcyP7ftKW9il1bhWDDg4Nlk9N2stXLaUd3zlt
	 L/od4UgutgQ5jmDRcdu7sZScKCORTOtGpwLB1+Kn7+OEQxmQBr2Jg8UvSYk1vZKWbEB9w
	 +cCMF/h5JJNBLYEmKY4agZJpDKbWhbiLkF3sjTMClwo1SC7P4c79QJdH8CWWwvvPyvgF3
	 TOlWcj7tpG0mXt4zBvqzwaD0Wzr9rqp1NPo+5U8olAOGpOqGJAQAZBHyGDarFLxy+Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxhacker.ru;
	spf=pass smtp.mailfrom=linuxhacker.ru;
	dkim=pass header.d=linuxhacker.ru header.i=@linuxhacker.ru header.a=rsa-sha256 header.s=mail header.b=pJV6LErh;
	arc=none smtp.remote-ip=159.69.87.85
Received: from eagle.linuxhacker.ru (linuxhacker.ru [159.69.87.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532FC606A339;
	Fri,  6 Nov 2026 05:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 532FC606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxhacker.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxhacker.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linuxhacker.ru header.i=@linuxhacker.ru header.a=rsa-sha256 header.s=mail header.b=pJV6LErh
Received: from intelbox1.virtnet (unknown [162.81.204.199])
	by eagle.linuxhacker.ru (Postfix) with ESMTPSA id E36D4BEE67;
	Fri,  6 Nov 2026 05:03:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 eagle.linuxhacker.ru E36D4BEE67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxhacker.ru;
	s=mail; t=1793941385;
	bh=NEmHPxgdCgP5LEraAZFaWFE29jwBPGLQnXjlp0QdjEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJV6LErhgigmKYbg61Gg7A6mxizilCVJ85VWZ1MLJ7EgQewZ5v12+QhY3lDICjnqo
	 A5I1bajI/7IlH99tT/O17xAOJPVpYkLNZSSiFjRuaQXbBBw7zbt7UqtFsxojBNVdhx
	 UYXAOPd8wbVW/Kemm8oBAn9pOaKA+4DPqGUGDOS4U8Vwg09DsVWQorVghcBbqueUjS
	 JL3X64OL6U7Edre70zoU7Z8MKLq92tnuCRauvrZvAv4yhLhHOgRyal8k9pVDP617dk
	 tZjFQfd7bCUVk3RlitrKl2J78NpTktY3KdcxhLACT8Qs9WMW/lau44uBKPy/J2ppfW
	 4vgTaVbZDbHug==
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
Subject: [PATCH net v2 1/3] vhost/vsock: release the accounting of packets dropped on rx errors
Date: Fri,  6 Nov 2026 00:02:42 -0500
Message-ID: <20261106050244.602625-2-green@linuxhacker.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106050244.602625-1-green@linuxhacker.ru>
References: <20261106050244.602625-1-green@linuxhacker.ru>
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

Found by an LLM-assisted security review of vhost-vsock, done while
porting a project from Xen to KVM. These error paths were not
reproduced: they need a guest that posts malformed rx buffers.

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

