Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B5F3A9D90;
	Thu, 23 Apr 2026 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966903; cv=none; b=Nu4XWeAMsQhg5y5fjRcLWMLXPbT/QmMrhcLUdmpWiHBOHWzS0oBAt0u0IYUNTy8FPy7kIdwkCRMQmFSQurbEF/fBPpdwdz98QLw2cFeKwpoY7XLapGKY8AI+TWXEx39I7HGigPVB040chqXijE2nX9dHbHzDyny9ev6tyOVs90U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966903; c=relaxed/simple;
	bh=zXy++oaLR7vJD1x7DfWk6XGybabKvzDaOO9Wx0sD0BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzdtMzclOTbwnLbwrOjMBVZYIQatFyv2uQsSSv/Gw2UaaXsM7pzgeK9Hdgd/FYmAT35zsh6CQA+BOx52FFYt+KPUAVvzqC9wElEb44gc1qpVbm3L1Ycu18Ami5mklJ7B/NthiPjWNUBl/PuIBO8P2ft8LxYC7Mp65NRX1fNvGio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ofm4JEbQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ofm4JEbQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776966901; x=1808502901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zXy++oaLR7vJD1x7DfWk6XGybabKvzDaOO9Wx0sD0BI=;
  b=Ofm4JEbQ0uagVyQlq80k9rqIsRABPc4hCUbbSigr6/FRxhA+4/ATB2ff
   fVz1a8Bca3xRHVFJkgcZhhZwXagqP9rh/XUNCV4Pm9NgmolT7+sI8wGHR
   CXazVqU3LLYyimoIT970cfTzGPL0rL7i2DhB8vTAwM9qnD2jF8UucZMU3
   /7NvGyfCemGOFqw/wXVOuzZ+hnaOR2NdIad2JCg9DK9YVQbAts3B+JblZ
   v/mxqnZKF45jwLRuhm42JKUWXC0jq2uKWdnkD4q2463IfDUAMo6qAioyA
   FDIi01Vd3U0rzw45G951uMhuJoJYO/fVKf7tNM/nZka7uQgds09uUxrOx
   Q==;
X-CSE-ConnectionGUID: VsQNGZvhTR6JD0/Sjr7BWg==
X-CSE-MsgGUID: lDTad0FpRnSPd/B76bzqmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89407718"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="89407718"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 10:54:57 -0700
X-CSE-ConnectionGUID: mJQZjRFOS7asWeDQL1pfeA==
X-CSE-MsgGUID: AZx4w9XbR+S/dlkoWXFIQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="236707814"
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
Subject: [PATCH V2 2/4] KVM: x86/pmu: Support Intel fixed counter 3 on mediated vPMU
Date: Thu, 23 Apr 2026 10:46:37 -0700
Message-ID: <20260423174639.56149-3-zide.chen@intel.com>
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

Starting with Ice Lake, Intel introduces fixed counter 3, which counts
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
V2:
- Don't advertise fixed counter 3 to userspace if the host doesn't
  support it.
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/cpuid.c            | 9 +++++++--
 arch/x86/kvm/pmu.c              | 4 ++++
 arch/x86/kvm/x86.c              | 4 ++--
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c470e40a00aa..cb736a4c72ea 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -556,7 +556,7 @@ struct kvm_pmc {
 #define KVM_MAX_NR_GP_COUNTERS		KVM_MAX(KVM_MAX_NR_INTEL_GP_COUNTERS, \
 						KVM_MAX_NR_AMD_GP_COUNTERS)
 
-#define KVM_MAX_NR_INTEL_FIXED_COUNTERS	3
+#define KVM_MAX_NR_INTEL_FIXED_COUNTERS	4
 #define KVM_MAX_NR_AMD_FIXED_COUNTERS	0
 #define KVM_MAX_NR_FIXED_COUNTERS	KVM_MAX(KVM_MAX_NR_INTEL_FIXED_COUNTERS, \
 						KVM_MAX_NR_AMD_FIXED_COUNTERS)
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e69156b54cff..d87a26f740e5 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1505,7 +1505,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		break;
 	case 0xa: { /* Architectural Performance Monitoring */
 		union cpuid10_eax eax = { };
-		union cpuid10_edx edx = { };
+		union cpuid10_edx edx = { }, host_edx;
 
 		if (!enable_pmu || !static_cpu_has(X86_FEATURE_ARCH_PERFMON)) {
 			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
@@ -1516,9 +1516,14 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		eax.split.num_counters = kvm_pmu_cap.num_counters_gp;
 		eax.split.bit_width = kvm_pmu_cap.bit_width_gp;
 		eax.split.mask_length = kvm_pmu_cap.events_mask_len;
-		edx.split.num_counters_fixed = kvm_pmu_cap.num_counters_fixed;
 		edx.split.bit_width_fixed = kvm_pmu_cap.bit_width_fixed;
 
+		/* Guest does not support non-contiguous fixed counters. */
+		host_edx = (union cpuid10_edx)entry->edx;
+		edx.split.num_counters_fixed =
+			 min_t(int, kvm_pmu_cap.num_counters_fixed,
+			       host_edx.split.num_counters_fixed);
+
 		if (kvm_pmu_cap.version)
 			edx.split.anythread_deprecated = 1;
 
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index e218352e3423..9ff4a6a9cd0b 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -148,12 +148,16 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
 	}
 
 	memcpy(&kvm_pmu_cap, &kvm_host_pmu, sizeof(kvm_host_pmu));
+
 	kvm_pmu_cap.version = min(kvm_pmu_cap.version, 2);
 	kvm_pmu_cap.num_counters_gp = min(kvm_pmu_cap.num_counters_gp,
 					  pmu_ops->MAX_NR_GP_COUNTERS);
 	kvm_pmu_cap.num_counters_fixed = min(kvm_pmu_cap.num_counters_fixed,
 					     KVM_MAX_NR_FIXED_COUNTERS);
 
+	if (!enable_mediated_pmu && kvm_pmu_cap.num_counters_fixed > 3)
+		kvm_pmu_cap.num_counters_fixed = 3;
+
 	kvm_pmu_eventsel.INSTRUCTIONS_RETIRED =
 		perf_get_hw_event_config(PERF_COUNT_HW_INSTRUCTIONS);
 	kvm_pmu_eventsel.BRANCH_INSTRUCTIONS_RETIRED =
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..604072d9354f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -360,7 +360,7 @@ static const u32 msrs_to_save_base[] = {
 
 static const u32 msrs_to_save_pmu[] = {
 	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
-	MSR_ARCH_PERFMON_FIXED_CTR0 + 2,
+	MSR_ARCH_PERFMON_FIXED_CTR2, MSR_ARCH_PERFMON_FIXED_CTR3,
 	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
 	MSR_CORE_PERF_GLOBAL_CTRL,
 	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
@@ -7756,7 +7756,7 @@ static void kvm_init_msr_lists(void)
 {
 	unsigned i;
 
-	BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 3,
+	BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 4,
 			 "Please update the fixed PMCs in msrs_to_save_pmu[]");
 
 	num_msrs_to_save = 0;
-- 
2.54.0

