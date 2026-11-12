Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516230;
	b=QaBkiYjotBIWkBAJWr7gKxKQbLbMtOtRF15BrJ7p09aARVjUKF3lb1q1UDJHiphDNoyh
	 UoiKwDCwVGtK9QC62zqHmGO/PkqEg+nV1tDyLFu3u1AZcqsbWx903oG6CfuRn8QWqwEEh
	 Qn1iE65UnFEcz5pXwraihVfYHejddgXPgTDPin413q58y9C6dUmAAEX5ZQwVnyNRZa5sB
	 1MgvcMEYQb5DncE0Lei91agvZOky5zNcgxMlw6415NkqTu/+ttJbLtsshlTUOE4P35oA+
	 7ITacp8iXxEtW0yykLSm1TKpHFcFc7/qTyDgA+mYJlQlyA2gZ4+Bpu4qAt6RWVSHgHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516230;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/WSsX43BQw0FAQKPkl/fLVvF27PIOpmkTgAJSaGa1kc=;
	b=HpkzeW3PzAZQRuAaHusHTc8omVepBxlZlZiIaPW4q+R4a2zQVyY3SUWMgakAvJ06JpI0
	 RApySvRlpBAHPBqySW03OcolKOUNf0x+1MIJpz71s4h2N2aJo/shWIwMiO6nLXuJ7AS1y
	 Exked6Fl+WRG5A4td7pCttomHiQ1iluXIH1FYXriuMt5Q2C0tzHe8Oy4eiwz9J8Ub+C8e
	 AcXLcYKszNi0ZIHNnIoltTfmEIg4PA4WTGXsAwZrM2XMHCBYSw6qzlcP3ebPrehTXw34r
	 jHTS6lv40SQjUeRg/zJWR/7NECm6aBUiMJkJkdwP/DmiiFooskv0yJUHUToItNUIBlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="PozA/UG6";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1FA606A8BE;
	Thu, 12 Nov 2026 20:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F1FA606A8BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PozA/UG6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516230; x=1826052230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+hSpRl0Rirp4obyrctX7EsF7CdjZV3ESSk4YTqod/LY=;
  b=PozA/UG69SgsVal4GtVsKpODaaDCS0phfwJd4jkuZSs8wxtylp0XvMsL
   Qfe8Zmmgagl0zwXAlxDQ/SvUNZXpTgNpnsHlRxVDRVRXNiuLbcZkUihnv
   P9t0d2wfdUTrcA1t3VNp5KMBBcaeuW5h9rAxaAyilM1yXVP/FGOb8G9M9
   xbN+8UrixFfSF6H2TJXhAjMQSXoNR++/5nY9+FaEshKv6BoCukT669R0K
   lq6aTEdDWvlWi96iJnSMrfNUz4zzmKl1AxcfAv67CIrGfeFZYNjlSnAlS
   ABFiTqbDPtQfAowL1fXzvwi78HNvntNUuAgTsSgctogaJtyGnDDDyesYG
   A==;
X-CSE-ConnectionGUID: uozkCTAbSPK+5D8NKoFMlg==
X-CSE-MsgGUID: iZyE0CyITuS5Yr1W6vcbCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192264"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192264"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:49 -0800
X-CSE-ConnectionGUID: 4B20ZSEeR7mqCv2ARUIXxQ==
X-CSE-MsgGUID: zyRC/4ePTyCMqI4KJf5LTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087896"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:49 -0800
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
Subject: [PATCH v4 09/21] KVM: x86/pmu: Switch to bitmask-based KVM PMU capabilities
Date: Thu, 12 Nov 2026 13:32:15 -0700
Message-ID: <20261112203227.289379-10-zide.chen@intel.com>
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

Intel platforms support non-contiguous fixed counters via CPUID.0AH:ECX
starting with PerfMon v5, and support non-contiguous GP counters
through the Architectural PerfMon Extension (CPUID leaf 23H).

struct x86_pmu_capability now exposes {,fixed_}cntr_mask64 bitmaps,
which may contain sparse bits representing non-contiguous counters.
Switch KVM's kvm_host_pmu and kvm_pmu_cap consumers over to the new
bitmask fields, including iterating kvm_host_pmu bitmasks directly in
VMX and SVM PMU MSR intercept setup.

CPUID.0AH:EAX[15:8] and CPUID.0AH:EDX[4:0] enumerate only contiguous
counters. Derive these values from kvm_pmu_cap.{,fixed_}cntr_mask64 as
the number of consecutive counters starting at index 0.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v4:
- Cleanly substitute kvm_pmu_cap.num_counters_{gp,fixed} with
  find_first_zero_bit() in intel_pmu_refresh() without throwaway
  code churn.
- Use find_first_zero_bit() instead of hweight64() for AMD CPUID
  0x80000022 EBX[3:0] (NumCorePmc) and svm_set_cpu_caps() to enumerate
  contiguous counters. (Yosry)
- Do not carry over Jim's Reviewed-by from v3 due to reworking counter
  clamping in intel_pmu_refresh().

v3:
- Iterate kvm_host_pmu bitmasks directly in VMX and SVM intercept loops.
- Clamp nr_{gp,fixed}_counters to the number of contiguous counters
  supported by KVM in intel_pmu_refresh(). (Jim, Sashiko)
- Drop redundant !enable_mediated_pmu clamp on fixed_cntr_mask64.
  (Sashiko)
---
 arch/x86/kvm/cpuid.c         | 17 ++++++++++++++---
 arch/x86/kvm/msrs.c          | 12 ++++++------
 arch/x86/kvm/pmu.c           | 17 ++++++++---------
 arch/x86/kvm/svm/pmu.c       |  2 +-
 arch/x86/kvm/svm/svm.c       |  8 ++++----
 arch/x86/kvm/vmx/pmu_intel.c | 18 +++++++++++++++---
 arch/x86/kvm/vmx/vmx.c       |  4 ++--
 7 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index adafd6fa2c54..427871ec365f 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1535,10 +1535,18 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
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
@@ -1903,7 +1911,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 
 		cpuid_entry_override(entry, CPUID_8000_0022_EAX);
 
-		ebx.split.num_core_pmc = kvm_pmu_cap.num_counters_gp;
+		/* Contiguous GP counters only. */
+		ebx.split.num_core_pmc =
+			find_first_zero_bit(kvm_pmu_cap.cntr_mask,
+					    KVM_MAX_NR_GP_COUNTERS);
 		entry->ebx = ebx.full;
 		break;
 	}
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index e91650af44c2..01fb130a7d24 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -2621,20 +2621,20 @@ static void kvm_probe_msr_to_save(u32 msr_index)
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
index d203cbc7fd12..e1999a6c85d7 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -20,7 +20,6 @@
 #include <asm/perf_event.h>
 #include <asm/cpu_device_id.h>
 #include "x86.h"
-#include "cpuid.h"
 #include "lapic.h"
 #include "pmu.h"
 
@@ -156,8 +155,8 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
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
@@ -177,10 +176,10 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
 
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
 
 	kvm_pmu_eventsel.INSTRUCTIONS_RETIRED =
 		perf_get_hw_event_config(PERF_COUNT_HW_INSTRUCTIONS);
@@ -788,8 +787,8 @@ static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
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
index 64215024e70e..5eedf9b35fce 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -196,7 +196,7 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 	}
 
 	pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
-			    (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
+			    kvm_pmu_cap.cntr_mask64;
 
 	if (pmu->version > 1) {
 		pmu->global_ctrl_rsvd = ~pmu->pmc_exists64;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e21abcedea70..5b9c9d149486 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -773,7 +773,7 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 					  MSR_TYPE_RW, intercept || !test_bit(i, &gp_mask));
 
 	intercept |= !guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_CORE);
-	for (i = 0; i < kvm_pmu_cap.num_counters_gp; i++)
+	for_each_set_bit(i, kvm_host_pmu.cntr_mask, AMD64_NUM_COUNTERS_CORE)
 		svm_set_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i,
 					  MSR_TYPE_RW, intercept || !test_bit(i, &gp_mask));
 
@@ -5719,9 +5719,9 @@ static __init void svm_set_cpu_caps(void)
 		 * access to enough counters to virtualize "core" support,
 		 * otherwise limit vPMU support to the legacy number of counters.
 		 */
-		if (kvm_pmu_cap.num_counters_gp < AMD64_NUM_COUNTERS_CORE)
-			kvm_pmu_cap.num_counters_gp = min(AMD64_NUM_COUNTERS,
-							  kvm_pmu_cap.num_counters_gp);
+		if (find_first_zero_bit(kvm_pmu_cap.cntr_mask,
+					KVM_MAX_NR_GP_COUNTERS) < AMD64_NUM_COUNTERS_CORE)
+			kvm_pmu_cap.cntr_mask64 &= GENMASK_ULL(AMD64_NUM_COUNTERS - 1, 0);
 		else
 			kvm_cpu_cap_check_and_set(X86_FEATURE_PERFCTR_CORE);
 
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 68d23c7877a2..a240b74ac704 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -493,7 +493,8 @@ static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
 	 * have a known encoding for the associated general purpose event.
 	 */
 	eventsel = perf_get_hw_event_config(fixed_pmc_perf_ids[index]);
-	WARN_ON_ONCE(!eventsel && index < kvm_pmu_cap.num_counters_fixed);
+	WARN_ON_ONCE(!eventsel &&
+		     (kvm_pmu_cap.fixed_cntr_mask64 & BIT_ULL(index)));
 	return eventsel;
 }
 
@@ -548,12 +549,23 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 				      kvm_pmu_cap.events_mask_len);
 	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
 
+	/*
+	 * CPUID.0AH:EDX[4:0] can only enumerate contiguous counters. Clamp the
+	 * value to the number of contiguous fixed counters supported by KVM.
+	 */
 	nr_fixed_counters = min_t(int, edx.split.num_counters_fixed,
-				  kvm_pmu_cap.num_counters_fixed);
+				  find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
+						      KVM_MAX_NR_FIXED_COUNTERS));
+
 	fixed_mask = BIT_ULL(nr_fixed_counters) - 1;
 
+	/*
+	 * CPUID.0AH:EAX[15:8] can only enumerate contiguous counters. Clamp the
+	 * value to the number of contiguous GP counters supported by KVM.
+	 */
 	nr_gp_counters = min_t(int, eax.split.num_counters,
-			       kvm_pmu_cap.num_counters_gp);
+			       find_first_zero_bit(kvm_pmu_cap.cntr_mask,
+						   KVM_MAX_NR_GP_COUNTERS));
 	pmu->pmc_exists64 = BIT_ULL(nr_gp_counters) - 1;
 
 	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 944ecbf351cf..9db6107943ec 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4264,7 +4264,7 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 
 	vm_exit_controls_changebit(vmx, vm_exit_controls_bits, has_mediated_pmu);
 
-	for (i = 0; i < kvm_pmu_cap.num_counters_gp; i++) {
+	for_each_set_bit(i, kvm_host_pmu.cntr_mask, INTEL_PMC_MAX_GENERIC) {
 		bool pmc_intercept = intercept || !test_bit(i, &gp_mask);
 
 		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PERFCTR0 + i,
@@ -4273,7 +4273,7 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 					  pmc_intercept || !fw_writes_is_enabled(vcpu));
 	}
 
-	for (i = 0; i < kvm_pmu_cap.num_counters_fixed; i++) {
+	for_each_set_bit(i, kvm_host_pmu.fixed_cntr_mask, INTEL_PMC_MAX_FIXED) {
 		bool pmc_intercept = intercept || !test_bit(i, &fixed_mask);
 
 		vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_FIXED_CTR0 + i,
-- 
2.56.1

