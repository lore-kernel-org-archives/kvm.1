Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C149A3AB;
	Fri, 18 Sep 2026 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721006; cv=none; b=cRIIKps21M0V4BEgxmhRVm9Bi5gPcadWcUKtxwoePRZhWV4DE1dRLB6my1RYE3+q6NpsCBY8sYMM9BpVOHZrdlyNTJQCfcmYg9j40oyHcbFLBwZ9EVS7p1/K+YCwtJ0DQGILMzH+XLSo5NdgPXP34u1fn6qB7StIy9H4+iTxOtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721006; c=relaxed/simple;
	bh=EY8K/VzeOI3yuxlBnPBiEIl1h5qybRiUtB8bGEOUjaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZOcgAkp6ZT3fcUpPFm8BkoEIJnlTam8D6Y1ayTxMMYpFb1n3nDB+f88m4UBvBoMGuaNTRxHnkOhYQHdlgEGvd7vk50zmY1IDuPYVGpmOvtQ4+vLCxKkUeZETAHabgoanlH2JB2iKO7I36SVwS6sqg2OFZvPw/buVYcecE89g7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KYpuxGPW; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KYpuxGPW"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=foFuPJGFKDj9ITO6MPchpecWpxif5LDmm96lzrsIlUk=;
	b=KYpuxGPWPDfqI8xEunzxseA1IFG1YGy8aHOf1ghHOn83hRV9fQKxCxhjBfEqHEld2vKENXZDH
	7LsCjVyB+eWRhD19Xko1GR/X0+1QNiQIfpGr33YPpaxMm7snuXI5nk1k6z7YHnWjGTbeVMok59y
	8Esoh+DVR4Pa2DBH8RNRvFk=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hmQpq6j8rzRhQs;
	Fri, 18 Sep 2026 16:32:19 +0800 (CST)
Received: from whupemk100014.china.huawei.com (unknown [7.152.184.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 52BDF4056D;
	Fri, 18 Sep 2026 16:43:17 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemk100014.china.huawei.com
 (7.152.184.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 16:43:16 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v4 1/2] hisi_acc_vfio_pci: fix NULL dereference in reset_prepare on PF passthrough
Date: Fri, 18 Sep 2026 16:42:43 +0800
Message-ID: <20260918084244.1485837-2-liulongfang@huawei.com>
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

When a PF is bound to the driver via driver_override and passed
through to a VM, its pf_qm stays NULL. The PCI error handler
reset_prepare() runs during open_device through
pci_try_reset_function(), before the mig_ops gate, and dereferences
the NULL pf_qm for the timeout log, crashing the kernel.

Move the mig_ops check to the entry of reset_prepare() and
aer_reset_done() so non-migration devices skip the QM_RESETTING
coordination. Also clear set_reset_flag together with QM_RESETTING
in aer_reset_done(); the flag was never cleared before, so a later
timed-out reset could release a foreign lock. Replace
pci_iov_vf_id() >= 0 with pdev->is_virtfn in probe() for clearer
on-VF gating.

Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
Fixes: a22099ed7936f ("hisi_acc_vfio_pci: fix VF reset timeout issue")
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 86362ec424a5..8ff69c8d1ff7 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1154,9 +1154,14 @@ static void hisi_acc_vf_pci_reset_prepare(struct pci_dev *pdev)
 {
 	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
 	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
-	struct device *dev = &qm->pdev->dev;
+	struct device *dev = &pdev->dev;
 	u32 delay = 0;
 
+	if (!hisi_acc_vdev->core_device.vdev.mig_ops) {
+		dev_err(dev, "device not support migration\n");
+		return;
+	}
+
 	/* All reset requests need to be queued for processing */
 	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
 		msleep(1);
@@ -1174,12 +1179,14 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
 	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
 	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
 
-	if (hisi_acc_vdev->set_reset_flag)
-		clear_bit(QM_RESETTING, &qm->misc_ctl);
-
 	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
 		return;
 
+	if (hisi_acc_vdev->set_reset_flag) {
+		clear_bit(QM_RESETTING, &qm->misc_ctl);
+		hisi_acc_vdev->set_reset_flag = false;
+	}
+
 	mutex_lock(&hisi_acc_vdev->state_mutex);
 	hisi_acc_vf_reset(hisi_acc_vdev);
 	mutex_unlock(&hisi_acc_vdev->state_mutex);
@@ -1670,13 +1677,11 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
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

