Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C179E4D9561;
	Mon,  5 Oct 2026 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791225859; cv=fail; b=gV6z0aJqldo6irY71LBtaXGcY8ITtvIwlOQSY0WDccnoqDAgOUNgA6Xv3078bcEFA+4p+9atD9TKvddiL6FM1saRJ2XxFnGbsZ0zAreNa2Fei+l1pV22pZOCKde35IWXih2pkLo74dKfzUVlb9/CSGQjyAHQlLDK27FVQb7Hm/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791225859; c=relaxed/simple;
	bh=LZYI7/F4DtSWR+vEDqzk2zKEVbQ6AusG17ARbZvED6w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m8liwJLkdJYC1ZZRkP72EjWu3BaznVgCYsyBaf0FuIfAC9IXpPbl6WvRr9FaS9eXEm6DLLTRUXdeSORBsNydbmdpP2ZB2m+w2UiYRtmnnSlGSchVj+0b0omhdmVHUnA//2ahbbOC6GGG6jddq9GHDaOAiRFlrtLM0SgFDxOElc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eMK7JHN4; arc=fail smtp.client-ip=52.101.61.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eMK7JHN4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjpBSzyOHV2pVTfyJKm8W9pbH6qvDsxyZqivXB07zBItXQKYSPwUzw5KAJ6dlMFCl0oOiBWjD7uYBK+qJObLwQjh9gmKvXXRdgHCa4R59gI+Iwklt+i8V05egVP71dtY9WsrO+vM1Xa/ns+MhvMNXI9NZYEXzH54ePpf34rn70DpZoPUT/1KwIKvd+MXU/p8dNrOeuOle2Midx2gk4kMsxzlWut8Miw3C9YFgBz3RjeEMT85GyDAX0/ff4KcUCHFdBCLFDmuUhTwElTfdBG5eXatCLupytTt/X04k0yHzLqFpEBo2ksRiVBYm2z4UJhQTvTRTFyUXX958MvC78tQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdR5kFp2s6s992zptQr5Npnl2AzsI/qNY5TCX+6Yr3Q=;
 b=ddt59f59FlStsHMiKtyBDFpXXv/EZM+pCg4mdHxmAW9i8hQBMUKxAlzbjmNrRgLJ7OVosDFuHKrQssqS2yuSTS/IX9wH+6O0/3UF1dBsAfOcQzJ4g/h+vWiioTkmyD/oAs+oE8axwZsiBUGdj7wYoHKMWRg4AASu95DjcX/k8o7Equ91orNdlrm5uoLpw152suGNgM0mmwf72oYQZoLGzTOT9NwtPNzYhM4AF/SmMbUwngMAJOIVSAqWNP65Bm5FspWEeGP13DgB81XqjyYdmH1jHLKp0Pf3s7pxpjB07eB0vaqFnAlGKi1Ouj1Sbd2gixmMK/vHdS8/QmysGRfG1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdR5kFp2s6s992zptQr5Npnl2AzsI/qNY5TCX+6Yr3Q=;
 b=eMK7JHN4uVaS9rytd78J0Ok2fq7DjdiQpJK3qJAKdpTxtieKyeIqbD+mDDNTxthYR8Pf6dP+HTtEDQIYiD5P8AAc2/U3Q7enf75FWq2HsUl25xpQJAzc+/RV1/uswOshOrEEjigVspnVkeHCBz+ZANL/X299ILZ/tvRIpaqkUJ4uIFg8fyZCfxBSgZJb0x7fIospyyUH3atUiblPz/7gi9qSjZxhww50zi1F6IZoiqeQFX0Uhq4kgTCU9HX7qbU0MNT7ZnBrbdFGhyHcLWju860JF6pIC+n7gWCe1uBQl0WodSZLGPEXN9LDenICze96HwpnqY8zNdU2Vr6RPRd0iA==
Received: from DS1PR02CA0015.namprd02.prod.outlook.com (2603:10b6:8:44a::13)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 18:43:37 +0000
Received: from DS8PEPF000000E0.namprd05.prod.outlook.com
 (2603:10b6:8:44a:cafe::1d) by DS1PR02CA0015.outlook.office365.com
 (2603:10b6:8:44a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 18:43:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS8PEPF000000E0.mail.protection.outlook.com (10.167.23.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 18:43:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 11:43:15 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 11:43:13 -0700
From: Simon Song <xinmengs@nvidia.com>
To: <alex@shazbot.org>, <jgg@nvidia.com>
CC: <dakr@kernel.org>, <acourbot@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <jhubbard@nvidia.com>,
	<ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <zhiwang@kernel.org>,
	<zhiw@nvidia.com>, Simon Song <xinmengs@nvidia.com>
Subject: [PATCH v3 0/1] vfio/pci: Give drivers control of PCI driver_data
Date: Mon, 5 Oct 2026 11:42:35 -0700
Message-ID: <20261005184236.1946167-1-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E0:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f9dd2a-abfe-4183-9f0a-08df23109103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|6133799003|18002099003|10067099003|13003099007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	B1kc9dDrLVbtWxI34hz/wXR5pD2tI34ORYb5yTpt6oHuc5ErXFPU8p6EDyYfk9zEvAYxUdFMufKJgVHBWFnmZvcxxPBxh4Q0eitEfZRtW54mTeR89iZ58y6Hv4HQKkwkMeGsXQhHE+KJrkybjga5ceOU0CqkesDyw0oAINRhfRFODW5RFv2nGOL0QG/6MzY7YshG51AuqsHehKWHzg+V4oju3u6QfdQ7GkM+SeZFQHbLP8ykluowOBV52rVr6se/fHkg/BIvmegWPBalUDMJl6KLamrMOSpwKGm2wsdUhzP6ysy6gxoISTxs2+gQtRAUiolbt8mFk8tl3sWfbVq1H86Sqa2P9uNdpfdYa5qVtS55AA6aFDVleFBSq6HA5+t1VLkWIHaavOYQTxKICWMdRxQFtDIit0LPQdmO3FJcUp79Heu8JaPhOGWb+iEgWj4zSzc0deqITz2ksww3MJmQm22+ouPeTyK6kNmFaFTJR6nJ3/mixR4BSdMJEmcoHE2ghsgD3sSoQc+l2i7Ena4DDkqknYmNU9C7wWicWKDFNh6k0AWTx4EGdS21vuP/tJ4kEpmVHK9VszhXJI+ITNfAkNQW1b8F4gbaX9yVZhIgFNUmMROTIXb7lQlfIdbAdTwLtgxf5YFiXFaeu3/QPeqfzWw2vfuZcLNcgg3LxobPq3XtpuXhLhkSodH4yY28YMbhtOBndzxka+hKOQ92aZb9aw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(6133799003)(18002099003)(10067099003)(13003099007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eEp//bUkD9NaboIdQZUBSqGDKe8jaw2sYoqfnGpI91geprHn/LCaSTsFXezql1mv7yQ1Ot9Uugt79CqmVNKx2qGAo/XxxA8ChoVyawbYoNCBY6OoQ0BNiumFiLEcKTHYPzBIB+HuSDqpnH3FAN6qweO816xy9M5WCYZlCJgl5+7fxKMFMrTunFStdj5Ydwh0z8WZTLozNwb9k5VmQ5ovJEx7Kl49HTbUVWYo9Je3y96tjJuTzAL5D2/0m+KfjYDslzMG/s9PlrdLo9Mp6CIF0suAAoNUB69fb5svYjQDWWGPd5RrPgW5PknOz+mkPfG6BWTl1JNcbGGW936w5141ggWi4GrFE16g+YVVCOEc14qLRQugrLOb7mz+mcB2Gg7hKs/jqUveM9l+f9Z/1aPBVCjJj7zUx26nkb2i+1q0BMgn9lJcGbTxVt36urW3cPzR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 18:43:36.7859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f9dd2a-abfe-4183-9f0a-08df23109103
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616

Hi all,

This patch lets VFIO PCI variant drivers store their private structures
in PCI driver_data, removing the requirement that it point directly to
struct vfio_pci_core_device. This also accommodates the typed driver data
used by the Rust PCI infrastructure, as discussed for the proposed Rust
NVIDIA vGPU VFIO driver [1].

Runtime PM and AER helpers receive an explicit vfio_pci_core_device
pointer. VFIO_PCI_CORE_DEFINE_CALLBACKS() generates per-driver wrappers
that retrieve the driver's private data and pass its embedded core device
to these helpers. Each driver installs its own PM ops table.

VGA initialization selects the decode callback in vfio_pci_vga_init()
based on vfio_vga_disabled(vdev). Both callbacks use pci_dev directly and
do not depend on driver_data.

Changes since v2 [2]:
- Drop the unused pci_channel_state_t argument from the core AER helper
  and its callers, preserving the PCI callback signature (Danilo).
- Wrap each driver's PM ops pointer with pm_ptr() so unused tables can
  be removed when CONFIG_PM=n (Sashiko).

Changes since v1:
- Extend VFIO_PCI_CORE_DEFINE_CALLBACKS() to accept the driver's private
  structure type and the member containing vfio_pci_core_device.
- Store each variant driver's private structure in PCI driver_data.
- Select the VGA decode callback in the core and retain the one-argument
  vfio_pci_core_register_device() interface.

[1] https://lore.kernel.org/all/DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org/
[2] https://lore.kernel.org/r/20260930143641.4160785-1-xinmengs@nvidia.com/

Thanks,
Simon

Simon Song (1):
  vfio/pci: Remove the core dependency on driver data

 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 27 ++++----
 drivers/vfio/pci/ism/main.c                   | 19 +++---
 drivers/vfio/pci/mlx5/main.c                  | 13 ++--
 drivers/vfio/pci/nvgrace-gpu/main.c           | 19 +++---
 drivers/vfio/pci/pds/pci_drv.c                |  8 ++-
 drivers/vfio/pci/pds/vfio_dev.c               |  5 +-
 drivers/vfio/pci/qat/main.c                   | 12 ++--
 drivers/vfio/pci/vfio_pci.c                   | 33 +++++++++-
 drivers/vfio/pci/vfio_pci_core.c              | 61 +++++++------------
 drivers/vfio/pci/virtio/main.c                |  8 ++-
 drivers/vfio/pci/xe/main.c                    |  8 ++-
 include/linux/vfio_pci_core.h                 | 41 ++++++++++++-
 12 files changed, 159 insertions(+), 95 deletions(-)

-- 
2.43.7

