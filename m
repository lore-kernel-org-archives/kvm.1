Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450666;
	b=EzabWCWfBFwhpbxlfBXEciZZNvpgnwJHncwS8OOVCZTNnROYv6UcFB5069iQrS6QZTTt
	 TdowYI2hwWH4fxGlRghMi2W7Wy6nTFJpbu3QguqOa11MzZ0u21FJQE1v5Pnt6mOEYIyPm
	 ctsmADB1ChDZhTpU/BIzFhwPn1RBXYKW1y/g6srh9M1OCyoJrVEQ7gFGxdKNf3GVhkaxt
	 aJobt2UYZem5hFCOQEYKqNaHqEEV8isTjeZsIoReBYR2pEO6HUfqWafix7CbaFvh1jvQt
	 /iyHxs1VLAynoQhUTv5T7bHFsCsUU1AKTWOzSEaBcgUmKPFivb8HmswEuPYW0nPoZ5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450666;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qKjC7MwPtb9rlXRFn/imJ4VBX67PhhjBmJbfa0X27x4=;
	b=M8QH5I9/gdD2A6o9lD5fB3fD5ogtYve1NprwHVzsSiYVCe7/AG7PccBYr3AI0SYMxET2
	 +O8DHOVkCwnlHrHyaboiJXfnnAWWynR3vNm8lEb8D0QpbTc7tpEZt7L06aN9EjuT3iMSd
	 Vwa0wB+GAk/fNFW8o8yf7faU2KVc7ZnEa1uari/1uCwz0onLzjrMnBIPyRH2yjYpXlzj8
	 MBtxlEk4Mjb2M+sZcZmUEJrJPz4o6QlCkhd26vNlk/yExwvG3OlYxqYlFJ82vxOQJH2Os
	 Eps04WRobYynn35WHUeDnt2L42oldPed5Gr6l8JSQNbSLfGkEw1UBqLW5unEKspyoAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=M+e+pkj0;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC601606A31C;
	Thu, 12 Nov 2026 02:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC601606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=M+e+pkj0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=M+e+pkj0YvA7MfhZ6JFFM3JhlxH9y6oGMQWQti7TBqjjIm+ZsjVUa77Q6zZ/Bd4RpifsDZPdRCftR
	 PtzvssBsx2pH3tOTUTx0ZhNahnWARjZi+gyQXXLBoQTokVKg5i0K/dGDP57EHtK3YZuSa4glKNbkfa
	 UThgBKg0jqPGRl6s=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af524e60ba-b8639;
	Thu, 12 Nov 2026 10:31:02 +0800 (CST)
X-RM-TRANSID:2ee16af524e60ba-b8639
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af524e3cdb-ef375;
	Thu, 12 Nov 2026 10:31:02 +0800 (CST)
X-RM-TRANSID:2ee56af524e3cdb-ef375
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: brett.creeley@amd.com
Cc: jgg@ziepe.ca,
	yishaih@nvidia.com,
	skolothumtho@nvidia.com,
	kevin.tian@intel.com,
	alex@shazbot.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] vfio/pds: Release migration files on allocation failure
Date: Thu, 12 Nov 2026 10:31:01 +0800
Message-ID: <20261112023101.118174-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pds_vfio_get_lm_file() takes an extra file reference before allocating its
backing storage. If an allocation fails, the error path drops only one
reference and frees the private data, leaving the anonymous file leaked.

Take the extra reference only after all allocations succeed. On failure,
drop the initial reference and let the file's release callback destroy the
mutex and free the private data.

OpenAI Codex assisted with analysis and patch preparation.

Fixes: bb500dbe2ac6 ("vfio/pds: Add VFIO live migration support")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/vfio/pci/pds/lm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/pds/lm.c b/drivers/vfio/pci/pds/lm.c
index 08487eab11b0..d96ec77402c0 100644
--- a/drivers/vfio/pci/pds/lm.c
+++ b/drivers/vfio/pci/pds/lm.c
@@ -37,9 +37,6 @@ pds_vfio_get_lm_file(const struct file_operations *fops, int flags, u64 size)
 	stream_open(lm_file->filep->f_inode, lm_file->filep);
 	mutex_init(&lm_file->lock);
 
-	/* prevent file from being released before we are done with it */
-	get_file(lm_file->filep);
-
 	/* Allocate memory for file pages */
 	npages = DIV_ROUND_UP_ULL(size, PAGE_SIZE);
 	pages = kmalloc_objs(*pages, npages);
@@ -73,6 +70,9 @@ pds_vfio_get_lm_file(const struct file_operations *fops, int flags, u64 size)
 	lm_file->page_mem = page_mem;
 	lm_file->alloc_size = npages * PAGE_SIZE;
 
+	/* prevent file from being released before we are done with it */
+	get_file(lm_file->filep);
+
 	return lm_file;
 
 out_free_page_mem:
@@ -81,7 +81,8 @@ pds_vfio_get_lm_file(const struct file_operations *fops, int flags, u64 size)
 	kfree(pages);
 out_put_file:
 	fput(lm_file->filep);
-	mutex_destroy(&lm_file->lock);
+	return NULL;
+
 out_free_file:
 	kfree(lm_file);
 
-- 
2.51.0



