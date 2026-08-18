Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0764339714
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 04:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787027227; cv=none; b=jOo5IHc0AjR/ouONeCWiL/pHBQHBSVNiI7pXblneWMQlEF2yMFWTjx6toXdlzHN2PvQCKfaJzcEM9/nyHm5FxGWzqjBZFx2t1+izxE2KDij7irLwNR00CMfOllTaewKM5d6O1GQ3noQ7N00u4kKu2PK2XLhcHCOAseZRY3fT8FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787027227; c=relaxed/simple;
	bh=6mXttWXqP7hKPvKeC1m83ALHTC+qzKExe01Jfr/zd+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k46nkcUJWUds48unfM1uAXlXr5wu65xoFcfYM5Ml/xQqRoUDjyq9QsVQqAlSH06s2dTSb1DgcDNG1IatkDOwOJuV5AyfEIHvD3StUiQDD3jHhNniDGgWJ6NjyCwgkZ54qM8Gzh2PQF7p1FzWgVe0PrNrFi78QDxTAibGZ13Ovo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdYbhCLg; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdYbhCLg"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so3481726a91.0
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 21:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787027225; x=1787632025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Z6WowRuMM5BuwpectVAQheGXdLd2OFjAur/zQyOeH0=;
        b=YdYbhCLg09rumWe2qGjk9B4rpUgDUMsMwxzsg45rOBEnRJQAKlUQ5RZl99qzLhVpE3
         2cl4cjTpduG52hM7sqSCmWK8Ie7wjYl9eE2P/guDhzgyRvRf63qLq1SrFBWooAmfoUll
         p2ND1eqmwZ7Y+RWjAnUzZd1yceChp09OtfyfvLt0r7NZ793WWvEPmkHnYWmaZ9zBfVkL
         KHNYOXGKOjQ9n9zPBhIjGkTsuhKqfsnkpXJLNiXljknOayYUlBMGYCizprU3NGQ4i5v/
         uAg4f+ER43sOEav/0B4NCaA3k9S6RCm7h9FsO2ZhXTgBy9HBSFrX4NRF+p9TJyCfO1C4
         qkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787027225; x=1787632025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Z6WowRuMM5BuwpectVAQheGXdLd2OFjAur/zQyOeH0=;
        b=YIMDydD4skZN+mEgY6XMERCjQWnMbLD9h1wx3XQsahWcrKvQhL4N6hInCxpUSrapD2
         HtHXq1PW4ehzqToG6OP4eqoDVe0W2r8KZx3A7MYB4htDvsWo8hdM6OB6xl8MdhsYhqyG
         +Ofxb0leZv16W5CzqLO2PslK0pug7Jx3SInla23sGl62u1hyfK8Lx/LK7yW38hSRRKlS
         Gz20qrNo9taPRgm0W47B53CmVTspGMi/qAcNhqR1urX1tzN9g4/GAlqOrSooCiT1S9MD
         OdMmtNXdsJ0u+BM16MTJ5NrUs3Tg2EqRDuzywLMEh3oJkfXKtNVkU3AgyQ7XVgyKRslc
         dPEg==
X-Forwarded-Encrypted: i=1; AHgh+RrsRJPqg4h1XLSVdbE2TyNwumjc1nWK1fdgYKNgpLvJI1rHTYlh6g2bltDWM48sKAfJy7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3BizlUV1bIxJGfqsq9hb38l5pEybtC6mpr8V6M/VU+QaKZ8Hu
	P7/pft7bwVaGqkXnrW1DNwpMz5RcCm+npmGngPcJdsqAU6pMiNOVvHnz
X-Gm-Gg: AR+sD100O4VUNgaxKg88mb+ybOmXzAYnbW0bYbwK1EbBMhLMgKcj2eRftWy4uarwG56
	AWUVcucamvk3FqwhX5dPAEUInpzd0lVpYl7cLpsidQf0bpzTbTMTDCmt2RdkmWbEK4EXj8UDVwM
	r3aL3PNG+rUsBztUZTbYk2zm/uPqD8qO+jdq79r8+MBHOCsxL/cGJCizk3vvNE0DZ5BiXm9Mepl
	WQtmwTV9XiK6OZrwRGSvc/cKPMI/o14pcovBpY/d3raoGCLCiDABTM8Ka2ZHsgqNrXbz/8CH4ud
	yjSTDdmQnd1pp8pYXfBRyX21rQ4WNiYlj3rVUmY5FyaSa6xA92W5qNu8wtPQoAGZViYRKb7aTVc
	qQschGCx1XwVwdCjcL+N9aR1hw5HtofVCCjExsd4ahbUj5PyiYZlZPxCljh2vZHkMqVIyjhLIdK
	Sks+osRlefJMDur1iX9gvMSDEkKgpMAC0pEuO1vCJ/iHNQqy0UxAAE5A==
X-Received: by 2002:a17:90b:3d45:b0:37f:fd1f:d30f with SMTP id 98e67ed59e1d1-3933b9157eemr32102204a91.12.1787027224856;
        Mon, 17 Aug 2026 21:27:04 -0700 (PDT)
Received: from jia ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531fbb41esm7011643a91.10.2026.08.17.21.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 21:27:04 -0700 (PDT)
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
Subject: [PATCH v6 3/3] vhost/net: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Tue, 18 Aug 2026 12:26:13 +0800
Message-Id: <20260818042613.281125-4-physicalmtea@gmail.com>
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
 drivers/vhost/net.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 77b59f49bddb..64671cf77a35 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1673,6 +1673,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 {
 	size_t vhost_hlen, sock_hlen, hdr_len;
+	int ret = -EFAULT;
 	int i;
 
 	hdr_len = virtio_features_test_bit(features, VIRTIO_NET_F_MRG_RXBUF) ||
@@ -1701,8 +1702,11 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 		goto out_unlock;
 
 	if (virtio_features_test_bit(features, VIRTIO_F_ACCESS_PLATFORM)) {
-		if (vhost_init_device_iotlb(&n->dev))
+		ret = vhost_init_device_iotlb(&n->dev);
+		if (ret)
 			goto out_unlock;
+	} else {
+		vhost_clear_device_iotlb(&n->dev);
 	}
 
 	for (i = 0; i < VHOST_NET_VQ_MAX; ++i) {
@@ -1718,7 +1722,7 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 
 out_unlock:
 	mutex_unlock(&n->dev.mutex);
-	return -EFAULT;
+	return ret;
 }
 
 static long vhost_net_set_owner(struct vhost_net *n)

