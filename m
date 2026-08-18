Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E436377000
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 04:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787027214; cv=none; b=pVsV5qC6GWs/B+MP8z6FqLiFaj6DFeaC7f2JL2KhfacQShHlK02z22YsDk5BOUuUgjRg1D8MKrkn4WZ4Z1xfZraEv4lZCAOA9kjjhk1j0EWkXqIC0Mphtjh5AVAxBHyxFIEdK8IHVbWWkWKXLr2DwuvHY5IxR3JaNClEhk6r4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787027214; c=relaxed/simple;
	bh=ieK2+IysJqjtboJuOsV9J7sxXGFN4Dr4N7HwSPkkMxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hz2SEWSk7d0Rz6BPuIbibQyrDjttTDADCIPFlYUH4re0UvLzaAv5wVZSV1JHE5L1vRp7NaV5MvgT98LE8+2Lw0SvVSUI2PgCepZpo+Og3CNMFEgslLLHde6bWMYBrPe/FTf+LeZMF/t9Cfe+xFzpVvHXfW7DRbB4rQXYblbTn4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sd1mEljQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sd1mEljQ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc61541f8cso6377205ad.0
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 21:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787027213; x=1787632013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6hk0+goG2CVie+owgSwZFn8ixOAcSPlM11kHKU9J/60=;
        b=sd1mEljQpcosrbQ2FIUI5kM8h69O+t4PQEUDGOPXAVvv8g6G26sltEX+cv9c3GetyL
         fppJWZmrqPru36/PopNNztvl+M/CG5pNMwqNx/0o0+7ixRg0tRxw9WGwlnQTOu5eM2GQ
         xPP14GMGWE0xwh9uAg/7Y2QFXbpifEef9e2fHGLf3nKTQs45aV6HR5azM7axFydh64Wj
         zpDuJnRqeUhspYOxfRwOEksvkaKC7hIXz2SVLHYB3EWWFe6aGkxQM5IvlxCYjczVi4m2
         4BTsrsYMNFoB79CxWK2RraYHycNemOgCbqvxa+h9MucJzec8FCb3CMpS9LMj3vmll5ll
         3j/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787027213; x=1787632013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6hk0+goG2CVie+owgSwZFn8ixOAcSPlM11kHKU9J/60=;
        b=a0nbTBcj4m/6uU5OG2Kk0Ga8VefYmUiIuuQx0YPldvJHHJIcy5TP5YcosnmJBC8vvu
         zxoNZXLqcw6oYv/Ef3w9Htre+f8sPerzEYDGn9Fb7GPCNpOArK3LDGrWNju3sSim9Ows
         CGOUe34n2kXUEyzPTTt/W2dkL5RTDFsHlgwG3xNEdPMVbLCG/J6N6Ifb8NGnctoO9ggi
         BdTWXy/c8c8vrR9Nzi7DStoNMQlDhO+sbLND4vpX0uuAs77dLHNsaL5cDFaRmpEcrDPZ
         F0RrcbaC4uJrm2uyKgguH4FZ4hLVaOQyF1GJqP4lAtE/Scleu079pnZ3ReutGDXLJ3RK
         o5yg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/4ViCm3TPr++oq0kZ9g4zr15KnPGKIP9vHnGqG0PMqRLYkYkT6UfQ/Z22jG33u+sKuIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpaCipJKzXwNhV0pJkeK5le56cVA/HZN/KepvvokgOpymdgbPX
	Ybg9rK/EQbk4RdBjDai1AVa11Nxx7+fEQhEuPI2mQwaqqL8Crr9hP7Pb
X-Gm-Gg: AR+sD12tDhR0+/k2qt8QoQzODxZBWYYlRnEvxmU/B8aH26FDUYzwvTzF4PIojV3hsID
	um+U+n7Td6UOhixdSdaSNPilOWJjKnb4viJzQcfpQHy0JtL/JNN0ma9DcghB84mjLQtC5MCmJpF
	O6C9JAMG5MJZIV2KvpB10EyCKSecaYkWW/JiGhgtCmG+jYYcIGGt2/cYuaM4LCE7RRk36A8I1wI
	Dxz3JTPBWZ/31EJcJLmV55YyiSTU30rgWcdrhR+DMkZ5wQeD8EtDA4zO/EqIfSAcyJFkS2I0cmq
	wojI0BEmxbufly08OdjGOERaLOQp45mz9ist62En8PAiQ2DPAEfoPgxJRSQA575HhRJMN0Flz5B
	Ba/HPDe021VMpx1kCQ1o/gmGIFidzSAANyVxaePEdDCKC/hKrzFwuWGdWLKy/WGRbJMQwFAIT1l
	GR8/Y0SPMrWEAqM8uGaSlV3KKDKJhR1tc5shb3HQ7Pe4SDmIfyUYxokeF5LaUOLHdn
X-Received: by 2002:a17:902:e78e:b0:2c7:f5c6:c4a6 with SMTP id d9443c01a7336-2d5d149bafamr27492395ad.7.1787027212376;
        Mon, 17 Aug 2026 21:26:52 -0700 (PDT)
Received: from jia ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb499e81sm12349535ad.1.2026.08.17.21.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 21:26:52 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	weiyj.lk@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH v6 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Tue, 18 Aug 2026 12:26:12 +0800
Message-Id: <20260818042613.281125-3-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818042613.281125-1-physicalmtea@gmail.com>
References: <20260818042613.281125-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clear the device IOTLB when userspace clears VIRTIO_F_ACCESS_PLATFORM.
Otherwise descriptor translation can continue to use mappings installed
before the feature change.

The common helper invalidates cached vring access and applies the
transition even while a backend is attached. The backend remains attached,
but userspace must configure the vring addresses for the new address mode
after a successful live transition.

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")

Suggested-by: Michael S. Tsirkin <mst@redhat.com>

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..77a5a6775c86 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -854,6 +854,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 {
 	struct vhost_virtqueue *vq;
+	int ret = -EFAULT;
 	int i;
 
 	if (features & ~VHOST_VSOCK_FEATURES)
@@ -865,9 +866,12 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 		goto err;
 	}
 
-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
-		if (vhost_init_device_iotlb(&vsock->dev))
+	if (features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) {
+		ret = vhost_init_device_iotlb(&vsock->dev);
+		if (ret)
 			goto err;
+	} else {
+		vhost_clear_device_iotlb(&vsock->dev);
 	}
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
@@ -883,7 +887,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 
 err:
 	mutex_unlock(&vsock->dev.mutex);
-	return -EFAULT;
+	return ret;
 }
 
 static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,

