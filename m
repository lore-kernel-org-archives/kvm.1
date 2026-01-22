Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81CC330668;
	Thu, 22 Jan 2026 02:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769047372; cv=none; b=c8vWtunQr+Q2j7v99MTzzYcBjbL1u7+RfKMv5qmBNtnK8uA8dFTYpyLsVlBca8iGqrEdGSslJ2A3/kepk3HowiC7snz25IVJCqdHOq5Ohqy/S9VCT3jpnqTxJSwO4iV4rU2lFoQ8skDUs6BkrVKN13I71jMi8gga1ezdpEnfXRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769047372; c=relaxed/simple;
	bh=3Yez/NvZXwlauKN6NjcvaE3NyiIZfdy6wPGh3mcBJ80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPDdbXfb9OS8u7y97kr2Zhh0rh3Ce8ddSrTMeFV4NmlbqMSrcVdN1jCia2w9Afhz/YHIiJOAxJFCfoUR/FSXpVxva1tqbfW2DTQ/OfiVS+rFnODGgBGtdJ9Bw5fzI6Bh9sYydKXd8NF76p0zvNNUz8yza6rkQd28R8owr5eQS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=P1ejIla0; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="P1ejIla0"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DESLk+/2MnfEhBhzIEX1R4Za2cJAYmV5Grdhor4/fBs=;
	b=P1ejIla0GN/dbKpYAEvWx18maL9n0bWP38cSeLRfYcIIovUrwikBjciIbRxilH2/D7e3zA+li
	A3oLmsXLrqtu3Fgapzbet/OB3lKtg2ZtYqrG/nl6FXBYvXsme4YbYviCI73BzTCqpftUyE1yJCc
	aD4Q/xqJBkF4gxWsv16HsaI=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dxPNw3hBZz12LGl;
	Thu, 22 Jan 2026 09:58:40 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 77D4F40539;
	Thu, 22 Jan 2026 10:02:38 +0800 (CST)
Received: from huawei.com (10.90.31.46) by dggpemf500015.china.huawei.com
 (7.185.36.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 10:02:37 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>,
	<jonathan.cameron@huawei.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v2 1/4] hisi_acc_vfio_pci: fix VF reset timeout issue
Date: Thu, 22 Jan 2026 10:02:02 +0800
Message-ID: <20260122020205.2884497-2-liulongfang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260122020205.2884497-1-liulongfang@huawei.com>
References: <20260122020205.2884497-1-liulongfang@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500015.china.huawei.com (7.185.36.143)

From: Weili Qian <qianweili@huawei.com>

If device error occurs during live migration, qemu will
reset the VF. At this time, VF reset and device reset are performed
simultaneously. The VF reset will timeout. Therefore, the QM_RESETTING
flag is used to ensure that VF reset and device reset are performed
serially.

Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 24 +++++++++++++++++++
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index cf45f6370c36..d1e8053640a9 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1188,9 +1188,32 @@ hisi_acc_vfio_pci_get_device_state(struct vfio_device *vdev,
 	return 0;
 }
 
+static void hisi_acc_vf_pci_reset_prepare(struct pci_dev *pdev)
+{
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
+	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
+	struct device *dev = &qm->pdev->dev;
+	u32 delay = 0;
+
+	/* All reset requests need to be queued for processing */
+	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
+		msleep(1);
+		if (++delay > QM_RESET_WAIT_TIMEOUT) {
+			dev_err(dev, "reset prepare failed\n");
+			return;
+		}
+	}
+
+	hisi_acc_vdev->set_reset_flag = true;
+}
+
 static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
 {
 	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
+	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
+
+	if (hisi_acc_vdev->set_reset_flag)
+		clear_bit(QM_RESETTING, &qm->misc_ctl);
 
 	if (hisi_acc_vdev->core_device.vdev.migration_flags !=
 				VFIO_MIGRATION_STOP_COPY)
@@ -1734,6 +1757,7 @@ static const struct pci_device_id hisi_acc_vfio_pci_table[] = {
 MODULE_DEVICE_TABLE(pci, hisi_acc_vfio_pci_table);
 
 static const struct pci_error_handlers hisi_acc_vf_err_handlers = {
+	.reset_prepare = hisi_acc_vf_pci_reset_prepare,
 	.reset_done = hisi_acc_vf_pci_aer_reset_done,
 	.error_detected = vfio_pci_core_aer_err_detected,
 };
diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
index cd55eba64dfb..a3d91a31e3d8 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
@@ -27,6 +27,7 @@
 
 #define ERROR_CHECK_TIMEOUT		100
 #define CHECK_DELAY_TIME		100
+#define QM_RESET_WAIT_TIMEOUT  60000
 
 #define QM_SQC_VFT_BASE_SHIFT_V2	28
 #define QM_SQC_VFT_BASE_MASK_V2		GENMASK(15, 0)
@@ -128,6 +129,7 @@ struct hisi_acc_vf_migration_file {
 struct hisi_acc_vf_core_device {
 	struct vfio_pci_core_device core_device;
 	u8 match_done;
+	bool set_reset_flag;
 	/*
 	 * io_base is only valid when dev_opened is true,
 	 * which is protected by open_mutex.
-- 
2.33.0

