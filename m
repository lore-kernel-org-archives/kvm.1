Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C25522F18;
	Fri, 18 Sep 2026 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761020; cv=none; b=gDR7yjqkKd1X/UgtMGyagM2O17FroXlQOfnzKJ90uN0uTXZ6pU6lvsl3cquJZc3ElP7v5e/xtqPVBKcMnAY4Pug5x1UErdQU0ghl/USGILAu+UUmuIGBNmtwMOeni+gm0un8StWmDr8oFnbwn0HEecdq2eNCai5fqQCVJUzH/Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761020; c=relaxed/simple;
	bh=ysWbtPoovnUUuEs7ePCxtRTEHCH8yywg1iONeXDgVNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyIcMdy3IepokHGvB3qVUtZIh8LkIKDXkM8N8U7v940kP6JWULG8oIeVTSqvLQODPfOyX+88LsG5T7lZ0IgBfHUJTejo8YOJS+z0PyPnDa1ySSdGEYO/vOHRQ/bqKRKPc0tve1zjcHiA8Z2arwOBmp+pwZ6Vv/HbStqsFfbwhTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XlRnwkUp; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XlRnwkUp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789761019; x=1821297019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ysWbtPoovnUUuEs7ePCxtRTEHCH8yywg1iONeXDgVNA=;
  b=XlRnwkUpxD6ZVBT+UgO3p/g01e27hMCKLl2yfu+YwbbXhYrgL2ziS7hr
   pTUcqdT1c1H124zhWE9G+vMpMoADnLTjrwiJnCFbFQziQ6ZOL2TKYo4E0
   LQMmeowFAFw1gJiyDl1CK4KHx50fN1Cgs8ZM6/RGS5qHmHBUsW/T8zXan
   /Ou9WPbh9xIauFW8oXA1CyU7vRYONDOpbSiShPVm6VZwHZgSxRQD4WuzA
   yoDj5KtaHTCQqi8bZuvQghbeWZX2jsF77+xZjjUBRPrI2T70oeHhLGHEI
   voh0q9fIEE7lhPJRQbDSZtb2DNZczoJrUXIxDJBHyEZiX+KPFCIOiXsa5
   w==;
X-CSE-ConnectionGUID: gLNTKs+gQoCxlYCEiBjGTg==
X-CSE-MsgGUID: Wqzjnuh9Tl60enPuogfjEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="790332"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="790332"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:50:01 -0700
X-CSE-ConnectionGUID: JZhBiKOVSQKIavqHcxGkPQ==
X-CSE-MsgGUID: O2LyjqwqRgyb4l78uQH86g==
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
Subject: [PATCH v9 11/12] KVM: x86/pmu: Reject writes to reserved MSR_PERF_METRICS bits
Date: Fri, 18 Sep 2026 12:39:36 -0700
Message-ID: <20260918193937.569414-12-zide.chen@intel.com>
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

When the host CPU supports only 4 Topdown metrics, bits [63:32] of
MSR_PERF_METRICS are reserved.

Derive pmu->perf_metrics_rsvd from the number of supported Topdown
metrics and use it to validate writes. Reject any attempts to set
reserved bits in MSR_PERF_METRICS.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v9: new patch.
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/pmu.c              |  1 +
 arch/x86/kvm/vmx/pmu_intel.c    | 18 +++++++++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 052bf377dedb..31454ecee371 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -585,6 +585,7 @@ struct kvm_pmu {
 	u64 reserved_bits;
 	u64 raw_event_mask;
 	u64 perf_metrics;
+	u64 perf_metrics_rsvd;
 	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
 	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
 
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 0df283a169b6..41f2d31c495f 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1006,6 +1006,7 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->fixed_ctr_ctrl_rsvd = ~0ull;
 	pmu->pebs_enable_rsvd = ~0ull;
 	pmu->pebs_data_cfg_rsvd = ~0ull;
+	pmu->perf_metrics_rsvd = ~0ull;
 	bitmap_zero(pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
 
 	if (!vcpu->kvm->arch.enable_pmu)
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index fab0891ad46a..98e2fb80347a 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -417,6 +417,9 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			reprogram_fixed_counters(pmu, data);
 		break;
 	case MSR_PERF_METRICS:
+		if (data & pmu->perf_metrics_rsvd)
+			return 1;
+
 		pmu->perf_metrics = data;
 		break;
 	case MSR_IA32_PEBS_ENABLE:
@@ -601,9 +604,22 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	counter_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
 			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
 	pmu->global_ctrl_rsvd = counter_rsvd;
-	if (perf_capabilities & PERF_CAP_PERF_METRICS)
+	if (perf_capabilities & PERF_CAP_PERF_METRICS) {
 		pmu->global_ctrl_rsvd &= ~GLOBAL_CTRL_EN_PERF_METRICS;
 
+		/*
+		 * PERF_METRICS has one 8-bit field per metric. At 8 metrics,
+		 * skip computing the mask and set perf_metrics_rsvd to 0
+		 * directly, since BIT_ULL(64) is undefined.
+		 */
+		if (kvm_pmu_cap.num_topdown_events < INTEL_TD_METRIC_NUM)
+			pmu->perf_metrics_rsvd =
+				~(BIT_ULL(kvm_pmu_cap.num_topdown_events *
+					  INTEL_TD_METRIC_FIELD_BITS) - 1);
+		else
+			pmu->perf_metrics_rsvd = 0;
+	}
+
 	/*
 	 * GLOBAL_STATUS and GLOBAL_OVF_CONTROL (a.k.a. GLOBAL_STATUS_RESET)
 	 * share reserved bit definitions.  The kernel just happens to use
-- 
2.55.0

