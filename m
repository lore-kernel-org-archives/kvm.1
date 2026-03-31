Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6131345CC0;
	Tue, 31 Mar 2026 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977767; cv=fail; b=RuOK9MCtzAoEYkJ1aDUW6O48V9m/oNHd+R/Hg9SKIEReWu0S1vQfh8bhJyoMrUWOnTVc39yZJqiPCGr57AC8IM8gSXBMtRWaGyIba+hqz1bc+oTIdws9HsXToyz8KGxiEnyN1FI8B/Y5L3YOAig0JmAYUSCDRpelCxtgv2vV4UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977767; c=relaxed/simple;
	bh=XNRVDUm4ohyfehWzrIrrekmHDFsAzXbGqLuv8HY9vL8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pSeBGKcgpxckWFlNzA6zI1asPmmZ54ar8dUxxxGpNGnQw3wbHxdBZVxEECvW1CGXVSbCzPd6JuYutyhgibtQmK5kZZ8hzviqjg0rrs88Xm/iXTOM0P8dvNQ5tz76W7EdLZOv+y7U5EXSdPEfFnlc39Q2sZIqsCZpvvi2a32+XJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tyfs2Z5P; arc=fail smtp.client-ip=52.101.48.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tyfs2Z5P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfhO8yHIMTrjXzRRfpOBW2shpTVEGREzEBUDr1+c3xkHG3D7UfnwauJtHd7wpZvLMRtj3I0wqKdLr2xXxSgt1/62MzvzqQZMWFKUkoJ7hWjozHh/VWfgDQxpyYdo/Dhwb3YWcAo25jZNT8Im+WpRZi8qkElILjfIgtd5dAce9FrTt/mMuwuMp71tM4gthLi7XyHzli1XeFTQ1aAAXEsCDPFmLbOyNkuAoS9CwK3hVgWRRIIgAFODXK6YwFl6VuH0xKUpCJDCoKfbRklV4r9tPlyQkihhqFTNtLbwaCbsBcwE+A9fxygs7s8U7mTCTrkwZ2g091C7igUCXTPvINUX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWVjJYpTF0lQpO/vn6U5NltGCUI0O2AwvJDKwcwq9Os=;
 b=INfCwrfXlA+mULUWrYryM5roQIQndKY9+4WaMlD6G9G+ZO7+jXguSuUJVfk0OEKhccNYpH9kJFgpagqjxQHug7e2RaMDcBf1gSRMsmPLP20hYd1q6pFkVDYxr5hgsNX24dXgcLHUrUp+v23HXRTSCfdLkIC0iQPHun3j3BlU0Nah1WWIOlFuCleForYTWb2Ghl6oN8hRdtBVJ/aAK4FuHm4eBExtdwJ3whbqZNGDOpmA5rc+0VjgCuEZjXe6JeA7ZQoohbaqx/Oa5CllERur8RkvBpi/Jwj66XdvjKdUrlss/FJnsD7Fe6XJO6K3WTtD9CluX560AwCO6cYBn/y1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWVjJYpTF0lQpO/vn6U5NltGCUI0O2AwvJDKwcwq9Os=;
 b=tyfs2Z5PomSBV14B1bKWgHzA/rknXvKTIcYi4P7EYrF+f4koM9jlju/P+Blc/1FyAFT58cXK05meM/WRgGG5FqUsUPUA9C7BMX73rmZLSFo3MvyMFs5dxO7ispdpv9Ag7x7CHU42IBnOCFVKjkM32pdASrFCdlU6aa/wSwlpMooDy+9qwA9eWgKkwBknB2YpYY/XpcNhL0bqtN1Y3B9Df1sgNlMCq8eQvgJrzvhyN3AlHQV1gsaqiTltUoKaXwGj6Z+YYxBXYlaUpbX334oweHenpNbcTm8eKVWUgYydCylgDnWJa2lUJFQel8/rIaOGgYyp0HnwfF0gB224vzgCFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) by CY3PR12MB9678.namprd12.prod.outlook.com
 (2603:10b6:930:101::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 17:22:42 +0000
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7]) by SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 17:22:42 +0000
From: Rubin Du <rubind@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 0/3] selftests/vfio: Add NVIDIA GPU Falcon DMA test driver
Date: Tue, 31 Mar 2026 10:22:38 -0700
Message-ID: <20260331172241.50456-1-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::35) To SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF80B25317E:EE_|CY3PR12MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb751cf-c7db-4767-63b2-08de8f4a1dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	z1KGcEjqlhZAemfPpd0PtpymB8m7nRJpEJI8p6CvCN2KfgcuCY5tQT4tPZy00ZDam/e+nkpcYU92/hPw2xS/uI+hey5aXxrX44hzYE+YqWloEl6xQzPFqpvgAsuamgA1Ejr4l9Ozw0ddPu8yxxskNwhPrlks0vA4mF9b6o+d9FydZw6StNqLNuFgm8FtV+hbOijx5g8doeA5zA+pCg1OpZJP5/ihTiZpQFbkr/aUPDqvLZisc/+5Os6n7+66MlNhknWOoAu1ObD/lYdMaRMdJkmWDaJLGRuc5BUw8Yte3nWlHSwwdFGsVpJ1qS4CyeJJPC420LXyrE82k7n4nElehlfgVRxPTm7eG9QGSZlAdBbHDHJtSQpcmw+lpyMa5Mmvl31D+8lVhWgusR9G0QgM7VNLEdgxjWukTZ9J0vzb/yzHmaf8P54/Ha4NdGpB8QTTVMHj7hHQ0YJUkhJ2A5mZT2U2qUuNGaOC0uXg2VoAHMzFun/8onxSfEjooJZYjY7s3tTMDJ+PPNNOkMvN/I2FcQ8t4Zpp857movaMNnQpFFT5FgxrQ2cE6eFED2yio5Z3dC1YZKDWj57+UFT/QLmQFxDIEZd3E0m68fjLJ6p+zVO/kpTWO04rBhdBC49zcfxi6RxQolyefgSipeRqKt8yr1AsawcJZEy1SufQQR5o87mlN23hiOXazJ7KQaEYpTX/brLkXp4CCyvXEnIcvCumY5zHhtrIobyjfM5ZSWIDzDA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPF80B25317E.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U7qLH9Pp47Qde0oN2wYFu9nal8TyCRkxAtNfkxlQqUnwymu2tK3x86l4CaFm?=
 =?us-ascii?Q?sok2GVp66ckoTlN1jH4B6XgNYwhCfDiaHCi4LswRJIWx7o6KKsP1/WvylWem?=
 =?us-ascii?Q?fWz8tlI1mAdgpgC6yxFuxiNN+zlhTv4Xmfkab1eDyL5KOHs9v4BpkFLZmICb?=
 =?us-ascii?Q?al9R2D4uN8U5WwXfEIBgFjvdAV1b3ni4f8RDg2wpxPUxMP7wWEG8W0kQMj5z?=
 =?us-ascii?Q?fOngEHsNPjPltLANf7DCYF4iAzt+/PsXz+lQV63KTBaZPVC7lNEOQd94kqLE?=
 =?us-ascii?Q?fAF/sc/c99frgRiv0gYDQQyv32Zjp2gMpQnvpAywCkHOM+Nb01g4LOmYiBsQ?=
 =?us-ascii?Q?jjdja3bEhgPT2301gTRocUivjx5HW+nlqPRYQCTWYNrTDsCf5oy2Kz7dcJWe?=
 =?us-ascii?Q?wVEvcHwSji3hZwx6EmQAoBUifXdGqSQWEZQDS/oLosFPSr+wtkiB8lIjgkul?=
 =?us-ascii?Q?3NBkV5pXfkRTROB4Y/DoDABN7BLu5/x2nBf2JZsf7U4K0+kCinRIbjB/pH62?=
 =?us-ascii?Q?Nf3H1NTOup4nvPDGzkrWzAAJypZfBp/1vF9UKlkYo7MnKPmvz50f0MRTif1M?=
 =?us-ascii?Q?Xd/uP/HIYUnUJKx7kVvG6IgqitrWjHHnrJvw0Ghve43ZLVACuc3/SIM2JHn9?=
 =?us-ascii?Q?0E+h/igrT+6xs3n8QpKHJN64h7vSBveqfYTzZAGyTBb+CWHhuX0dz9WSEOKt?=
 =?us-ascii?Q?itvD4mVUX+ONjKxLXz8brYT91HfTP8JM1UCy4lMHvXIB6ZvEGywCOdyej9Jn?=
 =?us-ascii?Q?kNNO9DMmVcmYB9ui3/JEkn35XeSuT0kAgl55a9E3APD4c90AVmhXeaS5fPVq?=
 =?us-ascii?Q?g57nMjfkfvXy3pYW894N+tNtVIqtiWU0K7qQsjit198xHTThDa6OaStF9ZJA?=
 =?us-ascii?Q?6o2xYi0ZA5FW22yPgtUCqB8mlzl7XB2hsFgd1/OfvSZMGbYmAgqYO9trBmuT?=
 =?us-ascii?Q?4yW62I80AUCubuHdRyBLY0HpUTOAKqVEgAoqYBMPAMZLcJwWb1LilxL/6ib7?=
 =?us-ascii?Q?IXvU/sUz8InSIfQq2NoWGQjSLpAO2wtyUi7LFr8mSew6haQ+FJyWxBoPIoGd?=
 =?us-ascii?Q?QbEnNmH3vJdfiRVVB+U/p/1Yk1Un6MxXz5PvseRfTvbGi+X/hcHjq/wr7qcm?=
 =?us-ascii?Q?74zBtCh0UJruvpDzIHcYnpNBSM1bxOJ/nquPCJV+nGB4B6VBuhWDwCzksuUG?=
 =?us-ascii?Q?vrKX0v7o18O7PE1DDYZBT31XWE/YMvLoxW7AgT1KIWVm7KKbebMS5q+58o07?=
 =?us-ascii?Q?hGSPVujIoSSkraSIXvHE2guGOUl/g95QVOv6+UvkUVp1kKnhYUnXgJHfdwTp?=
 =?us-ascii?Q?Cbp8CXFx6ljQnH7jiVVJ9dI4YuaE1fjDaMEnSCh2iKhbKSLR832aqbT+Lg6B?=
 =?us-ascii?Q?OUgTwDy0x7FUD4GP9mkHfIC/neJEqasmXTNZ2vNX4MlM+aCC6YI3SDns6+R7?=
 =?us-ascii?Q?i7r7rgQz68/PKDH5YSbjIZKphn2NxiN2HhQq8MPo/aqfDQdiWyrgN1IPsKO9?=
 =?us-ascii?Q?L4ZQu+KGzj7EDkmsQoGVCJuKRf2aiy+pOrb1AXiyj4GrWApsGNCDcFDOsh3k?=
 =?us-ascii?Q?1a4NlvNu4Xj2aPmQIbIht7PKK9Gr9NHByZ1bn5dFX2wBKpxGstQyXlxRiCDJ?=
 =?us-ascii?Q?a2srwSArDOGR2AVQVOVtatBKvNmAe2sD86GehQlB6x/L3c93kKChoMDqXgmd?=
 =?us-ascii?Q?OFIXmrmHDMqL2UKbTGcSPiTBeNRSdyRyEyRY1N9kwiWPSP6HJzrW9bRloSP4?=
 =?us-ascii?Q?/iwgwZH+eQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb751cf-c7db-4767-63b2-08de8f4a1dda
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF80B25317E.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 17:22:42.6639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zU46KiwE5Fx+Z5HOKW9D6/K3gJYIaSnIO4zljbupaKxhoc4BedWMCAVBhwPLaDKvN+Fw+cU13A/Yg7hk/u8MGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9678

Patch 1:

Add a chunking loop to vfio_pci_driver_memcpy() so that it handles
arbitrarily sized memcpy requests by breaking them into
max_memcpy_size-sized chunks. This allows tests to request any memcpy
size. Update the test to use a size of 4x max_memcpy_size to exercise
the chunking logic.

Add vfio_pci_cmd_set()/vfio_pci_cmd_clear() macros for PCI_COMMAND
operations.

Patch 2:

Allow drivers that cannot trigger MSI interrupts to leave the
send_msi callback NULL. Tests check ops->send_msi directly and
gracefully skip MSI-related operations when it is absent.

Patch 3:

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

Changes in v11:
- Split into 3 patches: added precursor patch that moves
  memcpy chunking into vfio_pci_driver_memcpy() and adds generic
  vfio_pci_cmd_set()/vfio_pci_cmd_clear() PCI command helpers
- Replaced feature flag with NULL send_msi callback check
- Renamed nv_falcons/ to nv_falcon/; moved struct gpu_device to
  .c file; renamed to_nv_gpu() to to_gpu_device()
- Allow gpu_poll_register() and fsp_poll_queue() callers to
  propagate timeout errors
- Fixed macro alignment in hw.h

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

Rubin Du (3):
  selftests/vfio: Add memcpy chunking and PCI command helpers
  selftests/vfio: Allow drivers without send_msi() support
  selftests/vfio: Add NVIDIA Falcon driver for DMA testing

 .../selftests/vfio/lib/drivers/nv_falcon/hw.h | 349 ++++++++
 .../vfio/lib/drivers/nv_falcon/nv_falcon.c    | 755 ++++++++++++++++++
 .../lib/include/libvfio/vfio_pci_device.h     |  10 +
 tools/testing/selftests/vfio/lib/libvfio.mk   |   2 +
 .../selftests/vfio/lib/vfio_pci_driver.c      |  21 +-
 .../selftests/vfio/vfio_pci_driver_test.c     |  59 +-
 6 files changed, 1171 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcon/hw.h
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcon/nv_falcon.c

-- 
2.43.0

