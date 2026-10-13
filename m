Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1944237E5EC;
	Tue, 13 Oct 2026 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791876053; cv=none; b=PNakQQCZqiR+3TB60lmyI/qF66yb26In1eU+lBFDx8rJAq4zmeNGCd1OvvToNgAIRDp92Iaal8gy1ntQvUTZJtRpqBR4uSxPN+1UgBW7ms5rOGx3OKPRT7AIFlVAbLbuyNFtRI+NZkMzqi7agfyykuZX3BqLal+xFV1NRv3RAvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791876053; c=relaxed/simple;
	bh=8ruDrG+7kblQv4lEuAMqrKGPI8cdAOGgFsd8qtmamyk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UO8Q/CGUl8HT/AaoyzWsW+9RKaJdkVkpcHGwepsifZsJN41cr39kpPNdidzpvwd996k0rS9/zDBqN4i2mKYrYvuIDMO+XARSQ3oUTr1tdJAMVN3c8MKa+GzARtsxDy1LI0spjBwjAps0GNfXNhkq7se3wvcoFKzokvQV1pVlxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1bPKAiZO; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1bPKAiZO"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bQTKbkQaInLeC4sRW42x65VDz7oCWXwEaQmK5R5AmlQ=;
	b=1bPKAiZOkgGAECHcWr14IPZZGIm+ZyLZZ8lbAITUekWLnsdVyZMf4Wc34hr9JNGccznlqXdYr
	exd0bQuRAWoodJQFqogzgNzvCcmmBsuGF2Z+OLVTAmi3Z+m3A1eKWSg0jdU6zY470tpUDf/l23P
	QNVGFSiWl9MfRVrtvu+1mY0=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4j3lmz0rm1z12LF9;
	Tue, 13 Oct 2026 15:08:51 +0800 (CST)
Received: from whupemk100014.china.huawei.com (unknown [7.152.184.20])
	by mail.maildlp.com (Postfix) with ESMTPS id BE5DF4057F;
	Tue, 13 Oct 2026 15:20:45 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemk100014.china.huawei.com
 (7.152.184.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 13 Oct
 2026 15:20:44 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v6 2/2] hisi_acc_vfio_pci: reject live migration on 64KB page with QM_HW_V3 hardware
Date: Tue, 13 Oct 2026 15:19:29 +0800
Message-ID: <20261013071929.3988687-3-liulongfang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013071929.3988687-1-liulongfang@huawei.com>
References: <20261013071929.3988687-1-liulongfang@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk100014.china.huawei.com (7.152.184.20)

On QM_HW_V3 (VF_CTRL mode) hardware with 64KB pages, the functional
region and migration registers share one BAR2 physical page with no
isolation, which leaks migration registers to the guest and causes
guest kernel calltrace under the KVM emulated device scheme.

The previous fix rejected the device in hisi_acc_vf_qm_init() during
open_device, returning -EINVAL and breaking passthrough entirely.
Move the drv_mode check into a helper called from probe() so that a
VF_CTRL device on a 64KB page is bound to the generic ops, keeping
passthrough working while disabling live migration.

Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 32 ++++++++++++-------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index e6fdf4d2e581..818ad5112d7b 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1195,13 +1195,6 @@ static int hisi_acc_vf_qm_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
 	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
 	struct hisi_qm *pf_qm = hisi_acc_vdev->pf_qm;
 	struct pci_dev *vf_dev = vdev->pdev;
-	u32 val;
-
-	val = readl(pf_qm->io_base + QM_MIG_REGION_SEL);
-	if (pf_qm->ver > QM_HW_V3 && (val & QM_MIG_REGION_EN))
-		hisi_acc_vdev->drv_mode = HW_ACC_MIG_PF_CTRL;
-	else
-		hisi_acc_vdev->drv_mode = HW_ACC_MIG_VF_CTRL;
 
 	if (hisi_acc_vdev->drv_mode == HW_ACC_MIG_PF_CTRL) {
 		/*
@@ -1669,21 +1662,34 @@ static void hisi_acc_vf_debugfs_exit(struct hisi_acc_vf_core_device *hisi_acc_vd
 	hisi_acc_vdev->debug_migf = NULL;
 }
 
+static enum hw_drv_mode hisi_acc_vf_get_drv_mode(struct hisi_qm *pf_qm)
+{
+	u32 val;
+
+	val = readl(pf_qm->io_base + QM_MIG_REGION_SEL);
+	if (pf_qm->ver > QM_HW_V3 && (val & QM_MIG_REGION_EN))
+		return HW_ACC_MIG_PF_CTRL;
+
+	return HW_ACC_MIG_VF_CTRL;
+}
+
 static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct hisi_acc_vf_core_device *hisi_acc_vdev;
 	const struct vfio_device_ops *ops = &hisi_acc_vfio_pci_ops;
+	enum hw_drv_mode drv_mode = HW_ACC_MIG_VF_CTRL;
+	resource_size_t func_len;
 	struct hisi_qm *pf_qm;
-	int vf_id;
 	int ret;
 
 	pf_qm = hisi_acc_get_pf_qm(pdev);
 	if (pf_qm && pf_qm->ver >= QM_HW_V3) {
-		vf_id = pci_iov_vf_id(pdev);
-		if (vf_id >= 0)
-			ops = &hisi_acc_vfio_pci_migrn_ops;
+		func_len = pci_resource_len(pdev, VFIO_PCI_BAR2_REGION_INDEX) >> 1;
+		drv_mode = hisi_acc_vf_get_drv_mode(pf_qm);
+		if (drv_mode == HW_ACC_MIG_VF_CTRL && func_len < PAGE_SIZE)
+			pci_warn(pdev, "migration not supported on 64KB pages with QM_HW_V3\n");
 		else
-			pci_warn(pdev, "migration support failed, continue with generic interface\n");
+			ops = &hisi_acc_vfio_pci_migrn_ops;
 	}
 
 	hisi_acc_vdev = vfio_alloc_device(hisi_acc_vf_core_device,
@@ -1691,6 +1697,8 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
 	if (IS_ERR(hisi_acc_vdev))
 		return PTR_ERR(hisi_acc_vdev);
 
+	hisi_acc_vdev->drv_mode = drv_mode;
+
 	dev_set_drvdata(&pdev->dev, &hisi_acc_vdev->core_device);
 	ret = vfio_pci_core_register_device(&hisi_acc_vdev->core_device);
 	if (ret)
-- 
2.43.0

