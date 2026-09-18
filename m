Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98D522F01;
	Fri, 18 Sep 2026 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761006; cv=none; b=ep3anXq2axLFA7QVqM57SLDAiwS6mVAO5JITikhVyMdFRbP++0hvSPyessDaIkmpYb9DApNT/w3+DCMmArwpGV1lt76dqi36eCYKKeLPbtsXB8xdxSiTo16J1KA9q2g8Yj2FGVKVt2WjBq2hUs56HhCY7zgwoRDtuBQDJsAP28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761006; c=relaxed/simple;
	bh=BKRFDfnKCzT1VG4FRCGZoTY9QdK+Hm3mkGxLVEceKvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2kBQGoX0ZaH+VHf0vMFNM7gPqAqvG1NBg9bGY7xZJ+jV85cMNjw4obstRytGDU/RjFWbFtDohQlAw2RLQjHn8mGZJ5zy3KviR1laZtVA8lTYO6qwGEHqV0GwX361Xz5M4WGOOl2QyPnd/AOf+QnEKygOP1qNZnMZjD3w4kQ1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nePmEWaO; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nePmEWaO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789761004; x=1821297004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BKRFDfnKCzT1VG4FRCGZoTY9QdK+Hm3mkGxLVEceKvI=;
  b=nePmEWaO1v2HMCCVIU5jgnvCryk0v0vGFuiTu/ntUROIrR3oKRoCIb1t
   MfidApDGFC8Wy0T9CjAmpRVfIYRWiA8v7pZhl1yrBtWCsOs4gZW2VfJEG
   2CyqkkYpjdwd+cpVcD5BYyXKFldStiJ3zCVgRSkINZm7Cqyria0iccYmn
   gRtvHJ9UBkMSDKg/o6y6VIRylhbhVCykqVlhi1F18TN2E/ayv9kUCITmm
   5/4EVHa2Lo+yyoY8XTQWAEKhDAxEZhdZ6r2no3u4ArQj8b1vPau5kIoRa
   5QzUsaQdGgibokHxjbGIJTrFVGpuHc9KhzlExLAF0d3KaxjqKekJbhfde
   w==;
X-CSE-ConnectionGUID: 5l/wjelOS9mHePM74H7DnA==
X-CSE-MsgGUID: 88I6WIhJTw6Yr+7XuMZdQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="790322"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="790322"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:50:00 -0700
X-CSE-ConnectionGUID: K4v+RmgTQ9KUY5YlxyZk7Q==
X-CSE-MsgGUID: cOoqMGiTS6O1EoEvJm6ANA==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:49:59 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v9 05/12] KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU
Date: Fri, 18 Sep 2026 12:39:30 -0700
Message-ID: <20260918193937.569414-6-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918193937.569414-1-zide.chen@intel.com>
References: <20260918193937.569414-1-zide.chen@intel.com>
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
enabled and bit 15 is set in guest IA32_PERF_CAPABILITIES.  Allow
kvm_pmu_{get,set}_msr() to handle this MSR for host accesses.

Save and restore this MSR on host/guest PMU context switches so that
host PMU activity does not clobber the guest value, and guest state
is not leaked into the host.

If the host supports PERF_METRICS but it is not exposed to the guest,
MSR_CORE_PERF_GLOBAL_CTRL must be intercepted so the guest cannot
enable PERF_METRICS via GLOBAL_CTRL[48].

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v9:
- Remove the incorrect comment about writing to MSR_PERF_METRICS.
v8:
- Intercept global ctrl MSR if host supports PerfMetrics but not
  enabled in the guest.
---
 arch/x86/include/asm/kvm_host.h  |  1 +
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/kvm/msrs.c              |  6 +++++-
 arch/x86/kvm/pmu.c               |  7 +++++++
 arch/x86/kvm/pmu.h               |  5 +++++
 arch/x86/kvm/vmx/nested.c        |  2 ++
 arch/x86/kvm/vmx/pmu_intel.c     | 29 +++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c           |  7 +++++++
 8 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d00c7cbcfa14..052bf377dedb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -584,6 +584,7 @@ struct kvm_pmu {
 	u64 global_status_rsvd;
 	u64 reserved_bits;
 	u64 raw_event_mask;
+	u64 perf_metrics;
 	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
 	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3a8e51a0c9e8..8fad944197fb 100644
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
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 45e4c8a32436..7b7b5db00f54 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -219,7 +219,7 @@ static const u32 msrs_to_save_pmu[] = {
 	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
 	MSR_ARCH_PERFMON_FIXED_CTR2, MSR_ARCH_PERFMON_FIXED_CTR3,
 	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
-	MSR_CORE_PERF_GLOBAL_CTRL,
+	MSR_CORE_PERF_GLOBAL_CTRL, MSR_PERF_METRICS,
 	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
 
 	/* This part of MSRs should match KVM_MAX_NR_INTEL_GP_COUNTERS. */
@@ -2609,6 +2609,10 @@ static void kvm_probe_msr_to_save(u32 msr_index)
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
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 448044a2b121..f4d3801b97bc 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -806,9 +806,16 @@ static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
 	       pmu->nr_arch_fixed_counters != kvm_host_pmu.num_counters_fixed;
 }
 
+static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
+{
+	return (kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS) &&
+		!kvm_vcpu_has_perf_metrics(vcpu);
+}
+
 bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
 {
 	return kvm_need_any_pmc_intercept(vcpu) ||
+	       kvm_need_perf_metrics_intercept(vcpu) ||
 	       !kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu));
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 82f955e5a450..be578013ed83 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -279,6 +279,11 @@ static inline u64 kvm_vcpu_get_perf_caps(struct kvm_vcpu *vcpu)
 	return vcpu->arch.perf_capabilities;
 }
 
+static inline bool kvm_vcpu_has_perf_metrics(struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PERF_METRICS;
+}
+
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
 int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 0e5f4d7ce9eb..a1cf57c6bea1 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -724,6 +724,8 @@ static void nested_vmx_merge_pmu_msr_bitmaps(struct kvm_vcpu *vcpu,
 	nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_GLOBAL_CTRL);
 	nested_vmx_merge_msr_bitmaps_read(MSR_CORE_PERF_GLOBAL_STATUS);
 	nested_vmx_merge_msr_bitmaps_write(MSR_CORE_PERF_GLOBAL_OVF_CTRL);
+
+	nested_vmx_merge_msr_bitmaps_rw(MSR_PERF_METRICS);
 }
 
 /*
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 28c1542e5ba5..fe66f03b006b 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -192,6 +192,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		return kvm_pmu_has_perf_global_ctrl(pmu);
+	case MSR_PERF_METRICS:
+		return kvm_vcpu_has_perf_metrics(vcpu);
 	case MSR_IA32_PEBS_ENABLE:
 		ret = kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PEBS_FORMAT;
 		break;
@@ -349,6 +351,9 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		msr_info->data = pmu->fixed_ctr_ctrl;
 		break;
+	case MSR_PERF_METRICS:
+		msr_info->data = pmu->perf_metrics;
+		break;
 	case MSR_IA32_PEBS_ENABLE:
 		msr_info->data = pmu->pebs_enable;
 		break;
@@ -398,6 +403,9 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (pmu->fixed_ctr_ctrl != data)
 			reprogram_fixed_counters(pmu, data);
 		break;
+	case MSR_PERF_METRICS:
+		pmu->perf_metrics = data;
+		break;
 	case MSR_IA32_PEBS_ENABLE:
 		if (data & pmu->pebs_enable_rsvd)
 			return 1;
@@ -580,6 +588,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	counter_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
 			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
 	pmu->global_ctrl_rsvd = counter_rsvd;
+	if (perf_capabilities & PERF_CAP_PERF_METRICS)
+		pmu->global_ctrl_rsvd &= ~GLOBAL_CTRL_EN_PERF_METRICS;
 
 	/*
 	 * GLOBAL_STATUS and GLOBAL_OVF_CONTROL (a.k.a. GLOBAL_STATUS_RESET)
@@ -636,6 +646,9 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
 
 static void intel_pmu_reset(struct kvm_vcpu *vcpu)
 {
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	pmu->perf_metrics = 0;
 	intel_pmu_release_guest_lbr_event(vcpu);
 }
 
@@ -806,6 +819,9 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	u64 global_status, toggle;
 
+	if (kvm_vcpu_has_perf_metrics(vcpu))
+		wrmsrq(MSR_PERF_METRICS, pmu->perf_metrics);
+
 	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
 	toggle = pmu->global_status ^ global_status;
 	if (global_status & toggle)
@@ -834,6 +850,19 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
 	 */
 	if (pmu->fixed_ctr_ctrl_hw)
 		wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
+
+	if (kvm_vcpu_has_perf_metrics(vcpu)) {
+		pmu->perf_metrics = rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS);
+		/*
+		 * The SDM requires restoring fixed counter 3 before
+		 * PERF_METRICS. However, this path writes 0 to PERF_METRICS
+		 * before fixed counter 3. For this all-zero case, the
+		 * resulting hardware state is therefore the same regardless
+		 * of write order.
+		 */
+		if (pmu->perf_metrics)
+			wrmsrq(MSR_PERF_METRICS, 0);
+	}
 }
 
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 715e44489e22..372de66365ab 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4289,6 +4289,10 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 				  MSR_TYPE_RW, intercept);
 	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
 				  MSR_TYPE_RW, intercept);
+
+	intercept = !has_mediated_pmu || !kvm_vcpu_has_perf_metrics(vcpu);
+	vmx_set_intercept_for_msr(vcpu, MSR_PERF_METRICS,
+				  MSR_TYPE_RW, intercept);
 }
 
 static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
@@ -7994,6 +7998,9 @@ static __init u64 vmx_get_perf_capabilities(void)
 		perf_cap &= ~PERF_CAP_PEBS_BASELINE;
 	}
 
+	if (enable_mediated_pmu)
+		perf_cap |= kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS;
+
 	return perf_cap;
 }
 
-- 
2.55.0

