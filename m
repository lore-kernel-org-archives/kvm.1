Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C90564
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779926807; cv=fail; b=N8dg+StFruLVgwyqpiagngwOnaWNzdlI4yc8fLMac9CuyXDdJYTTb99DFI5uwI9FN8TNJLbXFlU863NaPPaCQ36cIzE1YLgPYryqbhPm9iHrkcgHkC5A2hISJFlcR7/RJA3Ag4T/Ai8RnTrTxr2fXR9RHVbpb8ChpMFVdTEOSfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779926807; c=relaxed/simple;
	bh=R/ZYKWyrdOsdTdLabjyKHOoXNEnR23rFf1D1GyoqazE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J89bYDpyC0r50rwwHSK0W3R9uu3XdRFH3e4yLigmIujk5Vivv5LGFT3xc+ZHWIECtCo0MQCYDet4Nw+AqVMNjdp54RPwxmXiyRfvDeyMraWu5yw0yFpU31Z/DVGreDqxgw3ypU+RS8axsbScg+aFqcERhBww3pAVfTcYfyW7DM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SvCqHa8f; arc=fail smtp.client-ip=52.101.57.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SvCqHa8f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkkMgIMSNwezHkmXpXn5dgbeemxz1gvitxSHc3gQ4P94SI1nN1McfEoX/4bvn2uv9tJYmwSC61Fnz0LLGIesWRK5B+A/VaqjuaK7sMfeFlPdwzB1Ftep64/nfBYF6cYonwQYDkz7/PbPavh1Au8UfYZTO+taufL/bdszMlg/w4uS04CR62iQWs1S/uBdmLGb4Yh1L86ET2RbRXEmVTjK3ynjZih1g1AnP8bD496wvqU1eQ0Gz1Dt9ycBs2jbSZjbligEjWCbKsqhEFvQ4Ss0TeyEsfTcoh++Av4MGwTvWhvM10TmuGrU5nJ4+MINz59jnuw5hNVqFXQg12h+NeX9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtMqU+Z7r/iC6dFVUfUvh7Dedue+Qx7VZulVemFDXaE=;
 b=HqNlvQSUTej+POdWa4oisfiVwgCXjmY3S5EZS/YdjMiXJwOiqH2vA5P7UWsN5AGiWm6DfP1pYSzL4NwVqbmiGaIxwXNGYr2G5Rk4CPJaIohouKyL/Fq6FbrLIYb3Q51wKqq9x+4WrRVYM+IoGiUQPP8xNpP1T9g2LLcMS6ir6PCv81q5TmQcTU9g7XkVQhWUyCEUdMNedMp5k0FjkpSuGFDr7/JXtYI2Rdj7JxLLqU/6MXFSgKI4eBO4A2cpy6EARc3Gy6Y718oTJb3iEWFklCWJh77ET+In4ja+ROs3qtiBlvuP+9RSe79iNZVjieQ+u1CVNhqGKCwcA/7nlcmC3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtMqU+Z7r/iC6dFVUfUvh7Dedue+Qx7VZulVemFDXaE=;
 b=SvCqHa8fNjl0IEuUdq7LMXewe/YfQORDVf9Kuaa8cE/M1AMvqhrK3yOgbnytoaVPxuGzyvllb2IRl5XwMcV0vbIfvYowSFcZqDN/ahLjLl8iopRZ8a4mhqvZYH3JH2APSKwjsm0/YG66zP4xUu3sWK4LbQIcFjYqa+XkzIE3uo8=
Received: from PH8P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::8)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Thu, 28 May
 2026 00:06:40 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::78) by PH8P222CA0010.outlook.office365.com
 (2603:10b6:510:2d7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 00:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 00:06:40 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 19:06:39 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: [PATCH RFC 01/12] accel/kvm: Decouple guest_memfd checks from memory attribute checks
Date: Wed, 27 May 2026 19:03:26 -0500
Message-ID: <20260528000416.8161-2-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b30e9f-5a55-44b3-3958-08debc4cfe39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|11063799006|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Agal6DOEi1NeF55mlEzdj9hgLvFEFk41FYmJprtR5+EwIx8mFquS9PafW8wk+Ynbgy3JlSejDmcfUtjiObssV228oiRKC9seYswQ1IAkyeRD78rTU4lqIMCmaHubmujQiQ7WPNBVtYnXGwEHSW4e67HKuuRFVdwHDteEyi+rNsGblovkQUHD59LRx5PR548/Usv7ECtwermQienpsF+6YPGJWKjR7an0hZ3TnzbCEu/Ovqwmrf57wVF9He0IT4akk9RBYWeJgV6lsT2gpcbWmHThDEKmbueK807hbUWAvw/Lv8xCS5jSp/zazsxy3oBMa7zSDHneNNQPQcCKE7s2d7d5RoCo2zHyg2GLkh13186FdE8BYEuztpvNGvN5j7xP6bTZE5CCH65kp/TV+eEI7SFBjhQtAQziIn0EWvtRkBykiU3MzoCIIzZJ4YigQlzyk/hk4BmdZjDGd9mc9Jlp2LrluS1SCjWX7PiQh3oIw0TN3Vz/Pzh9guDOZjtkdRdr3jYBS76rf6TJGRtmhLQ+8t3UK+8mnE7vX2CBVbXRKiq+YNdoA4ma2NQgI76F2Ci69LtYZKZmbbWQf/Xh46RyacZbaXRkxU88PKEJwR0YzyayTzjAs8dIRe9fFqeNmQiOVUMlC+GQN0EW0yX0l7ajNURsGyvrFpZgIxF9OVk/2hipkQ6UBnH5hkgYvIUmqsYzStx3PN5V80MwbehLMHPcMI5cNT0xyBznzigTFg0rLBQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(11063799006)(18002099003)(22082099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Etm0OAbVPaSkx41YHq2kkFwmE97dlMLPaBw2v4GvVHXCvgUEl/4LbJEYfiVzLQGiGpxD0HMF1kw77MLla6OK/MsJn6Ij5qdd/2/+RbJM4efmoHBL81iW+Yi358ikWQd1JpOfdZzRo9chkwJW0ERMuPjm3mM/r5uk0skMClJASI/atX0rBilnYoqkwckyQXp03x4lLabasVUnFpwGHpfJUVKWIEljE2yu6uEmObSh0wBSWPcq9dAE0pet/f/FYFP++edWMIOKs2CKRQ8rMrbZKkyekOgzjPheLM7X5lwPoo4OYq+2GCDutTtr7Jb4dxqScBxNmfoOzp90IL/LvE35gcRqAmd5aO6Ei4Wpxea2ol6gNei2btyyKkI+rM0FKmebxQ+OTcM44G6yB+6PTLatDF82Vscz9bJYLVldiVQNXXDcDE6XaPEh6oApyA6+DsFk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 00:06:40.1225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b30e9f-5a55-44b3-3958-08debc4cfe39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451

Currently QEMU supports using guest_memfd internally (separately from
user-specified memory backends) to handle private memory for
confidential VMs, and as a result has checks for guest_memfd support
merged with checks to see if KVM can handle mapping private memory (as
determined by KVM_MEMORY_ATTRIBUTE_PRIVATE).

Future QEMU support will allow using guest_memfd not just for private
memory, but as mmap()'able memory that can be used by non-confidential
guests as well.

In prep for this, split the checks for guest_memfd out from the check
for KVM_MEMORY_ATTRIBUTE_PRIVATE, and rename the current
kvm_create_guest_memfd() to kvm_create_guest_memfd_private() to
self-document current behavior/expectations and disambiguate from future
helpers intended for creating a guest_memfd to handle non-private/shared
memory. While there, fix up the missing error_setg() handling in the
stub functions.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c     | 20 +++++++++++++++++---
 accel/stubs/kvm-stub.c  |  3 ++-
 include/system/kvm.h    |  2 +-
 include/system/memory.h |  5 +++--
 system/physmem.c        |  8 ++++----
 5 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 585f1cea35..02911ff6e3 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -795,6 +795,11 @@ static int kvm_mem_flags(MemoryRegion *mr)
     }
     if (memory_region_has_guest_memfd(mr)) {
         assert(kvm_guest_memfd_supported);
+        /*
+         * memory_region_has_guest_memfd() is specifically pertaining to
+         * using guest_memfd to handle private memory use cases.
+         */
+        assert(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
         flags |= KVM_MEM_GUEST_MEMFD;
     }
     return flags;
@@ -3066,8 +3071,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
     kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
     kvm_guest_memfd_supported =
         kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
-        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
-        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
     kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
 
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
@@ -4854,7 +4858,7 @@ void kvm_mark_guest_state_protected(void)
     kvm_state->guest_state_protected = true;
 }
 
-int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
+static int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
 {
     int fd;
     struct kvm_create_guest_memfd guest_memfd = {
@@ -4875,3 +4879,13 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
 
     return fd;
 }
+
+int kvm_create_guest_memfd_private(uint64_t size, Error **errp)
+{
+    if (!(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
+        error_setg(errp, "KVM does not support using guest_memfd for private memory");
+        return -1;
+    }
+
+    return kvm_create_guest_memfd(size, 0, errp);
+}
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index c4617caac6..1940bcbd2c 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -139,7 +139,8 @@ bool kvm_hwpoisoned_mem(void)
     return false;
 }
 
-int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
+int kvm_create_guest_memfd_private(uint64_t size, Error **errp)
 {
+    error_setg(errp, "guest_memfd is not supported for this configuration");
     return -ENOSYS;
 }
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5fa33eddda..aeb0c7ca8f 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -561,7 +561,7 @@ void kvm_mark_guest_state_protected(void);
  */
 bool kvm_hwpoisoned_mem(void);
 
-int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
+int kvm_create_guest_memfd_private(uint64_t size, Error **errp);
 
 int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
 int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
diff --git a/include/system/memory.h b/include/system/memory.h
index 1417132f6d..24c68720aa 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1745,9 +1745,10 @@ bool memory_region_is_protected(const MemoryRegion *mr);
 
 /**
  * memory_region_has_guest_memfd: check whether a memory region has guest_memfd
- *     associated
+ *     associated with it for handling private memory
  *
- * Returns %true if a memory region's ram_block has valid guest_memfd assigned.
+ * Returns %true if a memory region's ram_block has valid guest_memfd assigned
+ * for handling private memory.
  *
  * @mr: the memory region being queried
  */
diff --git a/system/physmem.c b/system/physmem.c
index 7bcbf87573..04c7c38721 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2202,8 +2202,8 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             goto out_free;
         }
 
-        new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
-                                                        0, errp);
+        new_block->guest_memfd = kvm_create_guest_memfd_private(new_block->max_length,
+                                                                errp);
         if (new_block->guest_memfd < 0) {
             qemu_mutex_unlock_ramlist();
             goto out_free;
@@ -2835,8 +2835,8 @@ int ram_block_rebind(Error **errp)
             if (block->guest_memfd >= 0) {
                 close(block->guest_memfd);
             }
-            block->guest_memfd = kvm_create_guest_memfd(block->max_length,
-                                                        0, errp);
+            block->guest_memfd = kvm_create_guest_memfd_private(block->max_length,
+                                                                errp);
             if (block->guest_memfd < 0) {
                 qemu_mutex_unlock_ramlist();
                 return -1;
-- 
2.43.0

