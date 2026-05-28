Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010034.outbound.protection.outlook.com [52.101.193.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0C564
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779926852; cv=fail; b=j+pvZE3uo8FydLOhjA7rpZAyydo0rNht5RCEtc4gEX0Uj4ernB5mRYVeZqQ9ZJWMBV6hFg6fZjKWTZ0YiD2AXIGPH/JzCmoT5+1m3fUDg0iwmUk8I2m/zz2Ypb6a8Lgq/hebg5HdTyIyI7p0ha6icG+gMMLleGWOCHaKi8/k9Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779926852; c=relaxed/simple;
	bh=lKoEZ5xUHSkSgtHREkVKN3Z7FN1ReUfy1pI5hO7VK+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+l5oTU0O+K1ZDNG+bk7VMWBK9onwyjFajF3n5cyP7KY1rUXW+P+vQZuG74u3lOFI2J1Av9p+y8W5tyV1QPER72LDXL++U9iFkHGTQ+JFSBod+XIfpLMKL3NvfrO36a/jcQmrxYOvZ7CmgUZpLOETzQXDy0wE/IzNzR6yMx4MME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MGaU8gq4; arc=fail smtp.client-ip=52.101.193.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MGaU8gq4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e35ZT2ObyC+bMsIBbLAZXZpG7brVdJ+jDNPuzxQi1hu4w6U+6hIowOsQ7qwneigu60Xdk594xzvW26orhV8lcNno7VKITR7OBavBnXvWW1vrB9wWd+AIwtQYek4I7VWYIqlVTBxBGZFExwSaCDOOcwLxe5ybMzyrjHyNUgihX5671lRLpcC+nMX1qmtRLIWhB0SqVFcNflPhCzvNUmpGZoEgzDqhqJPKyzhLF/2VLrSBzqM6FGeb45s68jTQRRcqqJCggxvdxhO9MbgfdEDjAItWISsm+xjhINLnoO2uXRzJ5OF13AFfQBtyOPStyb42iVsKb9YLcG8O07WXyOXkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KReqHkkWRL9AWUz6xGPb9tSyK0s2uIkGAcALEz4xPk8=;
 b=kXVIBOV58rOaMDC0myvReLOKzGtP6U4yHQlstM9S5RjULPaFrmy90I4Z06QfQLBQSfPSQ4PAc+h1R/8Nh2oUoeAjnUY93Ol2swrJ2NUqzKjupZ4by/YxPWQZRuhjGahjvftHJ8bhpQoKKInaNs32Ins5M0d285fe3Uf+ktAY5IRmmKg0C4tfLT/UH5ODcJSll3I/sWbiv/BqpuDQZfzz2F6V5+ldaEt5lHMRWsZVlv++X1d6rZKwwbY/9c2A11PsjK9r5PJiSJTqofwa1jgTG6ypVtWx4ptYxd6JhUFUmMc7f5dXlx/OgPwZZrjjkO4iEzNBdLZgovL7pvPgRFMZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KReqHkkWRL9AWUz6xGPb9tSyK0s2uIkGAcALEz4xPk8=;
 b=MGaU8gq4ZwNfuFITprrfvTTm/QieTKyW6XlJes0urwe70uIaTOxIr7XwQKBc65ukOqvF7hUSFkiN5cA9C+Nr6F1S1Qd50KBOmH1sEhYRzRktGvo6be/rvLUfMUq0Bhc/PLJHey5x/SB1I45LIhOjyrCtg5d2ZBUR4J8MlCb3YA0=
Received: from PH5P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::9)
 by DS7PR12MB9525.namprd12.prod.outlook.com (2603:10b6:8:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 00:07:22 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:34b:cafe::a9) by PH5P222CA0002.outlook.office365.com
 (2603:10b6:510:34b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 00:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 00:07:21 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 19:07:20 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: [PATCH RFC 03/12] linux-headers: Update headers for v7 of in-place conversion kernel support
Date: Wed, 27 May 2026 19:03:28 -0500
Message-ID: <20260528000416.8161-4-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528000416.8161-1-michael.roth@amd.com>
References: <20260528000416.8161-1-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|DS7PR12MB9525:EE_
X-MS-Office365-Filtering-Correlation-Id: 0764a0ed-771c-4fff-29d5-08debc4d16c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|5023799004|56012099006|6133799003|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vGtjIvkU4J8DqnjSBgeV2V6xIgow/N8HzdYSCj/2loS3KnOxSWTMugQk7ZY5pr04/EQ8chTJq3P2r+v0LKtoSHpziPk9+2FXJgMWc1KSCR+45pBq6RS01/L1tHgzMCGLPvgs8ege5NLNHxqFg4PNIf9XCHilYFK2VuVVt8edFNNH0heKSyUcs3oq7dp9ih3YueiEva1z/VI3Tl5hYoW/Rlsse6DrMat8VPTeJH54cODMJViWj3X4YV7YZ6Y0Ou6Uv2ZjkoMcPr1nuFegPBG8Yqv6TYUjG5fEZD21M4WiP48gju4lUHBRNmiFnar/QSL0bQu0JrvjM+Tm1CrOFftZUKrnxpW7xkn2Ilwx6N+bF0KWgTQRr90YmX4oBK/J/0i2pxev2L+1GO8v85Dr7rVBLi7JW0dygIGe2CKBsyZZfUbEHqo2RLe5kSNZGXvu14jKc16j9kayecx/tE5IscIRB9+mTsRWxsXsGOzv8e5cPQJJFkc8G474AYkgUoQN5HKkrQNFLYUHeOj/g/kbWyuOhh0DrlNr0ZBH9You3aW47cUGzRD+nQ47HEiSESb6dQyXSlGhBYtiyaqTCJ0Z3P4VqNO9Io5rf4zmmbwrIIbAFbfTwndsog5teziaXAqJwlu1GjZilR6xoI7EBn+jCGTn2n+OBGXv4jWm7IB/A/eZsRaY2FbJM5H+PcuPrdKAkCYejkw8OmGQ+qv8OVtoBTUOTXH7b66WnPiKEHwW+UmbA28=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(5023799004)(56012099006)(6133799003)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	okA15mKQBbXa04ns3O7++9WhbjPnZdi4LNoZdeYC2zibPo5O25bhVE9aiM4wzTe9Z+ohYnxC84Rytk1ubAWu4ziQoj6bhpQxpcLzbTzR/sVbAw39kVFjBAfKgBMCn7WhTYLhwoXqL2fSGUs4QdQL95xCZv0MbukMTxUbmiGbpGK2KRu2Wp0H4Xmy0p/g1SD7GoRnQErsSD+74HYoiGXiDvnLrWslMNxCNHrQ8uno+5fWUI+fuF51fIVN+/t2Xv0ogUjoOI5yxgs98JLGcgdnY+zeO8qG9e+GlL0he5ahkb3KfglE85TKY7R0t/FrxatsRI6TmBia5NV4IVVeFIgoiuAggZMMDfc0p7GNKikncCErLa0Od3ITnD927K+WyU58TvgZvA5lbL0jUJbdN7zVRqiTT9wJ1Q2HW2VwClDBzbcksihAX5PsKhAV+3EA0Ag9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 00:07:21.3273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0764a0ed-771c-4fff-29d5-08debc4d16c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9525

This will also pull in kernel 7.1.0-rc2 definitions.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 include/standard-headers/drm/drm_fourcc.h     |  28 +-
 include/standard-headers/linux/const.h        |  18 +
 include/standard-headers/linux/ethtool.h      |  28 +-
 .../linux/input-event-codes.h                 |  13 +
 include/standard-headers/linux/pci_regs.h     |  71 ++-
 include/standard-headers/linux/typelimits.h   |   8 +
 include/standard-headers/linux/virtio_ring.h  |   5 +-
 include/standard-headers/linux/virtio_rtc.h   | 237 ++++++++++
 include/standard-headers/linux/vmclock-abi.h  |  20 +
 linux-headers/asm-arm64/kvm.h                 |   1 +
 linux-headers/asm-arm64/unistd_64.h           |   1 +
 linux-headers/asm-generic/unistd.h            |   5 +-
 linux-headers/asm-loongarch/kvm.h             |   5 +
 linux-headers/asm-loongarch/kvm_para.h        |   1 +
 linux-headers/asm-loongarch/unistd_64.h       |   2 +
 linux-headers/asm-mips/unistd_n32.h           |   1 +
 linux-headers/asm-mips/unistd_n64.h           |   1 +
 linux-headers/asm-mips/unistd_o32.h           |   1 +
 linux-headers/asm-powerpc/unistd_32.h         |   1 +
 linux-headers/asm-powerpc/unistd_64.h         |   1 +
 linux-headers/asm-riscv/kvm.h                 |  11 +-
 linux-headers/asm-riscv/ptrace.h              |  37 ++
 linux-headers/asm-riscv/unistd_32.h           |   1 +
 linux-headers/asm-riscv/unistd_64.h           |   1 +
 linux-headers/asm-s390/unistd_32.h            | 446 ------------------
 linux-headers/asm-s390/unistd_64.h            |   1 +
 linux-headers/asm-x86/kvm.h                   |  21 +-
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/const.h                   |  18 +
 linux-headers/linux/iommufd.h                 |  48 ++
 linux-headers/linux/kvm.h                     |  62 ++-
 linux-headers/linux/mshv.h                    |   4 +-
 linux-headers/linux/psp-sev.h                 |   2 +-
 linux-headers/linux/stddef.h                  |   4 +
 linux-headers/linux/vduse.h                   |  85 +++-
 linux-headers/linux/vfio.h                    |  30 +-
 38 files changed, 729 insertions(+), 493 deletions(-)
 create mode 100644 include/standard-headers/linux/typelimits.h
 create mode 100644 include/standard-headers/linux/virtio_rtc.h
 delete mode 100644 linux-headers/asm-s390/unistd_32.h

diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-headers/drm/drm_fourcc.h
index b39e197cc7..4bad457cc2 100644
--- a/include/standard-headers/drm/drm_fourcc.h
+++ b/include/standard-headers/drm/drm_fourcc.h
@@ -400,8 +400,8 @@ extern "C" {
  * implementation can multiply the values by 2^6=64. For that reason the padding
  * must only contain zeros.
  * index 0 = Y plane, [15:0] z:Y [6:10] little endian
- * index 1 = Cr plane, [15:0] z:Cr [6:10] little endian
- * index 2 = Cb plane, [15:0] z:Cb [6:10] little endian
+ * index 1 = Cb plane, [15:0] z:Cb [6:10] little endian
+ * index 2 = Cr plane, [15:0] z:Cr [6:10] little endian
  */
 #define DRM_FORMAT_S010	fourcc_code('S', '0', '1', '0') /* 2x2 subsampled Cb (1) and Cr (2) planes 10 bits per channel */
 #define DRM_FORMAT_S210	fourcc_code('S', '2', '1', '0') /* 2x1 subsampled Cb (1) and Cr (2) planes 10 bits per channel */
@@ -413,8 +413,8 @@ extern "C" {
  * implementation can multiply the values by 2^4=16. For that reason the padding
  * must only contain zeros.
  * index 0 = Y plane, [15:0] z:Y [4:12] little endian
- * index 1 = Cr plane, [15:0] z:Cr [4:12] little endian
- * index 2 = Cb plane, [15:0] z:Cb [4:12] little endian
+ * index 1 = Cb plane, [15:0] z:Cb [4:12] little endian
+ * index 2 = Cr plane, [15:0] z:Cr [4:12] little endian
  */
 #define DRM_FORMAT_S012	fourcc_code('S', '0', '1', '2') /* 2x2 subsampled Cb (1) and Cr (2) planes 12 bits per channel */
 #define DRM_FORMAT_S212	fourcc_code('S', '2', '1', '2') /* 2x1 subsampled Cb (1) and Cr (2) planes 12 bits per channel */
@@ -423,8 +423,8 @@ extern "C" {
 /*
  * 3 plane YCbCr
  * index 0 = Y plane, [15:0] Y little endian
- * index 1 = Cr plane, [15:0] Cr little endian
- * index 2 = Cb plane, [15:0] Cb little endian
+ * index 1 = Cb plane, [15:0] Cb little endian
+ * index 2 = Cr plane, [15:0] Cr little endian
  */
 #define DRM_FORMAT_S016	fourcc_code('S', '0', '1', '6') /* 2x2 subsampled Cb (1) and Cr (2) planes 16 bits per channel */
 #define DRM_FORMAT_S216	fourcc_code('S', '2', '1', '6') /* 2x1 subsampled Cb (1) and Cr (2) planes 16 bits per channel */
@@ -1421,6 +1421,22 @@ drm_fourcc_canonicalize_nvidia_format_mod(uint64_t modifier)
 #define DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED \
 	DRM_FORMAT_MOD_ARM_CODE(DRM_FORMAT_MOD_ARM_TYPE_MISC, 1ULL)
 
+/*
+ * ARM 64k interleaved modifier
+ *
+ * This is used by ARM Mali v10+ GPUs. With this modifier, the plane is divided
+ * into 64k byte 1:1 or 2:1 -sided tiles. The 64k tiles are laid out linearly.
+ * Each 64k tile is divided into blocks of 16x16 texel blocks, which are
+ * themselves laid out linearly within a 64k tile. Then within each 16x16
+ * block, texel blocks are laid out according to U order, similar to
+ * 16X16_BLOCK_U_INTERLEAVED.
+ *
+ * Note that unlike 16X16_BLOCK_U_INTERLEAVED, the layout does not change
+ * depending on whether a format is compressed or not.
+ */
+#define DRM_FORMAT_MOD_ARM_INTERLEAVED_64K \
+	DRM_FORMAT_MOD_ARM_CODE(DRM_FORMAT_MOD_ARM_TYPE_MISC, 2ULL)
+
 /*
  * Allwinner tiled modifier
  *
diff --git a/include/standard-headers/linux/const.h b/include/standard-headers/linux/const.h
index 95ede23342..c6a9d0c983 100644
--- a/include/standard-headers/linux/const.h
+++ b/include/standard-headers/linux/const.h
@@ -50,4 +50,22 @@
 
 #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 
+/*
+ * Divide positive or negative dividend by positive or negative divisor
+ * and round to closest integer. Result is undefined for negative
+ * divisors if the dividend variable type is unsigned and for negative
+ * dividends if the divisor variable type is unsigned.
+ */
+#define __KERNEL_DIV_ROUND_CLOSEST(x, divisor)		\
+({							\
+	__typeof__(x) __x = x;				\
+	__typeof__(divisor) __d = divisor;		\
+							\
+	(((__typeof__(x))-1) > 0 ||			\
+	 ((__typeof__(divisor))-1) > 0 ||		\
+	 (((__x) > 0) == ((__d) > 0))) ?		\
+		(((__x) + ((__d) / 2)) / (__d)) :	\
+		(((__x) - ((__d) / 2)) / (__d));	\
+})
+
 #endif /* _LINUX_CONST_H */
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index d0f7a63f10..5d82126cd7 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -17,11 +17,10 @@
 #include "net/eth.h"
 
 #include "standard-headers/linux/const.h"
+#include "standard-headers/linux/typelimits.h"
 #include "standard-headers/linux/types.h"
 #include "standard-headers/linux/if_ether.h"
 
-#include <limits.h> /* for INT_MAX */
-
 /* All structures exposed to userland should be defined such that they
  * have the same layout for 32-bit and 64-bit userland.
  */
@@ -228,7 +227,7 @@ enum tunable_id {
 	ETHTOOL_ID_UNSPEC,
 	ETHTOOL_RX_COPYBREAK,
 	ETHTOOL_TX_COPYBREAK,
-	ETHTOOL_PFC_PREVENTION_TOUT, /* timeout in msecs */
+	ETHTOOL_PFC_PREVENTION_TOUT, /* both pause and pfc, see man ethtool */
 	ETHTOOL_TX_COPYBREAK_BUF_SIZE,
 	/*
 	 * Add your fresh new tunable attribute above and remember to update
@@ -603,6 +602,8 @@ enum ethtool_link_ext_state {
 	ETHTOOL_LINK_EXT_STATE_POWER_BUDGET_EXCEEDED,
 	ETHTOOL_LINK_EXT_STATE_OVERHEAT,
 	ETHTOOL_LINK_EXT_STATE_MODULE,
+	ETHTOOL_LINK_EXT_STATE_OTP_SPEED_VIOLATION,
+	ETHTOOL_LINK_EXT_STATE_BMC_REQUEST_DOWN,
 };
 
 /* More information in addition to ETHTOOL_LINK_EXT_STATE_AUTONEG. */
@@ -1094,13 +1095,20 @@ enum ethtool_module_fw_flash_status {
  * struct ethtool_gstrings - string set for data tagging
  * @cmd: Command number = %ETHTOOL_GSTRINGS
  * @string_set: String set ID; one of &enum ethtool_stringset
- * @len: On return, the number of strings in the string set
+ * @len: Number of strings in the string set
  * @data: Buffer for strings.  Each string is null-padded to a size of
  *	%ETH_GSTRING_LEN.
  *
  * Users must use %ETHTOOL_GSSET_INFO to find the number of strings in
  * the string set.  They must allocate a buffer of the appropriate
  * size immediately following this structure.
+ *
+ * Setting @len on input is optional (though preferred), but must be zeroed
+ * otherwise.
+ * When set, @len will return the requested count if it matches the actual
+ * count; otherwise, it will be zero.
+ * This prevents issues when the number of strings is different than the
+ * userspace allocation.
  */
 struct ethtool_gstrings {
 	uint32_t	cmd;
@@ -1177,13 +1185,20 @@ struct ethtool_test {
 /**
  * struct ethtool_stats - device-specific statistics
  * @cmd: Command number = %ETHTOOL_GSTATS
- * @n_stats: On return, the number of statistics
+ * @n_stats: Number of statistics
  * @data: Array of statistics
  *
  * Users must use %ETHTOOL_GSSET_INFO or %ETHTOOL_GDRVINFO to find the
  * number of statistics that will be returned.  They must allocate a
  * buffer of the appropriate size (8 * number of statistics)
  * immediately following this structure.
+ *
+ * Setting @n_stats on input is optional (though preferred), but must be zeroed
+ * otherwise.
+ * When set, @n_stats will return the requested count if it matches the actual
+ * count; otherwise, it will be zero.
+ * This prevents issues when the number of stats is different than the
+ * userspace allocation.
  */
 struct ethtool_stats {
 	uint32_t	cmd;
@@ -2190,6 +2205,7 @@ enum ethtool_link_mode_bit_indices {
 #define SPEED_40000		40000
 #define SPEED_50000		50000
 #define SPEED_56000		56000
+#define SPEED_80000		80000
 #define SPEED_100000		100000
 #define SPEED_200000		200000
 #define SPEED_400000		400000
@@ -2200,7 +2216,7 @@ enum ethtool_link_mode_bit_indices {
 
 static inline int ethtool_validate_speed(uint32_t speed)
 {
-	return speed <= INT_MAX || speed == (uint32_t)SPEED_UNKNOWN;
+	return speed <= __KERNEL_INT_MAX || speed == (uint32_t)SPEED_UNKNOWN;
 }
 
 /* Duplex, half or full. */
diff --git a/include/standard-headers/linux/input-event-codes.h b/include/standard-headers/linux/input-event-codes.h
index ede79c6ae4..dd7c986106 100644
--- a/include/standard-headers/linux/input-event-codes.h
+++ b/include/standard-headers/linux/input-event-codes.h
@@ -643,6 +643,10 @@
 #define KEY_EPRIVACY_SCREEN_ON		0x252
 #define KEY_EPRIVACY_SCREEN_OFF		0x253
 
+#define KEY_ACTION_ON_SELECTION		0x254	/* AL Action on Selection (HUTRR119) */
+#define KEY_CONTEXTUAL_INSERT		0x255	/* AL Contextual Insertion (HUTRR119) */
+#define KEY_CONTEXTUAL_QUERY		0x256	/* AL Contextual Query (HUTRR119) */
+
 #define KEY_KBDINPUTASSIST_PREV		0x260
 #define KEY_KBDINPUTASSIST_NEXT		0x261
 #define KEY_KBDINPUTASSIST_PREVGROUP		0x262
@@ -891,6 +895,7 @@
 
 #define ABS_VOLUME		0x20
 #define ABS_PROFILE		0x21
+#define ABS_SND_PROFILE		0x22
 
 #define ABS_MISC		0x28
 
@@ -1000,4 +1005,12 @@
 #define SND_MAX			0x07
 #define SND_CNT			(SND_MAX+1)
 
+/*
+ * ABS_SND_PROFILE values
+ */
+
+#define SND_PROFILE_SILENT	0x00
+#define SND_PROFILE_VIBRATE	0x01
+#define SND_PROFILE_RING	0x02
+
 #endif
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index 3add74ae25..14f634ab93 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -132,6 +132,11 @@
 #define PCI_SECONDARY_BUS	0x19	/* Secondary bus number */
 #define PCI_SUBORDINATE_BUS	0x1a	/* Highest bus number behind the bridge */
 #define PCI_SEC_LATENCY_TIMER	0x1b	/* Latency timer for secondary interface */
+/* Masks for dword-sized processing of Bus Number and Sec Latency Timer fields */
+#define  PCI_PRIMARY_BUS_MASK		0x000000ff
+#define  PCI_SECONDARY_BUS_MASK		0x0000ff00
+#define  PCI_SUBORDINATE_BUS_MASK	0x00ff0000
+#define  PCI_SEC_LATENCY_TIMER_MASK	0xff000000
 #define PCI_IO_BASE		0x1c	/* I/O range behind the bridge */
 #define PCI_IO_LIMIT		0x1d
 #define  PCI_IO_RANGE_TYPE_MASK	0x0fUL	/* I/O bridging type */
@@ -707,7 +712,7 @@
 #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
 #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
 #define  PCI_EXP_LNKSTA2_FLIT		0x0400 /* Flit Mode Status */
-#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x32	/* end of v2 EPs w/ link */
+#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x34	/* end of v2 EPs w/ link */
 #define PCI_EXP_SLTCAP2		0x34	/* Slot Capabilities 2 */
 #define  PCI_EXP_SLTCAP2_IBPD	0x00000001 /* In-band PD Disable Supported */
 #define PCI_EXP_SLTCTL2		0x38	/* Slot Control 2 */
@@ -1253,11 +1258,6 @@
 #define PCI_DEV3_STA		0x0c	/* Device 3 Status Register */
 #define  PCI_DEV3_STA_SEGMENT	0x8	/* Segment Captured (end-to-end flit-mode detected) */
 
-/* Compute Express Link (CXL r3.1, sec 8.1.5) */
-#define PCI_DVSEC_CXL_PORT				3
-#define PCI_DVSEC_CXL_PORT_CTL				0x0c
-#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
-
 /* Integrity and Data Encryption Extended Capability */
 #define PCI_IDE_CAP			0x04
 #define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
@@ -1338,4 +1338,63 @@
 #define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
 #define PCI_IDE_SEL_BLOCK_SIZE(nr_assoc)  (20 + PCI_IDE_SEL_ADDR_BLOCK_SIZE * (nr_assoc))
 
+/*
+ * Compute Express Link (CXL r4.0, sec 8.1)
+ *
+ * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
+ * is "disconnected" (CXL r4.0, sec 9.12.3). Re-enumerate these
+ * registers on downstream link-up events.
+ */
+
+/* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
+#define PCI_DVSEC_CXL_DEVICE				0
+#define  PCI_DVSEC_CXL_CAP				0xA
+#define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
+#define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
+#define  PCI_DVSEC_CXL_CTRL				0xC
+#define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
+#define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
+#define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
+#define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
+#define   PCI_DVSEC_CXL_MEM_ACTIVE			_BITUL(1)
+#define   PCI_DVSEC_CXL_MEM_SIZE_LOW			__GENMASK(31, 28)
+#define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)		(0x20 + (i * 0x10))
+#define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)		(0x24 + (i * 0x10))
+#define   PCI_DVSEC_CXL_MEM_BASE_LOW			__GENMASK(31, 28)
+
+#define CXL_DVSEC_RANGE_MAX				2
+
+/* CXL r4.0, 8.1.4: Non-CXL Function Map DVSEC */
+#define PCI_DVSEC_CXL_FUNCTION_MAP			2
+
+/* CXL r4.0, 8.1.5: Extensions DVSEC for Ports */
+#define PCI_DVSEC_CXL_PORT				3
+#define  PCI_DVSEC_CXL_PORT_CTL				0x0c
+#define   PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
+
+/* CXL r4.0, 8.1.6: GPF DVSEC for CXL Port */
+#define PCI_DVSEC_CXL_PORT_GPF				4
+#define  PCI_DVSEC_CXL_PORT_GPF_PHASE_1_CONTROL		0x0C
+#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_BASE	__GENMASK(3, 0)
+#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_SCALE	__GENMASK(11, 8)
+#define  PCI_DVSEC_CXL_PORT_GPF_PHASE_2_CONTROL		0xE
+#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_BASE	__GENMASK(3, 0)
+#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_SCALE	__GENMASK(11, 8)
+
+/* CXL r4.0, 8.1.7: GPF DVSEC for CXL Device */
+#define PCI_DVSEC_CXL_DEVICE_GPF			5
+
+/* CXL r4.0, 8.1.8: Flex Bus DVSEC */
+#define PCI_DVSEC_CXL_FLEXBUS_PORT			7
+#define  PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS		0xE
+#define   PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_CACHE	_BITUL(0)
+#define   PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_MEM		_BITUL(2)
+
+/* CXL r4.0, 8.1.9: Register Locator DVSEC */
+#define PCI_DVSEC_CXL_REG_LOCATOR			8
+#define  PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1		0xC
+#define   PCI_DVSEC_CXL_REG_LOCATOR_BIR			__GENMASK(2, 0)
+#define   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID		__GENMASK(15, 8)
+#define   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW	__GENMASK(31, 16)
+
 #endif /* LINUX_PCI_REGS_H */
diff --git a/include/standard-headers/linux/typelimits.h b/include/standard-headers/linux/typelimits.h
new file mode 100644
index 0000000000..1304520082
--- /dev/null
+++ b/include/standard-headers/linux/typelimits.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_TYPELIMITS_H
+#define _LINUX_TYPELIMITS_H
+
+#define __KERNEL_INT_MAX ((int)(~0U >> 1))
+#define __KERNEL_INT_MIN (-__KERNEL_INT_MAX - 1)
+
+#endif /* _LINUX_TYPELIMITS_H */
diff --git a/include/standard-headers/linux/virtio_ring.h b/include/standard-headers/linux/virtio_ring.h
index 22f6eb8ca7..a0f73a1c7b 100644
--- a/include/standard-headers/linux/virtio_ring.h
+++ b/include/standard-headers/linux/virtio_ring.h
@@ -1,5 +1,7 @@
 #ifndef _LINUX_VIRTIO_RING_H
 #define _LINUX_VIRTIO_RING_H
+
+#define VIRTIO_RING_NO_LEGACY
 /* An interface for efficient virtio implementation, currently for use by KVM,
  * but hopefully others soon.  Do NOT change this since it will
  * break existing servers and clients.
@@ -31,7 +33,6 @@
  * SUCH DAMAGE.
  *
  * Copyright Rusty Russell IBM Corporation 2007. */
-#include <stdint.h>
 #include "standard-headers/linux/types.h"
 #include "standard-headers/linux/virtio_types.h"
 
@@ -200,7 +201,7 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
 	vr->num = num;
 	vr->desc = p;
 	vr->avail = (struct vring_avail *)((char *)p + num * sizeof(struct vring_desc));
-	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
+	vr->used = (void *)(((unsigned long)&vr->avail->ring[num] + sizeof(__virtio16)
 		+ align-1) & ~(align - 1));
 }
 
diff --git a/include/standard-headers/linux/virtio_rtc.h b/include/standard-headers/linux/virtio_rtc.h
new file mode 100644
index 0000000000..7e2c21ebff
--- /dev/null
+++ b/include/standard-headers/linux/virtio_rtc.h
@@ -0,0 +1,237 @@
+/* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * Copyright (C) 2022-2024 OpenSynergy GmbH
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _LINUX_VIRTIO_RTC_H
+#define _LINUX_VIRTIO_RTC_H
+
+#include "standard-headers/linux/types.h"
+
+/* alarm feature */
+#define VIRTIO_RTC_F_ALARM	0
+
+/* read request message types */
+
+#define VIRTIO_RTC_REQ_READ			0x0001
+#define VIRTIO_RTC_REQ_READ_CROSS		0x0002
+
+/* control request message types */
+
+#define VIRTIO_RTC_REQ_CFG			0x1000
+#define VIRTIO_RTC_REQ_CLOCK_CAP		0x1001
+#define VIRTIO_RTC_REQ_CROSS_CAP		0x1002
+#define VIRTIO_RTC_REQ_READ_ALARM		0x1003
+#define VIRTIO_RTC_REQ_SET_ALARM		0x1004
+#define VIRTIO_RTC_REQ_SET_ALARM_ENABLED	0x1005
+
+/* alarmq message types */
+
+#define VIRTIO_RTC_NOTIF_ALARM			0x2000
+
+/* Message headers */
+
+/** common request header */
+struct virtio_rtc_req_head {
+	uint16_t msg_type;
+	uint8_t reserved[6];
+};
+
+/** common response header */
+struct virtio_rtc_resp_head {
+#define VIRTIO_RTC_S_OK			0
+#define VIRTIO_RTC_S_EOPNOTSUPP		2
+#define VIRTIO_RTC_S_ENODEV		3
+#define VIRTIO_RTC_S_EINVAL		4
+#define VIRTIO_RTC_S_EIO		5
+	uint8_t status;
+	uint8_t reserved[7];
+};
+
+/** common notification header */
+struct virtio_rtc_notif_head {
+	uint16_t msg_type;
+	uint8_t reserved[6];
+};
+
+/* read requests */
+
+/* VIRTIO_RTC_REQ_READ message */
+
+struct virtio_rtc_req_read {
+	struct virtio_rtc_req_head head;
+	uint16_t clock_id;
+	uint8_t reserved[6];
+};
+
+struct virtio_rtc_resp_read {
+	struct virtio_rtc_resp_head head;
+	uint64_t clock_reading;
+};
+
+/* VIRTIO_RTC_REQ_READ_CROSS message */
+
+struct virtio_rtc_req_read_cross {
+	struct virtio_rtc_req_head head;
+	uint16_t clock_id;
+/* Arm Generic Timer Counter-timer Virtual Count Register (CNTVCT_EL0) */
+#define VIRTIO_RTC_COUNTER_ARM_VCT	0
+/* x86 Time-Stamp Counter */
+#define VIRTIO_RTC_COUNTER_X86_TSC	1
+/* Invalid */
+#define VIRTIO_RTC_COUNTER_INVALID	0xFF
+	uint8_t hw_counter;
+	uint8_t reserved[5];
+};
+
+struct virtio_rtc_resp_read_cross {
+	struct virtio_rtc_resp_head head;
+	uint64_t clock_reading;
+	uint64_t counter_cycles;
+};
+
+/* control requests */
+
+/* VIRTIO_RTC_REQ_CFG message */
+
+struct virtio_rtc_req_cfg {
+	struct virtio_rtc_req_head head;
+	/* no request params */
+};
+
+struct virtio_rtc_resp_cfg {
+	struct virtio_rtc_resp_head head;
+	/** # of clocks -> clock ids < num_clocks are valid */
+	uint16_t num_clocks;
+	uint8_t reserved[6];
+};
+
+/* VIRTIO_RTC_REQ_CLOCK_CAP message */
+
+struct virtio_rtc_req_clock_cap {
+	struct virtio_rtc_req_head head;
+	uint16_t clock_id;
+	uint8_t reserved[6];
+};
+
+struct virtio_rtc_resp_clock_cap {
+	struct virtio_rtc_resp_head head;
+#define VIRTIO_RTC_CLOCK_UTC			0
+#define VIRTIO_RTC_CLOCK_TAI			1
+#define VIRTIO_RTC_CLOCK_MONOTONIC		2
+#define VIRTIO_RTC_CLOCK_UTC_SMEARED		3
+#define VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED	4
+	uint8_t type;
+#define VIRTIO_RTC_SMEAR_UNSPECIFIED	0
+#define VIRTIO_RTC_SMEAR_NOON_LINEAR	1
+#define VIRTIO_RTC_SMEAR_UTC_SLS	2
+	uint8_t leap_second_smearing;
+#define VIRTIO_RTC_FLAG_ALARM_CAP		(1 << 0)
+	uint8_t flags;
+	uint8_t reserved[5];
+};
+
+/* VIRTIO_RTC_REQ_CROSS_CAP message */
+
+struct virtio_rtc_req_cross_cap {
+	struct virtio_rtc_req_head head;
+	uint16_t clock_id;
+	uint8_t hw_counter;
+	uint8_t reserved[5];
+};
+
+struct virtio_rtc_resp_cross_cap {
+	struct virtio_rtc_resp_head head;
+#define VIRTIO_RTC_FLAG_CROSS_CAP	(1 << 0)
+	uint8_t flags;
+	uint8_t reserved[7];
+};
+
+/* VIRTIO_RTC_REQ_READ_ALARM message */
+
+struct virtio_rtc_req_read_alarm {
+	struct virtio_rtc_req_head head;
+	uint16_t clock_id;
+	uint8_t reserved[6];
+};
+
+struct virtio_rtc_resp_read_alarm {
+	struct virtio_rtc_resp_head head;
+	uint64_t alarm_time;
+#define VIRTIO_RTC_FLAG_ALARM_ENABLED	(1 << 0)
+	uint8_t flags;
+	uint8_t reserved[7];
+};
+
+/* VIRTIO_RTC_REQ_SET_ALARM message */
+
+struct virtio_rtc_req_set_alarm {
+	struct virtio_rtc_req_head head;
+	uint64_t alarm_time;
+	uint16_t clock_id;
+	/* flag VIRTIO_RTC_FLAG_ALARM_ENABLED */
+	uint8_t flags;
+	uint8_t reserved[5];
+};
+
+struct virtio_rtc_resp_set_alarm {
+	struct virtio_rtc_resp_head head;
+	/* no response params */
+};
+
+/* VIRTIO_RTC_REQ_SET_ALARM_ENABLED message */
+
+struct virtio_rtc_req_set_alarm_enabled {
+	struct virtio_rtc_req_head head;
+	uint16_t clock_id;
+	/* flag VIRTIO_RTC_ALARM_ENABLED */
+	uint8_t flags;
+	uint8_t reserved[5];
+};
+
+struct virtio_rtc_resp_set_alarm_enabled {
+	struct virtio_rtc_resp_head head;
+	/* no response params */
+};
+
+/** Union of request types for requestq */
+union virtio_rtc_req_requestq {
+	struct virtio_rtc_req_read read;
+	struct virtio_rtc_req_read_cross read_cross;
+	struct virtio_rtc_req_cfg cfg;
+	struct virtio_rtc_req_clock_cap clock_cap;
+	struct virtio_rtc_req_cross_cap cross_cap;
+	struct virtio_rtc_req_read_alarm read_alarm;
+	struct virtio_rtc_req_set_alarm set_alarm;
+	struct virtio_rtc_req_set_alarm_enabled set_alarm_enabled;
+};
+
+/** Union of response types for requestq */
+union virtio_rtc_resp_requestq {
+	struct virtio_rtc_resp_read read;
+	struct virtio_rtc_resp_read_cross read_cross;
+	struct virtio_rtc_resp_cfg cfg;
+	struct virtio_rtc_resp_clock_cap clock_cap;
+	struct virtio_rtc_resp_cross_cap cross_cap;
+	struct virtio_rtc_resp_read_alarm read_alarm;
+	struct virtio_rtc_resp_set_alarm set_alarm;
+	struct virtio_rtc_resp_set_alarm_enabled set_alarm_enabled;
+};
+
+/* alarmq notifications */
+
+/* VIRTIO_RTC_NOTIF_ALARM notification */
+
+struct virtio_rtc_notif_alarm {
+	struct virtio_rtc_notif_head head;
+	uint16_t clock_id;
+	uint8_t reserved[6];
+};
+
+/** Union of notification types for alarmq */
+union virtio_rtc_notif_alarmq {
+	struct virtio_rtc_notif_alarm alarm;
+};
+
+#endif /* _LINUX_VIRTIO_RTC_H */
diff --git a/include/standard-headers/linux/vmclock-abi.h b/include/standard-headers/linux/vmclock-abi.h
index 15b0316cb4..fe824badc0 100644
--- a/include/standard-headers/linux/vmclock-abi.h
+++ b/include/standard-headers/linux/vmclock-abi.h
@@ -115,6 +115,17 @@ struct vmclock_abi {
 	 * bit again after the update, using the about-to-be-valid fields.
 	 */
 #define VMCLOCK_FLAG_TIME_MONOTONIC		(1 << 7)
+	/*
+	 * If the VM_GEN_COUNTER_PRESENT flag is set, the hypervisor will
+	 * bump the vm_generation_counter field every time the guest is
+	 * loaded from some save state (restored from a snapshot).
+	 */
+#define VMCLOCK_FLAG_VM_GEN_COUNTER_PRESENT     (1 << 8)
+	/*
+	 * If the NOTIFICATION_PRESENT flag is set, the hypervisor will send
+	 * a notification every time it updates seq_count to a new even number.
+	 */
+#define VMCLOCK_FLAG_NOTIFICATION_PRESENT       (1 << 9)
 
 	uint8_t pad[2];
 	uint8_t clock_status;
@@ -177,6 +188,15 @@ struct vmclock_abi {
 	uint64_t time_frac_sec;		/* Units of 1/2^64 of a second */
 	uint64_t time_esterror_nanosec;
 	uint64_t time_maxerror_nanosec;
+
+	/*
+	 * This field changes to another non-repeating value when the guest
+	 * has been loaded from a snapshot. In addition to handling a
+	 * disruption in time (which will also be signalled through the
+	 * disruption_marker field), a guest may wish to discard UUIDs,
+	 * reset network connections, reseed entropy, etc.
+	 */
+	uint64_t vm_generation_counter;
 };
 
 #endif /*  __VMCLOCK_ABI_H__ */
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 46ffbddab5..6aefe79738 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -416,6 +416,7 @@ enum {
 #define   KVM_DEV_ARM_ITS_RESTORE_TABLES        2
 #define   KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES	3
 #define   KVM_DEV_ARM_ITS_CTRL_RESET		4
+#define   KVM_DEV_ARM_VGIC_USERSPACE_PPIS	5
 
 /* Device Control API on vcpu fd */
 #define KVM_ARM_VCPU_PMU_V3_CTRL	0
diff --git a/linux-headers/asm-arm64/unistd_64.h b/linux-headers/asm-arm64/unistd_64.h
index 1ef9c40813..70b3754a42 100644
--- a/linux-headers/asm-arm64/unistd_64.h
+++ b/linux-headers/asm-arm64/unistd_64.h
@@ -327,6 +327,7 @@
 #define __NR_file_getattr 468
 #define __NR_file_setattr 469
 #define __NR_listns 470
+#define __NR_rseq_slice_yield 471
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic/unistd.h
index 942370b3f5..a627acc8fb 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -860,8 +860,11 @@ __SYSCALL(__NR_file_setattr, sys_file_setattr)
 #define __NR_listns 470
 __SYSCALL(__NR_listns, sys_listns)
 
+#define __NR_rseq_slice_yield 471
+__SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
+
 #undef __NR_syscalls
-#define __NR_syscalls 471
+#define __NR_syscalls 472
 
 /*
  * 32 bit systems traditionally used different
diff --git a/linux-headers/asm-loongarch/kvm.h b/linux-headers/asm-loongarch/kvm.h
index de6c3f18e4..cd0b5c11ca 100644
--- a/linux-headers/asm-loongarch/kvm.h
+++ b/linux-headers/asm-loongarch/kvm.h
@@ -105,6 +105,7 @@ struct kvm_fpu {
 #define  KVM_LOONGARCH_VM_FEAT_PV_STEALTIME	7
 #define  KVM_LOONGARCH_VM_FEAT_PTW		8
 #define  KVM_LOONGARCH_VM_FEAT_MSGINT		9
+#define  KVM_LOONGARCH_VM_FEAT_PV_PREEMPT	10
 
 /* Device Control API on vcpu fd */
 #define KVM_LOONGARCH_VCPU_CPUCFG	0
@@ -154,4 +155,8 @@ struct kvm_iocsr_entry {
 #define KVM_DEV_LOONGARCH_PCH_PIC_GRP_CTRL	        0x40000006
 #define KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT	        0
 
+#define KVM_DEV_LOONGARCH_DMSINTC_GRP_CTRL		0x40000007
+#define KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_BASE		0x0
+#define KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_SIZE		0x1
+
 #endif /* __UAPI_ASM_LOONGARCH_KVM_H */
diff --git a/linux-headers/asm-loongarch/kvm_para.h b/linux-headers/asm-loongarch/kvm_para.h
index fd7f40713d..3fd87a096b 100644
--- a/linux-headers/asm-loongarch/kvm_para.h
+++ b/linux-headers/asm-loongarch/kvm_para.h
@@ -15,6 +15,7 @@
 #define CPUCFG_KVM_FEATURE		(CPUCFG_KVM_BASE + 4)
 #define  KVM_FEATURE_IPI		1
 #define  KVM_FEATURE_STEAL_TIME		2
+#define  KVM_FEATURE_PREEMPT		3
 /* BIT 24 - 31 are features configurable by user space vmm */
 #define  KVM_FEATURE_VIRT_EXTIOI	24
 #define  KVM_FEATURE_USER_HCALL		25
diff --git a/linux-headers/asm-loongarch/unistd_64.h b/linux-headers/asm-loongarch/unistd_64.h
index aa5daac4ef..3a29d86e1d 100644
--- a/linux-headers/asm-loongarch/unistd_64.h
+++ b/linux-headers/asm-loongarch/unistd_64.h
@@ -300,6 +300,7 @@
 #define __NR_landlock_create_ruleset 444
 #define __NR_landlock_add_rule 445
 #define __NR_landlock_restrict_self 446
+#define __NR_memfd_secret 447
 #define __NR_process_mrelease 448
 #define __NR_futex_waitv 449
 #define __NR_set_mempolicy_home_node 450
@@ -323,6 +324,7 @@
 #define __NR_file_getattr 468
 #define __NR_file_setattr 469
 #define __NR_listns 470
+#define __NR_rseq_slice_yield 471
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-mips/unistd_n32.h b/linux-headers/asm-mips/unistd_n32.h
index a33d106dca..5fa1ee0cb4 100644
--- a/linux-headers/asm-mips/unistd_n32.h
+++ b/linux-headers/asm-mips/unistd_n32.h
@@ -399,5 +399,6 @@
 #define __NR_file_getattr (__NR_Linux + 468)
 #define __NR_file_setattr (__NR_Linux + 469)
 #define __NR_listns (__NR_Linux + 470)
+#define __NR_rseq_slice_yield (__NR_Linux + 471)
 
 #endif /* _ASM_UNISTD_N32_H */
diff --git a/linux-headers/asm-mips/unistd_n64.h b/linux-headers/asm-mips/unistd_n64.h
index 1bc251e450..e1f873d83a 100644
--- a/linux-headers/asm-mips/unistd_n64.h
+++ b/linux-headers/asm-mips/unistd_n64.h
@@ -375,5 +375,6 @@
 #define __NR_file_getattr (__NR_Linux + 468)
 #define __NR_file_setattr (__NR_Linux + 469)
 #define __NR_listns (__NR_Linux + 470)
+#define __NR_rseq_slice_yield (__NR_Linux + 471)
 
 #endif /* _ASM_UNISTD_N64_H */
diff --git a/linux-headers/asm-mips/unistd_o32.h b/linux-headers/asm-mips/unistd_o32.h
index c57175d496..8207e9ca4f 100644
--- a/linux-headers/asm-mips/unistd_o32.h
+++ b/linux-headers/asm-mips/unistd_o32.h
@@ -445,5 +445,6 @@
 #define __NR_file_getattr (__NR_Linux + 468)
 #define __NR_file_setattr (__NR_Linux + 469)
 #define __NR_listns (__NR_Linux + 470)
+#define __NR_rseq_slice_yield (__NR_Linux + 471)
 
 #endif /* _ASM_UNISTD_O32_H */
diff --git a/linux-headers/asm-powerpc/unistd_32.h b/linux-headers/asm-powerpc/unistd_32.h
index a3f4aa2fe2..1f63360120 100644
--- a/linux-headers/asm-powerpc/unistd_32.h
+++ b/linux-headers/asm-powerpc/unistd_32.h
@@ -452,6 +452,7 @@
 #define __NR_file_getattr 468
 #define __NR_file_setattr 469
 #define __NR_listns 470
+#define __NR_rseq_slice_yield 471
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-powerpc/unistd_64.h b/linux-headers/asm-powerpc/unistd_64.h
index d4444557f1..87439c53c1 100644
--- a/linux-headers/asm-powerpc/unistd_64.h
+++ b/linux-headers/asm-powerpc/unistd_64.h
@@ -424,6 +424,7 @@
 #define __NR_file_getattr 468
 #define __NR_file_setattr 469
 #define __NR_listns 470
+#define __NR_rseq_slice_yield 471
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-riscv/kvm.h b/linux-headers/asm-riscv/kvm.h
index 54f3ad7ed2..504e733053 100644
--- a/linux-headers/asm-riscv/kvm.h
+++ b/linux-headers/asm-riscv/kvm.h
@@ -110,6 +110,10 @@ struct kvm_riscv_timer {
 	__u64 state;
 };
 
+/* Possible states for kvm_riscv_timer */
+#define KVM_RISCV_TIMER_STATE_OFF	0
+#define KVM_RISCV_TIMER_STATE_ON	1
+
 /*
  * ISA extension IDs specific to KVM. This is not the same as the host ISA
  * extension IDs as that is internal to the host and should not be exposed
@@ -192,6 +196,9 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZFBFMIN,
 	KVM_RISCV_ISA_EXT_ZVFBFMIN,
 	KVM_RISCV_ISA_EXT_ZVFBFWMA,
+	KVM_RISCV_ISA_EXT_ZCLSD,
+	KVM_RISCV_ISA_EXT_ZILSD,
+	KVM_RISCV_ISA_EXT_ZALASR,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
@@ -235,10 +242,6 @@ struct kvm_riscv_sbi_fwft {
 	struct kvm_riscv_sbi_fwft_feature pointer_masking;
 };
 
-/* Possible states for kvm_riscv_timer */
-#define KVM_RISCV_TIMER_STATE_OFF	0
-#define KVM_RISCV_TIMER_STATE_ON	1
-
 /* If you need to interpret the index values, here is the key: */
 #define KVM_REG_RISCV_TYPE_MASK		0x00000000FF000000
 #define KVM_REG_RISCV_TYPE_SHIFT	24
diff --git a/linux-headers/asm-riscv/ptrace.h b/linux-headers/asm-riscv/ptrace.h
index a3f8211ede..cf87642994 100644
--- a/linux-headers/asm-riscv/ptrace.h
+++ b/linux-headers/asm-riscv/ptrace.h
@@ -9,6 +9,7 @@
 #ifndef __ASSEMBLER__
 
 #include <linux/types.h>
+#include <linux/const.h>
 
 #define PTRACE_GETFDPIC		33
 
@@ -127,6 +128,42 @@ struct __riscv_v_regset_state {
  */
 #define RISCV_MAX_VLENB (8192)
 
+struct __sc_riscv_cfi_state {
+	unsigned long ss_ptr;   /* shadow stack pointer */
+};
+
+#define PTRACE_CFI_BRANCH_LANDING_PAD_EN_BIT		0
+#define PTRACE_CFI_BRANCH_LANDING_PAD_LOCK_BIT		1
+#define PTRACE_CFI_BRANCH_EXPECTED_LANDING_PAD_BIT	2
+#define PTRACE_CFI_SHADOW_STACK_EN_BIT			3
+#define PTRACE_CFI_SHADOW_STACK_LOCK_BIT		4
+#define PTRACE_CFI_SHADOW_STACK_PTR_BIT			5
+
+#define PTRACE_CFI_BRANCH_LANDING_PAD_EN_STATE		_BITUL(PTRACE_CFI_BRANCH_LANDING_PAD_EN_BIT)
+#define PTRACE_CFI_BRANCH_LANDING_PAD_LOCK_STATE	\
+	_BITUL(PTRACE_CFI_BRANCH_LANDING_PAD_LOCK_BIT)
+#define PTRACE_CFI_BRANCH_EXPECTED_LANDING_PAD_STATE	\
+	_BITUL(PTRACE_CFI_BRANCH_EXPECTED_LANDING_PAD_BIT)
+#define PTRACE_CFI_SHADOW_STACK_EN_STATE		_BITUL(PTRACE_CFI_SHADOW_STACK_EN_BIT)
+#define PTRACE_CFI_SHADOW_STACK_LOCK_STATE		_BITUL(PTRACE_CFI_SHADOW_STACK_LOCK_BIT)
+#define PTRACE_CFI_SHADOW_STACK_PTR_STATE		_BITUL(PTRACE_CFI_SHADOW_STACK_PTR_BIT)
+
+#define PTRACE_CFI_STATE_INVALID_MASK	~(PTRACE_CFI_BRANCH_LANDING_PAD_EN_STATE | \
+					  PTRACE_CFI_BRANCH_LANDING_PAD_LOCK_STATE | \
+					  PTRACE_CFI_BRANCH_EXPECTED_LANDING_PAD_STATE | \
+					  PTRACE_CFI_SHADOW_STACK_EN_STATE | \
+					  PTRACE_CFI_SHADOW_STACK_LOCK_STATE | \
+					  PTRACE_CFI_SHADOW_STACK_PTR_STATE)
+
+struct __cfi_status {
+	__u64 cfi_state;
+};
+
+struct user_cfi_state {
+	struct __cfi_status	cfi_status;
+	__u64 shstk_ptr;
+};
+
 #endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_RISCV_PTRACE_H */
diff --git a/linux-headers/asm-riscv/unistd_32.h b/linux-headers/asm-riscv/unistd_32.h
index 9f33956246..828f3c2b9d 100644
--- a/linux-headers/asm-riscv/unistd_32.h
+++ b/linux-headers/asm-riscv/unistd_32.h
@@ -318,6 +318,7 @@
 #define __NR_file_getattr 468
 #define __NR_file_setattr 469
 #define __NR_listns 470
+#define __NR_rseq_slice_yield 471
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-riscv/unistd_64.h b/linux-headers/asm-riscv/unistd_64.h
index c2e7258916..8fa59835a3 100644
--- a/linux-headers/asm-riscv/unistd_64.h
+++ b/linux-headers/asm-riscv/unistd_64.h
@@ -328,6 +328,7 @@
 #define __NR_file_getattr 468
 #define __NR_file_setattr 469
 #define __NR_listns 470
+#define __NR_rseq_slice_yield 471
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-s390/unistd_32.h b/linux-headers/asm-s390/unistd_32.h
deleted file mode 100644
index 37b8f6f358..0000000000
--- a/linux-headers/asm-s390/unistd_32.h
+++ /dev/null
@@ -1,446 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_S390_UNISTD_32_H
-#define _ASM_S390_UNISTD_32_H
-
-#define __NR_exit 1
-#define __NR_fork 2
-#define __NR_read 3
-#define __NR_write 4
-#define __NR_open 5
-#define __NR_close 6
-#define __NR_restart_syscall 7
-#define __NR_creat 8
-#define __NR_link 9
-#define __NR_unlink 10
-#define __NR_execve 11
-#define __NR_chdir 12
-#define __NR_time 13
-#define __NR_mknod 14
-#define __NR_chmod 15
-#define __NR_lchown 16
-#define __NR_lseek 19
-#define __NR_getpid 20
-#define __NR_mount 21
-#define __NR_umount 22
-#define __NR_setuid 23
-#define __NR_getuid 24
-#define __NR_stime 25
-#define __NR_ptrace 26
-#define __NR_alarm 27
-#define __NR_pause 29
-#define __NR_utime 30
-#define __NR_access 33
-#define __NR_nice 34
-#define __NR_sync 36
-#define __NR_kill 37
-#define __NR_rename 38
-#define __NR_mkdir 39
-#define __NR_rmdir 40
-#define __NR_dup 41
-#define __NR_pipe 42
-#define __NR_times 43
-#define __NR_brk 45
-#define __NR_setgid 46
-#define __NR_getgid 47
-#define __NR_signal 48
-#define __NR_geteuid 49
-#define __NR_getegid 50
-#define __NR_acct 51
-#define __NR_umount2 52
-#define __NR_ioctl 54
-#define __NR_fcntl 55
-#define __NR_setpgid 57
-#define __NR_umask 60
-#define __NR_chroot 61
-#define __NR_ustat 62
-#define __NR_dup2 63
-#define __NR_getppid 64
-#define __NR_getpgrp 65
-#define __NR_setsid 66
-#define __NR_sigaction 67
-#define __NR_setreuid 70
-#define __NR_setregid 71
-#define __NR_sigsuspend 72
-#define __NR_sigpending 73
-#define __NR_sethostname 74
-#define __NR_setrlimit 75
-#define __NR_getrlimit 76
-#define __NR_getrusage 77
-#define __NR_gettimeofday 78
-#define __NR_settimeofday 79
-#define __NR_getgroups 80
-#define __NR_setgroups 81
-#define __NR_symlink 83
-#define __NR_readlink 85
-#define __NR_uselib 86
-#define __NR_swapon 87
-#define __NR_reboot 88
-#define __NR_readdir 89
-#define __NR_mmap 90
-#define __NR_munmap 91
-#define __NR_truncate 92
-#define __NR_ftruncate 93
-#define __NR_fchmod 94
-#define __NR_fchown 95
-#define __NR_getpriority 96
-#define __NR_setpriority 97
-#define __NR_statfs 99
-#define __NR_fstatfs 100
-#define __NR_ioperm 101
-#define __NR_socketcall 102
-#define __NR_syslog 103
-#define __NR_setitimer 104
-#define __NR_getitimer 105
-#define __NR_stat 106
-#define __NR_lstat 107
-#define __NR_fstat 108
-#define __NR_lookup_dcookie 110
-#define __NR_vhangup 111
-#define __NR_idle 112
-#define __NR_wait4 114
-#define __NR_swapoff 115
-#define __NR_sysinfo 116
-#define __NR_ipc 117
-#define __NR_fsync 118
-#define __NR_sigreturn 119
-#define __NR_clone 120
-#define __NR_setdomainname 121
-#define __NR_uname 122
-#define __NR_adjtimex 124
-#define __NR_mprotect 125
-#define __NR_sigprocmask 126
-#define __NR_create_module 127
-#define __NR_init_module 128
-#define __NR_delete_module 129
-#define __NR_get_kernel_syms 130
-#define __NR_quotactl 131
-#define __NR_getpgid 132
-#define __NR_fchdir 133
-#define __NR_bdflush 134
-#define __NR_sysfs 135
-#define __NR_personality 136
-#define __NR_afs_syscall 137
-#define __NR_setfsuid 138
-#define __NR_setfsgid 139
-#define __NR__llseek 140
-#define __NR_getdents 141
-#define __NR__newselect 142
-#define __NR_flock 143
-#define __NR_msync 144
-#define __NR_readv 145
-#define __NR_writev 146
-#define __NR_getsid 147
-#define __NR_fdatasync 148
-#define __NR__sysctl 149
-#define __NR_mlock 150
-#define __NR_munlock 151
-#define __NR_mlockall 152
-#define __NR_munlockall 153
-#define __NR_sched_setparam 154
-#define __NR_sched_getparam 155
-#define __NR_sched_setscheduler 156
-#define __NR_sched_getscheduler 157
-#define __NR_sched_yield 158
-#define __NR_sched_get_priority_max 159
-#define __NR_sched_get_priority_min 160
-#define __NR_sched_rr_get_interval 161
-#define __NR_nanosleep 162
-#define __NR_mremap 163
-#define __NR_setresuid 164
-#define __NR_getresuid 165
-#define __NR_query_module 167
-#define __NR_poll 168
-#define __NR_nfsservctl 169
-#define __NR_setresgid 170
-#define __NR_getresgid 171
-#define __NR_prctl 172
-#define __NR_rt_sigreturn 173
-#define __NR_rt_sigaction 174
-#define __NR_rt_sigprocmask 175
-#define __NR_rt_sigpending 176
-#define __NR_rt_sigtimedwait 177
-#define __NR_rt_sigqueueinfo 178
-#define __NR_rt_sigsuspend 179
-#define __NR_pread64 180
-#define __NR_pwrite64 181
-#define __NR_chown 182
-#define __NR_getcwd 183
-#define __NR_capget 184
-#define __NR_capset 185
-#define __NR_sigaltstack 186
-#define __NR_sendfile 187
-#define __NR_getpmsg 188
-#define __NR_putpmsg 189
-#define __NR_vfork 190
-#define __NR_ugetrlimit 191
-#define __NR_mmap2 192
-#define __NR_truncate64 193
-#define __NR_ftruncate64 194
-#define __NR_stat64 195
-#define __NR_lstat64 196
-#define __NR_fstat64 197
-#define __NR_lchown32 198
-#define __NR_getuid32 199
-#define __NR_getgid32 200
-#define __NR_geteuid32 201
-#define __NR_getegid32 202
-#define __NR_setreuid32 203
-#define __NR_setregid32 204
-#define __NR_getgroups32 205
-#define __NR_setgroups32 206
-#define __NR_fchown32 207
-#define __NR_setresuid32 208
-#define __NR_getresuid32 209
-#define __NR_setresgid32 210
-#define __NR_getresgid32 211
-#define __NR_chown32 212
-#define __NR_setuid32 213
-#define __NR_setgid32 214
-#define __NR_setfsuid32 215
-#define __NR_setfsgid32 216
-#define __NR_pivot_root 217
-#define __NR_mincore 218
-#define __NR_madvise 219
-#define __NR_getdents64 220
-#define __NR_fcntl64 221
-#define __NR_readahead 222
-#define __NR_sendfile64 223
-#define __NR_setxattr 224
-#define __NR_lsetxattr 225
-#define __NR_fsetxattr 226
-#define __NR_getxattr 227
-#define __NR_lgetxattr 228
-#define __NR_fgetxattr 229
-#define __NR_listxattr 230
-#define __NR_llistxattr 231
-#define __NR_flistxattr 232
-#define __NR_removexattr 233
-#define __NR_lremovexattr 234
-#define __NR_fremovexattr 235
-#define __NR_gettid 236
-#define __NR_tkill 237
-#define __NR_futex 238
-#define __NR_sched_setaffinity 239
-#define __NR_sched_getaffinity 240
-#define __NR_tgkill 241
-#define __NR_io_setup 243
-#define __NR_io_destroy 244
-#define __NR_io_getevents 245
-#define __NR_io_submit 246
-#define __NR_io_cancel 247
-#define __NR_exit_group 248
-#define __NR_epoll_create 249
-#define __NR_epoll_ctl 250
-#define __NR_epoll_wait 251
-#define __NR_set_tid_address 252
-#define __NR_fadvise64 253
-#define __NR_timer_create 254
-#define __NR_timer_settime 255
-#define __NR_timer_gettime 256
-#define __NR_timer_getoverrun 257
-#define __NR_timer_delete 258
-#define __NR_clock_settime 259
-#define __NR_clock_gettime 260
-#define __NR_clock_getres 261
-#define __NR_clock_nanosleep 262
-#define __NR_fadvise64_64 264
-#define __NR_statfs64 265
-#define __NR_fstatfs64 266
-#define __NR_remap_file_pages 267
-#define __NR_mbind 268
-#define __NR_get_mempolicy 269
-#define __NR_set_mempolicy 270
-#define __NR_mq_open 271
-#define __NR_mq_unlink 272
-#define __NR_mq_timedsend 273
-#define __NR_mq_timedreceive 274
-#define __NR_mq_notify 275
-#define __NR_mq_getsetattr 276
-#define __NR_kexec_load 277
-#define __NR_add_key 278
-#define __NR_request_key 279
-#define __NR_keyctl 280
-#define __NR_waitid 281
-#define __NR_ioprio_set 282
-#define __NR_ioprio_get 283
-#define __NR_inotify_init 284
-#define __NR_inotify_add_watch 285
-#define __NR_inotify_rm_watch 286
-#define __NR_migrate_pages 287
-#define __NR_openat 288
-#define __NR_mkdirat 289
-#define __NR_mknodat 290
-#define __NR_fchownat 291
-#define __NR_futimesat 292
-#define __NR_fstatat64 293
-#define __NR_unlinkat 294
-#define __NR_renameat 295
-#define __NR_linkat 296
-#define __NR_symlinkat 297
-#define __NR_readlinkat 298
-#define __NR_fchmodat 299
-#define __NR_faccessat 300
-#define __NR_pselect6 301
-#define __NR_ppoll 302
-#define __NR_unshare 303
-#define __NR_set_robust_list 304
-#define __NR_get_robust_list 305
-#define __NR_splice 306
-#define __NR_sync_file_range 307
-#define __NR_tee 308
-#define __NR_vmsplice 309
-#define __NR_move_pages 310
-#define __NR_getcpu 311
-#define __NR_epoll_pwait 312
-#define __NR_utimes 313
-#define __NR_fallocate 314
-#define __NR_utimensat 315
-#define __NR_signalfd 316
-#define __NR_timerfd 317
-#define __NR_eventfd 318
-#define __NR_timerfd_create 319
-#define __NR_timerfd_settime 320
-#define __NR_timerfd_gettime 321
-#define __NR_signalfd4 322
-#define __NR_eventfd2 323
-#define __NR_inotify_init1 324
-#define __NR_pipe2 325
-#define __NR_dup3 326
-#define __NR_epoll_create1 327
-#define __NR_preadv 328
-#define __NR_pwritev 329
-#define __NR_rt_tgsigqueueinfo 330
-#define __NR_perf_event_open 331
-#define __NR_fanotify_init 332
-#define __NR_fanotify_mark 333
-#define __NR_prlimit64 334
-#define __NR_name_to_handle_at 335
-#define __NR_open_by_handle_at 336
-#define __NR_clock_adjtime 337
-#define __NR_syncfs 338
-#define __NR_setns 339
-#define __NR_process_vm_readv 340
-#define __NR_process_vm_writev 341
-#define __NR_s390_runtime_instr 342
-#define __NR_kcmp 343
-#define __NR_finit_module 344
-#define __NR_sched_setattr 345
-#define __NR_sched_getattr 346
-#define __NR_renameat2 347
-#define __NR_seccomp 348
-#define __NR_getrandom 349
-#define __NR_memfd_create 350
-#define __NR_bpf 351
-#define __NR_s390_pci_mmio_write 352
-#define __NR_s390_pci_mmio_read 353
-#define __NR_execveat 354
-#define __NR_userfaultfd 355
-#define __NR_membarrier 356
-#define __NR_recvmmsg 357
-#define __NR_sendmmsg 358
-#define __NR_socket 359
-#define __NR_socketpair 360
-#define __NR_bind 361
-#define __NR_connect 362
-#define __NR_listen 363
-#define __NR_accept4 364
-#define __NR_getsockopt 365
-#define __NR_setsockopt 366
-#define __NR_getsockname 367
-#define __NR_getpeername 368
-#define __NR_sendto 369
-#define __NR_sendmsg 370
-#define __NR_recvfrom 371
-#define __NR_recvmsg 372
-#define __NR_shutdown 373
-#define __NR_mlock2 374
-#define __NR_copy_file_range 375
-#define __NR_preadv2 376
-#define __NR_pwritev2 377
-#define __NR_s390_guarded_storage 378
-#define __NR_statx 379
-#define __NR_s390_sthyi 380
-#define __NR_kexec_file_load 381
-#define __NR_io_pgetevents 382
-#define __NR_rseq 383
-#define __NR_pkey_mprotect 384
-#define __NR_pkey_alloc 385
-#define __NR_pkey_free 386
-#define __NR_semget 393
-#define __NR_semctl 394
-#define __NR_shmget 395
-#define __NR_shmctl 396
-#define __NR_shmat 397
-#define __NR_shmdt 398
-#define __NR_msgget 399
-#define __NR_msgsnd 400
-#define __NR_msgrcv 401
-#define __NR_msgctl 402
-#define __NR_clock_gettime64 403
-#define __NR_clock_settime64 404
-#define __NR_clock_adjtime64 405
-#define __NR_clock_getres_time64 406
-#define __NR_clock_nanosleep_time64 407
-#define __NR_timer_gettime64 408
-#define __NR_timer_settime64 409
-#define __NR_timerfd_gettime64 410
-#define __NR_timerfd_settime64 411
-#define __NR_utimensat_time64 412
-#define __NR_pselect6_time64 413
-#define __NR_ppoll_time64 414
-#define __NR_io_pgetevents_time64 416
-#define __NR_recvmmsg_time64 417
-#define __NR_mq_timedsend_time64 418
-#define __NR_mq_timedreceive_time64 419
-#define __NR_semtimedop_time64 420
-#define __NR_rt_sigtimedwait_time64 421
-#define __NR_futex_time64 422
-#define __NR_sched_rr_get_interval_time64 423
-#define __NR_pidfd_send_signal 424
-#define __NR_io_uring_setup 425
-#define __NR_io_uring_enter 426
-#define __NR_io_uring_register 427
-#define __NR_open_tree 428
-#define __NR_move_mount 429
-#define __NR_fsopen 430
-#define __NR_fsconfig 431
-#define __NR_fsmount 432
-#define __NR_fspick 433
-#define __NR_pidfd_open 434
-#define __NR_clone3 435
-#define __NR_close_range 436
-#define __NR_openat2 437
-#define __NR_pidfd_getfd 438
-#define __NR_faccessat2 439
-#define __NR_process_madvise 440
-#define __NR_epoll_pwait2 441
-#define __NR_mount_setattr 442
-#define __NR_quotactl_fd 443
-#define __NR_landlock_create_ruleset 444
-#define __NR_landlock_add_rule 445
-#define __NR_landlock_restrict_self 446
-#define __NR_memfd_secret 447
-#define __NR_process_mrelease 448
-#define __NR_futex_waitv 449
-#define __NR_set_mempolicy_home_node 450
-#define __NR_cachestat 451
-#define __NR_fchmodat2 452
-#define __NR_map_shadow_stack 453
-#define __NR_futex_wake 454
-#define __NR_futex_wait 455
-#define __NR_futex_requeue 456
-#define __NR_statmount 457
-#define __NR_listmount 458
-#define __NR_lsm_get_self_attr 459
-#define __NR_lsm_set_self_attr 460
-#define __NR_lsm_list_modules 461
-#define __NR_mseal 462
-#define __NR_setxattrat 463
-#define __NR_getxattrat 464
-#define __NR_listxattrat 465
-#define __NR_removexattrat 466
-#define __NR_open_tree_attr 467
-#define __NR_file_getattr 468
-#define __NR_file_setattr 469
-
-#endif /* _ASM_S390_UNISTD_32_H */
diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/unistd_64.h
index 8d9e579ef5..01f674c1bc 100644
--- a/linux-headers/asm-s390/unistd_64.h
+++ b/linux-headers/asm-s390/unistd_64.h
@@ -390,6 +390,7 @@
 #define __NR_file_getattr 468
 #define __NR_file_setattr 469
 #define __NR_listns 470
+#define __NR_rseq_slice_yield 471
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index b804fd25a2..01d46e2929 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -197,13 +197,13 @@ struct kvm_msrs {
 	__u32 nmsrs; /* number of msrs in entries */
 	__u32 pad;
 
-	struct kvm_msr_entry entries[];
+	__DECLARE_FLEX_ARRAY(struct kvm_msr_entry, entries);
 };
 
 /* for KVM_GET_MSR_INDEX_LIST */
 struct kvm_msr_list {
 	__u32 nmsrs; /* number of msrs in entries */
-	__u32 indices[];
+	__DECLARE_FLEX_ARRAY(__u32, indices);
 };
 
 /* Maximum size of any access bitmap in bytes */
@@ -243,7 +243,7 @@ struct kvm_cpuid_entry {
 struct kvm_cpuid {
 	__u32 nent;
 	__u32 padding;
-	struct kvm_cpuid_entry entries[];
+	__DECLARE_FLEX_ARRAY(struct kvm_cpuid_entry, entries);
 };
 
 struct kvm_cpuid_entry2 {
@@ -265,7 +265,7 @@ struct kvm_cpuid_entry2 {
 struct kvm_cpuid2 {
 	__u32 nent;
 	__u32 padding;
-	struct kvm_cpuid_entry2 entries[];
+	__DECLARE_FLEX_ARRAY(struct kvm_cpuid_entry2, entries);
 };
 
 /* for KVM_GET_PIT and KVM_SET_PIT */
@@ -396,7 +396,7 @@ struct kvm_xsave {
 	 * the contents of CPUID leaf 0xD on the host.
 	 */
 	__u32 region[1024];
-	__u32 extra[];
+	__DECLARE_FLEX_ARRAY(__u32, extra);
 };
 
 #define KVM_MAX_XCRS	16
@@ -474,6 +474,7 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_SLOT_ZAP_ALL		(1 << 7)
 #define KVM_X86_QUIRK_STUFF_FEATURE_MSRS	(1 << 8)
 #define KVM_X86_QUIRK_IGNORE_GUEST_PAT		(1 << 9)
+#define KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM (1 << 10)
 
 #define KVM_STATE_NESTED_FORMAT_VMX	0
 #define KVM_STATE_NESTED_FORMAT_SVM	1
@@ -501,6 +502,7 @@ struct kvm_sync_regs {
 #define KVM_X86_GRP_SEV			1
 #  define KVM_X86_SEV_VMSA_FEATURES	0
 #  define KVM_X86_SNP_POLICY_BITS	1
+#  define KVM_X86_SEV_SNP_REQ_CERTS	2
 
 struct kvm_vmx_nested_state_data {
 	__u8 vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
@@ -562,7 +564,7 @@ struct kvm_pmu_event_filter {
 	__u32 fixed_counter_bitmap;
 	__u32 flags;
 	__u32 pad[4];
-	__u64 events[];
+	__DECLARE_FLEX_ARRAY(__u64, events);
 };
 
 #define KVM_PMU_EVENT_ALLOW 0
@@ -741,6 +743,7 @@ enum sev_cmd_id {
 	KVM_SEV_SNP_LAUNCH_START = 100,
 	KVM_SEV_SNP_LAUNCH_UPDATE,
 	KVM_SEV_SNP_LAUNCH_FINISH,
+	KVM_SEV_SNP_ENABLE_REQ_CERTS,
 
 	KVM_SEV_NR_MAX,
 };
@@ -912,8 +915,10 @@ struct kvm_sev_snp_launch_finish {
 	__u64 pad1[4];
 };
 
-#define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
-#define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  (1ULL << 1)
+#define KVM_X2APIC_API_USE_32BIT_IDS			_BITULL(0)
+#define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK		_BITULL(1)
+#define KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST	_BITULL(2)
+#define KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST	_BITULL(3)
 
 struct kvm_hyperv_eventfd {
 	__u32 conn_id;
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unistd_32.h
index 34255aac64..e945468829 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -461,6 +461,7 @@
 #define __NR_file_getattr 468
 #define __NR_file_setattr 469
 #define __NR_listns 470
+#define __NR_rseq_slice_yield 471
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unistd_64.h
index 07f242a5fa..3c49b00ed1 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -385,6 +385,7 @@
 #define __NR_file_getattr 468
 #define __NR_file_setattr 469
 #define __NR_listns 470
+#define __NR_rseq_slice_yield 471
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/unistd_x32.h
index 08fc9da2fa..bd2af9ad08 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -338,6 +338,7 @@
 #define __NR_file_getattr (__X32_SYSCALL_BIT + 468)
 #define __NR_file_setattr (__X32_SYSCALL_BIT + 469)
 #define __NR_listns (__X32_SYSCALL_BIT + 470)
+#define __NR_rseq_slice_yield (__X32_SYSCALL_BIT + 471)
 #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
 #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
 #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
diff --git a/linux-headers/linux/const.h b/linux-headers/linux/const.h
index 95ede23342..c6a9d0c983 100644
--- a/linux-headers/linux/const.h
+++ b/linux-headers/linux/const.h
@@ -50,4 +50,22 @@
 
 #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 
+/*
+ * Divide positive or negative dividend by positive or negative divisor
+ * and round to closest integer. Result is undefined for negative
+ * divisors if the dividend variable type is unsigned and for negative
+ * dividends if the divisor variable type is unsigned.
+ */
+#define __KERNEL_DIV_ROUND_CLOSEST(x, divisor)		\
+({							\
+	__typeof__(x) __x = x;				\
+	__typeof__(divisor) __d = divisor;		\
+							\
+	(((__typeof__(x))-1) > 0 ||			\
+	 ((__typeof__(divisor))-1) > 0 ||		\
+	 (((__x) > 0) == ((__d) > 0))) ?		\
+		(((__x) + ((__d) / 2)) / (__d)) :	\
+		(((__x) - ((__d) / 2)) / (__d));	\
+})
+
 #endif /* _LINUX_CONST_H */
diff --git a/linux-headers/linux/iommufd.h b/linux-headers/linux/iommufd.h
index 384183a403..82587c7d62 100644
--- a/linux-headers/linux/iommufd.h
+++ b/linux-headers/linux/iommufd.h
@@ -465,16 +465,27 @@ struct iommu_hwpt_arm_smmuv3 {
 	__aligned_le64 ste[2];
 };
 
+/**
+ * struct iommu_hwpt_amd_guest - AMD IOMMU guest I/O page table data
+ *				 (IOMMU_HWPT_DATA_AMD_GUEST)
+ * @dte: Guest Device Table Entry (DTE)
+ */
+struct iommu_hwpt_amd_guest {
+	__aligned_u64 dte[4];
+};
+
 /**
  * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
  * @IOMMU_HWPT_DATA_NONE: no data
  * @IOMMU_HWPT_DATA_VTD_S1: Intel VT-d stage-1 page table
  * @IOMMU_HWPT_DATA_ARM_SMMUV3: ARM SMMUv3 Context Descriptor Table
+ * @IOMMU_HWPT_DATA_AMD_GUEST: AMD IOMMU guest page table
  */
 enum iommu_hwpt_data_type {
 	IOMMU_HWPT_DATA_NONE = 0,
 	IOMMU_HWPT_DATA_VTD_S1 = 1,
 	IOMMU_HWPT_DATA_ARM_SMMUV3 = 2,
+	IOMMU_HWPT_DATA_AMD_GUEST = 3,
 };
 
 /**
@@ -623,6 +634,32 @@ struct iommu_hw_info_tegra241_cmdqv {
 	__u8 __reserved;
 };
 
+/**
+ * struct iommu_hw_info_amd - AMD IOMMU device info
+ *
+ * @efr : Value of AMD IOMMU Extended Feature Register (EFR)
+ * @efr2: Value of AMD IOMMU Extended Feature 2 Register (EFR2)
+ *
+ * Please See description of these registers in the following sections of
+ * the AMD I/O Virtualization Technology (IOMMU) Specification.
+ * (https://docs.amd.com/v/u/en-US/48882_3.10_PUB)
+ *
+ * - MMIO Offset 0030h IOMMU Extended Feature Register
+ * - MMIO Offset 01A0h IOMMU Extended Feature 2 Register
+ *
+ * Note: The EFR and EFR2 are raw values reported by hardware.
+ * VMM is responsible to determine the appropriate flags to be exposed to
+ * the VM since cetertain features are not currently supported by the kernel
+ * for HW-vIOMMU.
+ *
+ * Current VMM-allowed list of feature flags are:
+ * - EFR[GTSup, GASup, GioSup, PPRSup, EPHSup, GATS, GLX, PASmax]
+ */
+struct iommu_hw_info_amd {
+	__aligned_u64 efr;
+	__aligned_u64 efr2;
+};
+
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
  * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
@@ -632,6 +669,7 @@ struct iommu_hw_info_tegra241_cmdqv {
  * @IOMMU_HW_INFO_TYPE_ARM_SMMUV3: ARM SMMUv3 iommu info type
  * @IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                     SMMUv3) info type
+ * @IOMMU_HW_INFO_TYPE_AMD: AMD IOMMU info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE = 0,
@@ -639,6 +677,7 @@ enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_INTEL_VTD = 1,
 	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
 	IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV = 3,
+	IOMMU_HW_INFO_TYPE_AMD = 4,
 };
 
 /**
@@ -656,11 +695,15 @@ enum iommu_hw_info_type {
  * @IOMMU_HW_CAP_PCI_PASID_PRIV: Privileged Mode Supported, user ignores it
  *                               when the struct
  *                               iommu_hw_info::out_max_pasid_log2 is zero.
+ * @IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED: ATS is not supported or cannot be used
+ *                                      on this device (absence implies ATS
+ *                                      may be enabled)
  */
 enum iommufd_hw_capabilities {
 	IOMMU_HW_CAP_DIRTY_TRACKING = 1 << 0,
 	IOMMU_HW_CAP_PCI_PASID_EXEC = 1 << 1,
 	IOMMU_HW_CAP_PCI_PASID_PRIV = 1 << 2,
+	IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED = 1 << 3,
 };
 
 /**
@@ -1013,6 +1056,11 @@ struct iommu_fault_alloc {
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
 	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
+	/*
+	 * TEGRA241_CMDQV requirements (otherwise, VCMDQs will not work)
+	 * - Kernel will allocate a VINTF (HYP_OWN=0) to back this VIOMMU. So,
+	 *   VMM must wire the HYP_OWN bit to 0 in guest VINTF_CONFIG register
+	 */
 	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
 };
 
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index a4ab42dcba..c1baca4302 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -11,9 +11,11 @@
 #include <linux/const.h>
 #include <linux/types.h>
 
+#include <linux/stddef.h>
 #include <linux/ioctl.h>
 #include <asm/kvm.h>
 
+
 #define KVM_API_VERSION 12
 
 /*
@@ -135,6 +137,12 @@ struct kvm_xen_exit {
 	} u;
 };
 
+struct kvm_exit_snp_req_certs {
+	__u64 gpa;
+	__u64 npages;
+	__u64 ret;
+};
+
 #define KVM_S390_GET_SKEYS_NONE   1
 #define KVM_S390_SKEYS_MAX        1048576
 
@@ -180,6 +188,8 @@ struct kvm_xen_exit {
 #define KVM_EXIT_MEMORY_FAULT     39
 #define KVM_EXIT_TDX              40
 #define KVM_EXIT_ARM_SEA          41
+#define KVM_EXIT_ARM_LDST64B      42
+#define KVM_EXIT_SNP_REQ_CERTS    43
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -394,7 +404,7 @@ struct kvm_run {
 		} eoi;
 		/* KVM_EXIT_HYPERV */
 		struct kvm_hyperv_exit hyperv;
-		/* KVM_EXIT_ARM_NISV */
+		/* KVM_EXIT_ARM_NISV / KVM_EXIT_ARM_LDST64B */
 		struct {
 			__u64 esr_iss;
 			__u64 fault_ipa;
@@ -474,6 +484,8 @@ struct kvm_run {
 			__u64 gva;
 			__u64 gpa;
 		} arm_sea;
+		/* KVM_EXIT_SNP_REQ_CERTS */
+		struct kvm_exit_snp_req_certs snp_req_certs;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -520,7 +532,7 @@ struct kvm_coalesced_mmio {
 
 struct kvm_coalesced_mmio_ring {
 	__u32 first, last;
-	struct kvm_coalesced_mmio coalesced_mmio[];
+	__DECLARE_FLEX_ARRAY(struct kvm_coalesced_mmio, coalesced_mmio);
 };
 
 #define KVM_COALESCED_MMIO_MAX \
@@ -570,7 +582,7 @@ struct kvm_clear_dirty_log {
 /* for KVM_SET_SIGNAL_MASK */
 struct kvm_signal_mask {
 	__u32 len;
-	__u8  sigset[];
+	__DECLARE_FLEX_ARRAY(__u8, sigset);
 };
 
 /* for KVM_TPR_ACCESS_REPORTING */
@@ -681,6 +693,11 @@ struct kvm_enable_cap {
 #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
 #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
 	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
+
+#define KVM_VM_TYPE_ARM_PROTECTED	(1UL << 31)
+#define KVM_VM_TYPE_ARM_MASK		(KVM_VM_TYPE_ARM_IPA_SIZE_MASK | \
+					 KVM_VM_TYPE_ARM_PROTECTED)
+
 /*
  * ioctls for /dev/kvm fds:
  */
@@ -966,6 +983,9 @@ struct kvm_enable_cap {
 #define KVM_CAP_GUEST_MEMFD_FLAGS 244
 #define KVM_CAP_ARM_SEA_TO_USER 245
 #define KVM_CAP_S390_USER_OPEREXEC 246
+#define KVM_CAP_S390_KEYOP 247
+#define KVM_CAP_S390_VSIE_ESAMODE 248
+#define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 249
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1028,7 +1048,7 @@ struct kvm_irq_routing_entry {
 struct kvm_irq_routing {
 	__u32 nr;
 	__u32 flags;
-	struct kvm_irq_routing_entry entries[];
+	__DECLARE_FLEX_ARRAY(struct kvm_irq_routing_entry, entries);
 };
 
 #define KVM_IRQFD_FLAG_DEASSIGN (1 << 0)
@@ -1119,7 +1139,7 @@ struct kvm_dirty_tlb {
 
 struct kvm_reg_list {
 	__u64 n; /* number of regs */
-	__u64 reg[];
+	__DECLARE_FLEX_ARRAY(__u64, reg);
 };
 
 struct kvm_one_reg {
@@ -1201,6 +1221,10 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_LOONGARCH_EIOINTC	KVM_DEV_TYPE_LOONGARCH_EIOINTC
 	KVM_DEV_TYPE_LOONGARCH_PCHPIC,
 #define KVM_DEV_TYPE_LOONGARCH_PCHPIC	KVM_DEV_TYPE_LOONGARCH_PCHPIC
+	KVM_DEV_TYPE_LOONGARCH_DMSINTC,
+#define KVM_DEV_TYPE_LOONGARCH_DMSINTC	KVM_DEV_TYPE_LOONGARCH_DMSINTC
+	KVM_DEV_TYPE_ARM_VGIC_V5,
+#define KVM_DEV_TYPE_ARM_VGIC_V5	KVM_DEV_TYPE_ARM_VGIC_V5
 
 	KVM_DEV_TYPE_MAX,
 
@@ -1211,6 +1235,16 @@ struct kvm_vfio_spapr_tce {
 	__s32	tablefd;
 };
 
+#define KVM_S390_KEYOP_ISKE 0x01
+#define KVM_S390_KEYOP_RRBE 0x02
+#define KVM_S390_KEYOP_SSKE 0x03
+struct kvm_s390_keyop {
+	__u64 guest_addr;
+	__u8  key;
+	__u8  operation;
+	__u8  pad[6];
+};
+
 /*
  * KVM_CREATE_VCPU receives as a parameter the vcpu slot, and returns
  * a vcpu fd.
@@ -1230,6 +1264,7 @@ struct kvm_vfio_spapr_tce {
 #define KVM_S390_UCAS_MAP        _IOW(KVMIO, 0x50, struct kvm_s390_ucas_mapping)
 #define KVM_S390_UCAS_UNMAP      _IOW(KVMIO, 0x51, struct kvm_s390_ucas_mapping)
 #define KVM_S390_VCPU_FAULT	 _IOW(KVMIO, 0x52, unsigned long)
+#define KVM_S390_KEYOP           _IOWR(KVMIO, 0x53, struct kvm_s390_keyop)
 
 /* Device model IOC */
 #define KVM_CREATE_IRQCHIP        _IO(KVMIO,   0x60)
@@ -1571,7 +1606,7 @@ struct kvm_stats_desc {
 	__u16 size;
 	__u32 offset;
 	__u32 bucket_size;
-	char name[];
+	__DECLARE_FLEX_ARRAY(char, name);
 };
 
 #define KVM_GET_STATS_FD  _IO(KVMIO,  0xce)
@@ -1599,6 +1634,21 @@ struct kvm_memory_attributes {
 	__u64 flags;
 };
 
+/* Available with KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES */
+#define KVM_SET_MEMORY_ATTRIBUTES2              _IOWR(KVMIO,  0xd2, struct kvm_memory_attributes2)
+
+struct kvm_memory_attributes2 {
+	union {
+		__u64 address;
+		__u64 offset;
+	};
+	__u64 size;
+	__u64 attributes;
+	__u64 flags;
+	__u64 error_offset;
+	__u64 reserved[11];
+};
+
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
diff --git a/linux-headers/linux/mshv.h b/linux-headers/linux/mshv.h
index acceeddc1c..6c7d3a9316 100644
--- a/linux-headers/linux/mshv.h
+++ b/linux-headers/linux/mshv.h
@@ -27,6 +27,8 @@ enum {
 	MSHV_PT_BIT_X2APIC,
 	MSHV_PT_BIT_GPA_SUPER_PAGES,
 	MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES,
+	MSHV_PT_BIT_NESTED_VIRTUALIZATION,
+	MSHV_PT_BIT_SMT_ENABLED_GUEST,
 	MSHV_PT_BIT_COUNT,
 };
 
@@ -355,7 +357,7 @@ struct mshv_vtl_sint_post_msg {
 
 struct mshv_vtl_ram_disposition {
 	__u64 start_pfn;
-	__u64 last_pfn;
+	__u64 last_pfn; /* last_pfn is excluded from the range [start_pfn, last_pfn) */
 };
 
 struct mshv_vtl_set_poll_file {
diff --git a/linux-headers/linux/psp-sev.h b/linux-headers/linux/psp-sev.h
index 9479928a4a..7df5002259 100644
--- a/linux-headers/linux/psp-sev.h
+++ b/linux-headers/linux/psp-sev.h
@@ -277,7 +277,7 @@ struct sev_user_data_snp_wrapped_vlek_hashstick {
  * struct sev_issue_cmd - SEV ioctl parameters
  *
  * @cmd: SEV commands to execute
- * @opaque: pointer to the command structure
+ * @data: pointer to the command structure
  * @error: SEV FW return code on failure
  */
 struct sev_issue_cmd {
diff --git a/linux-headers/linux/stddef.h b/linux-headers/linux/stddef.h
index 48ee4438e0..4574982594 100644
--- a/linux-headers/linux/stddef.h
+++ b/linux-headers/linux/stddef.h
@@ -69,6 +69,10 @@
 #define __counted_by_be(m)
 #endif
 
+#ifndef __counted_by_ptr
+#define __counted_by_ptr(m)
+#endif
+
 #define __kernel_nonstring
 
 #endif /* _LINUX_STDDEF_H */
diff --git a/linux-headers/linux/vduse.h b/linux-headers/linux/vduse.h
index da6ac89af1..e19b3c0f51 100644
--- a/linux-headers/linux/vduse.h
+++ b/linux-headers/linux/vduse.h
@@ -10,6 +10,10 @@
 
 #define VDUSE_API_VERSION	0
 
+/* VQ groups and ASID support */
+
+#define VDUSE_API_VERSION_1	1
+
 /*
  * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION).
  * This is used for future extension.
@@ -27,6 +31,8 @@
  * @features: virtio features
  * @vq_num: the number of virtqueues
  * @vq_align: the allocation alignment of virtqueue's metadata
+ * @ngroups: number of vq groups that VDUSE device declares
+ * @nas: number of address spaces that VDUSE device declares
  * @reserved: for future use, needs to be initialized to zero
  * @config_size: the size of the configuration space
  * @config: the buffer of the configuration space
@@ -41,7 +47,9 @@ struct vduse_dev_config {
 	__u64 features;
 	__u32 vq_num;
 	__u32 vq_align;
-	__u32 reserved[13];
+	__u32 ngroups; /* if VDUSE_API_VERSION >= 1 */
+	__u32 nas; /* if VDUSE_API_VERSION >= 1 */
+	__u32 reserved[11];
 	__u32 config_size;
 	__u8 config[];
 };
@@ -118,14 +126,18 @@ struct vduse_config_data {
  * struct vduse_vq_config - basic configuration of a virtqueue
  * @index: virtqueue index
  * @max_size: the max size of virtqueue
- * @reserved: for future use, needs to be initialized to zero
+ * @reserved1: for future use, needs to be initialized to zero
+ * @group: virtqueue group
+ * @reserved2: for future use, needs to be initialized to zero
  *
  * Structure used by VDUSE_VQ_SETUP ioctl to setup a virtqueue.
  */
 struct vduse_vq_config {
 	__u32 index;
 	__u16 max_size;
-	__u16 reserved[13];
+	__u16 reserved1;
+	__u32 group;
+	__u16 reserved2[10];
 };
 
 /*
@@ -156,6 +168,16 @@ struct vduse_vq_state_packed {
 	__u16 last_used_idx;
 };
 
+/**
+ * struct vduse_vq_group_asid - virtqueue group ASID
+ * @group: Index of the virtqueue group
+ * @asid: Address space ID of the group
+ */
+struct vduse_vq_group_asid {
+	__u32 group;
+	__u32 asid;
+};
+
 /**
  * struct vduse_vq_info - information of a virtqueue
  * @index: virtqueue index
@@ -215,6 +237,7 @@ struct vduse_vq_eventfd {
  * @uaddr: start address of userspace memory, it must be aligned to page size
  * @iova: start of the IOVA region
  * @size: size of the IOVA region
+ * @asid: Address space ID of the IOVA region
  * @reserved: for future use, needs to be initialized to zero
  *
  * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
@@ -224,7 +247,8 @@ struct vduse_iova_umem {
 	__u64 uaddr;
 	__u64 iova;
 	__u64 size;
-	__u64 reserved[3];
+	__u32 asid;
+	__u32 reserved[5];
 };
 
 /* Register userspace memory for IOVA regions */
@@ -238,6 +262,7 @@ struct vduse_iova_umem {
  * @start: start of the IOVA region
  * @last: last of the IOVA region
  * @capability: capability of the IOVA region
+ * @asid: Address space ID of the IOVA region, only if device API version >= 1
  * @reserved: for future use, needs to be initialized to zero
  *
  * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
@@ -248,7 +273,8 @@ struct vduse_iova_info {
 	__u64 last;
 #define VDUSE_IOVA_CAP_UMEM (1 << 0)
 	__u64 capability;
-	__u64 reserved[3];
+	__u32 asid; /* Only if device API version >= 1 */
+	__u32 reserved[5];
 };
 
 /*
@@ -257,6 +283,32 @@ struct vduse_iova_info {
  */
 #define VDUSE_IOTLB_GET_INFO	_IOWR(VDUSE_BASE, 0x1a, struct vduse_iova_info)
 
+/**
+ * struct vduse_iotlb_entry_v2 - entry of IOTLB to describe one IOVA region
+ *
+ * @v1: the original vduse_iotlb_entry
+ * @asid: address space ID of the IOVA region
+ * @reserved: for future use, needs to be initialized to zero
+ *
+ * Structure used by VDUSE_IOTLB_GET_FD2 ioctl to find an overlapped IOVA region.
+ */
+struct vduse_iotlb_entry_v2 {
+	__u64 offset;
+	__u64 start;
+	__u64 last;
+	__u8 perm;
+	__u8 padding[7];
+	__u32 asid;
+	__u32 reserved[11];
+};
+
+/*
+ * Same as VDUSE_IOTLB_GET_FD but with vduse_iotlb_entry_v2 argument that
+ * support extra fields.
+ */
+#define VDUSE_IOTLB_GET_FD2	_IOWR(VDUSE_BASE, 0x1b, struct vduse_iotlb_entry_v2)
+
+
 /* The control messages definition for read(2)/write(2) on /dev/vduse/$NAME */
 
 /**
@@ -265,11 +317,14 @@ struct vduse_iova_info {
  * @VDUSE_SET_STATUS: set the device status
  * @VDUSE_UPDATE_IOTLB: Notify userspace to update the memory mapping for
  *                      specified IOVA range via VDUSE_IOTLB_GET_FD ioctl
+ * @VDUSE_SET_VQ_GROUP_ASID: Notify userspace to update the address space of a
+ *                           virtqueue group.
  */
 enum vduse_req_type {
 	VDUSE_GET_VQ_STATE,
 	VDUSE_SET_STATUS,
 	VDUSE_UPDATE_IOTLB,
+	VDUSE_SET_VQ_GROUP_ASID,
 };
 
 /**
@@ -304,6 +359,19 @@ struct vduse_iova_range {
 	__u64 last;
 };
 
+/**
+ * struct vduse_iova_range_v2 - IOVA range [start, last] if API_VERSION >= 1
+ * @start: start of the IOVA range
+ * @last: last of the IOVA range
+ * @asid: address space ID of the IOVA range
+ */
+struct vduse_iova_range_v2 {
+	__u64 start;
+	__u64 last;
+	__u32 asid;
+	__u32 padding;
+};
+
 /**
  * struct vduse_dev_request - control request
  * @type: request type
@@ -312,6 +380,8 @@ struct vduse_iova_range {
  * @vq_state: virtqueue state, only index field is available
  * @s: device status
  * @iova: IOVA range for updating
+ * @iova_v2: IOVA range for updating if API_VERSION >= 1
+ * @vq_group_asid: ASID of a virtqueue group
  * @padding: padding
  *
  * Structure used by read(2) on /dev/vduse/$NAME.
@@ -324,6 +394,11 @@ struct vduse_dev_request {
 		struct vduse_vq_state vq_state;
 		struct vduse_dev_status s;
 		struct vduse_iova_range iova;
+		/* Following members but padding exist only if vduse api
+		 * version >= 1
+		 */
+		struct vduse_iova_range_v2 iova_v2;
+		struct vduse_vq_group_asid vq_group_asid;
 		__u32 padding[32];
 	};
 };
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 720edfee7a..f3282b8e86 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -141,7 +141,7 @@ struct vfio_info_cap_header {
  *
  * Retrieve information about the group.  Fills in provided
  * struct vfio_group_info.  Caller sets argsz.
- * Return: 0 on succes, -errno on failure.
+ * Return: 0 on success, -errno on failure.
  * Availability: Always
  */
 struct vfio_group_status {
@@ -964,6 +964,10 @@ struct vfio_device_bind_iommufd {
  * hwpt corresponding to the given pt_id.
  *
  * Return: 0 on success, -errno on failure.
+ *
+ * When a device is resetting, -EBUSY will be returned to reject any concurrent
+ * attachment to the resetting device itself or any sibling device in the IOMMU
+ * group having the resetting device.
  */
 struct vfio_device_attach_iommufd_pt {
 	__u32	argsz;
@@ -1262,6 +1266,19 @@ enum vfio_device_mig_state {
  * The initial_bytes field indicates the amount of initial precopy
  * data available from the device. This field should have a non-zero initial
  * value and decrease as migration data is read from the device.
+ * The presence of the VFIO_PRECOPY_INFO_REINIT output flag indicates
+ * that new initial data is present on the stream.
+ * The new initial data may result, for example, from device reconfiguration
+ * during migration that requires additional initialization data.
+ * In that case initial_bytes may report a non-zero value irrespective of
+ * any previously reported values, which progresses towards zero as precopy
+ * data is read from the data stream. dirty_bytes is also reset
+ * to zero and represents the state change of the device relative to the new
+ * initial_bytes.
+ * VFIO_PRECOPY_INFO_REINIT can be reported only after userspace opts in to
+ * VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2. Without this opt-in, the flags field
+ * of struct vfio_precopy_info is reserved for bug-compatibility reasons.
+ *
  * It is recommended to leave PRE_COPY for STOP_COPY only after this field
  * reaches zero. Leaving PRE_COPY earlier might make things slower.
  *
@@ -1297,6 +1314,7 @@ enum vfio_device_mig_state {
 struct vfio_precopy_info {
 	__u32 argsz;
 	__u32 flags;
+#define VFIO_PRECOPY_INFO_REINIT (1 << 0) /* output - new initial data is present */
 	__aligned_u64 initial_bytes;
 	__aligned_u64 dirty_bytes;
 };
@@ -1506,6 +1524,16 @@ struct vfio_device_feature_dma_buf {
 	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
 };
 
+/*
+ * Enables the migration precopy_info_v2 behaviour.
+ *
+ * VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2.
+ *
+ * On SET, enables the v2 pre_copy_info behaviour, where the
+ * vfio_precopy_info.flags is a valid output field.
+ */
+#define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.43.0

