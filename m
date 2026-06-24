Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F43339861
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328337; cv=none; b=qhUJMJiIRTC3LceN176wnS5MLZhC/owV1dVZFyco8fUI6XLuF/FxdxuK/E2opk0JkcuI8BI3mxYWe07/sEBlhG8/+KqdHy/fEmTUIStz1y20ndyfVj+T9KyheyKgoTEPBquL+3tlW2qw9q5Aw0m/59/Ti/AtQK+yjZDQa6dE6HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328337; c=relaxed/simple;
	bh=4YrFRigel65Gt+dh4luOyWozRezA4Dk8/7Gn8IJG0Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HP8gnlq3Z8j56hTW9jv2EblmrjFnVipDdA/+hU6g4SOkSLuwf9PVl9sGEfI9R+/ESTZMALFkpssx2muxaFqt4Byb/dLWXq/N8tm8d4dVa0eEWH1MND7ean9NzPCcJ1ZACo1b8NRfAoTWJOlGmH9siXGQn18SudngItY6zuUKg9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqIc1cSm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqIc1cSm"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so14561105e9.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 12:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782328334; x=1782933134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YSVjzRBmQFYwfQSkxHVzN7pkPCZVpx+D6sU3JXp6ZaA=;
        b=kqIc1cSmlPkimjZjTN3mhIA53hn75u9NypqoCCuhAuwqDQurPdpqvCSgsR7VWpLVtO
         9330A4sex4B9xng1kgVytxG5LEOVxlVCJmDgBmLhKQnUlqrkAEBchCB6jayYDtTnlqO7
         JJNe1Px7xMKaro/l+Tty+QgBeBd+WQKK7pxg/f50nyYKVG3GUS6SbNP880XoluTLgcm2
         zHLR4LLWENna4QdT9+CU3YApjuEpzLnLVPsQ3GQug2vQjUyxE/uzCD1TTAqHZHkdP0xO
         HZlO8cpJqd/nIOJnVRdkviJkjIYqrShKW5ZECskrYDdCN40TR7gNnBSUMZ72xHOzrWXm
         nNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782328334; x=1782933134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSVjzRBmQFYwfQSkxHVzN7pkPCZVpx+D6sU3JXp6ZaA=;
        b=HxWnugYn5SMmjiaGOAqfF724SBueXwSFtQ5R6yFSk9XNxO3cX3ZTRR+bGzyZFH3MEx
         cItR2GiT1E0Syr51+cKwfPax008n7HCUuIJFwj7B+3PUtmqg1YDoOb1Jbs8yS2VkRciB
         THM2Ral5vCGw/vmL/V6GM666nQZqgLy3BNdw3zrs3wiEbFTIMEH7aqUFeymdSvh2smDY
         l20mQhJSDZO2/IoPLlOrVKsTOK3zfkOIVxUSQaWM/4iJ2cQPLdIO4wyI6XFAZIZhPjua
         mbrdM2dDQzk0t774nVQ/g91fv5pOQ31mfyMPziCSukZB0TieIeh62B+AAp3xy79haKU7
         Hjuw==
X-Gm-Message-State: AOJu0Yy7CKboAsed6t3K9kG8R88G6b7idqIE9uQEeSNd5m4czk5te5Qa
	Cclq7+s/jvYwwGWKo7gtQwYDgmoM+reF3+A6+x2KQnvzrClLbDR1Mr6KHMQqLItjUhbyeA==
X-Gm-Gg: AfdE7cmsf28PdKi2H94gZerV1gByUtzwa5zh5dKxaLSKIJ060Yi+YO+usaKIVUQRMDQ
	/ySwrGPn3cylbE8KICMQ/LzqRvljsAewwP+FjpbEJNyYqFvTt65E/Tk+7ZcJ+Jpb21SGnAejRbI
	U6Sa/YFY4bOK4oe+xlBfSJelVLDoVlvhwpebwWug1JMR2wQ06b6fO1Tv5DiGFvSXb6qwk/eUkrc
	aK92TM+rDV9R3HzmyNEBq8tatKBr9yMWB2KmPCjSKG6y4rhS0wo+e/iRP86QwRneypQdqyJVV/A
	elLKlWnlfxBho5JfaGDUrZ/+hefoLA3nCuF5the/qcFeROsrD9EINMIrdkLch4NIBiZILs1g1u5
	2FMpzLZJsNjv7Q6pl1koWULkYjbcX7LzD6AYqY4zu4LGOCVKbStOGl5psM/wk/8H35gbLxZXoRD
	se6Pzr6bxp0ap03dtpBp//VLvRxw==
X-Received: by 2002:a05:600c:1c25:b0:492:488c:f627 with SMTP id 5b1f17b1804b1-4925b359bc7mr139631375e9.11.1782328334427;
        Wed, 24 Jun 2026 12:12:14 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492640260a6sm12341355e9.6.2026.06.24.12.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:12:14 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] vfio/type1: validate dirty bitmap page size before use
Date: Wed, 24 Jun 2026 21:12:04 +0200
Message-ID: <20260624191204.3774-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dirty bitmap ioctl paths derive a shift with __ffs() from the
userspace supplied bitmap page size before comparing it with the IOMMU
page size. A zero page size has undefined behavior, and a non-power-of-2
value makes the bitmap size check use a different granularity than the
page size later accepted by the ioctl.

Reject invalid bitmap page sizes before using them in shift arithmetic.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/vfio/vfio_iommu_type1.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c8151ba54..9499381d0 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -26,6 +26,7 @@
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/iommu.h>
+#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/kthread.h>
@@ -2949,6 +2950,9 @@ static int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
 		if (!access_ok((void __user *)bitmap.data, bitmap.size))
 			return -EINVAL;
 
+		if (!is_power_of_2(bitmap.pgsize))
+			return -EINVAL;
+
 		pgshift = __ffs(bitmap.pgsize);
 		ret = verify_bitmap_size(unmap.size >> pgshift,
 					 bitmap.size);
@@ -3039,6 +3043,9 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 			       range.bitmap.size))
 			return -EINVAL;
 
+		if (!is_power_of_2(range.bitmap.pgsize))
+			return -EINVAL;
+
 		pgshift = __ffs(range.bitmap.pgsize);
 		ret = verify_bitmap_size(size >> pgshift,
 					 range.bitmap.size);
-- 
2.54.0

