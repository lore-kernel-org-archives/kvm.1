Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4213EEACB;
	Thu, 27 Aug 2026 22:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870899; cv=none; b=HRkneAFou5qEzWCWf5vYAC5VvzwJTaZHB2jt5mfnUtyuGne73iOK37aFA6J3/ddBkHvreSImpfc7hP9cwht/nmrCTNdmO4PstlhSFhALpaPzhKqot0Yrk/UjYpd885LIXJOa07EQAWxpYb90dA+Z4/H0Hp+N7dbRTtCgSVzDb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870899; c=relaxed/simple;
	bh=e2hkXbHMQWstYz+VEcQqgKu52pILBTL7z3hYG3gwxJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PD/jRQhjeXB2pSYkufzCyAVap1k+RL89WtdvPwdPCw8CkPFIXIe9VZ1TQx9s78I1JAUmfIZtxtHVfW5NqQ79tlEEke+9AkLH6P4STw7Hfzc52LdppGkSa9P1/XoBznjijVEcDxrA3WNCgQuC2C6N+TQMGvUu14cvZf5dOBYLY1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2jPmW+/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2jPmW+/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787870898; x=1819406898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e2hkXbHMQWstYz+VEcQqgKu52pILBTL7z3hYG3gwxJ0=;
  b=N2jPmW+/9nocPolyI43askee+DcoH26HMAPmfIlTFtUK+3FHY5zWT9p8
   nYLGpqCCkTg5+rcSAfhL9SPa6c0fDE13RhKIat7CeuRHEqbEMGHr0N3wB
   OFHRqncMz144FxNoORfGHiia1LivrXhT7+2wWPDlO2tb/dZ/aLFKfCAEC
   3H8XoBTBrMfwg6PR2Da4DyEVbpqMSPEojVvIxdZfMK4sTzQ6LLuRLtP4W
   NhlLTATpuHjXCIX6WxARG0V8ld/QynJbODaNo6STK/c4ZNyMO/n/JHggR
   QTRUq7H785QNHxK8SNn092tNPwSN+B7OTM5Cpd3p6G6Y6b0R0vbToZ7Db
   g==;
X-CSE-ConnectionGUID: Shg44gYXRH2c/atyMGUUyA==
X-CSE-MsgGUID: BX3kUau2T5ax+o/WwkhqMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113914906"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="113914906"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:10 -0700
X-CSE-ConnectionGUID: bOiApUoRTRGi6Fi+BWyoXA==
X-CSE-MsgGUID: BJ2pF+qoQP2zWGC3g5bVYA==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:10 -0700
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
Subject: [PATCH v2 16/16] KVM: selftests: Support fixed counters bitmap in pmu_counters_test
Date: Thu, 27 Aug 2026 15:37:55 -0700
Message-ID: <20260827223755.143247-17-zide.chen@intel.com>
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

On PerfMon v5, CPUID.0AH:ECX represents the fixed counter bitmask,
while EDX[4:0] indicates the number of contiguous fixed counters
starting from 0:

FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i).

Fix test_fixed_counters() to derive supported fixed counters using the
above formula instead of relying solely on EDX[4:0]. This allows the
test to cover non-contiguous fixed counter configurations.

Update this_pmu_has() to take the PMU version into consideration.
Without this fix, it could return incorrect results in test cases such
as test_arch_events(), which configure a PMU version different from
the one originally advertised by KVM without explicitly updating
CPUID.0AH.{ECX,EDX} to match the new PMU version.

For example, after downgrading a guest from PMU v5 to PMU v2,
this_pmu_has() would still consult CPUID.0AH.ECX while KVM ignores it,
resulting in a mismatch in the reported fixed counter capabilities.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v2:
- Fix this_pmu_has() to honor the guest's configured PMU version.
- Update the pmu_vm_create_with_vcpus() calls after rebasing.
---
 .../selftests/kvm/include/x86/processor.h     |  6 ++++-
 .../selftests/kvm/x86/pmu_counters_test.c     | 26 ++++++++++++++-----
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 6e6f70035508..c983dbfd9d70 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -827,6 +827,7 @@ static __always_inline bool this_cpu_has_p(struct kvm_x86_cpu_property property)
 
 static inline bool this_pmu_has(struct kvm_x86_pmu_feature feature)
 {
+	u8 pmu_version;
 	u32 nr_bits;
 
 	if (feature.f.reg == KVM_CPUID_EBX) {
@@ -836,7 +837,10 @@ static inline bool this_pmu_has(struct kvm_x86_pmu_feature feature)
 
 	GUEST_ASSERT(feature.f.reg == KVM_CPUID_ECX);
 	nr_bits = this_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
-	return nr_bits > feature.f.bit || this_cpu_has(feature.f);
+	pmu_version = this_cpu_property(X86_PROPERTY_PMU_VERSION);
+
+	return (pmu_version < 5) ? nr_bits > feature.f.bit :
+	       nr_bits > feature.f.bit || this_cpu_has(feature.f);
 }
 
 static __always_inline u64 this_cpu_supported_xcr0(void)
diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
index c3e784e16348..21bd8ec90c98 100644
--- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2023, Tencent, Inc.
  */
 #include <x86intrin.h>
+#include <linux/bitmap.h>
 
 #include "pmu.h"
 #include "processor.h"
@@ -631,23 +632,36 @@ static void __test_fixed_counters(struct kvm_vcpu *vcpu, u8 nr_fixed_counters,
 static void test_fixed_counters(u8 pmu_version, u64 perf_capabilities)
 {
 	u8 nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
+	unsigned long fixed_subset;
 	struct kvm_vcpu **vcpus;
 	struct kvm_vm *vm;
+	u32 fixed_bitmap;
 	int i = 0;
-	u32 k;
-	u8 j;
 
 	pr_info("Testing %u fixed counters, PMU version %u, perf_caps = %lx\n",
 		nr_fixed_counters, pmu_version, perf_capabilities);
 
+	fixed_bitmap = BIT_ULL(nr_fixed_counters) - 1;
+	if (pmu_version >= 5)
+		fixed_bitmap |= kvm_cpu_property(X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK);
 
-	vm = pmu_vm_create_with_vcpus((nr_fixed_counters + 1) * BIT(nr_fixed_counters),
+	vm = pmu_vm_create_with_vcpus((1 << __builtin_popcount(fixed_bitmap)),
 				      guest_test_fixed_counters,
 				      pmu_version, perf_capabilities, &vcpus);
 
-	for (j = 0; j <= nr_fixed_counters; j++) {
-		for (k = 0; k <= (BIT(nr_fixed_counters) - 1); k++)
-			__test_fixed_counters(vcpus[i++], j, k);
+	for (fixed_subset = 0; fixed_subset <= fixed_bitmap; fixed_subset++) {
+		u32 nr_contiguous;
+
+		/*
+		 * The loop walks all values from 0 to fixed_bitmap, so skip any
+		 * value that is not a subset of fixed_bitmap.
+		 */
+		if (fixed_subset & ~fixed_bitmap)
+			continue;
+
+		nr_contiguous = find_first_zero_bit(&fixed_subset,
+						    MAX_NR_FIXED_COUNTERS);
+		__test_fixed_counters(vcpus[i++], nr_contiguous, fixed_subset);
 	}
 
 	pmu_vm_free(vm, vcpus);
-- 
2.55.0

