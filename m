Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011003.outbound.protection.outlook.com [40.93.194.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9FF45C6ED
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380905; cv=fail; b=O38/MGPJl/HVE7MMSTp4fq6vdcCaT0CGkF1FLKMZMJOYwHdDMtMlrEAtSTuy4ESCRXz9J369PIfiGviPpEIN7OLLSdvoLzzO1rXJvL/z/WPtC5YpIH2w8Awx1GqRzMjy7wadtfi0rcFbAVa/nt5BTyFsQYP+wX0FmVA/oGU3uio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380905; c=relaxed/simple;
	bh=KzRZKHIdHYG+8e3oNnLJ2sFZyB7bg5JohmVwcw48Kh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rK4d02Re67q3d5QFdi0Va5+kKPEPbRiZPck7utC0DXKhigdMrzH4dhePZbOzGnFUCJLBaWWWRnNfgXjcKnr5KmZZPUa2Kwif71x9quaNIaruy/drfVCK2xK3XB1Xkoh+8a3mnyXTX5RifsBIQOc17MpazUQEGxudxBHIQjbhiyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=inieBsT7; arc=fail smtp.client-ip=40.93.194.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="inieBsT7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrZ3ZfElLf02BsmU8KiptahPEcput3c7L1KyV1elH0E/JF5hyL1S68rJqeM4IUK+8Brve4vPu+mFkJ26n1vfhHwnvEq9IuxNbslWOtISoGXkJ8+yTnZdOm+TNdxDPqQ6wkGXLXPjGradtNnih0PRdaELJOBrElc1BjYqN3RBI6sMGGSBCV05csVzZzEaO+VFp1D/B+TtRAPbhJouVNNgJUpA5d2nZrRjWkV9xUOtIy/eOePFIqR2D4086Jc6ShjQc6icCTNGcK//N7XKaCnBce/TyylzTVEC7EeiYOQlGvfFTg8wLfCGC77tSqWkKi6eDNKUpTO8Ue0zFwU3z3smew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5abwgF8DvVYI9AYSzlBVazZExpdePXaGa8i6mrF5cfI=;
 b=CpIuulYSE6Lt5WtK5RtING4JkZjy7vk9iG/gMM15bhH61inI56s0xCGiA8qF5cXgOldSvNINoxWJ+Xmzr0DHqm+efUUzKTevqin1b3EeS/wmYdqT4BiVNcf2YLKW9xLxQThUNle1LO3RBUMS6fR9Mnp50v8vLchinEryhgdx36GpfCryAQUZMlA79oIrCMQRs780zT97nCTV3RnGc/pFRsFLM6wyScn9ZCwQP1/8veSFzNYJC8VzAMDFDjGBInvY//yOw+g1ZvZwuAGi1mmD3WkEzXBCBFy0fdZsYRWzDA3pvUTj1F7TVOEYUNugtqdg1+CwlZ0RKtJzxvAKtTLm/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5abwgF8DvVYI9AYSzlBVazZExpdePXaGa8i6mrF5cfI=;
 b=inieBsT7dP77h4ZW0dDEtNNF6Yxy29H3pdk6HdZvqVmGm4nQY12h0LmuFiaAmQNJXQb8Iz0viDrHEqZiMTJrHI11fRj5BMAvhiE8s55qRttQMrVzQfubiG/F/LhuNqgzb87OmrJppBKT0jR0UGZFX0WRGLcMHjdIcb1DHsE3vjg=
Received: from BY3PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:39b::12)
 by DS2PR12MB9797.namprd12.prod.outlook.com (2603:10b6:8:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:48:09 +0000
Received: from BY1PEPF000264B1.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::e) by BY3PR05CA0037.outlook.office365.com
 (2603:10b6:a03:39b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 13:48:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B1.mail.protection.outlook.com (10.167.242.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:48:09 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:47:54 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
	<ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 01/19] accel/kvm: Add helper for handling conversions of MMIO holes
Date: Wed, 7 Oct 2026 08:41:25 -0500
Message-ID: <20261007134323.1606088-2-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B1:EE_|DS2PR12MB9797:EE_
X-MS-Office365-Filtering-Correlation-Id: abb232b0-5438-496f-59c0-08df24799f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	IH1w1aatfyw9LejFAIn1OyWZQmo+XnUPE5MFjXrxOvqVdS9SrDd9zOS6aw/ZKPkT/uFZf99cf3PKZFDXgVIe6nKD2Gae7Ell4zd5sl61091EOxvDlKIAiNrbNJZQ0YCgb5RWPUH2K2phTB1mfmKIZkefMt4HaizQF8Dxz5HY/VI7/JaotcQ3mewQcQczpW/AFG4TzxCIQqizDXBsPfHRYDXGbhyk23nCESHQdt9lU40SycY3KIzG7vdcYpFeglGyBYTUJ6kJVgRY05K4uNo8vGccyPBetiOaIlHPva6Tv51TeB6fux0C3pCI/8DM7HqQnBCJ5NZwyTuYgdZC0dv2AWRhhvUparkz3FJo4lq06y0WFHpIZ/srYb5pHKOpDuEQPFzlYCnKpJe2Dp7g6I0jrZIvBFyn/BfScQwbZKslO4eQTZEC6g6gH1srW65Z6knEhC3WgJ0kByr+0+iaFa3zxaETE8lcSJDXqZBjNhJ5i481y+L2bAL1g8rDzb4rqol8iqBMqECeXoXvhd2SFSKBeLLc6egC2fFNfyHOO1al8VGttB0HHMmxeznfgL/wjSzM5z2CsQmqT3J4nsiKpxf2xa33WydEgk9OJF3QxvAQFfaBXVTa7sg3PlXpDtfZq0DgpSWd65fS8eF4P9iSoxE73ijW4iz0BoLLe96uAhH7XcRV2bB7j3D6wKW1cihzt4OvQHFFpeSKoy37XNwIzf9O3Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vAYcCbBDqrsItC565ib7HICuES9Jcecfgp0HMvExSnIAjsakZMdSarMSVndPG90vm7ETwb9cxI5RuKzwi0RwgrHtGYBLkYPSdI6OjVAjurPZ5Hh/efye0hj9SGrX71g3G3ro7zmOljZbwEEszHsOQkwozbPSCQaZR8P4OqvXxYs/NwhILkHKSfRddSghdawDm3W5TSoHnIGKncr3rKl1sdVcJcGympVz34ZMyDow/l8dIMiW9BjqCoE7jCe1cay3fcf/6PkUYu7C0UjzymbOVpPfp0Vzprav6vuk10sPIMSYFUlRUgWhIOZVi9nfbatPUbgutnCyrtX9W0WezzUtQUD7FBC9wZxxt/41Gp8D7xjba+IqtLp8bxl6S7PF57MayBIkW49TeWnna4PcY2uG4AnUeO908rznlUsDHMq9ZHI+a2pHKobnqL67Dp2zc8TG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:48:09.3985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abb232b0-5438-496f-59c0-08df24799f7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9797

When converting GPA ranges containing MMIO holes, the general intended
logic is to skip MMIO ranges as long as it is a private->shared
conversion, and to fail otherwise.

To better enable some future refactorings to address bugs in the current
code, go ahead and consolidate all of the MMIO handling to a
self-contained helper.

The only intended functional change is that the error message for
shared->private conversion of MMIO ranges corresponding to a
non-RAM/non-ROM region now report the range of the region that
specifically caused the failure, as opposed to reporting the entire
conversion range. There is also a stray "," in the error message which
is fixed up as part of this refactoring.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 96 ++++++++++++++++++++++++++++++---------------
 1 file changed, 64 insertions(+), 32 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index db52bb9ffb..c824e4d963 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3334,6 +3334,67 @@ static void kvm_eat_signals(CPUState *cpu)
     } while (sigismember(&chkset, SIG_IPI));
 }
 
+/*
+ * This handles checking whether a conversion overlaps with any holes in
+ * the given section/range, and indicates whether or not the section/range
+ * can be safely skipped (which is generally allowed as long as the
+ * conversion is private->shared and not the other way around).
+ *
+ * Returns 0 if section is normal guest-memfd-backed memory, or is a hole or
+ * non-RAM/ROM region that should be skipped as MMIO. In the latter case, the
+ * 'skip' parameter will be set. Returns < 0 if the conversion request is not
+ * valid.
+ */
+static int handle_memory_hole(MemoryRegionSection *section, bool to_private,
+                              bool *skip)
+{
+    MemoryRegion *mr = section->mr;
+
+    if (!mr) {
+        /*
+         * TDX requires vMMIO region to be shared to inject #VE to guest.
+         * OVMF issues conservatively MapGPA(shared) on 32bit PCI MMIO
+         * region, and vIO-APIC 0xFEC00000 4K page.
+         * OVMF assigns 32bit PCI MMIO region to
+         * [top of low memory: typically 2GB=0xC000000,  0xFC00000)
+         *
+         * If the current lookup failed to find any regions, then skip the
+         * entire remaining range as a hole/MMIO.
+         */
+        if (!to_private) {
+            *skip = true;
+            return 0;
+        }
+        return -EINVAL;
+    }
+
+    /*
+     * Because vMMIO region must be shared, guest TD may convert vMMIO
+     * region to shared explicitly.  Don't complain such case.  See
+     * memory_region_type() for checking if the region is MMIO region.
+     */
+    if (!memory_region_has_guest_memfd_private(mr)) {
+        if (!to_private &&
+            !memory_region_is_ram(mr) &&
+            !memory_region_is_ram_device(mr) &&
+            !memory_region_is_rom(mr) &&
+            !memory_region_is_romd(mr)) {
+            *skip = true;
+            return 0;
+        } else {
+            error_report("Convert non guest_memfd backed memory region "
+                         "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s",
+                         section->offset_within_address_space,
+                         int128_get64(section->size),
+                         to_private ? "private" : "shared");
+            return -EINVAL;
+        }
+    }
+
+    *skip = false;
+    return 0;
+}
+
 int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
 {
     MemoryRegionSection section;
@@ -3341,6 +3402,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     MemoryRegion *mr;
     RAMBlock *rb;
     void *addr;
+    bool skip;
     int ret = -EINVAL;
 
     trace_kvm_convert_memory(start, size, to_private ? "shared_to_private" : "private_to_shared");
@@ -3356,39 +3418,9 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
 
     section = memory_region_find(get_system_memory(), start, size);
     mr = section.mr;
-    if (!mr) {
-        /*
-         * Ignore converting non-assigned region to shared.
-         *
-         * TDX requires vMMIO region to be shared to inject #VE to guest.
-         * OVMF issues conservatively MapGPA(shared) on 32bit PCI MMIO region,
-         * and vIO-APIC 0xFEC00000 4K page.
-         * OVMF assigns 32bit PCI MMIO region to
-         * [top of low memory: typically 2GB=0xC000000,  0xFC00000)
-         */
-        if (!to_private) {
-            return 0;
-        }
-        return ret;
-    }
 
-    if (!memory_region_has_guest_memfd_private(mr)) {
-        /*
-         * Because vMMIO region must be shared, guest TD may convert vMMIO
-         * region to shared explicitly.  Don't complain such case.  See
-         * memory_region_type() for checking if the region is MMIO region.
-         */
-        if (!to_private &&
-            !memory_region_is_ram(mr) &&
-            !memory_region_is_ram_device(mr) &&
-            !memory_region_is_rom(mr) &&
-            !memory_region_is_romd(mr)) {
-            ret = 0;
-        } else {
-            error_report("Convert non guest_memfd backed memory region "
-                        "(0x%"HWADDR_PRIx" ,+ 0x%"HWADDR_PRIx") to %s",
-                        start, size, to_private ? "private" : "shared");
-        }
+    ret = handle_memory_hole(&section, to_private, &skip);
+    if (ret || skip) {
         goto out_unref;
     }
 
-- 
2.43.0

