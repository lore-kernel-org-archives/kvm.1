Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54128314D2D;
	Fri, 17 Apr 2026 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439735; cv=fail; b=F6A9DZDboodDIA9ynlXnY6IZCKZtHEJ0QkfexeisVAHf5aqUqyBY2RWaKBEDkqUDRq6lTUj8O4PaRWpDZlOT2B0gKT61iol5xHX7uMPRAG98fE0T/jURTQ/9lPlih/ezI1RqkIOKvVIEUMXJRkc00qyyEfPBoeXhgqL+i000zhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439735; c=relaxed/simple;
	bh=bHaMgbmBEv1TWd75f8jKYX70moHzJKTQL5L8BJHi2cc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dw0rup+dmElLHMwBYM/u27u6Ed02gYVjqcdH/PoKvmhZKo+ZwvvRtdN7NuHbcpJShIsBEqJ5eDX4r30Im3BW6FwrZcasqZx5jr4IpBLkrQ3pkPWKVZdn8wH/B/4dtbiyJcPecKV0Mo9+m58BgfE/6a5HPmJZN2A6yFH69uB8qDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qLaOblvZ; arc=fail smtp.client-ip=40.107.200.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qLaOblvZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pM/5FuFyRLwh4EBpLt5QMh35+eupmwrghc1R/WNdkZLjSHBgtmNOBeCFiT0BWJKQCgcWvvg3jolauCZqSOFR1i6lKe+eNaLRRV0Ag3roD45+3qKAoAxu6vsQ0pzOcWazD5iP8WBNUCOUrEkW7CB6LtwpZukGAt0LnNNqLsQPWA3c6MVYtlTXVfRvsLFDwVfViUEm2Rz0tfQu77k+VKEeOFt1n5LLNIFoPHSPzNQ4u2taivPnQHAb1WqncHRl9/nLPwY5P/hUpMmhzUJYbgAZCVha5I3b0i/5JCzKWG2StUtmvyzaCrH2x4FwMo5uoEbqALAAIkkbKfa8FYWzJwFQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3PPmlHtx6kr92owjZ8DKCsIewxsKzXXIRh4KGDBsUQ=;
 b=D1VLlTXvVLRsoY/9+0vk8Ji8odo8df4U8nD3wvRbqJyoNDfKuXKtzPLviIUCXR7cdGLq0LICubuwZL/bmf/bb+xOC681OGDuaIIZMaapl1WDk66rjkMghXzXa9/CT9JSsJZ3NcaZP0PeKH3HPZcLMKgU7gzeEux/XJeeF1Vn7SUT0RbsWJa1me16/l2xaGPjjXQrGscALsZeDl57oxI43fQ7/n3ygEK5IT7Sld5noIJCQBTEq70z70G7olZ9zGzWqOUO+aGUD7G7bA1J/AzFr+fnBS73qGtOdxVjBCBf5GheV+1QNcT9IBZW1UYSKk6xWC2Kn3Ws8uTXvwlnZK0UGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3PPmlHtx6kr92owjZ8DKCsIewxsKzXXIRh4KGDBsUQ=;
 b=qLaOblvZB0fT7pUVCuMWs5qy2MpMLHeZX2zX5uWoiOVoYfDc5ykYlip77C/C047Y6uNctt/0iYoi+V2MsROC2ytXeEJ5VRyRklGZc+TlvVzB40aV2XfUa5mwPyWTTzWVM5yvkngKTOOAjn1XzYTZwBCVHlmQrRNhSOj8DT60R8lB6/jU1lWe87KeuDD3zla7m3JESm3spELGId65v9mTTRkWs77qj3BrkJCIYYBdqR09Q/MAqGvy13EvJvrP9jFT2LQZn3IQILcq+kHVjTQAJIE/igxnBxEDQdh7Psfrj9R0JNLfd776zGn36lMBagU/sOuVBdRexS2B8tRhjkw8sg==
Received: from SJ0PR03CA0057.namprd03.prod.outlook.com (2603:10b6:a03:33e::32)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Fri, 17 Apr
 2026 15:28:43 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::51) by SJ0PR03CA0057.outlook.office365.com
 (2603:10b6:a03:33e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 15:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 15:28:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Apr
 2026 08:28:25 -0700
Received: from meforce.lab.shazbot.org (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 17 Apr 2026 08:28:24 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: <alex@shazbot.org>
CC: Alex Williamson <alex.williamson@nvidia.com>, <jkoolstra@xs4all.nl>,
	<gregkh@linuxfoundation.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] vfio: replace vfio->device_class with a const struct class
Date: Fri, 17 Apr 2026 09:28:12 -0600
Message-ID: <20260417152814.18026-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|MN2PR12MB4486:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe18c79-a45f-48a9-eee2-08de9c960289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|13003099007|56012099003;
X-Microsoft-Antispam-Message-Info:
	BLxuXWGoCg7J44uhraPh/FoTX2cvdFhL6DPFtbm0R3kVVn/epIVcElcz6ZMxsRI3TBpuh48/rNrmqySBbVMWmqTatH7e+2F282Ta0Xc7oQ/+m3fLMDlBpZIpmTd2NYXOa+cUH3ssZTHhrflTnAjcqgSMhVGJrqJ/bUSLKYx6Y/tRg3h9GLeqja2WoxOgxRW1FM+4MoBxz2aKcqwxvY17i60sdHwi55Xq7Jl1QAAUEPLq9br3kmTRydYqUqnsvMfrFk8r9kA154Q6UVzDwVXsGUzGOTuSnm4kWOIuSIOigCuRsyDX4ad2nhqkIJoFePz64wBy43/CgzBn5rEGg8mqpgklwxk4HKU5fdg4QdzyhMTArkDjWWc9RiXJpATGKmiB1xb776HOjb6jgV0dIWhck/4U3HtYyJZc4w5Zfc6ZN8Nq4ugcTV1H6uWa97HPdP3+eEXjf+XLy4Wz/IOeDkof1EjUltLGLUHr2UzgthTQI7Gld9aBZOwoHrbinc+PdZKxdHivVtZoX0y00kigJ4BxmiS+gOa+ctahnnRpKbBCdisERIZtTs5NwkfEZWVESuJUHLFmG4x+ECa9AlRDddDKdBVKcwdxuCVeCRAIkycX2uAs+Z7ANlpqXjH9yPWON5LAetPZDElq+YOc9u3oIm/2DEZHtyFTnB9Z6UmYy4ZmuPOFpfS5fn5cn01n23yjxxGToLJy+dZky0aCJIPO3kX/fSS9i4ot6/K3Y49Pk+H1z5A3yYXfvV49bYxfetRVt0hzXmPj96N20A006iXgYxCw4Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(13003099007)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vpR69ARJFNNU+itSy6Qn2JKMfgshhMbbxeHngpvCg9tcaXdyuRSwHsUkZmuJVEvHXg9vLVBaf34KN7+kXkoeejcYZXLMUMcm3nwHo++VCjSXylGCk3ZGthpMgnieo5f2dzMWM+5BkCn52uKqszq6l1jCgpjTArcld6Uo41s+b6fajUIzAwe3tP/8RP248YReqzWr0CAFhsZvTaXHGkiF+qg8JeUS1LsXe5vIplDBNIU2QPxbeWh/Ujnricx68JjnMloglMLVzbGduW0OCxeSiT97dNq6IMCPUaFbxd8De3oirm5u+uD23Qb5afUKG10P5Dfe2BJW9XP4c6K0g48tTbfSnARCNEgT/tSfGn9EsaGtLenUgQ9pu7MnumFU4JTZhOIcA4xaDx0YhrHHvP3pYVy7AaQ0ypSFvQv/5/6dHDaaY+D8QejcG4ACko2Ut9jS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:28:43.4226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe18c79-a45f-48a9-eee2-08de9c960289
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486

The class_create() call has been deprecated in favor of class_register()
as the driver core now allows for a struct class to be in read-only
memory. Replace vfio->device_class with a const struct class and drop
the class_create() call.

Compile tested with both CONFIG_VFIO_DEVICE_CDEV on and off (and
CONFIG_VFIO on); found no errors/warns in dmesg.

Link: https://lore.kernel.org/all/2023040244-duffel-pushpin-f738@gregkh/

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
[Remove unused vfio_cdev_init() args]
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---

Follow-up on Jori's original series that seems to have gone cold after
review comment:
https://lore.kernel.org/all/20260306204032.353452-1-jkoolstra@xs4all.nl/

 drivers/vfio/device_cdev.c |  8 +-------
 drivers/vfio/vfio.h        |  4 ++--
 drivers/vfio/vfio_main.c   | 27 ++++++++++++++++-----------
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 8ceca24ac136..54abf312cf04 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -293,14 +293,8 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
 	return 0;
 }
 
-static char *vfio_device_devnode(const struct device *dev, umode_t *mode)
+int vfio_cdev_init(void)
 {
-	return kasprintf(GFP_KERNEL, "vfio/devices/%s", dev_name(dev));
-}
-
-int vfio_cdev_init(struct class *device_class)
-{
-	device_class->devnode = vfio_device_devnode;
 	return alloc_chrdev_region(&device_devt, 0,
 				   MINORMASK + 1, "vfio-dev");
 }
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 0854f3fa1a22..e4b72e79b7e3 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -377,7 +377,7 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep);
 long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
 				struct vfio_device_bind_iommufd __user *arg);
 void vfio_df_unbind_iommufd(struct vfio_device_file *df);
-int vfio_cdev_init(struct class *device_class);
+int vfio_cdev_init(void);
 void vfio_cdev_cleanup(void);
 #else
 static inline void vfio_init_device_cdev(struct vfio_device *device)
@@ -410,7 +410,7 @@ static inline void vfio_df_unbind_iommufd(struct vfio_device_file *df)
 {
 }
 
-static inline int vfio_cdev_init(struct class *device_class)
+static inline int vfio_cdev_init(void)
 {
 	return 0;
 }
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 8666f35fb3f0..6222376ab6ab 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -49,7 +49,6 @@
 #define VFIO_MAGIC 0x5646494f /* "VFIO" */
 
 static struct vfio {
-	struct class			*device_class;
 	struct ida			device_ida;
 	struct vfsmount			*vfs_mount;
 	int				fs_count;
@@ -64,6 +63,16 @@ MODULE_PARM_DESC(enable_unsafe_noiommu_mode, "Enable UNSAFE, no-IOMMU mode.  Thi
 
 static DEFINE_XARRAY(vfio_device_set_xa);
 
+static char *vfio_device_devnode(const struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "vfio/devices/%s", dev_name(dev));
+}
+
+static const struct class vfio_device_class = {
+	.name		= "vfio-dev",
+	.devnode	= vfio_device_devnode
+};
+
 int vfio_assign_device_set(struct vfio_device *device, void *set_id)
 {
 	unsigned long idx = (unsigned long)set_id;
@@ -299,7 +308,7 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
 
 	device_initialize(&device->device);
 	device->device.release = vfio_device_release;
-	device->device.class = vfio.device_class;
+	device->device.class = &vfio_device_class;
 	device->device.parent = device->dev;
 	return 0;
 
@@ -1804,13 +1813,11 @@ static int __init vfio_init(void)
 		goto err_virqfd;
 
 	/* /sys/class/vfio-dev/vfioX */
-	vfio.device_class = class_create("vfio-dev");
-	if (IS_ERR(vfio.device_class)) {
-		ret = PTR_ERR(vfio.device_class);
+	ret = class_register(&vfio_device_class);
+	if (ret)
 		goto err_dev_class;
-	}
 
-	ret = vfio_cdev_init(vfio.device_class);
+	ret = vfio_cdev_init();
 	if (ret)
 		goto err_alloc_dev_chrdev;
 
@@ -1819,8 +1826,7 @@ static int __init vfio_init(void)
 	return 0;
 
 err_alloc_dev_chrdev:
-	class_destroy(vfio.device_class);
-	vfio.device_class = NULL;
+	class_unregister(&vfio_device_class);
 err_dev_class:
 	vfio_virqfd_exit();
 err_virqfd:
@@ -1833,8 +1839,7 @@ static void __exit vfio_cleanup(void)
 	vfio_debugfs_remove_root();
 	ida_destroy(&vfio.device_ida);
 	vfio_cdev_cleanup();
-	class_destroy(vfio.device_class);
-	vfio.device_class = NULL;
+	class_unregister(&vfio_device_class);
 	vfio_virqfd_exit();
 	vfio_group_cleanup();
 	xa_destroy(&vfio_device_set_xa);
-- 
2.51.0

