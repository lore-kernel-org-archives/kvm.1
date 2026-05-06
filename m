Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FA3301493;
	Wed,  6 May 2026 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032685; cv=none; b=eDMxMBsHBBEUuvSAJisg8WWj7DkpF/CQb4spl63MuIOD3VWBcTqXYG55imLi7brG9PyROYYixRVCTUd+7QDvMaN+gIVN5lqdG1Bzi3WW5aAeNPuA9wn3Jb6fWjwEkGtmP7Ob4N2iPcLXYZ9oJuaz1oQlZYxBGStP1IuWm70c4jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032685; c=relaxed/simple;
	bh=gXzff9reFCnaLdjrAFtxgLc3IYzOqctQSRcX/CnC+y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6RneTnjQflNK5wW387F1NinBMiU6JwWEjdZ9VjpqnzLUJWaGMAKoGMnNmwzEoiAOjKUVhHfp2PpvK8IGgcU8uxP8TArRMg9oK46gPP9P1rCn03ziF86Cz0BJdEaeE6rW3tQx7CoBYbfSdru29KM83sHaRg0k+0X42c7Pu0OUgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qw9WeB9c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qw9WeB9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EBEC2BCC9;
	Wed,  6 May 2026 01:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032685;
	bh=gXzff9reFCnaLdjrAFtxgLc3IYzOqctQSRcX/CnC+y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qw9WeB9cCZboi6/fb/bdjYprfssTpYUqSB+9+ZpJCMY5hJpqAiBfKWcMIaxDXYxDP
	 osN4kICaTScC9IxNgxKD8t8zmMdcgafH+0C2nDGfcwaS/vKJLDgJiQ2bPCim/C9j1x
	 jiS0QPJ6xm1TIpapUoZRh4LFhzb2lHA70hMoR5BhCz8R4UA0XdYq7dq6klq3VFfSbu
	 C4C2447zGYPZFnKF4sI4LjKZuMpbKXuz2JA4UWVi8AdtRpS184DGPdzitjsXNsN6nK
	 3t4+xIuJe+Gxq3NOzguZ4kFkBRkPiRHObmRxkDnNkc2oZSyPI0EVlqisc6+rN5LsjW
	 F5koODa2BiiJA==
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
Subject: [PATCH v6 09/16] KVM: x86/pmu: Disable counters based on Host-Only/Guest-Only bits in SVM
Date: Wed,  6 May 2026 01:57:25 +0000
Message-ID: <20260506015733.1671124-10-yosry@kernel.org>
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

Introduce an optional per-vendor PMU callback for checking if a counter
is disabled in the current mode, and register a callback on AMD to
disable a counter based on the vCPU's setting of Host-Only or Guest-Only
EVENT_SELECT bits with the mediated PMU.

If EFER.SVME is set, all events are counted if both bits are set or
cleared. If only one bit is set, the counter is disabled if the vCPU
context does not match the set bit.

If EFER.SVME is cleared, the counter is disabled if any of the bits is
set, otherwise all events are counted. Note that a Linux guest correctly
handles this and clears Host-Only when EFER.SVME is cleared, see commit
1018faa6cf23 ("perf/x86/kvm: Fix Host-Only/Guest-Only counting with SVM
disabled").

The callback is made from pmc_is_locally_enabled(), which is used for
the mediated PMU when updating eventsel_hw in
kvm_mediated_pmu_refresh_eventsel_hw(), as well as when checking what
PMCs count instructions/branches for emulation in
kvm_pmu_recalc_pmc_emulation().

Host-Only and Guest-Only bits are currently reserved, so this change is
a noop, but the bits will be allowed with mediated PMU in a following
change when fully supported.

Originally-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h |  1 +
 arch/x86/include/asm/perf_event.h      |  2 ++
 arch/x86/kvm/pmu.c                     |  1 +
 arch/x86/kvm/pmu.h                     |  4 +++-
 arch/x86/kvm/svm/pmu.c                 | 32 ++++++++++++++++++++++++++
 5 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index 03ed2c917bb56..55442fc355eea 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -24,6 +24,7 @@ KVM_X86_PMU_OP(init)
 KVM_X86_PMU_OP_OPTIONAL(reset)
 KVM_X86_PMU_OP_OPTIONAL(deliver_pmi)
 KVM_X86_PMU_OP_OPTIONAL(cleanup)
+KVM_X86_PMU_OP_OPTIONAL_RET0(pmc_is_disabled_in_current_mode)
 
 KVM_X86_PMU_OP_OPTIONAL(write_global_ctrl)
 KVM_X86_PMU_OP(mediated_load)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index ff5acb8b199b0..5961c002b28eb 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -60,6 +60,8 @@
 #define AMD64_EVENTSEL_INT_CORE_ENABLE			(1ULL << 36)
 #define AMD64_EVENTSEL_GUESTONLY			(1ULL << 40)
 #define AMD64_EVENTSEL_HOSTONLY				(1ULL << 41)
+#define AMD64_EVENTSEL_HOST_GUEST_MASK			\
+	(AMD64_EVENTSEL_HOSTONLY | AMD64_EVENTSEL_GUESTONLY)
 
 #define AMD64_EVENTSEL_INT_CORE_SEL_SHIFT		37
 #define AMD64_EVENTSEL_INT_CORE_SEL_MASK		\
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 9b7e39610be22..8159b07e9bc20 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -100,6 +100,7 @@ static struct kvm_pmu_ops kvm_pmu_ops __read_mostly;
 #define KVM_X86_PMU_OP_OPTIONAL KVM_X86_PMU_OP
 #define KVM_X86_PMU_OP_OPTIONAL_RET0 KVM_X86_PMU_OP
 #include <asm/kvm-x86-pmu-ops.h>
+EXPORT_STATIC_CALL_GPL(kvm_x86_pmu_pmc_is_disabled_in_current_mode);
 
 void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops)
 {
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index a062f0bc3dbb1..cc7f55d4a78b4 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -36,6 +36,7 @@ struct kvm_pmu_ops {
 	void (*reset)(struct kvm_vcpu *vcpu);
 	void (*deliver_pmi)(struct kvm_vcpu *vcpu);
 	void (*cleanup)(struct kvm_vcpu *vcpu);
+	bool (*pmc_is_disabled_in_current_mode)(struct kvm_pmc *pmc);
 
 	bool (*is_mediated_pmu_supported)(struct x86_pmu_capability *host_pmu);
 	void (*mediated_load)(struct kvm_vcpu *vcpu);
@@ -201,7 +202,8 @@ static inline bool pmc_is_locally_enabled(struct kvm_pmc *pmc)
 					pmc->idx - KVM_FIXED_PMC_BASE_IDX) &
 					(INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER);
 
-	return pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE;
+	return (pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE) &&
+		!kvm_pmu_call(pmc_is_disabled_in_current_mode)(pmc);
 }
 
 extern struct x86_pmu_capability kvm_pmu_cap;
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 7aa298eeb0721..41ee6532290e9 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -260,6 +260,37 @@ static void amd_mediated_pmu_put(struct kvm_vcpu *vcpu)
 		wrmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, pmu->global_status);
 }
 
+static bool amd_pmc_is_disabled_in_current_mode(struct kvm_pmc *pmc)
+{
+	struct kvm_vcpu *vcpu = pmc->vcpu;
+	u64 host_guest_bits;
+
+	if (!kvm_vcpu_has_mediated_pmu(vcpu))
+		return false;
+
+	/* Common code is supposed to check the common enable bit */
+	if (WARN_ON_ONCE(!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE)))
+		return false;
+
+	/* If both bits are cleared, the counter is always enabled */
+	host_guest_bits = pmc->eventsel & AMD64_EVENTSEL_HOST_GUEST_MASK;
+	if (!host_guest_bits)
+		return false;
+
+	/* If EFER.SVME=0 and either bit is set, the counter is disabled */
+	if (!(vcpu->arch.efer & EFER_SVME))
+		return true;
+
+	/*
+	 * If EFER.SVME=1, the counter is disabled iff only one of the bits is
+	 * set AND the set bit doesn't match the vCPU mode.
+	 */
+	if (host_guest_bits == AMD64_EVENTSEL_HOST_GUEST_MASK)
+		return false;
+
+	return !!(host_guest_bits & AMD64_EVENTSEL_GUESTONLY) != is_guest_mode(vcpu);
+}
+
 struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.rdpmc_ecx_to_pmc = amd_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = amd_msr_idx_to_pmc,
@@ -269,6 +300,7 @@ struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.set_msr = amd_pmu_set_msr,
 	.refresh = amd_pmu_refresh,
 	.init = amd_pmu_init,
+	.pmc_is_disabled_in_current_mode = amd_pmc_is_disabled_in_current_mode,
 
 	.is_mediated_pmu_supported = amd_pmu_is_mediated_pmu_supported,
 	.mediated_load = amd_mediated_pmu_load,
-- 
2.54.0.545.g6539524ca2-goog

