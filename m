Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66E164
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779926971; cv=fail; b=D+7A3nOIGYfIVe/YeUT1mGCvZRHxHOqbRAGaReydXZRv73i/n63P5p++V7687eDwt8jS1KIdCo8lOu0nW4qjCibxN0gzcgZYfIsk7WjTcQJgL2RZXwEKyBXzYTVfyXXIoyq/Jlbghmoe4w62PNbnaVF9NT/tSJYbnRmJ3MNk8kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779926971; c=relaxed/simple;
	bh=2ejcWfAgsX01Q9dqnp4NXM0bykWwh+EFSKMNnNwjh1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtHB7wzNF6nDf1eLk5LjmkY+oWrmoczsgYPTYO33tJbbLRIp9/nD/b+8AOdv4HSE3uwwamjU9xICvksEnEP/L4yzljsJ1nMP1dbQtuNAqfv5lvGwKBU3CDjTjkB87/X2PdsB6ibf0/pa7KMcfCaHPjP0sj8g98Y96D2xjf/d3qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HR8Qt2aK; arc=fail smtp.client-ip=40.107.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HR8Qt2aK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eobWXZ0mkk5VwRn7BI0b24Q3LKCqNNPcklvwsZMos/dx6ttlLpS/TmDgpyqTMbGiuh1NdmFMMfOUgYsVLEkph4w869OGFuZFn4aGy1qpj/7E4NBKKRnQ7OaGwoSGsP/+3t72BGZ3Mt/MyHuHHWWcj4TkJxVpmTdCD1NxULsbXCR6Vj7Z6WiOJTK9f9yyP8x3N7dK/Gs4aLkGl9aMB5i9kNDqIzHll1dPFLI+Il1Y6yskYed6GOgfQExMBDx9oo2v+oqa2ujIgru1xzVx/M4IFFzl81icm/11vE7FohVY2yQ5GTizfibTA5vl4KgiYtfWM1QiQdIlCum8E0+56bUZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNkYtlCGhTViDiVbZJ2CWs/0V36hOC1BOYoMHbI6nqc=;
 b=YTfqvVnju4WhS1ixT0JcGqWwBum7BFPHxceZFLtlqAHWp8dZik2DxciztdT8XB3azgVsBwetZj+jhXgAZ9O9+BN8F42hKPf4COR8tqPDnQEBiSlaH7zEafVfzZv6VRQVlJEnueJQngTzOx7J7h79XsE6SHlcp9vxbRVe1gW0lOk6dP0ryZ4qbrBYJUvlCStTGjtNKEps8maxJZWQxueVXNCTraSzIapIEsBRhkeyKepfhsSunYVGYy92T7n7aU+dxXlvnoYeDwganeu7ANMnARQk4ciam/IGqBu+FmmGBiglirsAuoY3cQqX5NHJcoluesbV3b6OLkAPO0BOWCGE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNkYtlCGhTViDiVbZJ2CWs/0V36hOC1BOYoMHbI6nqc=;
 b=HR8Qt2aK+RVgR0MaZELnHObO6+ec3KL2NakLFYJMfIc2zy4pXYoIehKUgsUGjiwGN9zxEcS8AGDRW5HVlqTXPFws2kG7jnzqcG5te8VX2udQ8kMmiKJE6tDiwMFJ45t3ofWNigUG6/nflckBCv7UVkIrn9zFgQczunE1Eftkn3M=
Received: from SN6PR2101CA0006.namprd21.prod.outlook.com
 (2603:10b6:805:106::16) by IA0PR12MB8225.namprd12.prod.outlook.com
 (2603:10b6:208:408::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Thu, 28 May
 2026 00:09:25 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::a5) by SN6PR2101CA0006.outlook.office365.com
 (2603:10b6:805:106::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Thu, 28
 May 2026 00:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 00:09:24 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 19:09:24 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: [PATCH RFC 06/12] system/memory: Default to guest_memfd for RAM for in-place conversion
Date: Wed, 27 May 2026 19:03:31 -0500
Message-ID: <20260528000416.8161-7-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|IA0PR12MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c217d39-2d9b-438e-60b1-08debc4d606d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NJztGPN5udHna2pq6LPOL/f3be80N/KqMqfz/X/jO+swSJdp6gQr4DwKFbfIT6FRIbwWgb9qKaDASyNeHibHJpiBoFxi/ZSrHnwuMDmEetVo1mtC4quEjfNnNxOYEaRv9uEq2g1JXuOo5XOLmDClWKYLeg1AbXBpVh+mdBs6PoRL/pMyE00vVdEtI1pIOtWykvEEdHDGyiE8iLVIg8O2obqcrd7blGcIuagWggZIw7R1eRf2FrpucJvgTStQRQzO7SafZaN0GcOy9TQXBH2RAwYvdzB3RDjyolHnhJFzXal72SypQvkgbftUP80htjU8VAdHx9zH2Q4aMbkSpqG4MqiAWGW7NJdgKPeDNrMxQ2PZi+b3NN6IZ1WFfoE8XQZJT9zi8ef8/dVZyGxAGPh5NEbKCjRtnHJv2QGFug3op0wTT7PCe8r6nxBE4Mxnx51P7/u0+vMekgKdiLEHEsyHv0G0Qokv/TAk5hYo4jG9ShiyxlkyUC1qdpfBbMf4jZYGZ+6zukArvFjkeX1ResQXF5S1r80lLUWIxjqeIovHm2ot/9wnGptbgLloHAOkzNNIsaX7jCttq6VpriumtmlZPksSPAabL0tg8wH7WOX6YVX1jv4pGYEJg1LmB7FYz7iqcH3phAeUk6k4JBx8r/sRM0wfx8OlEHkjU3ACuH9YSKMv8GWdOoM2j2Tu1eJuBVHgjo+KM7SCWtlSnHMpb9eHipulCNJn8JL6zD1weOtiLpE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vlnJ002TZYHkCUT+lUY1iIKxmAML46LLUfFrOHbkV1E0c1CMHspP0/xpoDCmMj62+l61pcaQaw9oXBElpvzJ7N7ASJrAO7gNFxqxECykM9FCDkNY8VyBZN7OH5KMqAyWEMOtwVroJImXWVPzmgxzzMaXN4Kn0nL1kWoHhnLGctjsAiYLpuxtkDP1tKJjHy7P5dV/xgPDgCFOHCgpZ0M8jOHxwYKPAYa3dmfp87p7J/1c3zqoHNVyk8hNQVFbV12Dhl6YOtI3zW9pnJGn/t9AML9oE7N9GmBhWU3bY9iHC1vtq+zqoF6MQWOhL2fXnOSwom+dup0hB4/8trF830pk4Twx4J+X/O1eHD5XZziuGVGw4Rl4lnjDp/zB3xMiLqFC2dvVeEd2/uZv+uKngDfS66kXBCzumjhpl3v8euMCXWGHRLKZQVp7rR7sBoq0xHkp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 00:09:24.9123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c217d39-2d9b-438e-60b1-08debc4d606d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8225

memory_region_init_ram_guest_memfd() is called in some cases (legacy
BIOS regions / IGVM regions) to allocate a new RAM region with a
guest_memfd FD under the covers to handle private memory since the GPA
range can be converted between shared/private guest RAM.

When in-place conversion is enabled, the conversions happen with the
guest_memfd inode itself, so the same inode must be used for both shared
and private memory. Handle this accordingly when convert-in-place=true.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 system/memory.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 739ba11da6..f6c695fd23 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -35,6 +35,7 @@
 #include "hw/core/boards.h"
 #include "migration/vmstate.h"
 #include "system/address-spaces.h"
+#include "system/confidential-guest-support.h"
 
 #include "memory-internal.h"
 
@@ -3674,10 +3675,25 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr, Object *owner,
                                         const char *name, uint64_t size,
                                         Error **errp)
 {
-    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
-                                                RAM_GUEST_MEMFD, errp)) {
-        return false;
+    if (current_machine->cgs && current_machine->cgs->convert_in_place) {
+        int fd = kvm_create_guest_memfd_shared(size, errp);
+        if (fd < 0) {
+            return false;
+        }
+
+        if (!memory_region_init_ram_from_fd(mr, owner, name, size,
+                                            RAM_SHARED | RAM_GUEST_MEMFD |
+                                            RAM_GUEST_MEMFD_SHARED,
+                                            fd, 0, errp)) {
+                return false;
+        }
+    } else {
+        if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
+                                                    RAM_GUEST_MEMFD, errp)) {
+            return false;
+        }
     }
+
     memory_region_register_ram(mr, owner);
     return true;
 }
-- 
2.43.0

