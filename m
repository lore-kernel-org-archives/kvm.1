Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E18495504
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380745; cv=fail; b=HthirOlkItukYqeJJMkrFV0kYlH+VI/3hTU+ETUo9aisTUMv/uM64MCc5DntPA7RNrmz7tZ5fyfdb7UFRoUd1BP8QyLM2F7bCeptakBfZy2idZEjypieG5Dpn+U7wyDVKs8oZKr2+bAfMRHsVTQzoBoQeqG/y09KHiB7M2QeHFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380745; c=relaxed/simple;
	bh=kPAKAsZKgZKlVm1KWs+MIqB0ECQutsVs7sMUxndECQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXijHWhYN893wTm9kOoCJiKXJN9faG5fWYisiMTZLuiwknnNwtkggIAVqgkGu5gubxj78y3SgQs7TrB/VuQ4wyOOKOJH9Fcybe88ZT9mkwqVT34g8oM7SmPwCn7EMO7PbLmPQRA/9+YI9HrEDM6QGii+hEHEPAQd0ccd8z0fFRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uR9NQUhF; arc=fail smtp.client-ip=52.101.57.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uR9NQUhF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJcljWv8UPQj2Ov/iugEb9vVMOLdP9pkSEPMcVDWyH9FQLDI9UOsqQ4CeuEsZtxjXzghQD9fB0X4SjXumJ0jcejm09wEWeE1StnIvV53U2Hq335c5l83u8uOm8IcfSpRiNzq5isehpVc6Kkgg9OQi0eJgxZ6cWFDe59mRxcvmn3rtO3G41cS7K/lrbsEroQZcK8ANLbuZ4ZzW0f8RUD9cXGUPvG7Sp7FQ/uGUaDt7itEKbNQEGVcMOZ/KfgzCJtRR39joO1lWybWtsSof2xSUqkwAPC/SMeLPgCDyIoy2Mqav5I2BHYbi/X+aef/7oXRhkjOTxLClooqf8OznBAX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvscxJty+4OV3tzxnN+dSPhVbPWFnZaOnZPEI7/2UsU=;
 b=Pz9Dy94KkqVZrZ+ybYmgP7fPUFrtCmGp1dlxuQ7zBKh+X/SFZHoocNun3cOZL9WwFJtomzfzE5eY8p9R/q47JWHysYYnclsQeQ0g9lJJtKXXUZJ8il9p+Lx+X5UejrLxpNx7ffNxj6QZQzGF/+WMVAQiKKhx3Bs0CI0JAE0QqEYo+dNqr4zlI3qD/rcNVTLVGQGsE4s51wE5Lgr7UgtPrxL6hpHvJXhWrTG9pTzDo6nsj9GKPbq1b2Zynfwe/zGL0XCtP7xX2K5HQevNUxWaquRnvnLbkrPwn+07+h/pxKxBRQp3gnOoVe0D7xb2HIZqaQT+hA0Z94K7eUknOZ23sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvscxJty+4OV3tzxnN+dSPhVbPWFnZaOnZPEI7/2UsU=;
 b=uR9NQUhFUBFW+3NiwSAJj1guK47CyPgangqmHjgCICi60qumOMwpbp0a7kjrRzAN+GgpydltaFiaGdqYkw3yM83zeQMajlXyqtfgwVH3YkB74ExS7cOT5jhgBQQiNfdwhtvNAzSR3VbQ4YDO++uUIIkWYpARIiiEFxqjKncEA1Q=
Received: from PH0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::28)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 13:45:31 +0000
Received: from BY1PEPF000264B4.namprd02.prod.outlook.com
 (2603:10b6:510:d3:cafe::53) by PH0P220CA0014.outlook.office365.com
 (2603:10b6:510:d3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 13:45:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B4.mail.protection.outlook.com (10.167.242.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:45:30 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:45:28 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
	<ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 13/19] accel/kvm: Support shared/private conversions via guest_memfd ioctls
Date: Wed, 7 Oct 2026 08:41:37 -0500
Message-ID: <20261007134323.1606088-14-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007134323.1606088-1-michael.roth@amd.com>
References: <20261007134323.1606088-1-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B4:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 030aed6a-b6d0-4632-da30-08df247940c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|7416014|6133799003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	6NjOtYU0WT5JrrKvre8radpVO8zcnwOm2YEamgGsmTibLnAeGnfz+PDZIB8AceTPp+RMfmvNTdVmAQEIAdaSHwxznXbZQNTjC8hMFJxPEWSWXfQoj++MVf4yHHLkTmXmykBamXB3oF64VF4ypylB2dUTHYOu+62wky554nAi7lNQW+adeqV8tLfzrTVF6vC/lJKN22MAN4FzYIxHsc8ZxYYTMWTtAOjrA5sZT9oI1YHipzRlY4KMRHzHqttA+DeFljWsY4BZ5/OtMIY317jffBvbz3R0YhFTqjX0b06MjEzqtVh5qr7X3uy8N66J5PmhayvevWr/+b1y3qYyO+OQgOEqKQ2P6RcOjfKDayR9UgUdrbm/rFODVqyto1zS+UHj2o5uj8xiudXoAllI4m0+v+dSNHwNZDChS8j+9AwB9VVB/dI2fReiJegifgdsQ6l7sYHUWI5eZtXR2dK+yZURqhn/iNt0VxRR6zw+UlB6UJZdY+1+w465V+eN4sgHbb72M5a/qgcH7/OlbBanJ2ODDc/7cjTBsEcvXX8VuZhNn4B/UiG2SFcvGuB47tRgJ+a/K8C73WxYYZ8afqbm07iZahejveBFgF7PPMR+Q58mCNEoNGUTVUVI83sLP3cfFGzKJjaAd64eILLfd7qOmled5lucu5crGjhyrEMfd5Y3Fj5Vja8ZkRHOeJRDPuvEED84EC19fcvqfBDQDv0QDOTeBg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(7416014)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hM/ptapnzOQrk9ITuRH2NRr50aFX/JHWnSHWWqz/x+GH2EkabLY7cqAplD4q8G8lim33bdhot7LZx0cu2tHzPJrnvmGLjkTCrpjute5ww6QWuolmyi9ol/+4VAV8Lv5Ql0vOarWIB1O8VoUOfPsbXmJaccDJOmfn09GWZv5Q/dzL+DTzUPMJm74mKuzS9bkiF1DekxAbCGdwS2AG2rYASNYwpa4T24iN06FK6E9tu3fet4e3rLat9539ags1rpsJtI2iWQIZBBQ4peU5JnIi4bVW+wpHjXjkNXPhG/ghISNhYAV9ZNcooVRfzCsmzsuRsb8PymSsFY6RAWMX71szHAs9epofkueawUWvn0+sGm4jwnCZ051ouYHQq28uLpuodWYbsUqtHAqzfgzD3R6FN9MBLSwmlRcXnTIJVxNDl6wl6SZD7JVkZNtZvk5i68MO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:45:30.5255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 030aed6a-b6d0-4632-da30-08df247940c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440

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
index 60ab5193c9..2d4cba1a3b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1623,14 +1623,78 @@ static int kvm_set_memory_attributes(hwaddr start, uint64_t size, uint64_t attr)
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

