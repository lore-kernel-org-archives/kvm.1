Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929841;
	b=KDHxRga8N+M5vkgbNh3dtgMvwvZw7VV+SYx+tcY2+6JLlgGAnWwcGmf4P0F7Swj6XbJA
	 yc1SnEWD4KL9Seg+/AoBmddSKC/+bOJnaopSTB6HO39a5/XakF/YThZmngdiOl20Nx3vy
	 +uhDTjp/eFByAu7snpw/OKsRM1iPowuTzSoajgDNNvz4biRxHs5pVMB3OgU0M0AbnbyZq
	 Dg/vKoMvCWkO6HCOLF315rISQiY03M7x6o2kt3I6KGblbKS4hsZoxAeyihSlLQGY0BAGK
	 E+fZXu/4em1dCTSFwths/YYnpNp5V8MzNDxUE+oy/Vs6eFDb3mebyajfCPQyxy0UVSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929841;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k6GpxUSOBkepNG/7AUTAINEEEyPxCb8lZe4Y7y9q6EU=;
	b=t/KBb9AeuZEZ7Ynm0tOl2w8A8+hkDVCNjYsU9mynMeIiiUgzO6NMoJIwxE08ZhVyXd6/
	 GnvYPtMBpRFXMAbW1lasD+ux4uc5+IXnA1i1zo1qbAhzwgpVXzPWp912qOBlYUyrwoWC3
	 4CY7CP92tDDeWwxhshzMr44ogXbMEOtfTJG/RAozQ+OxpF3Z5DWmH5AXq5sS9Z+EI/6HM
	 EiinIkqunziYcfgiNunCcZq9R4XWmWTfECu2zQ9GSTJLgA2RdCK67mLsy9tKPWzmzDz+d
	 JZG4x0o+mPB1RbzxfHhkcFg4KP2ddhNVHNgiGo4Z6sPnPQgVyTgMEV9+GXiRfVYlq2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GTZlI7mm;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A59606D82D;
	Fri,  6 Nov 2026 01:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52A59606D82D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GTZlI7mm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793929840; x=1825465840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FKf79K3Z0P/wrLSbHeO46/+gfErlRjAZZxxoEJusUp4=;
  b=GTZlI7mmP5m2+5SNc2JqJn2cRvSrDvr09AjZjQkEET4UkcWlbyZDkYOj
   GjaG+OWG/rMRAx14ghhCVJmsuzA0UKiMia3EkUjj6XbB3kqHyKo37ETJE
   kluebL1QexQtqn3BRi7tig7gYTrCVrKaPZv70lnrU8qPxWHQg67BXqK41
   S9gUHc4Wwo9DEil5fRm3VbpCLLl5xq47Ztr/Le7jNk1zA0Ce0YekfrK1o
   juMLcqsp8oQUa2jrK/nimI3WO9VJc6gfel1HbCogIoh8+y9s5nerYRsgf
   KDYVN2Uw84fnstrR8pH5Xidvi1sPCXdTBH7SlFIG8Vv9g7q/y4fjG3jhK
   Q==;
X-CSE-ConnectionGUID: 8c0ufQsRSEqMMhMddmls7g==
X-CSE-MsgGUID: 9CjnALGDRGCEX84lekLS+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740205"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2740205"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:32 -0800
X-CSE-ConnectionGUID: qpMbqxXLR7eZbw5p2M6eBw==
X-CSE-MsgGUID: DLIF0L22QDa161UoGmulow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067211"
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
Subject: [PATCH v3 16/18] KVM: x86/pmu: Ignore AnyThread bit if CPUID.0AH:EDX[15] is set
Date: Thu,  5 Nov 2026 18:39:25 -0700
Message-ID: <20261106013927.166209-17-zide.chen@intel.com>
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

Intel PerfMon v5 introduces the ANYTHREAD_DEPRECATION capability
(CPUID.0AH:EDX[15]) to indicate that AnyThread counting is deprecated
and that writes to the AnyThread bit in IA32_PERFEVTSELx and
IA32_FIXED_CTR_CTRL are ignored.

Preserve the guest-written value in guest-visible state so that guest
RDMSRs observe the AnyThread bit, but strip it before programming
hardware to ensure cross-VM SMT isolation.

Continue to inject #GP when ANYTHREAD_DEPRECATION is not present in the
guest CPUID, e.g. for PerfMon v3/v4 guests or when the capability is
not configured for a PerfMon v5+ guest.

Advertise CPUID.0AH:EDX[15] only for PMU version 5+ guests, since the
bit doesn't exist below version 5.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3:
- Exclude Fixed Counter 3 bit 14 (METRICS_CLEAR_EN) from the AnyThread mask
  so it remains reserved in fixed_ctr_ctrl_rsvd. (Jim)
- Preserve AnyThread in guest-visible state (eventsel/fixed_ctr_ctrl) to
  match bare-metal RDMSR behavior. (Jim)
- Removed it from the hardware-visible counterparts (_hw) so that it
  doesn't need to explicitly remove this bit in intel_pmu_set_msr().
  (Jim)
- Re-use intel_pmu_fixed_ctrl_bits() for AnyThread bits computation.
  (Sashiko)

v2:
- Advertise anythread_deprecated only if kvm_pmu_cap.version >= 5.
- Add the missing AnyThr bit handling for IA32_FIXED_CTR_CTRL.
- Update the comments to be clearer.
---
 arch/x86/kvm/cpuid.c         |  2 +-
 arch/x86/kvm/vmx/pmu_intel.c | 28 +++++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 00a2ca6d3049..66e68a867946 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1549,7 +1549,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 					    KVM_MAX_NR_FIXED_COUNTERS);
 		edx.split.bit_width_fixed = kvm_pmu_cap.bit_width_fixed;
 
-		if (kvm_pmu_cap.version)
+		if (kvm_pmu_cap.version >= 5)
 			edx.split.anythread_deprecated = 1;
 
 		entry->eax = eax.full;
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 6bd7c8e03c14..961d16e7f31f 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -67,6 +67,13 @@ static u64 intel_pmu_fixed_ctrl_bits(struct kvm_pmu *pmu, u64 bits)
 	return fixed_ctrl_bits;
 }
 
+static u64 intel_pmu_fixed_anythread_mask(struct kvm_pmu *pmu)
+{
+	/* Fixed counter 3 repurposes that bit for METRICS_CLEAR_EN. */
+	return intel_pmu_fixed_ctrl_bits(pmu, INTEL_FIXED_0_ANYTHREAD) &
+	       ~intel_fixed_bits_by_idx(3, INTEL_FIXED_3_METRICS_CLEAR);
+}
+
 static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 {
 	/*
@@ -83,9 +90,9 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 	int i;
 
 	pmu->fixed_ctr_ctrl = data;
-	pmu->fixed_ctr_ctrl_hw = data;
+	pmu->fixed_ctr_ctrl_hw = data & ~intel_pmu_fixed_anythread_mask(pmu);
 	kvm_for_each_fixed_counter(i, fixed_mask) {
-		u8 new_ctrl = fixed_ctrl_field(data, i);
+		u8 new_ctrl = fixed_ctrl_field(pmu->fixed_ctr_ctrl_hw, i);
 		u8 old_ctrl = fixed_ctrl_field(old_fixed_ctr_ctrl, i);
 
 		if (old_ctrl == new_ctrl)
@@ -500,7 +507,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 			if (data != pmc->eventsel) {
 				pmc->eventsel = data;
-				pmc->eventsel_hw = data;
+				pmc->eventsel_hw = data & ~ARCH_PERFMON_EVENTSEL_ANY;
 				kvm_pmu_request_counter_reprogram(pmc);
 			}
 			break;
@@ -672,6 +679,21 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 
 	pmu->fixed_ctr_ctrl_rsvd &=
 		~intel_pmu_fixed_ctrl_bits(pmu, fixed_enable_bits);
+
+	/*
+	 * AnyThread counting is not supported by KVM due to cross-VM
+	 * information leakage concerns on SMT cores. Therefore, AnyThread
+	 * remains unavailable for PerfMon v3/v4 guests, where AnyThread
+	 * deprecation is not enumerated.
+	 *
+	 * On PerfMon v5+ with ANYTHREAD_DEPRECATION, writes to AnyThread bits
+	 * are accepted and preserved on RDMSR, while counting behavior is
+	 * ignored.
+	 */
+	if (pmu->version >= 5 && edx.split.anythread_deprecated) {
+		pmu->eventsel_rsvd &= ~ARCH_PERFMON_EVENTSEL_ANY;
+		pmu->fixed_ctr_ctrl_rsvd &= ~intel_pmu_fixed_anythread_mask(pmu);
+	}
 }
 
 static void intel_pmu_init(struct kvm_vcpu *vcpu)
-- 
2.56.0

