Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70B0282F1E;
	Wed, 30 Sep 2026 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779082; cv=fail; b=fZU6sKP0rP7IWp7hJmUVYVGoon5AWK9FXA94ElgYtNHtNTgfEr3bcfAOXQemIe9AMrrAQd5GCmlzh3bhVlPzGvsNKMNYKNsY1RAXb63tcVsLqFi62YIRszLlwH5yUl4d2RGqITNicHfPd/ASn0R4gRUXzh+FBQnlpXTUPen8g98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779082; c=relaxed/simple;
	bh=Mq6FV6OJdODgdz0XYKhZnvpn9GTA+pSCotY7uHdG7So=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtZeTJah5tiM7XkkDqNIkrOfKcXMxmCg/Jq2dKRylSbTFCF/utcpMnjQkJOmUxPFAu0hq2zOQnmB7Yzm8MzyOHbkOqybJscSCU7tovnJtoCj2wb5TxDGQSQKA063mX83uPmCBilP2NpWHAb20uZ3o1l/cSsmlpKAC6/1j8r2Y3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ceZmJbL9; arc=fail smtp.client-ip=40.93.198.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ceZmJbL9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArmPI/qZx/cYU4YWElDU59hrj6rgwExbUmLMnXi2VGSoUjFGX5Q5zqvGuGxGqijb/PXwZzdU11HBsYAK/UqkMvlOqOSLSqPwtnCkcDm7+QDu8cvDQMDd2E4QowcFuSpxt3HKAozZitHCF50x/j4BF9aNqUwOmf0RL+NftAeQenEddKeNUu3OZlQShJJKj0c/tEFoi2pflSh9gyrBnNt6v2ywnp5I1VEuJxM4faq535BjpuBqAY64oTG8GbjVuJJtm+dswCu5GYlgeLm/tGKA92xC1hd+zRTjFNXX7gKZguTJO+YUY9QFWYovmZbQoBOGCKUcUBCKnejXDKRQvZxizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5DRD1uqIrhsrZJMyXlAjcmAYk9FdNH6NGRFv11xq4k=;
 b=gi6iiqNYr7/o2KDKmkvjzfAmULiYOPmT+mv6NNX2i9prUCAKtPKkXGgGUK2rtfxltIPGaPxPM951IbsWF1HBQOKNfz+iH1Az5OY12a4YKYg8ClqfqI0XdyPLM5/Hz+NmTeN79+pSLAtZgNhhuBPLhSCwiQ76D6KIbZ3PusmtjV0/Em6pDipDp+lI1VjW6mDASBAoVtyn8MafEQ8ExALljqWJbowt8PbjVn4leSKJnN8GCv5Qk8VN5Keh7wo899FKy/zRcDchonP8yGrT1AtHZSm+ZZ3eLJnLrPWkq5ZPHizrWEVTCiJGP4TpVnJ/L6+4Z/gJq1mrZxNtVMcWhqTktQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5DRD1uqIrhsrZJMyXlAjcmAYk9FdNH6NGRFv11xq4k=;
 b=ceZmJbL900lU+27MGNz/wkpeb2gpzzeY8ZG2Bem+jkPKzgL9bDe/eTxD/kuYa/uoWXT/YysGmhpd92wOWYkL32VHrEnqTV2GGSecmgeCDhmvxJVpLX53LuGff4Y12i5ob55Y+BgCzF8Nfd7xhvC0pEfrycYSuJkAWsbv7VhXMu8k+/FRTRDfRErOQ64+cDBB+02tqlDPC5UBmlnFv5No+9DVXQR9PaDqTleJjYk8DZhoDIbLHJcVD/AfZG8cLzbGE/n5vZ8+zXZcqU+LRNVOIFWSiugYr4Xpf0zVJWJM6KoLPug0vKhE9tk4I3P7m0b1eN3/4Xk6S2AWpYOqtE5jhg==
Received: from BL1P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::13)
 by CH1PPF4CBE7339A.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 14:37:37 +0000
Received: from BN6PEPF0000006F.namprd03.prod.outlook.com
 (2603:10b6:208:2c4:cafe::27) by BL1P223CA0008.outlook.office365.com
 (2603:10b6:208:2c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 14:37:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN6PEPF0000006F.mail.protection.outlook.com (10.167.248.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:37:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 07:37:05 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 07:37:03 -0700
From: Simon Song <xinmengs@nvidia.com>
To: <alex@shazbot.org>, <jgg@nvidia.com>
CC: <dakr@kernel.org>, <acourbot@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <jhubbard@nvidia.com>,
	<ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <zhiwang@kernel.org>,
	<zhiw@nvidia.com>, Simon Song <xinmengs@nvidia.com>, Alex Williamson
	<alex.williamson@nvidia.com>
Subject: [PATCH v2 1/1] vfio/pci: Remove the core dependency on driver data
Date: Wed, 30 Sep 2026 07:36:41 -0700
Message-ID: <20260930143641.4160785-2-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260930143641.4160785-1-xinmengs@nvidia.com>
References: <20260930143641.4160785-1-xinmengs@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF0000006F:EE_|CH1PPF4CBE7339A:EE_
X-MS-Office365-Filtering-Correlation-Id: 097adc71-0785-4452-ec8c-08df1f005f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|13003099007|18002099003|22082099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ruRvJeJbAl2PwDxaEDbCtXgyfJak6z/fPcq5LBHcs/6Sq5xxNd69kV30wDKFNwyb87Yc6+G0NCFgCxQUSZ/KJIW8zmP5o9Z0p7+PKOrV5VXuKnEZxYjHaWIAQGlOcND9eKrDC38jt5qguQ0cmW/FYTUJN9Kvhaqfr3eVWauZGh4yeY87AV9KCOJ3nIZj7CIFf5HC2egasLmeN87lI3eh3MMHNH/yshVOUSIT2V+dpM4r5WMfwln4omrHq1lfiIw4wbJHlYDP77Z0ltqprUEgFS2oUTaz/ntD1eA+vGZhSdPR9qBqeoeIy++1BJBfLxtZAfAk2k5rlVatKWG73BU4vRQKkuNI+zTgxk3C5r7FoS1Z17wjDEFlZ2sAYbo2TcKboDIO5A2yLcKAS5D1/gZvfjiecRQaPvCZmZlnaueRIcqa+i8jaTCnvPIU9+IDOpOC1QCGJHEvcxDiHPQbyUl0NyEe0VQOxwX8o7K7dHOGqOdAtFO/wSEMIaF3XH9JWHXXVBeTVfotlQ/WuJ0vrFfm8+YylQPyc9won81EbRTzrtIYzno+c+YYeNjBfIR1Dt3Ohii+uR3g0+hAaTiSA0yrapYKLeFGM9lhyPhPycdCNIOPsy+PqCsf6VK4I6RzLx8uuVN/2r3xuNW3mJLCS8MexPKx9twrt6XyKpWHtpzFym8QvApouqfSd651bTbx8UNO6z+Dz5+5/aP+Hc8jGtHbyQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(13003099007)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tERiov+Ma41mTUMpo/y+qLTa/Sq3uoSQ4LSTuCkliHcsu08CNHmWNIU2NlN81vFkCrJtLt/W3SALTFLno7n9QO9sOopdh8tfl1xXy5fzFtdhp2ZYesGi1EaB3mx7mc6S+3LD5pXYZTLNV1KDUAtaXtwx6uiEXPVTPBXY75LheWzn8+TqDfZDTO59YWVcml0YKPaRyKy/UlvEO6fpwIy4HO/+NL1mkKffJ6mUOtfz79eaP2U0r8ZMQZg/BZJ/fPIJetfUYjNK0SXEc5AbI09Iwpif+CrRE1FWiY35kp9R8edNMMuO3bIRJWgesku+/3f0i7mROOxlVnFoWI1Nl1cEK/rlamnEmzCQR0iHoiKAyA66kJzfc3vKQy61XEbRgyrRovlnwf0gKc7GzQeYHUnE+8oA6T0f7S/7CsPJ3zlg48grk7ShYrcK9r9qR+hAnIev
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:37:36.2951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 097adc71-0785-4452-ec8c-08df1f005f08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF0000006F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF4CBE7339A

vfio-pci-core currently has runtime functions that interpret pci
driver_data as a pointer to vfio_pci_core_device, and enforce vfio
variant drivers must set vfio_pci_core_device to their pci driver_data.
This constrains variant drivers' private-data layout, including the
typed driver data used by the Rust PCI infrastructure.

Added VFIO_PCI_CORE_DEFINE_CALLBACKS marcos to generate wrapper code for
each vfio variant driver, update vfio variant drivers to store their
private strctures in driver_data and use generated wrapper to pass the
vfio core device to helpers.

Select the vga decode callback during vfio_pci_vga_init based on if
vfio_vga_disabled, the callback only use pci_dev and does not require
driver_data

Assisted-by: LLM
Link: https://lore.kernel.org/all/DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org/
Co-developed-by: Alex Williamson <alex.williamson@nvidia.com>
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 27 ++++-----
 drivers/vfio/pci/ism/main.c                   | 19 +++---
 drivers/vfio/pci/mlx5/main.c                  | 13 ++--
 drivers/vfio/pci/nvgrace-gpu/main.c           | 19 +++---
 drivers/vfio/pci/pds/pci_drv.c                |  8 ++-
 drivers/vfio/pci/pds/vfio_dev.c               |  5 +-
 drivers/vfio/pci/qat/main.c                   | 12 ++--
 drivers/vfio/pci/vfio_pci.c                   | 33 +++++++++-
 drivers/vfio/pci/vfio_pci_core.c              | 60 +++++++------------
 drivers/vfio/pci/virtio/main.c                |  8 ++-
 drivers/vfio/pci/xe/main.c                    |  8 ++-
 include/linux/vfio_pci_core.h                 | 42 ++++++++++++-
 12 files changed, 160 insertions(+), 94 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 86362ec424a5..5b9bd3bcdc14 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -16,6 +16,9 @@
 
 #include "hisi_acc_vfio_pci.h"
 
+VFIO_PCI_CORE_DEFINE_CALLBACKS(hisi_acc_vf, struct hisi_acc_vf_core_device,
+			       core_device)
+
 /* Return 0 on VM acc device ready, -ETIMEDOUT hardware timeout */
 static int qm_wait_dev_not_ready(struct hisi_qm *qm)
 {
@@ -588,10 +591,7 @@ static int vf_qm_state_save(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 
 static struct hisi_acc_vf_core_device *hisi_acc_drvdata(struct pci_dev *pdev)
 {
-	struct vfio_pci_core_device *core_device = dev_get_drvdata(&pdev->dev);
-
-	return container_of(core_device, struct hisi_acc_vf_core_device,
-			    core_device);
+	return pci_get_drvdata(pdev);
 }
 
 /* Check the PF's RAS state and Function INT state */
@@ -1416,9 +1416,8 @@ static int hisi_acc_vf_debug_check(struct seq_file *seq, struct vfio_device *vde
 static int hisi_acc_vf_debug_cmd(struct seq_file *seq, void *data)
 {
 	struct device *vf_dev = seq->private;
-	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
-	struct vfio_device *vdev = &core_device->vdev;
-	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = dev_get_drvdata(vf_dev);
+	struct vfio_device *vdev = &hisi_acc_vdev->core_device.vdev;
 	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
 	u64 value;
 	int ret;
@@ -1445,9 +1444,8 @@ static int hisi_acc_vf_debug_cmd(struct seq_file *seq, void *data)
 static int hisi_acc_vf_dev_read(struct seq_file *seq, void *data)
 {
 	struct device *vf_dev = seq->private;
-	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
-	struct vfio_device *vdev = &core_device->vdev;
-	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = dev_get_drvdata(vf_dev);
+	struct vfio_device *vdev = &hisi_acc_vdev->core_device.vdev;
 	size_t vf_data_sz = offsetofend(struct acc_vf_data, padding);
 	struct acc_vf_data *vf_data;
 	int ret;
@@ -1492,9 +1490,7 @@ static int hisi_acc_vf_dev_read(struct seq_file *seq, void *data)
 static int hisi_acc_vf_migf_read(struct seq_file *seq, void *data)
 {
 	struct device *vf_dev = seq->private;
-	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
-	struct vfio_device *vdev = &core_device->vdev;
-	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = dev_get_drvdata(vf_dev);
 	size_t vf_data_sz = offsetofend(struct acc_vf_data, padding);
 	struct hisi_acc_vf_migration_file *debug_migf = hisi_acc_vdev->debug_migf;
 
@@ -1687,7 +1683,7 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
 	if (IS_ERR(hisi_acc_vdev))
 		return PTR_ERR(hisi_acc_vdev);
 
-	dev_set_drvdata(&pdev->dev, &hisi_acc_vdev->core_device);
+	dev_set_drvdata(&pdev->dev, hisi_acc_vdev);
 	ret = vfio_pci_core_register_device(&hisi_acc_vdev->core_device);
 	if (ret)
 		goto out_put_vdev;
@@ -1721,7 +1717,7 @@ MODULE_DEVICE_TABLE(pci, hisi_acc_vfio_pci_table);
 static const struct pci_error_handlers hisi_acc_vf_err_handlers = {
 	.reset_prepare = hisi_acc_vf_pci_reset_prepare,
 	.reset_done = hisi_acc_vf_pci_aer_reset_done,
-	.error_detected = vfio_pci_core_aer_err_detected,
+	.error_detected = hisi_acc_vf_aer_err_detected,
 };
 
 static struct pci_driver hisi_acc_vfio_pci_driver = {
@@ -1729,6 +1725,7 @@ static struct pci_driver hisi_acc_vfio_pci_driver = {
 	.id_table = hisi_acc_vfio_pci_table,
 	.probe = hisi_acc_vfio_pci_probe,
 	.remove = hisi_acc_vfio_pci_remove,
+	.driver = { .pm = &hisi_acc_vf_pm_ops },
 	.err_handler = &hisi_acc_vf_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/ism/main.c b/drivers/vfio/pci/ism/main.c
index f83e09b915ed..5f050b90df11 100644
--- a/drivers/vfio/pci/ism/main.c
+++ b/drivers/vfio/pci/ism/main.c
@@ -47,6 +47,9 @@ struct ism_vfio_pci_core_device {
 	struct kmem_cache *store_block_cache;
 };
 
+VFIO_PCI_CORE_DEFINE_CALLBACKS(ism_vfio, struct ism_vfio_pci_core_device,
+			       core_device)
+
 static int ism_vfio_pci_open_device(struct vfio_device *core_vdev)
 {
 	struct ism_vfio_pci_core_device *ivpcd;
@@ -363,7 +366,7 @@ static int ism_vfio_pci_probe(struct pci_dev *pdev,
 	if (IS_ERR(ivpcd))
 		return PTR_ERR(ivpcd);
 
-	dev_set_drvdata(&pdev->dev, &ivpcd->core_device);
+	dev_set_drvdata(&pdev->dev, ivpcd);
 
 	ret = vfio_pci_core_register_device(&ivpcd->core_device);
 	if (ret)
@@ -374,12 +377,7 @@ static int ism_vfio_pci_probe(struct pci_dev *pdev,
 
 static void ism_vfio_pci_remove(struct pci_dev *pdev)
 {
-	struct vfio_pci_core_device *core_device;
-	struct ism_vfio_pci_core_device *ivpcd;
-
-	core_device = dev_get_drvdata(&pdev->dev);
-	ivpcd = container_of(core_device, struct ism_vfio_pci_core_device,
-			     core_device);
+	struct ism_vfio_pci_core_device *ivpcd = pci_get_drvdata(pdev);
 
 	vfio_pci_core_unregister_device(&ivpcd->core_device);
 	vfio_put_device(&ivpcd->core_device.vdev);
@@ -392,12 +390,17 @@ static const struct pci_device_id ism_device_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, ism_device_table);
 
+static const struct pci_error_handlers ism_vfio_err_handlers = {
+	.error_detected = ism_vfio_aer_err_detected,
+};
+
 static struct pci_driver ism_vfio_pci_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = ism_device_table,
 	.probe = ism_vfio_pci_probe,
 	.remove = ism_vfio_pci_remove,
-	.err_handler = &vfio_pci_core_err_handlers,
+	.driver	= { .pm = &ism_vfio_pm_ops },
+	.err_handler = &ism_vfio_err_handlers,
 	.driver_managed_dma = true,
 };
 
diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
index de306dee1d1a..a6e06190f948 100644
--- a/drivers/vfio/pci/mlx5/main.c
+++ b/drivers/vfio/pci/mlx5/main.c
@@ -21,6 +21,9 @@
 
 #include "cmd.h"
 
+VFIO_PCI_CORE_DEFINE_CALLBACKS(mlx5vf, struct mlx5vf_pci_core_device,
+			       core_device)
+
 /* Device specification max LOAD size */
 #define MAX_LOAD_SIZE (BIT_ULL(__mlx5_bit_sz(load_vhca_state_in, size)) - 1)
 
@@ -28,10 +31,7 @@
 
 static struct mlx5vf_pci_core_device *mlx5vf_drvdata(struct pci_dev *pdev)
 {
-	struct vfio_pci_core_device *core_device = dev_get_drvdata(&pdev->dev);
-
-	return container_of(core_device, struct mlx5vf_pci_core_device,
-			    core_device);
+	return pci_get_drvdata(pdev);
 }
 
 static void mlx5vf_disable_fd(struct mlx5_vf_migration_file *migf)
@@ -1415,7 +1415,7 @@ static int mlx5vf_pci_probe(struct pci_dev *pdev,
 	if (IS_ERR(mvdev))
 		return PTR_ERR(mvdev);
 
-	dev_set_drvdata(&pdev->dev, &mvdev->core_device);
+	dev_set_drvdata(&pdev->dev, mvdev);
 	ret = vfio_pci_core_register_device(&mvdev->core_device);
 	if (ret)
 		goto out_put_vdev;
@@ -1443,7 +1443,7 @@ MODULE_DEVICE_TABLE(pci, mlx5vf_pci_table);
 
 static const struct pci_error_handlers mlx5vf_err_handlers = {
 	.reset_done = mlx5vf_pci_aer_reset_done,
-	.error_detected = vfio_pci_core_aer_err_detected,
+	.error_detected = mlx5vf_aer_err_detected,
 };
 
 static struct pci_driver mlx5vf_pci_driver = {
@@ -1451,6 +1451,7 @@ static struct pci_driver mlx5vf_pci_driver = {
 	.id_table = mlx5vf_pci_table,
 	.probe = mlx5vf_pci_probe,
 	.remove = mlx5vf_pci_remove,
+	.driver	= { .pm = &mlx5vf_pm_ops },
 	.err_handler = &mlx5vf_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index d07dcacb76bd..5c58ccd53481 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -72,6 +72,9 @@ struct nvgrace_gpu_pci_core_device {
 	int cxl_dvsec;
 };
 
+VFIO_PCI_CORE_DEFINE_CALLBACKS(nvgrace_gpu, struct nvgrace_gpu_pci_core_device,
+			       core_device)
+
 static void nvgrace_gpu_init_fake_bar_emu_regs(struct vfio_device *core_vdev)
 {
 	struct nvgrace_gpu_pci_core_device *nvdev =
@@ -1340,7 +1343,7 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
 	if (ret)
 		goto out_put_vdev;
 
-	dev_set_drvdata(&pdev->dev, &nvdev->core_device);
+	dev_set_drvdata(&pdev->dev, nvdev);
 
 	if (ops == &nvgrace_gpu_pci_ops) {
 		nvdev->has_mig_hw_bug = nvgrace_gpu_has_mig_hw_bug(pdev);
@@ -1371,10 +1374,10 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
 
 static void nvgrace_gpu_remove(struct pci_dev *pdev)
 {
-	struct vfio_pci_core_device *core_device = dev_get_drvdata(&pdev->dev);
+	struct nvgrace_gpu_pci_core_device *nvdev = pci_get_drvdata(pdev);
 
-	vfio_pci_core_unregister_device(core_device);
-	vfio_put_device(&core_device->vdev);
+	vfio_pci_core_unregister_device(&nvdev->core_device);
+	vfio_put_device(&nvdev->core_device.vdev);
 }
 
 static const struct pci_device_id nvgrace_gpu_vfio_pci_table[] = {
@@ -1406,17 +1409,14 @@ MODULE_DEVICE_TABLE(pci, nvgrace_gpu_vfio_pci_table);
  */
 static void nvgrace_gpu_vfio_pci_reset_done(struct pci_dev *pdev)
 {
-	struct vfio_pci_core_device *core_device = dev_get_drvdata(&pdev->dev);
-	struct nvgrace_gpu_pci_core_device *nvdev =
-		container_of(core_device, struct nvgrace_gpu_pci_core_device,
-			     core_device);
+	struct nvgrace_gpu_pci_core_device *nvdev = pci_get_drvdata(pdev);
 
 	nvdev->reset_done = true;
 }
 
 static const struct pci_error_handlers nvgrace_gpu_vfio_pci_err_handlers = {
 	.reset_done = nvgrace_gpu_vfio_pci_reset_done,
-	.error_detected = vfio_pci_core_aer_err_detected,
+	.error_detected = nvgrace_gpu_aer_err_detected,
 };
 
 static struct pci_driver nvgrace_gpu_vfio_pci_driver = {
@@ -1424,6 +1424,7 @@ static struct pci_driver nvgrace_gpu_vfio_pci_driver = {
 	.id_table = nvgrace_gpu_vfio_pci_table,
 	.probe = nvgrace_gpu_probe,
 	.remove = nvgrace_gpu_remove,
+	.driver = { .pm = &nvgrace_gpu_pm_ops },
 	.err_handler = &nvgrace_gpu_vfio_pci_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/pds/pci_drv.c b/drivers/vfio/pci/pds/pci_drv.c
index 4923f1823126..66f4637e60cc 100644
--- a/drivers/vfio/pci/pds/pci_drv.c
+++ b/drivers/vfio/pci/pds/pci_drv.c
@@ -16,6 +16,9 @@
 #include "pci_drv.h"
 #include "cmds.h"
 
+VFIO_PCI_CORE_DEFINE_CALLBACKS(pds_vfio, struct pds_vfio_pci_device,
+			       vfio_coredev)
+
 #define PDS_VFIO_DRV_DESCRIPTION	"AMD/Pensando VFIO Device Driver"
 #define PCI_VENDOR_ID_PENSANDO		0x1dd8
 
@@ -118,7 +121,7 @@ static int pds_vfio_pci_probe(struct pci_dev *pdev,
 	if (IS_ERR(pds_vfio))
 		return PTR_ERR(pds_vfio);
 
-	dev_set_drvdata(&pdev->dev, &pds_vfio->vfio_coredev);
+	dev_set_drvdata(&pdev->dev, pds_vfio);
 
 	err = vfio_pci_core_register_device(&pds_vfio->vfio_coredev);
 	if (err)
@@ -173,7 +176,7 @@ static void pds_vfio_pci_aer_reset_done(struct pci_dev *pdev)
 
 static const struct pci_error_handlers pds_vfio_pci_err_handlers = {
 	.reset_done = pds_vfio_pci_aer_reset_done,
-	.error_detected = vfio_pci_core_aer_err_detected,
+	.error_detected = pds_vfio_aer_err_detected,
 };
 
 static struct pci_driver pds_vfio_pci_driver = {
@@ -181,6 +184,7 @@ static struct pci_driver pds_vfio_pci_driver = {
 	.id_table = pds_vfio_pci_table,
 	.probe = pds_vfio_pci_probe,
 	.remove = pds_vfio_pci_remove,
+	.driver = { .pm = &pds_vfio_pm_ops },
 	.err_handler = &pds_vfio_pci_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/pds/vfio_dev.c b/drivers/vfio/pci/pds/vfio_dev.c
index be103c74e969..6d2b2dc61a28 100644
--- a/drivers/vfio/pci/pds/vfio_dev.c
+++ b/drivers/vfio/pci/pds/vfio_dev.c
@@ -20,10 +20,7 @@ struct device *pds_vfio_to_dev(struct pds_vfio_pci_device *pds_vfio)
 
 struct pds_vfio_pci_device *pds_vfio_pci_drvdata(struct pci_dev *pdev)
 {
-	struct vfio_pci_core_device *core_device = dev_get_drvdata(&pdev->dev);
-
-	return container_of(core_device, struct pds_vfio_pci_device,
-			    vfio_coredev);
+	return pci_get_drvdata(pdev);
 }
 
 void pds_vfio_reset(struct pds_vfio_pci_device *pds_vfio,
diff --git a/drivers/vfio/pci/qat/main.c b/drivers/vfio/pci/qat/main.c
index 60ff907b6a67..e52ba6109445 100644
--- a/drivers/vfio/pci/qat/main.c
+++ b/drivers/vfio/pci/qat/main.c
@@ -55,6 +55,9 @@ struct qat_vf_core_device {
 	struct qat_vf_migration_file *saving_migf;
 };
 
+VFIO_PCI_CORE_DEFINE_CALLBACKS(qat_vf, struct qat_vf_core_device,
+			       core_device)
+
 static int qat_vf_pci_open_device(struct vfio_device *core_vdev)
 {
 	struct qat_vf_core_device *qat_vdev =
@@ -623,9 +626,7 @@ static const struct vfio_device_ops qat_vf_pci_ops = {
 
 static struct qat_vf_core_device *qat_vf_drvdata(struct pci_dev *pdev)
 {
-	struct vfio_pci_core_device *core_device = pci_get_drvdata(pdev);
-
-	return container_of(core_device, struct qat_vf_core_device, core_device);
+	return pci_get_drvdata(pdev);
 }
 
 static void qat_vf_pci_aer_reset_done(struct pci_dev *pdev)
@@ -651,7 +652,7 @@ qat_vf_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(qat_vdev))
 		return PTR_ERR(qat_vdev);
 
-	pci_set_drvdata(pdev, &qat_vdev->core_device);
+	pci_set_drvdata(pdev, qat_vdev);
 	ret = vfio_pci_core_register_device(&qat_vdev->core_device);
 	if (ret)
 		goto out_put_device;
@@ -686,7 +687,7 @@ MODULE_DEVICE_TABLE(pci, qat_vf_vfio_pci_table);
 
 static const struct pci_error_handlers qat_vf_err_handlers = {
 	.reset_done = qat_vf_pci_aer_reset_done,
-	.error_detected = vfio_pci_core_aer_err_detected,
+	.error_detected = qat_vf_aer_err_detected,
 };
 
 static struct pci_driver qat_vf_vfio_pci_driver = {
@@ -694,6 +695,7 @@ static struct pci_driver qat_vf_vfio_pci_driver = {
 	.id_table = qat_vf_vfio_pci_table,
 	.probe = qat_vf_vfio_pci_probe,
 	.remove = qat_vf_vfio_pci_remove,
+	.driver	= { .pm = &qat_vf_pm_ops },
 	.err_handler = &qat_vf_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 830369ff878d..14801419bc1d 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -223,13 +223,44 @@ static const struct pci_device_id vfio_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, vfio_pci_table);
 
+static int __maybe_unused vfio_pci_pm_suspend(struct device *dev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(dev);
+
+	return vfio_pci_core_runtime_suspend(vdev);
+}
+
+static int __maybe_unused vfio_pci_pm_resume(struct device *dev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(dev);
+
+	return vfio_pci_core_runtime_resume(vdev);
+}
+
+static const struct dev_pm_ops vfio_pci_pm_ops = {
+	SET_RUNTIME_PM_OPS(vfio_pci_pm_suspend, vfio_pci_pm_resume, NULL)
+};
+
+static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
+					       pci_channel_state_t state)
+{
+	struct vfio_pci_core_device *vdev = pci_get_drvdata(pdev);
+
+	return vfio_pci_core_aer_err_detected(vdev, state);
+}
+
+static const struct pci_error_handlers vfio_pci_err_handlers = {
+	.error_detected = vfio_pci_aer_err_detected,
+};
+
 static struct pci_driver vfio_pci_driver = {
 	.name			= "vfio-pci",
 	.id_table		= vfio_pci_table,
 	.probe			= vfio_pci_probe,
 	.remove			= vfio_pci_remove,
 	.sriov_configure	= vfio_pci_sriov_configure,
-	.err_handler		= &vfio_pci_core_err_handlers,
+	.err_handler		= &vfio_pci_err_handlers,
+	.driver		= { .pm = &vfio_pci_pm_ops },
 	.driver_managed_dma	= true,
 };
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 362c375a0579..881283e9d08a 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -153,6 +153,12 @@ static inline void vfio_pci_core_debugfs_init(struct vfio_pci_core_device *vdev)
 }
 #endif /* CONFIG_VFIO_DEBUGFS */
 
+static unsigned int vfio_pci_vga_decode_all(struct pci_dev *pdev, bool single_vga)
+{
+	return VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM |
+	       VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM;
+}
+
 /*
  * Our VGA arbiter participation is limited since we don't know anything
  * about the device itself.  However, if the device is the only VGA device
@@ -161,16 +167,14 @@ static inline void vfio_pci_core_debugfs_init(struct vfio_pci_core_device *vdev)
  * has no way to get to it and routing can be disabled externally at the
  * bridge.
  */
-static unsigned int vfio_pci_set_decode(struct pci_dev *pdev, bool single_vga)
+static unsigned int vfio_pci_vga_decode_novga(struct pci_dev *pdev, bool single_vga)
 {
-	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
 	struct pci_dev *tmp = NULL;
 	unsigned char max_busnr;
 	unsigned int decodes;
 
-	if (single_vga || !vfio_vga_disabled(vdev) || pci_is_root_bus(pdev->bus))
-		return VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM |
-		       VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM;
+	if (single_vga || pci_is_root_bus(pdev->bus))
+		return vfio_pci_vga_decode_all(pdev, single_vga);
 
 	max_busnr = pci_bus_max_busnr(pdev->bus);
 	decodes = VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
@@ -487,10 +491,8 @@ static int vfio_pci_core_pm_exit(struct vfio_pci_core_device *vdev, u32 flags,
 }
 
 #ifdef CONFIG_PM
-static int vfio_pci_core_runtime_suspend(struct device *dev)
+int vfio_pci_core_runtime_suspend(struct vfio_pci_core_device *vdev)
 {
-	struct vfio_pci_core_device *vdev = dev_get_drvdata(dev);
-
 	down_write(&vdev->memory_lock);
 	/*
 	 * The user can move the device into D3hot state before invoking
@@ -515,11 +517,10 @@ static int vfio_pci_core_runtime_suspend(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(vfio_pci_core_runtime_suspend);
 
-static int vfio_pci_core_runtime_resume(struct device *dev)
+int vfio_pci_core_runtime_resume(struct vfio_pci_core_device *vdev)
 {
-	struct vfio_pci_core_device *vdev = dev_get_drvdata(dev);
-
 	/*
 	 * Resume with a pm_wake_eventfd_ctx signals the eventfd and exit
 	 * low power mode.
@@ -536,6 +537,7 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(vfio_pci_core_runtime_resume);
 #endif /* CONFIG_PM */
 
 /*
@@ -575,18 +577,6 @@ static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
 	}
 }
 
-/*
- * The pci-driver core runtime PM routines always save the device state
- * before going into suspended state. If the device is going into low power
- * state with only with runtime PM ops, then no explicit handling is needed
- * for the devices which have NoSoftRst-.
- */
-static const struct dev_pm_ops vfio_pci_core_pm_ops = {
-	SET_RUNTIME_PM_OPS(vfio_pci_core_runtime_suspend,
-			   vfio_pci_core_runtime_resume,
-			   NULL)
-};
-
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -2148,20 +2138,27 @@ static void vfio_pci_vf_uninit(struct vfio_pci_core_device *vdev)
 
 static int vfio_pci_vga_init(struct vfio_pci_core_device *vdev)
 {
+	unsigned int (*set_decode)(struct pci_dev *pdev, bool single_vga);
 	struct pci_dev *pdev = vdev->pdev;
 	int ret;
 
 	if (!vfio_pci_is_vga(pdev))
 		return 0;
 
+	/* VGA access is fixed for the lifetime of this registration. */
+	if (vfio_vga_disabled(vdev))
+		set_decode = vfio_pci_vga_decode_novga;
+	else
+		set_decode = vfio_pci_vga_decode_all;
+
 	ret = aperture_remove_conflicting_pci_devices(pdev, vdev->vdev.ops->name);
 	if (ret)
 		return ret;
 
-	ret = vga_client_register(pdev, vfio_pci_set_decode);
+	ret = vga_client_register(pdev, set_decode);
 	if (ret)
 		return ret;
-	vga_set_legacy_decoding(pdev, vfio_pci_set_decode(pdev, false));
+	vga_set_legacy_decoding(pdev, set_decode(pdev, false));
 	return 0;
 }
 
@@ -2220,10 +2217,6 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	/* Drivers must set the vfio_pci_core_device to their drvdata */
-	if (WARN_ON(vdev != dev_get_drvdata(dev)))
-		return -EINVAL;
-
 	/* Drivers must set a name.  Required for sequestering SR-IOV VFs */
 	if (WARN_ON(!vdev->vdev.ops->name))
 		return -EINVAL;
@@ -2291,7 +2284,6 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	 */
 	vfio_pci_set_power_state(vdev, PCI_D0);
 
-	dev->driver->pm = &vfio_pci_core_pm_ops;
 	pm_runtime_allow(dev);
 	if (!vdev->disable_idle_d3)
 		pm_runtime_put(dev);
@@ -2332,10 +2324,9 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_device);
 
-pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
+pci_ers_result_t vfio_pci_core_aer_err_detected(struct vfio_pci_core_device *vdev,
 						pci_channel_state_t state)
 {
-	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
 	struct vfio_pci_eventfd *eventfd;
 
 	rcu_read_lock();
@@ -2418,11 +2409,6 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 
-const struct pci_error_handlers vfio_pci_core_err_handlers = {
-	.error_detected = vfio_pci_core_aer_err_detected,
-};
-EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
-
 static bool vfio_dev_in_groups(struct vfio_device *vdev,
 			       struct vfio_pci_group_info *groups)
 {
diff --git a/drivers/vfio/pci/virtio/main.c b/drivers/vfio/pci/virtio/main.c
index d2e5cbca13c8..69c2bf864aa7 100644
--- a/drivers/vfio/pci/virtio/main.c
+++ b/drivers/vfio/pci/virtio/main.c
@@ -18,6 +18,9 @@
 
 #include "common.h"
 
+VFIO_PCI_CORE_DEFINE_CALLBACKS(virtiovf, struct virtiovf_pci_core_device,
+			       core_device)
+
 static int virtiovf_pci_open_device(struct vfio_device *core_vdev)
 {
 	struct virtiovf_pci_core_device *virtvdev = container_of(core_vdev,
@@ -174,7 +177,7 @@ static int virtiovf_pci_probe(struct pci_dev *pdev,
 	if (sup_lm)
 		virtiovf_set_migratable(virtvdev);
 
-	dev_set_drvdata(&pdev->dev, &virtvdev->core_device);
+	dev_set_drvdata(&pdev->dev, virtvdev);
 	ret = vfio_pci_core_register_device(&virtvdev->core_device);
 	if (ret)
 		goto out;
@@ -211,7 +214,7 @@ static void virtiovf_pci_aer_reset_done(struct pci_dev *pdev)
 
 static const struct pci_error_handlers virtiovf_err_handlers = {
 	.reset_done = virtiovf_pci_aer_reset_done,
-	.error_detected = vfio_pci_core_aer_err_detected,
+	.error_detected = virtiovf_aer_err_detected,
 };
 
 static struct pci_driver virtiovf_pci_driver = {
@@ -219,6 +222,7 @@ static struct pci_driver virtiovf_pci_driver = {
 	.id_table = virtiovf_pci_table,
 	.probe = virtiovf_pci_probe,
 	.remove = virtiovf_pci_remove,
+	.driver = { .pm = &virtiovf_pm_ops },
 	.err_handler = &virtiovf_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
index cbff5af385ef..18a87ac68841 100644
--- a/drivers/vfio/pci/xe/main.c
+++ b/drivers/vfio/pci/xe/main.c
@@ -38,6 +38,9 @@ struct xe_vfio_pci_core_device {
 	struct xe_vfio_pci_migration_file *migf;
 };
 
+VFIO_PCI_CORE_DEFINE_CALLBACKS(xe_vfio, struct xe_vfio_pci_core_device,
+			       core_device)
+
 #define xe_vdev_to_dev(xe_vdev) (&(xe_vdev)->core_device.pdev->dev)
 
 static void xe_vfio_pci_disable_file(struct xe_vfio_pci_migration_file *migf)
@@ -140,7 +143,7 @@ static void xe_vfio_pci_reset_done(struct pci_dev *pdev)
 static const struct pci_error_handlers xe_vfio_pci_err_handlers = {
 	.reset_prepare = xe_vfio_pci_reset_prepare,
 	.reset_done = xe_vfio_pci_reset_done,
-	.error_detected = vfio_pci_core_aer_err_detected,
+	.error_detected = xe_vfio_aer_err_detected,
 };
 
 static int xe_vfio_pci_open_device(struct vfio_device *core_vdev)
@@ -550,7 +553,7 @@ static int xe_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	if (IS_ERR(xe_vdev))
 		return PTR_ERR(xe_vdev);
 
-	dev_set_drvdata(&pdev->dev, &xe_vdev->core_device);
+	dev_set_drvdata(&pdev->dev, xe_vdev);
 
 	ret = vfio_pci_core_register_device(&xe_vdev->core_device);
 	if (ret) {
@@ -586,6 +589,7 @@ static struct pci_driver xe_vfio_pci_driver = {
 	.id_table = xe_vfio_pci_table,
 	.probe = xe_vfio_pci_probe,
 	.remove = xe_vfio_pci_remove,
+	.driver = { .pm = &xe_vfio_pm_ops },
 	.err_handler = &xe_vfio_pci_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 9a1674c152aa..a7286100c4f9 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -8,6 +8,7 @@
  * Author: Tom Lyon, pugs@cisco.com
  */
 
+#include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/vfio.h>
@@ -16,6 +17,7 @@
 #include <linux/types.h>
 #include <linux/uuid.h>
 #include <linux/notifier.h>
+#include <linux/pm.h>
 
 #ifndef VFIO_PCI_CORE_H
 #define VFIO_PCI_CORE_H
@@ -168,7 +170,6 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
 void vfio_pci_core_release_dev(struct vfio_device *core_vdev);
 int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev);
-extern const struct pci_error_handlers vfio_pci_core_err_handlers;
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 				  int nr_virtfn);
 long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
@@ -193,8 +194,6 @@ int vfio_pci_core_match_token_uuid(struct vfio_device *core_vdev,
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_disable(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev);
-pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
-						pci_channel_state_t state);
 ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 			       void __iomem *io, char __user *buf,
 			       loff_t off, size_t count, size_t x_start,
@@ -260,4 +259,41 @@ vfio_pci_core_get_iomap(struct vfio_pci_core_device *vdev, unsigned int bar)
 int vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
 				 struct phys_vec *phys);
 
+int vfio_pci_core_runtime_suspend(struct vfio_pci_core_device *vdev);
+int vfio_pci_core_runtime_resume(struct vfio_pci_core_device *vdev);
+pci_ers_result_t vfio_pci_core_aer_err_detected(struct vfio_pci_core_device *vdev,
+						pci_channel_state_t state);
+
+/*
+ * Per-driver PM/AER trampolines. driver_data points to the driver's private
+ * structure, which embeds a struct vfio_pci_core_device.
+ *
+ * @name: prefix for <name>_pm_ops and <name>_aer_err_detected
+ * @drv_type: type of the driver's private structure, including struct
+ * @member: member containing the struct vfio_pci_core_device
+ */
+#define VFIO_PCI_CORE_DEFINE_CALLBACKS(name, drv_type, member)                \
+static int __maybe_unused name##_pm_suspend(struct device *dev)               \
+{                                                                             \
+	drv_type *drvdata = dev_get_drvdata(dev);                             \
+									      \
+	return vfio_pci_core_runtime_suspend(&drvdata->member);               \
+}                                                                             \
+static int __maybe_unused name##_pm_resume(struct device *dev)                \
+{                                                                             \
+	drv_type *drvdata = dev_get_drvdata(dev);                             \
+									      \
+	return vfio_pci_core_runtime_resume(&drvdata->member);                \
+}                                                                             \
+static const struct dev_pm_ops name##_pm_ops = {                              \
+	SET_RUNTIME_PM_OPS(name##_pm_suspend, name##_pm_resume, NULL)         \
+};                                                                            \
+static pci_ers_result_t name##_aer_err_detected(struct pci_dev *pdev,         \
+					     pci_channel_state_t state)       \
+{                                                                             \
+	drv_type *drvdata = pci_get_drvdata(pdev);                            \
+									      \
+	return vfio_pci_core_aer_err_detected(&drvdata->member, state);       \
+}
+
 #endif /* VFIO_PCI_CORE_H */
-- 
2.43.7

