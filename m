Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D23CF20C;
	Mon, 29 Jun 2026 23:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782775734; cv=none; b=a7dd33ouj9zk2NEeYb5wmcNRNGxKBmxktfFJ3T4uWcpaKxIx95sGz6qxdVN757OXbwRBGk1LEsueEf4MxZStsTmesbHichL5BJ31GVpd5I+aiOjfVyvlW1MK5PMpjJpmNayR8nvs3WXpkjuyB0gUjEHpHcRQQzLVl+QeXzJfmHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782775734; c=relaxed/simple;
	bh=Lj9PQZhDVDRAiTDkfHZaPAUjunitSd6JLMDgVHdgNSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpgpfFGZjA99OyfLXLB2Dqj+P+YvxMj6fHhyONVgPV+PG8KPoGy/lvSgbqYvu+cR0KpGGOfOTTbd1xAnj/XuO8zkFM7FwSW77/P3sMW9ItJZd4DoytytZrAEu6gdvO5rsBqMDzsynO8Ojr/G9WO4HytSEoxNlYk3n9UxwioJg4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fy39h454; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fy39h454"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782775729; x=1814311729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lj9PQZhDVDRAiTDkfHZaPAUjunitSd6JLMDgVHdgNSg=;
  b=Fy39h454+BQbEwEwKXuf6S5u9bpit3rYFx0vDvjW6wSlLOndxF9fNW6t
   BtDqdJLC3x89FkFNWCoUo7wc8PwFKNDMhfz8FxYjaz0F1ZdEKajm2c9dv
   Y7euYr8T+DY+8cd/qoknB01c9Ar0wbisbnpmTEU3uFtMVDH67/ru3ldcQ
   Iv/TyjgD/T4eiFGcV4cooJW3X+w+OyM9oZAUPQpvAbkLLuYMmW4qKY8Ii
   gQO2WrBhrz5znbCGjrS7j+dLJNiRgaTJT1emSAVGaNVzx+b8+5I/o17Zq
   +qOCJIBjWmC1gi4LqnwLtDXK6xJObYHYLijfLAiqoNdGf1ijIlXG3BqZ+
   Q==;
X-CSE-ConnectionGUID: /kJjIPSISguVQxmlE4CB8g==
X-CSE-MsgGUID: 4jPzsNu0SU2KLx/I0+knyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82593493"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="82593493"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 16:28:44 -0700
X-CSE-ConnectionGUID: Hb+IyfNmTrOnOEr0X9Qlzg==
X-CSE-MsgGUID: AyMn1dI2Sv+l1z7aeHwsqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="290220132"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 16:28:44 -0700
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
Subject: [PATCH v6 2/8] KVM: x86/pmu: Support Intel fixed counter 3 on mediated vPMU
Date: Mon, 29 Jun 2026 16:19:31 -0700
Message-ID: <20260629231938.15129-3-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629231938.15129-1-zide.chen@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
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
 arch/x86/kvm/pmu.c              | 18 +++++++++++++++++-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d8700eb848b4..dc9e4e8bfc07 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -609,7 +609,7 @@ struct kvm_pmc {
 #define KVM_MAX_NR_GP_COUNTERS		KVM_MAX(KVM_MAX_NR_INTEL_GP_COUNTERS, \
 						KVM_MAX_NR_AMD_GP_COUNTERS)
 
-#define KVM_MAX_NR_INTEL_FIXED_COUNTERS	3
+#define KVM_MAX_NR_INTEL_FIXED_COUNTERS	4
 #define KVM_MAX_NR_AMD_FIXED_COUNTERS	0
 #define KVM_MAX_NR_FIXED_COUNTERS	KVM_MAX(KVM_MAX_NR_INTEL_FIXED_COUNTERS, \
 						KVM_MAX_NR_AMD_FIXED_COUNTERS)
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index c230b18d87e3..3bf42d90ad14 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -228,7 +228,7 @@ static const u32 msrs_to_save_base[] = {
 
 static const u32 msrs_to_save_pmu[] = {
 	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
-	MSR_ARCH_PERFMON_FIXED_CTR0 + 2,
+	MSR_ARCH_PERFMON_FIXED_CTR2, MSR_ARCH_PERFMON_FIXED_CTR3,
 	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
 	MSR_CORE_PERF_GLOBAL_CTRL,
 	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
@@ -2688,7 +2688,7 @@ void kvm_init_msr_lists(void)
 {
 	unsigned i;
 
-	BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 3,
+	BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 4,
 			 "Please update the fixed PMCs in msrs_to_save_pmu[]");
 
 	num_msrs_to_save = 0;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 62d0ed99ebe9..f82ba63767d0 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -99,7 +99,8 @@ static const struct x86_cpu_id vmx_pebs_pdist_cpu[] = {
  *        all perf counters (both gp and fixed). The mapping relationship
  *        between pmc and perf counters is as the following:
  *        * Intel: [0 .. KVM_MAX_NR_INTEL_GP_COUNTERS-1] <=> gp counters
- *                 [KVM_FIXED_PMC_BASE_IDX .. KVM_FIXED_PMC_BASE_IDX + 2] <=> fixed
+ *                 [KVM_FIXED_PMC_BASE_IDX .. KVM_FIXED_PMC_BASE_IDX +
+ *                  KVM_MAX_NR_INTEL_FIXED_COUNTERS - 1] <=> fixed
  *        * AMD:   [0 .. AMD64_NUM_COUNTERS-1] and, for families 15H
  *          and later, [0 .. AMD64_NUM_COUNTERS_CORE-1] <=> gp counters
  */
@@ -134,6 +135,8 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
 {
 	bool is_intel = boot_cpu_data.x86_vendor == X86_VENDOR_INTEL;
 	int min_nr_gp_ctrs = pmu_ops->MIN_NR_GP_COUNTERS;
+	union cpuid10_edx edx;
+	u32 eax, ebx, ecx;
 
 	/*
 	 * Hybrid PMUs don't play nice with virtualization without careful
@@ -181,6 +184,19 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
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
2.54.0

