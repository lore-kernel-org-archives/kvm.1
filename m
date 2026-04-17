Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394763BADA2
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423444; cv=none; b=Z1T8qKZz3lvmFYHPMvfBMkXiMF75lFPp7KSWP62du4MThzAcDFCzHxam46CjpPSBPUF/cA6AMQNMA+F+bTle/JQIOrsAfO6pJ7bmgb9fiuL2u4NyDAeF9vI6v7hg5HOOu5kdggvQN3BStWkY4efOEcXLyK6D/778Mpe19TrEVdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423444; c=relaxed/simple;
	bh=MIrRHABxgyZGSHwhqEKKKfAr+HSc9H1EleplPxlswio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pqfifkKHMI+lcQTzFm/MgAeYBCzjmV0086/GPfP/Z8zVlOQbf79pEIEkOrx4wx4vGjLcbZN71rEpxX6ZBY9zLitf85c/jA1fI15BVqbBTUig13uK1c1Q8BvSwwworLk9VW59xGeYVy6mvOcWdTIWhtocCyb6/mjb5R0X8zbhwEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jh8ThyFs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jh8ThyFs"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2868620B7129;
	Fri, 17 Apr 2026 03:57:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2868620B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423443;
	bh=n7/23i78ePWRFCNhXvpu2aDZEvpadavS9yPcaXyN5rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jh8ThyFs/ODcR1xk4+8KIBEoaMRe8iwL0cLaJRiqYN3rE45XHIFYso3fkeTIGgf8o
	 AHDZKir0CeUJdMf4VWKa7sA+W0qYNWWdtnwCyUo0TB5lElLHVJtiy9JOjaeB//YVDq
	 XjvH394nRuh0skp4phxzIjGQx4zoYp4QfY9tnWBs=
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
Subject: [PATCH 16/34] target/i386/mshv: migrate LAPIC state
Date: Fri, 17 Apr 2026 12:56:00 +0200
Message-Id: <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
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

This change implements loading and storing the hyperv lapic state as
part of the load/store routines for a vcpu.

The HyperV LAPIC is similar to the the split-irqchip in KVM, it will
only handle MSI/X interrupts. PIC and IOAPIC have to be handled in
userland.

An opaque blob is added to the APICCommonState, guarded behind a flag,
hence it will be covered by a migration, as we declare VMSTATE_BUFFER
for the hv_lapic_state field.

In the future we might want to introduce a dedicated class for MSHV, that
would require us to wire up an IOAPIC delivery path to QEMU's userland
emulation.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 hw/intc/apic_common.c           |  3 ++
 include/hw/i386/apic_internal.h |  5 +++
 target/i386/mshv/mshv-cpu.c     | 61 +++++++++++++++++++++++++++++++--
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index bf4abc21d7..a7df870f1a 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -380,6 +380,9 @@ static const VMStateDescription vmstate_apic_common = {
         VMSTATE_INT64(next_time, APICCommonState),
         VMSTATE_INT64(timer_expiry,
                       APICCommonState), /* open-coded timer state */
+#ifdef CONFIG_MSHV
+        VMSTATE_BUFFER(hv_lapic_state, APICCommonState),
+#endif
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 0cb06bbc76..6d4ccca4e8 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -23,6 +23,7 @@
 
 #include "cpu.h"
 #include "hw/i386/apic.h"
+#include "hw/hyperv/hvgdk_mini.h"
 #include "system/memory.h"
 #include "qemu/timer.h"
 #include "target/i386/cpu-qom.h"
@@ -188,6 +189,10 @@ struct APICCommonState {
     DeviceState *vapic;
     hwaddr vapic_paddr; /* note: persistence via kvmvapic */
     uint32_t extended_log_dest;
+
+#ifdef CONFIG_MSHV
+    uint8_t hv_lapic_state[sizeof(struct hv_local_interrupt_controller_state)];
+#endif
 };
 
 typedef struct VAPICState {
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 12343acb01..22c962c5ac 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -112,6 +112,25 @@ static int get_generic_regs(CPUState *cpu,
                             struct hv_register_assoc *assocs,
                             size_t n_regs);
 
+static int get_lapic(CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    APICCommonState *apic = APIC_COMMON(x86cpu->apic_state);
+    int cpu_fd = mshv_vcpufd(cpu);
+    int ret;
+    struct hv_local_interrupt_controller_state lapic_state = { 0 };
+
+    ret = mshv_get_lapic(cpu_fd, &lapic_state);
+    if (ret < 0) {
+        error_report("failed to get lapic state");
+        return -1;
+    }
+
+    memcpy(&apic->hv_lapic_state, &lapic_state, sizeof(lapic_state));
+
+    return 0;
+}
+
 static void populate_fpu(const hv_register_assoc *assocs, X86CPU *x86cpu)
 {
     union hv_register_value value;
@@ -559,6 +578,11 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
+    ret = get_lapic(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     return 0;
 }
 
@@ -926,9 +950,11 @@ static uint32_t set_apic_delivery_mode(uint32_t reg, uint32_t mode)
 
 static int init_lint(const CPUState *cpu)
 {
-    int ret;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    APICCommonState *apic = APIC_COMMON(x86cpu->apic_state);
     uint32_t *lvt_lint0, *lvt_lint1;
     int cpu_fd = mshv_vcpufd(cpu);
+    int ret;
 
     struct hv_local_interrupt_controller_state lapic_state = { 0 };
     ret = mshv_get_lapic(cpu_fd, &lapic_state);
@@ -944,7 +970,32 @@ static int init_lint(const CPUState *cpu)
 
     /* TODO: should we skip setting lapic if the values are the same? */
 
-    return mshv_set_lapic(cpu_fd, &lapic_state);
+    ret = mshv_set_lapic(cpu_fd, &lapic_state);
+    if (ret < 0) {
+        return -1;
+    }
+
+    memcpy(apic->hv_lapic_state, &lapic_state, sizeof(lapic_state));
+
+    return 0;
+}
+
+static int set_lapic(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    APICCommonState *apic = APIC_COMMON(x86cpu->apic_state);
+    int cpu_fd = mshv_vcpufd(cpu);
+    int ret;
+
+    struct hv_local_interrupt_controller_state lapic_state = { 0 };
+    memcpy(&lapic_state, &apic->hv_lapic_state, sizeof(lapic_state));
+    ret = mshv_set_lapic(cpu_fd, &lapic_state);
+    if (ret < 0) {
+        error_report("failed to set lapic");
+        return -1;
+    }
+
+    return 0;
 }
 
 int mshv_arch_store_vcpu_state(const CPUState *cpu)
@@ -971,6 +1022,12 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
         return ret;
     }
 
+    /* INVARIANT: special regs (APIC_BASE) must be restored before LAPIC */
+    ret = set_lapic(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     return 0;
 }
 
-- 
2.34.1

