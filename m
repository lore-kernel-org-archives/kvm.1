Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49569314A60;
	Mon, 31 Aug 2026 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167491; cv=none; b=keosVYnN0JHkoy2EChYy29IBGuZqSMzq3aKAqK9Tu++Er3RobGtRV0Akmkf9iWxZoWwzCY2Zg6l9Gybf4Z6omHOd/8cWVcQhbaHMwXpe+92vOKR8OIs60OVAQ/a0MEQGtsdk2HKn9kdgss9/oR5oOX3If/yMNGh9FYfuu4H0DSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167491; c=relaxed/simple;
	bh=AXeX4BwH772tajBA9P5Vt2kDxJK4NLg4FEhYOK4iblY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oidd/qa5tOz78SXiJ2vhgqGISQQozHcPeGSP/HMBS5+u03xgski9SV5+VykhHxNsBfjT3d5HOVT+39gE9aftIdehEEfwFUaaL5nXDWFcItYiQsUmzLfBFwJdVWDD4FbGjRDTTdh2cdbgngl/R4GzdzyA668bNKfcHg22SFM1e2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rU9aKF5b; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rU9aKF5b"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=X0mf82n+J6jkdtZ2VBJPcRPPrydsFgzumUz3bXcAmMQ=;
	b=rU9aKF5bWqhCCUrMVlsSEPeXe6u9m9+Wf6x55C5wThG/DhBAR39q6bxXne4O644quOCbXBB3P
	XQPr4rUfCEnWoygWgoiMoZLQNkHBVG2CafAuS7LjffdmAGQrQlbJtk7krhG/4uWlXed4tR/pg+l
	EoDknNh2Pa6EjMgReTrKkc8=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hYNHn3qbgz1K9XX;
	Mon, 31 Aug 2026 17:00:37 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 71AD44056C;
	Mon, 31 Aug 2026 17:11:26 +0800 (CST)
Received: from huawei.com (10.50.163.32) by dggpemf500015.china.huawei.com
 (7.185.36.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 31 Aug
 2026 17:11:25 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v3 3/3] hisi_acc_vfio_pci: reject live migration on 64KB page with QM_HW_V3 hardware
Date: Mon, 31 Aug 2026 17:09:51 +0800
Message-ID: <20260831090951.844569-4-liulongfang@huawei.com>
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

In the scenario combining QM_HW_V3 hardware with 64KB large pages, the
device functional region and migration registers share the BAR2 physical
page, resulting in a lack of isolation that triggers security issues.
More critically, since KVM does not support the specific 16-byte read/write
instructions used by the guest driver, operating under the KVM emulated
device scheme will lead to Guest kernel calltrace issues.
To prevent Guest exceptions and avoid security vulnerabilities, the
driver directly disables live migration functionality in this scenario.
This ensures the system fails cleanly with an error early during startup,
while other configuration modes remain unaffected and can still utilize
passthrough functionality normally.

Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 4abed2e49986..4f12cab96545 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1210,6 +1210,23 @@ static int hisi_acc_vf_qm_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
 	else
 		hisi_acc_vdev->drv_mode = HW_ACC_MIG_VF_CTRL;
 
+	/*
+	 * On VF_CTRL hardware, BAR2 holds 32KB functional + 32KB
+	 * migration registers. When the host page exceeds 32KB, the
+	 * two share one physical page and cannot be isolated by mmap.
+	 * Reject the open so QEMU fails cleanly at startup.
+	 */
+	if (hisi_acc_vdev->drv_mode == HW_ACC_MIG_VF_CTRL) {
+		resource_size_t func_len =
+			pci_resource_len(vf_dev, VFIO_PCI_BAR2_REGION_INDEX) >> 1;
+
+		if (func_len < PAGE_SIZE) {
+			dev_err(&vf_dev->dev,
+				"migration not supported on 64KB pages with QM_HW_V3\n");
+			return -EINVAL;
+		}
+	}
+
 	if (hisi_acc_vdev->drv_mode == HW_ACC_MIG_PF_CTRL) {
 		/*
 		 * On hardware platforms greater than QM_HW_V3, the migration function
-- 
2.43.0

