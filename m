Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E81B2F25F3
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764333; cv=fail; b=cPjanZUd1yzF4aG7Hx2knDu45YRDnxQsJuZFqfixeoIk9UoijvWXAFqiFZjHurAzIUW6Hsh4YL4g3lPQ7NKTZLPUSPoRvrxY6omMXLsq8d/PFJ5W5GEqS6ZL5BPC6CzqUhrsfCpc+V7WEHXy/5Bd2Uj3/B7yOFGFZ5oXcyIlzhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764333; c=relaxed/simple;
	bh=M1GN/Pygtq6+i4GkK8pYzd94Q/Squwtb0tuPGr42hks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LDnpGiB12jBgU7WerQjh1bvJVZBFvKYMJ1GNkDRrAlVPba0IzB/EfW2PKNW04Icye1ufiux+BW20J05WW+Pt106YM3z3M5DIKoTF/th99N0JDIGMGgA05Kmvb+aB7yxwqrbO+NpBo31TXdbsl7oLH6Y4ewIXi780Jqnxsapddww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HmkntCJ/; arc=fail smtp.client-ip=52.101.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HmkntCJ/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JecwbeeVB6EqNGCFdjgvceyfNkXh6dXKp3X+tAHH43Y/N7d17hxb52zLEXDVjcasmuGaAlWif4BwtL4SGMCjqlvsrMudDAs4/HRW330QI2Fy0zB33nasLy9uHC5KjX/kRhorEMdOKCvtp3NjhpIzQDdFJZeBUi8Uuq+qdsfDJwxiska1jSzagKs27A2+WnJkzKYH3vJJKXKVnvGytCfBm1Urf4rG/1DIx+F/+N6zyDiXwJ4JsU0YDG6/nZBte+R54le7NWVL0V1odr2QfZDa4ozfCv/UFPBlbsFDfDQg2txyrwxIRcMXp711BD5z35hLWzQhaIHiXPeHQXEMZYgH0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uu2PkZ/ECt+qioHuUt3B5kWP1jvfOSCEomMLTOV2WWI=;
 b=lQg9RNOxXJaEYH4RPxN4kZ2QkpgL73tLr6hoeCBbicIvOdk8tylBi/ojSkarkpSIUmUCaZflCVPKolzU+iQFRILVYX+xdQVz7rgmb9f9euUhYcsuMhMHRkRm+X3eADQEHz4iH4n65+PRpKQBTFxC49vnfoiRxvpfS2w+XeYED8kQVCr1Icq3XquiaFZ1/Oc6clvrR/uW8lBwp2nIAKsqD88sIY30lYABosIQl1apRUcKZjMxZYBUCuE+Bv9gvG6PsaF6AZPPDAJHdY18N4oYs52SLP9GV7ozUsH7VMrDxm+VtPnfduVhD8WsgjIL7iyliSM2Jexpnzpdj6oknXiy9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uu2PkZ/ECt+qioHuUt3B5kWP1jvfOSCEomMLTOV2WWI=;
 b=HmkntCJ/0rSZP6q0/+o6UaMNw5LXrzmnInBO9bHrlgLdXgf9DvAvxVXHSZkC77slg4ird3TsKEUoOinbMf1JTcXJ/yj3GHJCCdpsS21OpDdrlHHUDRd+qwZtNfM+iY3fP6CYg0v7PEUio0RP7PjwLfqsTl5gpSKJieN+ZMe2CdkM+EAhDMQivNfBg7cIb5vfArkuEyADgrM0C8wGP6YS1lETTZV1PlEUFlN4wJBGorB4zhVV/qF5i9lDSVFHDCL1DB7wG0C9sXBKQCRKrlcSdQavnpw2bhE1ojIpBr6DJRSI1HcABlMxJSlWMAH+QnZVmS+3PII5mmszxhn83CqcxQ==
Received: from MN2PR16CA0064.namprd16.prod.outlook.com (2603:10b6:208:234::33)
 by DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.17; Tue, 17 Mar 2026 16:18:44 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::60) by MN2PR16CA0064.outlook.office365.com
 (2603:10b6:208:234::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 16:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 17 Mar 2026 16:18:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 09:18:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 17 Mar 2026 09:18:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 09:18:10 -0700
From: Yishai Hadas <yishaih@nvidia.com>
To: <alex@shazbot.org>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
	<joao.m.martins@oracle.com>, <leonro@nvidia.com>, <yishaih@nvidia.com>,
	<maorg@nvidia.com>, <avihaih@nvidia.com>, <clg@redhat.com>,
	<peterx@redhat.com>, <liulongfang@huawei.com>, <giovanni.cabiddu@intel.com>,
	<kwankhede@nvidia.com>
Subject: [PATCH V2 vfio 0/6] Add support for PRE_COPY initial bytes re-initialization
Date: Tue, 17 Mar 2026 18:17:47 +0200
Message-ID: <20260317161753.18964-1-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|DS7PR12MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 29dc5c1f-10eb-4ec3-2290-08de8440dabf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	sScZNmUprUzDrbs4FIWbD8ePsQFEeFIJoDKuejNMPRFCp5rlJs/uhwvP3PXg9WW7g0y+2SiXjtoFebgtwYmO6aT54CEuni0NsXZbD3TGLy9jmJZxihyFevu1+kFH/7CoU++yhCTpHgkHjR+kARaZpYPScGrlD8ykgVykwEkeUYrlpa1xMMS5VnLu7pNhURGHZ2vz9NI6Pd1lpw80WnH88uwxEqaTKEIFjALlTowfQMAZJzNESOGLhgar1peMvW254pEMmKJ65GDvhHo9at8eQ/BveAwJC/zfrrWiCgnV62dazBnKEr/vNSHVapzTVLN+QwsbxVGXDCUaGuqSLVLWJ+WLwmPHAdqAhU4lA3whiwYeA28LGXhYt965yxFsme7/eYl5drAhz5dH1QHsEwiziqRBwN/v5mCO6/irzJ4HXIylbZO3MnS8tFtRASuNpTUT+GZiKsFGYhZOkGpzKczkj0pkGDz9t7Y0bWtUYVfjsFgVJUkcFYh7XejCtTjm8s9ke9EyR7hSDzqa4bCHHRRjT6DgSL4+T0OprNXymQlYyegPFtmmqOodTQ1US12KgUXL+QcABMDCK0PFejA1TNjsb91CbxG8WOWwKf5DsfbPTn5ckop6q+zpqrpTzcebBypjFJuck5KYun6qWktgOqKpA8QwY4eZFdwgVrCN9Dxzdh0m74j3iZb77xrV68mfr6nd3cLh/7kAPrNgoez+BkE2IeDDQ1XSKlmjgrUFkFcrUm8SYIOUMC55x1SRrtURUJ3dySqh9sYZdleTGw7Jp9pV2w==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RYYoX1MltVfh3gEOLLvE5sArZQI7eIZI7BpubeYPYwJLpmAJvvLrysyt2mekE1OlA84IxXrnIrAwPWLEOZbfLmdt9s3nt/BKBcQHnMAfDonTTgQBcjhRYfGuUWQS1v9fJfZPbdrNB50XVmLVDIQUX7wf4w6oRg0hTKOm4pqchixEAmKTh3ErIn4RUFud+xGz9HP0zJCJkyTh+oo1qQ6dDo6LpeGJRZMuzrUbJrRvZ+GhAZekHsh1WImvpXnKtNukodumnshiXHEOFSWI9uRuTNeLnUutzqlPBe02y3CF0uFe/GnedjPcaCp+MAcdVqdI8biYRakpCYxJKW+z4eyuq9ajvEpxqB8Z2pIhwBOHE3hjIAvHQUSviUZnonq2hmVtHBQyBH2KrlZbm76Jq7TIK47QzOwyIq69SWgTKeUr4xDzgU+qFEZ0Szq9Ozb8GS+W
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:18:41.4098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29dc5c1f-10eb-4ec3-2290-08de8440dabf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262

This series introduces support for re-initializing the initial_bytes
value during the VFIO PRE_COPY migration phase.

Background
==========
As currently defined, initial_bytes is monotonically decreasing and
precedes dirty_bytes when reading from the saving file descriptor.
The transition from initial_bytes to dirty_bytes is unidirectional and
irreversible.

The initial_bytes are considered critical data that is highly
recommended to be transferred to the target as part of PRE_COPY.
Without this data, the PRE_COPY phase would be ineffective.

Problem Statement
=================
In some cases, a new chunk of critical data may appear during the
PRE_COPY phase. The current API does not provide a mechanism for the
driver to report an updated initial_bytes value when this occurs.

Solution
========
For that, we extend the VFIO_MIG_GET_PRECOPY_INFO ioctl with an output
flag named VFIO_PRECOPY_INFO_REINIT to allow drivers reporting a new
initial_bytes value during the PRE_COPY phase.

However, Currently, existing VFIO_MIG_GET_PRECOPY_INFO implementations
don't assign info.flags before copy_to_user(), this effectively echoes
userspace-provided flags back as output, preventing the field from being
used to report new reliable data from the drivers.

Reliable use of the new VFIO_PRECOPY_INFO_REINIT flag requires userspace
to explicitly opt in. For that we introduce a new feature named
VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2.

User should opt-in to the above feature with a SET operation, no data is
required and any supplied data is ignored.

When the caller opts in:
- We set info.flags to zero, otherwise we keep v1 behaviour as is for
  compatibility reasons.
- The new output flag VFIO_PRECOPY_INFO_REINIT can be used reliably.
- The VFIO_PRECOPY_INFO_REINIT output flag indicates that new initial
  data is present on the stream. The initial_bytes value should be
  re-evaluated relative to the readiness state for transition to
  STOP_COPY.

The mlx5 VFIO driver is extended to support this case when the
underlying firmware also supports the REINIT migration state.

As part of this series, a core helper function is introduced to provide
shared functionality for implementing the VFIO_MIG_GET_PRECOPY_INFO
ioctl, and all drivers have been updated to use it.

Changes from V1:
https://patchwork.kernel.org/project/kvm/cover/20260310164006.4020-1-yishaih@nvidia.com/

Patch #1:
- Extend the uAPI documentation to refer to the source of new
  initial_bytes data.

Changes from V0:
https://patchwork.kernel.org/project/kvm/cover/20260224082019.25772-1-yishaih@nvidia.com/

Patch #1:
-Fix a typo in a comment (prepcopy_info_v2 -> precopy_info_v2)

Patch #2,#3,#6:
-Rename 'precopy_info_flags_fix' to 'precopy_info_v2'.

The corresponding QEMU series can be found here [1].
[1] https://github.com/avihai1122/qemu/commits/vfio_precopy_info_reinit/

Note:
We may need to send the net/mlx5 patch to VFIO as a pull request to
avoid conflicts prior to acceptance.

Yishai

Yishai Hadas (6):
  vfio: Define uAPI for re-init initial bytes during the PRE_COPY phase
  vfio: Add support for VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2
  vfio: Adapt drivers to use the core helper vfio_check_precopy_ioctl
  net/mlx5: Add IFC bits for migration state
  vfio/mlx5: consider inflight SAVE during PRE_COPY
  vfio/mlx5: Add REINIT support to VFIO_MIG_GET_PRECOPY_INFO

 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    |  17 +--
 drivers/vfio/pci/mlx5/cmd.c                   |  25 +++-
 drivers/vfio/pci/mlx5/cmd.h                   |   6 +-
 drivers/vfio/pci/mlx5/main.c                  | 118 +++++++++++-------
 drivers/vfio/pci/qat/main.c                   |  17 +--
 drivers/vfio/pci/vfio_pci_core.c              |   1 +
 drivers/vfio/pci/virtio/migrate.c             |  17 +--
 drivers/vfio/vfio_main.c                      |  20 +++
 include/linux/mlx5/mlx5_ifc.h                 |  16 ++-
 include/linux/vfio.h                          |  40 ++++++
 include/uapi/linux/vfio.h                     |  24 ++++
 samples/vfio-mdev/mtty.c                      |  16 +--
 12 files changed, 219 insertions(+), 98 deletions(-)

-- 
2.18.1

