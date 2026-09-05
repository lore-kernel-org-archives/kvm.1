Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695414503E0;
	Sat,  5 Sep 2026 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788596030; cv=fail; b=pGm/gYv6oYcsBjqngUXauiUe1Ig29hPGe1FV6bs3XSfrl/Kf3MwlxieG1atgxPnidTPZlvBpc6sYacus6wT5ku3+u47zQhTQWPvLHBLxDwcYYx4q5Toe9PVyPiM5XtfHjrcgOdjy8UvhZd/ZyzOfSANSK3vWmGYT66cJAarxUDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788596030; c=relaxed/simple;
	bh=jE6+x6R486UU0VdJmwmQHvlN8RukzAX3/qs5azyPqoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjUs+ii/N2ggy+YUgx9HaQ+A1rpC3mL/UQXM/W62XZAe91lA0GwiMoKRPXwyh6HJrGKshc+4n4+k4f0/+XD0ivPHMxV+Jcwrv9OsIjpoVEyh8wwW2lC2RVglwSHY3CrTr4YlRJ6D6/gc3QRM3fV6SlKW9Q89av0cX+iIkm/M8to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qAvMCqNk; arc=fail smtp.client-ip=52.101.57.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qAvMCqNk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJopyIgHw4oHzEaIhBAO28qkjEBUfffs6oTJv2zGEc5ywjy7HvecqA7uQB2EhGS6dndsiPt56vAwddT9cD0yjAHwSbkegyK9n89F78wg1VBu0n3D0ygGVNNCF6dj2KRJzXJxk9wH8aXQs6Q/o7TL87vfdzgCVIx2lByg5E8kaVriCfa0ee8xX80zfcLIc/+iD8CDTecCYS1PYDoURZkBKGVTp/SQjyBnqH6vbf9b6+/vj2hOY4M/JZggJ8gnYKNvv2X+4OOSHWkoLSE8Th2iY1nimg8OxyC1zct/nwoGBjueJGRIFQXUmkDkBlezOVqfn0sZj/eDmU5Wh8NZo6To4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvu6UEccL7obCi5In/FQC+/SNI929r8FvTxCnjoGT30=;
 b=qy2i4n/b+p88tavN5nviJRCdq7/yE2UUt9fShU1CL9Y8rMnEcUUM7kWVsHMhA59TML3+wj1DkhuERCDlTe6GVW/DPH4j2iSQXJcfRzLHbQwf0OFRqfQYhU8y8QFz5/KGFZgIt2+O9f/ewPpf+kbOE4B22uJ6RIO+0ANaxj/9DgDpOHUtUtJrU8JSUmN4gMXBfeCNMRrBmGrms5NwysEYsL6XKNuTmlN5OqsQjWkFjPs93d2Z27kbCQPGQmyhac38tT+3jGbJSNuHZmFSN6PIkWebEZc4+iFNW/Cn18gekQuhPp/Bqerm0IQ/u0c1DKHWZUd923O9Ybqrmfp7NB6BpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvu6UEccL7obCi5In/FQC+/SNI929r8FvTxCnjoGT30=;
 b=qAvMCqNkko5A3GTypYInwo4DQ5WlcBbyPgcHcQBScULh0ROYVTe2Nxxb4wZtVP11JoqvowuqMM+Wc27CMChysUpRbx6FN0YIwIjRP/CGtZJ9ZIJ/eM2pXikuOawoLSjFKtSnHXIDnZ01ka0MB86Zq3NUe+ijoWdeHfdDSnhnbU5le7CosXQ7JakVedFY/+hY+6ERJDakgSxFXF2+xwY2uEhrSvFHsV6qLda0uiVdC0G+wnH1FD/+QdgsK8pQELzaLp9/2jNYSIlYM05JjaOfxIQK/6nebpaP5OklW0oATfzkumtl4I1+8kktorXSPgkhYY16TtGduk4D39s18VVIDg==
Received: from BN0PR04CA0067.namprd04.prod.outlook.com (2603:10b6:408:ea::12)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Sat, 5 Sep
 2026 08:13:27 +0000
Received: from BN6PEPF0000006F.namprd03.prod.outlook.com
 (2603:10b6:408:ea:cafe::25) by BN0PR04CA0067.outlook.office365.com
 (2603:10b6:408:ea::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 08:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN6PEPF0000006F.mail.protection.outlook.com (10.167.248.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 08:13:26 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 5 Sep
 2026 01:13:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 5 Sep
 2026 01:13:12 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.46 via Frontend Transport; Sat, 5 Sep
 2026 01:13:03 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, Zhi Wang
	<zhiw@nvidia.com>, <kvm@vger.kernel.org>
Subject: [PATCH 12/13] vfio/nvidia-vgpu: add the NVIDIA vGPU VFIO variant driver
Date: Sat, 5 Sep 2026 11:11:15 +0300
Message-ID: <20260905081116.106613-13-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905081116.106613-1-zhiw@nvidia.com>
References: <20260905081116.106613-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN6PEPF0000006F:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f699c50-6647-42bc-ccd2-08df0b25902f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|23010399003|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	onpwf2h0d5BBLwRu2dfc+qJhVrgSKYQKA9mQHPRSo2ZtuhiLU3GW4hQ/CpF7/HkJ4+8z3GBtTNUahTRuF6+2y/SIyhIBNFSGyPYP7ZJr86QhhGWo6vn14vV95Rocs9ti8P4Dfkip1E1lTOJJtjCjt3Jm6+SqpmVq3mF5DMHvwsXt8lKKxXrb65Zs0djw254hHpqrfIbaDBZ5R5VDv7wMYFZVv86tacfAdSZw1URSlxWiyE3ej/0ni64j/h9tcoxLLaJSvdnyCo5Tn1vc/ytzlDQQSgJpJKYNz7VRnAyf2XAwp5iXpfNQzI1z3joxpZWSLIY4H24d5tt5x1WBUeEWgn30ICNqi4YZHOvTVjH4W8jzmqGB3kO9krxydeVxlmc6SZHib4bpuC/Als77GKb7c48g6vR683zUwojDhRqIpHPa0hayIQ3+PYRQxwZ+gmKxhaRvYBLTtwofSHMjWee8FFerTYrVHu9myZb2IqPbDDD2mwNVkGj/2L0HpjheoTf3SBHkT7Wacuu2xN23i/szsuTAVM9tu2EXk0fudgG3DMMSdAdKw2c+VxB4aqy4kWThv9pXafZ3iDwMYvOSsLNC9rTSJ5/0cGIjgxue8b4783LtZPkZX1DMPUi0iGXO4/WtbiShHTPnixvHtpbTz3jDBftobv9p3g8NM4L58n41sEoxO8a2ZNEAib6VhnuUm/D4CJrt/+e7OuMkiF+j3/kAkw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jmeNkrquKcLqBSYe9fJ/4YWt+1r1y5zaGsQXxtSmhWB0zC+kH1Yl5LDR9pE0mkkkagkUacpStg1u5VS8KLRRjd3UI4gKYRD1b0vrJ9jnCb/+o1MIk5WBz4JyKfdF7rvzsHIwYaNaMP/T7acDedhOBNZAqAtpASt93KNNNen/VHtc8EspDzrYuDxeHeIwSyrxa481tdD4TU52twzkkkE9LyTu+VJjSBdiALoOj5rbAiShO7u+9L1/jHJH2v8hybXpG8isuVgn4lbaCQOcSRjtMrIx9EN9E5j3TzT5m4H5YUpxYzjy0P+EAXSZRVBmrS5leJO7QzxeFRdkO26aY313svfSNsLom/eWFuLEqcZ89/QKoEZZDJ9ma1tc8yuZ4bCwIoOYSteIH0jLbNSpSQOvlbcXlQAEuQ6BAzBqwsk3HBCc6mSEoycYH2swPDKK5hLL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 08:13:26.8773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f699c50-6647-42bc-ccd2-08df0b25902f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF0000006F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288

NVIDIA vGPU VFs require their open, reset, and close lifecycle to be
coordinated with the PF-side nova-core driver.

Add a VFIO PCI variant driver that binds NVIDIA devices only through
driver_override and rejects non-VFs. Delegate instance lifecycle
operations to nova-core, present the firmware-selected device and
subsystem IDs in configuration-space reads, and adjust the reported BAR1
aperture to the assigned profile. Use vfio-pci-core for the remaining
VFIO operations.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/vfio/pci/Kconfig              |   2 +
 drivers/vfio/pci/Makefile             |   2 +
 drivers/vfio/pci/nvidia-vgpu/Kconfig  |  16 ++
 drivers/vfio/pci/nvidia-vgpu/Makefile |   2 +
 drivers/vfio/pci/nvidia-vgpu/main.c   | 253 ++++++++++++++++++++++++++
 5 files changed, 275 insertions(+)
 create mode 100644 drivers/vfio/pci/nvidia-vgpu/Kconfig
 create mode 100644 drivers/vfio/pci/nvidia-vgpu/Makefile
 create mode 100644 drivers/vfio/pci/nvidia-vgpu/main.c

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 296bf01e185e..b48d8d1af42a 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -74,4 +74,6 @@ source "drivers/vfio/pci/qat/Kconfig"
 
 source "drivers/vfio/pci/xe/Kconfig"
 
+source "drivers/vfio/pci/nvidia-vgpu/Kconfig"
+
 endmenu
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 6138f1bf241d..f3498e541555 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -24,3 +24,5 @@ obj-$(CONFIG_NVGRACE_GPU_VFIO_PCI) += nvgrace-gpu/
 obj-$(CONFIG_QAT_VFIO_PCI) += qat/
 
 obj-$(CONFIG_XE_VFIO_PCI) += xe/
+
+obj-$(CONFIG_NVIDIA_VGPU_VFIO_PCI) += nvidia-vgpu/
diff --git a/drivers/vfio/pci/nvidia-vgpu/Kconfig b/drivers/vfio/pci/nvidia-vgpu/Kconfig
new file mode 100644
index 000000000000..098822d32380
--- /dev/null
+++ b/drivers/vfio/pci/nvidia-vgpu/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NVIDIA_VGPU_VFIO_PCI
+	tristate "VFIO support for the NVIDIA vGPU"
+	depends on NOVA_CORE && PCI_IOV
+	select VFIO_PCI_CORE
+	help
+	  This option enables VFIO (Virtual Function I/O) support for
+	  NVIDIA virtual GPUs (vGPU). It allows the assignment of a virtual
+	  GPU instance to userspace applications via VFIO, typically used
+	  with hypervisors such as KVM and device emulators like QEMU.
+
+	  The NVIDIA vGPU allows a physical GPU to be partitioned into
+	  multiple virtual GPUs, each of which can be passed to a virtual
+	  machine as a PCI device using the standard VFIO infrastructure.
+
+	  If you don't know what to do here, say N.
diff --git a/drivers/vfio/pci/nvidia-vgpu/Makefile b/drivers/vfio/pci/nvidia-vgpu/Makefile
new file mode 100644
index 000000000000..193cc801a081
--- /dev/null
+++ b/drivers/vfio/pci/nvidia-vgpu/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_NVIDIA_VGPU_VFIO_PCI) += nvidia-vgpu-vfio-pci.o
+nvidia-vgpu-vfio-pci-y := main.o
diff --git a/drivers/vfio/pci/nvidia-vgpu/main.c b/drivers/vfio/pci/nvidia-vgpu/main.c
new file mode 100644
index 000000000000..d8626644f952
--- /dev/null
+++ b/drivers/vfio/pci/nvidia-vgpu/main.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/pci.h>
+#include <linux/pid.h>
+#include <linux/vfio_pci_core.h>
+#include <drm/nvidia_vgpu.h>
+
+static int nvidia_vgpu_fb_bar_index(struct pci_dev *pdev)
+{
+	if (pci_resource_flags(pdev, 0) & IORESOURCE_MEM_64)
+		return 2;
+	return 1;
+}
+
+struct nvidia_vgpu_pci_core_device {
+	struct vfio_pci_core_device core_device;
+	struct nvidia_vgpu_type_info type_info;
+	unsigned int gfid;
+};
+
+static inline unsigned int nvidia_vgpu_vf_dbdf(struct pci_dev *vf)
+{
+	return ((u32)pci_domain_nr(vf->bus) << 16) | pci_dev_id(vf);
+}
+
+static int nvidia_vgpu_open_device(struct vfio_device *core_vdev)
+{
+	struct nvidia_vgpu_pci_core_device *nvdev = container_of(
+		core_vdev, struct nvidia_vgpu_pci_core_device, core_device.vdev);
+	struct pci_dev *vf = to_pci_dev(core_vdev->dev);
+	struct nvidia_vgpu_type_info type_info;
+	int ret;
+
+	if (!vf->is_virtfn)
+		return -ENODEV;
+
+	ret = vfio_pci_core_enable(&nvdev->core_device);
+	if (ret)
+		return ret;
+
+	ret = nvidia_vgpu_open(pci_physfn(vf), nvdev->gfid,
+			       nvidia_vgpu_vf_dbdf(vf), task_tgid_nr(current),
+			       &type_info);
+	if (ret) {
+		vfio_pci_core_disable(&nvdev->core_device);
+		return ret;
+	}
+
+	nvdev->type_info = type_info;
+	pci_dbg(vf, "vgpu open: dev_id=0x%x subsys_id=0x%x bar1_length=0x%llx\n",
+		type_info.pci_dev_id, type_info.pci_subsys_id,
+		type_info.bar1_length);
+	vfio_pci_core_finish_enable(&nvdev->core_device);
+	return 0;
+}
+
+static void nvidia_vgpu_close_device(struct vfio_device *core_vdev)
+{
+	struct nvidia_vgpu_pci_core_device *nvdev = container_of(
+		core_vdev, struct nvidia_vgpu_pci_core_device, core_device.vdev);
+	struct pci_dev *vf = to_pci_dev(core_vdev->dev);
+
+	nvidia_vgpu_close(pci_physfn(vf), nvdev->gfid);
+	vfio_pci_core_close_device(core_vdev);
+}
+
+static ssize_t nvidia_vgpu_pci_read_config(struct vfio_device *core_vdev,
+					   char __user *buf, size_t count,
+					   loff_t *ppos)
+{
+	struct nvidia_vgpu_pci_core_device *nvdev = container_of(
+		core_vdev, struct nvidia_vgpu_pci_core_device, core_device.vdev);
+	struct nvidia_vgpu_type_info *ti = &nvdev->type_info;
+	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
+	size_t register_offset;
+	loff_t copy_offset;
+	size_t copy_count;
+	__le16 val16;
+	int ret;
+
+	ret = vfio_pci_core_read(core_vdev, buf, count, ppos);
+	if (ret < 0)
+		return ret;
+
+	if (vfio_pci_core_range_intersect_range(pos, count, PCI_DEVICE_ID,
+						sizeof(val16), &copy_offset,
+						&copy_count, &register_offset)) {
+		val16 = cpu_to_le16(ti->pci_dev_id);
+		if (copy_to_user(buf + copy_offset,
+				 (void *)&val16 + register_offset, copy_count))
+			return -EFAULT;
+	}
+
+	if (vfio_pci_core_range_intersect_range(pos, count, PCI_SUBSYSTEM_ID,
+						sizeof(val16), &copy_offset,
+						&copy_count, &register_offset)) {
+		val16 = cpu_to_le16(ti->pci_subsys_id);
+		if (copy_to_user(buf + copy_offset,
+				 (void *)&val16 + register_offset, copy_count))
+			return -EFAULT;
+	}
+
+	return count;
+}
+
+static ssize_t nvidia_vgpu_pci_read(struct vfio_device *core_vdev,
+				    char __user *buf, size_t count,
+				    loff_t *ppos)
+{
+	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
+
+	if (index == VFIO_PCI_CONFIG_REGION_INDEX)
+		return nvidia_vgpu_pci_read_config(core_vdev, buf, count, ppos);
+
+	return vfio_pci_core_read(core_vdev, buf, count, ppos);
+}
+
+static int nvidia_vgpu_bar1_size(struct nvidia_vgpu_pci_core_device *nvdev,
+				 u64 *size)
+{
+	if (check_shl_overflow(nvdev->type_info.bar1_length, 20, size))
+		return -EOVERFLOW;
+
+	return 0;
+}
+
+static int nvidia_vgpu_get_region_info(struct vfio_device *core_vdev,
+				       struct vfio_region_info *info,
+				       struct vfio_info_cap *caps)
+{
+	int ret;
+
+	ret = vfio_pci_ioctl_get_region_info(core_vdev, info, caps);
+	if (ret)
+		return ret;
+
+	if (info->index == nvidia_vgpu_fb_bar_index(
+		to_pci_dev(core_vdev->dev)) && info->size) {
+		struct nvidia_vgpu_pci_core_device *nvdev = container_of(
+			core_vdev, struct nvidia_vgpu_pci_core_device,
+			core_device.vdev);
+		u64 vgpu_bar1;
+
+		ret = nvidia_vgpu_bar1_size(nvdev, &vgpu_bar1);
+		if (ret)
+			return ret;
+
+		if (vgpu_bar1 && vgpu_bar1 < info->size)
+			info->size = vgpu_bar1;
+	}
+
+	return 0;
+}
+
+static long nvidia_vgpu_pci_ioctl(struct vfio_device *core_vdev,
+				  unsigned int cmd, unsigned long arg)
+{
+	if (cmd == VFIO_DEVICE_RESET) {
+		struct nvidia_vgpu_pci_core_device *nvdev = container_of(
+			core_vdev, struct nvidia_vgpu_pci_core_device,
+			core_device.vdev);
+		struct pci_dev *vf = to_pci_dev(core_vdev->dev);
+		int ret;
+
+		ret = nvidia_vgpu_reset(pci_physfn(vf), nvdev->gfid);
+		if (ret)
+			return ret;
+	}
+
+	return vfio_pci_core_ioctl(core_vdev, cmd, arg);
+}
+
+static const struct vfio_device_ops nvidia_vgpu_pci_ops = {
+	.name		= "nvidia-vgpu-vfio-pci",
+	.init		= vfio_pci_core_init_dev,
+	.release	= vfio_pci_core_release_dev,
+	.open_device	= nvidia_vgpu_open_device,
+	.close_device	= nvidia_vgpu_close_device,
+	.ioctl		= nvidia_vgpu_pci_ioctl,
+	.get_region_info_caps = nvidia_vgpu_get_region_info,
+	.device_feature	= vfio_pci_core_ioctl_feature,
+	.read		= nvidia_vgpu_pci_read,
+	.write		= vfio_pci_core_write,
+	.mmap		= vfio_pci_core_mmap,
+	.request	= vfio_pci_core_request,
+	.match		= vfio_pci_core_match,
+	.match_token_uuid = vfio_pci_core_match_token_uuid,
+	.bind_iommufd	= vfio_iommufd_physical_bind,
+	.unbind_iommufd	= vfio_iommufd_physical_unbind,
+	.attach_ioas	= vfio_iommufd_physical_attach_ioas,
+	.detach_ioas	= vfio_iommufd_physical_detach_ioas,
+};
+
+static int nvidia_vgpu_pci_probe(struct pci_dev *pdev,
+				 const struct pci_device_id *id)
+{
+	struct nvidia_vgpu_pci_core_device *nvdev;
+	int vf_id;
+	int ret;
+
+	if (!pdev->is_virtfn)
+		return -ENODEV;
+
+	vf_id = pci_iov_vf_id(pdev);
+	if (vf_id < 0)
+		return vf_id;
+
+	nvdev = vfio_alloc_device(nvidia_vgpu_pci_core_device, core_device.vdev,
+				  &pdev->dev, &nvidia_vgpu_pci_ops);
+	if (IS_ERR(nvdev))
+		return PTR_ERR(nvdev);
+
+	nvdev->gfid = vf_id + 1;
+	dev_set_drvdata(&pdev->dev, &nvdev->core_device);
+	ret = vfio_pci_core_register_device(&nvdev->core_device);
+	if (ret)
+		goto out_put_vdev;
+
+	return 0;
+
+out_put_vdev:
+	vfio_put_device(&nvdev->core_device.vdev);
+	return ret;
+}
+
+static void nvidia_vgpu_pci_remove(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *core_device = dev_get_drvdata(&pdev->dev);
+
+	vfio_pci_core_unregister_device(core_device);
+	vfio_put_device(&core_device->vdev);
+}
+
+static const struct pci_device_id nvidia_vgpu_pci_table[] = {
+	/* Placeholder: match all NVIDIA VFs (vendor 0x10de) */
+	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) },
+	{}
+};
+MODULE_DEVICE_TABLE(pci, nvidia_vgpu_pci_table);
+
+static struct pci_driver nvidia_vgpu_pci_driver = {
+	.name		= "nvidia-vgpu-vfio-pci",
+	.id_table	= nvidia_vgpu_pci_table,
+	.probe		= nvidia_vgpu_pci_probe,
+	.remove		= nvidia_vgpu_pci_remove,
+	.driver_managed_dma = true,
+};
+module_pci_driver(nvidia_vgpu_pci_driver);
+
+MODULE_DESCRIPTION("NVIDIA vGPU vfio-pci driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("NOVA_CORE_VGPU");
-- 
2.53.0
