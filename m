Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A92764
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779926931; cv=fail; b=E9A/DDc8pGb0FV4i0m42s6x7mURcFAR77Azom2TRhB7tnA8maSl+45bmNBx5+9Un160bY5aD1SzQ/fnfLmapvxga5SwmlLV9sMAGz3U0BH1aj3jYl+aUlzLmx5cjwRWUth+LVd1e4+tMEV5FateHZXIlMdjPET+rm68zTvcziVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779926931; c=relaxed/simple;
	bh=6DHfKxhS1xFXLdQMLON59DMtLfX/p2Z+aoegcMeK8wQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tl+rW7c6rUsNj7GKQqGhw00aG3BIFyi6UtdHsNuOI0ahha00f/hJKm5Xqkb3vmaxY/5BoB2+hovKGxzfzv81Y1Lpffsk66T7lJYA9FhxfrHP8kaZR1wDuxwNvunqrrEkVztQ59lFckPcrW8iXVBqwCHwi7SuTkm+/gGod/xf61g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mMirw7pz; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mMirw7pz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECdYfZ4Rv9ms5hJRUxlX738INxCTXpLDzq2SSn1MHRd8i9yuR2s9vZA99NzMN6Xd5tVK+T5/P3U5H+skawFvzQdJEslRWYlBADT0V3sQgYw0Ctlm5DR/ELTuwulYwLGKZAsdPyq/u9XuVAStvfQ0ZujN0f9Zv4DQNIlWzp5jeJVLLEwiYLbio5fQersfwlqLXw3fjVWjg/B566HxHzWrka78CGmXbVzvKdgH9l6qxezDFNfXJt7D6KEEPsRaZWE/2wGJnFU7W/ud46IehJtFRfUPBdSUN5fbThQF5vWaC5bAEKwJxxEUuH6aYLSUv5AInIzbEjqceysypygzWRZJoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Reu/+jJj557tTnSjG7I7//btsTOl3ByKHW91XuCHiAU=;
 b=HQxnnqQy5vpDBbpq+/JSg98zlgLQD1jxObTM/qMbwHFoDFM16N4T0ZjbvmnCWzaKaCPJNqHSjO0TBiNk17Bwypi3aHIxEs4kycGwNhE5EbZ1tGR9qIa/98Doh5heQ1G62lAZ8tw5RvXgiTRT9xQXmuR91VO5J9tIpM7pTZL2nui9Kl4ua9SRYz6XY+TfgGz7IJkRTF5rWC+ueQ3T3n8dGW98/NyYyHECNRnAeDW7TZR0eYb5ex5Hbj5oL9FW0Bd23Xq2iinmExGNGZnHblZHYj1TLoqnC0TV56nkLtQpEPIjz6fAEYsjLL6O5QWdu3n7L4Y7QZ8QxkuaUU/sPpRm+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Reu/+jJj557tTnSjG7I7//btsTOl3ByKHW91XuCHiAU=;
 b=mMirw7pzeNbvAyu24j6mmKhLbpwoxJd0uCB79x1BdeLaqcdoVeQN2yXqZ/K00tdqI8q+0xUref6yNMzWQyfm1RMb8jJvDPUtIEbg3oksZiJPabs/6o4+N5BCiPkFzk5Y99dNQ1EmPur7sL9mjgQk7eSPaMvYQvu49l2pwoegX0o=
Received: from PH8P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::17)
 by SJ5PPFB332093D3.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 00:08:45 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::9a) by PH8P222CA0023.outlook.office365.com
 (2603:10b6:510:2d7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 00:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 00:08:44 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 19:07:41 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: [PATCH RFC 04/12] accel/kvm: Add CGS option to control in-place conversion support
Date: Wed, 27 May 2026 19:03:29 -0500
Message-ID: <20260528000416.8161-5-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SJ5PPFB332093D3:EE_
X-MS-Office365-Filtering-Correlation-Id: a164b1f3-c4bf-4bf4-5068-08debc4d48a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6wg1Q875UAHcGi2lWk2m6OcaDhNWiYLsKygkhnp1/IA2U/yOvxHc3Ek/sSjHbgAwMbV/pJO2BeHHUsWPednH6lsjGEn8yAWbIgB9MksDk9+qnDIs3WvrkoC0yPoEnRHr+3iJiWHrxri+OBY/8FZRLWs01QaAY+8De3FSjvMCs9RltkbJ0P3rg2JE4wsG4tfvV4gPX8BuQUOreI5yX6pXm1zo3ao4ZysRm0D6kHxC6QviPgj5dXHRmevPCLAG0HqvuHeneytr0jAvMcgARs28k56GBzs1TaU8T8S83A8rESSFAZZ2ehJtUJzV+AYi73US1ow9NDvG/ehjc8LslmdLeKncYADZ8QK3GeWr+AM/vXh77Gs/7qub4zSNNoY8Ca8bllTFXBioAHaVVGI5k78G+WWcX8RQ16mXrSMPkeL1UgmjmqMDa0uVL+L2Qw2YiutC6Q9ck6mI7m2YWCBUZAxYQ+UtqyvmavbvQdyJrBTFHX8x2MMo1jVh47m2jXESS+yqSQCJpwEjmymsdN6U1+LluORbKB0HJKyqVUOyTyhAqVyf3jvZsLqgLBIvwCG9JJHlRfKTsVcBwaH2Ntse7x0lZHPlpAcajJeS2iGx0MRCuLZyXRasx7txp71JiwldZ1mcqrNsmloke9KZvrDNbD4GCtr+Lt5JuRFh2ofqQl3VV6u5ZVBvwQRyawjID6R4O9SCI6hCafT31r1rAMhdaukP0glbt8CDzIAt0XKWpoITb/8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+WjIvbZ9xsUc5HJvsVgIDZn+OkCzFflzrT5w+zwhMta9jypymiPlhRQbN3Q3ft4F2ywSjSu9kBFy0jRzp8weNvPYIWvQFO1AmOfxgIgTUR+2Q8gMC+ujImWO3/hiuG59f8COArIQpY2IzldJdcJLkyATOPWD+C1wg9pVpLz9VYQ5P5kvMRzvgPzWrAgvkkh+Vbs3tbwdrJAWFOOqKKenOsjEIOfzUFyEx4aMlOi67lls0meEQMEpZ4eqObXnqTw8xqwFJ+ojk+CeMckDqL536gg0O04C/EZMnnl59vQ+h4k9jts1cF5feWGOSvvRiHkySQqZZiv9O7FFBN2HWyPXp7L+x0vRcScolvV3IofNAfWLhld7SAtzfKX4TQ4Vcq8YuSI3EMAoX9gViECvyEWLJzlLqoPiUh9IlxJvdrLp7aruop25szUfJyYbvC99EEkA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 00:08:44.9568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a164b1f3-c4bf-4bf4-5068-08debc4d48a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB332093D3

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

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c                         | 21 +++++++++++++++++
 backends/confidential-guest-support.c       | 25 +++++++++++++++++++++
 include/system/confidential-guest-support.h | 14 ++++++++++++
 qapi/qom.json                               | 16 +++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e6ae2e8ced..a1832712a4 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -52,6 +52,7 @@
 #include "kvm-cpus.h"
 #include "system/dirtylimit.h"
 #include "qemu/range.h"
+#include "system/confidential-guest-support.h"
 
 #include "hw/core/boards.h"
 #include "system/stats.h"
@@ -2901,6 +2902,7 @@ static int kvm_reset_vmfd(MachineState *ms)
 static int kvm_init(AccelState *as, MachineState *ms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
+    ConfidentialGuestSupport *cgs = ms->cgs;
     static const char upgrade_note[] =
         "Please upgrade to at least kernel 4.5.\n";
     const struct {
@@ -3076,6 +3078,25 @@ static int kvm_init(AccelState *as, MachineState *ms)
         kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
     kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
 
+    if (cgs && cgs->convert_in_place) {
+        uint64_t guest_memfd_supported_memory_attributes;
+
+        guest_memfd_supported_memory_attributes =
+            kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES);
+
+        if (!(guest_memfd_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
+            ret = -EINVAL;
+            error_report("In-place conversion is only supported if private "
+                         "memory attributes can be set via guest_memfd. "
+                         "Please ensure the 'vm_memory_attributes' KVM module "
+                         "parameter is set to 0.");
+            goto err;
+        }
+
+        assert(kvm_guest_memfd_supported);
+        kvm_supported_memory_attributes = guest_memfd_supported_memory_attributes;
+    }
+
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
         s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index 156dd15e66..c89bcf3cb3 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -21,6 +21,24 @@ OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
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
+    }
+
+    cgs->convert_in_place = value;
+}
+
 static bool check_support(ConfidentialGuestPlatformType platform,
                          uint16_t platform_version, uint8_t highest_vtl,
                          uint64_t shared_gpa_boundary)
@@ -70,6 +88,13 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
 
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
index 502fafeb15..037c078799 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1014,6 +1014,21 @@
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
+# Since: 11.1
+##
+{ 'struct': 'ConfidentialGuestSupportProperties',
+  'data': { '*convert-in-place': 'bool' } }
+
 ##
 # @SevCommonProperties:
 #
@@ -1038,6 +1053,7 @@
 # Since: 9.1
 ##
 { 'struct': 'SevCommonProperties',
+  'base': 'ConfidentialGuestSupportProperties',
   'data': { '*sev-device': 'str',
             '*cbitpos': 'uint32',
             'reduced-phys-bits': 'uint32',
-- 
2.43.0

