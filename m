Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D034957C9F;
	Fri, 18 Sep 2026 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721040; cv=none; b=ofCasQF7Hqub6TeQtvrVQ3VMhy475kWoMTg1xu2/hvfYlXamS9EkSxMDhALqAHPqHCaTyi2ewBvXzkEywBB2mWBGhUlMU49q/ZkjP4WgXc5tnEwgzoQnWs14pxV4I1rQ3Vt0bx8WaX15rP3ZsjM5MN0FZqdciygYNkjPaarcLx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721040; c=relaxed/simple;
	bh=If0woU3wB/U0GPMkW/UBmPHM9mrWMkULYMmonKX54CE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ougxVD+A+inh+gbZDj9lzIhDW+qhAdo1YDfVY3eFhfeqbD5JfVr/6OSu5Z13ujVADXxwGbgBUpAAgHkuAUjcREl9OMCfu4hqutwdQjAFIrdaL6vyGxR/5NFoyGvLVKWe9iLxcFmfsOglfnAzRCX2RRA9Sv9VSgGC14mfpJIy0eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=sldqc943; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="sldqc943"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lnb1HsHPC7o9LX8c5eToyfaI+3ww1o3UsgtWogez0oY=;
	b=sldqc9435XhYZkkErI8ITZ3BKXKuMG89YSDpE7Q+IpZU3aMkDd7u+aNynGpJyLWyB+ulU0CT8
	PKEmZwwBy4KtFo/6H59LCQ6vy5eKTvagVY8+fw5A/RGnDCJpHgmeTz1r6/34K/IWgpejOXXcy+G
	HAE3YSRcGMLc+MHHi2HlZYA=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hmQqF3FVGz12LFc;
	Fri, 18 Sep 2026 16:32:41 +0800 (CST)
Received: from whupemk100014.china.huawei.com (unknown [7.152.184.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 8007420333;
	Fri, 18 Sep 2026 16:43:48 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemk100014.china.huawei.com
 (7.152.184.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 16:43:47 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v4 2/2] hisi_acc_vfio_pci: reject live migration on 64KB page with QM_HW_V3 hardware
Date: Fri, 18 Sep 2026 16:42:44 +0800
Message-ID: <20260918084244.1485837-3-liulongfang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918084244.1485837-1-liulongfang@huawei.com>
References: <20260918084244.1485837-1-liulongfang@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 8ff69c8d1ff7..1c9f5cfa5c32 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1198,13 +1198,6 @@ static int hisi_acc_vf_qm_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
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
@@ -1672,19 +1665,34 @@ static void hisi_acc_vf_debugfs_exit(struct hisi_acc_vf_core_device *hisi_acc_vd
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
 	int ret;
 
 	pf_qm = hisi_acc_get_pf_qm(pdev);
-	if (pf_qm && pf_qm->ver >= QM_HW_V3) {
-		if (pdev->is_virtfn)
-			ops = &hisi_acc_vfio_pci_migrn_ops;
+	if (pf_qm && pf_qm->ver >= QM_HW_V3 && pdev->is_virtfn) {
+		func_len = pci_resource_len(pdev, VFIO_PCI_BAR2_REGION_INDEX) >> 1;
+		drv_mode = hisi_acc_vf_get_drv_mode(pf_qm);
+		if (drv_mode == HW_ACC_MIG_VF_CTRL && func_len < PAGE_SIZE)
+			pci_warn(pdev, "migration not supported on 64KB pages with QM_HW_V3\n");
 		else
-			pci_warn(pdev, "migration support failed, continue with generic interface\n");
+			ops = &hisi_acc_vfio_pci_migrn_ops;
 	}
 
 	hisi_acc_vdev = vfio_alloc_device(hisi_acc_vf_core_device,
@@ -1692,6 +1700,8 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
 	if (IS_ERR(hisi_acc_vdev))
 		return PTR_ERR(hisi_acc_vdev);
 
+	hisi_acc_vdev->drv_mode = drv_mode;
+
 	dev_set_drvdata(&pdev->dev, &hisi_acc_vdev->core_device);
 	ret = vfio_pci_core_register_device(&hisi_acc_vdev->core_device);
 	if (ret)
-- 
2.43.0

