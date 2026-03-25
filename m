Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013058.outbound.protection.outlook.com [40.93.196.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A967397692;
	Wed, 25 Mar 2026 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475016; cv=fail; b=bPQxOjqsVhUf40Bi//8bgqNoqUdanOKPv7m8Y+mOARNV2ic3FBWJ7nYe79VBOEl3i/cI9bTKpkdxAcaFvJGUU0V11Hdc974rXxOM8Ilj0+kJTZ/sxZJlpcAAHfqFfzAUFuFVXhAg1YBvQL+dEK4oeUo2KfwexAik3zouC8BDKds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475016; c=relaxed/simple;
	bh=kQdIeIug9XlmP/vxRuRlrd3BRnwn86TqouSzq0NS8fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SCRwLNxXROA84DUVGbcTMOoFjIgL2TVL1p3W/JaiOboIunfRISIT1GjK2+9k8YpDhkuvRxpsfZjXMeWft9C8Qh9nTWV7YTMZp2/8IQHSqln7TyqYzY5AxOGcpsJjZgGQstoFQj47Wy2mq4k+TLtU2RSo5Oqzayea1N67EqW+IPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JveXT/t5; arc=fail smtp.client-ip=40.93.196.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JveXT/t5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSjhYMUdFncqrh+Sevty2/Ps147sqR41tdREQBxNwgcGuxbgtnCZWzZ3NLnamw2E0Wi6gFQk1HFIaYNf9IgBkHKGwK2fWMci2jzov6ipyqyjY+aM5DV7JapN28PIEaakX2J8RCDl7OGEUNdKb8jfpQxT9Sj9SJKNS27FNOmcpyIqCTMH12wwvctj3WFXhqMBOfluDX05dPvK5X31v1QE8xrE6Ia5G8lXpSkd5keUYPbzyZYb0tqPYjMfz/alaWc1gnKW1Hz1q69fmxfLBFbxkayvlz74nmD9zHLqdwcwN8nT/ppDq3dcvc4CKciHy+DDcp77w1CiSto52gw0QGwYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKWR6Bi9L9q3pZwwMwidMr1ZlBxhMcGqQdBTAAUHEwU=;
 b=KEyw8dHEv5bZZsy0/V9zt7mQXhbYv1pkK/f7NRZzwKKRukzkZavPNC23WeiHaltK+Sz5eIysy/p2w/4I468njq7/PNpHV77g6nJuZFrVpBfbcZNrUYlW8Q+oDvbLzLTm7CzNS0I4Se8UKWmBnhRLnuwaXzft2TJiH2RI2kBE+teZgXudld8azGPYk6TQPc+UkXLAAB69gsw+Yp26alQ25EB+pgMm6lr9i2W4nEiQGXYRjoX8I8l6jyqgUWnO/LJknSxnf5RjSuj9O9jy77qF4CQdBImmXyMyvR+toTCn0i9teh3pKZXTkBHw8V5NO3sWHTRoj9IryCVp7zVpVDkNAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKWR6Bi9L9q3pZwwMwidMr1ZlBxhMcGqQdBTAAUHEwU=;
 b=JveXT/t5ZcuaHvg8nm/njHjLibcv0bNE7wjmqaUhdjOqfKlDPz3fFtDme1aA9gZSuQwhOLlpd7cdSylMAIxsX6Isf0duVwY2G/x03aU+JukeNu4FgE9wEa8VsPCPMeqUo/OKTv110K6kGzYBHffrl5QBF+SmbW+j7qc1+xByw9CekMR3uTneiqdZroRVoaBxmyzlmfgicHDSkbJGRSHYtsdcme/iPbCrnE7xxQA8AErpiz0pvLjjT5RbASG42cws1kgRgFvvvrA+3vuRS3lK60k/VgK5uAho3DLs6EhmaNKgCm6h5GoDeLNtuqkaqXdj4th7BmyuOd/TaQIIfzYUIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) by MN0PR12MB5954.namprd12.prod.outlook.com
 (2603:10b6:208:37d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 21:43:32 +0000
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7]) by SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7%6]) with mapi id 15.20.9723.014; Wed, 25 Mar 2026
 21:43:32 +0000
From: Rubin Du <rubind@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 1/2] selftests/vfio: Add NO_SEND_MSI feature flag and MSI helper macros
Date: Wed, 25 Mar 2026 14:43:28 -0700
Message-ID: <20260325214329.464727-2-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325214329.464727-1-rubind@nvidia.com>
References: <20260325214329.464727-1-rubind@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0051.namprd07.prod.outlook.com
 (2603:10b6:a03:60::28) To SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF80B25317E:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: c3944421-c287-4136-0ede-08de8ab78f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UNl/I/mpoiMzcHfz/+AJelS7iWgUhNXduaIbyCznFQihXhZfKh/nZq5Akvg0V+6EOWWVzn1YBodaLyVXUaojh8n2F+7W2Ea+Mj66ogwUmjne/8uqAHaFzZ2uWv/n6AV+ZZFiPa7ot8SUabAEFjGZjfdFXqyWu3V9xnpUAQeuJt6B5cGYOu4YRBfcD5IzA8AYuaOKNBXNpbhCsGaT3A6Rigw/EC6z4JKC3Lyci6WYRGJREqXOpRxDA4xRkZN4kuEgCGiW0X9IxHS421l8dV5APUllzWhHbs5SIGCvzs4YAYgCEC+3JUe1LXG6KOlq1YVAd+oKnyRVgSH/20jc6eQlzPBkTqCE/yGRXtob2N/93WaSNc75ouEpXWuwhcaYPJ6GLw5swiONdVWuRMO2zs2lX4Dzi0ypb2i8T8pXrA3iUMeAgcXxguncvA8mBdo8K/XBj5Z6MO30BNLIqay6bWUvrcp/rHVMWIUw2cXEz7hZZuUqrRfHcz8w3cjG38F6dXXKle+z0gHlODvLLI778wfgwrq4a9sTia8R6E4KccwK1q1dGeRL9K7q2+Mhn60PTJADcJdPDBQiC8tjyA4N3BpolFX976dQvawoqMniQ2sHuMuIhb6r+BWIIvsH1CNJsvHR+iYgCh6fXA0VmRohD93Yo6diNlKL/B8vmtAFPmlo6OoQWOD8cpETS/yx7ZLj8l3Avp+4UZkC3spj1GToGvpShruaCQPVOdBQ18Sv+Wd58mw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPF80B25317E.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DN629uFHvh/WL6nBw2rFWsr/tnss/LUOklIJ1STcd9HaSdmleEJUwgtd7u9r?=
 =?us-ascii?Q?eJkCDAKQ+isJRzF0XRcz8G6sQ96gdUnCFyqecZcXJXzZiTPzmWekQ6SdsbHA?=
 =?us-ascii?Q?MjY7prrDlk6kVAlbPbe9ue2RMddFLAwWcCxz0Vz11q1KjG9OsjmL5otTAwfP?=
 =?us-ascii?Q?u81z8KiaCFOueC54IwSArk9JZVhpt2sbaaNH/U3iwpt1BZaSkTQJ897BZwBD?=
 =?us-ascii?Q?yibKSeCpDzKcDi7B8qmW9LvHbkxQlXl7Qtfrd+KT6q7VfiSpWG/u1xoqHq4t?=
 =?us-ascii?Q?vxvIbYL0qD0KfgwmKNod3sT42RmSYY52rZHw6S5puPJsTT5uVpxPOSpRk7zZ?=
 =?us-ascii?Q?buqdPVsGI22ZR8xt2vFIwhiVyzDj8RHS3uXbun9W0WIxNvon5z+3B8zMcd3u?=
 =?us-ascii?Q?cj8xkTLZP48QJSp1mJT+zmmFR1UZ52TjZIvZxw/9B+m4UVwjEDiI7Pq985bd?=
 =?us-ascii?Q?7WhDH6Q0XPOm4oovV12IdcMEBYysdZ/KG6WXShWSbWHoelKtTsdRBVboOaPA?=
 =?us-ascii?Q?Ms2EpVKOmP2HaDBMmqOg9wWkvOKkA8cyCcWAD4IczvEN8tlx/27ByMAXnggU?=
 =?us-ascii?Q?ptXViuf2iO4j2oUBMA7LmvYT4gKK3E/uSlyUG9VPkjhcnPJ+C/NFRAsIE4iT?=
 =?us-ascii?Q?0O6g48aFk7QOV5Z75GtpxUYudqdwY0YGkWrUmKVAO9andFciJOU1qmE3CUct?=
 =?us-ascii?Q?NfhaH5wWjlwcgUq6FyecUjPc6x+8B0J6JnD6TVYx96tPTttCtes209WK6szX?=
 =?us-ascii?Q?pv2SlcuhAP7SfwnEmztodqQDlxO1MJZUlLQVyc2rzFStwEnvu0uE6JycZHTy?=
 =?us-ascii?Q?rEIx3wFzjbfiFfVuY/aNVBzD6wODIZQiLzdk+nH7D+A3panKolRFTFLxOkL1?=
 =?us-ascii?Q?E23Y7rZc1+f4oQP4DUNHjCAlLQxhhV3nokq8F4r3djpYFSy9WsBmZIR0eeUI?=
 =?us-ascii?Q?OTCfDTHh3sTbyPefQw92XF3Cs2VFnrzIdAKGT0sLkA2gwFCpKMhhnXLFdO0B?=
 =?us-ascii?Q?DHPlP7gkFoGB+8iQfyWrEMfLud6GdI8TiNqpakIluG0PQJB4tg91ItRDm2Gu?=
 =?us-ascii?Q?uOF4spSqp8RTFym8F1qWnyYm6TfzU99vRH7hvIUJKlZxElMkzGPzOUkM2B+6?=
 =?us-ascii?Q?5bHyuof4BweQHMcKZfHM6qAbxNjT64806VRVUar6qGRTLyoepdNwi7g0tdpZ?=
 =?us-ascii?Q?zziv+SOz0uwrRd7Af7vYjWav/sXqcsbF8fjKQuYsfr1Zw0suC2JJ5rs3FuLK?=
 =?us-ascii?Q?6Ln8k9nDtS3oh9d44fiZCmqkREOrHpszJfgq6ful+Gh8E6ygIuKMApllZs1/?=
 =?us-ascii?Q?tWYrBkCmne63dyaVjWqEMsTscTkRoPmuL++pzdV87AJq33K5VfovYvfAEAAo?=
 =?us-ascii?Q?lgy/R2fW0hV1Xj/QTOPneKVIx4KM4IMn6DGiTiyZtRXQwNwFhprBk9fyi8+H?=
 =?us-ascii?Q?PEbw/GfsaDvQeSJakKHgw/ATsXFm99PX/Ym15OqH3R7gUqND4kj9a1te0ah5?=
 =?us-ascii?Q?eOp8TD/taBZ7Yv+Az3RwHc2yDLtz8Nw9v8I9XCjoXROePbwhVkralRG7Pg2g?=
 =?us-ascii?Q?M/Cf34JnPsZ1ylFTyARL9N92hitK91+I+f4wl4QDMINSJJI6fWV/HmqLXS/4?=
 =?us-ascii?Q?UjByEBbi8e8CeFuCJT+KifHuhFl+nTPFU1z4fdXj8bkWLR84KAnsKjwNC/b8?=
 =?us-ascii?Q?42edAvyr1hinoEDKgqtGdcq+e30TIGleO6KTtbU3mES8ymXbUQZ6sBqBjprO?=
 =?us-ascii?Q?4Ij+CeHKOw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3944421-c287-4136-0ede-08de8ab78f32
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF80B25317E.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:43:32.0447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwQe9uKYHtiCZxGXBldFsffg3rvpV1Y31OQKjpZt/EXeotGUiw86iTAUarV82Ui3DXGHS0kYq2EuzU6n8MPaqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954

Add a features bitmask to struct vfio_pci_driver and define
VFIO_PCI_DRIVER_F_NO_SEND_MSI for drivers that cannot trigger MSI
interrupts via send_msi(). Drivers that lack MSI support opt-in by
setting this flag in their init() callback.

Change vfio_pci_driver_send_msi() to return int, checking the flag
internally and returning -EOPNOTSUPP when set.

Add fcntl_set_msi_nonblock(self) and update ASSERT_NO_MSI(self)
to check the flag internally.

Signed-off-by: Rubin Du <rubind@nvidia.com>
---
 .../lib/include/libvfio/vfio_pci_driver.h     |  5 ++-
 .../selftests/vfio/lib/vfio_pci_driver.c      |  6 ++-
 .../selftests/vfio/vfio_pci_driver_test.c     | 41 +++++++++++--------
 3 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
index e5ada209b1d1..f2cf2608f757 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
@@ -6,6 +6,8 @@
 
 struct vfio_pci_device;
 
+#define VFIO_PCI_DRIVER_F_NO_SEND_MSI	(1UL << 0) /* Device cannot trigger MSI */
+
 struct vfio_pci_driver_ops {
 	const char *name;
 
@@ -69,6 +71,7 @@ struct vfio_pci_driver {
 	const struct vfio_pci_driver_ops *ops;
 	bool initialized;
 	bool memcpy_in_progress;
+	unsigned long features;
 
 	/* Region to be used by the driver (e.g. for in-memory descriptors) */
 	struct dma_region region;
@@ -92,6 +95,6 @@ void vfio_pci_driver_memcpy_start(struct vfio_pci_device *device,
 				  iova_t src, iova_t dst, u64 size,
 				  u64 count);
 int vfio_pci_driver_memcpy_wait(struct vfio_pci_device *device);
-void vfio_pci_driver_send_msi(struct vfio_pci_device *device);
+int vfio_pci_driver_send_msi(struct vfio_pci_device *device);
 
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_VFIO_PCI_DRIVER_H */
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
index 6827f4a6febe..b72df578717a 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
@@ -67,13 +67,17 @@ void vfio_pci_driver_remove(struct vfio_pci_device *device)
 	driver->initialized = false;
 }
 
-void vfio_pci_driver_send_msi(struct vfio_pci_device *device)
+int vfio_pci_driver_send_msi(struct vfio_pci_device *device)
 {
 	struct vfio_pci_driver *driver = &device->driver;
 
+	if (driver->features & VFIO_PCI_DRIVER_F_NO_SEND_MSI)
+		return -EOPNOTSUPP;
+
 	VFIO_CHECK_DRIVER_OP(driver, send_msi);
 
 	driver->ops->send_msi(device);
+	return 0;
 }
 
 void vfio_pci_driver_memcpy_start(struct vfio_pci_device *device,
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index afa0480ddd9b..491ac631b108 100644
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
+	if (!(_self->device->driver.features & VFIO_PCI_DRIVER_F_NO_SEND_MSI)) \
+		fcntl_set_nonblock(_self->msi_fd);			\
+} while (0)
+
+#define ASSERT_NO_MSI(_self) do {					\
+	u64 __value;							\
+									\
+	if (_self->device->driver.features & VFIO_PCI_DRIVER_F_NO_SEND_MSI) \
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
@@ -167,15 +173,15 @@ TEST_F(vfio_pci_driver_test, memcpy_to_unmapped_iova)
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
 
-	vfio_pci_driver_send_msi(self->device);
+	if (vfio_pci_driver_send_msi(self->device))
+		SKIP(return, "Device does not support MSI\n");
 	ASSERT_EQ(8, read(self->msi_fd, &value, 8));
 	ASSERT_EQ(1, value);
 }
@@ -201,7 +207,8 @@ TEST_F(vfio_pci_driver_test, mix_and_match)
 				       self->dst_iova,
 				       self->size);
 
-		vfio_pci_driver_send_msi(self->device);
+		if (vfio_pci_driver_send_msi(self->device))
+			continue;
 		ASSERT_EQ(8, read(self->msi_fd, &value, 8));
 		ASSERT_EQ(1, value);
 	}
@@ -213,7 +220,7 @@ TEST_F_TIMEOUT(vfio_pci_driver_test, memcpy_storm, 60)
 	u64 total_size;
 	u64 count;
 
-	fcntl_set_nonblock(self->msi_fd);
+	fcntl_set_msi_nonblock(self);
 
 	/*
 	 * Perform up to 250GiB worth of DMA reads and writes across several
@@ -230,7 +237,7 @@ TEST_F_TIMEOUT(vfio_pci_driver_test, memcpy_storm, 60)
 				     self->size, count);
 
 	ASSERT_EQ(0, vfio_pci_driver_memcpy_wait(self->device));
-	ASSERT_NO_MSI(self->msi_fd);
+	ASSERT_NO_MSI(self);
 }
 
 static bool device_has_selftests_driver(const char *bdf)
-- 
2.43.0

