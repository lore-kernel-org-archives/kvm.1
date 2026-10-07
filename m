Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF0B4B1D03
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381000; cv=fail; b=UpCE3cWziXKF1ihGAVE4KXlOHfKUy3hflpJcv6baw7zl3Ml/ytenUTUrxWGKW2fRpQcAYf/YHaWaArLpFtGv1yWPbjoMGNMO+qL1ynrxn0EZINdblzWJzgEViHAqyuYs1hXltUW6EHgxBJM359dtLB+C/8pzacTu3UeJ9wfIDXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381000; c=relaxed/simple;
	bh=0wUOqqEn0AOw88jak+P7p5fbbaNvFaEOEKrcBX9lmjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=stfjN2lTBRXrX3Yv5nuTzDUL6A7ZxZdh7/eDhHG/BiZiEMaPaQMBC/+7hKYpMAy4wUICbkaLBBeX2JWkFMunLEbqmB0YM3tg+bTTCfOx0ff5pevERk838Ek7GjBve8VlbfFs8FWUwaytCNvIgPLHZSftN/cf/ADVtWCA0HPbLSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gw1+GmnJ; arc=fail smtp.client-ip=52.101.46.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gw1+GmnJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2xgFHMDNonuwH/CAhKQ3TBDJ9m7mU8rTpXnQz2g/GZiCo1Tc8KL3G8s9TpAMVFLb1w6+bu9XBDNKFF8uVkA1qaCzseyxKuGIp4KpsvMoUjhTSMDCdRlbYGe+EUBWPaXz1rHDyrM+aUk2Hm2+cBLtdobnNd4MGNautlyaPkMgKQMHo2QXWnGvglEKq9QzxJmlDyRE2uZHpopTIV/6oi2zJucTYTuRRk6fYcDQYbrgFKJe5NYRnjPw+94nXO7hclAQ7KDbc5+vO4nj2Hup7ySQDfnZjLwx8WHUKJn3qVTl+1hKlhkZ4k0yuZk78EyVVeXc7oxsykrU0FOxHQdGhpI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5Tff8OOoFfLXT65qpb9PoBrQVKbxUnYu6b2F1KUZts=;
 b=XI7dABXKg+91sPCbhiv0j4QlEwTegKpvliwBTAzxb7rSH/QP2QYS76g45eatHdqtjK2xqNeIVjV3qndw6ZH6P606ZEiCpooL35P/AxnqV7DRDex2BD2lu1Ixo6JByN8cQ0NwjIrjUjCLm1f/tfCESGwS87eVjQPJv8b/5ZqK89HjiA02yCPiDev8hoB/pekXO14Nuez/AxRuLQAAeoiXD/KZR1VXeSSdPrH7udYbSumlLXG3PWUsXjl8QPKPnCHvLo9Qr57gtgJYFRhyDoV8LILevDASK3LPLKPF9vG6rKlTjDGrOo1qnuS60aS63Y9WPlegp9hD7XMQuMCu2oRSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5Tff8OOoFfLXT65qpb9PoBrQVKbxUnYu6b2F1KUZts=;
 b=gw1+GmnJbqYV+BsKRJy8ytIkw+AoRvvD7xBAqzewTcF3OyZ+sdh67195xiUTujimE5OiUEDpJLlPuaGazv3VTCqTI3MQb1K0UbLroBKulr3RuwC8GZDwcRryKSD4R2aStj4kCjEVYIKCluHgSJW2lidxmnvRNFYsxedJBsEP5xM=
Received: from MW4PR04CA0059.namprd04.prod.outlook.com (2603:10b6:303:6a::34)
 by PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 7 Oct
 2026 13:49:31 +0000
Received: from BY1PEPF000264B3.namprd02.prod.outlook.com
 (2603:10b6:303:6a:cafe::93) by MW4PR04CA0059.outlook.office365.com
 (2603:10b6:303:6a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 13:49:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B3.mail.protection.outlook.com (10.167.242.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:49:30 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:49:21 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
	<ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 05/19] accel/kvm: Use dedicated helper for creating private-only gmem instances
Date: Wed, 7 Oct 2026 08:41:29 -0500
Message-ID: <20261007134323.1606088-6-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B3:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f32726-6780-4501-39ad-08df2479d002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|7416014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	hBqb0T2/FmxtGmt5MuPCg6GfXbsbduXu1KGyO/rewcvkzqLB4v8kWMm8a84Umvl4AU8NRjGA/FqODh/5WP5ycCC+tRBxVXsWqokprkWdbr8YyKsKHvmOaUyH9dkbv/4viAY2NkyCUGns+JQ1E93ylAS0RY3Zf2dPX+d2wZ7TsljzCxg000BH0Zt2GWU8psV7VPJPO1hm7b85jUYQ6E0IEAN5u3rjnR0zb619R3cpXrCCEqAOdX/Rb2Njsk2nVhR8bKXtz4CKT8ygtLlawU/OxOMDV3QlrW2GFUXsf1Y+S/+MdtRFrGtvpukVeN1vgYDBwzAHxC3/n7pnDsAeU6ye8XF5sDNMwe3zmf4vbLuhJFmU7HdkI2fi066QLoG1+JqhmliAQXuHs0D9AMVfnxRMoi72+CYmNRgfUFyquI9lQzgvXRpsaQdUTAr78xzlJOzf2vCZl55RkFkyN0n2lnrF5iFuWM4QNoBuOlpMgF4LG95dGZbvK1/1Ep0r7M1FW56RsKnVXuSvFsx/jde5k+g9TpAt0Dgn4BnQJU1bz3DJ4/fTZ+NYUoIzRffCLF/3+bQfFOorffKlzrwDkh5DDZe5VVCnbqKrvVuKlTaYRoAh2PNjtRqa8jhCeDNm8q0Psse23BbRfD/dwZHmISkpH6gj1KgY/iCnb8LaCxmYKY1MBILEsXp5k/EX6tiv7SuVsOc2ZNOi1RBJjzQR8DriTvtIrw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+EDqkLqSwNL3wlRGo6ptqiI4Z/5skLtEEE95iM62tpKQ+LQkJU6wSE0PTLQRG/GIdWi5DWYyls2y2bbZvLGZHCinKOV1701MlIySLI5yCOSaw24wXMWw9ATqkccSAu3WRzAlymOwGG2fUjAXngDJX0KrJxYLyLz8BhU9VBA0AoJ9/Uu41KoG1AvVEOF1XT3ZkQWCh1TAHlt9EhNFVak5VQ7tCdxwNtap3Qn1AFqje63jYHVuOfBueyqLqZDmyr1ew7iP8iOfllwpxIonAfZdsFa3FN2nAY0a2A6yG+6T/WOkr/Q5otrPMD05xm+sOheTIruip3Z+rWb28BDBrv88ZJSn9EwPohVZ5zaVj+vK7bgccObi7jCA8sUJg8s97dnjX3CwZsUyu6kkz3GjaG4lzoGIsLyYW1SLcXumVBj8wIkmk6y9313L33ELQdkN6N7K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:49:30.8085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f32726-6780-4501-39ad-08df2479d002
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537

Currently QEMU supports using guest_memfd internally (separately from
user-specified memory backends) to handle private memory for
confidential VMs. While KVM can switch between guest_memfd-backed
private memory and non-guest_memfd-backed shared memory via
KVM_SET_MEMORY_ATTRIBUTES, the memory in the guest_memfd inode can only
ever be private memory.

This is distinct from upcoming in-place conversion support, where
guest_memfd inodes can contain both private/shared memory and can
convert between the 2 in-place.

To help distinguish between these 2 uses of guest_memfd, add a dedicated
helper to handle the private-only uses of guest_memfd, and add some
additional sanity checks with that use-case in mind.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c    | 15 +++++++++++++++
 accel/stubs/kvm-stub.c |  6 ++++++
 include/system/kvm.h   |  1 +
 system/physmem.c       |  6 +++---
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 2dfd14c257..f1deb458ec 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -794,6 +794,11 @@ static int kvm_mem_flags(MemoryRegion *mr)
     }
     if (memory_region_has_guest_memfd_private(mr)) {
         assert(kvm_guest_memfd_supported);
+        /*
+         * memory_region_has_guest_memfd_private() is specifically pertaining to
+         * using guest_memfd to handle private memory use cases.
+         */
+        assert(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
         flags |= KVM_MEM_GUEST_MEMFD;
     }
     return flags;
@@ -4873,3 +4878,13 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
 
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
index acbd0785e0..9fe58efe91 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -145,6 +145,12 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
     return -ENOSYS;
 }
 
+int kvm_create_guest_memfd_private(uint64_t size, Error **errp)
+{
+    error_setg(errp, "KVM is not enabled");
+    return -ENOSYS;
+}
+
 bool kvm_private_memory_attribute_supported(void)
 {
     return false;
diff --git a/include/system/kvm.h b/include/system/kvm.h
index d29624034c..b1e43ddc93 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -548,6 +548,7 @@ void kvm_mark_guest_state_protected(void);
 bool kvm_hwpoisoned_mem(void);
 
 int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
+int kvm_create_guest_memfd_private(uint64_t size, Error **errp);
 
 int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
 int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
diff --git a/system/physmem.c b/system/physmem.c
index db3dda563d..86046d46df 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2212,7 +2212,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         }
 
         new_block->guest_memfd_private =
-            kvm_create_guest_memfd(new_block->max_length, 0, errp);
+            kvm_create_guest_memfd_private(new_block->max_length, errp);
         if (new_block->guest_memfd_private < 0) {
             qemu_mutex_unlock_ramlist();
             goto out_free;
@@ -2842,8 +2842,8 @@ int ram_block_rebind(Error **errp)
             if (block->guest_memfd_private >= 0) {
                 close(block->guest_memfd_private);
             }
-            block->guest_memfd_private = kvm_create_guest_memfd(
-                block->max_length, 0, errp);
+            block->guest_memfd_private =
+                kvm_create_guest_memfd_private(block->max_length, errp);
             if (block->guest_memfd_private < 0) {
                 qemu_mutex_unlock_ramlist();
                 return -1;
-- 
2.43.0

