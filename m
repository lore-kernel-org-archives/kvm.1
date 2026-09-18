Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF93E5226BD;
	Fri, 18 Sep 2026 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761002; cv=none; b=FDv5S35ZE/943Ccuq9PCMFf6ueMqoYBYl5T7cr9WlGb9v76aUy/MqMs89v4es+WbY31OtLPvDvvH3YK0L6jp2GWu0gtqpg+wHpkMk7JpfQKTWob2SEYTbXa5edj49z2PvZh8WDDw2dPb7a2czTQDzPbMGnQcN3xHaTD0yLMMdu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761002; c=relaxed/simple;
	bh=3iMYST5X29l3027pQ/XLTAVky5fTbewHB42aIY95FOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cF97JDyXvMz1qBDYnKS1csiqjxeBCE9eIoSNlEyq57Ni+myzA/agfGE5VdIK2vK2RmYa5ybVFClHfmP+kb4mq9dQ0Mw8BVoSb7i9sRgVdu76dP/sLY6PBq2mG6LDtD2OCKQmXtsx71jHRTbnLj999nFYvAdcp3O95zWtUGAflhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWIgZg6O; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWIgZg6O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789761000; x=1821297000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3iMYST5X29l3027pQ/XLTAVky5fTbewHB42aIY95FOM=;
  b=XWIgZg6O/tkd2jzIboRetmk6YxwfTi4xTlbfjqOex9xtnifsUfhAOqkL
   +iOhg7Y61JbHFL4tnBoOb75TqKaoXBWwiU2oRHMegrHMPommVZMjLQZz2
   qHLekwa36Zl8ax8nRfQmE5Bxmn0mMctS5SNk75lIerYUlASIgjHDsPO2t
   iWY1GVJXJjUCpN9AHk0OrAgm289wEERkk4J9RzezQd8uw5x6wP9VsEdKb
   w5KwoiEXyctM1ZSmh9FOPYyuRx9x0PghPrp9f43/wmUsA7UpoAMcYUDKB
   Gl7RqtLuLXy+cYIaU7ADOBm04P5UMQRaKcUCQMqbmq/fZPNwK89lgrBf6
   g==;
X-CSE-ConnectionGUID: a4tjooTzT+aYtVxzLFhxZQ==
X-CSE-MsgGUID: tog2zncTQ/+azimDHsoPAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="790316"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="790316"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:49:59 -0700
X-CSE-ConnectionGUID: MJk4jq/zRainXTqPj7fVnQ==
X-CSE-MsgGUID: hbR/DltSSfa2CYXim4yLYQ==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:49:58 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v9 01/12] KVM: x86/pmu: Do not map fixed counters >= 3 to generic perf events
Date: Fri, 18 Sep 2026 12:39:26 -0700
Message-ID: <20260918193937.569414-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918193937.569414-1-zide.chen@intel.com>
References: <20260918193937.569414-1-zide.chen@intel.com>
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
---
 arch/x86/kvm/vmx/pmu_intel.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 70a8c4816135..11ad64d43e35 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -468,11 +468,8 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -481,8 +478,13 @@ static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
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

