Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047703AF65C
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776071133; cv=none; b=C+jQqdQHSG59fl9RjtRFIS/LWsVDEtN2qbZqhR+jEWPZXvm6f0FH7kg3Jk/cWtZJ5ORIC3tFPFSQ0ymhpGWmo/he1Q2IISbuvRtRFyvp1yJBjM+lTEGPDewedTC8jq0FmpzYw7LSgDC6K7JuQVDUM4uyM2btiZC7+jWUPkO2IaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776071133; c=relaxed/simple;
	bh=3wAOmCEB6xmmFNvsqIUiyITnqZOU3fojvHPM3MMcEOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kasiOcgJwxXoPaJNqY6JuR0YxIUaQFcgsx33jnNbZYPVP2fpFE9Og2pP8mc8R3ZNX6uxvzVGP6ptgC/nT8UMQl4S9tDKFTUc+oJ6BHQG1VyWs3JYFlC0gCot4+pfNU9sGFC+qa1mSn4Edx450GaY08d0psVWRQ2kYeDY1I//wfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkYLaHCr; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkYLaHCr"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35fb0bb27e7so611322a91.1
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 02:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776071131; x=1776675931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4rWbsiBNxWsuEFoJoM14TUA11TPEejjWbsfveSsSAA8=;
        b=gkYLaHCrYST0pNJPg5FYd4JbMnXgfLxR/B8s7+9CRv0NHYEdwHyemhOR2kIawmgSRu
         ErW0fB7sVaS8YWIqdR+6uSov2TYhinVMNf6njXXWqtRi/syDXgzldf4XKrYaLnHXsfvp
         /zHmo7IDV8AHIuaSCZqVmDZBO+wlcvqbHgx1hkm3gETJFfcrMXzPRR95VM55E0CEwAd5
         FWmXyiKv75xVO9qonWZj7mWhIqT7d5PWlJa/DMItzXtuY/8jlPkjZZERWacYZz/jJMmJ
         QWn7tpl46G5fDT7sl43OK2TjLsOyho+f92MSmCAWwX6IIr67yqOdBm9Msoisy3WQsKv1
         STSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776071131; x=1776675931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rWbsiBNxWsuEFoJoM14TUA11TPEejjWbsfveSsSAA8=;
        b=HSiLlVZaSqCW5NyZPCgJR0fKhPSLIQY3aZSwaajn0yVFz1CgeugIo/i3ZDHZki0qf4
         3gXp+L1k5xf2o16zxk3Oy1rPETp0nFb6FZ3DGdc/mj97HCoTGc8Ds7nU0X0FGdPJQzsN
         UCKQtV3oVQ5wuYxcWrfPfIOL6Xp6d3vX0BnkRcCKYG6LbijS3PNQ5ekHPpFenSUHJRHd
         rngDRUhXFbC9H0whwR8w0YSmn0MS+LlzhMExEj9mbyuMr81UQOkCXYxV4E1qruPs+xMr
         cw8O2mf/lKHcok/Qg+trNMA1Js2TkZa3OPgWvgNIBkfZcbyMXe5vyHS6Xoh8OkUBZAGN
         0DcQ==
X-Gm-Message-State: AOJu0YwTLn7lQajKWVxbbtDsFsUGscSrbRpF+uoeshZUnmGoXCzB9UIC
	H0xkb3Mygtw9IGvx1U08PrkxbReI95dh4RKse0gMhv3fBa+mlcMkWpNYLofa2g==
X-Gm-Gg: AeBDietnFKAOvhkEVm/gzsldc09jtAiF8VlaeiwL8zt06QWegNle59My53Ih98lo/+y
	FDH6DpMFqL5HgVGxTfqMtcx2GqBmiPTSxf/UpVbphGJJyObFVqdzLZ3bUjXlcJ5BgWxkfkqUl2r
	G/oO7PXeL0WdGnryZFnBwHf02ggx6fjeU3Bb6kGPkRe5sOmbrPuHuw2jiZc2lpGKw3Gx/fScIq7
	GdIoFcvgwIA7oOHPRA/9tlPlEBoglSvOOo0hGRqbw1qrYiJp6GXbGyicL72/DizGoYK74PWNnWu
	TqvkeFEQOJ8LSY3X+Ba1AHYv0rkXwCfeAybZSr++T4PTUEBD/WgDVI0EIMArlT53YWYKid6J0Ej
	6gkZNTeq5oEMqt5KuwosWbCWf1E+qQHOyfMeCxxb4dpi9QRyp+GwFyVNJCke/GCcKwjHdEwi1Uk
	9ZCES1us2L6LlJi/ugDLSy9J8io7DdC2Y+jTRC9kLVHTleSRYm2JkCc1b0BZ6edSG5
X-Received: by 2002:a17:90b:35d0:b0:35c:cba:344f with SMTP id 98e67ed59e1d1-35e42814b32mr12084494a91.13.1776071131141;
        Mon, 13 Apr 2026 02:05:31 -0700 (PDT)
Received: from gmail.com (69-172-89-235.static.imsbiz.com. [69.172.89.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e5a725b2bsm4274931a91.16.2026.04.13.02.05.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 02:05:30 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: kvm@vger.kernel.org
Cc: mst@redhat.com,
	jasowang@redhat.com,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] vhost/vringh: Fix IOTLB permission in putu16_iotlb()
Date: Mon, 13 Apr 2026 17:05:26 +0800
Message-Id: <20260413090526.80563-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

putu16_iotlb() performs a write operation (__put_user / WRITE_ONCE)
but requests IOTLB translation with VHOST_MAP_RO (read-only
permission).  This means the IOTLB lookup succeeds only if the page
has read permission, ignoring write permission entirely.  A page
mapped read-only in the IOTLB would incorrectly allow the write,
while a page mapped write-only would incorrectly deny it.

The neighbouring getu16_iotlb() correctly uses VHOST_MAP_RO for its
read operation, and the copydesc write path (putdesc_iotlb) correctly
uses VHOST_MAP_WO, confirming this is a copy-paste error.

Fix by changing VHOST_MAP_RO to VHOST_MAP_WO to match the write
semantics of putu16_iotlb().

Fixes: 0ea9ee430111 ("vhost/vringh: add IOTLB support")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 drivers/vhost/vringh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 9066f9f12ba1..e6ca7e0824f9 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1244,7 +1244,7 @@ static inline int putu16_iotlb(const struct vringh *vrh,
 
 	/* Atomic write is needed for putu16 */
 	ret = iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p),
-			      NULL, &ivec, VHOST_MAP_RO);
+			      NULL, &ivec, VHOST_MAP_WO);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.3 (Apple Git-145)

