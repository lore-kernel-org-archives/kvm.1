Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012028.outbound.protection.outlook.com [40.93.195.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A4C305045
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764336; cv=fail; b=q15Lpm/0Yr8wi4pxEBnX72z2z9sFMVeIAd7eLQmam1Zl3gYtka0439q6gwf1vmQAOpIqTypMJ+mVB+2ZDlP/ZilIP4j0XbvnzYRcxjnUth8WZvi/QW6XpOwDB4bM3wvns5ZGYKFZC+iFmwsOiQvInyIX0GDCx21V1HXSOLpnOto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764336; c=relaxed/simple;
	bh=zFQW/a1w/3xSnLP7sRV/lNB4NoHGCDNEsDnnFcBqN7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgFIMtEodHEpPYxJgBn9ViOH97LfOJybhlJm7eJ+nXs8vARoItfTYyOWscWBqUDEPy/9UAi5pS59Ez22ntN+rgqo620OpzP0UpI6MM0nLxaLrPBwtVxgYmPIx9mdwzX7r0gY5LcwUH+ecTSrq9EWfiIvTGqt6SvIUStzohhuesE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QiTrU9ZH; arc=fail smtp.client-ip=40.93.195.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QiTrU9ZH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3GXIpcm+FmC+fsZMDdBoMaSZykCdSSjC4qMyZ95fj3mHTvPtGyzudbk9CktfbbReysbv1f5frMaePEhaoHscxFoVyMnksAjqmUuqYjpMqxYOm1VEEghjFLGnNDCPzGjttovFAwwTeLzrWI7q7+5gnu60IwWzK5MUZObyZi6MFpwN8Hl3Furo3I24b5rfso0MemlHhQf5s2ZLkDWDGeX9JSKtFIt8i8EeX6rGCeWnrhtXJahyqVUXlTp4MBhb4MTlxccdNDOEhWoyDUg+9x2DqvuxXi5JO0BO2cTqwejrcesd/UcknVSZQPOaY6eTvhAs77DCA1Q6rBkrX5YsYR4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbm+ZAL2MZNUhcNF4Zz/TAAKGkEpTc/VHKTHlb+HNjE=;
 b=jpUVDTFCCVD/Op1V7aCYCzhn/f836FDNuXgLI8xA1rA3756f5tev0VIIY7AIxO6XdI03iKDYA/xbwObWAAgMEsuTitt3jrpZaXFQZMvkmUONJWySQrCHL0Pbgv2fV0vF60tEFL/ISVeagwEneAeVLa8rr5hOK77AaG6JhkvvrSG0zvfTLNg3u8XbGss49ABMvNazY37+C3entoEtzAe5hqodTyVBjj46u7chp+tIWMGMmyPDs05JdM074dPBiXYe3FBZ0WbIIy6AqF+ICsaqiKUd7SyboN+wRbBRURV4WCC13z2v1qYwXHveIi/wU0UN7Cf/5KyHncuOWF520i/RgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbm+ZAL2MZNUhcNF4Zz/TAAKGkEpTc/VHKTHlb+HNjE=;
 b=QiTrU9ZH+TP9FYjcSbW1dO4q/NuoDUrvHKw9Ws3EvpMutby4K2/3mnsA6GyWUk2v+lMJa6OzceijQ0L+BjgVk2eT1vabrhVtseGP08uZLDVaienW350xJeReV0h68Ue+4myVK4sufT1OQQ5Nqj0uvBJXTebFJGrjBaUSoB9YNsYVud6R9Ffx+oOIsTBtqEKOpigCMfLrnXrZOxZELfr1o0JOR56VdGs5lVpTw13aF1NG8gtgZVILoqSnoHL+QfD17hIQpwRy9tN4pLbxhfKNeXnfMDFherCv3LGClDr0q1+5s5sTpioYR0I94hSBRV3nE24VaLe8zo/oKgDYO+nS/w==
Received: from MN0P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::15)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 16:18:46 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::1a) by MN0P221CA0005.outlook.office365.com
 (2603:10b6:208:52a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 16:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:18:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 09:18:24 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 17 Mar 2026 09:18:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 09:18:20 -0700
From: Yishai Hadas <yishaih@nvidia.com>
To: <alex@shazbot.org>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
	<joao.m.martins@oracle.com>, <leonro@nvidia.com>, <yishaih@nvidia.com>,
	<maorg@nvidia.com>, <avihaih@nvidia.com>, <clg@redhat.com>,
	<peterx@redhat.com>, <liulongfang@huawei.com>, <giovanni.cabiddu@intel.com>,
	<kwankhede@nvidia.com>
Subject: [PATCH V2 vfio 3/6] vfio: Adapt drivers to use the core helper vfio_check_precopy_ioctl
Date: Tue, 17 Mar 2026 18:17:50 +0200
Message-ID: <20260317161753.18964-4-yishaih@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d6efa5-a136-4990-43ec-08de8440dd8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pBseiQIIe9q+rkrvg98lCL54hXBU0p+Dh3XAtTpA+0uegp4WlN+14Z5PVWsj9di4fo/1zHsNy+G+bFDv5TeE9OFTMkRZ+sz8SSrx9uXENqxD3Q8A9Qn99Ae/QamnP8R4hNlbZouNYrrP1UEMjKB9wpxW9kRRYSUd8Tf5oBgYsodP3rPSB8jgNNKXFRFdoBbKxFjE/syIJbI/z8imhMllYkqLCYzUCZLTCXyfnS2RUgAGUBskimedH/obcbuYEd1g2mYKbEIM8QjuQrVdClw0umpKJ4f7Xstm3mPtVCm5dw1LfFuQcUbwFAZHKgHdI4RM7DwpCD6QZaQZY4XsC9c9oDNm9RX7Gkk5jgmShL4u4Iph8xeQ8ZpPX9Bphwciqt2P0XCl5mC2APrK3vMwhhgZWixh+npyDlEuuRZDWGAvirDvJ9tU0is/Tp8r9t4PIzQThUNTgZkTUr6vjKvLijLr4kBy1t+dFyOBW/qZ0vO/oQUmaOVffZ0haXbjOneoMMMMK1C1CS+3WFi+/75hBGAlQcayNM72HVB2ZJcFqxh+xmmMFN/S+JCKh1V+IyaXqSvUfXsAcAITUNI/d+I6X526gRlANUklJ+tlTskdZu6RuxZNGWUtucZ2HA3pcaX1R86kkPN3yfkLjLNNSdRXYNVVBEPuojsnlk924muOWGbIPv53Gc6mtIkCcLxSqmM5XgMWcehwYG4vZTrenw0BDNikUvr02qzfuyCdIftxC1tfGCHpKtUMrX4IHdYohE5WQD97M8lvWXz1v4V/Cm+JvkMTCg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jHTa/N8me7dDOo3lx4RngT7stqKNB4W+8I9H5fM+rIsT92w/ukLXHJL2qqYQhe27HrrETJ5EnaA3so7hMRSGFYWkZHWXKp7+YOyE965Qr40Nu9C5jtHPz047rJRUFnEpwMBhTbDWbSZW5wFWU+REeae+P2u5IypOWwYBh069iRNjJj0/ItnYqWwJiTWNGeM+AhtOB2xyw53ggEfHDpvVz7a9Db85Ly/1ewgek+krIXHXUnNUV7LVAymEaEaAvXkuRE+4pUC/kUzwJzq7oAgxH/7XhFf48+QN78OAUOxdXjax5v7ZWilP9WJWvg/QpW/ZhUiN7U0FtnkI2kNfG+8niRqdPKb14y+eWJXZnZgVQAoEN8oJSV9Wyhkr8cnjBmfdlefwTiyPib5yKBlIJebpIPGRMTLzj0lQMiwlrvF8/N7npQYwbaZLp0/R4LjfREBU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:18:46.1076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d6efa5-a136-4990-43ec-08de8440dd8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052

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

