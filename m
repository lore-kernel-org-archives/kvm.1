Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB63EAC80;
	Thu, 27 Aug 2026 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870899; cv=none; b=OXB3dzcIb9lD8EeRoGBoaTDz0NLD1NVn2wwfd7h4wTfGtKQ54+Oj3BdHzpH+vQx4gbDuOEw6MlYNfY1sxlU34spGvuHUrwXOwjTlR2kj3dpFb3LnRwGhIZetBwQ1zHEYCNF4n+YB4M/cVnr+OXJ1hjPXzgVpUdgqd5caEsbFb5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870899; c=relaxed/simple;
	bh=FOsX3pX2MXJLLF7H8uho8wtGjS25dhmTpou+N0Gjf68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4bi9XEyoqJkZdRJ14E5Isq9Y8dXZZZwlb/sm/qRYVbRbJHPvW64hIKpO4hYITNwebkbx0Mkf+cHPHOH0fZFdzyHqfnMnRsG/PmzASRR6XenYNYlttMvlIC8fJ96nyy45sb9OqLVrDnQF1XY9mOWx5UOrXyyEjBQLi2a+HLzWzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nAizpLpC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nAizpLpC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787870897; x=1819406897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FOsX3pX2MXJLLF7H8uho8wtGjS25dhmTpou+N0Gjf68=;
  b=nAizpLpCZqu9zj68Bha1HVOeD6gcwyHidquB4eaMBy8cdhR3Hs4nmkLc
   bISjxfcb00ZeotOzu2g/ezi2baH5ZovIMYPKDTOBuq8XLq1GE77sBu6L3
   b8lJDAdkp5fENGTX/WbgMtFmOwZ5ZG82DKVJ++IOyRPU5AX6BskkHQLb9
   uVXc9NtFA+5eWpGgr5agCfXRqUfBKyCSV4+1f8Jn4iHrfzDrtT0dA1NNn
   mjCVdfj+2cOMHODBw16KpjVcRQVsdqJIywSmN5/A0rXuwLz3mwrMuPTEZ
   c/mrT51+HF6dxDJtplqpoc85CYrQ98t97wEKFM96pvDdrwm7rSyhLd6X3
   w==;
X-CSE-ConnectionGUID: DhxMpqvqTiizOVmOUjxjmg==
X-CSE-MsgGUID: z3PP0K6wRlG/hwjmEAu/pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113914896"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="113914896"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:10 -0700
X-CSE-ConnectionGUID: n/I09j/GSMutKoxxtdSU6w==
X-CSE-MsgGUID: FhrAVx0rQ9mTepPfA6qmrg==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:09 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Jim Mattson <jmattson@google.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v2 14/16] KVM: x86/pmu: Ignore AnyThread bit if CPUID.0AH:EDX[15] is set
Date: Thu, 27 Aug 2026 15:37:53 -0700
Message-ID: <20260827223755.143247-15-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827223755.143247-1-zide.chen@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel PerfMon v5 introduces the ANYTHREAD_DEPRECATION capability
(CPUID.0AH:EDX[15]) to indicate that AnyThread counting is deprecated
and that writes to the AnyThread bit in IA32_PERFEVTSELx are ignored.

When ANYTHREAD_DEPRECATION is present in the guest CPUID, emulate the
architectural behavior and silently ignore writes to the AnyThread bit
instead of injecting #GP.

Continue to inject #GP when ANYTHREAD_DEPRECATION is not present in the
guest CPUID, e.g. for PerfMon v3/v4 guests or when the capability is
not configured for a PerfMon v5+ guest.

Advertise CPUID.0AH:EDX[15] only for PMU version 5+ guests, since the
bit doesn't exist below version 5.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v2:
- Advertise anythread_deprecated only if kvm_pmu_cap.version >= 5.
- Add the missing AnyThr bit handling for IA32_FIXED_CTR_CTRL.
- Update the comments to be clearer.
---
 arch/x86/kvm/cpuid.c         |  2 +-
 arch/x86/kvm/vmx/pmu_intel.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 63201d4ea4a1..ef208906b3ee 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1542,7 +1542,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 					    KVM_MAX_NR_FIXED_COUNTERS);
 		edx.split.bit_width_fixed = kvm_pmu_cap.bit_width_fixed;
 
-		if (kvm_pmu_cap.version)
+		if (kvm_pmu_cap.version >= 5)
 			edx.split.anythread_deprecated = 1;
 
 		entry->eax = eax.full;
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index c7472778137a..599c69dfa6e3 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -446,6 +446,12 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (data & pmu->fixed_ctr_ctrl_rsvd)
 			return 1;
 
+		/*
+		 * This is to emulate ANYTHREAD_DEPRECATION. Guests without
+		 * support for it would have had the write rejected by
+		 * pmu->fixed_ctr_ctrl_rsvd above.
+		 */
+		data &= ~intel_pmu_fixed_ctrl_bits(pmu, INTEL_FIXED_0_ANYTHREAD);
 		if (pmu->fixed_ctr_ctrl != data)
 			reprogram_fixed_counters(pmu, data);
 		break;
@@ -494,6 +500,8 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			if (data & eventsel_rsvd)
 				return 1;
 
+			/* See above comments for MSR_CORE_PERF_FIXED_CTR_CTRL. */
+			data &= ~ARCH_PERFMON_EVENTSEL_ANY;
 			if (data != pmc->eventsel) {
 				pmc->eventsel = data;
 				pmc->eventsel_hw = data;
@@ -603,6 +611,17 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
 			    kvm_pmu_cap.cntr_mask64;
 
+	/*
+	 * AnyThread counting is not supported by KVM due to cross-VM
+	 * information leakage concerns on SMT cores. Therefore, AnyThread
+	 * remains unavailable for PerfMon v3/v4 guests, where AnyThread
+	 * deprecation is not enumerated.
+	 */
+	if (pmu->version >= 5 && edx.split.anythread_deprecated) {
+		pmu->eventsel_rsvd &= ~ARCH_PERFMON_EVENTSEL_ANY;
+		fixed_enable_bits |= INTEL_FIXED_0_ANYTHREAD;
+	}
+
 	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
 	if (entry &&
 	    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) &&
-- 
2.55.0

