Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81A864
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779926955; cv=fail; b=IU33YD7fMf3Fl4BaIYkRx6/IgeVyVXUGFQx5nC/z8awgGaKaWX78pmBMC6mnSiYEGouHS1X8ivkzUjoNbEt4FujxqqcgIpbCTdtZfssFAkv/sK+UjpeIL8zVEGggUL9HU+EseKlPwbK4iP1x0u1hUWdbXqJxkIyJ93YtOs45Xsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779926955; c=relaxed/simple;
	bh=U0RQZ34fgwo5K627TrQmwy8WkDHuIGmhak69iPtCFjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOyfl081XcakOFoT+TLJT4weIwfxNY9ul/kazscreSk0jIBgdU6ovyfpbhnVsbTayT48NB4MnSEpq24l0SgyXj5pUh23HU0OrhtK9zRbK0zDuRBlZH+2EVo/8Tp95mtUSJpv1KnsnuYA7enDkIh1+637dyBcsY2oVkL0OqfUXao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2EmPWE6n; arc=fail smtp.client-ip=40.93.194.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2EmPWE6n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWghb1fOVQVDIonYTPjtoRPRhThTx2Rkxa/xsc0h1ykANoiJe4ON42PfvEFClNPdt9UF0bZ28vg+VhPfjQOkp3Hu3+TFFZkltjOtX9+h0JXxFU4a89iDii1BAqQPkO6EWe64ciQbXZCJzOQzPxzTF08sDF936wYD8ht+crhNvCXUR2wif2an7MuLfnvRKLQ57PjcCXMAviFFh9An0psmQMuBSy4j6PSz5ggtZhURD2oWj1VDckw9ZxRCao2Flntaoj6C9hwEmYtnRgG1DXw8yjLiKbaFZ6tsKJEyrg0fru3npPUUQ/yfEADZbkTS+EFdowYYT5AEJ29exhRx/17Lkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2s1sfWoh+gRyhciK6eFmKOuTxzH3j/ciyeczMXeMrI=;
 b=Ip23XWpqVnKfoa6QoqOzK4E47jUnYHnC41spsNrg7ee82+Vk4kKevGhOllUkjOcKmSW8iZMIU7D6dxn+GUcTea0GIL+iHoGrRDFV8+E98qpwBQcJ1ljL33oVh5+1nV0HltJonO/dJGA/1zYrewnXhEz7e4mMU93FiPaPsw8lwDEpUioPlUcoyZh82C2wHJ2V0gs2gXLFy85/10YmYvwdukTkbdBwJX42HdEW6nrGJaV0RvTea993sXPq5WdFmrF5yfnpNgMgIVNDowKjBqTTno7sV23YhEJiILJW4yihzleUoF3ib33ySbRlhY85xy+lQfUUSZ3tjNqdwQu0xynOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2s1sfWoh+gRyhciK6eFmKOuTxzH3j/ciyeczMXeMrI=;
 b=2EmPWE6nmx3MQvjHpTEnfg7lhlPsnEDEWQKCtH2fGFXVubgDxDtJIE9BazYrEDQ7eTMTI5iDJsQURVAKe1RUID6obUCIdy/wSZLpLjUciTAmgjzgg355LVi7ssljiqjnWqzqMnLqIAX820KoysQIMxVtq01uiFe7+wba5p4uNvI=
Received: from SA0PR11CA0137.namprd11.prod.outlook.com (2603:10b6:806:131::22)
 by IA1PR12MB6530.namprd12.prod.outlook.com (2603:10b6:208:3a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 00:09:05 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::a1) by SA0PR11CA0137.outlook.office365.com
 (2603:10b6:806:131::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 00:09:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 00:09:04 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 19:09:04 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: [PATCH RFC 05/12] system/memory: Re-use memory-backend-guest-memfd inode for private memory
Date: Wed, 27 May 2026 19:03:30 -0500
Message-ID: <20260528000416.8161-6-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|IA1PR12MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: 4139ca5e-ef8c-499d-dc95-08debc4d5428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|82310400026|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5TL8csQ2LmbTvGpJpv69Lf2NZAf8nEPMxAmdyKhCZR8gX+v93thLs/zNjh301B/5WYoBLazGsgwqpPNr//4d4bcpIHqN9gLVbWhDtGHUe0Ew+k1pzBhSBPAhpNRmBjEoYFWbzRFAqNIdLpYUD919UoHWAQtSwxHBvjalIKfcbyLwyOOze4KtpxpDjeqk5ysK9/tjByz0ktBUd47UYQTxi5G8Tz0bh2deQ6rXitDrayLiFVlIvHXAAMxQuoERtP6ZbjzHexEiYuyHCQKib9YM0W2SvL42HcrmoBbgIPp13Zo9tgYwk/vMkD3kfl+ye8z7zjUm8XOmsmiApGArVyyM+kmmkEnpFxllJgzkEVp2a7W/6VBKkxftNMtonD6gGILfV57e0PNKALC7ZWH2TV4O2VyMo/LsSsebryq4KPiC+yVh4VfbEEv8jkuui4/sqpbfhlvb02h/3fEojM7u0GBrgoIHw7Th2/FCTqbK8JOadysvUddVivw3hrAjAT1AkNR0ni+T3rX2b630MKiKv2sqKhIlf55rpVGILltMNUC4MyE9cFmQhRvfX8/Es6w2M+MGaLd/T7ifcOTV1mGS1Rar7r5JdmvAO+mfuSOvda7qolm9qTrf7seI+kzITGP5xEZSDPgoNG5MLqky1oSu4HiTWCUkUumLhJI15MpPNptLygT/ZFxrcN7rLvnOmAOp/yB/fA/xa0TshUD4cXuzRtNtOGnwuyF+c0beB1ghYKp8q9U=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zw9pq8YpwNPdFcchw6EYcrmT0sDVZh8ZMAwWDY1HSBOBa1v2HMQkUZvs2pN6+kx/jyLYKcrpZRrJVkm2vAw2WKr61EeVQGTMHhNITL/WD+4GMM3fm6WJDt2aazoF0PWuga66JZJBZ+taLpCexprY/NXGb69CIFAaPGQHbHSHprRVIeYRAcD7PhA57Pg/vdlpIhRIZCmJfPsIv/718qdH8+CzwSGoEugi31+LOiVyGeydQ8Ur50t1gg+G/tc7OXCYjnKqicZ3ERIWR4mlvFO7vDKrsami1k5KpKjYAD+FSRh65aKY8P5uIjfTLBFQ5IU5Z0jtn2xV7+WWSDz706ZelNi9e1P3H4zwlHfU6y7pRYdow5MHw1jgEJo5tORq0XRonfPswbKvGN18EHx8KdNBEGccH4VAja57E5jW0e7Per/S2uIye8arw0W+nKcwaVjS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 00:09:04.3043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4139ca5e-ef8c-499d-dc95-08debc4d5428
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6530

When convert-in-place=true, the shared memory allocated/provided by the
guest-memfd memory backend should also be used internally for private
memory. Do this by dup()'ing the guest_memfd FD so separate cleanup
paths for shared vs. private FDs can be managed in the same way they are
currently for convert-in-place=false (where shared memory comes from
some other backend like memory-backend-memfd).

Since it only currently makes sense to allow a
memory-backend-guest-memfd FD to be used for private memory, introduce a
new RAM_GUEST_MEMFD_SHARED flag that can be used to limit dup()'ing to
specific backend types like memory-backend-guest-memfd.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 backends/hostmem-guest-memfd.c |  1 +
 include/system/memory.h        |  3 +++
 system/physmem.c               | 46 +++++++++++++++++++++++++++++++---
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/backends/hostmem-guest-memfd.c b/backends/hostmem-guest-memfd.c
index deb796a6bd..8ab8242892 100644
--- a/backends/hostmem-guest-memfd.c
+++ b/backends/hostmem-guest-memfd.c
@@ -56,6 +56,7 @@ have_fd:
     ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
     ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
+    ram_flags |= RAM_GUEST_MEMFD_SHARED;
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
                                           backend->size, ram_flags, fd, 0, errp);
 }
diff --git a/include/system/memory.h b/include/system/memory.h
index 24c68720aa..0a371b686a 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -282,6 +282,9 @@ typedef struct IOMMUTLBEvent {
  */
 #define RAM_PRIVATE (1 << 13)
 
+/* RAM can be shared that has kvm guest memfd backend */
+#define RAM_GUEST_MEMFD_SHARED   (1 << 14)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
diff --git a/system/physmem.c b/system/physmem.c
index 04c7c38721..ebec7ae7a4 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -59,6 +59,7 @@
 #include "system/hostmem.h"
 #include "system/hw_accel.h"
 #include "system/xen-mapcache.h"
+#include "system/confidential-guest-support.h"
 #include "trace.h"
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
@@ -2187,11 +2188,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     if (new_block->flags & RAM_GUEST_MEMFD) {
         int ret;
 
+        assert(current_machine->cgs);
+
         if (!kvm_enabled()) {
             error_setg(errp, "cannot set up private guest memory for %s: KVM required",
                        object_get_typename(OBJECT(current_machine->cgs)));
             goto out_free;
         }
+
         assert(new_block->guest_memfd < 0);
 
         ret = ram_block_coordinated_discard_require(true);
@@ -2202,8 +2206,38 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             goto out_free;
         }
 
-        new_block->guest_memfd = kvm_create_guest_memfd_private(new_block->max_length,
-                                                                errp);
+        /*
+         * If both shared/private memory are handled by guest_memfd, make sure to
+         * re-use the guest_memfd inode that should have already been created for
+         * handling shared memory.
+         */
+        if (current_machine->cgs->convert_in_place) {
+            if (!(new_block->flags & RAM_GUEST_MEMFD_SHARED)) {
+                error_setg(errp, "configured memory backend is not compatible with in-place conversion");
+                qemu_mutex_unlock_ramlist();
+                goto out_free;
+            }
+            assert(new_block->fd >= 0);
+
+            /*
+             * Current logic calculates guest_memfd_offset on the assumption that
+             * offset 0 corresponds to the first GPA that is backed by the RAM
+             * block/backend. For cases where the guest_memfd is only used for
+             * private memory and created internally as-needed this is always the
+             * case, but when re-using a guest_memfd that's also usable for shared
+             * memory (e.g. via memory-backend-guest-memfd) it's possible that
+             * guest_memfd might be mmap()'d starting at some non-zero offset. For
+             * now, this isn't a reachable condition, but assert this in case this
+             * ever changes and the logic needs to be updated to account for this.
+             */
+            assert(new_block->fd_offset == 0);
+
+            new_block->guest_memfd = qemu_dup(new_block->fd);
+        } else {
+            new_block->guest_memfd =
+                kvm_create_guest_memfd_private(new_block->max_length, errp);
+        }
+
         if (new_block->guest_memfd < 0) {
             qemu_mutex_unlock_ramlist();
             goto out_free;
@@ -2315,7 +2349,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
                           RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
                           RAM_READONLY_FD | RAM_GUEST_MEMFD |
-                          RAM_RESIZEABLE)) == 0);
+                          RAM_RESIZEABLE | RAM_GUEST_MEMFD_SHARED)) == 0);
     assert(max_size >= size);
 
     if (xen_enabled()) {
@@ -2828,6 +2862,12 @@ int ram_block_rebind(Error **errp)
 {
     RAMBlock *block;
 
+    if (current_machine->cgs && current_machine->cgs->convert_in_place) {
+        error_setg(errp,
+                   "reset support is not yet enabled for in-place conversion");
+        return -1;
+    }
+
     qemu_mutex_lock_ramlist();
 
     RAMBLOCK_FOREACH(block) {
-- 
2.43.0

