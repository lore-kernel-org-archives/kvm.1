Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A0B3164D6;
	Tue, 13 Oct 2026 07:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791876019; cv=none; b=U9BuQy8mmG39cUuuYBjA1pswBcI7Ao4XpSPOklsYuSZTQHsuc9SP5OXagqq5zmWShcfO4JaVx2WncI5sSdEzBIGu1mSeI928cO3hoieo6WJyhLtyyh7GG67S/+DEiRthsa3fNQRXxiDr1uwb7x4zeys42FAPIdXLe1zJR8GO6AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791876019; c=relaxed/simple;
	bh=vHq6pigAqBAOMK8BlCssoXauhb6htINPCS9bc9+IkdY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOGGTdQbTxCsKcc/Un0OGz9vMy4ZctZoozARQEeyo4JHTJhcPplZ1jVe0Lq3VFPfgW0DoVFVzckB65ZVbdc3TmZ+SjACF3hrOjqGlM0mKVo3EgI+D2NCTkGuKhU27zUxsVwke7znxzW9l82C/G963dkg7fv2PP4JKg29lBGD7fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wbCLknAX; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wbCLknAX"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WnX6NNL1P9i4EDTKZXyqBYS7whmUcGN3kZ4xLf1zOlw=;
	b=wbCLknAXLXEXc5Hc3GDGzK451YQDCrT+CLurgxaaXy1WY6EoNa9O9tVSWr1M+fxF4SPMWADuY
	OuTXCA9Qx0p/3tlH5WTeiAU91VworzWWaf+vleURwC2DUi9kUxO2RN4LTMa4aB90LwqZlZg5V1j
	uGlyh5XHLJPlIJk5rXI8Rww=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4j3llx4dBtzmV8H;
	Tue, 13 Oct 2026 15:07:57 +0800 (CST)
Received: from whupemk100014.china.huawei.com (unknown [7.152.184.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 824774056A;
	Tue, 13 Oct 2026 15:20:14 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemk100014.china.huawei.com
 (7.152.184.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 13 Oct
 2026 15:20:13 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v6 1/2] hisi_acc_vfio_pci: fix NULL dereference in reset_prepare on PF passthrough
Date: Tue, 13 Oct 2026 15:19:28 +0800
Message-ID: <20261013071929.3988687-2-liulongfang@huawei.com>
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

When a PF is bound to the driver via driver_override and passed
through to a VM, its pf_qm stays NULL. The PCI error handler
reset_prepare() runs during open_device through
pci_try_reset_function(), before the mig_ops gate, and dereferences
the NULL pf_qm for the timeout log, crashing the kernel.

Move the mig_ops check to the entry of reset_prepare() and
aer_reset_done() so non-migration devices skip the QM_RESETTING
coordination. The dev local resolved &qm->pdev->dev before the
gate, so open code it at the dev_err() call where qm is known
valid. Also clear set_reset_flag together with QM_RESETTING in
aer_reset_done(); the flag was never cleared before, so a later
timed-out reset could release a foreign lock.

Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
Fixes: a22099ed7936f ("hisi_acc_vfio_pci: fix VF reset timeout issue")
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 86362ec424a5..e6fdf4d2e581 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1154,14 +1154,16 @@ static void hisi_acc_vf_pci_reset_prepare(struct pci_dev *pdev)
 {
 	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
 	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
-	struct device *dev = &qm->pdev->dev;
 	u32 delay = 0;
 
+	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
+		return;
+
 	/* All reset requests need to be queued for processing */
 	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
 		msleep(1);
 		if (++delay > QM_RESET_WAIT_TIMEOUT) {
-			dev_err(dev, "reset prepare failed\n");
+			dev_err(&qm->pdev->dev, "reset prepare failed\n");
 			return;
 		}
 	}
@@ -1174,12 +1176,14 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
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

