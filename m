Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011052.outbound.protection.outlook.com [40.93.194.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218CB2FFDE3;
	Tue, 31 Mar 2026 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977779; cv=fail; b=OkekGS0JFAEc+q6G2SWpZdLz2ik2+1udKszwJDa1l4ZTclf3rHwCwKCLIvLCBYjpkws7dWp+NJfv/Cn4Vjq4iRbgxeCrrXlRjKSJBI26F2UtO5JVqU53l6aikaOn0t0JGtMBATPyDULTimnf1XcyabANHfiHg6yDBDIHxxMv3mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977779; c=relaxed/simple;
	bh=xqy2hc7/YfloKK83mbuRHwkD2UVF+yjF3cLKWfHMzPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RdK5C3fp7E5kSLCPdKKVDwFsnnrd6isp3H5fBsd6NPJ19sMWqO3+FNRQc2a3aRmmlPvck8fOB3bRHIxmMnwx//WnUJNY3P5GvDabtkRH0YL8p7PEthfw6guamVJVmcR7Rd6IyqcW6tXoje/wVqWR7RAUGyLzhxBkJyniWlHZePM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hVzjk0wg; arc=fail smtp.client-ip=40.93.194.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hVzjk0wg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyS4r3JLDA2xscXkZVRDPwNc+5SpwqMpDNrKYRZixmVUi2cOaq9al7BAKm/S1riAk5WYcjMF5D2SWi4iJ/VSPQKW4OdORiI4JYYXNN+MsU0Vf74zsuS/tWjmpFBNmcci2EpaPJFcFnkkPxqvsEx2x6XIPX3vitnfxlm6n5AnGiCxqB+J3XaTfEnofYmKMtcT4vEOxexAjzBt0AFk4b0q/ZSyg3KZenFmDZ0EvWWYZrLo6MZqcl+FZlRbVUBSq6c4nII5GlSSahm/sR60fpc5vXbTPw3cpzLYUJsDxDuUc0LiLHMSYgGKI4pzK9lMOfN1UgQTvzvpZpmR9uylQwyqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzPG677dLz8lavcdSwMShzidqU6AwOq/AK7U0ViJAn8=;
 b=Em+ps4vZLqK1F2fiB/F+RsW4RLJCAJYXul2IGi8tteQ33P2JVdNMJEUJyk1aTUFR6e7Pq1uiGq3UiJLRx5LD/DRxctc1AdT3eCG9/jV6abg85/qdgUsy/pyzG7lVz5B0gZNUQcrtu63RQIZM2j+8vvC0FqagNAEPALNq73aIAVhEAsc9lUkayPTj8Ikj6q+iqGsIfKU1WCYgd7kcII5tEZk+IimXAfONmjV/M2hdwZmW8ZTQVh41ujQF8zmH/w0FcYefHw25ACpJcMS/+gXFFtjpDTma+xyznZUIWSqSyhPaTxTuMT8PM1NFq950N7x6ffYKPSz4qKmexiZ4yPc4/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzPG677dLz8lavcdSwMShzidqU6AwOq/AK7U0ViJAn8=;
 b=hVzjk0wgQSjR1btVH009pbppglVNrcc7lUmRJysolpTwkcZ5BJVfjhkriOuER8cf7q3SS6b2hqT1VJq4i2Bd93zclcMBr3Xfn1XDRpuIl9jWuP2/pBIAgopK3s4TBPM72usGQJe9OWDuocHMtGPju1P3y1WYdQOnTxUfpUm7zR6RX7DQffsT60PVzEaEj8UczYa1B0r7KeGyczeYvipXDktWTYQZggrtjJGF7McSmN6hwgymKIZIrx2pDnr6vk55+hUKDV9TnjIiLescBcfxZc9q5GNUsjOcCnqLPwSn8U+3upbaKiyIHr6UejRDsSOR+nROWfE/yqhx0D9aCRbISg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) by CY3PR12MB9678.namprd12.prod.outlook.com
 (2603:10b6:930:101::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 17:22:46 +0000
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7]) by SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 17:22:46 +0000
From: Rubin Du <rubind@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 3/3] selftests/vfio: Add NVIDIA Falcon driver for DMA testing
Date: Tue, 31 Mar 2026 10:22:41 -0700
Message-ID: <20260331172241.50456-4-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331172241.50456-1-rubind@nvidia.com>
References: <20260331172241.50456-1-rubind@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::42) To SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF80B25317E:EE_|CY3PR12MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c584f45-9118-4109-3edf-08de8f4a2047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7xyKsP9A8bK1EfP/uXNSt0vmgGI4GlpuJd4HjDYxgqCVzQ+ATko7/LhRFfEsJCETThfZau8jj40Ea1E0/Akn2oqVnHdw2pt8GGLA3fL1WY4taanhIOMSZkV2Jd9LRPsLU7LBym3fMWNBByrLlFtGWhmdUqqvO9vn4o7GfkZJfT0qoq1yrQXINSq2NgZbEzRNiBkyID/I/aULzDCgFQVrg7E83fHYGiOTB7sDQYGzJKn4fUjjmIQuYlYemr1r9fb+xyqg3Z/nCXKRM+QOjmkw8sjOwqdwT1OaRuFT/okdU+LYfx3rJvpMN5WjNX/4gLjblpIA1k/u9MMrCAAFtKQ95k/HUo8eRmwdFu6dUe0bp4AOnF2RPl+PIZQZ/QyxD2JYjENT0hnhEbx8siwaTVvaPWOKbFyNcsolhRK6im4A3BnhWUgS+Za0rC5A/QxOMi5cOawPyxt8rlBioiC7X/u+XfCbfUAXyLmsrsTwLsDA/AnKBprMHhNpFbedWbw2kZxfbKpqk0Wk5zLkRxQiMccVqfccuEU58rxM1/9ekqRSd6XTEzxpKGMzlNeUT7oLkETHW82brmuF15GrVk+y0Ccf5XLhup3pvAh8KuVpSDd6kgK6l5JXrqpWVpuTEg0PSduSr23e0g8OCn3vaWMp53yf7Z4Y55QVSGE116B+N2Z+lKKeoHLXhhTEomAZa2l5B+x0KJc5BKIIOTC6asoeVLsXSe5S/6qQZI/DF14LeDxvjr3bnWgFdBMntz44gBIO+9N6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPF80B25317E.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5WhE8rp4oc8nZmivJqPEfEHBWVjkp0a+B/rzG9yZVzxI5dpXrCKvPqT3DFx5?=
 =?us-ascii?Q?oNFm3zZQItUhx9BKVfX9tIqHXwF3Y+GPp2/mDyt/njV/LGFl70yfWbskagW6?=
 =?us-ascii?Q?LIZybADXjO1zNVGzuvDXrb2n39TS+Ol99yiw97frTGPHP5TpjxreT40aJZlY?=
 =?us-ascii?Q?lu+LHhMXshd553GfBUawvZgHuHCBiK7ljdTplQSJVuLlqe8Xh9KWHcwtTr8o?=
 =?us-ascii?Q?CkTi+gDfJmijlZc72zUlb90+GBvMPoT1d/8q8FvT1cZocHfP+pIs2O5H7ztP?=
 =?us-ascii?Q?bT53/lrxmOtfZ1i+r4Z6EjBhL4agaTg8smdvYesPwNhYowC2ssBTdMoIbJAA?=
 =?us-ascii?Q?Ier1kUWeOyfssCcHUEtqoyxfILujSKgYCtnJfyQ94EEYte9mFlFgPHCq4uvl?=
 =?us-ascii?Q?TjApy8Sc4tdlDZxDQuOhcAziw+0i0c2wc/S48k1hlOuBNVejDnWQajruHCtf?=
 =?us-ascii?Q?CTYubJ5zjle9TN+Pf1zlkukAPbUJie7DU0W2HXK/Yoiofu2kzpSicKTbULRS?=
 =?us-ascii?Q?QeCxYn03IywoIL2e0zIGTAkbC/wY1ZXdpxv+rgltw1XL3BMmzz/jJW2mtFR+?=
 =?us-ascii?Q?FqSrH7bAC445mIHD2gHnTIi7RiOiwyaHYgtPOXrILThdIbQpquq+jaimTVFl?=
 =?us-ascii?Q?rGM3VwMYmAprn16rLbgPYW7DyvXoPfkRee0RLP83SEkRVgj5LZXc1Av7umRI?=
 =?us-ascii?Q?lEyTbZoKEBVlrI9x7EpIaY6HP54aIuUAc8NZTJatZ7hyBykxOwNgLEMize4r?=
 =?us-ascii?Q?4/ZvH25/IHSh1D5TeEvXe8FBUOvvg7LrBzilIx3G+bCmS+qhNHEVklBHmO/y?=
 =?us-ascii?Q?VZBTZ3aD3GR93/QWaurJ0ceUDvl4yAS0OLPC+ABBT7oGqqeplXK++iLRCb1r?=
 =?us-ascii?Q?b0wfh4aEXXV4NgHhlC853phS5MeDsTg8yS4mbERyeHEVVLRU4rJHuHatxFl4?=
 =?us-ascii?Q?M6iEMXGuK3XJwBpJSEym+KY/LUHyJuz/UiOXvfLwKVTovkq+FP9w/DJgbQqG?=
 =?us-ascii?Q?bsx/grPwNSY38HUBXHMX0unM9vsIcT9Akg56ARphRKzlt6AI+qUtjZL/LEY1?=
 =?us-ascii?Q?pFDiqQIeaEN//GHGC6M9qx9peJQWwS4C30/djBlcH/my4pUBM5mMBrROjS6D?=
 =?us-ascii?Q?IBbCxqpR+f0ImeH9k0I/foMETPxYCGvl0XGkOZGCnqvSm+DGiUfa1PQCix1T?=
 =?us-ascii?Q?bzn7U+7kgjtjKzrc9kgQKk9ri2Z2cTAX48pocoPGK7OHsQxqARb8jeLwwTKS?=
 =?us-ascii?Q?D3f8qsbsCxxjzD/fyYpiXdxsUFHzkS4SFTyFYzCSf4VL0w2GpzviFr8dDDSY?=
 =?us-ascii?Q?lDGvu69eIfAUt+j33sdSjb4XWnAOfesIdAYhAY1ozI2RwXVxhxfd0mOg4pBY?=
 =?us-ascii?Q?FWKlEwsFJqE7b72NuTtYf5ZhzbpT7WQxLsAN+t3mzflY39ahIcDnL/99wjhd?=
 =?us-ascii?Q?1a0C3cPkw3ZDaRxEz3UP9ge/JlAzFfQbyBjNxCHbA8lMy7HZEaISDLUmPG6y?=
 =?us-ascii?Q?HoIvaZ77sdCBvZRifz+btyB90pz19+IamPxK89vpwXPDQDhp61DbP1h7ZwqA?=
 =?us-ascii?Q?Rr5/2qFfGe4o5T67Llyz4VEq8hHXG9VRQ6eckI9ASXPAniRoZ8fz25ZV0Q4d?=
 =?us-ascii?Q?J2xpmptAofvW5MwuzqJpvVJD2QH5Ksn9yYnpjEvKlKVE8H+5mH8Vl2StjdAN?=
 =?us-ascii?Q?65cTveBmRwk3hQZPA8c3y77SoqqpkcphkrTICGpSgRynU6+xNy/bZXwX+O1r?=
 =?us-ascii?Q?+qLovL0PwQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c584f45-9118-4109-3edf-08de8f4a2047
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF80B25317E.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 17:22:46.6841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4T+/tIyxlInZF2xIIgyMEe1RNdPKfST1QTb8FPnYi/WxM8YKRTYP9QwLx1Z044hBPkaApy3cQLg9NzWop/FZXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9678

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
 .../selftests/vfio/lib/drivers/nv_falcon/hw.h | 349 ++++++++
 .../vfio/lib/drivers/nv_falcon/nv_falcon.c    | 755 ++++++++++++++++++
 tools/testing/selftests/vfio/lib/libvfio.mk   |   2 +
 .../selftests/vfio/lib/vfio_pci_driver.c      |   3 +
 4 files changed, 1109 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcon/hw.h
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcon/nv_falcon.c

diff --git a/tools/testing/selftests/vfio/lib/drivers/nv_falcon/hw.h b/tools/testing/selftests/vfio/lib/drivers/nv_falcon/hw.h
new file mode 100644
index 000000000000..feafa8edccf3
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/nv_falcon/hw.h
@@ -0,0 +1,349 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#ifndef _NV_FALCON_HW_H_
+#define _NV_FALCON_HW_H_
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
+#define NV_FALCON_ENGINE_RESET_OFFSET				0x03c0
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
+#define NV_FALCON_DMA_ADDR_LOW_OFFSET				0x110
+#define NV_FALCON_DMA_MEM_OFFSET				0x114
+#define NV_FALCON_DMA_CMD_OFFSET				0x118
+#define NV_FALCON_DMA_BLOCK_OFFSET				0x11c
+#define NV_FALCON_DMA_ADDR_HIGH_OFFSET				0x128
+
+/* DMA Global Address Top Bits Register */
+#define NV_GPU_DMA_ADDR_TOP_BITS_REG			0x100f04
+
+/* DMA Command Register Bit Definitions */
+#define NV_FALCON_DMA_CMD_WRITE_BIT				0x20
+#define NV_FALCON_DMA_CMD_SIZE_SHIFT				8
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
+#define NV_FSP_FALCON_BASE						0x8f0100
+/* base_page = cpuctl & ~0xfff */
+#define NV_FSP_FALCON_BASE_PAGE						0x8f0000
+#define NV_FSP_EMEM_BASE						0x8f2000
+
+/* FSP EMEM Port Offsets (relative to FSP EMEM base) */
+#define NV_FSP_EMEMC_OFFSET						0xac0
+#define NV_FSP_EMEMD_OFFSET						0xac4
+#define NV_FSP_EMEM_PORT_STRIDE						0x8
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
+#define NV_MCTP_HDR_EOM_BIT					0x40000000
+#define NV_MCTP_HDR_SOM_BIT					0x80000000
+
+/* MCTP Message Header */
+#define NV_MCTP_MSG_TYPE_SHIFT					0
+#define NV_MCTP_MSG_TYPE_MASK					0x7f
+#define NV_MCTP_MSG_TYPE_VENDOR_DEFINED				0x7e
+#define NV_MCTP_MSG_VENDOR_ID_SHIFT				8
+#define NV_MCTP_MSG_VENDOR_ID_MASK				0xffff
+#define NV_MCTP_MSG_VENDOR_ID_NVIDIA				0x10de
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
+#define NV_FBIF_CTL_ALLOW_FULL_PHYS_MODE			0x80
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

