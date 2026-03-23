Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121D03AEF53
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274400; cv=none; b=j6zbnsOqPUmUGwXW3bREtNhTBrs+xj84QE2kshHJ5W2lrI7WYnnC6x8NqaVsDYIiE62edEas6xE1TEie39kJljlX2DAZjjD8ykCWRHVCfMzE05MScNaURxgvqfvrwW3LvQtrkHf2wWI1vsjmuX6qHZXTwUhJ7wBFZ0Ey00ER+cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274400; c=relaxed/simple;
	bh=brXW4CyzJPk86DE6OH74Gpiis62756PFbMxrw5ol0EI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X0TFbIG5IYen4DeTTCOS7KcRDeulW73y0+VSEgsBiQpCjT7JldOd0XJvjEI5Ekb2lbQ4r2+pXD+sjkkRF4UcTmafoSlmORZfqQO0mhOD8GjiDUVZdO5dd+GLDW2ikV9PbmqcKxaHpQwtQdRGOiUEMSSAxxCWoPahHMRcW11+AB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rwms7er1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rwms7er1"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id C51A720B6F0C;
	Mon, 23 Mar 2026 06:59:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C51A720B6F0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274398;
	bh=y5n6XcDjhdUcCeYhcYqonW1SGbx+ZfqghjHafqkUNaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rwms7er1i4rx+bIDzSkjhj8f3Yi4yf2DnOV4Ve4PgBWqy1b0o3Qrga5cwEz4KvVVh
	 NOb5L5/myhhXAMBZA7FR+xWMBFIrwPcrxNrhlFiP44RW8i2rBbNMd8qmBUil3Esv70
	 v6BME3POxLDaMFlohJeDWwuViOE7ViTZ5W+zfF98=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Wei Liu <liuwe@microsoft.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Wei Liu <wei.liu@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 27/32] target/i386/mshv: migrate pending ints/excs
Date: Mon, 23 Mar 2026 14:58:07 +0100
Message-Id: <20260323135812.383509-28-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use PENDING_INTERRUPTION, INTERRUPT_STATE, PENDING_EVENT hv registers
to map and roundtrip from/to CPUX86State.

We ignore HV_REGISTER_PENDING_EVENT1 which represent events for nested
virt contexts, as we don't support nested virt with MSHV currently.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/hw/hyperv/hvgdk_mini.h |   3 +
 include/system/mshv_int.h      |  13 +++
 target/i386/mshv/mshv-cpu.c    | 168 +++++++++++++++++++++++++++++++++
 3 files changed, 184 insertions(+)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index 00daac0431..a88420fafe 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -28,6 +28,9 @@ typedef enum hv_register_name {
 
     /* Pending Interruption Register */
     HV_REGISTER_PENDING_INTERRUPTION = 0x00010002,
+    HV_REGISTER_INTERRUPT_STATE      = 0x00010003,
+    HV_REGISTER_PENDING_EVENT0       = 0x00010004,
+    HV_REGISTER_PENDING_EVENT1       = 0x00010005,
 
     /* X64 User-Mode Registers */
     HV_X64_REGISTER_RAX     = 0x00020000,
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 7052f20a00..bc16b794b2 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -18,6 +18,19 @@
 
 struct mshv_get_set_vp_state;
 
+/*
+ * Interruption-type encoding, used by the hypervisor in
+ * hv_x64_pending_interruption_register.interruption_type
+ * See TLFS 6.0 section 7.9.2, p55
+ * https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/tlfs
+ */
+#define MSHV_HV_INTERRUPTION_TYPE_EXT_INT     0
+#define MSHV_HV_INTERRUPTION_TYPE_NMI         2
+#define MSHV_HV_INTERRUPTION_TYPE_HW_EXC      3
+#define MSHV_HV_INTERRUPTION_TYPE_SW_INT      4
+#define MSHV_HV_INTERRUPTION_TYPE_PRIV_SW_EXC 5
+#define MSHV_HV_INTERRUPTION_TYPE_SW_EXC      6
+
 typedef struct hyperv_message hv_message;
 
 typedef struct MshvHvCallArgs {
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 0b08f478ce..746987d62b 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -584,6 +584,164 @@ static int load_regs(CPUState *cpu)
     return 0;
 }
 
+static int get_vcpu_events(CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    struct hv_register_assoc assocs[] = {
+        { .name = HV_REGISTER_PENDING_INTERRUPTION },
+        { .name = HV_REGISTER_INTERRUPT_STATE },
+        { .name = HV_REGISTER_PENDING_EVENT0 },
+    };
+    union hv_x64_pending_interruption_register pending_int;
+    union hv_x64_interrupt_state_register int_state;
+    union hv_x64_pending_exception_event pending_exc;
+    int ret;
+
+    ret = mshv_get_generic_regs(cpu, assocs, ARRAY_SIZE(assocs));
+    if (ret < 0) {
+        error_report("failed to get vcpu event registers");
+        return -1;
+    }
+
+    pending_int.as_uint64 = assocs[0].value.reg64;
+    int_state.as_uint64 = assocs[1].value.reg64;
+    pending_exc = assocs[2].value.pending_exception_event;
+
+    /* Clear previous state. injected ints/excs are blanked w/ -1 */
+    env->interrupt_injected    = -1;
+    env->soft_interrupt        = 0;
+    env->exception_injected    = 0;
+    env->exception_pending     = 0;
+    env->exception_nr          = -1;
+    env->has_error_code        = 0;
+    env->error_code            = 0;
+    env->exception_has_payload = 0;
+    env->exception_payload     = 0;
+    env->nmi_injected          = 0;
+
+    if (pending_int.interruption_pending) {
+        switch (pending_int.interruption_type) {
+        case MSHV_HV_INTERRUPTION_TYPE_EXT_INT:
+            env->interrupt_injected = pending_int.interruption_vector;
+            break;
+        case MSHV_HV_INTERRUPTION_TYPE_NMI:
+            env->nmi_injected = 1;
+            break;
+        case MSHV_HV_INTERRUPTION_TYPE_HW_EXC:
+            env->exception_injected = 1;
+            env->exception_nr       = pending_int.interruption_vector;
+            env->has_error_code     = pending_int.deliver_error_code;
+            env->error_code         = pending_int.error_code;
+            break;
+        case MSHV_HV_INTERRUPTION_TYPE_SW_INT:
+            env->interrupt_injected = pending_int.interruption_vector;
+            env->soft_interrupt     = 1;
+            break;
+        case MSHV_HV_INTERRUPTION_TYPE_SW_EXC:
+        case MSHV_HV_INTERRUPTION_TYPE_PRIV_SW_EXC:
+            env->exception_injected = 1;
+            env->exception_nr       = pending_int.interruption_vector;
+            env->has_error_code     = pending_int.deliver_error_code;
+            env->error_code         = pending_int.error_code;
+            break;
+        default:
+            error_report("unknown interruption type %u",
+                         pending_int.interruption_type);
+            return -EINVAL;
+        }
+    }
+
+    /* disabled for one instr after STI, MOV/POP SS, see hvf_store_events() */
+    if (int_state.interrupt_shadow) {
+        env->hflags |= HF_INHIBIT_IRQ_MASK;
+    } else {
+        env->hflags &= ~HF_INHIBIT_IRQ_MASK;
+    }
+
+    /* see kvm_get_vcpu_events(), hvf_store_events() */
+    if (int_state.nmi_masked) {
+        env->hflags2 |= HF2_NMI_MASK;
+    } else {
+        env->hflags2 &= ~HF2_NMI_MASK;
+    }
+
+    /* HV_REGISTER_PENDING_EVENT0: pending exception not yet injected */
+    if (pending_exc.event_pending) {
+        env->exception_pending     = 1;
+        env->exception_nr          = pending_exc.vector;
+        env->has_error_code        = pending_exc.deliver_error_code;
+        env->error_code            = pending_exc.error_code;
+        env->exception_has_payload = (pending_exc.exception_parameter != 0);
+        env->exception_payload     = pending_exc.exception_parameter;
+    }
+
+    /*
+     * Ignoring HV_REGISTER_PENDING_EVENT1, virtualization fault events, MSHV
+     * does not support nested virtualization.
+     */
+
+    return 0;
+}
+
+static int set_vcpu_events(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    union hv_x64_pending_interruption_register pending_int = { 0 };
+    union hv_x64_interrupt_state_register int_state = { 0 };
+    union hv_x64_pending_exception_event pending_exc = { 0 };
+    struct hv_register_assoc assocs[3];
+    int ret;
+
+    /* build pending_int from CPUX86State */
+    if (env->exception_injected) {
+        pending_int.interruption_pending = 1;
+        pending_int.interruption_type    = MSHV_HV_INTERRUPTION_TYPE_HW_EXC;
+        pending_int.interruption_vector  = env->exception_nr;
+        pending_int.deliver_error_code   = env->has_error_code;
+        pending_int.error_code           = env->error_code;
+    } else if (env->nmi_injected) {
+        pending_int.interruption_pending = 1;
+        pending_int.interruption_type    = MSHV_HV_INTERRUPTION_TYPE_NMI;
+        pending_int.interruption_vector  = EXCP02_NMI;
+    } else if (env->interrupt_injected >= 0) {
+        pending_int.interruption_pending = 1;
+        pending_int.interruption_type    = env->soft_interrupt
+            ? MSHV_HV_INTERRUPTION_TYPE_SW_INT
+            : MSHV_HV_INTERRUPTION_TYPE_EXT_INT;
+        pending_int.interruption_vector  = env->interrupt_injected;
+    }
+
+    /* build int_state, normalize to bool */
+    int_state.interrupt_shadow = !!(env->hflags  & HF_INHIBIT_IRQ_MASK);
+    int_state.nmi_masked       = !!(env->hflags2 & HF2_NMI_MASK);
+
+    /* build pending_exc */
+    if (env->exception_pending) {
+        pending_exc.event_pending       = 1;
+        pending_exc.vector              = env->exception_nr;
+        pending_exc.deliver_error_code  = env->has_error_code;
+        pending_exc.error_code          = env->error_code;
+        pending_exc.exception_parameter = env->exception_payload;
+    }
+
+    assocs[0].name = HV_REGISTER_PENDING_INTERRUPTION;
+    assocs[0].value.reg64 = pending_int.as_uint64;
+    assocs[1].name = HV_REGISTER_INTERRUPT_STATE;
+    assocs[1].value.reg64 = int_state.as_uint64;
+    assocs[2].name = HV_REGISTER_PENDING_EVENT0;
+    assocs[2].value.pending_exception_event = pending_exc;
+
+    ret = mshv_set_generic_regs(cpu, assocs, ARRAY_SIZE(assocs));
+    if (ret < 0) {
+        error_report("failed to set vcpu event registers");
+        return -1;
+    }
+
+    return 0;
+}
+
 int mshv_arch_load_vcpu_state(CPUState *cpu)
 {
     int ret;
@@ -623,6 +781,11 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
+    ret = get_vcpu_events(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     return 0;
 }
 
@@ -1138,6 +1301,11 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
         return ret;
     }
 
+    ret = set_vcpu_events(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     return 0;
 }
 
-- 
2.34.1

