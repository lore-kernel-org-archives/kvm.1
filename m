Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A735F4195A3
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 07:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692582; cv=none; b=fF1SMw2mZ2kOUyiFVqzFw28PNMDTjm74zF2W7irUXoRQXTiE7X0DZcY9gKli0ov3dkUzoyMH10WiiWdHXkJowlFQCoImkgev9mKdG4mO0gELWVFwepG994LJWzJWOdMtMv8t4FSnD9DY9GO16GN1dCCd0Q5ficENz5V/bJixihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692582; c=relaxed/simple;
	bh=lBg0JhbsnNpsGb1wruN50IIhyCn8WZ0eKcALPJXFHwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RlKNTRaS1+GI0GFy6eKZbUUAYBaeFsiu6DbMlT9bD3q2HDxqzrEfb+qIux2IFUHkftDRzg3MjKVI5/ysZPUNdjcjOT1Zc0NgVTVPiPLsbFyyBgfDl+/RDCX1ds3c5u6HSiE+TC4e1p3ZVel+nu99qmx8ZMTuo2JtB8ngGmFDguI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5m22vlR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5m22vlR"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cacf197759so11938525ad.2
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 00:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786692569; x=1787297369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sb2mcYm1zw8ztLxWQHXttWOsqNChoxNNVKIkbMFY0ww=;
        b=k5m22vlR87KEN5e8D6r7wNHpVys6E772VUtKhbROw4/AKEqE6N/p1k/NtuoNBJvWFu
         AgoLqq1bAqTP54gb8kj7wf7h/vqlVrVS+iPY0bb3XEWntrEABPzWTtkarSIZ0OX9H0if
         LquE0PXj8h7crUyh5w3yZBp1PRcCbrsQb+Y7zzzdVAJ51JpsQWQvUMJnhIQdX7DjiCdl
         LvtUddo5dMJ/Ca9FvyFUE4mAMVelL2Mj8AhS5mYd98x64OU/giMXe8Q1AvSBT//adHJQ
         IFxdPgirDzTs8absJRtrDu21fBvQBCVjhpHMVFIoQ3oZUBel/vI68Nn2BDt6UlUk/kr1
         wqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692569; x=1787297369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sb2mcYm1zw8ztLxWQHXttWOsqNChoxNNVKIkbMFY0ww=;
        b=XIdXzd0i2tkhG7NVdKFWb7Vr++2y03ZEOe5FWclxgg+HzZ2MURp5BN+FxD4EGNnrvP
         QObWPE7KDitRXvrKde9/yO+Sg5/YloORROBxJ2e+31o4T12daXmNue9ADjX1mIrnRwG9
         WqyP//DjPHlcXu2XGBVvB5TW3Q8sD7mjrPjs0poJDPO5bjndcW23hbzldrMTVC6fb7zw
         raWShfUQYiL1B2UXldEsBA4IonsYLeiN0khMSarCvp0EQKIyDopClNUBRqoHZNfmtLMn
         I0VDoFPmtw9lqhnETIgZry/EMXRwtMpdFH/a9eyDAHqLoh3D2WxevEms6XOPExZGhRRV
         86ow==
X-Forwarded-Encrypted: i=1; AHgh+RoGCbnVgvLRzRrpFs7SOu/SxhYl92b6ughtm1c5t3rOKM8HqfV1AIiuY7EQ7RwGWSfpSCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4cFr36Fxb2u/pgiyl8xPvT2y5oXqGtisQl9IL/7+Yflyicea+
	ZsL7E4+KYhpsqwZzzqB6ASPjcH8D4ciogFsLFQOGxOm0X8Z00SSQKAYg
X-Gm-Gg: AR+sD13L+K8hNHb/DEjCPyj2S2uG57GjGkaMxYR0r4Vbq3bNZ6Ft7uP5v4z0jx+B9Cn
	WP9d6ZmkH77asDlsm8NgF+rJ89/IsmgnmEiJNlmz2gRlqAZmBi1IYLgg5/aVBLBXQ5ENS1j91BW
	WY3aMi4lsTHUSsg4lhHsob45Ls3xSfA6ROrowTEcI9wmWXT4Rz1TPYsBQyRszQD3hJleSVloBFU
	S8hBuv0zw/i/3MLyLFiTkM32w9zTInXI1jrmHwp03C/4DVdJK/IXDvy4xgVMDoYxwKFhNL4uoxU
	3MhbMGNtyXodWae/bZq/KLIL6jTxhS3dq5jDZ8MLs/PgktzJVcqiQmoPDH/QE+CFAyMqnpSXa2x
	6oQ1PJzMOUlhFXdlA+RHHzmuHg6f1uB61cet5qQ9qZmr5pSbhuEPR9n6Oxe1gnW9cjBm1aK2yaq
	55nFMBfvOy6ar/i7glHYGZR7NPPvumAhq0vWWf/TchIFolXlPQ1hZGjyddIlY/XpU=
X-Received: by 2002:a17:90b:520d:b0:38f:5801:cd76 with SMTP id 98e67ed59e1d1-3933b6d0171mr4528637a91.3.1786692568692;
        Fri, 14 Aug 2026 00:29:28 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ebb888e3sm1388828a91.11.2026.08.14.00.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:29:28 -0700 (PDT)
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
Subject: [PATCH v4 3/3] vhost/vsock: keep IOTLB across feature updates
Date: Fri, 14 Aug 2026 15:29:03 +0800
Message-Id: <20260814072903.124991-4-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814072903.124991-1-physicalmtea@gmail.com>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VHOST_SET_FEATURES is also used to update logging while a device is
running. When ACCESS_PLATFORM stays enabled, allocating a new empty
IOTLB on every call drops valid translations and forces avoidable
misses.

Initialize the device IOTLB only when one does not already exist.

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index b69c260eaeff..9142fa1143b2 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -869,6 +869,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	    vsock->dev.iotlb)
 		vhost_clear_device_iotlb(&vsock->dev);
 
-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
+	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
+	    !vsock->dev.iotlb) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
-- 
2.34.1
