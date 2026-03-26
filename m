Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B273939CD;
	Thu, 26 Mar 2026 03:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774494752; cv=none; b=gSpc1ZkuN4rHaiG6e0For4KktuMIpUC6Kf7mExnpRHlSEFXv5Fe+wvchcYFI5hymQNKi+G4yzt3Sd0ozCxX3OUDUHNVGAXHWQqqYgJLk8rXIBt/euzRZogi84mrZd389crdldcAZIxU1GHjDOrNo7Y+kXznf94HsPhztlBrtgow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774494752; c=relaxed/simple;
	bh=la1WaIfCaF2/MggGDt7wbuSsGkHH2X29eUAojHCz++c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnM90kOcKiT2dQ0fNCVBsmg+VjklTE/6YzAYtrEafBOhmbzwGzCpUbf6ZfoszLf9JKC87yCFUi/uLZkcV/Wo38DN9+X0iCj7gBucbode7wddoiT8Z8gssdvQ9kh/AE5+FI21TPmihb1LXw8HN7X9g5qwmzDvhsyNs+CvFUjAHQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1HxAGRV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1HxAGRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823E9C2BCB1;
	Thu, 26 Mar 2026 03:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774494752;
	bh=la1WaIfCaF2/MggGDt7wbuSsGkHH2X29eUAojHCz++c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q1HxAGRVaDEjq8OkBiIxOOiCuTAg4fxAIka0NEvejD65vfPpZmeigFyD/sURXXmqP
	 8qqKH6X1szexGxPWIJs/Jb4MW6mSovTdKYVOtMu+wBHYyzCas2nB97Xnj8ExP1Y0/J
	 KIKCrEy2YYhT6Hoe2O0AFAXdAswPY6H7wx2K1Vy1fy97EtQDqe+eXUGoQ5Gvt+9FUW
	 Ipw7ugmjd3abal+XDIG4MUGL4Os/Ite+x0E2pPfDbc8kscDNaRIzojOxudlsOxVYBZ
	 yvXxxd1uwtWQ6myFgytXUUZdBQ7EiEKzjXuDF0ruYUTmy7eaZCzvVGbmSB7Vw2Jrbe
	 srKymrlxIYaGw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 4/6] KVM: x86/pmu: Re-evaluate Host-Only/Guest-Only on nested SVM transitions
Date: Thu, 26 Mar 2026 03:11:48 +0000
Message-ID: <20260326031150.3774017-5-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260326031150.3774017-1-yosry@kernel.org>
References: <20260326031150.3774017-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reprogram all counters on nested transitions for the mediated PMU, to
re-evaluate Host-Only and Guest-Only bits and enable/disable the PMU
counters accordingly. For example, if Host-Only is set and Guest-Only is
cleared, a counter should be disabled when entering guest mode and
enabled when exiting guest mode.

Having one of Host-Only and Guest-Only set is only effective when
EFER.SVME is set, so also trigger counter reprogramming when EFER.SVME
is toggled.

Track counters with one of Host-Only and Guest-Only set as counters
requiring reprogramming on nested transitions in a bitmap. Use the
bitmap to only request KVM_PMU_REQ if some counters need reprogramming,
and only reprogram the counters that actually need it.

Track such counters even if EFER.SVME is cleared, such that if/when
EFER.SVME is set, KVM can reprogram those counters and enable/disable
them appropriately. Otherwise, toggling EFER.SVME would need to
reprogram all counters and use a different code path than
kvm_pmu_handle_nested_transition().

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  6 ++++++
 arch/x86/kvm/pmu.c              |  1 +
 arch/x86/kvm/pmu.h              | 13 +++++++++++++
 arch/x86/kvm/svm/pmu.c          | 13 ++++++++++++-
 arch/x86/kvm/svm/svm.c          |  1 +
 arch/x86/kvm/x86.h              |  5 +++++
 6 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d3bdc98281339..b2f8710838372 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -594,6 +594,12 @@ struct kvm_pmu {
 	DECLARE_BITMAP(pmc_counting_instructions, X86_PMC_IDX_MAX);
 	DECLARE_BITMAP(pmc_counting_branches, X86_PMC_IDX_MAX);
 
+	/*
+	 * Whether or not PMU counters need to be reprogrammed on transitions
+	 * between L1 and L2 (or when nesting enablement is toggled).
+	 */
+	DECLARE_BITMAP(pmc_needs_nested_reprogram, X86_PMC_IDX_MAX);
+
 	u64 ds_area;
 	u64 pebs_enable;
 	u64 pebs_enable_rsvd;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index e35d598f809a2..a7b38c104d067 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -932,6 +932,7 @@ static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 	pmu->need_cleanup = false;
 
 	bitmap_zero(pmu->reprogram_pmi, X86_PMC_IDX_MAX);
+	bitmap_zero(pmu->pmc_needs_nested_reprogram, X86_PMC_IDX_MAX);
 
 	kvm_for_each_pmc(pmu, pmc, i, pmu->all_valid_pmc_idx) {
 		pmc_stop_counter(pmc);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index bdbe0456049d0..fb73806d3bfa0 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -248,6 +248,19 @@ static inline bool kvm_pmu_is_fastpath_emulation_allowed(struct kvm_vcpu *vcpu)
 				  X86_PMC_IDX_MAX);
 }
 
+static inline void kvm_pmu_handle_nested_transition(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	if (bitmap_empty(pmu->pmc_needs_nested_reprogram, X86_PMC_IDX_MAX))
+		return;
+
+	BUILD_BUG_ON(sizeof(pmu->pmc_needs_nested_reprogram) != sizeof(atomic64_t));
+	atomic64_or(*(s64 *)pmu->pmc_needs_nested_reprogram,
+		    &vcpu_to_pmu(vcpu)->__reprogram_pmi);
+	kvm_make_request(KVM_REQ_PMU, vcpu);
+}
+
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
 void kvm_pmu_handle_event(struct kvm_vcpu *vcpu);
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 60931dfd624b2..cc1eabb0ad15f 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -262,17 +262,28 @@ static void amd_mediated_pmu_put(struct kvm_vcpu *vcpu)
 
 static void amd_mediated_pmu_handle_host_guest_bits(struct kvm_pmc *pmc)
 {
+	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
 	struct kvm_vcpu *vcpu = pmc->vcpu;
 	u64 host_guest_bits;
 
+	__clear_bit(pmc->idx, pmu->pmc_needs_nested_reprogram);
+
 	if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
 		return;
 
-	/* Count all events if both bits are cleared or both bits are set */
+	/*
+	 * If both bits are cleared or both bits are set, count all events.
+	 * Otherwise, the counter enablement should be re-evaluated on every
+	 * nested transition. Track which counters need to be re-evaluated even
+	 * if EFER.SVME == 0, such that the counters are correctly reprogrammed
+	 * on nested transitions after EFER.SVME is set.
+	 */
 	host_guest_bits = pmc->eventsel & AMD64_EVENTSEL_HOST_GUEST_MASK;
 	if (hweight64(host_guest_bits) != 1)
 		return;
 
+	__set_bit(pmc->idx, pmu->pmc_needs_nested_reprogram);
+
 	/* Host-Only and Guest-Only are ignored if EFER.SVME == 0 */
 	if (!(vcpu->arch.efer & EFER_SVME))
 		return;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d2ca226871c2f..1ac00d2cba0ab 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -261,6 +261,7 @@ int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 				set_exception_intercept(svm, GP_VECTOR);
 		}
 
+		kvm_pmu_handle_nested_transition(vcpu);
 		kvm_make_request(KVM_REQ_RECALC_INTERCEPTS, vcpu);
 	}
 
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index f1c29ac306917..966e4138308f6 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -9,6 +9,7 @@
 #include "kvm_cache_regs.h"
 #include "kvm_emulate.h"
 #include "cpuid.h"
+#include "pmu.h"
 
 #define KVM_MAX_MCE_BANKS 32
 
@@ -152,6 +153,8 @@ static inline void enter_guest_mode(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.hflags |= HF_GUEST_MASK;
 	vcpu->stat.guest_mode = 1;
+
+	kvm_pmu_handle_nested_transition(vcpu);
 }
 
 static inline void leave_guest_mode(struct kvm_vcpu *vcpu)
@@ -164,6 +167,8 @@ static inline void leave_guest_mode(struct kvm_vcpu *vcpu)
 	}
 
 	vcpu->stat.guest_mode = 0;
+
+	kvm_pmu_handle_nested_transition(vcpu);
 }
 
 static inline bool is_guest_mode(struct kvm_vcpu *vcpu)
-- 
2.53.0.1018.g2bb0e51243-goog

