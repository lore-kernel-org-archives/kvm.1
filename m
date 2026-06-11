Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013015.outbound.protection.outlook.com [40.107.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE554C8FFB;
	Thu, 11 Jun 2026 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202340; cv=fail; b=qQ/TglJTcxTF85CZFSstXo+BsX/wgMgnw5T5yX6k4NEigDTIP/Lvv0/+4z6GfrFx79V55hVF7gFg4nv5gDrQxKx9AkozIVr4douJpAHimtNE9CuThfbKMqnxAIQjrO2ezQbVmRIqLaBwsOfq+gmN/kkswYzzDpS7lmFOi560Xy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202340; c=relaxed/simple;
	bh=SFlezyuXjhsuHrkSx3xApbsABn/i+fB9GEC/LbMZruU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=E1tLFA7uDzUP9qs51p3vmFClGyvZOhiZ8cVsL1m+9hpygPOEClAK895pKlVBFhnbX7cmUQ7nGsVse0sYuta6iE6GfK9RttloHsxdz4kNys4O2NXvQgvVx7zWuPvr4Ji1zRPkEdeCg7jnBSpbAzfuldoM3gR6xQJiiIP5r0smvZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CiAvh3lj; arc=fail smtp.client-ip=40.107.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CiAvh3lj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyVe1l9isFLqSn4weJLO6NC2EfEcM4A5QLkdrxkkPYmmHTCiQeXf8yUg2WoR5Z7hIBUNhLYfLG83OnubjAq6kQMqWL9/06EeMSHqfvSW9aw2HNJhJBdvaJcc7XTyyB30IMtCttSFA+diA3Q6fnT/dLbYAM63bh05s6aH191OZGMWrOVEv3uc5XdaeSHNC0+pX4ahbSPnnXYlwKwcU9SeW66j+0VcN/ZtbYQjX7fmSDEiXq+La6Ii+tvbn2KPnfdpiOlPKb3TIEZoIuUAlyVkWj1OAuWJEMyaGFJeaKqgcX4Kpk+mmfhGOkhITAZLH8MfzoSpjOgoDO8+tE/s+kcz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKP2YfsOH+b9AzV0NJoZO09hoc2KKoyBOGyTxrHgt+A=;
 b=GCvCnZz6FK88uKPelm0/64hjhBbe3quk8PDEXy6YKnSMTV/Ugb9Eeej35SVhh3jdvk/LHiVrZuevcmZ4RdYAzdVeltluh4KmrcjOLwvxCpytSNZGG7961omet3XDfgqYg5pxrlUIdTPeLKe8VPZGzQ/q6IkS84wGIU0/saS3TFW1F2YzVqn10lNEFkHHAXzBnRTptf+zJeYhryft621DDgn2jWS/hCo2ItK5lJGUdDhuDtjB+VUbHs73WY9AWhD+JtMSZI2TB/Epp6D/V5qxqMkonMkofSQQNzkn/DrB3UANvaIAoqckklN7VbhSrLHFYP1u7pRco4eVTHifMzqw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKP2YfsOH+b9AzV0NJoZO09hoc2KKoyBOGyTxrHgt+A=;
 b=CiAvh3lj6mTLQa+LSsEwBByfN1F9zipm0pfZWOgxF2YSEEOp/5u0HJiHRpKhDYSdSCFn74PKYGKPGb/RqcZy42r5HuWIulS74rAVDvdC2d6lGibEBnUwhmy3/jrt25JZZGbmgBXRnk7CYYj6C20fKEuGwBTQenXy2g2RcDNkRDdCH6jEbKBKGI2nuubVudNzu4MWOB8TSAWc/f7tu17QzyDz28c0CZPeMc20gENijBe0TiVUmtd76cRoI8bViRwPfDm1XsaTAR/lWoorqN8fpuZhDi7+V8O/y4W1J8g6qjG2nUWDkmiCJ5EnU93t+O+GfnRZhMg9k7G/cTw/EUKajg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 18:25:33 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 18:25:33 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	kanie@linux.alibaba.com
Subject: [PATCH 0/2] vfio/pci: Latch module parameters per device
Date: Thu, 11 Jun 2026 12:25:24 -0600
Message-ID: <20260611182528.4004073-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR18CA0044.namprd18.prod.outlook.com
 (2603:10b6:930:13::13) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|IA1PR12MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 015a735f-a9d8-49f5-9bd9-08dec7e6d319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|3023799007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	COVQFa+3FlRAPShcfBXrF0Zh668BAKjGFkqkYNQwrEkv626HO1qDAEmZZKOgIB2ARF5ycLlNZU/kXUBqS+9MYXUKz8Ra1L3sYD1nkmtIdBGS6K3dwpywpGfqdrcGDThx2s8sN+BFKvazpG4LZNVU6g1qoMtoYW2tjv1GBITYBaIN4WWB2A7kWfBsjWbJ1DWp3leZjJtyqhYjZ1OcmHbXfdzg3FBGTF8RQkWtNni9i984ft6u29MCw6o40ldh0fzG7CsRUeulZ0cLNjKnMeXDBnJ8jeD71wn2KPs0ofLcNzdA3d3Aoc9y1Ei1UX1EX9qSqDo5/YoHLfYNvpo6y1+gf0ytNQ19pK0/FD+mV6wCM1X3NWziY9h0jpLaEJAy8oAkRtsi1HZgeXsd6oigljfS77zuYrylOFZJMdDCKep4aE+3iUpGtLx6EgnA7htDRFq6FelJw52aXtrjYkXQsxFOKnW83Nnz9j3d54sdzlYMuVQzHhPVuAArOEMC1r/3TtTVKIQXNQeAAOTjZIJBQ93k18Sr3E66NxQUeGs71EopDvtmo3bIlRzqEZddRpaw2EeTydT+WW2bhUu+w4Hdr8UEEFwGFKqynebS1EkrSR/5bsQHIbrXB0vSK1zl0TMxBJJetJzi+WoiTwyqaFPAenNRh4/LwyHR7OrZqckhFP4AE+4zdwUJ9HrxHHI0PbtgYCUx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(3023799007)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XAc45LYJRCsiuHKcaszIbNefAangJUHugs+J2rnhQI6tQcDzTKSr0MVqFjPB?=
 =?us-ascii?Q?JJN1KT3yxsGHN/sNx9AzqOjC0A3j9AS9yOIUfUmL1DxxsCFknSKk6rumhv2+?=
 =?us-ascii?Q?+F7eWQ9OChw5nRi3k5fuLV9DaBaJ86ldAYRWNOZIayRweqKvnrOS1Nk0sL75?=
 =?us-ascii?Q?x5C7WAoD30+dzUND/4UUqd8SeEJ+0BnQE0HkBlhJCxEzBIL8FMVIZMpdaxbL?=
 =?us-ascii?Q?qzfYbcveGbMVyEzuGYa2ValoJp8W4tRj+zms8NbUmukaUe+A/7UZnvAHn0YL?=
 =?us-ascii?Q?NCaT5Fv1rbKITA4rNraqPykgbkADZNkT9py2Lj4AU7jLzHzIp7u/YzbJRXmS?=
 =?us-ascii?Q?ZcXTXXERU1iYAi0jEAIX8JOJ2NZL18CLUTGFg4GLCYgbtqvMsxPn+jc3WIVQ?=
 =?us-ascii?Q?vpGLA7LAPz1SO/FLIC28OBVZ/zVGGrwhRNiNvszV+Tehetu55zF1adg8XiG8?=
 =?us-ascii?Q?TmMsfsAGjL8chpOBWIF5noRwPmsHw2R4lHqKjXLAk5GVilCC+rRV7ifh5dfi?=
 =?us-ascii?Q?UwxjKWHlsiqYBqTyafr8tRCoSNYniTV/QG3/FdG8rq73j2P7yBeqRLYE5GsK?=
 =?us-ascii?Q?GxTA4xs6SAFovmhaq8DVi1SKT7qSSBKo43LlZROnBUMiB3ugBmKeBk8bheph?=
 =?us-ascii?Q?HRIdUg2xILfLXsbeY3U+UiLqHn0yDBvFI4RwkTKcjsmiZNTKfq8kHjBcm3Ak?=
 =?us-ascii?Q?Z+fGIDszVRksrKQ+GnGfZr0XYmkHXsKvyOxPvTTpl1Gdpr2jcf/gFUxzPCRF?=
 =?us-ascii?Q?76mqEPvsN5aska+7t5ohDWy1BuFg1Sig5Vr+0Hbe43Az5KHiU149xwGj8LHU?=
 =?us-ascii?Q?Okt574RSkQxyXYpJUc27wBFUIpy0YvFYru6+vKLTqP0fvU5DUc4KZ3Ff0rHv?=
 =?us-ascii?Q?na1PyZ7dM4UpgmoGKmBxrW6sYtkyLEcsY+zG3OoIe06aIKAoW2IpV0t+u0Oc?=
 =?us-ascii?Q?O/6KeIL7jN2+86Fj19rsE4F2IK3IW7BQ+Vm4TmNXbPUaPP1Qh1qPWEqHm+ca?=
 =?us-ascii?Q?KO3QopDTgo25RklyRRgktKKXQuC0y7TyE0Z0tn6gayBiYzF/HrixE9rhcKsB?=
 =?us-ascii?Q?owitPIu1ZO3qSU3NYnrW0STv4QRInewOCw+lfi4g170Tr2FmbSdcEFdiBImY?=
 =?us-ascii?Q?BvPcFwNi4gMb6IghSanm49PcrPfRe5Bkdk2F+mYm4nc3MNe4PSCtBDoqoR4v?=
 =?us-ascii?Q?/sLXs1WD/9nwg4XY6jAkRZjcNNEN9sdH76oqnjfw5vQ3kssxYlFi1ZK5VAqV?=
 =?us-ascii?Q?UGvsFqiUyFBjcU/AiZFZqgbA/robVmVkG7sgsqSty3KQHb+snZ8YPC96rxOY?=
 =?us-ascii?Q?fQNWWwRkdA+aD2DoNqMtSkd74lsb04h57WwjuZ5ujRS471DwHz+hLbNfk2G1?=
 =?us-ascii?Q?GSOa4eLS59r3FfJVaryDlY0hqvol8YLdZxJ0wd9ORN3+/lqiuS2H164q6tOV?=
 =?us-ascii?Q?8xaPPo0OglGDgTPlGIIbbAjK4n/8eZy0+tObkUa56lKp1tA9F4OHiHY3r6Oi?=
 =?us-ascii?Q?97DoCFvKAXgsy6bGCSUBm6u4U3UY7I6jlR4xJP1Slpg5i/j1Mg8i4jUoyj+I?=
 =?us-ascii?Q?/7HDbGl952BRaDgs1p+SyBYI51dH97iDlCm2dYyU2YHGBrrBGK50fvpQ0WFj?=
 =?us-ascii?Q?wuHagad3uyfoqMm86y95SLIvy+xdEDbskZ68vK4Hd3Wkj5ciK9QwFwuJcFRN?=
 =?us-ascii?Q?8tWjs4XdsAXF021oxNm1pA8i8hLHLhU8WXlwzxCYf7k1AhzSlnQT0kp4FJWK?=
 =?us-ascii?Q?V1hM/tTAvQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015a735f-a9d8-49f5-9bd9-08dec7e6d319
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 18:25:33.3558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tEhh0C/SHIdIaIDIiCAH3bxdmYae69HC5/ZySKElI3/HBuGkeYFznOkK0MiHIHwjAyhc8MxGF+EDKieh2eC7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579

The vfio-pci module pushes module parameters into vfio-pci-core at
initialization that change global policies for all devices, bound to
vfio-pci itself or other variant drivers.  Not only is this generally bad
practice, but in the case of runtime PM, policy changes can affect
initialized devices, even while they're in use, resulting in unbalanced
operations.

This series first addresses the runtime PM case as a separate fix for
stable, latching the runtime PM support into the device.  It then
expands the scope to pull the policy set by vfio-pci out of the core,
making each policy latched at the device by the variant driver.

This also has the effect of restoring the mutability of two of the module
parameters, where that functionality was lost with the vfio-pci-core
split.  With this series, the current parameter values are latched into
the device at probe time.

Please review.  Thanks,

Alex


Alex Williamson (2):
  vfio/pci: Latch disable_idle_d3 per device
  vfio/pci: Latch all module parameters per device

 drivers/vfio/pci/vfio_pci.c      | 30 +++++++++++++-----
 drivers/vfio/pci/vfio_pci_core.c | 52 +++++++++++++++-----------------
 include/linux/vfio_pci_core.h    |  5 +--
 3 files changed, 49 insertions(+), 38 deletions(-)

-- 
2.53.0

