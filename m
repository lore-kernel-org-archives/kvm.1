Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3574330DEA2;
	Wed,  6 May 2026 01:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032687; cv=none; b=U4Lqxw6FvnSQWHTGmnGXzRFHeMTyyUHCok9kMKEn9Qa6JEL7ulWuiUT2fx75LMTFcEsu3JWNIxPkR0gH5e/iDVNpj7GtbkUJK7XQoH5RVRVqJp01tZzAX2iHWNIRjDRdkViCRCaMTMe5JOF8QnnTvUt3IKc0Afe4jDCMxQxGwrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032687; c=relaxed/simple;
	bh=T3cgRqVEVIuSXwcmUq5FZZ2VswWbqrXzW+LAsRgQ7pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3qe5zOSf0Gzq7aDtdmpXzg1yS0S3eZIpVkJopL8QIpbq2HRQnAWU0LaPXWUPvqVRxeGb0KiJKvuxSEX14wm85emw8eusfwrEkl0bnoIU2srSlWwAwYF4jM+WrkHGd6UYfzA1cYsj0Qc3v9KuAB8H12nTf95ZxajHKib97fMUoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ijtc6V39; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ijtc6V39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559B2C2BCB4;
	Wed,  6 May 2026 01:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032686;
	bh=T3cgRqVEVIuSXwcmUq5FZZ2VswWbqrXzW+LAsRgQ7pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ijtc6V3903ES1BMxpwMWUHiMkCGaawbhqAHr/ZilBegEx+1391fa2LIapyUXcHqf6
	 6fOhwGXLzaWT/gdr/CBiCCL6lygvphZgPOooZ8zv924OhZQBKL61IUcUvY3vAO6RXp
	 RuPA9LxRoC/0xtrND9ty+0OVCvL56XoA+wm4JA4IJIOqC8w5SvdyZFASS1N5sWKyhy
	 xT8JVxcOPP4h6+bNr+N1DTVGkcZdg9inhKIzKlKRAj4rqeJfvdJ74szN3R6GBI/qKT
	 JE3PKaoGulL31kQJWeS6yLWdk8k4ABayLAGhmQSNk3u9idM553v7PX1y1aKV/60sIp
	 tD9mpnjp+CSLA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v6 11/16] KVM: x86/pmu: Reprogram Host/Guest-Only counters on nested transitions
Date: Wed,  6 May 2026 01:57:27 +0000
Message-ID: <20260506015733.1671124-12-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260506015733.1671124-1-yosry@kernel.org>
References: <20260506015733.1671124-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reprogram PMU counters on nested transitions for the mediated PMU, to
re-evaluate Host-Only and Guest-Only bits and enable/disable the PMU
counters accordingly. For example, if Host-Only is set and Guest-Only is
cleared, a counter should be disabled when entering guest mode and
enabled when exiting guest mode.

According to the APM, when EFER.SVME is cleared, setting Host-Only or
Guest-Only disables the counter, so also trigger counter reprogramming
when EFER.SVME is toggled.

Counters setting any of Host-Only and Guest-Only bits are already being
tracked in pmc_has_mode_specific_enables, use the bitmap to reprogram
these counters.

Reprogram the counters synchronously on nested VMRUN/#VMEXIT and
EFER.SVME toggling. This is necessary as these instructions are counted
based on the new CPU state (after the instruction is retired in
hardware).  Hence, the PMU needs to be updated before instruction
emulation is completed and kvm_pmu_instruction_retired() is called.

Defer reprogramming the counters when force leaving guest mode through
svm_leave_nested() to avoid potentially reading stale state (e.g.
incorrect EFER). All flows force leaving nested are not architectural,
so precision is not a priority.

Refactor a helper out of kvm_pmu_request_reprogram_counters() that
accepts a boolean allowing synchronous vs deferred reprogramming, and
use that from SVM code to support both scenarios.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.c        |  1 +
 arch/x86/kvm/pmu.h        | 18 ++++++++++++++----
 arch/x86/kvm/svm/nested.c | 12 ++++++++++++
 arch/x86/kvm/svm/svm.c    |  1 +
 arch/x86/kvm/svm/svm.h    | 22 ++++++++++++++++++++++
 5 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 84c834ad2cd47..b92dd2e583356 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -685,6 +685,7 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 	kvm_for_each_pmc(pmu, pmc, bit, bitmap)
 		kvm_pmu_recalc_pmc_emulation(pmu, pmc);
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_pmu_handle_event);
 
 int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx)
 {
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 34c3c6913ef62..a5821d7c87f93 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -216,6 +216,7 @@ extern struct x86_pmu_capability kvm_pmu_cap;
 void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops);
 
 void kvm_pmu_recalc_pmc_emulation(struct kvm_pmu *pmu, struct kvm_pmc *pmc);
+void kvm_pmu_handle_event(struct kvm_vcpu *vcpu);
 
 static inline void kvm_pmu_request_counter_reprogram(struct kvm_pmc *pmc)
 {
@@ -225,14 +226,24 @@ static inline void kvm_pmu_request_counter_reprogram(struct kvm_pmc *pmc)
 	kvm_make_request(KVM_REQ_PMU, pmc->vcpu);
 }
 
-static inline void kvm_pmu_request_counters_reprogram(struct kvm_pmu *pmu,
-						      u64 counters)
+static inline void __kvm_pmu_reprogram_counters(struct kvm_pmu *pmu,
+						u64 counters,
+						bool defer)
 {
 	if (!counters)
 		return;
 
 	atomic64_or(counters, &pmu->__reprogram_pmi);
-	kvm_make_request(KVM_REQ_PMU, pmu_to_vcpu(pmu));
+	if (defer)
+		kvm_make_request(KVM_REQ_PMU, pmu_to_vcpu(pmu));
+	else
+		kvm_pmu_handle_event(pmu_to_vcpu(pmu));
+}
+
+static inline void kvm_pmu_request_counters_reprogram(struct kvm_pmu *pmu,
+						      u64 counters)
+{
+	__kvm_pmu_reprogram_counters(pmu, counters, true);
 }
 
 /*
@@ -261,7 +272,6 @@ static inline bool kvm_pmu_is_fastpath_emulation_allowed(struct kvm_vcpu *vcpu)
 }
 
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
-void kvm_pmu_handle_event(struct kvm_vcpu *vcpu);
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
 int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx);
 bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 58c78c889a812..bb3362c043395 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -826,6 +826,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 
 	/* Enter Guest-Mode */
 	enter_guest_mode(vcpu);
+	svm_pmu_handle_nested_transition(svm);
 
 	/*
 	 * Filled at exit: exit_code, exit_info_1, exit_info_2, exit_int_info,
@@ -1302,6 +1303,8 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 
 	/* Exit Guest-Mode */
 	leave_guest_mode(vcpu);
+	svm_pmu_handle_nested_transition(svm);
+
 	svm->nested.vmcb12_gpa = 0;
 
 	kvm_warn_on_nested_run_pending(vcpu);
@@ -1519,6 +1522,15 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 
 		leave_guest_mode(vcpu);
 
+		/*
+		 * Force leaving nested is a non-architectural flow so precision
+		 * is not a priority. Defer updating the PMU until the next vCPU
+		 * run, potentially tolerating some imprecision to avoid poking
+		 * into PMU state from arbitrary contexts (e.g.  KVM may end up
+		 * using stale state).
+		 */
+		__svm_pmu_handle_nested_transition(svm, true);
+
 		svm_switch_vmcb(svm, &svm->vmcb01);
 
 		nested_svm_uninit_mmu_context(vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e7fdd7a9c280d..7d3a142e63ff8 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -261,6 +261,7 @@ int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 				set_exception_intercept(svm, GP_VECTOR);
 		}
 
+		svm_pmu_handle_nested_transition(svm);
 		kvm_make_request(KVM_REQ_RECALC_INTERCEPTS, vcpu);
 	}
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index a10668d17a16a..71a49af941f4e 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -24,6 +24,7 @@
 
 #include "cpuid.h"
 #include "kvm_cache_regs.h"
+#include "pmu.h"
 
 /*
  * Helpers to convert to/from physical addresses for pages whose address is
@@ -877,6 +878,27 @@ void nested_sync_control_from_vmcb02(struct vcpu_svm *svm);
 void nested_vmcb02_compute_g_pat(struct vcpu_svm *svm);
 void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb);
 
+
+static inline void __svm_pmu_handle_nested_transition(struct vcpu_svm *svm, bool defer)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(&svm->vcpu);
+	u64 counters = *(u64 *)pmu->pmc_has_mode_specific_enables;
+
+	__kvm_pmu_reprogram_counters(pmu, counters, defer);
+}
+
+static inline void svm_pmu_handle_nested_transition(struct vcpu_svm *svm)
+{
+	/*
+	 * Do NOT defer reprogramming the counters by default.  Instructions
+	 * causing a state change are counted based on the _new_ CPU state
+	 * (e.g. a successful VMRUN is counted in guest mode). Hence, the
+	 * counters should be reprogrammed with the new state _before_ the
+	 * instruction is potentially counted upon emulation completion.
+	 */
+	__svm_pmu_handle_nested_transition(svm, false);
+}
+
 extern struct kvm_x86_nested_ops svm_nested_ops;
 
 /* avic.c */
-- 
2.54.0.545.g6539524ca2-goog

