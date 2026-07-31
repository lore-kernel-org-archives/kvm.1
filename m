Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD013E9F9D
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494089; cv=none; b=QCTrGlY7LmGlKIUSgNklfw86w6n0YZxYs5bQcy8zaWdRIpQiPS01ER6wtRUrQ2ibtAsPcMAc8j4M9mV6Kz3F0BbadOG/AtB4nnSHGESQ3DI48QfZ3qCqk22HdFqdUu5wvFgqE5odLjIZr+ugCm/Jj36lHGmaS5ACpt6SBbqabvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494089; c=relaxed/simple;
	bh=3wxMKIaYa0TEK/wezstt8blZU4l0k9Wg9VQ5r2HlO0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kKF6leznqgJE4rLoZy+7aFtht4QH2bZi6IbMBY1raYl6sMeUaoCKobBpbSaK5V6rxKFjRthfm2uFO7+IhT+TlBI0+BRs0yyIgAXXOOHKbp6GKrGr7JuZAqhllJbpY370f0Z9y7gx2k13O2TbwbJMtJPhBFZKmzLOWBl4jL0p27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sfOvbiGg; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfOvbiGg"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so814946a91.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 03:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785494068; x=1786098868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sSbgQp8eeyj2uwGNe57D0ofyxWkLsHgs5sTW3EdnPUM=;
        b=sfOvbiGg7t7Ff/w5WFXhBDxelky4WMoAc71pRMu907/SomI6pjzOkTWmfVIA2m4fWp
         A30fNdvdKa8QPRE1MklaAFXEaL0bYQkSehncm4+70mFFwKSSzsblz0gs6s7RmnWbWUIA
         SF6DL1wcA5dy5jkmMarVMce2zIqoQF1b1nHHkrYYx8i3s3YclhCH5Re1VGTYi4CY0+gt
         EH/a6GvOyVboZjNXdJUTJniTzkHlUNBRtrGCaDiush3ykVdP7+tcqzZja0T69YLApu25
         1KGjdlreBXDkLf+oxj6wvcAXDdrRuC9oA35sDP+HEOu2p0D4ZN0YST8ZeNJYRbsWnQ4A
         n3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494068; x=1786098868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sSbgQp8eeyj2uwGNe57D0ofyxWkLsHgs5sTW3EdnPUM=;
        b=AwyRAq6/BQmcyYtGsbhpXu2AqvtJK78LeJtBH4L+6W8R6rfKYSXgKJV+VveoS6zD7t
         OH5DrC4wRg4GuK5Trwk9KDgjklFDm99QUPwUTIFlqs/4FIF6C3s5699w3iJOfRDa8KNw
         5hvoSaXFw0RBXpVCJKV4xg4YWReWBIh2wXqNcQKIbfzm33wmIW5l7vt2NptYKlIM+nYE
         6LbDdrYj+tu0OCD84KAXgLitHWoZNwC2rrtCZdSKHl3kS2108cl7GBxvSR9Yggyh+MP2
         xjZ0hd/JqaS+X2MqJAUfnYjZmCS+5TwYGbyiEcKTTCPAs7xxNuA2NUnVDPGkjfNFG5HN
         XgKg==
X-Forwarded-Encrypted: i=1; AHgh+RqUqbvZ5j9Qd+NIoEK6IWL9djDYjff1KwlOgVxA2F6hzFNVmlOdcJ6SSghwy9VLHitZP58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzORbggUQVU6DZrVcGP1Y6YTggQF9rb9JqZFBiRR6xSrtOdPN7A
	FUbMsttw7l834PzJ89yqidAEkeuuAEW7WDkYkVOVDjBH4MPxmzXbiPca
X-Gm-Gg: AR+sD108yLQvkrS4O5Kmz56sqX1DWKDIM3aSrmC0VZtvYo1RMeDMexKrpUi01lVMtEP
	xIK5dau61TzOjXcDAdAM9724nU1OLJ3MNsBN9PDQAhkTg31FoIRFrZLUv+ydH57v9uFESHbolzE
	6KxgjoPHidqgHHtUvcjKS1yK5d6WcPTZDoVgF5eZIwgGxrOL82+Hjl4A5Iuq/WfdU68YSEA0N3F
	8kYLHNbp9cam+u6nDgro6HNHGVtB9HvmLjfTHdnvoN89WVXbmDe0euuFdvynAIDzs+BVTKmgoG5
	d2ii0sUzQ8Z74Awb+yrRea7fwMXSRpw35+GszNgt4TxYnCieNJ+TC/kuVnLJhsWINd+rbj41veo
	oQU5UVxVBtnp3ohtX2bxlIkpdEjcBFt0Cac+MuOfEyOE8FNrknNb5+eQB61o9yxfH/xJp520gBe
	ujaSYp7p9kzEmU5sWVYOSeNyLjnqhTWQ4Q6AZXiDCSzoluBWd6N7NMbcpSR1kfxN8=
X-Received: by 2002:a17:90b:5810:b0:38e:6a30:4bbc with SMTP id 98e67ed59e1d1-38fb13515aemr1518516a91.21.1785494067758;
        Fri, 31 Jul 2026 03:34:27 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153db2f911sm5434719eec.0.2026.07.31.03.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:34:27 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: stefanha@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject:
 [PATCH v2 1/2] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Fri, 31 Jul 2026 18:34:13 +0800
Message-Id: <20260731103414.1746316-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731103414.1746316-1-physicalmtea@gmail.com>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731103414.1746316-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vsock_set_features() leaves the device IOTLB attached when
userspace clears VIRTIO_F_ACCESS_PLATFORM. Descriptors can therefore
continue to use translations installed before the feature change,
including HVAs made stale by a later memory table update.

Detach the IOTLB before acknowledging a feature mask without
ACCESS_PLATFORM. Hold all virtqueue mutexes in index order while clearing
the device and virtqueue IOTLB pointers, resetting metadata caches, and
updating the acknowledged features. This prevents a kick handler from
observing a mixed translation state.

Free the old IOTLB after releasing the virtqueue mutexes. Also drop
the old IOTLB miss messages and wake readers now that the device no
longer accepts IOTLB updates.

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..562b9e139a76 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -851,6 +851,34 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 	return 0;
 }
 
+/* Caller must hold the device mutex. */
+static void vhost_vsock_clear_iotlb(struct vhost_vsock *vsock, u64 features)
+{
+	struct vhost_iotlb *iotlb;
+	struct vhost_virtqueue *vq;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++)
+		mutex_lock_nested(&vsock->vqs[i].mutex, i);
+
+	iotlb = vsock->dev.iotlb;
+	vsock->dev.iotlb = NULL;
+
+	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
+		vq = &vsock->vqs[i];
+		vq->iotlb = NULL;
+		memset(vq->meta_iotlb, 0, sizeof(vq->meta_iotlb));
+		vq->acked_features = features;
+	}
+
+	for (i = ARRAY_SIZE(vsock->vqs); i-- > 0;)
+		mutex_unlock(&vsock->vqs[i].mutex);
+
+	vhost_clear_msg(&vsock->dev);
+	vhost_iotlb_free(iotlb);
+	wake_up_interruptible_poll(&vsock->dev.wait, EPOLLIN | EPOLLRDNORM);
+}
+
 static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 {
 	struct vhost_virtqueue *vq;
@@ -872,11 +900,16 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
 
-	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
-		vq = &vsock->vqs[i];
-		mutex_lock(&vq->mutex);
-		vq->acked_features = features;
-		mutex_unlock(&vq->mutex);
+	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
+	    vsock->dev.iotlb) {
+		vhost_vsock_clear_iotlb(vsock, features);
+	} else {
+		for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
+			vq = &vsock->vqs[i];
+			mutex_lock(&vq->mutex);
+			vq->acked_features = features;
+			mutex_unlock(&vq->mutex);
+		}
 	}
 	mutex_unlock(&vsock->dev.mutex);
 	return 0;
-- 
2.34.1

