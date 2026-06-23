Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E73A7F51;
	Tue, 23 Jun 2026 04:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782188932; cv=none; b=ae04MJfNw8X6y0tkkYSxwaACkIXKBE3XhOntLV/Ttn3NRkmK5L9Oqn/azCy8oIMPUIHZoWrE02pi+RoWBolcGVRSX8n/UBN9TYQIrEiDnOGWYPGmygGR0VwZ0lrptDnrhSGcicSj90A34theYbAnV8F+qAclzb25dVUcTvEDL8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782188932; c=relaxed/simple;
	bh=uu0OcTgn3CPKXcF0xjMO0RfY0krvnzHgkkThexzDjvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtwIV12UpzuMsaRH5H3M8qOlpzliq5exb7ulFsdLePvbd9NXkDjwNNaV2KBH4/97nCDw/VqsxjXUSJoYoc+tb7YZF65rv+dyi8kOvGDd+bE4PXQnwDXbtCZPci0nz6jKUXMDmragbLWZe5dnOexowkHhTT6qwN1XKGO5/VbTiIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S8J+dmz3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S8J+dmz3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782188930; x=1813724930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uu0OcTgn3CPKXcF0xjMO0RfY0krvnzHgkkThexzDjvs=;
  b=S8J+dmz3YnR3WKIf644+HHAb10sqOsSRIcwgscu2GZ8TFbgLUi6T5Ho7
   3UenkAM9ZcL8jRCmu/NTncBqZV9IctIfshJhAWba7UFarZcjdkqYpKNgE
   sJ2fhb/L+fdJeJcoTRxdoQKNEmg/cupkcF/NDvpj3rFRMW0V1soGAJE3O
   kL/XHUPbWeA8s9sFhyUkG0yhblW3X53TJ2NpYByGxN8PoXIJPCt1WrAE1
   kQnDMyUrXFoyMWX4hCsL2x7ZC/8+N9lVRft/5ZoVKTVVEFt5XS/FfPEvr
   t08E/NDQHZ/WCrs3ojFxCBpKQIA6riMStItdEO7EWYN5Wm6+ezeLoP9Do
   A==;
X-CSE-ConnectionGUID: Uk375n2IRECf8GUDt6obGw==
X-CSE-MsgGUID: B8WaTKkESAOvIaWqWpPtvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82809043"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82809043"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 21:28:49 -0700
X-CSE-ConnectionGUID: s1mq7/L3SZqT2P8NrSNfGw==
X-CSE-MsgGUID: oYt41iiYSpu7TEWQl+4E8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="279587562"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 21:28:50 -0700
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
Subject: [PATCH V4 1/4] KVM: x86/pmu: Do not map fixed counters >= 3 to generic perf events
Date: Mon, 22 Jun 2026 21:19:24 -0700
Message-ID: <20260623041927.178256-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623041927.178256-1-zide.chen@intel.com>
References: <20260623041927.178256-1-zide.chen@intel.com>
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
v2:
- Replace 3 in "if (index < 3)" with ARRAY_SIZE(fixed_pmc_perf_ids).
---
 arch/x86/kvm/vmx/pmu_intel.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index a73a9515d96c..59b7a90c79e1 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -464,28 +464,30 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
2.54.0

