Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id ACCAE2F7EE5;
	Tue, 16 Jun 2026 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608683; cv=none; b=jUUmep2BU1ZALTmmQBt3KhfX2vIjtNbB6AWOGvpLpMJy1cUavkF2HhcNr1negPL0Itwm7xI5zItsPfc5TQs8qlw3xFDgTiZo6S5Jwe9bVlXCcHGevr3ejN9JUduYQpnWDG3W3zXMGoI64xntBtVlJkJKSJwbZo3B59uCi/+5ebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608683; c=relaxed/simple;
	bh=w7aOSUDcsoW4+9Vh7sLeCVE9kUvbkE1i9kM/ZTO+Ze0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oB/dsGFUD5oyQqWazw/pWgaY4asAKlen4K2xkq6JXfdcH7UUProK6u0rsnmMr3Udn7L2WBF9JRfZProBetHA8qXcbroz9IIpJ+m6NEPLK/C//7h4sk5tiG1LBNHbgLiNXU+9jjil0aKHhLtsri0mEO6Uncbcx4DUrlZGO/OfLrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=dMEe1NfE; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="dMEe1NfE"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Alex Williamson <alex@shazbot.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] vfio: Validate that bitmap.pgsize is a power-of-2 in vfio_iommu_type1_unmap_dma
Date: Tue, 16 Jun 2026 19:17:33 +0800
Message-ID: <20260616111733.1810-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc3.internal.baidu.com (172.31.50.47) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1781608664;
	bh=9ZfPokjQBoHGHktv2Rix6dxHDuLHHI6yRcTSd4rmg34=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=dMEe1NfEJPjmvBkEt27khLsUCjq6+kdiNRL2WG5HI4vGV5xVvLZulLkzo+FjKF6SO
	 XE7FmsUxv7/mUv8+7iCori6nwA30Lxt0pl/Dr/niQSZQeUs1cnBL3unTqJxSfdnCi8
	 RsHhqAldJeZD9hY0/TjUSmU3wZghlJvu1XAfT0QeOE9v6VZG8Yj2dvX78wnxwETD3Z
	 RFlkJ916FlxNE4NP/q+y6e4Ggr9rdAbvrxVIgC7EjkwzBVkW3DySEMhf2j0utHmN/L
	 +zvFDYaU+rZ9Z6OahaIcUUFMj2goVDVlxh9pJTUKEidkBNO1rx+iwMRHaDBKEaw1oB
	 lmI7ZQHaDkJWg==

From: Li RongQing <lirongqing@baidu.com>

In vfio_iommu_type1_unmap_dma(), the user-supplied bitmap.pgsize is
passed directly to __ffs() without sufficient validation.

If userspace passes bitmap.pgsize == 0, it triggers undefined behavior
in __ffs(), resulting in an undefined return value. Furthermore, passing
a non-power-of-2 value (e.g., 3 or 5) results in an incorrect pgshift
value. In either case, the invalid pgshift miscalculates the shifted
unmap size (unmap.size >> pgshift), which distorts the subsequent
verify_bitmap_size() validation logic and allows inconsistent user inputs
to bypass proper sanitization.

Fix this by introducing an explicit is_power_of_2() check on bitmap.pgsize
before processing. This strictly ensures the page size conforms to valid
IOMMU page size semantics while preventing any downstream arithmetic
anomalies caused by zero or non-power-of-2 inputs.

Fixes: 331e33d2960c8 ("vfio iommu: Update UNMAP_DMA ioctl to get dirty bitmap before unmap")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/vfio/vfio_iommu_type1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c8151ba..b05fde8 100644
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
-- 
2.9.4

