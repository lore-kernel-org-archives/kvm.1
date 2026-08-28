Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C19A3E8C74
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787907467; cv=none; b=PuocxHz+mJW0i/utLFmVVJzs6O//u3EZwOAtErZthkkdEkFUnBoqVQn2VPIkfYJvFLIQmsScuz/3uts/H1HSlwlaVGjpxp7cypyWP47dxM76Ejj+l4jUDplIuL1kLj4+L/xZvrsphilRJi+B+lBxhiPxtH8vQjQ4GBOzT+IY7+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787907467; c=relaxed/simple;
	bh=CVr12rwSyd5+dIyBwZ3R/x2kUA87toHh1O+F675zqvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jqicU0EcpPOjhLFsHPOOf29rNFaTkxnC8CZgUjsBsUJAqY8OXcNsyQMU2HR79Rveknf/QmHU5M7HnlYwaw7578NNClH71ITGV08Sw+a7uwFPcJDvf5A5qHcXLPbRSvylDhfrFx0JlxPokM0zoVijom3IIUxqpFshyeTQTc/HSmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLBoSnJ1; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLBoSnJ1"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so575444a12.3
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 01:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787907458; x=1788512258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DRZDfWbaxIo06pqq6KbCnhsJf55wwxY1teE90sizaTM=;
        b=dLBoSnJ1iPjBw3T2xIkOO6uoAbX9bii7uIkCcBn0/Baev5QT1YjoptmQGVq98sI319
         QZzvA9gg1Rb47r5+hSGqU92MkcmplKFLikx0XkH6VfCvh4aMSDddHAFjsrwrKvsX1DCJ
         Eb5vRVPYJrcD0xUAYsM2hNpmkU+3G7+dIvJOac2orYAJVQ05S07hcrvuXcF50h9zpvon
         WGnqld+KMz1TT8PeIpVCaz+UyiOdJgQJZ2Ky/PeKxoo3eePWFipOlE8DSbzvvnxj73qQ
         pfXVkKpR79wzk7YXxuHSpQD+M37NS530g18QczOk5QeIS2+oDe8CfaeDVBD62j3OVKVE
         8LrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787907458; x=1788512258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DRZDfWbaxIo06pqq6KbCnhsJf55wwxY1teE90sizaTM=;
        b=oW6hXpWEnObHDvf9gddOPTOwcY79V3h/yDxlTlUGtXOL2yyPUDDh5LCC9Hu/X3xKNq
         8paQl15iDt1qozV0nnRaQ/Og5I7/PrQVGAeoAQKBiWtwuYf/QK/fEWeLnvIsDErkyCyG
         X5lwKLijnKJlyf7BK6THvinh76VGios8k8s/rFEAoFzQAwRrYD/tdH4UCJRfNcg4Ogu5
         MnOA04fE/0muawwn/CLXUyibolc7eckjMsvTNwxeC6C5KtISmcxiTgA4iGZknmgQBfic
         FrkK+eVqPJNNq5CVQDLHOwgmBSyjn/ZdfMsjqH8ImK2QvCBmLYaTJjaRwzVd/0S4LHzf
         H5lQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr0ZNs7CLb96czoYfLdSDvyVJCP5oBZ41ZFpmVS76JjYDfkh9W88V/a5oGA/eaI0jHdTyw=@vger.kernel.org
X-Gm-Message-State: AFuF++m8s1tb/ECkNbbIGwDJrlUVWz8TVcGyck9NtSWt57qkkJz9vk3u
	Cgs7Wc9K+RllnmIcUt3sMKmpaMl5QwsC1DEvbycIxoN3sTHTCnBj3VJV
X-Gm-Gg: AR+sD12QoBBTW5p+eGdrA99JrSyWWJkhTvDqbrE+OfN2b2fqfyYbZA7Kv1ljljW6R4j
	2BNiAIdL6CaPRTb8QKibjWYsYTJT57/f0DnFVjfOXalGzaWApXLR1BfHbGoKW72Pn0/tOgIKuox
	EbggNWOKBIdCInDx9yejYlL8p+GTKPp9TcinKgYP9keFPUtngDcsNR5co9XZPB4Rv2MvkncVo1v
	AlVdHABMKPJEXQWE530SrTt41cOHj1yMmJLy9H2qrMDDhPOeJ1bXFlnO8fcJ0r0SjivJyGkZXp0
	6CY7wLBhXE93EXV415VBkaDc0I0LG50bmsBttEbcbsWDC9ZroIbFgCHqt75i78CkmCIFzHB7ZPD
	dihTgIEBeQ7ZJmhBonBKU96RbhiP/fa1JHS6xv7eUZpcxdNJVplQ8/LOjF8rj61NyYDPZAYq8R+
	jrI7KIJjxHKgbWjxtorNNQ1mJh0hdOe3BBvu/QoKmrqJcLD4CNiNgiO4j+KFDAgig=
X-Received: by 2002:a17:90b:39ae:b0:395:4de4:92c8 with SMTP id 98e67ed59e1d1-396d1003f45mr9482979a91.15.1787907457269;
        Fri, 28 Aug 2026 01:57:37 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f95a160sm3406128eec.18.2026.08.28.01.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:57:36 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	stefanha@redhat.com,
	sgarzare@redhat.com
Cc: eperezma@redhat.com,
	weiyj.lk@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9] vhost: invalidate vring access on IOTLB transitions
Date: Fri, 28 Aug 2026 16:57:21 +0800
Message-Id: <20260828085721.57816-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When VIRTIO_F_ACCESS_PLATFORM changes, cached vring pointers and IOTLB
metadata are interpreted in a different address space. Keeping them
across the transition can leave stale ring mappings in use.

Clearing d->iotlb before taking the VQ locks also lets a worker observe
a transient NULL d->iotlb and fall back to d->umem while translating a
descriptor.

Add a common vhost_clear_device_iotlb() helper for vhost-net and
vhost-vsock. Take all VQ mutexes in index order before dropping the
device-wide IOTLB, invalidate each VQ's cached ring access and metadata,
clear pending IOTLB messages, and free the old table after the handoff.
This serializes the transition with workers and prevents mixed address
space mappings.

On the first direct-to-IOTLB transition, invalidate the cached vring
addresses. When an existing device IOTLB is replaced, preserve the
GIOVA ring addresses and reset only the metadata cache. After clearing
ACCESS_PLATFORM, userspace must configure the vring addresses for the
new address mode.

vhost_vq_invalidate_access() clears desc, avail, and used together.
Treat the VQ as invalidated only when all three are NULL, since a single
GIOVA address may legitimately be zero.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Changes since v8:
- Lock all VQs in the existing index order during device IOTLB teardown,
  before clearing d->iotlb, to serialize the transition with workers.
---
 drivers/vhost/vhost.c | 57 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  1 +
 drivers/vhost/net.c   |  2 ++
 drivers/vhost/vsock.c |  2 ++
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 14637cff0bd4..f90cae7ca91a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -344,6 +344,17 @@ static void __vhost_vq_meta_reset(struct vhost_virtqueue *vq)
 		vq->meta_iotlb[j] = NULL;
 }
 
+/* Caller must hold the virtqueue mutex. */
+static void vhost_vq_invalidate_access(struct vhost_virtqueue *vq)
+{
+	vq->desc = NULL;
+	vq->avail = NULL;
+	vq->used = NULL;
+	vq->log_used = false;
+	vq->log_addr = -1ull;
+	__vhost_vq_meta_reset(vq);
+}
+
 static void vhost_vq_meta_reset(struct vhost_dev *d)
 {
 	int i;
@@ -1918,6 +1929,13 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
 {
 	unsigned int num = vq->num;
 
+	/*
+	 * vhost_vq_invalidate_access() clears all three addresses together.
+	 * A single zero address may be a valid GIOVA in IOTLB mode.
+	 */
+	if (!vq->desc && !vq->avail && !vq->used)
+		return 0;
+
 	if (!vq->iotlb)
 		return 1;
 
@@ -2287,6 +2305,40 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 }
 EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
 
+/* Caller must hold the device mutex. */
+void vhost_clear_device_iotlb(struct vhost_dev *d)
+{
+	struct vhost_iotlb *iotlb;
+	int i;
+
+	iotlb = d->iotlb;
+	if (!iotlb)
+		return;
+
+	vhost_dev_lock_vqs(d);
+
+	/*
+	 * vhost_dev_lock_vqs() takes all VQ mutexes in index order.  Drop the
+	 * device-wide view while they are held, then clear each per-VQ view
+	 * and its cached ring access before releasing the locks.  Workers
+	 * cannot observe a mixed address-space state during this handoff.
+	 */
+	d->iotlb = NULL;
+
+	for (i = 0; i < d->nvqs; ++i) {
+		struct vhost_virtqueue *vq = d->vqs[i];
+
+		vq->iotlb = NULL;
+		vhost_vq_invalidate_access(vq);
+	}
+
+	vhost_dev_unlock_vqs(d);
+	vhost_clear_msg(d);
+	vhost_iotlb_free(iotlb);
+	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
+}
+EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);
+
 int vhost_init_device_iotlb(struct vhost_dev *d)
 {
 	struct vhost_iotlb *niotlb, *oiotlb;
@@ -2307,7 +2359,10 @@ int vhost_init_device_iotlb(struct vhost_dev *d)
 
 		mutex_lock(&vq->mutex);
 		vq->iotlb = niotlb;
-		__vhost_vq_meta_reset(vq);
+		if (oiotlb)
+			__vhost_vq_meta_reset(vq);
+		else
+			vhost_vq_invalidate_access(vq);
 		mutex_unlock(&vq->mutex);
 	}
 
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 0192ade6e749..3c75e8089373 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -277,6 +277,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
 			    int noblock);
 ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 			     struct iov_iter *from);
+void vhost_clear_device_iotlb(struct vhost_dev *d);
 int vhost_init_device_iotlb(struct vhost_dev *d);
 
 void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 38d9c184082d..4d9d7c2216ed 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1696,6 +1696,8 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 	if (virtio_features_test_bit(features, VIRTIO_F_ACCESS_PLATFORM)) {
 		if (vhost_init_device_iotlb(&n->dev))
 			goto out_unlock;
+	} else {
+		vhost_clear_device_iotlb(&n->dev);
 	}
 
 	for (i = 0; i < VHOST_NET_VQ_MAX; ++i) {
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..abed1fbcf66c 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -868,6 +868,8 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
+	} else {
+		vhost_clear_device_iotlb(&vsock->dev);
 	}
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
-- 
2.34.1
