Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD1E377023;
	Fri, 21 Aug 2026 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351450; cv=none; b=ThmAS84ZqOLDX3WiXb5z3dHk1WgKTrorQDtMl5WPibFLA7ZkTlpS5I2kE+GGdDOFE+SRc7NQidK7X5Chnt1J3pL1NdYxX6Fm10+DiTXKgGbfMrVpF2gdI4/99FMUb2uoEgu+OEvO20pLIysu28tBRP3hXG9DeezHEJfPL9SJwug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351450; c=relaxed/simple;
	bh=GJlJniQ0Reto8D5v5MSYGurk8Mcw50akJYMXDVGQBX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olvWhbYoCktCtiXXaWdDEwzj13QLvZuqyh7A8G4XwUvhL3Bq2xy88vqIIqW7HAj9wVP7QOkavQTEkp64XSNKfu5fYp6JffgopFsMwOZjr4nRSKDvKjXsK8ajuM/4enlLW7nLXGoeSV4+YWZw0A5ex7FFkDM2HByZl7SoJI4/54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcYEpcrS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcYEpcrS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351446; x=1818887446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GJlJniQ0Reto8D5v5MSYGurk8Mcw50akJYMXDVGQBX0=;
  b=BcYEpcrSrSwJlRaYQMZX8a/qyWLk3JR3iC8lV4EnGoU2r3zyx5RwNGgX
   FETG+kP71vN1OdJg4GdX9wEQ+z5d57nYRu5g1XAx2sJLgNLrC4wcnOxaE
   gzG6VPGXln/UtvCSXK2g6mqcqxnD3/DhFX6GF+YuLFDFFq81fr9MQJJCx
   G4qw7gk0eIoII8OlYVgg0zmYVzRVuxSyH39L1azF0SQORr2nGSl6sZNi1
   BAwwGP+1GorFKiVHoGvVNW2hx4ie86izWv/ChdHjjPfrGT8VRcw0ENPbi
   uBbf6D6Z7NnygmtMClCevQNydMd3xzIXuQLvAs2iAaAb6xeq7ZKTCT7vU
   A==;
X-CSE-ConnectionGUID: c5iZe+7JTqa0J8MpCB5YTg==
X-CSE-MsgGUID: ZCQE///bRPact8EidDi5RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032569"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032569"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:45 -0700
X-CSE-ConnectionGUID: t59oE84JRuWDb97B9wfqhQ==
X-CSE-MsgGUID: pR+mZr7ATNSFEQMgjMNjcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679734"
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
Subject: [PATCH 03/23] perf/x86: Add GUEST_PMU states for PMU partitioning
Date: Fri, 21 Aug 2026 15:19:42 -0700
Message-ID: <20260821222002.54907-4-zide.chen@intel.com>
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

Currently, KVM loads a guest's mediated PMU context in a strict order:
perf_load_guest_context() runs first (it must execute in host context),
then PERF_GLOBAL_CTRL is cleared (to avoid spurious PMIs), then
perf_load_guest_lvtpc() switches the LVTPC hardware vector, and
finally the guest's PMCs are loaded.

Under PMU partitioning, host-owned counters remain available to host
events. When loading guest context, the perf scheduler must reschedule
host events off guest-owned counters.

Add GUEST_PMU_PARTITION_PRELOAD to represent the intermediate state in
which PMU partitioning constraints are needed for scheduling, but PMU
partition PMI handling is not yet active. Enter this state through the
new perf_pmu_partition_preload() helper.

Add GUEST_PMU_PARTITION_NMI for the state after the above _PRELOAD
state, i.e. the host context transition is complete and guest context
loading may proceed. LVTPC remains routed to NMI, and the PMU partition
mask can be applied in the PMI handler.

Add GUEST_PMU_MEDIATED to indicate that the LVTPC is set to the fixed
PERF_GUEST_MEDIATED_PMI_VECTOR, either in the PMU non-partitioned case,
or the partition setup where no host events are scheduled and no need
to share NMI with the host.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/core.c            | 94 ++++++++++++++++++++++++++++---
 arch/x86/events/perf_event.h      |  2 +
 arch/x86/include/asm/perf_event.h |  1 +
 arch/x86/kvm/pmu.c                |  2 +
 4 files changed, 91 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8032311c0a47..ba441f4d5f3e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -57,7 +57,38 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
 	.pmu = &pmu,
 };
 
-static DEFINE_PER_CPU(bool, guest_lvtpc_loaded);
+/*
+ * GUEST_PMU_NONE - No guest mediated PMU context is loaded.
+ *
+ * GUEST_PMU_MEDIATED - LVTPC is routed to the dedicated mediated PMI vector
+ *	instead of NMI, so any PMI in this state can only be guest-induced.
+ *	This covers both the non-partitioned mediated vPMU model and the PMU
+ *	partitioning case where the host currently has no events scheduled on
+ *	this CPU (see perf_load_guest_lvtpc()).
+ *
+ * GUEST_PMU_PARTITION_PRELOAD - Entering PMU partitioning guest mode, the host
+ *	context is still loaded. PMU partitioning constraints must be applied
+ *	so that host events can be rescheduled onto host-owned counters.
+ *
+ * GUEST_PMU_PARTITION_NMI - PMU partitioning is enabled, host event
+ *	rescheduling is complete, and the host currently has events scheduled
+ *	on this CPU, so LVTPC is routed to NMI and shared between host- and
+ *	guest-owned counters: a PMI in this state may be host- or
+ *	guest-induced.
+ *
+ * _PARTITION_PRELOAD and _PARTITION_NMI are distinct because PMU
+ * partitioning constraints must be visible to the scheduler before host
+ * events are rescheduled, while PMU partition masking can be applied to PMI
+ * handling only after the rescheduling completes.
+ */
+enum guest_pmu_mode {
+	GUEST_PMU_NONE,
+	GUEST_PMU_MEDIATED,
+	GUEST_PMU_PARTITION_PRELOAD,
+	GUEST_PMU_PARTITION_NMI,
+};
+
+static DEFINE_PER_CPU(enum guest_pmu_mode, guest_pmu_state);
 
 DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
 DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
@@ -1769,21 +1800,63 @@ void perf_events_lapic_init(void)
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 }
 
+bool pmu_partition_configured(void)
+{
+	return READ_ONCE(x86_pmu.partition_mask) != 0;
+}
+
 #ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
+/*
+ * Mark this CPU as running a PMU partitioned guest. Guest PMU partition
+ * constraints apply from this point, even if host PMU context remains loaded.
+ */
+void perf_pmu_partition_preload(void)
+{
+	if (pmu_partition_configured())
+		this_cpu_write(guest_pmu_state, GUEST_PMU_PARTITION_PRELOAD);
+}
+EXPORT_SYMBOL_FOR_KVM(perf_pmu_partition_preload);
+
 void perf_load_guest_lvtpc(u32 guest_lvtpc)
 {
-	u32 masked = guest_lvtpc & APIC_LVT_MASKED;
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	bool is_pmu_partitioned = pmu_partition_configured();
+	bool use_nmi;
 
-	apic_write(APIC_LVTPC,
-		   APIC_DM_FIXED | PERF_GUEST_MEDIATED_PMI_VECTOR | masked);
-	this_cpu_write(guest_lvtpc_loaded, true);
+	if (is_pmu_partitioned)
+		WARN_ON_ONCE(this_cpu_read(guest_pmu_state) !=
+			     GUEST_PMU_PARTITION_PRELOAD);
+
+	/*
+	 * If the host has events scheduled on this CPU, a PMI could be host-
+	 * or guest-induced, so share NMI with the guest. Otherwise, route
+	 * LVTPC to the dedicated mediated PMI vector for better
+	 * performance and simpler handling.
+	 */
+	use_nmi = is_pmu_partitioned && cpuc->n_events;
+	if (!use_nmi)
+		apic_write(APIC_LVTPC, APIC_DM_FIXED |
+			   PERF_GUEST_MEDIATED_PMI_VECTOR |
+			   (guest_lvtpc & APIC_LVT_MASKED));
+
+	this_cpu_write(guest_pmu_state,
+		       use_nmi ? GUEST_PMU_PARTITION_NMI : GUEST_PMU_MEDIATED);
 }
 EXPORT_SYMBOL_FOR_KVM(perf_load_guest_lvtpc);
 
 void perf_put_guest_lvtpc(void)
 {
-	this_cpu_write(guest_lvtpc_loaded, false);
-	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	enum guest_pmu_mode state = this_cpu_read(guest_pmu_state);
+
+	this_cpu_write(guest_pmu_state, GUEST_PMU_NONE);
+
+	/*
+	 * LVTPC needs restoring to NMI unless it's already routed there, i.e.
+	 * unless LVTPC was left routed to the dedicated mediated PMI vector
+	 * (see perf_load_guest_lvtpc()).
+	 */
+	if (state == GUEST_PMU_MEDIATED)
+		apic_write(APIC_LVTPC, APIC_DM_NMI);
 }
 EXPORT_SYMBOL_FOR_KVM(perf_put_guest_lvtpc);
 #endif /* CONFIG_PERF_GUEST_MEDIATED_PMU */
@@ -1802,8 +1875,13 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 	 * loaded will generate false positives and clobber guest state.  Note,
 	 * the LVTPC is switched to/from the dedicated mediated PMI IRQ vector
 	 * while host events are quiesced.
+	 *
+	 * GUEST_PMU_PARTITION_NMI is intentionally excluded here: LVTPC stays
+	 * routed to NMI in that state, and an NMI there can be host- or
+	 * guest-induced. GUEST_PMU_PARTITION_PRELOAD is likewise excluded, as
+	 * PMU is still loaded with host context.
 	 */
-	if (this_cpu_read(guest_lvtpc_loaded))
+	if (this_cpu_read(guest_pmu_state) == GUEST_PMU_MEDIATED)
 		return NMI_DONE;
 
 	/*
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 19beb16baa8e..29ea11421874 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1602,6 +1602,8 @@ static inline int is_pebs_pt(struct perf_event *event)
 	return !!(event->hw.flags & PERF_X86_EVENT_PEBS_VIA_PT);
 }
 
+bool pmu_partition_configured(void);
+
 #ifdef CONFIG_CPU_SUP_INTEL
 
 static inline bool intel_pmu_has_bts_period(struct perf_event *event, u64 period)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 17b0bc7dfce7..18f1ac5e008b 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -790,6 +790,7 @@ static inline void perf_check_microcode(void) { }
 #endif
 
 #ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
+extern void perf_pmu_partition_preload(void);
 extern void perf_load_guest_lvtpc(u32 guest_lvtpc);
 extern void perf_put_guest_lvtpc(void);
 #endif
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index b5a9fbd415d1..7f619a99a152 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1388,6 +1388,8 @@ void kvm_mediated_pmu_load(struct kvm_vcpu *vcpu)
 
 	lockdep_assert_irqs_disabled();
 
+	perf_pmu_partition_preload();
+
 	perf_load_guest_context();
 
 	/*
-- 
2.55.0

