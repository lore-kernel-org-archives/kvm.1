Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4813382F7;
	Tue,  1 Sep 2026 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299654; cv=fail; b=JUulhL3U8iFUVm3J+lYb1JHGZqf9b8bUaLzsWORtbCS3zzpuxQLSzkMRsk7e6T/8VFVCmgtb8K0b7bOn6ivF7SPjJo8xsK1yP0x6IgiAtpc4nSMG+ra4nEPhp5VStT1PGvw0ShVPPXl6fObvOQ4uT8L0QGSUI76KzXWKiPlrsrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299654; c=relaxed/simple;
	bh=G50mpkhpAJ1JuTcG8ai4qxGcbrr9+Txoh+Gd52B00V4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D1UePyKPtj9p3DLc5maUdvKu9UvImIGfsPJF/Nh41A7wXTi0HNmseIGl1dSnTJQSXaA6Auezm5Zvhdtdjpvz8PHeS+83By+G2ewFQUaBg2M6FvRYU/qcweDzWy6BLWRnlaBJvbr2MX35h2dd3T5O5nzRiEP2PZuBtcA9vbIxXOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qwk5CErh; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qwk5CErh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+lzSakCgZO/zCkTjBVFOpGJEFciVL46xm+ssTNdDhtSed2iOcywZcjDxbs7mkb3j6ofykg84Be0UIb/zAVKDd7J63D4O/6l6ASFjCeo3SGB5ed1Jb+yKe9b11m3La9s+1xZaWGsj5IxNBbvE5wRz57RYUuwyLUfuIHBQmt+jbUwc8uTmV1yYKBq7/nr4RIBsL9zUEICbVA7vGB1MOkTSjyLyfCZurnnVjJacSVNJd/YK54Y4snFlQtaerMs+fEyRxOlfgUN5WAvq30P117YBD88Oc7PLZ/hK1G4cNcbvxUVqG15TL40otLllB+xlrOQk4mTLmZFi/BvDQXAtqhiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36huR9ctn+DjQ2CEXFvnSQABtTj62WXgKZGW4X62KV8=;
 b=ZMl8/WepgEXJrmvt+VDU+voq6V4cIolFWx2n8Q14YdicJQ2DZ7D/+tuYCgeAVM1M/eQzFWSZhWDsg8pLXCvQ10IkAEihGGMWWspbKIa3PNRL4InD59blYXGiTEzXgaNM+BcYxcyR3uJQdOY1ZuV1+v2xjAeAE6d2/7H8N61l1HmJYPqv+cW/ZQdZkW57YTOYEXPEPSdEbc6QhBz0AtiCxRD6ndEQejDfcamyALtrCT1Vjz9YGrKzIAPRHPLcomm+cOBVHs/tRzp0n+rnSGb1UTESJQ2uZQnS8hrQRgnwi8OWpJEO0jDMYxCNt5Uqxt6YOv4C+KzPYVy5GiBvgXRXbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36huR9ctn+DjQ2CEXFvnSQABtTj62WXgKZGW4X62KV8=;
 b=Qwk5CErhqWLT/LUqSXDGQh8exVTKyZEbNgBFO7YWxEqW59G8QsPkayPTqbqx82X3zwwk2Zlnud9KVWB5nW36ZbLTa4NOmcqmcEsD3Ks5lOoUYyOtY4M0dIPaEHGfF9c5N5Wv5UteOPhYyip+g/w6D3hTXDuVbW6W7v/DvBEfoMDhpESCHnopgy5OrR5TEG6Gjg5XeUNlViev3slUiPCjM4Bf0c3lvOxnrmMKkOPVPorCn2SfakTSub+aLOqwlGiv9OniRjlivziQJ4F/RwkAt5yBPjAnvgp74LbyViH8dy42olinmoGEzn6nh5bJqUdNUizrRDB7EDLmDPCK/zkrWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 21:54:09 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 21:54:09 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	David Matlack <dmatlack@google.com>
Subject: [PATCH 0/4] vfio: Fix cdev second-open and harden selftests
Date: Tue,  1 Sep 2026 15:53:53 -0600
Message-ID: <20260901215358.2421359-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::27) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab36d67-da8b-4e94-f259-08df08738d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|56012099006|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	uZDq4yp7AxvoFsQh1q+QP8VS5rLUau8iqeDPw1ZvgBT9E20gmighOv5GuAEN6cd7BkH8A6joL4NJNEbmIx5YNJ4DdG9bekYZdfegu8LbH2drDV9CkBJXlw70LMUkUmoRyS1AY0QJ2k7wI4wJQYJTG0pTbRae8UUppMAclY1tFWoZuN3Kw1uMpUvqKe8kPslZhLgGMumHFBU9ZuSDatDCaZIzBSw6ZizexvL/cKTngrqUWz4Bg6pTFbLIM5ugaqk4iOLctnDk2jWoL8UdaMNuEZdBX5pGj6t67tUXxxkhCa2dcekM5FdTZNIwtf3upJonCTc/2SifJ1m4F/+gt2kGDdIA5XGDW76JYxt3QWFBCEhBp9992vxg5qIsu0nns7pszt6TLn3ADrQmr2jh7Q3u1bLvOqzAML/QOq8qDTArY87+rHLoTOWgZGTUUDAU5RRLV6lOhGHaDE5FaXkaVJgJ6tdDGdQnd29zs6P02NkNyDw4PPA0XEI5mgbTOiGKoMrIjKd+HxeKzqfuMzVah2H1vCxX01Rf8b4UuEuCRCiW1kD8fmXfvPHt483GmZLcdpiV/IaznaadoWUovPMqYMeE2goAuGgmz6BuWY2q3KKbthaF5RyhYfp6N+cIu6IaAm5q3LOjRE6CPdpHBDx9/XMTKBZR5DyQ8TCWH3X6taxk1Aw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(56012099006)(6133799003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ZY8Jc3lBLvSSuuNFBwC1zsI2Jurl8fdhATCXaQcIIEuIMja8W7LulIrAb7r?=
 =?us-ascii?Q?VINQ301Z7bCYgmS3/aCAJp0RGRGdSGcLgApTUgGq+/C+GK06ORQoQHJu9M1L?=
 =?us-ascii?Q?kXNfR2K8NXkOas524+XnY87VIjYDdK0wqzaQ0w2VQp+ID6nlZrkaRr2zs6UE?=
 =?us-ascii?Q?mhXyqEMD+YcJWIRUHSDwRJrCyr5JwP3sfcou4AyEaPMefYckz7wpWsrksojx?=
 =?us-ascii?Q?U/rm4WpbM6ufhLDrHWf7SrPuFWx7sAymNPtTYcRM2cVjm9E4Tqoj1b+599bI?=
 =?us-ascii?Q?xGnTGTgt+paUhGRrgHguv84gNg+3wLwJAzun+48AKCBEdcgUNyZGbLcMsDZI?=
 =?us-ascii?Q?1uQRHLpM+yilKBscruwB9ZCEePxQhFYz8758Y4NPPHAOsmUBS1RuVdyFaIdl?=
 =?us-ascii?Q?nctoJRc+4MVOMvRntX9vPqM58yV7xx+zayGaTlWcnruTy6q4OPTG8ERrNsBr?=
 =?us-ascii?Q?WiQATleMlgywT7eLIZ9T8oO367RPznRfGWLJNFaF7Oo2nPrjJZbQuXqVtVpT?=
 =?us-ascii?Q?7ng+66exqzaWNFfj8MbctOg4w59MsO2u/w8eKRlLK4WSHVqqAOpOddNYubfV?=
 =?us-ascii?Q?qnAZ75vk+9Ufv4xnXtvsPI7kVIhEE8KA2F1mIwvMAO+OVnrgZiN5GAq31bTz?=
 =?us-ascii?Q?a5qUh0U9gyik/eoAfgHNr6DKQPL4eRTHUP+lpSpzFhv+w2Z4R/k2kzolljAa?=
 =?us-ascii?Q?DfwHFEeQHPILWZsKZwgQiT2kdFPE9+hxBbLSkeBBVtfh3PuR7po3+2vwFvTp?=
 =?us-ascii?Q?RxYmFrAVJbMIFvO+iTG1v4V0OGsB76L8OvYE0WezNTd3pgEkHxcxjQH8KA5x?=
 =?us-ascii?Q?4PHQyMtWovc8DAYQDg0d6+LrPVHokJ7kkIh2WgE4K2m0dhcjM0/CJjIOSbeZ?=
 =?us-ascii?Q?eClSFcOnyAT5oSDCjlaAqNSp4wF6BnF2rZDxZnl934PoyibFmZPgxiy/ISGU?=
 =?us-ascii?Q?N7FRXEldC4xAXaLsyvvLstbvgVosbnZXCDz2o3EZx2MTfBl4yqnv6YCx/3Bc?=
 =?us-ascii?Q?qYNP/YgWTMUyyFxFw90DTuy3nLmQmcQnWaGzY1fUKoq8P0bC0O4JZQl5jPqU?=
 =?us-ascii?Q?exGd16vXlZQyATwfvGzqtgNbWLK9aE00SU2kUVdxe1rq1xzpsSLMqhVzdK34?=
 =?us-ascii?Q?+l/zZa7p7ZUxpFybpI/QB++VVrBqYoEGxoFkzQSfQabkofx/KnglDtpA5OdK?=
 =?us-ascii?Q?h7ecawN69ykc5fUI+DEqtE4KXMoM2U5ExQq/D3O+4o8Y+VAcIxAsVEZ/rUnY?=
 =?us-ascii?Q?yV3cQ6Ote7TJ6eCxKuuJTOQ3Eqlva4I7DPnz+PtLR0Cb7AHBr+GyhNKUQF31?=
 =?us-ascii?Q?c0gFr46V1yURWVBQ2U3AfgJNOsLvlhYzctI1hMdUuBwkjkD+CAiriWDM6Uih?=
 =?us-ascii?Q?F6bogBsrGfW94UChLcDcKcd/BbcDLOO1BBKZ3FmtGWyLg84Fddiz1sB6+0n8?=
 =?us-ascii?Q?7N30/P/ZBQyv/fbw7I66Rh41LFvbO//VJM+ak7Ng2u7QnIPLZDVUl2Ih2vpj?=
 =?us-ascii?Q?Ncuiv5hMOsdN5jNdXpwtekrTCkIaBKsdKBv27eCZoUY2u0U/bSJBp4GmJFS9?=
 =?us-ascii?Q?0kuMcWEx080Bm6bJHNw+QrdKS+/IOws+eTALNaBl3gTd74CQ+72SQRZsk7Eh?=
 =?us-ascii?Q?ULhbCm1y7y/YPmv47IuaqMCoFCpc/g1dVx6i6bgxuIimhhMQKUImBjqCcAY4?=
 =?us-ascii?Q?ZXkmuUQ9CAZRtlrKxT9vOwjeQeed9x6HhA62mCBovAHQcrRIc8Rl5WYgbika?=
 =?us-ascii?Q?5L7gRxB/KA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab36d67-da8b-4e94-f259-08df08738d4f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 21:54:09.6474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5KJuw3PPazWWtgiGkoxwFTi40anynENRaV3txwFItzUfu3qn9nb8x1IcipV/E8rqMoAWBKN5U2buY5MQLR9Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

In porting some testing infrastructure to a different system I found
the igb selftest failing in mix_and_match and generating a cascade
failure through the remaining tests.  The difference in the new system
is the firmware error handling.  When the igb device gets wedged due
to bad DMA in mix_and_match, we need to FLR the device.  The igb holds
transaction pending asserted for the full duration of
pci_wait_for_pending().  Meanwhile, firmware based error handling is
triggering SMIs and stealing time, such that the 700ms total delay
in pci_wait_for_pending() turns into several seconds.  With 10 cases
in mix_and_match generating bad DMAs, the transaction pending delays
alone push us close to the 30s per-test timeout.  The worst case I
observed for the total test was ~45s.  Increasing the mix_and_match
timeout to 90s provides plenty of headroom to get a passing test and
avoid the cascade failure.

When the process is killed via timeout, the release occurs through a
scheduled fput(), which is also delayed by the SMI storm.  Each
subsequent test then sees a non-zero open_count (for the group open
in legacy mode or on the iommufd bind in the cdev mode), resulting in
the cascade failure.  Group mode already uses -EBUSY when the group
fd open count is elevated, which allows selftests to interpret the
failure as potentially transient and implement a bounded retry.  The
cdev path instead returns -EINVAL for this case.  -EBUSY seems
justified here and allows userspace to have compatible retry flows
for group open and cdev bind operations.

A local sashiko review then found two existing issues.  First, in
analyzing the exit flow from the iommufd bind, we can see that the
vf_token and kvm pointers are clobbered by the second process before
the open count test.  The open_count test in vfio_df_open() is only
for the cdev path (!df->group) and is called under the dev_set lock,
so we really only need to relocate the test to
vfio_df_ioctl_bind_iommufd() prior to vf_token/kvm manipulation.

The second existing issue is that when executed via the kselftest
runner, all tests have a 45s timeout, which is the cumulative time
across each sub-test of the execution.  The pci_driver test already
fails this with ioatdma, nv_falcon, and obviously with physical igb.
Running in parallel across both ports of an igb on the system prone
to SMI overhead, the worst case I saw was 450s.  Therefore, we not
only need to extend the mix_and_match timeout to 90s to handle the
extra transaction pending delay, we need to extend the default
timeout to allow the full pci-driver test to complete when executed
via the runner.  600s is picked here as a "sufficient" margin.

Please review and comment.  Thanks,

Alex

Alex Williamson (4):
  vfio: Reject a second cdev open before mutating shared device state
  selftests/vfio: Wait out transient -EBUSY on open/bind
  selftests/vfio: Extend mix_and_match timeout to 90s
  selftests/vfio: Extend timeout for runner executions

 drivers/vfio/device_cdev.c                    | 12 ++++++++
 drivers/vfio/vfio_main.c                      |  7 -----
 tools/testing/selftests/vfio/.gitignore       |  1 +
 .../selftests/vfio/lib/vfio_pci_device.c      | 29 +++++++++++++++++--
 tools/testing/selftests/vfio/settings         |  5 ++++
 .../selftests/vfio/vfio_pci_driver_test.c     |  2 +-
 6 files changed, 46 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/settings


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.53.0
