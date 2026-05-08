Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2A840B6D6
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258671; cv=none; b=VYmnSjuFOziS9sg6/1VekBHOm3ld8R92/cnZGiSPzmUT4f4dvFR+Yha9luju/CYXbtVkSvCTpBtS59Z0cF1pFAaTacLS8qgFCmY6Z5wr8j7hzT7i9mE+eUEZywGYeY5QgFwRfW5FRCT/65W2JRsMSD6YzyU3AnW5I/CUmIPGh3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258671; c=relaxed/simple;
	bh=nI6jWfcws3jDGKtVHmRZ+UhUUSG86pLokLto4S1xK2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZoMkv1YrLB2S431T3bYe8Szv8XEH9SqkV/VmyVpSeT8St05xkl/jUF+KaSxOOJ+CjjTqt0KixjcwzPkS1srJByj/Fp6VtwQnW3gXQrKIHCpNxrEkw5pC1P3vZALdY2GxbU0K61F86SZ1osE+cDfqss8BebFw7ZvnzX3M0l9y2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYe6ZCNN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=feBwpVgg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYe6ZCNN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="feBwpVgg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778258668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SGD4ybYlVxcQvNSSgCT46FZDKdy4y6czHmnn+pucYo=;
	b=eYe6ZCNNuFT22h/KNO+rMSWPdqO8mqSj2wb75mPgEiN8rLkTLmsOV46R4GIiTnKWTzIQ1Z
	0KqB3u7JjYLY+jZKS/Bi7ddL2opnIamzFzwB3r4nkj97jztazBq2ciEUpLbDRnPatG24RO
	QYYyqw7hsdSYaIW/f8UDdtdz5yH53S0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-RpJXfIAjMz2GggL2dBfp7A-1; Fri, 08 May 2026 12:44:27 -0400
X-MC-Unique: RpJXfIAjMz2GggL2dBfp7A-1
X-Mimecast-MFC-AGG-ID: RpJXfIAjMz2GggL2dBfp7A_1778258666
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44d79da8cf7so2032920f8f.2
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778258666; x=1778863466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SGD4ybYlVxcQvNSSgCT46FZDKdy4y6czHmnn+pucYo=;
        b=feBwpVggIs73tS2qql5DfNIny1peM0+9ekxpP6ZSXVyZdqd9Wy5tzTP2GaaNfX5yAa
         VJsWiOiAy4RkDB6nRH5pMLB3USg19wPYXVHTGnGFy/+VQJ/4Tqo1adg5GelUoZN5py6B
         lJNYexUmK+Bb+T2e0xoqZSIFJDfOd9VwnDtP0M8qjGDr4c95M59wQA0FWjx5VqiVXzsD
         ATveWj9F2tqZg6OTLzEKHp4G/opz+jcL6Xs5VKQXrBk5qakJFw9aPp5Qm3f0FqzFBHS9
         OarpJr11spJ4lIgHigueg4qMQWvHYoZsAiggzCwNdCgkKMVSV2zngpLI2nMol+doiTLu
         owCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778258666; x=1778863466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1SGD4ybYlVxcQvNSSgCT46FZDKdy4y6czHmnn+pucYo=;
        b=KKA2RSWqVT4wR43seuTj501S3nBTC1I6/9fDYITvEUOceH0e+1S8DUjOWvRoFIp4dN
         s/lCBuStncbtpqsT6JBKKlRjsepF3U4ai0DlUJUlY5ftHuOxlrsw8R5MwLghWkwd30Vm
         Vu3b3dsKmo75v4xMwMoYyBEgOZK0X2GYSoyqL86U/W9fF4DfC63YEgAeK+OOX5mAvl2U
         rYCUnKLlm5AU0tBl8vY7+xZekqypJcf40zJszbkx0UpG0Xb+D0hfYbdVN2lKBl7K239u
         5D0t1Hop3CEojvOBduvnb9Yu4ha2jNrc3s5YUprENEnZYvShCIgVFSLjv0wsB+axSDvq
         e8vg==
X-Forwarded-Encrypted: i=1; AFNElJ/ogh9bvOCIIveoji6L9hngmPs1t2LeOeeyHrsq91NVLulDJqXOzLtWp9Ush2s+JjsmPp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW9psfQakoJEViGwpdY0kGyqvCTRgDfOLRs3DtEJatxEmnEkYk
	K3+e4XH65rIF+pTL79KJl8t/s8vBINXZWs7wWLhYqYnLObP+XNs1CMetqJq1iBPXRm94xbe567e
	Rlu2Fz2S/Im+2Lsg++h8CeWUjAZFsLMdKVwmDkBEm+7fPZCnsiXu+7w==
X-Gm-Gg: Acq92OGmmbbOfj+dsDtS84ATYWHotj3v2kFC71GmKQGH5RGukiIhKBaDvaSNr8Sg/sY
	9zDlPYfjwCZ8HeGCnltiMeuIv57BPPLL4E/dbetAsheLK62BrmoxdpgHX/qG7hu6wr2zhonQy8R
	yfgPeQ8/BiSalqlmc/bBdn/ELzfQxZ0bj4Z726KXj+Hv3Pka4KzujptyXjA8jjM7acWyuwb2CZ9
	osrLk1yYNT3lAVO3pjyR2PvGN7oFPvrLPtIJpqr6QHGELSWr3egkuqOZp76MZc5txDzmUlfYipf
	9FsEz4IAXt2066WNa5grAUEyMaJIkT6icbzt6QltPnc8KaYEqX/7nhtS9NRWokKcZt98WFnjeJo
	S4/4/6s4rmGrBFbZcWqcnESQH2iQvl5Uwweh+91AAeIbETHLnU1YWV8V4d10ZQXm4Yw==
X-Received: by 2002:a5d:5d08:0:b0:44e:1984:5f3e with SMTP id ffacd0b85a97d-4515d3dc343mr20223720f8f.31.1778258665062;
        Fri, 08 May 2026 09:44:25 -0700 (PDT)
X-Received: by 2002:a5d:5d08:0:b0:44e:1984:5f3e with SMTP id ffacd0b85a97d-4515d3dc343mr20223444f8f.31.1778258662937;
        Fri, 08 May 2026 09:44:22 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a5b65sm5572801f8f.8.2026.05.08.09.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:44:22 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Yiqi Sun <sunyiqixm@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net 2/2] vsock/virtio: fix empty payload in tap skb for non-linear buffers
Date: Fri,  8 May 2026 18:44:11 +0200
Message-ID: <20260508164411.261440-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508164411.261440-1-sgarzare@redhat.com>
References: <20260508164411.261440-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

For non-linear skbs, virtio_transport_build_skb() goes through
virtio_transport_copy_nonlinear_skb() to copy the original payload
in the new skb to be delivered to the vsockmon tap device.
This manually initializes an iov_iter but does not set iov_iter.count.
Since the iov_iter is zero-initialized, the copy length is zero and no
payload is actually copied to the monitor interface, leaving data
un-initialized.

Fix this by removing the linear vs non-linear split and using
skb_copy_datagram_iter() with iov_iter_kvec() for all cases, as
vhost-vsock already does. This handles both linear and non-linear skbs,
properly initializes the iov_iter, and removes the now unused
virtio_transport_copy_nonlinear_skb().

While touching this code, let's also check the return value of
skb_copy_datagram_iter(), even though it's unlikely to fail.

Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
Reported-by: Yiqi Sun <sunyiqixm@gmail.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 40 ++++++++-----------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index a678d5d75704..989cc252d3d3 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -136,27 +136,6 @@ static void virtio_transport_init_hdr(struct sk_buff *skb,
 	hdr->fwd_cnt	= cpu_to_le32(0);
 }
 
-static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
-						void *dst,
-						size_t len)
-{
-	struct iov_iter iov_iter = { 0 };
-	struct kvec kvec;
-	size_t to_copy;
-
-	kvec.iov_base = dst;
-	kvec.iov_len = len;
-
-	iov_iter.iter_type = ITER_KVEC;
-	iov_iter.kvec = &kvec;
-	iov_iter.nr_segs = 1;
-
-	to_copy = min_t(size_t, len, skb->len);
-
-	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
-			       &iov_iter, to_copy);
-}
-
 /* Packet capture */
 static struct sk_buff *virtio_transport_build_skb(void *opaque)
 {
@@ -214,13 +193,18 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));
 
 	if (payload_len) {
-		if (skb_is_nonlinear(pkt)) {
-			void *data = skb_put(skb, payload_len);
-
-			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
-		} else {
-			skb_put_data(skb, pkt->data + VIRTIO_VSOCK_SKB_CB(pkt)->offset,
-				     payload_len);
+		struct iov_iter iov_iter;
+		struct kvec kvec;
+		void *data = skb_put(skb, payload_len);
+
+		kvec.iov_base = data;
+		kvec.iov_len = payload_len;
+		iov_iter_kvec(&iov_iter, ITER_DEST, &kvec, 1, payload_len);
+
+		if (skb_copy_datagram_iter(pkt, VIRTIO_VSOCK_SKB_CB(pkt)->offset,
+					   &iov_iter, payload_len)) {
+			kfree_skb(skb);
+			return NULL;
 		}
 	}
 
-- 
2.54.0

