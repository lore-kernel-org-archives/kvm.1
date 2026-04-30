Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD173BED0E;
	Thu, 30 Apr 2026 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580884; cv=none; b=mUkbrsqpr+8INpPqLF/sMRiEFSEkqWftgaGZhUcxg2uo6s+dNmQpaVML6pGuNdn94ltR4/cc/oMpWarVVYYBimQxB+3ZuObqQHCtPvzMxRlO0KGCrS8+WRO9f2ZDNrPV+XJjwOwi0LcJTF9VVcZTayn7AF61OvYOcmT3eXg/+2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580884; c=relaxed/simple;
	bh=VNq/Aaa//rHBsfwCQhNNDA7ShO/zdr10J95GBlgmZ68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMg4MdkFz2B/9XG7jkI5h6x3YvlbrQXxYaEwAbeGSlCiZzK4qM5HXCfClsJZHcuzZxJmuJqi9C64y6b4mvq3hDSdN2+LAhbMzgP5eEY89rCSJqqSUrnbWO0b3lTC9x4nH80O/gLhkR/Pzty5SYKZ2dpQ4wpi8VsYm4cifViJX9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei47/nO6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ei47/nO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71FBC2BCC6;
	Thu, 30 Apr 2026 20:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777580884;
	bh=VNq/Aaa//rHBsfwCQhNNDA7ShO/zdr10J95GBlgmZ68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ei47/nO62ZUS+5xSgAe2mmRtnN+OlzEdHOtDX+zYN7amfldvOYTTzzzW9R6gUt6/I
	 1tiC4UdRqjpwQhJLuAfp9Bdvx1zaPHejwfVZMl5wKUVi3sxa9dDD8lafABEdI/kSlh
	 VGPBrlJUr66LW1qhxBEERbKOfwE4Rcet/9Bxo+0m2wvuxvga4+7MIouu8PvRoNhHhW
	 VDV7KwxPx5Vc5Ptu6Co6pc1l1v/81PrpZZ4S9jgBbtlqnYQ7lHVMR4GTC7N4yfznOr
	 i0ipGnqu4dE/Y5LIxBLymUFkvpR8zMXh8gdH8B8/6fjOloQuYDhaqRf3jQ+xFmbPxy
	 o6VDBsRpx60iw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v5 08/13] KVM: x86/pmu: Reprogram Host/Guest-Only counters on nested transitions
Date: Thu, 30 Apr 2026 20:27:45 +0000
Message-ID: <20260430202750.3924147-9-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260430202750.3924147-1-yosry@kernel.org>
References: <20260430202750.3924147-1-yosry@kernel.org>
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

Track counters with any of Host-Only and Guest-Only set as counters
requiring reprogramming on nested transitions in a bitmap. Track such
counters even if EFER.SVME is cleared as counters with Host-Only or
Guest-Only bits set need to be reprogrammed on EFER.SVME toggling.

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
 arch/x86/kvm/svm/pmu.c    | 12 +++++++++---
 arch/x86/kvm/svm/svm.c    |  2 ++
 arch/x86/kvm/svm/svm.h    | 33 +++++++++++++++++++++++++++++++++
 6 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 5e3a10e0a54ff..7b2b4ce6bdad9 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -684,6 +684,7 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 	kvm_for_each_pmc(pmu, pmc, bit, bitmap)
 		kvm_pmu_recalc_pmc_emulation(pmu, pmc);
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_pmu_handle_event);
 
 int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx)
 {
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 0c372b9f8ed34..4a9148cf779df 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -202,6 +202,7 @@ extern struct x86_pmu_capability kvm_pmu_cap;
 void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops);
 
 void kvm_pmu_recalc_pmc_emulation(struct kvm_pmu *pmu, struct kvm_pmc *pmc);
+void kvm_pmu_handle_event(struct kvm_vcpu *vcpu);
 
 static inline void kvm_pmu_request_counter_reprogram(struct kvm_pmc *pmc)
 {
@@ -211,14 +212,24 @@ static inline void kvm_pmu_request_counter_reprogram(struct kvm_pmc *pmc)
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
@@ -247,7 +258,6 @@ static inline bool kvm_pmu_is_fastpath_emulation_allowed(struct kvm_vcpu *vcpu)
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
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index fe6f2bb79ab83..902d7eb4a461b 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -263,20 +263,26 @@ static void amd_mediated_pmu_put(struct kvm_vcpu *vcpu)
 static void amd_mediated_pmu_handle_host_guest_bits(struct kvm_vcpu *vcpu,
 						    struct kvm_pmc *pmc)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
 	u64 host_guest_bits;
 
 	if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
 		return;
 
-	/* Count all events if both bits are cleared */
+	/*
+	 * If both bits are cleared, always keep the counter enabled. Otherwise,
+	 * counter enablement needs to be re-evaluated on every nested
+	 * transition (and EFER.SVME change).
+	 */
 	host_guest_bits = pmc->eventsel & AMD64_EVENTSEL_HOST_GUEST_MASK;
 	if (!host_guest_bits)
 		return;
+	__set_bit(pmc->idx, svm->nested.reprogram_pmcs_on_nested_transitions);
 
 	/*
-	 * If EFER.SVME is set, the counter is disabledd if only one of the bits
+	 * If EFER.SVME is set, the counter is disabled if only one of the bits
 	 * is set and it doesn't match the vCPU context. If EFER.SVME is
-	 * cleared, the counter is disable if any of the bits is set.
+	 * cleared, the counter is disabled if any of the bits is set.
 	 */
 	if (vcpu->arch.efer & EFER_SVME) {
 		if (host_guest_bits == AMD64_EVENTSEL_HOST_GUEST_MASK)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e7fdd7a9c280d..7ffa3c9033d0f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -261,6 +261,7 @@ int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 				set_exception_intercept(svm, GP_VECTOR);
 		}
 
+		svm_pmu_handle_nested_transition(svm);
 		kvm_make_request(KVM_REQ_RECALC_INTERCEPTS, vcpu);
 	}
 
@@ -1214,6 +1215,7 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 
 	svm->nested.vmcb12_gpa = INVALID_GPA;
 	svm->nested.last_vmcb12_gpa = INVALID_GPA;
+	bitmap_zero(svm->nested.reprogram_pmcs_on_nested_transitions, X86_PMC_IDX_MAX);
 
 	if (!kvm_pause_in_guest(vcpu->kvm)) {
 		control->pause_filter_count = pause_filter_count;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index a10668d17a16a..8709e87621d21 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -24,6 +24,7 @@
 
 #include "cpuid.h"
 #include "kvm_cache_regs.h"
+#include "pmu.h"
 
 /*
  * Helpers to convert to/from physical addresses for pages whose address is
@@ -238,6 +239,13 @@ struct svm_nested_state {
 	 * on its side.
 	 */
 	bool force_msr_bitmap_recalc;
+
+	/*
+	 * PMU counters where Host-Only or Guest-Only bits are used need to be
+	 * reprogrammed on nested transitions and EFER.SVME changes to correctly
+	 * enable/disable the counters based on the vCPU state.
+	 */
+	DECLARE_BITMAP(reprogram_pmcs_on_nested_transitions, X86_PMC_IDX_MAX);
 };
 
 struct vcpu_sev_es_state {
@@ -877,6 +885,31 @@ void nested_sync_control_from_vmcb02(struct vcpu_svm *svm);
 void nested_vmcb02_compute_g_pat(struct vcpu_svm *svm);
 void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb);
 
+
+static inline void __svm_pmu_handle_nested_transition(struct vcpu_svm *svm, bool defer)
+{
+	u64 counters = *(u64 *)svm->nested.reprogram_pmcs_on_nested_transitions;
+
+	if (!counters)
+		return;
+
+	/* Reprogramming sets the bit again for PMCs that still need tracking */
+	bitmap_zero(svm->nested.reprogram_pmcs_on_nested_transitions, X86_PMC_IDX_MAX);
+	__kvm_pmu_reprogram_counters(vcpu_to_pmu(&svm->vcpu), counters, defer);
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

