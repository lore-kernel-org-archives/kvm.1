Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A346D2CE;
	Mon, 17 Aug 2026 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992089; cv=none; b=FJg9dR2zvEhIgJWicj+TIPmVJ+wtd6Unk60vdTnPRFt3C4HEGuXMu+hTPE4cA3hnVBVHkdiraKZpnKjT4MnUn4TucC1kQeJiPJyTysRF7CnVz/IZkc4fYGIXsuOLmL+v7iBAR1mnlvFWivCi/oFqDexubrzyRpoa/+So73OYpys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992089; c=relaxed/simple;
	bh=1JE+m3tZntaa+yghR75WxF2AkhAkb2NTIHjVAS1ARUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lp/ENX1w6FTj+0rh++Hrc8vDyQPI9NNlDOotLIRCSesUoWe1ylWyet+XDrQDAioa9mFtqlP8TSz/MR4abYlzsooQbHfGBJPEMcDTcbi2blJoRyXB50BW8ZItHf/EOgT1qtq//2f9NYGVGOLuEKcsZPuMC0nRsM8XQ8ux8BTOL00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GK4cwrwY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GK4cwrwY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786992088; x=1818528088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1JE+m3tZntaa+yghR75WxF2AkhAkb2NTIHjVAS1ARUU=;
  b=GK4cwrwYi2cpDkHxiiUbQJA38keoWxYb5926B8oKBVcvUzt9eOG4G9c8
   ZqBorGSFHpyRtx/zFFYT7SpVJ/c/cVijos57cdiH3NW+YoaFOIomfETy2
   L8ezKdEwqa56nLjdyJwN3UwB0X/GErD3IPGVsRGmbiuGyMWueAyWnfPaT
   /TineIL7+819JHObi2wSXd8sfdnqqgsHnLXn8uNb+pkfXSK6U4ePWcaL/
   wxV1/wp1uZHOZYD4l+7iasRQkQpJzDCItCPTR03WyzO98rBnVt3lDV/Ix
   U47F2J8lkMe5jkX/nzDCT2XzIw0M23zXX5lfb4ciA7Ez7hl6sNORHkfe+
   A==;
X-CSE-ConnectionGUID: mZrII20pThCapwYMQhRjBw==
X-CSE-MsgGUID: 57YWSZA1RquHY30MZ9wnUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98066077"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="98066077"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 11:41:25 -0700
X-CSE-ConnectionGUID: SkGiWfhgSni/osSoDKExmQ==
X-CSE-MsgGUID: NLM3B1ZMSza2spvCCQmr/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="263656957"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 11:41:24 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v8 1/8] KVM: x86/pmu: Do not map fixed counters >= 3 to generic perf events
Date: Mon, 17 Aug 2026 11:31:35 -0700
Message-ID: <20260817183143.226156-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817183143.226156-1-zide.chen@intel.com>
References: <20260817183143.226156-1-zide.chen@intel.com>
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

The two BUILD_BUG_ON() checks are no longer needed, so drop them along
with __always_inline.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
v6:
- Re-arrange the code for early return. Clearer.
v2:
- Replace 3 in "if (index < 3)" with ARRAY_SIZE(fixed_pmc_perf_ids).
---
 arch/x86/kvm/vmx/pmu_intel.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index bfa8612fb450..df51a17b6e17 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -465,11 +465,8 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -478,8 +475,13 @@ static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
 	};
 	u64 eventsel;
 
-	BUILD_BUG_ON(ARRAY_SIZE(fixed_pmc_perf_ids) != KVM_MAX_NR_INTEL_FIXED_COUNTERS);
-	BUILD_BUG_ON(index >= KVM_MAX_NR_INTEL_FIXED_COUNTERS);
+	/*
+	 * Fixed counters 3 and above don't have a corresponding generic
+	 * hardware perf event, and KVM does not intend to emulate them on
+	 * non-mediated vPMU.
+	 */
+	if (index >= ARRAY_SIZE(fixed_pmc_perf_ids))
+		return 0;
 
 	/*
 	 * Yell if perf reports support for a fixed counter but perf doesn't
-- 
2.55.0

