Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047A31326A;
	Thu, 11 Jun 2026 21:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213747; cv=fail; b=ZauDYqeeLDmhNLRD3xF5uN6IFBDKZGjaDVRpGzrBy7wk4s7Lxa1LYW8P9+qGjBXpUgpxC3QGm4liP7vrYUwdNDCg9lmaJrbFgawTi6ZFykfl/5EBUzF7Q95i7qLVNeb61pkSHscxLnPoOyjphZ79oVTfVkOCwK+lCmd65/CyfHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213747; c=relaxed/simple;
	bh=Zs8NwMfNGLQoGD+FlpPEKQ++QqtsTppxGl9qv5MOkMc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=E35Prz9OCEZMa+YytEeId4hvAAvd9snLWjacy87SWcIWgkTKTWPxvm8r6XT92eNzNJKT7Y2YRYK1Tinz1KZR8v6Xdr6hJb1/SibFIAq6P4+2SmQhlfWPZMV4ScsN8FOlZCDpcHU0wSNTQ9yCOqjgdmvY06dhbUTQELxcMoBDZjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UISXDkvF; arc=fail smtp.client-ip=40.93.194.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UISXDkvF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QiGen3Eh6MnCgHKap7+imE0d6nLK/7dcGrpjQJ86f6o8z1m5k17riG2M8PozaUAexUFTFk5zJEJECPTrXdd+ehpg/Hv6u/gqYxXuCmzxW8mFESaGS98IVSltDLW86xXqv/b+5YXnSdjBol00aQliB1/O2YbOeiQbtdzJ+3micMThSvwb+hW7smS8GLXdnf8vLOuBgeSEgVvjZsgoaujTxNERBKjpl4GF/qih/20uVQaiSQrnFHkzJQqYv0oyXF6+24bLVkfCgOYHv3ikdOlev2klys+QtSqyWVbWRo48M40k3pUh3F5F8m4Brm6K99F9MkRIUejZw41q0xbzVnUPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiA0c5ROTCmUTomAiPLoorcS5nOA9Wya9cldf30e3co=;
 b=HUq1AM5sXbXPSylINpPCyJ/UeYqTH01qo991dO9lVoEE2sV88/8xepcdA1+vhlLbb9QxsvgIyYRr6G3oazd+YiCJjG881Q+rzQ2nntVSmID3A3SPyQgH0gKZc6T/rtxilc7TQXz4jtg9560J/X3mK6RtuxhTG7TYUTNZLoXm9G3nvq6rTxO5Ox9hjZi2rJnamedG7V/v/5WnvyfUjzcS3gf2mqEkN+bRy7T1Srje+e/fAkd8jarbRB334G6zfV2vzFj4RlGSeHJMdD2kBL0yfz+xXTFXU8VeNesHNJne8M9CFJj0pCCCMFOS5wZP3l3k1vruXFpQuVF/GAgfdpR4Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiA0c5ROTCmUTomAiPLoorcS5nOA9Wya9cldf30e3co=;
 b=UISXDkvFOUHktCurmsOHVEfgmW9+vS6jOF4wq2l7sU0QE5sYj+BCxfN4f1l23ATlEPu/niiif/MEun4SJTh9/hwqC4yV1/N2T+5nA5du9eVCFsvvlRKtDeiJ9NXFrggkjEN2SJKTIwvF7+73+HU5/lSkxfLHvGVSgIXRT8l34rsf3wSnjILIJXUs1/0+81KOWhc1wx04yTg6AIHsupXuV5oovOWNhCfpp4azle6ur026zyJRbmvl9n+7vA+pBVu8lS43lzCYautaJZl/F0Hcz7DGBjboWFAGAmpxzZWbqVlkrsSwtAQhcR30A8TZNMpujxd64ZZykmPdRoUBIsq41Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 21:35:42 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 21:35:42 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	kanie@linux.alibaba.com
Subject: [PATCH v2 0/5] vfio/pci: Latch module params, fix bitfield use and VGA unwind
Date: Thu, 11 Jun 2026 15:35:33 -0600
Message-ID: <20260611213539.4100590-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:44c::15) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|MW6PR12MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af0791a-dac4-4f77-c34c-08dec80163b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|6133799003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	sE2c2XZ+QWZJZqIkVuVYPu0Os7b8WClrjU6wUyhpNkHvMJp0hy6Oiqbl/q1HRAH7Uj5lio6hgdWr/Vio3ujF/FwICKpSW2yY0qOAFn+yLwlrOQjZUOlLQP3BGycmocg5qKkje7BJ3DF9xJTz8EjKalGa+PNRdx7YLc5YySW/jakdeJnIhPDzdVUw+4fN0qloGsahep7HLh5B9qD3ViAsgsR02wAEZAgl82hIj6JVvYCPRDXGK2EWmV9fDJ4hEqSq70wX5y02zJt6yd7hzYzErUGq7dU7hTRu1A/aWZmtL6b0ZjReeY0/i/AQo3+dqBaFb8rgV2ELnQOayPRaJY2fj/FVp3AcwFiJMi2k51z5IRccC8DAhhkYyxOBnq2UU2HPz+ZAwWvDh43IynTIe8YVLkKT81WP0vO5OCzHYJRIF/M+dXMlfRlXue55NumI9gVwajEJWk7a4qZOzs2gyEpkySECdO4MANPT/uyhqqlSp22Ph4YjBaZIv9UOqhMbLXi/Rs7I0PBh708136K4KehjE8Nh5R9HlOuJKVEhc12VRMw2xbRJO3IqS2FFo6WgL8hT/FC7dazG1/Ix2Hr/1FDIog5pCdmYdk06A6rVczAo/+Axk8xSZjbvmHhjCxz6d9jVL6ZqR1r1cQTTYU0x0+vHunda0oqNM3eKFrDube0Ex7RRSwNotxKqvpvH8ZNEuHLN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(6133799003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Wjk6DsTW6fOAgZjYRDvsiNg6YY+LexCIXbmfNrMcShZd4W0dP3wwdmW9R4B?=
 =?us-ascii?Q?JU0jQybrIL4rqg+WNg4M9GBdRrWlVFff5ZM2XIgUTIk6bSt0bHoBVMX8ouKn?=
 =?us-ascii?Q?zBsXiCwUrvEedS23eU4gTiVQsNhfugiSoG4al7AtgccMzrr1eSDNuD73IR8s?=
 =?us-ascii?Q?PMSzr07DRmF89QoyUn1+emnkcxMpmGhyujXOR5UjMOTgt0SMXGMrXABtMCG/?=
 =?us-ascii?Q?9wQ5AT2Xqelh888bpEPGkjdd89mWxdMYJki4SGd5Wbw4pyhe22a63adZ5HDh?=
 =?us-ascii?Q?XZ5bagGeYktPWk/rhd3wOPtV1vhL3tQqK+40QQgpW2OKha2/MPPYdlrqZYix?=
 =?us-ascii?Q?fQFESCRbF5n/2ZmGjjexBAmw9hAazahjz+1qbXlovgH0usWM/cNGktWi9aCI?=
 =?us-ascii?Q?eDawVCdEFQsFhOe4SfXeThNxYi/+BiTz9c6m6uWsZXwIdPnz+PBR5P603UxS?=
 =?us-ascii?Q?uK6peONvC/qqupX4DmkfwuLSR2eejCOwlqER1sklCGa5njfF/TkTVyvu+sVy?=
 =?us-ascii?Q?rgPTpr/6IBY7qhyeJDtElevmp2ywS3a8/a9M6cexpluBtmeEf3oHIFL0MNgc?=
 =?us-ascii?Q?9izC0hzR8vI9ojd4qtwaVLJr6ZGTdl9/Q/q9zRnXNha6d6oTapwmNw/F6DN6?=
 =?us-ascii?Q?9K5Bq5eNbiRm1sdQviPjFo+hYzNhHk0OOQ0jUruIEXxByB1hwnhIiy3IuDeO?=
 =?us-ascii?Q?xDZTFb4z+sD3V0O5dQCND+NAOzRPZ4r3LSLWwB+W81TFufmRmw5H+xrSzOeq?=
 =?us-ascii?Q?IHdikQxjY9KGArVe6WThMgFhC1UQcCXZah8Ak1NoPEIqKk4kzzzNkyWXwJKv?=
 =?us-ascii?Q?1pexD20exnrV4M4pnTZ/PIc9X8IDhhF1FOQauGbSO6p8O7lvoHD+lGoLTpDL?=
 =?us-ascii?Q?m6E2j1SqWenSq7HPjXEdoGfePzGX/FbZ/vMIf7H4AzdwAo+UOTvPMbKFRYZK?=
 =?us-ascii?Q?ZqFD7K9U413jOa+HrMyCsUqh9uCzHROPNBLXX/BjajLWHjyklN+6WahjknHe?=
 =?us-ascii?Q?hyPx3xaIDs2z4HRvY5c7E/RTRaGELE9MFztGr+kOfvLwu7bM0weWuM6kWKYd?=
 =?us-ascii?Q?FUy2PErX1tVjyLvRNemXtE9retAoECMZb7DmoWL8SshY0y0B3a08/JpyRQ06?=
 =?us-ascii?Q?ryNwBWRsUwNRngnYUzt6j+kCWbmfFAyuNkKTN5eWJOdznNZ3SzIqzCYzIpEq?=
 =?us-ascii?Q?mMpcTKyKvrudDnSzzPYBp/zBo0NJI7pAXzgs8ZeM3+vRDvhKKIixSniVbbot?=
 =?us-ascii?Q?pCg80ps09IISNJbTgv5AizWaedkgS1uJCdDs/ZSuryBRooIJce5SYgeeWhK6?=
 =?us-ascii?Q?iUwqzbYsLGwpAxmAfg1Bh4da/ms1URDgZykjTENXoBqnvSvoku+EDpjO/0Ej?=
 =?us-ascii?Q?3XKZpuRog9ZXYN9IFvdAR1FE9Rhi5GyKK6fKiqia8myWFVqxmk9C+vlQ56ca?=
 =?us-ascii?Q?w7vJ5i5y1VZIWBNqxx1czQzWO+Q4eAIOtLBh85GvZK9fmRq0dPvfCELD+rTl?=
 =?us-ascii?Q?Y661ZIMJPBDmUzmjRW4/juKYgncv7Hgfb0v15i8ipP5v7JR9aM1/rzS7zhqE?=
 =?us-ascii?Q?5MKYzQPjzP5jrrjGggnQRmhtS3nzbOVUSmCuADEkGQIMlt/jPJbs++diQxU9?=
 =?us-ascii?Q?ICfCXaDWiAxvO97bwWA/DRh1qGYEdE2qa6vtScsG8hoBdt7Mb7zvhPcPpy65?=
 =?us-ascii?Q?4r1ncOBqzSFRl5XSVfjMi0iUVmzlAijY38QMM9WLu2N6IJ7TjGbNuYIeP3uU?=
 =?us-ascii?Q?ochJIc1QrQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af0791a-dac4-4f77-c34c-08dec80163b1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 21:35:42.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLJweaCeHJjMiF4wJRYCmcSJHjGtUWZCUGeXLq1xN+/VaGRipDJ4XAnxatAhRsGhswqZS8yy+p0M4K6LeHNPmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706

The vfio-pci module pushes module parameters into vfio-pci-core at
initialization that change global policies for all devices, whether
bound to vfio-pci itself or other variant drivers.  Not only is this
generally bad practice, but in the case of runtime PM, policy changes
can affect initialized devices, even while they're in use, resulting in
unbalanced operations.

This series first addresses the runtime PM case as a separate fix for
stable, latching the runtime PM support into the device.

Then, in preparing for moving disable_vga to per device, it's discovered
that we lack proper unwind support for a registration failure, leaving
the VGA arbiter client registered.  This is resolved before it turns into
an issue, also marked for stable.

Next, we're again reminded of the risky bitfield use in both the
vfio-pci-core and mlx5 variant driver, therefore before expanding use
for more per-device flags, perform the binary split to categorize
flags as either setup/release or runtime to avoid RMW hazards of the
bitfields.  Also for stable.

Finally, close the series by pulling vfio-pci module parameter policy
out of the core, latching each into the device structure.

This latter change also has the effect of restoring the mutability of
two of the module parameters, where that functionality was lost with the
vfio-pci-core split.  With this series, the current parameter values are
latched into the device at probe time.

Please review.  Thanks,
Alex

Alex Williamson (5):
  vfio/pci: Latch disable_idle_d3 per device
  vfio/pci: Release the VGA arbiter client on register_device() failure
  vfio/pci: Fix racy bitfields and tighten struct layout
  vfio/mlx5: Fix racy bitfields and tighten struct layout
  vfio/pci: Latch all module parameters per device

 drivers/vfio/pci/mlx5/cmd.h      | 15 +++++----
 drivers/vfio/pci/vfio_pci.c      | 30 +++++++++++++-----
 drivers/vfio/pci/vfio_pci_core.c | 53 +++++++++++++++-----------------
 include/linux/vfio_pci_core.h    | 18 ++++++-----
 4 files changed, 67 insertions(+), 49 deletions(-)

-- 
2.53.0

