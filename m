Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557210;
	b=viL7xaCkIukHkI3zuCT4+wwXsKJcrVQ9egnqL3OXxFQCHeUW+Zfd75HAeLnOgnqlG9jW
	 UrM2QTG1mzRzgohSYYiNuDi1MELav2BVdaGqT8JLxoIFvwxvd4KYJSaEfGE6fP1zdSqmk
	 k7tm40npJd9n900JVi+LCSuio4M+G3LrO/n/xusec7P5c0TCUQngHKsbHsFgilSzSmBYz
	 7B1zhgyhYGXpdN45cCNBsEYcNHF2etfNjgqHufwbKlVShL1dNGPiIYXEp6mlRlicrptIz
	 X3hxKAMwiwrSqyvCr/0IsX5eRFczNCrRUPj/bxG/jdxNioLV5LbKwfDKap7JVoZF+tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557210;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0Nk2x3r1jR/s7mP470s13lG9JN9QWTS5IipzGrQzB5s=;
	b=JwgzFTylxW8lu2bdpfyxqBOoVPYSVZcng6+5c4JUCw314RZFW36F+xw+aPzrqlMEVHRJ
	 UCzihs7RLC6nwEMU4eAzA0tu3ZITtUVSaDHF8s+sylvQBLaPamOq6amrWZ2GKTf3tCEvh
	 IbOebk9S5c2DjH+sOEVHTCQ+PydkeJSDf9fYWAlcFJmnvoo/+xhRUUFY5/CqeJucenxYL
	 uWMGiRUfbp81h68V1AQ49VodgZCYX/UiEo5u7SVfI7kdyYjtiteU41lIepDPwfF3cj6Gg
	 iIgVxz3+duBvr4bmk2gyt9mB7hSyxZrh95hdQqh/4RphLTS7C2S1cgM7KaKALYZ3dTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rr1DeZzG;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBADF60A263D;
	Tue, 24 Nov 2026 21:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBADF60A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rr1DeZzG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557210; x=1827093210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aBEYUfLsJKxWZX9MXk82xLxJhn7lEfFUXCe5ZT9YYMM=;
  b=Rr1DeZzGWMhi54fcdGdWCjGwDZKXL9UNKc7AH3yMn+hpyimSHD2BdIUX
   GUrxFv+iRe/uKcg5LYqLiMb5smDuGF6r4R08I+zieP4dN/43YbhnFIIMc
   SEdoF0/pejaH00rvJsT7KxEo+LJhfmi2lPMNhu74F9m48dabW7ETMG/uy
   9WYADqpilshXT0bPNGSLy9pfBE+QZmOnY2uRgu8XJveZKcOtPEPhO3WfQ
   TbNBv9UM3sThq5zc4ZmPIjY3sfxu+g44CF3te5gXCnbApI/+AJ9HMXzaZ
   AboDnZHtU+H/ATY1C21c91loRLbkl3Bwiy63DRGlt2mRl8NcRI2m/5+2L
   g==;
X-CSE-ConnectionGUID: 1xpWGBO3RRCIc2pEprpkSA==
X-CSE-MsgGUID: quE+cn+TR2KZcJRtfFLypA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4306050"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4306050"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:29 -0800
X-CSE-ConnectionGUID: lHkwMRxfRmaX1hl6TmWm4A==
X-CSE-MsgGUID: GqI5IQqdQY6komanlupWHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271936"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:28 -0800
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
Subject: [PATCH v10 11/18] KVM: x86/pmu: Support Intel fixed counter 3 on mediated vPMU
Date: Tue, 24 Nov 2026 14:38:54 -0700
Message-ID: <20261124213901.120572-12-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124213901.120572-1-zide.chen@intel.com>
References: <20261124213901.120572-1-zide.chen@intel.com>
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

Starting with Ice Lake, Intel introduced fixed counter 3, which counts
TOPDOWN.SLOTS - the number of available slots for an unhalted logical
processor.  It serves as the denominator for top-level metrics in the
Topdown Microarchitecture Analysis method.

Emulating this counter on legacy vPMU would require introducing a new
generic perf encoding for the Intel-specific TOPDOWN.SLOTS event in
order to call perf_get_hw_event_config().  This is undesirable as it
would pollute the generic perf event encoding.

Moreover, KVM does not intend to emulate IA32_PERF_METRICS in the
legacy vPMU model, and without IA32_PERF_METRICS, emulating this
counter has little practical value.  Therefore, expose fixed counter
3 to guests only when mediated vPMU is enabled.

On PMU v5+, clamp num_counters_fixed to the number of contiguous fixed
counters enumerated in CPUID.0xA:EDX[4:0] to prevent exposing non-
contiguous counter holes that KVM cannot emulate.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
v10:
- Rename INTEL_FIXED_SLOTS_IDX to KVM_FIXED_SLOTS_IDX to match naming
  convention in pmu.h.
- Add explanatory comment for non-mediated PMU fixed counter capping.
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/msrs.c             |  4 ++--
 arch/x86/kvm/pmu.c              | 23 ++++++++++++++++++++++-
 arch/x86/kvm/pmu.h              |  1 +
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e2eef7057bd3..aad835338759 100644
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
index e91650af44c2..1ccea561f2e0 100644
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
@@ -2682,7 +2682,7 @@ void kvm_init_msr_lists(void)
 {
 	unsigned i;
 
-	BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 3,
+	BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 4,
 			 "Please update the fixed PMCs in msrs_to_save_pmu[]");
 
 	num_msrs_to_save = 0;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 4574cac5f148..45721c6fa92b 100644
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
@@ -181,6 +185,23 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
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
+	/*
+	 * Fixed counters >= KVM_FIXED_SLOTS_IDX (counter 3) do not map to
+	 * generic perf events and cannot be emulated without mediated PMU.
+	 */
+	if (!enable_mediated_pmu && kvm_pmu_cap.num_counters_fixed > KVM_FIXED_SLOTS_IDX)
+		kvm_pmu_cap.num_counters_fixed = KVM_FIXED_SLOTS_IDX;
+
 	kvm_pmu_eventsel.INSTRUCTIONS_RETIRED =
 		perf_get_hw_event_config(PERF_COUNT_HW_INSTRUCTIONS);
 	kvm_pmu_eventsel.BRANCH_INSTRUCTIONS_RETIRED =
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index ae1e6545df40..1d7cbe89fa95 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -24,6 +24,7 @@
 #define VMWARE_BACKDOOR_PMC_APPARENT_TIME	0x10002
 
 #define KVM_FIXED_PMC_BASE_IDX INTEL_PMC_IDX_FIXED
+#define KVM_FIXED_SLOTS_IDX    (INTEL_PMC_IDX_FIXED_SLOTS - INTEL_PMC_IDX_FIXED)
 
 struct kvm_pmu_ops {
 	struct kvm_pmc *(*rdpmc_ecx_to_pmc)(struct kvm_vcpu *vcpu,
-- 
2.56.1

