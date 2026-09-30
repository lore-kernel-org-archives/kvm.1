Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1854EB846;
	Wed, 30 Sep 2026 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779067; cv=fail; b=MfNM1GbkzqumafHFFuuA8WqfGLj8fs0v6Cngh+IVlqxXNw6qqmFthdUB2QJAV/ABRq4hknwSpi68fWhPX51cevJ4pehMo3Dl8B49kc1OUcRErwvDl7E/znMBeA/9Tc2T4h9N6YneCv0aq8DpWBK7CxA5qWvtxkoBm1Mvb7M7jn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779067; c=relaxed/simple;
	bh=aG6eyedPnNG32gdWyxvviTHA7zAusB3SqVAQJaxXB/I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KpM5BvvveY8XzBRWvxJg/NWHsAiJPDn0JvzDlpn5eKZ8Rv/yB2C7hO3ZvCImr/cmZ1oXX8GvTja9Fm/KB4e0BTdSGf5BqsyJ8Tc+mwsgWsi30m8Hu+jI20sygecwkuU5q2Q2QnkcR4urP544JncyRpSnVmjI6W5ty03f+Zm2LOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B7olLGu+; arc=fail smtp.client-ip=52.101.53.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B7olLGu+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5f+ZpAfiqn1IN0BTjMH8BG+y3Av/AtXRrJJtHA1LAAi3GfBlshS9W9FMt+qcEtDQo+nWBB1SD3tOXYyF0gptGkgwDnyrlmU/WcxsnSpKoiAHcqJlhYhS/6yNy3XHXMSZ5wuIwTtdeA7It12TnxWfoSFh48P8etBmYX+N5CsUbD+YmmuCuK5gQtZ+Bnn6+eYISFIm6k03Hdh8Efllrk59Twoi3/WNhN4opNddaXoWBL6n5ie5QRAanAXwQ9MGsMlwNp49yg5/l1u7UJ81kQ92Rjqk+zYqbJTG/2mpIjQBiMQXJsVugewDq61iN/5zC3SyEJV5mERkovZ1RoEDBzT5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntwNr2b2Lq8QrhppQ8u00kRC6OC3HGvP1nIYVWQFVj4=;
 b=uE9KW2pvA9MX3peVcz0rR6A7V0WfRpQKzPdHoj5bFBCx7B/5R7U1LNSqjAAwOJ714L6X5OSvE/zi/xF0xtX+ZhkkQkwMMXMUeJIu97QrYf/OxoCgyrzFJtqAQcdIcxN9sVl0ZdvmfoaP4zIxFt5vxxgKuVvsjFWX4o6gPmFgT8Jo2LzUTy7+BbP9oXd5UkyaJsqACWywwfByOFIXr4lagh0TRIrrWM8uDpDpqGS1mtKO8e3rAwA7CCPuY6vFz270QawbZwxCb8xHj4Km8Arr6ksE6zskukTsDfB1cL/g80L+kiQMAkahkZUnkGrMnedeD93O14eVFMCAsPQ58x0edg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntwNr2b2Lq8QrhppQ8u00kRC6OC3HGvP1nIYVWQFVj4=;
 b=B7olLGu+Jzk0UMTJdgm/i30X+QVChC835BKD4rucAM/vGpZHGM6bv4bqIQJy9DKgedcAVl1t30zNn9OlIe4LRbelnpf/ZZ55ELrKXjw8wkImZTRWXevp46vqvo7JuoC41EqFjmKasP4Jo3L6XcXrX6FvKZqP2/s1IoWnb2ZRnrKzi2x9bcG2GFJ9SdhZVGKRB/CgE/cGeLoZdFl/ROg6uJu8Cejz7M6b26TPvve0e+RDcq5Zn+1D/BAQxV4lqCG5AGl3wHH6Y48vUcnuPD7sSplIaKJA61tskSpE6UHsl9yqEGR5A3r+0v/YfFfDUsET9+7Fj37amBXBC7uhbXyHtQ==
Received: from BN0PR04CA0087.namprd04.prod.outlook.com (2603:10b6:408:ea::32)
 by PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 30 Sep
 2026 14:37:29 +0000
Received: from BN3PEPF00022BC2.namprd05.prod.outlook.com
 (2603:10b6:408:ea:cafe::4d) by BN0PR04CA0087.outlook.office365.com
 (2603:10b6:408:ea::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 14:37:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF00022BC2.mail.protection.outlook.com (10.167.248.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:37:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 07:37:00 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 07:36:59 -0700
From: Simon Song <xinmengs@nvidia.com>
To: <alex@shazbot.org>, <jgg@nvidia.com>
CC: <dakr@kernel.org>, <acourbot@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <jhubbard@nvidia.com>,
	<ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <zhiwang@kernel.org>,
	<zhiw@nvidia.com>, Simon Song <xinmengs@nvidia.com>
Subject: [PATCH v2 0/1] vfio/pci: Give drivers control of PCI driver_data
Date: Wed, 30 Sep 2026 07:36:40 -0700
Message-ID: <20260930143641.4160785-1-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC2:EE_|PH7PR12MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a630f6d-300f-4773-16e2-08df1f005aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|10067099003|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tRK1aG0ZzrVA+L1pauHdUEk3fWhPLKi5KmYwBwWVo/fHWuiWRbVJYL1d4jeXxxVDypicpILJc9/JMS18IW4/x+a8CVDKX1J6TqBQYDeGXC/ur3VGI0GnVdZrYBe8Qaf+XR13WQEmymtTg/vKskrTOUxeZ1w/whTaq2PDMzz9ODXZPd4TpmX2PJQtjCglsh3uNBQFEhZxX8wvrtmSiq5MR5bArQicH+oI1x2erqtuKpG7okLi1NnXHZXpPzkYQm1DJhdn3D2Yo9PoF7xDp9qOZurQS5qhYsIF3fTDjarm/MbUAy7nMTmrNAJvqPEJZoj/xfTouE5dHa19OC1cCOoOamp+31/1tnNkwSejRZp/IJKcPPiwy3J7mYpO8Z4sHdK/jqSOU4G66MdabdH3TlH7CLHVUPjJeOO6qK0m9eea7CPToUpXUHOEOkvV0Jeb/B/VYGJk1XtWT6y8cznQKdH0cg35x+MfW5Xwr4W/30LWjL4Cce8Q981Yzzp96Y3XyHzNWfTuDZgfD06mqvyqIKqjiw77ukyf2Gk6HHifCqq8buGVYw4OrwFTmaQp7h3qfUBxlQVScGboCRex8nFUfG3arR9j4vibdHLyvGWZKCAcfyRdEiRuurjemQXbSQUa4pwQM04ykLt4I/axVVqFlRwp67O6/8I4C2zDwjo+r8K6Wi40brV9oDYK+wS0DiT8yuEY
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tv8WlCmgpVqb+uJzITOT43kIa7K6/2ptVkdnZb7HiqmwSfIokzXfpwb96XTkckuP5MNXTBHxDk8EwETn+TLgKd+gfyaYZ+DswZHROcVfeaZaXj9YEE/dCtgPf9INUHUvgXSPRNqbXVkAaWfVf/Agsh0Emsps/gfFewqsfjOqDpWclOtQEAuK0H3oVFX0LJKobNDBnVZ7Z+oSmcKk/RCWDbNue3Hvajd/I2be/kmYk+dpP14DNtegCIt4UlFzyeVwU5aOlAmPU48uZ5zhKztkJ8jbIBnyiasYiLLyfy732mLTOF39hmBxer9I107S0wk2rq8EgrDTt4nfTE4RDN1IuonFsM9S/418/oEMdrPp7/03wEbb4T3Zg82hQMDVttK12jb/+qCLBu2O3AQsvVtADw3JUV0jz9wFWBo61tEULr3qgIOGDZNvhsC92x6v7lAP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:37:28.9449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a630f6d-300f-4773-16e2-08df1f005aa9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305

Hi All,

During the discussion of the proposed Rust NVIDIA vGPU VFIO variant
driver [1], Danilo mentioned that vfio-pci-core requires pci driver_data
to point to vfio_pci_core_device, this conflicts with driver data
managed by proposed nvidia vfio variant driver.

This patch moves the responsibility for interpreting driver_data to the
pci driver, the vfio core functions (PM, AER, VGA) takes an explicit
vfio_pci_core_device pointer and no longer depend on pci driver_data

VFIO_PCI_CORE_DEFINE_CALLBACK marcos generate the wrappers for existing
vfio variant drivers, each driver also assigns its own PM ops table to
replace the operation done by vfio-pci-core during registration.

For VGA, drivers provide its decode callback to
vfio_pci_core_register_device, VGA setup/teardown remains inside vfio
core registration/unregistration, this preserves vga initialize
sequence and also remove the core dependacy on driver data.


[1] https://lore.kernel.org/all/DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org/

Simon Song (1):
  vfio/pci: Remove the core dependency on driver data

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

-- 
2.43.7

