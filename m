Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EE43769F8;
	Fri, 21 Aug 2026 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351452; cv=none; b=gTad9iafTtm9UI7PAlKW8sdbPD6RMKcraJ+IxWXDwgeHT2YrhzeoHIGYxl0lzxQzkOoWUZ5BzqvkjM8B14ZbVSSBzib+0eN5Ldh/zikp1AcunRAah5+xtQMNOLECrmqX63qYso06NeuF80T8XivsjfC3nPMBFsq3b70PdksXj9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351452; c=relaxed/simple;
	bh=nN5L1YamjWTwnVOneurmy5Txa+koayj2WyZ0y+bPzas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+G2Tw6JC8TDNavQmtqDcEypARTDlyAgt1/IILcvtP3iFR2P/dZCUwddBbV7kUwZGjeFhP5MEh+0WkN/QqmUVfiZfIdfTnrtoPlcP9n7xHm+1xA7D8w11Jn+VsgC7yZPmSSntiOqV5c/6rWdLwoevAQYjgunK6FVSJYSz7nSUTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWLmRj8n; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWLmRj8n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351447; x=1818887447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nN5L1YamjWTwnVOneurmy5Txa+koayj2WyZ0y+bPzas=;
  b=AWLmRj8nqMNlKcWHx47tSSbyq3ao0wcNNC+iak2rzqjL1yZYx2uk9qe1
   T763QIvf8UsdgyJcqQqfOqTkad+h+bAo8QLpwUEPMQX+YE2nQUv14Kd3T
   m2/21KfCYeHz5Z6/GtaFbrstpaHj+5vKKiqgvCYGtfKD1phWZbIktz3h2
   XMWQZYvP92dfg/+hPK4/qEkG6eM1sEfTPmSDFhgv5L/A6xuVCfHFoZwJ9
   yBjrUjTQtUhIx5zSqJQlD9fSV5KbdkTpkjpzgyl6gvAs3Mzp7EGlM9MWO
   wSnb0e4T695CZGUV60jZ2eaACPSZlliJDflvthZ3ytpXI2sScU2S9vFWu
   Q==;
X-CSE-ConnectionGUID: BErBGkTCQH2jNRkaDSLTEQ==
X-CSE-MsgGUID: L0aiGznbQ5uA+uX/KPYtwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032575"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032575"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:45 -0700
X-CSE-ConnectionGUID: nLwTG8gpRCiunjvwpeywJw==
X-CSE-MsgGUID: Dr1LY27QQv2kuGoUjpI3yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679739"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:45 -0700
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
Subject: [PATCH 04/23] perf/x86: Split host/guest PMI handling under PMU partitioning
Date: Fri, 21 Aug 2026 15:19:43 -0700
Message-ID: <20260821222002.54907-5-zide.chen@intel.com>
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

If PMU partitioning is enabled, LVTPC could route to NMI if any host
events are scheduled in this CPU. Thus, PMIs that fire in guest context
can be host- or guest-induced.

The host NMI handler processes host-owned PMIs as usual. Guest-induced
PMIs are marked as handled to avoid unknown NMI warnings, and their
GLOBAL_STATUS bits deliberately remain untouched in hardware; it's
KVM's responsibility to inject the corresponding PMIs into the guest.

Other places that write to global MSRs in NMI context also need to
distinguish host-owned and guest-owned bits, so that they won't clobber
guest-owned bits. The GLOBAL_CTRL is an exception: its guest value is
expected to be saved by VMX on VM exit and restored by KVM on VM Entry.

Add x86_pmu_partition_nmi_active() to identify when PMU partitioning
is active and LVTPC is routed to NMI, to help determine when the
partition mask needs to be applied.

The effective mask may differ across guests. Add a per-cpu
partition_mask field to struct cpu_hw_events, to be updated by KVM
whenever the effective mask changes on the CPU. This could differ from
the static x86_pmu.partition_mask, of which the effective mask is a
subset.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/core.c       | 19 +++++++++++-
 arch/x86/events/intel/core.c | 58 ++++++++++++++++++++++++++++++++++--
 arch/x86/events/perf_event.h |  8 +++++
 3 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index ba441f4d5f3e..bbae68c49063 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1805,6 +1805,19 @@ bool pmu_partition_configured(void)
 	return READ_ONCE(x86_pmu.partition_mask) != 0;
 }
 
+bool x86_pmu_partition_nmi_active(void)
+{
+	enum guest_pmu_mode state = this_cpu_read(guest_pmu_state);
+
+	return pmu_partition_configured() &&
+	       state == GUEST_PMU_PARTITION_NMI;
+}
+
+u64 x86_pmu_current_partition_mask(void)
+{
+	return this_cpu_ptr(&cpu_hw_events)->partition_mask;
+}
+
 #ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
 /*
  * Mark this CPU as running a PMU partitioned guest. Guest PMU partition
@@ -1887,8 +1900,12 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 	/*
 	 * All PMUs/events that share this PMI handler should make sure to
 	 * increment active_events for their events.
+	 *
+	 * If PMU partitioning is enabled, guest-induced PMIs need to be marked
+	 * as handled to avoid unknown NMI warnings.
 	 */
-	if (!atomic_read(&active_events))
+	if (!atomic_read(&active_events) &&
+	    !x86_pmu_partition_nmi_active())
 		return NMI_DONE;
 
 	start_clock = sched_clock();
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8b13bcc5259c..c595c86ecf90 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2774,15 +2774,41 @@ static __always_inline void intel_pmu_disable_all(void)
 	intel_pmu_lbr_disable_all();
 }
 
+static inline u64 intel_pmu_guest_fixed_ctrl_mask(void)
+{
+	u64 partition_mask = x86_pmu_current_partition_mask();
+	int i = INTEL_PMC_IDX_FIXED;
+	u64 mask = 0;
+
+	for_each_set_bit_from(i, (unsigned long *)&partition_mask,
+			      INTEL_PMC_IDX_FIXED + INTEL_PMC_MAX_FIXED) {
+		mask |= intel_fixed_bits_by_idx(i - INTEL_PMC_IDX_FIXED,
+						INTEL_FIXED_BITS_MASK);
+	}
+
+	return mask;
+}
+
 static void __intel_pmu_enable_all(int added, bool pmi)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
+	u64 guest_mask, fixed_ctrl;
 
 	intel_pmu_lbr_enable_all(pmi);
 
 	if (cpuc->fixed_ctrl_val != cpuc->active_fixed_ctrl_val) {
-		wrmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cpuc->fixed_ctrl_val);
+		if (x86_pmu_partition_nmi_active() && pmi) {
+			guest_mask = intel_pmu_guest_fixed_ctrl_mask();
+
+			rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed_ctrl);
+			fixed_ctrl = (fixed_ctrl & guest_mask) |
+				     (cpuc->fixed_ctrl_val & ~guest_mask);
+		} else {
+			fixed_ctrl = cpuc->fixed_ctrl_val;
+		}
+
+		wrmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed_ctrl);
 		cpuc->active_fixed_ctrl_val = cpuc->fixed_ctrl_val;
 	}
 
@@ -3700,23 +3726,31 @@ static void intel_pmu_reset(void)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	unsigned long *cntr_mask = hybrid(cpuc->pmu, cntr_mask);
 	unsigned long *fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
+	u64 guest_owned_mask = 0;
 	unsigned long flags;
 	int idx;
 
 	if (!*(u64 *)cntr_mask)
 		return;
 
+	if (x86_pmu_partition_nmi_active())
+		guest_owned_mask = x86_pmu_current_partition_mask();
+
 	local_irq_save(flags);
 
 	pr_info("clearing PMU state on CPU#%d\n", smp_processor_id());
 
 	for_each_set_bit(idx, cntr_mask, INTEL_PMC_MAX_GENERIC) {
+		if (BIT_ULL(idx) & guest_owned_mask)
+			continue;
 		wrmsrq_safe(x86_pmu_config_addr(idx), 0ull);
 		wrmsrq_safe(x86_pmu_event_addr(idx),  0ull);
 	}
 	for_each_set_bit(idx, fixed_cntr_mask, INTEL_PMC_MAX_FIXED) {
 		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
+		if (BIT_ULL(INTEL_PMC_IDX_FIXED + idx) & guest_owned_mask)
+			continue;
 		wrmsrq_safe(x86_pmu_fixed_ctr_addr(idx), 0ull);
 	}
 
@@ -3730,7 +3764,7 @@ static void intel_pmu_reset(void)
 	}
 
 	/* Reset LBRs and LBR freezing */
-	if (x86_pmu.lbr_nr) {
+	if (x86_pmu.lbr_nr && !(guest_owned_mask & GLOBAL_STATUS_LBRS_FROZEN)) {
 		update_debugctlmsr(get_debugctlmsr() &
 			~(DEBUGCTLMSR_FREEZE_LBRS_ON_PMI|DEBUGCTLMSR_LBR));
 	}
@@ -3944,11 +3978,22 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	bool late_ack = hybrid_bit(cpuc->pmu, late_ack);
 	bool mid_ack = hybrid_bit(cpuc->pmu, mid_ack);
+	u64 guest_owned_mask = 0;
 	int loops;
 	u64 status;
 	int handled;
 	int pmu_enabled;
 
+	/*
+	 * When PMU partitioning is enabled, PMIs fired in non-root mode could
+	 * be either host- or guest-induced.
+	 *
+	 * The host won't clear guest-owned bits from IA32_PERF_GLOBAL_STATUS,
+	 * and leaves them for KVM to inject into the guest.
+	 */
+	if (x86_pmu_partition_nmi_active())
+		guest_owned_mask = x86_pmu_current_partition_mask();
+
 	/*
 	 * Save the PMU state.
 	 * It needs to be restored when leaving the handler.
@@ -3970,6 +4015,8 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	handled = intel_pmu_drain_bts_buffer();
 	handled += intel_bts_interrupt();
 	status = intel_pmu_get_status();
+	handled += hweight64(status & guest_owned_mask);
+	status &= ~guest_owned_mask;
 	if (!status)
 		goto done;
 
@@ -3995,6 +4042,13 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	 * Repeat if there is more work to be done:
 	 */
 	status = intel_pmu_get_status();
+
+	/*
+	 * Guest-owned bits were already counted into "handled" on the
+	 * initial read and are never acked, so no hweight64() is needed
+	 * here; just mask them out to avoid an infinite "goto again" loop.
+	 */
+	status &= ~guest_owned_mask;
 	if (status)
 		goto again;
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 29ea11421874..d9875f3e6c8c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -300,6 +300,12 @@ struct cpu_hw_events {
 	unsigned int		txn_flags;
 	int			is_fake;
 
+	/*
+	 * The PMU resources owned by the vCPU currently scheduled on this
+	 * CPU, which is a subset of x86_pmu.partition_mask.
+	 */
+	u64			partition_mask;
+
 	/*
 	 * Intel DebugStore bits
 	 */
@@ -1603,6 +1609,8 @@ static inline int is_pebs_pt(struct perf_event *event)
 }
 
 bool pmu_partition_configured(void);
+bool x86_pmu_partition_nmi_active(void);
+u64 x86_pmu_current_partition_mask(void);
 
 #ifdef CONFIG_CPU_SUP_INTEL
 
-- 
2.55.0

