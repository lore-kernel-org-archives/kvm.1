Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CA74446F7
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901184; cv=fail; b=uqM0TS/d0Duxi7l39zctDx4reul3mfTfOnC+4Xct9MU2kO15U9XijtvhqdeieS3oNWR1y4t1CVhO4FmAIK7kMjBWVXSCF9Wfd/GqaAxcnq+miuxLWTrkR4x0iyteTB9a5VFC9nDo3kwtjXeCHfK3bBN3NJlRW4Jk1GGxEbDAAgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901184; c=relaxed/simple;
	bh=afFhVg2gmp3VIXK2NfFaziRXiSKgh/CZpwb9AmdXqRk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5qHamIUZUYaPwfDTeCtPP9STS9l4IZhELRgHs4NTntB6OdKTZTQzZ5mSxzDClFWlk7YBxuenmX9jhrJm3tyc/4gddarQ6jzH6STZog7C0cBTptYX5gSu92XMzJbTWbva/0jUeIWFfL0QrGkHWfNDGydepuy7iP7WycUNlFCiKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QjQHpujD; arc=fail smtp.client-ip=52.101.57.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QjQHpujD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZvX8X1OwG2sao5xxxtmr0457XiNirfwwAabIMwK4TvMxM1CFJp9EEBO1wrKUpC3Xw2PEX157UipixmuP1ldgLEhfkB2h6j3BIRPG1DSX0BD175TFzoqkslIhoMPTXtWGekwVjZ4JECZzRr3xrymRFcMd2JCdCmFVcrtS0EsdJqrHIZGSHtCzOr7yzhvI2o1+RywrM5FF/p86dY37Pwt7pZiRXpNINfLDGccFnK1GWmXg4+RvE7yYYHkvh2/McNlUfa8GMGVYgZqqM8Q1fyG5r5B5DOb9yDmqdSIKXPIDlaLSrIWWN8dtBdoW2quB/VsUY/oZQnpCnbqV7I39s2pDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytu4/9UIWsuLcpRQ8EPBKSg7JIP6za1nfJqdyEVCD7Y=;
 b=b3/psY3xHMXsepJ/De5uM+Npwec8PL8PwwrE90nvqq8H4tCw9vjyOexqdeadud2H02ZhOFIrGnhoA7OohPF/Ky8KEIFHpGMuhAzZ5sgOWSHU+Y6AdrOaAPjFpaHAzDDVtw+0UZl1E4IW/asCaZ5a6BD8AWcHV21wCBhbyg9HSY4t94VBgVMaj4CAy9poPPyvbhVyo9U6FxtfPlHrQmW3lTQT8mUvEsUeZZJiypJQHZwpQg+07BQZuJZrKbAPpBkTBOd/2mCy0gKwTiIPaWvt5VIw6zJHiPIGN/nWZ4c6SC/vAx6MgB+yl0GfiiXVHGYwsnY08EVFNXnJa0hO6F826g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytu4/9UIWsuLcpRQ8EPBKSg7JIP6za1nfJqdyEVCD7Y=;
 b=QjQHpujD0TmPM0MptbzEEP5E46h0UmNq08LpVh3Y98ZsMnoCXxHNDXaeHtViVNAOY81QWssTWYMQtXr1aJNsdNK+EsfoaZP8ual8LsCkO/Fywb/6uXzuRi/ekyYwna0idNscV7vk6yWUYsxs9gbHgzZzVS+gq0+gPDKarl9WjT4=
Received: from DS7P220CA0094.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25a::14) by
 DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.6; Tue, 8 Sep 2026 20:59:33 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:8:25a:cafe::1) by DS7P220CA0094.outlook.office365.com
 (2603:10b6:8:25a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 20:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:59:32 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:59:32 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 07/19] accel/kvm: Add CGS option to control in-place conversion support
Date: Tue, 8 Sep 2026 15:48:27 -0500
Message-ID: <20260908205236.838281-8-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2ab9d8-a59d-490b-6c60-08df0dec154c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|7416014|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	rXCvU7vSTixCTVDHK2ZQXNowktpRxUvdBtZFbMA2scPV690/c9DssEV9LYZnbMo3dOS+bJ9v1KrYWgwd/QQEXFmWMzKiXP2ZTLZZITONjsRj82IVlrHwVoa67MM8QxM4/OboSGxBBsG73oWBLUMpqTP+Zb5IAorDLVZneyPRfzYWo8JPYvJwoG8R5k6YlwRJUcVdcZhkpOTgY69jInCRAhvqm+v5ysKzIIeOwJ7ZBZkYVNxGGK2it0ouckOpyAy4yFCaJFXW+6aYdQPXJHgT0P5eGeh48DpK1g5Zl4wSwC0EecEweqxwCwoOBypn3wjw7x0dMUgGIP+0MZxD26fnfVKHfProfQ9RMNWKU26Oo6m0vX5tScXaJNZ9PwMofecmJpuVj3kR+MmliWv9WxQII7uJPr/ZGsFma+7oUxFzW6MMARpLJYISkPqplM/NyHfx0MblIouSgFG6w5UCUJBSwCkJcDw/PHZIUP/fgGhDccohEMrCdTBQpbB33dmqDiWiHsk+ssm0xQkeJpsdtib53WvzIEhT85Zof7+J+jLy25herfpI2OrHBmMrNOmVXlig43eRXaGsxJTIITkRRUFBtvn5r3QrqOHxf6AMe7JyXZTc4UjsOMWGJ2nCKpMtGjkMFuKQt5oCY2NISK2vwPbsAsFfCES0GHxmXlq1kkJwRBNg2AgJC5z/17ysry/X/Xm20Xsh5Fea9Y4tMSFqfMK6ug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(7416014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YAFM2uip8azjrrcztpN2/BhtTCr0Rv2PZYa0xbXdUrMK1m1z60O87HO0/omjzBgaoGjVg9wp8vUKCbZvzWPmFtoijRMcY8Jj3+UJi8poTfvBCDbYR6V0BRUOLMfYy7aaHE8I4ItdoNLxKm8oVYN0kya3yo4MD9wmYRJMIRRwpoVslZR4QZ008QnoX5wSBwWfB8iJhBmzzok07skC9BPZLrAFGz1Zx7ZZRbgQuL6PG5oYeJVF0zAvbGkQAGKZPhUwxQFRlhRWUy0ZEQHky6IajkoAjEP+01MS9xxx/RXEQ+rSquj3WLC+9aYTGNmMrgqJEmSy5UgppaXBXK9WapmUiZZFSv3go2i8wum/hoXcmCtcz0MehXrgl6loS9KcePIS67wL8+LJOoFpxNa6KKcfLoh00aZvQ3BVRQc102Y2DmZKPvz0n+y6RzMbLa4Zko9F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:59:32.9892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2ab9d8-a59d-490b-6c60-08df0dec154c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945

For confidential guests, guest_memfd is currently used only for private
guest memory, and normal guest memory comes from the configured memory
backend just as it does for a non-confidential guest. It is now possible
to use the same physical memory to back a particular GPA regardless of
whether it is in a shared or private state. This avoids the need to
rely on discarding memory between shared/private conversions (to avoid
doubled memory usage), and is intended to be the primary mode of using
guest_memfd for confidential guests moving forward, and future features
like hugepage support will likely require it.

Add an option to enable this support. Since ConfidentialGuestSupport is
already used to track some guest_memfd-related functionality (e.g.
whether it is required for the configured machine), similarly introduce
this option as a property of ConfidentialGuestSupport.

Also add the KVM-specific checks to enable this support, but leave the
option disabled until other required changes are implemented for
CGS variants that intend to make use of KVM's in-place conversion
support.

While technically the convert-in-place option could be introduced as an
SEV-specific option, it is a given that TDX will also be introducing
in-place conversion support based on the same guest_memfd kernel
infrastructure, so introduce it via a new
ConfidentialGuestSupportProperties base class that other confidential VM
implementations can utilized for common options.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c                         | 19 +++++++++++++++
 backends/confidential-guest-support.c       | 26 +++++++++++++++++++++
 hw/core/machine.c                           |  5 ++++
 include/hw/core/boards.h                    |  1 +
 include/system/confidential-guest-support.h | 14 +++++++++++
 qapi/qom.json                               | 16 +++++++++++++
 6 files changed, 81 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 15f237de4e..2b838eb690 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -52,6 +52,7 @@
 #include "kvm-cpus.h"
 #include "system/dirtylimit.h"
 #include "qemu/range.h"
+#include "system/confidential-guest-support.h"
 
 #include "hw/core/boards.h"
 #include "system/stats.h"
@@ -3074,6 +3075,24 @@ static int kvm_init(AccelState *as, MachineState *ms)
     kvm_guest_memfd_flags_supported =
         kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_FLAGS);
 
+    if (machine_require_guest_memfd_convert_in_place(ms)) {
+        uint64_t guest_memfd_supported_memory_attributes;
+
+        guest_memfd_supported_memory_attributes =
+            kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES);
+
+        if (!(guest_memfd_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
+            ret = -EINVAL;
+            error_report("In-place conversion is only supported if private "
+                         "memory attributes can be set via guest_memfd. "
+                         "Please ensure the 'gmem_in_place_conversion' KVM "
+                         "module parameter is set to 0.");
+            goto err;
+        }
+
+        kvm_supported_memory_attributes = guest_memfd_supported_memory_attributes;
+    }
+
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
         s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index 156dd15e66..29447fa18e 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -21,6 +21,25 @@ OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
                             CONFIDENTIAL_GUEST_SUPPORT,
                             OBJECT)
 
+static bool
+cgs_get_convert_in_place(Object *obj, Error **errp)
+{
+    return CONFIDENTIAL_GUEST_SUPPORT(obj)->convert_in_place;
+}
+
+static void
+cgs_set_convert_in_place(Object *obj, bool value, Error **errp)
+{
+    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
+
+    if (!cgs->allow_convert_in_place && value) {
+        error_setg(errp, "In-place conversion support is not supported for this guest configuration.");
+        return;
+    }
+
+    cgs->convert_in_place = value;
+}
+
 static bool check_support(ConfidentialGuestPlatformType platform,
                          uint16_t platform_version, uint8_t highest_vtl,
                          uint64_t shared_gpa_boundary)
@@ -70,6 +89,13 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
 
 static void confidential_guest_support_init(Object *obj)
 {
+    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
+
+    object_property_add_bool(obj, "convert-in-place", cgs_get_convert_in_place,
+                             cgs_set_convert_in_place);
+
+    cgs->convert_in_place = false;
+    cgs->allow_convert_in_place = false;
 }
 
 static void confidential_guest_support_finalize(Object *obj)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 469033d6b3..5e66dbe193 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1342,6 +1342,11 @@ bool machine_require_guest_memfd_private(MachineState *machine)
     return machine->cgs && machine->cgs->require_guest_memfd;
 }
 
+bool machine_require_guest_memfd_convert_in_place(MachineState *machine)
+{
+    return machine->cgs && machine->cgs->convert_in_place;
+}
+
 static char *cpu_slot_to_string(const CPUArchId *cpu)
 {
     GString *s = g_string_new(NULL);
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 7925f0451a..5e67095f7c 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -44,6 +44,7 @@ int machine_phandle_start(MachineState *machine);
 bool machine_dump_guest_core(MachineState *machine);
 bool machine_mem_merge(MachineState *machine);
 bool machine_require_guest_memfd_private(MachineState *machine);
+bool machine_require_guest_memfd_convert_in_place(MachineState *machine);
 HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine);
 void machine_set_cpu_numa_node(MachineState *machine,
                                const CpuInstanceProperties *props,
diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
index 5dca717308..c1e9c41ad2 100644
--- a/include/system/confidential-guest-support.h
+++ b/include/system/confidential-guest-support.h
@@ -20,6 +20,7 @@
 
 #include "qom/object.h"
 #include "exec/hwaddr.h"
+#include "qapi/qapi-visit-qom.h"
 
 #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
 OBJECT_DECLARE_TYPE(ConfidentialGuestSupport,
@@ -92,6 +93,19 @@ struct ConfidentialGuestSupport {
      * so 'ready' is not set, we'll abort.
      */
     bool ready;
+
+    /*
+     * True if the machine re-uses physical pages when converting
+     * between shared/private (as opposed to using different
+     * physical pages depending on the access type).
+     */
+    bool convert_in_place;
+
+    /*
+     * CGS implementations will use this to indicate whether or not
+     * in-place conversion can be enabled by users.
+     */
+    bool allow_convert_in_place;
 };
 
 typedef struct ConfidentialGuestSupportClass {
diff --git a/qapi/qom.json b/qapi/qom.json
index 909add4299..20d6fefb04 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1005,6 +1005,21 @@
   'if': 'CONFIG_IGVM',
   'data': { 'file': 'str' } }
 
+##
+# @ConfidentialGuestSupportProperties:
+#
+# Properties for ConfidentialGuestSupport base class.
+#
+# @convert-in-place: If true, the same physical pages are reused
+#     when memory is converted between shared and private states.
+#     If false (default), separate allocations are used depending
+#     on whether the page is private or shared.
+#
+# Since: 11.2
+##
+{ 'struct': 'ConfidentialGuestSupportProperties',
+  'data': { '*convert-in-place': 'bool' } }
+
 ##
 # @SevCommonProperties:
 #
@@ -1033,6 +1048,7 @@
 # Since: 9.1
 ##
 { 'struct': 'SevCommonProperties',
+  'base': 'ConfidentialGuestSupportProperties',
   'data': { '*sev-device': 'str',
             '*cbitpos': 'uint32',
             'reduced-phys-bits': 'uint32',
-- 
2.43.0

