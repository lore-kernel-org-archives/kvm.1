Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B45537A498;
	Wed,  8 Apr 2026 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775688943; cv=fail; b=F9Bue6UggD9bCDyLt4YPI7V6qlh4hAlQmgcocTQyOOhLMraVlRecPgpDtIg6cQKzZbH+ce/Fo/eMsVDZrN6y1HjXc+ImLYAY2GVTZFr5DndH9lLJQj71BOnTJZqucOkDHqi4lXxApLX9H2SRuL69NGshze4XsLrU23bG8YGk1MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775688943; c=relaxed/simple;
	bh=qDB4OWQ4k+Bo9EPXY9roeUgeMAfr1E7WrptPv9rVDcE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUMaxZpCOJ0/acTYUpTKZasBjIHXE++62u48wnhIlBd68L+cH4qzfkTwI7IdtCyXXLu6bQwr69T/JqpRNB7KRLc5espZSECz1y9115+IZLxlF2JqyS58VsirAYy/+X/iVEMC2ONIaEAG/Hk8ghXa1+rDVne+XM9QXSp/qzCWqF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cAZQu9oO; arc=fail smtp.client-ip=52.101.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cAZQu9oO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0xxwlYmmtkFXiM76TI9knR+WhoQxczNzPBLc2VOfGvHtp+mU2g34323hC/0/wcxo2BdgPi4VfVPzAul1odxujQMPINs4SJIdP+Ca9GYcye8ix8UmJCgGyKnU3SKMINocAtfFfXgEFhdJlE6/e04iX3B4TWdOGjjt5cyk7fO1YFxYLP3+BcxUPKa/ZrbYpyaKK3JpIygYaZYkTL7e9eHyDNBC3CyCOGqpnuOaXZiFohZITEU/aywr/zQO8fG/IXXFcnzSeyjLodAW4IMpgfvPiTo9TlGsDXbFvF2QssM9rrv4xceLPAihTSIX0pxe0cAS3Gl1m9bwMFxOVG8cDS2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=notkgTfOf0bU5BA19EA8sTQe8rGtk3T2MxJoq5bxL8o=;
 b=T9oOaDM0MDXxnMJ0N3+GonO1tpICIOF175/EFEIseCRRa4ZJkKYbog+1WoocrA1Tc+D5Gy7ZBq1AWGZWOW/C6nJWSaXYqn4cJa/z9PpHWs49W4nD7x3I6X2wcllu5Knjcm0A/w/oTVcNkjDZyh0A9z3jHgDH3GC1UiicZ0ybH8+lzdNY/QPrQmv2TsbTPSeBK2jcGBqcSYtP46zEbGBvY1OOF11YIgADkBi2Ooex29C4N9CNyebB3+/aStCcaUFelvdStQuBxrwzSUSwfV+Buz7SB2lGMOy6h5e1sBzNaDutwUYkSHWr/SWEbSnKrFgEOQIUT6umw4d3h0fMiyW5YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=notkgTfOf0bU5BA19EA8sTQe8rGtk3T2MxJoq5bxL8o=;
 b=cAZQu9oOUGuj7duHaLsOIrCL14Z/QCJWUwSpEgXrBIM3wOK/o8MDVvLyOk924VGvbFSaEk3iKfUSupo7ghhfu/vTZwE+UxZPE8nMv05sMCavshdX4514ki7bou8rUS26kewctFHQXYK8Bz4jYLKwW/7ojUtM5sBidlCFNVxw43h4eygIlsb5KloqB7BTXEG62hyhY1hBK5+BmiWMJ4kg85HhSe0AK8PRSJvJSSmfKlrDgfb2Sw+pYJfwrLqWrG8BNuGWSvHgIGayAChtHgjDi83O9WdRYo95dAZqael9uObX6dT3u24SXDJJFE3ZJcef0Etimiw6ltbI6Y7C65YzVA==
Received: from SA1PR05CA0020.namprd05.prod.outlook.com (2603:10b6:806:2d2::22)
 by CY1PR12MB9652.namprd12.prod.outlook.com (2603:10b6:930:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 22:55:38 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::12) by SA1PR05CA0020.outlook.office365.com
 (2603:10b6:806:2d2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Wed,
 8 Apr 2026 22:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 8 Apr 2026 22:55:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Apr
 2026 15:55:25 -0700
Received: from meforce.lab.shazbot.org (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Apr 2026 15:55:23 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: <alex@shazbot.org>, <dmatlack@google.com>, <shuah@kernel.org>
CC: Rubin Du <rubind@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Alex
 Williamson" <alex.williamson@nvidia.com>
Subject: [PATCH v13 1/4] vfio: selftests: Add memcpy chunking to vfio_pci_driver_memcpy()
Date: Wed, 8 Apr 2026 16:54:54 -0600
Message-ID: <20260408225459.3088623-2-alex.williamson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|CY1PR12MB9652:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c951d58-ed9f-4a53-7ac7-08de95c1f393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xUxX0T4tnrIopPXUGtrHLSHaUyzjPmcB+d1Z9Y/lzDK9nM6lRSKBMBGa/iT3uNPEtpdbk9EW2Y8FfoffMigqf9vdSvOg6DoM8fLZP3DZrEoduwRLwW7Bib3GRwCQ5LJPBjkWpVSKsr5YZPWpm1smLNS5ilh+FiCWtiU33SMgwk51fApzZlxw1cBaNvlbt4lrTfDi1zVdhg+JNxceQMZD2EIceHQ3X3hi1oqi2ACJls5KaM6NAO7kpBCtXVlho/vXHFaehC9Rxu5T8CEuw+Wd+GuajESonI7uDw3DchpycP6F3aeA0I1Qm2H8NcYwjDwqTtn/LEmTH1g4ncJJ7Yd/HikxfodQhHBTJmNbv4Yvt/2ins2N6Da1wEoyF8IzMEZm+QTrqsTyg7wry0ddAoHPibZfyYXYlOx5bpXlK6IP6AAjLvyLPYBXb8w7M/uZzX2rpMcYVn+E8ZbH/LGu+vRd5G8pkHo8gXlwA/BxXsvOrynhCy5yn0hTCW46oArJGJRxFHQOl44BCmoJHA7ZPbjX8IYuLjR5vGe80wJfzHj2BcX6DQGsPOVFbn7X0sFKj0ucseU6dCm6dLzspf+o8e0CdxrUJY8gotfQIE8j0bAbjVY8hbKIKmGiN8m2ubW6ds1BQSal6/VjbpNNurzubLPlKL3JZ3oyKdLh/0hpJvLa31clzWz2pDD8ZGT+Ynk2nB/A2O2bB6tUhh+nTv57STaBMZAPiIJeI7ICNn32s6v7K2fZ1XdzNPtZzjMkGcx+iEJv77jRKuAu341p+NvKuLBa5Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6g4Y76Nbuwyqg8EWgdcqCagHymyqDaBnsbfkEnvJ9Rpr/v3dRPxpzChskpZwP46+foYgaLWEhD66oE3f+qVLE73N5uha8X8qodFNYCvTDbFTp48biV6K/trtnqp4tveuC4npaqkHWFNa+gRIVHpEif6JXAGTr2ZdcFxSlbx0+n2uAoCsm8yAB1svsvk8/m4rZN6YZs1VT9dphNDpsNhq/pPaHood8lMu8Pkb+WTZ3/sw9G1jWTero8uhX7a/C9pA1H31e2krAFG13ccsyFAM3jNrDjqwy9JPNq+I5hbhNb4jLp+MNTQxlw0QT7DJhVl0Hq3kgI6AZwXHBeg8eYnobXI7jDmcvLodAv79CELc33c0Ety8f2LAm4g6W/UR+ddVC3KkaImgGxg2i6yGB0Bn2mQ0pgaET0LuuDg9NidlFAXA3gjVGnBqeIAkBucBiSN5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 22:55:37.9585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c951d58-ed9f-4a53-7ac7-08de95c1f393
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9652

From: Rubin Du <rubind@nvidia.com>

Add a chunking loop to vfio_pci_driver_memcpy() so that it breaks up
large memcpy requests into max_memcpy_size-sized chunks. This allows
callers to request any size without worrying about per-driver limits.
The memcpy_start()/memcpy_wait() semantics are unchanged.

Update the test to use 4x max_memcpy_size so it exercises the new
chunking path (4 iterations) while keeping execution fast for drivers
with small DMA transfer sizes.

Signed-off-by: Rubin Du <rubind@nvidia.com>
Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 .../selftests/vfio/lib/vfio_pci_driver.c       | 18 ++++++++++++++++--
 .../selftests/vfio/vfio_pci_driver_test.c      | 18 ++++++++++--------
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
index 6827f4a6febe..e6c5b9c703f4 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
@@ -106,7 +106,21 @@ int vfio_pci_driver_memcpy_wait(struct vfio_pci_device *device)
 int vfio_pci_driver_memcpy(struct vfio_pci_device *device,
 			   iova_t src, iova_t dst, u64 size)
 {
-	vfio_pci_driver_memcpy_start(device, src, dst, size, 1);
+	struct vfio_pci_driver *driver = &device->driver;
+	u64 offset = 0;
+
+	while (offset < size) {
+		u64 chunk = min(size - offset, driver->max_memcpy_size);
+		int ret;
+
+		vfio_pci_driver_memcpy_start(device, src + offset,
+					     dst + offset, chunk, 1);
+		ret = vfio_pci_driver_memcpy_wait(device);
+		if (ret)
+			return ret;
+
+		offset += chunk;
+	}
 
-	return vfio_pci_driver_memcpy_wait(device);
+	return 0;
 }
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index afa0480ddd9b..44aa90ee113a 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -89,12 +89,12 @@ FIXTURE_SETUP(vfio_pci_driver_test)
 	self->msi_fd = self->device->msi_eventfds[driver->msi];
 
 	/*
-	 * Use the maximum size supported by the device for memcpy operations,
-	 * slimmed down to fit into the memcpy region (divided by 2 so src and
-	 * dst regions do not overlap).
+	 * Use 4x the driver's max_memcpy_size to exercise the chunking
+	 * logic in vfio_pci_driver_memcpy(). Cap to half the memcpy
+	 * region so src and dst do not overlap.
 	 */
-	self->size = self->device->driver.max_memcpy_size;
-	self->size = min(self->size, self->memcpy_region.size / 2);
+	self->size = min_t(u64, driver->max_memcpy_size * 4,
+			   self->memcpy_region.size / 2);
 
 	self->src = self->memcpy_region.vaddr;
 	self->dst = self->src + self->size;
@@ -211,6 +211,7 @@ TEST_F_TIMEOUT(vfio_pci_driver_test, memcpy_storm, 60)
 {
 	struct vfio_pci_driver *driver = &self->device->driver;
 	u64 total_size;
+	u64 size;
 	u64 count;
 
 	fcntl_set_nonblock(self->msi_fd);
@@ -221,13 +222,14 @@ TEST_F_TIMEOUT(vfio_pci_driver_test, memcpy_storm, 60)
 	 * will take too long.
 	 */
 	total_size = 250UL * SZ_1G;
-	count = min(total_size / self->size, driver->max_memcpy_count);
+	size = min(driver->max_memcpy_size, self->memcpy_region.size / 2);
+	count = min(total_size / size, driver->max_memcpy_count);
 
-	printf("Kicking off %lu memcpys of size 0x%lx\n", count, self->size);
+	printf("Kicking off %lu memcpys of size 0x%lx\n", count, size);
 	vfio_pci_driver_memcpy_start(self->device,
 				     self->src_iova,
 				     self->dst_iova,
-				     self->size, count);
+				     size, count);
 
 	ASSERT_EQ(0, vfio_pci_driver_memcpy_wait(self->device));
 	ASSERT_NO_MSI(self->msi_fd);
-- 
2.51.0

