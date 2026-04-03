Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BA5391837;
	Fri,  3 Apr 2026 23:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775259896; cv=fail; b=ju8OjZXybJl+1zvYLTqXl1yPVXLBgdQGJgqlz6N5lPd9NvnG8G7Sh3ZkGc/V1z3X9/diueNe0v2uymMjJ3RUXNCzwq35jAmU6OnT0WAFtSrPSkszS+ukfu3OfU+yoxcQL55hvJngkwrrtxKh4zX6O7cY9kzWn5A57nhy5JMxMro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775259896; c=relaxed/simple;
	bh=JreiuLo8mEuff0zqTtWqHLUED1Zd9EhOvZABy93n7II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ClF9R65+HDFJ6zX3Z981UAcr5WMSFZN7SljdCZmchshmUCg7av/4GIGzPnzesl7Inh2/nrglDVx07L9FqTqaKFuUIBvs7hFhTi+K7+EFKwFSjkq5uX2YIqOypbb3iiMkjyf3/gnpLdPTGIWRXHTgRkJyp543VZlfk4fGVJJgBVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LtocnHJ0; arc=fail smtp.client-ip=52.101.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LtocnHJ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3GwASMSFJiw74WfqkAQ+uII3RdjccFYmzSOSzUtJ0TN5aJnvrDez8YsfR4TFxnS7D/s3L/SaGYF3xSOsZu6Hye/5+Df2He1HQtzMw9c1xU2UXDFM1IJuXqiZAa0LYChSNsUIdT48CXpgg5Tpn6eY+vg6YTlLHwqgqUstqPlGQyYq/Yv3OU1NDLopjQxSeqfCXOvB16Q28HOUHcLrg0nXHz9iTpE95eKiAPWx/KLV5WQ566GFcrKQGSWp9FgStb8okMdO2Ju9rDNYHEckjY6n94bHKLYoV+8tMk4rn+Qdj/t5HAaHJiMazcB8E6mV3/hAODrcClONzaP6bIMvtMxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wywxkJRCB0FXgFMY+0fxkANff8Ro6bCPhRi2FfN4vk=;
 b=cpyoM4H2jl0xdsLo4Vg07Qb8OxdBoclVuIr07Cu8joYvvu3tDbR5CYgLSqxr77BeWSvAsBGkbg93nwiKUBcqyRCqKWcoo0bUFgSqz9SVkyWxPGuhD9eho9yFDvpBo0Xgod3yP3+M+WnUDFLEu11F4PRlF2aY/FulMl4XabXj4xLVLh2JAHtkuaikVr3+YzIMQRCNqVSS/59zwkrrDl7fz8FvQTaLbDu2YxmBKJr6Adbh/bOphtxniLuuZB2aHfVEmjTAZYTaFgQEr9xx8vm7gZWW1Jv7qtYt+nTrzCxIS/qShGAHb5khTAbZQmtLoXgZXUFbNv/vmgLxao1NNSPvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wywxkJRCB0FXgFMY+0fxkANff8Ro6bCPhRi2FfN4vk=;
 b=LtocnHJ0eTMgf/OvP3Z+/zs3t3OIjZ9pyorEyEfGnBJGTz7rfnFFizu9qG2Sl6VcBtTAnPP7zAAJ4VUR22TlYe/E/WWYM2vgNqkXeZtR57l8hzPdF1o6+KdcqiVXvIuWqBcUQJFGu4JjzRFFqnKYyjCzOOTxqNdLn3fcG4M+VrPBBlhvQ2yxHc6rA6NLwwpdW0LPHv/xTp3O2Dz+WVVKdrF/R2INnfRYyxuEDSVYV6pH+EuKwq+GSxIgI/SQVMPOZdiunD+4GzUqY/U7t/oLjnyrIHS0HHkx6lR+6kQoITwmT2BiCFlduplTKFr9+074eQ9mqKeLwFyw1L+s5kd/Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) by PH0PR12MB7078.namprd12.prod.outlook.com
 (2603:10b6:510:21d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 23:44:50 +0000
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7]) by SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7%6]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 23:44:50 +0000
From: Rubin Du <rubind@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 3/4] selftests/vfio: Allow drivers without send_msi() support
Date: Fri,  3 Apr 2026 16:44:43 -0700
Message-ID: <20260403234444.350867-4-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403234444.350867-1-rubind@nvidia.com>
References: <20260403234444.350867-1-rubind@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:74::22) To SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF80B25317E:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ebb2d5-b55d-4a82-729a-08de91daff08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ncvQUyx+3dDL4CvwG7T3SiZcsLTNrzUSlwFSJXRh+Rtap97wQgfSRanDOfh7peEyigs9JziCjCuIn3v/8ZpG7auBSO/c10rVPFE99K5bXIYxu9jTIhv/ThQAnZurwjqfJpCTji3Y/2lSmq6nGiZszaLM6odSc2bpdJ4Xk24wlT+e8Ncw9JaPoam4Ha6FTiYu4d3E2tE1VEYPrFZc8W6gRm492RIS/Z8u9ApmHoVS4aqLWYtfEN82kCJYDjS4g27nVEPbHgDLfk2MX2vkfchNWBd942xM9Dzq6EkxxDTBgH1jxst8rwUalysbNM7XNWRbN6efXFGDCU956q8moTH7oFIopi48irTH26dsQAoyReQXp2Gb7DSQLaB3uI4bpGuGPIFXZdlDkkCf1cG1/T6G1ULWbsv4sTLv+ng3f0aFFDKzZPaM+u1DmS6Ff2rbkdpZGbz6JtzZ2HTz/W6Su3gaekjKNHqCPrw1Iyd0gE6XxlQkD4/bpFq/Vjcqb9CJqxItI6NcMMrc9SXnM4cloUu75DeUui8Fla9dAvqZn4z1ICa018lJylWjJIfkMYahgPCOAdkwvjCiDVfJLRYU68KloKzqRpQAqSVKqOhTsghcPJMz3ezzz96P/Z1sJ/4P34hiVGfFEXZexu8hhA7hU0qbJrr0a9faIelkj4ducTTjcS+a2Ftyu5I2PmaKAGnP1b3P81N438MTvsBeodzPANLINfTnu4KmFF4DwJqQF29G+3Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPF80B25317E.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ehnQAwIE/TUCIctX7NoQqcYv2VI7XfWu8Wq3Secg8ryU5WM8dM7aDxymbW+l?=
 =?us-ascii?Q?PfTmK+PkgUpOhuQUDN2h3kKNnwKU3EfPp5679TwooR7GSX/Et6ni1nOy7quo?=
 =?us-ascii?Q?0sYJiAuTpzMKLK4HeN2JBbI2SVaedNm27Y419DyL29/gMWTM0SwLEE7TbIoS?=
 =?us-ascii?Q?QJrDMiPFCQVQPsZnn2HuQScm+rBhs6uWzYDfH41Wh6N5J8Ku5zQzegWW6K7p?=
 =?us-ascii?Q?8APWn/lewhtmOFPLkEOpTLKSjKOA45y/IwJACCaCrZ7TbMpKadR9rBrbkfwC?=
 =?us-ascii?Q?vuYUhS5XI2a9V+UkP0eqdsKhUNLVhGE4pWmXQvF83JDtRYCyPdHXt6ZKWswk?=
 =?us-ascii?Q?+l1G+RZ//CzFQ8kvEHA/A9i7hVE0IpHe6TeoqGn+AfsnInDbY21B2PaMJkf/?=
 =?us-ascii?Q?sFQQ9oGUeooNOsVHdq8FtumB7hR/AY99rRzKswbvDln0D0eRaZVhVn1HjeCJ?=
 =?us-ascii?Q?KzrFmL5LQ6R2C4R+DixCNz+EeVdzkaT8GGp1dwrUdUmWbCgWLLKsnWTSem0D?=
 =?us-ascii?Q?oVM1YEQV4s1ajHl7p+At7mp08zvGy6+MYxfuSxyrk6ZTyLx6lxRcfgKN4tKB?=
 =?us-ascii?Q?JxP6z5EOCKfA8dQUSbDKUKn0CPOLCnnjkUdPtvBpYpievUi/ihgqmfK/wzBk?=
 =?us-ascii?Q?Ke8QyKs/At3/7rYbZCOfRUC22JPqoCLTjWoFU2tH/D5vqGkjXNLHBt33SSYU?=
 =?us-ascii?Q?5rkXrFnexNsVc3TFjps7KAPgBN1gQ0T3Ho6IuEBL0312oSRBVB66tUEZK0GG?=
 =?us-ascii?Q?oW50+x7JK5idrpPmshxVF/CpFJiyyGkrhr/eheRIVJB9WNBD1+WiUKb+1D6Q?=
 =?us-ascii?Q?X8cpi9LL4xsYxrXZvlnh8cc3HERy82JFx/gw9KodhOqjdiW/uL+uP6mZpVxs?=
 =?us-ascii?Q?w7Wzft88GnZnD13i7nPXSLcshuDgBr03oB1dtRilk7NCMahiiNv8sr6awbs6?=
 =?us-ascii?Q?3CZf4j8YwRK/kUirru3mk4nfRYAQPq49XexMBJWFoIqHdqJsvA4iRF35E8YT?=
 =?us-ascii?Q?skRieoHosFOvw8a1EuAyQhfiRQg9xE5BCQ+5KuhrWnWWdkikBigZ/pzJex7q?=
 =?us-ascii?Q?8XPC6x4awckkBnWzT4IRS/O+YMYKs42n/UCdt7zq3XgnyYHG2qXa6Efqptyy?=
 =?us-ascii?Q?iUqBAgdb3sa6qNfjjeNFejLHRShRg8/HjaSD5u4VmkAW2UajlCRzyCgtnhmZ?=
 =?us-ascii?Q?+nARvrJoC0gSB7ryfuVhctB/EeTSgcII/42V5L86phkDNQnjH5SoEcDD4FZ3?=
 =?us-ascii?Q?cl/KrW9gflxnPWiru62wB6MXX40sujnjwkRqjuYvuobziaT9S/TSaGUH9gZJ?=
 =?us-ascii?Q?3WOizbZEM2J0QbdGxpM927TpNd/dDWSx40uzSEcB5//2/Cu8W7oAi3E76AZa?=
 =?us-ascii?Q?gmkX5A4FbooJJpQwPKDsFcwauPRKmt/BKUwbKLyoh+FnGAszMz0lNARocvB5?=
 =?us-ascii?Q?m5iJKuNNeX7/sZGK3emdeSAd0Fgz8GgiQKpl7iyT7wH3zDUyR5DKWP25CRG7?=
 =?us-ascii?Q?7whJvF/P9ykbt6d54I3TfxicqWdOuXTdH3yVvxNgYkoAC8wgzt5I3drMurDk?=
 =?us-ascii?Q?mjCCBPpzEaaM7QH0Hv65VvjzGka4j4++rYGbmxA3avUpZ6OV59EFczAVrc/q?=
 =?us-ascii?Q?U1mSNnoShYZSJxuwu2PUxoG5hxRX/C7y1mmIDQrHgBUfbL5vAqfEaXj+Mbta?=
 =?us-ascii?Q?PY9GPW/t8Zcyfvu6NcCXWprXgXKn7sBo911kZy/otRm/Usj3DTIKKFg/+0oL?=
 =?us-ascii?Q?eRH0tOc4Rg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ebb2d5-b55d-4a82-729a-08de91daff08
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF80B25317E.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 23:44:50.1878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Z28AJooNrXiP/53gbHDXsfLO2JcqAIbBBAavjKdkLMbjTSKMcjw/AO6ZTg9Qkr6nQx9dZiopztJJnWB8hC5Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078

Allow drivers that cannot trigger MSI interrupts to leave the send_msi
callback NULL. Add an fcntl_set_msi_nonblock() wrapper that only sets
nonblocking mode when send_msi is available, and update ASSERT_NO_MSI()
to skip when the driver lacks MSI support. The send_msi test SKIPs and
mix_and_match skips the MSI portion per iteration.

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

