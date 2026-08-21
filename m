Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC0B355F22;
	Fri, 21 Aug 2026 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351448; cv=none; b=oYjDx7+grFtw1qIvz1Qj8qYOt1rrob5e4E+cIo90cx8gHap0amD91XudiY/9J6FjtdioTuoK7WSp4mZL1KOjFiktyHj/bNQ8Gy3FtprsBjOhClr75fFSY5Myiv4tSZUfJAULd01eRHpyQ49jI/NW78Lshdtbj233B6bR0Br3hSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351448; c=relaxed/simple;
	bh=Esc98NV0oLjUbMK7ehSRwlbyJW/wPAEnrbb+hDJSJjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFvRhJ6/XRb3ioAz3rAoWy8DP/8+xdhy6bE4PRfMsaWVbiL5RwQLXeNDAgFeyC6kUbjQ9ZbnZaksGNG6MWLMtqiG3N+wP2lz3HsYDMDezFlIetY2djuOS0T5/qZS/CTddRP+zLqZ+KPO+1Hzifx8QJJq77iO+gqc3/7SADd+bQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vs7AbC+O; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vs7AbC+O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351446; x=1818887446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Esc98NV0oLjUbMK7ehSRwlbyJW/wPAEnrbb+hDJSJjs=;
  b=Vs7AbC+OnYE9/4Nn0smoKFTlJxNgxqIv2eJ3o/1P4RtSJwauX+ipbJG7
   zmRbOieVMKA8uZ+xo8fkgu6SDPAk/GqhMMg0oO1Grg9/1O7DgcANPunKB
   i196GbMab42QjIei5T6a+Lh2TViAG+OQpKVbDjgvFmzfNu8DKpBZ1WchV
   crm9mcOOKcn8c3FfjmoVPmBcvtVQfpORhbu9GOqUO4yHLnqgsQMpvOoJT
   Q5Kzo2O/bXasRgUA/ByEEdfgH/JRLPUS8r6rb55RwVCUjC+pk94ZE9ZMd
   LO2fi/sUW5VykFcGl9FGt+dd0kQ/kocLHWWCrfEuoIfsGiXdclZcNxxJF
   g==;
X-CSE-ConnectionGUID: /ccJa2ZmSbOmIokyZTe57w==
X-CSE-MsgGUID: /dC4cSY7Sr+YOI5HBUlRnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032563"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032563"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:44 -0700
X-CSE-ConnectionGUID: 8pgtyv9jSd6c+lmMtDpDAQ==
X-CSE-MsgGUID: Ut+46cQUTEeBHTjnh196fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679727"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:44 -0700
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
Subject: [PATCH 02/23] perf, perf/x86: Pass partition mask from KVM to perf/x86
Date: Fri, 21 Aug 2026 15:19:41 -0700
Message-ID: <20260821222002.54907-3-zide.chen@intel.com>
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

x86 PMU partitioning support requires mediated vPMU and is supported
only on Intel platforms. KVM is responsible for determining if PMU
partitioning can be enabled, and if so, it passes the mask to perf
core when creating a mediated PMU VM. The mask is host-wide state
shared by all mediated PMU guests.

Perf core passes the mask down to perf/x86 via the new callback
arch_perf_set_pmu_partition_mask(), which sanitizes it before applying
it to the newly added x86_pmu. The mask is cleared when the last
mediated PMU VM is released.

Note: PMU partitioning technically allows the host to run certain
!exclude_guest events while partitioned guests are running, as long as
such events don't use exclusive resources reserved for the guests. The
current behavior is kept: reject the creation of a partitioned guest
as long as any !exclude_guest host events exist.

Introduce PERF_PMU_CAP_PMU_PARTITION to indicate that the pmu supports
PMU partitioning. Note that virtualization of Intel PT and BTS is
currently unsupported; even if it were, this flag would not apply to
those PMUs, since their exclusive resources can't be shared between
host and guest, and their events are not subject to PMU partitioning
scheduling.

perf_create_mediated_pmu() is called with 0 for now; this will be
replaced with the actual partition_mask in a later patch.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/core.c       | 58 ++++++++++++++++++++++++++++++++++++
 arch/x86/events/perf_event.h |  9 ++++++
 arch/x86/kvm/x86.c           |  2 +-
 include/linux/perf_event.h   |  4 ++-
 kernel/events/core.c         | 19 +++++++++---
 5 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9b6df8bc9059..8032311c0a47 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2773,6 +2773,64 @@ static bool x86_pmu_filter(struct pmu *pmu, int cpu)
 	return ret;
 }
 
+/**
+ * arch_perf_set_pmu_partition_mask - Validate and set the VM-owned counter
+ *				      mask for mediated vPMU
+ * @partition_mask: Bitmask of PMU counters or other hardware resources
+ *		to hand over to mediated vPMU guests. 0 disables PMU
+ *		partitioning, as in the legacy model.
+ *
+ * Called via perf_create_mediated_pmu() to validate @partition_mask and,
+ * if valid, record it in x86_pmu.partition_mask for use by the
+ * scheduler, and set PERF_PMU_CAP_PMU_PARTITION on the generic PMU so
+ * perf core can check it without reaching into x86-private state.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int arch_perf_set_pmu_partition_mask(u64 partition_mask)
+{
+	u64 current_mask = READ_ONCE(x86_pmu.partition_mask);
+	struct pmu *pmu;
+
+	/* Non-paritioned mediated guests fall into this case. */
+	if (current_mask == partition_mask)
+		return 0;
+
+	/*
+	 * AMD does not yet implement the hardware support for PMU partitioning
+	 * between host and guest. Thus limit it to Intel platforms with the
+	 * PerfMon masking VMX extension. Leave it to KVM to check the VMX
+	 * feature. KVM doesn't support vPMU on Hybrid CPUs at all.
+	 */
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL || is_hybrid())
+		return -EOPNOTSUPP;
+
+	pmu = x86_get_pmu(raw_smp_processor_id());
+	if (!(pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU))
+		return -EOPNOTSUPP;
+
+	/*
+	 * If a mediated-PMU VM was already created, the configured mask
+	 * cannot be changed.
+	 */
+	if (current_mask && partition_mask)
+		return -EINVAL;
+
+	/*
+	 * perf/core guarantees that this path is reached only after all
+	 * partitioned guests have been released.
+	 */
+	if (!partition_mask) {
+		WRITE_ONCE(x86_pmu.partition_mask, 0);
+		pmu->capabilities &= ~PERF_PMU_CAP_PMU_PARTITION;
+		return 0;
+	}
+
+	WRITE_ONCE(x86_pmu.partition_mask, partition_mask);
+	pmu->capabilities |= PERF_PMU_CAP_PMU_PARTITION;
+	return 0;
+}
+
 static struct pmu pmu = {
 	.pmu_enable		= x86_pmu_enable,
 	.pmu_disable		= x86_pmu_disable,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index eae24bb35dc1..19beb16baa8e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -883,6 +883,15 @@ struct x86_pmu {
 	int		events_mask_len;
 	int		apic;
 	u64		max_period;
+
+	/*
+	 * Bitmask of PMU resources that may be assigned to a guest.
+	 *
+	 * The mask is set when the first mediated vPMU is created and is
+	 * cleared when the last mediated vPMU is torn down.
+	 */
+	u64		partition_mask;
+
 	struct event_constraint *
 			(*get_event_constraints)(struct cpu_hw_events *cpuc,
 						 int idx,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d349224d2734..5f3215915c76 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9328,7 +9328,7 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 	if (enable_mediated_pmu && kvm->arch.enable_pmu &&
 	    !kvm->arch.created_mediated_pmu) {
 		if (irqchip_in_kernel(kvm)) {
-			r = perf_create_mediated_pmu();
+			r = perf_create_mediated_pmu(0);
 			if (r) {
 				pr_warn_ratelimited(PERF_MEDIATED_PMU_MSG);
 				return r;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea..bd952e09055d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -306,6 +306,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_AUX_PAUSE		0x0200
 #define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400
 #define PERF_PMU_CAP_MEDIATED_VPMU	0x0800
+#define PERF_PMU_CAP_PMU_PARTITION	0x1000
 
 /**
  * pmu::scope
@@ -1931,10 +1932,11 @@ extern int perf_event_period(struct perf_event *event, u64 value);
 extern u64 perf_event_pause(struct perf_event *event, bool reset);
 
 #ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
-int perf_create_mediated_pmu(void);
+int perf_create_mediated_pmu(u64 pmu_partition_mask);
 void perf_release_mediated_pmu(void);
 void perf_load_guest_context(void);
 void perf_put_guest_context(void);
+int arch_perf_set_pmu_partition_mask(u64 pmu_partition_mask);
 #endif
 
 #else /* !CONFIG_PERF_EVENTS: */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d7f3e2c2ecb1..9ce27cd83e04 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6340,6 +6340,11 @@ static atomic_t nr_include_guest_events __read_mostly;
 static atomic_t nr_mediated_pmu_vms __read_mostly;
 static DEFINE_MUTEX(perf_mediated_pmu_mutex);
 
+int __weak arch_perf_set_pmu_partition_mask(u64 partition_mask)
+{
+	return partition_mask ? -EOPNOTSUPP : 0;
+}
+
 /* !exclude_guest event of PMU with PERF_PMU_CAP_MEDIATED_VPMU */
 static inline bool is_include_guest_event(struct perf_event *event)
 {
@@ -6387,15 +6392,18 @@ static void mediated_pmu_unaccount_event(struct perf_event *event)
  * No impact for the PMU without PERF_PMU_CAP_MEDIATED_VPMU. The perf
  * still owns all the PMU resources.
  */
-int perf_create_mediated_pmu(void)
+int perf_create_mediated_pmu(u64 partition_mask)
 {
-	if (atomic_inc_not_zero(&nr_mediated_pmu_vms))
-		return 0;
+	int ret;
 
 	guard(mutex)(&perf_mediated_pmu_mutex);
 	if (atomic_read(&nr_include_guest_events))
 		return -EBUSY;
 
+	ret = arch_perf_set_pmu_partition_mask(partition_mask);
+	if (ret)
+		return ret;
+
 	atomic_inc(&nr_mediated_pmu_vms);
 	return 0;
 }
@@ -6403,10 +6411,13 @@ EXPORT_SYMBOL_FOR_KVM(perf_create_mediated_pmu);
 
 void perf_release_mediated_pmu(void)
 {
+	guard(mutex)(&perf_mediated_pmu_mutex);
+
 	if (WARN_ON_ONCE(!atomic_read(&nr_mediated_pmu_vms)))
 		return;
 
-	atomic_dec(&nr_mediated_pmu_vms);
+	if (atomic_dec_and_test(&nr_mediated_pmu_vms))
+		arch_perf_set_pmu_partition_mask(0);
 }
 EXPORT_SYMBOL_FOR_KVM(perf_release_mediated_pmu);
 
-- 
2.55.0

