Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750C73EDAC1;
	Tue,  9 Jun 2026 23:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781047743; cv=fail; b=hZRL9lbha5LSLsDirNS0TiSwIBcUtfiXcaDSrf+K/b2uwzP5gGYEy4HdnARKuLn1CBZppYk7WFKdKDJNkf7NcaSpfs3s90S66JiBiCZ76vRgToheQ3WZWNc8w1wJ0Tou7+92hfRum93q4zx9Jpq6wuMn5bWFEUISbOB46pF3Lb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781047743; c=relaxed/simple;
	bh=mzxofvmOy8/fVp+5tMbjTIIR+LyVeNZJucCejvX4Mhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vn0nKMqevKMYjqd9iF2Qx+G0/ndGHFecUAPOlneT6cuBOvo3PWWDPeVcAB/gk+tuPiGpl1f1M80b/WhEk0TmLuaJrcCh+laH3kcHKRtKcp9XJaskqOYKlR5Ii7o4MP5nByIav6L62MJ83RFu9soDtHhRc9wa7g0959P3l3K07uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d43KMMiS; arc=fail smtp.client-ip=40.107.209.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d43KMMiS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StXkiUP6HxgFloHJOFlK8QIS5Nvm/C31L+rdfVxpZ23M/UcOJ55EAFY0rr8VGeAbKvZxfouNZ5lfoZESKUkCuDo1BCvAFgKYnv/Vyfx00rjcA6h8X3oY5pYFeq5jGtXKqtDuNt3qn4Y87jqgtv/NQlhwVU+CX7sIbClojgHVOL1WZoyKd3btR4HfA8KPJ4FfQztTDHhmsx0ExFZxDU4y1QgCFA9nmv1qTFSaBoG7oePQVyDlPJYBHbEQLSslCsbz0ZF/MQG8sPyZhKD3sde+d6vX+86x80nSmzIfQJHF2j0nFgAQ5X/kIjb2qSKQfQXNutya/ZfNCsfbKKdmAUuzKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcRH2tfA39mXO2tOZAKcg296KDoJTaPcAX0yV2Jjw7s=;
 b=YKD952JLo5hSUoZ6Z8TAw60U1XvQ2+3c7Rkow4v+eE4lxBbPco7htp9lfH58NLgQClPVB+3GDC8DKWprSzSzvkkwbjte4p99D6a0X+oBX+kNkgITdDvxeJAAS7Nildv0nc3NWguBQjbPGBxzgVwIr2/hOGrvMsJ3rxxiuWJwyGTuA5X3DAMLKORn53z8wYZx13MafhHuKk5p5wE8XXrZlcsACccZlsa5TZD9u67oe1mIvxgPPPEHU8uoLSp9f6hYCdZk/gVrEM9GkZGH34ui2wPoXAzr1qlWBOAlzfEC40ysqPD87XYaOHmuESpbWMHvO3dXFoR39Yvl7u3UYUwW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcRH2tfA39mXO2tOZAKcg296KDoJTaPcAX0yV2Jjw7s=;
 b=d43KMMiSmYFlL3CrWEYACOUb2jSo/4rcVXGTqI20LqThU8dx/l4oWzBEACtc7w7l/F5T7W/Q0EN5ssUHm2xD/w+yqgypWJU9vxWUc3pdbhBnDLxLXEQUiV1vG7QG5N8RPZl5merxSjUyYWiEt/6QHFW68tDoZlhZRtm7pxn9CkXRExPGlLJg4hdhD5vIJZqsa7JaP6nM6WrioZ0zLVUhbm3PN9BpJ31oCLcWFgcVRGqZKXmXiZN0793GkLVsbYmBZerlbCrwDPeCfrHhrsgN/Nc2cr4wwC1KF99UNsC9nscMsNcGbjRglQ9cJajrabQsIm0ZTqtN+WLiRk1ujh5qAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PPF73BED5E32.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd2) by MN0PR12MB5714.namprd12.prod.outlook.com
 (2603:10b6:208:371::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 23:28:58 +0000
Received: from IA0PPF73BED5E32.namprd12.prod.outlook.com
 ([fe80::8780:2964:7709:6b58]) by IA0PPF73BED5E32.namprd12.prod.outlook.com
 ([fe80::8780:2964:7709:6b58%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 23:28:58 +0000
From: Rubin Du <rubind@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v14 1/4] vfio: selftests: Add memcpy chunking to vfio_pci_driver_memcpy()
Date: Tue,  9 Jun 2026 16:28:52 -0700
Message-ID: <20260609232855.3808971-2-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609232855.3808971-1-rubind@nvidia.com>
References: <20260609232855.3808971-1-rubind@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::25) To IA0PPF73BED5E32.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF73BED5E32:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 988cc3a5-ab3b-4448-58f2-08dec67ee12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	aAIvoEgBcAR6ieeqozqPY6Mw4hbd0CBgzXsEEL/mUU45usQtYoQNJGNg8cgsawnrG62K0G6MH7+pE1tF+G5eUvxZkzpbkXxY7emEuiARBso+p2wulj0KgHChy5zWu7dtCu5jBU1l/Ihe8AEVsC59pqrWOlgABjXyqj5eCIqN4sq36H34wYyYFMUOGmcUbaekZs+8SpOyRfaPamOQtu3BNNN0xn706cqzljtzx6K7TbbNnrn/1iqVO0GkQRgpq6qPhYs0Oq/CDjXcagGvY93vHgKTAg4rB+TNr6ISjGKshXJ3yKTnrj2u5zdudMiKgvVnyIn0upI3Zf1ipFddQRuEvTkN/gZ2PATYwkKQF4X0nzJsUQZTO/7x4athheAo782DcDYq/+G1pfI6IEXMndNYIeZP/Pcqvujj0J5+BYNrSrs9dnSduod3e/+oBFGyX5RyFbMqvcYXFIdI+hyaVtISxYA3W+qD8/QM6CRj1UWg8FF3hmjisgjUSnp40u3BQIPmVskni+T6GysNMp/HaimZVWWw1QcCI74HTfG2TwzCym2Vi2bGSk+N8HU0FLT1zA3afNkRzvbyKtJ+QlqXxfkhd14prdVh4wUlDaXc3ki9hpcJdOi9k9Cv0gF8A+VWw4TWRcLUkbfBw8UuBTa6AZKftD2YXJKBc0Z/0fdE1bHvm4oZF65vHctpfswYxIhDRP92
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF73BED5E32.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GO+BS56TXxCSnlk5YvQq54Q22JPqd3q1IiAnponq2j9dby15Hhw0asuDeuQW?=
 =?us-ascii?Q?Nt6Ir/E2KNzGvfIAOAEYXJgy9XMCZNOdUy3Frlb1pLNuciv8Uc1kTyLXg4t9?=
 =?us-ascii?Q?N2sgsJgiFYdd9zkmka8UFolyod7UdX3+3OAJCxwU83muu2I9hy2o1i4WMvqe?=
 =?us-ascii?Q?8R+NF4F0dF1KmZtUtkrzsY2OASr+NSwDNEYQTuNJAu9uhvoy4OWrPEPCWzCs?=
 =?us-ascii?Q?EIO28kUjKPm5v5r32+Oi1zULwBOWPuVtLzC2fxv9WGuGgmmlwe8JjcRmMyV4?=
 =?us-ascii?Q?4fRbikjGwMhwyJ0SlUCbLI3pHcSqGyrXoa3f14xM0qqhIXzkXVtAqcFouRr8?=
 =?us-ascii?Q?WZQfsGhvGevNZk1/nPs4cIYt6rjyQwoaaLLdksIjQVtaozeOkJYnokmR2dpG?=
 =?us-ascii?Q?QVqhwTfTWUee2oBH4aYCcbWW/2DnflLMl1M8p+07PjRBVmGRGh3iVO3bWPuw?=
 =?us-ascii?Q?aRkaJXhWgI2w7cq7ozwqaE7HsYDNSoyCS4Vlm9q7PSI/++Yyo7OQcvtTvPxy?=
 =?us-ascii?Q?kTDZqpQQgYof2KQkgeL75XH5WOSdPPx9raa68X7Vq9Edml80sZzZJbaxq/Dm?=
 =?us-ascii?Q?CTw4oNxficyn/ia41EZf8dtbYVXplbBfnsTT4P2S9aRwElg816yWrW4WiasO?=
 =?us-ascii?Q?pcImxYl0NMdhoVZcJumFdGEVa8bYfC/GrlHgLrCDsHFTjeXCULgX1MnWItSg?=
 =?us-ascii?Q?W7dDy2aP5RRw0a3AGBKt90jgz56eF/BaYVH0NflVvsjGKCy+N4+RO2C1RYf3?=
 =?us-ascii?Q?L5Xuywi1p8VheMhorbaqId6buZZDHxkzSf7j1N+82kco9QV7R/5ZhJDwlzwt?=
 =?us-ascii?Q?H5mSa0WfZs/NMS/+E2shpTsX6PlRTXNYO9TvTa+fL7Q9zkMeEaLLfSdwQNzS?=
 =?us-ascii?Q?8cuDCZWFNcbDZz7s+PcgWI31zxROqHs+OM3nR69sWqTIKU+mVlIs5dkxm8LU?=
 =?us-ascii?Q?BymCmJGuFW+abCCCgSw6zJgT5PmHuf/yIrqu2TSUdC+rI/yW9mirkOnW/JqN?=
 =?us-ascii?Q?utshANv2jBP4PijwGnGM6gCSjRdMn2HeYNNW6ix4yLH+mgS/BHu/5ylAIE/q?=
 =?us-ascii?Q?pluc4fSWozrWj8fsRSnYZDO9R//H4bSy/JPLPdg3zpYFOyLE7tE9lpNZ+Vq8?=
 =?us-ascii?Q?NyIG7iGA07iaQT71sQYWE0GPRNXuJ5LhZCfNeL8fgtoXsbzGN4TNzUkK02EO?=
 =?us-ascii?Q?eqfJR2pGQ5crVZ9bsn6HulfhQt7ggXOvYoXPPB01X5Yx1vuPdmHXcwcMxKhq?=
 =?us-ascii?Q?jUj0ipUtCzpG3hYNfB8DxPZgtypqnan98Xtw9a6sdWGWlPURnTm/OVtrk17A?=
 =?us-ascii?Q?vYAY9xXoMRkGN6YjJ+2GmyTiVTAaflNKyJeXEiWciHMIWlzaRJjNB1xt37L8?=
 =?us-ascii?Q?RHoiccMKb6mMxYG7yoh9KtqHCCZ54rx6QVe2gvsnqViHPJ0Ur3B69+Se2Kjv?=
 =?us-ascii?Q?gsGvKWlhNnOburbwyRfuN0iRSP7LIHd9lTSGzpLr4LD6LB1AbHCSInEbuNr7?=
 =?us-ascii?Q?YNHpuXCwgIqhP7bWZ/qIwkrl9RWCI23Jnu2/64L5sJNj3XN8OQEiPw9V/8PL?=
 =?us-ascii?Q?gFuhpsA2PO4WvzfraaO/vw6PdN47tqkDwNQBlRachKyMZbHF6B30jEf0SQv2?=
 =?us-ascii?Q?Rv8+pdwDFOm7xkJ5KAdFIh9zXlWTkYk/4faMu969EN4+lBQuueF1JJ02Zk0k?=
 =?us-ascii?Q?g+fyIQTTzboMJKeTP5cP8OeU2BRs3udIQGvynW++2rK2aobH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988cc3a5-ab3b-4448-58f2-08dec67ee12d
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF73BED5E32.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 23:28:58.0184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwN9zpamXLaiS+fFxhGGu2xn21SOYrQKQKgVGTAviVsZXtYsjxCsKqj53boPsXWY/ctM9cex6yTxGzw0gF6kUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

Add a chunking loop to vfio_pci_driver_memcpy() so that it breaks up
large memcpy requests into max_memcpy_size-sized chunks. This allows
callers to request any size without worrying about per-driver limits.
The memcpy_start()/memcpy_wait() semantics are unchanged.

Update the test to use 4x max_memcpy_size so it exercises the new
chunking path (4 iterations) while keeping execution fast for drivers
with small DMA transfer sizes.

Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Signed-off-by: Rubin Du <rubind@nvidia.com>
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

base-commit: d0c3bcd5b8976159d835a897254048e078f447e6
-- 
2.43.0

