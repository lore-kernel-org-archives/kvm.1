Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCBE3CF047;
	Mon, 29 Jun 2026 23:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782775736; cv=none; b=LNeEMy7kXAJFj7LHOP8bD+4VvhTner5H4FOeHIZHXQ1WCefKsk/TFl6zI9il50Pw5gVDePH4YFjUDP4akj0+yKvf1Iqh7dCnwUgmcf0V7B1vokvB/uYp9mTwdDeIPFNIpxTbn5BgBIwQhlq6i9hcIPCVA7B3/xIUaw5q8zmbUwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782775736; c=relaxed/simple;
	bh=Rb74TtPntcb6nfQvSzlTCZkzMQqty6wAk0rCb6Z8YOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQZ1exYFXFcKMZzhlJLIvcPoLq2C5jLdpDkFsPQgzGRxyJb+tqCJ4AYhbu4AVChF5emzcfRsLfvbVyzg45HxT98SFMdZAGliTn9ZdBfSHhSU3ordSbyiEUd1qiI4B/yn89wuadQg2ZkNSXWQs9E1PBSSeaNrq5dMxdD66s96sEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xqtec+V4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xqtec+V4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782775734; x=1814311734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rb74TtPntcb6nfQvSzlTCZkzMQqty6wAk0rCb6Z8YOI=;
  b=Xqtec+V45WQNmG9bvvQR3H/K72Fwh6TScp9u5uPo5vNM5qicAhuMkyCK
   4JcqNPTk6A4O5hM3Uh6Il/h/3NTMLJEYWQapVfOhqMmTCwd383RBx67Hx
   6kZPq1G3/905MI0w9RsCVuwK0GLu3NSLiyWa3/UZV8yKOoCYWVjNaVA46
   E5JFmmz+r4YY+o7fOuRxNtHBgBaShl2RSYmkX6CA4qivaBuzCUmqcAT77
   xUiUqQ//D0uBE+9mbObUPV/RnkdTHDGG4K4l1zryR4isfH1/BEfpopPie
   WWtq4stb2LjQGX6FD/YMrlmBU2qNqpDjUFesbg+AofTrzD/fIf63sPy3s
   A==;
X-CSE-ConnectionGUID: OhRG9HMETh+6V4QO60DtkA==
X-CSE-MsgGUID: A5YxEF6UTZu80+/JUbw1EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82593506"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="82593506"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 16:28:44 -0700
X-CSE-ConnectionGUID: X8gWNsAfR5Wdz0MZOIVsew==
X-CSE-MsgGUID: cEhoouwbRnCerFneENZwIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="290220141"
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
Subject: [PATCH v6 5/8] KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU
Date: Mon, 29 Jun 2026 16:19:34 -0700
Message-ID: <20260629231938.15129-6-zide.chen@intel.com>
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
 arch/x86/include/asm/kvm_host.h   |  1 +
 arch/x86/include/asm/msr-index.h  |  1 +
 arch/x86/include/asm/perf_event.h |  1 +
 arch/x86/kvm/msrs.c               |  6 +++++-
 arch/x86/kvm/pmu.h                |  5 +++++
 arch/x86/kvm/vmx/pmu_intel.c      | 31 +++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c            |  7 +++++++
 7 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 80f638588bf7..96376d8a5199 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -630,6 +630,7 @@ struct kvm_pmu {
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
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 1eb13673e889..bc2e1cbcd9b9 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -447,6 +447,7 @@ static inline bool is_topdown_idx(int idx)
 #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT	54
 #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD	BIT_ULL(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT)
 #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT	48
+#define GLOBAL_STATUS_PERF_METRICS_OVF		BIT_ULL(GLOBAL_STATUS_PERF_METRICS_OVF_BIT)
 
 #define GLOBAL_CTRL_EN_PERF_METRICS		BIT_ULL(48)
 /*
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
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index e426ddc8add4..225afd3937c3 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -188,6 +188,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	switch (msr) {
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		return kvm_pmu_has_perf_global_ctrl(pmu);
+	case MSR_PERF_METRICS:
+		return kvm_vcpu_has_perf_metrics(vcpu);
 	case MSR_IA32_PEBS_ENABLE:
 		ret = kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PEBS_FORMAT;
 		break;
@@ -345,6 +347,9 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		msr_info->data = pmu->fixed_ctr_ctrl;
 		break;
+	case MSR_PERF_METRICS:
+		msr_info->data = pmu->perf_metrics;
+		break;
 	case MSR_IA32_PEBS_ENABLE:
 		msr_info->data = pmu->pebs_enable;
 		break;
@@ -394,6 +399,15 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (pmu->fixed_ctr_ctrl != data)
 			reprogram_fixed_counters(pmu, data);
 		break;
+	case MSR_PERF_METRICS:
+		/*
+		 * On platforms that support only hardware level-1, bits [63:32]
+		 * are reserved and ignored by hardware. If hardware level-2 is also
+		 * supported, they may contain valid metric data.
+		 * Either way, guest writes are passed through verbatim.
+		 */
+		pmu->perf_metrics = data;
+		break;
 	case MSR_IA32_PEBS_ENABLE:
 		if (data & pmu->pebs_enable_rsvd)
 			return 1;
@@ -589,6 +603,11 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 		pmu->global_status_rsvd &=
 				~MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI;
 
+	if (perf_capabilities & PERF_CAP_PERF_METRICS) {
+		pmu->global_ctrl_rsvd &= ~GLOBAL_CTRL_EN_PERF_METRICS;
+		pmu->global_status_rsvd &= ~GLOBAL_STATUS_PERF_METRICS_OVF;
+	}
+
 	if (perf_capabilities & PERF_CAP_PEBS_FORMAT) {
 		if (perf_capabilities & PERF_CAP_PEBS_BASELINE) {
 			pmu->pebs_enable_rsvd = counter_rsvd;
@@ -632,6 +651,9 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
 
 static void intel_pmu_reset(struct kvm_vcpu *vcpu)
 {
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	pmu->perf_metrics = 0;
 	intel_pmu_release_guest_lbr_event(vcpu);
 }
 
@@ -803,6 +825,9 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	u64 global_status, toggle;
 
+	if (kvm_vcpu_has_perf_metrics(vcpu))
+		wrmsrq(MSR_PERF_METRICS, pmu->perf_metrics);
+
 	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
 	toggle = pmu->global_status ^ global_status;
 	if (global_status & toggle)
@@ -831,6 +856,12 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
 	 */
 	if (pmu->fixed_ctr_ctrl_hw)
 		wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
+
+	if (kvm_vcpu_has_perf_metrics(vcpu)) {
+		pmu->perf_metrics = rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS);
+		if (pmu->perf_metrics)
+			wrmsrq(MSR_PERF_METRICS, 0);
+	}
 }
 
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b736b9ff965b..21eb4b339fa6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4273,6 +4273,10 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 				  MSR_TYPE_RW, intercept);
 	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
 				  MSR_TYPE_RW, intercept);
+
+	intercept = !has_mediated_pmu || !kvm_vcpu_has_perf_metrics(vcpu);
+	vmx_set_intercept_for_msr(vcpu, MSR_PERF_METRICS,
+				  MSR_TYPE_RW, intercept);
 }
 
 static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
@@ -8095,6 +8099,9 @@ static __init u64 vmx_get_perf_capabilities(void)
 		perf_cap &= ~PERF_CAP_PEBS_BASELINE;
 	}
 
+	if (enable_mediated_pmu)
+		perf_cap |= kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS;
+
 	return perf_cap;
 }
 
-- 
2.54.0

