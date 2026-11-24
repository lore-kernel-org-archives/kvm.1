Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557213;
	b=RJdHY7OHLcYVMU72rM1n5TTHwZbv/PwaY1hWifuHkCjvZA18bzOPu1G1tTSWhkEvBdVC
	 X6Sdk4FdiXDDVnOuwk+OXmTDsFdIIncWaemwMloEz8JFYY5mCxbqYYOxao8v0HoPMGfku
	 xqXcX4f18ZDBjIDJ8EKuRMy7W2Ad1HXv8nADe7AIWjdBBMH+y4uU96h7c9HZ/d4cUF7OY
	 i/DlRaD6Xqe7iGk4SqVFc7chhlYyLwAuxou9D8To7zFw5ocEk6ShAvibCDpa8ANT/3pc/
	 mZjol0rDNjBOmCtY0hpzxxbHE8BGzHBRCRaENOpL3fmmnpYpCY2goGPRxLkkimlWbMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557213;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eFi/MCHFV/iGEqwhrZ93u4CFOTXFTwBlyg8ehkDYwO4=;
	b=BnDtmu9T4rY7fJxrrewZOitDua/aFzEbd60BmTGCqv+fxn2bydtjOfmq/dFEcVM43/fo
	 qJyTKFTwi9C9k9lDGmijcnOPf7VPIm7WQGTcKdW140eiLUplgde2H5lobDKRK2rtIsAJk
	 fo0vxg8XHJE3rX6uUx2ihKkwSDS2VKpQ+h9UnJ0FjosBP0abPnQ0p0rJwDS2G8P78DBkt
	 PyN2cOg09ktR9e6mRlF1t/xP060oVqfuqAVSAEI6OY8PYWmHNZJviPGIMkMeYIMhvlbLb
	 m3Xz/E71zr10Jh908/yJ689jjU2Z4w0MyDSfwoVKxfERmTEXlk7/SapKnC9GcJkTSrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RFsqs4Oh;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3918960A383D;
	Tue, 24 Nov 2026 21:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3918960A383D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RFsqs4Oh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557212; x=1827093212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/+ZSyOWAz/BtXstavY7FHTBo6Fnj6JVhip7iyipZZAg=;
  b=RFsqs4Ohku74Aanwf9erO5l3foviz7p3K01J7WVFRo8srQLM6UOCfxLN
   Pnvjc0CfC6BfL6y7bXzXi0qd7xLZFjlUUYK+7OC2cd7QJ3H5moChQ1nHL
   Xw4smxwtp6lT239372QY8C4wlvl5V0NdCTfYRY6gkgdTIBIiRMwSxG5Ud
   FvY/4eAZ7mxL7FI102th0D8xljQ1TvU5992rXmratBifn4GPRt3DuClko
   23KsF2+2I50j60152kuS5fyF9Y4bM09tvSAD/9Hn9AaWcT05tWxivUPyG
   k4xD2o1HuPIxBqCX1lfxziYJ6G2Pr9IVFxDrYibrptH+NjJUz4TIzjcTK
   g==;
X-CSE-ConnectionGUID: Fgta1JTbS4ySkAH72ieI/g==
X-CSE-MsgGUID: 1ankINOsRFOOxuQWW0aXKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4306076"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4306076"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:31 -0800
X-CSE-ConnectionGUID: dEKhub/UTlKh/0eC4tVQgA==
X-CSE-MsgGUID: XnYnzxnVTqWi7vp+hbveeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271959"
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
Subject: [PATCH v10 15/18] KVM: x86/pmu: Support RDPMC Metrics Clear Mode
Date: Tue, 24 Nov 2026 14:38:58 -0700
Message-ID: <20261124213901.120572-16-zide.chen@intel.com>
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

Add PERF_CAP_RDPMC_METRICS_CLEAR (IA32_PERF_CAPABILITIES bit 19)
support. When set, and IA32_FIXED_CTR_CTRL.METRICS_CLEAR_EN (bit 14)
is also set, RDPMC of PERF_METRICS clears both PERF_METRICS and fixed
counter 3 (SLOTS) after the read.

Advertise the capability to guests only when the mediated vPMU is
enabled and the host reports it, and allow the guest to set
METRICS_CLEAR_EN for fixed counter 3 when PERF_METRICS,
RDPMC_METRICS_CLEAR, and fixed counter 3 are all exposed to the guest.

For the mediated vPMU, METRICS_CLEAR_EN takes effect natively via
passthrough. However, RDPMC can still be intercepted for unrelated
reasons, so also emulate the clear-on-read behavior for consistency.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v10:
- Gate METRICS_CLEAR_EN unmasking on both perf_metrics and FC3.
- Check for valid fixed counter 3 PMC before clearing it in
  intel_emulate_rdpmc().
- Drop check in vmx_set_msr() requiring PERF_CAP_PERF_METRICS. (Jim)
- Split event filter mask fix into a separate patch ("KVM: x86/pmu: Mask
  only OS/USR bits when filtering fixed counters").
v9: new patch.
---
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/kvm/vmx/pmu_intel.c     | 26 ++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c           |  3 ++-
 3 files changed, 29 insertions(+), 1 deletion(-)

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
index da6dae261514..0861c65bee95 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -86,6 +86,12 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 	}
 }
 
+static bool intel_pmu_metrics_clear_enabled(struct kvm_pmu *pmu)
+{
+	return fixed_ctrl_field(pmu->fixed_ctr_ctrl, KVM_FIXED_SLOTS_IDX) &
+	       INTEL_FIXED_3_METRICS_CLEAR;
+}
+
 static int intel_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx,
 			       u64 *data)
 {
@@ -140,6 +146,20 @@ static int intel_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx,
 			return 1;
 
 		*data = pmu->perf_metrics;
+
+		/*
+		 * Per the SDM, RDPMC of PERF_METRICS clears both PERF_METRICS
+		 * and the SLOTS fixed counter when Metrics Clear Mode is
+		 * enabled via INTEL_FIXED_3_METRICS_CLEAR in FIXED_CTR_CTRL.
+		 */
+		if (intel_pmu_metrics_clear_enabled(pmu)) {
+			pmc = kvm_pmc_idx_to_pmc(pmu, INTEL_PMC_IDX_FIXED_SLOTS);
+
+			pmu->perf_metrics = 0;
+			if (pmc)
+				pmc_write_counter(pmc, 0);
+		}
+
 		return 0;
 	default:
 		return 1;
@@ -552,6 +572,12 @@ static void intel_pmu_refresh_perf_metrics(struct kvm_vcpu *vcpu)
 			~GENMASK_ULL(kvm_pmu_cap.num_topdown_events *
 				     INTEL_TD_METRIC_FIELD_BITS - 1, 0);
 	}
+
+	if (kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_RDPMC_METRICS_CLEAR) {
+		pmu->fixed_ctr_ctrl_rsvd &=
+			~intel_fixed_bits_by_idx(KVM_FIXED_SLOTS_IDX,
+						 INTEL_FIXED_3_METRICS_CLEAR);
+	}
 }
 
 static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7441808be049..d977fc3a31d8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7944,7 +7944,8 @@ static __init u64 vmx_get_perf_capabilities(void)
 	 */
 	if (enable_mediated_pmu && kvm_pmu_cap.num_topdown_events &&
 	    kvm_pmu_cap.num_counters_fixed > KVM_FIXED_SLOTS_IDX)
-		perf_cap |= kvm_pmu_cap.perf_capabilities & PERF_CAP_PERF_METRICS;
+		perf_cap |= kvm_pmu_cap.perf_capabilities &
+			    (PERF_CAP_PERF_METRICS | PERF_CAP_RDPMC_METRICS_CLEAR);
 
 	return perf_cap;
 }
-- 
2.56.1

