Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013007.outbound.protection.outlook.com [40.93.196.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E32748A8A7
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381026; cv=fail; b=YsRqBKUeowjA0W6cgwju4dzMTcSR7Lkk4olRKY5Vbc5ZHUogrZlJw2fLBTpu4F/B6A6o4YtD09nuzG7qac27bcfRW4y6fKH3dYwA34mo3JITELZ/KLRInjMH6Jz7G0MtqgCKx+FHUinbnV7sbBzQe9TnDJ/nb5RE+MMTjWqsvr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381026; c=relaxed/simple;
	bh=DSAXvoTxcRnvI8T81A+dzPO3jP+WOQqvSqOWIFHE8aE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdsSNuG/UkvsbSkl7WwGc01wvyCpwt33926IVXY3oQLHc9KTi2ROktZhsj/zuGajcepj8soYb8H9TEnaKEyv90+u+W1+isLFzJQYkPdtYCQnJKWmyKOKOnb3fyi90YQDHpOlqXrK25wa+sPYFrWSEKq8suptuybi6aN9zp2Jmws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jgZCRsTj; arc=fail smtp.client-ip=40.93.196.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jgZCRsTj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/d20TlEfjTKCq2Uijz5asFPjpOYvE8vP6DPE7gvmWOki+8GbYtc4nKgzNYxMz2UwRfNhWJcjhvHiFp1EQdT2DtK1PH2Glh3+ckDQlb6/RONjHIuetoEaRR0y205DgIOljzHBH7GGm3/avLU/ARWolVfma+5heoZ/i8SsYnFIVkJpDcCsylqEUultMheyDb5bKEgdQPCBg4913FwmnEe4Awtmnp8qDZ1xcXfdwrimh0P/1yJ9zstKma3urCHvQEawuWwghhA5k48ysPFEatgoPDO0K2c8wyk5ycAOpFcWwe68Dyl3u2dtmbVB0oh5kKuqFc7RB9wtk3urqV97LBZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGE0IdfZoqVvqp3ybB5dYyjRe2En2t0XaFBRYaxlgfs=;
 b=uWNkuc4p+kEPUZ479z5+1kuYf+djEo62jINIZxNT3M+Do33bIWrOcNqtScfap1fFjxdSrL72GxsUApnJUr8qNOHXNwTqf5oMERdkn1sIv1X0jnjCtiyG7cLMl0IokJmmVFm7xCxbNJ4no/ACj5UBelmUaNriT1Kaq2f+dbdhyL9QHUPanEGhrYIesCbTEfEgS+cNh6Pds6yOhRBCEFg+STApJJP0+pfDljOtIr56JRFLSzqPMHU4w3Z0ixlmX37Dgedh/AWd15VJjA8Ud3X5i4CDY3uFso+8zyUwDBRDRqYV1rQvZto/QQVx1zOm8G/1g8x301/lmGJjcxOZ+syiUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGE0IdfZoqVvqp3ybB5dYyjRe2En2t0XaFBRYaxlgfs=;
 b=jgZCRsTj7iL3Mqmq4oU5r1DnYpuUoJG17aoSZRBzW/NJi8ZLbQT82YhWW0ipv7FfhzjrwQlM7b0USOCL9lo7wcxdSuYgWNs55Ng2jpfH8phLKXRfPPW6kS+QpoLPPCiT0kAejajIvYgxXA51xiZVkYxt4tFQ671bzA7AnvBwMpM=
Received: from MW4PR04CA0034.namprd04.prod.outlook.com (2603:10b6:303:6a::9)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 13:50:08 +0000
Received: from BY1PEPF000264B3.namprd02.prod.outlook.com
 (2603:10b6:303:6a:cafe::46) by MW4PR04CA0034.outlook.office365.com
 (2603:10b6:303:6a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 13:50:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B3.mail.protection.outlook.com (10.167.242.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:50:08 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:50:03 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
	<ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 07/19] accel/kvm: Add CGS flag to control in-place conversion support
Date: Wed, 7 Oct 2026 08:41:31 -0500
Message-ID: <20261007134323.1606088-8-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B3:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4a8a2b-ff6c-49ef-5a0f-08df2479e62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|23010399003|6133799003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Bv9ir1E5rShqDLVDVf0ONSrnbriPqb0GIqwODgpa3HUpONnNiYTjy4ENar0/THBd72/TerKwywyBCJKx3OvgFVNkk4vFtTQOgxnGYMkUSC4hJFK1a+qUP8+wMu9xn7mAQb/r4wAZMWeE3L3gNJ7U3fDKOaGun7wS98PToMf5m824GTv+DZEJLsCDvEvRpbkkOQlFyp0op3zhe9DTG4cIEE2v1auENQxDJuKAlaxLtFJ4S8P/HDuGLW+ZGageBNfSvZV0f2+K/p8SH0c68SBLnIq39RCbtFPwyJvsSpbMNnMMGNKv2Xx9guSYeMO2jEYvYVMYez5tqdFy3rIbOHXW2mjnEYHl8nT7TiSLip+DIvEd9EHJkIzSz+hXcn8dw6Vxjp1G48L/uU5ymf4zTuMEqmxwG8eeVRhTIvjfzbqXNVO5DNbK67gKFN44DMT1o73op2C1zGz++rn6V5lOTjD0LFRm/xfoBUuzECvDhTdFI53X47wTRXefm9FKjA3qYyqRpDXR9C/7lOVHKM7Y5E4zW60U1+rP89JLvVpMQ7219AlhjluW61inCmTo5265eV6LmkvU3zP1W7GjCrzQTSMBVeAdELYt+xiub7g2W815jysW2wKa6cNdHGeQbFF7UDh3QymF4UzxE6eARI9tYuZU91oBrX/P6QzN6g8YmwUzPUkvKchdoGmUE/goegs1piBSzL8Mtlir/DR0lDp8JX/1+g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1h45aBFqYbzI6qqHKLsAMUk8KqUwR2vf5cqKdU7xTC7ILDhcTk2TqF2jS3mDFl4+QxJQKThCTY4vgowztExfU8Uwy7WeTxQcZNo/jxiDrALzs9k6mZE6qnqwFU1wSgzL7ddA2lgvc0HgxfjDnbqutqg0QkghdlmUwBFX4ywG6xKgANLoyIlTGwd11amjVuBkWvStbYhtgLI93wPNLPIXBfsmVvmdep0UIsFgg1zHOC3YTEWiKjFhidV0uPmj1kCj2h6H2rSNz/gdkEqSOeFsMrgtU1aRPF8XFahW9DvWN2FHwle/Bx1H/YZFtYnShhQuT3DGoPeIaOw4WBT1pL/XiIXQba863yb7gex3cpW0ffBDs4gsNZ3zLzXnZUrGzV2Iks/ldInSJwYlWXXbDrw5Gf2MEtUsNXcnUxf69PjJpOgYhfrW4b5VHlSveQ/a5mEl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:50:08.0013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4a8a2b-ff6c-49ef-5a0f-08df2479e62d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232

For confidential guests, guest_memfd is currently used only for private
guest memory, and normal guest memory comes from the configured memory
backend just as it does for a non-confidential guest. It is now possible
to use the same physical memory to back a particular GPA regardless of
whether it is in a shared or private state. This avoids the need to
rely on discarding memory between shared/private conversions (to avoid
doubled memory usage), and is intended to be the primary mode of using
guest_memfd for confidential guests moving forward, and future features
like hugepage support will likely require it.

Add an internal flag to enable this support. Since
ConfidentialGuestSupport is already used to track some
guest_memfd-related functionality (e.g.  whether it is required for the
configured machine), similarly introduce this flag as a member of
the ConfidentialGuestSupport object.

Also add the KVM-specific checks to enable this support, but leave the
option disabled so that required changes can first be implemented for
CGS variants that intend to make use of KVM's in-place conversion
support.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c                         | 18 ++++++++++++++++++
 hw/core/machine.c                           |  5 +++++
 include/hw/core/boards.h                    |  1 +
 include/system/confidential-guest-support.h | 12 ++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f1deb458ec..862539aed4 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3074,6 +3074,24 @@ static int kvm_init(AccelState *as, MachineState *ms)
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
+                         "module parameter is set to 1.");
+            goto err;
+        }
+
+        kvm_supported_memory_attributes = guest_memfd_supported_memory_attributes;
+    }
+
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
         s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
diff --git a/hw/core/machine.c b/hw/core/machine.c
index d9ac4b419a..e9cc6c2420 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1346,6 +1346,11 @@ bool machine_require_guest_memfd_private(MachineState *machine)
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
index d0e4ad9820..9ea124b224 100644
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
index 5dca717308..2c9a9ff217 100644
--- a/include/system/confidential-guest-support.h
+++ b/include/system/confidential-guest-support.h
@@ -92,6 +92,18 @@ struct ConfidentialGuestSupport {
      * so 'ready' is not set, we'll abort.
      */
     bool ready;
+
+    /*
+     * CGS implementations will use this to indicate whether or not
+     * to enable in-place conversion for guest-memfd.
+     *
+     * If set, the machine re-uses physical pages when converting
+     * between shared/private (as opposed to using different
+     * physical pages depending on the access type, which is the
+     * default mode when 'require_guest_memfd' is set without
+     * additionally setting this flag).
+     */
+    bool convert_in_place;
 };
 
 typedef struct ConfidentialGuestSupportClass {
-- 
2.43.0

