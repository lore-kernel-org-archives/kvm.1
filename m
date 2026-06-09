Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F88E3DB337;
	Tue,  9 Jun 2026 23:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781047742; cv=fail; b=pBxLuioXfRw71kjFgTZ8oUIQAp31QOqEr1CENiinTIEn1BjydZHTmSflv2K6PIu80EgXrJcB/KZGZ6kuNrE4s1x+VZ/Xqv8JmNqLewDVhPrQc8GZim6S8MzBG1cu2u/yoGS2XcCseEV21yLmkKEKVc+wSMMRTnj3CIV7N3+P/9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781047742; c=relaxed/simple;
	bh=lORjZdOZ0tnf81es2cR7Ycn+gtiYQ7VO3EAknfmnsbo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X245XfHMPaBxyF2hoIWv8WPM7CNBhEBaP9GF2JdssR/9gY7d00whDBE7SFDPSz8MUQHGMK7eN6/4sj4neeLD981ubhqaCFIbF+y5Z5IxcGqFdqa1aH2075eNX3WuSS4Go1Y3T6syNpIllsYdYxB0xPp0bzMUPHctMgr6Up8U91c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K/Tm/Kpg; arc=fail smtp.client-ip=40.107.209.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K/Tm/Kpg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMmyA+4KaABlGoFv+zQH8zeoNlH88ZA4cSkQyduxWN1p03oQFIWTCoMb/9t3RRpht5UkulEy4fryadVo1zjtrn23FdY8kaJx5EAGvcQGXBj+wO7/ytFJ1+ozVIB6mOOtMBJ6eI4C+Cc7rTngC+X0rDLZplPpnaUMAe4mdopT+lZlMwSaQQHJkG1XURAaJFeIL8+i0P2G1fh9TOQq8MXjpDqqvOb4ZX6C4gjrZIOVSUo+i/Mvdi2lqqpNaWLhZ3TZM7tqt4LSOgyDjbvj6D5EGeg8rUcSAZT9YkX6kHJqQVrHsIn2sG2c0Prqv+X40fEKwI7R2Lm4qxRdEHzsGNalig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfoJy3H/jXgX/DmgFSnAVF7M9nlAcIFitniUw6hXjH8=;
 b=oEfCyvq5z9nmrHSnaPiBt3dgxu+oP/M7WMnQCvDWXJcgto14JseNMw/64uVejjqSAKlfybDUvTmsTHraCVN3iuVtxKbgn2Yb7UcVrmoE3LLu/V/QW7jKm6W3WAOXOilGEKDp6xe8Eiegb8dN65+9ZTJRRD+VgLgKJ3gSHPm4fs0Aub/D5QYOqHWg2X6Fn3z14BE8lxuSuivsJRgj8VmcUYszZF1jO6mltIKqGuKijn39WZdG7brS0TFUTrUVl3K4bWXzrg8CGcWFSMxKhWJvfF+OM1dVXc7jMOU2deaOGcPToyRo5r34hjs3rMQjD6g5N+qyU4n3sBGCkGeJGG+Onw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfoJy3H/jXgX/DmgFSnAVF7M9nlAcIFitniUw6hXjH8=;
 b=K/Tm/KpgsH33LtMaa8A4V2LQ+8k6CMv5LfMO5HuQhWNKguB8q0uyjEIuFR1KscBUIi88z4+Afy20V/fBxR+Pg7w35U5oUTQTWiPe252ploKR+UKxW4Xxcfa0HONHTFBmIzAtnEekUEl0LgesnhQ/40etOAFa7cz/74jJ+Y0iOxEpTNZyJUasK2rwqFZsy4oM6keoZy7AxQe7Jn+E+hwqB2sJilVInI4X7KcgBQjznDhZnTuB/J2B2wGGm/UR1lHquKokVoDsqpW4jeGzvQq6Nvw3FRkX0im2Rt2caYoBHwyfztbwtVz9Ki/643uRYx1sKl4ahxypg8EQol1nhgJhFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PPF73BED5E32.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd2) by MN0PR12MB5714.namprd12.prod.outlook.com
 (2603:10b6:208:371::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 23:28:56 +0000
Received: from IA0PPF73BED5E32.namprd12.prod.outlook.com
 ([fe80::8780:2964:7709:6b58]) by IA0PPF73BED5E32.namprd12.prod.outlook.com
 ([fe80::8780:2964:7709:6b58%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 23:28:56 +0000
From: Rubin Du <rubind@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v14 0/4] vfio: selftest: Add NVIDIA GPU Falcon DMA test driver
Date: Tue,  9 Jun 2026 16:28:51 -0700
Message-ID: <20260609232855.3808971-1-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::14) To IA0PPF73BED5E32.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF73BED5E32:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0caac3-2a00-4c1a-edfb-08dec67ee050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	aTG+38Vy9aVI/wOitcTBkvqiw2i4wmvBLs1MR0PQUmWT+y8Zab0pgcx2pQmUMM/FrAOTr0V/JYNet2PiBz10hVPP2pQIO7RrYGH0D5wu7AeMjoEVe52BiSiBhGn9i4c0U4UU7JM6ZOiI2/Ti4R4HAqDkLO2ETsOd59DP7qMSt5KiM7dQ3JkE2H28CGoV1cCzNTt5pNEBdaaWI8N4D2QopNc9ntqfFhjq+LP4Op9OlpEbFyLXmJ6Nm8kbOX04Z8QobTCNg6krPtMqcEARuwQsvnjauzgedR7A6hkug/xZVPMIttahVnnkggSvf03+UlEwRkPUk2uwMEGJbwNIGaSs9L2WJ/KD4u//mkGFXEOEeOScYlRXq9s9uELM213uWZ+AJvwj6LpvT6f0OgypXTn+EO1g27s7JgBpgyxZVWcUStAWrlycxR1Ib+dYvWeHKVVxHJXY75lvN8mycLIM2UV451ZCV0wW29z1thOwYmozFS2eMpQt23ph4kFBngIuvHJpg3wFUBl434LlKcggMCkRepyKLVX1iclOyWUUDGPnJVw+hCc7onHdvDttZ/sToyLoDb+o2BXDtTKfo9AgxIEKlFCm3m12li624/dmWb/pOrfXPdHhGAAGHZsOUhPEVCwpJjd5hgWOg/+Qtkxk/f/TBr7R1YVfbKPTSqADP6fS3iLhC3jaSz32Nw4uhzvG4wlY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF73BED5E32.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?72pBYgv15GnLn0vShK3aE/BvCYbPbBfZ23f9ZRhQ3KozWlVp1ph3LxpZk6rH?=
 =?us-ascii?Q?T2K6FDoJ0WqvP8LAOQdJiJkBMBZhU06Wfoc7ECegxa50lCSARvit8aZtfTtC?=
 =?us-ascii?Q?DhtHsiQ8abi/ZUiQSWV+lG8s1LJlQWgGrn509WSUKGP0nWNQYVqdAHAAzmJU?=
 =?us-ascii?Q?/zoQ1b4cHtYGJGFXX+RO8+8qJtcHTDU/OieOYEFfW9G2mSyp7iRV27xRtocO?=
 =?us-ascii?Q?8CCgFLKWhO1F3yi3ok6lnTBYMhXT7OGeUc+IpMpToIknXrx5JXaFaI3TSX9v?=
 =?us-ascii?Q?HuiN8bfItnf6nlbADaeoEr9UQD/4lq2yZJGmdHGMR4A9b0o/EUeEMPZh4bsX?=
 =?us-ascii?Q?lBCvZ42qWl9Mgu8dlI/pPbn4d9BHYI9GzTHzbXKlOOka6wYnsSO3MqfNaKyo?=
 =?us-ascii?Q?aIC3A3CE4XcXyP364wrXLci2ulkouPoGOFaaoCw9UwKYShkJprcQDoYFXVF9?=
 =?us-ascii?Q?EcLBD0C0ghqZZjbXs2LXmpTCDNDcDBRzyi/m/4G2FkxdR3DyxWZ5DH44mb6F?=
 =?us-ascii?Q?adnHRK8kJ2uOEep3lGjxFCJVjeH2eTuDCByfpZltRaZraaGFMAg+3xCSGWoE?=
 =?us-ascii?Q?EJdntAwnzB1K4pvp+15Zl4lLo7k6yLx9eXDsWkNuGdLJrqjugGM9snWyrUpy?=
 =?us-ascii?Q?BXn69P2LCsykY6lWuoXQVeaLKT5VFDuHBKAOgcEywgYX339uktIYNeVFqUkM?=
 =?us-ascii?Q?yf/pWlfebDsgpOSkb5BNOqckb0qISHQx3aeiwPf6QAIGexoj2EK6G+0QlP+X?=
 =?us-ascii?Q?JOkCdhCtGTebOJVjExYwoWWSARfDxMbQWAAtl4EmmYZxkJt64JJBE6Hhsup1?=
 =?us-ascii?Q?lIppwesOCIsZJxCdfT/LBlpmx40KFA5jUauyYty+K1r5NEOdjoaxvkAu23C/?=
 =?us-ascii?Q?rT9y9BM8RnYAJ5GeduajPx95JHd4iAbqF1dDhl12t3VJmCxAja+TlG3Kru0o?=
 =?us-ascii?Q?jBQz1VYJt4l7t4Slh+Qt6+OPwa4J9zG1EIw6DfvzFe2f14M1cOI7wCO/xvkx?=
 =?us-ascii?Q?DLk+HHoX7/usYYvu97eKpZsBx3wCtwonihJU4UF4ZvQPrYfn8/n62XowmErb?=
 =?us-ascii?Q?QPjnHgnLU6ySOtzFi5n8tlDU7x45tEkwrdyZ/piKoc1oz2Se/RNK53JWRNbn?=
 =?us-ascii?Q?hhmiBaUNgjq96GWdPJlxE6TZZTJkjBm+EA+qgya7NHgerl24A4wQ4Hw/nWvh?=
 =?us-ascii?Q?QsJyJryjzjxxgHA7lsw4v1vkZ7aOXl1ynKwnSZNbDHE1H2nV0sCH1E03vVXZ?=
 =?us-ascii?Q?xiPs14A24rlwHQckUQlq5gZZGdtXwZIMtE6ooK4QiEdavqSHeSA3O5BtE6mh?=
 =?us-ascii?Q?Z4o0h6dZDfuclbBNjzEQ06fpAbJdmLsBuRmM8JS+SQ6dwx17Xn8Ed1UtRQDH?=
 =?us-ascii?Q?1mbneinosCoNK+Xnhe1GWI08we+8zH/uZ3j2Jbi7u2G8GYE2MsvUqiFj1hBr?=
 =?us-ascii?Q?5k6xij2wQYco8CbyzAnmgd+JU0BDHkJAPFBOmvXRHckM/1Z42zWVz8fOF8j+?=
 =?us-ascii?Q?j6CORB3azXTb2mGVs6rTMmZFfBdyYeD8g6iXK3bkWpSbwDD5Y0j580vPFlum?=
 =?us-ascii?Q?Vg4mWR8j6rIdg2zI0HNL/8L8hKvCVCv/dHGxT7ltWemlDYlXR8s6BAsQmQwb?=
 =?us-ascii?Q?IFSSWjzOJu8Aj3Z3v+1Tn0y4ZQtUfWngdQeOdJjz3U4rc6crSh3EaC1HQDUH?=
 =?us-ascii?Q?oeDDe1L85Ur7cFC696Z8pGn+3qHvDV5Qxy/plkCw9E2PT1PH46FL0vgak6l9?=
 =?us-ascii?Q?80oY4XGOtw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0caac3-2a00-4c1a-edfb-08dec67ee050
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF73BED5E32.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 23:28:56.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBGhnn9yExg8rajSKTT8k7sIsGG7Jil8hTG2C7DHwnvrA2wMfaR5JBmGLZE99Ot8Q3UkrjFrsdr4T0bMUjKdow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

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

Changes for v14:
 - Re-tested with vfio_pci_driver_test on K2200, M60, P100, P4000, V100,
   T4, RTX 3090, RTX 4000 Ada and H100.
 - Alex prepared this respin addressing David's review of v13.
 - Patch 1 & 3: No change.
 - Patch 2: R-b collected.
 - Patch 4: address David's review -
   - Include <linux/types.h>
   - Factor out get_elapsed_ms()
   - Rename NV_*_BOOT_COMPLETE_MASK to _SUCCESS
   - Drop the redundant falcon_enable() and move the no_outside_reset
     check to the top of falcon_enable() so falcon_reset() is
     unconditional
   - Fold dev_err() and size_to_dma_encoding() into nv_falcon_dma()
   - Drop gpu->memcpy_count and the redundant GPU_ARCH_UNKNOWN assert
   - Alignment fixes

Note on version numbering: v1 through v9 were internal review iterations
that were mistakenly carried over to the upstream submission. Apologies
for the confusion, the internal changelog has been dropped.

Rubin Du (4):
  vfio: selftests: Add memcpy chunking to vfio_pci_driver_memcpy()
  vfio: selftests: Add generic PCI command register helpers
  vfio: selftests: Allow drivers without send_msi() support
  vfio: selftests: Add NVIDIA Falcon driver for DMA testing

 .../selftests/vfio/lib/drivers/nv_falcon/hw.h | 352 ++++++++
 .../vfio/lib/drivers/nv_falcon/nv_falcon.c    | 783 ++++++++++++++++++
 .../lib/include/libvfio/vfio_pci_device.h     |  14 +
 tools/testing/selftests/vfio/lib/libvfio.mk   |   2 +
 .../selftests/vfio/lib/vfio_pci_driver.c      |  21 +-
 .../selftests/vfio/vfio_pci_driver_test.c     |  57 +-
 6 files changed, 1206 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcon/hw.h
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcon/nv_falcon.c


base-commit: d0c3bcd5b8976159d835a897254048e078f447e6
--
2.43.0
