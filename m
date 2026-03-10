Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC263064A3
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160895; cv=fail; b=USg0imqYGRmtkZLH5PgqVijNxZJ63CESX3PLuftLQH5PhIPk2edK+H5VhGbDh2iwVL4O0lBf41SEByv9JOTBrGTP+SJ52fRrALOQqg3atED4+WhI69d8yVSDngx8aEsSwaZnPLuT6jb8XUITsan/cvx25s6mAfUYkNqeUIy+5DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160895; c=relaxed/simple;
	bh=+0TtxS7qrKo12wUOjwfP3HMCW9BQWreESd5KOgz2la4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/D6LXOMIzU64HruFtpUyvoQgJt4MZ1uBA1r1R2L5e7wDVmvnIjKh9mcK+OWIRqT5xjeCFhtXfarL37bW19xLPSZCXCDp3/SJhMfODfK/hz0IswPl6/EajcE6dsleMJ3m9WCdIvvK0YO0xdyN3QdpUG4wr5VSD2LL2JrJt1YY90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Da7SNT3C; arc=fail smtp.client-ip=52.101.62.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Da7SNT3C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3MiURBn5YI+Lr7asuEe4jlrs3YyitkKT+drNbOYo6zIhkZW1y36cdci5NeOEi17BxfdeLEQRZY6zD1LgNiWrMzPXLIzketrOXA0ElnWOUzFEhZaOMfxIryNfF51dQoTQzc0h6UKUpbBcJ7TFREhIz8bTyUkwGoD2M7z+/Ml8N+bnnkjH0VJCIh+EhWJ5x/Y6uldxdckNozrtBV1iCGDj4KANtK4R7ltbVIJ8e+8FDFcdN0XUP1Jpno0AmJ0BaRWGzmLB3+sl79B/qRUOBppwUAXmKtbnAru8hxVA9G8CDrkDJ4wPXbnVz6HxqRL2nTlg4cLrw2gWfi8rUEbSfZTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKy3S1GIZNYO0M6V7ev87aUVilMUaimUIpukNf9FUR4=;
 b=H5/lI00cSs7PYvCvksxnSFVbqSiYcSf1+KwsvF8Rsnlzz7EsywZdwQ5vWMXsJu8tU5KpCoOhHLviA4/Yc82T44sUz4GloYV7br1an/meWVyRiR8DzdT6u+5B+/5eILNHNZs9SwwQt9qj/zgXB1jw8mCK0UtnSaD6z6sSv5A3LCcogC382vyrr7kRRUe2ori6fNWZRe2OzQ8LPD9c6rQAS8h8H6ur4pA4TZROcdESnCp08qLEjYHYsDV+vvO9SPTI/8mz719dQigYRpEqrnobCTgQQWznmi8T7Ly0jb2vzpAdq6D04GKlRLKFh6pzd0y6ZxyTLbaiiL1/gK4mR1hZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKy3S1GIZNYO0M6V7ev87aUVilMUaimUIpukNf9FUR4=;
 b=Da7SNT3CZSvtaekfCV+K3dyWHZ+SKBCYjJmh0itr31wgP47m3bsEGWM5hBQJmbLCvxXExkadepMJY/Ve8hyVUziJcfb/0RumowK6mL0rzKu0aZsl0DgXPrZkVZKgTGjU44aC/7hbdekrEb64QfFWapJv9VhwXHLjHOh0JG9+3igtZDJA3qPywoq0I6H3G+bWJti3pXBpuErA9caWYAL4gE57zJ+i681FlYyv+Ehs6++eKh6X4NGibsIuvrstN8tTcq+5IFNUcZoXoD210K8zp7BUfZPxhbgSA6KYkafO2v5MiG0+c80J6PqmHh8mOEPdkBKxXjeaa7y93E2fDwuHgw==
Received: from SA0PR12CA0007.namprd12.prod.outlook.com (2603:10b6:806:6f::12)
 by LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 16:41:21 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::7c) by SA0PR12CA0007.outlook.office365.com
 (2603:10b6:806:6f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 16:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 16:41:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 09:40:58 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 10 Mar 2026 09:40:57 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 09:40:54 -0700
From: Yishai Hadas <yishaih@nvidia.com>
To: <alex@shazbot.org>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
	<joao.m.martins@oracle.com>, <leonro@nvidia.com>, <yishaih@nvidia.com>,
	<maorg@nvidia.com>, <avihaih@nvidia.com>, <clg@redhat.com>,
	<peterx@redhat.com>, <liulongfang@huawei.com>, <giovanni.cabiddu@intel.com>,
	<kwankhede@nvidia.com>
Subject: [PATCH V1 vfio 2/6] vfio: Add support for VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2
Date: Tue, 10 Mar 2026 18:40:02 +0200
Message-ID: <20260310164006.4020-3-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20260310164006.4020-1-yishaih@nvidia.com>
References: <20260310164006.4020-1-yishaih@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a83f2b0-53cc-4405-029d-08de7ec3dbe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lIb6ofXfH9CYwJWU8kLBpUWjAvc4+0MEex3Rjj7h025zDA73lPqY45QJzTXZuf2tjcoyZUkfF7RXmrbGWYNJOIGBE60jJ89VGwj9Uw4e19Sqss7fYYGVVhma4LG8SHVtDPotCn7z40wKZrAbr+JWozTyv5JbcUA59gT4VWJoph3FG0LGNMpARbY+/VX33sPKFn+RcyltL4J7C1g++E4E3eUXRQ59hGSLrq4tV9ww8h70433x+PpaWIn2fsq57HaiRvWJ8kQvL/Z+EslREQ8mG6awMxM+KiVO34MH/jqR24j1ksoF0FaokQioMFe+zk4GlNyDKl4jW8PjjjaKU7fVP32TZlieyUMOYNoka4dFMoHfDD7YaMq9m9pfb0u339sx9iy8uorL7spvXr15euaLU4qN6Dz20msBVvVJSOb1u5J8CVsDM1AbXvvcaKTNYRTgIOYYjFLeGgIwvhPTzeYUxqHnKA89MdP7S20YpPNY2nP2EYd9HV2KJKrs11esBr+nLxXKvjHTqxhaGGtBiTQr5HiQ4aoN9CRY0UZ1/ArPU6h0XMyQBMmRZ7bjlZjmEsL4kAXVUHPZ40YuztTY5JHXUhg21k23UCU4wcFs7H0QhHUfbv1+0EUM0K8toW19B8G+Xei/7tI1l+iZZcbxcm+4Qly15VbOWC5HvpEqak2b9OZqfQ73CSz72TutVHzv1TBVHpBBWvcbA6Hargvn2wKqqJTj+sPlo3sJL4viLwg9FzcQAff0HAy8NyLwukgpXRVHwK+NfJogUFR39FZAOBybXw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KIObgkmbkOvhe7pbhZk1wpkX8Ycowqwx9+BJQRF9ABoAKg0PesZo2cTkh4FOXn5+l0Zm2B6QhfEmqtq6occS3pxCGKPFmw9+cEUkk/r9Fen20GelKa7odG0B+N6MOg6MN9hm0KMfkBfcGIvR8yOzCpfC0n4G0M5z8XmqKSHL9GjZvvFsQYhwBVN6PVH0ALiOeBaQ6npiblubZigHflmfCXnjq7z+JZ8ocwc87MohSACuBBAnCXQAeYewfV1rpEd7uKXxeNWBL82AiwNgPL0x1QApjri9mxVS+bDcKLuxOG37AXu/T+srFQ6w+X9DuEX4D6o3LcqDzqkUsZ+bvNXCvSmpyU/BVz8JPm6FFkcI0PecIkCp1/UXim8UKOINUnCLiLy9Eyrh4FXkCca43jKb2jHYvTWNwo+P55OUaNW0D5v/nvtNHDrM+FP37la7YiCk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 16:41:20.4781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a83f2b0-53cc-4405-029d-08de7ec3dbe3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264

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

