Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516229;
	b=P4rAytBd1vds4sonVwQuQBNTaIqCUVje3Jz2J9Lb0tCfLZ9+/bRuh0aYMxCvxyY3HCs6
	 +d++RPNIvTVg+3O68ytCroUREovAUFjpt0kF8DywQ7/DLUX0W8HdXDB52LOJyZ6Dr93+W
	 sjkm0gl1dx8fkIqJUsmd6rEGu9bQgacawZLyYvSXgKqlja/8cxCx0JqlKYGx2bb5s5RYa
	 U83oH1c0wQIBR1qRdc4nfr4fxbSe9fDENYywhfVg4duupswrFQ7GukSAp2Mk8/xj8+J1w
	 feb0BUM2OtOUkoLu66SCVFllauneWY30FSDFCLc8xfMqJku3seXaqAAp1UBbJA/iyfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516229;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1SJibv4nw9/afCBuP+nWxXXrfId8ZU9kV+jh82GEElA=;
	b=bYo5zhQ2L+tnxZEnNzMYNdMGbAqJiu2mD0K7GzyRrRmIkEbdp927t6PX/OQs5Sk1a9sQ
	 C0loBl+j9ymwNISvACILQ6XuYdsyAt86z/CHEfrXTuQOEbgs4zm+zv/y8pQGQSzA+tYzm
	 1JEKy/zJkXjAwXzJUD86T+lgAhE65lwlnCjhQr/htHfaRKlvqZGwmsYuuOhKaGXtiLfRm
	 OeU3IUHsVbTlKURyWrbDtwHrijzvjkvrjZscyX1GxKpKl0gCmxss8srKq5k9Uztsxj62Q
	 dvsgslJk3+i/cIsc1YNOYU0jnC4bEwufNIC6oVX+m3OpjH5qrdsr7oW0U7xpdpmqwdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LMaVdIMl;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A7C606A896;
	Thu, 12 Nov 2026 20:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7A7C606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LMaVdIMl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516229; x=1826052229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gvqMHoAG364LNiqUYETIppzqc5tfOm8BE2WxdNRhwc4=;
  b=LMaVdIMlQKNPRbqRkX9QiEzmmeKz3bRdgMLgx5DG3YnA3WXfbu+hBmPK
   nvFmV7DfY2snTxk6/UaDjm9V4b2Qg1X89rJWCEpWTJ02uD6PPVT1f0hjK
   BVVoe4gja3mv7NW8JDaZFd2oTPgXxTVoeoTUL5/sVlUj+fS/s6YmIxRsN
   QnSvBs2+BQaoQgukpz6qypYFFI7zuKW/wTfSRKprVtQe6CojUa60gS4AB
   w+WHT3+QXfOWekMySsUzPJeHPbft/M4wudgYP1V0SBkWOFz6hvWKTELeT
   347lqyrnJKH4N8G1e/m07u2i6uKz0tKJHW3VjIJ8pyrSNLou18UvK7ffj
   w==;
X-CSE-ConnectionGUID: XpevKJj0QBSM65Zl7Rd3hA==
X-CSE-MsgGUID: P0GfliUgRy6jIpD0ne4rbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192244"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192244"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:48 -0800
X-CSE-ConnectionGUID: YbHJs5LtRRKvOiknSaPZfg==
X-CSE-MsgGUID: UYnDz/tTSKezpsqAxDmVyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087882"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:48 -0800
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
Subject: [PATCH v4 06/21] KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters from kvm_pmu
Date: Thu, 12 Nov 2026 13:32:12 -0700
Message-ID: <20261112203227.289379-7-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261112203227.289379-1-zide.chen@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
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

Extend pmu->pmc_exists to a union so that the u64 alias (pmc_exists64)
is available for mask arithmetic operations. Introduce
kvm_{gp,fixed}_pmc_mask() to extract the respective counter bitmasks,
and provide the kvm_for_each_{gp,fixed}_counter() iterator macros to
replace open-coded counter index loops.

Consolidate PMU MSR intercept setup in VMX and SVM into single loops.
In SVM, this also fixes legacy counter interception by re-enabling
intercepts if a vCPU's counter count is narrowed.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v4:
- In intel_pmu_refresh(), directly clamp guest counters against
  kvm_pmu_cap.num_counters_{gp,fixed} using min_t() instead of
  temporary BIT_ULL() mask ANDing, avoiding intermediate code churn
  with the subsequent bitmask capability conversion.
- Move pmc_exists64 union, BUILD_BUG_ON(), kvm_{gp,fixed}_pmc_mask(),
  and kvm_for_each_{gp,fixed}_counter() to this patch where they are
  first used, and return u64 to avoid casts and 32-bit truncation
  hazards. (Yosry)
- Pass 'pmu' directly to kvm_for_each_{gp,fixed}_counter() using
  compound literals. (Yosry)
- In reprogram_fixed_counters(), directly index &pmu->fixed_counters[i]
  instead of calling get_fixed_pmc(). (Yosry)
- In intel_rdpmc_ecx_to_pmc(), rename 'num_counters' to
  'max_nr_counters'. (Yosry)

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
 arch/x86/include/asm/kvm_host.h |  7 ++---
 arch/x86/kvm/pmu.c              | 24 +++++++----------
 arch/x86/kvm/pmu.h              | 23 ++++++++++++++++
 arch/x86/kvm/svm/pmu.c          | 23 +++++++---------
 arch/x86/kvm/svm/svm.c          | 13 ++++-----
 arch/x86/kvm/vmx/nested.c       |  4 +--
 arch/x86/kvm/vmx/pmu_intel.c    | 47 ++++++++++++++++++++-------------
 arch/x86/kvm/vmx/vmx.c          | 26 +++++++++---------
 8 files changed, 95 insertions(+), 72 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b8875ed5502c..8097d106d157 100644
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
@@ -595,7 +593,10 @@ struct kvm_pmu {
 		DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
 		atomic64_t __reprogram_pmi;
 	};
-	DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
+	union {
+		DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
+		u64 pmc_exists64;
+	};
 	DECLARE_BITMAP(pmc_in_use, X86_PMC_IDX_MAX);
 
 	DECLARE_BITMAP(pmc_counting_instructions, X86_PMC_IDX_MAX);
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index cbd63329cf13..484dfd2eba10 100644
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
@@ -1008,22 +1006,20 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
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
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 
+	BUILD_BUG_ON(sizeof(pmu->pmc_exists) != sizeof(pmu->pmc_exists64));
+
 	memset(pmu, 0, sizeof(*pmu));
 	kvm_pmu_call(init)(vcpu);
 }
@@ -1334,14 +1330,14 @@ static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
 	 * is intercepted if hardware has counters that aren't visible to the
 	 * guest (KVM will inject #GP as appropriate).
 	 */
-	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+	kvm_for_each_gp_counter(i, pmu) {
 		pmc = &pmu->gp_counters[i];
 
 		if (pmc->counter != rdpmc(i))
 			wrmsrq(gp_counter_msr(i), pmc->counter);
 		wrmsrq(gp_eventsel_msr(i), pmc->eventsel_hw);
 	}
-	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
+	kvm_for_each_fixed_counter(i, pmu) {
 		pmc = &pmu->fixed_counters[i];
 
 		if (pmc->counter != rdpmc(INTEL_PMC_FIXED_RDPMC_BASE | i))
@@ -1391,7 +1387,7 @@ static void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu)
 	 * Clear selectors and counters to ensure hardware doesn't count using
 	 * guest controls when the host (perf) restores its state.
 	 */
-	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+	kvm_for_each_gp_counter(i, pmu) {
 		pmc = &pmu->gp_counters[i];
 
 		pmc->counter = rdpmc(i);
@@ -1401,7 +1397,7 @@ static void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu)
 			wrmsrq(gp_eventsel_msr(i), 0);
 	}
 
-	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
+	kvm_for_each_fixed_counter(i, pmu) {
 		pmc = &pmu->fixed_counters[i];
 
 		pmc->counter = rdpmc(INTEL_PMC_FIXED_RDPMC_BASE | i);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index fbab4f5c9181..b312f80f5cda 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -88,6 +88,18 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
 	return enable_mediated_pmu && vcpu_to_pmu(vcpu)->version;
 }
 
+static inline u64 kvm_gp_pmc_mask(struct kvm_pmu *pmu)
+{
+	return pmu->pmc_exists64 &
+	       GENMASK_ULL(KVM_MAX_NR_GP_COUNTERS - 1, 0);
+}
+
+static inline u64 kvm_fixed_pmc_mask(struct kvm_pmu *pmu)
+{
+	return (pmu->pmc_exists64 >> KVM_FIXED_PMC_BASE_IDX) &
+	       GENMASK_ULL(KVM_MAX_NR_FIXED_COUNTERS - 1, 0);
+}
+
 static inline bool kvm_is_gp_pmc_supported(struct kvm_pmu *pmu, unsigned int idx)
 {
 	return idx < KVM_MAX_NR_GP_COUNTERS &&
@@ -132,6 +144,17 @@ static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
 			continue;				\
 		else						\
 
+/*
+ * Iterate over all general-purpose or fixed counters supported by @pmu.
+ */
+#define kvm_for_each_gp_counter(i, pmu)	\
+	for_each_set_bit((i), &(unsigned long){ kvm_gp_pmc_mask(pmu) }, KVM_MAX_NR_GP_COUNTERS)
+
+#define kvm_for_each_fixed_counter(i, pmu)				\
+	for_each_set_bit((i),						\
+			 &(unsigned long){ kvm_fixed_pmc_mask(pmu) },	\
+			 KVM_MAX_NR_FIXED_COUNTERS)
+
 static inline u64 pmc_bitmask(struct kvm_pmc *pmc)
 {
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index c1e401fabbde..64215024e70e 100644
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
@@ -177,6 +176,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 {
+	unsigned int nr_gp_counters = AMD64_NUM_COUNTERS;
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	union cpuid_0x80000022_ebx ebx;
 
@@ -190,18 +190,16 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
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
 
@@ -219,7 +217,6 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
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
index 9b0bfa2f854c..9b2559046971 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -713,12 +713,12 @@ static void nested_vmx_merge_pmu_msr_bitmaps(struct kvm_vcpu *vcpu,
 	if (!kvm_vcpu_has_mediated_pmu(vcpu))
 		return;
 
-	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+	kvm_for_each_gp_counter(i, pmu) {
 		nested_vmx_merge_msr_bitmaps_rw(MSR_IA32_PERFCTR0 + i);
 		nested_vmx_merge_msr_bitmaps_rw(MSR_IA32_PMC0 + i);
 	}
 
-	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
+	kvm_for_each_fixed_counter(i, pmu)
 		nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_FIXED_CTR0 + i);
 
 	nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_GLOBAL_CTRL);
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index fadc466cd600..68d23c7877a2 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -71,14 +71,14 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 
 	pmu->fixed_ctr_ctrl = data;
 	pmu->fixed_ctr_ctrl_hw = data;
-	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
+	kvm_for_each_fixed_counter(i, pmu) {
 		u8 new_ctrl = fixed_ctrl_field(data, i);
 		u8 old_ctrl = fixed_ctrl_field(old_fixed_ctr_ctrl, i);
 
 		if (old_ctrl == new_ctrl)
 			continue;
 
-		pmc = get_fixed_pmc(pmu, MSR_CORE_PERF_FIXED_CTR0 + i);
+		pmc = &pmu->fixed_counters[i];
 
 		__set_bit(KVM_FIXED_PMC_BASE_IDX + i, pmu->pmc_in_use);
 		kvm_pmu_request_counter_reprogram(pmc);
@@ -91,7 +91,7 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 	unsigned int type = idx & INTEL_RDPMC_TYPE_MASK;
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *counters;
-	unsigned int num_counters;
+	unsigned int max_nr_counters;
 	u64 bitmask;
 
 	/*
@@ -107,6 +107,8 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 	if (WARN_ON_ONCE(!pmu->version))
 		return NULL;
 
+	idx &= INTEL_RDPMC_INDEX_MASK;
+
 	/*
 	 * General Purpose (GP) PMCs are supported on all PMUs, and fixed PMCs
 	 * are supported on all architectural PMUs, i.e. on all virtual PMUs
@@ -117,25 +119,27 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 	 */
 	switch (type) {
 	case INTEL_RDPMC_FIXED:
+		if (!kvm_is_fixed_pmc_supported(pmu, idx))
+			return NULL;
+
 		counters = pmu->fixed_counters;
-		num_counters = pmu->nr_arch_fixed_counters;
+		max_nr_counters = KVM_MAX_NR_INTEL_FIXED_COUNTERS;
 		bitmask = pmu->counter_bitmask[KVM_PMC_FIXED];
 		break;
 	case INTEL_RDPMC_GP:
+		if (!kvm_is_gp_pmc_supported(pmu, idx))
+			return NULL;
+
 		counters = pmu->gp_counters;
-		num_counters = pmu->nr_arch_gp_counters;
+		max_nr_counters = KVM_MAX_NR_INTEL_GP_COUNTERS;
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
-	return &counters[array_index_nospec(idx, num_counters)];
+	return &counters[array_index_nospec(idx, max_nr_counters)];
 }
 
 static inline struct kvm_pmc *get_fw_gp_pmc(struct kvm_pmu *pmu, u32 msr)
@@ -497,7 +501,7 @@ static void intel_pmu_enable_fixed_counter_bits(struct kvm_pmu *pmu, u64 bits)
 {
 	int i;
 
-	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
+	kvm_for_each_fixed_counter(i, pmu)
 		pmu->fixed_ctr_ctrl_rsvd &= ~intel_fixed_bits_by_idx(i, bits);
 }
 
@@ -505,11 +509,13 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct lbr_desc *lbr_desc = vcpu_to_lbr_desc(vcpu);
+	int nr_gp_counters, nr_fixed_counters;
 	struct kvm_cpuid_entry2 *entry;
 	union cpuid10_eax eax;
 	union cpuid10_edx edx;
 	u64 perf_capabilities;
 	u64 counter_rsvd;
+	u64 fixed_mask;
 
 	if (!lbr_desc)
 		return;
@@ -535,8 +541,6 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	if (!pmu->version)
 		return;
 
-	pmu->nr_arch_gp_counters = min_t(int, eax.split.num_counters,
-					 kvm_pmu_cap.num_counters_gp);
 	eax.split.bit_width = min_t(int, eax.split.bit_width,
 				    kvm_pmu_cap.bit_width_gp);
 	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(eax.split.bit_width) - 1;
@@ -544,6 +548,14 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 				      kvm_pmu_cap.events_mask_len);
 	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
 
+	nr_fixed_counters = min_t(int, edx.split.num_counters_fixed,
+				  kvm_pmu_cap.num_counters_fixed);
+	fixed_mask = BIT_ULL(nr_fixed_counters) - 1;
+
+	nr_gp_counters = min_t(int, eax.split.num_counters,
+			       kvm_pmu_cap.num_counters_gp);
+	pmu->pmc_exists64 = BIT_ULL(nr_gp_counters) - 1;
+
 	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
 	if (entry &&
 	    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) &&
@@ -565,8 +577,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	if (pmu->version == 1)
 		return;
 
-	pmu->nr_arch_fixed_counters = min_t(int, edx.split.num_counters_fixed,
-					    kvm_pmu_cap.num_counters_fixed);
+	pmu->pmc_exists64 |= fixed_mask << KVM_FIXED_PMC_BASE_IDX;
 	edx.split.bit_width_fixed = min_t(int, edx.split.bit_width_fixed,
 					  kvm_pmu_cap.bit_width_fixed);
 	pmu->counter_bitmask[KVM_PMC_FIXED] = BIT_ULL(edx.split.bit_width_fixed) - 1;
@@ -575,8 +586,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 						 INTEL_FIXED_0_USER |
 						 INTEL_FIXED_0_ENABLE_PMI);
 
-	counter_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
-			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
+	counter_rsvd = ~(kvm_gp_pmc_mask(pmu) |
+			 (kvm_fixed_pmc_mask(pmu) << KVM_FIXED_PMC_BASE_IDX));
 	pmu->global_ctrl_rsvd = counter_rsvd;
 
 	pmu->global_status_rsvd = pmu->global_ctrl_rsvd
@@ -591,7 +602,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 			pmu->pebs_data_cfg_rsvd = ~0xff00000full;
 			intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_0_ADAPTIVE);
 		} else {
-			pmu->pebs_enable_rsvd = ~(BIT_ULL(pmu->nr_arch_gp_counters) - 1);
+			pmu->pebs_enable_rsvd = ~kvm_gp_pmc_mask(pmu);
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
2.56.1

