Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68667395D97;
	Tue, 17 Mar 2026 21:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773783767; cv=fail; b=euRW0wGrjNYMGWSuyMZKYP96cWPHNuTmT09p3cwXBxXNTWrDfaTgnjIjnvn9KReunebmstVwsdxt3xNINZcI/mJ+UF7nAtrhxjNEODbDbaCLPQefSCZZ3ytIbZbQtuhoR5QNQUtZIKos6y2a9TsyGhoHIBBWa9s0RT7t67NMiJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773783767; c=relaxed/simple;
	bh=H/ppyOpUyKHN8GrJ/hR0uLxwOKih2arhjOXjPA8Suag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DXo0X51Sg9n0cRk2kGaQxJJWT42yVy+uGj2PoAto52VxLQtdsV8xVYHUbZiQvlLSLYmNtwZMkqKeBwBpD0eUT4F9z/CUGv7T0386fSJi7/h+/HWcaM+WT9WDS9bJRy2+dW3pgRvhdWqRD720alcavWEIQKHplTERR9AurEGf7Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DDhH6vTF; arc=fail smtp.client-ip=52.101.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DDhH6vTF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b87eIMq9j66IMnxtuOkxdvs1D49f86EoaMlslEnenXIk/8sKKQWzQwxIbIJAFCUP2IfMPy8O5LGlRFpemsbn5CCZy6g09vE5zShMz7dz7UC5ovmPI3PsOqI9tyrrDton2PsmJMZ2BJh+MTHRrpvrRe3Mj9dFVOvunu9/RFqnpZRa906gTHTVW4ffKuF04aheJ03dkAqWP+ZPVRGKBUupUf9QHIQfM22+sjKsXxDFsH9rR/1G9Triz3qWeLCiJUaWccYvvMeEEZjm9lnfb9yx1zTULsLKl/KrgOWe0Bdzy3hXS13MRJIYzdwiXleK8ywHj1VmfHPaLIq46QuID8gtPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNsw+u6siujAhI+ksf9xO9ST+5KJJjtUzDRymzZyhq4=;
 b=YmKlRqO/0HnElaXWUpx6oH0Z5xESB+rhq9DWbCl4+oKpVCdbYj7VjiPL67CVH7R9cMmzEDPIHWOJCiQ2zhaFFULVc64Y0mPE2dBqKaArLRufhZ2YvDcE3uAz4+OEYpsHyVod+xTZa8xXtbG6cOWukunKMtEsSb0bfmSIEwzJZDGC71r0YIhK9yFVyD5FxXJl2PL8RIOAY11LCrTbinf9lflmT9/G1tlrs2CWVwjAbD7mwIT+/EvefNgfkxm+K5IQi4+8+sx9sAQ+cSn/xLToQP9x6muOBbIRDxEHF5GbtAxldD+5A0xLOcoyYqFJmsc+yRuDM3pQVdB8+sTnPF5WHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNsw+u6siujAhI+ksf9xO9ST+5KJJjtUzDRymzZyhq4=;
 b=DDhH6vTFQ3qYr3jUulk9p1Ve84S0I/Zz/P+eD+v3uL19AmoF0tCGeasYpA4HJykRk6ufLmOAPe7+23pjh2Z4zVwWWl5v8IPgJT/6YiAH12pkM7qykaQ7QiVW9Th8Xy/u3bbjIbaiJvIW/LdoFg31MbZB8XZsA0LyRDQrF/g1FMSMQ+H7mX1+u0VxdZOCgvW9w0kd5udAy+StNQMkQOeRh2YIaMdFe5uNrdCsnANzd5CCrRn7zV5lGLyGOoQLTkreAE9SUdDANrvuDBBnspvkSBHS/9oRTaEEA6CezbaIeAEjQTKvEncqqb26lkQ7un0/NCtSIu1hpCI+u9WQFB57vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) by CH2PR12MB4070.namprd12.prod.outlook.com
 (2603:10b6:610:ae::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:42:42 +0000
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7]) by SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7%6]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:42:42 +0000
From: Rubin Du <rubind@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rubind@nvidia.com
Subject: [PATCH v9 1/2] selftests/vfio: Skip MSI tests for drivers that cannot raise interrupts
Date: Tue, 17 Mar 2026 14:42:38 -0700
Message-ID: <20260317214239.124857-2-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317214239.124857-1-rubind@nvidia.com>
References: <20260317214239.124857-1-rubind@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::17) To SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF80B25317E:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d7b1c7-4c79-4093-faf9-08de846e1e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1FWphUpnar0KNngd642+O/Ny1JUN106z8oB9y/nLSIsm3r0ZAJsYtlhL6Cxx0uDHbV7M13xzD0TvhkQGeaKvTD8a2j1AAvBtpKW9lCqx2vxu+bfnNFq+a4VBAKcu/YrBeP6Y42KxHFOLx1IKkCIWMjgkQrRQMoBsj25If3EBW2MMlginJcO3gLOxLbND0Ops9UFic+2hE8Zx0562RJHhSTpWweB6A3OsGTXg9lN0FhEhNeFgoSF3EbpbRwVzxzutecyUZswWSd3BKwVJL/9dwhCPKnbavIJ07K7ARpXLnVXlSdRfEVNs/tzlJW8DH0JSKY0vmmGdyc9MG1zu29V0QqakWTJ9aKm4p2DnIdBjuimTtZqf8Hj2w6Db8u8PgfruWBzvDwTEO8Qg6LYftigcG21QuZbI+KO80w2caayQ8Hvk/BsrIrdxJ2G28VnSlAwQDpms9RqsKlkiEz9RzH+whqVh2NPNyEyj5fMfyKse9rMYw/TX20NmkZXJ2GsOFpLT6ISlrmZYac2zwE24qXvq5Suzl9LGXvP4PunZbjV5cMgUV8ItxYikNDXI46HcIFX6PJjCvQy1T3JmjiqlgPviI7LtVaoZG0qSze3TIUpnueq430waQLDntjmbCKbBFovDaiNSNy5VzZOuSzjj+meEBCM2rAvYrbKtFmnB4p85Klsh68vlOdsnTWQ1z90mI9YftbHaWJcJ/xz9AXv4vknxGmYUsAWpd91LW2V94LGouHk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPF80B25317E.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hGHKKrcnrQDS08hNnMfsy/sCaA586JRk86MGE5YWl4cCKN3Ri2xOVEyIVWs8?=
 =?us-ascii?Q?rmYFzgamwyL29ik+Y/sK1gvnKrf2e+ZV6Gju4A4f1Idvdh0Xt7nPmQQxj3Fz?=
 =?us-ascii?Q?jFwTMAs4+JLDzmYcy5VCEKEGrm1SZVw5eaGWAQkM38BaALH47dlAydswt9tG?=
 =?us-ascii?Q?/kfpkAIr31mFSLYy8e4wpun4a62GtKG6L7CbRjbPEq0XKpPpy3tvAIh+dYQN?=
 =?us-ascii?Q?X2oas9+P8UfSKCvXADuUrn4dAPyAOBRCSFF6XIzONZFwBnxX7VcGtl9+LpMp?=
 =?us-ascii?Q?Hjpp0VU5Ng6eUTKdZh9g38s/v6zxeBk7Tm5ABwloxsZkheUvWAoRTrcRB/OT?=
 =?us-ascii?Q?8WFg8+/JtbzY43kWDsavQemEqZ1PPrYLtwLJBNtCQtxG+cJBGe4iOQ0IRlh8?=
 =?us-ascii?Q?Td0BYW/Tz6k1EvLPgzoWJvmG2VADbADJx1jwz7TGCp53TdjMR37Aq/WtS6mx?=
 =?us-ascii?Q?5sOGTxOhlgCUYZV5qmwhxJSrRUMSVupzHmkTUX5gb1cpm9NJ9xUT2nVTMoue?=
 =?us-ascii?Q?IrzofptTC2pogyXS22SqWFn+d4TWnL7HQ43VN80AARoaOuqD5vyQQeg5mzmb?=
 =?us-ascii?Q?s3YSALfjNKnRm4Jxs+vUFEDr7LDwyBbrTb7TP9V1iJu2/LBOp1rO9SITmLnR?=
 =?us-ascii?Q?9sHsjUoAtCv5Rna5Z0gZZFL9nVaSZoPgAu+0QH8HIZFEbTsp0HAo1cEZ0i8s?=
 =?us-ascii?Q?flkKFveNIBytQCc8QakjMrTSluTZd/kzJW526FdnjMP8iRAh/VeQ+g4o67+M?=
 =?us-ascii?Q?5YIEZeG8J9qG5fHg3j9kmjFxZPctoYRuLPE+OkPjpoMD4o2hQ4t7ts1TuzIr?=
 =?us-ascii?Q?9Ezj4aiMzwkiAczXnmlYnZL6lMmiy0xqAIPcyL8AQzp+zISE7Uljso4GEpVD?=
 =?us-ascii?Q?JBcyT1QNrJbBwS2vJW1KAW9Rx7Bv7XYSDNW+A7qbs+0yxRl4yBK0bo6A67CB?=
 =?us-ascii?Q?BKDQxxO0YqAbxFY7gj0Xj8vQYbjmSqAVgggnFnJ33v121iyRhLqXjGPY8Fc+?=
 =?us-ascii?Q?kGDl++Qf0vKcXn4YnRDuzE26/3ywtve0tQGsFp5sp1n6aMpLebMl1RajXYSr?=
 =?us-ascii?Q?WWHUiZy7EUtxmKsX7/KAG+CFDqmHAS/+4+yjUk2FcUdxEDf+wUN5OSn7n0CX?=
 =?us-ascii?Q?1Xl0Y1VX9WE2jpdDul5kfMWPC/EiAFKU71JI3lAjVoFt2B1glSyJQyl+pqkA?=
 =?us-ascii?Q?1rvu2j5lG6FyWCiuZIwhadIs5lYxCBsBH3+XArY9FzbGxCpc1zk2wSWrA5DZ?=
 =?us-ascii?Q?W93cJe9bieRekVwCaac5EuXr87UPScME3h/s7picXzWyNlkuNujyi+81t3/C?=
 =?us-ascii?Q?o2uB9gYH5jo0Uik67jzgS90Vp0N2Vh/GKVThRi8NRihKq6JG7sp/quloj59o?=
 =?us-ascii?Q?FKm+RRK+v1myuBSzSCTvjhSjp2/DVLQxgWXXUURv2ioXskUzmy/PSci9kuXL?=
 =?us-ascii?Q?TidmGW/gXuH7niRK1PbtB824wQynyy47CAJpkbap+8F6jzTxM0iICZrMevKc?=
 =?us-ascii?Q?9mrru5cZh9csxsDqOLkAgu4np5YhPbHEOm4bk82PT5BRGjEpMW0QPtPq11z8?=
 =?us-ascii?Q?6h/lvgR9a0OJk228p/J28P3i2M18hqbhx9gLrXnF8udTE73s1MYqnUwkispz?=
 =?us-ascii?Q?6zV2FTRGFLaSWRns7PtFzYWRzMzZPiz/gBGZe/UMAhdmEdZNCc0UBj9dEaQP?=
 =?us-ascii?Q?MRE0fqIaXNNPPLjspSRWRAzTw2S2u903/gigKmWjfxM/yVDnO5H5ieQYdaGF?=
 =?us-ascii?Q?7htELm/yPg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d7b1c7-4c79-4093-faf9-08de846e1e1f
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF80B25317E.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:42:42.1201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGel++RapYvxdcFEdpqIGHmufoY6cjbN7roxqqnhn1upsenUZwjdIaxtn328Ua5ClEFSHukc3NxpjcT+DJLVZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070

Some device drivers may not have the capability to trigger MSI/MSI-X
interrupts from software. Add checks to skip the send_msi test and
the MSI portion of the mix_and_match test when the driver's send_msi
callback is NULL, allowing these drivers to still run the DMA tests.

Signed-off-by: Rubin Du <rubind@nvidia.com>
---
 .../selftests/vfio/lib/include/libvfio/vfio_pci_device.h  | 3 +++
 tools/testing/selftests/vfio/vfio_pci_driver_test.c       | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2858885a89bb..a497fc990924 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -74,6 +74,9 @@ static inline void fcntl_set_nonblock(int fd)
 {
 	int r;
 
+	if (fd == -1)
+		return;
+
 	r = fcntl(fd, F_GETFL, 0);
 	VFIO_ASSERT_NE(r, -1, "F_GETFL failed for fd %d\n", fd);
 
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index afa0480ddd9b..8269da741b67 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -14,6 +14,8 @@ static const char *device_bdf;
 #define ASSERT_NO_MSI(_eventfd) do {			\
 	u64 __value;					\
 							\
+	if (_eventfd == -1)				\
+		break;					\
 	ASSERT_EQ(-1, read(_eventfd, &__value, 8));	\
 	ASSERT_EQ(EAGAIN, errno);			\
 } while (0)
@@ -175,6 +177,9 @@ TEST_F(vfio_pci_driver_test, send_msi)
 {
 	u64 value;
 
+	if (self->device->driver.ops->send_msi == NULL)
+		SKIP(return, "Device does not support MSI\n");
+
 	vfio_pci_driver_send_msi(self->device);
 	ASSERT_EQ(8, read(self->msi_fd, &value, 8));
 	ASSERT_EQ(1, value);
@@ -201,6 +206,9 @@ TEST_F(vfio_pci_driver_test, mix_and_match)
 				       self->dst_iova,
 				       self->size);
 
+		if (self->device->driver.ops->send_msi == NULL)
+			continue;
+
 		vfio_pci_driver_send_msi(self->device);
 		ASSERT_EQ(8, read(self->msi_fd, &value, 8));
 		ASSERT_EQ(1, value);
-- 
2.43.0

