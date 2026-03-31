Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFB1346A11;
	Tue, 31 Mar 2026 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977769; cv=fail; b=R/Kkpsp//fJUUIQVxZGZvk1d5zWgrirHGuGWfNzK6/1wAH7g6XZ0rcEHdMqt0qE796nR6nBzPNBr00/HCdWV+3tqQVG6R56egKRb6q1HMklqB4l8W52UUXMxMxnvt7FHFMZvk5OQfjJ8KHPHJOsFosU4nhs8NhWCPPDYmqeheKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977769; c=relaxed/simple;
	bh=yq2mBjbY6Zk3rVv9TSb1PEV1Wph2xo1GFEHGEFv3Jj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JNm3iYcfSxXMX+dtCLw+Q0AKBiso5UuewZgqkjUKL1Tv3jPGKcsNoF5bybHNASz7cJYlZLUsEbco2mRD/z8kO/cKksEzNqAKWsGRdTMf2W3+rEMS3XzK3GXzKmVtA6addqc5me9PwytoBzNrgWcobJEePQJMOsw7JTqwb+FSOs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iouvaTdd; arc=fail smtp.client-ip=52.101.48.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iouvaTdd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvnHxLTQoCqhxdSKDxqRC38MHG+NFXkGhWVxxS9huGb38K7BhIxmIDtIotAGYUGyMZaHbt9cfUVtCKxwTiH5X42m90whx7lYstyH2celTHqHnKtQw44jBzu87XNJr+8pBbnLEjZflm/OrWU/8m/1yP5OgfhjkP4uy+pxCllToa7jDK+l+oDvZPuirN7I6wLhBEpspKT7F4b+5/h6sWMC5cmrSqkMgZbe8YYk5huf9EwVy2ecjKR6BhAj7NT0LsKyk3dpveHlzLy1Ucw7hTZ56xrshM0v+xTC5ofO8ObJOiNbfcxFqCHJ2e8Ogvlf3+X7EE0muG8AAKTgEdGOlEfl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1keSgbOQzk7oZh5Eq36vKvQ0XuothpXlQrBUKXAkp8=;
 b=yNPErFPMLBTaQ6hwNlwhoQsuWl50sEp64iJPTfODbaLIhpPLfJgf2n44aG+91DTfExv6IMOZDKoJr9ZrEgC2XRZ2/VpPXj3BnB2eB4rxlYhWovENK9JhAO7BFkmGY5qTDCpuD7PjEBHdkEjumZwNWmgAwFe8C0u7GVDknpnmDup1VGjUvi8Pp2aPYxyTc1aOifLif3tflnqKX/gUIEYjccmbDdsQYBvYKsNjV3R7fbYTX7cs41oAr2BjC3hmQ5fu69xddheNDeErhcFe/k1K7gtqazAD8PDciRaiT+ClrKAr0GLOTMNOAad/ZHgWPlvb/wre1n5YSRIAt8r/iJIT1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1keSgbOQzk7oZh5Eq36vKvQ0XuothpXlQrBUKXAkp8=;
 b=iouvaTdd4AEqLDcZIehNlbNnt7ylaxdWg2UZSUzuTHy0jT/WyKbreHgdmYVDZAo7gExYmPxR/nOWtAtxDCSyANvrKld84GrHQA0mqcl2QtfZ7UUCzad6VT2K6gf2y/+Rh1ldEQUFKQdo964AeFC5BN0mSYljiXOjCLiDvOeFF9Zep8dmv8M2fBdfc3jqQQiLndST+g6VuCjavw71qTEWUY6IRoBQNh/daYrbhAfKhFR6kQF7/ZvLa4psyqkk7Qnk5MI2mwS8rG/BTZkeT3cZtClDn0JB/FtWEsno+MyYijiS84lFRJKGCfqFqqUNDAa+VzeaQoXRi7RyzffmJ7cxrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) by CY3PR12MB9678.namprd12.prod.outlook.com
 (2603:10b6:930:101::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 17:22:45 +0000
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7]) by SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 17:22:45 +0000
From: Rubin Du <rubind@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 2/3] selftests/vfio: Allow drivers without send_msi() support
Date: Tue, 31 Mar 2026 10:22:40 -0700
Message-ID: <20260331172241.50456-3-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331172241.50456-1-rubind@nvidia.com>
References: <20260331172241.50456-1-rubind@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF80B25317E:EE_|CY3PR12MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: b3fec843-35b0-4919-cff8-08de8f4a1f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GW0ZPFesN6V7vMVCddz6AQkjFjTj7ayLwez951NAVUAmkMG4vkFUlPkbR7Dav+ttGlesib1VVtMe2ul2z153INnTaqtiYLCCOJ3Hz/Q/jRxI59EVpwrW4MrfmYu+S5aVIu+oLFhbBKAGNHUv5d4JkzG7VTN0aQGLLeh69ENZlg+7iWH7HPAXPA2swjjaeFfT42zi7c8LfLlnu/azCYCu77icuJ5Ybb4omNiD4SnN2fySALU8sk3irASagmEajYcDK57ZzzwN81MpponX3RQeRzW9AVvRI9eJVBCC6fbicVrISxmaRX0kw2XqHn3NwTPgA4MFnJJXVmwwIZLXj0c/lel3xI1L08s1MKxnJw8mf4PTDFk6L9miscVRe701Ah6VVSJlSJZKwTISB/fmkLZ5rj1iCEXU2Aei/fr/+P/XCVS1gIZFHYLiR+u/zxq+SXOAcUxzhch5OR3NNFsDy/HW8xME1ERRIY475WtwNDR8erY7yVJKOJEMWEhAkdipK1d5SDAkwL+aefCttYeJyEJJpqa9wsmQKwHyWS4zlBD1oS88rPYIWOe6T7EsvMt/hK/qJxrl6iFhh8DOC/czXpx1SFGqQH5qd6JsvSPxrFZFG90Od1EQiGvxWeFJNNNwQNrMXlmP7euXUzQRs1+jTwPtyvgdsYw5lVbfyVOLZ4yxGCUsSpF+BTVqwyANy0sv0hyQebyqtG+C+rnxz2Vk1LOehfkDI5E/3N6tlY1PoSRS7Xs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPF80B25317E.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YZ1O7RJmAXHbM4IYrOhUf96aTcvxpNE+cf07Q/EJScRCxgwrtrX6T3O2t+G1?=
 =?us-ascii?Q?zFcAZC8Hem+5eg3RVv4l0sYIShqNoycct01/GeOnnrPskdF3McSQQzH6rMoK?=
 =?us-ascii?Q?3b42zB4dwDVONfeLJfLgrQQTFYmCAHMjjl3amaT9ZHe0rUGuMQ/LTBFCAi+T?=
 =?us-ascii?Q?b3cVbt1CShkw9zK4rokAm4e9WRYa+u+p2Hqo6sMQlQYrPSuGAW4xF2lOy+md?=
 =?us-ascii?Q?kQfkDVelGUVk+dzO6eLwzCI45uJSUZtTNdg82AJ9KBB3JKy4q91DMAoyqYS4?=
 =?us-ascii?Q?caQdiwkIglKAY06y4aFLD4yQeGn3vOeALpPGKaMWYLs2fRJhxqxw1g6pR5jL?=
 =?us-ascii?Q?qsoP2xl/GnO34I1m9mnKy/vqbxm1Ymi//9+FLRH3y73U2Etphqh4OpAEy1X2?=
 =?us-ascii?Q?bf4kT/RRIlzXEpc5pJYq296C/iul9pJUyYnXeGYEiBF26dY30WTRUoaer72a?=
 =?us-ascii?Q?c1WNeZltUx2i0koN31lph6Rzf7ONVQZMuFVTuZMzQfEKmRmU16AugIbkDnzd?=
 =?us-ascii?Q?dIlQft55xs6M5FOvaFOZKsOt3CkFuA6Fex2Rrb5eea59dtrLgkwlApqF7VkV?=
 =?us-ascii?Q?SJuJUgrEGD9fvFYqraFUzCxp+Dirfa21vxPZSbA+w/nWS1m3YQWr4Ki18FEs?=
 =?us-ascii?Q?ieEwZqcyoCDODvAClnqe8kurXaMkt4xI9YhIvYtv43S6wPh2xpdcn65oEeD/?=
 =?us-ascii?Q?6GegVO5qnvmrVOJmcuf86RaJq1DUV5ID/aiugdb5keRd3KEZoljdqLt1qPZL?=
 =?us-ascii?Q?oZF2ygQVUrhf6z04ZXcPbx6D1tTXh8S2TBELsO2aCC/VKMwoRCGnUYUmlySx?=
 =?us-ascii?Q?5pI6wS27ixQ4IJG9FWH49gBgdroHFM6kzv2OQ17S275iKTo8G86DSW7OB2uk?=
 =?us-ascii?Q?7Taw45Ytusbkh6d6LOPqg+Jn48uAEMBVAAq/ANZORmzZKpOhwcp1yINAT9dj?=
 =?us-ascii?Q?zSklu4dWUnpfW9UCbz9W3T1/2G0+88mqqbRFflBXwsOoSdxKB4L2DIEtsjkn?=
 =?us-ascii?Q?IxGq6Dp2yIMBnZ+rZWL/PwvI49c09ahETuhC9q0qSpYvqjSTwZ0pBGA7XkSp?=
 =?us-ascii?Q?oC0PJHnu3IpIOgZre/COhmr7hrqn81OOMpeZOF8YjugRQ2tAPRZHhlCPRFGD?=
 =?us-ascii?Q?MjCe/Qobn6ToTt8jNY0HLnSZGQP/xt0NcmuH3ztKw5NM/F4FSUGVswMyufIP?=
 =?us-ascii?Q?Ji1IoQnqKUVAnk2/+W1ezmXVwRhKjRARWpZETxiCDY3QBGiY+cZoaJ1F3Lsb?=
 =?us-ascii?Q?LkPmyDGPF0xXb6d+mhLGi1fhFSzX1gxPQEYSVM5Glv9RwMD1S1306Hr5mWaQ?=
 =?us-ascii?Q?q5e+TNSZ8l8HdQv/9tTvNgNQkYT0zz3Ab75Ex6v8lNr1nFc1kxGFSh6AuzFj?=
 =?us-ascii?Q?Rrqz0o1nwUwrq4fwRAOFcBUcX0ISZ0S1sccLaSMlZY/tSEQl9Db4gagbcOvE?=
 =?us-ascii?Q?C7SMgeQ5Obc/B4yGj7ZUdd3YZyAGqVMm6EsRmBCKNDQvbvwNE4guJNjSudS5?=
 =?us-ascii?Q?QTsL/blXLG4AXgJpj2Xr8uqU21bOFDRN7mBLKb4AlXEeKKqvSbXesUpgHrIQ?=
 =?us-ascii?Q?l8imyKC9KaVwFsJVnBAqlaHny3gH1iop5nxSQ6IKx+Zk+ENanrbeaRAXLfZa?=
 =?us-ascii?Q?KwrpTlaODMv20AfiC2vjRg/W8VC8wMOPiXIpM3kFI9N+8mP0btTFvzRvT3Yd?=
 =?us-ascii?Q?QRBiABEtlAi56wHTMzRLnbzkc0tmUUCQg6YR3PkhctzSehPA8ite7MmK8Sb7?=
 =?us-ascii?Q?9lFli/Gy1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fec843-35b0-4919-cff8-08de8f4a1f80
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF80B25317E.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 17:22:45.3723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqBzOY0eZ3jDemGv8C8JbV/QLVtLRsPt2BB5MvZ4UGf0spLjAVpqY6UudJke69Px+W1C2rBGLC3UIRewTMap4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9678

Allow drivers that cannot trigger MSI interrupts to leave the send_msi
callback NULL. Add an fcntl_set_msi_nonblock() wrapper that only sets
nonblocking mode when send_msi is available, and update ASSERT_NO_MSI()
to skip when the driver lacks MSI support. The send_msi test SKIPs and
mix_and_match skips the MSI portion per iteration.

Signed-off-by: Rubin Du <rubind@nvidia.com>
---
 .../selftests/vfio/vfio_pci_driver_test.c     | 41 ++++++++++++-------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index 879e9813b44a..70de769262ed 100644
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
@@ -153,13 +160,12 @@ TEST_F(vfio_pci_driver_test, memcpy_from_unmapped_iova)
 	 */
 	vfio_pci_driver_memcpy(self->device, self->unmapped_iova,
 			       self->dst_iova, self->size);
-
-	ASSERT_NO_MSI(self->msi_fd);
+	ASSERT_NO_MSI(self);
 }
 
 TEST_F(vfio_pci_driver_test, memcpy_to_unmapped_iova)
 {
-	fcntl_set_nonblock(self->msi_fd);
+	fcntl_set_msi_nonblock(self);
 
 	/*
 	 * Ignore the return value since not all devices will detect and report
@@ -167,14 +173,16 @@ TEST_F(vfio_pci_driver_test, memcpy_to_unmapped_iova)
 	 */
 	vfio_pci_driver_memcpy(self->device, self->src_iova,
 			       self->unmapped_iova, self->size);
-
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
@@ -201,6 +209,9 @@ TEST_F(vfio_pci_driver_test, mix_and_match)
 				       self->dst_iova,
 				       self->size);
 
+		if (!self->device->driver.ops->send_msi)
+			continue;
+
 		vfio_pci_driver_send_msi(self->device);
 		ASSERT_EQ(8, read(self->msi_fd, &value, 8));
 		ASSERT_EQ(1, value);
@@ -213,7 +224,7 @@ TEST_F_TIMEOUT(vfio_pci_driver_test, memcpy_storm, 60)
 	u64 total_size;
 	u64 count;
 
-	fcntl_set_nonblock(self->msi_fd);
+	fcntl_set_msi_nonblock(self);
 
 	/*
 	 * Perform up to 250GiB worth of DMA reads and writes across several
@@ -232,7 +243,7 @@ TEST_F_TIMEOUT(vfio_pci_driver_test, memcpy_storm, 60)
 				     driver->max_memcpy_size, count);
 
 	ASSERT_EQ(0, vfio_pci_driver_memcpy_wait(self->device));
-	ASSERT_NO_MSI(self->msi_fd);
+	ASSERT_NO_MSI(self);
 }
 
 static bool device_has_selftests_driver(const char *bdf)
-- 
2.43.0

