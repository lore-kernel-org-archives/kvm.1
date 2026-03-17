Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011013.outbound.protection.outlook.com [52.101.57.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F1D30EF89
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764339; cv=fail; b=BUBD0AIFBtRBaEsuxnXmDm+dyMtQK44dB8TZnRpT/rbIeaM1QI4NpzRflM087q2YyXghw5KA/0Ezm67JNojiWeT+Ka17YdthrM5zI6FMm/2d6KyLUj7QPOTuXjt2n31HMB9MOJ8r0UmlytfqvgAkzZ27Vx5g7IbDh+zdKizcgoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764339; c=relaxed/simple;
	bh=+0TtxS7qrKo12wUOjwfP3HMCW9BQWreESd5KOgz2la4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOMKO2nbMWAxMTdA+uEZZvDSqgj9cATgF1DlBwR1DYJi8gD/wP/MubLriFVtQ+jfqhOAnofNnqrBRL/DviunsgvaXHPfNsKz+s7TaD6/EUnQmignbKUjbPQZpPtcJnBuQh36iPqUsdR5YVe7mOqzQbiWevIf1bKs4oZTuuG4iRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NUAYOF9a; arc=fail smtp.client-ip=52.101.57.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NUAYOF9a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTAJn1p1kiOL2MY/xZaGvA2MLIkrCDi4mWLALw3Al33lt1bx5x8p02cHarKUA3dsvOm9kEn1kVFB+bK0+fBXqBc89oGihHIbgLpShqdtltpyn9z7g3NrQqrjPmcstRuCyf84GJb28I3xRoKmTGmJy30jXWhHVkmuiR+Qj+5/9u6YoJxQOqx5cRhOtJgOaIqHJnJvNHXgJziObzqhN/ipCLhQdmRsHZMqHJCf0o1Yn8OaCWpbBBvFuV1O18nVljY4TPHopoA7rgSa/5/rIKV2TCNC9LxRfoM1y8VFKv8asd7fo6W64UVX87VkB1V9/ruALnrDpFiOmL+tvRUXYPaRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKy3S1GIZNYO0M6V7ev87aUVilMUaimUIpukNf9FUR4=;
 b=HdQFDJJkqXTonczHPFurZvr4m+cBmqFz8oQ4QcBtq4Hw42foMvjce8o8ZO+qXb16lrXpEhi7A/iT5AOXQrTJJq0Ml/lQDv6EOv7rlkiBxPTG5rHHdvJ4Q8bjGvTp+KDqf7QYNkScsiUY8eGJ5bSfAQ2wzSqNp3qh9AB1joHOv2qnb6fCLkPs2UlaS/9V1eT12gh7oQ9DjM1Et7sZ6iuviSbGKrxAWwyekurruxBu7iyRPalGWDhQB/YeUkTla+1kXgE/Jn2mov7UvOZ4mSU+yikdZ9hS6RyW+h2i0slczSH42kB+oR140xqN1YbxYKWsm/Q2mIf2LcM7DwCWRd67GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKy3S1GIZNYO0M6V7ev87aUVilMUaimUIpukNf9FUR4=;
 b=NUAYOF9aJQ6Ejr+4mn7bn2i1CCbKq8oNSL8ZPqXErjnEaavwLsc6QxI+fON/xlCo7NFb6ONVUKO1yksY3NQKlBxTrRHvflZvcGzU1DzhFkjRgSXC3TRYN2/f2oqA8fzPnuuYSYJmBf1Wqkdr2dq9yOIDC4AzA363QauNN2DChmrNsFYbCgl+ouPgG0mGVIFI8hvVFN7ri6Kt+VqjpN2bO/0plcaDEiORfoCXL2IhIjm3JUMldWK/JSkPXQKStp+bQA0/TMntMiYlhJ6P/lBrq+kBQsVlHgecav9ImaNpW1f/QfkYuzYmHHbCO7ooHbZBT9hgNCgtIQwxciV08kPO/Q==
Received: from BN0PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:143::24)
 by SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 16:18:45 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::f) by BN0PR10CA0021.outlook.office365.com
 (2603:10b6:408:143::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 16:18:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:18:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 09:18:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 17 Mar 2026 09:18:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 09:18:17 -0700
From: Yishai Hadas <yishaih@nvidia.com>
To: <alex@shazbot.org>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
	<joao.m.martins@oracle.com>, <leonro@nvidia.com>, <yishaih@nvidia.com>,
	<maorg@nvidia.com>, <avihaih@nvidia.com>, <clg@redhat.com>,
	<peterx@redhat.com>, <liulongfang@huawei.com>, <giovanni.cabiddu@intel.com>,
	<kwankhede@nvidia.com>
Subject: [PATCH V2 vfio 2/6] vfio: Add support for VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2
Date: Tue, 17 Mar 2026 18:17:49 +0200
Message-ID: <20260317161753.18964-3-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20260317161753.18964-1-yishaih@nvidia.com>
References: <20260317161753.18964-1-yishaih@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|SN7PR12MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c67233-0d33-4fc0-c9d0-08de8440dcf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	BrRrx833t4a7VhXK3a3EX/zgFugZKzN7LQ9nSxtl5B2sgdbb9nWBvOtEbgDIBZSAmcaT6BplhyWwXn59gitTWE+IZGXP4oaNEk3hQMjcAU0Kd5nbDkxYgnX0RAHo+ecLmamg9t7GWiqkk1pPrFOHX6fM3ux7d5LUfDa2Oj+rf8klP4YjmQsHxf/+oXsl6VsQa0uJ+dpCw5i1DTewqKdG5ymROlevr+CpHHftkWirdaVTdpRz4ZudWPRSqkf9ZX9nrPdVF1cQGsU3XTgriBLFzW6msMYDU1X7wPSmDQfOoWbmH3CTpRCTIM6p8N+wgAP/etsLw/vpaWJUcLrmvgedbQgxtQBnviAL+3qAjhdjHrvc+R9AXC4HzgWIn033Aum1mBYg/DXgGiNT24MuaIDF5a+aP8ygpA6fPY2l9QFVDhjX4CMgoVv/d9uXViVa5PcScBapRPxBfkzJA8hfDjf6pyaTUtID8kl4RUfbP+iF0IO+mVkw9Nel4xzaGhPYbHzGjaxFAxTyqtttv/iv2h7l+dMyvJQd6QPLjM6b/3mtBKkdwsQVY+50Hn5uICKR/NFpDRDSg/H1MVn6hE0W3z9q6dlItXolqIXjN+bWdWnB/7si782lO3CtRYSlFvyIsH6Kco2apISTi4nc5PV12cWUUesjFJSyBceFOBFAbHiYup4NqXC1eQxO3Pp9Ne0WrT8tmVeZOQeVfWCJ06bDM7xVWu8xh5+uV2ai0mo9KcYWVF6exRckYxJqMluNwUAY+xj2dUJpLtAx2FFZ1G/tLQc3AA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gGI3tQ55ESG1WQ61Mlgy7Hm1Hf59XgPzIkJ+mF/omU9axxz6/aW4jmFM/O3ba0m4Xt0DSpSvEgW6ykLOOZWO5oaAQwHAQDHnVQsl3ZvDb6JUVw8qSqaxiCp08TpU7FrkW0J7lioJpdc336nw1E4oFvffgADNHh6+hWYxgV7kybgzYHsqmiMlEFBZBo5WqmZE9D6FzT4THFwKEEnA9JKbnshxEz4fmO5DHbUJJSa6BnCZTxx2PRpE8myAe0OFya6hxDAn83925kdSFBs0BV1B4Cg9m3ly/ezO+xcOhJ2s3CqZ7KFCyBk6Wtno0djgj2eYLX+eav+b5UmKR4QOnJjQfDWlvsbiQmdbftaUVpnS3EDg5PxMyA8wf9hoMFAEhjToWHtGFV+kwVXMcppCL6bdTUDrhPYiZ2P5JjfInDgUh7Dm0Y53G+w9K0q+5rK35sym
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:18:45.1258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c67233-0d33-4fc0-c9d0-08de8440dcf7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768

Currently, existing VFIO_MIG_GET_PRECOPY_INFO implementations don't
assign info.flags before copy_to_user().

Because they copy the struct in from userspace first, this effectively
echoes userspace-provided flags back as output, preventing the field
from being used to report new reliable data from the drivers.

Add support for a new device feature named
VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2.

On SET, enables the v2 pre_copy_info behaviour, where the
vfio_precopy_info.flags is a valid output field.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c |  1 +
 drivers/vfio/vfio_main.c         | 20 ++++++++++++++++++++
 include/linux/vfio.h             |  1 +
 3 files changed, 22 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index d43745fe4c84..1daaceb5b2c8 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -736,6 +736,7 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 #endif
 	vfio_pci_core_disable(vdev);
 
+	core_vdev->precopy_info_v2 = 0;
 	vfio_pci_dma_buf_cleanup(vdev);
 
 	mutex_lock(&vdev->igate);
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 742477546b15..dcb879018f27 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -964,6 +964,23 @@ vfio_ioctl_device_feature_migration_data_size(struct vfio_device *device,
 	return 0;
 }
 
+static int
+vfio_ioctl_device_feature_migration_precopy_info_v2(struct vfio_device *device,
+						    u32 flags, size_t argsz)
+{
+	int ret;
+
+	if (!(device->migration_flags & VFIO_MIGRATION_PRE_COPY))
+		return -EINVAL;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET, 0);
+	if (ret != 1)
+		return ret;
+
+	device->precopy_info_v2 = 1;
+	return 0;
+}
+
 static int vfio_ioctl_device_feature_migration(struct vfio_device *device,
 					       u32 flags, void __user *arg,
 					       size_t argsz)
@@ -1251,6 +1268,9 @@ static int vfio_ioctl_device_feature(struct vfio_device *device,
 		return vfio_ioctl_device_feature_migration_data_size(
 			device, feature.flags, arg->data,
 			feature.argsz - minsz);
+	case VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2:
+		return vfio_ioctl_device_feature_migration_precopy_info_v2(
+			device, feature.flags, feature.argsz - minsz);
 	default:
 		if (unlikely(!device->ops->device_feature))
 			return -ENOTTY;
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index e90859956514..7c1d33283e04 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -52,6 +52,7 @@ struct vfio_device {
 	struct vfio_device_set *dev_set;
 	struct list_head dev_set_list;
 	unsigned int migration_flags;
+	u8 precopy_info_v2;
 	struct kvm *kvm;
 
 	/* Members below here are private, not for driver use */
-- 
2.18.1

