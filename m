Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56B0368D40
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 04:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785384606; cv=none; b=IHkKhsm6XyETWXcAvN2le4WGsjInreYLOodvRXVQj5twLlz27w319VGjRiyxo0IGRxB6a3ToXkPSDnV+Pjwh+mwm22If2sB7bAbR/E6ToP0OKUjiGbn/DTGnscxGOvjE9M/cjDtXf2ZLHaaBMHHvv6rjgCC2n9D5ciQs3KHJAKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785384606; c=relaxed/simple;
	bh=yjq5ysintMy6qPSJ4Cdq7WhtHnZn5JBYrFkMLEUEGsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=irKpumDkl6ujL4rNnHEr7nOZqaqBhktGVy3Z2B7/1KSvitaOw45eLL+YV4zz2+Ti3FZkNUFZDr2WDdBk+y5JkzMhNJWL8HZXAciBO/uNayi2UE7P1TrcKLBpLbgpLRWgZZ9s+gqWSAXjb76+UZfR8yYxhBvfSzOuGRvubjBuPgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxP4VZQ5; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxP4VZQ5"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9e7391839cso1506779a12.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 21:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785384604; x=1785989404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KnLHteJgCUKCQ5QeMJy2BEHKwrjGEMGZN70wKgx1U0U=;
        b=IxP4VZQ5pJJGPQCtNH147ZlfsTU4muFuS14jMbMflyY2hXo1zym078a42tkpZIf71i
         wiy6aVlqvHjICTJrU6QK9fu34Iljot5tC3H0f3720DgBmqkN+/kzqcYjZBJ7Pn37E1JE
         yqZFuArULbqV1FlkDIQpl8CtEGh0+eMBtkqHOWApIoEqVRM8TT3XQQ2lIeuaVnIksMNh
         nowkLzPNFqgFSeCKVEh23n5fpWiSEw6af39BZnspZOpTomRdoHpH5R6AbsmOeDVcEe5w
         4EMCiyLAa7C++B2odlY+1w5ua3kgT0UvElGGWidtdVb4A0B49usXR0DRqGdIKY9acpI5
         PSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785384604; x=1785989404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KnLHteJgCUKCQ5QeMJy2BEHKwrjGEMGZN70wKgx1U0U=;
        b=riTu4o3G3aRTdeg+03HcjOdoJrY/iTmfOS1rkn/ykIgLV1IS3zzgk5ZLnSyboFeelw
         uSg2RONd6Gy2sOsBG9gppf8ffpM1NbeQSNYdEKeJI163dGVXBjkCgpTddf6iehlLIGtU
         d8irxBz3yotb3M1FMGREwxp8ter+UtbhOKw8kVxC6OOeajnA54M3wc3lSS3dJwneXn74
         kPW/JvQSJHcd+Ln1cDPHpzpQ935Uvnspgp4ZvoxgvpmO3nOtBxmjRJ23gZe8tZlcLLo8
         YziG/9l8n91iW4ZQUv1Ta1HyzwEksZYG+89NE1TvKaCWXk1pVwv7MxZk29oSTtZhXqbq
         Qzlg==
X-Forwarded-Encrypted: i=1; AHgh+Rpw93oT3FtQ6CHbJZBVhuqFFNvGxZZQOLk8muwydh5nHnIOX5gjPnlK8kpWL49X241Yo50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3TRwIKuCtC5WZB5ahkL/fB9voBzrjepJyNBSexVLdMIyW1Cim
	tqkmubP4YzrQUctKIf936cHYaDBzuHaiIge1PMbfmpo5loEZ8f0EiQ5O
X-Gm-Gg: AR+sD136/QFrr1vIn884bw8sOJ828kVQvPELcMCBlJNNIaQcF66x6s/6Tx0zf8hybFA
	Eu+e5/8dPwfaxcc2lk7LWV0hDL2+H+KGhIB+Y8/SKTd3KKCP7PJ75rGVAalrvJVmUCORHr06tJ3
	vJZtxG7DfYrAc+iRsrsoE0f6ZVG5EcpCJO2iO4xkC8PZq0wN8jFRBbvNCDnssyN+v5NXiKpGKsG
	XjVMEKvu7lPt3a5HL0jA0lS6EIcid5ZDKTXZ+1isO0rB36Mep6i+J0zo+w/QgBrRwUQmZxXrraH
	ZB+pd4ZTs6ds7pTf3D1OFCScs2X1ZUqTinilEH99IPS/XXtfALoxTv08nQ9bnT+GnF4KETOZ/yK
	aFWz27CIi60NaXmsdlERUa7drie6T02Ub2k755+Ie2gDQhdfnDoJaRL5RL2Wz2v1+tcwNn0IIjz
	MCxlYtBpcckvPfD4/1U0XiRHpPIaCXyRL+6OQJpVdfi3HeGaqlUA0Tvn2bXSaurZNeEB7oTUU=
X-Received: by 2002:a05:6a20:b58b:b0:3c0:9c1b:d0c0 with SMTP id adf61e73a8af0-3c900793598mr870063637.75.1785384603654;
        Wed, 29 Jul 2026 21:10:03 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b125bbsm15993102eec.5.2026.07.29.21.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 21:10:03 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowang@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost/vsock: prevent stale IOTLB after ACCESS_PLATFORM changes
Date: Thu, 30 Jul 2026 12:09:38 +0800
Message-Id: <20260730040938.1725757-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vsock_set_features() initializes dev->iotlb when
VIRTIO_F_ACCESS_PLATFORM is enabled. It does not remove that IOTLB
when the feature is later cleared. The virtqueue still points at the
old IOTLB, and vhost_vsock_handle_tx_kick() passes descriptors to
vhost_get_vq_desc(), which translates them through that mapping.

A userspace backend can enable ACCESS_PLATFORM, install an IOTLB entry
for a payload GPA, start the device, clear ACCESS_PLATFORM, replace the
memory table, and reuse the old HVA before submitting the same GPA
again. The feature state then says direct memory access is in use
while the TX path still uses the old IOTLB HVA.

Reject clearing ACCESS_PLATFORM while the device IOTLB exists. Also
keep the existing IOTLB when a feature update leaves ACCESS_PLATFORM
enabled; VHOST_SET_FEATURES is used for runtime log updates and must
not discard the current translations by allocating an empty IOTLB.

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index ae01457ea2cd..57e8fd1eb670 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -798,6 +798,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 {
 	struct vhost_virtqueue *vq;
+	int ret = -EFAULT;
 	int i;
 
 	if (features & ~VHOST_VSOCK_FEATURES)
@@ -809,7 +810,14 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 		goto err;
 	}
 
-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
+	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
+	    vsock->dev.iotlb) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
+	    !vsock->dev.iotlb) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
 	}
@@ -827,7 +835,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 
 err:
 	mutex_unlock(&vsock->dev.mutex);
-	return -EFAULT;
+	return ret;
 }
 
 static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
-- 
2.34.1
