Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516233;
	b=bU4zUJHQsSVacSqFXLZMgWpTs1vsFVkpM9r2H1vWvuv9hD2VTmlWseV+8Wpkim0iCgUR
	 Mc7JIxJv5aGN5uE74jxKZ81LWLj9aUAAERXx8Z/LQ7QlcmejMVyoKqhN69QHBs/TDJJeL
	 CK2hptRkaBPslyn/FusT3JMybglk7KncQo+ZI9A1hlGHLk9qG+V6pTRe0HxdpRRniNdvs
	 Nj1cO5/JbP4GKP6yDlO42gzuXPxQgsWMg6ic9NGVV3AOPPwHPKgvL+BfMZrvMOUOj2vLH
	 ATruD4mkZKPV7nCsu9NyiVPkMafJanwkiKuNF16ENAl0dVVM/4yTXN/6pZDC1/Te7Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516233;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bgKzjDi+5CPm1tldHPQ1NupbfMGQHOskxIf27/MLNM0=;
	b=2ONfndD8oTV40yJ+hrZMOzWeCghSESSq9kfrGx01T0JvEsloaxoo0VyYDpupq9aADyFz
	 /5lhN8AU7/wKYivvhm2J2uodSFFheTZI4XcOJjFbGEm+eFooaRCjnm7PSEh/5xxQLAjut
	 tF80ZAaBp3YAuX2J1/MIte2OSnPg/f8GKaZxQpgJIsMxhmbwIfEYBfhYuIgK64o3O396D
	 eaZdw7s2z9CWc6uPlVOBdweS/kj+myyLhsJCdSWZsIuQMveGcnhFxDks+n7wKfzMShXVj
	 zsNLcTk8uCE7WpB0YI6TdjN2ofY38xPm/CiX9xxl8OWfFlCDPmJCMofg/ImGie5K5QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=djRMtvLk;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AB860A6F7D;
	Thu, 12 Nov 2026 20:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0AB860A6F7D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=djRMtvLk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516233; x=1826052233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LQ64gzUWOGYmY2oBsp7HEa6G6UTIDiVT87kszCRiI8M=;
  b=djRMtvLkojnlhCccuPb09g1ucim80qaL/qsOKfP4Z+MWuq33kySqEbC6
   appDAQ0Uwviv7/EHrCSlzV5vE2I5G+d7L7VtXYBLswyj2ia0kSuwtKGJl
   6i7YoCUwHjBPi4RtNLeDSyLMYP/Rpt57ni7enX464tx7VW6eBbqf3d7vc
   bkGScckxsf/bl2ey3ckXH07aFe7TlohkyIgQI2pD6oG0RvZzv3X+WB7On
   MkDb31RsI1w8AjrURkqCxAAylzzGeUguFsW1IsAehsYfzV8hGgA0bX5uo
   kZaQuCItNfaHDiqt4tnLMYd05nlxDp8MjKi7RASm/d8E3qcEmYlexx8VC
   g==;
X-CSE-ConnectionGUID: YVAYYwEYTuulHNUaxf0t1Q==
X-CSE-MsgGUID: AmX+avs+SemmIv6+v+276Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192326"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192326"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:52 -0800
X-CSE-ConnectionGUID: DYxzUYneTg+t4kKGkk8HPg==
X-CSE-MsgGUID: AlVU8ZTqTcSNiG6pETwh9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087942"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:52 -0800
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
Subject: [PATCH v4 19/21] KVM: x86/pmu: Ignore AnyThread bit if CPUID.0AH:EDX[15] is set
Date: Thu, 12 Nov 2026 13:32:25 -0700
Message-ID: <20261112203227.289379-20-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261112203227.289379-1-zide.chen@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
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
Reviewed-by: Jim Mattson <jmattson@google.com>
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
---
 arch/x86/kvm/cpuid.c         |  2 +-
 arch/x86/kvm/vmx/pmu_intel.c | 28 +++++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 2a4530d000fc..36540e121807 100644
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
index 65b6f274a8f6..4824e7eb98d3 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -66,6 +66,13 @@ static u64 intel_pmu_fixed_ctrl_bits(struct kvm_pmu *pmu, u64 bits)
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
@@ -81,9 +88,9 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 	int i;
 
 	pmu->fixed_ctr_ctrl = data;
-	pmu->fixed_ctr_ctrl_hw = data;
+	pmu->fixed_ctr_ctrl_hw = data & ~intel_pmu_fixed_anythread_mask(pmu);
 	kvm_for_each_fixed_counter(i, pmu) {
-		u8 new_ctrl = fixed_ctrl_field(data, i);
+		u8 new_ctrl = fixed_ctrl_field(pmu->fixed_ctr_ctrl_hw, i);
 		u8 old_ctrl = fixed_ctrl_field(old_fixed_ctr_ctrl, i);
 
 		if (old_ctrl == new_ctrl)
@@ -496,7 +503,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 			if (data != pmc->eventsel) {
 				pmc->eventsel = data;
-				pmc->eventsel_hw = data;
+				pmc->eventsel_hw = data & ~ARCH_PERFMON_EVENTSEL_ANY;
 				kvm_pmu_request_counter_reprogram(pmc);
 			}
 			break;
@@ -662,6 +669,21 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 
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
2.56.1

