Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929836;
	b=DiPP5L/jvOD/D+vtjDuwpFT1Ank4aJyy1OC2FP+ipinukSnSmBQ+4epfcnpfjjUVO1Eq
	 rG4jLa8RvKmfT3nz/E1D58ePrlGYTcb7fjbomkvbjSa/vw2WcMvbYKjbB3yHLEiS18ur0
	 TL9iEL8dXesF9tzmBntvsiJbQJh+AgLHTEGmELhmKtYZqPMM8wqE8MWMtqKodfz6HHDBz
	 zvJNqt62OovO/7TvbI+K2mRi1hsKLR8BtNIZ+pQgLHhsPtHUMqCJcPguPQzlUvOxRXHM0
	 qDAR6aHql4OW9pJtXUAcufyIOgy9LgZbbl7UK8IuD5YEFnTMoDvuZRdrU8ZSLXInAFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929836;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SFmb+hy4HKorbgyBaqZcccEpoSz9ywARVderUPBUTvg=;
	b=Vo/G0HQtFMKY8a3TGZTaAmuJSxnXMqQrNgbDAI1JaUDRbSrrg4KQl9UsREFtHcW6aLmU
	 9ObCAMoRf3aQu31RshuGDI8//eOb9X2BzBJF/nJQMdkSq6HXH1Qq4K7yRlo1VylOi8Edj
	 tKuF4ZKADjZdomli5GQ7Zo8tOgzKTg/EBTI62p1dq48IKgexJqyoUuSNTOkgiraQiJ07L
	 d1ttEe/1g26QzrB5O2RH8f7KOyIp4FeXohLyuv7sRaOqDdxMD0xqnfwchIEfaJXISzao9
	 ANGZwP4ic8LZT5VZusEKhE/JhclYxfWLv2GQWvDkFX4jYOd1HVaH6z7kJ70RX6EUf3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LALK1EHY;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A25E606A33E;
	Fri,  6 Nov 2026 01:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A25E606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LALK1EHY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793929834; x=1825465834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0dlyP/B9TY5xzaEGUjVAwzLzhxZjBP32c5FTODwdM3g=;
  b=LALK1EHYIyWfKLFXnrpQpsbmtUKsCG6YZFLY3Y79NZyl9lxgvug7d7XU
   lIA1axLMNlWXTh+9uGIBa1X72shcRg4m6Opl64ZmH9hi4eu45ref95CJ3
   RvNUTBgkjL4W6HBg4p2OyFsh7pO11gSDEEGjDlTnAe/pYtsw+di6asgn+
   vwWywxy74ObM7jg9u5bc9uKk0BSVHmDb2N89Je8LXvCKlvI8lJPlj+0zH
   T2mcHgeieh3R2XyV+eS078IbXh6K/adiWuS8cazALesxRmf+J/vUdX/C4
   yREq0NA9QN0p8G8kPCm8EBxh/opYp0FODabqnUYEbWxJFZSoUx3JvgTVA
   Q==;
X-CSE-ConnectionGUID: 4/1cdiapREecU+o4Vdj2Kg==
X-CSE-MsgGUID: i5cAHCT4SKmc0fylXDAvFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740142"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2740142"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:31 -0800
X-CSE-ConnectionGUID: i8KQ1t/eSIS31vuw6lTkOw==
X-CSE-MsgGUID: tuJ3nPl+Q++ntsHCnbhQiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067179"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:31 -0800
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
Subject: [PATCH v3 05/18] KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters from kvm_pmu
Date: Thu,  5 Nov 2026 18:39:14 -0700
Message-ID: <20261106013927.166209-6-zide.chen@intel.com>
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Populate and use pmc_exists directly when walking guest-visible PMCs,
instead of relying on pmu->nr_arch_{gp,fixed}_counters as intermediate
state, in preparation for switching KVM's host PMU capabilities from
counter counts to counter bitmaps.

Iterate counters via the newly added pmc_exists based helpers, and
remove the now-redundant nr_arch_{gp,fixed}_counters fields from struct
kvm_pmu. Consolidate PMU MSR intercept setup in VMX and SVM into single
loops.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3:
- Consolidate PMU MSR intercept setup into single loops in VMX and SVM.
- Rename fixed_cntr_mask to fixed_mask in intel_pmu_refresh().
- Fix 32-bit zero-extension bug in pebs_enable_rsvd calculation
  by explicitly casting to u64. (Sashiko)

v2:
- Fix AMD legacy PMU MSR intercept handling for guest PMU
  narrowing reconfiguration by adding for_each_clear_bit_from().
- Re-word the stale interception changelog part.
---
 arch/x86/include/asm/kvm_host.h |  2 --
 arch/x86/kvm/pmu.c              | 26 +++++++++----------
 arch/x86/kvm/svm/pmu.c          | 25 ++++++++----------
 arch/x86/kvm/svm/svm.c          | 13 ++++------
 arch/x86/kvm/vmx/nested.c       |  6 +++--
 arch/x86/kvm/vmx/pmu_intel.c    | 46 ++++++++++++++++++++++-----------
 arch/x86/kvm/vmx/vmx.c          | 26 +++++++++----------
 7 files changed, 75 insertions(+), 69 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4f192429ed93..8097d106d157 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -570,8 +570,6 @@ struct kvm_pmc {
 
 struct kvm_pmu {
 	u8 version;
-	unsigned nr_arch_gp_counters;
-	unsigned nr_arch_fixed_counters;
 	unsigned available_event_types;
 	u64 fixed_ctr_ctrl;
 	u64 fixed_ctr_ctrl_hw;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 5e174d95f3b7..6cd67f044b6e 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -787,8 +787,8 @@ static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
 	 * KVM's capabilities are constrained based on KVM support, i.e. KVM's
 	 * capabilities themselves may be a subset of hardware capabilities.
 	 */
-	return pmu->nr_arch_gp_counters != kvm_host_pmu.num_counters_gp ||
-	       pmu->nr_arch_fixed_counters != kvm_host_pmu.num_counters_fixed;
+	return kvm_gp_pmc_mask(pmu) != BIT_ULL(kvm_host_pmu.num_counters_gp) - 1 ||
+	       kvm_fixed_pmc_mask(pmu) != BIT_ULL(kvm_host_pmu.num_counters_fixed) - 1;
 }
 
 bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
@@ -979,8 +979,6 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	kvm_pmu_reset(vcpu);
 
 	pmu->version = 0;
-	pmu->nr_arch_gp_counters = 0;
-	pmu->nr_arch_fixed_counters = 0;
 	pmu->counter_bitmask[KVM_PMC_GP] = 0;
 	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
 	/*
@@ -1008,16 +1006,12 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	 * in the global controls).  Emulate that behavior when refreshing the
 	 * PMU so that userspace doesn't need to manually set PERF_GLOBAL_CTRL.
 	 */
-	if (pmu->nr_arch_gp_counters &&
+	if (kvm_gp_pmc_mask(pmu) &&
 	    (kvm_pmu_has_perf_global_ctrl(pmu) || kvm_vcpu_has_mediated_pmu(vcpu)))
-		pmu->global_ctrl = GENMASK_ULL(pmu->nr_arch_gp_counters - 1, 0);
+		pmu->global_ctrl = kvm_gp_pmc_mask(pmu);
 
 	if (kvm_vcpu_has_mediated_pmu(vcpu))
 		kvm_pmu_call(write_global_ctrl)(pmu->global_ctrl);
-
-	bitmap_set(pmu->pmc_exists, 0, pmu->nr_arch_gp_counters);
-	bitmap_set(pmu->pmc_exists, KVM_FIXED_PMC_BASE_IDX,
-		   pmu->nr_arch_fixed_counters);
 }
 
 void kvm_pmu_init(struct kvm_vcpu *vcpu)
@@ -1328,6 +1322,8 @@ static __always_inline u32 gp_eventsel_msr(u32 idx)
 static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
+	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
 	struct kvm_pmc *pmc;
 	u32 i;
 
@@ -1336,14 +1332,14 @@ static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
 	 * is intercepted if hardware has counters that aren't visible to the
 	 * guest (KVM will inject #GP as appropriate).
 	 */
-	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+	kvm_for_each_gp_counter(i, gp_mask) {
 		pmc = &pmu->gp_counters[i];
 
 		if (pmc->counter != rdpmc(i))
 			wrmsrq(gp_counter_msr(i), pmc->counter);
 		wrmsrq(gp_eventsel_msr(i), pmc->eventsel_hw);
 	}
-	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
+	kvm_for_each_fixed_counter(i, fixed_mask) {
 		pmc = &pmu->fixed_counters[i];
 
 		if (pmc->counter != rdpmc(INTEL_PMC_FIXED_RDPMC_BASE | i))
@@ -1386,6 +1382,8 @@ void kvm_mediated_pmu_load(struct kvm_vcpu *vcpu)
 static void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
+	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
 	struct kvm_pmc *pmc;
 	u32 i;
 
@@ -1393,7 +1391,7 @@ static void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu)
 	 * Clear selectors and counters to ensure hardware doesn't count using
 	 * guest controls when the host (perf) restores its state.
 	 */
-	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+	kvm_for_each_gp_counter(i, gp_mask) {
 		pmc = &pmu->gp_counters[i];
 
 		pmc->counter = rdpmc(i);
@@ -1403,7 +1401,7 @@ static void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu)
 			wrmsrq(gp_eventsel_msr(i), 0);
 	}
 
-	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
+	kvm_for_each_fixed_counter(i, fixed_mask) {
 		pmc = &pmu->fixed_counters[i];
 
 		pmc->counter = rdpmc(INTEL_PMC_FIXED_RDPMC_BASE | i);
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 52224872e0d4..0943ccc1d6b8 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -27,12 +27,11 @@ enum pmu_type {
 
 static struct kvm_pmc *amd_pmu_get_pmc(struct kvm_pmu *pmu, int pmc_idx)
 {
-	unsigned int num_counters = pmu->nr_arch_gp_counters;
-
-	if (pmc_idx >= num_counters)
+	if (!kvm_is_gp_pmc_supported(pmu, pmc_idx))
 		return NULL;
 
-	return &pmu->gp_counters[array_index_nospec(pmc_idx, num_counters)];
+	pmc_idx = array_index_nospec(pmc_idx, KVM_MAX_NR_AMD_GP_COUNTERS);
+	return &pmu->gp_counters[pmc_idx];
 }
 
 static inline struct kvm_pmc *get_gp_pmc_amd(struct kvm_pmu *pmu, u32 msr,
@@ -77,7 +76,7 @@ static int amd_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 
-	if (idx >= pmu->nr_arch_gp_counters)
+	if (!kvm_is_gp_pmc_supported(pmu, idx))
 		return -EINVAL;
 
 	return 0;
@@ -117,7 +116,7 @@ static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 		return pmu->version > 1;
 	default:
 		if (msr > MSR_F15H_PERF_CTR5 &&
-		    msr < MSR_F15H_PERF_CTL0 + 2 * pmu->nr_arch_gp_counters)
+		    msr < MSR_F15H_PERF_CTL0 + 2 * hweight_long(kvm_gp_pmc_mask(pmu)))
 			return pmu->version > 1;
 		break;
 	}
@@ -184,6 +183,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 {
+	unsigned int nr_gp_counters = AMD64_NUM_COUNTERS;
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	union cpuid_0x80000022_ebx ebx;
 
@@ -197,18 +197,16 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 		BUILD_BUG_ON(x86_feature_cpuid(X86_FEATURE_PERFMON_V2).function != 0x80000022 ||
 			     x86_feature_cpuid(X86_FEATURE_PERFMON_V2).index);
 		ebx.full = kvm_find_cpuid_entry_index(vcpu, 0x80000022, 0)->ebx;
-		pmu->nr_arch_gp_counters = ebx.split.num_core_pmc;
+		nr_gp_counters = ebx.split.num_core_pmc;
 	} else if (guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_CORE)) {
-		pmu->nr_arch_gp_counters = AMD64_NUM_COUNTERS_CORE;
-	} else {
-		pmu->nr_arch_gp_counters = AMD64_NUM_COUNTERS;
+		nr_gp_counters = AMD64_NUM_COUNTERS_CORE;
 	}
 
-	pmu->nr_arch_gp_counters = min_t(unsigned int, pmu->nr_arch_gp_counters,
-					 kvm_pmu_cap.num_counters_gp);
+	pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
+			    (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
 
 	if (pmu->version > 1) {
-		pmu->global_ctrl_rsvd = ~(BIT_ULL(pmu->nr_arch_gp_counters) - 1);
+		pmu->global_ctrl_rsvd = ~pmu->pmc_exists64;
 		pmu->global_status_rsvd = pmu->global_ctrl_rsvd;
 	}
 
@@ -227,7 +225,6 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
 	/* not applicable to AMD; but clean them to prevent any fall out */
 	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
-	pmu->nr_arch_fixed_counters = 0;
 }
 
 static void amd_pmu_init(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 136069dfcd44..e21abcedea70 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -761,24 +761,21 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 {
 	bool intercept = !kvm_vcpu_has_mediated_pmu(vcpu);
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
 	int i;
 
 	if (!enable_mediated_pmu)
 		return;
 
 	/* Legacy counters are always available for AMD CPUs with a PMU. */
-	for (i = 0; i < min(pmu->nr_arch_gp_counters, AMD64_NUM_COUNTERS); i++)
+	for (i = 0; i < AMD64_NUM_COUNTERS; i++)
 		svm_set_intercept_for_msr(vcpu, MSR_K7_PERFCTR0 + i,
-					  MSR_TYPE_RW, intercept);
+					  MSR_TYPE_RW, intercept || !test_bit(i, &gp_mask));
 
 	intercept |= !guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_CORE);
-	for (i = 0; i < pmu->nr_arch_gp_counters; i++)
+	for (i = 0; i < kvm_pmu_cap.num_counters_gp; i++)
 		svm_set_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i,
-					  MSR_TYPE_RW, intercept);
-
-	for ( ; i < kvm_pmu_cap.num_counters_gp; i++)
-		svm_enable_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i,
-					     MSR_TYPE_RW);
+					  MSR_TYPE_RW, intercept || !test_bit(i, &gp_mask));
 
 	intercept = kvm_need_perf_global_ctrl_intercept(vcpu);
 	svm_set_intercept_for_msr(vcpu, MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f854c..6dade9d26d1a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -704,6 +704,8 @@ static void nested_vmx_merge_pmu_msr_bitmaps(struct kvm_vcpu *vcpu,
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
+	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
 	int i;
 
 	/*
@@ -713,12 +715,12 @@ static void nested_vmx_merge_pmu_msr_bitmaps(struct kvm_vcpu *vcpu,
 	if (!kvm_vcpu_has_mediated_pmu(vcpu))
 		return;
 
-	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+	kvm_for_each_gp_counter(i, gp_mask) {
 		nested_vmx_merge_msr_bitmaps_rw(MSR_IA32_PERFCTR0 + i);
 		nested_vmx_merge_msr_bitmaps_rw(MSR_IA32_PMC0 + i);
 	}
 
-	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
+	kvm_for_each_fixed_counter(i, fixed_mask)
 		nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_FIXED_CTR0 + i);
 
 	nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_GLOBAL_CTRL);
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index fadc466cd600..7770200d0e91 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -66,12 +66,13 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 	 * hardware, e.g. to ensure the event filter is enforced.
 	 */
 	u64 old_fixed_ctr_ctrl = pmu->fixed_ctr_ctrl_hw;
+	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
 	struct kvm_pmc *pmc;
 	int i;
 
 	pmu->fixed_ctr_ctrl = data;
 	pmu->fixed_ctr_ctrl_hw = data;
-	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
+	kvm_for_each_fixed_counter(i, fixed_mask) {
 		u8 new_ctrl = fixed_ctrl_field(data, i);
 		u8 old_ctrl = fixed_ctrl_field(old_fixed_ctr_ctrl, i);
 
@@ -107,6 +108,8 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 	if (WARN_ON_ONCE(!pmu->version))
 		return NULL;
 
+	idx &= INTEL_RDPMC_INDEX_MASK;
+
 	/*
 	 * General Purpose (GP) PMCs are supported on all PMUs, and fixed PMCs
 	 * are supported on all architectural PMUs, i.e. on all virtual PMUs
@@ -117,23 +120,25 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 	 */
 	switch (type) {
 	case INTEL_RDPMC_FIXED:
+		if (!kvm_is_fixed_pmc_supported(pmu, idx))
+			return NULL;
+
 		counters = pmu->fixed_counters;
-		num_counters = pmu->nr_arch_fixed_counters;
+		num_counters = KVM_MAX_NR_INTEL_FIXED_COUNTERS;
 		bitmask = pmu->counter_bitmask[KVM_PMC_FIXED];
 		break;
 	case INTEL_RDPMC_GP:
+		if (!kvm_is_gp_pmc_supported(pmu, idx))
+			return NULL;
+
 		counters = pmu->gp_counters;
-		num_counters = pmu->nr_arch_gp_counters;
+		num_counters = KVM_MAX_NR_INTEL_GP_COUNTERS;
 		bitmask = pmu->counter_bitmask[KVM_PMC_GP];
 		break;
 	default:
 		return NULL;
 	}
 
-	idx &= INTEL_RDPMC_INDEX_MASK;
-	if (idx >= num_counters)
-		return NULL;
-
 	*mask &= bitmask;
 	return &counters[array_index_nospec(idx, num_counters)];
 }
@@ -495,9 +500,10 @@ static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
 
 static void intel_pmu_enable_fixed_counter_bits(struct kvm_pmu *pmu, u64 bits)
 {
+	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
 	int i;
 
-	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
+	kvm_for_each_fixed_counter(i, fixed_mask)
 		pmu->fixed_ctr_ctrl_rsvd &= ~intel_fixed_bits_by_idx(i, bits);
 }
 
@@ -509,6 +515,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	union cpuid10_eax eax;
 	union cpuid10_edx edx;
 	u64 perf_capabilities;
+	u64 fixed_mask;
+	int nr_gp_counters;
 	u64 counter_rsvd;
 
 	if (!lbr_desc)
@@ -535,8 +543,6 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	if (!pmu->version)
 		return;
 
-	pmu->nr_arch_gp_counters = min_t(int, eax.split.num_counters,
-					 kvm_pmu_cap.num_counters_gp);
 	eax.split.bit_width = min_t(int, eax.split.bit_width,
 				    kvm_pmu_cap.bit_width_gp);
 	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(eax.split.bit_width) - 1;
@@ -544,6 +550,17 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 				      kvm_pmu_cap.events_mask_len);
 	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
 
+	fixed_mask = BIT_ULL(edx.split.num_counters_fixed) - 1;
+	fixed_mask &= BIT_ULL(kvm_pmu_cap.num_counters_fixed) - 1;
+
+	/*
+	 * The number of counters comes from guest CPUID data. Clamp the value
+	 * to avoid a shift-by-64 in BIT_ULL().
+	 */
+	nr_gp_counters = min_t(int, eax.split.num_counters, X86_PMC_IDX_MAX - 1);
+	pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
+			    (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
+
 	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
 	if (entry &&
 	    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) &&
@@ -565,8 +582,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	if (pmu->version == 1)
 		return;
 
-	pmu->nr_arch_fixed_counters = min_t(int, edx.split.num_counters_fixed,
-					    kvm_pmu_cap.num_counters_fixed);
+	pmu->pmc_exists64 |= fixed_mask << INTEL_PMC_IDX_FIXED;
 	edx.split.bit_width_fixed = min_t(int, edx.split.bit_width_fixed,
 					  kvm_pmu_cap.bit_width_fixed);
 	pmu->counter_bitmask[KVM_PMC_FIXED] = BIT_ULL(edx.split.bit_width_fixed) - 1;
@@ -575,8 +591,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 						 INTEL_FIXED_0_USER |
 						 INTEL_FIXED_0_ENABLE_PMI);
 
-	counter_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
-			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
+	counter_rsvd = ~((u64)kvm_gp_pmc_mask(pmu) |
+			 ((u64)kvm_fixed_pmc_mask(pmu) << KVM_FIXED_PMC_BASE_IDX));
 	pmu->global_ctrl_rsvd = counter_rsvd;
 
 	pmu->global_status_rsvd = pmu->global_ctrl_rsvd
@@ -591,7 +607,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 			pmu->pebs_data_cfg_rsvd = ~0xff00000full;
 			intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_0_ADAPTIVE);
 		} else {
-			pmu->pebs_enable_rsvd = ~(BIT_ULL(pmu->nr_arch_gp_counters) - 1);
+			pmu->pebs_enable_rsvd = ~(u64)kvm_gp_pmc_mask(pmu);
 		}
 	}
 }
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index efde96e15533..944ecbf351cf 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4242,6 +4242,8 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 	bool has_mediated_pmu = kvm_vcpu_has_mediated_pmu(vcpu);
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
+	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
 	bool intercept = !has_mediated_pmu;
 	int i;
 
@@ -4262,25 +4264,21 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 
 	vm_exit_controls_changebit(vmx, vm_exit_controls_bits, has_mediated_pmu);
 
-	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+	for (i = 0; i < kvm_pmu_cap.num_counters_gp; i++) {
+		bool pmc_intercept = intercept || !test_bit(i, &gp_mask);
+
 		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PERFCTR0 + i,
-					  MSR_TYPE_RW, intercept);
+					  MSR_TYPE_RW, pmc_intercept);
 		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PMC0 + i, MSR_TYPE_RW,
-					  intercept || !fw_writes_is_enabled(vcpu));
-	}
-	for ( ; i < kvm_pmu_cap.num_counters_gp; i++) {
-		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PERFCTR0 + i,
-					  MSR_TYPE_RW, true);
-		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PMC0 + i,
-					  MSR_TYPE_RW, true);
+					  pmc_intercept || !fw_writes_is_enabled(vcpu));
 	}
 
-	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
-		vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_FIXED_CTR0 + i,
-					  MSR_TYPE_RW, intercept);
-	for ( ; i < kvm_pmu_cap.num_counters_fixed; i++)
+	for (i = 0; i < kvm_pmu_cap.num_counters_fixed; i++) {
+		bool pmc_intercept = intercept || !test_bit(i, &fixed_mask);
+
 		vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_FIXED_CTR0 + i,
-					  MSR_TYPE_RW, true);
+					  MSR_TYPE_RW, pmc_intercept);
+	}
 
 	intercept = kvm_need_perf_global_ctrl_intercept(vcpu);
 	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_STATUS,
-- 
2.56.0

