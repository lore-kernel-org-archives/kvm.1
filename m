Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557212;
	b=tTmryI451MRJiPQJk85YvjigDeDX1cMNTN4JTM83O6BiZ4lJ8yDJeZCI8Tya7XXB1xyG
	 pXd+2PmuGLILdx9lH+MzKwj69vuXFG12NXAe4C3Q335GShCBpcTZtNVuGlXZwzwfg1gK3
	 bxTqds0yJ5aOcR/6GqCO9RyUmGecoKCOAV7bIFvv6jkXw4rMzmEguvlfdy0tkINPknxbh
	 Af6rxu0VhlzOcr+KGcJ7DEVbLy5PBLiGDmO5J5nRXR7WLa9HpWh21VkvZy2OyvCi65QrN
	 dN8RvbwqmwmD/kMPD/WB/gq+TB7VP2tf9skVP8eUBjSIRvw3r2g/A4LdjCOvBVwwxpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557212;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MqEZ0L3Z2NqTuKZ3CGkVKGAK51a4bRw3t0lA655m6Lc=;
	b=VhtTT+sn6JvJrUn7PmJprotOnbkHvMB5YlpjbeCNIyGB8MMbaOzgu9oRaxH0xyJgnr5k
	 mcMRpJStryUvpCeVIjPFnlMG1GwE+GphfnCeE9/8ZfBv7EhwHUweZR3h7RGUd3w89jiV/
	 vL7uuc0n+4U3r3Fo96uJy1G6s2c9Zo0NNl6SzRZP4aFyKpRc6y5YibrL0Vq0DLWVPQO5s
	 e/119v9yntAVPbZPfsJIgGJEvcj2m0O+edxPOryRgv4ZxdAQX/rjBN93FX+T+sfuurp3c
	 mewJAcVEcQ48gRBYGNVGgsx9LvWC8quopo2TixpwD2f/jSdLan6+vBYlP4nGDPjJ+lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jQdoNXRP;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902960A3825;
	Tue, 24 Nov 2026 21:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A902960A3825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jQdoNXRP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557211; x=1827093211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dpsveV/TwfxxvNQzkj/30m903fPg+5AwzgIa3UXWH98=;
  b=jQdoNXRPsDZbO7MiK9kD8CfST7OBJZvpHnXtpM/T18aMW8AMpLbA3tMq
   KnC1/3ZyAVbgnmeBZLPF89yb6Q99NbAdXJLBj41EzFXe0rMljvrI6d0WW
   6wMLCgVG194THqmvhSuhZ/2PG+sTw4HRxDV+HTsi1TTolwj9M9JvNu1EW
   pdmibTWN2J+3HHCvz6cljksFubKEhe7iC8b93gY+Zp/AqgCHZk8vsIGFW
   yre3I0cxDvESQhpa/TJCa/bVGz/8Ab0KSW3sj36y452TqSgtZwMG1JvP0
   RXxgy0AlYlDJEApOrvGfNIizHj2R5XP5o1q0315sp72Qc881j/YubpgZt
   g==;
X-CSE-ConnectionGUID: w8HUYhx+RMKwElHojFokrA==
X-CSE-MsgGUID: TVRfX8ZxQOCSJBiC3dN9FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4306070"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4306070"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:30 -0800
X-CSE-ConnectionGUID: utKTg6JiSjaKr5afK89ofw==
X-CSE-MsgGUID: I+IwI/tSS7qcFvob7ktO6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271953"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:30 -0800
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
Subject: [PATCH v10 14/18] KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU
Date: Tue, 24 Nov 2026 14:38:57 -0700
Message-ID: <20261124213901.120572-15-zide.chen@intel.com>
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

Expose IA32_PERF_CAPABILITIES.PERF_METRICS_AVAILABLE[bit 15] only when
mediated vPMU is enabled, as emulating IA32_PERF_METRICS in the legacy
vPMU model is impractical.

Enabling Topdown metrics in hardware requires both IA32_PERF_METRICS
and fixed counter 3 (SLOTS). Therefore, gate MSR passthrough and
hardware context switching on fixed counter 3 in addition to guest
IA32_PERF_CAPABILITIES.PERF_METRICS_AVAILABLE[bit 15].

Architecturally, IA32_PERF_METRICS can be partly decoupled from fixed
counter 3. In that case, keep the MSR intercepted and treat all metric
fields as reserved (~0ull): reads return 0, writes of 0 succeed, and
non-zero writes are rejected. IA32_PERF_GLOBAL_CTRL[48] can likewise
be set without the counter.

Save and restore IA32_PERF_METRICS on vPMU context switches. Also add
IA32_PERF_METRICS to msrs_to_save_pmu[] to support guest migration.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v10:
- Fold v9 patch 11 ("KVM: x86/pmu: Reject writes to reserved
  MSR_PERF_METRICS bits") into this patch. (Jim)
- Gate advertising PERF_CAP_PERF_METRICS on num_topdown_events != 0. (Jim)
- Gate IA32_PERF_METRICS passthrough, perf_metrics_rsvd sizing, and
  context switch on fixed counter 3. (Jim, Yosry)

v9:
- Remove the incorrect comment about writing to MSR_PERF_METRICS.
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/msrs.c             |  6 +++-
 arch/x86/kvm/pmu.c              |  1 +
 arch/x86/kvm/pmu.h              | 13 +++++++
 arch/x86/kvm/vmx/nested.c       |  2 ++
 arch/x86/kvm/vmx/pmu_intel.c    | 60 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c          | 12 +++++++
 7 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1261f8302dc8..9d9b7aa38043 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -584,6 +584,7 @@ struct kvm_pmu {
 	u64 reserved_bits;
 	u64 raw_event_mask;
 	u64 perf_metrics;
+	u64 perf_metrics_rsvd;
 	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
 	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
 
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 1ccea561f2e0..26eb853baab5 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -219,7 +219,7 @@ static const u32 msrs_to_save_pmu[] = {
 	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
 	MSR_ARCH_PERFMON_FIXED_CTR2, MSR_ARCH_PERFMON_FIXED_CTR3,
 	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
-	MSR_CORE_PERF_GLOBAL_CTRL,
+	MSR_CORE_PERF_GLOBAL_CTRL, MSR_PERF_METRICS,
 	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
 
 	/* This part of MSRs should match KVM_MAX_NR_INTEL_GP_COUNTERS. */
@@ -2619,6 +2619,10 @@ static void kvm_probe_msr_to_save(u32 msr_index)
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
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index d4fd1d9d5d93..93be6ac96a1c 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1019,6 +1019,7 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->fixed_ctr_ctrl_rsvd = ~0ull;
 	pmu->pebs_enable_rsvd = ~0ull;
 	pmu->pebs_data_cfg_rsvd = ~0ull;
+	pmu->perf_metrics_rsvd = ~0ull;
 	bitmap_zero(pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
 
 	if (!vcpu->kvm->arch.enable_pmu)
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 40395d271392..a82f6a9b4cc9 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -287,6 +287,19 @@ static inline bool kvm_vcpu_has_perf_metrics(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PERF_METRICS;
 }
 
+static inline bool kvm_pmu_has_fixed_counter(struct kvm_pmu *pmu,
+					     unsigned int idx)
+{
+	return idx < pmu->nr_arch_fixed_counters;
+}
+
+/* Functional Topdown metrics in hardware also require fixed counter 3 (SLOTS). */
+static inline bool kvm_vcpu_can_enable_perf_metrics(struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_has_perf_metrics(vcpu) &&
+	       kvm_pmu_has_fixed_counter(vcpu_to_pmu(vcpu), KVM_FIXED_SLOTS_IDX);
+}
+
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
 int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f854c..2b36088ee056 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -724,6 +724,8 @@ static void nested_vmx_merge_pmu_msr_bitmaps(struct kvm_vcpu *vcpu,
 	nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_GLOBAL_CTRL);
 	nested_vmx_merge_msr_bitmaps_read(MSR_CORE_PERF_GLOBAL_STATUS);
 	nested_vmx_merge_msr_bitmaps_write(MSR_CORE_PERF_GLOBAL_OVF_CTRL);
+
+	nested_vmx_merge_msr_bitmaps_rw(MSR_PERF_METRICS);
 }
 
 /*
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index cb7db4784545..da6dae261514 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -207,6 +207,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		return kvm_pmu_has_perf_global_ctrl(pmu);
+	case MSR_PERF_METRICS:
+		return kvm_vcpu_has_perf_metrics(vcpu);
 	case MSR_IA32_PEBS_ENABLE:
 		ret = kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PEBS_FORMAT;
 		break;
@@ -364,6 +366,9 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		msr_info->data = pmu->fixed_ctr_ctrl;
 		break;
+	case MSR_PERF_METRICS:
+		msr_info->data = pmu->perf_metrics;
+		break;
 	case MSR_IA32_PEBS_ENABLE:
 		msr_info->data = pmu->pebs_enable;
 		break;
@@ -413,6 +418,12 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (pmu->fixed_ctr_ctrl != data)
 			reprogram_fixed_counters(pmu, data);
 		break;
+	case MSR_PERF_METRICS:
+		if (data & pmu->perf_metrics_rsvd)
+			return 1;
+
+		pmu->perf_metrics = data;
+		break;
 	case MSR_IA32_PEBS_ENABLE:
 		if (data & pmu->pebs_enable_rsvd)
 			return 1;
@@ -519,6 +530,30 @@ static void intel_pmu_enable_fixed_counter_bits(struct kvm_pmu *pmu, u64 bits)
 		pmu->fixed_ctr_ctrl_rsvd &= ~intel_fixed_bits_by_idx(i, bits);
 }
 
+static void intel_pmu_refresh_perf_metrics(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	if (!kvm_vcpu_has_perf_metrics(vcpu))
+		return;
+
+	/*
+	 * Per the SDM, setting GLOBAL_CTRL[48] is allowed as long as
+	 * PERF_CAP_PERF_METRICS is present. However, hardware metrics remain
+	 * inactive without enabling fixed counter 3.
+	 */
+	pmu->global_ctrl_rsvd &= ~GLOBAL_CTRL_EN_PERF_METRICS;
+
+	if (!kvm_pmu_has_fixed_counter(pmu, KVM_FIXED_SLOTS_IDX))
+		return;
+
+	if (kvm_pmu_cap.num_topdown_events) {
+		pmu->perf_metrics_rsvd =
+			~GENMASK_ULL(kvm_pmu_cap.num_topdown_events *
+				     INTEL_TD_METRIC_FIELD_BITS - 1, 0);
+	}
+}
+
 static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -597,6 +632,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
 	pmu->global_ctrl_rsvd = counter_rsvd;
 
+	intel_pmu_refresh_perf_metrics(vcpu);
+
 	/*
 	 * GLOBAL_STATUS and GLOBAL_OVF_CONTROL (a.k.a. GLOBAL_STATUS_RESET)
 	 * share reserved bit definitions.  The kernel just happens to use
@@ -652,6 +689,9 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
 
 static void intel_pmu_reset(struct kvm_vcpu *vcpu)
 {
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	pmu->perf_metrics = 0;
 	intel_pmu_release_guest_lbr_event(vcpu);
 }
 
@@ -817,6 +857,15 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	u64 global_status, toggle;
 
+	/*
+	 * Without fixed counter 3, Topdown metrics cannot count in hardware.
+	 * Thus, the guest metric state is always zero and no context switch
+	 * is needed.
+	 */
+	if (kvm_vcpu_can_enable_perf_metrics(vcpu) &&
+	    pmu->perf_metrics != rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS))
+		wrmsrq(MSR_PERF_METRICS, pmu->perf_metrics);
+
 	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
 	toggle = pmu->global_status ^ global_status;
 	if (global_status & toggle)
@@ -845,6 +894,17 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
 	 */
 	if (pmu->fixed_ctr_ctrl_hw)
 		wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
+
+	if (kvm_vcpu_can_enable_perf_metrics(vcpu)) {
+		pmu->perf_metrics = rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS);
+		/*
+		 * The SDM requires restoring fixed counter 3 before
+		 * PERF_METRICS, but order doesn't matter when both are being
+		 * zeroed.
+		 */
+		if (pmu->perf_metrics)
+			wrmsrq(MSR_PERF_METRICS, 0);
+	}
 }
 
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f04f2d3884d9..7441808be049 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4289,6 +4289,10 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 				  MSR_TYPE_RW, intercept);
 	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
 				  MSR_TYPE_RW, intercept);
+
+	intercept = !has_mediated_pmu || !kvm_vcpu_can_enable_perf_metrics(vcpu);
+	vmx_set_intercept_for_msr(vcpu, MSR_PERF_METRICS,
+				  MSR_TYPE_RW, intercept);
 }
 
 static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
@@ -7934,6 +7938,14 @@ static __init u64 vmx_get_perf_capabilities(void)
 		perf_cap &= ~PERF_CAP_PEBS_BASELINE;
 	}
 
+	/*
+	 * In addition to fixed counter 3, gate on num_topdown_events to
+	 * avoid advertising on generic arch setups (e.g. virtualized hosts).
+	 */
+	if (enable_mediated_pmu && kvm_pmu_cap.num_topdown_events &&
+	    kvm_pmu_cap.num_counters_fixed > KVM_FIXED_SLOTS_IDX)
+		perf_cap |= kvm_pmu_cap.perf_capabilities & PERF_CAP_PERF_METRICS;
+
 	return perf_cap;
 }
 
-- 
2.56.1

