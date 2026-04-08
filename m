Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C302D18DB37;
	Wed,  8 Apr 2026 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775688942; cv=fail; b=IPUzcymwbxfgQjWEPwv5IGOJKPwjV7CpWMYwbSvUh1/LSm01KXVQhvZgPqo1fZkmM/WGdLMZpdICezzaMjkntlxNP98s4tuF/vjrhMVciNAgr0V5yhIYHXMUQLEg9rr22wKlnNaWzULvNRgVthUVM3JQYlQdtZrb91AWJGgx/rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775688942; c=relaxed/simple;
	bh=XvJ1C0v2p7r83eR+DbZAyoatG+VylAuwPAk3hOsmzA8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZMCxUS0x/cKQRBbWWLD11tYfZG15B3b8QLabLd9sXQdNQkpHfhT3yT2M8EkNtmwC9NAALLpV7JaPxYnxPh+TLFCyMEaso9TKLBLXhSF4c1icv01AscqctznmGEYYRUANPb87lISrmgo7sC/XnZPORgQkdJpxHH42MrDTxSyjR8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D3asSZe2; arc=fail smtp.client-ip=40.107.209.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D3asSZe2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulGOvwrVBRW9ARO9ksiXLPp1iI+RxyioNq0gyqjLt632tiJhm32IIXx838ZdYuAeMJbqNJiWQUoqDvz+kJRME3vf3fVZZCf9DsEiHX0nZaiOJYt54yURoIoB35k8e9iXV5tbac1an5rIEtiUvsOaELlnFEYoUz6bmN8HVqoiWVkVLS2pci3mrIRGp00fXuQS7VxWsRtcL1AYlQsk7+Ocv4ellwaDXovb6VyrvVgwA/3OdPgx2Fasi4C35q4E+8/+8wLF864NslZRpo3M9uuBGndqteFl1c2nb+c909q//2goCRNdg1cf0yfQcpVpzxek8qCQ3VQuQtxeizYPsEEF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMKGvCnJQtQ9liMARrkbJ0xnStb/P7ynBtIH4qqu/gQ=;
 b=bDAwtJcud5V7URjhWMo1xAQZuixZU7xmGxrkKi0I3si0z85dtzw51+Kt4E2Lw8c9v03fD6TzR4Z48LvVzS4BS/f7XTw3irFYGVVA6GEHL7EobHL/cCqdvuf2d7VZOAd09S4tUU+m8zdF9kAStQ5dMF8aQkJXAxazIKBDYhWVMYjNcO8Qei1rjkcbYXUz8jtQJfFhIYBy6LCNDJd8OdSZjSMVXaglIeb9v7qmc0NfuCJxSnU3fVIegIIecwRWWrFiW8PPs2+FLomwX01lp2Iv3KVkwRm1QimLxuvjxNukxEECw+5GJbLnAcMD2CALal249HeLvS8fZIldq4XL6KuwZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMKGvCnJQtQ9liMARrkbJ0xnStb/P7ynBtIH4qqu/gQ=;
 b=D3asSZe2sdT6/yo1b1JhI++tpM1wYKJh6MmOIGPiwX8y/0P9xl3UBRNd6dAZRbLFnpFrQtEylIXFjBCbtZgLXRSrR9Td4UJGIlPUyOpduomo/7N1D5Ll8lvQfhwZgHm1YuPEI6wTNVevWbItq0ADPq69lh88wi8PquNgy0MWQuyjaU1MEI2uqseQ8RThWC9wF/DyevS6IHuXfoCBYD4XHSEn8UOD+r36bjeI/GrVkUi1/nhQw5kOhWGF7GakhKQo/DHQ3kY30sz6uI/KctXlxvO1ZJwcHwGxh9NIX737PrPvclp+1TQojLtlfFyXQad46LQGWTysEUwF1uUCR0nZYQ==
Received: from SA1PR04CA0017.namprd04.prod.outlook.com (2603:10b6:806:2ce::22)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 22:55:36 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:2ce:cafe::5a) by SA1PR04CA0017.outlook.office365.com
 (2603:10b6:806:2ce::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 22:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 22:55:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Apr
 2026 15:55:23 -0700
Received: from meforce.lab.shazbot.org (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Apr 2026 15:55:22 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: <alex@shazbot.org>, <dmatlack@google.com>, <shuah@kernel.org>
CC: Alex Williamson <alex.williamson@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 0/4] vfio: selftest: Add NVIDIA GPU Falcon DMA test driver
Date: Wed, 8 Apr 2026 16:54:53 -0600
Message-ID: <20260408225459.3088623-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 72cb9589-3c80-458d-2119-08de95c1f2b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|30052699003|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	C+ZTBmWiz7hhiq/l61AuuOvYgsNRt5D40Ix//n9fMj2ckkQJFa6cC8hMJ+0+gPy3echzDVs+8gf4LbuVJV6ixOc8SRjOteE72ghVNxAddlCDPAthRve/JE06l6l7WFh4jJ4BLuUH9j9YyWhJkC+j5+zoVnSEc3ZYdMHEVpLzPtDbKCFH3O/Ve5sgdlKUFPS0QOx0rtncgI/bYbeeyvVNxnm+4htCbgcpns2x+TElHdtLlwFQcgHocndP/LIZpGBFJ72NYvNsOuI8DBHmALPYzi4jvrOl43qMWcs5KdWQGsJleJT6/Fu/uCdgklpf56MJXY6CCcGW4xVM9zoDO0qN02t8V0OGeLe9u/tYG95A70X0zU6WDbaD/Nw5qYaPWOg1perTzvxKY/n/e02mFi6tyAqi8rpnZzmC+uReX72HVk7O8GG+q09orA7IW8FLLkRm4gLtVIfhqHJgxijuWQm4GwXhTpEojfYkCBwTyR/utBxFsHB9JGzH2KbLPWvLElKGZLn99ENjxgbmiqzqB/XtSusXe/x+YKHBdLzTcIaoqdogPlMOp+gnYEmeY43SgrH7hCEr6iM2gCD2DhUEYwWu8Q32SlpG0YTIvbEQcZ6MWZoQvBVL31oHcgFKzkQ1dcDB4MLgJQ6B5LIJFr62QS5rSJs+HD6M91Wt8AWxhdHDOkn0XVnLOaebJIBSrNQL+8s3PIjx3qa69rQEGDXEAFkqJ9mcikUMiwH6ep/XsoiN0KuKQU9DtgpOC8Q+Qs1LETwQBM0woQdL5ElHN27QOHR0PfWCdTN/oikiOq95Ns+5XoU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(30052699003)(376014)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RcmAo6Y/RuKQmv44/hTk9C8aNkAuuIKYr01wu7THbKEfdLKbHT/r1nehB+I/G7m7OehIjwkuf/e/JbOugbehyuUJh33F/PanH1EBN260DYkOK10NG931/tyjXUe+TkMJ+ncIn5rz9damDhY7/wG0uyWKJmbeDgod22IbuwltFiiEzVH2z1F1FrptmdO8Q+LlXnN8uw73/K9pX4EZV18BhmM7plviiRJ7zKYXa+O3YvnQgCOW/qRln4JPHStyy8EMZN0HDzwoPokYWp5RTdeDPDSXHvCgAl1My7LW9URI9NQpMk6KdWkIRceXKp8ItFZvmERDrlreS/OTxg+PAI1Io0w9WVs5qIkr7otNq7U8f7/jhibz3H/OH486jsdOghR/ZNT6plZXFrhqKCQTRk2ngDNKPjPQHeLhfidn/osJfwXvt/pk07aUVJWT22YXadrH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 22:55:36.4872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cb9589-3c80-458d-2119-08de95c1f2b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146

Patch 1:

Add a chunking loop to vfio_pci_driver_memcpy() so that it handles
arbitrarily sized memcpy requests by breaking them into
max_memcpy_size-sized chunks. This allows tests to request any memcpy
size. Update the test to use a size of 4x max_memcpy_size to exercise
the chunking logic.

Patch 2:

Add vfio_pci_cmd_set()/vfio_pci_cmd_clear() macros for PCI_COMMAND
operations.

Patch 3:

Allow drivers that cannot trigger MSI interrupts to leave the
send_msi callback NULL. Tests check ops->send_msi directly and
gracefully skip MSI-related operations when it is absent.

Patch 4:

Introduce the nv_falcon plugin driver, which extracts and adapts
relevant functionality from NVIDIA's gpu-admin-tools project [1] and
integrates it into the VFIO selftest framework. As a result, any
system equipped with a PCIe slot and a supported NVIDIA GPU can now
run VFIO DMA selftests using commonly available hardware.

Falcons are general-purpose microcontrollers present on NVIDIA GPUs
that can perform DMA operations between system memory and device
memory.

[1] https://github.com/NVIDIA/gpu-admin-tools

Note on version numbering: v1 through v9 were internal review
iterations that were mistakenly carried over to the upstream
submission. Apologies for the confusion, the internal changelog
has been dropped.

Changes for lucky v13:
 - Respin from Alex.  No fundamental changes here, so keeping
   Rubin's authorships, sign-offs, and cover letter.
 - Throughout: updated subject for consistency (David)
 - Patch 1 & 3: No change, R-b collected
 - Patch 2: Macros converted to static inlines (David)
 - Patch 4: 
   - Formats %ll -> %l (David)
   - Converted size_to_dma_encoding() size testing/manipulation
     to asserts (David)
   - Re-introduced iterative transfer for non-power-of-2 memcpy (David)
     Testing this revealed we need some gymnastics to also avoid
     transfers crossing block boundaries, so we use the largest power-
     of-2 taking into account the transfer size as well as source and
     destination IOVA addresses.
   - Function renaming for consistency (David).

Rubin Du (4):
  vfio: selftests: Add memcpy chunking to vfio_pci_driver_memcpy()
  vfio: selftests: Add generic PCI command register helpers
  vfio: selftests: Allow drivers without send_msi() support
  vfio: selftests: Add NVIDIA Falcon driver for DMA testing

 .../selftests/vfio/lib/drivers/nv_falcon/hw.h | 350 ++++++++
 .../vfio/lib/drivers/nv_falcon/nv_falcon.c    | 789 ++++++++++++++++++
 .../lib/include/libvfio/vfio_pci_device.h     |  14 +
 tools/testing/selftests/vfio/lib/libvfio.mk   |   2 +
 .../selftests/vfio/lib/vfio_pci_driver.c      |  21 +-
 .../selftests/vfio/vfio_pci_driver_test.c     |  57 +-
 6 files changed, 1210 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcon/hw.h
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcon/nv_falcon.c

-- 
2.51.0

