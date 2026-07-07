Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F378844102E;
	Tue,  7 Jul 2026 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449855; cv=none; b=lCVseFJJ5916xI7ZWWG7gamZapGKLpDzhE2ofJSkkHsheN4NkJFUl8PNgsLIXaRdHYaIIU3vOg85917oaE19YQMRYXHv2tel/wDeSnEl+xxz+UjlR7JreHSQV/oDAByC+yoZ1e+wZknni+E29IX+OKxYQBH6nqayWNSBTJiCC2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449855; c=relaxed/simple;
	bh=nLxWaAjgilSBX2DJysv1YdnLh58ZaCa8z92G8jZi0Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNkhyO47UGfS8StoLsIeomwxVGQAh6lGtZqWyCAo4wLl7YjgabnYlSyxbWAESYiy21PJIY4K9goI0j4ItfR/qnNPubeg+EPguy4s/Ptq8/hRAVCsaZ4cLOnskXAnrWiP5H0l27GHuPDj3YD283xtg1t7YjzlkW+vQ4n8xPpaCUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBMLdMDs; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBMLdMDs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783449843; x=1814985843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nLxWaAjgilSBX2DJysv1YdnLh58ZaCa8z92G8jZi0Ys=;
  b=kBMLdMDsNQw5x9A0Sj78JZcqthEtoQ7NytiSqc94Mbi+78uFYmaluup4
   gdZC/talXb8n9/zpYb6gVJXEyZhnttRL/eIO2RSPHp6ophwpAhqHduLnx
   I2AfxCIwPkspX6+T3qXQ8Y8VIU6QFfoI36/Q+yp0ysEqInT9V82sfYGTt
   OeYp4r3cBDSlmzoX1pLtcWec9bAPCfu6RX5roXBbDXl526O3TVSs6Sdkf
   SHm9voo7gL7+XAzmtDm9KBv54SWXcD9H3+fhXaddbw9G00M3HrlMIgAxD
   2NhHBw7ox2QeeEjvcynIsRN22q71wZjrSvcxzEEYUbrP6IxvP2fNqEbrs
   g==;
X-CSE-ConnectionGUID: i6PElhffTT24e7bkWs0FKA==
X-CSE-MsgGUID: 2XXkIie/R9CBwFYxsW1yvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94713881"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94713881"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:58 -0700
X-CSE-ConnectionGUID: HubnpMpST72IUtQa9f4/Mg==
X-CSE-MsgGUID: eB8VXldkRGaXo4vkQss4mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277279305"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:58 -0700
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
Subject: [PATCH 08/15] KVM: x86/pmu: Switch to bitmask-based KVM PMU capabilities
Date: Tue,  7 Jul 2026 11:33:58 -0700
Message-ID: <20260707183405.15571-9-zide.chen@intel.com>
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Intel platforms support non-contiguous fixed counters via CPUID.0AH:ECX
starting with PerfMon v5, and support non-contiguous GP counters
through the Architectural PerfMon Extension (CPUID leaf 23H).

struct x86_pmu_capability now exposes {,fixed_}cntr_mask64 bitmaps,
which may contain sparse bits representing non-contiguous counters.
Switch KVM's kvm_host_pmu and kvm_pmu_cap consumers over to the new
bitmask fields.

CPUID.0AH:EAX[15:8] and CPUID.0AH:EDX[4:0] enumerate only contiguous
counters. Derive these values from kvm_pmu_cap.{,fixed_}cntr_mask64 as
the number of consecutive counters starting at index 0.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/kvm/cpuid.c         | 14 +++++++++++---
 arch/x86/kvm/msrs.c          | 12 ++++++------
 arch/x86/kvm/pmu.c           | 34 +++++++++++-----------------------
 arch/x86/kvm/svm/pmu.c       |  2 +-
 arch/x86/kvm/svm/svm.c       |  9 +++++----
 arch/x86/kvm/vmx/pmu_intel.c |  7 ++++---
 arch/x86/kvm/vmx/vmx.c       |  7 +++++--
 7 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 2698fa42cd97..151a4794f834 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1514,10 +1514,18 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		}
 
 		eax.split.version_id = kvm_pmu_cap.version;
-		eax.split.num_counters = kvm_pmu_cap.num_counters_gp;
+
+		/* Contiguous GP counters only. */
+		eax.split.num_counters =
+			find_first_zero_bit(kvm_pmu_cap.cntr_mask,
+					    KVM_MAX_NR_GP_COUNTERS);
 		eax.split.bit_width = kvm_pmu_cap.bit_width_gp;
 		eax.split.mask_length = kvm_pmu_cap.events_mask_len;
-		edx.split.num_counters_fixed = kvm_pmu_cap.num_counters_fixed;
+
+		/* Contiguous fixed counters only. */
+		edx.split.num_counters_fixed =
+			find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
+					    KVM_MAX_NR_FIXED_COUNTERS);
 		edx.split.bit_width_fixed = kvm_pmu_cap.bit_width_fixed;
 
 		if (kvm_pmu_cap.version)
@@ -1882,7 +1890,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 
 		cpuid_entry_override(entry, CPUID_8000_0022_EAX);
 
-		ebx.split.num_core_pmc = kvm_pmu_cap.num_counters_gp;
+		ebx.split.num_core_pmc = hweight64(kvm_pmu_cap.cntr_mask64);
 		entry->ebx = ebx.full;
 		break;
 	}
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index c751a8dbd45d..7524d019f1be 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -2631,20 +2631,20 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 		break;
 	case MSR_ARCH_PERFMON_PERFCTR0 ...
 	     MSR_ARCH_PERFMON_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
-		if (msr_index - MSR_ARCH_PERFMON_PERFCTR0 >=
-		    kvm_pmu_cap.num_counters_gp)
+		if (!(BIT_ULL(msr_index - MSR_ARCH_PERFMON_PERFCTR0) &
+		      kvm_pmu_cap.cntr_mask64))
 			return;
 		break;
 	case MSR_ARCH_PERFMON_EVENTSEL0 ...
 	     MSR_ARCH_PERFMON_EVENTSEL0 + KVM_MAX_NR_GP_COUNTERS - 1:
-		if (msr_index - MSR_ARCH_PERFMON_EVENTSEL0 >=
-		    kvm_pmu_cap.num_counters_gp)
+		if (!(BIT_ULL(msr_index - MSR_ARCH_PERFMON_EVENTSEL0) &
+		      kvm_pmu_cap.cntr_mask64))
 			return;
 		break;
 	case MSR_ARCH_PERFMON_FIXED_CTR0 ...
 	     MSR_ARCH_PERFMON_FIXED_CTR0 + KVM_MAX_NR_FIXED_COUNTERS - 1:
-		if (msr_index - MSR_ARCH_PERFMON_FIXED_CTR0 >=
-		    kvm_pmu_cap.num_counters_fixed)
+		if (!(BIT_ULL(msr_index - MSR_ARCH_PERFMON_FIXED_CTR0) &
+		      kvm_pmu_cap.fixed_cntr_mask64))
 			return;
 		break;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 3647ce3f0e3f..bc2ca60114e9 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -20,7 +20,6 @@
 #include <asm/perf_event.h>
 #include <asm/cpu_device_id.h>
 #include "x86.h"
-#include "cpuid.h"
 #include "lapic.h"
 #include "pmu.h"
 
@@ -136,8 +135,6 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
 {
 	bool is_intel = boot_cpu_data.x86_vendor == X86_VENDOR_INTEL;
 	int min_nr_gp_ctrs = pmu_ops->MIN_NR_GP_COUNTERS;
-	union cpuid10_edx edx;
-	u32 eax, ebx, ecx;
 
 	/*
 	 * Hybrid PMUs don't play nice with virtualization without careful
@@ -159,8 +156,8 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
 		 * there are a non-zero number of counters, but fewer than what
 		 * is architecturally required.
 		 */
-		if (!kvm_host_pmu.num_counters_gp ||
-		    WARN_ON_ONCE(kvm_host_pmu.num_counters_gp < min_nr_gp_ctrs))
+		if (!kvm_host_pmu.cntr_mask64 ||
+		    WARN_ON_ONCE(hweight64(kvm_host_pmu.cntr_mask64) < min_nr_gp_ctrs))
 			enable_pmu = false;
 		else if (is_intel && !kvm_host_pmu.version)
 			enable_pmu = false;
@@ -180,23 +177,14 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
 
 	memcpy(&kvm_pmu_cap, &kvm_host_pmu, sizeof(kvm_host_pmu));
 	kvm_pmu_cap.version = min(kvm_pmu_cap.version, 2);
-	kvm_pmu_cap.num_counters_gp = min(kvm_pmu_cap.num_counters_gp,
-					  pmu_ops->MAX_NR_GP_COUNTERS);
-	kvm_pmu_cap.num_counters_fixed = min(kvm_pmu_cap.num_counters_fixed,
-					     KVM_MAX_NR_FIXED_COUNTERS);
+	kvm_pmu_cap.cntr_mask64 &=
+		GENMASK_ULL(pmu_ops->MAX_NR_GP_COUNTERS - 1, 0);
+	kvm_pmu_cap.fixed_cntr_mask64 &=
+		GENMASK_ULL(KVM_MAX_NR_FIXED_COUNTERS - 1, 0);
 
-	/*
-	 * Currently, KVM doesn't support non-contiguous fixed counters; make
-	 * sure only contiguous ones are retained in kvm_pmu_cap.
-	 */
-	if (kvm_host_pmu.version >= 5) {
-		cpuid(0xa, &eax, &ebx, &ecx, &edx.full);
-		if (kvm_pmu_cap.num_counters_fixed > edx.split.num_counters_fixed)
-			kvm_pmu_cap.num_counters_fixed = edx.split.num_counters_fixed;
-	}
-
-	if (!enable_mediated_pmu && kvm_pmu_cap.num_counters_fixed > 3)
-		kvm_pmu_cap.num_counters_fixed = 3;
+	/* Legacy vPMU exposes at most 3 fixed counters. */
+	if (!enable_mediated_pmu)
+		kvm_pmu_cap.fixed_cntr_mask64 &= GENMASK_ULL(2, 0);
 
 	kvm_pmu_eventsel.INSTRUCTIONS_RETIRED =
 		perf_get_hw_event_config(PERF_COUNT_HW_INSTRUCTIONS);
@@ -796,8 +784,8 @@ static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
 	 * KVM's capabilities are constrained based on KVM support, i.e. KVM's
 	 * capabilities themselves may be a subset of hardware capabilities.
 	 */
-	return kvm_gp_pmc_mask(pmu) != BIT_ULL(kvm_host_pmu.num_counters_gp) - 1 ||
-	       kvm_fixed_pmc_mask(pmu) != BIT_ULL(kvm_host_pmu.num_counters_fixed) - 1;
+	return kvm_gp_pmc_mask(pmu) != kvm_host_pmu.cntr_mask64 ||
+	       kvm_fixed_pmc_mask(pmu) != kvm_host_pmu.fixed_cntr_mask64;
 }
 
 bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 02cf960a215a..d519eba518bf 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -208,7 +208,7 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 	}
 
 	pmu->all_valid_pmc_mask64 = (BIT_ULL(nr_gp_counters) - 1) &
-				    (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
+				    kvm_pmu_cap.cntr_mask64;
 
 	if (pmu->version > 1) {
 		pmu->global_ctrl_rsvd = ~pmu->all_valid_pmc_mask64;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3b3e98b6abb6..002cdd074fd7 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -754,6 +754,7 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 	bool intercept = !kvm_vcpu_has_mediated_pmu(vcpu);
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
+	unsigned long host_only_gp_mask;
 	int i;
 
 	if (!enable_mediated_pmu)
@@ -769,7 +770,8 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 		svm_set_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i,
 					  MSR_TYPE_RW, intercept);
 
-	for ( ; i < kvm_pmu_cap.num_counters_gp; i++)
+	host_only_gp_mask = kvm_pmu_cap.cntr_mask64 & ~gp_mask;
+	kvm_for_each_set_pmc_idx(i, host_only_gp_mask, AMD_GP)
 		svm_enable_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i,
 					     MSR_TYPE_RW);
 
@@ -5574,9 +5576,8 @@ static __init void svm_set_cpu_caps(void)
 		 * access to enough counters to virtualize "core" support,
 		 * otherwise limit vPMU support to the legacy number of counters.
 		 */
-		if (kvm_pmu_cap.num_counters_gp < AMD64_NUM_COUNTERS_CORE)
-			kvm_pmu_cap.num_counters_gp = min(AMD64_NUM_COUNTERS,
-							  kvm_pmu_cap.num_counters_gp);
+		if (hweight64(kvm_pmu_cap.cntr_mask64) < AMD64_NUM_COUNTERS_CORE)
+			kvm_pmu_cap.cntr_mask64 &= GENMASK_ULL(AMD64_NUM_COUNTERS - 1, 0);
 		else
 			kvm_cpu_cap_check_and_set(X86_FEATURE_PERFCTR_CORE);
 
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 31422bd20d96..425f17aa9be2 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -518,7 +518,8 @@ static u64 intel_get_fixed_pmc_eventsel(unsigned int index)
 	 * have a known encoding for the associated general purpose event.
 	 */
 	eventsel = perf_get_hw_event_config(fixed_pmc_perf_ids[index]);
-	WARN_ON_ONCE(!eventsel && index < kvm_pmu_cap.num_counters_fixed);
+	WARN_ON_ONCE(!eventsel &&
+		     (kvm_pmu_cap.fixed_cntr_mask64 & BIT_ULL(index)));
 	return eventsel;
 }
 
@@ -575,7 +576,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
 
 	fixed_cntr_mask = BIT_ULL(edx.split.num_counters_fixed) - 1;
-	fixed_cntr_mask &= BIT_ULL(kvm_pmu_cap.num_counters_fixed) - 1;
+	fixed_cntr_mask &= kvm_pmu_cap.fixed_cntr_mask64;
 
 	/*
 	 * The number of counters comes from guest CPUID data. Clamp the value
@@ -583,7 +584,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	 */
 	nr_gp_counters = min_t(int, eax.split.num_counters, X86_PMC_IDX_MAX - 1);
 	pmu->all_valid_pmc_mask64 = (BIT_ULL(nr_gp_counters) - 1) &
-				    (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
+				    kvm_pmu_cap.cntr_mask64;
 
 	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
 	if (entry &&
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0a6880bb7ebe..2a59bbe52bd8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4226,6 +4226,7 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 	bool has_mediated_pmu = kvm_vcpu_has_mediated_pmu(vcpu);
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	unsigned long host_only_gp_mask, host_only_fixed_mask;
 	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
 	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
 	bool intercept = !has_mediated_pmu;
@@ -4248,23 +4249,25 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 
 	vm_exit_controls_changebit(vmx, vm_exit_controls_bits, has_mediated_pmu);
 
+	host_only_gp_mask = kvm_host_pmu.cntr_mask64 & ~gp_mask;
 	kvm_for_each_set_pmc_idx(i, gp_mask, INTEL_GP) {
 		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PERFCTR0 + i,
 					  MSR_TYPE_RW, intercept);
 		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PMC0 + i, MSR_TYPE_RW,
 					  intercept || !fw_writes_is_enabled(vcpu));
 	}
-	for ( ; i < kvm_pmu_cap.num_counters_gp; i++) {
+	for_each_set_bit(i, &host_only_gp_mask, INTEL_PMC_MAX_GENERIC) {
 		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PERFCTR0 + i,
 					  MSR_TYPE_RW, true);
 		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PMC0 + i,
 					  MSR_TYPE_RW, true);
 	}
 
+	host_only_fixed_mask = kvm_host_pmu.fixed_cntr_mask64 & ~fixed_mask;
 	kvm_for_each_set_pmc_idx(i, fixed_mask, INTEL_FIXED)
 		vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_FIXED_CTR0 + i,
 					  MSR_TYPE_RW, intercept);
-	for ( ; i < kvm_pmu_cap.num_counters_fixed; i++)
+	for_each_set_bit(i, &host_only_fixed_mask, INTEL_PMC_MAX_FIXED)
 		vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_FIXED_CTR0 + i,
 					  MSR_TYPE_RW, true);
 
-- 
2.54.0

