Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C43D1CA7
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213150; cv=none; b=aEbU6g1V/XzVdHRupsOyYw3/Ufvu2shXh6J0byKXL4vHGx+zNs2wac49JJ9JgAvi5r9cuGyY3l8filxVxHRNV5eJeV0DrMRhkf8grV3TN58wVM9CPai+xJe0PYITOWxlKgm5dM4Y6RLEwykHcMJLgTOK26OAFOF9cac7vwDwoPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213150; c=relaxed/simple;
	bh=qgynlLSlE9GedrgWrdeKiRWEM+qpmwf3VbwiSO5eBQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q7qGEpYHd2be6ARMXX6WhvSFX+D59ld2h2Sg7WOtKApxgLriyZIX+oYZz9Qa+9EKTsgak3PGEKdK6CyJZ5K3irssxgrkgs4Oo0B2xepkBtrI6MmcT93G3JYsNlJqkP5lcqJu8GdtST8gvtd0NCj3EAkJkvkLaKeHVLHsortyirc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMHm7pSb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMHm7pSb"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so1917316b3a.3
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 01:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787213149; x=1787817949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNr0zjEJARTG031KsfcMOG4mbwEr/hGSSzyVmooR7Lg=;
        b=ZMHm7pSb8aVMctA7jgqzIMXhu0MwOYjbBVPhNeDQ6I45ZUTUNU2DErSoiL2krcIvVs
         8o4yq4YA6BRnXvIf6OoYEO6RMbDJOz8YVzalMP+VkbuYBwXoGwDUymkeq9YpZ3WtMBHC
         ozIHTbH/iu1aBYdM137yPrakpdTDHBjlKme4mYQGYN7Wrf3VmGm9XIdp+1UIg2di4Hyn
         mBP1Kqw5VyKwOLmWlUvS5jB2bykQt/w9ahAqnJLX/fwpxdK9nsR4qqRFIAVyE+HOsxCy
         i3TMvScpOMfyGc0CVcVZEyuJ0WVKmMOssxMuLREgFvlLSkBxKUswcdsvLkHuCA+Y4LGP
         cwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787213149; x=1787817949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GNr0zjEJARTG031KsfcMOG4mbwEr/hGSSzyVmooR7Lg=;
        b=FY/B56f+SW6B+i3BuatiO8WTEUmPfM+0aWS/EddRi8WWlqvs08YRaJZ6icWTTsMbIh
         /Hvh93v0i4XO/vbv2WDGSvnOmX8wOyN2CviR5YnJ88PxBcsWMWZqHGRTQsNeRE0KFsfj
         RFsZ+NNHBkYp5oiP2S680NHbQgT5COdUhuGA4fjaGLOwmrooar2mJm2rnOh5p1Mim8Vu
         1gWW1C0wqcIgCmc0jQB4R8U1TOffDBNl99sS4vfzJdb54LTFw3GE8LKvudGjXVnLRbdh
         LYta0HTyhMpDPM5xgnaol9rPI31JWD8KhZxk/0pO1tfjkAgg6U2QWlzUdvUy0jYk9Mwu
         bFAA==
X-Forwarded-Encrypted: i=1; AHgh+RrByoI/ixljzuMClsyqPfFc3OlVj6YJzuoFcu2Qk++bt/ujWAPyOgebI/JPx0yoKSRk2Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCnh28KIfi+SztpW1fK17DcJhcGiqZ3VSNLPCFLiafYlnTVUCi
	JnzdbemcyZAy/ZPaCyM2qG9ZKky9pgBBEbzXFThuagFuXjuBOfJC768G
X-Gm-Gg: AR+sD13qITxREUXSKtHVTHd4A2IoHqDEeGW8KBKtjpKXJ6+bi5iBrXI0eOoOOD/Dqf8
	+lRHIK97Hgpmng2jeWVTpv8cSb33DXJykMVBGsooLQYvx6zdKqx9jzDVrgcXZHths3vFX3/kg9c
	Dyf6dZfv73d1vwMnPdlDAEM224Tl5OX0ASObNYYT1B5x+6UtA5/L/MRBPcmJ4JcKShkxWcxwXK0
	GRB45Z9rTQiU7rdTkoPZ3oLyNz0UDqwuRtilxOcnOYTOcQ2rYfi/+7oR3KqORGExmHermBJURGY
	4V6aCqyhZ+COMplInlT1ZE8b68wDyiXYy3gMaW2KTD6veptDXo07OzjI17RNO92g8CvpqGBEG7b
	tFL058rz9jt/Y6ADim4NhZIu6wN4B3pXsfqb18hylyiPtL5ClOiObAeFxZvHJZYfb1jBqE+KpQB
	PWXSUtEi6d4x3rLvrXkzAjE72NaGj574oxjdl7x+s8cy++k8RZ4Zqk1+oB74AjyOpL
X-Received: by 2002:a05:6a00:2301:b0:847:7ffd:ce35 with SMTP id d2e1a72fcca58-851d382e720mr17907618b3a.8.1787213148258;
        Thu, 20 Aug 2026 01:05:48 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d366d65dsm1412020b3a.50.2026.08.20.01.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:05:47 -0700 (PDT)
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
 [PATCH v7 3/3] vhost/net: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Thu, 20 Aug 2026 16:03:32 +0800
Message-Id: <20260820080332.313933-4-physicalmtea@gmail.com>
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

Apply the common device IOTLB teardown when userspace clears
VIRTIO_F_ACCESS_PLATFORM. This drops stale translations and avoids
rebuilding an existing IOTLB during feature updates that keep
ACCESS_PLATFORM enabled.

The transition invalidates cached vring access even with an attached
backend. The backend remains attached, but userspace must configure the
vring addresses for the new address mode after a successful live
transition.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
Link: https://lore.kernel.org/all/20260726141158.1652386-1-physicalmtea@gmail.com/
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/net.c | 2 ++
 1 file changed, 2 insertions(+)

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
-- 
2.34.1

