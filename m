Received: from outbound.baidu.com (mx14.baidu.com [220.181.3.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 5D4672E7387;
	Wed, 17 Jun 2026 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695991; cv=none; b=JVjeX/FfYrjuhe18Q4vpbm4pUNtDZ9uclGjQlP28qHuq1UFuinqTHTNr4ysLGFNrUx2eWJprpCRBJd5fW95nx8TAgDm0zgPSt8LZVqR0Z8o/Hw2SAx+Zp38DnWb8Z/P7JxA2T6+blT66ayXe9lBcVV7B3MhdE3y0Hu9dIKUnk8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695991; c=relaxed/simple;
	bh=7gFn5gTd/ypZzmTpYtNuU8f4ur6eWiWCmOG2QsJNcis=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EJVnASUWkjR6JGbwNXVIDl1jkMA9yMezYbzToSbWB4Ewh7l+KWA8r5Auy18/asMTN9HEvsqkfu6Ug0tVlY5cEtHAfSu/rp8Tf1LUTTjyrM3Y1mwVUxoQ6h77ch1Pp/FoPLNWdqCav4w2riBQKIbWzFz5YVmkXWO4LNISDe5X6c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=HdQCa2rv; arc=none smtp.client-ip=220.181.3.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="HdQCa2rv"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Alex Williamson <alex@shazbot.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v2] vfio/type1: Sanitize user-supplied inputs to prevent undefined __ffs() behavior
Date: Wed, 17 Jun 2026 19:32:51 +0800
Message-ID: <20260617113251.2535-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc11.internal.baidu.com (172.31.3.21) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1781695980;
	bh=9agGyD/kq2iviiLlwr0fRUojB9oAGvNxSuQHmCeq2bs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=HdQCa2rvoaNOr2pYYVgFqOMq30b4WhlMxTclFiQL+LCM6wf3WrBa3HSEytj7fxjM2
	 KfZ1kfGgxSB7QVJIkldEmeX+LHHxGPvtepVrvTR8u6hNCgdcZW/RNcvtHtVTljW/M+
	 IFtSLfBfGlec09wSk64gRp6MRIV07uk4EIq8qHxmvubGxbNKx5GY2CYkWtrCYPGsR5
	 pU6QElGKDLOsNpFjAjNMymsua+EfxqJTiBaY/tq2E+NsXtKbAQSVuj7VDJ+w1DBEo4
	 J73cH9bBf/Rk6kmWKWcJrC4qSsn16bEB2YmKja4xYqhUUE5BqTlTHTdnBWwpMtmhqx
	 7lo776vbE2lNg==

From: Li RongQing <lirongqing@baidu.com>

The __ffs() function expects a non-zero input. When passed 0, its return
value is undefined (garbage) but does not trigger a hardware fault.
Although downstream logic may eventually catch invalid derived values,
passing unchecked user inputs into __ffs() is a robust-ness and code
quality issue.

Fix this by validating user-supplied inputs early in the UNMAP_DMA and
DIRTY_PAGES ioctl paths before they reach any bit scan operations:

1. Reject an empty dirty.flags in vfio_iommu_type1_dirty_pages() to
   ensure the subsequent __ffs() / __fls() single-bit check is safe.
2. Ensure bitmap.pgsize and range.bitmap.pgsize are valid non-zero
   powers of two before calculating pgshift via __ffs().

This change improves the overall robustness of the VFIO type1 IOMMU
driver against erratic or malicious user-space inputs.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v1: Add the two check in vfio_iommu_type1_dirty_pages
              and rewrite the commit message

 drivers/vfio/vfio_iommu_type1.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c8151ba..b74f56c 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -38,6 +38,7 @@
 #include <linux/workqueue.h>
 #include <linux/mm_inline.h>
 #include <linux/overflow.h>
+#include <linux/log2.h>
 #include "vfio.h"
 
 #define DRIVER_VERSION  "0.2"
@@ -2949,6 +2950,9 @@ static int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
 		if (!access_ok((void __user *)bitmap.data, bitmap.size))
 			return -EINVAL;
 
+		if (unlikely(!is_power_of_2(bitmap.pgsize)))
+			return -EINVAL;
+
 		pgshift = __ffs(bitmap.pgsize);
 		ret = verify_bitmap_size(unmap.size >> pgshift,
 					 bitmap.size);
@@ -2985,6 +2989,9 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 	if (dirty.argsz < minsz || dirty.flags & ~mask)
 		return -EINVAL;
 
+	if (!dirty.flags)
+		return -EINVAL;
+
 	/* only one flag should be set at a time */
 	if (__ffs(dirty.flags) != __fls(dirty.flags))
 		return -EINVAL;
@@ -3039,6 +3046,9 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 			       range.bitmap.size))
 			return -EINVAL;
 
+		if (unlikely(!is_power_of_2(range.bitmap.pgsize)))
+			return -EINVAL;
+
 		pgshift = __ffs(range.bitmap.pgsize);
 		ret = verify_bitmap_size(size >> pgshift,
 					 range.bitmap.size);
-- 
2.9.4

