Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5B03CF1E5;
	Mon, 29 Jun 2026 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782775728; cv=none; b=inM8dmdOHx1KYOf5DzLMJtzBcAha68zFqSGjU80mjhvfMMVlHApW0g+qiP6I25FHDIPvXyBAQyFKJ9MFKywN43Z4uIY44+G3bwVVBOA6KnR+lt0+bkU+VSsTeakEUARXkuqnYruaHSdXDuZPBpHwk1xuRaouPovchsMbTb/FAD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782775728; c=relaxed/simple;
	bh=pZz/MCLdUQGHWW7fgkdzMQfukhXabJhpuUkre9bGRYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4VxVCOdKJr6eqHyGs42f0MM+QprYg5vM8OREfzWhQlTM1L0j/n06j9mHtM3/uTZuY7/ZdEOzcviW+dWGvpZQava/22qeeCS3l82w8e70GhfXWi0yYB1FNGEOPvSpLHh44mEyWz++0uW7AGNC6+DI4U8H+7/6PES6KclaX2Yh6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNLnx6il; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNLnx6il"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782775727; x=1814311727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pZz/MCLdUQGHWW7fgkdzMQfukhXabJhpuUkre9bGRYw=;
  b=jNLnx6ilYJnvb0G2jHjQ12rrtNB/xNtwbYQLGUNahyHzsnxmyzLqantH
   RDxVzz04mxOPZrFfeQnVkP+r/s6cBz12t2BGwdzhW1BS/ejxNeJcRtqLC
   TR3CtXC1It4caUt503VaJ+cggoaERDmYOaC4MfCzf2W8WxBbrZr0G6B/f
   S+QbjHDiZVeYdH5RYgyQFk4CkHcWWakEAhOG3nuUv3xWmkX4dUJeCsra7
   RNslqjopjK2JbcfK1O7mTgQOOXVt9yxlZ6rya8kAZ6p9wpOapAJ54kM+M
   ALVXonixluUero4X0TGF0oFQaTAqcmPA6Rz8vUVWLIxNxel7GktpssZBE
   A==;
X-CSE-ConnectionGUID: HPN2rZIyQpGjanl5LJ95zA==
X-CSE-MsgGUID: Uq2AK6Z1RJ2dUlNN4q8mXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82593485"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="82593485"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 16:28:43 -0700
X-CSE-ConnectionGUID: gGCDMJRjQ12OwEmHkQQCZQ==
X-CSE-MsgGUID: Zn5pBSbiRcGrTOAXlPVaPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="290220129"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 16:28:44 -0700
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
Subject: [PATCH v6 1/8] KVM: x86/pmu: Do not map fixed counters >= 3 to generic perf events
Date: Mon, 29 Jun 2026 16:19:30 -0700
Message-ID: <20260629231938.15129-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629231938.15129-1-zide.chen@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
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
---
v6:
- Re-arrange the code for early return. Clearer.
v2:
- Replace 3 in "if (index < 3)" with ARRAY_SIZE(fixed_pmc_perf_ids).
---
 arch/x86/kvm/vmx/pmu_intel.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index a73a9515d96c..f15af497d27f 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -464,11 +464,8 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -477,8 +474,13 @@ static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
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
2.54.0

