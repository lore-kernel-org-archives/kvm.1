Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB2343887
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779926703; cv=fail; b=HxaNjKjl6J9pCVmTQPjayescbis0VI68/kZKvH9lQsyRHN/EiMYl60JyEnvpj4qvHU69hK81Zm15qlWGNLP9n+jtPZGZ6Qxvx8U73nP/8qil4Grm5Ko4hODYuSgl/vYLF7ldhvOYiT4mtafO7Eg6q73dduTBuMCuyCSNqY27Lvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779926703; c=relaxed/simple;
	bh=Ib7xZ1bs71w+5fcJP6A29wT0egkzPOLTlrr4ej4deUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kER2UR4b9jNU8D/334aqqh3tEa6bvnYrw5d11NIqoWUxMB+JHp6hd3WtN/Q3JOaAenhN71FLrkQ7vWO+izfBv3wqvy1HMmenwzH0gHBFe+5op9PXjHtcWIi91ZfcUwIFFzhXC+uq722KY29CjlgagP9LUlnDs1rAXk870R64Ptg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O6hUV5T+; arc=fail smtp.client-ip=52.101.62.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O6hUV5T+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmIi6g1GbUvj93I4NKg1FJ81sAT00rGQlhQD6Nqd18lfyQvFTyUulnnSUcau6TjI0ZeHa6Hthez0czGVrL5TMfjaPQDqW/k00nHt8FHD/V4ap9bsxYpg2dyE+DnKPrmlxkYlwZOpZie8/PMrsQAq+1muvRXACVzi57Ebh6rNahlGwuEfUYFo+AjQNuJDPRcgq9N7iOFfSFOfcL4l+32IyG0yRac07erMJmYJ0EoALT2FU+bp9aKm0rxRaqDfx3RdQdzoA4GoYT8Jxi69eCxxZW6OYQTRyBmJAL8xZB8ymdtTAVfbntu+JCM+771XC3o7LNk1z2MxTr5i7Hfwiimx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUghxL4UuHiU2joTwH4t2dr+EvJ6Aq3A2Gclj5UCsSI=;
 b=kdG7GEVkaAInrwnyQRhDfUSdN610otw1oW3SchiSOn+VXVHvVSL5ioS26RvlUc7mJ/2jr6m6piFFsOOkxJg63ru7hQ6IIt2EG6cDrOEwS5pNcQNl07i+X6/mMRbe8AUAnmXA7UZZx+IR+Z1ffh2aa0hVAUE0mVOxRTrFV0vxllNBQXhFvCWG/9tTdbtaFuGfJrGkD0VmonBl9IuVFqlA8FzNMCKf8Kun3XJM2YAmEk7gebCKOX17TVuthKtgpepGJtsQwsPOk5IFPHQ9WPP5ymi+Doe8Ae31RDih+WTasf183W+NhsoQ/IlEBblTJiI8SQzBBsrwC5KOEzDP1T9bSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUghxL4UuHiU2joTwH4t2dr+EvJ6Aq3A2Gclj5UCsSI=;
 b=O6hUV5T+LIYvJKL0t17hqFTFC7xm06fqSX62r7R9jrnqQoFYgr4FCY5F6MQxNTRhvga/CGZimuKnHKGFlAddb9DTirEccMWrBpRt0ls6RPWQ6vXogGclX/5eBDAK8WboXe6pcZJ9BiOL+MrJ1SkJsRXGAa9swhMb2VrlreKysRU=
Received: from SA1P222CA0123.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::10)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Thu, 28 May 2026 00:04:57 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::52) by SA1P222CA0123.outlook.office365.com
 (2603:10b6:806:3c5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 00:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 00:04:57 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 19:04:57 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: [PATCH RFC 09/12] accel/kvm: Support shared/private conversions via guest_memfd ioctls
Date: Wed, 27 May 2026 19:03:34 -0500
Message-ID: <20260528000416.8161-10-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ecd3c37-fcda-4f30-c3b4-08debc4cc0e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ru6T1Zzz/NX52sXzXAtNH2DB1GnwpZy8+i0/+u2bX5is0snizzDaMR3YifRSBYlKPSPJ9El9yFrve9pJqrrRa6brUL7zx8JxmFs16euX03Uef0NMvm3Y+5fepdLwXFBTK6O+clWKMD9E0DL1JcchCH9gU/cEB+x6cmL0eCY9xjgStjBfpYnV50hlkMdlZ94ONbjEa4nFQk0jr1ee3/XnPl95NLEDO9NoBkvfYXyeWWvOZ8prlERczFnveNwVPryXpbVm7Bz0zf1gSlKorPgXn4ncW1591IlnaCAYTTC02PGpTZmtLGhluqa53vnOIGOFwAZyT1K0G1IJuuYTOYnQkjl53radfXzXg3Q2NK3+r12049aW+R49BlNQEG0gV1ng4NnWg+JbveCbS4rJpoTyPgWU7r9hKQqY8L/ZSAEcxj4fl1KalRDGbUFl2HtqdlEgf3xg+qeKNpt+O7G1JRvfen9MXEBoBH/JFZYWKLeGMe7G94EAQgJaA2+K6ljRyfHuiKdHtBfJ09GnWqvg6LKkuEFLfAhzm8USbX6MyfESFCIvzwOPR3v5B1EuZ/v/D/sXN31FTgPGLIEGKMbUb323f/P1h7+zOm3QMaafZoiySJVKR5bsifNVvIe1uRlCYemHANBjB28dhP3+pl95XRnrptKicbG8CS59Lehjfx2b9beYWfJWQyD4dd4lUTiZjdAWTn1M6NSZCv192OyEcw3BTvwCsukoAFsiJPLcvTQMgpY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z6rn3MTXvrX0kxESyPtKNylAcWERImkjsQmIUblPPGrFY3HBq/AYNdwRUT45wR6krWqCK79k56xs+hgRhYen1knkSFbWlC1Ff3X9kHM7xXVPWMa/s8/nSBk/fd19QjEWjjxTsVVMNctl1yoGn3k7IRdvjjxK2CBKoiQCbviaDYKTg/B5hjQXFmw4ebZsCvdsVgTjg1qsH5OlktH4OV4RQZM7oqjBspss/Sd2KCxMQr0HY4Hln12xgnAjIhI0RJe0txr6ihwEb7JOYMil/UHgeDb8SgB6ejNA8Og/HXgbX8GJu4BvyVwnstxRaiWG2MVDxnESlJugzjwh5klSH45rKn2rkHCDbyvVlRcK44pgpUPvbUygPHPNzHmyhZkSHpQuNNaSHgRUAuXzVV2gs8/TjTTJza+4i5UXZmDDUKIWKYv+NJ2WfXN1UdXzC6l5eJY5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 00:04:57.2323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecd3c37-fcda-4f30-c3b4-08debc4cc0e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592

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
index 62f2e8aa15..fd01435a0f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1626,14 +1626,78 @@ static int kvm_set_memory_attributes(hwaddr start, uint64_t size, uint64_t attr)
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
+    struct kvm_memory_attributes2 attrs;
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
+    assert(rb->guest_memfd);
+    convert_offset = section->offset_within_region;
+    convert_size = int128_get64(section->size);
+
+    return guest_memfd_set_memory_attributes_fd(rb->guest_memfd,
+                                                convert_offset,
+                                                convert_size,
+                                                attr);
 }
 
 /* Called with KVMMemoryListener.slots_lock held */
@@ -3447,10 +3511,18 @@ static int kvm_convert_section(MemoryRegionSection *section, bool to_private)
     hwaddr size = int128_get64(section->size);
     int ret;
 
-    if (to_private) {
-        ret = kvm_set_memory_attributes_private(start, size);
+    if (current_machine->cgs && current_machine->cgs->convert_in_place) {
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
@@ -3544,7 +3616,8 @@ static int kvm_post_convert_section(MemoryRegionSection *section, bool to_privat
     return 0;
 }
 
-int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
+static int kvm_convert_memory_full(hwaddr start, hwaddr size, bool to_private,
+                                   bool pre_hooks, bool post_hooks)
 {
     int ret = -EINVAL;
 
@@ -3588,10 +3661,12 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
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
@@ -3600,13 +3675,15 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
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
@@ -3614,6 +3691,26 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
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

