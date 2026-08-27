Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB023168EF
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 05:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810378; cv=none; b=J1aLkX5te494S7cHXQB4sxOZbXozt5lT2hjPv3+pZ9VEZifRTFjaL/aMAp98awR7HYmiQqJt7pw1DsxhSdF4hvZoVxyXfBhLBsErQENUU0nsgfxzjJoV1LVRbOI34IRNuaKlBPCRBgzlbNtzI0WyZwhA+NuQUrBgzXIRG5/YclM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810378; c=relaxed/simple;
	bh=6xGaRyHabjqQHSPfBdLVdAauPJVqvcRRuz9CkwkMyeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lQY2uR7g6ebHLWs5xm7fDyKcHV4DrdFMPrJdwixKHmzIbdCMJCiuCD8w+wl8dMqV743EOY9Kju2pJLOLqspz1vWOPeVJA/knMUlWK+yLsk0qf8WLDyFrmDDYh3a+j6QwXUUlMwoVLGS8axskZfs2UXNCAVs1FD+DPCUy71qYHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs0FqDlj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs0FqDlj"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so8890855ad.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 22:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787810376; x=1788415176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O+Chh90ybpjMvhqrL9ZavLsHC4dx+fqvxodSXo5kx7g=;
        b=Xs0FqDljlZn6x2APeKbbN8j5+UH+bW7gCj4xE83ZZvJJNxFhu7A4Ncc1cNleiuAigo
         ZedauA0g9W8IRsdrDZ19PCtRhtu4MWDsSIKcOMO+so7BsQEnJ2vTanX8+wzs9cirJWJW
         IVhddrbpRIzYA8N4FZ7AJff8pt1OAPzea6Rx4L6pN7JVFOlpU9oDdXQXUKWDMd2nMO9U
         qj8UObvAoPdP9goHhsQU+tb2IQq0WOnlUft04TQaePTDKsgXB/IfKpuV1ZiEb6eNEVSb
         ptUZ9aAqy9QVcxBcD9ZqGCNGThjyEHFn5i81kBYGr1cNR1smJynm1p8Gj1bYz19ouZJe
         YAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787810376; x=1788415176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O+Chh90ybpjMvhqrL9ZavLsHC4dx+fqvxodSXo5kx7g=;
        b=g/j3D4tjW6NQajFEKVVyeTQBtZBAuiqhFHv4H6M/zYohM7qJ7+nnmQzeZT7kXuW3RY
         xtNQfzbmcmHIkc4OkjWBxQOZ3z3JzkAT0oxaTPCvnTjcc8PBZmukm/ucz0TubMmncKEn
         rlV/BuH8cgurJSEETVxHxOa3o+CJTXxhVCpmjfRDI+ez+267BhOh/zAKVXWGM8lvsasV
         P+9a6Khp1VXYe2kgecK4DcwZ3AjKSrKHzBshKVO1kPliDsX4sli9O4O31+spW2YZ1th4
         KOP9hZD0iItjaw1Z65QiuuLDLB/hseRFAZ3pFeYMpA4g//+wy5knwhyZCQUypqSpLzO/
         lx7g==
X-Forwarded-Encrypted: i=1; AHgh+Rpxara1+u9jLz2xXvJrGFBYuBJ1ecTg6smJwZubL1HjS++UVpdx7OkT+4n6d/54WvULstI=@vger.kernel.org
X-Gm-Message-State: AFuF++lxTp20JPGFe64fy0TVisOZ/tvl2Gx2tb4BK67stjblyIoHEUjY
	6/gH2MCe+wLZ4X/mHSUys6jxCQsi4lH3Jdv4WN76yWYh16sOYXQQLIOy
X-Gm-Gg: AR+sD11O7RK5BnXpDlKbd0KlwQuz3HrjhHcbhXR00CxcCSbgEUuVzV4/iN1IwizMrTC
	IRyLN31ZhT4h6YdyidqPii5LJquhXoGaGc1IwwyZmI5yQ2Cbxvs/srUgHDo8Wu74suiNdPfY8Uj
	fUmO9Z9Xz1Ezs2A6WzG6hrc+hQ00ukojBmqnognmei6/6M/ixvPyO+8BC3Np+/fqN7ZPzGkBoiw
	cXiDlO4lN+f87n1pzMM0O0JqoaIoWmJl6d8IqXDswtmNHZrUoe+lpU6upm2Xg7FIqIZZYSSnl09
	P7OYkvVJzqbFVUXUwLo0jEmocQJTqQ8tlkWSKyszcNv5W8KS+kyvOEsB2OfNsQCj6dWABPzoGQP
	Hj1mA8SIBVvUAVtx+6/u2h9YMG0okb3vc5AhK09IlbQu/JcABcW31IeeRrtzpDNxa51zL1arcLc
	yv73rd2Aw5imYof3j6dVIUGHAP1USsHC0Ctuz3auEcU5AXNdfLLRCxHXswHiU0ozzCD4kDjPY=
X-Received: by 2002:a17:903:26c5:b0:2d1:1a18:4d0a with SMTP id d9443c01a7336-2d707b3c6a6mr237304505ad.9.1787810375877;
        Wed, 26 Aug 2026 22:59:35 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d70493f3f5sm13971145ad.1.2026.08.26.22.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 22:59:35 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost/vsock: batch RX used-ring updates
Date: Thu, 27 Aug 2026 13:58:50 +0800
Message-Id: <20260827055850.26951-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_transport_do_send_pkt() calls vhost_add_used() for every Guest RX
buffer even though it delays the Guest signal until the worker finishes.
Each call publishes one used entry and updates the used index separately.

Collect the completed buffer heads in the arrays already allocated for the
virtqueue and publish them with vhost_add_used_n().  Bound the batch by the
ring size, array capacity, and worker packet budget.  Flush before
re-enabling notifications or leaving the worker.

Each used entry describes one completed RX buffer and keeps its actual used
length, so set nheads to 1 for every entry.  This patch does not change
negotiated features or compress multiple buffers into one used entry.

This patch is limited to the current skb-based vhost-vsock RX path.

Performance:

Tested with a QEMU/KVM guest on a host with 4 online CPUs, using 2 vCPUs
pinned to host CPUs 2 and 3, QEMU 10.2.1, q35, 1536 MiB, and Linux
7.2.0-rc3-next-20260713-next-debug-kasan.  The vhost-vsock source is based
on linux-next master at 49362394dad7df66c274c867a271394c10ca2bb8.

Current vhost-vsock does not implement VIRTIO_F_IN_ORDER or
VIRTIO_F_RING_PACKED, so both configurations used packed=off and
in_order=off:

  baseline:                 RX batching=off
  vhost-vsock RX batching:  RX batching=on

The test used vsock_perf.  The Guest receiver was started with:

  vsock_perf --port PORT --buf-size 64M --vsk-size 64M --rcvlowat 1

The Host sender was started with:

  vsock_perf --sender 3 --port PORT --bytes BYTES \
      --buf-size SEND_BUF --vsk-size 64M

Each workload transferred BYTES=1 GiB.  The SEND_BUF values were 256 B
(SEND_BUF=256), 512 B (SEND_BUF=512), 4 KiB (SEND_BUF=4K), and 64 KiB
(SEND_BUF=64K).
Each state used a fresh Guest.  Each workload uses 20 paired runs, with 10
runs in each order.  The reported values are
Guest RX throughput in Gbits/s.  The baseline and batching columns are the
geometric means over the 20 runs; change is batching / baseline - 1,
computed from the unrounded values:

  workload   baseline RX    batching RX   change   faster
  256 B      0.0795724      0.0831509      +4.497%  20/20
  512 B      0.1194885      0.1210297      +1.290%  14/20
  4 KiB      0.7208273      0.7242053      +0.469%  11/20
  64 KiB     2.1712797      2.1951941      +1.101%  13/20

For reference, the table below gives the 95% normal-approximation intervals
obtained from the 20 paired log(batching / baseline) values:

  workload   paired 95% interval
  256 B      +3.985% to +5.011%
  512 B      +0.206% to +2.385%
  4 KiB      -1.442% to +2.416%
  64 KiB     -1.474% to +3.745%

All transfers passed byte-count checks, and no kernel errors were observed
in the logs.  The 256-byte workload improved in every pair.  The 512 B
workload was faster in 14 of 20 pairs, with a small gain.  The 4 KiB and
64 KiB workloads showed no material throughput change; the difference
between their results may be due to scheduling and execution variation.

Link: https://lore.kernel.org/r/20181214082146-mutt-send-email-mst@kernel.org
Link: https://lore.kernel.org/r/20220901055434.824-4-qtxuning1999@sjtu.edu.cn
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8..d8050cca2 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -103,12 +103,37 @@ static bool vhost_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
 	return found;
 }
 
+static bool vhost_vsock_flush_used(struct vhost_virtqueue *vq,
+				   unsigned int *used_count)
+{
+	if (!*used_count)
+		return false;
+
+	vhost_add_used_n(vq, vq->heads, vq->nheads, *used_count);
+	*used_count = 0;
+	return true;
+}
+
+static void vhost_vsock_add_used(struct vhost_virtqueue *vq,
+				 unsigned int *used_count,
+				 unsigned int head, unsigned int len)
+{
+	struct vring_used_elem *used = &vq->heads[*used_count];
+
+	used->id = cpu_to_vhost32(vq, head);
+	used->len = cpu_to_vhost32(vq, len);
+	vq->nheads[*used_count] = 1;
+	(*used_count)++;
+}
+
 static void
 vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			    struct vhost_virtqueue *vq)
 {
 	struct vhost_virtqueue *tx_vq = &vsock->vqs[VSOCK_VQ_TX];
 	int pkts = 0, total_len = 0;
+	unsigned int used_count = 0;
+	unsigned int used_limit;
 	bool added = false;
 	bool restart_tx = false;
 
@@ -120,6 +145,12 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 	if (!vq_meta_prefetch(vq))
 		goto out;
 
+	used_limit = min_t(unsigned int, vq->num,
+			   min_t(unsigned int, vq->dev->iov_limit,
+				 vq->dev->weight));
+	if (unlikely(!used_limit))
+		goto out;
+
 	/* Avoid further vmexits, we're already processing the virtqueue */
 	vhost_disable_notify(&vsock->dev, vq);
 
@@ -134,9 +165,13 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		u32 offset;
 		int head;
 
+		if (used_count == used_limit)
+			added |= vhost_vsock_flush_used(vq, &used_count);
+
 		skb = virtio_vsock_skb_dequeue(&vsock->send_pkt_queue);
 
 		if (!skb) {
+			added |= vhost_vsock_flush_used(vq, &used_count);
 			vhost_enable_notify(&vsock->dev, vq);
 			break;
 		}
@@ -153,6 +188,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			/* We cannot finish yet if more buffers snuck in while
 			 * re-enabling notify.
 			 */
+			added |= vhost_vsock_flush_used(vq, &used_count);
 			if (unlikely(vhost_enable_notify(&vsock->dev, vq))) {
 				vhost_disable_notify(&vsock->dev, vq);
 				continue;
@@ -230,8 +266,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		 */
 		virtio_transport_deliver_tap_pkt(skb);
 
-		vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
-		added = true;
+		vhost_vsock_add_used(vq, &used_count, head,
+				     sizeof(*hdr) + payload_len);
 
 		VIRTIO_VSOCK_SKB_CB(skb)->offset += payload_len;
 		total_len += payload_len;
@@ -264,6 +300,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			virtio_transport_consume_skb_sent(skb, true);
 		}
 	} while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
+	added |= vhost_vsock_flush_used(vq, &used_count);
 	if (added)
 		vhost_signal(&vsock->dev, vq);
 
-- 
2.53.0
