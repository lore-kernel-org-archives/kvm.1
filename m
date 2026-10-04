Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4533370D4F
	for <kvm@vger.kernel.org>; Sun,  4 Oct 2026 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791157875; cv=none; b=jfGdGLOfZ6QbN3CP/l/qmHQfByHLUWVhFHq7dfx4CvKhnf8R5kFIq5jJvHTXx6OpS62KIuQ8Pp+7ARodQWIuiEQmhG3bnriK0l30emWL4nzqyb0mk6WGVH9hvTaZ6amXwM/gr6D2tz9r95SMY+juvHsHvrPTcmmae34DrHBZoDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791157875; c=relaxed/simple;
	bh=r9JeIpNoZHCyy/ygKsUJh/s5EDs4VehT8XxBw1zqi5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qz/bKLkEbE0ueCkupoQHeMpxq9d2rpEJO7hkvh+28Xu3Ny/sCfuv6+fwMte9EWdEJnGF5KKinSyY0KBWz8eYSboKOTX+7SwnA2ZnVhwnzjqoq/lTMvjJMhcbeakvVrCv5kjFa4I60Vg9K7xaggtmYMzMxyJ9EuRKdBzEej5aYW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxHITV/t; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxHITV/t"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a49573b8bdso713477a91.2
        for <kvm@vger.kernel.org>; Sun, 04 Oct 2026 16:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791157873; x=1791762673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tAh1IpDRk+myJWBu/bO09Zer/mYlX7SwJvX5QUX3ZFc=;
        b=NxHITV/tytzmKOoPxadaMttMY4kcVcinH2kWqlilSa4OVguO0ovx6Hw1g8QRh06h3d
         AAnp4w9Pa1q+UuyU0jNyGvdo1RY3akgo16i+dpr9QKiRa3DFEI+UxLjMR5jtXCvhvH+N
         4ZBGKI9rFmjjXE+yKvCvxIz8bAbodTarUQFe/EGKyzkRK2vpQH6KVdU0gLbOJAvOh0Ve
         qbEROSsFCQLsKCoe7HGj8tE/IvfPEXJ7/Mq7dy6xd8AAg6Zd8m4egz98x66wdVWLfe3u
         2H1S+37l1VTtHwkQGrezko+gosuR4k7XZNm+3JurvLY+JemvpFQho4k8CDF//mQAKK8X
         4RQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791157873; x=1791762673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tAh1IpDRk+myJWBu/bO09Zer/mYlX7SwJvX5QUX3ZFc=;
        b=alCaf1nEzjGEcsmQ+cShYpnXggcuIeTYPSNarAfof74HuPhmE+J/2pS2k0pUBg577i
         EOf8/8JnEz0c/NrZvl6MWZqtj5OC59vAtAsLSypGYa+RckEKM4+RjYHtDKb3qwJ/BZOE
         sLtsjqr464iHWPnvJEN0oDAKL1SVUeJZ7m1z5+n1k7sBTGbpva7i5y4blG3vA7F7RObu
         QVXzErLuasJCXhWCErzLaog+avPX1H7AloGPTjjTMXfVgs5hovrmFBEYgADlCRUoWHTE
         M1EbFgIRWuP1rPVmkFoRmZciIoxwndRFtPO5y5gj/H+UiflRYD23srSxG+Ro8kN9w1Qk
         v1vg==
X-Forwarded-Encrypted: i=1; AKwUvBwxsaIT/wLptwbba5v+ptokESwqEdKUoHG+ScyP3ReCZ5bODb7vM/iR4hvyL5WBzP0C86Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYLig7mcIloQJxKCkO6JAIG4/gYXkRjM5/23uz0Nj67jyKW5DaBC
	BmdnSxQta7Mr5SIs51ShfxRnnceKDt4K6CQbgyPYRnbclwa5sJ5wTu5pPgoZh7+2
X-Gm-Gg: AYBFou1q2cYD2lA8tj8EMpF1H1CHcLQ92OjM4iVQCWBEGM4fW9H3cs+z9ReX7aPJElC
	3RgIBf3dm4B1EcGcz/fAkSX1yKaemgOxCPvtweKBiEIFZV20DC3zTn9htBArBzitAjQof6WcXCZ
	GGkD2a9gkEik0Izxeduj4w7q7EG2Q0POaPTLE8ARv9wMLpsMh/1oSIMoc+wrSGSOF8zFeH0Tu0t
	R9K11KJPvtVxQJZ8hDeKxe+K2CQoD8RlJ3XuQ4dTGbT/c7zGMQXCgqikSpumAokr16dJvdTYM6V
	VsGraKbDMB3c3K6hYAfjjDo56JY7EYjKtvZLbzICadlidzpO9icy/OPf2NIEK94BSHHVDy3hMv3
	ydKynZUJ7OIT2JRXPzr9RYbWLHCEW309/HPgP0iOkc0a3FStLarvJnrrp6xdOVlHnP1V4kA0+VL
	tmu9/bwgXGyzMG48tI6gJeaRJ+2uF1KYOr6VcrM8lYgMqqw3NrUTj6MIViaJH9Lhcsg7XcTyxgw
	WTe55iaAoQ=
X-Received: by 2002:a17:90b:58c5:b0:3a4:f8da:2478 with SMTP id 98e67ed59e1d1-3a6cec6044emr6950610a91.29.1791157873044;
        Sun, 04 Oct 2026 16:51:13 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7bfc344bbsm5532242a91.12.2026.10.04.16.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 16:51:12 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	"David S . Miller" <davem@davemloft.net>,
	Will Deacon <will@kernel.org>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] vhost/vsock: size receive SKBs from declared payload
Date: Mon,  5 Oct 2026 08:51:01 +0900
Message-ID: <20261004235101.1464007-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vsock_alloc_skb() sizes the skb from iov_length(), the total guest
descriptor length.  virtio_transport_inc_rx_pkt() instead adds hdr->len to
rx_bytes and buf_used, and budgets each queued skb as SKB_TRUESIZE(0).  The
guest controls the descriptor length and hdr->len independently.

A guest can therefore provide a 64 KiB descriptor while declaring a zero
payload.  The descriptor-sized skb remains queued, rx_bytes and buf_used
remain unchanged, and only the fixed queue-entry budget limits retention.
This is not a lifetime leak: the skb is freed when dequeued or at socket
teardown.  Repeating this across connections can nevertheless exhaust host
memory.  On Linux v7.2, 455 such descriptors retained 30,255,680 bytes for
a 262,144-byte receive buffer; a full-payload control retained 265,984
bytes.

Vhost previously read hdr->len and allocated pkt->buf from that value.  The
conversion from virtio_vsock_pkt to sk_buff instead allocated receive skbs
from the descriptor length, introducing the allocation-accounting mismatch.

Copy the header into a stack object and validate hdr->len before allocating
the skb.  Size the allocation as sizeof(hdr) + payload_len so descriptor
capacity no longer determines queued memory.  Check payload_len against
len - sizeof(hdr) to avoid addition overflow on 32-bit hosts.

Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Changes in v3:
- clarify that queued skb memory is under-accounted rather than leaked, and
  explain why a zero payload is the strongest case;
- remove v1-to-v2 implementation rationale from the permanent changelog;
- correct the Fixes tag from ab9aa2f3afc2 to 71dc9ec9ac7d; and
- make no code changes.

v2: https://lore.kernel.org/netdev/20261004073419.4039011-1-4ncienth@gmail.com/

The issue was identified during an LLM-assisted source audit and confirmed
with a focused in-kernel probe on Linux v7.2.  The code diff is
byte-identical to v2, so its existing build and runtime results remain
applicable.

 drivers/vhost/vsock.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index abed1fbcf66cc5..35f75e23c7497e 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -364,7 +364,7 @@ static struct sk_buff *
 vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		      unsigned int out, unsigned int in)
 {
-	struct virtio_vsock_hdr *hdr;
+	struct virtio_vsock_hdr hdr;
 	struct iov_iter iov_iter;
 	struct sk_buff *skb;
 	size_t payload_len;
@@ -382,34 +382,32 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
 		return NULL;
 
-	/* len contains both payload and hdr */
-	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
-	if (!skb)
-		return NULL;
-
 	iov_iter_init(&iov_iter, ITER_SOURCE, vq->iov, out, len);
 
-	hdr = virtio_vsock_hdr(skb);
-	nbytes = copy_from_iter(hdr, sizeof(*hdr), &iov_iter);
-	if (nbytes != sizeof(*hdr)) {
+	nbytes = copy_from_iter(&hdr, sizeof(hdr), &iov_iter);
+	if (nbytes != sizeof(hdr)) {
 		vq_err(vq, "Expected %zu bytes for pkt->hdr, got %zu bytes\n",
-		       sizeof(*hdr), nbytes);
-		kfree_skb(skb);
+		       sizeof(hdr), nbytes);
 		return NULL;
 	}
 
-	payload_len = le32_to_cpu(hdr->len);
+	payload_len = le32_to_cpu(hdr.len);
+
+	/* The pkt is too big or the length in the header is invalid */
+	if (payload_len > len - sizeof(hdr))
+		return NULL;
+
+	/* Allocate only for the payload declared in the header. */
+	skb = virtio_vsock_alloc_skb(payload_len + sizeof(hdr), GFP_KERNEL);
+	if (!skb)
+		return NULL;
+
+	memcpy(virtio_vsock_hdr(skb), &hdr, sizeof(hdr));
 
 	/* No payload */
 	if (!payload_len)
 		return skb;
 
-	/* The pkt is too big or the length in the header is invalid */
-	if (payload_len + sizeof(*hdr) > len) {
-		kfree_skb(skb);
-		return NULL;
-	}
-
 	virtio_vsock_skb_put(skb, payload_len);
 
 	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {

base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
-- 
2.55.0
