Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D60E37F006;
	Thu, 27 Aug 2026 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870890; cv=none; b=cOzn1LvUHbCT0UAtsHCMkK0j5iDUKTOMBMdCRgIVKRPokm/zPWC+vFUIvuUzhxb3vaEsFyAUH2yzhbUipS1Ffx4XVcgnNb6E+Kh9mWRqF8DezExBYl3MoEeSdbkYpHzgHxqZR6vHaM10Z4VgWQ+Hh7li/GK6vIiV+tMYBF0wvco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870890; c=relaxed/simple;
	bh=FHDPnh2kXbwiIr3J36aVtrrBW3VwaXzgKI7lIOdiUhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4nwqc8Wj2INoKPNb9gHmRIC6MlgQxHsJ1vMNT988AUo43YsUxp+FqvU34hPiJVyMaFyXwaNQB9VtVds76T1hYIv1Sg2mGv0mS3WzkoIAk5ts9JV5GkQjJbP7T0ksE83cUvV/8BBaZRBJEtbv4FDctM3ox5iWH8gPDi2mCsadoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VB0thsLa; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VB0thsLa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787870888; x=1819406888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FHDPnh2kXbwiIr3J36aVtrrBW3VwaXzgKI7lIOdiUhM=;
  b=VB0thsLawCxfK4Dx9KFmsreutQ9toMcr3OkM6pH+aFo52AxFHfmEJC4E
   yov2PrxJt2lmsIwKpRUE37TXSG3sw+2mjDAILHCj5FCavd7mbJ0v/SiY+
   0dxyqEeKR1y00/c7W+bf+QmJPlSBUgTL9k44Wuqha1+37haD7Qmje3NPv
   F/f49Aq8RWZKV+LneO6kpHzoV4914M7G9fFpjkvT3nJR2/ItQncPSBMyF
   YyxyF5EKisdtq1MoDjS5WGppndc02JgwK1VriELcSlICTmDtj7UTj6YNK
   bZWr1c6qXLx8eaQue552lIqgR2+ptv+AljKIoQyf/vh/kDHhAkHTaktmL
   w==;
X-CSE-ConnectionGUID: QwXicRPsQgio+nyPf1StWg==
X-CSE-MsgGUID: YuaRV6nlR5KrD8lO2of8Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113914836"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="113914836"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:06 -0700
X-CSE-ConnectionGUID: Ud/ME5xtREuIFYnu59BIbQ==
X-CSE-MsgGUID: EvkzJBaTQTm8maaTXGd6XQ==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:06 -0700
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
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v2 03/16] KVM: x86/pmu: Rename reserved_bits to eventsel_rsvd in kvm_pmu
Date: Thu, 27 Aug 2026 15:37:42 -0700
Message-ID: <20260827223755.143247-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827223755.143247-1-zide.chen@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
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
v2:
- Replace magic numbers in AMD pmu->eventsel_rsvd.
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/pmu.c              |  6 +++++-
 arch/x86/kvm/svm/pmu.c          | 12 +++++++++---
 arch/x86/kvm/vmx/pmu_intel.c    | 12 ++++++------
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e473796da7d9..90d80483df7f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -580,7 +580,7 @@ struct kvm_pmu {
 	u64 counter_bitmask[2];
 	u64 global_ctrl_rsvd;
 	u64 global_status_rsvd;
-	u64 reserved_bits;
+	u64 eventsel_rsvd;
 	u64 raw_event_mask;
 	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
 	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 8f2effee3b7b..964e74bdaaa7 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -989,7 +989,11 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
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
index 322a3ad580dd..11c9161dc853 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -385,7 +385,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	struct kvm_pmc *pmc;
 	u32 msr = msr_info->index;
 	u64 data = msr_info->data;
-	u64 reserved_bits, diff;
+	u64 eventsel_rsvd, diff;
 
 	switch (msr) {
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
@@ -433,11 +433,11 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -545,7 +545,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	if (entry &&
 	    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) &&
 	    (entry->ebx & (X86_FEATURE_HLE|X86_FEATURE_RTM))) {
-		pmu->reserved_bits ^= HSW_IN_TX;
+		pmu->eventsel_rsvd ^= HSW_IN_TX;
 		pmu->raw_event_mask |= (HSW_IN_TX|HSW_IN_TX_CHECKPOINTED);
 	}
 
@@ -584,7 +584,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	if (perf_capabilities & PERF_CAP_PEBS_FORMAT) {
 		if (perf_capabilities & PERF_CAP_PEBS_BASELINE) {
 			pmu->pebs_enable_rsvd = counter_rsvd;
-			pmu->reserved_bits &= ~ICL_EVENTSEL_ADAPTIVE;
+			pmu->eventsel_rsvd &= ~ICL_EVENTSEL_ADAPTIVE;
 			pmu->pebs_data_cfg_rsvd = ~0xff00000full;
 			intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_0_ADAPTIVE);
 		} else {
-- 
2.55.0

