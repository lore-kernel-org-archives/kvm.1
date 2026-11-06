Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929835;
	b=3ucVFTrCkYpmR9LEGyvvWgVq07cmoC9ftJJxzdog66/YLc7k+kO8DEeRE2AjjKCJe73s
	 1YHa5szwto1TXPsHA+NyxEsbRj48K67kxkf0Kd1Vfx1279NNJvoYeboHnQnFnFpztNYch
	 DPw7k2K5TOVSiYKAxwZ5hlBfk087O5gbuZUHc4whRD1Me2T6Yncy37JCfBPVxeUcqMHwb
	 uFqYCgX+JlFWJ8YzbCvbDsw8gP+N2bl5f8B9egIdFiSarHdlBhIq+3vFycxYPcXCErsA9
	 jdHc20JSiQhzPKk2miM5hsVUmQCn0pjMknzYmB4lewRgiiqz4RBEQZUrz8Lm5V2pqVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929835;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rzh/57D/Os12w0B7Zg9xSrxHnpKlYfseouaL6M96UYA=;
	b=fMqoWetdx/rnkKuLSzwI7FDabPyIgB+lEbXHvmgHl8ECaie+xRkCVsE7XFx+zv5WNNng
	 RLnPIYzIWN0vusY11oiEQEUNGE7NcP6I0rZBQ0TrR6rWEilknDrW1j6XCssvz7QWRpO79
	 5X7+1ghcpSmZ8c5PpWA6fIBw4rgwwKfqsPLrsOsyTgLQGbxSYxCbR5F9Iw+wz60wiQhJt
	 XAh1LoLsA+NPh/HxwdBf2HLUC4kyyCsqYj2Qxva7hBDo//fMndNzPO4Pfv4h7dcGl9NzF
	 edONiFvQqxpRhk44QDBtUvjlipwWdNUrev52S6RLnNY5bX4qf08zWulLDPqfEMC+NTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F0El7gug;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63747606A32D;
	Fri,  6 Nov 2026 01:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63747606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F0El7gug
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793929833; x=1825465833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zrT2Jehl0w9tgBku/To9B6uR9JNpgItE0BrVjptXSAU=;
  b=F0El7gugHVjn/diVZB+spJerHBQIQNgXBaYnXBtRArV1zKPv2xZLpNna
   w/qtrpK5WlxIWAGWI/u61Gw8qwikck7H+sYCEbf4EdxlpndUI/C3NleNy
   7ZuaH62Tl/0zRxr7scXxbpeoA4tkMlU4D2WNcc0bPZhi0BcIt9a/+mCNv
   HvNkCRAHeiZRKLBRTb1zle7g/8bMYCRXHPhgHpFe31IK5RgXswElo5DO3
   GfE6Igg9PS1vaN75pU/FVXMXetFwDOrL7mwUdT7r5iJQMqY0c546qjXeb
   8F+OrcKJjqZPkTud0+YXPJKnA0vAVP95kCfMM3kHy40VXcXu9FnlxMogp
   A==;
X-CSE-ConnectionGUID: u2D1LZcFS+KlddWYcNfhGA==
X-CSE-MsgGUID: 9qzJzBHPQH+KmNXOiN7EuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740125"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2740125"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:30 -0800
X-CSE-ConnectionGUID: WQxz2NdETfOVFfucxnpvRw==
X-CSE-MsgGUID: AXxVgJCLRSOK5T9xF4aAbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067172"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:30 -0800
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v3 03/18] KVM: x86/pmu: Rename reserved_bits to eventsel_rsvd in kvm_pmu
Date: Thu,  5 Nov 2026 18:39:12 -0700
Message-ID: <20261106013927.166209-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106013927.166209-1-zide.chen@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This field stores the bits that are reserved in guest IA32_PERFEVTSELx
MSRs. Rename it to eventsel_rsvd to better reflect its purpose and to
align with other field names in struct kvm_pmu.

Opportunistically, replace magic numbers with macros.

No functional change intended.

Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
---
v3:
- Mention "magic numbers" in changelog to cover AMD as well.

v2:
- Replace magic numbers in AMD pmu->eventsel_rsvd.
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/pmu.c              |  6 +++++-
 arch/x86/kvm/svm/pmu.c          | 12 +++++++++---
 arch/x86/kvm/vmx/pmu_intel.c    | 12 ++++++------
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 72b8fbf432a2..b8875ed5502c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -581,7 +581,7 @@ struct kvm_pmu {
 	u64 counter_bitmask[2];
 	u64 global_ctrl_rsvd;
 	u64 global_status_rsvd;
-	u64 reserved_bits;
+	u64 eventsel_rsvd;
 	u64 raw_event_mask;
 	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
 	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 83883191d124..cbd63329cf13 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -983,7 +983,11 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->nr_arch_fixed_counters = 0;
 	pmu->counter_bitmask[KVM_PMC_GP] = 0;
 	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
-	pmu->reserved_bits = 0xffffffff00200000ull;
+	/*
+	 * KVM is not able to emulate the AnyThread bit due to cross-VM
+	 * information leakage on SMT cores.
+	 */
+	pmu->eventsel_rsvd = GENMASK_ULL(63, 32) | ARCH_PERFMON_EVENTSEL_ANY;
 	pmu->raw_event_mask = X86_RAW_EVENT_MASK;
 	pmu->global_ctrl_rsvd = ~0ull;
 	pmu->global_status_rsvd = ~0ull;
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index c18286545a7a..52224872e0d4 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -163,7 +163,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	/* MSR_EVNTSELn */
 	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_EVNTSEL);
 	if (pmc) {
-		data &= ~pmu->reserved_bits;
+		data &= ~pmu->eventsel_rsvd;
 		if (data != pmc->eventsel) {
 			pmc->eventsel = data;
 			pmc->eventsel_hw = (data & ~AMD64_EVENTSEL_HOSTONLY) |
@@ -214,9 +214,15 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 
 	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;
 
-	pmu->reserved_bits = 0xfffffff000280000ull;
+	/*
+	 * AMD PerfEvtSeln registers do not support PinControl, and KVM does
+	 * not emulate AnyThread due to cross-VM information leakage on SMT
+	 * cores (as on the Intel side).
+	 */
+	pmu->eventsel_rsvd = GENMASK_ULL(63, 36) | ARCH_PERFMON_EVENTSEL_PIN_CONTROL |
+			     ARCH_PERFMON_EVENTSEL_ANY;
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SVM) && kvm_vcpu_has_mediated_pmu(vcpu))
-		pmu->reserved_bits &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;
+		pmu->eventsel_rsvd &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;
 
 	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
 	/* not applicable to AMD; but clean them to prevent any fall out */
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index ee18899614a1..fadc466cd600 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -388,7 +388,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	struct kvm_pmc *pmc;
 	u32 msr = msr_info->index;
 	u64 data = msr_info->data;
-	u64 reserved_bits, diff;
+	u64 eventsel_rsvd, diff;
 
 	switch (msr) {
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
@@ -436,11 +436,11 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			pmc_write_counter(pmc, data);
 			break;
 		} else if ((pmc = get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0))) {
-			reserved_bits = pmu->reserved_bits;
+			eventsel_rsvd = pmu->eventsel_rsvd;
 			if ((pmc->idx == 2) &&
 			    (pmu->raw_event_mask & HSW_IN_TX_CHECKPOINTED))
-				reserved_bits ^= HSW_IN_TX_CHECKPOINTED;
-			if (data & reserved_bits)
+				eventsel_rsvd ^= HSW_IN_TX_CHECKPOINTED;
+			if (data & eventsel_rsvd)
 				return 1;
 
 			if (data != pmc->eventsel) {
@@ -548,7 +548,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	if (entry &&
 	    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) &&
 	    (entry->ebx & (X86_FEATURE_HLE|X86_FEATURE_RTM))) {
-		pmu->reserved_bits ^= HSW_IN_TX;
+		pmu->eventsel_rsvd ^= HSW_IN_TX;
 		pmu->raw_event_mask |= (HSW_IN_TX|HSW_IN_TX_CHECKPOINTED);
 	}
 
@@ -587,7 +587,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	if (perf_capabilities & PERF_CAP_PEBS_FORMAT) {
 		if (perf_capabilities & PERF_CAP_PEBS_BASELINE) {
 			pmu->pebs_enable_rsvd = counter_rsvd;
-			pmu->reserved_bits &= ~ICL_EVENTSEL_ADAPTIVE;
+			pmu->eventsel_rsvd &= ~ICL_EVENTSEL_ADAPTIVE;
 			pmu->pebs_data_cfg_rsvd = ~0xff00000full;
 			intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_0_ADAPTIVE);
 		} else {
-- 
2.56.0

