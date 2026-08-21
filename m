Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B817B38F64D;
	Fri, 21 Aug 2026 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351465; cv=none; b=rWI8qLZ9LCyhrg8kx2RXXbS7ARcGLL46WiNjkPMkNwM0/m3JN1MTiDVyoX5P8WVyNLgJEYeRM5cDoVyHq1eW5MVYZUX+fMpZb/tsofQwQI6e2S50bpAZLMfsZigjQvXREtATyf7K5o7Ba6sU41JPm43+X/WPmPTwk9eKvgvGNgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351465; c=relaxed/simple;
	bh=jvWmcmB6iAzPLMAExSIzujcPp+D4ECxg2F7MvHFRHXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbMBykVoCKlPBGDSvibbMRxZeiQeSIl+kbOwYSxIltIry9VajNMhOQWg9PN6k6MM2PU+cUoLfRIyU2FjaaIv9ACi5Rbn1sjQ7Sk5X2mM3xsQmvCxW/C9rzz6tHuZwCnW1OEZS5q6WMBoSnNuqguGtiE5hpWFv1Gzkp5dZ1cFbh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AS2AsMJ/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AS2AsMJ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351463; x=1818887463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jvWmcmB6iAzPLMAExSIzujcPp+D4ECxg2F7MvHFRHXQ=;
  b=AS2AsMJ/4nzYIa3Cjk6JwEe8cEazHAXP70cu6sIr9XteI3c4sPyHvEDq
   FjOMY0x2zWC+YLuoFApkAx8+WQkkd84U6s5jG8q1B5lT0feGYIh+oyAtc
   HiHTAkvAI9Tb7E3TetENRmPGEdSU7MCrBavOEUauJqQ2WQED+Fy3d2yUx
   +eXx5m2l3s5i3sS3PTp2pTSDnvo0p8TWGJpX3QxmXAgNsJstPMurxvCUQ
   YYUdi4Wz4QNGGTDmgOY6Q0tb0nIlVqKcw3S5Q4AbMQmtkWjaqqCBJ1f+W
   N5mZvqF6LOFYoUPYdE2GWTmYFWhmVdVtYE27KA1hjxpz3A3ncPx2yRiP9
   w==;
X-CSE-ConnectionGUID: 0TQBUs8wQrmac+3wlbxvnA==
X-CSE-MsgGUID: w2E9hobZRhePzDbX8IuxfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032620"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032620"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:49 -0700
X-CSE-ConnectionGUID: qnTSBA2UR32TukOTVZ0m/Q==
X-CSE-MsgGUID: m/MExomMSmGvoIptHCfeIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679776"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:49 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Jim Mattson <jmattson@google.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH 12/23] KVM: x86/pmu: Add the perfmon_mask module parameter
Date: Fri, 21 Aug 2026 15:19:51 -0700
Message-ID: <20260821222002.54907-13-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821222002.54907-1-zide.chen@intel.com>
References: <20260821222002.54907-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only Intel CPUs support PerfMon masking, so this new parameter is
Intel-specific. Mediated vPMU must be enabled for PerfMon masking.

PerfMon masking lets a VMM partition PMU resources between host and
guest: each mask bit determines whether the guest (set) or host
(clear) owns a counter's MSR(s), RDPMC access, and the corresponding
bit in the global MSRs (e.g. IA32_PERF_GLOBAL_CTRL) in non-root mode.

The setting is system-wide and caps what any individual guest may be
given; each guest may configure a subset of it.

The parameter is configured with a text-based, semicolon-separated
list of terms. Currently supported for a mediated vPMU guest:

  guest_gp=<list>    general purpose counters (0-based) owned by the guest
  guest_fixed=<list> fixed counters (0-based) owned by the guest
  perf_metrics       PERF_METRICS is owned by the guest

For example:

  kvm-intel.perfmon_mask=guest_gp=0-3;guest_fixed=0,2-3;perf_metrics

Internally, the parsed terms are folded into a 64-bit perfmon_mask
variable that uses the same layout as the PERFMON_MASK VMCS field,
i.e. the IA32_PERF_GLOBAL_STATUS layout. An empty (default) value
behaves the same as a plain mediated vPMU.

Using IA32_PERF_GLOBAL_CTRL in the generic VM-exit MSR-store area
while the PerfMon masking VM-execution control is set is undefined,
so PerfMon masking requires the dedicated Save-IA32_PERF_GLOBAL_CTRL
VM-exit control.

cpu_has_vmx_perfmon_mask() is hardcoded to false temporarily until
later patches.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 .../admin-guide/kernel-parameters.txt         | 30 ++++++++
 arch/x86/kvm/pmu.c                            |  3 +
 arch/x86/kvm/pmu.h                            |  1 +
 arch/x86/kvm/vmx/capabilities.h               |  5 ++
 arch/x86/kvm/vmx/pmu_intel.c                  | 68 +++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c                        | 54 +++++++++++++++
 arch/x86/kvm/vmx/vmx.h                        |  1 +
 arch/x86/kvm/x86.c                            |  2 +-
 8 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..e0ff16746a08 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3284,6 +3284,36 @@ Kernel parameters
 			[KVM,Intel] Control nested virtualization feature in
 			KVM/VMX. Default is 1 (enabled).
 
+	kvm-intel.perfmon_mask=
+			[KVM,Intel] Defines the host-wide PMU resource
+			partition between guest and host. Resources assigned
+			to the guest are unavailable to the host, and vice
+			versa, while a guest is running.
+
+			The value is a semicolon-separated list of terms:
+
+			  guest_gp=<list>    General purpose counters
+					     (0-based) assigned to the guest.
+			  guest_fixed=<list> Fixed counters (0-based) assigned
+					     to the guest.
+			  perf_metrics       PERF_METRICS is assigned to the
+					     guest. Requires fixed counter 3
+					     to also be assigned to the
+					     guest.
+
+			<list> is a comma-separated list of numbers and/or
+			ranges, e.g. "0-2,5". Terms and the resources they
+			don't mention default to being host-owned. For
+			example:
+
+				kvm-intel.perfmon_mask=guest_gp=0-3;guest_fixed=0-1,3;perf_metrics
+
+			assigns general purpose counters 0-3, fixed counters
+			0, 1 and 3, and PERF_METRICS to the guest, while all
+			other resources remain with the host.
+
+			Default is "" (disabled).
+
 	kvm-intel.unrestricted_guest=
 			[KVM,Intel] Control KVM's use of unrestricted guest
 			feature (virtualized real and unpaged mode). Default
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index c022337d0bec..92ff685d11b3 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -43,6 +43,9 @@ module_param(enable_pmu, bool, 0444);
 bool __read_mostly enable_mediated_pmu;
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(enable_mediated_pmu);
 
+u64 __read_mostly perfmon_mask;
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(perfmon_mask);
+
 struct kvm_x86_pmu_event_filter {
 	__u32 action;
 	__u32 nevents;
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 8322bbed2d64..2dc12e3f3af0 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -64,6 +64,7 @@ struct kvm_pmu_ops {
 
 extern bool enable_pmu;
 extern bool enable_mediated_pmu;
+extern u64 perfmon_mask;
 
 void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops);
 
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 810119167f79..d4c362093966 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -296,6 +296,11 @@ static inline bool cpu_has_vmx_ipiv(void)
 	return vmcs_config.cpu_based_3rd_exec_ctrl & TERTIARY_EXEC_IPI_VIRT;
 }
 
+static inline bool cpu_has_vmx_perfmon_mask(void)
+{
+	return false;
+}
+
 static inline bool cpu_has_vmx_flexpriority(void)
 {
 	return cpu_has_vmx_tpr_shadow() &&
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index e2e51006ca47..62e542eac05e 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -955,6 +955,74 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
 	}
 }
 
+static bool intel_pmu_validate_perfmon_mask(void)
+{
+	u64 guest_fixed_mask, guest_gp_mask;
+
+	/*
+	 * Combining VM-exit MSR-store with PerfMon masking produces
+	 * undefined behavior, so it requires hardware support for this
+	 * dedicated save control.
+	 */
+	if (!cpu_has_save_perf_global_ctrl())
+		return false;
+
+	guest_gp_mask = perfmon_mask & GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
+	guest_fixed_mask = perfmon_mask >> INTEL_PMC_IDX_FIXED;
+	guest_fixed_mask &= GENMASK_ULL(INTEL_PMC_MAX_FIXED - 1, 0);
+
+	if ((guest_fixed_mask & ~kvm_pmu_cap.fixed_cntr_mask64) ||
+	    (guest_gp_mask & ~kvm_pmu_cap.cntr_mask64))
+		return false;
+
+	/*
+	 * Without KVM Arch PerfMon extension support, the guest cannot own
+	 * non-contiguous GP counters.
+	 */
+	if (guest_gp_mask & (guest_gp_mask + 1))
+		return false;
+
+	if ((perfmon_mask & GLOBAL_STATUS_PERF_METRICS_OVF) &&
+	    !(kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS))
+		return false;
+
+	/*
+	 * PERF_METRICS and fixed counter 3 must both be host-owned or both
+	 * guest-owned.
+	 */
+	if (!!(perfmon_mask & BIT_ULL(GLOBAL_STATUS_PERF_METRICS_OVF_BIT)) !=
+	    !!(perfmon_mask & BIT_ULL(INTEL_PMC_IDX_FIXED + 3)))
+		return false;
+
+	/*
+	 * The guest must not own all PMU counters. Otherwise, the configuration
+	 * degenerates into plain mediated vPMU and adds unnecessary complexity
+	 * to the perf scheduler.
+	 */
+	if ((guest_fixed_mask == kvm_host_pmu.fixed_cntr_mask64) &&
+	    (guest_gp_mask == kvm_host_pmu.cntr_mask64))
+		return false;
+
+	return true;
+}
+
+void intel_pmu_perfmon_mask_setup(void)
+{
+	if (!perfmon_mask)
+		return;
+
+	if (!enable_mediated_pmu || !cpu_has_vmx_perfmon_mask()) {
+		perfmon_mask = 0;
+		return;
+	}
+
+	if (!intel_pmu_validate_perfmon_mask()) {
+		pr_warn("Invalid perfmon_mask=%#llx, disabling PerfMon masking\n",
+			perfmon_mask);
+		perfmon_mask = 0;
+	}
+}
+
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
 	.emulate_rdpmc = intel_emulate_rdpmc,
 	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ded63e2e39ce..cdd141d22efa 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -14,6 +14,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bitmap.h>
 #include <linux/highmem.h>
 #include <linux/hrtimer.h>
 #include <linux/kernel.h>
@@ -25,6 +26,7 @@
 #include <linux/sched.h>
 #include <linux/sched/smt.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/tboot.h>
 #include <linux/trace_events.h>
 
@@ -164,6 +166,56 @@ module_param(allow_smaller_maxphyaddr, bool, S_IRUGO);
 
 module_param(enable_mediated_pmu, bool, 0444);
 
+/*
+ * See the "kvm-intel.perfmon_mask" entry in
+ * Documentation/admin-guide/kernel-parameters.txt for the full syntax.
+ * Example: kvm-intel.perfmon_mask=guest_gp=0-3;guest_fixed=0-1,3;perf_metrics
+ */
+static int perfmon_mask_set(const char *val, const struct kernel_param *kp)
+{
+	unsigned long gp_bitmap = 0, fixed_bitmap = 0;
+	char *buf, *orig, *tok;
+	size_t prefix_len;
+	u64 mask = 0;
+	int r = 0;
+
+	buf = orig = kstrdup(val, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	while ((tok = strsep(&buf, ";")) != NULL) {
+		if (!*tok)
+			continue;
+
+		if (!strcmp(tok, "perf_metrics")) {
+			mask |= GLOBAL_STATUS_PERF_METRICS_OVF;
+		} else if ((prefix_len = str_has_prefix(tok, "guest_gp="))) {
+			r = bitmap_parselist(tok + prefix_len, &gp_bitmap,
+					     INTEL_PMC_MAX_GENERIC);
+		} else if ((prefix_len = str_has_prefix(tok, "guest_fixed="))) {
+			r = bitmap_parselist(tok + prefix_len, &fixed_bitmap,
+					     INTEL_PMC_MAX_FIXED);
+		} else {
+			r = -EINVAL;
+		}
+
+		if (r)
+			goto out;
+	}
+
+	mask |= gp_bitmap | ((u64)fixed_bitmap << INTEL_PMC_IDX_FIXED);
+	*(u64 *)kp->arg = mask;
+out:
+	kfree(orig);
+	return r;
+}
+
+static const struct kernel_param_ops perfmon_mask_ops = {
+	.set = perfmon_mask_set,
+	.get = param_get_ullong,
+};
+module_param_cb(perfmon_mask, &perfmon_mask_ops, &perfmon_mask, 0444);
+
 #define KVM_VM_CR0_ALWAYS_OFF (X86_CR0_NW | X86_CR0_CD)
 #define KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST X86_CR0_NE
 #define KVM_VM_CR0_ALWAYS_ON				\
@@ -8824,6 +8876,8 @@ __init int vmx_hardware_setup(void)
 	else
 		vt_init_ops.handle_intel_pt_intr = NULL;
 
+	intel_pmu_perfmon_mask_setup();
+
 	setup_default_sgx_lepubkeyhash();
 
 	vmx_set_cpu_caps();
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index dc8517f15bc4..ccda5c5c8c2c 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -667,6 +667,7 @@ static __always_inline struct vcpu_vmx *to_vmx(struct kvm_vcpu *vcpu)
 void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu);
 int intel_pmu_create_guest_lbr_event(struct kvm_vcpu *vcpu);
 void vmx_passthrough_lbr_msrs(struct kvm_vcpu *vcpu);
+void intel_pmu_perfmon_mask_setup(void);
 
 struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags);
 void free_vmcs(struct vmcs *vmcs);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5f3215915c76..26a3b7a267b5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9328,7 +9328,7 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 	if (enable_mediated_pmu && kvm->arch.enable_pmu &&
 	    !kvm->arch.created_mediated_pmu) {
 		if (irqchip_in_kernel(kvm)) {
-			r = perf_create_mediated_pmu(0);
+			r = perf_create_mediated_pmu(perfmon_mask);
 			if (r) {
 				pr_warn_ratelimited(PERF_MEDIATED_PMU_MSG);
 				return r;
-- 
2.55.0

