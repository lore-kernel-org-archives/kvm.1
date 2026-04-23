Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A129E314D34;
	Thu, 23 Apr 2026 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966899; cv=none; b=IwJsjKLJz119DZxJ3j9w/eBRRh4sSqOHG1In5sPn4djYL6vK3zvVHM/4B6qhD3XGFGwTXsgYxLmuttx6ADwpw9dK1EpAyldI+iYnbu/m/pzaIsmBUE8ZEoUb9pHq8ypjLVwC1DCqYeQySdM37z9laQAt4JUXwMEna9hAVXcR05U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966899; c=relaxed/simple;
	bh=aX5yFD6wXZyxrZ6ek1uOj3AtBiiMttmhZETDPmWuuyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FC807usIbYAr1bVWMZ1i7eHSRSerksbphkyHCi+RdsTglceFHeEHRfwAo6FXTTehp8bYpq9qNe9XIcekSfFSjyrUtfeSbU/rSqG8GT76gURYUZj5TyH5GfSmJTL1+DrbBizAPPHEJtC2D/0g5cnrF120CKpnBHE8dvIrykq1E0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EeuxnClF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EeuxnClF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776966898; x=1808502898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aX5yFD6wXZyxrZ6ek1uOj3AtBiiMttmhZETDPmWuuyo=;
  b=EeuxnClFmEBKPME7BwmwfbOK6VwTrVsdWPPoCgKiF30CeH2iPTNcsDjp
   4uCMHjazLBVdm5F70SLpfXZuYlITUi7cdGPUcRHRblebTc82ZpC7a8/9w
   F3XHrtDQbQG+uq89X/RY7DyGlOYPn91xMwjhS40oX7hbXKpqMrFtK4pO/
   gVZcmUXXy/5afva0ypLkbJ6cNP+DNA2b6VtxaVvfAcEutqcOGFohpiIyL
   tW47ThtW9N19XI4D9ch98AixsyRvYkEJRYZHPYGSlocpDIGY50D3fUhf1
   SphTii3Jghja0ftNJfUd510k1WbK7yPtfS0f9MpE8zLKBXeXbJR/7/kPq
   Q==;
X-CSE-ConnectionGUID: OpJrzv/ZT5imM4KFI74iIg==
X-CSE-MsgGUID: exFqq0eHSaqTxklulaJ/ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89407714"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="89407714"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 10:54:57 -0700
X-CSE-ConnectionGUID: Hhnh88tGR0Km/02N03jahw==
X-CSE-MsgGUID: jIFpCArNSeO5KgPDyKWKfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="236707812"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 10:54:57 -0700
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
Subject: [PATCH V2 1/4] KVM: x86/pmu: Do not map fixed counters >= 3 to generic perf events
Date: Thu, 23 Apr 2026 10:46:36 -0700
Message-ID: <20260423174639.56149-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260423174639.56149-1-zide.chen@intel.com>
References: <20260423174639.56149-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only fixed counters 0..2 have matching generic cross-platform
hardware perf events (INSTRUCTIONS, CPU_CYCLES, REF_CPU_CYCLES).
Therefore, perf_get_hw_event_config() is only applicable to these
counters.

KVM does not intend to emulate fixed counters >= 3 on legacy
(non-mediated) vPMU, while for mediated vPMU, KVM does not care what
the fixed counter event mappings are.  Therefore, return 0 for their
eventsel.

Also remove __always_inline as BUILD_BUG_ON() is no longer needed.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- Replace 3 in "if (index < 3)" with ARRAY_SIZE(fixed_pmc_perf_ids).
---
 arch/x86/kvm/vmx/pmu_intel.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 27eb76e6b6a0..05a59f4acfdd 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -454,28 +454,30 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
  * different perf_event is already utilizing the requested counter, but the end
  * result is the same (ignoring the fact that using a general purpose counter
  * will likely exacerbate counter contention).
- *
- * Forcibly inlined to allow asserting on @index at build time, and there should
- * never be more than one user.
  */
-static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
+static u64 intel_get_fixed_pmc_eventsel(unsigned int index)
 {
 	const enum perf_hw_id fixed_pmc_perf_ids[] = {
 		[0] = PERF_COUNT_HW_INSTRUCTIONS,
 		[1] = PERF_COUNT_HW_CPU_CYCLES,
 		[2] = PERF_COUNT_HW_REF_CPU_CYCLES,
 	};
-	u64 eventsel;
-
-	BUILD_BUG_ON(ARRAY_SIZE(fixed_pmc_perf_ids) != KVM_MAX_NR_INTEL_FIXED_COUNTERS);
-	BUILD_BUG_ON(index >= KVM_MAX_NR_INTEL_FIXED_COUNTERS);
+	u64 eventsel = 0;
 
 	/*
-	 * Yell if perf reports support for a fixed counter but perf doesn't
-	 * have a known encoding for the associated general purpose event.
+	 * Fixed counters 3 and above don't have corresponding generic hardware
+	 * perf event, and KVM does not intend to emulate them on non-mediated
+	 * vPMU.
 	 */
-	eventsel = perf_get_hw_event_config(fixed_pmc_perf_ids[index]);
-	WARN_ON_ONCE(!eventsel && index < kvm_pmu_cap.num_counters_fixed);
+	if (index < ARRAY_SIZE(fixed_pmc_perf_ids)) {
+		/*
+		 * Yell if perf reports support for a fixed counter but perf
+		 * doesn't have a known encoding for the associated general
+		 * purpose event.
+		 */
+		eventsel = perf_get_hw_event_config(fixed_pmc_perf_ids[index]);
+		WARN_ON_ONCE(!eventsel && index < kvm_pmu_cap.num_counters_fixed);
+	}
 	return eventsel;
 }
 
-- 
2.53.0

