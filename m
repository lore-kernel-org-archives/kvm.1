Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA6D3630AE;
	Fri,  3 Apr 2026 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775259892; cv=fail; b=oXN+YLP6azcwha8+52sI78JJyQclCrr42zAZXaKy5CgvHl+tGbm9NDAfAYTsauQx2ITEIY3Qd1gxRkEIA/nCDSeLadheTBV8O0MzwrpxQKE/mARGhBRNraXSJmRq5EoZA68fPXB1v7EZOWKN2CX1vzpGMRd94LEOJR/casx2XNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775259892; c=relaxed/simple;
	bh=ueIAsu0l6oTAW+DcGGWS2y2gzisqpr50U8BPQ28kmtE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mTuTnVA1OsxiRR9uR1NCzg7CNS4HboNS4QRI7gqcuWAgUmt0+tlUcHFBvQvzQRGo74jSPAyNtZRYe5/SfnwYjSDIW6dumfTJvYHJwjM7MHx/i4cYQpMLsCJgS2N+Q1+7MIhGPdaEPihK6ds1Nj1ApyCmBLGRrKIxO82WjKkDBJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YdYX+J1q; arc=fail smtp.client-ip=52.101.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YdYX+J1q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnF0ET6OrCmeeRQ3RdBjKhYM7Q0t/vwBxCYlHD2HLILmOh4vtlzxPnAeeus3vYpGcE09IEiER/ld70M75K0dYxuRZbaQFu1nzet3Hh3WTSzSxbnaX8LhpjvLLs9nIuvRM1ETDYdr2xfWWlP5dTRaShzcvlZl43kNIbHYiyFKlfSYyS5l2tLi05bzydKWZHDeXW1WW6+UqDeIV3N4gdYFTERhc+Bgrs+07A2fxKLKF7Wt/wOSnMJkmh3Qb6Aa4ND4fPxUfW91uCON4BTGQ9IOZNpDoFihp39IKhiiJ8ulija/ozLw5qUdh1rTGzj8Z2GWfj/Xo8LVZ8upf/DtdG24jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiu5So1Hm2go9qAWk/sJcSvqxFHCjY10ixJPvaKf6ZQ=;
 b=o24V4oJRuiWuoPbdo6ewxa6MOoly7abE6m3BelthDx8uYdPfh7G1+bxZkMeZTFwRyT0G+qJiczwLjYMa5VBf1CNzNOyGFoSS4SQOCb9NeJI8lKW2iNcpJG9/Wm2P2Cnw/wj1RxxZBj34ECoHpGtNZ1x1m7C+HukYlOsJw/7fP5Cv3vBfoz0J4lvKzV4jvjAO02qkfho+Aq0sR19pFfJCi5FoyqgBGGncGleFIqUKDQ5Z0MowbyUTFiiQvEvn/0dyOSs6MmLR2ersNj5hehN8pI3ESxt/trnHmPO7zsWb+8cNiZIJW9OpJS+zuknXyIYrhTpKRUIT049mSiFe1bVoBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiu5So1Hm2go9qAWk/sJcSvqxFHCjY10ixJPvaKf6ZQ=;
 b=YdYX+J1q1lwsehn9RTnn7zrXw7owwgcRmJECem+XBs4GEgdyMTS5dSQyBLkWuSbVk9GF+pgBaffPxCVPthVg+Hg3MUvWfYLoE6Rix0Nmhp5KKHqlA40YCZSRpkjE5tYcK0FEc9O6GrkX4Cce/kyDpot2FuobejjEtxA5dZY3yKUEcLw2QH1UyhhOujKbxKAU9v97MN11CjVhmyfZIcnKsZSyRJfdvIzBeEEV5kmZCRi9fEvp9CNOu6nrkRuKFPc77UTWguqwAl1MOQW8WMzgNV1WihbRxnYEDnTPIb33uL+/4rkqhPhKuPXqCFC6i0lm3zR8ngFLNwSR3DVdMGOlxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) by PH0PR12MB7078.namprd12.prod.outlook.com
 (2603:10b6:510:21d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 23:44:47 +0000
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7]) by SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7%6]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 23:44:46 +0000
From: Rubin Du <rubind@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 0/4] selftests/vfio: Add NVIDIA GPU Falcon DMA test driver
Date: Fri,  3 Apr 2026 16:44:40 -0700
Message-ID: <20260403234444.350867-1-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:74::49) To SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF80B25317E:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce184eb-eeef-42e9-2071-08de91dafd06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZHp1y4qO53cSS9GqcCaeSc9Z6ZMFlAtxVzJHmSZJ20RB/OannVHPwHN6FN7PTK9TdJnY55FIlLD4zLIhULTKUuirBTt8v4+XFvRktUJXOcMPTkTHPoC2qXnvZLScJrVKw/shNNTDZydtnUJtxBQ34esrKKLKG9evZZBFdH3H6+B66nG+CFa+G4n1Mekis22k1GpjK/Fn76p/cVmFxDIykB/jwNPG/yqtwJHrAB8AO6/LmQIVUPNqrYzGj8ggnmFN7pOs1GslNfwbONmwo6Pu8raeljlXtf/JglkeyAZ2ta9GS2b09QsM3GA1P7yWrNvirPO0Pld/mVaRKGRpalehPB7Nkd1lUhBkldfBhSnouRlsu44OMPthlh9hH+5KLdyZHC8DFEXP3a6ruM9/hgw8XmJRCxfnQW3T95+y0QN8mLVqWHqxT07RkNsBoaYCj9egz+TvwJnOglbUHte14Sh5PrrgG3RGr5I0xCliVgBDHGC5oOCYugBi9SrdeKE3wdXNdnQQKpN2OQpBGq+L9qsgewHgKEapJtggzWp+Mzcl+9UwI6So28G1joDOjFZ8ZwV/S3mdZ+3pgLC5SRcS6IATAbOYWteUa0OLQMkNFSYUS2A0JF6/fKAKn1OsDKxS1F341r6WxUuqRUATsGvhlQFb7xGYfZWmy8m1ZQtqcnOFOQ+SCXbQwaS3fmHPEgwbyPxJHe7y+gZ6MFzk2/y2Hsi0nervRlKpE5VM3SNa00c/5Ns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPF80B25317E.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qF/imrbZvBdncLvq/CfUFU82NBTmHpT9plZ5Iwo0n90y+qdNCmj89uN4naFq?=
 =?us-ascii?Q?vh9RtFUG7ubyspoUo7Fz9YOi5hhGu8YepbZ7TAURKxsHNfsE7wmfpQ7W1AID?=
 =?us-ascii?Q?B3iuN4xoa6cWGoyz/w44LOf4wDnUS7urAsHGs/7WieJh2uj+9PXzqS3rFs2G?=
 =?us-ascii?Q?/3V2P2fnqTbUtuHj6A5jZ5BSw2vq5CNDkVAqwPauQU7UErocGG2HpTfg3f0E?=
 =?us-ascii?Q?v+Yz/dwYth+w6FrYuJsut5rz7j7t14PIF12MqTIkmCSSY86U2g5TEVipCk4U?=
 =?us-ascii?Q?z5aAGgDHgG3Lb6FL1KizzM0k9WDJuGVoT2alVqC7Gv6axaPBj8o/il92QZGN?=
 =?us-ascii?Q?+G/qAdqYrCpmj8HnPz2f494mKhyw6E1cgNRSIo1LTZs8ROAzHpZM5rWax4G9?=
 =?us-ascii?Q?T8UcQWUfmC5vBv/icwocGbV0GfPK+zcMSqSAP95fXZZuXsI7kSqRrectI1RY?=
 =?us-ascii?Q?BobcqD+qGVS60yAjBsdpN/Xdq1gF1K2lPBc3ctFg14u2mD+1+k1wyGgOU4H4?=
 =?us-ascii?Q?jHYcW1kRyDtz/RqBO2OArQFeIhVNsE5s2MIx7/IZDtJZkdJUBYbmpYfaIfRo?=
 =?us-ascii?Q?ANEc6V1LN0ro+7RukT3XA31Us2KOeKTe5TTvNEHcnyZvgy3udvvgiO9lbg2c?=
 =?us-ascii?Q?snNyAR8zxk0rnH6kLEhC5lK03C0Avz2Rcl46V/WxFPKLyOAnrutZ8L+EhcMy?=
 =?us-ascii?Q?gnNikLea4XpghImOHbXKEwDzKDnWuolzXv02IwVpVX30+Cs1+fiEuz64etNH?=
 =?us-ascii?Q?RDcY4e6rI7HWwXMz0B4W+P8xwU7yAnCEGaLlY8zzAZ0osSR7hQjoPmTruv8s?=
 =?us-ascii?Q?VvyO42BvxcHmAKR6+9kSUXSJNjIFszC/PiQQh5YRs3u+s2MiWDnmX6BrAxTw?=
 =?us-ascii?Q?Qu32xhsstaNZWncFMC+5Hai4BnJO/D3r+t4u7j+muPL2TyX9rRABsSdVQxUg?=
 =?us-ascii?Q?Ps1lSjUvDYjXlWAS3y3tG0OT7dND4pnaRvem9aZZmUqVEKvSEEVvjbzmmx4s?=
 =?us-ascii?Q?IRxybOkO5v4K2NyjLFvhb4HoFnNlQwG3wfg+7j6TLDZQtBmx6sG5cdpo1Iaj?=
 =?us-ascii?Q?aoXAr/wqEA2P27QWeHsFonbDymIBinByQNIW2GzC7seYqVSwLEjzNaEsqBaU?=
 =?us-ascii?Q?uuKW1WYTpXKB6Dew6BAebRrpfNg9svrhHwbsa8whRPfJ8mCdagVgfGYRvZJg?=
 =?us-ascii?Q?KcBDfoHPZUcQ5zJ32ETSC5oPLPiwMCWPXD/T/MrGIsLD9oeUc9n9EtHdqS3u?=
 =?us-ascii?Q?dq+bSnwlnv2WsrujtMOmUpHljczCa+kYD5890JYu99tAywDrIt0IHhyQi/KW?=
 =?us-ascii?Q?M9Ui7ngTUNt8Ogr1gH2tIgZKJJGMvKsaSkk3lRiwiQ+K+m+iiLUp3YGQifay?=
 =?us-ascii?Q?X8SdDhIgB5giHV57oP8AVYAPWpgqJWhbw6NxCrgGy90I0QZYaWD6ePJ+/x1U?=
 =?us-ascii?Q?NafLiT9V+If12zzEJxo7gzswJQLc5URa8HLyXDAwJQGs6zqgfbDyKE92MvFb?=
 =?us-ascii?Q?P0rcoPUHTFqZ5XBjBDjiXHjDeNddO3nSNf69MDrw6AIxdoHr9lUlLgyGYAc0?=
 =?us-ascii?Q?u2UYhvNnC4fcf4XduuW6E7MQOLk43Fqy8hasQdiZheBJp3KBuFc72ZGiKYTA?=
 =?us-ascii?Q?HdPNugjpBiIFMoC/Onjj8JdOG4moPx0/j6sx32U5m9Fveu3Cdq0sMvxdFXmX?=
 =?us-ascii?Q?O1mPb9xBv7HCu3fyVb4680GMPoK3IeOc2YmPLerjEZmZfF2XsiSuGsxPjtPN?=
 =?us-ascii?Q?JP6eXLtecA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce184eb-eeef-42e9-2071-08de91dafd06
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF80B25317E.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 23:44:46.8459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uX3Y2eW9Q/6+mwcya10iU2dT74Y6fvGJ6d0aaQx0ABtRZzOQgclMX9npILl8UPeYQWjbscwAscbOb5OPO5qGFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078

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

Changes in v12:
- Split into 4 patches: moved PCI command macros into their own
  patch
- Placed PCI command macros next to the existing vfio_pci_config_*()
  routines
- Fixed memcpy_storm size to cap at memcpy_region.size / 2

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

Rubin Du (4):
  selftests/vfio: Add memcpy chunking to vfio_pci_driver_memcpy()
  selftests/vfio: Add generic PCI command register helpers
  selftests/vfio: Allow drivers without send_msi() support
  selftests/vfio: Add NVIDIA Falcon driver for DMA testing

 .../selftests/vfio/lib/drivers/nv_falcon/hw.h | 348 ++++++++
 .../vfio/lib/drivers/nv_falcon/nv_falcon.c    | 755 ++++++++++++++++++
 .../lib/include/libvfio/vfio_pci_device.h     |  10 +
 tools/testing/selftests/vfio/lib/libvfio.mk   |   2 +
 .../selftests/vfio/lib/vfio_pci_driver.c      |  21 +-
 .../selftests/vfio/vfio_pci_driver_test.c     |  57 +-
 6 files changed, 1170 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcon/hw.h
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcon/nv_falcon.c

--
2.43.0

