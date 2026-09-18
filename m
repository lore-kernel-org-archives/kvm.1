Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1826F3E3DAB;
	Fri, 18 Sep 2026 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761003; cv=none; b=niEXpbF0PSPZOOtnO2gFjc2HaXA5nlOx0xbLXcOpf562UOvcKKC+XTwi6q7J8Qa5qU7UW/5KOcaWpX66TAUcG8iBqdrjQDVI4XVwSX2YilUbhDgfWQ+S8Rk3WKVn3P9YiFoogdP33IDxIqiNXXZprZptNXOtX7CHiL9KsXH9rrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761003; c=relaxed/simple;
	bh=PV8p6bFGHbpA/2U/1SIMCkH32U3o+CDyqkOIV5mcXJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjgR6O5Qi5Uyh1C2CJPO2CWzOScIvaJec6y48vMw8CtvTD6YH0ntp1gD+ZTxx/8048e/Kq9UHYEJ7iVKKKIQRUMTu9eNQ3TEifWkChlGyEMJBJuh1tQl2HwSIVEkvizxjq9r/ONruIOx3c3Hrt4y2CEj5mPcc9Fd8mkSC8mN8/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahBhfEWs; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahBhfEWs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789761001; x=1821297001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PV8p6bFGHbpA/2U/1SIMCkH32U3o+CDyqkOIV5mcXJg=;
  b=ahBhfEWscBi9NxfLBNuzSsZDLM1iV2DCn9cJz2H9g/oSzAJt0b+8Jbpd
   qc1Refk6avaJKDdEPUYgqtl4ySYTp8UYcbxsUtpEaQ8RkiytExxBeVcPF
   aZ8Fg0DkSmJyYW+klhuNTUOuag61X41YFWbYqhGWQ/F76j5zY9BfmMJ+L
   8vOo/PpcjqsuEqw1HB8VbXqmqUfBCS7FJF8HRNpFI5Ra/dr9GrYwXfWCn
   nmreJjT/ZTMf/dLLkrYc9ELCJPU8HkpkjXZgZaghFMLpAb6c2xsQOsy0+
   +QyFq8vd5JSTXRw26y76sK7hyvx/TKchWw+FlcyBXsgQO9RaGbJr2IbJ1
   A==;
X-CSE-ConnectionGUID: XD57GYMYT7yuC29wQYq4dw==
X-CSE-MsgGUID: i2x283H9RqWGJu6mNUhP5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="790318"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="790318"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:49:59 -0700
X-CSE-ConnectionGUID: gzaWrTjYT3uA5pJ4rI1zYQ==
X-CSE-MsgGUID: wtVFMkTPRzOAazKvOErnlA==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:49:58 -0700
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
Subject: [PATCH v9 02/12] KVM: x86/pmu: Support Intel fixed counter 3 on mediated vPMU
Date: Fri, 18 Sep 2026 12:39:27 -0700
Message-ID: <20260918193937.569414-3-zide.chen@intel.com>
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

Starting with Ice Lake, Intel introduced fixed counter 3, which counts
TOPDOWN.SLOTS - the number of available slots for an unhalted logical
processor.  It serves as the denominator for top-level metrics in the
Top-down Microarchitecture Analysis method.

Emulating this counter on legacy vPMU would require introducing a new
generic perf encoding for the Intel-specific TOPDOWN.SLOTS event in
order to call perf_get_hw_event_config().  This is undesirable as it
would pollute the generic perf event encoding.

Moreover, KVM does not intend to emulate IA32_PERF_METRICS in the
legacy vPMU model, and without IA32_PERF_METRICS, emulating this
counter has little practical value.  Therefore, expose fixed counter
3 to guests only when mediated vPMU is enabled.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
v6:
- Update comments to replace 2 with KVM_MAX_NR_INTEL_FIXED_COUNTERS - 1.
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/msrs.c             |  4 ++--
 arch/x86/kvm/pmu.c              | 19 ++++++++++++++++++-
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 30ffaa65f589..00584fcffa33 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -563,7 +563,7 @@ struct kvm_pmc {
 #define KVM_MAX_NR_GP_COUNTERS		KVM_MAX(KVM_MAX_NR_INTEL_GP_COUNTERS, \
 						KVM_MAX_NR_AMD_GP_COUNTERS)
 
-#define KVM_MAX_NR_INTEL_FIXED_COUNTERS	3
+#define KVM_MAX_NR_INTEL_FIXED_COUNTERS	4
 #define KVM_MAX_NR_AMD_FIXED_COUNTERS	0
 #define KVM_MAX_NR_FIXED_COUNTERS	KVM_MAX(KVM_MAX_NR_INTEL_FIXED_COUNTERS, \
 						KVM_MAX_NR_AMD_FIXED_COUNTERS)
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 37d5bed3529f..45e4c8a32436 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -217,7 +217,7 @@ static const u32 msrs_to_save_base[] = {
 
 static const u32 msrs_to_save_pmu[] = {
 	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
-	MSR_ARCH_PERFMON_FIXED_CTR0 + 2,
+	MSR_ARCH_PERFMON_FIXED_CTR2, MSR_ARCH_PERFMON_FIXED_CTR3,
 	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
 	MSR_CORE_PERF_GLOBAL_CTRL,
 	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
@@ -2672,7 +2672,7 @@ void kvm_init_msr_lists(void)
 {
 	unsigned i;
 
-	BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 3,
+	BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 4,
 			 "Please update the fixed PMCs in msrs_to_save_pmu[]");
 
 	num_msrs_to_save = 0;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index d2fd47ee5ec8..448044a2b121 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -19,6 +19,7 @@
 #include <linux/moduleparam.h>
 #include <asm/perf_event.h>
 #include <asm/cpu_device_id.h>
+#include <asm/cpuid/api.h>
 #include "x86.h"
 #include "cpuid.h"
 #include "lapic.h"
@@ -99,7 +100,8 @@ static const struct x86_cpu_id vmx_pebs_pdist_cpu[] = {
  *        all perf counters (both gp and fixed). The mapping relationship
  *        between pmc and perf counters is as the following:
  *        * Intel: [0 .. KVM_MAX_NR_INTEL_GP_COUNTERS-1] <=> gp counters
- *                 [KVM_FIXED_PMC_BASE_IDX .. KVM_FIXED_PMC_BASE_IDX + 2] <=> fixed
+ *                 KVM_MAX_NR_INTEL_FIXED_COUNTERS counters starting at
+ *                 KVM_FIXED_PMC_BASE_IDX <=> fixed
  *        * AMD:   [0 .. AMD64_NUM_COUNTERS-1] and, for families 15H
  *          and later, [0 .. AMD64_NUM_COUNTERS_CORE-1] <=> gp counters
  */
@@ -134,6 +136,8 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
 {
 	bool is_intel = boot_cpu_data.x86_vendor == X86_VENDOR_INTEL;
 	int min_nr_gp_ctrs = pmu_ops->MIN_NR_GP_COUNTERS;
+	union cpuid10_edx edx;
+	u32 eax, ebx, ecx;
 
 	/*
 	 * Hybrid PMUs don't play nice with virtualization without careful
@@ -181,6 +185,19 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
 	kvm_pmu_cap.num_counters_fixed = min(kvm_pmu_cap.num_counters_fixed,
 					     KVM_MAX_NR_FIXED_COUNTERS);
 
+	/*
+	 * Currently, KVM doesn't support non-contiguous fixed counters; make
+	 * sure only contiguous ones are retained in kvm_pmu_cap.
+	 */
+	if (kvm_host_pmu.version >= 5) {
+		cpuid(0xa, &eax, &ebx, &ecx, &edx.full);
+		if (kvm_pmu_cap.num_counters_fixed > edx.split.num_counters_fixed)
+			kvm_pmu_cap.num_counters_fixed = edx.split.num_counters_fixed;
+	}
+
+	if (!enable_mediated_pmu && kvm_pmu_cap.num_counters_fixed > 3)
+		kvm_pmu_cap.num_counters_fixed = 3;
+
 	kvm_pmu_eventsel.INSTRUCTIONS_RETIRED =
 		perf_get_hw_event_config(PERF_COUNT_HW_INSTRUCTIONS);
 	kvm_pmu_eventsel.BRANCH_INSTRUCTIONS_RETIRED =
-- 
2.55.0

