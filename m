Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A3E3932C6;
	Thu, 26 Mar 2026 03:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774494752; cv=none; b=OnG/9twRFck37iccr0Qq0NjsD/eftZVbxhssCIx9yeLfDcHmNUajrrkLWyx+/1m3RIhRawu104CfbePSUqqT+NeUhuodd2d4+Fzx8Yxd+fBOWBXXhYdIJaPAiN8wUiq91PMw88nxE+gJs0/HCbPYjHJBvwwE3nNXtEsh+q5gbOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774494752; c=relaxed/simple;
	bh=53QaIKDk7fN2Ew8/rOTS7tu4uaix84f/2x/Yx6CWKOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFYJYbG4YLcFFe+W5WCBT59wkCygkCtjxmEO+3tesWyMfVtJVKXLiM/+PltK2JMLBs0O50yRyiAnNXlPOoqYjIWbjuVVfC6oTYdWbrcVFct7npCw3TY1L8j1BxNZOR0g2z8wjk5iRuAwnoghF0kULwgPJxhRRUlMS9VcD26RuSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZn8vwOb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZn8vwOb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26002C2BCB4;
	Thu, 26 Mar 2026 03:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774494752;
	bh=53QaIKDk7fN2Ew8/rOTS7tu4uaix84f/2x/Yx6CWKOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pZn8vwOb/i6G3QnJfKP1r6rO/frFGWu7iNe8gAVwnCXX0Lxyt80xFyVAjiWhkNLJ5
	 85EUvaIPTwKZyaPwRiIWnz8+RTbW55LBMsN6veIZ1BE+BHdDlkX3z9eXd36YgFbl2F
	 Yn7ByzcLVuQOyOjGUkB5Wiq3RKN1BwD8fNfUV78T6SDAPfysTo1m7E2N/qLPB08dD4
	 gl8GX+QcUe/7dLEhZ+nbRRrWPQFUHdGaHBv3p3/KkxBZJkcKH2OXnTzMrXRkT+NtNE
	 JGfHOfS2mDqIHM8FMmFDL8vOn1ATXX8tWguuoKNbpc214qzfZV3ksEeuklHd0PCuQd
	 dwOUaX+IBrI2Q==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 3/6] KVM: x86/pmu: Disable counters based on Host-Only/Guest-Only bits in SVM
Date: Thu, 26 Mar 2026 03:11:47 +0000
Message-ID: <20260326031150.3774017-4-yosry@kernel.org>
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

Introduce a per-vendor PMU callback for reprogramming counters with a
mediated PMU, and register a callback on AMD to disable a counter based
on the vCPU's setting of Host-Only or Guest-Only EVENT_SELECT bits (if
EFER.SVME is set). In other words, disable the counter if Host-Only and
guest_mode() or Guest-Only and !guest_mode().

kvm_mediated_pmu_refresh_event_filter() ensures that
ARCH_PERFMON_EVENTSEL_ENABLE is set for any enabled counters before
mediated_reprogram_counter() callback, and kvm_mediated_pmu_load()
writes the updated value of eventsel_hw to the appropriate MSR after the
counters are reprogrammed through KVM_REQ_PMU.

Note that the behavior is equivalent if both bits are cleared or if both
bits are set, events are counted regardless of host/guest state (from
L1's perspective), so KVM should always keep the counter enabled unless
only one of the bits is set.

It's a bit unnatural to check if both bits are set or cleared, then
check EFER.SVME, then go back to checking the set bit. This ordering
will be needed by following changes that will track counters with only
one Host-Only/Guest-Only bit set regardless of EFER.SVME.

Host-Only and Guest-Only bits are currently reserved, so this change is
a noop, but the bits will be allowed with mediated PMU in a following
change when fully supported.

Originally-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h |  1 +
 arch/x86/include/asm/perf_event.h      |  2 ++
 arch/x86/kvm/pmu.c                     |  1 +
 arch/x86/kvm/pmu.h                     |  1 +
 arch/x86/kvm/svm/pmu.c                 | 29 ++++++++++++++++++++++++++
 5 files changed, 34 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index d5452b3433b7d..11ce0012b8301 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -27,6 +27,7 @@ KVM_X86_PMU_OP_OPTIONAL(cleanup)
 KVM_X86_PMU_OP_OPTIONAL(write_global_ctrl)
 KVM_X86_PMU_OP(mediated_load)
 KVM_X86_PMU_OP(mediated_put)
+KVM_X86_PMU_OP_OPTIONAL(mediated_reprogram_counter)
 #endif
 
 #undef KVM_X86_PMU_OP
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
index d6ac3c55fce55..e35d598f809a2 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -559,6 +559,7 @@ static int reprogram_counter(struct kvm_pmc *pmc)
 
 	if (kvm_vcpu_has_mediated_pmu(pmu_to_vcpu(pmu))) {
 		kvm_mediated_pmu_refresh_event_filter(pmc);
+		kvm_pmu_call(mediated_reprogram_counter)(pmc);
 		return 0;
 	}
 
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index b1f2418e960ac..bdbe0456049d0 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -40,6 +40,7 @@ struct kvm_pmu_ops {
 	bool (*is_mediated_pmu_supported)(struct x86_pmu_capability *host_pmu);
 	void (*mediated_load)(struct kvm_vcpu *vcpu);
 	void (*mediated_put)(struct kvm_vcpu *vcpu);
+	void (*mediated_reprogram_counter)(struct kvm_pmc *pmc);
 	void (*write_global_ctrl)(u64 global_ctrl);
 
 	const u64 EVENTSEL_EVENT;
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 7aa298eeb0721..60931dfd624b2 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -260,6 +260,34 @@ static void amd_mediated_pmu_put(struct kvm_vcpu *vcpu)
 		wrmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, pmu->global_status);
 }
 
+static void amd_mediated_pmu_handle_host_guest_bits(struct kvm_pmc *pmc)
+{
+	struct kvm_vcpu *vcpu = pmc->vcpu;
+	u64 host_guest_bits;
+
+	if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
+		return;
+
+	/* Count all events if both bits are cleared or both bits are set */
+	host_guest_bits = pmc->eventsel & AMD64_EVENTSEL_HOST_GUEST_MASK;
+	if (hweight64(host_guest_bits) != 1)
+		return;
+
+	/* Host-Only and Guest-Only are ignored if EFER.SVME == 0 */
+	if (!(vcpu->arch.efer & EFER_SVME))
+		return;
+
+	if (!!(host_guest_bits & AMD64_EVENTSEL_GUESTONLY) == is_guest_mode(vcpu))
+		return;
+
+	pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
+}
+
+static void amd_mediated_pmu_reprogram_counter(struct kvm_pmc *pmc)
+{
+	amd_mediated_pmu_handle_host_guest_bits(pmc);
+}
+
 struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.rdpmc_ecx_to_pmc = amd_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = amd_msr_idx_to_pmc,
@@ -273,6 +301,7 @@ struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.is_mediated_pmu_supported = amd_pmu_is_mediated_pmu_supported,
 	.mediated_load = amd_mediated_pmu_load,
 	.mediated_put = amd_mediated_pmu_put,
+	.mediated_reprogram_counter = amd_mediated_pmu_reprogram_counter,
 
 	.EVENTSEL_EVENT = AMD64_EVENTSEL_EVENT,
 	.MAX_NR_GP_COUNTERS = KVM_MAX_NR_AMD_GP_COUNTERS,
-- 
2.53.0.1018.g2bb0e51243-goog

