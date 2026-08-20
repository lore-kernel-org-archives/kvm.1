Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D63D1CA7
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 08:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213113; cv=none; b=ibBLhOL6cRn3ldt5E4unih1T5FX4U4c30R9yGsOxZunS+3ti24wmincu4NVHr0vtir6cifWOcodQVsL2BYkAyJ6Cy4wOgtZl0/+BQvJUHGgft4k5ozXrB5pSJLYmfaK3rdogzbyfQAQQrwNgwISVVOYEYZgwBpX/X2LyFr7tun4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213113; c=relaxed/simple;
	bh=dKGHt4r84CpOxIzBLIbsre1FSK83Rg5xkKpViCYYB1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dtht96oY9tYVLcMZCp51pBP+m946iT1q3pv7ldir2E7HrggnLeNCbTXweyO+4oTO8z/OdTzHxY+lUQ+rpNvtIf+q42ZoBBAmHq2fo5JcCeBxaZSM9g9IqSa8Q20SGLfCwv0qltTxkBgP8tKarx8pl7Fl3UaRSY2IjxAZIOKr8K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEw+F0Lr; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEw+F0Lr"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbedf318752so1161868a12.0
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 01:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787213111; x=1787817911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lTb4s8ilSvnVrxrv/sl/GlxziAICPTcGZMT22LW8F5Y=;
        b=dEw+F0Lrqj/hRN1l2/jZd26S04Zj0a5E3WrPiGj/IP4mbCSRqeFpKsU/v6QLXFVj9l
         8UDW3h1Fw6p6KgHiuFy7A/n44ExciFeEm/2XYyUs6xedPLtgBwR9zr8Pl14ZbCrb7deh
         eumPK/1wSFQH4dJFrhsUE5MzI2wSv0IFSJQglh0fS7NCRKLvJvEwabyIsKx1PEhVEsF4
         PE+JsRZtJJVCizyjze0pOVwmy7607mUyQuQfGswAKHuFV+HO1ZhFZpSE7DgzO0iweL+H
         G6GXebAxPvUMHws9AksTOu4uQ3HEd4SzUPqud8CyV4ftcEVV2EJ5xXzSDvRW0gi/Ipv8
         dQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787213111; x=1787817911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lTb4s8ilSvnVrxrv/sl/GlxziAICPTcGZMT22LW8F5Y=;
        b=T6Phr1sEsPXYQcUFxm51HP6YZLm0N/IwrcQjqdInu9+vu+H7/rbSOcpE0iCNJZE/0E
         40Bf4eRyN4gzIgEM/WEwuW6Ee6oqczRA0xXZyPxxEPLbQBM2RpxE7EWv2vqgnGzziNgy
         ve3G2+DgJuOcuvm5iPM/BAnE2hEntRVTgEOO2CXm1QSmmr5AxEKA/iv2SbwN37SJHT5D
         I2UO2akgSBKxDcxBospXVnRyjGS8WNbIpKXYArpyuTqDhmwALUbsAvh+CQrncAtvR61i
         J5uWwamie2zivqAUEEAUhogPnmtcXTjnhsXRF39/lQvO4EcGb5PjX+BebJBakHu8ouB9
         LRsw==
X-Forwarded-Encrypted: i=1; AHgh+RrtN7wMSJUFnr1yU3Y63YJihwvefmw0QQMJFUjXTvdHau6oSPalLo94OTw1gBGCRQ3tglU=@vger.kernel.org
X-Gm-Message-State: AFuF++l+B8slMxgB6CrAC7K+r6Fc9+yu9np+UGIDfLTQeimYx3WwJzo0
	Wto45TxXE6kkTe9LNwdG8VAZ8XnblECoqm/u7H8MtCUTFefOlnVKgGg3
X-Gm-Gg: AR+sD12dgunjNKwjEavAmpAZLpdbKfwoCG8nehfG2lFDIPUblTPHUi4ZAEz94wyTg+d
	Al0LeKkdTo5u2hPzPa6IIfMXOcQn/MGz6ysqgZH34uT4TsSpfWdsPK9ET90uXhS6zcKxYv+Vjom
	gB731tq5ou9gWdz1lW2OB4dsiea0aXpd0X7yHyve0qmSyhjibc/EUoGBiDzomHUZ/7xXS5cJp7q
	hgIm7LkBiXO1U/Qz7EMSKb1lEMiBOMk/KHpDUcUym8omGhk2LAmnBNlg5zGb3JRE1aXCxd9UVrT
	qPrdMiw/ff0o0BvsQ5KBa2P7pO2tJ5IpNoIu8HgzJYG3Zf8XGhCSdFY2feR7TStoNc7S+1l6m3t
	n8QSepRRzXxqpcO8nPoqPbCWOlUOPfaFWfojGoJWqgG07Njo/TMMufcCXwICOj1djDamXZOp3mj
	29oQZXzwfGcI5AD51wOevoLBgiLE+2EYARzNDTFukElNZ/FXDbgteaJ2rrcY+fNCmJ
X-Received: by 2002:a17:90b:4fd0:b0:38e:5b59:c2ff with SMTP id 98e67ed59e1d1-39580a4d031mr20764760a91.3.1787213111062;
        Thu, 20 Aug 2026 01:05:11 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb321dfsm6047155a91.16.2026.08.20.01.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:05:10 -0700 (PDT)
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
Subject:
 [PATCH v7 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Thu, 20 Aug 2026 16:03:31 +0800
Message-Id: <20260820080332.313933-3-physicalmtea@gmail.com>
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
 drivers/vhost/vsock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..e1e9d002d6ae 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -865,9 +865,11 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 		goto err;
 	}
 
-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
+	if (features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
+	} else {
+		vhost_clear_device_iotlb(&vsock->dev);
 	}
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
-- 
2.34.1

