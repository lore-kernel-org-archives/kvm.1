Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799213B95E7
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900912; cv=fail; b=ilIzzY1Hp2dnGO8023Kldf+SL+1JVaFcrrpXO0A1clzFS5rU+ooCJue1uEtug844L1HCgwf8XOUA0tDyjPSnzO22H/LlxQWiChj+6KfbGb0abjd30dimRLiNwOiZuUpZCJpJs7pFoca2Qqtuinit/u8yKCD1w7pMSsxWQXy9DXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900912; c=relaxed/simple;
	bh=T75g4Hj13dujNwLNVUs9JdPXFo2dHOlzEWaP2QWD5w8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plfNq4yS22nN1NlR+IOT7oeZ8A1jmFbd0VyUFV19JcHdKgh5Jt2H0L1pTQm+XackkQsm98A57nmUOlROyNwF31kCJv1G8eUFmsNLkwivaggrktkdIF+Tn9AczlNRrRtfWAnVBqqYQhXJ+AEVpb5OWTxa/89pD7IRzFAcZUFGggA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=483jjlxo; arc=fail smtp.client-ip=40.93.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="483jjlxo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSD9o2wq4tFkRgsYTgsu1A6NtU4ogz7DCGohfaNuQ3yfAM4YPni/sKhff0LTEgTuHaGq0Uv0VrjQXfnuOb38+H1dNU218Y+93nv797g/6jSEd5UqFJKhlOpt9kEUl9FyLcRANXNIquhKkF1cWgSwvdXBWXP11+Xz7wV3uIPGIwMWlamU7klYuirBqEq3zvrQB48egSBzE1Znu5XAt+pH8Uz+WT6nz0y3ciUrZFVWjmyCJlr/3RjgFtNYREzsEuHbvFpufKDjYhwtoeDoNKiZ5VwyV0ytAv/sT+PwBrign2/mXYFdhRzs5PXEzbqu2KT1qGl4NLI4p/uypZBeQD2ciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wWcfZ6zProw8uSdMUCsXZ5Ke0HjGPfWcPwMrGMLbZY=;
 b=cdG7NNdO+mnURGNmH4dr9LLkelcrJopiGZFIHhUf6QWyXbSLqgnFro8JrO0UOig1q7J+xj/Wma0jtojR7UQD/t9rLRZl3+aZNL95PlsNkkVIBSDB7NctHvO0XUtQqv5l8sWYtG6RVIRZPYWxmAFB/JypYzlrsfJrWPpUW2tIbG30FESfM3Zkq9q7XxypNPE10h+xMoYmI4WlgOnjSPHJy73jsO45iRUbVCuEZT8Ek0pocybi7pZUBjexIxUanYSIOpG/0sQIJbP0BeDz4U26qKFCYYHpmLapcsWNkCyeglkqIEtmKZjDa/QiYUfNA46Yz1nTYnEpWok15W0YBNMHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wWcfZ6zProw8uSdMUCsXZ5Ke0HjGPfWcPwMrGMLbZY=;
 b=483jjlxoXaZXw1h5jvwCImKO8lmZ+fLdiO8pJzg5MMQcGDvHq6+7NHc0FjXvmKf57tTS7gra1uavmow/pSCmj2fsye7vQNAjC3EIOO8P6qbgsd/wR8jrh6oI7y41QkoLqrjKP4X4rtfDhiQ0KGeDOHj16MF5HmB4scTSnK3lqnA=
Received: from CH0PR03CA0068.namprd03.prod.outlook.com (2603:10b6:610:cc::13)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:55:04 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::d) by CH0PR03CA0068.outlook.office365.com
 (2603:10b6:610:cc::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 20:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:55:03 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:55:03 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 13/19] accel/kvm: Support shared/private conversions via guest_memfd ioctls
Date: Tue, 8 Sep 2026 15:48:33 -0500
Message-ID: <20260908205236.838281-14-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908205236.838281-1-michael.roth@amd.com>
References: <20260908205236.838281-1-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: ed402069-4161-468f-61b3-08df0deb74d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|23010399003|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EnTbhjL+E6MVUvRXd5lqNBDX07mLZBigUHAtp+vghJv/oEr/2/ptpAr1GzJIeghnW6oKfYijHHYBjBnaCwTzuF/DgFAKjlgFOHp7Gx9JDhp2fMUL+cv6n5sGa8m8rwgfUwcK3Ra4mdolMJokG78gEyC3hpp4Itmp2jV7SYst8SqNwD0FGPdOPIwvP9t56+INtC0qdcJucbZjEf7YFN/gT1lXNX23mQYtxf5z7nBNrQeTBpc4QpSPjEVuHwiKzAqljUX5RMtMyHfuALLGzbgpRaKlia3kyuEPZIE3216qxSCY7RmvQ1ALcxYgMIJTjVG8O9ndtyOeMcOo5/LI2I1qUvMvrU9nHfrGdLShDo8I/J8jrYI3bQhze8snZte0488dh8PF0TmCo+2PWIhMMYW5Teo+XwV5Pb/7QdcV20JO4PQyrt4WwuSt+8u3lLEaBZv5C4pcuiGrOIu3gQxIjHJhSJM+NRjTX4cMkKM6sNjVKez0avfvA0glqaJrivcZrZspG/o2fo3rL85RozrTzWXp81VkayxWwPLZlE41+VUQ09ymExpzjudCXCfHt6NuzUSFHfatcJi7VY39pdik8GRfg27GAFTRW/3yLhB1PFtIKSZKQuUQ4I7MDcn9yYWNtn4HynCDwu5sChWgv4T+OVn4fspxDaBVru6AGkujdKBzaifXoz4kzCaJK8Dh+TO1AnkZvZca9MuFKtlZ6s/dRja/hQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	10d82bA4DFUayHLzYWlJlbTgV0bUYb8FBHZE+Scxxm5tVXZHJlZDlAGgP22K0iN6+K1GAV7ARtWAL+EKRpDqkGF9wCWXiaXDLIA4u37BH95VNWqEadFigWejqqLPw0l08zDYALj7BoF5Z+Wp0W4turJSAOLabjddickxWcvSYGDA/otKJrlJd4f5C6LaT+XkJ1FD/GGPipzGxUVuSkVemzQwnvUeHu7WlFvMBeQFYoHF2S3G9HqfdhNJ3t3YGtQhgM9XctT04xcqJ2dubFVqVQomVj6+sBZ8/hdwkp5edMA2TNgGxPtImYlmpiOWm74eK+/l9VSsZuM3kLKNkx/0AOS4PsStKnZ9ez8nOSwU6tiQrSgyLl4gJWXzoD8I/GZ3fXolGKRh8scveAZ8Rsw8JSCUofwjufbPJowKBNYlwkwkL2YXw4VAWOtKuUdGKQF9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:55:03.8208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed402069-4161-468f-61b3-08df0deb74d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310

When using guest_memfd with support for shared memory / in-place
conversion, it is necessary to use the guest_memfd ioctls to handle
conversions instead of KVM ioctls. Implement support for this by looping
through all the sections within a converison range. Implement everything
in terms of the kvm_convert_memory() loop, which already deals with some
special considerations regarding various holes / region types that might
be encountered.

Also update kvm_set_memory_attributes_*() to use the same common path
when convert-in-place=false. This potentially results in a small change
in behavior due to the additional MMIO checks/skips now being applied in
that case (generally qemu-triggered during setup) rather than only for
kvm_convert_memory() (generally guest-triggered), but this is arguably
safer, and it provides similar behavior between convert-in-place=false
vs. convert-in-place=true, the latter of which *must* skip MMIO holes
because the regions (and associated guest_memfds) themselves track
shared/private state internally and passing the whole conversion range
through to KVM is not an option in that case.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 131 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 114 insertions(+), 17 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 17e25f9074..fcb6f3bee9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1624,14 +1624,78 @@ static int kvm_set_memory_attributes(hwaddr start, uint64_t size, uint64_t attr)
     return r;
 }
 
-int kvm_set_memory_attributes_private(hwaddr start, uint64_t size)
+static int kvm_gmem_ioctl(int guest_memfd, unsigned long type, ...)
 {
-    return kvm_set_memory_attributes(start, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
+    int ret;
+    void *arg;
+    va_list ap;
+
+    va_start(ap, type);
+    arg = va_arg(ap, void *);
+    va_end(ap);
+
+    ret = ioctl(guest_memfd, type, arg);
+    if (ret == -1) {
+        ret = -errno;
+    }
+    return ret;
 }
 
-int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size)
+static int guest_memfd_set_memory_attributes_fd(int guest_memfd, hwaddr offset,
+                                                uint64_t size, uint64_t attr)
 {
-    return kvm_set_memory_attributes(start, size, 0);
+    struct kvm_memory_attributes2 attrs = {0};
+    int r;
+
+    assert((attr & kvm_supported_memory_attributes) == attr);
+    attrs.attributes = attr;
+    attrs.offset = offset;
+    attrs.size = size;
+    attrs.flags = 0;
+
+    /*
+     * guest_memfd may need to delay conversion requests due to
+     * the memory being in-use by the kernel. In most cases these
+     * will be transient uses. In some cases, userspace itself may
+     * be the cause of the memory being considered in-use, though
+     * QEMU currently takes steps to avoid this (e.g. via
+     * RamBlockAttributes). On that basis, this code loops
+     * indefinitely with the assumption that only transient cases
+     * will block, and that those will be for relatively short
+     * periods vs. the overall conversion path.
+     * If those assumptions at some point prove false, most likely
+     * this will manifest as guest-side lockups on their conversion
+     * path, which seems like the appropriate way to surface this
+     * situation to the guest owner rather than some hard timeout.
+     */
+    do {
+        r = kvm_gmem_ioctl(guest_memfd, KVM_SET_MEMORY_ATTRIBUTES2, &attrs);
+    } while (r == -EAGAIN);
+
+    if (r) {
+        error_report("failed to set memory (0x%" HWADDR_PRIx "+0x%" PRIx64 ") "
+                     "with attr 0x%" PRIx64 " error '%s'",
+                     offset, size, attr, strerror(-r));
+    }
+    return r;
+}
+
+static int guest_memfd_set_memory_section_attributes(MemoryRegionSection *section, uint64_t attr)
+{
+    hwaddr convert_offset, convert_size;
+    MemoryRegion *mr = section->mr;
+    RAMBlock *rb;
+
+    assert(mr);
+    rb = mr->ram_block;
+    assert(rb->guest_memfd_private >= 0);
+    convert_offset = section->offset_within_region;
+    convert_size = int128_get64(section->size);
+
+    return guest_memfd_set_memory_attributes_fd(rb->guest_memfd_private,
+                                                convert_offset,
+                                                convert_size,
+                                                attr);
 }
 
 bool kvm_private_memory_attribute_supported(void)
@@ -3439,10 +3503,18 @@ static int kvm_convert_section(MemoryRegionSection *section, bool to_private)
     hwaddr size = int128_get64(section->size);
     int ret;
 
-    if (to_private) {
-        ret = kvm_set_memory_attributes_private(start, size);
+    if (machine_require_guest_memfd_convert_in_place(current_machine)) {
+        ret = guest_memfd_set_memory_section_attributes(section,
+                                                        to_private ? KVM_MEMORY_ATTRIBUTE_PRIVATE
+                                                                   : 0);
     } else {
-        ret = kvm_set_memory_attributes_shared(start, size);
+        /*
+         * Without in-place conversion, attribute-tracking is handled by KVM
+         * across all guest memory rather than on a per-section/slot basis.
+         */
+        ret = kvm_set_memory_attributes(start, size,
+                                        to_private ? KVM_MEMORY_ATTRIBUTE_PRIVATE
+                                                   : 0);
     }
 
     return ret;
@@ -3536,7 +3608,8 @@ static int kvm_post_convert_section(MemoryRegionSection *section, bool to_privat
     return ret;
 }
 
-int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
+static int kvm_convert_memory_full(hwaddr start, hwaddr size, bool to_private,
+                                   bool pre_hooks, bool post_hooks)
 {
     int ret = -EINVAL;
 
@@ -3580,10 +3653,12 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
             continue;
         }
 
-        ret = kvm_pre_convert_section(&section, to_private);
-        if (ret) {
-            memory_region_unref(section.mr);
-            break;
+        if (pre_hooks) {
+            ret = kvm_pre_convert_section(&section, to_private);
+            if (ret) {
+                memory_region_unref(section.mr);
+                break;
+            }
         }
 
         ret = kvm_convert_section(&section, to_private);
@@ -3592,13 +3667,15 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
             break;
         }
 
-        ret = kvm_post_convert_section(&section, to_private);
-        memory_region_unref(section.mr);
-
-        if (ret) {
-            break;
+        if (post_hooks) {
+            ret = kvm_post_convert_section(&section, to_private);
+            if (ret) {
+                memory_region_unref(section.mr);
+                break;
+            }
         }
 
+        memory_region_unref(section.mr);
         size -= section_end - start;
         start = section_end;
     }
@@ -3606,6 +3683,26 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     return ret;
 }
 
+int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
+{
+    return kvm_convert_memory_full(start, size, to_private, true, true);
+}
+
+static int kvm_convert_memory_attributes(hwaddr start, hwaddr size, bool to_private)
+{
+    return kvm_convert_memory_full(start, size, to_private, false, false);
+}
+
+int kvm_set_memory_attributes_private(hwaddr start, uint64_t size)
+{
+    return kvm_convert_memory_attributes(start, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
+}
+
+int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size)
+{
+    return kvm_convert_memory_attributes(start, size, 0);
+}
+
 int kvm_cpu_exec(CPUState *cpu)
 {
     struct kvm_run *run = cpu->kvm_run;
-- 
2.43.0

