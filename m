Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24F73D3324;
	Fri, 21 Aug 2026 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351464; cv=none; b=PHITpjgBfvlp6b8ZZm5GAEsbmXSHtD9eVLiDEgr0/8z+1VzOCT/asepGavImgtPAvcgsMSaZBSWJp0ziUTCXckz9HqmoZmOw5ViPok8A/Yv/r/h8WplALkqV/hLzW20l7344XV9N/XtrlilQvHm7jw1NyqZMlDZ0uDkzffD6y2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351464; c=relaxed/simple;
	bh=g1+N+H7xYlbFzwMh2grcA0qO5wUDekwUFo6QTH3dUVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVOp2MlragU8XRJ5Pg/AxwkmzEfncxQjFscA+0QVMCFX6IN07TpjEknHN0zzLdheUpqHY+DgdNe0o1jp11iRvYFhPZMC6KO4x9upEvpjN40Qp2Of7APP6hwBz/W7eLN+5guE+mLQkbGgvskECuczcn5E4M7ZgejeudOLKvoP5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhiygJld; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhiygJld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351457; x=1818887457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g1+N+H7xYlbFzwMh2grcA0qO5wUDekwUFo6QTH3dUVo=;
  b=QhiygJldVWi8IJwaJIUyqs5QddASl0E+fw80/ldZ2GqbBVpG+fDUwuBE
   wycXAtelpCvs1ZTnqK6BTHqq9CVG2QHzYeymXprfGGwYaHuV7rHcvvIsT
   vLEHTCDXUOzc9ZWOTnnzuI7fPX7qwE5m10Z97XtoYjQiStvdHUpCZzYmz
   TuhsXGuiCZJ9jZBJiTx+UW4Mp26FexLu1j9i59U85Y8NphzP2YOcqx0Ao
   VMUL0y63pJTez4+nTNoEnsal74FGqDeKmrVVgU0UhY7BGHldKspqHW0S5
   /2es5Ej5sm+98UlGPhid45JDycZI98CFOVPCBI2drhkId1swfChmkCDos
   Q==;
X-CSE-ConnectionGUID: SuKFefixSNOyvucvk/YgDQ==
X-CSE-MsgGUID: KUfPzSttT+K7fBvuPPhssQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032610"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032610"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:48 -0700
X-CSE-ConnectionGUID: HE+B1bhsQ2SESZFhjGRLkg==
X-CSE-MsgGUID: k9wq6skmT/KXgKuTY87Vtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679766"
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
	Xudong Hao <xudong.hao@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 10/23] perf: Reschedule events across PMU partition transitions
Date: Fri, 21 Aug 2026 15:19:49 -0700
Message-ID: <20260821222002.54907-11-zide.chen@intel.com>
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

When entering a guest with PMU partitioning enabled, some counters
remain available to the host. Similar to the non-partitioning setup,
schedule out all events because a counter may become guest-owned.

Unlike the non-partitioned case, host events must then be rescheduled
so that !exclude_guest events can be scheduled onto the remaining
host-owned counters, while keeping exclude_guest events off. Since
PMU partitioning shrinks the counters available to host events, add a
lightweight PMU-context reschedule cpuctx_sched_in_all() instead of
rebuilding the entire CPU perf scheduling state.

When exiting the guest, schedule out host events so that they can be
rescheduled against the expanded set of host-owned counters. Similar to
guest entry, only PMU-level event placement needs to be rebuilt, so add
ctx_sched_out_all() instead of using the existing full CPU-context
scheduling API.

These context switches rely on the architectural PMU partition mask
being configured for the target context. On guest entry, the guest
PMU partition mask is expected to be active before events are
rescheduled. On guest exit, it is expected to be disabled so that
events are rescheduled with host counter constraints.

This differs from the perf core guest context, where guest_ctx_loaded
is updated at the end of the load/put guest context. As a result,
guest_ctx_loaded does not yet reflect the target context when the
rescheduling occurs.

Add pmu_partition_enabled to perf_{load,put}_guest_context(), and
hardcode to false temporarily until later patches.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/kvm/pmu.c         |  4 +--
 include/linux/perf_event.h |  4 +--
 kernel/events/core.c       | 52 +++++++++++++++++++++++++++++++++++---
 3 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 7f619a99a152..c022337d0bec 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1390,7 +1390,7 @@ void kvm_mediated_pmu_load(struct kvm_vcpu *vcpu)
 
 	perf_pmu_partition_preload();
 
-	perf_load_guest_context();
+	perf_load_guest_context(false);
 
 	/*
 	 * Explicitly clear PERF_GLOBAL_CTRL, as "loading" the guest's context
@@ -1463,5 +1463,5 @@ void kvm_mediated_pmu_put(struct kvm_vcpu *vcpu)
 
 	perf_put_guest_lvtpc();
 
-	perf_put_guest_context();
+	perf_put_guest_context(false);
 }
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index bd952e09055d..9f66a4c49256 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1934,8 +1934,8 @@ extern u64 perf_event_pause(struct perf_event *event, bool reset);
 #ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
 int perf_create_mediated_pmu(u64 pmu_partition_mask);
 void perf_release_mediated_pmu(void);
-void perf_load_guest_context(void);
-void perf_put_guest_context(void);
+void perf_load_guest_context(bool pmu_partition_enabled);
+void perf_put_guest_context(bool pmu_partition_enabled);
 int arch_perf_set_pmu_partition_mask(u64 pmu_partition_mask);
 #endif
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 23375f8d2261..c9e7a2f0edc8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6442,8 +6442,25 @@ void perf_release_mediated_pmu(void)
 }
 EXPORT_SYMBOL_FOR_KVM(perf_release_mediated_pmu);
 
-/* When loading a guest's mediated PMU, schedule out all exclude_guest events. */
-void perf_load_guest_context(void)
+static void cpuctx_sched_in_all(struct perf_cpu_context *cpuctx,
+				enum event_type_t type)
+{
+	struct perf_event_pmu_context *pmu_ctx;
+
+	for_each_epc(pmu_ctx, &cpuctx->ctx, NULL, EVENT_GUEST)
+		__pmu_ctx_sched_in(pmu_ctx, type | EVENT_GUEST);
+
+	if (cpuctx->task_ctx) {
+		for_each_epc(pmu_ctx, cpuctx->task_ctx, NULL, EVENT_GUEST)
+			__pmu_ctx_sched_in(pmu_ctx, type | EVENT_GUEST);
+	}
+}
+
+/*
+ * When loading a guest's mediated PMU, schedule out all exclude_guest events.
+ * In PMU partitioning, reschedule host events onto host-owned counters.
+ */
+void perf_load_guest_context(bool pmu_partition_enabled)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 
@@ -6461,6 +6478,12 @@ void perf_load_guest_context(void)
 		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
 	}
 
+	/* Reschedule !exclude_guest events onto host-owned counters. */
+	if (pmu_partition_enabled) {
+		cpuctx_sched_in_all(cpuctx, EVENT_PINNED);
+		cpuctx_sched_in_all(cpuctx, EVENT_FLEXIBLE);
+	}
+
 	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
 	if (cpuctx->task_ctx)
 		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
@@ -6469,7 +6492,21 @@ void perf_load_guest_context(void)
 }
 EXPORT_SYMBOL_GPL(perf_load_guest_context);
 
-void perf_put_guest_context(void)
+static void ctx_sched_out_all(struct perf_event_context *ctx)
+{
+	struct perf_event_pmu_context *pmu_ctx;
+
+	if (!ctx)
+		return;
+
+	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
+		if (perf_skip_pmu_ctx(pmu_ctx, EVENT_GUEST))
+			continue;
+		__pmu_ctx_sched_out(pmu_ctx, EVENT_ALL);
+	}
+}
+
+void perf_put_guest_context(bool pmu_partition_enabled)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 
@@ -6484,6 +6521,15 @@ void perf_put_guest_context(void)
 	if (cpuctx->task_ctx)
 		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
 
+	if (pmu_partition_enabled) {
+		ctx_time_update(cpuctx, &cpuctx->ctx);
+		if (cpuctx->task_ctx)
+			ctx_time_update(cpuctx, cpuctx->task_ctx);
+
+		ctx_sched_out_all(&cpuctx->ctx);
+		ctx_sched_out_all(cpuctx->task_ctx);
+	}
+
 	perf_event_sched_in(cpuctx, cpuctx->task_ctx, NULL, EVENT_GUEST);
 
 	if (cpuctx->task_ctx)
-- 
2.55.0

