Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387F831194C;
	Mon, 31 Aug 2026 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167430; cv=none; b=XJ7xk+VY7qWk+igHS2alLg31BB47uMPUF+L8WYbtMQ4iUazuHcj/c+qbY/u2GqJpd3/VAwvoDXmuV/FdNbco+hjFCYJqkZtHGlJ7J+BiNFTjj0rYFi95pqn5SBgqvLe744IdJw9ztx9j+Z6cxduOg8xNOfDj9eejmYL5INoQkf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167430; c=relaxed/simple;
	bh=IARrRNNyiTAKoF6wwICzbs9Wa28MtqXKIxPUJZ1ERvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKGehUoBKqk1V+0slYcFCecMgUAIlERXCALIeM6jxIecCO2+KiAp5jUShxlaBlOxzA3s2ICnwRU/q5WwnbipJD8nUPv/gpGlClR6V5qNuH2BorcM0CV6I9Ywcklc+LZBOvkem3F5LvyF7Z/uf/Dl2ClqxViemHQqtFq7MMhyk+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fID65l5t; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fID65l5t"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LYTsOMWil8VNbH9yTrDfh9/73Sw9jTDzZkwHDpz4ui4=;
	b=fID65l5tZ8Qh3HVzMbR/8vat7qoT2rQwOF4Dd2QvL9C47nAqf+QMzb2kDhJeSzlmCKYYUQsJ7
	yVGXKNQktB+6fwBN7Aqp5RtvLJePXDbqPVRgkKOWoW+J4SKzBqzQYb0YkGvh/m/Qp9REymJj34O
	XxiIEQwjBTueeuXXv8pvfRE=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hYNGk1w36zcb4j;
	Mon, 31 Aug 2026 16:59:42 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 42A0B40561;
	Mon, 31 Aug 2026 17:10:24 +0800 (CST)
Received: from huawei.com (10.50.163.32) by dggpemf500015.china.huawei.com
 (7.185.36.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 31 Aug
 2026 17:10:23 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v3 1/3] hisi_acc_vfio_pci: fix live migration enable conditions for PF passthrough
Date: Mon, 31 Aug 2026 17:09:49 +0800
Message-ID: <20260831090951.844569-2-liulongfang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831090951.844569-1-liulongfang@huawei.com>
References: <20260831090951.844569-1-liulongfang@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500015.china.huawei.com (7.185.36.143)

When a PF device is bound to the live migration driver in passthrough mode,
it cannot support live migration functionality, and key pointers will
remain uninitialized. Although most migration functions within the driver
are unreachable, low-level error handling callbacks may be triggered
directly, causing a crash due to null pointer dereference.
The fix involves adding validity checks at three entry points: device
probe, error handling, and migration initialization. If the pointer is
invalid, the operation is exited or rejected directly to avoid crashes,
while redundant internal checks are removed.

Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 86362ec424a5..e95d0ab0f11a 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1154,9 +1154,14 @@ static void hisi_acc_vf_pci_reset_prepare(struct pci_dev *pdev)
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
@@ -1174,8 +1179,12 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
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
@@ -1565,6 +1574,11 @@ static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
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
@@ -1670,13 +1684,11 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
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

