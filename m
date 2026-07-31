Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C93EA970
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494094; cv=none; b=k8AT8quGUSmic4y5SlRDZydN/Lny9NSYn4lX9YQ2hU5k0Re3ebah/pGCvRguC4wdpboeWusbP1j+m+Xs4ieIaqZyfi8uCh9ILahSRVp9cJw6bd8kLCNpavgGru3WItCLz0ZkQ6/WCyXij4HqralGg0v0PxNdRBKZFbsFM6252oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494094; c=relaxed/simple;
	bh=8jBFo3leZDgnmqctwiw0V0hqICmlxQdyuA6JJbEn+2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bsywqtvhLTDGjvfdiIiqbvxMPiKNAxYmhXbMWl7otWw0QzJ3rws+tQ5X0H5yYwQ6qIw+rtawW4T/BB/VYcQWzbEsCnKEHDZavxCN0wiXgcsDsg8VPRMpyLc3+rXrxcdQYQqYFgrWg1YCmxDhtjOFrvbCv/FpH604ppW5RhTL2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amMWzn2G; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amMWzn2G"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso600062a91.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 03:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785494073; x=1786098873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2oD6x90/2ngEh3h/+xTr/e8V2AGqBaiy+5NsZiEXuL8=;
        b=amMWzn2G7H4DsYjZsU4DW9QPkdO2lYcEdgzK8PDh0yRCiDEPydyTjvUcowdEibAcTS
         0Ofk43j8m7xQSKZ9ltuYhs1q4q1b2wKJhZB3KK4U6yuy5UL/MhOJPi6Dy0woVaBE5n/J
         cjJ9hjDrLxGDMhsFZNEkSDUlHdFq/VQl6YAAaC4IANuizvbZ9Hxb/4dhw7wN4Ffhref2
         8UAyGxlWdDVz0zd2vVOAmHnyaYYXDjg7ltBKxSf9dypxGEMrd09OcuqanP0kS6uWZXWg
         ckUyLME1hVr47Zf1KOHmy5flBSXvH5UPxxjoLrJnYDz+RaG2P7zjaL1j1U+b2HRze3o9
         UrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494073; x=1786098873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2oD6x90/2ngEh3h/+xTr/e8V2AGqBaiy+5NsZiEXuL8=;
        b=PPpNVCrM0DMVswswEOlt2Z9Zf/sxN6iUQmpioNaMFuwYq5BlRqLAoSrgxXyN0UZhnX
         w+4aIGCcJ1rWZTnt0mLk/4Eg8ZXmmaEDz4IscyTxdD1KvNPxSSyqsQlZmUM5IfbeEMJ6
         GoRjkkuMuiF1bGy51cyNh39Ejt1Br9j3HM2/jWJ9e30Bip84H257OVdghQi2H51Y1oMI
         pWSlv2QQYoyBCptsyJzMcm8h+IxwGOtI3r0cXda9ebWLqNz5QJKRYOz7VZhZsHh2FFJy
         NWsXWTysMgrBp4OIFRIo7SENV6U9CbRBOVLvDVPvW6AWIIua1+6jx16JTGpIRYCGJKhE
         qbGQ==
X-Forwarded-Encrypted: i=1; AHgh+RoRFa23XfhKSuoZkdxZwNuavGE2XrTMEAKDCtcOvwv+w8K7ttySS8pgzfEgA9Mwt35I+Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDnT5rbSx+D8RtVfugK9YNIlEFC8er2DAeJPs9aSdWqf93kBWP
	AHZOcf6yhr7wXedqlV/pQoIDitcHSWDYdiotlTpnv1ab0ekVPPx5/L8Y
X-Gm-Gg: AR+sD11LTyxy6KZoyZK+NdPk94kG/ijGFfyNqMrhTDsZ52oIN8O8P6BW2pYONWMbF3h
	xah3W1O86sntSoeMwf+AQAge27OWHWD9UC+7BJ7+xrkgW7hoLQEyyLHtI9F57aQRzgmr2JFmfAx
	a7paSa0gte/6XcUDAp6mypdHaUdNrbMfTvJYMRyewKPKXB3dv9O1kakerFtHNuVcf/uE8iPE4sk
	dCJmSZ16zhPbkxv7qKPIN/WvgbMFSf/yik1A8edT/yoGgmlJ/+rKyAZneMZsuXmRt39Edn74l/L
	0UNQbKcnNCTcG8AuJmW63VC+y4+dJFj+SIrzPnwOaarg4wyUTJFgvKduEf61xN5OPJj3SsCUqDk
	u87K47zPWuUEMO3x6bu3CoXULCGGGam4qFYhNT3KpE7xBMSsaxFXO1C0EXM6gmv11Pen+p/BSIu
	4bQCAlevR+lFS9n1Pj6nfyF2j24HozLJEorfGtRK4zL8FT9nCHvznvFn1RvCKVlms=
X-Received: by 2002:a17:90b:4d04:b0:38e:712a:be68 with SMTP id 98e67ed59e1d1-38fb15304fdmr1243750a91.43.1785494072849;
        Fri, 31 Jul 2026 03:34:32 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab25227bsm1934172c88.7.2026.07.31.03.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:34:32 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: stefanha@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] vhost/vsock: keep IOTLB across feature updates
Date: Fri, 31 Jul 2026 18:34:14 +0800
Message-Id: <20260731103414.1746316-3-physicalmtea@gmail.com>
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

VHOST_SET_FEATURES is also used to update logging while a device is
running. When ACCESS_PLATFORM stays enabled, allocating a new empty
IOTLB on every call drops valid translations and forces avoidable
misses.

Initialize the device IOTLB only when one does not already exist.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 562b9e139a76..3703fd219039 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -893,7 +893,8 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 		goto err;
 	}
 
-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
+	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
+	    !vsock->dev.iotlb) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
 	}
-- 
2.34.1

