Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67113A1690;
	Mon, 24 Aug 2026 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560205; cv=none; b=r7mO/K2BOo203Uw+uc85gGqpNjsW9IrH7Cvarqo+/mdl7CXxjrOHeMcAVVo51GQoa2SHWTz6qPvXDv0JfKlnQ8tLUrcP6tlX0Hzr+fNH6PprzcL6iMl6gaEAR6qw0FOcLAC2Qz3H28a9/JCAoCL32oNLmoZiD2y/feJpPB/W4TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560205; c=relaxed/simple;
	bh=V+zVqgBW+5YHXH+lVtisbOOKy4bNL5t/TJOq9NXERYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=maEJZ178UuVEC5TiWGK0VJTTkBBf+6Tq43qp0L9S5tc7uPHGDkFomlvGn5dPoSD1wmzjZeE8KyN4U3ouL3SbIqwjXpL+XbXp0HMuEqt83MdEgg/ju9Q/f+mp5MgY021anO+VmFnjKMlZc76aLG0Im+10ToLo6mYwj5mHIKwvHc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WrcQPYdu; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WrcQPYdu"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WnyD1w0MzGk6U19nu+YUYowWjy0UsFHj2ZyWdRSEcXI=;
	b=WrcQPYduyidanR9tKkUJpjk/n4+L9oe+vqBCYKNsH1xx9pyRHgq4Sx+bwzTUA/EnUAnhzz+dL
	gyCZ8RDDsJlSo31Z0SARMNxpuRRG/wcSjjLcgkzLfx2JYYTGHHnbVz5tdtem2b6QAcCDlNodMaj
	jdE11QSxhNhNDDKKEQ9Zw6A=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hT3jB2Ywlz1K9CV;
	Mon, 24 Aug 2026 16:19:10 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id DB4D240578;
	Mon, 24 Aug 2026 16:29:54 +0800 (CST)
Received: from huawei.com (10.50.163.32) by dggpemf500015.china.huawei.com
 (7.185.36.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 24 Aug
 2026 16:29:54 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v2 2/2] hisi_acc_vfio_pci: reject live migration on 64KB page with QM_HW_V3 hardware
Date: Mon, 24 Aug 2026 16:28:51 +0800
Message-ID: <20260824082851.1436129-3-liulongfang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824082851.1436129-1-liulongfang@huawei.com>
References: <20260824082851.1436129-1-liulongfang@huawei.com>
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
index e95d0ab0f11a..4e845474fa90 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1208,6 +1208,23 @@ static int hisi_acc_vf_qm_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
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

