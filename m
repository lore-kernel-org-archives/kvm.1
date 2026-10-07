Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AAF4B0484
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381040; cv=fail; b=r/uraOD6nDWg219zhM6VhHU06wIPfT4REN1GWn5dCGDeRXTknlo+nRW1KVKycUI8L4eRDVnROBLR9THxJqm6oYXpHVJo8UTSRxvkJ/5pN5nu2tx6ybQ+I7MLHMRq4v2Xwgj22I5MBVscCv5kvcmhnrlb6kjrZkOBcB3A9CNfUAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381040; c=relaxed/simple;
	bh=KJNAcI4FTrZwrdQC6WZ71AUPS9Ufccwx2YT8jon4plg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7qmjyB5VZwSe1ObvwPyHK35atfyUyx1mg0YfUeCz3VngxEbsxiIB2KreQSE00lHtBeUaTpUoGkoRnmYSptkRu9TT1yA9etn18r7Vjx+sQGbMhd2d192BD8tQ/Uxo/ReqFNmmCdtDdi/b5GOZMFHTmrCzhnuptGCc1Sow54zhrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cfhseGK/; arc=fail smtp.client-ip=52.101.46.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cfhseGK/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjrvcPeQLgGviGCG7FPnCuCFlZuKo8iwjEfGJdMqsE7Vub7BJmw/Aws08rkRdw1de1nrTvVscAeTZZPT0K2cbhYUmSe7TJNJRyPTS/18cxzbVilCVgRc7tzI041ovhPXPvrfrR7eHSzpgv4RNQzqIVfR0dBa4cf8ZYkdDbIscn1dSl31qEdtYTEGWtovwoWUJWwioYw18XUU1UNrr/QMaUhCEdy0djI/UySUFPY2NVVA12alw8q99aBwH/i4P7r/5ZZN0Cf9dZqooztF8DC3mAysWZyAmjx3l1wmFqCYV+XqlpHlCJVUZDXQ93nzt2lwuPjE6fTnU7DS5xQHtwT5rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8FrZ3+Fy2e196Kcifl/Kgnvomb1xROz6PQEKbm3QSA=;
 b=wqN4zZ0XW/oFlY0Kbl1HOu0MQTjKl+cfSMLynr6sBBXnTq4Ru6WZMh73iliQsRid2nrRV+ua9QH5CdZN29MHk0A2dOzXzPydeaxNp9aUEB0FeZrYrXz9AyoRD71ONqJzQSxU4exLS09cYs8ybGSDCg7MzafcW4N2CZyGstuAcfMWuyZYocHrzOIEhgF0nYyRBa7byBd+iWWYqTMpjD7YMIaxzTZfFk1kC5bxkfCxtZ6w7jLdsa5A9D1OHOCOHVKWMr08mSt+Vd8L6zcDQj0gwqZDLt5cMWmnC3dr6ubZKQV0zntYT9a+vEq7kwLZRNuF/NRDUxyw7bFmEm8naUZ3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8FrZ3+Fy2e196Kcifl/Kgnvomb1xROz6PQEKbm3QSA=;
 b=cfhseGK/Nt5IHW3qSe+eQXSI5dOiGTon6vQxGVAIlmfjK/MKusV3Xscj16nckTfuGnu89ivM1LqWb9HAx78z48KX7+b1EgVR9SbUL/z/SjeZfidWrB8UFB6PnWjJIURhr4NNmhhIbryrP3Um3frpJ5MjmAuu7aSGOYxz80C2qAA=
Received: from CH0PR03CA0408.namprd03.prod.outlook.com (2603:10b6:610:11b::9)
 by CHXPR12MB999245.namprd12.prod.outlook.com (2603:10b6:610:2fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:50:26 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::46) by CH0PR03CA0408.outlook.office365.com
 (2603:10b6:610:11b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 13:50:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:50:25 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:50:23 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
	<ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 08/19] system/memory: Re-use memory-backend-guest-memfd inode for private memory
Date: Wed, 7 Oct 2026 08:41:32 -0500
Message-ID: <20261007134323.1606088-9-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|CHXPR12MB999245:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e86a633-6656-4ffa-f0d8-08df2479f050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	CLerRd/DHar0X55FyKqH+o9KP3wawEJAt/OsRIOluD1nk2TZMN3Qa08rJS1UoxTxpwUh7wY1cK7llefZqi6vTc1ymzKUbFYpUDjppU4PueDJqax7lqOCg/dVuIBVPaV+L0C+D2a1xGY9c+7EMgp5skYfUDIEeqxlVbGskxKSyrFVol+F1C4XHokfMveZGnBmJFSJ2yILRx+8CdmUSr06rzbO7HRiRBtESqUEFwRLt7ckwSxLjsDybDjfkfzIl/RfPd49kpV6Cra3JJnwtxnFTLBfY4dFU9GtjD2pO9FIM8F0HZ6ovL4JbBMOtvkgXcOjGeT0hXlnwUcUzq24+/NRyAZ2a26cj+wlHBbYQU182fsIp+/ckFSoDB3EWWpHRXPjTD9R55yKxZ4myZAYba5EbiOUX4N3rFcDUTaQnpB59fjB+t9cA8bgPHYfImWPZa2xe7lS3tSCRCOuN94NI8z9NjTVG46508M3NA5okUnufV/iGmZG24tU1AC9wnDLOhmUBkQXNvYjxJC0wYJwOCUCd7F+dI4qec2WggXGrnZNQiNTPgtofj4QOxytUfo3GPqRAhA2WGdVvAQ2PAGbzqB9idco3ew1JThbdUC7K9rv2PvHaEAg/5IurXiPB8e7yhu12mv3AKdxHZw7PseslHPVK3V40OU2w43smSSjPwLKRtz8kOERbh5YbtMbupNTzO0FyuVX2WcMRfJaRTXbwN62BQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zX5xyAsk52ALaAGpVTDF5mI5Zr7+06keD7ne0VEJCb9eAZw+MYnXmNJvuCqfVqUd/lePN6rqDsK8n5Mj+NfvBQn/Idb7WAZ0HkmurCa6NCbekWM7G7pMTtVqBwLX2W4w0KZzFlKobklgg5B0HnQQtuHoJaNnLktjxtcjUUy+gQJHWTdEUJkjBWraTndpNUxlutc+6GttUnWJkTzZXOzCQv579w+l0hMm6+CHgnlFHcGFn9utoAyIb/6+3dXcOA5sd/gTSwn7G8dso7Zb3faIOtOau14W+itO1bmkOF56ki+GoEVjDqRO+XM1S1oY7gWQ0G0ruuD0c5qMqcEZj0uR8UDH0LbIqsCdf/W2SDGeSpmVfEbKLoNGv6o4L2CIyKnKJo+xILy4FcqQaV1hZZjyadVwRS2xMzOAS7bRDdLm5buVBn2+3ASST0cFV3JU5n5w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:50:25.0933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e86a633-6656-4ffa-f0d8-08df2479f050
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999245

When convert-in-place=true, the guest_memfd instance created by
memory-backend-memfd (when guest-memfd=on option is specified) should
also be used internally for private memory.

Do this by dup()'ing the guest_memfd FD provided by the backend so the
separate cleanup paths for shared vs. private FDs can be managed in the
same way they are currently for convert-in-place=false (where shared
memory must come from something other than guest_memfd).

Introduce a new RAM_GUEST_MEMFD_SHAREABLE flag that can be used to
limit this dup()'ing to specific backend types like
memory-backend-memfd.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 backends/hostmem-memfd.c |  1 +
 include/system/memory.h  |  7 ++++++
 system/physmem.c         | 50 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 666593ff6c..c1ea6eefbd 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -90,6 +90,7 @@ have_fd:
     backend->aligned = true;
     ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
+    ram_flags |= RAM_GUEST_MEMFD_SHAREABLE;
     ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
                                           backend->size, ram_flags, fd, 0, errp);
diff --git a/include/system/memory.h b/include/system/memory.h
index 027ca81bd2..ef6c767021 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -274,6 +274,13 @@ typedef struct IOMMUTLBEvent {
  */
 #define RAM_PRIVATE (1 << 13)
 
+/*
+ * RAM is backed by a guest-memfd instance that supports being used as shared
+ * memory (as opposed to RAM_GUEST_MEMFD_PRIVATE which, by itself, entails
+ * the guest-memfd instance can only ever be used for private memory).
+ */
+#define RAM_GUEST_MEMFD_SHAREABLE   (1 << 14)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
diff --git a/system/physmem.c b/system/physmem.c
index 86046d46df..b9b4864a94 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -59,6 +59,7 @@
 #include "system/hostmem.h"
 #include "system/hw_accel.h"
 #include "system/xen-mapcache.h"
+#include "system/confidential-guest-support.h"
 #include "trace.h"
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
@@ -2187,6 +2188,8 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     if (new_block->flags & RAM_GUEST_MEMFD_PRIVATE) {
         int ret;
 
+        assert(current_machine->cgs);
+
         if (!kvm_enabled()) {
             error_setg(errp, "cannot set up private guest memory for %s: KVM required",
                        object_get_typename(OBJECT(current_machine->cgs)));
@@ -2211,9 +2214,44 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
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
+            if (!(new_block->flags & RAM_GUEST_MEMFD_SHAREABLE)) {
+                error_setg(errp, "configured memory backend is not compatible"
+                                 " with in-place conversion");
+                ram_block_coordinated_discard_require(false);
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
+                kvm_create_guest_memfd_private(new_block->max_length, &err);
+        }
+
         if (new_block->guest_memfd_private < 0) {
+            error_propagate(errp, err);
+            ram_block_coordinated_discard_require(false);
             qemu_mutex_unlock_ramlist();
             goto out_free;
         }
@@ -2323,7 +2361,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
                           RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
                           RAM_READONLY_FD | RAM_GUEST_MEMFD_PRIVATE |
-                          RAM_RESIZEABLE)) == 0);
+                          RAM_RESIZEABLE | RAM_GUEST_MEMFD_SHAREABLE)) == 0);
     assert(max_size >= size);
 
     if (xen_enabled()) {
@@ -2835,6 +2873,12 @@ int ram_block_rebind(Error **errp)
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

