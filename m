Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B88396D1C;
	Tue, 11 Aug 2026 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413188; cv=none; b=Sp12GlY6vPKLbxiDoKIabXQbRK9QlJ0a+eUGdL4562v0HaE5YfnVdQEJh60BHic3mK627k6jzXx/H4PqwbBIdGm4erz0/vVcKLV81enmCwSVSbKL2Io96OelI4EJEJoJbM5HmemBbAr+4svbcosZ8n2IMkyc2UvStDEpW1RqO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413188; c=relaxed/simple;
	bh=Ye+FKb+O4vDOZT+EEdbqG3BJt9HeESDb5F9zr4JuXXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWnKeI7gZYa0Vsz9hrF2x5Qoidrg7oKBCXlS9dRHbGjJ9pf9OgvXrCdillziA12HykAqtZXVfjBNiOei3KKlqXV3rye1J17/zYMg2f6t71VTAML97clnZMfDPIRYaKDfRbxMUqdxkcqWvmpx5AbgS87f25D5RuZTfwWa24ZDQAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QzIPO/SV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QzIPO/SV"
Received: from fedora (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6068520B7129;
	Mon, 10 Aug 2026 18:52:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6068520B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786413162;
	bh=7OQNua6H09fypXrgEyrMYCrbqK4v9ks9MhiALwXkFTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzIPO/SVo1ofRn+EWdsKs5Rbw1AbCUdyP6cCVkBX92ZfMv5QCVLFiuko8hI51SsJN
	 w+zobnBQXM9pwspjSZEjzLnlX0+gWFH0rmkRc8c68wBpr/aaMuDnRXRJVJphbt28Eq
	 q1yK/sLgpqucvVDbupW+HzEf07KPGpv689a9OKtw=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 8/8] drivers/virt: add KVM VM-planes secure-plane monitor
Date: Mon, 10 Aug 2026 18:52:43 -0700
Message-ID: <20260811015243.188486-9-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811015243.188486-1-snambakam@linux.microsoft.com>
References: <20260811015243.188486-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the secure-plane (plane >0) side of the VM-planes park/dispatch
handshake, so an otherwise ordinary kernel can act as the secure plane
without the full VBS stack.  Activated by the "secure_monitor" kernel
command-line option, a late_initcall kthread hands control back to the
normal plane via KVM_HC_VBS_VTL_RETURN and then services VTL calls from the
shared calling area (matching struct vbs_kvm_ca in security/vbs).

Calls are acknowledged as no-ops for now; real per-call handlers are added
incrementally.  The same option also skips the sub-1M real-mode trampoline
(arch/x86/realmode/init.c), which the secure plane neither has memory for
nor uses.

Gated by CONFIG_VBS_SECURE_MONITOR.
---
 arch/x86/realmode/init.c      |  21 +++++
 drivers/virt/Kconfig          |  15 ++++
 drivers/virt/Makefile         |   1 +
 drivers/virt/secure_monitor.c | 141 ++++++++++++++++++++++++++++++++++
 4 files changed, 178 insertions(+)
 create mode 100644 drivers/virt/secure_monitor.c

diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 694d80a5c68e..d9d73cd892bf 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -44,6 +44,27 @@ void load_trampoline_pgtable(void)
 	__flush_tlb_all();
 }
 
+#ifdef CONFIG_VBS_SECURE_MONITOR
+/*
+ * A KVM VM-planes secure plane (plane > 0) is entered directly in 64-bit long
+ * mode and boots from a single carved-out high-memory region that contains no
+ * RAM below 1 MiB.  It runs with no firmware, ACPI sleep, or hibernation, so
+ * the 16-bit real-mode trampoline can neither be allocated (there is no
+ * sub-1M memory) nor is it ever used.  Disable the real-mode setup from an
+ * early_param so it takes effect before setup_arch() calls
+ * x86_platform.realmode_reserve(); triggered by the "secure_monitor" option,
+ * the same switch that activates the in-kernel secure-plane monitor.
+ */
+static int __init secure_plane_no_real_mode(char *arg)
+{
+	x86_platform.realmode_reserve = x86_init_noop;
+	x86_platform.realmode_init = x86_init_noop;
+	pr_info("realmode: secure plane: skipping sub-1M trampoline\n");
+	return 0;
+}
+early_param("secure_monitor", secure_plane_no_real_mode);
+#endif /* CONFIG_VBS_SECURE_MONITOR */
+
 void __init reserve_real_mode(void)
 {
 	phys_addr_t mem, limit = x86_init.resources.realmode_limit;
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 52eb7e4ba71f..bb1a7de559c3 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -13,6 +13,21 @@ menuconfig VIRT_DRIVERS
 
 if VIRT_DRIVERS
 
+config VBS_SECURE_MONITOR
+	bool "KVM VM-planes secure-plane monitor"
+	depends on X86 && KVM_GUEST
+	help
+	  In-kernel monitor for the secure plane (plane >0) of a KVM VM-planes
+	  guest.  When enabled and the "secure_monitor" kernel command-line
+	  option is present, a kernel thread hands control back to the normal
+	  plane via the KVM_HC_VBS_VTL_RETURN hypercall and then services VTL
+	  calls from a shared calling area.
+
+	  This is independent of the full VBS stack (CONFIG_VBS) so that any
+	  secure kernel can act as plane 1.  Per-call handlers are plumbed in
+	  incrementally; until then calls are acknowledged as no-ops.  Say N
+	  unless this kernel is used as a VM-planes secure plane.
+
 config VMGENID
 	tristate "Virtual Machine Generation ID driver"
 	default y
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index f29901bd7820..22d1121ba5bd 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_FSL_HV_MANAGER)	+= fsl_hypervisor.o
 obj-$(CONFIG_VMGENID)		+= vmgenid.o
+obj-$(CONFIG_VBS_SECURE_MONITOR)	+= secure_monitor.o
 obj-y				+= vboxguest/
 
 obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
diff --git a/drivers/virt/secure_monitor.c b/drivers/virt/secure_monitor.c
new file mode 100644
index 000000000000..4fe3ceb051e3
--- /dev/null
+++ b/drivers/virt/secure_monitor.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * secure_monitor - KVM VM-planes secure-plane monitor
+ *
+ * This is the secure-plane (plane >0) side of the VM-planes park/dispatch
+ * handshake.  It lets an otherwise ordinary kernel act as the secure plane
+ * (conventionally plane 1, though the index is not hard-coded) without pulling
+ * in the full VBS stack (CONFIG_VBS).  Its single job is to hand control back
+ * to the normal plane (plane 0) via the KVM_HC_VBS_VTL_RETURN hypercall and
+ * then service VTL calls from the shared calling area.
+ *
+ * Control flow (all within plane 0's single KVM_RUN; see
+ * arch/x86/kvm/x86.c __kvm_emulate_hypercall):
+ *
+ *   normal plane                   KVM                       secure plane
+ *   ------------                   ---                       ------------
+ *   fill calling area
+ *   HC_VBS_VTL_CALL(ca_gpa) ─────▶ switch_plane ───────────▶ resume in
+ *                                  (RAX := ca_gpa)            secmon_vtl_return()
+ *                                                            dispatch(call_id)
+ *                                                            write ca->status
+ *   resume after VTL_CALL ◀─────── switch_plane ◀─────────── HC_VBS_VTL_RETURN
+ *
+ * All planes of a VM share the same memslots, so the secure plane sees the
+ * same guest-physical address space as the normal plane and can read the
+ * calling area directly.  Every VTL call is acknowledged as a no-op so the
+ * normal plane can make progress; real per-call handlers are plumbed in
+ * incrementally.
+ *
+ * Activated by the "secure_monitor" kernel command-line option; without it
+ * this kernel boots normally and never parks.
+ */
+
+#define pr_fmt(fmt) "vbs-secmon: " fmt
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/kthread.h>
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/kvm_para.h>
+#include <asm/kvm_para.h>
+
+/*
+ * Shared-memory calling area.  MUST match struct vbs_kvm_ca in
+ * security/vbs/kvm_planes.c (the normal-plane <-> secure-plane wire ABI):
+ *
+ *   [ call_pending | call_id | status | arg_size | resp_size | buffer ]
+ */
+struct vbs_kvm_ca {
+	__u8	call_pending;	/* 1 while call is in flight            */
+	__u8	rsvd[3];
+	__u32	call_id;	/* request id (set by caller)           */
+	__s32	status;		/* return code (set by responder)       */
+	__u32	arg_size;	/* request payload size                 */
+	__u32	resp_size;	/* response payload size                */
+	__u8	buffer[];	/* request data in, response data out   */
+} __packed;
+
+/* Set from the "secure_monitor" kernel command-line option. */
+static bool secmon_active __ro_after_init;
+
+static int __init secmon_setup(char *str)
+{
+	secmon_active = true;
+	return 1;
+}
+__setup("secure_monitor", secmon_setup);
+
+/*
+ * Park the secure plane and hand control back to the normal plane.  On the
+ * next VTL call KVM resumes us here with the calling-area GPA in the
+ * hypercall return value (RAX).  @status is carried for tracing only; the
+ * real result is already in the calling area.
+ */
+static u64 secmon_vtl_return(long status)
+{
+	return kvm_hypercall1(KVM_HC_VBS_VTL_RETURN, (unsigned long)status);
+}
+
+static int secmon_monitor_fn(void *unused)
+{
+	long status = 0;
+
+	pr_info("secure monitor started\n");
+
+	for (;;) {
+		struct vbs_kvm_ca *ca;
+		u64 ca_gpa;
+
+		/* Park; resume with the next request's calling-area GPA. */
+		ca_gpa = secmon_vtl_return(status);
+		if (!ca_gpa) {
+			status = -EINVAL;
+			continue;
+		}
+
+		ca = memremap(ca_gpa, PAGE_SIZE, MEMREMAP_WB);
+		if (!ca) {
+			pr_err_ratelimited("failed to map calling area 0x%llx\n",
+					   ca_gpa);
+			status = -EFAULT;
+			continue;
+		}
+
+		/*
+		 * No handlers are plumbed in yet: acknowledge the call as a
+		 * no-op so the normal plane can make progress.  Real per-call
+		 * dispatch is added incrementally.
+		 */
+		pr_info_ratelimited("VTL call id=0x%x arg_size=%u (no-op)\n",
+				    ca->call_id, ca->arg_size);
+		ca->status    = 0;
+		ca->resp_size = 0;
+		status = 0;
+
+		memunmap(ca);
+	}
+
+	return 0;
+}
+
+static int __init secmon_init(void)
+{
+	struct task_struct *t;
+
+	if (!secmon_active)
+		return 0;
+
+	t = kthread_run(secmon_monitor_fn, NULL, "vbs-secmon");
+	if (IS_ERR(t)) {
+		pr_err("failed to start secure monitor: %ld\n", PTR_ERR(t));
+		return PTR_ERR(t);
+	}
+
+	return 0;
+}
+late_initcall(secmon_init);
-- 
2.55.0

