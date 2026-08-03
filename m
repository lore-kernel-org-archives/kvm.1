Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A7A312815;
	Mon,  3 Aug 2026 02:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723577; cv=none; b=eBZr2S0MZiEWYWVM6D5r7lEJYbUTPOE7SP/JTtJB447ZoOYX2Zjtwr5b6tRiA/92M2ZQmKK/mKQXq8Ayu+Ec1Ge9/kuegZ7Zhft5AC9gWN2RVPEujA1uJSpRUrbhTJpyHMCYPo37To51TJT6ruBCJSg1/iu9/QUro3rred2Jkk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723577; c=relaxed/simple;
	bh=OuA6CGOsm7CMrSInVHMrva857eS76tCXK72w72LlxIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KuzVz5e4K/+p9IzgKCC+7WREiGrxX+MgqENyt61GRR7bo/8amMSOIPbdGX5Q5M0bFU5eUBmSp4qrRCZgoSDkDr/jwzz486LeW/WVeBMka+3XpntvMsJFF0ZN5A+l82W6o5JPNGdanr/ZOnpVvZ09fhJcebPZ+iy+mngEFlYKsf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HecTr/le; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HecTr/le"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4lCx/AU2K8lIiIpvmuXy5ZTh43DKw1+7hFIc6Ct5Z4g=;
	b=HecTr/lewSgChRaIdxJf4kTVou3h3LekRt6X55ag/uT3G88vDUiQm1kn04dMB6RHWFYP2/xAC
	IR+LxHkPeva7oOfZ+2Ro1OnWtQ0qsEo5yThmOQfFTdaRTPGnqSJsQ3SKj1nw9frsVsQgb/5QabB
	d0dh8cqZ+8SjT2ZlSHUVMdo=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hD0Vx01yqz1cySl;
	Mon,  3 Aug 2026 10:10:01 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 810E6402AB;
	Mon,  3 Aug 2026 10:19:29 +0800 (CST)
Received: from huawei.com (10.50.163.32) by dggpemf500015.china.huawei.com
 (7.185.36.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 3 Aug
 2026 10:19:29 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH 1/2] hisi_acc_vfio_pci: fix live migration enable conditions for PF passthrough
Date: Mon, 3 Aug 2026 10:18:56 +0800
Message-ID: <20260803021857.2370179-2-liulongfang@huawei.com>
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

    In the previous implementation of live migration support for
Hisilicon accelerator devices, there was insufficient consideration
for the fact that PFs cannot support virtualization live migration.
If a user unbinds the PF device driver from the host and directly
passes it through to a VM, then attempts a live migration operation,
it will trigger a calltrace exception.

    To address this, we conducted a detailed analysis of potential
failure points. We added checks for all operations that depend on
PF driver commands and incorporated relevant conditional judgments
to prevent system calltrace exceptions when users attempt live
migration after passing PFs through to VMs.

Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 48 +++++++++++++++----
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 86362ec424a5..36490be7a61a 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -378,6 +378,11 @@ static int vf_qm_check_match(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 	if (migf->total_length < QM_MATCH_SIZE || hisi_acc_vdev->match_done)
 		return 0;
 
+	if (!pf_qm || !pf_qm->io_base) {
+		dev_err(dev, "failed to match check for PF QM migration\n");
+		return -ENODEV;
+	}
+
 	ret = vf_qm_version_check(vf_data, dev);
 	if (ret) {
 		dev_err(dev, "failed to match ACC_DEV_MAGIC\n");
@@ -423,10 +428,15 @@ static int vf_qm_get_match_data(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 				struct acc_vf_data *vf_data)
 {
 	struct hisi_qm *pf_qm = hisi_acc_vdev->pf_qm;
-	struct device *dev = &pf_qm->pdev->dev;
+	struct device *dev = &hisi_acc_vdev->vf_dev->dev;
 	int vf_id = hisi_acc_vdev->vf_id;
 	int ret;
 
+	if (!pf_qm || !pf_qm->io_base) {
+		dev_err(dev, "failed to check PF QM available!\n");
+		return -ENODEV;
+	}
+
 	vf_data->acc_magic = ACC_DEV_MAGIC_V2;
 	vf_data->major_ver = ACC_DRV_MAJOR_VER;
 	vf_data->minor_ver = ACC_DRV_MINOR_VER;
@@ -601,9 +611,14 @@ hisi_acc_check_int_state(struct hisi_acc_vf_core_device *hisi_acc_vdev)
 	struct hisi_qm *vfqm = &hisi_acc_vdev->vf_qm;
 	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
 	struct pci_dev *vf_pdev = hisi_acc_vdev->vf_dev;
-	struct device *dev = &qm->pdev->dev;
+	struct device *dev = &vf_pdev->dev;
 	u32 state;
 
+	if (!qm || !qm->io_base) {
+		dev_err(dev, "failed to interrupt state check for PF QM!\n");
+		return -ENODEV;
+	}
+
 	/* Check RAS state */
 	state = qm_check_reg_state(qm, QM_ABNORMAL_INT_STATUS);
 	if (state) {
@@ -1154,9 +1169,14 @@ static void hisi_acc_vf_pci_reset_prepare(struct pci_dev *pdev)
 {
 	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
 	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
-	struct device *dev = &qm->pdev->dev;
+	struct device *dev = &pdev->dev;
 	u32 delay = 0;
 
+	if (!qm || !qm->io_base) {
+		dev_err(dev, "PF QM not available for reset\n");
+		return;
+	}
+
 	/* All reset requests need to be queued for processing */
 	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
 		msleep(1);
@@ -1174,8 +1194,12 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
 	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
 	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
 
-	if (hisi_acc_vdev->set_reset_flag)
-		clear_bit(QM_RESETTING, &qm->misc_ctl);
+	if (hisi_acc_vdev->set_reset_flag) {
+		if (qm && qm->io_base)
+			clear_bit(QM_RESETTING, &qm->misc_ctl);
+		else
+			dev_err(&pdev->dev, "PF QM not available for reset done\n");
+	}
 
 	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
 		return;
@@ -1193,6 +1217,11 @@ static int hisi_acc_vf_qm_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
 	struct pci_dev *vf_dev = vdev->pdev;
 	u32 val;
 
+	if (!pf_qm || !pf_qm->io_base) {
+		dev_err(&vf_dev->dev, "PF QM not available for init\n");
+		return -ENODEV;
+	}
+
 	val = readl(pf_qm->io_base + QM_MIG_REGION_SEL);
 	if (pf_qm->ver > QM_HW_V3 && (val & QM_MIG_REGION_EN))
 		hisi_acc_vdev->drv_mode = HW_ACC_MIG_PF_CTRL;
@@ -1565,6 +1594,11 @@ static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
 	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
 	struct hisi_qm *pf_qm = hisi_acc_get_pf_qm(pdev);
 
+	if (!pf_qm) {
+		dev_err(&pdev->dev, "PF driver not loaded, cannot enable migration\n");
+		return -ENODEV;
+	}
+
 	hisi_acc_vdev->vf_id = pci_iov_vf_id(pdev) + 1;
 	hisi_acc_vdev->pf_qm = pf_qm;
 	hisi_acc_vdev->vf_dev = pdev;
@@ -1670,13 +1704,11 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
 	struct hisi_acc_vf_core_device *hisi_acc_vdev;
 	const struct vfio_device_ops *ops = &hisi_acc_vfio_pci_ops;
 	struct hisi_qm *pf_qm;
-	int vf_id;
 	int ret;
 
 	pf_qm = hisi_acc_get_pf_qm(pdev);
 	if (pf_qm && pf_qm->ver >= QM_HW_V3) {
-		vf_id = pci_iov_vf_id(pdev);
-		if (vf_id >= 0)
+		if (pdev->is_virtfn)
 			ops = &hisi_acc_vfio_pci_migrn_ops;
 		else
 			pci_warn(pdev, "migration support failed, continue with generic interface\n");
-- 
2.43.0

