Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E376C43F4CE;
	Tue,  7 Jul 2026 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449840; cv=none; b=o/npVXJ+Ex5otCEzf1cYsyp4T+jhLnlTdP4pugklaD+xpjq/dP5nFZ+gQgpprLT6U5UIc8GzWSreZoBZaGP70pzouNsa8074w/niy0dpBjpUCBIS+hPKo+LHfLc1AtUmT7fbba+uLXXiaqbaXmhctXIdSg+djuePdQa/1D25F24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449840; c=relaxed/simple;
	bh=JGuPKA9fdrhRJmhkZv0m48mnr0yD+1ShfHNFQx1/2DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcrbeyBRE7UZcJfdUbD1wGoXw6s4yh3hVlEVe3iPt5FxhNsUyBGKHJa45t/prTcMQ5KmdOMiYsvYAI19pmYvOmZtU3pGxC9IfvZzger4jjYsGz+kCGQjuf/HTQNZZBpyQs/1QLPOBOZQwKcFE5+i4C2RVJlADEumcI+2OH8BAuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tct3MP9X; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tct3MP9X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783449839; x=1814985839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JGuPKA9fdrhRJmhkZv0m48mnr0yD+1ShfHNFQx1/2DY=;
  b=Tct3MP9Xu/LomWUQOOLi9WPdXlFvwlOq2lmL4MUlAekFijHpLeWc3h2P
   3daTO9Zg/+qpMTfLTmsN87d3xC9Yi8anJpj7qT/jyGs+R4zAhgBsH581w
   80oXSJIfk2re9OtKghaZkpKjjgP/2HVuSMGaTBxWFvGR3W4nEuqDQK2iB
   NjIf3V8rPdiYfIY3W3Qind/M7Eskyx/RtPfvJ4lGKklzq7cyj/rGhOvau
   4Jp9Yo2VOxSakxB4xLszTjSYpNO9ERuBeEaxcbN1btOBFA0lk3zwJrCBY
   GT43fg/e+Ex2dhoZBsYmNwWxnszuuUpeNN1ndShvC1o6vgFu7lp2iHxg+
   w==;
X-CSE-ConnectionGUID: Ob+JrU8gTjG2f5JpBDIyHA==
X-CSE-MsgGUID: +ETaVT/SQcme6xSBxnBBkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94713856"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94713856"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:57 -0700
X-CSE-ConnectionGUID: e0LF+ucnROe7qH34lDBx3w==
X-CSE-MsgGUID: rsFkrPkPQVKnOrYl+QQrHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277279286"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:56 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH 03/15] KVM: x86/pmu: Rename reserved_bits to eventsel_rsvd in kvm_pmu
Date: Tue,  7 Jul 2026 11:33:53 -0700
Message-ID: <20260707183405.15571-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707183405.15571-1-zide.chen@intel.com>
References: <20260707183405.15571-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This field stores the bits that are reserved in guest IA32_PERFEVTSELx
MSRs. Rename it to eventsel_rsvd to better reflect its purpose and to
align with other field names in struct kvm_pmu.

Opportunistically, replace the magic number 0xffffffff00200000ull with
macros.

No functional change intended.

Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/pmu.c              |  3 ++-
 arch/x86/kvm/svm/pmu.c          |  6 +++---
 arch/x86/kvm/vmx/pmu_intel.c    | 12 ++++++------
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4677773cfa30..395b6f20e9ac 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -628,7 +628,7 @@ struct kvm_pmu {
 	u64 counter_bitmask[2];
 	u64 global_ctrl_rsvd;
 	u64 global_status_rsvd;
-	u64 reserved_bits;
+	u64 eventsel_rsvd;
 	u64 raw_event_mask;
 	u64 perf_metrics;
 	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 9db12c54814d..cef22fed6c53 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1007,7 +1007,8 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->nr_arch_fixed_counters = 0;
 	pmu->counter_bitmask[KVM_PMC_GP] = 0;
 	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
-	pmu->reserved_bits = 0xffffffff00200000ull;
+	/* KVM is not able to emulate the AnyThread bit */
+	pmu->eventsel_rsvd = GENMASK_ULL(63, 32) | ARCH_PERFMON_EVENTSEL_ANY;
 	pmu->raw_event_mask = X86_RAW_EVENT_MASK;
 	pmu->global_ctrl_rsvd = ~0ull;
 	pmu->global_status_rsvd = ~0ull;
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 0517fd4bbcd7..90832160fa34 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -168,7 +168,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	/* MSR_EVNTSELn */
 	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_EVNTSEL);
 	if (pmc) {
-		data &= ~pmu->reserved_bits;
+		data &= ~pmu->eventsel_rsvd;
 		if (data != pmc->eventsel) {
 			pmc->eventsel = data;
 			pmc->eventsel_hw = (data & ~AMD64_EVENTSEL_HOSTONLY) |
@@ -219,9 +219,9 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 
 	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;
 
-	pmu->reserved_bits = 0xfffffff000280000ull;
+	pmu->eventsel_rsvd = 0xfffffff000280000ull;
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SVM) && kvm_vcpu_has_mediated_pmu(vcpu))
-		pmu->reserved_bits &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;
+		pmu->eventsel_rsvd &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;
 
 	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
 	/* not applicable to AMD; but clean them to prevent any fall out */
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 5950445ebc69..f42b2972cb7b 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -402,7 +402,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	struct kvm_pmc *pmc;
 	u32 msr = msr_info->index;
 	u64 data = msr_info->data;
-	u64 reserved_bits, diff;
+	u64 eventsel_rsvd, diff;
 
 	switch (msr) {
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
@@ -459,11 +459,11 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -573,7 +573,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	if (entry &&
 	    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) &&
 	    (entry->ebx & (X86_FEATURE_HLE|X86_FEATURE_RTM))) {
-		pmu->reserved_bits ^= HSW_IN_TX;
+		pmu->eventsel_rsvd ^= HSW_IN_TX;
 		pmu->raw_event_mask |= (HSW_IN_TX|HSW_IN_TX_CHECKPOINTED);
 	}
 
@@ -617,7 +617,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	if (perf_capabilities & PERF_CAP_PEBS_FORMAT) {
 		if (perf_capabilities & PERF_CAP_PEBS_BASELINE) {
 			pmu->pebs_enable_rsvd = counter_rsvd;
-			pmu->reserved_bits &= ~ICL_EVENTSEL_ADAPTIVE;
+			pmu->eventsel_rsvd &= ~ICL_EVENTSEL_ADAPTIVE;
 			pmu->pebs_data_cfg_rsvd = ~0xff00000full;
 			intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_0_ADAPTIVE);
 		} else {
-- 
2.54.0

