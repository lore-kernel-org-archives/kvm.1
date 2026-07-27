Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAFE3D45EA;
	Mon, 27 Jul 2026 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180730; cv=none; b=dMRTCT3anmFVbhnGtxt7O7HcJbMqfIWng/cp7VPJSFA5K7tA0mU6hu0Ve9AcyYUJteoRI62IW8uYg7ARBGO3cV7SB2Zt1dnn72mru0lr3LbpfVCzuoxuHDJHyxBtpHE41ThEOwi0Ghz1/R1gUy/N38GiFyiKuQGRrajyQhTxXis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180730; c=relaxed/simple;
	bh=OIpgGHMD61ck7m1vwTrtcDDodUwOEUis5qKg+8LrYGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thWZKlegnbmzqWB4AFtPbRKUsiAMwTa5cLCEtmPSr7IrhDuY95JjwZVnzrePuQsqgcJdW72pUSp3kmimjBy/rXfv9r3UWv8/kqLNtNh0J+sc0VgHMJfpGjmEiJGgTJRCyOs3+jPxRqdvDCyoHDgNaZ+pIE/udz+sHNiHqUBSXjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ec7V6I88; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ec7V6I88"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785180727; x=1816716727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OIpgGHMD61ck7m1vwTrtcDDodUwOEUis5qKg+8LrYGs=;
  b=Ec7V6I88D/ydhrG0JXI7sKTli2jQm8eoxhq2T7Aye+9+1Wi2A9zMyd4z
   R8wSIU4c4zB3m4UGKx3FOrn+kY+5PgMX2OB0Z4WZWvi5A1DG4VJiJXhyF
   w7U8iklpvTkcuVQ4PG5+1PnhZqmjvoJKZGjdsQvYhpitzDuQFw9YVAMYN
   +LVxVcA8jWJjzpIBNM7CoIV2V3Zf79NhX1y1TwsKUKMSjNEGZQT4aOAfD
   /TEKdV6a5PUn3545U0voPrfJ6VUNQLjNJ6ZKVRqseiXKKBTLDCwUgukkA
   5RrYOcCNYdeIlSe789fE+8EuUUbIw9r62Oxj3ifBcZ0ETBVUqcbNwVz9p
   g==;
X-CSE-ConnectionGUID: +/BF9YvZRWCl3XfbeJrOQQ==
X-CSE-MsgGUID: vshnNY6dSB2PuI7DIRgzAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85876710"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="85876710"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 12:32:00 -0700
X-CSE-ConnectionGUID: WfC5YUwFRRqtLA770XEcZA==
X-CSE-MsgGUID: N9eXSM2lTH6VJ3ei+LP7Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="289451041"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 12:32:00 -0700
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
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v7 5/9] KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU
Date: Mon, 27 Jul 2026 12:21:27 -0700
Message-ID: <20260727192131.582105-6-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727192131.582105-1-zide.chen@intel.com>
References: <20260727192131.582105-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Bit 15 in IA32_PERF_CAPABILITIES indicates that the CPU provides
built-in support for Topdown Microarchitecture Analysis (TMA) L1
metrics via the IA32_PERF_METRICS MSR.

Expose this capability only when mediated vPMU is enabled, as emulating
IA32_PERF_METRICS in the legacy vPMU model is impractical.

Pass IA32_PERF_METRICS through to the guest only when mediated vPMU is
enabled and bit 15 is set in guest IA32_PERF_CAPABILITIES.  Allow
kvm_pmu_{get,set}_msr() to handle this MSR for host accesses.

Save and restore this MSR on host/guest PMU context switches so that
host PMU activity does not clobber the guest value, and guest state
is not leaked into the host.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v7:
- Clear bit 48 in global_ctrl_rsvd instead of explicitly clearing it in
  global_status_rsvd, allowing it to propagate through the assignment
  from global_ctrl_rsvd.
- Add comments documenting the all-zero PERF_METRICS/FC3 write-order
  exception.
- Add nested_vmx_merge_msr_bitmaps_rw(MSR_PERF_METRICS);
v5:
- Remove host_initiated check in set/get MSR handlers.
v4:
- Remove WARN_ON_ONCE() and simply reject the guest accesses by checking
  host_initiated. (Sashiko)
- Passthru MSR_PERF_METRICS only if has_mediated_pmu is true. (Sashiko)
- Remove the redundant !! in vcpu_has_perf_metrics().
v3:
- Replace WARN_ON() with WARN_ON_ONCE(). (Dapeng)
- Add comments to explain why we don't validate writes on PERF_METRICS.
---
 arch/x86/include/asm/kvm_host.h  |  1 +
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/kvm/msrs.c              |  6 +++++-
 arch/x86/kvm/pmu.h               |  5 +++++
 arch/x86/kvm/vmx/nested.c        |  2 ++
 arch/x86/kvm/vmx/pmu_intel.c     | 34 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c           |  7 +++++++
 7 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e663bdfb1d02..a90bce8552f9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -581,6 +581,7 @@ struct kvm_pmu {
 	u64 global_status_rsvd;
 	u64 reserved_bits;
 	u64 raw_event_mask;
+	u64 perf_metrics;
 	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
 	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 18c4be75e927..fdcaeb6c8352 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -331,6 +331,7 @@
 #define PERF_CAP_PEBS_FORMAT		0xf00
 #define PERF_CAP_FW_WRITES		BIT_ULL(13)
 #define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
+#define PERF_CAP_PERF_METRICS		BIT_ULL(15)
 #define PERF_CAP_PEBS_TIMING_INFO	BIT_ULL(17)
 #define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
 					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 3bf42d90ad14..c751a8dbd45d 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -230,7 +230,7 @@ static const u32 msrs_to_save_pmu[] = {
 	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
 	MSR_ARCH_PERFMON_FIXED_CTR2, MSR_ARCH_PERFMON_FIXED_CTR3,
 	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
-	MSR_CORE_PERF_GLOBAL_CTRL,
+	MSR_CORE_PERF_GLOBAL_CTRL, MSR_PERF_METRICS,
 	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
 
 	/* This part of MSRs should match KVM_MAX_NR_INTEL_GP_COUNTERS. */
@@ -2625,6 +2625,10 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 		     intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) * 2))
 			return;
 		break;
+	case MSR_PERF_METRICS:
+		if (!(kvm_caps.supported_perf_cap & PERF_CAP_PERF_METRICS))
+			return;
+		break;
 	case MSR_ARCH_PERFMON_PERFCTR0 ...
 	     MSR_ARCH_PERFMON_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
 		if (msr_index - MSR_ARCH_PERFMON_PERFCTR0 >=
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 1b2f66a2e915..3066cade5790 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -279,6 +279,11 @@ static inline u64 kvm_vcpu_get_perf_caps(struct kvm_vcpu *vcpu)
 	return vcpu->arch.perf_capabilities;
 }
 
+static inline bool kvm_vcpu_has_perf_metrics(struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PERF_METRICS;
+}
+
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
 int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b5460de4b1a7..56a9931d6994 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -717,6 +717,8 @@ static void nested_vmx_merge_pmu_msr_bitmaps(struct kvm_vcpu *vcpu,
 	nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_GLOBAL_CTRL);
 	nested_vmx_merge_msr_bitmaps_read(MSR_CORE_PERF_GLOBAL_STATUS);
 	nested_vmx_merge_msr_bitmaps_write(MSR_CORE_PERF_GLOBAL_OVF_CTRL);
+
+	nested_vmx_merge_msr_bitmaps_rw(MSR_PERF_METRICS);
 }
 
 /*
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index a9202737debe..a2845d398377 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -189,6 +189,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	switch (msr) {
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		return kvm_pmu_has_perf_global_ctrl(pmu);
+	case MSR_PERF_METRICS:
+		return kvm_vcpu_has_perf_metrics(vcpu);
 	case MSR_IA32_PEBS_ENABLE:
 		ret = kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PEBS_FORMAT;
 		break;
@@ -346,6 +348,9 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		msr_info->data = pmu->fixed_ctr_ctrl;
 		break;
+	case MSR_PERF_METRICS:
+		msr_info->data = pmu->perf_metrics;
+		break;
 	case MSR_IA32_PEBS_ENABLE:
 		msr_info->data = pmu->pebs_enable;
 		break;
@@ -395,6 +400,14 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (pmu->fixed_ctr_ctrl != data)
 			reprogram_fixed_counters(pmu, data);
 		break;
+	case MSR_PERF_METRICS:
+		/*
+		 * Bits [63:32] are ignored on hardware that supports only
+		 * level-1 metrics, but may be valid on hardware that supports
+		 * level-2 metrics. Preserve guest writes verbatim.
+		 */
+		pmu->perf_metrics = data;
+		break;
 	case MSR_IA32_PEBS_ENABLE:
 		if (data & pmu->pebs_enable_rsvd)
 			return 1;
@@ -577,6 +590,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	counter_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
 			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
 	pmu->global_ctrl_rsvd = counter_rsvd;
+	if (perf_capabilities & PERF_CAP_PERF_METRICS)
+		pmu->global_ctrl_rsvd &= ~GLOBAL_CTRL_EN_PERF_METRICS;
 
 	/*
 	 * GLOBAL_STATUS and GLOBAL_OVF_CONTROL (a.k.a. GLOBAL_STATUS_RESET)
@@ -633,6 +648,9 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
 
 static void intel_pmu_reset(struct kvm_vcpu *vcpu)
 {
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	pmu->perf_metrics = 0;
 	intel_pmu_release_guest_lbr_event(vcpu);
 }
 
@@ -804,6 +822,9 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	u64 global_status, toggle;
 
+	if (kvm_vcpu_has_perf_metrics(vcpu))
+		wrmsrq(MSR_PERF_METRICS, pmu->perf_metrics);
+
 	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
 	toggle = pmu->global_status ^ global_status;
 	if (global_status & toggle)
@@ -832,6 +853,19 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
 	 */
 	if (pmu->fixed_ctr_ctrl_hw)
 		wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
+
+	if (kvm_vcpu_has_perf_metrics(vcpu)) {
+		pmu->perf_metrics = rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS);
+		/*
+		 * The SDM requires restoring fixed counter 3 before
+		 * PERF_METRICS. However, this path writes 0 to PERF_METRICS
+		 * before fixed counter 3. For this all-zero case, the
+		 * resulting hardware state is therefore the same regardless
+		 * of write order.
+		 */
+		if (pmu->perf_metrics)
+			wrmsrq(MSR_PERF_METRICS, 0);
+	}
 }
 
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 08c70f94ae39..c93ba17838c4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4274,6 +4274,10 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 				  MSR_TYPE_RW, intercept);
 	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
 				  MSR_TYPE_RW, intercept);
+
+	intercept = !has_mediated_pmu || !kvm_vcpu_has_perf_metrics(vcpu);
+	vmx_set_intercept_for_msr(vcpu, MSR_PERF_METRICS,
+				  MSR_TYPE_RW, intercept);
 }
 
 static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
@@ -8096,6 +8100,9 @@ static __init u64 vmx_get_perf_capabilities(void)
 		perf_cap &= ~PERF_CAP_PEBS_BASELINE;
 	}
 
+	if (enable_mediated_pmu)
+		perf_cap |= kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS;
+
 	return perf_cap;
 }
 
-- 
2.54.0

