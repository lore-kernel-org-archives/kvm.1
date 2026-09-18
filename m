Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B852E522EF7;
	Fri, 18 Sep 2026 19:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761022; cv=none; b=PsCLkURBIX7G6R6e8jww4FYdxx4DmeVUsxH/CeRrNDIwsqv9k6KG0rxB/tTA2jwMqNbojW+63WGZMXsG7o8AdC/7f+MZNWHtqSQwm3WG0G2O65kHJhzYse7SrEekxxkYEWQoXvlJO4f6ArzXw+27EHeNn9Pc+PUPvYvVl8lhBak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761022; c=relaxed/simple;
	bh=q/Ylq4VOuCweW7soP1rWHUekmtQBs+CbvU+5Fa4f/2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJjEb59fkNZWnFexHln41K5tvp20ZzQmm9l3u07YPT7U01vWjSUnxRcz5vBYUDwdE3ClULXJOw5xnto13unNKbnOldTO159FPGvCPYIY9S758BSxYLB1W3pUi3BQ3jTCJcbl4TyObDSQjyHOMEPUxr5nVYZYAbhLMJzBHkYl2Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+IzvDP+; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+IzvDP+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789761019; x=1821297019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q/Ylq4VOuCweW7soP1rWHUekmtQBs+CbvU+5Fa4f/2Y=;
  b=L+IzvDP+64xqBDcFDcaIgbBYaAb7GE3txDt+rvbz2Fw8jQjCGXOTLO11
   bE6cUYqy7RRT/TO8NEfjbj3+TUinCQ378JgACwokkL30fZPYvX/8NE+Sx
   gZDU0Dqzbg2mFj2hWVJVWlgspYEfYAmFD95TAynOlY66qeQC3zkm0h9SM
   d46eKBZBXuhHu6vlTp10WrHLf/23tKtL2b5Qv/NYDCbd9HHnVQiFXe0ZX
   Tz8bsawlbHa7khqBxFoVzYy+T3ytz8QLviuEIYmXMqf9VjrFfniBS97Qm
   x7Dbc4uzbPU9FC6jM7XnGxdw6tj05IcTpTwQUIZUH38bRNgWtnMpFzfGF
   Q==;
X-CSE-ConnectionGUID: EFOJSXWuR8GBAKsK6Vi81w==
X-CSE-MsgGUID: 19Rlvo+jQEOO00cLw/UswQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="790333"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="790333"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:50:01 -0700
X-CSE-ConnectionGUID: NknVs8TMQL6MCSMaaEWtog==
X-CSE-MsgGUID: p02D6JC6TaiFIJ18DxJ8+A==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:50:01 -0700
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
Subject: [PATCH v9 12/12] KVM: x86/pmu: Support RDPMC Metrics Clear Mode
Date: Fri, 18 Sep 2026 12:39:37 -0700
Message-ID: <20260918193937.569414-13-zide.chen@intel.com>
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

Add PERF_CAP_RDPMC_METRICS_CLEAR (IA32_PERF_CAPABILITIES bit 19)
support. When set, and IA32_FIXED_CTR_CTRL.METRICS_CLEAR_EN (bit 14)
is also set, RDPMC of PERF_METRICS clears both PERF_METRICS and fixed
counter 3 (SLOTS) after the read.

Advertise the capability to guests only when the mediated PMU is
enabled and the host reports it. Unmask FIXED_CTR_CTRL bit 14 in
intel_pmu_refresh(), scoped to fixed counter 3 only via
intel_fixed_bits_by_idx().

For the mediated PMU, METRICS_CLEAR_EN takes effect natively via
passthrough. But kvm_need_rdpmc_intercept() can still force
interception for unrelated reasons, so intel_emulate_rdpmc() also
replicates the clear-on-read behavior for consistency.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v9: new patch.
---
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/kvm/vmx/pmu_intel.c     | 28 ++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c           |  6 +++++-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 8fad944197fb..5851edcdda05 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -333,6 +333,7 @@
 #define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
 #define PERF_CAP_PERF_METRICS		BIT_ULL(15)
 #define PERF_CAP_PEBS_TIMING_INFO	BIT_ULL(17)
+#define PERF_CAP_RDPMC_METRICS_CLEAR	BIT_ULL(19)
 #define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
 					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
 					 PERF_CAP_PEBS_TIMING_INFO)
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 98e2fb80347a..3e5e8bae67ab 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -36,6 +36,9 @@
 #define INTEL_RDPMC_TYPE_MASK	GENMASK(31, 16)
 #define INTEL_RDPMC_INDEX_MASK	GENMASK(15, 0)
 
+/* Index of the SLOTS fixed counter relative to the first fixed counter. */
+#define INTEL_FIXED_SLOTS_IDX	(INTEL_PMC_IDX_FIXED_SLOTS - INTEL_PMC_IDX_FIXED)
+
 #define MSR_PMC_FULL_WIDTH_BIT      (MSR_IA32_PMC0 - MSR_IA32_PERFCTR0)
 
 static struct lbr_desc *vcpu_to_lbr_desc(struct kvm_vcpu *vcpu)
@@ -86,6 +89,14 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 	}
 }
 
+static bool intel_pmu_metrics_clear_enabled(struct kvm_pmu *pmu)
+{
+	u8 fixed_ctr_ctrl = fixed_ctrl_field(pmu->fixed_ctr_ctrl,
+					     INTEL_FIXED_SLOTS_IDX);
+
+	return fixed_ctr_ctrl & INTEL_FIXED_3_METRICS_CLEAR;
+}
+
 static int intel_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx,
 			       u64 *data)
 {
@@ -138,6 +149,18 @@ static int intel_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx,
 			return 1;
 
 		*data = pmu->perf_metrics;
+
+		/*
+		 * Per the SDM, RDPMC of PERF_METRICS clears both PERF_METRICS
+		 * and the SLOTS fixed counter when Metrics Clear Mode is
+		 * enabled via INTEL_FIXED_3_METRICS_CLEAR in FIXED_CTR_CTRL.
+		 */
+		pmc = kvm_pmc_idx_to_pmc(pmu, INTEL_PMC_IDX_FIXED_SLOTS);
+		if (pmc && intel_pmu_metrics_clear_enabled(pmu)) {
+			pmu->perf_metrics = 0;
+			pmc_write_counter(pmc, 0);
+		}
+
 		return 0;
 	default:
 		return 1;
@@ -601,6 +624,11 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 						 INTEL_FIXED_0_USER |
 						 INTEL_FIXED_0_ENABLE_PMI);
 
+	if (perf_capabilities & PERF_CAP_RDPMC_METRICS_CLEAR)
+		pmu->fixed_ctr_ctrl_rsvd &=
+			~intel_fixed_bits_by_idx(INTEL_FIXED_SLOTS_IDX,
+						 INTEL_FIXED_3_METRICS_CLEAR);
+
 	counter_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
 			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
 	pmu->global_ctrl_rsvd = counter_rsvd;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 372de66365ab..df02372c70e3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2616,6 +2616,9 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			if (!cpuid_model_is_consistent(vcpu))
 				return 1;
 		}
+		if ((data & PERF_CAP_RDPMC_METRICS_CLEAR) &&
+		    !(data & PERF_CAP_PERF_METRICS))
+			return 1;
 		ret = kvm_set_msr_common(vcpu, msr_info);
 		break;
 
@@ -7999,7 +8002,8 @@ static __init u64 vmx_get_perf_capabilities(void)
 	}
 
 	if (enable_mediated_pmu)
-		perf_cap |= kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS;
+		perf_cap |= kvm_host.perf_capabilities &
+			    (PERF_CAP_PERF_METRICS | PERF_CAP_RDPMC_METRICS_CLEAR);
 
 	return perf_cap;
 }
-- 
2.55.0

