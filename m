Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EF1420867
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506568; cv=none; b=lPwADd8kjZiGV1w7MWsaxF90pamJE1CatclWRg0jdbP+ltb+/eIY4ZQlkX8QUxO1dW5el2rVh3ZuCYYEOdoNgT1ExV7rFw9KxbhmPNnIsR7/9RJkIbmfVXK7CL9WUyF3V7hT2lhLEVATPMac4dch4ZlIy1wsD+9Dusn8hq2Bl9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506568; c=relaxed/simple;
	bh=4Ioj+uXwmlNtFGd3w9E4QvxQHEehHS7LxUvD6BHqD3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xe8En7AnAizyyKPBwoMiPKW7wlKeNcPO09q2MBgOpMbpE7WU0LZJtmQJ8+R3fOTAvaBjyhLHHKJqPlG6MhdkW2lyGBDcxjzT49jWsTZtiMiQ1f95N8Sh6HWivx6uSpuIxAbKAy5uVdhXMs4p8Dji2kzxGkVAzQZGnXOcudzhKiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6HsLmav; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RnMkle4W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6HsLmav";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnMkle4W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783506557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QeIXOWju9kpJlG84+jBij7M8XqoyvMRFU8kzphZpY1c=;
	b=V6HsLmavwDKWQxXDlo7V0HMLQB/nCpzeK8NRSrLzU5vxE9YsqxSc4exE/yZgCeikELcxIC
	fMnVRhzjV4CGhn3VyJnYs44IvgZnff4uhIGSex3r3QKu1CLZXCK3nv9knxf0GFVxv2TV99
	TG5TvIFWklXjV8bbCbVXV+xTwtzA0Pk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-tzQurMPSOYqzQlsHECnrJg-1; Wed, 08 Jul 2026 06:29:13 -0400
X-MC-Unique: tzQurMPSOYqzQlsHECnrJg-1
X-Mimecast-MFC-AGG-ID: tzQurMPSOYqzQlsHECnrJg_1783506553
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-475e540a0ffso343729f8f.3
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 03:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783506552; x=1784111352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeIXOWju9kpJlG84+jBij7M8XqoyvMRFU8kzphZpY1c=;
        b=RnMkle4WKIO6dJK5IhJ8eh0+IUTeCqhknzlLoV0HNONKo9UtjJLNTl1ekiLtsGGHz9
         dI0dYWPuObeh8oXQoL3AKvdB9q7t6xD4f01XCG/8sbsbK2sA9SFYZPR75MYPA12kO8Q8
         oR5PLAluSOMFsjmcaE3x7mykve2S6jz5yRIDPYbLiVUf+TEaxxlxtvfk4aDsRa+9lP1F
         nAm7lMGvQo2qbrdhWERXXq11sE/9q+goChZzbvpW0ksoaO2H+OYW+NULbEc89lvpeaNJ
         2Cq8OAAqOnzIwHr8zq8fG7PWPfzBmRtlelRAG5LNUO5YmJD7borfzeyWShg8WmMJokXx
         +C8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506552; x=1784111352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QeIXOWju9kpJlG84+jBij7M8XqoyvMRFU8kzphZpY1c=;
        b=ZYvoUINPWE8VX0fLXjn9NxwuFwxToI/eMvhSKrGheeWNv0i1Fm5aRyJRwfRFrbCjw3
         Oj4hjJ0g/u5h3RX50bDp73bo0LLQmyZBli87eDHKtL5tEWlYHEdUh6RuRhmjRBmbtvQE
         WNkyPN8IY61R303hqm3IxgWgtmg7zhtRIflYeXz/f3iMuiJBqJAK1JmVgHXdF0gtJxYh
         z9pI1TAS4PvYXPqpwcyTBkAjbGeeeHzXeusBH/7tuDHUqGaC7IxGrNhTTb96b7Uv70Jl
         9ZT+YOrMevBfPpQQ00pfnuTIbKH+Zz7CfKlXmQOpGhkDa4pS99kCTLg0gdu1zNDHCGhc
         XIfA==
X-Forwarded-Encrypted: i=1; AHgh+RohW4QTJDUjVw7eI/EMC58Rmn/KlbRhmvseIVQVd/yW4tihgV6OC3q/EnXD16Cf01GlmPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6eshhFiOWP/cGBhzrrpgU3N+S95fBAT7hrlSBhDF8GjqHxyo7
	1Z6SZxyW1NaZuk4sTa1Wd2gpIuH9ihpAWMEHyvorI/k8fZRV8/AZmJcls6xzSfgVtMog9hSJPeU
	g5tezUvo4TZe5R0eYOcyNOV+K5GgYS8DP25+BHg4NP5ok1sEC9/Aipw==
X-Gm-Gg: AfdE7cl3ZktphLETBJDJvnIt9GDIAbQRVNtbJp53rWAIZkQoJR1G8HSdwjLmDq0+R9I
	KZ6MZFwE9fw0hUjS0yUwg3K/Znqj0ZxiF9yKkniw04mp8lrw708EOrnDZfq3yVFWXNK+LhgsjEl
	dmIteF2TDximN8schCopKvp6yHI1pUVnQYQqUOgiryTgAaOl3K9ZWJ9bu+hRXL9l4xszqVZMFTg
	AQxqi4YJHScW8dWA3RYYcmshadwh8egVzeeIqG2TazstMqLuI5nlB/YS45vjB8X/tvhoFfTKCR0
	Rjd72TAoLa+2YnFHikhAzrTPePgWQOj95CD004cfUIkFGFkDesz0cPpM5R3WU6+ZJebIqsST301
	Gzhb54fgbC8/JFksqJdvFmUoOaeKVC+zMWaIf0g1dNix6BW8=
X-Received: by 2002:a05:6000:310c:b0:475:f0c2:5afb with SMTP id ffacd0b85a97d-47df078bf3fmr2020545f8f.49.1783506552518;
        Wed, 08 Jul 2026 03:29:12 -0700 (PDT)
X-Received: by 2002:a05:6000:310c:b0:475:f0c2:5afb with SMTP id ffacd0b85a97d-47df078bf3fmr2020485f8f.49.1783506551889;
        Wed, 08 Jul 2026 03:29:11 -0700 (PDT)
Received: from stex1 (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm43045414f8f.2.2026.07.08.03.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:29:11 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Jason Wang <jasowangio@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	stable@vger.kernel.org,
	Brien Oberstein <brienpub@gmail.com>
Subject: [PATCH net v2 1/2] vsock/virtio: collapse receive queue under memory pressure
Date: Wed,  8 Jul 2026 12:29:03 +0200
Message-ID: <20260708102904.50732-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708102904.50732-1-sgarzare@redhat.com>
References: <20260708102904.50732-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

When many small packets accumulate in the receive queue, the skb overhead
can exceed buf_alloc even while the payload is within bounds. This causes
virtio_transport_inc_rx_pkt() to reject packets, leading to connection
resets during large transfers under backpressure.

The issue was reported by Brien, who has a reproducer, but it is also
easily reproducible with iperf-vsock [1] using a small packet size:

  iperf3 --vsock -c $CID -l 129

which fails immediately without this patch but with commit 059b7dbd20a6
("vsock/virtio: fix potential unbounded skb queue").

Inspired by TCP's tcp_collapse() which solves a similar problem, add
virtio_transport_collapse_rx_queue() that walks the receive queue and
re-copies data into compact linear skbs to reduce the overhead.

The collapse is triggered proactively from when the number of skb queued
is close to exceeding the overhead budget.

A pre-scan counts the eligible bytes to size each allocation precisely,
avoiding waste for isolated small packets. Partially consumed skbs are
kept as-is to preserve buf_used/fwd_cnt accounting, EOM-marked skbs to
maintain SEQPACKET message boundaries, and skbs already larger than the
collapse target because they already have a good data-to-overhead ratio.

Walking a large queue may take a significant amount of time and cache
misses, causing traffic burstiness. To limit this, the collapse stops
once enough room is freed for this packet and the next one, but may
opportunistically free more to fill each collapsed skb to capacity.

[1] https://github.com/stefano-garzarella/iperf-vsock

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Cc: stable@vger.kernel.org
Reported-by: Brien Oberstein <brienpub@gmail.com>
Closes: https://lore.kernel.org/netdev/618701dd023e$063de350$12b9a9f0$@gmail.com/
Tested-by: Brien Oberstein <brienpub@gmail.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- defined MAX_COLLAPSE_LEN macro instead of using a variable [Paolo]
- added a threshold to avoid walking all the queue while collapsing
  [Paolo]
- collapsed the queue before calling virtio_transport_inc_rx_pkt().
  While working on the threshold, I figured out that the check I was
  introducing can also be used to proactively trigger the collapse, so I
  moved the call to virtio_transport_collapse_rx_queue() before acquiring
  the rx_lock to have also a better diff to simplify backports
- improved code readability (removed `out` label, `keep` initialization,
  etc.) [Paolo + other small stuff]
- Brien kindly retested this version as well (thank you so much)
---
 net/vmw_vsock/virtio_transport_common.c | 165 +++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 09475007165b..8becad81279c 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -26,6 +26,13 @@
 /* Threshold for detecting small packets to copy */
 #define GOOD_COPY_LEN  128
 
+/* Max payload that can be collapsed into a single linear skb, using the same
+ * allocation threshold as virtio_vsock_alloc_skb() to avoid adding pressure
+ * on the page allocator.
+ */
+#define MAX_COLLAPSE_LEN \
+	SKB_MAX_ORDER(VIRTIO_VSOCK_SKB_HEADROOM, PAGE_ALLOC_COSTLY_ORDER)
+
 static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
 					       bool cancel_timeout);
 static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs);
@@ -420,6 +427,145 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	return ret;
 }
 
+static bool virtio_transport_can_collapse(struct sk_buff *skb)
+{
+	/* skbs that are partially consumed, mark a SEQPACKET message boundary,
+	 * or are already large enough should not be collapsed: they either
+	 * need special accounting, carry protocol state, or already have a
+	 * good data-to-overhead ratio.
+	 */
+	if (VIRTIO_VSOCK_SKB_CB(skb)->offset)
+		return false;
+	if (le32_to_cpu(virtio_vsock_hdr(skb)->flags) & VIRTIO_VSOCK_SEQ_EOM)
+		return false;
+	if (skb->len >= MAX_COLLAPSE_LEN)
+		return false;
+	return true;
+}
+
+/* Iterate through the packets in the queue starting from the current skb to
+ * count the number of bytes we can collapse.
+ */
+static unsigned int
+virtio_transport_collapse_size(struct sk_buff *skb, struct sk_buff_head *queue)
+{
+	unsigned int target = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
+
+	while ((skb = skb_peek_next(skb, queue)) &&
+	       virtio_transport_can_collapse(skb)) {
+		unsigned int len = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
+
+		if (len > MAX_COLLAPSE_LEN - target)
+			return target;
+
+		target += len;
+	}
+
+	return target;
+}
+
+/* Called under lock_sock to compact the receive queue by merging small skbs.
+ * @min_to_free: minimum number of skbs to eliminate from the queue. May free
+ *               more to fill each collapsed skb to capacity.
+ */
+static void
+virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
+				   u32 min_to_free)
+{
+	struct sk_buff *skb, *next_skb, *new_skb = NULL;
+	struct sk_buff_head new_queue;
+	u32 saved = 0;
+
+	__skb_queue_head_init(&new_queue);
+
+	skb_queue_walk_safe(&vvs->rx_queue, skb, next_skb) {
+		struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+		u32 src_off = VIRTIO_VSOCK_SKB_CB(skb)->offset;
+		u32 src_len = skb->len - src_off;
+		bool keep;
+
+		keep = !virtio_transport_can_collapse(skb);
+		if (keep) {
+			/* Finalize pending collapsed skb to preserve packet
+			 * ordering.
+			 */
+			if (new_skb) {
+				__skb_queue_tail(&new_queue, new_skb);
+				new_skb = NULL;
+				saved--;
+			}
+			goto next;
+		}
+
+		/* Finalize if this packet won't fit in the remaining tailroom,
+		 * so we can allocate a right-sized new_skb.
+		 */
+		if (new_skb && src_len > skb_tailroom(new_skb)) {
+			__skb_queue_tail(&new_queue, new_skb);
+			new_skb = NULL;
+			saved--;
+		}
+
+		if (!new_skb) {
+			unsigned int alloc_size;
+
+			/* Check after finalizing to opportunistically fill
+			 * each collapsed skb to capacity, merging more skbs
+			 * than strictly required.
+			 */
+			if (saved >= min_to_free)
+				break;
+
+			alloc_size = virtio_transport_collapse_size(skb, &vvs->rx_queue);
+
+			/* Only this skb's data is eligible, nothing to merge
+			 * with. Keep as-is.
+			 */
+			if (alloc_size <= src_len) {
+				keep = true;
+				goto next;
+			}
+
+			new_skb = virtio_vsock_alloc_linear_skb(alloc_size +
+					VIRTIO_VSOCK_SKB_HEADROOM, GFP_KERNEL);
+			if (!new_skb)
+				break;
+
+			memcpy(virtio_vsock_hdr(new_skb), hdr,
+			       sizeof(struct virtio_vsock_hdr));
+			virtio_vsock_hdr(new_skb)->len = 0;
+		}
+
+		/* Cannot fail since src_off/src_len are within bounds, but if
+		 * it does, discard new_skb to avoid queuing corrupted data.
+		 */
+		if (WARN_ON_ONCE(skb_copy_bits(skb, src_off,
+					       skb_put(new_skb, src_len),
+					       src_len))) {
+			kfree_skb(new_skb);
+			new_skb = NULL;
+			break;
+		}
+
+		le32_add_cpu(&virtio_vsock_hdr(new_skb)->len, src_len);
+		virtio_vsock_hdr(new_skb)->flags |= hdr->flags;
+
+next:
+		__skb_unlink(skb, &vvs->rx_queue);
+		if (keep) {
+			__skb_queue_tail(&new_queue, skb);
+		} else {
+			consume_skb(skb);
+			saved++;
+		}
+	}
+
+	if (new_skb)
+		__skb_queue_tail(&new_queue, new_skb);
+
+	skb_queue_splice(&new_queue, &vvs->rx_queue);
+}
+
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
@@ -1354,12 +1500,29 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	bool can_enqueue, free_pkt = false;
+	u32 len, queue_max, queue_len;
 	struct virtio_vsock_hdr *hdr;
-	u32 len;
 
 	hdr = virtio_vsock_hdr(skb);
 	len = le32_to_cpu(hdr->len);
 
+	/* virtio_transport_inc_rx_pkt() rejects packets when the per-skb
+	 * overhead (skb_queue_len * SKB_TRUESIZE(0)) exceeds buf_alloc.
+	 * Proactively collapse the queue before that happens.
+	 * No rx_lock needed: lock_sock is held by caller, preventing
+	 * concurrent enqueue or dequeue.
+	 */
+	queue_max = vvs->buf_alloc / SKB_TRUESIZE(0);
+	queue_len = skb_queue_len(&vvs->rx_queue);
+	if (queue_len >= queue_max) {
+		/* Walking a large queue may take a significant amount of time
+		 * and cache misses, causing traffic burstiness. Limit the
+		 * collapse to freeing room for this packet and the next one.
+		 * It may free more to fill each collapsed skb to capacity.
+		 */
+		virtio_transport_collapse_rx_queue(vvs, queue_len + 2 - queue_max);
+	}
+
 	spin_lock_bh(&vvs->rx_lock);
 
 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
-- 
2.55.0

