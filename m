Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9B13126B9;
	Mon,  3 Aug 2026 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723613; cv=none; b=qUrlD7PQ+z7l5fYOGlCoRznt4iXz+bCt95pVI55I3IEuEX4V6tgPG2dhQDMDyvJqnz+hYCwZRYlDz3Gr/FDEbP/TgfV5fe1bLBVaSoX19SaB3H2c5EeVw7J0oABI4HbeZ7EI1rNn97sxOrMteT8/u56Nnz7SgunkpgEAzdI8OYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723613; c=relaxed/simple;
	bh=plr2sLaORL0evL1/zkWyfBcheeh7c7N1Cy9mDTPJENE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cL+jHx9s1eEYc4ocdZQJ4ik0x+82++dw6AWDyiZuaLEQtvq0j7adMTKpuv9UrDwuPoCxCK3c5IPGxB4PytB1IzYrHjePCxp5CdRSrzm2iSYvK1oWHjF5B+ue443Q6TPw4wFSV4pLOGRN3KwsUQ+9DlFaGKgBWAnKMtCDIZkNsTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LeojY92n; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LeojY92n"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1KJ1V0q32HSR285luoF6bGzZESOmfnh+OyNwaAio0Ls=;
	b=LeojY92nNSymfkbAKpV3LmvXxLMy8pNhIj9mM92SQjXBNtRLDPwmWKppL0USen2lu4099Rou6
	y5d0qK9EmfllDZTHshiewBsJ+S+cve1NZSr2Tme/AHG0Jr12lZ0oMlE+6E0Jr1ULlNMjoqir1Mw
	0Xgth2IeG/3gdNl0Pk5yi8M=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hD0WV4XBZzLlX5;
	Mon,  3 Aug 2026 10:10:30 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FD3B4057A;
	Mon,  3 Aug 2026 10:20:00 +0800 (CST)
Received: from huawei.com (10.50.163.32) by dggpemf500015.china.huawei.com
 (7.185.36.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 3 Aug
 2026 10:20:00 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH 2/2] hisi_acc_vfio_pci: fix VF BAR2 mmap on 64KB page size
Date: Mon, 3 Aug 2026 10:18:57 +0800
Message-ID: <20260803021857.2370179-3-liulongfang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803021857.2370179-1-liulongfang@huawei.com>
References: <20260803021857.2370179-1-liulongfang@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500015.china.huawei.com (7.185.36.143)

    On HW_ACC_MIG_VF_CTRL hardware, VF BAR2 is split into functional
and migration register regions. When kernel page size exceeds the
functional region size (e.g. 64KB pages vs 32KB functional region),
guest mmap operations get rounded up to page size, causing the VMA
to exceed functional boundaries and fail validation.
    The solution aligns mmap boundaries to page size while maintaining
byte-granularity access control through hisi_acc_pci_rw_access_check()
for read/write operations and accurate region size reporting via
hisi_acc_vfio_ioctl_get_region(), ensuring migration registers remain
protected from non-mmap access while resolving compatibility issues.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 36490be7a61a..44b3e7d8fef5 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1355,14 +1355,21 @@ static int hisi_acc_vfio_pci_mmap(struct vfio_device *core_vdev,
 	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
 	if (index == VFIO_PCI_BAR2_REGION_INDEX) {
 		u64 req_len, pgoff, req_start;
-		resource_size_t end;
+		resource_size_t end, dev_len;
 
-		end = hisi_acc_get_resource_len(vdev, index);
+		dev_len = hisi_acc_get_resource_len(vdev, index);
 		req_len = vma->vm_end - vma->vm_start;
 		pgoff = vma->vm_pgoff &
 			((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
 		req_start = pgoff << PAGE_SHIFT;
-
+		/*
+		 * The BAR2 functional region (dev_len) may be smaller than the
+		 * kernel page size. Align it to PAGE_SIZE so a page-rounded
+		 * guest mmap is not rejected, which would make the VF unusable.
+		 * The read/write path still truncates at the real functional
+		 * boundary, keeping the migration registers inaccessible.
+		 */
+		end = PAGE_ALIGN(dev_len);
 		if (req_start + req_len > end)
 			return -EINVAL;
 	}
-- 
2.43.0

