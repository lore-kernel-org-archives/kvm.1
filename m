Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013008.outbound.protection.outlook.com [40.107.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750AD390994;
	Fri,  3 Apr 2026 23:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775259907; cv=fail; b=L1+Zo4zAae4hD35Lcp2h75rtWnfZGdg9q/Qx9wU+Xqt63sTGJocfdIeIhpPK+LTfDIKKcuhoT4vdfjthQkgmzhf7UltGbGFnU5pAm0fwQ0p2bR0QvXYUa6EEmekErrSwzCLMvHTqdYff1eggRDeGmoBywfcNGGeVzAlWHM88gKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775259907; c=relaxed/simple;
	bh=KMJJyztXmNYxxTsWQnd/b5k2IoJumu6EATjuzI5oLJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IZBq9ZD5mYdONJVy+zZLXtOLYbNJBWZakC3zyy7adj1++gz/UobfDbWjUodHPL5vE9MIr5xbLT05mh376doW9tIPBVAytqeJIUmCcK84kHO8mI/C5LhfB/GkUMqTWojlpgnZohCoj8DfMuVgVgA4+1subKtdKEZa6Oo6aZ40/3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XsNp8h6R; arc=fail smtp.client-ip=40.107.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XsNp8h6R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMWvU1/BsTjUNdljFZILxVSSAlxWqmv5I3qJaODmwr44igVsNbVpnR6xbvQe0f0uaNd13Kro+BryB4WHark9F4W/RgK8QnoL+VrT0vQpqKzCapcl+YyXxvDWSOokhF9KyXXJOsqbXcDz55x+qZqGKYLT+Z2GmJUR9av5214LGazm3ExcSieC6xBY517zQ+0P2GAbECMOOj0FiIcTzhE0m8Tvd+s2Ih2vTu9hR8BzBUsm8Y75L2+nw8/JqIKO3XmLQN6QmJtl3gLOl4+KNc5Cc/EBRCYWNQJdvRCxGIK802MwevakHkSgKW8wzoUvXSXzcKjcniM/vXpAUBmPPlGRcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyZapN1jXf5N4P5Hk4UClcAnjvagnF/Cb/h38qK2rPY=;
 b=d0DhaNoNjT0k5fdJq3T++KwoILCCUzYxdQL6L/+rBepbKCjgOFu3mRssQIg6HmWVN7i5/4W7TeDKgNrezawdCV/E1VbgELSle3vlxZ8mw4sVlOXbkyaGmhDxV0glJyu6hZBfcw3+HhKsziyttGj0my0Ghg4AgTvIkRB+mktygmRwCL3R3V17D8vOeMZSQmkG97GmfzIK/2Hq8WE8MbYMDS70OAV0V623e2lDD2Q5V5uN+VsuMmycGAsTFgW6Ch7Vmj+G9z7KjmH24ffFxK1yEfNAeW4wslOcEugdIZji3ynF/Zn6rdaFahMehNUeO+E7njaK4vp4S8g4aCQsMuXuFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyZapN1jXf5N4P5Hk4UClcAnjvagnF/Cb/h38qK2rPY=;
 b=XsNp8h6RbWsEIbSimx2s9xG8WrzgJmg3fRv1K+TELCSQzLyvv5lqXQ7mSTQo3RMMmA9pbdptdAzJAqaRazzG8sKFsi4vKx39pWR/6LNnGc49+pUkqViBL2OhJ/MHYeMeSltIEj+xaR0N6ALM9/jYC6+EOGW7dUUKInW+BkO8qItiD/uGJwL9XALXtEjShKNrScucur9fwECyo6WtpPj/m3JUMfYf5AbS4Oa2vLZ/kTI6aXwRnXuJ3fobJtcHz+Ik5EZajKQH2TMLwckK/fsvcQW5nHhupvwI87885MHgzqX81olNpJhDSqI85NVejm6+podkVmaiYsd8kWYG0+MPEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) by PH0PR12MB7078.namprd12.prod.outlook.com
 (2603:10b6:510:21d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 23:44:51 +0000
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7]) by SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7%6]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 23:44:51 +0000
From: Rubin Du <rubind@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 4/4] selftests/vfio: Add NVIDIA Falcon driver for DMA testing
Date: Fri,  3 Apr 2026 16:44:44 -0700
Message-ID: <20260403234444.350867-5-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403234444.350867-1-rubind@nvidia.com>
References: <20260403234444.350867-1-rubind@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0127.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::12) To SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF80B25317E:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed84ea5-586f-45f1-7392-08de91daff91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	O9z1fAO+t0XCDLfuqhDGN382SFx4uYvwwVvsegt78cZz6jVxJrIjFjakYiFYgsoQee7YXHJq7NxB91oBVSFrW5WcDdfWM+A6260AUj7EkDAmGnokSzYy++hb2dBPiB+uKkHTsZlM9cJ2jyaxSO+gKfRVIM3GMR+5DJOd32pwPseNMrAUAD7M8PhQXqFSZQR7BMwMUfOQDMloIt1pye0exPLjVjBrn5QGEJBPWO8fKOCF/StdS+HZfPtLi0J7r44aio213tlvDny0DRjJeK1Gkrr/VwUziwiIPUUX8qSWAh48yyIQOjFnLL9xFhes3R/HPJGLQcEwVZ6chkEJAiQoH0SD/enNZdhNjgfJML3Z4afd5MwEzTqvlQB77Y771HULYbLAPloWxS7Z92a4ThcR8iBzH3jgzU+CcGiPVuPpZShWRk32yEUeRqw/+ecW7kzyucbXvEFQekVL7qfM+S0O5RfOqC8vpBMIY5smiJnZMRJLsDC9KagBJ2njNfq2urSAfPHkkbuxrbZT1tE9notRaRPocUSZMyYHjMKFYTVEUL0dc5TKZzpYra4ShnWn0XemD2N8wnOJlfq2JWMl0s/cej84UY6DFee/oFpnY9jHDue5Jh4v5GOZevtb5sczNWyDaus2Hp9ZQukTZe233HzaQuGYYcNb7TG0q2OqBk+l8at+E+zO/p+iDIQkuM5SbgVRSyHt+yRG3UKPxQnK6ydeK4arMGuhSaU7TQECwQbnDK4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPF80B25317E.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/2FXL5AWkveeC7jZWryASv+SnV3rpKv7KZpqlbKApGfC7AbqSe8wSAbZFXC1?=
 =?us-ascii?Q?B26AmN4c0OEtRBhUfrJUNg/HhykzT72tFLEJpKUOhCuU7UAdrlxBgjnX/W/J?=
 =?us-ascii?Q?IHWFqEw19Fvi2XzC3ia+5kKJ6WHZaSVbWeEDUbgaxZl0GvU8xj3ROF+MZyZl?=
 =?us-ascii?Q?eFQ6J2QDFySTIOmEv4Qj8l1XuTiBVq1r6/7I8B3h5RZYSDRXFl5Ypk9Mb84F?=
 =?us-ascii?Q?RQxmXhsBrdiZbtEasRGZMGkm3aNBcuyQGm3j4bjhoVpXmFbC9aGpfY1CYO61?=
 =?us-ascii?Q?iQyIs9ryDKRzXTLG2Vx7AQoXKl53uAN5716NVNMRotyJTlWSeY1gujyDN+Yw?=
 =?us-ascii?Q?pnzoDseCC+A/pxDqBa+9oH0vSi+Caf+qt95DqQW8+Tp0kvmZjbTc+jjmmorc?=
 =?us-ascii?Q?1DEMYVv9i0pJQMTynP6HqF0rtxDyeUbYzuy0PQjGYYl+04QxrZfEFxvlTgIB?=
 =?us-ascii?Q?la8t/eY+3jIblavJTXTTGufLKEwbQX28MdnmePiQ+VFrojhz+V36rAALuQfr?=
 =?us-ascii?Q?2IV4cxyhjPrXTI1BGPUj+7BrZycRnEw7U5qsd+KF+iHylgWfdDM+4TOB3TKN?=
 =?us-ascii?Q?uasqgI5Y0CaZHlXutBvhlwHIRFKjC5BP75hsnnO3UoiSQz3fDn7OU3zDVq1n?=
 =?us-ascii?Q?3ASo/LbNo0pADKjaHqsRhu0deAR4wGPOebDoVbDS0QQKWZBW2cXaDrp9YYGK?=
 =?us-ascii?Q?zc1Fwmk8cFKhUlrgZOfxADPmj+w6eAQ9JDWP/ZjSE5EJ1pVDjDJvELTLbolS?=
 =?us-ascii?Q?WDXuezfr9OyYyKXsD5IXT5pUBe40Yuy6DzUO9k6aB0H/Vxt6uFpgV1bW7YHz?=
 =?us-ascii?Q?E7XccvZQWatXqYgQYu8HmiHPLvRSdjPvqyZmur/b/YZs8peeYRJYbFsRZLMp?=
 =?us-ascii?Q?6yTvI9R4T+B98YKcYS6Pi4dSSa+KCTMnw9atFS6OipjNHevX61fVcQzePfh6?=
 =?us-ascii?Q?uriXG0wWLuhCVsvKytfHxsdJ5fOm+cFvBTQAj9EXtRp/a5tTc2pfX1Av3sXY?=
 =?us-ascii?Q?vBtY1xoCeAEnC4lbaQIWpiCG/4tfo9xgjRhq9AhrfV64DDxlW2S1jAkG34h+?=
 =?us-ascii?Q?SzE8iBVkjvvFkLwWuJ+wMibTmU7eqSuljGt+YIsJmK+EpAxJCLtlr6Ee/UfL?=
 =?us-ascii?Q?T6vHRPJWfydJDYl1lya9g6Sj6kTbnH1mp8VvYPafzsL7TUMzPZksQPlBj5+b?=
 =?us-ascii?Q?rmlMkWU5jAQL1MzN7lYa0Cv2/bqkNfDszh0aYA9a3T4pnmZW5Vx7pg9gij99?=
 =?us-ascii?Q?qKiEsb+drcPklPkqZA6z+A6RAVpuDMzkQp4UIJO4+3Dw4oGanZBuJLD0i2UP?=
 =?us-ascii?Q?IdX6Q57ABL56+Zb9TZ/olw/9+HHWkivCxFd9PNWkU5bBNQ9gkv259/E+2KV2?=
 =?us-ascii?Q?zYXEb3//YYrKWegt3jwx0nBfFPeMqjWVr3u9Ei36u00q0YojaBKHnIw+CKfk?=
 =?us-ascii?Q?XWE2guhqv5kgeV9XP/90mqwDPbPlOO7Yo5hTZOLVj37eWI2PDacUk0GaAnid?=
 =?us-ascii?Q?ycCK2jNDMg+0Hw2kCidYb5xFKVyaNzm7wTYns1dM5lrJk0JVTQ1qk0Nt2zP6?=
 =?us-ascii?Q?VPBkSA0e9QkGrY2JqnT1xp/V/AfV6K69FFpG52zCeXFcXfXuBPDx407LHI0S?=
 =?us-ascii?Q?ZQCraJR7MevklkEOQ/VW3YctKJ4FbJBSx0G5skuzUB7oYN02XDwm+uvArC6P?=
 =?us-ascii?Q?lj62Am6Rd86MLbQmjHcxjx39ZxmiLcIBhi8OOhm16Q4wQnrNJzjCYrIyvoOl?=
 =?us-ascii?Q?gQHcEdHrqg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed84ea5-586f-45f1-7392-08de91daff91
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF80B25317E.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 23:44:51.1060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C23rUAmVkmtjb22QJcR3y2LMx6N9h4GYaB8vnhCFHfDX6lc8WBB3d/XVh1mEkKeW0YGg2TXgeHhisq4D/TtShQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078

Add a new VFIO PCI driver for NVIDIA GPUs that enables DMA testing
via the Falcon (Fast Logic Controller) microcontrollers. This driver
extracts and adapts the DMA test functionality from NVIDIA's
gpu-admin-tools project and integrates it into the existing VFIO
selftest framework.

Falcons are general-purpose microcontrollers present on NVIDIA GPUs
that can perform DMA operations between system memory and device
memory. By leveraging Falcon DMA, this driver allows NVIDIA GPUs to
be tested alongside Intel IOAT and DSA devices using the same
selftest infrastructure.

The driver is named 'nv_falcon' to reflect that it specifically
controls the Falcon microcontrollers for DMA operations, rather
than exposing general GPU functionality.

Reference implementation:
https://github.com/NVIDIA/gpu-admin-tools

Signed-off-by: Rubin Du <rubind@nvidia.com>
---
 .../selftests/vfio/lib/drivers/nv_falcon/hw.h | 348 ++++++++
 .../vfio/lib/drivers/nv_falcon/nv_falcon.c    | 755 ++++++++++++++++++
 tools/testing/selftests/vfio/lib/libvfio.mk   |   2 +
 .../selftests/vfio/lib/vfio_pci_driver.c      |   3 +
 4 files changed, 1108 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcon/hw.h
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcon/nv_falcon.c

diff --git a/tools/testing/selftests/vfio/lib/drivers/nv_falcon/hw.h b/tools/testing/selftests/vfio/lib/drivers/nv_falcon/hw.h
new file mode 100644
index 000000000000..6a00542b1f78
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/nv_falcon/hw.h
@@ -0,0 +1,348 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#ifndef _NV_FALCON_HW_H_
+#define _NV_FALCON_HW_H_
+
+/* PMC (Power Management Controller) Registers */
+#define NV_PMC_BOOT_0					0x00000000
+#define NV_PMC_ENABLE					0x00000200
+#define NV_PMC_ENABLE_PWR				0x00002000
+#define NV_PMC_ENABLE_HUB				0x20000000
+
+/* Falcon Base Pages for Different Engines */
+#define NV_PPWR_FALCON_BASE				0x10a000
+#define NV_PGSP_FALCON_BASE				0x110000
+
+/* Falcon Common Register Offsets (relative to base_page) */
+#define NV_FALCON_DMACTL_OFFSET				0x010c
+#define NV_FALCON_ENGINE_RESET_OFFSET			0x03c0
+
+/* DMEM Control Register Flags */
+#define NV_PPWR_FALCON_DMEMC_AINCR_TRUE			0x01000000
+#define NV_PPWR_FALCON_DMEMC_AINCW_TRUE			0x02000000
+
+/* Falcon DMEM port offsets (for port 0) */
+#define NV_FALCON_DMEMC_OFFSET				0x1c0
+#define NV_FALCON_DMEMD_OFFSET				0x1c4
+
+/* DMA Register Offsets (relative to base_page) */
+#define NV_FALCON_DMA_ADDR_LOW_OFFSET			0x110
+#define NV_FALCON_DMA_MEM_OFFSET			0x114
+#define NV_FALCON_DMA_CMD_OFFSET			0x118
+#define NV_FALCON_DMA_BLOCK_OFFSET			0x11c
+#define NV_FALCON_DMA_ADDR_HIGH_OFFSET			0x128
+
+/* DMA Global Address Top Bits Register */
+#define NV_GPU_DMA_ADDR_TOP_BITS_REG			0x100f04
+
+/* DMA Command Register Bit Definitions */
+#define NV_FALCON_DMA_CMD_WRITE_BIT			0x20
+#define NV_FALCON_DMA_CMD_SIZE_SHIFT			8
+#define NV_FALCON_DMA_CMD_DONE_BIT			0x2
+
+/*
+ * Falcon DMA is synchronous, so a transfer size and count larger than
+ * its per-operation maximum adds no value.
+ */
+
+/* DMA block size and alignment */
+#define NV_FALCON_DMA_MAX_TRANSFER_SIZE			256
+#define NV_FALCON_DMA_MAX_TRANSFER_COUNT		1
+
+/* DMACTL register bits */
+#define NV_FALCON_DMACTL_DMEM_SCRUBBING			0x1
+#define NV_FALCON_DMACTL_READY_MASK			0x6
+
+/* Falcon Core Selection Register */
+#define NV_FALCON_CORE_SELECT_OFFSET			0x1668
+#define NV_FALCON_CORE_SELECT_MASK			0x30
+
+/* Falcon mailbox register (for Ada+ reset check) */
+#define NV_FALCON_MAILBOX_TEST_OFFSET			0x40c
+#define NV_FALCON_MAILBOX_RESET_MAGIC			0xbadf5620
+
+/* Falcon Message Queue Register Offsets (relative to base_page) */
+#define NV_FALCON_QUEUE_HEAD_BASE_OFFSET		0x2c00
+#define NV_FALCON_QUEUE_TAIL_BASE_OFFSET		0x2c04
+#define NV_FALCON_QUEUE_STRIDE				0x8
+#define NV_FALCON_MSG_QUEUE_HEAD_BASE_OFFSET		0x2c80
+#define NV_FALCON_MSG_QUEUE_TAIL_BASE_OFFSET		0x2c84
+
+/* FSP Falcon Base Pages */
+#define NV_FSP_FALCON_BASE				0x8f0100
+/* base_page = cpuctl & ~0xfff */
+#define NV_FSP_FALCON_BASE_PAGE				0x8f0000
+#define NV_FSP_EMEM_BASE				0x8f2000
+
+/* FSP EMEM Port Offsets (relative to FSP EMEM base) */
+#define NV_FSP_EMEMC_OFFSET				0xac0
+#define NV_FSP_EMEMD_OFFSET				0xac4
+#define NV_FSP_EMEM_PORT_STRIDE				0x8
+
+/* EMEM Control Register Flags (same as DMEM) */
+#define NV_FALCON_EMEMC_AINCR				0x01000000
+#define NV_FALCON_EMEMC_AINCW				0x02000000
+
+/* FSP RPC channel configuration */
+#define NV_FSP_RPC_CHANNEL_SIZE				1024
+#define NV_FSP_RPC_MAX_PACKET_SIZE			1024
+#define NV_FSP_RPC_CHANNEL_HOPPER			2
+#define NV_FSP_RPC_EMEM_BASE					\
+	(NV_FSP_RPC_CHANNEL_HOPPER * NV_FSP_RPC_CHANNEL_SIZE)
+
+/* FSP EMEM port 2 registers (pre-computed for Hopper channel 2) */
+#define NV_FSP_EMEM_PORT2_CTRL		(NV_FSP_EMEM_BASE + NV_FSP_EMEMC_OFFSET + \
+					 NV_FSP_RPC_CHANNEL_HOPPER * NV_FSP_EMEM_PORT_STRIDE)
+#define NV_FSP_EMEM_PORT2_DATA		(NV_FSP_EMEM_BASE + NV_FSP_EMEMD_OFFSET + \
+					 NV_FSP_RPC_CHANNEL_HOPPER * NV_FSP_EMEM_PORT_STRIDE)
+
+/* FSP queue register offsets (pre-computed for Hopper channel 2) */
+#define NV_FSP_QUEUE_HEAD	\
+	(NV_FSP_FALCON_BASE_PAGE + NV_FALCON_QUEUE_HEAD_BASE_OFFSET + \
+	 NV_FSP_RPC_CHANNEL_HOPPER * NV_FALCON_QUEUE_STRIDE)
+#define NV_FSP_QUEUE_TAIL	\
+	(NV_FSP_FALCON_BASE_PAGE + NV_FALCON_QUEUE_TAIL_BASE_OFFSET + \
+	 NV_FSP_RPC_CHANNEL_HOPPER * NV_FALCON_QUEUE_STRIDE)
+#define NV_FSP_MSG_QUEUE_HEAD	\
+	(NV_FSP_FALCON_BASE_PAGE + NV_FALCON_MSG_QUEUE_HEAD_BASE_OFFSET + \
+	 NV_FSP_RPC_CHANNEL_HOPPER * NV_FALCON_QUEUE_STRIDE)
+#define NV_FSP_MSG_QUEUE_TAIL	\
+	(NV_FSP_FALCON_BASE_PAGE + NV_FALCON_MSG_QUEUE_TAIL_BASE_OFFSET + \
+	 NV_FSP_RPC_CHANNEL_HOPPER * NV_FALCON_QUEUE_STRIDE)
+
+/* MCTP Header */
+#define NV_MCTP_HDR_SEID_SHIFT				16
+#define NV_MCTP_HDR_SEID_MASK				0xff
+#define NV_MCTP_HDR_SEQ_SHIFT				28
+#define NV_MCTP_HDR_SEQ_MASK				0x3
+#define NV_MCTP_HDR_EOM_BIT				0x40000000
+#define NV_MCTP_HDR_SOM_BIT				0x80000000
+
+/* MCTP Message Header */
+#define NV_MCTP_MSG_TYPE_SHIFT				0
+#define NV_MCTP_MSG_TYPE_MASK				0x7f
+#define NV_MCTP_MSG_TYPE_VENDOR_DEFINED			0x7e
+#define NV_MCTP_MSG_VENDOR_ID_SHIFT			8
+#define NV_MCTP_MSG_VENDOR_ID_MASK			0xffff
+#define NV_MCTP_MSG_VENDOR_ID_NVIDIA			0x10de
+#define NV_MCTP_MSG_NVDM_TYPE_SHIFT			24
+#define NV_MCTP_MSG_NVDM_TYPE_MASK			0xff
+
+/* NVDM response type */
+#define NV_NVDM_TYPE_RESPONSE				0x15
+
+/* Minimum response size: mctp_hdr + msg_hdr + status_hdr + type + status */
+#define NV_FSP_RPC_MIN_RESPONSE_WORDS			5
+
+/* FBIF (Frame Buffer Interface) Registers */
+/* Legacy PMU FBIF offsets (Kepler, Maxwell Gen1) */
+#define NV_PMU_LEGACY_FBIF_CTL_OFFSET			0x624
+#define NV_PMU_LEGACY_FBIF_TRANSCFG_OFFSET		0x600
+
+/* PMU FBIF offsets */
+#define NV_PMU_FBIF_CTL_OFFSET				0xe24
+#define NV_PMU_FBIF_TRANSCFG_OFFSET			0xe00
+
+/* GSP FBIF offsets */
+#define NV_GSP_FBIF_CTL_OFFSET				0x624
+#define NV_GSP_FBIF_TRANSCFG_OFFSET			0x600
+
+/* OFA Falcon Base Page and FBIF offsets (used for Hopper+ DMA) */
+#define NV_OFA_FALCON_BASE				0x844000
+#define NV_OFA_FBIF_CTL_OFFSET				0x424
+#define NV_OFA_FBIF_TRANSCFG_OFFSET			0x400
+
+/* OFA DMA support check register (Hopper+) */
+#define NV_OFA_DMA_SUPPORT_CHECK_REG			0x8443c0
+
+/* FSP NVDM command types */
+#define NV_NVDM_TYPE_FBDMA				0x22
+#define NV_FBDMA_SUBCMD_ENABLE				0x1
+
+/* FBIF CTL2 offset (relative to fbif_ctl) */
+#define NV_FBIF_CTL2_OFFSET				0x60
+
+/* FBIF TRANSCFG register bits */
+#define NV_FBIF_TRANSCFG_TARGET_MASK			0x3
+#define NV_FBIF_TRANSCFG_SYSMEM_DEFAULT			0x5
+
+/* FBIF CTL register bits */
+#define NV_FBIF_CTL_ALLOW_PHYS_MODE			0x10
+#define NV_FBIF_CTL_ALLOW_FULL_PHYS_MODE		0x80
+
+/* Memory clear register offsets */
+#define NV_MEM_CLEAR_OFFSET				0x100b20
+#define NV_BOOT_COMPLETE_OFFSET				0x118234
+#define NV_BOOT_COMPLETE_MASK				0x3ff
+
+/* FSP boot complete register (Hopper+) */
+#define NV_FSP_BOOT_COMPLETE_OFFSET			0x200bc
+#define NV_FSP_BOOT_COMPLETE_MASK			0xff
+
+enum gpu_arch {
+	GPU_ARCH_UNKNOWN = -1,
+	GPU_ARCH_KEPLER = 0,
+	GPU_ARCH_MAXWELL_GEN1,
+	GPU_ARCH_MAXWELL_GEN2,
+	GPU_ARCH_PASCAL,
+	GPU_ARCH_PASCAL_10X,
+	GPU_ARCH_VOLTA,
+	GPU_ARCH_TURING,
+	GPU_ARCH_AMPERE,
+	GPU_ARCH_ADA,
+	GPU_ARCH_HOPPER,
+};
+
+enum falcon_type {
+	FALCON_TYPE_PMU_LEGACY = 0,
+	FALCON_TYPE_PMU,
+	FALCON_TYPE_GSP,
+	FALCON_TYPE_OFA,
+};
+
+struct falcon {
+	u32 base_page;
+	u32 dmactl;
+	u32 engine_reset;
+	u32 fbif_ctl;
+	u32 fbif_ctl2;
+	u32 fbif_transcfg;
+	u32 dmem_control_reg;
+	u32 dmem_data_reg;
+	bool no_outside_reset;
+};
+
+struct gpu_properties {
+	u32 pmc_enable_mask;
+	bool memory_clear_supported;
+	enum falcon_type falcon_type;
+};
+
+static const u32 verified_gpu_map[] = {
+	0x0e40a0a2,	/* K520 */
+	0x0e6000a1,	/* GTX660 */
+	0x0e63a0a1,	/* K4000 */
+	0x0f22d0a1,	/* K80 */
+	0x108000a1,	/* GT635 */
+	0x117010a2,	/* GTX750 */
+	0x117020a2,	/* GTX745 */
+	0x124320a1,	/* M60 */
+	0x130000a1,	/* P100 */
+	0x134000a1,	/* P4 */
+	0x132000a1,	/* P40 */
+	0x140000a1,	/* V100 */
+	0x164000a1,	/* T4 */
+	0xb77000a1,	/* A16 */
+	0x170000a1,	/* A100 */
+	0xb72000a1,	/* A10 */
+	0x180000a1,	/* H100 */
+	0x194000a1,	/* L4 */
+	0x192000a1,	/* L40S */
+};
+
+#define VERIFIED_GPU_MAP_SIZE ARRAY_SIZE(verified_gpu_map)
+
+static const struct gpu_properties gpu_properties_map[] = {
+	[GPU_ARCH_KEPLER] = {
+		.pmc_enable_mask = NV_PMC_ENABLE_PWR | NV_PMC_ENABLE_HUB,
+		.memory_clear_supported = false,
+		.falcon_type = FALCON_TYPE_PMU_LEGACY,
+	},
+	[GPU_ARCH_MAXWELL_GEN1] = {
+		.pmc_enable_mask = NV_PMC_ENABLE_PWR | NV_PMC_ENABLE_HUB,
+		.memory_clear_supported = false,
+		.falcon_type = FALCON_TYPE_PMU_LEGACY,
+	},
+	[GPU_ARCH_MAXWELL_GEN2] = {
+		.pmc_enable_mask = NV_PMC_ENABLE_PWR,
+		.memory_clear_supported = false,
+		.falcon_type = FALCON_TYPE_PMU,
+	},
+	[GPU_ARCH_PASCAL] = {
+		.pmc_enable_mask = NV_PMC_ENABLE_PWR,
+		.memory_clear_supported = false,
+		.falcon_type = FALCON_TYPE_PMU,
+	},
+	[GPU_ARCH_PASCAL_10X] = {
+		.pmc_enable_mask = 0,
+		.memory_clear_supported = false,
+		.falcon_type = FALCON_TYPE_PMU,
+	},
+	[GPU_ARCH_VOLTA] = {
+		.pmc_enable_mask = 0,
+		.memory_clear_supported = false,
+		.falcon_type = FALCON_TYPE_GSP,
+	},
+	[GPU_ARCH_TURING] = {
+		.pmc_enable_mask = 0,
+		.memory_clear_supported = true,
+		.falcon_type = FALCON_TYPE_GSP,
+	},
+	[GPU_ARCH_AMPERE] = {
+		.pmc_enable_mask = 0,
+		.memory_clear_supported = true,
+		.falcon_type = FALCON_TYPE_GSP,
+	},
+	[GPU_ARCH_ADA] = {
+		.pmc_enable_mask = 0,
+		.memory_clear_supported = true,
+		.falcon_type = FALCON_TYPE_PMU,
+	},
+	[GPU_ARCH_HOPPER] = {
+		.pmc_enable_mask = 0,
+		.memory_clear_supported = true,
+		.falcon_type = FALCON_TYPE_OFA,
+	},
+};
+
+static const struct falcon falcon_map[] = {
+	[FALCON_TYPE_PMU_LEGACY] = {
+		.base_page = NV_PPWR_FALCON_BASE,
+		.dmactl = NV_PPWR_FALCON_BASE + NV_FALCON_DMACTL_OFFSET,
+		.engine_reset = NV_PPWR_FALCON_BASE + NV_FALCON_ENGINE_RESET_OFFSET,
+		.fbif_ctl = NV_PPWR_FALCON_BASE + NV_PMU_LEGACY_FBIF_CTL_OFFSET,
+		.fbif_ctl2 = NV_PPWR_FALCON_BASE +
+			     NV_PMU_LEGACY_FBIF_CTL_OFFSET + NV_FBIF_CTL2_OFFSET,
+		.fbif_transcfg = NV_PPWR_FALCON_BASE + NV_PMU_LEGACY_FBIF_TRANSCFG_OFFSET,
+		.dmem_control_reg = NV_PPWR_FALCON_BASE + NV_FALCON_DMEMC_OFFSET,
+		.dmem_data_reg = NV_PPWR_FALCON_BASE + NV_FALCON_DMEMD_OFFSET,
+		.no_outside_reset = false,
+	},
+	[FALCON_TYPE_PMU] = {
+		.base_page = NV_PPWR_FALCON_BASE,
+		.dmactl = NV_PPWR_FALCON_BASE + NV_FALCON_DMACTL_OFFSET,
+		.engine_reset = NV_PPWR_FALCON_BASE + NV_FALCON_ENGINE_RESET_OFFSET,
+		.fbif_ctl = NV_PPWR_FALCON_BASE + NV_PMU_FBIF_CTL_OFFSET,
+		.fbif_ctl2 = NV_PPWR_FALCON_BASE + NV_PMU_FBIF_CTL_OFFSET + NV_FBIF_CTL2_OFFSET,
+		.fbif_transcfg = NV_PPWR_FALCON_BASE + NV_PMU_FBIF_TRANSCFG_OFFSET,
+		.dmem_control_reg = NV_PPWR_FALCON_BASE + NV_FALCON_DMEMC_OFFSET,
+		.dmem_data_reg = NV_PPWR_FALCON_BASE + NV_FALCON_DMEMD_OFFSET,
+		.no_outside_reset = false,
+	},
+	[FALCON_TYPE_GSP] = {
+		.base_page = NV_PGSP_FALCON_BASE,
+		.dmactl = NV_PGSP_FALCON_BASE + NV_FALCON_DMACTL_OFFSET,
+		.engine_reset = NV_PGSP_FALCON_BASE + NV_FALCON_ENGINE_RESET_OFFSET,
+		.fbif_ctl = NV_PGSP_FALCON_BASE + NV_GSP_FBIF_CTL_OFFSET,
+		.fbif_ctl2 = NV_PGSP_FALCON_BASE + NV_GSP_FBIF_CTL_OFFSET + NV_FBIF_CTL2_OFFSET,
+		.fbif_transcfg = NV_PGSP_FALCON_BASE + NV_GSP_FBIF_TRANSCFG_OFFSET,
+		.dmem_control_reg = NV_PGSP_FALCON_BASE + NV_FALCON_DMEMC_OFFSET,
+		.dmem_data_reg = NV_PGSP_FALCON_BASE + NV_FALCON_DMEMD_OFFSET,
+		.no_outside_reset = false,
+	},
+	[FALCON_TYPE_OFA] = {
+		.base_page = NV_OFA_FALCON_BASE,
+		.dmactl = NV_OFA_FALCON_BASE + NV_FALCON_DMACTL_OFFSET,
+		.engine_reset = NV_OFA_FALCON_BASE + NV_FALCON_ENGINE_RESET_OFFSET,
+		.fbif_ctl = NV_OFA_FALCON_BASE + NV_OFA_FBIF_CTL_OFFSET,
+		.fbif_ctl2 = NV_OFA_FALCON_BASE + NV_OFA_FBIF_CTL_OFFSET + NV_FBIF_CTL2_OFFSET,
+		.fbif_transcfg = NV_OFA_FALCON_BASE + NV_OFA_FBIF_TRANSCFG_OFFSET,
+		.dmem_control_reg = NV_OFA_FALCON_BASE + NV_FALCON_DMEMC_OFFSET,
+		.dmem_data_reg = NV_OFA_FALCON_BASE + NV_FALCON_DMEMD_OFFSET,
+		.no_outside_reset = true,
+	},
+};
+
+#endif /* _NV_FALCON_HW_H_ */
diff --git a/tools/testing/selftests/vfio/lib/drivers/nv_falcon/nv_falcon.c b/tools/testing/selftests/vfio/lib/drivers/nv_falcon/nv_falcon.c
new file mode 100644
index 000000000000..9e2943040c4d
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/nv_falcon/nv_falcon.c
@@ -0,0 +1,755 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#include <stdint.h>
+#include <strings.h>
+#include <unistd.h>
+#include <stdbool.h>
+#include <string.h>
+#include <time.h>
+
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/pci_ids.h>
+
+#include <libvfio.h>
+
+#include "hw.h"
+
+struct gpu_device {
+	enum gpu_arch arch;
+	void *bar0;
+	bool is_memory_clear_supported;
+	const struct falcon *falcon;
+	u32 pmc_enable_mask;
+	bool fsp_dma_enabled;
+
+	/* Pending memcpy parameters, set by memcpy_start() */
+	u64 memcpy_src;
+	u64 memcpy_dst;
+	u64 memcpy_size;
+	u64 memcpy_count;
+};
+
+static inline struct gpu_device *to_gpu_device(struct vfio_pci_device *device)
+{
+	return device->driver.region.vaddr;
+}
+
+static enum gpu_arch nv_gpu_arch_lookup(u32 pmc_boot_0)
+{
+	u32 arch = (pmc_boot_0 >> 24) & 0x1f;
+
+	switch (arch) {
+	case 0x0e:
+	case 0x0f:
+	case 0x10:
+		return GPU_ARCH_KEPLER;
+	case 0x11:
+		return GPU_ARCH_MAXWELL_GEN1;
+	case 0x12:
+		return GPU_ARCH_MAXWELL_GEN2;
+	case 0x13:
+		/* P100 (impl 0) uses PMC reset; P4/P40 use engine reset */
+		if (((pmc_boot_0 >> 20) & 0xf) == 0)
+			return GPU_ARCH_PASCAL;
+		return GPU_ARCH_PASCAL_10X;
+	case 0x14:
+		return GPU_ARCH_VOLTA;
+	case 0x16:
+		return GPU_ARCH_TURING;
+	case 0x17:
+		return GPU_ARCH_AMPERE;
+	case 0x18:
+		return GPU_ARCH_HOPPER;
+	case 0x19:
+		return GPU_ARCH_ADA;
+	default:
+		return GPU_ARCH_UNKNOWN;
+	}
+}
+
+static inline u32 gpu_read32(struct gpu_device *gpu, u32 offset)
+{
+	return readl(gpu->bar0 + offset);
+}
+
+static inline void gpu_write32(struct gpu_device *gpu, u32 offset, u32 value)
+{
+	writel(value, gpu->bar0 + offset);
+}
+
+static int gpu_poll_register(struct vfio_pci_device *device,
+			     const char *name, u32 offset,
+			     u32 expected, u32 mask, u32 timeout_ms)
+{
+	struct gpu_device *gpu = to_gpu_device(device);
+	struct timespec start, now;
+	u64 elapsed_ms;
+	u32 value;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+
+	for (;;) {
+		value = gpu_read32(gpu, offset);
+		if ((value & mask) == expected)
+			return 0;
+
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		elapsed_ms = (now.tv_sec - start.tv_sec) * 1000
+			     + (now.tv_nsec - start.tv_nsec) / 1000000;
+
+		if (elapsed_ms >= timeout_ms)
+			break;
+
+		usleep(1000);
+	}
+
+	dev_err(device,
+		"Timeout polling %s (0x%x): value=0x%x expected=0x%x mask=0x%x after %llu ms\n",
+		name, offset, value, expected, mask,
+		(unsigned long long)elapsed_ms);
+	return -ETIMEDOUT;
+}
+
+static int fsp_poll_queue(struct vfio_pci_device *device, const char *name,
+			  u32 head_reg, u32 tail_reg, bool wait_empty,
+			  u32 timeout_ms)
+{
+	struct gpu_device *gpu = to_gpu_device(device);
+	struct timespec start, now;
+	u64 elapsed_ms;
+	u32 head, tail;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+
+	for (;;) {
+		head = gpu_read32(gpu, head_reg);
+		tail = gpu_read32(gpu, tail_reg);
+		if (wait_empty ? (head == tail) : (head != tail))
+			return 0;
+
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		elapsed_ms = (now.tv_sec - start.tv_sec) * 1000
+			     + (now.tv_nsec - start.tv_nsec) / 1000000;
+
+		if (elapsed_ms >= timeout_ms)
+			break;
+
+		usleep(1000);
+	}
+
+	dev_err(device,
+		"Timeout polling %s: head=0x%x tail=0x%x wait_empty=%d after %llu ms\n",
+		name, head, tail, wait_empty,
+		(unsigned long long)elapsed_ms);
+	return -ETIMEDOUT;
+}
+
+static void fsp_emem_write(struct vfio_pci_device *device, u32 offset,
+			   const u32 *data, u32 count)
+{
+	struct gpu_device *gpu = to_gpu_device(device);
+	u32 i;
+
+	/* Configure port with auto-increment for read and write */
+	gpu_write32(gpu, NV_FSP_EMEM_PORT2_CTRL,
+		    offset | NV_FALCON_EMEMC_AINCR | NV_FALCON_EMEMC_AINCW);
+
+	for (i = 0; i < count; i++)
+		gpu_write32(gpu, NV_FSP_EMEM_PORT2_DATA, data[i]);
+}
+
+static void fsp_emem_read(struct vfio_pci_device *device, u32 offset,
+			  u32 *data, u32 count)
+{
+	struct gpu_device *gpu = to_gpu_device(device);
+	u32 i;
+
+	/* Configure port with auto-increment for read and write */
+	gpu_write32(gpu, NV_FSP_EMEM_PORT2_CTRL,
+		    offset | NV_FALCON_EMEMC_AINCR | NV_FALCON_EMEMC_AINCW);
+
+	for (i = 0; i < count; i++)
+		data[i] = gpu_read32(gpu, NV_FSP_EMEM_PORT2_DATA);
+}
+
+static int fsp_rpc_send_data(struct vfio_pci_device *device, const u32 *data,
+			     u32 count)
+{
+	struct gpu_device *gpu = to_gpu_device(device);
+	int ret;
+
+	ret = fsp_poll_queue(device, "fsp_cmd_queue_empty",
+			     NV_FSP_QUEUE_HEAD, NV_FSP_QUEUE_TAIL, true, 1000);
+	if (ret)
+		return ret;
+
+	fsp_emem_write(device, NV_FSP_RPC_EMEM_BASE, data, count);
+
+	/* Update queue head/tail to signal data is ready */
+	gpu_write32(gpu, NV_FSP_QUEUE_TAIL,
+		    NV_FSP_RPC_EMEM_BASE + (count - 1) * 4);
+	gpu_write32(gpu, NV_FSP_QUEUE_HEAD, NV_FSP_RPC_EMEM_BASE);
+
+	return ret;
+}
+
+static int fsp_rpc_receive_data(struct vfio_pci_device *device, u32 *data,
+				u32 max_count, u32 timeout_ms)
+{
+	struct gpu_device *gpu = to_gpu_device(device);
+	u32 head, tail;
+	u32 msg_size_words;
+	int ret;
+
+	ret = fsp_poll_queue(device, "fsp_msg_queue_ready",
+			     NV_FSP_MSG_QUEUE_HEAD, NV_FSP_MSG_QUEUE_TAIL,
+			     false, timeout_ms);
+	if (ret)
+		return ret;
+
+	head = gpu_read32(gpu, NV_FSP_MSG_QUEUE_HEAD);
+	tail = gpu_read32(gpu, NV_FSP_MSG_QUEUE_TAIL);
+
+	msg_size_words = (tail - head + 4) / 4;
+	if (msg_size_words > max_count)
+		msg_size_words = max_count;
+
+	fsp_emem_read(device, NV_FSP_RPC_EMEM_BASE, data, msg_size_words);
+
+	/* Reset message queue tail to acknowledge receipt */
+	gpu_write32(gpu, NV_FSP_MSG_QUEUE_TAIL, head);
+
+	return msg_size_words;
+}
+
+static void fsp_reset_rpc_state(struct vfio_pci_device *device)
+{
+	struct gpu_device *gpu = to_gpu_device(device);
+	u32 head, tail;
+
+	head = gpu_read32(gpu, NV_FSP_QUEUE_HEAD);
+	tail = gpu_read32(gpu, NV_FSP_QUEUE_TAIL);
+
+	if (head == tail) {
+		head = gpu_read32(gpu, NV_FSP_MSG_QUEUE_HEAD);
+		tail = gpu_read32(gpu, NV_FSP_MSG_QUEUE_TAIL);
+		if (head == tail)
+			return;
+	}
+
+	/* Best-effort drain; timeout is expected if no pending message. */
+	fsp_poll_queue(device, "fsp_msg_queue_drain",
+		       NV_FSP_MSG_QUEUE_HEAD, NV_FSP_MSG_QUEUE_TAIL, false, 5000);
+
+	gpu_write32(gpu, NV_FSP_QUEUE_TAIL, NV_FSP_RPC_EMEM_BASE);
+	gpu_write32(gpu, NV_FSP_QUEUE_HEAD, NV_FSP_RPC_EMEM_BASE);
+	gpu_write32(gpu, NV_FSP_MSG_QUEUE_TAIL, NV_FSP_RPC_EMEM_BASE);
+	gpu_write32(gpu, NV_FSP_MSG_QUEUE_HEAD, NV_FSP_RPC_EMEM_BASE);
+}
+
+static inline u32 mctp_header_build(u8 seid, u8 seq, bool som, bool eom)
+{
+	u32 hdr = 0;
+
+	hdr |= (seid & NV_MCTP_HDR_SEID_MASK) << NV_MCTP_HDR_SEID_SHIFT;
+	hdr |= (seq & NV_MCTP_HDR_SEQ_MASK) << NV_MCTP_HDR_SEQ_SHIFT;
+	if (som)
+		hdr |= NV_MCTP_HDR_SOM_BIT;
+	if (eom)
+		hdr |= NV_MCTP_HDR_EOM_BIT;
+
+	return hdr;
+}
+
+static inline u32 mctp_msg_header_build(u8 nvdm_type)
+{
+	u32 hdr = 0;
+
+	hdr |= (NV_MCTP_MSG_TYPE_VENDOR_DEFINED & NV_MCTP_MSG_TYPE_MASK)
+		<< NV_MCTP_MSG_TYPE_SHIFT;
+	hdr |= (NV_MCTP_MSG_VENDOR_ID_NVIDIA & NV_MCTP_MSG_VENDOR_ID_MASK)
+		<< NV_MCTP_MSG_VENDOR_ID_SHIFT;
+	hdr |= (nvdm_type & NV_MCTP_MSG_NVDM_TYPE_MASK)
+		<< NV_MCTP_MSG_NVDM_TYPE_SHIFT;
+
+	return hdr;
+}
+
+static inline u8 mctp_msg_header_get_nvdm_type(u32 hdr)
+{
+	return (hdr >> NV_MCTP_MSG_NVDM_TYPE_SHIFT) & NV_MCTP_MSG_NVDM_TYPE_MASK;
+}
+
+static int fsp_rpc_send_cmd(struct vfio_pci_device *device, u8 nvdm_type,
+			    const u32 *data, u32 data_count, u32 timeout_ms)
+{
+	u32 max_packet_words = NV_FSP_RPC_MAX_PACKET_SIZE / 4;
+	u32 packet[256];
+	u32 resp_buf[256];
+	u32 total_words;
+	int resp_words;
+	u8 resp_nvdm_type;
+	int ret;
+
+	total_words = 2 + data_count;
+	if (total_words > max_packet_words)
+		return -EINVAL;
+
+	packet[0] = mctp_header_build(0, 0, true, true);
+	packet[1] = mctp_msg_header_build(nvdm_type);
+
+	if (data_count > 0)
+		memcpy(&packet[2], data, data_count * sizeof(u32));
+
+	ret = fsp_rpc_send_data(device, packet, total_words);
+	if (ret)
+		return ret;
+
+	resp_words = fsp_rpc_receive_data(device, resp_buf, 256, timeout_ms);
+	if (resp_words < 0)
+		return resp_words;
+
+	if (resp_words < NV_FSP_RPC_MIN_RESPONSE_WORDS)
+		return -EPROTO;
+
+	resp_nvdm_type = mctp_msg_header_get_nvdm_type(resp_buf[1]);
+	if (resp_nvdm_type != NV_NVDM_TYPE_RESPONSE)
+		return -EPROTO;
+
+	if (resp_buf[3] != nvdm_type)
+		return -EPROTO;
+
+	if (resp_buf[4] != 0)
+		return -resp_buf[4];
+
+	return 0;
+}
+
+static int fsp_init(struct vfio_pci_device *device)
+{
+	int ret;
+
+	ret = gpu_poll_register(device, "fsp_boot_complete",
+				NV_FSP_BOOT_COMPLETE_OFFSET,
+				NV_FSP_BOOT_COMPLETE_MASK, 0xffffffff, 5000);
+	if (ret)
+		return ret;
+
+	fsp_reset_rpc_state(device);
+	return ret;
+}
+
+static int fsp_fbdma_enable(struct vfio_pci_device *device)
+{
+	struct gpu_device *gpu = to_gpu_device(device);
+	u32 cmd_data = NV_FBDMA_SUBCMD_ENABLE;
+	int ret = 0;
+
+	if (gpu->fsp_dma_enabled)
+		return ret;
+
+	ret = fsp_rpc_send_cmd(device, NV_NVDM_TYPE_FBDMA, &cmd_data, 1, 5000);
+	if (ret)
+		return ret;
+
+	gpu->fsp_dma_enabled = true;
+	return ret;
+}
+
+static bool fsp_check_ofa_dma_support(struct vfio_pci_device *device)
+{
+	struct gpu_device *gpu = to_gpu_device(device);
+	u32 val = gpu_read32(gpu, NV_OFA_DMA_SUPPORT_CHECK_REG);
+
+	return (val >> 16) != 0xbadf;
+}
+
+static int size_to_dma_encoding(u64 size)
+{
+	size = min_t(u64, size, NV_FALCON_DMA_MAX_TRANSFER_SIZE);
+
+	if (!size || (size & 0x3))
+		return -EINVAL;
+
+	return ffs(size) - 3;
+}
+
+static void falcon_dmem_port_configure(struct vfio_pci_device *device,
+				       u32 offset, bool auto_inc_read,
+				       bool auto_inc_write)
+{
+	struct gpu_device *gpu = to_gpu_device(device);
+	const struct falcon *falcon = gpu->falcon;
+	u32 memc_value = offset;
+
+	/* Set auto-increment flags */
+	if (auto_inc_read)
+		memc_value |= NV_PPWR_FALCON_DMEMC_AINCR_TRUE;
+	if (auto_inc_write)
+		memc_value |= NV_PPWR_FALCON_DMEMC_AINCW_TRUE;
+
+	gpu_write32(gpu, falcon->dmem_control_reg, memc_value);
+}
+
+static void falcon_select_core_falcon(struct vfio_pci_device *device)
+{
+	struct gpu_device *gpu = to_gpu_device(device);
+	const struct falcon *falcon = gpu->falcon;
+	u32 core_select_reg = falcon->base_page + NV_FALCON_CORE_SELECT_OFFSET;
+	u32 core_select;
+
+	/* Read current value */
+	core_select = gpu_read32(gpu, core_select_reg);
+
+	/* Clear bits 4:5 to select falcon core (not RISCV) */
+	core_select &= ~NV_FALCON_CORE_SELECT_MASK;
+
+	gpu_write32(gpu, core_select_reg, core_select);
+}
+
+static int falcon_enable(struct vfio_pci_device *device)
+{
+	struct gpu_device *gpu = to_gpu_device(device);
+	const struct falcon *falcon = gpu->falcon;
+	u32 mailbox_test_reg;
+	u32 mailbox_val;
+
+	/* Ada-specific: Check if falcon needs reset before enable */
+	if (gpu->arch == GPU_ARCH_ADA) {
+		mailbox_test_reg = falcon->base_page + NV_FALCON_MAILBOX_TEST_OFFSET;
+		mailbox_val = gpu_read32(gpu, mailbox_test_reg);
+		if (mailbox_val == NV_FALCON_MAILBOX_RESET_MAGIC)
+			gpu_write32(gpu, falcon->engine_reset, 1);
+	}
+
+	/* Enable the falcon based on control method */
+	if (!falcon->no_outside_reset) {
+		if (gpu->pmc_enable_mask != 0) {
+			u32 pmc_enable;
+
+			/* Enable via PMC_ENABLE register */
+			pmc_enable = gpu_read32(gpu, NV_PMC_ENABLE);
+			gpu_write32(gpu, NV_PMC_ENABLE, pmc_enable | gpu->pmc_enable_mask);
+		} else {
+			/* Enable by deasserting engine reset */
+			gpu_write32(gpu, falcon->engine_reset, 0);
+		}
+	}
+
+	if (gpu->arch < GPU_ARCH_HOPPER) {
+		falcon_select_core_falcon(device);
+
+		/* Wait for DMACTL to be ready (bits 1:2 should be 0) */
+		return gpu_poll_register(device, "falcon_dmactl", falcon->dmactl,
+					0, NV_FALCON_DMACTL_READY_MASK, 1000);
+	}
+
+	return 0;
+}
+
+static void falcon_disable(struct vfio_pci_device *device)
+{
+	struct gpu_device *gpu = to_gpu_device(device);
+	const struct falcon *falcon = gpu->falcon;
+	u32 pmc_enable;
+
+	if (falcon->no_outside_reset)
+		return;
+
+	if (gpu->pmc_enable_mask != 0) {
+		/* Disable via PMC_ENABLE */
+		pmc_enable = gpu_read32(gpu, NV_PMC_ENABLE);
+		gpu_write32(gpu, NV_PMC_ENABLE, pmc_enable & ~gpu->pmc_enable_mask);
+	} else {
+		/* Disable by asserting engine reset */
+		gpu_write32(gpu, falcon->engine_reset, 1);
+	}
+}
+
+static int falcon_reset(struct vfio_pci_device *device)
+{
+	falcon_disable(device);
+
+	return falcon_enable(device);
+}
+
+static int nv_gpu_falcon_dma_init(struct vfio_pci_device *device)
+{
+	struct gpu_device *gpu = to_gpu_device(device);
+	const struct falcon *falcon;
+	u32 transcfg;
+	u32 dmactl;
+	u32 ctl;
+	int ret = 0;
+
+	falcon = gpu->falcon;
+
+	vfio_pci_cmd_set(device, PCI_COMMAND_MASTER);
+
+	if (gpu->arch >= GPU_ARCH_HOPPER) {
+		ret = fsp_init(device);
+		if (ret) {
+			dev_err(device, "Failed to init FSP: %d\n", ret);
+			return ret;
+		}
+
+		ret = fsp_fbdma_enable(device);
+		if (ret) {
+			dev_err(device, "Failed to enable FSP FBDMA: %d\n", ret);
+			return ret;
+		}
+
+		if (!fsp_check_ofa_dma_support(device)) {
+			dev_err(device, "OFA DMA not supported with current firmware\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	if (gpu->is_memory_clear_supported) {
+		/* For Turing+, wait for boot to complete first */
+		if (gpu->arch >= GPU_ARCH_TURING) {
+			/* Wait for boot complete - Hopper+ uses FSP register */
+			if (gpu->arch >= GPU_ARCH_HOPPER) {
+				ret = gpu_poll_register(device,
+					"fsp_boot_complete",
+					NV_FSP_BOOT_COMPLETE_OFFSET,
+					NV_FSP_BOOT_COMPLETE_MASK,
+					0xffffffff, 5000);
+			} else {
+				ret = gpu_poll_register(device,
+					"boot_complete",
+					NV_BOOT_COMPLETE_OFFSET,
+					NV_BOOT_COMPLETE_MASK,
+					0xffffffff, 5000);
+			}
+			if (ret)
+				return ret;
+
+			ret = gpu_poll_register(device,
+				"memory_clear_finished",
+				NV_MEM_CLEAR_OFFSET, 0x1, 0xffffffff, 5000);
+			if (ret)
+				return ret;
+		}
+	}
+
+	if (!falcon->no_outside_reset) {
+		ret = falcon_reset(device);
+		if (ret)
+			return ret;
+	}
+
+	falcon_dmem_port_configure(device, 0, false, false);
+
+	transcfg = gpu_read32(gpu, falcon->fbif_transcfg);
+	transcfg &= ~NV_FBIF_TRANSCFG_TARGET_MASK;
+	transcfg |= NV_FBIF_TRANSCFG_SYSMEM_DEFAULT;
+	gpu_write32(gpu, falcon->fbif_transcfg, transcfg);
+
+	gpu_write32(gpu, falcon->fbif_ctl2, 0x1);
+
+	ctl = gpu_read32(gpu, falcon->fbif_ctl);
+	ctl |= NV_FBIF_CTL_ALLOW_PHYS_MODE | NV_FBIF_CTL_ALLOW_FULL_PHYS_MODE;
+	gpu_write32(gpu, falcon->fbif_ctl, ctl);
+
+	dmactl = gpu_read32(gpu, falcon->dmactl);
+	dmactl &= ~NV_FALCON_DMACTL_DMEM_SCRUBBING;
+	gpu_write32(gpu, falcon->dmactl, dmactl);
+
+	return ret;
+}
+
+static int nv_gpu_falcon_dma(struct vfio_pci_device *device,
+			     u64 address,
+			     u32 size_encoding,
+			     bool write)
+{
+	struct gpu_device *gpu = to_gpu_device(device);
+	const struct falcon *falcon = gpu->falcon;
+	u32 dma_cmd;
+
+	gpu_write32(gpu, NV_GPU_DMA_ADDR_TOP_BITS_REG,
+		    (address >> 47) & 0x1ffff);
+	gpu_write32(gpu, falcon->base_page + NV_FALCON_DMA_ADDR_HIGH_OFFSET,
+		    (address >> 40) & 0x7f);
+	gpu_write32(gpu, falcon->base_page + NV_FALCON_DMA_ADDR_LOW_OFFSET,
+		    (address >> 8) & 0xffffffff);
+	gpu_write32(gpu, falcon->base_page + NV_FALCON_DMA_BLOCK_OFFSET,
+		    address & 0xff);
+	gpu_write32(gpu, falcon->base_page + NV_FALCON_DMA_MEM_OFFSET, 0);
+
+	dma_cmd = (size_encoding << NV_FALCON_DMA_CMD_SIZE_SHIFT);
+
+	/* Set direction: write (DMEM->mem) or read (mem->DMEM) */
+	if (write)
+		dma_cmd |= NV_FALCON_DMA_CMD_WRITE_BIT;
+
+	gpu_write32(gpu, falcon->base_page + NV_FALCON_DMA_CMD_OFFSET, dma_cmd);
+
+	return gpu_poll_register(device, "dma_done",
+		falcon->base_page + NV_FALCON_DMA_CMD_OFFSET,
+		NV_FALCON_DMA_CMD_DONE_BIT, NV_FALCON_DMA_CMD_DONE_BIT,
+		1000);
+}
+
+static int nv_gpu_memcpy_chunk(struct vfio_pci_device *device,
+				iova_t src,
+				iova_t dst,
+				u32 size_encoding)
+{
+	int ret;
+
+	ret = nv_gpu_falcon_dma(device, src, size_encoding, false);
+	if (ret) {
+		dev_err(device, "Failed DMA read (src=0x%llx, encoding=%u)\n",
+			(unsigned long long)src, size_encoding);
+		return ret;
+	}
+
+	ret = nv_gpu_falcon_dma(device, dst, size_encoding, true);
+	if (ret) {
+		dev_err(device, "Failed DMA write (dst=0x%llx, encoding=%u)\n",
+			(unsigned long long)dst, size_encoding);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int nv_gpu_probe(struct vfio_pci_device *device)
+{
+	enum gpu_arch gpu_arch;
+	u32 pmc_boot_0;
+	void *bar0;
+	int i;
+
+	if (vfio_pci_config_readw(device, PCI_VENDOR_ID) != PCI_VENDOR_ID_NVIDIA)
+		return -ENODEV;
+
+	if (vfio_pci_config_readw(device, PCI_CLASS_DEVICE) >> 8 !=
+	    PCI_BASE_CLASS_DISPLAY)
+		return -ENODEV;
+
+	/* Get BAR0 pointer for reading GPU registers */
+	bar0 = device->bars[0].vaddr;
+	if (!bar0)
+		return -ENODEV;
+
+	/* Read PMC_BOOT_0 register from BAR0 to identify GPU */
+	pmc_boot_0 = readl(bar0 + NV_PMC_BOOT_0);
+
+	/* Look up GPU architecture to verify this is a supported GPU */
+	gpu_arch = nv_gpu_arch_lookup(pmc_boot_0);
+	if (gpu_arch == GPU_ARCH_UNKNOWN) {
+		dev_err(device, "Unsupported GPU architecture for PMC_BOOT_0: 0x%x\n",
+			pmc_boot_0);
+		return -ENODEV;
+	}
+
+	/* Check verified GPU map */
+	for (i = 0; i < VERIFIED_GPU_MAP_SIZE; i++) {
+		if (verified_gpu_map[i] == pmc_boot_0)
+			return 0;
+	}
+
+	dev_info(device, "Unvalidated GPU: PMC_BOOT_0: 0x%x, possibly not supported\n",
+		pmc_boot_0);
+
+	return 0;
+}
+
+static void nv_gpu_init(struct vfio_pci_device *device)
+{
+	struct gpu_device *gpu = to_gpu_device(device);
+	const struct gpu_properties *props;
+	enum gpu_arch gpu_arch;
+	u32 pmc_boot_0;
+	int ret;
+
+	VFIO_ASSERT_GE(device->driver.region.size, sizeof(*gpu));
+
+	/* Read PMC_BOOT_0 register from BAR0 to identify GPU */
+	pmc_boot_0 = readl(device->bars[0].vaddr + NV_PMC_BOOT_0);
+
+	/* Look up GPU architecture */
+	gpu_arch = nv_gpu_arch_lookup(pmc_boot_0);
+	VFIO_ASSERT_NE(gpu_arch, GPU_ARCH_UNKNOWN,
+		       "Unsupported GPU architecture (PMC_BOOT_0=0x%x)\n", pmc_boot_0);
+
+	props = &gpu_properties_map[gpu_arch];
+
+	/* Populate GPU structure */
+	gpu->arch = gpu_arch;
+	gpu->bar0 = device->bars[0].vaddr;
+	gpu->is_memory_clear_supported = props->memory_clear_supported;
+	gpu->falcon = &falcon_map[props->falcon_type];
+	gpu->pmc_enable_mask = props->pmc_enable_mask;
+
+	ret = falcon_enable(device);
+	VFIO_ASSERT_EQ(ret, 0, "Failed to enable falcon: %d\n", ret);
+
+	/* Initialize falcon for DMA */
+	ret = nv_gpu_falcon_dma_init(device);
+	VFIO_ASSERT_EQ(ret, 0, "Failed to initialize falcon DMA: %d\n", ret);
+
+	device->driver.max_memcpy_size = NV_FALCON_DMA_MAX_TRANSFER_SIZE;
+	device->driver.max_memcpy_count = NV_FALCON_DMA_MAX_TRANSFER_COUNT;
+}
+
+static void nv_gpu_remove(struct vfio_pci_device *device)
+{
+	falcon_disable(device);
+	vfio_pci_cmd_clear(device, PCI_COMMAND_MASTER);
+}
+
+/*
+ * Falcon DMA can only process one transfer at a time,
+ * so the actual work is deferred to memcpy_wait() to conform to the
+ * memcpy_start()/memcpy_wait() contract.
+ */
+static void nv_gpu_memcpy_start(struct vfio_pci_device *device,
+				iova_t src, iova_t dst, u64 size, u64 count)
+{
+	struct gpu_device *gpu = to_gpu_device(device);
+
+	VFIO_ASSERT_EQ(gpu->memcpy_count, 0);
+
+	gpu->memcpy_src = src;
+	gpu->memcpy_dst = dst;
+	gpu->memcpy_size = size;
+	gpu->memcpy_count = count;
+}
+
+static int nv_gpu_memcpy_wait(struct vfio_pci_device *device)
+{
+	struct gpu_device *gpu = to_gpu_device(device);
+	int chunk_encoding;
+	int ret;
+
+	VFIO_ASSERT_NE(gpu->memcpy_count, 0);
+
+	chunk_encoding = size_to_dma_encoding(gpu->memcpy_size);
+	if (chunk_encoding < 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = nv_gpu_memcpy_chunk(device, gpu->memcpy_src, gpu->memcpy_dst,
+				  chunk_encoding);
+
+out:
+	gpu->memcpy_count = 0;
+	return ret;
+}
+
+const struct vfio_pci_driver_ops nv_falcon_ops = {
+	.name = "nv_falcon",
+	.probe = nv_gpu_probe,
+	.init = nv_gpu_init,
+	.remove = nv_gpu_remove,
+	.memcpy_start = nv_gpu_memcpy_start,
+	.memcpy_wait = nv_gpu_memcpy_wait,
+};
diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
index 9f47bceed16f..d7017b0a0767 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -14,6 +14,8 @@ LIBVFIO_C += drivers/ioat/ioat.c
 LIBVFIO_C += drivers/dsa/dsa.c
 endif
 
+LIBVFIO_C += drivers/nv_falcon/nv_falcon.c
+
 LIBVFIO_OUTPUT := $(OUTPUT)/libvfio
 
 LIBVFIO_O := $(patsubst %.c, $(LIBVFIO_OUTPUT)/%.o, $(LIBVFIO_C))
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
index e6c5b9c703f4..153bf4a7a19f 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
@@ -7,11 +7,14 @@ extern struct vfio_pci_driver_ops dsa_ops;
 extern struct vfio_pci_driver_ops ioat_ops;
 #endif
 
+extern struct vfio_pci_driver_ops nv_falcon_ops;
+
 static struct vfio_pci_driver_ops *driver_ops[] = {
 #ifdef __x86_64__
 	&dsa_ops,
 	&ioat_ops,
 #endif
+	&nv_falcon_ops,
 };
 
 void vfio_pci_driver_probe(struct vfio_pci_device *device)
-- 
2.43.0

