Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B1936A344
	for <kvm@vger.kernel.org>; Sun, 26 Jul 2026 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785075146; cv=none; b=tulnKzZUw1TNJNzavJfm8143ggrCb+WciWEvS96N4JPzfvA6LEXD+8dCiA/S/v4VrlBChwy/tyHlfou+owlv9rJ07S6FguNwrOJX4wNH+eaIqm/qYTxsQVu3FkuX8BXg8OPYTtECByvE9z6jO9UIu/30RjfrCea/JY6gvBq7WXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785075146; c=relaxed/simple;
	bh=hAzGSzba1NEi7B4ecRdbiFHQv/Op0Tbx9G5qrGuEuC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g6c9/j7pgGQBXcBFWG8PfG5tiX+tffJjuqs1UcalCvljDpE6oAjAZ6fLRtEtpdYlqjbPDbMEVGt7Y8p8FVvYmV9Pp+4G9dA3Q5Fw7ix2KCSUEGKnhkQ2Dq+4wnxiUTxd9pME9Xh9GAV4JDYd9pnePf/nO9lJMlsbjCe/56+YUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsEBRNEz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsEBRNEz"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so1255981a91.1
        for <kvm@vger.kernel.org>; Sun, 26 Jul 2026 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785075144; x=1785679944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QKBVDCs0y9smsIpgENM3SuWaNy6SuXbVP3tPSuphxHk=;
        b=WsEBRNEzKhzBvgyVEuLowpGAGYlrQWOOaJeQNE16aDOjX0lg6qMOx8rpX82PVb9r+p
         2Reykz6bOkbaXbl8H7sJ9gjxgynI3vjAeqFpARpIATWkd93a6aR/k0C/41nTSRGvI/tX
         nEIrr70U13LiIR76UsIh8R4bKRuamFj+WKsj3tadLSwi5luGBfCxZY78N1CMAPXWFyyL
         0FD8Xk7iVKGmLYLyvme8Kauf/dp0sW2B94jRONY0MCzJspaeh9GtvQhzOrlJM7Yc+NcV
         kT9JokBVXE43jxWLOGo8KZJTRa3fF+AyDmgtrQfuSbxlew/TnJzmxUvYtRZ8hRdWwwnZ
         NYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785075144; x=1785679944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QKBVDCs0y9smsIpgENM3SuWaNy6SuXbVP3tPSuphxHk=;
        b=SiagLLfF5KT6/EXWCHqc5YTj6CpCFCS9UY7vz4QCnouL78q0n/M0D5VF1QsDmZcQAo
         y6/zxvV8lLZcW710R4qDgvEYS4kLx3ZkIEq09UcyMOaj3bbWbYDg/UOKCUn65McF3zi8
         NJ4YOk9C/E0slsUzRnuJoPngw2g6tPjgXpCRzxGEFVbYty7L97JIg1Qcs58QcbsX1ICx
         ZiBCrsZjFBFYZSAk+Tcpo0wHAghOe5teE0vDU9tSlYzcv671SiN07Tm540rsm88pV6e2
         TO/VjnXbzzv8ZOArNVszoxHXllot864ppl5TUD3LSk5AYXAQuYFP36/DYKQFbVKXzjJH
         fR8Q==
X-Forwarded-Encrypted: i=1; AHgh+RrukCbFBtmMV/feWvLCErUOe9mOeK1Z3H6C6Guh6GJTAi5FyFByN99LlOjbt/PUpdKPm2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5tUP1Xj6ZIp+kaeelQqLXYVZhia35bG7nawXo+eiRjIqET/O
	pIcTWXUj40NvRRZnrOa/BubI8FEu8WwAR9ONXzlGG9EX7Uk7paCYn0Km
X-Gm-Gg: AR+sD120Q6hi2URseEbCfDAAYhMeOhDEh4k0oTi3cX47CHaS3xOnEq/img8E306q/YL
	9PMs8T4Z1CpJkQ/jUUBSuKJODm2luDDNRXuVopPYkYo/jeOqLjWFbux6m79THjLIbRktxCzIvjs
	6c3ruzZSlhRoyhyxUSYH/Rg9708t79Bn4bNVdu6BEebYickdPG3kRRO8xNUsSkiTfWWDrJFgMxV
	d1rgq9rKzF4ngB+ZoemK79TaAfgNwSKbswPR6ZJH2hCCH2gFFGO6ADcetItdbE9vJrseKapJGWw
	qUxuOksI8A2C2581RkeCVds+Oqqs5lqhH3gFSqU3llcZHjpZFJwMRzTz5n5jGtbEigL0qWwp/s8
	FRKwvup77qlPiEUiDCOtbgw69egEhvCUsANJXOSoMl1b0RCZkpbvP1ppCLKMCXz9TqWifyKhmmq
	dbMQ==
X-Received: by 2002:a17:90b:4b8e:b0:38e:2a4:cffc with SMTP id 98e67ed59e1d1-38f2961561dmr5471035a91.25.1785075143784;
        Sun, 26 Jul 2026 07:12:23 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e0f4a039asm17136083c88.9.2026.07.26.07.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 07:12:23 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	physicalmtea@gmail.com
Subject: [PATCH] vhost_net: reject unsafe feature changes after activation
Date: Sun, 26 Jul 2026 22:11:58 +0800
Message-Id: <20260726141158.1652386-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_net_set_features() is reachable through VHOST_SET_FEATURES and
VHOST_SET_FEATURES_ARRAY. A successful VHOST_NET_SET_BACKEND with a
socket backend invokes vhost_net_set_backend() and enables a virtqueue;
a later VHOST_SET_FEATURES can still change feature-dependent state.

When ACCESS_PLATFORM is first enabled, vhost_net_set_features() calls
vhost_init_device_iotlb(). vhost_get_vq_desc() calls translate_desc(),
which prefers dev->iotlb over dev->umem. Clearing ACCESS_PLATFORM
updates acked_features but does not clear dev->iotlb, so the old IOTLB
and its HVA entries remain in the descriptor path.

With IN_ORDER disabled, vhost_get_vq_desc() reads the next head from
the guest's avail ring but still advances vq->next_avail_head after a
successful consume. Enabling IN_ORDER later makes vhost use that
existing cursor without resetting it, so the next descriptor may not
be the one from the guest's avail ring.

Keep feature negotiation fixed after the first successful backend
activation, except for VHOST_F_LOG_ALL. Reject clearing
ACCESS_PLATFORM while a device IOTLB exists, and avoid rebuilding an
existing IOTLB for a log-only update. Use VHOST_RESET_OWNER before
starting a new feature negotiation.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
Fixes: 45347e79b544 ("vhost_net: basic in_order support")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/net.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 6edac0c1ba9b..df357142461a 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -144,6 +144,8 @@ struct vhost_net {
 	unsigned tx_zcopy_err;
 	/* Flush in progress. Protected by tx vq lock. */
 	bool tx_flush;
+	/* Feature negotiation is fixed after a backend has been started. */
+	bool features_locked;
 	/* Private page frag cache */
 	struct page_frag_cache pf_cache;
 };
@@ -318,6 +320,24 @@ static void vhost_net_vq_reset(struct vhost_net *n)
 
 }
 
+/* Caller must hold n->dev.mutex. */
+static bool vhost_net_features_changed(struct vhost_net *n, const u64 *features)
+{
+	const u64 *acked = n->vqs[VHOST_NET_VQ_TX].vq.acked_features_array;
+	int i;
+
+	for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
+		u64 changed = features[i] ^ acked[i];
+
+		if (i == VIRTIO_DWORD(VHOST_F_LOG_ALL))
+			changed &= ~VIRTIO_BIT(VHOST_F_LOG_ALL);
+		if (changed)
+			return true;
+	}
+
+	return false;
+}
+
 static void vhost_net_tx_packet(struct vhost_net *net)
 {
 	++net->tx_packets;
@@ -1321,6 +1341,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 	n = kvmalloc(sizeof *n, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
 	if (!n)
 		return -ENOMEM;
+	n->features_locked = false;
 	vqs = kmalloc_array(VHOST_NET_VQ_MAX, sizeof(*vqs), GFP_KERNEL);
 	if (!vqs) {
 		kvfree(n);
@@ -1597,6 +1618,8 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 		vhost_dev_flush(&n->dev);
 		sockfd_put(oldsock);
 	}
+	if (sock)
+		n->features_locked = true;
 
 	mutex_unlock(&n->dev.mutex);
 	return 0;
@@ -1637,6 +1660,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 	vhost_dev_stop(&n->dev);
 	vhost_dev_reset_owner(&n->dev, umem);
 	vhost_net_vq_reset(n);
+	n->features_locked = false;
 done:
 	mutex_unlock(&n->dev.mutex);
 	if (tx_sock)
@@ -1649,6 +1673,8 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 {
 	size_t vhost_hlen, sock_hlen, hdr_len;
+	bool access_platform;
+	int r = -EFAULT;
 	int i;
 
 	hdr_len = virtio_features_test_bit(features, VIRTIO_NET_F_MRG_RXBUF) ||
@@ -1672,11 +1698,23 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 		sock_hlen = hdr_len;
 	}
 	mutex_lock(&n->dev.mutex);
+	if (n->features_locked && vhost_net_features_changed(n, features)) {
+		r = -EBUSY;
+		goto out_unlock;
+	}
+
 	if (virtio_features_test_bit(features, VHOST_F_LOG_ALL) &&
 	    !vhost_log_access_ok(&n->dev))
 		goto out_unlock;
 
-	if (virtio_features_test_bit(features, VIRTIO_F_ACCESS_PLATFORM)) {
+	access_platform =
+		virtio_features_test_bit(features, VIRTIO_F_ACCESS_PLATFORM);
+	if (!access_platform && n->dev.iotlb) {
+		r = -EBUSY;
+		goto out_unlock;
+	}
+
+	if (access_platform && !n->dev.iotlb) {
 		if (vhost_init_device_iotlb(&n->dev))
 			goto out_unlock;
 	}
@@ -1694,7 +1732,7 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 
 out_unlock:
 	mutex_unlock(&n->dev.mutex);
-	return -EFAULT;
+	return r;
 }
 
 static long vhost_net_set_owner(struct vhost_net *n)
-- 
2.34.1

