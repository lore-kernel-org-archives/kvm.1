Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B6538F94A;
	Fri,  3 Apr 2026 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775259893; cv=fail; b=VSWztTrh/5tip7UK5XvqJgyX1yE7Lipfjnua54jo3VScLAnPNDBjS4DfXi/+TozQ+rMthQW59c1PrL0BEOkIOexhQFvx6Qq36PbthHoP6PlM0Tod82jZjl5QG6CLljjhcUo1dymvHGBwB30lfa8N8aD/6pp5UNzc10/QVTRJOc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775259893; c=relaxed/simple;
	bh=/pFl0L1rDTZZFeodRAGQnMT5bz36K4zJyYsbi2lDEqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VNHfJ83Vo4OtauWKt/WnJWTHOFkTWM3dnQs7nq+uzrh3NEkI1ECLzKmpaMupUn7Tmm9JVBfUEKHPCxvnW+HEPfbF0035Vkch20qG7zAC1mbDols/VpYV4Fus61hhjeQ3h/vv0go8/zTqZmrOKuK9oWSZTgCGajSccTSv9TT7dFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U0L1Kt1V; arc=fail smtp.client-ip=52.101.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U0L1Kt1V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sghv2GDwav6HPfyrZ/e6FV1f9imJTGjqCNGEXKzUyd2YHqwfcy0n4xJI5iE+cXzjhDV9QW6ODYawAZAYP+0VU9yb1cJ8ytOwIXbX7eeEpYMDCIKpQJ+WrFcSj9H3s5ORkQ9AFcj2wcaCekm1AdlhU/ViryMUwM0LE5G9MQe2kAIl8My+ktwzdnhgSFJ16lb+IQv9GETfuS5cX9Gxu6aChlLD7F05FkaMghqbYU9KPxCWK/qm8z+4eEPJnG0M7fT7wWB7mIGIMAUObnrTIkilb7eJ9A0s9/klQpuaVN5WrY20sMXEaDbbjc12y2jK5Ddhzg8Bb8ry0H2l22PRILQ4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqX6O2URpT3lFQu780CYL+Elq6NiiKzVPr5qAXeZKSo=;
 b=hJevDvkudEjK+YlAo1B09yF7J3pNXuk0hrx6mKQGn76J7dxQYoofsHTSd77oCeRkrXVnjoGsLMxlr5Y+uzeLfw8+5sl9c+YqOTKO0n0Ubu80tFrBsyQDfEvJnjZTnzA0ub3bJXX2u5Ie659UMOFEEwwoUk7Y0TJEOL1BoYppYoxlrMYjKVtUmrPVboiXVwjLGftNBAcytGNmCYMrSig0q32gms5ulvxCwfn26KTRDyjI3RPQmojFknoYGHksoS1qRWYniVwLuKF2hiu7rA2YEdHlj0SSrns+jppfxYJpqz9GRCLUW5FeFo7dHIVFQmbKaYEFtp2RqJhNQSwhwYEhug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqX6O2URpT3lFQu780CYL+Elq6NiiKzVPr5qAXeZKSo=;
 b=U0L1Kt1VuORmvRsLEaJ1pZmwwfulMotAkGMM+4BW0skTB9Zui9N1Y+daVfF4ZP5HDYdFrxtBhiE+6NEpJ9TIR0H6eDmT7i4htLFc6b5xQn7h1VWmVzSFb2iVe9tB7ezNK1eAyBjcPw/eO+e5AKY7VZrlP6c9/1RPtKBJSwQuBz9dmm63vNpdMa4EnAZlsLnEYmRwQ5c94ajo7pY1KcqAuxofCgwABx07AWChoesexVxe2MU/ejDM/w5Q7PubNqA3W33DjeVdtq0wJvyIR9OoOyL0IRZ1C/v7WYTmaGqsPhKQdIa21CcM4ffOG9yKTWES76JEgqkkIGuIaLNhlNEbDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) by PH0PR12MB7078.namprd12.prod.outlook.com
 (2603:10b6:510:21d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 23:44:48 +0000
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7]) by SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7%6]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 23:44:48 +0000
From: Rubin Du <rubind@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 1/4] selftests/vfio: Add memcpy chunking to vfio_pci_driver_memcpy()
Date: Fri,  3 Apr 2026 16:44:41 -0700
Message-ID: <20260403234444.350867-2-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403234444.350867-1-rubind@nvidia.com>
References: <20260403234444.350867-1-rubind@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0238.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::33) To SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF80B25317E:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 92dccc51-f8f0-42f1-36b3-08de91dafdbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kc3cT4sfAbtthi6aKhDLZHFr5HAegy5Ob9tgsIWpQvSBiKlcr1t9jII6CVzMfGpwqbLohnXkt3fd+Zxl95u4G2Wu3ZR6ExkXjO4I8yNlbc8LD/AAMatZ9Tmtqo7KYIvVX+fjEujYOVV8Fsh2OH8PL6jzQJB9MB1MpDK20PsYpBYwJF6X7pm1B03p7CSr87QOLYDQVDyXVL0x0g9AXor/Y2JpLgtdygFOOzZjGPgbAO33VjEm2r5oPfnZVyHYZaQ4MU5BOJvLfF0dko23+B6OVIymeF4pQDpCyx83niTK5LqHUpppVDzejRBd9JcjOFirMDp6FRHR3I2US2y13SH7boCI7oPOy7EnVM3OdYGF2Qk/Ksm57eXhRYKr0DFA8lBC4rXMj82CBaX05xhDy4SaDaiI+UsKLFs1TU+Dst4HUOnuVYJ7jJcwsXE+XlMMSukFuR03l8tCjkdnxtk6En611ae4w5FyBUIo1a5cT7a68wN4cDqt+wV+zscmaYufPFMPX5TUqqOWpX3LkHRy0CE0ophoLHP7nkJBZ6V6hKd/R3z7ChXt0WpHr5DtPfFz0OtZL/XFPXH4RWAbVHdEhojSspWXfXO3Kc3Q23YygIsYZTx/huBTnU6dyfL6IEXWRUX6toI7MRPtnvonJ7+j4Ol/gXnrjMp0mv2Z5jTuvdCOR+kmePA+k2X8pzBCsmJmRIluxTnyqea9g5CzhXzc/Xs8H4c+kD/cKdZ1irhYCRQWJ+k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPF80B25317E.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ZHr5xWXCAOQWDHEMeJyGyi7LTMMfKi5BIzH64AfQBeO1GHPnJukPEf9tFEy?=
 =?us-ascii?Q?d7ZHlpPdXoe2K+e5ovjYA4hq1WjCeTlzHlz4a1tn0svGfaYPAKJfKr41GuhW?=
 =?us-ascii?Q?kaHvjNFLEsfwjTPZLekToa1AGshefruzfe42JjFSH1a5wcy+xwcTsX9Gc5ND?=
 =?us-ascii?Q?f2XYtqqCS23HLumFmfNL+AE6GbD4y9FW81g37RQI0boIacvnIEY+tlN9ifGs?=
 =?us-ascii?Q?fQd9SUGtw30oC5VkrRVINUALvxvoWKI1duNuUbSEmNAuy7AeyFwM5HrxZDkg?=
 =?us-ascii?Q?ERYc52B+VGBY3Pm4trC2jVF4pTiRHkyOpRyD0sED5cGWLhspKZ/NLkkSTO1k?=
 =?us-ascii?Q?MMAYSkqKjGNW9OawrJJzMSmkDBiYm4I6V1kqq2qlVg6TtV+hmEDNoB1jlEkY?=
 =?us-ascii?Q?dksW1kIN0zMc7sNgHlp5teElqC3tKzogRan6ZW4/H/frgzUylDeR7pKtFptl?=
 =?us-ascii?Q?2dXw8IXED6Vft/w/RB0qHkSWWGGCUg5cXBcnsUWscUfvwp78Nww4+lafemdp?=
 =?us-ascii?Q?A+x3yw836UBOWUBsMT0I5n4HPnvvlK2j7mbBKuk+YTL0J3YUjjOpjjyGHlzp?=
 =?us-ascii?Q?tThRv740yCMJGF1FfYUX1nG89ieieDrBC/sCVbhBSsa9AepoPk0Rngl5exQ/?=
 =?us-ascii?Q?8DND4/UI1ZAt+/0dTAmtbhSuCcnjs+A6DvCJh1TvEDYU0aulBpR3e959L4RG?=
 =?us-ascii?Q?JLHfZsqRKxDA2EdB7cBlYnmGToVCs/uJ/yN0U2esUb+/2BofybGoNPQ3d0cx?=
 =?us-ascii?Q?8doR6ERgwY3HiovPyB0djwHgJ95ujylMd5M+mYL3OX+gwQ1abt7K9wKxcqwG?=
 =?us-ascii?Q?ucgcdRdrKLPk8ytIiNbGF9T5RtW7spM8spYUFPyuIrII8xhanwd7RHTAksjN?=
 =?us-ascii?Q?P1mvrtmPTztoFuCC3JTArg7r29amcwQukv4mNRrXoXz0teGlsl1PqZV/GCDk?=
 =?us-ascii?Q?fbfMFPpkxxW938SHnCI5QxsibDBKpe8FPYlt1ziVj/M/txtBgdeZzJSe5VV1?=
 =?us-ascii?Q?eOaaKlcU10k7YtICCTB5zXTJ2C6oGWpKQmefCMS/bE+MU7TQWSl/bTVyvz0j?=
 =?us-ascii?Q?KO9mKrDyyaygh6l2T1cLz+gatSWJH+CeS+kUtpyzVQR9RaEyQiBW2qt+UQgR?=
 =?us-ascii?Q?ypYnrKCMW7l6I8/pOZvNYCZ/nLQarkBZKyDY6hXgZJPotPChlmQE6U3f79GU?=
 =?us-ascii?Q?AQKEXVWhZeDcCvr6R0gd57kHNxeuCPRIPYOemysVh3KtUJZf17oiioV1WC5O?=
 =?us-ascii?Q?8gJBplYK/HPK+FrWwPGNLYeMFeIoFxFB3ToYsfkTMWBz0qhm8PRoMW1k8g2j?=
 =?us-ascii?Q?T5fT6dBYOu7zeH7ZVQMSP4/7P4E6ntN8PLEKbZ2esZTG46Y38g3l8FYDA0Ak?=
 =?us-ascii?Q?cHmJLViHsbe7mOsD8bmelLGbbOGl2q5G3nlJTD/oiCQ07AutZ8UUpcuTI4jo?=
 =?us-ascii?Q?/FR9Xts39zcz6/WfFgvXTpA48HE+AYv+I2rBNKpKydxulXQDTgYn6QSgokNG?=
 =?us-ascii?Q?moQyUJmHKPppWpY6kPrsn8DuEayes4pO2BupPmE6zgklOviRiDvY6Dv+fkMI?=
 =?us-ascii?Q?GD7IEOB+zEIXhY8DgFh/lRFB2nlLfrePDPTT1HNlPoJMD174hJQPp67Abuzg?=
 =?us-ascii?Q?0asOnRMdCzPhJ6/GghoWm55dB8yp7Og5J+3fx9opHoIf3dCHPmhb02HtGBjA?=
 =?us-ascii?Q?E4ulY5CM4OfzQeu59wmel0ut0ACdJmhBJfQFvReRphEynTJeg8BwJnNWzxn0?=
 =?us-ascii?Q?v00Qdg0Hwg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92dccc51-f8f0-42f1-36b3-08de91dafdbc
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF80B25317E.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 23:44:47.9901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akRznxoKnCe65p17Yocz5x2hZFh6J4useQ4drxWWbE1M3oXRyxVnFM3wdq2UvX+H3eleQozPwBKfyZHsIr1YBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078

Add a chunking loop to vfio_pci_driver_memcpy() so that it breaks up
large memcpy requests into max_memcpy_size-sized chunks. This allows
callers to request any size without worrying about per-driver limits.
The memcpy_start()/memcpy_wait() semantics are unchanged.

Update the test to use 4x max_memcpy_size so it exercises the new
chunking path (4 iterations) while keeping execution fast for drivers
with small DMA transfer sizes.

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
-- 
2.43.0

