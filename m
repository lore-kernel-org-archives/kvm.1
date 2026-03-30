Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08C940DFB4;
	Mon, 30 Mar 2026 05:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774849365; cv=fail; b=offXdb0iUUkmyl9u2x4fjUKIFvEVU7pwGTcPbil4U1HW2cJsiH4k0zNJfimou0XGxyRBRk1IpQE3pCE0Qa84TXjHDOHwHvHZm/+CAg0445AHXX5/uSkTd8Unzpv3u0MYjuBDyyX47rQmWkPTrTl0QMuvSEN+llF2I1zz/NnW6dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774849365; c=relaxed/simple;
	bh=qMznrMV2TidApZwesNOAvMVFuiar56FJw2kFa2HrjSk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AgjKI6KMCatR35okiUYwXCwNBY5Znkztr/LdU2Wc75ZG6ar/8kzYLXgqQ2LAeAp20HpFMxIfDxNxx9SdpP5TmqmjVzbXvQdgCzsBR9ltvrvn4SVJ/wdGZ5+Z11+Z2u9HKHUyb6hcclO3Ym98QsF4+x/1Tb+7wck9E+CmLzvzHpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fp6NSPUu; arc=fail smtp.client-ip=52.101.48.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fp6NSPUu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBDTpT/7Lump/c6uvoQD+6+DA67OklLd5DeIfzABkyC6ZhYliRAA25lDBje5lHBm+1sGgbWs7vaWszyCuzgKuX5YFcRsRiAyinFbvcZj8UMAZP9jKWNr1fr6mUlcEQHDpQnkFw7Z0jVIGmSeCkcZ0nC5Q7rSU1hvMJA2ylwdFUevP9hEPYaQ7hUucDTzAIDHu/a+D2WieNnXPWjAG2xsEnBWd+W/Utox1oMyWs2x/EIY0C8PA6IKwh6A6sRZ9QZuc+92CJbSYVRAizZUeIJG5AS3v/Owm7metZmEcvhQuXPoUXZRZcdAvkPSuKd278qA5PyXXZtyZfzSh17BCv6lRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rm0VTnxP6fTV6/fg17q+Um5Gm8Q3MsSEZWnJxtHFfB4=;
 b=yO9qI7x/Y7ZY01Pg4tep9F857yk1tIUcVbdN6pFEzld+OQv+BQPXHslLTIURQqyopkEVQIAGH88pDZZxtW8vNvcQUIbvpzbg8DxgQC4Q5IngxZEQwX4uWkNEPBzLpBYPHhs+ru3XMhnwQ1xFXYShrG2a5OhiedH7p1pOS/mPtg52sOe7duhhWTo6ahxnDPhZm+V5FkENHMCRFlxr0OxNn5cWtT1Xg7PEhDVBeqodcKmIqeUwkBgaNHSDTM1IfRoOHn1qq4FLZIRDBKak5etO3vp9g5PvM1z+y7h4Qfx/ixjTdHmDO/AnYSPO5QSt/BHPVLpYaEsoxLZqikNI0Mogxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rm0VTnxP6fTV6/fg17q+Um5Gm8Q3MsSEZWnJxtHFfB4=;
 b=fp6NSPUuNr0iO9ghhHr1SNcfUmbnNUXTlB4nMP/0gJhkdhRDUwQsFBElLvOYcQjqlzqYZIX5wZdYV2ZiMYlt3fqifv6TXA8K9FmGsmrShfm7QdSjisT+9cczd9GcKnEB2sBTaWX2mriLCYpfIQEsOsRAiUmZQ/KqvP02NKJrYfcP5AvuiFko9XFlXgRjBk6PrevDLpF2eWGlZEGLn/O2+iWBH7LR6XDo0VWrXDtRwbV9ZdPyRzg6WLwO12mEAkJ61poFXhQfXdvJjTY/S/wNU9I6zMr5Wk7nNVqza4xGCrRbRwwqpU26FtuamfdPAQGH8DM5g/z4ZiBMhxhbi2WASw==
Received: from BN0PR04CA0038.namprd04.prod.outlook.com (2603:10b6:408:e8::13)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 05:42:37 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::35) by BN0PR04CA0038.outlook.office365.com
 (2603:10b6:408:e8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 05:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 05:42:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 29 Mar
 2026 22:42:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 29 Mar
 2026 22:42:20 -0700
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 29 Mar 2026 22:42:20 -0700
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <jgg@ziepe.ca>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <alex@shazbot.org>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness check via CXL DVSEC
Date: Mon, 30 Mar 2026 05:42:20 +0000
Message-ID: <20260330054220.620049-1-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: db18d4eb-2350-4ef1-833e-08de8e1f268d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IN2PCwalNgGvW/ySSj/BHUZh0lcIZ7QB1rtMiWuiEdS7yUzZvo/73ZBKmRJVPc4a+suSKkJ2besZvHcu6+PhlgwyCvF7iwjjLQ/GSCaUA2SbCiraWCCwgML8IUgQLAIBT65CmjIhkpnr0FzDrnXnzH4/nrf3LpPNFs54nhki5h3wiTzauRsX2QpXRNqWMY8zPWl9yVxvWWjEWtD6zcP1vu18ZhxJcx2JhljmywfOJXs9FzwK0HLQg++7mtBc+yGmKgTA+/uh8vufOc5WNqj/vTofx5KV9jqyBDYhZ41JFYTm+DSVgA9UeP0c888YxnyI3n+c4kt77aTXmiAsYzHM1rjEBJaUX7vusUzqLyBEajhYEE3cEmKdSbdfVuFUnHLxqrDvEZqZnXGX66YT5BpPxAIXJe7xmR7MAGWrfcRh2VU9Fyuq1rH/7fRZRzXg5H2RnEF6+5/j7c5qzRjqbPQrshvoDoU5ffosLvykpvypB6uZbtNn9/MhJFJBOV7wr9vqWA7mHXSbWU/UBQxrurLZrsw1RI+JSch9VPwDKZB0EZwKeozeru6jHnxsMNbvukzDkCO/Fhr8+b94v8YTPI4TSaSBk3wx0ezF6KGyne51rIGtSnmpX78U95CvMlDu7L660JWYPJdqa7rOCh2pekEs7awXXUZIYaRWWMo3b0uU+m5uHyifm8uAkpNxvTt9LM9C/HeXIrZMIEBaGnBDTGt5kB1oCTGJfsQ5hKvAiPSwD8egUA+4UkfN2KTIdrb4cbtRhVwqaTDf4muv7tvxpsfp/A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m2uvLQYPxYeG8xrFQH3JP7ef/Zb354B5jRAZcB6eY2v/J6yWiK/pJw3DvLQcMziLnYBKTokWtQTTrTr+3BbyVHEru7JfZFcGSEzkiaQDn+vgqW9tipHcceseh5LzxsxqjQF2bxk71TPPBk3tlEdqVp6vGRTy8b726iwVExfID/Tc6QY2mIPMSpoFRazHE9Y2jpPbQ3QZUeIxs1LKAZr2gW7VnSuHkKYXihfbXVBbMGBNblGTEAyJqpo8bJ7utgLUDOvyMo+vFGQCInRqIrwvPwLQDcTj9uPnPdSFrR8yx3J6PvwCm7xfU9qnxlHATHqnuTiaXdKop8Yfg3hVpY1QmwMghXa7bVVppbc6JJasAWWz+NpT0xSjvbW36kqf4n7LhXBQ440IXCas+pktMo4NOuVjoWFHWtSxn+p/yZlAgOMK8qTKdA+7efuaNx6SOxeY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 05:42:37.3229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db18d4eb-2350-4ef1-833e-08de8e1f268d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226

From: Ankit Agrawal <ankita@nvidia.com>

Blackwell-Next GPUs report device readiness via the CXL DVSEC Range 1 Low
register (offset 0x1C) instead of the BAR0 HBM training register used by
GB200. The GPU memory readiness is checked by polling for the Memory_Active
bit (bit 1) for the Memory_Active_Timeout (bits 15:13).

Add runtime detection by checking the presence of the DVSEC register.
Wire a wait_device_ready ops pointer on nvgrace_gpu_pci_core_device,
which is set at probe to either the Blackwell-Next (CXL DVSEC) or
legacy variant.

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 drivers/vfio/pci/nvgrace-gpu/main.c | 80 ++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index fa056b69f899..8b6b3577a8ea 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -34,6 +34,12 @@
 #define HBM_TRAINING_BAR0_OFFSET 0x200BC
 #define STATUS_READY 0xFF
 
+#define CXL_DEVICE_DVSEC_ID		0
+#define CXL_DVSEC_RANGE_1_LOW		0x1C
+#define CXL_DVSEC_MEMORY_VALID		BIT(0)
+#define CXL_DVSEC_MEMORY_ACTIVE		BIT(1)
+#define CXL_DVSEC_MEMORY_ACTIVE_TIMEOUT	GENMASK(15, 13)
+
 #define POLL_QUANTUM_MS 1000
 #define POLL_TIMEOUT_MS (30 * 1000)
 
@@ -64,6 +70,10 @@ struct nvgrace_gpu_pci_core_device {
 	bool has_mig_hw_bug;
 	/* GPU has just been reset */
 	bool reset_done;
+	/* CXL Device DVSEC offset; 0 if not present (legacy GB path) */
+	int cxl_dvsec;
+	int (*wait_device_ready)(struct nvgrace_gpu_pci_core_device *nvdev,
+				 void __iomem *io);
 };
 
 static void nvgrace_gpu_init_fake_bar_emu_regs(struct vfio_device *core_vdev)
@@ -242,7 +252,8 @@ static void nvgrace_gpu_close_device(struct vfio_device *core_vdev)
 	vfio_pci_core_close_device(core_vdev);
 }
 
-static int nvgrace_gpu_wait_device_ready(void __iomem *io)
+static int nvgrace_gpu_wait_device_ready_legacy(struct nvgrace_gpu_pci_core_device *nvdev,
+						void __iomem *io)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(POLL_TIMEOUT_MS);
 
@@ -256,6 +267,52 @@ static int nvgrace_gpu_wait_device_ready(void __iomem *io)
 	return -ETIME;
 }
 
+/*
+ * Decode the 3-bit Memory_Active_Timeout field from CXL DVSEC Range 1 Low
+ * (bits 15:13) into milliseconds. Encoding per CXL spec r4.0 sec 8.1.3.8.2:
+ * 000b = 1s, 001b = 4s, 010b = 16s, 011b = 64s, 100b = 256s,
+ * 101b-111b = reserved (clamped to 256s).
+ */
+static inline unsigned long nvgrace_gpu_cxl_mem_active_timeout_ms(u8 timeout)
+{
+	return 1000UL << (2 * min_t(u8, timeout, 4));
+}
+
+static int nvgrace_gpu_wait_device_ready_bw_next(struct nvgrace_gpu_pci_core_device *nvdev,
+						 void __iomem *io)
+{
+	struct pci_dev *pdev = nvdev->core_device.pdev;
+	int pcie_dvsec = nvdev->cxl_dvsec;
+	unsigned long timeout;
+	u32 dvsec_memory_status;
+	u8 mem_active_timeout;
+
+	pci_read_config_dword(pdev, pcie_dvsec + CXL_DVSEC_RANGE_1_LOW,
+			      &dvsec_memory_status);
+
+	if (!(dvsec_memory_status & CXL_DVSEC_MEMORY_VALID))
+		return -ENODEV;
+
+	mem_active_timeout = FIELD_GET(CXL_DVSEC_MEMORY_ACTIVE_TIMEOUT,
+				       dvsec_memory_status);
+
+	timeout = jiffies +
+		  msecs_to_jiffies(nvgrace_gpu_cxl_mem_active_timeout_ms(mem_active_timeout));
+
+	do {
+		pci_read_config_dword(pdev,
+				      pcie_dvsec + CXL_DVSEC_RANGE_1_LOW,
+				      &dvsec_memory_status);
+
+		if (dvsec_memory_status & CXL_DVSEC_MEMORY_ACTIVE)
+			return 0;
+
+		msleep(POLL_QUANTUM_MS);
+	} while (!time_after(jiffies, timeout));
+
+	return -ETIME;
+}
+
 /*
  * If the GPU memory is accessed by the CPU while the GPU is not ready
  * after reset, it can cause harmless corrected RAS events to be logged.
@@ -275,7 +332,7 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
 	if (!__vfio_pci_memory_enabled(vdev))
 		return -EIO;
 
-	ret = nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
+	ret = nvdev->wait_device_ready(nvdev, vdev->barmap[0]);
 	if (ret)
 		return ret;
 
@@ -1146,8 +1203,9 @@ static bool nvgrace_gpu_has_mig_hw_bug(struct pci_dev *pdev)
  * Ensure that the BAR0 region is enabled before accessing the
  * registers.
  */
-static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
+static int nvgrace_gpu_probe_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
 {
+	struct pci_dev *pdev = nvdev->core_device.pdev;
 	void __iomem *io;
 	int ret;
 
@@ -1165,7 +1223,7 @@ static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
 		goto iomap_exit;
 	}
 
-	ret = nvgrace_gpu_wait_device_ready(io);
+	ret = nvdev->wait_device_ready(nvdev, io);
 
 	pci_iounmap(pdev, io);
 iomap_exit:
@@ -1183,10 +1241,6 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
 	u64 memphys, memlength;
 	int ret;
 
-	ret = nvgrace_gpu_probe_check_device_ready(pdev);
-	if (ret)
-		return ret;
-
 	ret = nvgrace_gpu_fetch_memory_property(pdev, &memphys, &memlength);
 	if (!ret)
 		ops = &nvgrace_gpu_pci_ops;
@@ -1198,6 +1252,16 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
 
 	dev_set_drvdata(&pdev->dev, &nvdev->core_device);
 
+	nvdev->cxl_dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+						     CXL_DEVICE_DVSEC_ID);
+	nvdev->wait_device_ready = nvdev->cxl_dvsec ?
+		nvgrace_gpu_wait_device_ready_bw_next :
+		nvgrace_gpu_wait_device_ready_legacy;
+
+	ret = nvgrace_gpu_probe_check_device_ready(nvdev);
+	if (ret)
+		goto out_put_vdev;
+
 	if (ops == &nvgrace_gpu_pci_ops) {
 		nvdev->has_mig_hw_bug = nvgrace_gpu_has_mig_hw_bug(pdev);
 
-- 
2.34.1

