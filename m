Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D8438BF61;
	Mon, 15 Jun 2026 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781550784; cv=fail; b=sK2YjocVbV2gwzM3b3vA2V5JJqoDYKovB5G7pj47jaGa/rU1F1iwmuns54ofJ7RP+4md9Ms6d9rzYFtjoqsE5ZieDBm45iqJPPQn5CRf4nbRc6kWmye9TXAh1f2RQaGXkvQKWWg8BE5TIr9/wMKlmL1cDmnyzuuJVl/nK23/xkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781550784; c=relaxed/simple;
	bh=ybGpbUDWK8vwrI8MhXP8VvFN68lNISuE9KbehIpkJAk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=W8yquHGoEDdgmI4uyWXRhfMlroNpX0uK2kCjrc4rYYilD4lwedJW0jkUVwbQlUzF5XaiZRxAry1sdQE8bRr6JJsXF8fYwza0XzNzXa8nxhvVhyUsdNnULmuqSEAOVFCAwLTv7cvRMKbfRUB9oFmroYwyLE7rWbBGcduQaMCHdIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uqQ01cts; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uqQ01cts"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWxkdq9l4stAhBmsHPN4CA8RsV2u9HYltX+b3ERXqa/D79EY6La2tPxdDVb6ywmtPWw33BY9Sr86xaLi2scI4Bza2BLRgOq21KMqFuv7oLWwY0ceNfqK8XQzlFTT2JdqEwSLYZJ4D6wqKaVCYBFQ5Riq5fw48qPMwgVadpEMWIdwASBv3eCE8UA1TwJIqYdtLetge0cJDzd8mvFGCiHrSDnjRltYkEgl9W5zDyrCEcRojNfRGfrPQH4iNV9ZpOCfCIu/BdATu0EydJRtHnxgF/0tenjpN1cDEcTqUgmc03aNiIcNs9lRdMb+PICnN2bDM+PNx6cShekdBE7JnZVoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rHZtMw9gW74zCIbb4JJVzDvSeDNjQwFF4aUsOkXDZs=;
 b=RqLV2qTc28UG8xCuQnkJwLTc3ANUXrM3eJ76g7+Xu66eo/zQZkV+SHFbV0VlugKPgJgK5E28OH4sYyc17OB3GjKeQqJfp4gZOMfb5JItWqdUYwnIcvFjLOjRKLFwr+JhM1Mbxml6pHxMuqytPQbItAjjG4XlyU9BDn/Uz7LykFt6T/q8itzAXVYtnLn1XvfrTuS8mKXYb+XYXSJFpJ/Oj24w0M0FS39DSjZlE12rDHY/qXHCFMQgUAE8cxJ0DrUuKM6LHbDJKJ5YEVpDZquwbvXeA3btr60KjTy3ZaUcst35bdm7pMniPc07z/S9yVfmKgYr87whyetlbGBHmdlX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rHZtMw9gW74zCIbb4JJVzDvSeDNjQwFF4aUsOkXDZs=;
 b=uqQ01ctsnhrC/mIM0ev2z+XeKpq/bDfq9GwgZ402fFVOKAKO+xWsde//m5WJ9ge6zsAMMf/7bmW4Od5DY3dCCD82yQJgT2g2Am4LGuQT4V1999QbeAbyxJz6+atY6ycC6U+WHSkAWeuWEinIekW3HXkxAw2J32rpggFYn4/eIt/V6fXD/5rWLXc+E9wrsjhOOPywvuxK/Ny0RqiNpLTjN729jv3WZT1G5JKuDCB4InWcf0aLYMhsUpQdKPjkSUibVuYvmgvPRTwTXZLS9u/YwxyGsE055X3Mvdfz9trf7AsxTaDyA/8t4AjwHYBea9E3CqQv9lNTYqHsDSPpQPphEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 19:12:56 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 19:12:55 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	kanie@linux.alibaba.com
Subject: [PATCH v3 0/6] vfio/pci: Latch module params, fix bitfield use and VGA unwind
Date: Mon, 15 Jun 2026 13:12:28 -0600
Message-ID: <20260615191241.688297-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0046.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::14) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1099f0-02d1-4ff5-fde6-08decb121af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/QxTyR1+jtZwZD8XXiCVr2tk3axbPxjixuqCEnp54W3H+6J1BmeKWioBU6ONCGj7K/geLBdbSD/DqSK0FbX4JZXtwI11ZruQlDl+kqFmg3p7Ou2WwyiQufSy6KNNqT38E1x6cyMh38nujY2XZd98M1Gb8oatCe/vRvprAvkc1kGq07KoElyMV4LUzCoz+a06QKp8Y3xLT925a7ZNHZ3gtwExbZyCvWla0OUOQGp/zE4P0TUAeFpPF3s8ZT1FNOVMzjJt/1Ounl+YWDqHF8ekmv+Yex185NZCzGgu5Vn+anvM0HaDqV2rzlUAqkYnr26qbPrF5O+M0VOzmeEQiKojkzdSkwC/yjm0UWzGLZw5EJoY5+23ss282d3ua3DBy2bSxraBW0QnTp+bFzoybboh5zq4hO24tWJWzIim2MVIhDh/Jmd1YPdk74zKeppAkQP+0UnFLnzrDC4Lhph/8/SvUi7Gf4qF/LrgD1lLmmDs/HWJQPSAsqe1cletlIxnoCHjsPYh+JXrj089OSwq/ds6Xi6CSJuMSLp/HqrIcI3nVNmR5vNuCXMcjaq77Mb0KNV+c+ep1dGc2P/5tCrEf/1LGnaymHxrFI6CHLAOXyXfUSoOZkfbp/n++eQXEjb1VvRCIc8kc4O7d3eLUwTIqD3Jjpw++lnSZNJkMpzw/CyN6URCr23S2IqfIijvHqGnmdf3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mRXerjf/I9fx9gM5KWwM0cDCc8h3zQ8eHhy0o/v3A7yILVxiIN6onoKirtbg?=
 =?us-ascii?Q?LKXH6qAK9+krQtzzp2FuDnF7W/MdE8WWNfuSiEydJsUg3R9eUi6MQTUt5znY?=
 =?us-ascii?Q?imWGGJYKqxrhl+e6EbBdzDnGIAPwhZ7B0/MeGGYNfbstP0nnhubfm2kiz8W/?=
 =?us-ascii?Q?Hkg8RAQwA3UmsNRIF0WIZf5OgNxbsNbz6zsU8+3CsWGSmmG7SqP1vt41tHpy?=
 =?us-ascii?Q?siGff0smxepHNR7parpwH54pQwH5nF+f5Iosij2v0tFsec3wN5+/yqwEHh5j?=
 =?us-ascii?Q?Nj5q/ZBARSmMvfGekUQp/l6gZQQ1v5GzU4CYXIznKkayk9HcbjEJ1xG83RkC?=
 =?us-ascii?Q?X7jFq+9/K+/K7B1Rh9n+43iH/xm2imT5/pKTouHR9WarjBEoT707nm9mNr2E?=
 =?us-ascii?Q?XDVE0L9X44rNixzg75iakXIAj4RaS/Ep1kS1ZKUp4RX5F9lRrY2sJ01I6SW2?=
 =?us-ascii?Q?0iBA+YiV4SDuaRpgyLZE2psJyA+5hmSZFju0myMN7+vGTiMItEOZTvH0lZ8w?=
 =?us-ascii?Q?hvE/lPsH8k8k8sN3DzPZs5kMvGKa1ncng5kMTrjOzjuOphqpZOX7Vv4RyVuI?=
 =?us-ascii?Q?ck6Qy3vdfokzUmFK5YqyqTQzOs6GjnojqxiNAuWDwAhzgE7sbY3cHmNbccMz?=
 =?us-ascii?Q?2iqtYO/o0AYbfm52JtLon8+/p7mv10/C8ayVGP2xOGgZl4pF76lu5cITs2Z/?=
 =?us-ascii?Q?B8z/c/xCupYiPNnZDINJkBGQzrwwbWQsHX6O7pHW1c0ztjXy+x971TygxsaB?=
 =?us-ascii?Q?Xmpaz49VDg09OZQ+WnjFU7uIo0p4ZwTy5nbyXVwc2BFDKNYo8L0UAQVvczBE?=
 =?us-ascii?Q?hxamUTbiakJv8mykkFQMm1m+9phryz/Twmqv0Q9LS4Yh2VTZFyWzVo9Fh5nX?=
 =?us-ascii?Q?uhYZ8LENg2+4Pu+3xScy6E/FeRQuEy1v5VJ3C9r2zA+mQJILGlTFMGomHU0g?=
 =?us-ascii?Q?Uc3itYD8KvJBzwxTp6fNf3Eqp8NXwAeV2WRcLFCHaamATvQgZJpkKloM1tqQ?=
 =?us-ascii?Q?FMh6mEVvXtZDeDd9vBucG/MKB8kRwvzfpyr/Cg6lS6cXW7j6YYmri7c8at6e?=
 =?us-ascii?Q?l6aJ+x7fQ05WaDJW5yiVDibqGx6jORS4FsbEU98eAy0e990VkrRptd2XF/7g?=
 =?us-ascii?Q?5LfqQnCXsm58ISoBn3ds3R3FWvQsUQGzCLYDjKIJOicnXLwWQ/NA8eBWY+cR?=
 =?us-ascii?Q?LhoRGJxA5xTnQtTdaBHrcbLFS2Ns3hxTclCUUPIqVF0IKizcXFLxx1BKPcOD?=
 =?us-ascii?Q?RLCMdQePSSHw/bLuq7BRXuAOsHKB4Rtdw7KS99NXp+i5d4WOTY4yJUUzDpTm?=
 =?us-ascii?Q?M+ruVwAVkWL53M17rGkqQUXz/DEhklNEe8XicjdSndbo8sXTQ/e5QMrk/G8w?=
 =?us-ascii?Q?Lb+ikmFbsnqtZTplult2NKVnlfga2ZNhbsKz+ySS6m0vCvq1a7zRb4C8IT0w?=
 =?us-ascii?Q?BxkdtNovDaoJqbn0F0bfUBp6xRg7VGk69w/uldg3rGPdnHIOgdunanYq6ZAf?=
 =?us-ascii?Q?D7KdjZPGqwcUVm29laiDSsPfZ0jT/btVEukkNdrAJGtrAgCorVCKP7ez1md5?=
 =?us-ascii?Q?/g4LD8ut7yds/995lOI+XZuv6oqLjbkj6irVMDz4aLIA51JjsLdQO+7oGTqM?=
 =?us-ascii?Q?zAUQgikZ68oTse5REKszRynXJAKXG5HLFwto/jMXMtOjECYzbJhYt5J74MNo?=
 =?us-ascii?Q?ysx7QzR6w6lhaDCeKK9eR1YiHAdL9nP909suNiL6iaUjHyTrqc7d1wLiy75x?=
 =?us-ascii?Q?B+3HBRKQBg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1099f0-02d1-4ff5-fde6-08decb121af1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 19:12:55.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhNFA/Ntz5cqoJG+jXIMyWCzNtRyM3Y36S1EjLgr9V0q3PqFLbYCK8j8qh2VCUj0X9DP/NUtT40nPlT0ED53XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775

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

v3:
 - patch 1: Remove the conditional runtime PM get/put in
   vfio_pci_dev_set_pm_runtime_get(), which failed to account for devices
   that might already be in low power due to the low power device feature
   ioctl.  Now that disable_idle_d3 is no longer global, use the same
   unconditional runtime PM get/put around try_reset from the disable path.
   This is harmless regardless of the disable_idle_d3 flag and consistent
   with other unconditional use cases, such as read/write accesses.

 - patch 6: New.  Since we need a respin, implement the suggested debugfs
   exposure of the per-device flag state.

v2:
 - Sashiko fixes, including pulling in the bitfield split series.

Alex Williamson (6):
  vfio/pci: Latch disable_idle_d3 per device
  vfio/pci: Release the VGA arbiter client on register_device() failure
  vfio/pci: Fix racy bitfields and tighten struct layout
  vfio/mlx5: Fix racy bitfields and tighten struct layout
  vfio/pci: Latch all module parameters per device
  vfio/pci: Expose latched module parameter policy in debugfs

 Documentation/ABI/testing/debugfs-vfio |  26 +++++++
 drivers/vfio/pci/mlx5/cmd.h            |  15 ++--
 drivers/vfio/pci/vfio_pci.c            |  30 ++++++--
 drivers/vfio/pci/vfio_pci_core.c       | 101 ++++++++++++++++++-------
 include/linux/vfio_pci_core.h          |  18 +++--
 5 files changed, 142 insertions(+), 48 deletions(-)

-- 
2.53.0

