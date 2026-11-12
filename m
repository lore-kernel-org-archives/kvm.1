Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516228;
	b=CXafSTbldjV6wX+AK55DqWr3GIT80WavIiCUKouQ3fVE3UB/t/LT0666zUYGf9rUGFMy
	 s7J9a1RI7k/Ofps/ddvFIJwSloTU6k52smolEYFkClZNpMbXKNj8q7aqwwbX5+yrblhNN
	 Fs4P+AZVd4T/gYvl1EGTnog0oCafZxqfhpZ1apwjQ7ymnKp4/J5I0/OfbiXcsMBEutbm+
	 Tn7dkZ0v2XIHbhqyQe2Ej8gbIrG8rFqzxjtlcCngkg4tjbJkC1eqmT+4bdDKD4WFpD4xp
	 a6tHeRUyEytug3i3hm/MNstyoRKnjsoQAcMDkufe2gqXqSkqBkHWaS3Suyp2QdP3bDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516228;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Imp/TT7xPboMa7wUI1aoKpqLSTJlfBXzPpRAI9Z9hPY=;
	b=yLIdExRQ95S/UZdzEiflum0LyykXqIFOBTIhAFF2WQ2qd9fqhBaBe7hcKTVkUG90pPrW
	 0Ld/PpeujIe6L1lk4EGxZgjGCB4NuAQBEXPosPemO6soGNp6Z/4g/4RPlyWiU9xhCrdGI
	 2slNcMarAQnzUkPYVpZ97cdc7wEmK6AX/WwcYzZCR3h/yX71EbolZK06NfR13I8aiy6Yb
	 EeFZfHPrR+o6gPaY4HCul+pBTPePEziOOKOzZLDuc1UVmS5YTYpdeHuLDXvwnd1K4c0rD
	 9x28+P8NtC4ytf87MiIlnBqtkPa6YLah2dzkPQRlq3HJx0ZyUUNI1JXdja4YHDpXoDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hIGWC1kX;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27726606A33A;
	Thu, 12 Nov 2026 20:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27726606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hIGWC1kX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516228; x=1826052228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LrUVwug2B3YORXOcBQ3+5IOdL21MNmkepQn1+87+mnI=;
  b=hIGWC1kXBRSrdN1bJsgn7vloKNgxvtd9FJl3+0XBwIsivCjX+Ugyxec7
   On5TpOAO88vQsLBy6oQCz1ok9VLPoPOJ6bBLdDPBKnOdEoRLnm0V23F0/
   tyy06yKBIUkuDr4qRh3BkuKau+t87rm4/zN5r7fUPFSPJu1AK98fC+9js
   orzWRBqzfNR8TOmlPYisDFHhHbFNRUSkqixwpJWh2lZvv8arCDd9DMSCK
   l1EDRIY9NSjfTU1fr+cjjXxtdbDZhKywAWF4hVEelFV+5AoTBayXeLYT2
   Y0Laby8fk9CwUTkmPimD5oZsRKJzPxzzmXiBv8Ai4cpoHiat1nkNMS4mI
   A==;
X-CSE-ConnectionGUID: +fIOjq7RTz2INHOJk03TxQ==
X-CSE-MsgGUID: vM62rJQAReSNH9/mjm2Yzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192231"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192231"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:47 -0800
X-CSE-ConnectionGUID: VgwhTOIFTHCIuWsIsJrfMw==
X-CSE-MsgGUID: t83r2eP7T5mIYqvZy9A4qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087875"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:47 -0800
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
Subject: [PATCH v4 04/21] KVM: x86/pmu: Rename reserved_bits to eventsel_rsvd in kvm_pmu
Date: Thu, 12 Nov 2026 13:32:10 -0700
Message-ID: <20261112203227.289379-5-zide.chen@intel.com>
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

This field stores the bits that are reserved in guest IA32_PERFEVTSELx
MSRs. Rename it to eventsel_rsvd to better reflect its purpose and to
align with other field names in struct kvm_pmu.

Opportunistically, replace magic numbers with macros.

No functional change intended.

Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
---
v4:
- Diff AMD eventsel_rsvd against generic baseline instead of overwriting
  from scratch. (Yosry)
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/pmu.c              |  6 +++++-
 arch/x86/kvm/svm/pmu.c          | 11 ++++++++---
 arch/x86/kvm/vmx/pmu_intel.c    | 12 ++++++------
 4 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 72b8fbf432a2..b8875ed5502c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -581,7 +581,7 @@ struct kvm_pmu {
 	u64 counter_bitmask[2];
 	u64 global_ctrl_rsvd;
 	u64 global_status_rsvd;
-	u64 reserved_bits;
+	u64 eventsel_rsvd;
 	u64 raw_event_mask;
 	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
 	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 83883191d124..cbd63329cf13 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -983,7 +983,11 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->nr_arch_fixed_counters = 0;
 	pmu->counter_bitmask[KVM_PMC_GP] = 0;
 	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
-	pmu->reserved_bits = 0xffffffff00200000ull;
+	/*
+	 * KVM is not able to emulate the AnyThread bit due to cross-VM
+	 * information leakage on SMT cores.
+	 */
+	pmu->eventsel_rsvd = GENMASK_ULL(63, 32) | ARCH_PERFMON_EVENTSEL_ANY;
 	pmu->raw_event_mask = X86_RAW_EVENT_MASK;
 	pmu->global_ctrl_rsvd = ~0ull;
 	pmu->global_status_rsvd = ~0ull;
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index bf2f23c30afc..c1e401fabbde 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -156,7 +156,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	/* MSR_EVNTSELn */
 	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_EVNTSEL);
 	if (pmc) {
-		data &= ~pmu->reserved_bits;
+		data &= ~pmu->eventsel_rsvd;
 		if (data != pmc->eventsel) {
 			pmc->eventsel = data;
 			pmc->eventsel_hw = (data & ~AMD64_EVENTSEL_HOSTONLY) |
@@ -207,9 +207,14 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 
 	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;
 
-	pmu->reserved_bits = 0xfffffff000280000ull;
+	/*
+	 * AMD PerfEvtSeln registers do not support PinControl, but support
+	 * a 12-bit EventSelect (bits 35:32 in addition to 7:0).
+	 */
+	pmu->eventsel_rsvd |= ARCH_PERFMON_EVENTSEL_PIN_CONTROL;
+	pmu->eventsel_rsvd &= ~AMD64_EVENTSEL_EVENT;
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SVM) && kvm_vcpu_has_mediated_pmu(vcpu))
-		pmu->reserved_bits &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;
+		pmu->eventsel_rsvd &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;
 
 	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
 	/* not applicable to AMD; but clean them to prevent any fall out */
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index ee18899614a1..fadc466cd600 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -388,7 +388,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	struct kvm_pmc *pmc;
 	u32 msr = msr_info->index;
 	u64 data = msr_info->data;
-	u64 reserved_bits, diff;
+	u64 eventsel_rsvd, diff;
 
 	switch (msr) {
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
@@ -436,11 +436,11 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			pmc_write_counter(pmc, data);
 			break;
 		} else if ((pmc = get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0))) {
-			reserved_bits = pmu->reserved_bits;
+			eventsel_rsvd = pmu->eventsel_rsvd;
 			if ((pmc->idx == 2) &&
 			    (pmu->raw_event_mask & HSW_IN_TX_CHECKPOINTED))
-				reserved_bits ^= HSW_IN_TX_CHECKPOINTED;
-			if (data & reserved_bits)
+				eventsel_rsvd ^= HSW_IN_TX_CHECKPOINTED;
+			if (data & eventsel_rsvd)
 				return 1;
 
 			if (data != pmc->eventsel) {
@@ -548,7 +548,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	if (entry &&
 	    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) &&
 	    (entry->ebx & (X86_FEATURE_HLE|X86_FEATURE_RTM))) {
-		pmu->reserved_bits ^= HSW_IN_TX;
+		pmu->eventsel_rsvd ^= HSW_IN_TX;
 		pmu->raw_event_mask |= (HSW_IN_TX|HSW_IN_TX_CHECKPOINTED);
 	}
 
@@ -587,7 +587,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	if (perf_capabilities & PERF_CAP_PEBS_FORMAT) {
 		if (perf_capabilities & PERF_CAP_PEBS_BASELINE) {
 			pmu->pebs_enable_rsvd = counter_rsvd;
-			pmu->reserved_bits &= ~ICL_EVENTSEL_ADAPTIVE;
+			pmu->eventsel_rsvd &= ~ICL_EVENTSEL_ADAPTIVE;
 			pmu->pebs_data_cfg_rsvd = ~0xff00000full;
 			intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_0_ADAPTIVE);
 		} else {
-- 
2.56.1

