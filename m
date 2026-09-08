Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21332448BA3
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901200; cv=fail; b=VxqZdB/K6VFJaMeLnIW978gveDzjjSKrF0gnuG30Enew2vHkBwCjZTTYOAhO6rHra3ZT1HGZiUYNJqaJYQg7nm1voncttdAdy8FdB8X2XVghHCba26MnDOETga3OozAY265IzDnQg2/LisEZIRkw/V7ds6sYoxREOtqAmbMJk6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901200; c=relaxed/simple;
	bh=Gn7VJeKx2XRR0vXtbNmXoreRd9KRxR2e4EGQqE3s2ac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXF/HCLgKCXmnYmK2FhWMQV0GhWO+FZ8TRnYu+wD27zJGIjIGNDxF7+jEh0oht9o2O50Ak8B5ysTSr0uPFFx+4azgwOwfQmRvMiScE7ahQKgIUdkEnEUc7K5UbX24pMib5fETr/4KydRdePBGrtRAaQI/GVPb7gLk8aM5lCKN0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dr/8iqLv; arc=fail smtp.client-ip=52.101.52.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dr/8iqLv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edunwQ6g4x4s94pd6Tpz/BUyHy5jlvdO2LfjW8VmGPCwGqje+8ZZ7RROC4SXoQ1Q2mKoQzGURN8vzWtloNcbdycPv1ehrLlvSDwX/4Kuc9ikp822g6u1zJ92XaHdx0/JeQWvzhwVY+7aaKXTUhxbUmd2eQYKj8nP4Rh3ljPaDhzqW7/Ci77fvoSwJhYu1hbnNAFF7rtgPyq2IxXoR+xqN53xcP547d8TM3XBUIuwB3j0Ph7JKH46sWdBU0/Yw4EdnUrqCiuIJTQ0kVUL6PFqg1MAQfQqPNaLlRwTlIzwU5shJ7udymF8R2WNwhihayJsKxnZ7Hmt9uOxR3kFQEBVOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htLGLzxQ9IhSD2a0ak7YN15f6+aAVal5dyK17sxyuwA=;
 b=MiLw6XRXA6gc9UK6eAcroZ2+pT69wTZkbDngVSyuR9907u9rWcoHN9tZcfrvYu/UB+DXMXvgLwWMYVQmIwtlbKgmYOUzEpcsZJqx+TM9ZX3+sVzxQUbX1TxksykQGUdgf2w8s5FzvMDHsDdwQEACv+K8OH0l0YjIoWwtXzNul8AEvZa8KPUM7xRopLhehmSPcMOXF/b1t6DFQqiJD7enoF72VMB6MjMAB2Po2kzs7xR/4vKahVJqk9DA8cWvmt63xOxa9BBTVWu4aEgfDCIcU5vvcDq3/qq1DeAXCbda/C4CH0COSvxIa9O1HJ3kE7aHTnU2wrRijeJJWLfdoK7AmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htLGLzxQ9IhSD2a0ak7YN15f6+aAVal5dyK17sxyuwA=;
 b=Dr/8iqLvNi+XI6frjU82xuLj5kTDbqjrpFIr7UAyw464QaotapKyjGA5uJIXuXK6fHhFdrC2l47jKMWlLtoYZvI4luKV6dAoqQDhvXL0yn4ejh0iB/BugyFPmjbVjywQp85758utaKzFGszFKe6Hf9U1CuIcrcH9j4axo3lOiwc=
Received: from CH2PR17CA0008.namprd17.prod.outlook.com (2603:10b6:610:53::18)
 by BN7PPFFF39339DD.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:59:53 +0000
Received: from DM2PEPF00003FC2.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::46) by CH2PR17CA0008.outlook.office365.com
 (2603:10b6:610:53::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 20:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC2.mail.protection.outlook.com (10.167.23.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:59:53 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:59:53 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 08/19] system/memory: Re-use memory-backend-guest-memfd inode for private memory
Date: Tue, 8 Sep 2026 15:48:28 -0500
Message-ID: <20260908205236.838281-9-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC2:EE_|BN7PPFFF39339DD:EE_
X-MS-Office365-Filtering-Correlation-Id: e685d0e9-8657-4531-550c-08df0dec21a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|7416014|1800799024|82310400026|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UHBypfWcLk7X81DciF7EN8LJiQfl0aRHpu9qX9sR7mp5fQTM7ZYkENqF9p+CYhnCA+SjiUO/smarDmG02cZXkrU4/2brdj4bMBrn74mgCkEa8TaSuY2BzULod5xHiyP0Y9/TqsrxykCpMChEk4B+m7eGdOoj2DMoAm3ozQ0NEF04yWIXWz854zOWhse5VBIZZUekRj4MPfcQNBjs7AtkRlbLERHX8Yi26v8rVWmIQd4778gkHjknu//WgpDpiugA32yaZ6nbFIICv1g3fUaQ+z0Ej6QZHfg+9faWW4qN1NpHKKixLmbMQaRhtk8vgW/tahEMGvYdY1JYBPrp+OZm1njAWkYWSZEoZ93WpjnhfJweJ8gx7wk1Fjn3TGp6gQ5GpJUDlhmPQGA8VPLUcgaOJiFFkS7Eco1ebx0dLndOJHkOysb0MYX3lgDEeWyaWUAbiJPeNrOCqLLv4sHREmKOptO0uJ/cqiZfqmgX+q5z46T0vcrxMntYZW9L9qdqSsdxGOG5kWdsYCBF6i31mpemgAEJT5cfmjijK2cXCs2gX5uNCwKvV4aMlN6gdL/kdx3eNsuFtdoePqY870EMe/tZCxID/dshJdlGUcqPCEFF3VX/icCMhwhGrBvHmeXMRrmEhD/XMC9GwYnlYrQsZ0LaYFvGimOMUaQw2JWe+Or9nqtw0809FTR6sTVX0ZaMpYH1XBXp/IpcZ0GxxqyJk2pDxg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(7416014)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9hxr3ub5yXyx9zmUFbuey+5SN6y5ocNvZxSnFcy6CjgpsG/3/oBXC9skWUhtSYuHfniVsRxnU06vvFJ/t+RFs6A779sgljnA9RRLMahk9Otex2CCMYQexLRtPGoXsBfSNwegGdZXAceKLOBcPotaxM+4hPGDh/XfmD1F3NUSXDeLk98tu4TvZbik/CrHQD4CsEXBxFuKEVVcEReY7jHn5b8It8oEOFto7dk+dJa5XDWUMFuVKL1J7lZHWPMGgYFdldhdYXfw7EAo8id3rZfa1HCMxOjBT+xPAULoCmateTi0ytiHCTAiDGXVLuO2X9plM3LIjaHyZe7YP1owbWHscOj+ZMPPiE/VVRCKOjWuzpJ0IuiMjTrlWyfQMdqSiM8VyD+Z75wfaQb2utFvd76yktWvnjyEyNqaXxTLbpMIyo85X+NNAs2WMJsFDgv0Sycf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:59:53.7162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e685d0e9-8657-4531-550c-08df0dec21a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFF39339DD

When convert-in-place=true, the guest_memfd instance created by
memory-backend-memfd (when guest-memfd=on option is specified) should
also be used internally for private memory.

Do this by dup()'ing the guest_memfd FD provided by the backend so the
separate cleanup paths for shared vs. private FDs can be managed in the
same way they are currently for convert-in-place=false (where shared
memory must come from something other than guest_memfd).

Introduce a new RAM_GUEST_MEMFD_SHARED flag that can be used to
limit this dup()'ing to specific backend types like
memory-backend-memfd.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 backends/hostmem-memfd.c |  1 +
 include/system/memory.h  |  3 +++
 system/physmem.c         | 48 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 6576331441..a9759e682b 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -89,6 +89,7 @@ have_fd:
     backend->aligned = true;
     ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
+    ram_flags |= RAM_GUEST_MEMFD_SHARED;
     ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
                                           backend->size, ram_flags, fd, 0, errp);
diff --git a/include/system/memory.h b/include/system/memory.h
index 027ca81bd2..81616bfe39 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -274,6 +274,9 @@ typedef struct IOMMUTLBEvent {
  */
 #define RAM_PRIVATE (1 << 13)
 
+/* RAM can be shared that has kvm guest memfd backend */
+#define RAM_GUEST_MEMFD_SHARED   (1 << 14)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
diff --git a/system/physmem.c b/system/physmem.c
index 991f7bb815..d77e6fccb5 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -59,6 +59,7 @@
 #include "system/hostmem.h"
 #include "system/hw_accel.h"
 #include "system/xen-mapcache.h"
+#include "system/confidential-guest-support.h"
 #include "trace.h"
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
@@ -2185,6 +2186,8 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     if (new_block->flags & RAM_GUEST_MEMFD_PRIVATE) {
         int ret;
 
+        assert(current_machine->cgs);
+
         if (!kvm_enabled()) {
             error_setg(errp, "cannot set up private guest memory for %s: KVM required",
                        object_get_typename(OBJECT(current_machine->cgs)));
@@ -2208,10 +2211,43 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             goto out_free;
         }
 
-        new_block->guest_memfd_private =
-            kvm_create_guest_memfd_private(new_block->max_length, errp);
+        /*
+         * If both shared/private memory are handled by guest_memfd, make sure
+         * to re-use the guest_memfd inode that should have already been created
+         * for handling shared memory.
+         */
+        if (machine_require_guest_memfd_convert_in_place(current_machine)) {
+            if (!(new_block->flags & RAM_GUEST_MEMFD_SHARED)) {
+                error_setg(errp, "configured memory backend is not compatible"
+                                 " with in-place conversion");
+                qemu_mutex_unlock_ramlist();
+                goto out_free;
+            }
+            assert(new_block->fd >= 0);
+
+            /*
+             * Current logic calculates guest_memfd_offset on the assumption
+             * that offset 0 corresponds to the first GPA that is backed by the
+             * RAM block/backend. For cases where the guest_memfd is only used
+             * for private memory and created internally as-needed this is
+             * always the case, but when re-using a guest_memfd that's also
+             * usable for shared memory (e.g. via memory-backend-guest-memfd)
+             * it's possible that guest_memfd might be mmap()'d starting at some
+             * non-zero offset. For now, this isn't a reachable condition, but
+             * assert this in case this ever changes and the logic needs to be
+             * updated to account for this.
+             */
+            assert(new_block->fd_offset == 0);
+
+            new_block->guest_memfd_private = qemu_dup(new_block->fd);
+        } else {
+            new_block->guest_memfd_private =
+                kvm_create_guest_memfd_private(new_block->max_length, errp);
+        }
+
         if (new_block->guest_memfd_private < 0) {
             qemu_mutex_unlock_ramlist();
+            error_setg(errp, "failed to create guest_memfd instance.");
             goto out_free;
         }
 
@@ -2320,7 +2356,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
                           RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
                           RAM_READONLY_FD | RAM_GUEST_MEMFD_PRIVATE |
-                          RAM_RESIZEABLE)) == 0);
+                          RAM_RESIZEABLE | RAM_GUEST_MEMFD_SHARED)) == 0);
     assert(max_size >= size);
 
     if (xen_enabled()) {
@@ -2832,6 +2868,12 @@ int ram_block_rebind(Error **errp)
 {
     RAMBlock *block;
 
+    if (machine_require_guest_memfd_convert_in_place(current_machine)) {
+        error_setg(errp,
+                   "rebind support is not yet enabled for in-place conversion");
+        return -1;
+    }
+
     qemu_mutex_lock_ramlist();
 
     RAMBLOCK_FOREACH(block) {
-- 
2.43.0

