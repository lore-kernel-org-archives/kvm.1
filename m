Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFF529827E
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423393; cv=none; b=Y+TkGtxFYUtbAq+x9+Wt1yj5NoKnRurkLbuvHTiCfpi6/AAqUH2ahSOu82ctaWL2ZQ3dqlqVeix6APT1IZnkgJJfQed2byRIAjoxziVXAY0jk/7Jy/D3ysLvTAxbW8zO0E7jO3q8IkvBFFdpSvT0V+fk1PV61QzfbF3LKyDUm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423393; c=relaxed/simple;
	bh=8onQ5cBwm3mwTxgpAQALDhuLbjheAuTdcvtsQlqlzOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dkSi8QqCsfSrDfOiy9KCbe3ZF9LgCiTfRzDLj3Vks/HFmBIq0KyN+9WffVvx92v/yQ5wmZFWDF2GfjazHido+bVwHU9i7FLEcYPh3r/AXHDRqtKEeu8O0ui0IHJ8IvBbNb33Ol2yx2pQgQpT5JaH4jl14JT6RxFcGTRuUin2s1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WW6lXpiZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WW6lXpiZ"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 08B5520B712B;
	Fri, 17 Apr 2026 03:56:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 08B5520B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423391;
	bh=YCyjkeVZjehmvMqQkFEvROL42xs/v9qbwCcFiaYqzZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WW6lXpiZ5ztwWAzYMi8+dtuwB9y949MCfQCX38vw3l+U4W4YJ2SGBTAp855NjeSbD
	 XhCStMIDj0zqzXoBfiMs84yW1P5ofQyvvAU/JLbI2EO67M1qIIu/YMZCRKc0AdKonQ
	 06xwyRay3IWObgsVJpGwL1w7Wca9b0tTJ/5gtE0c=
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
Subject: [PATCH 02/34] target/i386/mshv: use generic FPU/xcr0 state
Date: Fri, 17 Apr 2026 12:55:46 +0200
Message-Id: <20260417105618.3621-3-magnuskulke@linux.microsoft.com>
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

Instead of using an mshv-specific FPU state representation we switch to
the generic i386 representation of the registers.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/system/mshv_int.h   | 15 +-------
 target/i386/mshv/mshv-cpu.c | 76 ++++++++++++++++++++++---------------
 2 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index a142dd241a..e3d1867a77 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -58,19 +58,6 @@ typedef struct MshvMsiControl {
 #define mshv_vcpufd(cpu) (cpu->accel->cpufd)
 
 /* cpu */
-typedef struct MshvFPU {
-    uint8_t fpr[8][16];
-    uint16_t fcw;
-    uint16_t fsw;
-    uint8_t ftwx;
-    uint8_t pad1;
-    uint16_t last_opcode;
-    uint64_t last_ip;
-    uint64_t last_dp;
-    uint8_t xmm[16][16];
-    uint32_t mxcsr;
-    uint32_t pad2;
-} MshvFPU;
 
 typedef enum MshvVmExit {
     MshvVmExitIgnore   = 0,
@@ -81,7 +68,7 @@ typedef enum MshvVmExit {
 void mshv_init_mmio_emu(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
-int mshv_configure_vcpu(const CPUState *cpu, const MshvFPU *fpu, uint64_t xcr0);
+int mshv_configure_vcpu(const CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
 int mshv_arch_load_regs(CPUState *cpu);
 int mshv_arch_store_regs(CPUState *cpu);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 9456e75277..78b218e596 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -108,6 +108,9 @@ static enum hv_register_name FPU_REGISTER_NAMES[26] = {
 };
 
 static int set_special_regs(const CPUState *cpu);
+static int get_generic_regs(CPUState *cpu,
+                            struct hv_register_assoc *assocs,
+                            size_t n_regs);
 
 static int translate_gva(const CPUState *cpu, uint64_t gva, uint64_t *gpa,
                          uint64_t flags)
@@ -717,48 +720,65 @@ static int set_special_regs(const CPUState *cpu)
     return 0;
 }
 
-static int set_fpu(const CPUState *cpu, const struct MshvFPU *regs)
+static int set_fpu(const CPUState *cpu)
 {
     struct hv_register_assoc assocs[ARRAY_SIZE(FPU_REGISTER_NAMES)];
     union hv_register_value *value;
-    size_t fp_i;
     union hv_x64_fp_control_status_register *ctrl_status;
     union hv_x64_xmm_control_status_register *xmm_ctrl_status;
     int ret;
     size_t n_regs = ARRAY_SIZE(FPU_REGISTER_NAMES);
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    size_t i, fp_i;
+    bool valid;
 
     /* first 16 registers are xmm0-xmm15 */
-    for (size_t i = 0; i < 16; i++) {
+    for (i = 0; i < 16; i++) {
         assocs[i].name = FPU_REGISTER_NAMES[i];
         value = &assocs[i].value;
-        memcpy(&value->reg128, &regs->xmm[i], 16);
+        value->reg128.low_part  = env->xmm_regs[i].ZMM_Q(0);
+        value->reg128.high_part = env->xmm_regs[i].ZMM_Q(1);
     }
 
     /* next 8 registers are fp_mmx0-fp_mmx7 */
-    for (size_t i = 16; i < 24; i++) {
-        assocs[i].name = FPU_REGISTER_NAMES[i];
+    for (i = 16; i < 24; i++) {
         fp_i = (i - 16);
+        assocs[i].name = FPU_REGISTER_NAMES[i];
         value = &assocs[i].value;
-        memcpy(&value->reg128, &regs->fpr[fp_i], 16);
+        value->fp.mantissa        = env->fpregs[fp_i].d.low;
+        value->fp.biased_exponent = env->fpregs[fp_i].d.high & 0x7FFF;
+        value->fp.sign            = (env->fpregs[fp_i].d.high >> 15) & 0x1;
+        value->fp.reserved        = 0;
     }
 
     /* last two registers are fp_control_status and xmm_control_status */
     assocs[24].name = FPU_REGISTER_NAMES[24];
     value = &assocs[24].value;
     ctrl_status = &value->fp_control_status;
-    ctrl_status->fp_control = regs->fcw;
-    ctrl_status->fp_status = regs->fsw;
-    ctrl_status->fp_tag = regs->ftwx;
+
+    ctrl_status->fp_control = env->fpuc;
+    /* bits 11,12,13 are the top of stack pointer */
+    ctrl_status->fp_status = (env->fpus & ~0x3800) | ((env->fpstt & 0x7) << 11);
+
+    ctrl_status->fp_tag = 0;
+    for (i = 0; i < 8; i++) {
+        valid = (env->fptags[i] == 0);
+        if (valid) {
+            ctrl_status->fp_tag |= (1u << i);
+        }
+    }
+
     ctrl_status->reserved = 0;
-    ctrl_status->last_fp_op = regs->last_opcode;
-    ctrl_status->last_fp_rip = regs->last_ip;
+    ctrl_status->last_fp_op = env->fpop;
+    ctrl_status->last_fp_rip = env->fpip;
 
     assocs[25].name = FPU_REGISTER_NAMES[25];
     value = &assocs[25].value;
     xmm_ctrl_status = &value->xmm_control_status;
-    xmm_ctrl_status->xmm_status_control = regs->mxcsr;
-    xmm_ctrl_status->xmm_status_control_mask = 0;
-    xmm_ctrl_status->last_fp_rdp = regs->last_dp;
+    xmm_ctrl_status->xmm_status_control = env->mxcsr;
+    xmm_ctrl_status->xmm_status_control_mask = 0x0000ffff;
+    xmm_ctrl_status->last_fp_rdp = env->fpdp;
 
     ret = mshv_set_generic_regs(cpu, assocs, n_regs);
     if (ret < 0) {
@@ -769,12 +789,15 @@ static int set_fpu(const CPUState *cpu, const struct MshvFPU *regs)
     return 0;
 }
 
-static int set_xc_reg(const CPUState *cpu, uint64_t xcr0)
+static int set_xc_reg(const CPUState *cpu)
 {
     int ret;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+
     struct hv_register_assoc assoc = {
         .name = HV_X64_REGISTER_XFEM,
-        .value.reg64 = xcr0,
+        .value.reg64 = env->xcr0,
     };
 
     ret = mshv_set_generic_regs(cpu, &assoc, 1);
@@ -785,8 +808,7 @@ static int set_xc_reg(const CPUState *cpu, uint64_t xcr0)
     return 0;
 }
 
-static int set_cpu_state(const CPUState *cpu, const MshvFPU *fpu_regs,
-                         uint64_t xcr0)
+static int set_cpu_state(const CPUState *cpu)
 {
     int ret;
 
@@ -798,11 +820,11 @@ static int set_cpu_state(const CPUState *cpu, const MshvFPU *fpu_regs,
     if (ret < 0) {
         return ret;
     }
-    ret = set_fpu(cpu, fpu_regs);
+    ret = set_fpu(cpu);
     if (ret < 0) {
         return ret;
     }
-    ret = set_xc_reg(cpu, xcr0);
+    ret = set_xc_reg(cpu);
     if (ret < 0) {
         return ret;
     }
@@ -951,8 +973,7 @@ static int setup_msrs(const CPUState *cpu)
  * CPUX86State *env = &x86cpu->env;
  * X86CPUTopoInfo *topo_info = &env->topo_info;
  */
-int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
-                        uint64_t xcr0)
+int mshv_configure_vcpu(const CPUState *cpu)
 {
     int ret;
     int cpu_fd = mshv_vcpufd(cpu);
@@ -969,7 +990,7 @@ int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
         return -1;
     }
 
-    ret = set_cpu_state(cpu, fpu, xcr0);
+    ret = set_cpu_state(cpu);
     if (ret < 0) {
         error_report("failed to set cpu state");
         return -1;
@@ -986,14 +1007,9 @@ int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
 
 static int put_regs(const CPUState *cpu)
 {
-    X86CPU *x86cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86cpu->env;
-    MshvFPU fpu = {0};
     int ret;
 
-    memset(&fpu, 0, sizeof(fpu));
-
-    ret = mshv_configure_vcpu(cpu, &fpu, env->xcr0);
+    ret = mshv_configure_vcpu(cpu);
     if (ret < 0) {
         error_report("failed to configure vcpu");
         return ret;
-- 
2.34.1

