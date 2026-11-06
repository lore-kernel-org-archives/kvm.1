Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929836;
	b=lZ2/z/EGqN0l6kzXp1ZZOg3ZzCPJfANIp3LPJNMH2aDLGXx/1RJ8onGBJw03yK9M2Upg
	 fsUErc5uw4MqIJFfcNTCM5DsXq8/2EH5IVC1r5y7r1CrOrmVtelLCFTf4RSJNomlDXzn2
	 UiYKjhtWgcZWWc/7NWq8uwalmB9ZLJ34AQ81ORRABxGsdDBV0mLlcyjHoq3ox/7QLdimK
	 ai2oxSxJ8gJY7WXVw6pt7Z0JlhDXE1diJMhKX0DVlxCBIhCDLTlTgm5Ajd6gn7NoovCDX
	 +j5IgAyl2KeUhI3i1xTUMu+DvKa6YLiscPSOaShaZ+nM7h0UJbDU79bBzIjAivFG2Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929836;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+URcv+8Ai3eH2FF67Uq0NAwZiPJiDT0cSxhHs5mI56I=;
	b=n4OtO5JGqh1WXxbNmNirMga9ndDqRNa9n0fderhrMK6KcCMEK7oEIQJw4/FQBqpbys8m
	 t5zrmron5CPnpWPXD0Pe2mKnrhDapFi6BCumNXCVbq+TYFdreHD8BuZsuZelhUuNbhaRX
	 V476SU8VH/0b9KF/+mzcPy+H5i7WwVaPVo8+dutAHCQP5YeozHJSEnqaf7m0LTjKcdz+h
	 2UNNphKG6XaXL3hVeauJu62MmVGF3pOxwjCBrMTDZQCMb9imskndWcaRoxsa5+uP9fG4f
	 fGnbim9X4CNhYQwPqjpOE+rOc3/Wk+LguX4H7Imdk5jDmXCbwuWd0YhrHwkpTncHuJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nHx5ZkWi;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C83606D812;
	Fri,  6 Nov 2026 01:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73C83606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nHx5ZkWi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793929835; x=1825465835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aBiUjoPalsS7/pBONIabaXH7JEINV6DcYrro9xagAIM=;
  b=nHx5ZkWiC62PJUnebOqm77s6I5QYVYa/dQVlOUGLdzo7R2DsadK+AFN7
   XtYkbtmqdGES6jMEGLQc5W+LlB3IuKyCuM6uN4O4g6K0e7B5cL8jL5TTY
   Q8FYRvlmCgugjoalrbA0TdtILyg/MTPkYr4/GjNNJkXEbMl95lOuoiKhv
   IUT0jXvxSOwkG9/+88VJrwoqA/R2EI/XgvxUzg/AieaIlVGSwav0RYXfn
   guwkuVsGYM2uvIwAlutI+bq2r4ZTtsx5Jmu7nVgNfvxDHkkPCSKioXBxh
   dKNH8HvOZjsq696JBNf3hw0XS7Mm2+u9jTzq+TcS9T6LgQlpM+KZPfZMU
   g==;
X-CSE-ConnectionGUID: zTEIvkfITBKOMqkCh8gYfQ==
X-CSE-MsgGUID: 11/FbavXT1a89nIxLmdbVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740154"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2740154"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:31 -0800
X-CSE-ConnectionGUID: eIEKRu/mSt2/9EzAnWNk4Q==
X-CSE-MsgGUID: ovgDGnZfTH2z0TL7BPbsfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067188"
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
Subject: [PATCH v3 08/18] KVM: x86/pmu: Switch to bitmask-based KVM PMU capabilities
Date: Thu,  5 Nov 2026 18:39:17 -0700
Message-ID: <20261106013927.166209-9-zide.chen@intel.com>
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
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
v3:
- Iterate kvm_host_pmu bitmasks directly in VMX and SVM intercept loops.
- Clamp nr_{gp,fixed}_counters to the number of contiguous counters
  supported by KVM in intel_pmu_refresh(). (Jim, Sashiko)
- Drop redundant !enable_mediated_pmu clamp on fixed_cntr_mask64. (Sashiko)
---
 arch/x86/kvm/cpuid.c         | 14 +++++++++++---
 arch/x86/kvm/msrs.c          | 12 ++++++------
 arch/x86/kvm/pmu.c           | 17 ++++++++---------
 arch/x86/kvm/svm/pmu.c       |  2 +-
 arch/x86/kvm/svm/svm.c       |  7 +++----
 arch/x86/kvm/vmx/pmu_intel.c | 28 +++++++++++++++++++---------
 arch/x86/kvm/vmx/vmx.c       |  4 ++--
 7 files changed, 50 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index adafd6fa2c54..3310c370c5fa 100644
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
@@ -1903,7 +1911,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 
 		cpuid_entry_override(entry, CPUID_8000_0022_EAX);
 
-		ebx.split.num_core_pmc = kvm_pmu_cap.num_counters_gp;
+		ebx.split.num_core_pmc = hweight64(kvm_pmu_cap.cntr_mask64);
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
index b9c493c6db48..27d6a9169821 100644
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
index 0943ccc1d6b8..fb5a298244ec 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -203,7 +203,7 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 	}
 
 	pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
-			    (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
+			    kvm_pmu_cap.cntr_mask64;
 
 	if (pmu->version > 1) {
 		pmu->global_ctrl_rsvd = ~pmu->pmc_exists64;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e21abcedea70..c9ed6a6e8325 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -773,7 +773,7 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 					  MSR_TYPE_RW, intercept || !test_bit(i, &gp_mask));
 
 	intercept |= !guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_CORE);
-	for (i = 0; i < kvm_pmu_cap.num_counters_gp; i++)
+	for_each_set_bit(i, kvm_host_pmu.cntr_mask, AMD64_NUM_COUNTERS_CORE)
 		svm_set_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i,
 					  MSR_TYPE_RW, intercept || !test_bit(i, &gp_mask));
 
@@ -5719,9 +5719,8 @@ static __init void svm_set_cpu_caps(void)
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
index 7770200d0e91..ce668ea08da5 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -494,7 +494,8 @@ static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
 	 * have a known encoding for the associated general purpose event.
 	 */
 	eventsel = perf_get_hw_event_config(fixed_pmc_perf_ids[index]);
-	WARN_ON_ONCE(!eventsel && index < kvm_pmu_cap.num_counters_fixed);
+	WARN_ON_ONCE(!eventsel &&
+		     (kvm_pmu_cap.fixed_cntr_mask64 & BIT_ULL(index)));
 	return eventsel;
 }
 
@@ -516,7 +517,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	union cpuid10_edx edx;
 	u64 perf_capabilities;
 	u64 fixed_mask;
-	int nr_gp_counters;
+	int nr_gp_counters, nr_fixed_counters;
 	u64 counter_rsvd;
 
 	if (!lbr_desc)
@@ -550,16 +551,25 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 				      kvm_pmu_cap.events_mask_len);
 	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
 
-	fixed_mask = BIT_ULL(edx.split.num_counters_fixed) - 1;
-	fixed_mask &= BIT_ULL(kvm_pmu_cap.num_counters_fixed) - 1;
+	/*
+	 * CPUID.0AH:EDX[4:0] can only enumerate contiguous counters. Clamp the
+	 * value to the number of contiguous fixed counters supported by KVM.
+	 */
+	nr_fixed_counters = min_t(int, edx.split.num_counters_fixed,
+				  find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
+						      KVM_MAX_NR_FIXED_COUNTERS));
+
+	fixed_mask = BIT_ULL(nr_fixed_counters) - 1;
+	fixed_mask &= kvm_pmu_cap.fixed_cntr_mask64;
 
 	/*
-	 * The number of counters comes from guest CPUID data. Clamp the value
-	 * to avoid a shift-by-64 in BIT_ULL().
+	 * CPUID.0AH:EAX[15:8] can only enumerate contiguous counters. Clamp the
+	 * value to the number of contiguous GP counters supported by KVM.
 	 */
-	nr_gp_counters = min_t(int, eax.split.num_counters, X86_PMC_IDX_MAX - 1);
-	pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
-			    (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
+	nr_gp_counters = min_t(int, eax.split.num_counters,
+			       find_first_zero_bit(kvm_pmu_cap.cntr_mask,
+						   KVM_MAX_NR_GP_COUNTERS));
+	pmu->pmc_exists64 = BIT_ULL(nr_gp_counters) - 1;
 
 	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
 	if (entry &&
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
2.56.0

