Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07473A873C;
	Tue, 23 Jun 2026 04:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782188935; cv=none; b=ReZ2nGMDldsVklPAUf57Is0xpDAC/u55nwLMxtxUjiQxMaLoQzpO7ayaFPRQbukhEwdxFpFTrpdcdcGwcexfzzHz7aZMOCAOugh3lUJzyJgFx8nU7waRq8OTHHF3oSzj/4Xp/pYEsrnTDmECvY72F6vp6PiV795oNX9hlzLC7+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782188935; c=relaxed/simple;
	bh=o/dZvoy52Mi2UIjktg4HBnygE0EDoohvA8LebRiLeh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfA19k5Rxjj4q6Kz1RCQwnGeQpGf+VOqNF5u9CFrKPcJjb+HACAuvKiCJOyoJ1/Q/46+uOJ208+uhgsT5IK6q2w/CJUcQpj+QzuK5KXH/mz7wrGT3TACFNOpCMz0oCc9nCz+2XXyQTCICl5VayIEO/AYv1UskXkTZqV95mfSJwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5FMxUmJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5FMxUmJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782188934; x=1813724934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o/dZvoy52Mi2UIjktg4HBnygE0EDoohvA8LebRiLeh4=;
  b=R5FMxUmJLGC1tzu3RTXn7f/zfhcv/JiG+0Ad8EFI1xcWwS4zq5eJAQ/c
   YwMyAxa0cuIcBTWU+BBoHujcZEOUYXF3Tc3F4I0cJO0Jp8KlBtWjwpOPh
   UZQ3yGkuZ8P+bVEIshcxSUgfMlbwCKF73c7+BhpXr+NXW9tSfadhjH8FC
   p6GE1NElNLMb6Tn+O6Wz/K57uMt/lCjmp0HZw8mWT7+iXx5THmjXGjGNW
   E+mwyFq0eJHhn36i40yoNssKDVvqmF3Hjf3++iLUS9HPEhXoFlXBp2p+5
   3vrvbG+epb0EBf0nRRHTv6MQpSgoUcUNThDKmJ0dcIOg6AI0ZXIAVxQhF
   A==;
X-CSE-ConnectionGUID: BOpts9nJRcCRu5t056qNoA==
X-CSE-MsgGUID: OXKYqggSTnKpXk2oc0nVeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82809049"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82809049"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 21:28:49 -0700
X-CSE-ConnectionGUID: fA1bnw15TVKkkBMe9eBARw==
X-CSE-MsgGUID: 4phj5xWeROqKjk7pdmN65Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="279587566"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 21:28:50 -0700
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
Subject: [PATCH V4 2/4] KVM: x86/pmu: Support Intel fixed counter 3 on mediated vPMU
Date: Mon, 22 Jun 2026 21:19:25 -0700
Message-ID: <20260623041927.178256-3-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623041927.178256-1-zide.chen@intel.com>
References: <20260623041927.178256-1-zide.chen@intel.com>
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
v3:
- Move the non-contiguous counter filter code to pmu.c
v2:
- Don't advertise fixed counter 3 to userspace if the host doesn't
  support it.
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/pmu.c              | 18 ++++++++++++++++++
 arch/x86/kvm/x86.c              |  4 ++--
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index eee473717c0e..edd414f8ee95 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -574,7 +574,7 @@ struct kvm_pmc {
 #define KVM_MAX_NR_GP_COUNTERS		KVM_MAX(KVM_MAX_NR_INTEL_GP_COUNTERS, \
 						KVM_MAX_NR_AMD_GP_COUNTERS)
 
-#define KVM_MAX_NR_INTEL_FIXED_COUNTERS	3
+#define KVM_MAX_NR_INTEL_FIXED_COUNTERS	4
 #define KVM_MAX_NR_AMD_FIXED_COUNTERS	0
 #define KVM_MAX_NR_FIXED_COUNTERS	KVM_MAX(KVM_MAX_NR_INTEL_FIXED_COUNTERS, \
 						KVM_MAX_NR_AMD_FIXED_COUNTERS)
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index b92dd2e58335..0faf580782d5 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -122,6 +122,8 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
 {
 	bool is_intel = boot_cpu_data.x86_vendor == X86_VENDOR_INTEL;
 	int min_nr_gp_ctrs = pmu_ops->MIN_NR_GP_COUNTERS;
+	union cpuid10_edx edx;
+	u32 eax, ebx, ecx;
 
 	/*
 	 * Hybrid PMUs don't play nice with virtualization without careful
@@ -169,6 +171,22 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
 	kvm_pmu_cap.num_counters_fixed = min(kvm_pmu_cap.num_counters_fixed,
 					     KVM_MAX_NR_FIXED_COUNTERS);
 
+	/*
+	 * Intel platforms may support non-contiguous fixed counters, e.g., some
+	 * E-core based server processors don't implement fixed counter 3.
+	 *
+	 * Before KVM supports non-contiguous fixed counters, make sure only
+	 * contiguous ones are retained in kvm_pmu_cap.
+	 */
+	if (kvm_host_pmu.version >= 5) {
+		cpuid(10, &eax, &ebx, &ecx, &edx.full);
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
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d9d51803b7b2..e872398c12fc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -350,7 +350,7 @@ static const u32 msrs_to_save_base[] = {
 
 static const u32 msrs_to_save_pmu[] = {
 	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
-	MSR_ARCH_PERFMON_FIXED_CTR0 + 2,
+	MSR_ARCH_PERFMON_FIXED_CTR2, MSR_ARCH_PERFMON_FIXED_CTR3,
 	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
 	MSR_CORE_PERF_GLOBAL_CTRL,
 	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
@@ -7742,7 +7742,7 @@ static void kvm_init_msr_lists(void)
 {
 	unsigned i;
 
-	BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 3,
+	BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 4,
 			 "Please update the fixed PMCs in msrs_to_save_pmu[]");
 
 	num_msrs_to_save = 0;
-- 
2.54.0

