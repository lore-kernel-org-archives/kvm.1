Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81483F076C;
	Tue,  9 Jun 2026 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781047755; cv=fail; b=kEJ5PNNErbx6Xv5T3TPARMnFOIw38q71dvwtapdkafIl6OjD5wpCgtlNtHdRt8/SIr5rGNEkOokEFy/hcnbfU4odRYQy22PqV8uRzxRQnoSziTR6QAfxgxrP0jXJEoNd38lLedjcYpkjssIPwsq0fX2/lSVrp0+In87nYYUM7nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781047755; c=relaxed/simple;
	bh=3A/3aUybTAdJhctZWzLeCYt+OwyZasnSOUdIDn+4bCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YAqXuU3mLrravqsD+WIHPAxEsultGOZhEdsKFowbMF8F05GzXhsGKKCWhajTj8JovsKt8EKupVP7dqsNFcczKPQe2zFcdPRAck8rJdnzwtvmwyCevCFbkgSVbzUn/VPWyHelV64jdH20FWPWZkqiaMXIHNPtM6ymg9ljgA+8YEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GO2h80fe; arc=fail smtp.client-ip=52.101.56.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GO2h80fe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWYXcVyT3E/d6l8jceuArr3mFQ283XjfGjLB1wELMKb1rNj4+92FG9EXybAbCBM+yCjXT0cxuStqcgVMh2w5Ztio1f50Wr2dJdDKdnbTlfAcuSa9tIekxdjzow49gtQ3pI/ICF4Xi6uTEz6cO6prhOgcpQYTSntAo1SLha6bZ4nbubgu/CVwN+pX3d1X2Ih+IwX3wDm67iupsY6dXYYyzDhWnyrA4ZLmPhOnWaz6B7HT+kNOpTsLqPKx5bi+8oA5S0W4QWzMr87X830rGUKGi/HS7tHzD3zUWwwZq6p5LHq2OyW2Fze0EvybKKdWWLKeC2gvAl1uSmL6q2Ofj1uvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sojLqx0q/9bhGUIVv3/WT5vSvanHE7A7pyezVtue/c=;
 b=XbQ/zTFY64jyvXcfCEUfy8jnp99sjfekx4TDr+mpzGuxf91TMrJ3PT2wwHa5lc1arcQU7K3QgbBOOcRxlm93bDQJZnF2K6YAfOrbVu0lgQ0iVM+nNmO7g9YTSrPj9PvVBmzeEW9SQ50vuPcEk0Eaac51Jez3YFnglsMO1XyY9XcZ6Q8HJqinVt8hLk9cBE1CVoVavRVCQ0qrtVu8xKsMVEcJOk/ZHkJeL7Nsol5m1A0hihvs/VeJGlYGv57NICbx6E6SMFEwBKgtCe1gkryOeshMOopL0SJtbRnLN2BLubUmhwjMFHhrqMNdRmpiq9x2qOAvqs3OUJ9wiJbvxO2A1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sojLqx0q/9bhGUIVv3/WT5vSvanHE7A7pyezVtue/c=;
 b=GO2h80feqE1aPYOpvIVYtVxZg1sDxHbCWz0sugQ0I/TUqYNnqBscQ/t1x2xMLxmCGGeuCZs6Ff2xrXo1UOauEtVHNt2aCLWvWGDFh05uGF61alf3fair2tofFc7mxfcH3uG9al6zghrp44phx2/OVTdPeW8RFLc5K6xHVILYg6WftkwuLIdF89Q8KTHDIN9ky3yNvywoBNdQxE46QmSb9XCWF59bD6vcNFbFzNEZpIx/3pxPyWG9QmIta43lmBe/iqu2hU2Qxy8DHLa9glVp7Pb/on4zfzf9PR/uf5jVQlRfOIjqRJ3aXpn1wgwTe6b7Ey6CAM/yZpdLQc4qJuiZow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PPF73BED5E32.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd2) by MN0PR12MB5714.namprd12.prod.outlook.com
 (2603:10b6:208:371::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 23:29:01 +0000
Received: from IA0PPF73BED5E32.namprd12.prod.outlook.com
 ([fe80::8780:2964:7709:6b58]) by IA0PPF73BED5E32.namprd12.prod.outlook.com
 ([fe80::8780:2964:7709:6b58%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 23:29:01 +0000
From: Rubin Du <rubind@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v14 3/4] vfio: selftests: Allow drivers without send_msi() support
Date: Tue,  9 Jun 2026 16:28:54 -0700
Message-ID: <20260609232855.3808971-4-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609232855.3808971-1-rubind@nvidia.com>
References: <20260609232855.3808971-1-rubind@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::17) To IA0PPF73BED5E32.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF73BED5E32:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2a04ff-e766-42d1-be67-08dec67ee32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Lll3d/8bjoa/9TIeda5mYwyY0T/rvyL8Is+LtROYinthBvOTE3gx9K5ryIsrHFTFQOqzgxxt5pneqz8ri4PqYYx7sqOXT9Rq4Sbe97bLyv0j1OryL7qib/7tiJth4PSKGqELoBtgzLBu8hlS2uImu16qI6Z+gUyyd5jv2xFAABs3BrZLPesNXRME3CsT6SXDKOrRhWcagelJ/Krq0RE5H0frSVXo4iGnzfWyrIvQ9Ywzw/TGTGILnFmgJQDGysRDnuuFfw/M223v4yjxbFw2ZSxpYbySamg79e5dj5RyfS7NsfNS3/OcQ3i3acAAm3+tWPEoscPFmsjoG/GFVfVKaQC+tIXav4o5NSe06XsZuU1Qkh2WlL8gPsUf/NDpmY47DsWm7yjHKzAtYpjexSdp+v+UZNWGdr7y0j88qzqcN01tl+bi+8nAc7jxhpAJ1Iraxg8zj5aN2h+yVO5tWXnnvnCh+XDMn1jhfL2uRw8AYO8JB680unOAcxxfK2jMpe3nKqzfjQGeT9G+2hSw7f18bJJdd9oXCxGM5xBsnqnDKuKuXKnNwEA5awI7fpS1paENkzEgzrNkTsPw+tLbVZOtJVWw8ZHsuTZdkZHj8oLb+KIqBRsxrnuW2k1EefRcIKgOUThfLimnWdsmjSSWd2SarwhQj7yrehX0oR4++NoZpnvTB+gCb89A7jtVJidD2UUW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF73BED5E32.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WPfKv6FMtCaJuTtPFamd/K4/Tl7Zn2KKM6puWTnN3bgOIeh2p9Wh8hJn0Hz2?=
 =?us-ascii?Q?aoQGbUeqhhUiCn1F+BrPVEMizbyGhEL+bzmmIWnDpZ8J9PFc7S2nXz/mV3wS?=
 =?us-ascii?Q?AsLPQcYc9Zhp10X/VSEmRcBBJCUslLE/umyqp/hYHBp6/WJHbJpGp9H/OrRw?=
 =?us-ascii?Q?jMcs5ScjoXxccluA8k0k9vNL+HZ06ZkTSpHMhjHbJ4Wmg2xIsuQEMTFtNv/N?=
 =?us-ascii?Q?JsbUupdKLJKaesSmNFsRdAqUWBEG2aKCz8jJaW5oQ2Zer/iwyUBZKwkKqjSa?=
 =?us-ascii?Q?/2GY/guaM8r0ttTcOXmdoJxz+9yLioPVpPJ3GJf3YrOf44eFeHuyzKe1lKHa?=
 =?us-ascii?Q?usVapU9WUTB6zOuWEt9BLvZ2BZLS5K18LYbFkqwugEt5LQg5m8Bmw+ON9Wes?=
 =?us-ascii?Q?ZtkYofIniWFrga0Bi7aPn5/4J//KhcRz7nD8eEL5d0JdhFGL/irYHj+eXDAd?=
 =?us-ascii?Q?MtIg1jz+ChxHfzfkH1j2jlhbIo8cVPM0nhgKxE7OW4pYEB9lEke6xMe+mOVc?=
 =?us-ascii?Q?KQmwQEbC71djQ/VGBPXLT7xgKYu8S/N5QRKijjX3FvSH/55VlBLEXsr1EZqq?=
 =?us-ascii?Q?4gVY0KNnFwaVzXKNF4p0OWs8UzpS/gKD5NZTUlygLz8Y8F1Lo1VuGJW2IA44?=
 =?us-ascii?Q?Cio8nF/0BTNOQc18weltWfZERO9vN8xJoEq4UaZAfDrw0P9A1sRRdQhgt4Hg?=
 =?us-ascii?Q?47DxiHcGNbsxmXTo2eoj471xSKwsEk9/PlrRohe6nzmybBs0C2dL2HOzOxgg?=
 =?us-ascii?Q?9dmu8dZoIh07rFZJCDlje5nwz27Ycvwqdj8Byj48WmGcRU4ZdkFO1O6fb3be?=
 =?us-ascii?Q?333KG6zOqFg8cbGEPRGtBoJ/RL7n5UY+GReZOgBSeN7wNVTHG6UK7PDS9NIy?=
 =?us-ascii?Q?AGARFiOIQs9u6KwI5VvtTTkm0C2zWikypQDCAUO/w9X3IzC5xDEZaOFcCxN+?=
 =?us-ascii?Q?V9sI02Ba1SpyIDLYWUDeX1P576RJAajPsKT6OGaPZrLuq3/nJSgVnk4MnuDW?=
 =?us-ascii?Q?zN7bSHVizvxNZjnOEHsgA7elZHs7gZbFjx38YGLt/YBen8x3FLTMgzcLp9uM?=
 =?us-ascii?Q?03SR79yILWykqzuaiDHXy6eudkSewuBgeuy5HJ1NleA3P+r8/ICWAabx6bA/?=
 =?us-ascii?Q?0gbinD9Mcz7cdRMkH44mWAyXF+nMkhQg6Bg3rxjCHgpwk89QLP6YJUBV0Aef?=
 =?us-ascii?Q?TSs5QT/KULl1NqA8bUi62V6/jjHIP9oxLhcwoFmkynkrS188h9z4QkJnzxGB?=
 =?us-ascii?Q?RuZoy4Rb4neq6Hg/uNlLVx/YUMXWXkkyZcHMt/oEU8YY7nCvYe0vz66+UZ4Z?=
 =?us-ascii?Q?Ja9uCxlF4yh5EKEU9TtXXBbuAOsWSS7SA+ZNHcUgbgZ0istihiUvidM6O8F0?=
 =?us-ascii?Q?T3uQe/hJdwVyhBVt6ofi7oKEf5ZAQUWWf4VWuj0TdrHXJ79P/v/EMM5Indkg?=
 =?us-ascii?Q?MbOmWcfqRl0q8F5Gx0Qs/9oCu7Bqb8OQGydTp2K7G7GUX3uKJp4roVoEY5U6?=
 =?us-ascii?Q?4yD67VGeFzoJlj53kpzP9cidWksuSCdHedCAkf9J11t31vGBZyauatU0yvue?=
 =?us-ascii?Q?Oeo20RmwUUIlnYfKKBE0819blKWFpryKd8hMR2CMF0OlMITEZtkp06rWwUH5?=
 =?us-ascii?Q?J6NbQSO8fskRAG7xv+m10TgytTbkkMbf954mu9DUqPZPC777nGFQJTRK0JzB?=
 =?us-ascii?Q?Fx2vMhMRq8hqEobPTUQ1oPQ5t14J0oJUPDn0fdo1zqYZP0TU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2a04ff-e766-42d1-be67-08dec67ee32a
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF73BED5E32.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 23:29:01.4253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2TUoFh/yIHS65IX4oFQxL5bCmyij9QNXyY/EMcy6+6byGG+WjzWe6dq2gor+4ZKPaIk98l5dHzBjnFegGeo2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

Allow drivers that cannot trigger MSI interrupts to leave the send_msi
callback NULL. Add an fcntl_set_msi_nonblock() wrapper that only sets
nonblocking mode when send_msi is available, and update ASSERT_NO_MSI()
to skip when the driver lacks MSI support. The send_msi test SKIPs and
mix_and_match skips the MSI portion per iteration.

Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Signed-off-by: Rubin Du <rubind@nvidia.com>
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
2.43.0

