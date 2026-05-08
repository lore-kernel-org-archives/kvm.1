Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5A52D9EDB
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232218; cv=none; b=WpwMAhRgvgCnOt/VlVDiMkoo0dVTLzuq6Dg+3ou+gF6eimbAui+17JYVhBeqNBTd8qyfzlKzXWQsnC8gLp8QaTrhy9+dPU6TnrEhHg1bwDsH0a6YxfSL5vCbTcEAww2M1bdd8KTFOM4WY2JFjViTtkNCze+ZXmXXUsPTSoM7E/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232218; c=relaxed/simple;
	bh=8LRSStW2VoNApjyq7vcaSmNuz5Qon/i9zONda+7Hib4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=raAw3VLHyVktMjhrZ0pWS+iXyWbROhp/tUW23nqvtE87BwF8C99uUDqHMTnHfK6Hnq6jbEbXtKcQFnqa2TAxASR/BQuS+UHXUEcW5G0xjTGAea348e1+om9gOmbIg9F3iJxl8KFIjTFrUGgLXDxYw0npoxz5HOgonRp3kEPBKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SVTTgEM/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAqbmb3N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVTTgEM/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAqbmb3N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778232216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yASdWjRr9O1Fv1pSyMZ8vcPjBnLsiRkgqyUNKE6lF10=;
	b=SVTTgEM/16hqDCRLd6Ltd0H0zXuBEMyq80MrNbPFKzuVmsysCwO/CI2UgQH4Gbiw8ffX/o
	TZNcRj0DFUWRr7d/gbtOWUwiUbefrtjgoun6d2BHFuCza5N/daIaN33dr7XVOr9QmLEPJ7
	gqcDjOsHbc5t34Jougluy4XOlO9ZFWc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-KpYX_NSvPOGaeQVQeDgxZQ-1; Fri, 08 May 2026 05:23:35 -0400
X-MC-Unique: KpYX_NSvPOGaeQVQeDgxZQ-1
X-Mimecast-MFC-AGG-ID: KpYX_NSvPOGaeQVQeDgxZQ_1778232214
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48906aa28cbso20002525e9.0
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 02:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778232214; x=1778837014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yASdWjRr9O1Fv1pSyMZ8vcPjBnLsiRkgqyUNKE6lF10=;
        b=UAqbmb3NgLhlHhVv3Z0Df0HK4c9rBMSAhrI9whilxC3PoVFNLGV3tSX8ZrvsQ7vJfV
         eZywgp6eEEczuTSwHicHvJOzAADY1qpFZi8NWd0UJMmSwG163YEnWvqYRjjP1O1BwNiG
         JCc/4BbtHCuWTzYXpmYGq4/wx2dKDG9+3fZOdJtQeO3iYPEDK5YC5g9Sl3qWp12HBmwk
         wZMbPe3brllIh96BGPz+0ePNdhgQQQNzjKGHZTHpXf+Inl/LLoKsBLiFaEyAUeu0+L+k
         UZvdcuTzb9EI+V2tCOP8lwNB1ulMe6TLeJAp+pnLQM5dimSU55VuBYZ/fQT/tgd5HnLV
         z68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778232214; x=1778837014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yASdWjRr9O1Fv1pSyMZ8vcPjBnLsiRkgqyUNKE6lF10=;
        b=o0ljnhzEpEbk7HqXhC7ln/bMGCfxQc/3URO+Y/7T+1aP1jjaHg0l27eN5YAssmBMoq
         OCZ+PqJzY76hMQAN1t5LOuLubvXXE2zRp9w+EG8dBhL1IH+Wo4M1GNhYLVi9GcM9+W/u
         I+XHAKhabX/cYzpa46GtpO09CPukjNS/xCGXLTb/juREOUtTqL0bHqEuTPsdnqMD46fP
         FXm6zauZUhfyXjiqcxEzz6IyV2ObFmYKaiY97WxjSXOm9+TkjqE6bVFIyMPOEMoIFQKj
         6490Webv2DSoTnzbYK9kefNkJCjJu0ksbqIZx9jcO43DXxczTBIfFYnpJKO5i7nRWVoo
         WU0A==
X-Forwarded-Encrypted: i=1; AFNElJ/v1v6q/vfUGSjbpORIaJdLt+8aUZA9fG8FZYHHXHZsEyElUT6SZ5f5p4ewdsUlshNGtXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz10fUj2xxCiIF7WtMF4m+vlzAz4GreG9qGSDQfP/1H6RbHUWyZ
	A748yTbzI0TVf9QlUfxA5Ib0vs0LJQFsZZDu+J83uRDWrch9O6BBKpyBGJOeXNCExGsgViC3k1t
	VR4wKxZdXTEkavmZCLdzItMgLSkb6D1HwM7iiAAsjwHQQfhfPfRZv0w==
X-Gm-Gg: AeBDiev8Dlony+QujBNAH8hM2Dc1RBsWJ09C57h1ct6392qpyTtCbH5pp1k84RpwC8p
	qy+lAs5DIxu/aiYD5Gr7hKuWfS/Sgq1iPf1p9Dx+DRi3w8daTFA5eXmd5pN2zGG4Z8lJNTP3nKD
	El0BOdGEY0kg0k1khvTitBztUz5RAMPMhyt+hALqi3KVClZhpkgeCYjzHJTo/u7ykTdtZDpn/nD
	dbSkc6Ini/M8eglOFxiin6iInhv2WzPn2hEhzah+/SxfxYTdK2pEEN7aZ6M/u7LiCnZKCLMpBBa
	JaJhPeuEGH8dEuAUln0cKbjgay8f0tHrY/a29b9kk82XEuTIGK8BZ3KCEmVIESksCIjamg09JVF
	bzJjZyn6zGHx7x/DwwPyob2JZAJiLtYnOYpU2P+c0J/6hW++4qZbwcWCaf90ys8im3A==
X-Received: by 2002:a05:600c:3e86:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48e5dffabcamr92546905e9.9.1778232213902;
        Fri, 08 May 2026 02:23:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3e86:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48e5dffabcamr92546285e9.9.1778232213361;
        Fri, 08 May 2026 02:23:33 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e642e5805sm15776295e9.7.2026.05.08.02.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:23:32 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	kvm@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Fri,  8 May 2026 11:23:30 +0200
Message-ID: <20260508092330.69690-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
buf_alloc when checking whether a new packet fits. This reduces the
effective receive buffer below what the user configured via
SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
silently dropped and applications that rely on the full buffer size
to deadlock.

Also, the reduced space is not communicated to the remote peer, so
its credit calculation accounts more credit than the receiver will
actually accept, causing data loss (there is no retransmission).

This also causes failures in tools/testing/vsock/vsock_test.c.
Test 18 sometimes fails, while test 22 always fails in this way:
    18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch

    22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
    Resource temporarily unavailable

Fix this by introducing virtio_transport_rx_buf_size() to calculate the
size of the RX buffer based on the overhead. Using it in the acceptance
check, the advertised buf_alloc, and the credit update decision.
Use buf_alloc * 2 as total budget (payload + overhead), similar to how
SO_RCVBUF is doubled to reserve space for sk_buff metadata.
The function returns buf_alloc as long as overhead fits within the
reservation, then gradually reduces toward 0 as overhead exceeds
buf_alloc (e.g. under small-packet flooding), informing the peer to
slow down.

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 31 +++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9b8014516f4f..94a4beb8fd61 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -444,12 +444,32 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	return ret;
 }
 
+/* vvs->rx_lock held by the caller */
+static u32 virtio_transport_rx_buf_size(struct virtio_vsock_sock *vvs)
+{
+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
+	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
+	 */
+	u64 total_budget = (u64)vvs->buf_alloc * 2;
+
+	/* Overhead within buf_alloc: full buf_alloc available for payload */
+	if (skb_overhead < vvs->buf_alloc)
+		return vvs->buf_alloc;
+
+	/* Overhead exceeded buf_alloc: gradually reduce to bound skb queue */
+	if (skb_overhead < total_budget)
+		return total_budget - skb_overhead;
+
+	return 0;
+}
+
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+	u32 rx_buf_size = virtio_transport_rx_buf_size(vvs);
 
-	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
+	if (!rx_buf_size || vvs->buf_used + len > rx_buf_size)
 		return false;
 
 	vvs->rx_bytes += len;
@@ -472,7 +492,7 @@ void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *
 	spin_lock_bh(&vvs->rx_lock);
 	vvs->last_fwd_cnt = vvs->fwd_cnt;
 	hdr->fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
-	hdr->buf_alloc = cpu_to_le32(vvs->buf_alloc);
+	hdr->buf_alloc = cpu_to_le32(virtio_transport_rx_buf_size(vvs));
 	spin_unlock_bh(&vvs->rx_lock);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_inc_tx_pkt);
@@ -594,6 +614,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 	bool low_rx_bytes;
 	int err = -EFAULT;
 	size_t total = 0;
+	u32 rx_buf_size;
 	u32 free_space;
 
 	spin_lock_bh(&vvs->rx_lock);
@@ -639,7 +660,9 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 	}
 
 	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
-	free_space = vvs->buf_alloc - fwd_cnt_delta;
+	rx_buf_size = virtio_transport_rx_buf_size(vvs);
+	free_space = rx_buf_size > fwd_cnt_delta ?
+		     rx_buf_size - fwd_cnt_delta : 0;
 	low_rx_bytes = (vvs->rx_bytes <
 			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
 
-- 
2.54.0

