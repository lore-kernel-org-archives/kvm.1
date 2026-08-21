Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537D38F64D;
	Fri, 21 Aug 2026 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351457; cv=none; b=lXyjaeEraDTimiJ2jfEbhOtiDve371icmn3TsCcO319dds6MhVxvsSQkHdRzgrEjzrNPJWp3NUVDQwkhG9NP2lT6AzI8nFu++uv6VYHsEnBvOZWLuBn4nxlpiMarbK2Tuth3Hf0Kxp8zzh9LArOgrmu8wH9XRbcHjl6rZlIGk6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351457; c=relaxed/simple;
	bh=LTa9pW7gxHW4AAkJXbjhLSTviVTnjlo+6Aj+z1Kv/n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojsGn4pgFYkQucU2TYX0BsAxLuQxM6mCUn08PBTAQqBmmhVeTxkFDLSmdEYDqOeGFi9rqfw25SgqMB/hyUe1nKPuBXgqImaTABVrLWxT/S5kiu4StyVI0859o8ykOXwvthVcrhOpR9KKk/7VAUh2hT+VHH0mP7M3a9H2Y7eM7RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVA5XfFo; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVA5XfFo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351452; x=1818887452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LTa9pW7gxHW4AAkJXbjhLSTviVTnjlo+6Aj+z1Kv/n8=;
  b=JVA5XfFo0S38KKYlOb9NNDTqIFjnlh1k8MdzfQEafYyEsjZA4wTKH9hW
   ooHqiEaiEy0BSRhsZmQDs2IXdl2tIeLEhJ7WsuJlxQ42JT1U3xJ2x2t73
   MHz/83BhqjA0B4b8lAshboZav57grDiWZ5/vK5hrldw7bSlAg5j2qZPj2
   6w6ILTvYyeTI57qzUv7n3GSRhZLxH0cp2m/Mn0HpasjPKzLNIAcVMjmBa
   th/4KjJTvzmN6LifF4KSmQU/9LbxC7FxOzocwnjDkqpyrCgmyRzocz/Q3
   GRXTB4X1sd/HnRZtMxCN8iezx4gK8GIIO01PN1m94iFlkDJ1kGpHjPDkR
   Q==;
X-CSE-ConnectionGUID: HUzEK5MwTE+5Q5+lPEy/bQ==
X-CSE-MsgGUID: yWlpocVJSOewaFF+khczKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032589"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032589"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:46 -0700
X-CSE-ConnectionGUID: BJbvC+99SwWy3WkYgOP4jA==
X-CSE-MsgGUID: 7gv25SLeRvGZQ4UA5wzoVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679747"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:46 -0700
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
	Xudong Hao <xudong.hao@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 06/23] perf/x86: Restrict !exclude_guest events to host-owned counters
Date: Fri, 21 Aug 2026 15:19:45 -0700
Message-ID: <20260821222002.54907-7-zide.chen@intel.com>
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

From: Kan Liang <kan.liang@linux.intel.com>

When PMU partitioning is enabled and a guest is running,
!exclude_guest events must be scheduled only on host-owned counters.

After guest exit, PMU partition constraints are no longer applied and
host events may use the full counter set.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/core.c | 45 +++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 894f98eb871a..7951accfcf2c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2814,6 +2814,13 @@ static void __intel_pmu_enable_all(int added, bool pmi)
 
 	if (!x86_pmu_partition_loaded(cpuc))
 	       intel_ctrl &= ~cpuc->intel_ctrl_guest_mask;
+	else if (pmi)
+		/*
+		 * Guest-owned bits are excluded here, not because of clobbering
+		 * global ctrl guest bits in non-root mode, but because guest
+		 * counter MSRs have not yet been saved by KVM in NMI context.
+		 */
+		intel_ctrl &= ~x86_pmu_current_partition_mask();
 
 	wrmsrq(MSR_CORE_PERF_GLOBAL_CTRL, intel_ctrl);
 
@@ -4448,6 +4455,31 @@ dyn_constraint(struct cpu_hw_events *cpuc, struct event_constraint *c, int idx)
 	return c;
 }
 
+/*
+ * Mask out guest-owned counters from a constraint when PMU partition has been
+ * entered, so !exclude_guest host events are not scheduled onto them while
+ * the CPU is in non-root mode.
+ */
+static struct event_constraint *
+part_constraint(struct cpu_hw_events *cpuc, int idx,
+		struct perf_event *event, struct event_constraint *c)
+{
+	/*
+	 * Skip &emptyconstraint: dyn_constraint() would clone it, breaking
+	 * the "c == &emptyconstraint" pointer checks callers rely on.
+	 */
+	if (!c->weight || c == &emptyconstraint)
+		return c;
+
+	if (x86_pmu_partition_loaded(cpuc)) {
+		c = dyn_constraint(cpuc, c, idx);
+		c->idxmsk64 &= ~x86_pmu_current_partition_mask();
+		c->weight = hweight64(c->idxmsk64);
+	}
+
+	return c;
+}
+
 static struct event_constraint *
 intel_get_excl_constraints(struct cpu_hw_events *cpuc, struct perf_event *event,
 			   int idx, struct event_constraint *c)
@@ -4569,8 +4601,14 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 		c2 = c1;
 	}
 
-	if (cpuc->excl_cntrs)
+	/*
+	 * No platform supports both PMU_FL_EXCL_CNTRS and PerfMon masking
+	 * simultaneously, so part_constraint() is not needed on this path.
+	 */
+	if (cpuc->excl_cntrs) {
+		WARN_ON_ONCE(x86_pmu_partition_loaded(cpuc));
 		return intel_get_excl_constraints(cpuc, event, idx, c2);
+	}
 
 	if (event->hw.dyn_constraint != ~0ULL) {
 		c2 = dyn_constraint(cpuc, c2, idx);
@@ -4578,7 +4616,7 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 		c2->weight = hweight64(c2->idxmsk64);
 	}
 
-	return c2;
+	return part_constraint(cpuc, idx, event, c2);
 }
 
 static void intel_put_excl_constraints(struct cpu_hw_events *cpuc,
@@ -5948,7 +5986,8 @@ int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 			goto err;
 	}
 
-	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA | PMU_FL_DYN_CONSTRAINT)) {
+	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA | PMU_FL_DYN_CONSTRAINT) ||
+	    (x86_get_pmu(cpu)->capabilities & PERF_PMU_CAP_MEDIATED_VPMU)) {
 		size_t sz = X86_PMC_IDX_MAX * sizeof(struct event_constraint);
 
 		cpuc->constraint_list = kzalloc_node(sz, GFP_KERNEL, cpu_to_node(cpu));
-- 
2.55.0

