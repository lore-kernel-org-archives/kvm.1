Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654E73D3D1A;
	Mon, 27 Jul 2026 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180727; cv=none; b=mMsiUtcruuEaXPaZpQ7UEHVxSzAYqYpiPNy59S2gqXV4bbFeeuBs+0ehQ0jAXvEvqLzefD2jPJuUu7CeN2Eh+mPkUJlOAu5mUisJBlzvn5s5lghsRrreCNq1pXLtv/y3vY3pujeKhYjhhCZcJ5SX9GgDHYb+bDRHAXpY0eGSnJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180727; c=relaxed/simple;
	bh=tBeaDm9lp0at0hNGGHr8/VwFbC5faXlsv4JRYV5tZj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKQEpg+Vr6Hbdr9WLSaynaFEIf52Hlr82sids+8VJFi6AfzdfDxcV3q6kyfQtj5ABhrTERnRKSZM4AuJPA+OYiEI2b6esxZoyehi+JeX+z6Urw4Slb1RsNFAo4aL38zXzVc83Itn3cw1r1ugk7oLlqLm+swQD/oA9tlUoQUd1rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M7qcWsZB; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7qcWsZB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785180725; x=1816716725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tBeaDm9lp0at0hNGGHr8/VwFbC5faXlsv4JRYV5tZj0=;
  b=M7qcWsZB2l5r61u52eFpNGMhxI/enBqI1hsjQhPjUl72ehf4UfIA+rjt
   pMeP9QORA5y4JTvx6VTFk7O8BucFeO+Kn4ls71jg8eDoelUbBHde3WD0o
   E6y7yJT2yG0u6vAYN9zQDsR50d8JPnEolp3ZeHe/CRW+K0Fz5SNgKy5CQ
   PmOV/Wa6FAJDDygI5SeaR64XPoI99sFlSI33c7nwO/vBgN99yJCRFhg1d
   286VYgHQCBnm/9SxrmoH8OTD/lo0N5JHIxsesi/ZYDdJ0ass8Q2GmMyoN
   n043b6TEN5vQ4EvrZElteic8TBvOSEM4sdxQEaCXeJMBasmPuXM2c2m/Y
   g==;
X-CSE-ConnectionGUID: y1BtikzQQjKnffpVi2MirA==
X-CSE-MsgGUID: +sOmF0hmScqeUSmz+o+bEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85876691"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="85876691"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 12:32:00 -0700
X-CSE-ConnectionGUID: mZFZjd4tRn6TtihQGJoSEg==
X-CSE-MsgGUID: YaJKEpXiQvuNZEUH1MIanw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="289451028"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 12:32:00 -0700
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
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v7 1/9] KVM: x86/pmu: Do not map fixed counters >= 3 to generic perf events
Date: Mon, 27 Jul 2026 12:21:23 -0700
Message-ID: <20260727192131.582105-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727192131.582105-1-zide.chen@intel.com>
References: <20260727192131.582105-1-zide.chen@intel.com>
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
index 1944939c4139..00865234d489 100644
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
2.54.0

