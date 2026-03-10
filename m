Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7D391E42
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160881; cv=fail; b=MWghAODCobZnu2axQf78q68kmBOGQU2pAsI2ZwzFeAXw3h3lFgc9gtbmdB2s48wlWgT1RQ57VI73xru+TNUqbiwuwGJYz+jVE2qLsJD5jwm9Y44N2z7Xer78MV7hmI0QsC01W/d1eaQeZvf0mf49UwCRILA5LpVS4uCusFguUrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160881; c=relaxed/simple;
	bh=oDXKij/yXdF5j6sZ23rXCQOhWXZ7NDR8zkKiKEfxHDk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D/b1sumkKzoK/PxqzAz6/W3HySydRW2FI28RddEdSptsFz2Ys0BZvUnbuSQK3eUqLLlouJIBSbg24CLMwxP+BuZ7qH85oioq63OjAZa4oYtLmXPn07H+bgGMu160hFmlasTuZSMKNlsB2geI8Xk7ZF3dNH8qx7Jx42V9PSeP/8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GcejkXrP; arc=fail smtp.client-ip=52.101.85.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GcejkXrP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSP2kL8XXYeqnINYuasw37qL+AdkRy1BeZ6yotuXehq0O9spxKYGtnFYJSY59vLcpvQrJTcQmG+TC6S2rcYjx1CBQBnLokSKqolR9UezeJFAq8c7HIcpcF8i1uWksX6IJaMoCqhFKQFWkIEwH4/mS5SdTLoipjIizt8Oc/RyqkFNe9V12gEwOK5RaCdCjJnGy0jpYguF5CkgfXdu7MI0DqwaYMfa30H4IbfYj0O2jSiMFvfIGmn9WC6au94oe9jB4sKZ6fYdnztMN9vKIvOA0IWGDeKOa8/UoAUEsusqZ7M+JsTTEb8MriudSGW66oYEUGjkqktBxzoqNkVwecHdSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiqIXIZOnVzqe4mAkB+lWYPoTrIFILbTSB76UtDo6Sc=;
 b=v4eZ+vaRQpvOxgL1GkFgjFuYV9sdZhI59Xn7ODocQpQWkCxwNIx3S1dNjBaOR7Y25zexPtEYoImFiP8vZRC66BKN71lNI3qUpXXE0neg+G2ARunp+nJ35rXt4+0clH6CA6pDuFBc084fe8j4Snm5Ex/DfOg+uHTvJJKkIouMnUNuvBbu0OrXcjKtMTfR9sfdT04qyjV1YB5mKJMfrKM3ebFo/4HRUT7HNO8pH4UYB/UyDda5j5HxmNb7T+Uae1isjV8kBAt9y/HxLHRzbLMJEtWWEHcDEDFkN1NqVlvC3sl5yYLROB4PR2uJZWaBQK4q/b01DUf0zNC1hQCSyxFCuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiqIXIZOnVzqe4mAkB+lWYPoTrIFILbTSB76UtDo6Sc=;
 b=GcejkXrP/HfjCAJIDcaWvl9O35QHCL8eHzAKXzitkoqL2yLEw/6Hm2D54c728AKEgExYj7TXDNsInQdDGk90NHnYOaHSIsDVhLaAhn0Jl+/Mm50O8sXQrg0GihN5792r0sPLR5GXZwQYBD5/JWav9r3KV+W770TNSu5YEqzX5KKKHBc5iVWVJ0g6FO4IVoFCvc8U/sQjHiC8nsel+cV98a5KAD1gst3UDF9002r4jSlsX6FxJ8LiJ7OFRkWAKlAyc5k72xgBE4iPk3SYLGJN5JmZrbyfpLYo6/Gjys1G+B1cUVuvv8YknQlpzmO/XoIqZDfMpW5nXR8jaCbAfbyjLQ==
Received: from PH7P220CA0120.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::22)
 by IA0PR12MB8714.namprd12.prod.outlook.com (2603:10b6:208:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 16:41:05 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:510:32d:cafe::e6) by PH7P220CA0120.outlook.office365.com
 (2603:10b6:510:32d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 16:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Tue, 10 Mar 2026 16:41:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 09:40:51 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 10 Mar 2026 09:40:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 09:40:47 -0700
From: Yishai Hadas <yishaih@nvidia.com>
To: <alex@shazbot.org>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
	<joao.m.martins@oracle.com>, <leonro@nvidia.com>, <yishaih@nvidia.com>,
	<maorg@nvidia.com>, <avihaih@nvidia.com>, <clg@redhat.com>,
	<peterx@redhat.com>, <liulongfang@huawei.com>, <giovanni.cabiddu@intel.com>,
	<kwankhede@nvidia.com>
Subject: [PATCH V1 vfio 0/6] Add support for PRE_COPY initial bytes re-initialization
Date: Tue, 10 Mar 2026 18:40:00 +0200
Message-ID: <20260310164006.4020-1-yishaih@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|IA0PR12MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d1801c-827f-4ea4-5060-08de7ec3d2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	TuHtuQUswToQR1Pm+Y5bKvg/AntZnxALmX6BOChTvokP3V9yehjnrUOxz7k7pA5zUg4tQP+RE5A+w5ZJ3ItNvkJk3Q9Y8Ue3OGM1Kp9FZ+u5CmgFlrP+l/Q1RtvguVb7g1TfYLgSi7CApt051x3Z0p9ZUYBEpjGF5aGb2SXp3a7koU+FRLbEPU5hi06IYN+na6gCmnNpzFPZg10IzUntHQFDfU0ajIMMNWA1KQondRdTDwZtv3eib5ezxGbeFses3nSO6AvZmHM1XVKe7z+mPnaxltyLLqcXFdyNqB9RGaEgsCBbmPvk7y13SYoQ9RB0L9xuvRH7LztO9l2+Z6KvJWpmfmgY9gcwNEDyaManoK3MEREPyLUL1C4r/M7eiudpMxmcq636mcSOKjR7dyFw2sh/mH7nmstY27zUt7zJPw27Y/cbEAyQkw4oI+XGdTGTfO4wbh/m6evM3kvGxcx6aHifnhrxq0DABeaJI/YUX+dObc8s/WDe289dSrMKFX+HaeUmTbGMI4BnVH2CZ2+S6rLf8WPKCuu8yFMI7T6SpEl64vQlpHe793UejOtiqwR+kClapEZ/K5vDo36PlgBqBsRlO/+UCAH1VlP9fP585Dyq+cnzNfgCvlA3pe89oNHvxZGSDDpMYxNAUXkoP+clW942vr9/weU1lfRYCZLWoE5kd4gikm14ShvN1vugEDa9I61CYkHK1yUUyBtuMu2QJ/5E8MVn/wuKHmCAVzB6fOB0UQqqDYwbqdWmJpsBC8xjO2K1sFdy3CVr0yyQRqwhqw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q+wLWD1SJI+hG5eTC6GsiKlzwkIGpuNVD7XWuLrYD57VlN1b9dRPTnG4alPrWlbVNERd9ZuBuloB5ta9Yv63unDPoJBrYR1IIdqS+WcKN7qN9OBw7e59BZukXa2A8/ahTsYvLUmXP4kC1qn7QTJ3vGSFoKDOnBCLFDbpDMqwhCC2okl+l2dJknrOPJvkmuw2kuZP9gszKm0cliVSjsKp4YdwfQYzp64gQLJTzGxHSzoUmHuULkhi0h08yys23NksoS5UX0kyXJBYr++WWY3k+rdKzLLDkG85kpL95APoHRp1S88/k4vzp6SAzf53xq3tLFTOvtuVwP5QnvBnQB8F8TVSyAaeJH6pzWvyhHDuQmCXWMRPUqWa6+7gTMVg0b5u1Tp50nffaQKIfJEuABAPpc6B9YmDx2zu2KKKM3sC0ZfAT9OO78tMfIB7FZDaNHq/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 16:41:05.2965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d1801c-827f-4ea4-5060-08de7ec3d2d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8714

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
 include/uapi/linux/vfio.h                     |  22 ++++
 samples/vfio-mdev/mtty.c                      |  16 +--
 12 files changed, 217 insertions(+), 98 deletions(-)

-- 
2.18.1

