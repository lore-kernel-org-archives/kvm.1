Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2673447044B;
	Wed, 23 Sep 2026 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151992; cv=none; b=jp21Yi6Oxp2HJFQxtVxf4eV84a6Ct1P732Cpo2nX5SLAqn84xG8+zp5+ZTuLUoUyB4xuch+6yy1R552tj6Mq//JVq2nYN6F7QcvVkUlEnL8ULLZiwthS5nqbh/wjbCgL0IZ05Hf//iFuzFbFUhwMsMSUCzhU9ca/e6UrNG4K1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151992; c=relaxed/simple;
	bh=pudnmNnNHem2+zLyWmpisJlkMI78OT1mUuHjenRZjio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+F1YMHQjk2zNpM5XVicTfCYZMWG2cOYGwnBps/fHG88VGeSFErIbR69ExX6o+NAXMQ+C0f258RdnVgTP5a93X9S5jWehDsBYk83CpMPcNWWpib3ckMsj9as0jGX0DLOHt29xxTv0ReQo2ViKY/WmYXis5X5/iILLtuuPmYXB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XB10/uTW; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XB10/uTW"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=x5xgwpgWYwx6Lo+O1meEqswvmKRH8IbYKiRzVhS9x6I=;
	b=XB10/uTW38E45b2LIwMWA/4EuXVU4tV/r43gqLKVCZl3doqUEP0N59KyRzbb/VUaZfrQaWqiV
	CojD6hzSZkINStiZupOfRJW7l+lCPq2Tm5i1nXbEDaae4gCjREvghCG/bAJ6PLrOYS+UFSMxvB0
	3ZOdkD2cry+YEajgvaBLGyU=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hqVBy0XDkz1cyq5;
	Wed, 23 Sep 2026 16:15:22 +0800 (CST)
Received: from whupemk100014.china.huawei.com (unknown [7.152.184.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 626A740586;
	Wed, 23 Sep 2026 16:26:24 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemk100014.china.huawei.com
 (7.152.184.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 23 Sep
 2026 16:26:23 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v5 1/2] hisi_acc_vfio_pci: fix NULL dereference in reset_prepare on PF passthrough
Date: Wed, 23 Sep 2026 16:25:50 +0800
Message-ID: <20260923082551.1754351-2-liulongfang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923082551.1754351-1-liulongfang@huawei.com>
References: <20260923082551.1754351-1-liulongfang@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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
timed-out reset could release a foreign lock.

Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
Fixes: a22099ed7936f ("hisi_acc_vfio_pci: fix VF reset timeout issue")
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 86362ec424a5..6a09252258b9 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1157,6 +1157,9 @@ static void hisi_acc_vf_pci_reset_prepare(struct pci_dev *pdev)
 	struct device *dev = &qm->pdev->dev;
 	u32 delay = 0;
 
+	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
+		return;
+
 	/* All reset requests need to be queued for processing */
 	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
 		msleep(1);
@@ -1174,12 +1177,14 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
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
-- 
2.43.0

