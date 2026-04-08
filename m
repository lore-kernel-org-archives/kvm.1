Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011035.outbound.protection.outlook.com [40.93.194.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551913A1694;
	Wed,  8 Apr 2026 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775688952; cv=fail; b=OsF5QeKud6QixF3C9bzBgZEI0pYpDkwBMY387/pj3WWZr9+e1dL6qVAP7oNguJNgqUsxvv+JUtN4Uh/dzahW5ljmm9QPgrIpKhVSDdE7w2oQQ9+yEE4iTu4AKOX1G62CTYiqNBqWnHMJt21ueXqRSrFXgo49THM0cdn5cnbihFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775688952; c=relaxed/simple;
	bh=fRGLbE+5+2CdZHsFiG1BNu1dyUXs1179M3hscShJohI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eA6vZFQNsaHX5aXiRTxQ0VieeoRmMusj23A3BapPiaGjYbAgans9qzdzLisIPO4enPCNhKZ8hVRNpsKs0iQ0z0r4XOVkxx6MJcx57SRNDD0O+DYqR/P3mbAasxv4wPq7zgUYkQG6bd0Lb25DxICo6UBjEXd0OC5ecSukItq1vhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DTXW1Lt1; arc=fail smtp.client-ip=40.93.194.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DTXW1Lt1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvtpDRLnkSdGHhzveyapnjay5pD/BztyYW3+zCEEjJCjc3RaM4TccQeWzpCsCphurQy72vz5Urx7w+PWVvbLerL/9/hCb5REMiWFT7StKWhtPqfkixKfvYJ0HWeBKX5Dpgsv6ZPKRlzIH9RdaAH2taqrop6CmiVx+cH8oo9oi24pRMhkdj6wTDKU7xn2i0eZgMrcBKfON6KOl9hA5jVRU6R23hDbAD6g52f+MP3MXbZejQBBvDRZ4Myog6C5atIZYW3j3L9N+S8XXt/ht8CMEH5CdDfEpWc7k33yjyr4NN440+QIW3K7AqNkkBEhsKWJyjglwxByBgAkiSeRDka30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=731PwsMtZW5rVfZ0CgNGHmqFyLwRns8whsrMLct56l0=;
 b=OlxY3ALGJtgFwqiPNyEwdEVCx94MR1wKdFi1Ul+S2WfB4+AJBqmSIqRfnE+B6XzlcRBfYH3CZV5faIXvsUwsgWjaIaHlBuSgZzHSW7Fa/6rvMkKdJlEIwel7+ZvDn+W1mQDOJBTfBKU5nPTEMXN0AQPWD9938ro0Mpe1/jSDz4pHWbNMZgexQifviELaQRCgZdD/Xr1j68gLyC1WgC+B9/DcURqq29QKOSbJGCmIa2fX/NDhuwdnpQwLfqXzUMnjh6hgf4SODxnGlnqwbZXYkDX24iaxdwuxCGwygbPqWRdUdUd6C8LL5AR3TdYiIwjXOwd8wZfVH4k8UXimEZanMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=731PwsMtZW5rVfZ0CgNGHmqFyLwRns8whsrMLct56l0=;
 b=DTXW1Lt1PHVxOaYRre0a+gB9EsMj5R5ZiPEOklLnwr/ntPHb8AWO7wm23HPbOIx5Tw9upwitdPBnm7Y/+2HwF53xyuo0Y5ZeClE8yliwD64QkVYJawcoKg0rTVDK0lESSCEMGqztSUP5B1cXezBv1TvvgdqGkS1BXTKYnKHmCrmPxmmctxwMn84A9VmB8TlCqYoTQPQSUNCorXpB4DliYJEuriduAHDFaVIapJcXIf+RRuVA+7JK0OEcPijHTWju60Vx12gix4yxlP0YMuo6GRDf+UujS52IJg3UTHDYmeXbD9LplFD4NUaV2t7bq4sLQOU8BH4cuJJCD+hBhGdDTQ==
Received: from PH8P220CA0058.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::32)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 22:55:46 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:510:2d9:cafe::40) by PH8P220CA0058.outlook.office365.com
 (2603:10b6:510:2d9::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 22:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 22:55:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Apr
 2026 15:55:28 -0700
Received: from meforce.lab.shazbot.org (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Apr 2026 15:55:26 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: <alex@shazbot.org>, <dmatlack@google.com>, <shuah@kernel.org>
CC: Rubin Du <rubind@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Alex
 Williamson" <alex.williamson@nvidia.com>
Subject: [PATCH v13 3/4] vfio: selftests: Allow drivers without send_msi() support
Date: Wed, 8 Apr 2026 16:54:56 -0600
Message-ID: <20260408225459.3088623-4-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260408225459.3088623-1-alex.williamson@nvidia.com>
References: <20260408225459.3088623-1-alex.williamson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 34480e0f-5db0-45b5-8d02-08de95c1f83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hKDIb4nquLj6o3xNIfbGA3Vws9G0I/f8W6v+V70ZGoqA8FsnZx9++xsBdq6QSiKjzhLoFXK6pn2yBJFYPJ6PeqKeXsKPWEuar0BeQNFOZkVwHZVcdFobSaLVad7hwShwIwiXbuh5MV5RtGhV31iGBBkbG5MxgYRMS5NksvkBiYBJCfV06NxV8L1BGV3E1/NM3+HYGAp6p9hjFPFsoO2pDeKVETqyk4Cd+ePrQDxbhYCZ47P3G53DEHL9AsT9+XNZ2vn8tTxdeyIEHaKDHWyVYctdtXg84Ip2cGA5P8rL1Gno3Kj2VbD2yQ3MxG4NY/1uRm95vj6rl7eZt0yGt4q5G/fQEmYXceWzmr+SzcT4XEzXvq2sl0YkhyzAdXwciVQbkBf5y1vxT0HFd8Y8OCzFgl0tgDgBMC14rqlhMoPRYZsAdWXhp+f2tK7he8NtK0gGybI46oTC5WGQxV/yBnBvehyaumOUr2Q54KxaLf6/66VVVl9Crup5KdUmG7uKzXNEsxkeuS2SOHr+GSA1PXPpIUsfWW5FF4rRZXL+OUlc+Eup2l8+BP6LvFCl8RCxpvFrNUQWpy49tmDWdAmJCk+99DeNH7iGtwcbWCd3fCJygjoLUbPqg+TrWt6vlmLzjIc3ViLOtblem7SFLYN+pZo3kDuX8naHKowftC1ttffeh6hrF6M7G4loYU1DKiSnyF/MY+dTTOYm2Rh6LFgl0af+MZVbPYozprS3sxOEdeJ7aoidtVwjcych7483hncMuLFrTQaqdBrJgPPCeKmY7fvyxg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jz7BfRZOyRRwVnQ70q5d3Yg1y5omxF1C2VMAxzEeMKONgegEhfwctsIQFeG2TQoDQBCoB6J+BW3+rIILf1Yg9rmp84xB9bJpkaf9KoDvFd51gV1BR+mpTGv+KUY0SznOB39lwOy0pe/cD50Fkp+/9+tuteq4HhnV+65IaSLwd4yIQMjgcdQj46br76RjzcwxNALdtHFnVGMhzFlG4yqVv6Uopun/dybGQk1a9QZq4uyuUjVh8RUKN9E90sYy7rNiqQCQSkAKGw37gk+f4PiXC5JpZcS7eAq7xTYOkctsmvFJcjmy1UViPKyxZzG93h6CjlFj/QxPHJ3O0mZeGR233y+DsuWxw0IpK52sX1KEeyZFZJ3jsd1JFJ+L+llJdb2fyCnljc9xaO+pTeSzRF5DEhOnPNrCjgLCcQ07UwfKP/CRRhovpAJeEwU9g/oslpsn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 22:55:45.8027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34480e0f-5db0-45b5-8d02-08de95c1f83b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383

From: Rubin Du <rubind@nvidia.com>

Allow drivers that cannot trigger MSI interrupts to leave the send_msi
callback NULL. Add an fcntl_set_msi_nonblock() wrapper that only sets
nonblocking mode when send_msi is available, and update ASSERT_NO_MSI()
to skip when the driver lacks MSI support. The send_msi test SKIPs and
mix_and_match skips the MSI portion per iteration.

Signed-off-by: Rubin Du <rubind@nvidia.com>
Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 .../selftests/vfio/vfio_pci_driver_test.c     | 39 ++++++++++++-------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index 44aa90ee113a..761bf117d624 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -11,11 +11,18 @@
 
 static const char *device_bdf;
 
-#define ASSERT_NO_MSI(_eventfd) do {			\
-	u64 __value;					\
-							\
-	ASSERT_EQ(-1, read(_eventfd, &__value, 8));	\
-	ASSERT_EQ(EAGAIN, errno);			\
+#define fcntl_set_msi_nonblock(_self) do {				\
+	if (_self->device->driver.ops->send_msi)			\
+		fcntl_set_nonblock(_self->msi_fd);			\
+} while (0)
+
+#define ASSERT_NO_MSI(_self) do {					\
+	u64 __value;							\
+									\
+	if (!_self->device->driver.ops->send_msi)			\
+		break;							\
+	ASSERT_EQ(-1, read(_self->msi_fd, &__value, 8));		\
+	ASSERT_EQ(EAGAIN, errno);					\
 } while (0)
 
 static void region_setup(struct iommu *iommu,
@@ -129,7 +136,7 @@ TEST_F(vfio_pci_driver_test, init_remove)
 
 TEST_F(vfio_pci_driver_test, memcpy_success)
 {
-	fcntl_set_nonblock(self->msi_fd);
+	fcntl_set_msi_nonblock(self);
 
 	memset(self->src, 'x', self->size);
 	memset(self->dst, 'y', self->size);
@@ -140,12 +147,12 @@ TEST_F(vfio_pci_driver_test, memcpy_success)
 					    self->size));
 
 	ASSERT_EQ(0, memcmp(self->src, self->dst, self->size));
-	ASSERT_NO_MSI(self->msi_fd);
+	ASSERT_NO_MSI(self);
 }
 
 TEST_F(vfio_pci_driver_test, memcpy_from_unmapped_iova)
 {
-	fcntl_set_nonblock(self->msi_fd);
+	fcntl_set_msi_nonblock(self);
 
 	/*
 	 * Ignore the return value since not all devices will detect and report
@@ -154,12 +161,12 @@ TEST_F(vfio_pci_driver_test, memcpy_from_unmapped_iova)
 	vfio_pci_driver_memcpy(self->device, self->unmapped_iova,
 			       self->dst_iova, self->size);
 
-	ASSERT_NO_MSI(self->msi_fd);
+	ASSERT_NO_MSI(self);
 }
 
 TEST_F(vfio_pci_driver_test, memcpy_to_unmapped_iova)
 {
-	fcntl_set_nonblock(self->msi_fd);
+	fcntl_set_msi_nonblock(self);
 
 	/*
 	 * Ignore the return value since not all devices will detect and report
@@ -168,13 +175,16 @@ TEST_F(vfio_pci_driver_test, memcpy_to_unmapped_iova)
 	vfio_pci_driver_memcpy(self->device, self->src_iova,
 			       self->unmapped_iova, self->size);
 
-	ASSERT_NO_MSI(self->msi_fd);
+	ASSERT_NO_MSI(self);
 }
 
 TEST_F(vfio_pci_driver_test, send_msi)
 {
 	u64 value;
 
+	if (!self->device->driver.ops->send_msi)
+		SKIP(return, "Driver does not support send_msi()\n");
+
 	vfio_pci_driver_send_msi(self->device);
 	ASSERT_EQ(8, read(self->msi_fd, &value, 8));
 	ASSERT_EQ(1, value);
@@ -201,6 +211,9 @@ TEST_F(vfio_pci_driver_test, mix_and_match)
 				       self->dst_iova,
 				       self->size);
 
+		if (!self->device->driver.ops->send_msi)
+			continue;
+
 		vfio_pci_driver_send_msi(self->device);
 		ASSERT_EQ(8, read(self->msi_fd, &value, 8));
 		ASSERT_EQ(1, value);
@@ -214,7 +227,7 @@ TEST_F_TIMEOUT(vfio_pci_driver_test, memcpy_storm, 60)
 	u64 size;
 	u64 count;
 
-	fcntl_set_nonblock(self->msi_fd);
+	fcntl_set_msi_nonblock(self);
 
 	/*
 	 * Perform up to 250GiB worth of DMA reads and writes across several
@@ -232,7 +245,7 @@ TEST_F_TIMEOUT(vfio_pci_driver_test, memcpy_storm, 60)
 				     size, count);
 
 	ASSERT_EQ(0, vfio_pci_driver_memcpy_wait(self->device));
-	ASSERT_NO_MSI(self->msi_fd);
+	ASSERT_NO_MSI(self);
 }
 
 static bool device_has_selftests_driver(const char *bdf)
-- 
2.51.0

