Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BAF42E41E;
	Fri, 21 Aug 2026 22:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351473; cv=none; b=NZ5yota3MxkUWTk/xHuvNFzMZAWV2w8D5+BxtdgtLLkygD77Q1o3uLmb6KkIKB+2e4SGvqaEBOSuiEuUPlcC5HP6mUwtlTdZb20g/tcfJeuNo9hZBj7dfUUmAdhkqTumGp2EkLRnp/6cX37L71BW3DF79BBbZJFa30WpYCp7ZiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351473; c=relaxed/simple;
	bh=FHFDZyv6mGjABpe0Q314QUEJzatCeiq4oBRo4DWEIVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9uPrlOgnLpEaHo2Ecx3PTf8GVm2PUQ9hsqzyEvXwSRLqA9I2l7IQskMKbReRzNoeSHprqOE79NRZchWlqmcR7aRSmbaR6hnS5ErrHeBicLC2BCAS0QzlNkM1/tRUvPjJV6DT60ftmJ16u3YMsELfBDJCOyWKlt9pwx+ELWojFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0o7xQK4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0o7xQK4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351471; x=1818887471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FHFDZyv6mGjABpe0Q314QUEJzatCeiq4oBRo4DWEIVE=;
  b=Y0o7xQK42sp7RSi1YCKAkEe6zhPfrwhOePVM4wMi8oqCDSx6L7+x/iIe
   zuZ/9rRl4i6aBvLg0Lj+QhSYzgrXazcSTG8NDpaAlL2yPGxxIZjKOIUJj
   plYtjB7pWGqIdPjLJiHJyUN5iQ08GJpjpNhD1+W73ERIqsSGgB7XYnaY9
   oW3lGEkho1hqwJ1muLpsOZuVxa7nUfeLFqhxvskfTrFCpis8R/+ZrUslA
   4HMFKlZZcK+kv/3zij595LeJxmggdq/L+id+wz/dDxWVGH/pOL2myu482
   d89pY4EHmGDicCWfwtsopeJ5CGmvGuXnlKwkRX5cnktGoIN7xJMzhNtMQ
   Q==;
X-CSE-ConnectionGUID: OS4fWCaWSj2dThjQlM2sIw==
X-CSE-MsgGUID: QEhbY02aQ32O5L6KJgkW/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032677"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032677"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:54 -0700
X-CSE-ConnectionGUID: 6dPFKSpnQkSJJHwmFvqSJQ==
X-CSE-MsgGUID: cSMK/XfYRXaw2Rmu+B5XpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679825"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:54 -0700
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
Subject: [PATCH 23/23] KVM: selftests: Allow no general purpose counters on the host
Date: Fri, 21 Aug 2026 15:20:02 -0700
Message-ID: <20260821222002.54907-24-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821222002.54907-1-zide.chen@intel.com>
References: <20260821222002.54907-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not GUEST_ASSERT(nr_gp_counters). Instead, skip the architectural
event tests that require general-purpose counters when none are
available.

In theory, guest CPUID.0AH:EAX[15:08] can be configured to report zero
when the selftest runs on L1. In practice, this scenario is
more likely to occur when PMU partitioning limits the number of
available general-purpose counters.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 .../selftests/kvm/x86/pmu_counters_test.c     | 26 +++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
index edcd04b4111c..b38e802e753b 100644
--- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
@@ -282,19 +282,16 @@ static void __guest_test_arch_event(u8 idx, u32 pmc, u32 pmc_msr,
 		GUEST_TEST_EVENT(idx, pmc, pmc_msr, ctrl_msr, ctrl_msr_value, KVM_FEP);
 }
 
-static void guest_test_arch_event(u8 idx)
+static void guest_test_arch_gp_event(u8 idx, bool guest_has_perf_global_ctrl)
 {
 	u32 nr_gp_counters = this_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
-	u32 pmu_version = guest_get_pmu_version();
-	/* PERF_GLOBAL_CTRL exists only for Architectural PMU Version 2+. */
-	bool guest_has_perf_global_ctrl = pmu_version >= 2;
-	struct kvm_x86_pmu_feature gp_event, fixed_event;
+	struct kvm_x86_pmu_feature gp_event;
 	u32 base_pmc_msr;
 	unsigned int i;
 	u64 eventsel;
 
-	/* The host side shouldn't invoke this without a guest PMU. */
-	GUEST_ASSERT(pmu_version);
+	if (!nr_gp_counters)
+		return;
 
 	if (this_cpu_has(X86_FEATURE_PDCM) &&
 	    rdmsr(MSR_IA32_PERF_CAPABILITIES) & PMU_CAP_FW_WRITES)
@@ -305,7 +302,6 @@ static void guest_test_arch_event(u8 idx)
 	gp_event = intel_event_to_feature(idx).gp_event;
 	GUEST_ASSERT_EQ(idx, gp_event.f.bit);
 
-	GUEST_ASSERT(nr_gp_counters);
 	i = kvm_random_u32_in_range(&kvm_rng, 0, nr_gp_counters - 1);
 
 	eventsel = ARCH_PERFMON_EVENTSEL_OS | ARCH_PERFMON_EVENTSEL_ENABLE |
@@ -316,6 +312,20 @@ static void guest_test_arch_event(u8 idx)
 		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, BIT_ULL(i));
 
 	__guest_test_arch_event(idx, i, base_pmc_msr + i, MSR_P6_EVNTSEL0 + i, eventsel);
+}
+
+static void guest_test_arch_event(u8 idx)
+{
+	u32 pmu_version = guest_get_pmu_version();
+	/* PERF_GLOBAL_CTRL exists only for Architectural PMU Version 2+. */
+	bool guest_has_perf_global_ctrl = pmu_version >= 2;
+	struct kvm_x86_pmu_feature fixed_event;
+	unsigned int i;
+
+	/* The host side shouldn't invoke this without a guest PMU. */
+	GUEST_ASSERT(pmu_version);
+
+	guest_test_arch_gp_event(idx, guest_has_perf_global_ctrl);
 
 	if (!guest_has_perf_global_ctrl)
 		return;
-- 
2.55.0

