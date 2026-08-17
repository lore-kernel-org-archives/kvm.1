Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35423470110;
	Mon, 17 Aug 2026 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992090; cv=none; b=J/4+AzPPREUnFyTz1fQD2uj7dXbILD1mTHXPNKrUMjJQ2C3bfRKpPiryciEqzj7ScnHOeJXv+3RHC7OWhUgFzvjP+QQH/af/7uIQYE0BfR4Hy8iYd6zPoaNux/gQI98hJ6mipTZkGn2wd8LzYyKufHvMlAyCtCP7CxvexZKtbcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992090; c=relaxed/simple;
	bh=7enoeOr+5bHlwtkPhEcyQTkoqg1DbtY8tEDKcB319iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRErLed52afxvFrPfEdoYuZjGVAeIoOJiRRJbOSeyd/WTcILV3HbkEQ/YjB4OkO40sp7hcAblT1vNUepPLt343zikdLrfHfeXt1c06kSHxWinQrW/s4us73ZiZAd/VEjMd1oMjcAr8lK6aT4BxrfLQ4qNgkI8ZE0dQMHpSnnWXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aEX/Np5K; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aEX/Np5K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786992089; x=1818528089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7enoeOr+5bHlwtkPhEcyQTkoqg1DbtY8tEDKcB319iE=;
  b=aEX/Np5KujO3l/4VNRodIZfywDX19156JW+EhNWOmCGBOGtLKzsIIxos
   yQ7t1OvbNk6Qg9/RLRhi0bJTVCcXrBwPPFraX7wGIwYv9uKViROR9yzxn
   5QXGJZ0AF3XNkJblmnvxEzzs4NAUg9L8RtmeumGNd785IIDrKFHBTwV1T
   Vtx4rPrfieyPzbHxET5ZETXrPt9DYmpNd1B5Cf/DqyE08M3DAsiCL2BdJ
   JkTXfahSGu+76vY2I2Iq2eQmuD7bJMAdatmbV9B5i8lm17y7yEEGTFOyw
   SbGyiUoK1g7fXZAFr9i+aSbivKaXviUMn9jGsRPz2CnlnZOVV4cH+44mz
   w==;
X-CSE-ConnectionGUID: Se1UkMjsRDSc7K4Fsogziw==
X-CSE-MsgGUID: K1+pvi5lSP2hBQWDACNT2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98066084"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="98066084"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 11:41:25 -0700
X-CSE-ConnectionGUID: NytYkXPSRg+GGvz9nguNUA==
X-CSE-MsgGUID: dbs722HgTJaosJhrxE2y4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="263656959"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 11:41:24 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v8 2/8] KVM: x86/pmu: Support Intel fixed counter 3 on mediated vPMU
Date: Mon, 17 Aug 2026 11:31:36 -0700
Message-ID: <20260817183143.226156-3-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817183143.226156-1-zide.chen@intel.com>
References: <20260817183143.226156-1-zide.chen@intel.com>
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
v3:
- Move the non-contiguous counter filter code to pmu.c
v2:
- Don't advertise fixed counter 3 to userspace if the host doesn't
  support it.
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/msrs.c             |  4 ++--
 arch/x86/kvm/pmu.c              | 19 ++++++++++++++++++-
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 283847619ff8..8a4e542218a7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -562,7 +562,7 @@ struct kvm_pmc {
 #define KVM_MAX_NR_GP_COUNTERS		KVM_MAX(KVM_MAX_NR_INTEL_GP_COUNTERS, \
 						KVM_MAX_NR_AMD_GP_COUNTERS)
 
-#define KVM_MAX_NR_INTEL_FIXED_COUNTERS	3
+#define KVM_MAX_NR_INTEL_FIXED_COUNTERS	4
 #define KVM_MAX_NR_AMD_FIXED_COUNTERS	0
 #define KVM_MAX_NR_FIXED_COUNTERS	KVM_MAX(KVM_MAX_NR_INTEL_FIXED_COUNTERS, \
 						KVM_MAX_NR_AMD_FIXED_COUNTERS)
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 66fa7140d65d..1fbd8f08a7f0 100644
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
@@ -2671,7 +2671,7 @@ void kvm_init_msr_lists(void)
 {
 	unsigned i;
 
-	BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 3,
+	BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 4,
 			 "Please update the fixed PMCs in msrs_to_save_pmu[]");
 
 	num_msrs_to_save = 0;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index a7d60c8785cd..913a0ecbf260 100644
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
+ *                 [KVM_FIXED_PMC_BASE_IDX .. KVM_FIXED_PMC_BASE_IDX +
+ *                  KVM_MAX_NR_INTEL_FIXED_COUNTERS - 1] <=> fixed
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

