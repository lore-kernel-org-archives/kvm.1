Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013058.outbound.protection.outlook.com [40.93.196.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BAB38D00A;
	Wed, 25 Mar 2026 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475015; cv=fail; b=VQZHjjjPZbUwozZ82XBhv7eVelZVnyIgsV8ahIPfPGkL9kEA58GJ4uYfbIbKlrGDfShb52wVSY8Ubu8dLP3aVkXbsCw8rlXbLbvMzrHLM8PTjWAPEHFXhH5JY8p3IpIDRC6sXue+9fh7nAtNoyRP8+95Qx43JZXlz1+8dO328KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475015; c=relaxed/simple;
	bh=ngDIe6Z5GJGE0OBRpLjOSC2gaDkeic29EsWYqxmwygk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g8yxMA85TVtxuRgFTDHBahAr3KYr+KRjvd0jgcrrZvqjv/Ul1QuSRXZ28L9kQ6+1C3HyeHT1hVO8VDXGXHdYkeFfjPUlajjMGhX2IhfriRX/MAz0GikicunaWseX1ascyvDCKEDkhDjF5w7PzdSLXf5/mtE9fWz6DbmNJkZQxTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KI9+emeO; arc=fail smtp.client-ip=40.93.196.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KI9+emeO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCCf07ZTnz+vITPBbNCccW1izC865znssjG53sIOezYxqJUOLU6djxe7q3FDwIrIoNNfX/5JTKv32IpngqO4kUMVQXAOJDMeGxIAaHCEe+iQapi5eEE2nkPRb2uwIyRhIFYa4/XioIi1cDPjfE0MipdKkK8Sx4kQse3x/wA4PYiZpA4l3r57/Hbh3RIIKMn6p3/RR65t5w1/FhsBDl5SuuTImCY2o36l+g1iKElqy3PtCXH6aPYZcoD2Eh7tMAqrgQwRZZa5DW/Ve/kOJ8z5hGAno5TPEYr/PhgmIdULXK+P/RyV3+GjCS6IhWjBYZUoO9zab6IM5z74uofusRY+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUYN5PYl57+jvnW+z2GubD1MmAgq0PdMIAYePrEB1fs=;
 b=b/+ePYCrh5xApVWAb7MUX9QN/LIabHf+3gLT7xy2aFaLKU2ZVHBaq29pvCUyM+Y+sCvCj3hZIJe8iRdtBPa1a35J4nW/Eu2mK7wpuMEMucdevDHnTHYCwWOhIuIET3FLB7oR/wWaIYWZQ3Fwd4rPyxbWcL5seTsfiTIaYeraUpOZ46qjp5SD01i9kp53pnXZlOWmbHMo1zXD1bqPQ2MBf8BM18ZyAmiHLU1S6CGUHp4Ae/tZGoIanp5ZzQGRg7RdBcsBNrT3XjykoHbHTNtNUYS05fpLDQVU4t+jGshNHtP7d+9/PPiewJ3ZBybQf6XbAP8onPwybK3BN01AeJlOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUYN5PYl57+jvnW+z2GubD1MmAgq0PdMIAYePrEB1fs=;
 b=KI9+emeOX44GS8hDK+LZcGp2SKvYD+0IKEtbdVttiKTYQEWb4pFi9GzT2U2wFhoCA08Z1fbV+LMH+WsincWGlu7ruYUi3W3Z8ZGG93aruxUd6cLX5jXJdjil7PQaL3mRiYQL0BlumekNDE+571KSdVHpvfupF4QSUopPPpBkwlJH25xDjdG8dF5//60YI8f9h0fb+NfuRDtnStIADIdoagxJnLP8fbtq7Y9m18nOzrW2HwyYIz5x/C9vmDWb4caRa/9GW9RgCraXdW0I4AGdOhGdF4ST8IVUQaR4FYd0n9JXN/JdA3o5jHGXkk+XSTnlpMn70hjUiqF/wF5P3vpBkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) by MN0PR12MB5954.namprd12.prod.outlook.com
 (2603:10b6:208:37d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 21:43:30 +0000
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7]) by SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7%6]) with mapi id 15.20.9723.014; Wed, 25 Mar 2026
 21:43:30 +0000
From: Rubin Du <rubind@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/2] selftests/vfio: Add NVIDIA GPU Falcon DMA test driver
Date: Wed, 25 Mar 2026 14:43:27 -0700
Message-ID: <20260325214329.464727-1-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::34) To SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF80B25317E:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 771ab1a9-2486-4ee2-318c-08de8ab78e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	axJ/cLdI8apWudh3fTrMX8JbfkMxUEKVLiID87SPc2H4G+mcWfTPKcRIwPayrAttSFeGxV8quxNdwbeMOOE0s+PvyFZwlr9Yg4fOgDU7BJW04IC1NJDod2ifZbwsYVLRBY5Ge+L0wHUpPpZIP/WyfO7yEqPh7bYBRbOW2zQpS7sxXJO+OdPe8hMENNm83nlrYqpHdK/h+F0KtgUA7BrWpq0DvC2YFNcPYKoNbZ1ZEGCXyQ4rpwW7r9LB9TGeLSOPp7MFd9uVK4EPwhmqsGxkzfhf0zMXa5woh03k+c7/K0Ez4hRwTctlxbuFQpSGPT72LUix8/ciVwr8+X1LVpBFtsfzJA/krvlivKbtZ5u39y7kYFQ+GxHugwA7Y51xva9Pg24VjlegtNxuWTcUjbH7DNcXU4eI5MA4CqgrMciloDKzMa+AtgrQAQU6Ao4hp8PHS2dxfs86n6C6L7JHARarPMG/1/UVx7zQReH6VyklP0t5lbKf2HY+NrAxmtVpX3qws6xEmGpLPgBTL6JJ4H8Xtsa5ELG+FJteMK1YW1JPQZr2IEaicdY7lpD6aEkuCK2qQkO8StMJb4JcAPEIAHnQF0D9zOtJtSLFuzWw92WvbE/AKe3fac/Nphw3Yc4jvtEPWJ6eH3uLDLN1gR4m0bn7o9LBzxSto9tSO8n43IUAL6rmNkEdwIH2hOMJP3CDl/re9YLzmU4CtZSDNz2eV624pzN5/QVI6uo6MVrJRgcPydjYEIJpszOeCHsjgi8rkheJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPF80B25317E.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m0TdXZu8JQbO2zLNfr/JRriZf+sD7DmkZ2vdCotyHfr5EKbwIEoVepiD5bcf?=
 =?us-ascii?Q?iufq8sLnwYc7XzGL089rvNfNfPV70hqOw7pNA1xE41VqAFcquKUoVUBuxrSX?=
 =?us-ascii?Q?PdcrIUAn2DjeIkVvWSVwccW5nRoZ2B1BkkGqgwCY9Kzxh88Z98ITPrF+waij?=
 =?us-ascii?Q?XR6AaQY/3h7Dla+2BiyxZgmWnPabsgChpD48Tgg2YcuzAvOxRloVGdV3GKHk?=
 =?us-ascii?Q?zhEbNjiFG7T1sWd/vLTCNLqaZDuxwjep1+tm5Q7FtwS8eGmKIJ5otDpmH3ap?=
 =?us-ascii?Q?YxwmfE2T06fcBu6W0CI52tc2poikmCLV0P6/P74wDlfH1a7yB36kjZs5zSrM?=
 =?us-ascii?Q?jaxjP5oRyfO5IGHdFtJkY87CRWdXa2fln5LkXE7MmO7DpSqX/xLP6g9DqsFU?=
 =?us-ascii?Q?kRsn1+urodguBzVt5BCGP4H+TaKNAR7kHCZxgunH6NY5X6BDjNTYjjjLgDs8?=
 =?us-ascii?Q?oFCVGym4uff2E10dn6gcMEtIK9870YvbUiS7qd2Pth+TL99aV/fGM0N+gYgc?=
 =?us-ascii?Q?xtxt6EY5G9Cefnubj9LE8ize6AqRhpm0/WSaADKvVBkzokZd3RX85qqxGUrE?=
 =?us-ascii?Q?tmN0m3K3tlgZhVidR2+tjc9z10Hk46DgMI8+VaYBW2GinP63vUIOPlSD3A1J?=
 =?us-ascii?Q?cHRxILw45qtZ8tqyvzgs/Yg8y/tVTWF2h3QrITCM0b+xy9d96mrcKNwVMXdS?=
 =?us-ascii?Q?XXJ9TYdwcFA4rcO+eaHmM+iIMVesx0jLY99mPJd48kfy+ejpzdleuoVN0OI1?=
 =?us-ascii?Q?KK29GBMcARCwDrtDFo8F8xS10OfFQ4AZkQgFbW6ImoCcxUPErhL/Ln90NYOD?=
 =?us-ascii?Q?qwFe1/9jghM0AVuaM5nXhMN3LtsdyKeCKUH1IvXbgC4Pppvf7Cw+s+XInpNC?=
 =?us-ascii?Q?1x4IZ3vVM2jujwgOV4/JIHwaH7aTna8O/g/UuaCDr2xuunIzBW1KtBNgdHOx?=
 =?us-ascii?Q?WfwIxqiE7AxCUNylpjIL7wOBWaocdbi9MnnKa3crJsqsMYb9yQSamUgu0a70?=
 =?us-ascii?Q?BchXC8hmNVgdLdp/mYz7JdcmhSckkWseR1Wglwg2P4+A7BVLXBspnwqkT35l?=
 =?us-ascii?Q?q+UyaRGTIKCS0nOlXS80NsAqorWg44wr1dPBiVf1euhFVQqWPViYRdI+1pXz?=
 =?us-ascii?Q?kXhgbYjWgs2k9Ijo+TMlRk5fhGPc3wR7nxNDYi6om01m+kKDXA0AO14GG1l0?=
 =?us-ascii?Q?Z+O4i8RZRXgbfxDWD17BLBBNd18H/Pt8DUn2Ur5hVw9MQzB8j7F+FK4boBOe?=
 =?us-ascii?Q?DcgC2TyJCHkPvs3RDoQUT5xgwuvjDkm1xnyIDT8dq60xly09WSzR12AzL08R?=
 =?us-ascii?Q?D9d4UNRtgeWiLahCpYtEWPlWVxB0CtIEfBKM0Eg6fnnw8l8hCAJbmh4QW+o2?=
 =?us-ascii?Q?uY72kl3IEzGR8kPMybfXom1UQwoey9UEEKqrebJxHGqqJpLCY8MvbenuBRLm?=
 =?us-ascii?Q?DJ9SxS8o8BwLjBmDjaRxbvNpsah0//bmeYe5hcwHKno/WTFlyPlZQHxTaVjk?=
 =?us-ascii?Q?q98RARrnf/Glb8i5jUq7ohmTtShOgwMidyDJoHwzOgUAvcoM4G/wh/UgfmFe?=
 =?us-ascii?Q?Y+sUQLlE5UMyP/UyYn2CJ4hKc39eIMuIqRML/TWypFz5Iw4Slp7QCE8s3dnH?=
 =?us-ascii?Q?SyWedvaGrsGjCTsjE0rUYse5gq/c4BD6WCaLD+dapUaXp4sFYklFiYxoEuMU?=
 =?us-ascii?Q?QL9pseOt2HB66dKTHlLGfrZ2zJVP2rpMsnIAgO7+TxYZ5++gNwrr0SFwWv7H?=
 =?us-ascii?Q?IRT8FimSMw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771ab1a9-2486-4ee2-318c-08de8ab78e75
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF80B25317E.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:43:30.7936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jX7boFUiUNiwl4cIEGA7NvSinGjLVE7eYbaRepOUWtbAZ4+BHdYcNTh6mM4bNXHhUGUV0DAi6qmed4zvzDynVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954

Patch 1:

Add VFIO_PCI_DRIVER_F_NO_SEND_MSI feature flag for drivers that cannot
trigger MSI interrupts. Drivers that lack MSI support opt-in by setting
this flag.

Change vfio_pci_driver_send_msi() to return int, checking the flag
internally and returning -EOPNOTSUPP when set. Add
fcntl_set_msi_nonblock(self) and update ASSERT_NO_MSI(self) to check
the flag internally.

Patch 2:

Falcons are general-purpose microcontrollers present on NVIDIA GPUs
that can perform DMA operations between system memory and device memory.

Introduce the nv_falcon plugin driver, which extracts and adapts
relevant functionality from NVIDIA's gpu-admin-tools project [1] and
integrates it into the VFIO selftest framework. As a result, any
system equipped with a PCIe slot and a supported NVIDIA GPU can now
run VFIO DMA selftests using commonly available hardware.

The core VFIO selftest infrastructure handles:

- VFIO container/group management
- IOMMU domain setup
- DMA buffer allocation and mapping
- Test orchestration and reporting

The plugin drivers provide device-specific implementations for:

- Probing and initializing device
- Triggering DMA operations
- Verifying DMA completion
- Device cleanup


[1] https://github.com/NVIDIA/gpu-admin-tools

Note on version numbering: v1 through v9 were internal review
iterations that were mistakenly carried over to the upstream
submission. Apologies for the confusion, the internal changelog
has been dropped.

Changes in v10:
- Replaced NULL pointer checks on send_msi() with per-device
  VFIO_PCI_DRIVER_F_NO_SEND_MSI feature flag
- Changed vfio_pci_driver_send_msi() to return int with the feature
  check moved inside, so callers branch on the return value
- Added fcntl_set_msi_nonblock(self) and updated ASSERT_NO_MSI(self)
  macros that check the flag internally
- Moved DMA execution from memcpy_start() to memcpy_wait() so that
  memcpy_start() stores parameters and returns immediately, emulating
  async behavior to conform to the memcpy_start()/memcpy_wait() contract
- Split GPU_ARCH_PASCAL into GPU_ARCH_PASCAL (P100, PMC reset) and
  GPU_ARCH_PASCAL_10X (P4/P40, engine reset) to match per-product
  reset behavior
- Minor cleanups: improved size_to_dma_encoding(), fixed DMA address
  bits mask

Rubin Du (2):
  selftests/vfio: Add NO_SEND_MSI feature flag and MSI helper macros
  selftests/vfio: Add NVIDIA Falcon driver for DMA testing

 .../vfio/lib/drivers/nv_falcons/hw.h          | 365 +++++++++
 .../vfio/lib/drivers/nv_falcons/nv_falcons.c  | 739 ++++++++++++++++++
 .../lib/include/libvfio/vfio_pci_driver.h     |   5 +-
 tools/testing/selftests/vfio/lib/libvfio.mk   |   2 +
 .../selftests/vfio/lib/vfio_pci_driver.c      |   9 +-
 .../selftests/vfio/vfio_pci_driver_test.c     |  41 +-
 6 files changed, 1142 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcons/hw.h
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcons/nv_falcons.c

-- 
2.43.0

