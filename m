Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9983BD638;
	Thu, 30 Apr 2026 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580883; cv=none; b=hJhN7nUwlmvQdTXWMOLvYiBSGDgv7VLCDVVxLVMh7Ufm8IvTjvS/itSgDXdVMpfLVxUEB2i4b2bgLuIl+9gmFO38U4IgrYebujU6NzYNWRXCjMzhh6sjvWeGlT0B9+hZLoAA3vvgL8ZIfJBS4lLOlXU2T316DJRb0r9YdFFNbX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580883; c=relaxed/simple;
	bh=dDnneAZEjI+AYbZfcZL7n3wWjyMvkOPl7dyZQ2L4nHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqDgqrfm7ChnQYaK/xHjfdG47e/igoz2DCMSZ/yysofTHiyQVFe6B9WaIvC0zHaVYvzsFJmxSt8wM3c3e/vO9sa11EJl8h7btRP1sVzdIKO6pq+ORAgzICjFOSOtWbdTzO6IOoca+wdWs4xF0Gpt7F89D1acXbzpL02GG0PYzDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCI7efXE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCI7efXE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBFFC2BCB8;
	Thu, 30 Apr 2026 20:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777580883;
	bh=dDnneAZEjI+AYbZfcZL7n3wWjyMvkOPl7dyZQ2L4nHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aCI7efXEKWKK1lKw2feg2BUo6Zr4sf7yO1hEOGUIiUBRXzf7jbdKJHJHDlIekzT2S
	 15gD6Q3dNBra0uuVUiEtK9/VLofBNqmUIfzRclJ8aHNRqrS0SsI6P9ryXBRMXYVkyA
	 Qd2yfUALSN2LSCxEGKTO7Wuc0h5Ac7O3K+LB6GjSTHGGSvgG00scJzgXnmoRbePik6
	 JFWax9XrNFVk4p/go/5ouDRJoULrDdq8iEnly/dXKfH4D2u/Iev2Rcp4ix6t4eMVDX
	 kSTmk0pNDI6pKcG2RKA6ZpHQSHBh4kRWeaXVF9KfSVtXNdckbhQt/HLHYDFxdFQnGJ
	 Awj7nTlgJi6vg==
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
Subject: [PATCH v5 07/13] KVM: x86/pmu: Disable counters based on Host-Only/Guest-Only bits in SVM
Date: Thu, 30 Apr 2026 20:27:44 +0000
Message-ID: <20260430202750.3924147-8-yosry@kernel.org>
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

Introduce a per-vendor PMU callback for reprogramming counters, and
register a callback on AMD to disable a counter based on the vCPU's
setting of Host-Only or Guest-Only EVENT_SELECT bits.

If EFER.SVME is set, all events are counted if both bits are set or
cleared. If only one bit is set, the counter is disabled if the vCPU
context does not match the set bit.

If EFER.SVME is cleared, the counter is disabled if any of the bits is
set, otherwise all events are counted. Note that a Linux guest correctly
handles this and clears Host-Only when EFER.SVME is cleared, see commit
1018faa6cf23 ("perf/x86/kvm: Fix Host-Only/Guest-Only counting with SVM
disabled").

The reprogram_counters() callback is made after the reprogram_counter()
loop, as it depends on kvm_mediated_pmu_refresh_event_filter() setting
ARCH_PERFMON_EVENTSEL_ENABLE for any enabled counters first.

kvm_mediated_pmu_load() writes the updated value of eventsel_hw to the
appropriate MSR before the vCPU is run.

Host-Only and Guest-Only bits are currently reserved, so this change is
a noop, but the bits will be allowed with mediated PMU in a following
change when fully supported.

Originally-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h |  1 +
 arch/x86/include/asm/perf_event.h      |  2 ++
 arch/x86/kvm/pmu.c                     |  6 +++-
 arch/x86/kvm/pmu.h                     |  1 +
 arch/x86/kvm/svm/pmu.c                 | 43 ++++++++++++++++++++++++++
 5 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index d5452b3433b7d..5402efd26282b 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -23,6 +23,7 @@ KVM_X86_PMU_OP(init)
 KVM_X86_PMU_OP_OPTIONAL(reset)
 KVM_X86_PMU_OP_OPTIONAL(deliver_pmi)
 KVM_X86_PMU_OP_OPTIONAL(cleanup)
+KVM_X86_PMU_OP_OPTIONAL(reprogram_counters)
 
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
index afbc731e72174..5e3a10e0a54ff 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -646,9 +646,11 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 	DECLARE_BITMAP(bitmap, X86_PMC_IDX_MAX);
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
+	u64 counters;
 	int bit;
 
 	bitmap_copy(bitmap, pmu->reprogram_pmi, X86_PMC_IDX_MAX);
+	counters = *(u64 *)bitmap;
 
 	/*
 	 * The reprogramming bitmap can be written asynchronously by something
@@ -656,7 +658,7 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 	 * the bits that will actually processed.
 	 */
 	BUILD_BUG_ON(sizeof(bitmap) != sizeof(atomic64_t));
-	atomic64_andnot(*(s64 *)bitmap, &pmu->__reprogram_pmi);
+	atomic64_andnot(counters, &pmu->__reprogram_pmi);
 
 	kvm_for_each_pmc(pmu, pmc, bit, bitmap) {
 		/*
@@ -669,6 +671,8 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 			set_bit(pmc->idx, pmu->reprogram_pmi);
 	}
 
+	kvm_pmu_call(reprogram_counters)(vcpu, counters);
+
 	/*
 	 * Release unused perf_events if the corresponding guest MSRs weren't
 	 * accessed during the last vCPU time slice (need_cleanup is set when
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 0e99022168a85..0c372b9f8ed34 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -36,6 +36,7 @@ struct kvm_pmu_ops {
 	void (*reset)(struct kvm_vcpu *vcpu);
 	void (*deliver_pmi)(struct kvm_vcpu *vcpu);
 	void (*cleanup)(struct kvm_vcpu *vcpu);
+	void (*reprogram_counters)(struct kvm_vcpu *vcpu, u64 counters);
 
 	bool (*is_mediated_pmu_supported)(struct x86_pmu_capability *host_pmu);
 	void (*mediated_load)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 7aa298eeb0721..fe6f2bb79ab83 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -260,6 +260,48 @@ static void amd_mediated_pmu_put(struct kvm_vcpu *vcpu)
 		wrmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, pmu->global_status);
 }
 
+static void amd_mediated_pmu_handle_host_guest_bits(struct kvm_vcpu *vcpu,
+						    struct kvm_pmc *pmc)
+{
+	u64 host_guest_bits;
+
+	if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
+		return;
+
+	/* Count all events if both bits are cleared */
+	host_guest_bits = pmc->eventsel & AMD64_EVENTSEL_HOST_GUEST_MASK;
+	if (!host_guest_bits)
+		return;
+
+	/*
+	 * If EFER.SVME is set, the counter is disabledd if only one of the bits
+	 * is set and it doesn't match the vCPU context. If EFER.SVME is
+	 * cleared, the counter is disable if any of the bits is set.
+	 */
+	if (vcpu->arch.efer & EFER_SVME) {
+		if (host_guest_bits == AMD64_EVENTSEL_HOST_GUEST_MASK)
+			return;
+
+		if (!!(host_guest_bits & AMD64_EVENTSEL_GUESTONLY) == is_guest_mode(vcpu))
+			return;
+	}
+
+	pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
+}
+
+static void amd_pmu_reprogram_counters(struct kvm_vcpu *vcpu, u64 counters)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
+	int bit;
+
+	if (!kvm_vcpu_has_mediated_pmu(vcpu))
+		return;
+
+	kvm_for_each_pmc(pmu, pmc, bit, (unsigned long *)&counters)
+		amd_mediated_pmu_handle_host_guest_bits(vcpu, pmc);
+}
+
 struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.rdpmc_ecx_to_pmc = amd_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = amd_msr_idx_to_pmc,
@@ -269,6 +311,7 @@ struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.set_msr = amd_pmu_set_msr,
 	.refresh = amd_pmu_refresh,
 	.init = amd_pmu_init,
+	.reprogram_counters = amd_pmu_reprogram_counters,
 
 	.is_mediated_pmu_supported = amd_pmu_is_mediated_pmu_supported,
 	.mediated_load = amd_mediated_pmu_load,
-- 
2.54.0.545.g6539524ca2-goog

