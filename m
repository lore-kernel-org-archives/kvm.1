Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013027.outbound.protection.outlook.com [40.107.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26357397692;
	Wed, 25 Mar 2026 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475024; cv=fail; b=ogsWPAxXlMGf4g7AuqH5geDZkkwK19194YlJM1TWcUoYVY8o1rU48VEwNU7Ba0nJ7mXcJ3UoOWpNAOkrpgW8mZ5vyAlPhGoeUtHyUi2f09N9vsLDNiZjheNIO8N2yMxmeaaENPBOfVtARnjuYD0S2RkxQaKoypk07m1Kw3YlwL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475024; c=relaxed/simple;
	bh=M9KnE+Hl2S4F0ukqa0uLsklnenhvtt/Pno9i1Se06L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bJfOlTS5urmZLUe4pociQE6mfXa+ZK1cj+HHSM3o/SyPNSscoPbDJFKiu2hpmvB9VzPRC8qZ3xWKrqT/iBuD7aXfgnxKxgQ6oNXIM6i5Ulw0iKVP9rUAn90sVXLB0sVoL5YGXNo/yCwQaD9BQoO9VcE9+ItxUDNa0yt6ezw3hLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TXri5ACK; arc=fail smtp.client-ip=40.107.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TXri5ACK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxhlBNpZ6sHD9ZbXbCeWwXA7qjVbwjAiyg0VfDZVzrBMoQA/TxNxLuOD9q2CO8YcU0kzEedwra0HbEDs4eDH/+uTPHrnqwaWD3MD6mu8OgsFMb2BCPazBKlS5wTzb2ykZ4cNQitldNBhGaL18KRVczxBhbpMxPAMARYkT/hAKRZF4LXs63n54BpIiz9uVJBwI7LUlXobbbrvYBKb9oXhwCErc0uyeouRhecNFweTup69BC9uw84VbaORXTPDJHN2kdAEZlg4jqPh0lxeLVPq3zOOOAn4SUmlgOQL2bEgeYoyGoniRDOuv9phw7Zlp0KJPUZnVA0iLA/JUeCL+Y+Taw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SGQH1CIn5Fk2H7x2gmzGhCQ9ki2iwte5Hro8Rrb64Q=;
 b=KDPEwR5dlUyy+7ZMibPJB44HeuX/CFFlb0thQ0f0FSQLJQrsm9ksBE42pE3ejSv3EJ8kyYel1u7+z0dAIYbMk79PZtiP1DgyWsImzIDYiTbsbgrbqsMVRug7ZVaPlkhg8dNQe+K5MLSFeAPOk67xIFnTp4PeTDWkVrAh2AEycTOa8EhYpP6d6Olb25OkaA0al5+lqa/8X6MjSYbk/7qtffkQuiTvcTNDsa1rQylsOoD0fenUmW0sOWoPzxyL4yx72Cc00DxjEl1yAmCMQo6oBXwuXowMBdv8t3J34529w3ZH6THtdvhIQG4astKXG7uq0EmMmh4qG8QmK3IyOktJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SGQH1CIn5Fk2H7x2gmzGhCQ9ki2iwte5Hro8Rrb64Q=;
 b=TXri5ACKXlQG8FObHraxEz4w0RNH9azjlmON/gHtYdRM1vFmKg1+Fx+Rie3PqTC0QEay8jMb40hc9Cf/31ocWrNPKmzmgrs2KJi9bAyCixqeRCQwQCgDzHL67Va3hxUe2t6gOkGIV6meLAEMR9wRZdys+EegLFqXjBa+dDrvXJv2VpnFYNvaOoITXPS7tLXeKPGk84ylhhBLFbn42Leg4pwLiuwPMk6tst93iG3Crii9rlxQcPrOml37EVRzEas0WnLXxXY9XxqhU89CRw8o+132yZMp6mKqg7WFb0RdKdtiX7qjlQGrXuYkN+tV6E0Ce0NGPksZDr6/9qtV49zktA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) by MN0PR12MB5954.namprd12.prod.outlook.com
 (2603:10b6:208:37d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 21:43:33 +0000
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7]) by SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7%6]) with mapi id 15.20.9723.014; Wed, 25 Mar 2026
 21:43:33 +0000
From: Rubin Du <rubind@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/2] selftests/vfio: Add NVIDIA Falcon driver for DMA testing
Date: Wed, 25 Mar 2026 14:43:29 -0700
Message-ID: <20260325214329.464727-3-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325214329.464727-1-rubind@nvidia.com>
References: <20260325214329.464727-1-rubind@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0040.namprd07.prod.outlook.com
 (2603:10b6:a03:60::17) To SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF80B25317E:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 59eba08c-a3e3-495c-8223-08de8ab78fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CiNNvjHf0V9DMt1USUodoCUP8Bn8x4rqP7I4zFY5bnGJww1taACn33vXBb31GcGv/Ya8GrjzNthH56nGWnkcrl97tCuAIg9Th/linHlC/785UljIGIUkd2uYE0e/N/MplmAkIWlf4FceQ50QXI2S/W4dDew7MASOT76B3QD3Jh12n9GukDiIgGt5LchdltVfig4W3LKCUwaT6ZS653BesE4nWCznvryTrXl42UlFfObtyfLBMa1wDAsIN/0Kl6GcpDUtD7X+Kty+ER/RKsooV08aY0U9zp/2+ZQArED/fIyV5z/LeCt5/syCwu8z59yb4nOLIRWrKo2V3bW8ESnfElnOZvC3Ris0kFiQInag9ifb1/Kd5VzhMbMyepArjpfWjnHSizK4viKMlmuO42Ff/I8R83eIhKzPbAaAmEqG7iiwwebD0pD1JNAInv3PxvdvmUXmDF2Tr1hb2SWjHTHlMrUD//7IZ1IVNQ+0COd5I3jTjv/HVNLd9f4V8HLpsITKZRfTaBa1q2ZdbQdEmqRaUTh4Y8/HKvKhWyBfSSC9ThSwr6f3fb9L996wUtuKuVj0Z/x5aShRbWOEjbRx4E8yuP47+FqzcV6lJjzdrALINDREC3fqsApFno8AHq8uE/rlsJkVuqhsW0jL0CZFqSfP04cMxlp8BbpLHSS8CGF7eTjKUiSO3BFouW2TTuz30UOqzJWdc1PRORf+jSY/5giiLdk3pgY8Zi018AXG+VUyg/FD4X8hU8WyR38L0QftkS+J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPF80B25317E.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a1ktpYiXq0Mat+n36E+tA3LnRRZp/ukeUPQXgJx08xfMO67cyVsA8uXBMCiL?=
 =?us-ascii?Q?Tf9ilcyqTDCnfgT04vcAWsSuofsp+OFppovsQyBMu05O3KigTuBroB87bPuE?=
 =?us-ascii?Q?EqWeBO9q9fjdjcaZAFt5Md9U4QFOcw63YR63qbgU3ITCK6I0jqEsB1I7Cbcu?=
 =?us-ascii?Q?NSl0AV/VORY6xYbIqlW1xzvL5HbF117TCBNFtXwH0zYpr/DLKbM1uQlJUc4V?=
 =?us-ascii?Q?DaXvX/27QTV1xS6x0AJnmOSQMB2i69IZi26X9Cszu/s0JGAHW+wMeS9M7U/M?=
 =?us-ascii?Q?RjAB/oad3TEkzhu5n/1soC3ZLg44+scnwMaKSh5IfP9dDQAX5EKLhkDtNpUl?=
 =?us-ascii?Q?baRCUMA+K86d1BP+irMkrgEt5TWZ7nNfs+NjoJZ/5m8u12mVfXBHWouf11e9?=
 =?us-ascii?Q?VvdVaOr2P+95FveUrOMl+9nIj+UZAEBPUoWWj/JkeghZVBQwYsSVRRXbjK1U?=
 =?us-ascii?Q?FoN8Olqterqj/T06lNp0QqxP7H0rriFuJ0KOXoQkFXSjXjMxdNOmRq2i5CaF?=
 =?us-ascii?Q?5YtATEaCXwvix1E3KLqQZrOy5LEMGY7dGKY2Fii/rmavz/ZWLoEX89vBAoVd?=
 =?us-ascii?Q?RNYM1CNlvUZ/gxj4QkdWCpC7xL8PB4f5yjSBuIzwoWfxS3JJUwtD/tKAHpFl?=
 =?us-ascii?Q?WLXn14750idWhoOqgGY63BnL8Lu3uBupWAZOnLOfuBTxq/PGZLM7x9d90Zz+?=
 =?us-ascii?Q?MR2ILUG3yzvaZ24pT39WV/RNzn3YIT2tKuqTov8Bc0srjFWEvUW4Yt09aV6h?=
 =?us-ascii?Q?okUENgp3EPlx9+3ctxkGLIWr1e+Pv8XM7tfjeipVpblvDB5eb3yP6fREFSFr?=
 =?us-ascii?Q?NYxgHnzeupdvTWDXVW7c26weMO0otoNOqBAEsbSPuFo9/WWiumVE6HUBaMjx?=
 =?us-ascii?Q?I7Pk8wQdVOLCslhUzkbPRe6gsg2//qcIjes7supTXsTfTSIlFBJ/cI519Iuj?=
 =?us-ascii?Q?9WzxHZIG1vNaHuD5x5t935FoLxSSVvvs5VAlpB+v7r3rLcirgLnXvL680JUc?=
 =?us-ascii?Q?8sVAhZxvJjr7hOcakfh8jh8LnBsJJmxSAd4V4Ur3uWnCiImQByIdK6PnO7Yh?=
 =?us-ascii?Q?JPVibpHHCk//Cly6txiLfc6yH07xI7aBBTLc+dKQ1sCQKnw0MvonuB9Flv0b?=
 =?us-ascii?Q?Jvrd3XS6gJPxlEMERgMcJr2GTrkYoDa+WzPKyArT2ez4Xl1INnccY9KHC5qS?=
 =?us-ascii?Q?qLGlPw/ijr2Eo9R7nTj9U1F3yZ2O168oOe8vV+Iw1SUqtHKMJqnm2uGAjvuS?=
 =?us-ascii?Q?NeP1aRBe5FVQ9+xqEr1NCC1sfMRKt8zmNlHqDcmguX0SiGWqy22tiYa/L+ni?=
 =?us-ascii?Q?1ShSgOkdOyZ3JDdJ55WH7CMAcXr4Abyoac2QcrSqbaq6GSVCy+S3xV5Sslg2?=
 =?us-ascii?Q?9xX537aUuZEWy1Mj62a0nDIwTYi2x1ebuELC+YVnE4wkbgVfZ1wrzdvrJS/n?=
 =?us-ascii?Q?vXUdhw85T1n+iSG7kDRX0fQUBFWIaWOm8TBC1mUeDnS+yYyLYmxNpNupfzNT?=
 =?us-ascii?Q?IoahknX01RR850l2igufiUcgFY5VZUicXc2XwtA/wbwCQ2eTq4z9TiD5HGF8?=
 =?us-ascii?Q?UvvexxjSlbycOUhe4o3sn+ZiSSHV5ixkoXuD1Ra1LJySHzrTtLaAhM/SeMWV?=
 =?us-ascii?Q?AFtLp2sWlurDUmSogjuxREqU/00guen4IKujGUGZIm/fwzuVku2VjT+NSW+g?=
 =?us-ascii?Q?iXmYjAmO1jK6DGoc8G/G6xtrnwnObG+sWXf3eLPrz+fktzfpZF1LfD2Jv52h?=
 =?us-ascii?Q?Z7qqv+D3UQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59eba08c-a3e3-495c-8223-08de8ab78fff
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF80B25317E.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:43:33.3978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fa2O3I6Jg/LeoKEKna2j9EeROWyamRkcMYZdNOjmOLvRaiRFlMII9AaZJcPDBQMqnVtCqpu9oAUYi57/oqAl2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954

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

Supported GPUs:
- Kepler: K520, GTX660, K4000, K80, GT635
- Maxwell Gen1: GTX750, GTX745
- Maxwell Gen2: M60
- Pascal: P100, P4, P40
- Volta: V100
- Turing: T4
- Ampere: A16, A100, A10
- Ada: L4, L40S
- Hopper: H100

The PMU falcon on Kepler and Maxwell Gen1 GPUs uses legacy FBIF
register offsets and requires enabling via PMC_ENABLE with the HUB
bit set.

Limitations and tradeoffs:

1. Architecture support:
   Blackwell and newer architectures may require additional work
   due to firmware.

2. DMA operations:
   The Falcon DMA engine can only process one transfer at a time,
   with a maximum of 256 bytes per transfer. Since the hardware
   cannot perform truly asynchronous DMA, the driver emulates async
   behavior: memcpy_start() stores the request parameters and
   returns immediately; memcpy_wait() performs the actual DMA in
   256-byte chunks.

The driver is named 'nv_falcon' to reflect that it specifically
controls the Falcon microcontrollers for DMA operations, rather
than exposing general GPU functionality.

Reference implementation:
https://github.com/NVIDIA/gpu-admin-tools

Signed-off-by: Rubin Du <rubind@nvidia.com>
---
 .../vfio/lib/drivers/nv_falcons/hw.h          | 365 +++++++++
 .../vfio/lib/drivers/nv_falcons/nv_falcons.c  | 739 ++++++++++++++++++
 tools/testing/selftests/vfio/lib/libvfio.mk   |   2 +
 .../selftests/vfio/lib/vfio_pci_driver.c      |   3 +
 4 files changed, 1109 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcons/hw.h
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcons/nv_falcons.c

diff --git a/tools/testing/selftests/vfio/lib/drivers/nv_falcons/hw.h b/tools/testing/selftests/vfio/lib/drivers/nv_falcons/hw.h
new file mode 100644
index 000000000000..a92cdcfec63f
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/nv_falcons/hw.h
@@ -0,0 +1,365 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#ifndef _NV_FALCONS_HW_H_
+#define _NV_FALCONS_HW_H_
+
+/* PMC (Power Management Controller) Registers */
+#define NV_PMC_BOOT_0							0x00000000
+#define NV_PMC_ENABLE							0x00000200
+#define NV_PMC_ENABLE_PWR						0x00002000
+#define NV_PMC_ENABLE_HUB						0x20000000
+
+/* Falcon Base Pages for Different Engines */
+#define NV_PPWR_FALCON_BASE						0x10a000
+#define NV_PGSP_FALCON_BASE						0x110000
+
+/* Falcon Common Register Offsets (relative to base_page) */
+#define NV_FALCON_DMACTL_OFFSET					0x010c
+#define NV_FALCON_CPUCTL_OFFSET					0x0100
+#define NV_FALCON_ENGINE_RESET_OFFSET			0x03c0
+
+/* DMEM Control Register Flags */
+#define NV_PPWR_FALCON_DMEMC_AINCR_TRUE			0x01000000
+#define NV_PPWR_FALCON_DMEMC_AINCW_TRUE			0x02000000
+
+/* Falcon DMEM port offsets (for port 0) */
+#define NV_FALCON_DMEMC_OFFSET					0x1c0
+#define NV_FALCON_DMEMD_OFFSET					0x1c4
+
+/* DMA Register Offsets (relative to base_page) */
+#define NV_FALCON_DMA_ADDR_LOW_OFFSET			0x110
+#define NV_FALCON_DMA_MEM_OFFSET				0x114
+#define NV_FALCON_DMA_CMD_OFFSET				0x118
+#define NV_FALCON_DMA_BLOCK_OFFSET				0x11c
+#define NV_FALCON_DMA_ADDR_HIGH_OFFSET			0x128
+
+/* DMA Global Address Top Bits Register */
+#define NV_GPU_DMA_ADDR_TOP_BITS_REG			0x100f04
+
+/* DMA Command Register Bit Definitions */
+#define NV_FALCON_DMA_CMD_WRITE_BIT				0x20
+#define NV_FALCON_DMA_CMD_SIZE_SHIFT			8
+#define NV_FALCON_DMA_CMD_DONE_BIT				0x2
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
+#define NV_FALCON_DMACTL_READY_MASK				0x6
+
+/* Falcon Core Selection Register */
+#define NV_FALCON_CORE_SELECT_OFFSET			0x1668
+#define NV_FALCON_CORE_SELECT_MASK				0x30
+
+/* Falcon mailbox register (for Ada+ reset check) */
+#define NV_FALCON_MAILBOX_TEST_OFFSET			0x40c
+#define NV_FALCON_MAILBOX_RESET_MAGIC			0xbadf5620
+
+/* Falcon Message Queue Register Offsets (relative to base_page) */
+#define NV_FALCON_QUEUE_HEAD_BASE_OFFSET		0x2c00
+#define NV_FALCON_QUEUE_TAIL_BASE_OFFSET		0x2c04
+#define NV_FALCON_QUEUE_STRIDE					0x8
+#define NV_FALCON_MSG_QUEUE_HEAD_BASE_OFFSET	0x2c80
+#define NV_FALCON_MSG_QUEUE_TAIL_BASE_OFFSET	0x2c84
+
+/* FSP Falcon Base Pages */
+#define NV_FSP_FALCON_BASE						0x8f0100
+/* base_page = cpuctl & ~0xfff */
+#define NV_FSP_FALCON_BASE_PAGE					0x8f0000
+#define NV_FSP_EMEM_BASE						0x8f2000
+
+/* FSP EMEM Port Offsets (relative to FSP EMEM base) */
+#define NV_FSP_EMEMC_OFFSET						0xac0
+#define NV_FSP_EMEMD_OFFSET						0xac4
+#define NV_FSP_EMEM_PORT_STRIDE					0x8
+
+/* EMEM Control Register Flags (same as DMEM) */
+#define NV_FALCON_EMEMC_AINCR					0x01000000
+#define NV_FALCON_EMEMC_AINCW					0x02000000
+
+/* FSP RPC channel configuration */
+#define NV_FSP_RPC_CHANNEL_SIZE					1024
+#define NV_FSP_RPC_MAX_PACKET_SIZE				1024
+#define NV_FSP_RPC_CHANNEL_HOPPER				2
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
+#define NV_MCTP_HDR_SEID_SHIFT					16
+#define NV_MCTP_HDR_SEID_MASK					0xff
+#define NV_MCTP_HDR_SEQ_SHIFT					28
+#define NV_MCTP_HDR_SEQ_MASK					0x3
+#define NV_MCTP_HDR_EOM_BIT						0x40000000
+#define NV_MCTP_HDR_SOM_BIT						0x80000000
+
+/* MCTP Message Header */
+#define NV_MCTP_MSG_TYPE_SHIFT					0
+#define NV_MCTP_MSG_TYPE_MASK					0x7f
+#define NV_MCTP_MSG_TYPE_VENDOR_DEFINED			0x7e
+#define NV_MCTP_MSG_VENDOR_ID_SHIFT				8
+#define NV_MCTP_MSG_VENDOR_ID_MASK				0xffff
+#define NV_MCTP_MSG_VENDOR_ID_NVIDIA			0x10de
+#define NV_MCTP_MSG_NVDM_TYPE_SHIFT				24
+#define NV_MCTP_MSG_NVDM_TYPE_MASK				0xff
+
+/* NVDM response type */
+#define NV_NVDM_TYPE_RESPONSE					0x15
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
+#define NV_PMU_FBIF_CTL_OFFSET					0xe24
+#define NV_PMU_FBIF_TRANSCFG_OFFSET				0xe00
+
+/* GSP FBIF offsets */
+#define NV_GSP_FBIF_CTL_OFFSET					0x624
+#define NV_GSP_FBIF_TRANSCFG_OFFSET				0x600
+
+/* OFA Falcon Base Page and FBIF offsets (used for Hopper+ DMA) */
+#define NV_OFA_FALCON_BASE						0x844000
+#define NV_OFA_FBIF_CTL_OFFSET					0x424
+#define NV_OFA_FBIF_TRANSCFG_OFFSET				0x400
+
+/* OFA DMA support check register (Hopper+) */
+#define NV_OFA_DMA_SUPPORT_CHECK_REG			0x8443c0
+
+/* FSP NVDM command types */
+#define NV_NVDM_TYPE_FBDMA						0x22
+#define NV_FBDMA_SUBCMD_ENABLE					0x1
+
+/* FBIF CTL2 offset (relative to fbif_ctl) */
+#define NV_FBIF_CTL2_OFFSET						0x60
+
+/* FBIF TRANSCFG register bits */
+#define NV_FBIF_TRANSCFG_TARGET_MASK			0x3
+#define NV_FBIF_TRANSCFG_SYSMEM_DEFAULT			0x5
+
+/* FBIF CTL register bits */
+#define NV_FBIF_CTL_ALLOW_PHYS_MODE				0x10
+#define NV_FBIF_CTL_ALLOW_FULL_PHYS_MODE		0x80
+
+/* Memory clear register offsets */
+#define NV_MEM_CLEAR_OFFSET						0x100b20
+#define NV_BOOT_COMPLETE_OFFSET					0x118234
+#define NV_BOOT_COMPLETE_MASK					0x3ff
+
+/* FSP boot complete register (Hopper+) */
+#define NV_FSP_BOOT_COMPLETE_OFFSET				0x200bc
+#define NV_FSP_BOOT_COMPLETE_MASK				0xff
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
+
+#endif /* _NV_FALCONS_HW_H_ */
diff --git a/tools/testing/selftests/vfio/lib/drivers/nv_falcons/nv_falcons.c b/tools/testing/selftests/vfio/lib/drivers/nv_falcons/nv_falcons.c
new file mode 100644
index 000000000000..4b62793570a2
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/nv_falcons/nv_falcons.c
@@ -0,0 +1,739 @@
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
+static inline struct gpu_device *to_nv_gpu(struct vfio_pci_device *device)
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
+	struct gpu_device *gpu = to_nv_gpu(device);
+	u32 value;
+	struct timespec start, now;
+	u64 elapsed_ms;
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
+static int fsp_poll_queue(struct gpu_device *gpu, u32 head_reg, u32 tail_reg,
+			  bool wait_empty, u32 timeout_ms)
+{
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
+			return -ETIMEDOUT;
+
+		usleep(1000);
+	}
+}
+
+static void fsp_emem_write(struct gpu_device *gpu, u32 offset,
+			   const u32 *data, u32 count)
+{
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
+static void fsp_emem_read(struct gpu_device *gpu, u32 offset,
+			  u32 *data, u32 count)
+{
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
+static int fsp_rpc_send_data(struct gpu_device *gpu, const u32 *data, u32 count)
+{
+	int ret;
+
+	ret = fsp_poll_queue(gpu, NV_FSP_QUEUE_HEAD, NV_FSP_QUEUE_TAIL, true, 1000);
+	if (ret)
+		return ret;
+
+	fsp_emem_write(gpu, NV_FSP_RPC_EMEM_BASE, data, count);
+
+	/* Update queue head/tail to signal data is ready */
+	gpu_write32(gpu, NV_FSP_QUEUE_TAIL,
+		    NV_FSP_RPC_EMEM_BASE + (count - 1) * 4);
+	gpu_write32(gpu, NV_FSP_QUEUE_HEAD, NV_FSP_RPC_EMEM_BASE);
+
+	return 0;
+}
+
+static int fsp_rpc_receive_data(struct gpu_device *gpu, u32 *data,
+				u32 max_count, u32 timeout_ms)
+{
+	u32 head, tail;
+	u32 msg_size_words;
+	int ret;
+
+	ret = fsp_poll_queue(gpu, NV_FSP_MSG_QUEUE_HEAD, NV_FSP_MSG_QUEUE_TAIL,
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
+	fsp_emem_read(gpu, NV_FSP_RPC_EMEM_BASE, data, msg_size_words);
+
+	/* Reset message queue tail to acknowledge receipt */
+	gpu_write32(gpu, NV_FSP_MSG_QUEUE_TAIL, head);
+
+	return msg_size_words;
+}
+
+static void fsp_reset_rpc_state(struct vfio_pci_device *device)
+{
+	struct gpu_device *gpu = to_nv_gpu(device);
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
+	fsp_poll_queue(gpu, NV_FSP_MSG_QUEUE_HEAD, NV_FSP_MSG_QUEUE_TAIL, false, 5000);
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
+	struct gpu_device *gpu = to_nv_gpu(device);
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
+	ret = fsp_rpc_send_data(gpu, packet, total_words);
+	if (ret)
+		return ret;
+
+	resp_words = fsp_rpc_receive_data(gpu, resp_buf, 256, timeout_ms);
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
+static void fsp_init(struct vfio_pci_device *device)
+{
+	gpu_poll_register(device, "fsp_boot_complete", NV_FSP_BOOT_COMPLETE_OFFSET,
+			  NV_FSP_BOOT_COMPLETE_MASK, 0xffffffff, 5000);
+	fsp_reset_rpc_state(device);
+}
+
+static int fsp_fbdma_enable(struct vfio_pci_device *device)
+{
+	struct gpu_device *gpu = to_nv_gpu(device);
+	u32 cmd_data = NV_FBDMA_SUBCMD_ENABLE;
+	int ret;
+
+	if (gpu->fsp_dma_enabled)
+		return 0;
+
+	ret = fsp_rpc_send_cmd(device, NV_NVDM_TYPE_FBDMA, &cmd_data, 1, 5000);
+	if (ret < 0)
+		return ret;
+
+	gpu->fsp_dma_enabled = true;
+	return 0;
+}
+
+static bool fsp_check_ofa_dma_support(struct vfio_pci_device *device)
+{
+	struct gpu_device *gpu = to_nv_gpu(device);
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
+static void gpu_enable_bus_master(struct vfio_pci_device *device)
+{
+	u16 cmd;
+
+	cmd = vfio_pci_config_readw(device, PCI_COMMAND);
+	vfio_pci_config_writew(device, PCI_COMMAND, cmd | PCI_COMMAND_MASTER);
+}
+
+static void gpu_disable_bus_master(struct vfio_pci_device *device)
+{
+	u16 cmd;
+
+	cmd = vfio_pci_config_readw(device, PCI_COMMAND);
+	vfio_pci_config_writew(device, PCI_COMMAND, cmd & ~PCI_COMMAND_MASTER);
+}
+
+static void falcon_dmem_port_configure(struct vfio_pci_device *device,
+				       u32 offset, bool auto_inc_read,
+				       bool auto_inc_write)
+{
+	struct gpu_device *gpu = to_nv_gpu(device);
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
+	struct gpu_device *gpu = to_nv_gpu(device);
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
+static void falcon_enable(struct vfio_pci_device *device)
+{
+	struct gpu_device *gpu = to_nv_gpu(device);
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
+		gpu_poll_register(device, "falcon_dmactl", falcon->dmactl,
+				  0, NV_FALCON_DMACTL_READY_MASK, 1000);
+	}
+}
+
+static void falcon_disable(struct vfio_pci_device *device)
+{
+	struct gpu_device *gpu = to_nv_gpu(device);
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
+static void falcon_reset(struct vfio_pci_device *device)
+{
+	falcon_disable(device);
+
+	falcon_enable(device);
+}
+
+static int nv_gpu_falcon_dma_init(struct vfio_pci_device *device)
+{
+	struct gpu_device *gpu = to_nv_gpu(device);
+	const struct falcon *falcon;
+	u32 transcfg;
+	u32 dmactl;
+	u32 ctl;
+	int ret;
+
+	falcon = gpu->falcon;
+
+	gpu_enable_bus_master(device);
+
+	if (gpu->arch >= GPU_ARCH_HOPPER) {
+		fsp_init(device);
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
+				gpu_poll_register(device, "fsp_boot_complete",
+					NV_FSP_BOOT_COMPLETE_OFFSET,
+					NV_FSP_BOOT_COMPLETE_MASK, 0xffffffff, 5000);
+			} else {
+				gpu_poll_register(device, "boot_complete",
+					NV_BOOT_COMPLETE_OFFSET,
+					NV_BOOT_COMPLETE_MASK, 0xffffffff, 5000);
+			}
+			gpu_poll_register(device, "memory_clear_finished",
+				NV_MEM_CLEAR_OFFSET, 0x1, 0xffffffff, 5000);
+		}
+	}
+
+	if (!falcon->no_outside_reset)
+		falcon_reset(device);
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
+	return 0;
+}
+
+static int nv_gpu_falcon_dma(struct vfio_pci_device *device,
+			     u64 address,
+			     u32 size_encoding,
+			     bool write)
+{
+	struct gpu_device *gpu = to_nv_gpu(device);
+	const struct falcon *falcon = gpu->falcon;
+	u32 dma_cmd;
+	int ret;
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
+	ret = gpu_poll_register(device, "dma_done",
+		falcon->base_page + NV_FALCON_DMA_CMD_OFFSET,
+		NV_FALCON_DMA_CMD_DONE_BIT, NV_FALCON_DMA_CMD_DONE_BIT,
+		1000);
+	if (ret)
+		return ret;
+
+	return 0;
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
+		dev_err(device, "Failed to queue DMA read (src=0x%llx, size=%u)\n",
+			(unsigned long long)src, size_encoding);
+		return ret;
+	}
+
+	ret = nv_gpu_falcon_dma(device, dst, size_encoding, true);
+	if (ret) {
+		dev_err(device, "Failed to queue DMA write (dst=0x%llx, size=%u)\n",
+			(unsigned long long)dst, size_encoding);
+		return ret;
+	}
+
+	return 0;
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
+	struct gpu_device *gpu = to_nv_gpu(device);
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
+	if (gpu_arch == GPU_ARCH_UNKNOWN) {
+		dev_err(device, "Unsupported GPU architecture\n");
+		return;
+	}
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
+	falcon_enable(device);
+
+	/* Initialize falcon for DMA */
+	ret = nv_gpu_falcon_dma_init(device);
+	VFIO_ASSERT_EQ(ret, 0, "Failed to initialize falcon DMA: %d\n", ret);
+
+	device->driver.features |= VFIO_PCI_DRIVER_F_NO_SEND_MSI;
+	device->driver.max_memcpy_size = NV_FALCON_DMA_MAX_TRANSFER_SIZE;
+	device->driver.max_memcpy_count = NV_FALCON_DMA_MAX_TRANSFER_COUNT;
+}
+
+static void nv_gpu_remove(struct vfio_pci_device *device)
+{
+	falcon_disable(device);
+	gpu_disable_bus_master(device);
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
+	struct gpu_device *gpu = to_nv_gpu(device);
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
+	struct gpu_device *gpu = to_nv_gpu(device);
+	u64 iteration;
+	u64 offset;
+	int ret;
+
+	VFIO_ASSERT_NE(gpu->memcpy_count, 0);
+
+	for (iteration = 0; iteration < gpu->memcpy_count; iteration++) {
+		offset = 0;
+
+		while (offset < gpu->memcpy_size) {
+			int chunk_encoding;
+
+			chunk_encoding = size_to_dma_encoding(
+						gpu->memcpy_size - offset);
+			if (chunk_encoding < 0) {
+				ret = -EINVAL;
+				goto out;
+			}
+
+			ret = nv_gpu_memcpy_chunk(device,
+						  gpu->memcpy_src + offset,
+						  gpu->memcpy_dst + offset,
+						  chunk_encoding);
+			if (ret)
+				goto out;
+
+			offset += 0x4 << chunk_encoding;
+		}
+	}
+
+	ret = 0;
+out:
+	gpu->memcpy_count = 0;
+
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
index 9f47bceed16f..ae690a248a1f 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -14,6 +14,8 @@ LIBVFIO_C += drivers/ioat/ioat.c
 LIBVFIO_C += drivers/dsa/dsa.c
 endif
 
+LIBVFIO_C += drivers/nv_falcons/nv_falcons.c
+
 LIBVFIO_OUTPUT := $(OUTPUT)/libvfio
 
 LIBVFIO_O := $(patsubst %.c, $(LIBVFIO_OUTPUT)/%.o, $(LIBVFIO_C))
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
index b72df578717a..98e610bf0d6d 100644
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

