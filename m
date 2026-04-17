Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF3441C62;
	Fri, 17 Apr 2026 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776457717; cv=fail; b=nKd4/Ne0QPQFNd6C86hDYRW7NSKKWfnIWW7UR6eaqU/kDMVPLTcN/05jyw2OJAYZr/iQGj0FNFyVJA07RnfgX4OM1h6rEppOF5tx6CNnG4tL8vF91Q8tcvd8dHXLw1GNUB3MlVMfoxmZ+u1CCWbVvJ4chAekKXWS4cAAaPsc8Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776457717; c=relaxed/simple;
	bh=svWPNR5jyoDhh/LwC2RX0u21gkKuiJd2ZKYal0lbDiI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lT2NF8B3T7GSBHLkWJUXQgDkH5kOV45N/ZU491Qckmgd/MEA50Z0oN80wMVJyq8ufrCragBGWostsBpjVzR8LvxKA1a7JdMr3t1LYI/mfiCmgsdqQ+H+ZDdMcE9NAuzsC0pWIwjCOV1D1GOtEgCYWFYaHZTgrKByuyf0saA9+h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dUVGujDJ; arc=fail smtp.client-ip=52.101.56.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dUVGujDJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfObiXnswfWtY6Oog6N/os9Ql0m+pt/24gK+3mr+wxBggA+6eATQ3lMNGjNHG2vPrppjAwxYBqlrm+hP+9fe4uA1/HI3X5EtHsGgwvcP7w8lNDcrMEcFucJUcUHuxMrr0jKgtYoLeGW+9veMA5fK+BPFBK770RI8Ah1G0G7pYmBdL4YF5/SzW5iJKtlKFcw2lxz4AISUpayjC+JPfw1rdbehQrBPLc8zVHQqdlwS7QnX6acYXec6dxzNqCJsxNSIThkuLDllDqqgfm95NF3/6y5VVHL9DnvYrlmtE6cGNmx445+48S4m/QytQcnJelUHCTJyePvnAhpN7eZXEGYgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7qvuMJwIhE4lYiEchCKqUpmiuIsLZzZlu2jlNZFIs8=;
 b=DrzTCTQg+4Nr/aGWPjFpM9fmIyI0vMeddKIhZpVgTljgk0IBPkbSQIVUnEG5mYWC2GCeVUpDYcKPzI/5xQR3Jms9EVWQuNVB5H1FDIKjoZQw23rupyZSdE4guZ7TRQGMnB8JLwbQ7yHruu9KMDinc1QyffqONAzjIfU8Y/b5gYVlctz/72zcq58Cw0GUdfKC4O3c2N0VzR60nZfBCkW7E7DtdLLziE1yqrZaPeWh5z1o67kSHHPxa639P9XUYZQ/NPs5fb4rD05KbRWkjm4cCNYHmY48nuccgPvCm/fE1Daizmfc0aM+i9aqm+ph20LIOpto7Z/77/T2cMPPYyJPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7qvuMJwIhE4lYiEchCKqUpmiuIsLZzZlu2jlNZFIs8=;
 b=dUVGujDJkhR8IaCAUMr6V8LODSPpC3AP86V2weg/YebQuNct3fLdo9kOuDTeIN0un+mvPvpNwTWQ4VZbLlWIdDfeLvCfuGumqZX/H/fpR+HpxVeOXkuZzQg30EV22eDVAfEkKDsL9k3/GxfhcADNCNNAzBZ2aCLro0Zn6vBDS4oX5h89x+hvveaGTWgzv+dAurcRjpQ0DoWfvE47dH7dDILTxe7/13bf4uKmD30xY7S0pmohFbch8YIu+8f4A30IurFvgHVWCqtsNUdWfFi2grADij7bx3TUCxrTgx0g0+T38RySUu1bK5AWDW7bUsG0uOUJ04LxcPVipJkokbliIQ==
Received: from MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20) by
 MN0PR12MB5834.namprd12.prod.outlook.com (2603:10b6:208:379::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 20:28:30 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::8f) by MN2PR01CA0051.outlook.office365.com
 (2603:10b6:208:23f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 20:28:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 20:28:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Apr
 2026 13:28:09 -0700
Received: from meforce.lab.shazbot.org (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 17 Apr 2026 13:28:08 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: <alex@shazbot.org>
CC: Alex Williamson <alex.williamson@nvidia.com>, <ptsm@linux.microsoft.com>,
	<nipun.gupta@amd.com>, <nikhil.agarwal@amd.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] vfio/cdx: Fix interrupt trigger races and consolidate MSI state
Date: Fri, 17 Apr 2026 14:27:55 -0600
Message-ID: <20260417202800.88287-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|MN0PR12MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 6760402d-84b6-4621-2d98-08de9cbfe39d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qp2nkufal35Ji94/Gu0pFzDNaJy1z9eivo5LtgeQBnhWNrpL/wWNDe5VWXOcyO4V2efvc8Z/FMo7KjVOYDe4AThQ4hCjhOUKrnb/Zi9Gzg+0VcoieY1ALKQsIYwfJqUfYZBWAj4fL7bdA7aHqk/TLpKDvqnAGpPQazDJ+Ct+hkwNAhl5ir61lmptzKROpzw7sRekwUMNG3o/0u5yeCXQSdiD3Q6igQ5mysdZRVwwygBl+251o1VT/1v70Oc3OjtTiRb2qllUeVGn9DFjA/xX+X00oKIHyVXHmIcZ4sIEKEQ9jaURfY/d58QW2hcZE1gjXTFKYCntGHV+VNlcCnTvDCXT5OTqbvGuUJ/Whgl9ehUx69BPyJNLVZfH0mW/xVhHDNTfPh9vhOufup8gpJfeIih3sjlpH1qkPJ8wStrnfyhOHbGJYL1Hr7YE2sgA9Zv/0ShecNKmJDNNBfxMO8PM4/951VLnhGNGGEdksMKh3avDKobeIDvj9Wb12f2NyupPeYiQICWjJWKwryNJj5/AxNY4Ehtf6kkJ8/TqsrDN+UTsMi+LlR0nTRQfe7ONugN3y+0qbf2uCRbCNkLq8rlmoLeOz8V/84IAP6wKhUHW7d1VS/RqM+QrSNNlbem07YKT3KONuZk2WWJCmvhYbJTOnlOTS4UYDKTAFb4HJhXbgxGaRjmRl06LjLKRbxUs2GzR/ZdQJlyahR32ZfiRZTEO99osMuTP73Z7sJdv+MSf/Cw6hH3EzeiRP/ZbIqavYamxq/1YBq5bGs2aaHyXXK28ag==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eTRl9AfhNcmECYUzqqnZCKAwgi7q1cwH0mQ7IPPbiAKK2seomiM/nhzopa6XjI7IUIbyZ4qImfZ2hSJCV3otWXxeRgEr2CsOwRu8kbPAltTsiqzw27njMjDVKYyj+SD7Ivv9T4ECX5zEcm8EG8/OhmCSk26vzePojHOXPOx8b57Lhw5mySge3r4lMtPaKPIl+LzYhqTKK+Ztpi6RHZb74+gww+pL0k8uzy3gdbK8FveXF2npAznHnRb5ltttba8dG8uVt3iqkD2cXaer+M3QoZlQBpxCeJfmPVrp6hVR6CiLiJ/cgQf3UIDoHXTlhOoBzjX6vv0pTE2y1JEiBCrDbw0XImkngRLGA6I1ipEx28CbeI973P4nUt4WBX4T1FcZBf/gl8vWMzSgo0dsDNpMwRn0+NZzxC7xoCbzz626WLxmRB8tVXTXngi/wLnXicix
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 20:28:30.2728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6760402d-84b6-4621-2d98-08de9cbfe39d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5834

Prasanna Kumar's original patch [1] closes a NULL-pointer dereference
that can be triggered by userspace via VFIO_DEVICE_SET_IRQS with
VFIO_IRQ_SET_DATA_BOOL or VFIO_IRQ_SET_DATA_NONE before any
VFIO_IRQ_SET_DATA_EVENTFD.  Included here unchanged as patch 1/3.

Review of that patch identified a race in the same code path, where
concurrent SET_IRQS calls can potentially result in time-of-check vs
time-of-use and use-after-free inconsistencies.  Patch 2/3 adds a
per-device cdx_irqs_lock mutex and serializes all MSI state updates
through vfio_cdx_set_msi_trigger(), which is the single choke-point
covering both the ioctl path and the close-device cleanup.

Patch 3/3 is a non-stable cleanup that aligns vdev->cdx_irqs to NULL
in error paths, thereby allowing removal of the now redundant
config_msi.

[1] https://lore.kernel.org/all/20260320101933.1554416-1-ptsm@linux.microsoft.com

Alex Williamson (2):
  vfio/cdx: Serialize VFIO_DEVICE_SET_IRQS with a per-device mutex
  vfio/cdx: Consolidate MSI configured state onto cdx_irqs

Prasanna Kumar T S M (1):
  vfio/cdx: Fix NULL pointer dereference in interrupt trigger path

 drivers/vfio/cdx/intr.c    | 38 ++++++++++++++++++--------------------
 drivers/vfio/cdx/main.c    | 19 +++++++++++++++++++
 drivers/vfio/cdx/private.h |  4 +++-
 3 files changed, 40 insertions(+), 21 deletions(-)

-- 
2.51.0
