Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A258D3D34B9;
	Fri, 21 Aug 2026 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351464; cv=none; b=R3KMlnAD8NaLVLOAFeuaYxuqjQTBiuOCwHKed7325mO9GfOYNzMLamJlFWojC7E9V1k5PAkL+yor6nquf3a30GJ80869cX5nOJkt7bNd7SMT5+u3fUpgGI7pLdQWPm9GGKNjLWNQYe4aeYJUs32sYVGYvu1s1xfoh+VXOqgAf38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351464; c=relaxed/simple;
	bh=ksPtYZC9RDBaE7edIfAKBUwwYQg0BNEA5l2JuczkKRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrbhWIORGILf25MnE8XYsWkeSzVDUO98FHskibFM0dHI1EkgTJr9/KfHpRlQ0OjoZPYSf0HBhtZ6lWE3Y0KVh/XK4OlUT3HEEUNX5sIrcewyLs/hVUS4QsdxS/G3knEd6hBOyDUFIPSgOjiBGXf+rNm11/wjoupSnmyrT+1UPOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=np0u0FVG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="np0u0FVG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351457; x=1818887457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ksPtYZC9RDBaE7edIfAKBUwwYQg0BNEA5l2JuczkKRE=;
  b=np0u0FVGtW2kwgUtglHbvOwY2IzOWdQ1SRRDu0PmlG20D30tDLHrsD7P
   AXWLEp7U0dYYN90gGJPe4o0NEEUBlLTZsE7ZQXeTEKdzK665HM73bU8Zn
   x9zfn4IEJ+O+lOEiWewWS3L3kyPso2aHJjcFMCxRjrvpK5dgzfc0TWY9D
   bNAGGidtgjzsclLO0IXjEaY1mniwrHjMkjo1jSw4WifynODxHtzp6tnUt
   AL8YVmFs17L5kI1K2oVa5cUmdnJ/1v6vXWNM+Ks/1FhJD+3/hCecoN6kv
   02liGq5oyCCktElpkMSXigeh40S/kTo7RqPLBN7gOo139h9h15rYGRYeP
   w==;
X-CSE-ConnectionGUID: yfiKe+9cRWW0+2MT5HkVJQ==
X-CSE-MsgGUID: ho/v9YKWRDa1vZqNl8HO4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032615"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032615"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:49 -0700
X-CSE-ConnectionGUID: /Kq1W5RETLS+Z87FOGEgdQ==
X-CSE-MsgGUID: pP3mPZOBQ9+2yBC0hif1Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679770"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:48 -0700
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
Subject: [PATCH 11/23] perf, perf/x86: Allow host !exclude_guest events in PMU partitioning
Date: Fri, 21 Aug 2026 15:19:50 -0700
Message-ID: <20260821222002.54907-12-zide.chen@intel.com>
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

With PMU partitioning, the host is allowed to create !exclude_guest
events because it no longer yields all PMU resources to the guest
while the guest is running.

However, Perf Metrics, LBR, BTS, and PEBS cannot be shared between
host and guest. Host events that rely on these exclusive facilities
must not be scheduled in if the facilities are guest-owned.

Intel PT PMU is special: Since it can't be partitioned, supporting
Intel PT passthrough requires heterogeneous mediated vPMUs. Additional
work is needed to handle nr_include_guest_events accounting.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/core.c      | 35 ++++++++++++++++++++++++++++++-
 arch/x86/include/asm/perf_event.h |  1 +
 kernel/events/core.c              | 16 ++++++++++++--
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0f76e56fd2db..2928c8262fef 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4455,10 +4455,40 @@ dyn_constraint(struct cpu_hw_events *cpuc, struct event_constraint *c, int idx)
 	return c;
 }
 
+static bool event_uses_guest_owned_facility(struct perf_event *event)
+{
+	/*
+	 * For Intel platforms, PMU partition mask shares the same bit layout
+	 * as IA32_PERF_GLOBAL_STATUS.
+	 */
+	u64 partition_mask = x86_pmu_current_partition_mask();
+
+	if ((partition_mask & GLOBAL_STATUS_PERF_METRICS_OVF) &&
+	    is_topdown_event(event))
+		return true;
+
+	if ((partition_mask & GLOBAL_STATUS_LBRS_FROZEN) &&
+	    needs_branch_stack(event))
+		return true;
+
+	if (partition_mask &
+	    (GLOBAL_STATUS_BUFFER_OVF | GLOBAL_STATUS_ARCH_PEBS_THRESHOLD)) {
+		if (event->attr.precise_ip || is_pebs_counter_event_group(event))
+			return true;
+
+		if ((partition_mask & GLOBAL_STATUS_BUFFER_OVF) &&
+		    intel_pmu_has_bts(event))
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * Mask out guest-owned counters from a constraint when PMU partition has been
  * entered, so !exclude_guest host events are not scheduled onto them while
- * the CPU is in non-root mode.
+ * the CPU is in non-root mode. Reject the event when a guest is currently
+ * loaded and it needs a guest-owned exclusive facility.
  *
  * This is also used by PMU-specific get_event_constraints() wrappers
  * that hard-code a static, counter-specific constraint.
@@ -4475,6 +4505,9 @@ part_constraint(struct cpu_hw_events *cpuc, int idx,
 		return c;
 
 	if (x86_pmu_partition_loaded(cpuc)) {
+		if (event_uses_guest_owned_facility(event))
+			return &emptyconstraint;
+
 		c = dyn_constraint(cpuc, c, idx);
 		c->idxmsk64 &= ~x86_pmu_current_partition_mask();
 		c->weight = hweight64(c->idxmsk64);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 18f1ac5e008b..aaaa34062f8c 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -453,6 +453,7 @@ static inline bool is_topdown_idx(int idx)
 #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT	54
 #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD	BIT_ULL(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT)
 #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT	48
+#define GLOBAL_STATUS_PERF_METRICS_OVF		BIT_ULL(GLOBAL_STATUS_PERF_METRICS_OVF_BIT)
 
 #define GLOBAL_CTRL_EN_PERF_METRICS		BIT_ULL(48)
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c9e7a2f0edc8..1ae52a0ce234 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6381,11 +6381,23 @@ static int mediated_pmu_account_event(struct perf_event *event)
 	if (!is_include_guest_event(event))
 		return 0;
 
+	/*
+	 * This lockless fast path assumes that heterogeneous mediated vPMUs
+	 * are not supported, i.e. a mix of PERF_PMU_CAP_MEDIATED_VPMU PMUs
+	 * with and without PERF_PMU_CAP_PMU_PARTITION.
+	 */
 	if (atomic_inc_not_zero(&nr_include_guest_events))
 		return 0;
 
 	guard(mutex)(&perf_mediated_pmu_mutex);
-	if (atomic_read(&nr_mediated_pmu_vms))
+
+	/*
+	 * PMU partitioning allows scheduling !exclude_guest events while a
+	 * guest is running. However, it is up to the PMU driver to validate
+	 * whether the facilities needed by the event are available on the host.
+	 */
+	if (atomic_read(&nr_mediated_pmu_vms) &&
+	    !(event->pmu->capabilities & PERF_PMU_CAP_PMU_PARTITION))
 		return -EOPNOTSUPP;
 
 	atomic_inc(&nr_include_guest_events);
@@ -6418,7 +6430,7 @@ int perf_create_mediated_pmu(u64 partition_mask)
 	int ret;
 
 	guard(mutex)(&perf_mediated_pmu_mutex);
-	if (atomic_read(&nr_include_guest_events))
+	if (atomic_read(&nr_include_guest_events) && !partition_mask)
 		return -EBUSY;
 
 	ret = arch_perf_set_pmu_partition_mask(partition_mask);
-- 
2.55.0

