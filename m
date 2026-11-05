Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.87.85
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836929;
	b=MLJ8JkFqEtzX9z6Y8ZLt+hjMfkPl6u7EwRzSDkRCq/ckjFOyAa6/nbuHN1QzUTvUxm6X
	 Fpc87f0PEqp1/oPBXTBk2qaymFpPkmzDfL4znYOppvaCPdtQ0CfUsj0AbE+rPjhcZKWTw
	 ZC+wOtF405DVJxP7bDszQgrMH/3KXsEx60umVlaF1rTpypz6nO4NTOkRjpKa200ZKBo3H
	 kRxz9k2xI53nVo5+LcPT2bnmodFaOv9qu79lsS7Gh7S50CaL1sQWUwaT4WCF43tTx0y9C
	 oORut80CWMxmGWhsmg9Q/8/2Pzruamb9ulN8W1F7SUqA+pEg65PJBCLQs+QjhC76EFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836929;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=gvXZud60WW8KOHt3CUZkR9JbkQ/A5YVK6z5NEHxZryM=;
	b=XEHIv7rrckRq0egX+2K86c6LgBImxyMEYbZPtguXPOFDvJvelzNQ7dtQycdGWbT0CT4r
	 TDTD9/ubCa0d3mubRu1JzUdn/2hwHylPjLH7flDUC5/YaLxEMSPWvdWPEFgE/c2CSbArK
	 AY87TtftK7P7l66wMZxaxok0m+3mQ/gerUTUPMzoCNVMIAmFDaTNb5RCoR/lEvXSLh1p8
	 3fl1O8e53VQdASmzJRbwILot5/yIPKygR+NR+yAtBXCulbXyvHlU8HjxkEL4UpT9IwGMo
	 Ws1JjfpmHBdSo1bQ7oiv/s/Tthvc9fooCUsLeY0iFse+4QxpZuIEX7ABiD8wCqsz9ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linuxhacker.ru;
	spf=none smtp.mailfrom=linuxhacker.ru;
	arc=none smtp.remote-ip=159.69.87.85
Received: from eagle.linuxhacker.ru (linuxhacker.ru [159.69.87.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33657606A330;
	Thu,  5 Nov 2026 00:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33657606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linuxhacker.ru
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linuxhacker.ru
Received: from intelbox1.virtnet (unknown [162.81.204.199])
	by eagle.linuxhacker.ru (Postfix) with ESMTPSA id BAE43BEE69;
	Thu,  5 Nov 2026 00:02:04 +0000 (UTC)
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
Subject: [PATCH net 2/3] vsock/virtio: bound the send credit by bytes not yet consumed by the transport
Date: Wed,  4 Nov 2026 19:01:40 -0500
Message-ID: <20261105000141.3617241-3-green@linuxhacker.ru>
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

The send credit is

    min(peer_buf_alloc, buf_alloc) - (tx_cnt - peer_fwd_cnt)

where peer_fwd_cnt is taken unchecked from every header the peer sends.
A peer that never consumes what it is sent but keeps reporting
fwd_cnt == tx_cnt gets unlimited credit: every send() is accepted and
the skbs pile up in the transport's queue (on a host, vhost's
send_pkt_queue, for a guest that posts no rx buffers). The skbs are
GFP_KERNEL allocations charged to no memory cgroup. The peer learns
tx_cnt easily when the host side relays a stream it also controls.

Commit 8ee784fdf006 ("vsock/virtio: cap TX credit to local buffer size")
bounded peer_buf_alloc, but not peer_fwd_cnt.

bytes_unsent (maintained for SIOCOUTQ) counts what was handed to the
transport and not yet consumed by the device. It is local knowledge, so
bounding it by the same window limits a lying peer to one window of
queued data per socket.

For an honest peer, bytes_unsent can exceed tx_cnt - peer_fwd_cnt only
by data the peer already has but the transport has not yet released:

 - on a host, the delivered part of an skb that vhost splits across rx
   buffers smaller than the skb: the peer acknowledges the pieces, but
   bytes_unsent drops only once the whole skb is delivered, so at most
   one skb (64 KiB);
 - in a guest, tx buffers the host has consumed but
   virtio_transport_tx_work() has not reaped yet: vhost passes the
   packet to the host socket before it marks the buffer used, so the
   host's credit update can arrive first.

Either way the window shrinks only until the transport catches up;
nothing stalls and nothing changes on the wire. The writer is woken when
bytes_unsent drops (sock_wfree() calls sk_write_space()).

With a user-space vhost-vsock "guest" that posts no rx buffers and
acknowledges everything, one host socket queued 256 MiB in under 2 s
(SIOCOUTQ 268304384, where the test stops); with this patch it stays at
one window (SIOCOUTQ 262144).

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
---
 net/vmw_vsock/virtio_transport_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1e762a480df4..74a8fdf825d5 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1031,14 +1031,17 @@ EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_has_data);
 
 static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs)
 {
+	s64 tx_buf_size = virtio_transport_tx_buf_size(vvs);
 	s64 bytes;
 
 	/* Use s64 arithmetic so if the peer shrinks peer_buf_alloc while
 	 * we have bytes in flight (tx_cnt - peer_fwd_cnt), the subtraction
 	 * does not underflow.
 	 */
-	bytes = (s64)virtio_transport_tx_buf_size(vvs) -
-		(vvs->tx_cnt - vvs->peer_fwd_cnt);
+	bytes = tx_buf_size - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+
+	/* peer_fwd_cnt is peer-controlled, bytes_unsent is not. */
+	bytes = min_t(s64, bytes, tx_buf_size - (s64)vvs->bytes_unsent);
 	if (bytes < 0)
 		bytes = 0;
 
-- 
2.56.0

