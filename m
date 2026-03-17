Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075FF5CDF1;
	Tue, 17 Mar 2026 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773783766; cv=fail; b=pfeahXKFj9BY7F7MkCNk0sR3rQI8wY0IbuB0S/AplPjHCfCNhY/ZYHXtnpA3HaZkYOHH34f6huX/A6IbsOKuaQSjWxOsSY9yaLEC6TpcFSvC2SgqNrrYGEq96Zoksqx8dfHhEjkgCkW9urB9fN5QC3ct80Dsxe83MFbfYmW5xjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773783766; c=relaxed/simple;
	bh=CGsRvUutEUODvAV9WORmpXR2q3pc6uupz+phzlTOo2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=p+IOu9dSUJhBwtMfivufrJiTxtb8K4vo+HINsU01F/GDDWaFNW2RfmXG87XU68NIFziZ8gzqJX5TcmTFXF2UDNimIUEOmwiirWaZz/il9s7IxDrbeBDY4RwziMGR74skqvE1DzzJg2n3/oNxNqe9JX7FuTiqht6n3ulBgYgd4BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z/9gA5kM; arc=fail smtp.client-ip=52.101.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z/9gA5kM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfxJV9i+o+lvY7x5eWmREMiHD+zmhNmmjWp0yFV4gSMq/9Vcyq1HjdWwJxbIpJZcosblEqOYGbmhrqAY6eitUhiIQAZ8GvILyN87jt+VUCmhsOTICmsOXoX1UnUF6hfAC2pNr3SZqy4ByvC9T0CHAFuKxxhcIRhv6izb1Gl6qtd6hYP12wPLEigr6mbblQQ06BngdY+IsaQsVNb3nhmwP4cwaak22WHJSkv4k7a4CLc5wAJpI+G81WgkeKFEJFsAK0ShkxwF4dPyYB/jwA0gOLrhOIvBrr0Ti7IyO7751ug6KleeSdpsMAo+lGpTYL0KyQPCuAI8vaqda5NCe5ACow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEsuY82jJJbm4Rm1QVpZez6sTQqFh6S8wJWxeAdEtdg=;
 b=kFmu9JQyllUucvpqzvz6atvsUzdC2avpmsP3z99u9uRNMwjg++qY7BdOZDJs5YcvEBctC3RSrtBTqBsNeG0vbG1VQaHW+Bd8X5zIAThr89icrhoobYPiaMRnhO0YhzFxXZLW3RZNHroeeGiFbeO3NHPOaMoByKPyEr4SGDOpWsc7kqIqmFgkwwv97fGm2U+eo6PxB81DQYJbJVR38+6UP6lar8YVpvTpjf8jH5N8W0UvAPDmRIp2xJDeAC2QIpXtRPXYlxWm1YRsvL7XNIdIhvsYKIZuTZLzKeE8KA71mgR9Gz4yu2joMxx3+uss3XPno4AOS1LsFHErTDIqIKdQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEsuY82jJJbm4Rm1QVpZez6sTQqFh6S8wJWxeAdEtdg=;
 b=Z/9gA5kMNZPfy3Xvn7EOwnAQTo3IIo+blYW/Jc9Tb48atXQTYgyDHkXhoYiInMGHsC7MkigcAGLlXdknLy4lo+lcF1bDflLayRoSET3n6vcqUeIccYm2MucySuXT+E+p6MF21sU5Y4M30X0d7tnNcq1jFg5g+nlQ0+K4GuQcDVEzG/xxl9wxyCafQ5IAVl3Cbnxrefzyd/sp4F1fRmv/2bulHbU4J+MUJ4uZkxBx9/DxSwIBFL/+E6A84V9IGg+lNuFYfb0r/jChTEd1w6i7UKiIuECchLrdDkmJgDuBaVWx/1LT88Z+BmZfogfwofhPoGGjMP+MivVn0tlN6saxcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) by CH2PR12MB4070.namprd12.prod.outlook.com
 (2603:10b6:610:ae::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:42:41 +0000
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7]) by SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7%6]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:42:41 +0000
From: Rubin Du <rubind@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rubind@nvidia.com
Subject: [PATCH v9 0/2] selftests/vfio: Add NVIDIA GPU Falcon DMA test driver
Date: Tue, 17 Mar 2026 14:42:37 -0700
Message-ID: <20260317214239.124857-1-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::25) To SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF80B25317E:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a439148-70e2-4321-bcd9-08de846e1d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5GYl9xdjoR3WCNKa3VkJ4IUe9K3rOTsKLDU/FdWc1M86E6luJeDKJpOCHfsSFWLpvzY+jcxtDciasK0OS+GRWbhilcglnDs/GZ0FCj2xdz2OiQB1DYMBSxe3b55p+M4k7i3VSPh0WUDew3YpfU48Q6Z2DaGYCUGsbxW6u9tVaAhF/RhDgUpA90cWbmBdFODzsJt0IT3U96AkNya4MVQKWPgNtxOQDTzt07QDKfWofD+EDoQ8YQGESi6UlTemojk3ze4svbISKc4OdL8ORDkLCcaAta9NtsETbg7sxY56ACbltbP9epbTvyNy5WoNLwlfMamZzU+j5SHF6yEt/0EmnxU8YyN+jHStpV7lzWBLYrxx94ftrVQDBiRauGfefs3IYn3cc3ZV//C04diPkFrD4r/H2XaXNmM6mbOORh8sBF09IAbC60WAMVdkCQGn/453k45N+7O4TMIIkLLHsHaI2WB3bHDMWbb0RZNxkhvAekimHMeWOEWygf+Cos6jPYasxT/xOBwzvi3y+7MgVkmJfin0T5UnftlIPjTB153/8tEGeGwpaDUQ/DIW4zSjA3wzE0NIWXh9Lq8jEtP+t5Cj2nykY6FK7rZfGNbc8HcjF5XAbj5ImLTp3wZMdcSfb2/yVdPqL8Y8Jv4Dj5nx5fD1EPq1Zy9TMhS0XVgITH6gVvcR92LycsdB/TzamVeEWDBKwYx2g1eLTUyjAdcf52XJxjLnlDaiS/TPjOkcbcYC6OI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPF80B25317E.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dD84tJtwrioS3+V0g6IoDZHKvXGFZhbHryGPWz9dpw5N8K65mDgr9fBXmLyV?=
 =?us-ascii?Q?AqaOJhWbZhDTjR4xec0PM0TWzbpqJ7h06OeTjrb2ILiWbBQTQ2T0fflJd/Nx?=
 =?us-ascii?Q?0hKUPnEvrtFRCmbnOYC4deO89Pb2ha5g5E6npCvCFNnFMuMhLcHlOBis2FaU?=
 =?us-ascii?Q?cZGrUhDZB6zJOyeedRaTMyOh7MaR9cs8+K6ul/4sdYN6LzdvFofHB/q8bYy3?=
 =?us-ascii?Q?yskMhzd3aghIpUTMBn14H/HIZ+VkKTCNHjZEzwuSkS7lN8UfEP/jzLb6ocvj?=
 =?us-ascii?Q?TJ0xoa4LfzwNf12iN/5wnwpnIFKQjeFVd4OfXSpKTZVYlTMP4KvtAa4/fAcE?=
 =?us-ascii?Q?OM4APXkjLyR36jrqbG4iFAr5YopmFbxDJXy43e7QdyL1jZ24gv6SWCyy1Y4C?=
 =?us-ascii?Q?bXjm58CdEyCke6NAxNjOaXQSNjd3PLhPeTmy1SjKLfC65mzbBgHzZQ0BctO2?=
 =?us-ascii?Q?ZUqE9YFsk0KAp8h6r22zkZ883bWZV3bZs/i3Juh6JtLiVOHl/3d/VxBCb5Ow?=
 =?us-ascii?Q?h+EhGJXB4knT/wxWL27sOmCicPGYNHnwkMvrLwCQlpM7GWdSzdTfal3fCGh8?=
 =?us-ascii?Q?+3GD6Dn1XQsMsgKLKlx+rwcphICet0SXeDJnD6VgYZd5NPT90Yu9YrPhI7Ut?=
 =?us-ascii?Q?D0VgyowIPBEbQLk3raqXgrIAoxKsXmQRFHX/jz5udeGVJwrxXpC/3RrBM4y3?=
 =?us-ascii?Q?c3doXHro6vWtEE5zJPSb2i/lfLANjDLP4N0xd3hA2AsqTlGOgrFnQrGzqtDn?=
 =?us-ascii?Q?G2cnbeu67qaeki8Be84Oywt2XunZkkU3BcjC/G8+l2ooWy8YatbVONVmAd6p?=
 =?us-ascii?Q?vbTxL/iL4L6TgjaWbEZNhT4hOVH2xxhkViZLoVlmplkRpss9tM2YNnqtSRyd?=
 =?us-ascii?Q?t1PbSGi/+ZxIPtcOz3hUluJ4ZSB487P7zhGhKmn81Cd03/cxMynZcNwH5Ou/?=
 =?us-ascii?Q?/9+ecVNNUfXvXg+NYPJizv+mjqhBBiSi1y9V1C6yiafKqCv0Fh1GERCuy450?=
 =?us-ascii?Q?dftIusteoiw+SNRMbCsu0PXhMLLXP9rajFeXQ0cYkl+1Pi9ClGcxifj80QSz?=
 =?us-ascii?Q?9GEfHMCFN1ePPJo6oUGTH/9fx5cM57gb5b0AGFY2ClG+XLi9XKcIGQf61nNB?=
 =?us-ascii?Q?dfdlKnImxfwrZZsAADWHtAwVGJBN3Vdwi3m+SgqCGU4Nkc+PdCKbCo7G2u2b?=
 =?us-ascii?Q?YyQQnELfHQ93a1YBd7wnKjgw80ocfmKcYXwFLSzkj614iHI6KtwLkWO8iHyV?=
 =?us-ascii?Q?JZh2Y3rLKGy/BbqyLkUT52vyY7JM5SMJFJuxx0G4JMQjEluK9MglVxyNLJzi?=
 =?us-ascii?Q?ThN0F3h9dsOnvn/4oNnDDDZtuFjnwzQHdaCbA3DePiAnDDmzBDrKul3jlu+6?=
 =?us-ascii?Q?ZL6AxH7Id430QT33oz9RxszOq0qLCTPs3xTfKn1ayBrFZfOpBO7ZZe6fEkcu?=
 =?us-ascii?Q?QrFGLfo05rgmHal9JYu6NEZfQ/EhiK/k5zC2NcEG8+79Rp+Nv8dVbg7MZQvl?=
 =?us-ascii?Q?HCdP4DsJytqkmFMrND73KGZ2307fK1pT/B4JhrLT6n40pUhPgnAbSCnudF3s?=
 =?us-ascii?Q?paKLjqAceFDOjff6c52ViGtMIa8hkCiFJhQzRHtOPk5ycpKwJWeP8lNLPr8H?=
 =?us-ascii?Q?GazjvPVJbXPzIPQduPw4uz7+0iPsDbdYJeaDWXwXpsE0NXLqiJy3Aa0WP/Up?=
 =?us-ascii?Q?Z2xoDNkBMgMfmGXMC1z8keA+xshn1OT0UNV3D6g60BP9bBVRlexql5zVQj9U?=
 =?us-ascii?Q?mGWZWQByxA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a439148-70e2-4321-bcd9-08de846e1d85
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF80B25317E.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:42:41.1359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7IfjZb+c8ykzaR1LN8zvdAwMaNFtOx1S5x5urYJVTOjojjt7U/+D4KNhmhid01BKnsDk1r99QZwyEI4ZSONaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070

This patch series adds a new VFIO selftest plugin driver for NVIDIA 
GPUs that enables DMA testing via the Falcon microcontrollers.

Patch 1: 

Kernel selftests are a collection of test programs that live within the
Linux kernel source tree (tools/testing/selftests/) and are designed to
test various kernel subsystems from userspace. The VFIO selftest 
framework have a pluggable driver architecture that allows different 
hardware drivers to implement various test capabilities. However, not 
all drivers can trigger MSI/MSI-X interrupts from software.

This patch adds checks to gracefully skip MSI-related tests when the
driver's send_msi callback is NULL, allowing drivers without MSI
support to still run the DMA functionality tests. It also makes MSI
truly optional by checking msi_fd validity before operations.

Patch 2:

This patch introduces the core implementation of the plugin driver. It 
extracts and adapts relevant functionality from NVIDIA's gpu-admin-tools 
project [1], integrating it into the VFIO selftest framework. As a 
result, any system equipped with a PCIe slot and a supported NVIDIA GPU 
can now run VFIO DMA selftests using commonly available hardware.

The Falcon is a general-purpose microcontroller present on NVIDIA GPUs
that can perform DMA operations between system memory and device memory.

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

Changes in v9:
- Squashed patch 3 (PMU falcon support for Kepler and Maxwell Gen1)
  into patch 2, as the registers and fields required have been approved
  for open source disclosure

Changes in v8:
- Corrected Makefile to also build nv_falcons driver on other
  architectures than x86_64

Changes in v7:
- Added Hopper (H100) support
- Made MSI optional by checking msi_fd != -1 in ASSERT_NO_MSI
  macro and guarding fcntl_set_nonblock() calls
- Refactored to use gpu_properties_map[] array indexed by enum gpu_arch
- Added falcon_map[] array indexed by enum falcon_type for cleaner
  initialization
- Coding style fixes

Changes in v6:
- Added GPU architecture detection
- Refactored GPU detection to use per-architecture property structs

Changes in v5:
- Reorganized as a 3-patch series
- Added patch to skip MSI tests for drivers without MSI support
- Removed stub MSI function from Falcon driver
- Added support to Maxwell Gen1 GPUs and Kepler GPUs

Changes in v4:
- Removed redundant PCI_VENDOR_ID_NVIDIA macro
- Macro cleanup and style fixes

Changes in v3:
- Updated cover letter to clarify purpose and scope

Changes in v2:
- Fixed NV_PMC_ENABLE_PWR macro value (0x2000, was incorrectly 0x1000)
- Added gpu_disable_bus_master and falcon_disable calls in remove path
  for proper cleanup
- Added error handling for unknown GPU pmc_boot_0 values
- General code cleanup and style fixes
- Note: Kepler cards may not work, pending further testing

Rubin Du (2):
  selftests/vfio: Skip MSI tests for drivers that cannot raise
    interrupts
  selftests/vfio: Add NVIDIA Falcon driver for DMA testing

 .../vfio/lib/drivers/nv_falcons/hw.h          | 345 ++++++++
 .../vfio/lib/drivers/nv_falcons/nv_falcons.c  | 757 ++++++++++++++++++
 .../lib/include/libvfio/vfio_pci_device.h     |   3 +
 tools/testing/selftests/vfio/lib/libvfio.mk   |   2 +
 .../selftests/vfio/lib/vfio_pci_driver.c      |   4 +-
 .../selftests/vfio/vfio_pci_driver_test.c     |   8 +
 6 files changed, 1118 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcons/hw.h
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcons/nv_falcons.c

-- 
2.43.0

