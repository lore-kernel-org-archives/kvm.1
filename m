Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BAA3B2FFD
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423397; cv=none; b=hObZbUVjZHyoo5bzVt+LMA6GIE/FjIEGJLzuD1yyRMNp/pXfihcINrUMvdEDq+KyF1YnQ4BHYSMIrvXUJ+MZhls1DC/zbvCufU9rbEViIG+ET23GAjkJs3OdyNLcT5uBAht1l6tQnA3Jafi1bDeZMDDiMb98shAw5EMqaEHzL8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423397; c=relaxed/simple;
	bh=ccdAr0+UNAVuDV8DNBIdMUj7/fF7CK5KjeEu4BLEmzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RPZK5gzAS8XJSMPed3kCHQIN0/DOB6J3AFXuXrMFxMX/NG7uGHLv6EQxkGn9f1GBBDDSEpd9rYyzOuDl72pYU2niJaSx5giqxkMjBwJh1jbfQrPPehE/qZnZefGhXge6PrybWWAAAINbvXL+EAvlDuxYa/s5EQCrjhUooTD1moE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jJHsii9j; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jJHsii9j"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id AACC620B7128;
	Fri, 17 Apr 2026 03:56:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AACC620B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423395;
	bh=A8uL1r6Og/T/HGwRnV+r8ObS1E2Hjxpnf4cpXNnVOek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jJHsii9j6U9sjLjwA7Jhxccd3f1LAUzvV9P64zcaJb4tRoi2zzxwHFS8ZdSPZeW6g
	 Pi+7Ou899zJnRUMv0J+iMBWsYks3fLV0Ct6LYtsw8bmrJGZVy/6l0tgeVMTSIAXxAf
	 UIg5v+yA8FCr9/abzmZb3m1KQNzWEmAo9WFc5bus=
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
Subject: [PATCH 03/34] target/i386/mshv: impl init/load/store_vcpu_state
Date: Fri, 17 Apr 2026 12:55:47 +0200
Message-Id: <20260417105618.3621-4-magnuskulke@linux.microsoft.com>
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

In migration we will handle more than registers, so we rework the
routines that were used to load & store CPU registers from/to the
hypervisor into more explicit init/load/store_vcpu_state() functions
that can be called from the appropriate hooks.

load/store_regs() still exists for the purpose of MMIO emulation, but it
will only address standard and special x86 registers.

Functions to retrieve FPU and XCR0 state from the hypervsisor have been
introduced.

MSR and APIC state covered are covered only as part of init_vcpu(). They
are not yet part of the load/store routines.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c       |  10 +-
 include/system/mshv_int.h   |   5 +-
 target/i386/mshv/mshv-cpu.c | 354 ++++++++++++++++++------------------
 3 files changed, 185 insertions(+), 184 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 7c0eb68a5b..04d248fe1d 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -400,13 +400,13 @@ static int mshv_init_vcpu(CPUState *cpu)
     int ret;
 
     cpu->accel = g_new0(AccelCPUState, 1);
-    mshv_arch_init_vcpu(cpu);
 
     ret = mshv_create_vcpu(vm_fd, vp_index, &cpu->accel->cpufd);
     if (ret < 0) {
         return -1;
     }
 
+    mshv_arch_init_vcpu(cpu);
     cpu->accel->dirty = true;
 
     return 0;
@@ -488,7 +488,7 @@ static int mshv_cpu_exec(CPUState *cpu)
 
     do {
         if (cpu->accel->dirty) {
-            ret = mshv_arch_put_registers(cpu);
+            ret = mshv_arch_store_vcpu_state(cpu);
             if (ret) {
                 error_report("Failed to put registers after init: %s",
                               strerror(-ret));
@@ -610,7 +610,7 @@ static void mshv_start_vcpu_thread(CPUState *cpu)
 static void do_mshv_cpu_synchronize_post_init(CPUState *cpu,
                                               run_on_cpu_data arg)
 {
-    int ret = mshv_arch_put_registers(cpu);
+    int ret = mshv_arch_store_vcpu_state(cpu);
     if (ret < 0) {
         error_report("Failed to put registers after init: %s", strerror(-ret));
         abort();
@@ -626,7 +626,7 @@ static void mshv_cpu_synchronize_post_init(CPUState *cpu)
 
 static void mshv_cpu_synchronize_post_reset(CPUState *cpu)
 {
-    int ret = mshv_arch_put_registers(cpu);
+    int ret = mshv_arch_store_vcpu_state(cpu);
     if (ret) {
         error_report("Failed to put registers after reset: %s",
                      strerror(-ret));
@@ -650,7 +650,7 @@ static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
 static void do_mshv_cpu_synchronize(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->accel->dirty) {
-        int ret = mshv_arch_load_regs(cpu);
+        int ret = mshv_arch_load_vcpu_state(cpu);
         if (ret < 0) {
             error_report("Failed to load registers for vcpu %d",
                          cpu->cpu_index);
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index e3d1867a77..70631ca6ba 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -70,11 +70,10 @@ int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
 int mshv_configure_vcpu(const CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
-int mshv_arch_load_regs(CPUState *cpu);
-int mshv_arch_store_regs(CPUState *cpu);
 int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
                           size_t n_regs);
-int mshv_arch_put_registers(const CPUState *cpu);
+int mshv_arch_store_vcpu_state(const CPUState *cpu);
+int mshv_arch_load_vcpu_state(CPUState *cpu);
 void mshv_arch_init_vcpu(CPUState *cpu);
 void mshv_arch_destroy_vcpu(CPUState *cpu);
 void mshv_arch_amend_proc_features(
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 78b218e596..56656ac0b0 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -112,6 +112,92 @@ static int get_generic_regs(CPUState *cpu,
                             struct hv_register_assoc *assocs,
                             size_t n_regs);
 
+static void populate_fpu(const hv_register_assoc *assocs, X86CPU *x86cpu)
+{
+    union hv_register_value value;
+    const union hv_x64_fp_control_status_register *ctrl_status;
+    const union hv_x64_xmm_control_status_register *xmm_ctrl;
+    CPUX86State *env = &x86cpu->env;
+    size_t i, fp_i;
+    bool valid;
+
+    /* first 16 registers are xmm0-xmm15 */
+    for (i = 0; i < 16; i++) {
+        value = assocs[i].value;
+        env->xmm_regs[i].ZMM_Q(0) = value.reg128.low_part;
+        env->xmm_regs[i].ZMM_Q(1) = value.reg128.high_part;
+    }
+
+    /* next 8 registers are fp_mmx0-fp_mmx7 */
+    for (i = 16; i < 24; i++) {
+        fp_i = i - 16;
+        value = assocs[i].value;
+        env->fpregs[fp_i].d.low = value.fp.mantissa;
+        env->fpregs[fp_i].d.high = (value.fp.sign << 15)
+                                 | (value.fp.biased_exponent & 0x7FFF);
+    }
+
+    /* last two registers are fp_control_status and xmm_control_status */
+    ctrl_status = &assocs[24].value.fp_control_status;
+    env->fpuc = ctrl_status->fp_control;
+
+    env->fpus = ctrl_status->fp_status & ~0x3800;
+    /* bits 11,12,13 are the top of stack pointer */
+    env->fpstt = (ctrl_status->fp_status >> 11) & 0x7;
+
+    for (i = 0; i < 8; i++) {
+        valid = ctrl_status->fp_tag & (1 << i);
+        env->fptags[i] = valid ? 0 : 1;
+    }
+
+    env->fpop = ctrl_status->last_fp_op;
+    env->fpip = ctrl_status->last_fp_rip;
+
+    xmm_ctrl = &assocs[25].value.xmm_control_status;
+    env->mxcsr = xmm_ctrl->xmm_status_control;
+    env->fpdp = xmm_ctrl->last_fp_rdp;
+}
+
+static int get_fpu(CPUState *cpu)
+{
+    struct hv_register_assoc assocs[ARRAY_SIZE(FPU_REGISTER_NAMES)];
+    int ret;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    size_t n_regs = ARRAY_SIZE(FPU_REGISTER_NAMES);
+
+    for (size_t i = 0; i < n_regs; i++) {
+        assocs[i].name = FPU_REGISTER_NAMES[i];
+    }
+    ret = get_generic_regs(cpu, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to get special registers");
+        return -errno;
+    }
+
+    populate_fpu(assocs, x86cpu);
+
+    return 0;
+}
+
+static int get_xc_reg(CPUState *cpu)
+{
+    int ret;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    struct hv_register_assoc assocs[1];
+
+    assocs[0].name = HV_X64_REGISTER_XFEM;
+
+    ret = get_generic_regs(cpu, assocs, 1);
+    if (ret < 0) {
+        error_report("failed to get xcr0");
+        return -1;
+    }
+    env->xcr0 = assocs[0].value.reg64;
+
+    return 0;
+}
+
 static int translate_gva(const CPUState *cpu, uint64_t gva, uint64_t *gpa,
                          uint64_t flags)
 {
@@ -290,7 +376,7 @@ static int set_standard_regs(const CPUState *cpu)
     return 0;
 }
 
-int mshv_arch_store_regs(CPUState *cpu)
+static int store_regs(CPUState *cpu)
 {
     int ret;
 
@@ -432,20 +518,45 @@ static int get_special_regs(CPUState *cpu)
     return 0;
 }
 
-int mshv_arch_load_regs(CPUState *cpu)
+static int load_regs(CPUState *cpu)
 {
     int ret;
 
     ret = get_standard_regs(cpu);
     if (ret < 0) {
-        error_report("Failed to load standard registers");
-        return -1;
+        return ret;
     }
 
     ret = get_special_regs(cpu);
     if (ret < 0) {
-        error_report("Failed to load special registers");
-        return -1;
+        return ret;
+    }
+
+    return 0;
+}
+
+int mshv_arch_load_vcpu_state(CPUState *cpu)
+{
+    int ret;
+
+    ret = get_standard_regs(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = get_special_regs(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = get_xc_reg(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = get_fpu(cpu);
+    if (ret < 0) {
+        return ret;
     }
 
     return 0;
@@ -617,7 +728,7 @@ static int register_intercept_result_cpuid(const CPUState *cpu,
     return ret;
 }
 
-static int set_cpuid2(const CPUState *cpu)
+static int init_cpuid2(const CPUState *cpu)
 {
     int ret;
     size_t n_entries, cpuid_size;
@@ -808,29 +919,6 @@ static int set_xc_reg(const CPUState *cpu)
     return 0;
 }
 
-static int set_cpu_state(const CPUState *cpu)
-{
-    int ret;
-
-    ret = set_standard_regs(cpu);
-    if (ret < 0) {
-        return ret;
-    }
-    ret = set_special_regs(cpu);
-    if (ret < 0) {
-        return ret;
-    }
-    ret = set_fpu(cpu);
-    if (ret < 0) {
-        return ret;
-    }
-    ret = set_xc_reg(cpu);
-    if (ret < 0) {
-        return ret;
-    }
-    return 0;
-}
-
 static int get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state)
 {
     int ret;
@@ -844,7 +932,7 @@ static int get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state)
     return 0;
 }
 
-static int get_lapic(int cpu_fd,
+static int get_lapic(const CPUState *cpu,
                      struct hv_local_interrupt_controller_state *state)
 {
     int ret;
@@ -852,6 +940,7 @@ static int get_lapic(int cpu_fd,
     /* buffer aligned to 4k, as *state requires that */
     void *buffer = qemu_memalign(size, size);
     struct mshv_get_set_vp_state mshv_state = { 0 };
+    int cpu_fd = mshv_vcpufd(cpu);
 
     mshv_state.buf_ptr = (uint64_t) buffer;
     mshv_state.buf_sz = size;
@@ -888,7 +977,7 @@ static int set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state)
     return 0;
 }
 
-static int set_lapic(int cpu_fd,
+static int set_lapic(const CPUState *cpu,
                      const struct hv_local_interrupt_controller_state *state)
 {
     int ret;
@@ -896,6 +985,7 @@ static int set_lapic(int cpu_fd,
     /* buffer aligned to 4k, as *state requires that */
     void *buffer = qemu_memalign(size, size);
     struct mshv_get_set_vp_state mshv_state = { 0 };
+    int cpu_fd = mshv_vcpufd(cpu);
 
     if (!state) {
         error_report("lapic state is NULL");
@@ -917,13 +1007,13 @@ static int set_lapic(int cpu_fd,
     return 0;
 }
 
-static int set_lint(int cpu_fd)
+static int init_lint(const CPUState *cpu)
 {
     int ret;
     uint32_t *lvt_lint0, *lvt_lint1;
 
     struct hv_local_interrupt_controller_state lapic_state = { 0 };
-    ret = get_lapic(cpu_fd, &lapic_state);
+    ret = get_lapic(cpu, &lapic_state);
     if (ret < 0) {
         return ret;
     }
@@ -936,161 +1026,31 @@ static int set_lint(int cpu_fd)
 
     /* TODO: should we skip setting lapic if the values are the same? */
 
-    return set_lapic(cpu_fd, &lapic_state);
+    return set_lapic(cpu, &lapic_state);
 }
 
-static int setup_msrs(const CPUState *cpu)
-{
-    int ret;
-    uint64_t default_type = MSR_MTRR_ENABLE | MSR_MTRR_MEM_TYPE_WB;
-
-    /* boot msr entries */
-    MshvMsrEntry msrs[9] = {
-        { .index = IA32_MSR_SYSENTER_CS, .data = 0x0, },
-        { .index = IA32_MSR_SYSENTER_ESP, .data = 0x0, },
-        { .index = IA32_MSR_SYSENTER_EIP, .data = 0x0, },
-        { .index = IA32_MSR_STAR, .data = 0x0, },
-        { .index = IA32_MSR_CSTAR, .data = 0x0, },
-        { .index = IA32_MSR_LSTAR, .data = 0x0, },
-        { .index = IA32_MSR_KERNEL_GS_BASE, .data = 0x0, },
-        { .index = IA32_MSR_SFMASK, .data = 0x0, },
-        { .index = IA32_MSR_MTRR_DEF_TYPE, .data = default_type, },
-    };
-
-    ret = mshv_configure_msr(cpu, msrs, 9);
-    if (ret < 0) {
-        error_report("failed to setup msrs");
-        return -1;
-    }
-
-    return 0;
-}
-
-/*
- * TODO: populate topology info:
- *
- * X86CPU *x86cpu = X86_CPU(cpu);
- * CPUX86State *env = &x86cpu->env;
- * X86CPUTopoInfo *topo_info = &env->topo_info;
- */
-int mshv_configure_vcpu(const CPUState *cpu)
+int mshv_arch_store_vcpu_state(const CPUState *cpu)
 {
     int ret;
-    int cpu_fd = mshv_vcpufd(cpu);
-
-    ret = set_cpuid2(cpu);
-    if (ret < 0) {
-        error_report("failed to set cpuid");
-        return -1;
-    }
-
-    ret = setup_msrs(cpu);
-    if (ret < 0) {
-        error_report("failed to setup msrs");
-        return -1;
-    }
-
-    ret = set_cpu_state(cpu);
-    if (ret < 0) {
-        error_report("failed to set cpu state");
-        return -1;
-    }
 
-    ret = set_lint(cpu_fd);
+    ret = set_standard_regs(cpu);
     if (ret < 0) {
-        error_report("failed to set lpic int");
-        return -1;
+        return ret;
     }
 
-    return 0;
-}
-
-static int put_regs(const CPUState *cpu)
-{
-    int ret;
-
-    ret = mshv_configure_vcpu(cpu);
+    ret = set_special_regs(cpu);
     if (ret < 0) {
-        error_report("failed to configure vcpu");
         return ret;
     }
 
-    return 0;
-}
-
-struct MsrPair {
-    uint32_t index;
-    uint64_t value;
-};
-
-static int put_msrs(const CPUState *cpu)
-{
-    int ret = 0;
-    X86CPU *x86cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86cpu->env;
-    MshvMsrEntries *msrs = g_malloc0(sizeof(MshvMsrEntries));
-
-    struct MsrPair pairs[] = {
-        { MSR_IA32_SYSENTER_CS,    env->sysenter_cs },
-        { MSR_IA32_SYSENTER_ESP,   env->sysenter_esp },
-        { MSR_IA32_SYSENTER_EIP,   env->sysenter_eip },
-        { MSR_EFER,                env->efer },
-        { MSR_PAT,                 env->pat },
-        { MSR_STAR,                env->star },
-        { MSR_CSTAR,               env->cstar },
-        { MSR_LSTAR,               env->lstar },
-        { MSR_KERNELGSBASE,        env->kernelgsbase },
-        { MSR_FMASK,               env->fmask },
-        { MSR_MTRRdefType,         env->mtrr_deftype },
-        { MSR_VM_HSAVE_PA,         env->vm_hsave },
-        { MSR_SMI_COUNT,           env->msr_smi_count },
-        { MSR_IA32_PKRS,           env->pkrs },
-        { MSR_IA32_BNDCFGS,        env->msr_bndcfgs },
-        { MSR_IA32_XSS,            env->xss },
-        { MSR_IA32_UMWAIT_CONTROL, env->umwait },
-        { MSR_IA32_TSX_CTRL,       env->tsx_ctrl },
-        { MSR_AMD64_TSC_RATIO,     env->amd_tsc_scale_msr },
-        { MSR_TSC_AUX,             env->tsc_aux },
-        { MSR_TSC_ADJUST,          env->tsc_adjust },
-        { MSR_IA32_SMBASE,         env->smbase },
-        { MSR_IA32_SPEC_CTRL,      env->spec_ctrl },
-        { MSR_VIRT_SSBD,           env->virt_ssbd },
-    };
-
-    if (ARRAY_SIZE(pairs) > MSHV_MSR_ENTRIES_COUNT) {
-        error_report("MSR entries exceed maximum size");
-        g_free(msrs);
-        return -1;
-    }
-
-    for (size_t i = 0; i < ARRAY_SIZE(pairs); i++) {
-        MshvMsrEntry *entry = &msrs->entries[i];
-        entry->index = pairs[i].index;
-        entry->reserved = 0;
-        entry->data = pairs[i].value;
-        msrs->nmsrs++;
-    }
-
-    ret = mshv_configure_msr(cpu, &msrs->entries[0], msrs->nmsrs);
-    g_free(msrs);
-    return ret;
-}
-
-
-int mshv_arch_put_registers(const CPUState *cpu)
-{
-    int ret;
-
-    ret = put_regs(cpu);
+    ret = set_xc_reg(cpu);
     if (ret < 0) {
-        error_report("Failed to put registers");
-        return -1;
+        return ret;
     }
 
-    ret = put_msrs(cpu);
+    ret = set_fpu(cpu);
     if (ret < 0) {
-        error_report("Failed to put msrs");
-        return -1;
+        return ret;
     }
 
     return 0;
@@ -1126,7 +1086,7 @@ static int emulate_instruction(CPUState *cpu,
     int ret;
     x86_insn_stream stream = { .bytes = insn_bytes, .len = insn_len };
 
-    ret = mshv_arch_load_regs(cpu);
+    ret = load_regs(cpu);
     if (ret < 0) {
         error_report("Failed to load registers");
         return -1;
@@ -1135,7 +1095,7 @@ static int emulate_instruction(CPUState *cpu,
     decode_instruction_stream(env, &decode, &stream);
     exec_instruction(env, &decode);
 
-    ret = mshv_arch_store_regs(cpu);
+    ret = store_regs(cpu);
     if (ret < 0) {
         error_report("failed to store registers");
         return -1;
@@ -1433,7 +1393,7 @@ static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
 
-    ret = mshv_arch_load_regs(cpu);
+    ret = load_regs(cpu);
     if (ret < 0) {
         error_report("Failed to load registers");
         return -1;
@@ -1579,6 +1539,33 @@ void mshv_init_mmio_emu(void)
     init_emu(&mshv_x86_emul_ops);
 }
 
+static int init_msrs(const CPUState *cpu)
+{
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
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(assocs) > MSHV_MSR_ENTRIES_COUNT);
+
+    ret = mshv_set_generic_regs(cpu, assocs, ARRAY_SIZE(assocs));
+    if (ret < 0) {
+        error_report("failed to put msrs");
+        return -1;
+    }
+
+    return 0;
+}
+
 void mshv_arch_init_vcpu(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -1586,6 +1573,7 @@ void mshv_arch_init_vcpu(CPUState *cpu)
     AccelCPUState *state = cpu->accel;
     size_t page = HV_HYP_PAGE_SIZE;
     void *mem = qemu_memalign(page, 2 * page);
+    int ret;
 
     /* sanity check, to make sure we don't overflow the page */
     QEMU_BUILD_BUG_ON((MAX_REGISTER_COUNT
@@ -1598,6 +1586,20 @@ void mshv_arch_init_vcpu(CPUState *cpu)
     state->hvcall_args.output_page = (uint8_t *)mem + page;
 
     env->emu_mmio_buf = g_new(char, 4096);
+
+    /*
+     * TODO: populate topology info:
+     * X86CPUTopoInfo *topo_info = &env->topo_info;
+     */
+
+    ret = init_cpuid2(cpu);
+    assert(ret == 0);
+
+    ret = init_msrs(cpu);
+    assert(ret == 0);
+
+    ret = init_lint(cpu);
+    assert(ret == 0);
 }
 
 void mshv_arch_destroy_vcpu(CPUState *cpu)
-- 
2.34.1

