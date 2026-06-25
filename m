Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0108C1CAA78;
	Thu, 25 Jun 2026 03:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782359695; cv=none; b=V0lMKZ4RRmrsivs+UynmF1uZd+16ruSj8RclK0fqt2AxDHqd4P+mp0IvuWkRcYPJsfaqAhdcTMmJ0E9kCJ4Z4WTpJyvjgnF15WpukKOKvQf1JlYGbXuO3enUNKlTN1qVs62XCKdVB41y8nR8R6SdaErMmxAf/cHsoPnmyEHWBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782359695; c=relaxed/simple;
	bh=cnIcwmbbTbzD78xzTfIyMXwnIfQGt6qigGgffUtGN5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCadYDlzygmeplloQGmwjHbkSR/NNNWUZcpysPz71Ep2+ktxjV+vOV2/e5efmN1jLt6+KbpR+1VP4Te/EFzPtRARYoPuXg0Ux1wC89huLFXjML390U1g45qkOZUEVBTjjzwybZHxsa/Kcd3n/Txg/rfNioS3/pMzcOhzn6JoAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Brjzcpys; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Brjzcpys"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782359694; x=1813895694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cnIcwmbbTbzD78xzTfIyMXwnIfQGt6qigGgffUtGN5I=;
  b=Brjzcpysuo1qEu3Pg/S97e0UliME7FnzKMBKAqurghyKbQksgFGstyVy
   jBLa9+1oPdYmo8MX/vKOEKQYG7Panlk/GFbitrMOnJv7EsS6Qjt5Vo4VG
   MNJW8tMGWPzgXP9VHx41I7bb5vDqOp+dPgktwRCQX6G2SyTmdDjhfKy2/
   8XJBgbhRpD3hTgqBvXw7g/BCpRvTAIHPQTgEOq0mOSt2DCwlFio6jHaX9
   uvrF7ubRHdBc+fzbDID+F932A1PgDUw9n5q0iuouuRwUv+6yYaxf5PODw
   Ybxt1h0kI+cxLVV77ZQ9/cdZavEPtwifTMc1PESYOuA5yiubEuo96JL4i
   A==;
X-CSE-ConnectionGUID: uiwnvD9CTNyo4ZTm9m1oSg==
X-CSE-MsgGUID: +5MxV9oxTb65uX8au3Qs7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82901454"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="82901454"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 20:54:53 -0700
X-CSE-ConnectionGUID: WjNZjeZOS2CgZSU4rIHgRg==
X-CSE-MsgGUID: Kj5sEOfhS+KqaVgoD0Y9Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="288396615"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 20:54:52 -0700
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
Subject: [PATCH V5 1/7] KVM: x86/pmu: Do not map fixed counters >= 3 to generic perf events
Date: Wed, 24 Jun 2026 20:45:49 -0700
Message-ID: <20260625034555.141453-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625034555.141453-1-zide.chen@intel.com>
References: <20260625034555.141453-1-zide.chen@intel.com>
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
index a73a9515d96c..60b6b83c7ced 100644
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
+	 * Fixed counters 3 and above don't have a corresponding generic
+	 * hardware perf event, and KVM does not intend to emulate them on
+	 * non-mediated vPMU.
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

