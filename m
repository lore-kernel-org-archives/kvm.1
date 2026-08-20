Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94D73C1F4B
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213094; cv=none; b=cmSkj7L9MFR+ObjugbzNEJ7EXT4DgATxmmMK7vchnNMEKuBpZdOBwv1Tl0ZvTZaA4gxvcMNJ74mVV8M57zs6Uy8k9HY7RoAa4c1g7b8X7lavM9L2HZOpGhYVeX4SfnLJLGZ1K9EMtaX2neUgMJdwC4G69+ZMcPoN2o7aDUk/DD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213094; c=relaxed/simple;
	bh=409NHPEg8d9hyDA6rbo5mNuY8rOh8AiKvTJnLeNNu+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ghnYq8OtWv1xesJg/CiRWZdeEUWUYYqtwjBD69XuOvjG+lAaH+1ycpnzBG7CcLtnHJ49x+nlKSAqIuuJ5OwSAFvSOFcq+OrVeaSroaMDXMPKjl8kZ+XJ65/jJjpO/OUm5TFcCyy3bre8W8fP5YEqLmaiGBmzf66xVXzKJLHFAsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIU96Dob; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIU96Dob"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccf2360620so14103185ad.3
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 01:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787213092; x=1787817892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uNFgqqtecTA8geY8RdpK/nki92/0qSfCNTMPBz/Sj1Q=;
        b=OIU96Dob713ylc2uQkNugwSYvYAFRQN2JOt5VHH0pNJELOkdjjh0hPGY5yqmsccBWr
         EnXi63XkQdWzNxker6WpXPwPFV/JYfAglB/ZUNO3MkN0YZyTLvG2Zi+ZLV9U8KJX+toi
         X7KuR+/R/Z92GOwiQF/jjo3aKmDDpLwsvWkBTM/vZJAnqSAes5sBx1SB5dRimaEyLMjL
         JL79VuffwSgH4c3gEYbIJSKIyqfEG5lers/ZWPBJUcyP4SvjXZyZZqyalOrsI7yI1NC0
         Xw8zQo1DE0SsxJcq02S2CZZK2QVHIAyiQnLd6K15MHQgNsf/o8eI/cwXF65wS2YE5BA5
         3U9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787213092; x=1787817892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uNFgqqtecTA8geY8RdpK/nki92/0qSfCNTMPBz/Sj1Q=;
        b=T5ZEmNSOVp/x9lP0ygFOhImhOG4Ptj3gbM8GPGGvXix05Lc8eQGq6gv0WROkS8GMZ7
         a0Q8FK6R21HaHka4QHLWuRMQv74JNQTngikZl0xnt3IxDg94zAcZxjjsfsY06dvOIj4I
         38c0nMcl47RF8eqMp6YLbajm+rvz1s1HBUCCu7R+m5fjWNpb7nJzsdDVVw1bl0ypHsIh
         M7XdzWhz4zxX2N82vblDkOzyyaO9siJ+gTVnX5fBIBTwW/D0jEtmV0pxzIr1+YumHnLb
         iMGHtR10Pk9//kiPes9hTGABznJs5PAz9DNwKfCzkFReXg9ulypF0JarKuL6HHiDzCpq
         ZfbA==
X-Forwarded-Encrypted: i=1; AHgh+Roc49Ei/cQ1AnaUcr/n2coemJEsg59oRZD7x/kSzBBIWIzqCDW/joVhQ95e9JJsk6IAgWk=@vger.kernel.org
X-Gm-Message-State: AFuF++nVnnFXa1G2qF//JorjxFOL3Vmld+cPO49QBOMypMKAHpZVnMxl
	Qt+3qk7rV0b3WbUWbrSMMOa69ObAcBT+AAW3ttcZ1SLxGDY1hBCW6cgd
X-Gm-Gg: AR+sD12oer9yHlFLnFgk0O9FIH7Dn/C0nXUgJohf+8rBr2RtJ7c4wLBct8ZjCCFojOD
	0YYUtzCw1F0uiCugQ+UPrgMln9eIyjn/LMt33fsm2+/ESIuz/Ifv+2FkLrAhPLCkQGnrC1MTdSw
	BOljEGUNM4YIkTj4zeBVN0yfQTJENOG6Zz06tVu9ZhYSzWZ/t6vW0XWe4CXdSGfvj3JUw8ba/Ln
	hLdqsk8qno0BPIgWQGcKDsg8z3+8eXzoLc8SNautLbknpL+KtG3HEvwAoQnoRSc6oAqKMYWhcAi
	PT8Aa5hD5IgJcfmB4Zvsed50aoSpSlUimf0v0anL1iZZSWFlEa7sjTlVIzFxALUvQ07X039JuYR
	ZV4BBTQvfciEHTtkgymusvEvExjp+Fh3bemYouvOkhvDFF/5yjRqwhDIzQnHiTRRGUpfvuMFRZs
	mw6Ntm1vgszO17kKUQcOzPIerIEPS+gjvZ/e6wbOfJR94p+KZuedu4IzaLgdwxe+w9
X-Received: by 2002:a17:902:d58b:b0:2d2:da8e:9017 with SMTP id d9443c01a7336-2d5fd711facmr217368835ad.8.1787213091762;
        Thu, 20 Aug 2026 01:04:51 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e3c27aesm3553425ad.69.2026.08.20.01.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:04:51 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	weiyj.lk@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/3] vhost: invalidate vring access on IOTLB transitions
Date: Thu, 20 Aug 2026 16:03:30 +0800
Message-Id: <20260820080332.313933-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820080332.313933-1-physicalmtea@gmail.com>
References: <20260820080332.313933-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ACCESS_PLATFORM changes, the addresses cached in desc, avail, and
used change meaning with the address space. Clear the cached vring access
state when the device IOTLB is installed or removed so stale IOVAs cannot
be reused as direct userspace addresses.

Keep device IOTLB initialization idempotent and apply the mode change even
when a virtqueue backend is attached. Drop the device-wide IOTLB first,
then clear each VQ state under its own mutex, and keep the old table alive
until every VQ has completed the handoff.

A successful live mode change leaves the backend attached but invalidates
the cached vring addresses. Userspace must configure the vring addresses
for the new address mode before data processing can resume.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  1 +
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 14637cff0bd4..31fff9800045 100644
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
@@ -1918,6 +1929,9 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
 {
 	unsigned int num = vq->num;
 
+	if (!vq->desc || !vq->avail || !vq->used)
+		return 0;
+
 	if (!vq->iotlb)
 		return 1;
 
@@ -2287,11 +2301,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
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
+	/*
+	 * Drop the device-wide view first.  Each VQ then drops its
+	 * per-VQ view and its cached ring access under its own mutex.
+	 * Keep the old table alive until every VQ has completed this
+	 * handoff, since a worker may still be using it while waiting
+	 * for its VQ mutex.
+	 */
+	d->iotlb = NULL;
+
+	for (i = 0; i < d->nvqs; ++i) {
+		struct vhost_virtqueue *vq = d->vqs[i];
+
+		mutex_lock(&vq->mutex);
+		vq->iotlb = NULL;
+		vhost_vq_invalidate_access(vq);
+		mutex_unlock(&vq->mutex);
+	}
+
+	vhost_clear_msg(d);
+	vhost_iotlb_free(iotlb);
+	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
+}
+EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);
+
 int vhost_init_device_iotlb(struct vhost_dev *d)
 {
 	struct vhost_iotlb *niotlb, *oiotlb;
 	int i;
 
+	if (d->iotlb)
+		return 0;
+
 	if (max_iotlb_entries <= 0)
 		return -EINVAL;
 
@@ -2307,7 +2358,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d)
 
 		mutex_lock(&vq->mutex);
 		vq->iotlb = niotlb;
-		__vhost_vq_meta_reset(vq);
+		vhost_vq_invalidate_access(vq);
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
-- 
2.34.1

