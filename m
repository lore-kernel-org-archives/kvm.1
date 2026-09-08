Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5992392811
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 20:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900804; cv=fail; b=UjX+3pm2IFlnB7N6ikgz+vpJ1EJiSsYIYO+5zDxcQjxJXjmHzThMnozrR+1KzsYYjyLhpb9wUZNZPfPoo2+iWKj4JjJ76BVMYu6P+mM4kT37Tw6vdogo5uuE+2b0V2dqZZushd2dgtTDgWmhbU0qGeX62vuxfRktsLnpqXhxkSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900804; c=relaxed/simple;
	bh=oRW9ym9wY6e3WJ7GCBqaBmgf6LcTYXtXZY62+dTcuSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJ5d6y6HNXmfZ4cENLN/6crmbEQ54UDOnmyG6QN1+RZ+MUkBhe09O+0h4fMnHhApHuiw9ApGvWz27y0BA8jxfx+hWblKVFoafxID/aUaVsQlg3IrNlulQxzYEZoV/ueCm/Hqha8AQ25pBrPIeEY078ER3ivWvh7QKxKtnFdNxn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DjHF3zjN; arc=fail smtp.client-ip=52.101.61.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DjHF3zjN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+PU7momG7snc95Khmc3mRm5ACwVUBEBYCCuwfx5PeWIqQL/HeBGdjuGMx9taejn2A/CZmApoazSY7y4wAzZOLXDJSFF+IRuRu+N5Pp6/eKiMx/Pmi3fHwFdRhiUk4h9Wz99MYe49z9kES/wzyFc/Pq/5hFyx4l2nloO//E1xi48DT3YGS4WzjzJFPdCNGAU1gbNTZ7oq4VFzSTsUPdY9JJZHQXkNbtmvtA+EgKiWQowZaK1tEDNKHlLdYOJJi7MhCAPa1au79cydo2IPnjCPEETesGGFhdyAZqBRPI0/rog6rXG2uKQxai/dyfcLcdQcuPZ4+eq09FR1bErFmQSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/ATI8xHG3sBP9BTnBAUw0vNEqEn3qhd+nR+cz98RWY=;
 b=y6nAmPG1zmYE7T5b+2cAAg+gbkdCsqfkd61kZSO2VaEjntEAuG25l2SPvYwRU4igGlGI+DcxKAU7KtKNmk5jQDLtc9w9WjdgJqi/TbNLFoTzqbdpNVaGA6gozKBfR8C71px/UAgJavIdK26t42yWIqaEvlHE/mpD1s//QcgMxcHjGHwnHf0M+T4mDIIs1MbNFRga2ikGo90vVK4PoLwM6KPULpqWNw5Efrmv/KK1Ec7JgOz+jKQqML4ksKcOthjFGegfGcv4It3QnU2VoBXT59UQcqww+cd0Ad7XQzjVW5pufJIaIF/ahvh3ja0y2ep7Ii5dYlJoqtMsRc1U4+BvyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/ATI8xHG3sBP9BTnBAUw0vNEqEn3qhd+nR+cz98RWY=;
 b=DjHF3zjNHkZj6si3fkDeLBhcWSkyFYFO4UEtm6JLV2V3p5mVkcg0RfIFLFoUIgxS0ftJjpdmidvZCiX9B+UC8sm23+KVZceMDyau8cDmbwYTJjFN+tPYGrM3qT8IX3wJnwC14YkqBKzCw3A+DC+fkquqZLbCxT1zUWybd6S0tc4=
Received: from CH0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:610:cc::29)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:53:17 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::83) by CH0PR03CA0084.outlook.office365.com
 (2603:10b6:610:cc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 20:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:53:15 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:53:14 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 09/19] accel/kvm: Handle guest_memfd flags internally when creating instances
Date: Tue, 8 Sep 2026 15:48:29 -0500
Message-ID: <20260908205236.838281-10-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: e64631d7-7d51-40ac-aedc-08df0deb3440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|6133799003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	J0UTI24mlm/DMvFaqZ0zkcx5dAjuVY/MwqXGLRySoYgPokH82ijcAkYCLBYhtMuLEhBGbxHTuH68PE4n29+/h+n4UtsvNjydDKceZ9OD9AmI9v089FTc3rweI/p0/J7BjhjNhIxVV2uwiETPzKrsc1mGCxIqCDr58SlSHy5//ErAnWIObBq3iBIEsaVB2ZcUBod+6TIW+vE3PWyZRJCBUkohqRmIF5p3n+YUCRuOizwpmx2hqT3BymejEFL3o54FGywNamcGNmy7DroHkCkgl+i2wwy0O7dIiA2fyPrOGbuhkEjHmIGte7574rQbbdQy2xozIGYCUsOM7bDn6uWkQVs0u4MkSvgXH7aE1CBF0bQIunbXO9//Ux94Lvlf+Ne168codGyfd2FwpAmuNqOZ2jk3JSDua5UGS2kAQkyP0ZjRTm1AMTLj6XtnaPK+bBrHuKFoHqHZS6WLmSZjT9jQJoqdJPcIX9flVTChzIg/vUrbKeSzBRn5MVdA0OfidS8NJogfojrxTNU/z+lt0hUIg3l8TyhZBJkQAhfXyw4EIQPAep15+jZCOUcMqITx71wUFmkM2S0xb/sH8PhU3IvEYtRmFPGrWtDv53z3/6ZqDdoU+sCk6h86N++qT0pQr+I8IigxQ67niezAD2hNxXzNR1JpkWmPqU8KsPHwY0/oeFJDziGOiplo7yPYOArE9G6pP1dhGUKQBr0P1U6d930Fpw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yg4/pcXchC85dSz0g4K6IRksu6bVEiZyyad8Ml2PDPO5FnO553rdwsBBZx/B7wziYmpUBFEx9dYsbSgkjJjtRKi91fL0EwEZOESuIwRURV28w/W6qrpuBVqUk2a2UT4XtLnyNyvn1cqqFyWwK+1jRHrdtD1fMrLktCDCKOhKZ1oI0RVkA20fN0JkPXZLbpMdtxnzR1/Sm1kccqnu+Bwnu5xz51jQ2dzHyJrykArBeiuVTvUTeSf2BT2MNQpO7Cpf8gySU+IZC/AamhWGZ9+AOIfJESJ3RSHi91ugggi+KUZIxCs0eDK+zvnpYdhqlWKa8hGRlAS4pqAc8oGV8qusEFGCvB4XMzvfbF2y9QLr0f9zKAmf8KReZ5fVlppGXP/F8MG5vnF5+QwOeZEZqsyQ+dBFgz75vmkg3irMfXLc4je9/7m8N1LscV2nCc9R8X2L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:53:15.4486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e64631d7-7d51-40ac-aedc-08df0deb3440
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

Current hostmem code (which is callable even outside of KVM) specifies
guest_memfd flags directly, which requires pulling in kernel headers.
Additionally, it will eventually require additional knowledge that is
more suitable for KVM-aware code (e.g. whether or not to default to
private memory for confidential VMs).

Instead, push the determination for what flags are needed down into the
KVM/guest_memfd code so they can be handled internally based on VM
type/configuration and avoid further potential leakage of KVM-specific
code to general code.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c      | 26 ++++++++++++++++++++++++--
 accel/stubs/kvm-stub.c   |  2 +-
 backends/hostmem-memfd.c |  6 +-----
 include/system/kvm.h     |  2 +-
 4 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 2b838eb690..bf81a19423 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4857,7 +4857,8 @@ void kvm_mark_guest_state_protected(void)
     kvm_state->guest_state_protected = true;
 }
 
-int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
+static int kvm_create_guest_memfd_flags(uint64_t size, uint64_t flags,
+                                        Error **errp)
 {
     int fd;
     struct kvm_create_guest_memfd guest_memfd = {
@@ -4898,6 +4899,27 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
     return fd;
 }
 
+int kvm_create_guest_memfd(uint64_t size, Error **errp)
+{
+    /*
+     * There isn't currently any use for non-mmap()'able gmem instances
+     * outside of kvm_create_guest_memfd_private(), so hardcode it here
+     * for general use.
+     *
+     * Additionally, *_INIT_SHARED is needed for non-confidential VMs, and
+     * confidential VMs will default to this as well to allow similar flows
+     * for initializing the VM's initial memory contents as with normal
+     * guests. In the future, the initial state may become a global policy
+     * decision based on the confidential VM configuration, in which case
+     * this would likely be the right place to decide whether or not to set
+     * the flag since it would likely be a globally-configured option.
+     */
+    return kvm_create_guest_memfd_flags(size,
+                                        GUEST_MEMFD_FLAG_MMAP |
+                                        GUEST_MEMFD_FLAG_INIT_SHARED,
+                                        errp);
+}
+
 int kvm_create_guest_memfd_private(uint64_t size, Error **errp)
 {
     if (!(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
@@ -4905,5 +4927,5 @@ int kvm_create_guest_memfd_private(uint64_t size, Error **errp)
         return -1;
     }
 
-    return kvm_create_guest_memfd(size, 0, errp);
+    return kvm_create_guest_memfd_flags(size, 0, errp);
 }
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 9fe58efe91..26003b01a3 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -139,7 +139,7 @@ bool kvm_hwpoisoned_mem(void)
     return false;
 }
 
-int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
+int kvm_create_guest_memfd(uint64_t size, Error **errp)
 {
     error_setg(errp, "KVM is not enabled");
     return -ENOSYS;
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index a9759e682b..de51cf738a 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -19,7 +19,6 @@
 #include "qom/object.h"
 #include "migration/cpr.h"
 #include "system/kvm.h"
-#include <linux/kvm.h>
 
 OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
 
@@ -69,10 +68,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
             return false;
         }
 
-        fd = kvm_create_guest_memfd(backend->size,
-                                    GUEST_MEMFD_FLAG_MMAP |
-                                    GUEST_MEMFD_FLAG_INIT_SHARED,
-                                    errp);
+        fd = kvm_create_guest_memfd(backend->size, errp);
     } else {
         fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
                                m->hugetlb, m->hugetlbsize, m->seal ?
diff --git a/include/system/kvm.h b/include/system/kvm.h
index b1e43ddc93..2a1501bba6 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -547,7 +547,7 @@ void kvm_mark_guest_state_protected(void);
  */
 bool kvm_hwpoisoned_mem(void);
 
-int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
+int kvm_create_guest_memfd(uint64_t size, Error **errp);
 int kvm_create_guest_memfd_private(uint64_t size, Error **errp);
 
 int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
-- 
2.43.0

