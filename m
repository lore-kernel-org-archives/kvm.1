Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012030.outbound.protection.outlook.com [40.93.195.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222A4346777;
	Tue, 31 Mar 2026 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977771; cv=fail; b=roJ72pAFythynLhon0PBpvH+MpiWAruPADerALrl3buNHoP+77jGOonw/G5rQt56cPr3rH5MdXYX1lPwouobjK3C9O1YyywmH3G8vH0bucR6K5oOIQNygG/ouJuecetBk4dmuENVnM8Bnozqh09SI5c4dGEy2j/8ryFIEtz6kWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977771; c=relaxed/simple;
	bh=lqcfB38/kIaeqXUnB6S7hEXb33g4vp+F+cXZETYH0nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T2wkv7mtAXVbrguUNYoVM9wnVP0qzhOgBn+OunZeqfRhf/U/6tu1FkuRDq5xrLDArZDuHdWanDelJMVJr0xWo5R9QoUxZdj7D3bmeFnvETgeLWyziRJUE3AyyPH9rxbaVKX/WZXaoxHdl68AkWttT2Sm6+Y+M0fpbUp94klbfZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iGtJr0Eu; arc=fail smtp.client-ip=40.93.195.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iGtJr0Eu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDaqXth+sEaZ6jxCOVYIwBpYg5QeWwH2LhVPDP8j0zfDzsc1a7/j6lzijbpHJ2ek7djLV9xPPSzUS3uNZ3QHhOtdXl3LBO+FDQa5p1DVinucIUQ0JTjCr3poHB5TnqMFFOl/3b7QMu+P5pqoNbgdm3lPbRZfDdYxQw2p2btIRcIkCpNDGN+elWI22nPdXC6jxXeVeAkdfO6g3apUTwH/yEHollHTM/ae9NUTlFSvdfX3vjjey+i66SIY+sVmPu7sx93CCgG87FklCyXaegi7RUNS/qgctSPFycM1/luZ3wuk3Gx4gdr2PMBWTOTiFnvPAj91EAcFoTa0tte9H+kvcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWysxOkt4vHdxN2ZNcW9w1yYiej/yUUOd5aSLpERJtk=;
 b=EQ1t0MIgdZ0NLacYn5lP5yKOGqDiNhnOFu6gYmczy6zUweuBNWzjg/J/ATnJnfnbQi94crHq+WJ+tOdkHF6rNHpYWWk3z5ujAGlza+V6BMCvIniDD7lxt1Ft0zPHcDC+KrpTqA+rSeEDjsPaqFu7Sx9xYsf1ZDzALIIl+VPs+AzoXpwCqyYHJXw67vD3kwfgkuOM4R8X2mQC9C6LmZs3JZEQe3RYiaK7tFNghHFcsA1dQ41I4c0NqCNgCikQj/cpBykgdcjnBjytJXCf0AT6ij7pnCorqpQsjbKkBjUCbjj+ymemf5LG21UWHBypDWvhFb7fCvF80EpPaSrKDkC/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWysxOkt4vHdxN2ZNcW9w1yYiej/yUUOd5aSLpERJtk=;
 b=iGtJr0EuDiRxztH/BZElRqNUDO6bSaJC7xRiQsFiW12Cnkhq4uebbrzy4SYlshFJgQ/DZHrdMkK5Mx6dBIGn/S+SHpusCWflcgKSG/k7/fGN02QkCu0ljQ0lAoJp7vHPgx5mLEZ0Ir/eJh3OAagk35+Lf1YuNE7d2jk25Msa5dPUNd+4I1noMee3+Z8rLI3hDjZ5MNf20S5KjUxAkFlWS8tY4OIoJ2pLaHY8agRBJBJa6odut4s4cQMbkEYiCQXFwwt3g68HuIoFRR2IXIDmGEdXTr+66xueRfUV6oialPNON7qubLk2XdrZqv1VZ9Yg5BUwmaBJDzgk+gQoHkELMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) by SA3PR12MB9180.namprd12.prod.outlook.com
 (2603:10b6:806:39b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 17:22:44 +0000
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7]) by SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 17:22:44 +0000
From: Rubin Du <rubind@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 1/3] selftests/vfio: Add memcpy chunking and PCI command helpers
Date: Tue, 31 Mar 2026 10:22:39 -0700
Message-ID: <20260331172241.50456-2-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331172241.50456-1-rubind@nvidia.com>
References: <20260331172241.50456-1-rubind@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0069.namprd17.prod.outlook.com
 (2603:10b6:a03:167::46) To SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF80B25317E:EE_|SA3PR12MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae0a531-f2a8-4282-b43f-08de8f4a1ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	q+MgAaCg4bexoUpymzzMK2kgZiASit8J6y/AUgkhwpYSNdx29twBA3Tl6h0wxLCuorvfbFEAlbV90tSnWeviC1IlRktsg+vD+Ufrs2LBvXIIHBz72gWes1Xn0IF/Am/RWv3qAmmKRB3JRZkCKWVnlKG+u5GkPkZnJWGZZLyIx7gFa5tVYoiTUvGkF03Jvj75Mo9wnp+++ksCRu1i+t//tMMwMbEvWUoU7I2MNGRsH5M7ILlN/EhzJ/WadKeYzyq5e6FVkxpHTi81jYakdYM9qY6+YCCshBYCtmBR9imSOPTz8gJ8/e4V2rZWrNIur8tbf4Cb4GHvbF1mn8qfs3koORICfwQGtRkJ6v6xro6Pxlu+s4Y8WrRDaWshBBn7feXmmUY991XDp77GdvewxK4g8Gz+DzetiIEkeOh2MCfIr8EVc5GPkF+6Z09pYe7ELKRC4CarrRmjDJbSPYeD3Oa1ohEtMm5+4s4fYczui8XZjr8YjCfnPXqsdF7m3+hMlG3E9JD4r4mB2d6Jum0umriGIK1nJo/Z3CzHndJiX9DJwhRQf3NNJvjli5BolF5Uobhx3sOFtM7v6zEYRa6jVKeVTxyoqwss4UWz1cU8jybUr4WJDG0PLu/jwlKMtWMbNh+1c7pxVXjMWq1empCbgYDEIhi6HHwEiucyiq0U798rR4mAf/odMnGY+9lt3+oeVG8OuEWRtfzje1fjSzbPg8dANI6JH3ZmO+kWOKHo6xE8t2o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPF80B25317E.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?azR2Kw50O4XQs+gZBZv+ao7NCzGGWpp9Vg4HDywof1F7qMWGicQnAR4bY304?=
 =?us-ascii?Q?T/CbnjDrJ0gnekehYsvqNt/ka7kK3YaHDV5CWUSapWGDAKWQSXfHVTM1y7v3?=
 =?us-ascii?Q?WVsYyAhUWU7kCmLtiCm0G3ambPX4RjX54RfHI7V/Rwkn6wzPxS2qt+F6hl01?=
 =?us-ascii?Q?NawZCWcwV5jYgDgm5cRneCiMBpUkK1ehZhniowXHgWS+sdCB+bNnCd7TMxK1?=
 =?us-ascii?Q?K5SvcreNquhWGHFJih50odXlb8WMkzzSxWOft5VTBHQbzhmtPs6uqvcX8ceC?=
 =?us-ascii?Q?N3fNkgUxR7ZtWKTYq60LHNztPQyCJdPIGnfWoEypzf2SCaY9rLmLChlCuA9B?=
 =?us-ascii?Q?l54HYCV1m+iNZlU0L03yM4oANgURbat/fnCSG1XacIxBnkV896sCdvwpEweA?=
 =?us-ascii?Q?t1jZJGusvIfrgVGYJftr1H4xQ+ulj/PBL272T7kYu9XoKP68YP2O4QhdNh8l?=
 =?us-ascii?Q?pvCsN2I/pB/zugyfms4aNssx3r+M0iRWUzOl8ZVrW3JRb8D0hQ7OF/lNX//H?=
 =?us-ascii?Q?0nmJ5GKNn3tK317jAf+krORF+ufvupfm8PiatDfqD2u7sFNl8yGT5V2lPMVl?=
 =?us-ascii?Q?On1rwlHTqvL3bFY9AIF+qmRq1rW4Y3q7JUuNRlD2ZKLFkeCIUJFOXFr+qODX?=
 =?us-ascii?Q?ZAEJ2z8n07eWF2VszbZdPPpPen3uw4C1DhBAWRCsHq7obTR7XwwJ8zpQzZXw?=
 =?us-ascii?Q?2qhDRlXbw0VWK6LAtISrBVKfGvSNV/EDGkx1+Uf68r8vOjJG2atIvkfc6yNv?=
 =?us-ascii?Q?WFWRA5UhBIP9XzizAviDiJ7uCw7/68syBgqau7Tgtna1N/qacdj6dWtIlYA2?=
 =?us-ascii?Q?rm8IyJ3jwrWKyiNQqD553aL6qEhx5OOzk/Gwcgow/C1Mmh3xyPF3JSq/iL3y?=
 =?us-ascii?Q?P+VgIaDPLtTz7Gpvx+h+OzYAEiYHS0ijL2MBCMKv56MO8jopQz0sb8+plRQC?=
 =?us-ascii?Q?2z6yJFYpvt+pSBL6YP1qzvkS2sVtUdPl03HsxrtdCzky4mqd9BoT0ghPC3Q5?=
 =?us-ascii?Q?0Kpge6lzUIY+UJjahmi65014RzFTixF1wiPIGab3HK3xT4D5ZEB5zxVBLZIy?=
 =?us-ascii?Q?PcEtvUw0/AzIHTWNvywQX86rV0Qz6vA5aO4BaVHIGItXtrmD6lhxv/dC4cSS?=
 =?us-ascii?Q?MVj2iFXsIyUIAxg0JWlB4Tv4ftmnllrpTTedDZYs5hy2rNdFUnqlnjSV+AZP?=
 =?us-ascii?Q?g5XLselnUwOpYUkGuvTXJZgIrYI+wcFupOx78UsNmOve8oKMjkZNTvthBFJg?=
 =?us-ascii?Q?cj6w65tjhY+DaF6OBOHvTZTiUYFKL8E3SKeQgorgQElaNr5mZ/umrU1jWtYC?=
 =?us-ascii?Q?2QxY3LodiIoMwZJaFXqmcQK7PSxTCLvrZDpxe6sYUm34+++Rvp1HJRomwtWh?=
 =?us-ascii?Q?9+nT8VBWEOJzPwPMeZx1ft0Q2BrgmgwIMbxa/59b5qw1pA1kEK+OwFAqOe/p?=
 =?us-ascii?Q?n7RTJPZqU0/S0Dy5lnA8J6FQjMiopqcpPY7Hu22ZdD+3TAI/WFDw3utlFTz8?=
 =?us-ascii?Q?dLcSsZLGN6P+QZOLB8mvaQzoucHUEAr6VWH9b4GNc4ZDGZXJbG9P3p0HJOWR?=
 =?us-ascii?Q?L6QGHi5LZZjGxT2IC3eMn3u0KEuaUwH/Y4gduSxlcB0SIpHQDBgFl4zCESxG?=
 =?us-ascii?Q?LTIzz9J6ZC9y/R9P8bQy4OX0Y87T4sYAcY1IVYBTpQadMgSJayBU18hWW9Wp?=
 =?us-ascii?Q?+EGNlmQK05MzcaQgNzgBGdcAu2jmPixUJ/2TemROPpllB5l3482lmpuczNY+?=
 =?us-ascii?Q?QeLwADDmTA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae0a531-f2a8-4282-b43f-08de8f4a1ed9
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF80B25317E.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 17:22:44.2966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZU2ZDoISmoNkt2cldsrQEuv7SdWq4wflj2M9i1BDmR94cWwnb3zryg9hGFacDjOezEYcf65gC99cqnnmlAVMzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9180

Add a chunking loop to vfio_pci_driver_memcpy() so that it breaks up
large memcpy requests into max_memcpy_size-sized chunks. This allows
callers to request any size without worrying about per-driver limits.
The memcpy_start()/memcpy_wait() semantics are unchanged.

Update the test to use 4x max_memcpy_size so it exercises the new
chunking path (4 iterations) while keeping execution fast for drivers
with small DMA transfer sizes.

Add generic vfio_pci_cmd_set()/vfio_pci_cmd_clear() read-modify-write
macros for PCI_COMMAND in vfio_pci_device.h.

Signed-off-by: Rubin Du <rubind@nvidia.com>
---
 .../vfio/lib/include/libvfio/vfio_pci_device.h | 10 ++++++++++
 .../selftests/vfio/lib/vfio_pci_driver.c       | 18 ++++++++++++++++--
 .../selftests/vfio/vfio_pci_driver_test.c      | 18 ++++++++++--------
 3 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2858885a89bb..d151bb94f187 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -122,4 +122,14 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
 
 const char *vfio_pci_get_cdev_path(const char *bdf);
 
+#define vfio_pci_cmd_set(_device, _bits) do {				\
+	u16 __cmd = vfio_pci_config_readw((_device), PCI_COMMAND);	\
+	vfio_pci_config_writew((_device), PCI_COMMAND, __cmd | (_bits));\
+} while (0)
+
+#define vfio_pci_cmd_clear(_device, _bits) do {				\
+	u16 __cmd = vfio_pci_config_readw((_device), PCI_COMMAND);	\
+	vfio_pci_config_writew((_device), PCI_COMMAND, __cmd & ~(_bits));\
+} while (0)
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_VFIO_PCI_DEVICE_H */
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
index afa0480ddd9b..879e9813b44a 100644
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
@@ -221,13 +221,15 @@ TEST_F_TIMEOUT(vfio_pci_driver_test, memcpy_storm, 60)
 	 * will take too long.
 	 */
 	total_size = 250UL * SZ_1G;
-	count = min(total_size / self->size, driver->max_memcpy_count);
+	count = min(total_size / driver->max_memcpy_size,
+		    driver->max_memcpy_count);
 
-	printf("Kicking off %lu memcpys of size 0x%lx\n", count, self->size);
+	printf("Kicking off %lu memcpys of size 0x%lx\n", count,
+	       driver->max_memcpy_size);
 	vfio_pci_driver_memcpy_start(self->device,
 				     self->src_iova,
 				     self->dst_iova,
-				     self->size, count);
+				     driver->max_memcpy_size, count);
 
 	ASSERT_EQ(0, vfio_pci_driver_memcpy_wait(self->device));
 	ASSERT_NO_MSI(self->msi_fd);
-- 
2.43.0

