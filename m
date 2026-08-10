Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A30D3E16A9
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369268; cv=none; b=Kkfwv2Td0487moMmt/ef9YVj2d3BLapTWHoqH1yaIX/rnmdW25m7oIcntmo9oXOd/nDdV1VkudbnRBmBwNHQmsgHms68B8mK0iCkt9Ld0wVIQtCmYrIfZaRuVdrAKps2sYpF8yy/kck9O9pPn2gLyowD5F3+R6H+W+sMuhW3t5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369268; c=relaxed/simple;
	bh=OR5SJbAjYqfNbWbLK/Xp9DBpEIRw6MZvXrZYmbjvOZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i8lbCM9QWAPD19h2joojQivNov3ipGJx7ylSJOG7yhmuuHhXlivYM5sxIFTpgaFLqaldprvxNLRh2tbYcxNozEEL1pyXBOv2VO6qB0FxYVPe913qmGw2Zgx12N+qYjNp6at9AM1hlTIM6PGoj+jOZPjR80gCpWR1hCd/BXEGZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkgeGrME; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkgeGrME"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8486ac3f347so4316894b3a.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 06:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786369266; x=1786974066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WBpRbjDpae64ONOAIzC7CQyuvwbiULpdksSC8EfBNlY=;
        b=nkgeGrMED/BnADIseGgNwE9yKH7QWUbfP5ObzPqSkJ+/7xlEh194AXD7TRUE+WVR6P
         OPDuhf/M4n/k+aWQcEKsp5H1F60SHbLG3fII4pf4yersSf3NIEvGNuDpmttSRofGb13y
         y/wctwLotJomgvKjx7sECk9I43+P20XChjK81yucRep2NAu5pVqowHvZFMkMwWwnG+TL
         fHa3J7/g77mZ/CUrNkPFzfL6Ky1lyIUjf56XfMOOk+Mb8BQBig5T5h2roEXjMJ9GTlOr
         XKyg97mYhhC80Sl33kTyO2qT9i1WF6fQDZhBsXvAEpIxHaN+/IqLZ/xzk+cGErokDpzt
         8/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786369266; x=1786974066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WBpRbjDpae64ONOAIzC7CQyuvwbiULpdksSC8EfBNlY=;
        b=lruFNZNql+zCDOuqkdR4zAgSyqvejTjGcDHJbeK0lsXAQWOrPwYYFuByGaglIgfctM
         hsyGOoesKNuAsdca3enxZ2qGpTIaPluQIE4Jg7qGn+s3FnTP07j50WviRhCroVzklYgx
         PoiCkzXRj0f7fDXRiG9H76Nt8at/uyk+EkoHsfDqLk1Hmjjhob3j9N6YwV+leJUTtJ1F
         hCEmmbNkowgPUYw0efgp1yHFa0NpsfqdNP4ds3RxvAB9aurau22lS/CSjN3Gk25Uk7Lm
         gVvO0E60Di88TRry2Nhq9Hg7Tw39rIkL2aGJbUjLW1vpUpqrS6QNEQz1Ba8cKxdtnhN7
         zxIw==
X-Forwarded-Encrypted: i=1; AHgh+RqvWUbvF/TMukBv9LmxMXwlnofbMuo2BoM4Cd5HwHi19QHCHhiwt1jeT9M5r5/ClmURG6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVz7Jjmc6+/LGv45ju13e38QvtuiRkxY87gJ3SFU6LAWmw66e7
	4ndv/XE8SytZ21+vvQorc+BkTBC4A8gjgIr9vRoUd0vn1yDU5Kc9x7uS
X-Gm-Gg: AR+sD11s+ROmoirqrAP26jskf1x0ZoHLcGxZfDWQkWdE6OM+LPAySg9cJOfWeHfNw4g
	ZKwPlpZGThgpptOjr4jbAsCyK6JrEgY4F+vWGGegvIR7DUltwz5Ut01385E7kThN++cYMdlW9FP
	yFfp2cdsDf3JYVjfrwoCfik70vR24S2OREoEuTc60f4vl9t3AiztN8uZ8hdmqs5E8r2JUEe75Bd
	28chTWf39uWtUlXkT8ny8PpNe+qFvxlZwX795sy+f/e0da8qMLatRXPES/SwOtyEN+XfkeYMU4E
	Ohm3YUJUauUEoiEhXJgVw4YfBekI3ypB1F+1X41YiIQF9daI22mJSsZyW23uDvI95uVLJH3pwd5
	obDSHDsxIMM0a8QThs/YvjopXB7DMqxAEx7+TtUi44IVDhwZhQofrid/F3V2WNTndMP2pghizmS
	jlyiQoadHSylS1HQaPtEw50y1mwNebriI9LyiuL9BHii3FDn6A7liDNXCllWiOZP0GqXaZk3U=
X-Received: by 2002:a05:6a00:4b45:b0:84e:cd14:aeba with SMTP id d2e1a72fcca58-84f6b6f2e61mr17355422b3a.6.1786369265853;
        Mon, 10 Aug 2026 06:41:05 -0700 (PDT)
Received: from gmail.com ([123.118.75.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51f166sm4006236b3a.35.2026.08.10.06.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:41:05 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] vhost/vsock: keep IOTLB across feature updates
Date: Mon, 10 Aug 2026 21:40:18 +0800
Message-Id: <20260810134018.143973-3-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260810134018.143973-1-physicalmtea@gmail.com>
References: <20260810134018.143973-1-physicalmtea@gmail.com>
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
index 7372c22691de..1beae7f5b9a9 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -889,7 +889,8 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
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

