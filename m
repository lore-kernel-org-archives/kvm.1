Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532AB2E9757
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423460; cv=none; b=I+W8FxA52KEgZys0tbsDriZAQGSwosK+MqwvyeTiI4V18bPZZgjDtELChUXMozyl6fU30kiGwmv1WCilqU3d2BPoVQQgpWI4GBalfbIEh12BDj6aWxiJQlJ+WwrltFY+2+1cUqm/VilSOlHZ15/3GZVNtdj3l03d9pVsFHNXE2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423460; c=relaxed/simple;
	bh=gMOSr40kaw/ZmJN/TdZr0xb/YoP9ErkyEnjhVK7tIx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hrmCoPF9H0E/rlF1ct3sbQy9wM4YcoO2uDiAGbYGcxYnPig911bsj+uDqRTkSYzqSBAHtyPgXxSWIJFskUYyaRIwfh83w2rrr/PhM5iIyGtE9kffdlGnQOk/fmGFRdklGV/LCs5L0zfBc0jtjrhTAtqBcMQLJdLbA52sEe9S+JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Dw7JnsBb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Dw7JnsBb"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 753C520B7136;
	Fri, 17 Apr 2026 03:57:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 753C520B7136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423457;
	bh=K2f0mDhH3YaMavu+Y6z/Fkk1B9ptr1dYqpJLusfrqVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dw7JnsBbpZe1QF5fGrh9B5S1JR4IjJah9aUFxZdM+XtlqbWmHbMdXxY91jEbwoG0h
	 j2Vut3rG1O5KhzEUAS2Nl2EbrUvsGwxTrZqH765j2dHqQt/6sZJSS6uU4U+HuQ6E3P
	 gLeEucpBdU1Xnm7JfzNYn3S7ltw5854m/MHq6Pr8=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 20/34] target/i386/mshv: migrate MSRs
Date: Fri, 17 Apr 2026 12:56:04 +0200
Message-Id: <20260417105618.3621-21-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this change the we rewrite the existing MSR logic to make MSRs
migratable:

- we map them on existing QEMU fields in the CPU. A table and a macro
  MSHV_ENV_FIELD is used to associate a HV register name to the their msr
  index and their offset in the cpu state struct. The list is not
  exhaustive and will be extended in follow-up commits.
- mshv_set/get_msrs() fns are called in the arch_load/store_vcpu_state()
  fns. they use use generic registers ioctl's and map the input/output
  via load/store_to/from_env() from/to the hv register content to the
  cpu state representation.
- init_msrs() has been moved from mshv-vcpu to the msr source file
- we need to perform some filtering of MSR because before writing and
  reading, because the hvcalls will fail if the partition doesn't
  support a given MSRs.
- Some MSRs are partition-wide and so we will only write the to on the
  BSP.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/hw/hyperv/hvgdk_mini.h |  16 +
 include/system/mshv_int.h      |  17 +-
 target/i386/mshv/mshv-cpu.c    |  40 +--
 target/i386/mshv/msr.c         | 554 ++++++++++++++-------------------
 4 files changed, 259 insertions(+), 368 deletions(-)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index c3a8f33280..4d1e062e48 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -9,6 +9,19 @@
 
 #define MSHV_IOCTL  0xB8
 
+/* Hyper-V specific model specific registers (MSRs) */
+
+/* HV_X64_SYNTHETIC_MSR */
+#define HV_X64_MSR_GUEST_OS_ID      0x40000000
+#define HV_X64_MSR_HYPERCALL        0x40000001
+#define HV_X64_MSR_VP_INDEX         0x40000002
+#define HV_X64_MSR_RESET            0x40000003
+#define HV_X64_MSR_VP_RUNTIME       0x40000010
+#define HV_X64_MSR_TIME_REF_COUNT   0x40000020
+#define HV_X64_MSR_REFERENCE_TSC    0x40000021
+#define HV_X64_MSR_TSC_FREQUENCY    0x40000022
+#define HV_X64_MSR_APIC_FREQUENCY   0x40000023
+
 typedef enum hv_register_name {
     /* Pending Interruption Register */
     HV_REGISTER_PENDING_INTERRUPTION = 0x00010002,
@@ -152,12 +165,14 @@ typedef enum hv_register_name {
     /* Available */
 
     HV_X64_REGISTER_SPEC_CTRL       = 0x00080084,
+    HV_X64_REGISTER_TSC_DEADLINE    = 0x00080095,
     HV_X64_REGISTER_TSC_ADJUST      = 0x00080096,
 
     /* Other MSRs */
     HV_X64_REGISTER_MSR_IA32_MISC_ENABLE = 0x000800A0,
 
     /* Misc */
+    HV_X64_REGISTER_HYPERCALL       = 0x00090001,
     HV_REGISTER_GUEST_OS_ID         = 0x00090002,
     HV_REGISTER_REFERENCE_TSC       = 0x00090017,
 
@@ -797,6 +812,7 @@ struct hv_cpuid {
 #define IA32_MSR_DEBUG_CTL        0x1D9
 #define IA32_MSR_SPEC_CTRL        0x00000048
 #define IA32_MSR_TSC_ADJUST       0x0000003b
+#define IA32_MSR_TSC_DEADLINE     0x000006e0
 
 #define IA32_MSR_MISC_ENABLE 0x000001a0
 
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 2c5d16bf9a..29b363e73e 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -14,7 +14,6 @@
 #ifndef QEMU_MSHV_INT_H
 #define QEMU_MSHV_INT_H
 
-#define MSHV_MSR_ENTRIES_COUNT 64
 #include "hw/hyperv/hvhdk.h"
 
 struct mshv_get_set_vp_state;
@@ -116,18 +115,8 @@ void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
                        bool add);
 
 /* msr */
-typedef struct MshvMsrEntry {
-  uint32_t index;
-  uint32_t reserved;
-  uint64_t data;
-} MshvMsrEntry;
-
-typedef struct MshvMsrEntries {
-    MshvMsrEntry entries[MSHV_MSR_ENTRIES_COUNT];
-    uint32_t nmsrs;
-} MshvMsrEntries;
-
-int mshv_configure_msr(const CPUState *cpu, const MshvMsrEntry *msrs,
-                       size_t n_msrs);
+int mshv_init_msrs(const CPUState *cpu);
+int mshv_get_msrs(CPUState *cpu);
+int mshv_set_msrs(const CPUState *cpu);
 
 #endif
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 2d1f90637e..760fcfe8da 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -580,6 +580,11 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
+    ret = mshv_get_msrs(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     return 0;
 }
 
@@ -1025,6 +1030,12 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
         return ret;
     }
 
+    /* INVARIANT: LAPIC must be restored before MSRs (TSC_DEADLINE) */
+    ret = mshv_set_msrs(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     return 0;
 }
 
@@ -1511,33 +1522,6 @@ void mshv_init_mmio_emu(void)
     init_emu(&mshv_x86_emul_ops);
 }
 
-static int init_msrs(const CPUState *cpu)
-{
-    int ret;
-    uint64_t d_t = MSR_MTRR_ENABLE | MSR_MTRR_MEM_TYPE_WB;
-
-    const struct hv_register_assoc assocs[] = {
-        { .name = HV_X64_REGISTER_SYSENTER_CS,       .value.reg64 = 0x0 },
-        { .name = HV_X64_REGISTER_SYSENTER_ESP,      .value.reg64 = 0x0 },
-        { .name = HV_X64_REGISTER_SYSENTER_EIP,      .value.reg64 = 0x0 },
-        { .name = HV_X64_REGISTER_STAR,              .value.reg64 = 0x0 },
-        { .name = HV_X64_REGISTER_CSTAR,             .value.reg64 = 0x0 },
-        { .name = HV_X64_REGISTER_LSTAR,             .value.reg64 = 0x0 },
-        { .name = HV_X64_REGISTER_KERNEL_GS_BASE,    .value.reg64 = 0x0 },
-        { .name = HV_X64_REGISTER_SFMASK,            .value.reg64 = 0x0 },
-        { .name = HV_X64_REGISTER_MSR_MTRR_DEF_TYPE, .value.reg64 = d_t },
-    };
-    QEMU_BUILD_BUG_ON(ARRAY_SIZE(assocs) > MSHV_MSR_ENTRIES_COUNT);
-
-    ret = mshv_set_generic_regs(cpu, assocs, ARRAY_SIZE(assocs));
-    if (ret < 0) {
-        error_report("failed to put msrs");
-        return -1;
-    }
-
-    return 0;
-}
-
 void mshv_arch_init_vcpu(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -1567,7 +1551,7 @@ void mshv_arch_init_vcpu(CPUState *cpu)
     ret = init_cpuid2(cpu);
     assert(ret == 0);
 
-    ret = init_msrs(cpu);
+    ret = mshv_init_msrs(cpu);
     assert(ret == 0);
 
     ret = init_lint(cpu);
diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
index e6e5baef50..0ecd864458 100644
--- a/target/i386/mshv/msr.c
+++ b/target/i386/mshv/msr.c
@@ -14,362 +14,264 @@
 #include "hw/hyperv/hvgdk_mini.h"
 #include "linux/mshv.h"
 #include "qemu/error-report.h"
+#include "cpu.h"
 
-static uint32_t supported_msrs[64] = {
-    IA32_MSR_TSC,
-    IA32_MSR_EFER,
-    IA32_MSR_KERNEL_GS_BASE,
-    IA32_MSR_APIC_BASE,
-    IA32_MSR_PAT,
-    IA32_MSR_SYSENTER_CS,
-    IA32_MSR_SYSENTER_ESP,
-    IA32_MSR_SYSENTER_EIP,
-    IA32_MSR_STAR,
-    IA32_MSR_LSTAR,
-    IA32_MSR_CSTAR,
-    IA32_MSR_SFMASK,
-    IA32_MSR_MTRR_DEF_TYPE,
-    IA32_MSR_MTRR_PHYSBASE0,
-    IA32_MSR_MTRR_PHYSMASK0,
-    IA32_MSR_MTRR_PHYSBASE1,
-    IA32_MSR_MTRR_PHYSMASK1,
-    IA32_MSR_MTRR_PHYSBASE2,
-    IA32_MSR_MTRR_PHYSMASK2,
-    IA32_MSR_MTRR_PHYSBASE3,
-    IA32_MSR_MTRR_PHYSMASK3,
-    IA32_MSR_MTRR_PHYSBASE4,
-    IA32_MSR_MTRR_PHYSMASK4,
-    IA32_MSR_MTRR_PHYSBASE5,
-    IA32_MSR_MTRR_PHYSMASK5,
-    IA32_MSR_MTRR_PHYSBASE6,
-    IA32_MSR_MTRR_PHYSMASK6,
-    IA32_MSR_MTRR_PHYSBASE7,
-    IA32_MSR_MTRR_PHYSMASK7,
-    IA32_MSR_MTRR_FIX64K_00000,
-    IA32_MSR_MTRR_FIX16K_80000,
-    IA32_MSR_MTRR_FIX16K_A0000,
-    IA32_MSR_MTRR_FIX4K_C0000,
-    IA32_MSR_MTRR_FIX4K_C8000,
-    IA32_MSR_MTRR_FIX4K_D0000,
-    IA32_MSR_MTRR_FIX4K_D8000,
-    IA32_MSR_MTRR_FIX4K_E0000,
-    IA32_MSR_MTRR_FIX4K_E8000,
-    IA32_MSR_MTRR_FIX4K_F0000,
-    IA32_MSR_MTRR_FIX4K_F8000,
-    IA32_MSR_TSC_AUX,
-    IA32_MSR_DEBUG_CTL,
-    HV_X64_MSR_GUEST_OS_ID,
-    HV_X64_MSR_SINT0,
-    HV_X64_MSR_SINT1,
-    HV_X64_MSR_SINT2,
-    HV_X64_MSR_SINT3,
-    HV_X64_MSR_SINT4,
-    HV_X64_MSR_SINT5,
-    HV_X64_MSR_SINT6,
-    HV_X64_MSR_SINT7,
-    HV_X64_MSR_SINT8,
-    HV_X64_MSR_SINT9,
-    HV_X64_MSR_SINT10,
-    HV_X64_MSR_SINT11,
-    HV_X64_MSR_SINT12,
-    HV_X64_MSR_SINT13,
-    HV_X64_MSR_SINT14,
-    HV_X64_MSR_SINT15,
-    HV_X64_MSR_SCONTROL,
-    HV_X64_MSR_SIEFP,
-    HV_X64_MSR_SIMP,
-    HV_X64_MSR_REFERENCE_TSC,
-    HV_X64_MSR_EOM,
+#define MSHV_ENV_FIELD(env, offset) (*(uint64_t *)((char *)(env) + (offset)))
+
+typedef struct MshvMsrEnvMap {
+    uint32_t msr_index;
+    uint32_t hv_name;
+    ptrdiff_t env_offset;
+} MshvMsrEnvMap;
+
+/* We assert that 64bit access to sysenter_cs is safe because of padding */
+QEMU_BUILD_BUG_ON(offsetof(CPUX86State, sysenter_esp) -
+                  offsetof(CPUX86State, sysenter_cs)
+                  < sizeof(uint64_t));
+
+/* Those MSRs have a direct mapping to fields in CPUX86State  */
+static const MshvMsrEnvMap msr_env_map[] = {
+    /* Architectural */
+    { IA32_MSR_EFER, HV_X64_REGISTER_EFER, offsetof(CPUX86State, efer) },
+    { IA32_MSR_PAT,  HV_X64_REGISTER_PAT,  offsetof(CPUX86State, pat) },
+
+    /* Syscall */
+    { IA32_MSR_SYSENTER_CS,    HV_X64_REGISTER_SYSENTER_CS,
+                               offsetof(CPUX86State, sysenter_cs) },
+    { IA32_MSR_SYSENTER_ESP,   HV_X64_REGISTER_SYSENTER_ESP,
+                               offsetof(CPUX86State, sysenter_esp) },
+    { IA32_MSR_SYSENTER_EIP,   HV_X64_REGISTER_SYSENTER_EIP,
+                               offsetof(CPUX86State, sysenter_eip) },
+    { IA32_MSR_STAR,           HV_X64_REGISTER_STAR,
+                               offsetof(CPUX86State, star) },
+    { IA32_MSR_LSTAR,          HV_X64_REGISTER_LSTAR,
+                               offsetof(CPUX86State, lstar) },
+    { IA32_MSR_CSTAR,          HV_X64_REGISTER_CSTAR,
+                               offsetof(CPUX86State, cstar) },
+    { IA32_MSR_SFMASK,         HV_X64_REGISTER_SFMASK,
+                               offsetof(CPUX86State, fmask) },
+    { IA32_MSR_KERNEL_GS_BASE, HV_X64_REGISTER_KERNEL_GS_BASE,
+                               offsetof(CPUX86State, kernelgsbase) },
+
+    /* TSC-related */
+    { IA32_MSR_TSC,          HV_X64_REGISTER_TSC,
+                             offsetof(CPUX86State, tsc) },
+    { IA32_MSR_TSC_AUX,      HV_X64_REGISTER_TSC_AUX,
+                             offsetof(CPUX86State, tsc_aux) },
+    { IA32_MSR_TSC_ADJUST,   HV_X64_REGISTER_TSC_ADJUST,
+                             offsetof(CPUX86State, tsc_adjust) },
+    { IA32_MSR_TSC_DEADLINE, HV_X64_REGISTER_TSC_DEADLINE,
+                             offsetof(CPUX86State, tsc_deadline) },
+
+    /* Hyper-V per-partition MSRs */
+    { HV_X64_MSR_HYPERCALL,     HV_X64_REGISTER_HYPERCALL,
+                                offsetof(CPUX86State, msr_hv_hypercall) },
+    { HV_X64_MSR_GUEST_OS_ID,   HV_REGISTER_GUEST_OS_ID,
+                                offsetof(CPUX86State, msr_hv_guest_os_id) },
+    { HV_X64_MSR_REFERENCE_TSC, HV_REGISTER_REFERENCE_TSC,
+                                offsetof(CPUX86State, msr_hv_tsc) },
+
+    /* Hyper-V MSRs (non-SINT) */
+    { HV_X64_MSR_SCONTROL,  HV_REGISTER_SCONTROL,
+                            offsetof(CPUX86State, msr_hv_synic_control) },
+    { HV_X64_MSR_SIEFP,     HV_REGISTER_SIEFP,
+                            offsetof(CPUX86State, msr_hv_synic_evt_page) },
+    { HV_X64_MSR_SIMP,      HV_REGISTER_SIMP,
+                            offsetof(CPUX86State, msr_hv_synic_msg_page) },
+
+    /* Other */
+
+    /* TODO: find out processor features that correlate to unsupported MSRs. */
+    /* { IA32_MSR_MISC_ENABLE, HV_X64_REGISTER_MSR_IA32_MISC_ENABLE, */
+    /*                         offsetof(CPUX86State, msr_ia32_misc_enable) }, */
+    /* { IA32_MSR_BNDCFGS,     HV_X64_REGISTER_BNDCFGS, */
+    /*                         offsetof(CPUX86State, msr_bndcfgs) }, */
+    { IA32_MSR_SPEC_CTRL,   HV_X64_REGISTER_SPEC_CTRL,
+                            offsetof(CPUX86State, spec_ctrl) },
 };
-static const size_t msr_count = ARRAY_SIZE(supported_msrs);
 
-static int compare_msr_index(const void *a, const void *b)
+int mshv_init_msrs(const CPUState *cpu)
 {
-    return *(uint32_t *)a - *(uint32_t *)b;
+    int ret;
+    uint64_t d_t = MSR_MTRR_ENABLE | MSR_MTRR_MEM_TYPE_WB;
+
+    const struct hv_register_assoc assocs[] = {
+        { .name = HV_X64_REGISTER_SYSENTER_CS,       .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_SYSENTER_ESP,      .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_SYSENTER_EIP,      .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_STAR,              .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_CSTAR,             .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_LSTAR,             .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_KERNEL_GS_BASE,    .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_SFMASK,            .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_MSR_MTRR_DEF_TYPE, .value.reg64 = d_t },
+    };
+
+    ret = mshv_set_generic_regs(cpu, assocs, ARRAY_SIZE(assocs));
+    if (ret < 0) {
+        error_report("failed to put msrs");
+        return -1;
+    }
+
+    return 0;
 }
 
-__attribute__((constructor))
-static void init_sorted_msr_map(void)
+
+/*
+ * INVARIANT: this fn expects assocs in the same order as they appear in
+ * msr_env_map.
+ */
+static void store_in_env(CPUState *cpu, const struct hv_register_assoc *assocs,
+                         size_t n_assocs)
 {
-    qsort(supported_msrs, msr_count, sizeof(uint32_t), compare_msr_index);
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    size_t i, j;
+    const MshvMsrEnvMap *mapping;
+    union hv_register_value hv_value;
+    ptrdiff_t offset;
+    uint32_t hv_name;
+
+    assert(n_assocs <= (ARRAY_SIZE(msr_env_map)));
+
+    for (i = 0, j = 0; i < ARRAY_SIZE(msr_env_map); i++) {
+        hv_name = assocs[j].name;
+        mapping = &msr_env_map[i];
+        if (hv_name != mapping->hv_name) {
+            continue;
+        }
+
+        hv_value = assocs[j].value;
+        offset = mapping->env_offset;
+        MSHV_ENV_FIELD(env, offset) = hv_value.reg64;
+        j++;
+    }
 }
 
-static int mshv_is_supported_msr(uint32_t msr)
+static void set_hv_name_in_assocs(struct hv_register_assoc *assocs,
+                                  size_t n_assocs)
 {
-    return bsearch(&msr, supported_msrs, msr_count, sizeof(uint32_t),
-                   compare_msr_index) != NULL;
+    size_t i;
+
+    assert(n_assocs == ARRAY_SIZE(msr_env_map));
+    for (i = 0; i < ARRAY_SIZE(msr_env_map); i++) {
+        assocs[i].name = msr_env_map[i].hv_name;
+    }
 }
 
-static int mshv_msr_to_hv_reg_name(uint32_t msr, uint32_t *hv_reg)
+static bool msr_supported(uint32_t name)
 {
-    switch (msr) {
-    case IA32_MSR_TSC:
-        *hv_reg = HV_X64_REGISTER_TSC;
-        return 0;
-    case IA32_MSR_EFER:
-        *hv_reg = HV_X64_REGISTER_EFER;
-        return 0;
-    case IA32_MSR_KERNEL_GS_BASE:
-        *hv_reg = HV_X64_REGISTER_KERNEL_GS_BASE;
-        return 0;
-    case IA32_MSR_APIC_BASE:
-        *hv_reg = HV_X64_REGISTER_APIC_BASE;
-        return 0;
-    case IA32_MSR_PAT:
-        *hv_reg = HV_X64_REGISTER_PAT;
-        return 0;
-    case IA32_MSR_SYSENTER_CS:
-        *hv_reg = HV_X64_REGISTER_SYSENTER_CS;
-        return 0;
-    case IA32_MSR_SYSENTER_ESP:
-        *hv_reg = HV_X64_REGISTER_SYSENTER_ESP;
-        return 0;
-    case IA32_MSR_SYSENTER_EIP:
-        *hv_reg = HV_X64_REGISTER_SYSENTER_EIP;
-        return 0;
-    case IA32_MSR_STAR:
-        *hv_reg = HV_X64_REGISTER_STAR;
-        return 0;
-    case IA32_MSR_LSTAR:
-        *hv_reg = HV_X64_REGISTER_LSTAR;
-        return 0;
-    case IA32_MSR_CSTAR:
-        *hv_reg = HV_X64_REGISTER_CSTAR;
-        return 0;
-    case IA32_MSR_SFMASK:
-        *hv_reg = HV_X64_REGISTER_SFMASK;
-        return 0;
-    case IA32_MSR_MTRR_CAP:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_CAP;
-        return 0;
-    case IA32_MSR_MTRR_DEF_TYPE:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_DEF_TYPE;
-        return 0;
-    case IA32_MSR_MTRR_PHYSBASE0:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0;
-        return 0;
-    case IA32_MSR_MTRR_PHYSMASK0:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0;
-        return 0;
-    case IA32_MSR_MTRR_PHYSBASE1:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1;
-        return 0;
-    case IA32_MSR_MTRR_PHYSMASK1:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1;
-        return 0;
-    case IA32_MSR_MTRR_PHYSBASE2:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2;
-        return 0;
-    case IA32_MSR_MTRR_PHYSMASK2:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2;
-        return 0;
-    case IA32_MSR_MTRR_PHYSBASE3:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3;
-        return 0;
-    case IA32_MSR_MTRR_PHYSMASK3:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3;
-        return 0;
-    case IA32_MSR_MTRR_PHYSBASE4:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4;
-        return 0;
-    case IA32_MSR_MTRR_PHYSMASK4:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4;
-        return 0;
-    case IA32_MSR_MTRR_PHYSBASE5:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5;
-        return 0;
-    case IA32_MSR_MTRR_PHYSMASK5:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5;
-        return 0;
-    case IA32_MSR_MTRR_PHYSBASE6:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6;
-        return 0;
-    case IA32_MSR_MTRR_PHYSMASK6:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6;
-        return 0;
-    case IA32_MSR_MTRR_PHYSBASE7:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7;
-        return 0;
-    case IA32_MSR_MTRR_PHYSMASK7:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7;
-        return 0;
-    case IA32_MSR_MTRR_FIX64K_00000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX64K00000;
-        return 0;
-    case IA32_MSR_MTRR_FIX16K_80000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX16K80000;
-        return 0;
-    case IA32_MSR_MTRR_FIX16K_A0000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX16KA0000;
-        return 0;
-    case IA32_MSR_MTRR_FIX4K_C0000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KC0000;
-        return 0;
-    case IA32_MSR_MTRR_FIX4K_C8000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KC8000;
-        return 0;
-    case IA32_MSR_MTRR_FIX4K_D0000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KD0000;
-        return 0;
-    case IA32_MSR_MTRR_FIX4K_D8000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KD8000;
-        return 0;
-    case IA32_MSR_MTRR_FIX4K_E0000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KE0000;
-        return 0;
-    case IA32_MSR_MTRR_FIX4K_E8000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KE8000;
-        return 0;
-    case IA32_MSR_MTRR_FIX4K_F0000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KF0000;
-        return 0;
-    case IA32_MSR_MTRR_FIX4K_F8000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KF8000;
-        return 0;
-    case IA32_MSR_TSC_AUX:
-        *hv_reg = HV_X64_REGISTER_TSC_AUX;
-        return 0;
-    case IA32_MSR_BNDCFGS:
-        *hv_reg = HV_X64_REGISTER_BNDCFGS;
-        return 0;
-    case IA32_MSR_DEBUG_CTL:
-        *hv_reg = HV_X64_REGISTER_DEBUG_CTL;
-        return 0;
-    case IA32_MSR_TSC_ADJUST:
-        *hv_reg = HV_X64_REGISTER_TSC_ADJUST;
-        return 0;
-    case IA32_MSR_SPEC_CTRL:
-        *hv_reg = HV_X64_REGISTER_SPEC_CTRL;
-        return 0;
-    case HV_X64_MSR_GUEST_OS_ID:
-        *hv_reg = HV_REGISTER_GUEST_OS_ID;
-        return 0;
-    case HV_X64_MSR_SINT0:
-        *hv_reg = HV_REGISTER_SINT0;
-        return 0;
-    case HV_X64_MSR_SINT1:
-        *hv_reg = HV_REGISTER_SINT1;
-        return 0;
-    case HV_X64_MSR_SINT2:
-        *hv_reg = HV_REGISTER_SINT2;
-        return 0;
-    case HV_X64_MSR_SINT3:
-        *hv_reg = HV_REGISTER_SINT3;
-        return 0;
-    case HV_X64_MSR_SINT4:
-        *hv_reg = HV_REGISTER_SINT4;
-        return 0;
-    case HV_X64_MSR_SINT5:
-        *hv_reg = HV_REGISTER_SINT5;
-        return 0;
-    case HV_X64_MSR_SINT6:
-        *hv_reg = HV_REGISTER_SINT6;
-        return 0;
-    case HV_X64_MSR_SINT7:
-        *hv_reg = HV_REGISTER_SINT7;
-        return 0;
-    case HV_X64_MSR_SINT8:
-        *hv_reg = HV_REGISTER_SINT8;
-        return 0;
-    case HV_X64_MSR_SINT9:
-        *hv_reg = HV_REGISTER_SINT9;
-        return 0;
-    case HV_X64_MSR_SINT10:
-        *hv_reg = HV_REGISTER_SINT10;
-        return 0;
-    case HV_X64_MSR_SINT11:
-        *hv_reg = HV_REGISTER_SINT11;
-        return 0;
-    case HV_X64_MSR_SINT12:
-        *hv_reg = HV_REGISTER_SINT12;
-        return 0;
-    case HV_X64_MSR_SINT13:
-        *hv_reg = HV_REGISTER_SINT13;
-        return 0;
-    case HV_X64_MSR_SINT14:
-        *hv_reg = HV_REGISTER_SINT14;
-        return 0;
-    case HV_X64_MSR_SINT15:
-        *hv_reg = HV_REGISTER_SINT15;
-        return 0;
-    case IA32_MSR_MISC_ENABLE:
-        *hv_reg = HV_X64_REGISTER_MSR_IA32_MISC_ENABLE;
-        return 0;
-    case HV_X64_MSR_SCONTROL:
-        *hv_reg = HV_REGISTER_SCONTROL;
-        return 0;
-    case HV_X64_MSR_SIEFP:
-        *hv_reg = HV_REGISTER_SIEFP;
-        return 0;
-    case HV_X64_MSR_SIMP:
-        *hv_reg = HV_REGISTER_SIMP;
-        return 0;
-    case HV_X64_MSR_REFERENCE_TSC:
-        *hv_reg = HV_REGISTER_REFERENCE_TSC;
-        return 0;
-    case HV_X64_MSR_EOM:
-        *hv_reg = HV_REGISTER_EOM;
-        return 0;
-    default:
-        error_report("failed to map MSR %u to HV register name", msr);
-        return -1;
+    /*
+     * This check is not done comprehensively, it's meant to avoid hvcall
+     * failures for certain MSRs on architectures that don't support them.
+     */
+
+    switch (name) {
+    case HV_X64_REGISTER_SPEC_CTRL:
+        return mshv_state->processor_features.ibrs_support;
+    case HV_X64_REGISTER_TSC_ADJUST:
+        return mshv_state->processor_features.tsc_adjust_support;
+    case HV_X64_REGISTER_TSC_DEADLINE:
+        return mshv_state->processor_features.tsc_deadline_tmr_support;
     }
+
+    return true;
 }
 
-static int set_msrs(const CPUState *cpu, GList *msrs)
+int mshv_get_msrs(CPUState *cpu)
 {
-    size_t n_msrs;
-    GList *entries;
-    MshvMsrEntry *entry;
-    enum hv_register_name name;
-    struct hv_register_assoc *assoc;
-    int ret;
-    size_t i = 0;
-
-    n_msrs = g_list_length(msrs);
-    hv_register_assoc *assocs = g_new0(hv_register_assoc, n_msrs);
-
-    entries = msrs;
-    for (const GList *elem = entries; elem != NULL; elem = elem->next) {
-        entry = elem->data;
-        ret = mshv_msr_to_hv_reg_name(entry->index, &name);
-        if (ret < 0) {
-            g_free(assocs);
-            return ret;
+    int ret = 0;
+    size_t n_assocs = ARRAY_SIZE(msr_env_map);
+    struct hv_register_assoc assocs[ARRAY_SIZE(msr_env_map)];
+    size_t i, j;
+    uint32_t name;
+
+    set_hv_name_in_assocs(assocs, n_assocs);
+
+    /* Filter out MSRs that cannot be read */
+    for (i = 0, j = 0; i < n_assocs; i++) {
+        name = assocs[i].name;
+
+        if (!msr_supported(name)) {
+            continue;
         }
-        assoc = &assocs[i];
-        assoc->name = name;
-        /* the union has been initialized to 0 */
-        assoc->value.reg64 = entry->data;
-        i++;
+
+        if (j != i) {
+            assocs[j] = assocs[i];
+        }
+        j++;
     }
-    ret = mshv_set_generic_regs(cpu, assocs, n_msrs);
-    g_free(assocs);
+    n_assocs = j;
+
+    ret = mshv_get_generic_regs(cpu, assocs, n_assocs);
     if (ret < 0) {
-        error_report("failed to set msrs");
-        return -1;
+        error_report("Failed to get MSRs");
+        return -errno;
     }
+
+    store_in_env(cpu, assocs, n_assocs);
+
     return 0;
 }
 
+static void load_from_env(const CPUState *cpu, struct hv_register_assoc *assocs,
+                          size_t n_assocs)
+{
+    size_t i;
+    const MshvMsrEnvMap *mapping;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    ptrdiff_t offset;
+    union hv_register_value *hv_value;
+
+    assert(n_assocs == ARRAY_SIZE(msr_env_map));
+
+    for (i = 0; i < ARRAY_SIZE(msr_env_map); i++) {
+        mapping = &msr_env_map[i];
+        offset = mapping->env_offset;
+        assocs[i].name = mapping->hv_name;
+        hv_value = &assocs[i].value;
+        hv_value->reg64 = MSHV_ENV_FIELD(env, offset);
+    }
+}
 
-int mshv_configure_msr(const CPUState *cpu, const MshvMsrEntry *msrs,
-                       size_t n_msrs)
+int mshv_set_msrs(const CPUState *cpu)
 {
-    GList *valid_msrs = NULL;
-    uint32_t msr_index;
+    size_t n_assocs = ARRAY_SIZE(msr_env_map);
+    struct hv_register_assoc assocs[ARRAY_SIZE(msr_env_map)];
     int ret;
+    size_t i, j;
+
+    load_from_env(cpu, assocs, n_assocs);
+
+    /* Filter out MSRs that cannot be written */
+    for (i = 0, j = 0; i < n_assocs; i++) {
+        uint32_t name = assocs[i].name;
 
-    for (size_t i = 0; i < n_msrs; i++) {
-        msr_index = msrs[i].index;
-        /* check whether index of msrs is in SUPPORTED_MSRS */
-        if (mshv_is_supported_msr(msr_index)) {
-            valid_msrs = g_list_append(valid_msrs, (void *) &msrs[i]);
+        /* Partition-wide MSRs: only write on vCPU 0 */
+        if (cpu->cpu_index != 0 &&
+            (name == HV_X64_REGISTER_HYPERCALL ||
+             name == HV_REGISTER_GUEST_OS_ID ||
+             name == HV_REGISTER_REFERENCE_TSC)) {
+            continue;
         }
+
+        if (!msr_supported(name)) {
+            continue;
+        }
+
+        if (j != i) {
+            assocs[j] = assocs[i];
+        }
+        j++;
     }
+    n_assocs = j;
 
-    ret = set_msrs(cpu, valid_msrs);
-    g_list_free(valid_msrs);
+    ret = mshv_set_generic_regs(cpu, assocs, n_assocs);
+    if (ret < 0) {
+        error_report("Failed to set MSRs");
+        return -errno;
+    }
 
-    return ret;
+    return 0;
 }
-- 
2.34.1

