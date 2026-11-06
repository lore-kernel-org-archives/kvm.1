Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929840;
	b=XZDRP2rajVn5tZoxOCNBawV10vUvq+JfTY8CeLQ77ZDC8tHGNnZNOTebSoy5pne/77x9
	 1oqyUBseSUHnWhRxu0B4zWp55LSCBmreq2QhHePHWYLARevS1zupMxuIQp46x732pnSJ3
	 i717qL842uMljw422akTk34Zeqj9QniRdPcLiQU4kcseQ8nLNLeiScBVmwhlQm4sbUPd8
	 y2VLn5JHmqFu1s6kvSuBMu7qCz1P7m20yUhGpWyELt+CkTw6o8+fiGPUJVh45iDkHp3CA
	 8lUEzurJaBVvdpDrHp+C/mErRsNkkZEZ+a/MrSkJ5xDxKUpHp3u/gBsMxCNyMOz90xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929840;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9TYqOXsew+Y+Q8c5CLe4mxAcwiCP6VtG9pQKJdgk8aI=;
	b=gPFGi57Bwiog9Z7yDq3pDDFGGE8v6ukErhKeNL6JAaT4qMKg/UBZpWh1qAIvbx5pwn1P
	 eilQyXfHpXATZTkSJeBLgmd2tuMzTXrciJfeJSZotI+4BAhuYGVyD5I4nyHIi6Czd0UO8
	 muV0eiRFRdk2wbYgLycN1KSlaAad+nKoeSZYrR4u2jbsLHxn9rr4AwsT3cARpfkumuu4L
	 Nyv3xX2V63UltNU8fBFlXWKOx1zaM3ASF0XxvBuraaXRkr3XiI/JyGRat9pATyTVUE//F
	 AC4wciWteoKiDZtwXgg13PMNLoehzHQjglqgj4VzXWyJyEnKYkBj/sVditCgrlIP1Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kPkdoKO5;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF832606D826;
	Fri,  6 Nov 2026 01:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF832606D826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kPkdoKO5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793929838; x=1825465838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QLNPLyxjRgFiTSVWFbWIdFOomaI9/H6t0hb0/RgMl4E=;
  b=kPkdoKO53MoBtE8de6c9WNANadOUij7Plipsr01N1IbfRnX1n8+mXJwO
   +2xQD6udJ0FctsqC+SY1NxAXq1xRthZoBORo6EFUEF34sj75maX0mIYqE
   YpcWW3WdlL8uB0S0RDxuF7xqQx6opY1xsHwFxA3xh6bE2n5wlnjiV8RK2
   CKeTqnIqJ2sgXRKV71w8+dWz5OxoSbqb5dWmMno1T6s2oUSLKgIOCdnRF
   WMcuCAO6fa3DoNnCQGbT34ZAFfqHruk9SfXy0NSmThO9oGGSj+y+R8DiO
   iSKMPVGttSANt5Ux2Qk1oLKzqKGtAOsiEP43frsTGjKeVLoz/e+HwB5Wf
   Q==;
X-CSE-ConnectionGUID: Kn1x2BGJRIy5nGQHy1yw4w==
X-CSE-MsgGUID: scmoRnFJQzq8HId8kfLwCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740195"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2740195"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:32 -0800
X-CSE-ConnectionGUID: wdfob0K8Skq4iL/v4d871g==
X-CSE-MsgGUID: wyx1utJ/QziQoE/F33shCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067206"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:31 -0800
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
Subject: [PATCH v3 14/18] KVM: x86/pmu: Factor out fixed counter control bit calculation
Date: Thu,  5 Nov 2026 18:39:23 -0700
Message-ID: <20261106013927.166209-15-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106013927.166209-1-zide.chen@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
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

Rename intel_pmu_enable_fixed_counter_bits() to
intel_pmu_fixed_ctrl_bits() and have it return the computed fixed
counter control mask instead of updating fixed_ctr_ctrl_rsvd directly.

Accumulate the desired fixed counter control bits during PMU setup and
apply them once in intel_pmu_refresh().

Move the helper earlier in the file so it can also be reused for
upcoming ANYTHREAD_DEPRECATION emulation.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
v2:
- New patch.
---
 arch/x86/kvm/vmx/pmu_intel.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 37b34b588601..6bd7c8e03c14 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -55,6 +55,18 @@ static struct x86_pmu_lbr *vcpu_to_lbr_records(struct kvm_vcpu *vcpu)
 
 #pragma GCC poison to_vmx
 
+static u64 intel_pmu_fixed_ctrl_bits(struct kvm_pmu *pmu, u64 bits)
+{
+	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
+	u64 fixed_ctrl_bits = 0;
+	int i;
+
+	kvm_for_each_fixed_counter(i, fixed_mask)
+		fixed_ctrl_bits |= intel_fixed_bits_by_idx(i, bits);
+
+	return fixed_ctrl_bits;
+}
+
 static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 {
 	/*
@@ -537,20 +549,12 @@ static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
 	return eventsel;
 }
 
-static void intel_pmu_enable_fixed_counter_bits(struct kvm_pmu *pmu, u64 bits)
-{
-	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
-	int i;
-
-	kvm_for_each_fixed_counter(i, fixed_mask)
-		pmu->fixed_ctr_ctrl_rsvd &= ~intel_fixed_bits_by_idx(i, bits);
-}
-
 static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct lbr_desc *lbr_desc = vcpu_to_lbr_desc(vcpu);
 	struct kvm_cpuid_entry2 *entry;
+	u64 fixed_enable_bits = 0;
 	union cpuid10_eax eax;
 	union cpuid10_edx edx;
 	u64 perf_capabilities;
@@ -643,9 +647,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 					  kvm_pmu_cap.bit_width_fixed);
 	pmu->counter_bitmask[KVM_PMC_FIXED] = BIT_ULL(edx.split.bit_width_fixed) - 1;
 
-	intel_pmu_enable_fixed_counter_bits(pmu, INTEL_FIXED_0_KERNEL |
-						 INTEL_FIXED_0_USER |
-						 INTEL_FIXED_0_ENABLE_PMI);
+	fixed_enable_bits |= INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER |
+			     INTEL_FIXED_0_ENABLE_PMI;
 
 	counter_rsvd = ~((u64)kvm_gp_pmc_mask(pmu) |
 			 ((u64)kvm_fixed_pmc_mask(pmu) << KVM_FIXED_PMC_BASE_IDX));
@@ -661,11 +664,14 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 			pmu->pebs_enable_rsvd = counter_rsvd;
 			pmu->eventsel_rsvd &= ~ICL_EVENTSEL_ADAPTIVE;
 			pmu->pebs_data_cfg_rsvd = ~0xff00000full;
-			intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_0_ADAPTIVE);
+			fixed_enable_bits |= ICL_FIXED_0_ADAPTIVE;
 		} else {
 			pmu->pebs_enable_rsvd = ~(u64)kvm_gp_pmc_mask(pmu);
 		}
 	}
+
+	pmu->fixed_ctr_ctrl_rsvd &=
+		~intel_pmu_fixed_ctrl_bits(pmu, fixed_enable_bits);
 }
 
 static void intel_pmu_init(struct kvm_vcpu *vcpu)
-- 
2.56.0

