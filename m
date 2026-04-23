Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD436E46C;
	Thu, 23 Apr 2026 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966901; cv=none; b=QmG1Aa10XRj1yFSGqnTWn8v2qx+Z/YaaogvUYhVEnrqUUObR09ksAYIfrtx+rFu5+8iE9yE2KYllCgV6WN/Bvu8XeAuXTeIBH/P5fxx5dqmZf2PK448noSoJhcPgERx0/3BSWkZmLlycORAXxEcASAUe3EX1VKDfPMc+wCAZa7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966901; c=relaxed/simple;
	bh=cP2y9WqcYA+1GyXSyyah0iOEgioocGdlZShrbcNRhYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvV2M/mD/V35ub5FfurP0peRE7qtq9yb9eoRUNQwWKxOcptDiXjoab7k2aPhlUX/lCtP+GBQkHnqsi9STkZBUpjkBrv6b0VMQi4GqE8TSbwJgK/P4060Xw0lttwfV1zyQWGQflodpucSuOesTFMNPdojVMNcz6ADuFhqY3s2DSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZ0Dgp/Z; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZ0Dgp/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776966899; x=1808502899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cP2y9WqcYA+1GyXSyyah0iOEgioocGdlZShrbcNRhYs=;
  b=gZ0Dgp/Z+kwazSpDks82RHVDTKyZxguVCwZ9lWpPXzwpJ4WeyNMRJXlk
   0NMX+x2B6bXTGOyZKZvF6/HGNUVnQCNAr2mhP7yPWGU4SjNvSkltZNoFR
   99WmQLuiZXnNaWmnvZj1ALQy7eeaEuw2k1Gr4hzjtAejBXaYFBuVLxxON
   4TOzZOMajZtiulhfMAL05KfT9LXUPENdCTq9znqm6XC0mrcc+V14LRn2U
   XJumgP2uOHgPK/BLs71bC9hAD/gcOZAvYwlKlN8ZNYmSXLHIR+e3kiSj7
   yVJ4UxegalAdnd5zMq1sb1M2SSGMjIH8zJ+C73JfasI5y26LEuhNUU6jV
   w==;
X-CSE-ConnectionGUID: amQNPREzTpKdS1sS6kf9MA==
X-CSE-MsgGUID: LQxHzzzcRv+w7cQ4cI8r2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89407726"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="89407726"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 10:54:58 -0700
X-CSE-ConnectionGUID: N59kwrMPTl6ACWigaiUOBA==
X-CSE-MsgGUID: 0TsrwcmDTTqvsvqdLBpiHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="236707818"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 10:54:57 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
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
Subject: [PATCH V2 3/4] KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU
Date: Thu, 23 Apr 2026 10:46:38 -0700
Message-ID: <20260423174639.56149-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260423174639.56149-1-zide.chen@intel.com>
References: <20260423174639.56149-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Bit 15 in IA32_PERF_CAPABILITIES indicates that the CPU provides
built-in support for Topdown Microarchitecture Analysis (TMA) L1
metrics via the IA32_PERF_METRICS MSR.

Expose this capability only when mediated vPMU is enabled, as emulating
IA32_PERF_METRICS in the legacy vPMU model is impractical.

Pass IA32_PERF_METRICS through to the guest only when mediated vPMU is
enabled and bit 15 is set in guest IA32_PERF_CAPABILITIES is.  Allow
kvm_pmu_{get,set}_msr() to handle this MSR for host accesses.

Save and restore this MSR on host/guest PMU context switches so that
host PMU activity does not clobber the guest value, and guest state
is not leaked into the host.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/include/asm/kvm_host.h   |  1 +
 arch/x86/include/asm/msr-index.h  |  1 +
 arch/x86/include/asm/perf_event.h |  1 +
 arch/x86/kvm/vmx/pmu_intel.c      | 31 +++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/pmu_intel.h      |  5 +++++
 arch/x86/kvm/vmx/vmx.c            |  6 ++++++
 arch/x86/kvm/x86.c                |  6 +++++-
 7 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cb736a4c72ea..69a02e58eba2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -576,6 +576,7 @@ struct kvm_pmu {
 	u64 global_status_rsvd;
 	u64 reserved_bits;
 	u64 raw_event_mask;
+	u64 perf_metrics;
 	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
 	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a14a0f43e04a..b60fdf79816a 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -331,6 +331,7 @@
 #define PERF_CAP_PEBS_FORMAT		0xf00
 #define PERF_CAP_FW_WRITES		BIT_ULL(13)
 #define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
+#define PERF_CAP_PERF_METRICS		BIT_ULL(15)
 #define PERF_CAP_PEBS_TIMING_INFO	BIT_ULL(17)
 #define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
 					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 752cb319d5ea..cbfe6a55dea8 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -445,6 +445,7 @@ static inline bool is_topdown_idx(int idx)
 #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT	54
 #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD	BIT_ULL(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT)
 #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT	48
+#define GLOBAL_STATUS_PERF_METRICS_OVF		BIT_ULL(GLOBAL_STATUS_PERF_METRICS_OVF_BIT)
 
 #define GLOBAL_CTRL_EN_PERF_METRICS		BIT_ULL(48)
 /*
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 05a59f4acfdd..a7d862a6f1be 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -180,6 +180,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	switch (msr) {
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		return kvm_pmu_has_perf_global_ctrl(pmu);
+	case MSR_PERF_METRICS:
+		return vcpu_has_perf_metrics(vcpu);
 	case MSR_IA32_PEBS_ENABLE:
 		ret = vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PEBS_FORMAT;
 		break;
@@ -335,6 +337,10 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		msr_info->data = pmu->fixed_ctr_ctrl;
 		break;
+	case MSR_PERF_METRICS:
+		WARN_ON(!msr_info->host_initiated);
+		msr_info->data = pmu->perf_metrics;
+		break;
 	case MSR_IA32_PEBS_ENABLE:
 		msr_info->data = pmu->pebs_enable;
 		break;
@@ -384,6 +390,10 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (pmu->fixed_ctr_ctrl != data)
 			reprogram_fixed_counters(pmu, data);
 		break;
+	case MSR_PERF_METRICS:
+		WARN_ON(!msr_info->host_initiated);
+		pmu->perf_metrics = data;
+		break;
 	case MSR_IA32_PEBS_ENABLE:
 		if (data & pmu->pebs_enable_rsvd)
 			return 1;
@@ -579,6 +589,11 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 		pmu->global_status_rsvd &=
 				~MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI;
 
+	if (perf_capabilities & PERF_CAP_PERF_METRICS) {
+		pmu->global_ctrl_rsvd &= ~GLOBAL_CTRL_EN_PERF_METRICS;
+		pmu->global_status_rsvd &= ~GLOBAL_STATUS_PERF_METRICS_OVF;
+	}
+
 	if (perf_capabilities & PERF_CAP_PEBS_FORMAT) {
 		if (perf_capabilities & PERF_CAP_PEBS_BASELINE) {
 			pmu->pebs_enable_rsvd = counter_rsvd;
@@ -622,6 +637,9 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
 
 static void intel_pmu_reset(struct kvm_vcpu *vcpu)
 {
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	pmu->perf_metrics = 0;
 	intel_pmu_release_guest_lbr_event(vcpu);
 }
 
@@ -793,6 +811,13 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	u64 global_status, toggle;
 
+	/*
+	 * PERF_METRICS MSR must be restored closely after fixed counter 3
+	 * (kvm_pmu_load_guest_pmcs()).
+	 */
+	if (vcpu_has_perf_metrics(vcpu))
+		wrmsrq(MSR_PERF_METRICS, pmu->perf_metrics);
+
 	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
 	toggle = pmu->global_status ^ global_status;
 	if (global_status & toggle)
@@ -821,6 +846,12 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
 	 */
 	if (pmu->fixed_ctr_ctrl_hw)
 		wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
+
+	if (vcpu_has_perf_metrics(vcpu)) {
+		pmu->perf_metrics = rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS);
+		if (pmu->perf_metrics)
+			wrmsrq(MSR_PERF_METRICS, 0);
+	}
 }
 
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
diff --git a/arch/x86/kvm/vmx/pmu_intel.h b/arch/x86/kvm/vmx/pmu_intel.h
index 5d9357640aa1..2ec547223b09 100644
--- a/arch/x86/kvm/vmx/pmu_intel.h
+++ b/arch/x86/kvm/vmx/pmu_intel.h
@@ -40,4 +40,9 @@ struct lbr_desc {
 
 extern struct x86_pmu_lbr vmx_lbr_caps;
 
+static inline bool vcpu_has_perf_metrics(struct kvm_vcpu *vcpu)
+{
+	return !!(vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PERF_METRICS);
+}
+
 #endif /* __KVM_X86_VMX_PMU_INTEL_H */
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a29896a9ef14..d10d86abbce7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4229,6 +4229,9 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 				  MSR_TYPE_RW, intercept);
 	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
 				  MSR_TYPE_RW, intercept);
+
+	vmx_set_intercept_for_msr(vcpu, MSR_PERF_METRICS, MSR_TYPE_RW,
+				  !vcpu_has_perf_metrics(vcpu));
 }
 
 static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
@@ -8074,6 +8077,9 @@ static __init u64 vmx_get_perf_capabilities(void)
 		perf_cap &= ~PERF_CAP_PEBS_BASELINE;
 	}
 
+	if (enable_mediated_pmu)
+		perf_cap |= host_perf_cap & PERF_CAP_PERF_METRICS;
+
 	return perf_cap;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 604072d9354f..d497ffc5d90e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -362,7 +362,7 @@ static const u32 msrs_to_save_pmu[] = {
 	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
 	MSR_ARCH_PERFMON_FIXED_CTR2, MSR_ARCH_PERFMON_FIXED_CTR3,
 	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
-	MSR_CORE_PERF_GLOBAL_CTRL,
+	MSR_CORE_PERF_GLOBAL_CTRL, MSR_PERF_METRICS,
 	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
 
 	/* This part of MSRs should match KVM_MAX_NR_INTEL_GP_COUNTERS. */
@@ -7693,6 +7693,10 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 		     intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) * 2))
 			return;
 		break;
+	case MSR_PERF_METRICS:
+		if (!(kvm_caps.supported_perf_cap & PERF_CAP_PERF_METRICS))
+			return;
+		break;
 	case MSR_ARCH_PERFMON_PERFCTR0 ...
 	     MSR_ARCH_PERFMON_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
 		if (msr_index - MSR_ARCH_PERFMON_PERFCTR0 >=
-- 
2.53.0

