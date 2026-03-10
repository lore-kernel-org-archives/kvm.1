Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013067.outbound.protection.outlook.com [40.93.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF712E0401
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160889; cv=fail; b=RjvLRUQBYYE7w101EZ2vFYqV/PwAljmmF7X/5ZFXp3jIu8jBqhiE3/aVKr9KrRnEj/74uk4xyE82xxmsiSKEu2NvJM+0m07eY1aAsQ10zY6WTojeOfhpjrbPhW98rzoMCIfK+TDKaquXz4K+lA9XdNBk8YXPHYHPh7fkvRrLtEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160889; c=relaxed/simple;
	bh=zFQW/a1w/3xSnLP7sRV/lNB4NoHGCDNEsDnnFcBqN7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhRFu4F6ESXOSSg85BBZYcW0jUQEBq2bKPct3luIUFWjmmSwbaWswxFWAZlvCugU31TGF2iQindXUyEb+CKer2uFNJHwIOr6yUT1Vk/NBijcEWCP4kF58O5xes+AmBHqUDTK72a1uS45rX2GiPIsDI+spWGVhhCdLocQNQi1Hpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I1K55sWj; arc=fail smtp.client-ip=40.93.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I1K55sWj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpnDOUn27ezch0cq/LalL71ZSyr3QlE6mjHaTN703lCYTomdbSa9chbdQ2YzuYGUq+ivKB4PMSR5vDQ7KhNfQP+NBdI8ywTiPm7pNxy1fL0j2ORjKJKTm7OmfXXH4zPSt0sXDyT2ucNoXte3U1w3h4BVYAREWWQgT0SOqPLVxLFznuvsv9AqHS9Uu4tPwvRB/47JnJzgInD1TnKZQVemKQgRUIK2916MaCWO1Ups7BWyWKhAE/x5+VaBCzsdNwJ2AKGK7oTViDO2hrj65kbK95b3Hon2O5IcfJZzOyylva22NVdI8ckZt7ikUkgycLHAi+hzApLJR0JisQ4IW/oxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbm+ZAL2MZNUhcNF4Zz/TAAKGkEpTc/VHKTHlb+HNjE=;
 b=L6kZKS6DxzlJ0OPPyeIf1GqFg61TNgt4TjQCxVAgWtPo37+H1Mw0lXyhm2jJ6J5IEm3g4hIv0Hzdvzxi/ZbRP67iasjjk8lnIBaq12OZ9lgj6NmH5xYlHtJ2AfiRUj3Wb7shum4OAeFokXmnu4iZsy/Oj3X2fVtc+TBYEjMVr5bqk0zK0tNJWK1GZpfXQ2XN0k/Qgjwn9pNthvRkOTX7BaDaG6GxMJBDkNjrZTRi681DsQzN3Pz8zMsxRcGcIcKi0qz4TO1faBmA1EqI7X/VpjeWabFDxyFa1HoeTQ69DtRkFVUXJjnzB4tLT+a3t/mxavTJ7Qv+sNiwfckg2wjH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbm+ZAL2MZNUhcNF4Zz/TAAKGkEpTc/VHKTHlb+HNjE=;
 b=I1K55sWjh/87SLgvpnuiNLLxw4D092PeKesLwY/JrWi6EhSagL6cfyVwg51JbPjjlQhEYXmJwt1vUpXcJxpLc8DmakwxhGnrRus2qQknwzOJkoeCvm7JiOIOl0ce0iTLM9jQrr55xHsI94K9VKiypdQdO/4GGTRb4xjHf8noNxSYReVKyx5O7D3OfBB3ecOufIgNNOr2g5GdERq+AkZAqTTsZ65iTRAnlHrxWMa9RfTbDBa2NXyFK4ca0OwZmGn0jjRO8UUTz8QwJfTrHQhn1E28E70e6Y/DRm/Vz1qj58NOQ98B6L08tlF+ujfKv3yO98fx7jtOpPFHheW7VxQTXg==
Received: from PH7PR17CA0045.namprd17.prod.outlook.com (2603:10b6:510:323::10)
 by SJ2PR12MB8808.namprd12.prod.outlook.com (2603:10b6:a03:4d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 16:41:20 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:510:323:cafe::af) by PH7PR17CA0045.outlook.office365.com
 (2603:10b6:510:323::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 16:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Tue, 10 Mar 2026 16:41:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 09:41:01 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 10 Mar 2026 09:41:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 09:40:58 -0700
From: Yishai Hadas <yishaih@nvidia.com>
To: <alex@shazbot.org>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
	<joao.m.martins@oracle.com>, <leonro@nvidia.com>, <yishaih@nvidia.com>,
	<maorg@nvidia.com>, <avihaih@nvidia.com>, <clg@redhat.com>,
	<peterx@redhat.com>, <liulongfang@huawei.com>, <giovanni.cabiddu@intel.com>,
	<kwankhede@nvidia.com>
Subject: [PATCH V1 vfio 3/6] vfio: Adapt drivers to use the core helper vfio_check_precopy_ioctl
Date: Tue, 10 Mar 2026 18:40:03 +0200
Message-ID: <20260310164006.4020-4-yishaih@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|SJ2PR12MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3c6bce-0b03-43ce-164e-08de7ec3da91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IYxxMQIs73/JZO5pATR9aZjm569QpgzqrzoPuFBHQ7p7VZpvA/OhwtxtXWoK3hahPxsOAMNFeIqjDIJPrXz0CK+dh/SVKoIMoZjGrUWUnmU4Lu0EuZi4xDUtMbCAAQLH6RBvP8jCHERzA1T7ikjHybfNJT3DOFxcEWQUe4pI5AnrLje11IwooT7GnCR7l1etnviVw21xKPTt3Qp6nS5nmIpl/CSLLWV5ylZzr6aSV/ZJ0f4lFpd/WPpDffN82Cwwmdb+yMpMymBZiPZo9j5w3zL3bUKCv/CGY30unqO7StnZlR7aSvvl2kBTBUDnOhXPnTitgjYiluEpXz/thTeFvPxS+JGtqDIqXQRkgHnz6oub8rLkU2fKgCU0ECEU9qe0z5be2SsgMlH/AhtWCcr4lKgfkwQzTxXAo4L3y7d57sCE+bBe3SFE1xQzmD12vnvW/Nf84rCFHbias2Nttb5bxygmn56OqQWWfXj+FY6S6aylGLjV2LHXBb9vfrI6uN0FMaDRN8/cgcJugnqkceYNddbC3bx7uvQOtaFiUpqEcfJFyiPRMZqqL9ObaQUAk7qw3NTD7mdo/oqgKsv/nJ9vxrFjyKTTR9Lcggq2BxCFhNswk834T6KusmOSd8BL1+45uwNl9N61ds8FLw6w8z3s53QNkr7WXlwU50LawJGlf6YM73f4kP6HFeZ0ijE0468Rp0s0mTIt5RVBFWqIjr1YsiYScGRkgnYoNKbM28YvevCi5sA8RP5nIq5kiM9wjU4SJdJlEyxBfA2aDrbyH1sd2A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zihUv33EAB4r+jSCRNtO1dUG06aMQIBXTDtZJvH6nkFfSkraUC9Pv/bzl/uR8Xz1PVUExCWJPK2ZbmKFMfrtsXnHlRad5ZKsSIa1GcAHWLyu59ncp0alshgZGu2evfN6duDME6jBLgXPiXi8+7xvsGpnnBAFulw3he1Ncg0c6Ys7IjWiwIJicBH5BwTDSERx9KGxLbaC+C1za/0HCS8C2Lnt+NN9TRdx1VrqVjBWcaWEIOgjgA0ispQIDGucdCXuiXV26DErjzwoYF5xCUlWi9LHC4Uny/zwMATS/xfZffBB66S4WYgTU0ap0px38EF2d4T33bpcLzlhx8X41W0xakew6NzC+U+w6uRiG/4SJ6I+dPxp2F1H4P6Dm761/ZzGxwK+4saqbkAKnTt1Ecs1ZYUyIpOiYGAhhbQsG0BKg0xOMoT9qUMaX8IHmGEP3xZc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 16:41:18.3606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3c6bce-0b03-43ce-164e-08de7ec3da91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8808

Introduce a core helper function for VFIO_MIG_GET_PRECOPY_INFO and adapt
all drivers to use it.

It centralizes the common code and ensures that output flags are cleared
on entry, in case user opts in to VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2.
This preventing any unintended echoing of userspace data back to
userspace.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 17 +++-----
 drivers/vfio/pci/mlx5/main.c                  | 18 +++------
 drivers/vfio/pci/qat/main.c                   | 17 +++-----
 drivers/vfio/pci/virtio/migrate.c             | 17 +++-----
 include/linux/vfio.h                          | 39 +++++++++++++++++++
 samples/vfio-mdev/mtty.c                      | 16 +++-----
 6 files changed, 68 insertions(+), 56 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 1d367cff7dcf..bb121f635b9f 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -857,18 +857,12 @@ static long hisi_acc_vf_precopy_ioctl(struct file *filp,
 	struct hisi_acc_vf_core_device *hisi_acc_vdev = migf->hisi_acc_vdev;
 	loff_t *pos = &filp->f_pos;
 	struct vfio_precopy_info info;
-	unsigned long minsz;
 	int ret;
 
-	if (cmd != VFIO_MIG_GET_PRECOPY_INFO)
-		return -ENOTTY;
-
-	minsz = offsetofend(struct vfio_precopy_info, dirty_bytes);
-
-	if (copy_from_user(&info, (void __user *)arg, minsz))
-		return -EFAULT;
-	if (info.argsz < minsz)
-		return -EINVAL;
+	ret = vfio_check_precopy_ioctl(&hisi_acc_vdev->core_device.vdev, cmd,
+				       arg, &info);
+	if (ret)
+		return ret;
 
 	mutex_lock(&hisi_acc_vdev->state_mutex);
 	if (hisi_acc_vdev->mig_state != VFIO_DEVICE_STATE_PRE_COPY) {
@@ -893,7 +887,8 @@ static long hisi_acc_vf_precopy_ioctl(struct file *filp,
 	mutex_unlock(&migf->lock);
 	mutex_unlock(&hisi_acc_vdev->state_mutex);
 
-	return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
+	return copy_to_user((void __user *)arg, &info,
+		offsetofend(struct vfio_precopy_info, dirty_bytes)) ? -EFAULT : 0;
 out:
 	mutex_unlock(&migf->lock);
 	mutex_unlock(&hisi_acc_vdev->state_mutex);
diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
index dbba6173894b..fb541c17c712 100644
--- a/drivers/vfio/pci/mlx5/main.c
+++ b/drivers/vfio/pci/mlx5/main.c
@@ -463,21 +463,14 @@ static long mlx5vf_precopy_ioctl(struct file *filp, unsigned int cmd,
 	struct mlx5_vhca_data_buffer *buf;
 	struct vfio_precopy_info info = {};
 	loff_t *pos = &filp->f_pos;
-	unsigned long minsz;
 	size_t inc_length = 0;
 	bool end_of_data = false;
 	int ret;
 
-	if (cmd != VFIO_MIG_GET_PRECOPY_INFO)
-		return -ENOTTY;
-
-	minsz = offsetofend(struct vfio_precopy_info, dirty_bytes);
-
-	if (copy_from_user(&info, (void __user *)arg, minsz))
-		return -EFAULT;
-
-	if (info.argsz < minsz)
-		return -EINVAL;
+	ret = vfio_check_precopy_ioctl(&mvdev->core_device.vdev, cmd, arg,
+				       &info);
+	if (ret)
+		return ret;
 
 	mutex_lock(&mvdev->state_mutex);
 	if (mvdev->mig_state != VFIO_DEVICE_STATE_PRE_COPY &&
@@ -545,7 +538,8 @@ static long mlx5vf_precopy_ioctl(struct file *filp, unsigned int cmd,
 
 done:
 	mlx5vf_state_mutex_unlock(mvdev);
-	if (copy_to_user((void __user *)arg, &info, minsz))
+	if (copy_to_user((void __user *)arg, &info,
+			 offsetofend(struct vfio_precopy_info, dirty_bytes)))
 		return -EFAULT;
 	return 0;
 
diff --git a/drivers/vfio/pci/qat/main.c b/drivers/vfio/pci/qat/main.c
index b982d4ae666c..b3a4b7a55696 100644
--- a/drivers/vfio/pci/qat/main.c
+++ b/drivers/vfio/pci/qat/main.c
@@ -121,18 +121,12 @@ static long qat_vf_precopy_ioctl(struct file *filp, unsigned int cmd,
 	struct qat_mig_dev *mig_dev = qat_vdev->mdev;
 	struct vfio_precopy_info info;
 	loff_t *pos = &filp->f_pos;
-	unsigned long minsz;
 	int ret = 0;
 
-	if (cmd != VFIO_MIG_GET_PRECOPY_INFO)
-		return -ENOTTY;
-
-	minsz = offsetofend(struct vfio_precopy_info, dirty_bytes);
-
-	if (copy_from_user(&info, (void __user *)arg, minsz))
-		return -EFAULT;
-	if (info.argsz < minsz)
-		return -EINVAL;
+	ret = vfio_check_precopy_ioctl(&qat_vdev->core_device.vdev, cmd, arg,
+				       &info);
+	if (ret)
+		return ret;
 
 	mutex_lock(&qat_vdev->state_mutex);
 	if (qat_vdev->mig_state != VFIO_DEVICE_STATE_PRE_COPY &&
@@ -160,7 +154,8 @@ static long qat_vf_precopy_ioctl(struct file *filp, unsigned int cmd,
 	mutex_unlock(&qat_vdev->state_mutex);
 	if (ret)
 		return ret;
-	return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
+	return copy_to_user((void __user *)arg, &info,
+		offsetofend(struct vfio_precopy_info, dirty_bytes)) ? -EFAULT : 0;
 }
 
 static ssize_t qat_vf_save_read(struct file *filp, char __user *buf,
diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
index 35fa2d6ed611..7e11834ad512 100644
--- a/drivers/vfio/pci/virtio/migrate.c
+++ b/drivers/vfio/pci/virtio/migrate.c
@@ -443,19 +443,13 @@ static long virtiovf_precopy_ioctl(struct file *filp, unsigned int cmd,
 	struct vfio_precopy_info info = {};
 	loff_t *pos = &filp->f_pos;
 	bool end_of_data = false;
-	unsigned long minsz;
 	u32 ctx_size = 0;
 	int ret;
 
-	if (cmd != VFIO_MIG_GET_PRECOPY_INFO)
-		return -ENOTTY;
-
-	minsz = offsetofend(struct vfio_precopy_info, dirty_bytes);
-	if (copy_from_user(&info, (void __user *)arg, minsz))
-		return -EFAULT;
-
-	if (info.argsz < minsz)
-		return -EINVAL;
+	ret = vfio_check_precopy_ioctl(&virtvdev->core_device.vdev, cmd, arg,
+				       &info);
+	if (ret)
+		return ret;
 
 	mutex_lock(&virtvdev->state_mutex);
 	if (virtvdev->mig_state != VFIO_DEVICE_STATE_PRE_COPY &&
@@ -514,7 +508,8 @@ static long virtiovf_precopy_ioctl(struct file *filp, unsigned int cmd,
 
 done:
 	virtiovf_state_mutex_unlock(virtvdev);
-	if (copy_to_user((void __user *)arg, &info, minsz))
+	if (copy_to_user((void __user *)arg, &info,
+			 offsetofend(struct vfio_precopy_info, dirty_bytes)))
 		return -EFAULT;
 	return 0;
 
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 7c1d33283e04..50b474334a19 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -16,6 +16,7 @@
 #include <linux/cdev.h>
 #include <uapi/linux/vfio.h>
 #include <linux/iova_bitmap.h>
+#include <linux/uaccess.h>
 
 struct kvm;
 struct iommufd_ctx;
@@ -285,6 +286,44 @@ static inline int vfio_check_feature(u32 flags, size_t argsz, u32 supported_ops,
 	return 1;
 }
 
+/**
+ * vfio_check_precopy_ioctl - Validate user input for the VFIO_MIG_GET_PRECOPY_INFO ioctl
+ * @vdev: The vfio device
+ * @cmd: Cmd from the ioctl
+ * @arg: Arg from the ioctl
+ * @info: Driver pointer to hold the userspace input to the ioctl
+ *
+ * For use in a driver's get_precopy_info. Checks that the inputs to the
+ * VFIO_MIG_GET_PRECOPY_INFO ioctl are correct.
+
+ * Returns 0 on success, otherwise errno.
+ */
+
+static inline int
+vfio_check_precopy_ioctl(struct vfio_device *vdev, unsigned int cmd,
+			 unsigned long arg, struct vfio_precopy_info *info)
+{
+	unsigned long minsz;
+
+	if (cmd != VFIO_MIG_GET_PRECOPY_INFO)
+		return -ENOTTY;
+
+	minsz = offsetofend(struct vfio_precopy_info, dirty_bytes);
+
+	if (copy_from_user(info, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (info->argsz < minsz)
+		return -EINVAL;
+
+	/* keep v1 behaviour as is for compatibility reasons */
+	if (vdev->precopy_info_v2)
+		/* flags are output, set its initial value to 0 */
+		info->flags = 0;
+
+	return 0;
+}
+
 struct vfio_device *_vfio_alloc_device(size_t size, struct device *dev,
 				       const struct vfio_device_ops *ops);
 #define vfio_alloc_device(dev_struct, member, dev, ops)				\
diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
index bd92c38379b8..c1070af69544 100644
--- a/samples/vfio-mdev/mtty.c
+++ b/samples/vfio-mdev/mtty.c
@@ -837,18 +837,11 @@ static long mtty_precopy_ioctl(struct file *filp, unsigned int cmd,
 	struct mdev_state *mdev_state = migf->mdev_state;
 	loff_t *pos = &filp->f_pos;
 	struct vfio_precopy_info info = {};
-	unsigned long minsz;
 	int ret;
 
-	if (cmd != VFIO_MIG_GET_PRECOPY_INFO)
-		return -ENOTTY;
-
-	minsz = offsetofend(struct vfio_precopy_info, dirty_bytes);
-
-	if (copy_from_user(&info, (void __user *)arg, minsz))
-		return -EFAULT;
-	if (info.argsz < minsz)
-		return -EINVAL;
+	ret = vfio_check_precopy_ioctl(&mdev_state->vdev, cmd, arg, &info);
+	if (ret)
+		return ret;
 
 	mutex_lock(&mdev_state->state_mutex);
 	if (mdev_state->state != VFIO_DEVICE_STATE_PRE_COPY &&
@@ -875,7 +868,8 @@ static long mtty_precopy_ioctl(struct file *filp, unsigned int cmd,
 	info.initial_bytes = migf->filled_size - *pos;
 	mutex_unlock(&migf->lock);
 
-	ret = copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
+	ret = copy_to_user((void __user *)arg, &info,
+		offsetofend(struct vfio_precopy_info, dirty_bytes)) ? -EFAULT : 0;
 unlock:
 	mtty_state_mutex_unlock(mdev_state);
 	return ret;
-- 
2.18.1

