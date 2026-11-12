Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516233;
	b=ujlyEZuXWXrUk+j1hIZS7p81J9kU3ck7+P0sxEXySvp3GU0Dz/baF0tRBJYypXnCSWwH
	 T8cxOUDUIs9nstTNQQC4X/xlN2bYxalx5Frrx/DWxD8QAJ4Nv79w302Brd8Rs1ay9Oxvr
	 OM6JLJiuqmjv7JHfI9Duz+6kR/bWZv3jmcPNwzZbHludZ06viBuYrUkZ4fTS1OldujAUF
	 VndnxYwxCsS+rnXRNgxIjlpX5gMNZ8gV2QzMOzRefBPuyDCk0Mb5px2+hgbuqFtCs65Kb
	 IHWlk73aJg3o75sF2dBoPFaN4eb9zwUMtsTn4qKwYugNN0Xrqyu8J0s29cJMgDga/WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516233;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kvze38ECVkkoquVsuStB/NNciXFQXJNvRuhu+YzsMrc=;
	b=EUgxYiSDVoHN2icXD0yVOMhKPyO1QGA7uSzpEpvIJigfllA35ZfOl6Yq6EgiDKSTtAZw
	 dL/avBPvfWqiE9ykCaiSIrGoJc7+TwWnxMEZX2Dr0uhy9ZIzdFmDZ61GfeyTk+fHAN+bG
	 572siCgjJtd2SGxEU9ZBRHFGWOkXfMZWdBn739xDw89phvuahPhZPd+jqAUF9G3vhxMC4
	 L6iMnRyxyYpiswkYJux3q6vwpPSdYiKs+FoNVxsqqmANLoG8+HoAo25rvzrOtYw3oxHiw
	 v5w7BxNyVPF5GGmh1SdlQNJ1g1NkdWzvWHqrZAPPX9DxrGAcw3ylTJSedI6n482+KFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="C/iqYxFb";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9CD6070FAB;
	Thu, 12 Nov 2026 20:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E9CD6070FAB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C/iqYxFb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516233; x=1826052233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3kfXq8XKeviXllu9kbikQ4EfCzrG1aIaDTiGgZbBUoE=;
  b=C/iqYxFbH4pUjLzH8Zqkya/mRIadhDEOJmLOLXIp1HkOKQKTOG038EGo
   RN2Kbnzd/QuGjiiHZ5JfZEPuPGZau6l77UOXsm+tcpun+apuXcE2QFXwx
   WxO648Z2sRBom622PJgTAPlBEzb1wELBm1X/wAXuo5trnURSZZ6PtKJyn
   ACd7xYN89uv3XMbyVA2VoKeXzWPzW58/vMaljr0pRRsOxf/C/e1HWmIm7
   njqmvJ6mH8T5SxNBDuxNe+oFY9ZzrZBw0HbsBmJdJYm0xZPGdBw2yooJt
   fFcOUm6RC3otEplhCyu8EBVpez6B81OXZ4UxYI5xyevNW/RmHRMxHitmp
   g==;
X-CSE-ConnectionGUID: KU5Yeo6XQoGkdXLNY4uIfg==
X-CSE-MsgGUID: aQOB25VHTRqVtULiQ4JfFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192338"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192338"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:53 -0800
X-CSE-ConnectionGUID: ftvpN2BnSJ2jVseFL4K3VA==
X-CSE-MsgGUID: JFBRORD1SIGAWSuuYuoWtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087951"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:53 -0800
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v4 21/21] KVM: selftests: Support fixed counters bitmap in pmu_counters_test
Date: Thu, 12 Nov 2026 13:32:27 -0700
Message-ID: <20261112203227.289379-22-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261112203227.289379-1-zide.chen@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
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
CPUID.0AH:{ECX,EDX} to match the new PMU version.

For example, after downgrading a guest from PMU v5 to PMU v2,
this_pmu_has() would still consult CPUID.0AH:ECX while KVM ignores it,
resulting in a mismatch in the reported fixed counter capabilities.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3:
- use the BIT() macro instead of an open-coded left shift. (Sashiko)
- Simplified ternary condition in this_pmu_has(). (Sashiko)
- Also test legacy EDX contiguous counts with ECX=0 in
  test_fixed_counters(). (Sashiko)

v2:
- Fix this_pmu_has() to honor the guest's configured PMU version.
- Update the pmu_vm_create_with_vcpus() calls after rebasing.
---
 .../selftests/kvm/include/x86/processor.h     |  6 +++-
 .../selftests/kvm/x86/pmu_counters_test.c     | 29 +++++++++++++++----
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index ffec2291b1e1..21381db1c4ca 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -836,6 +836,7 @@ static __always_inline bool this_cpu_has_p(struct kvm_x86_cpu_property property)
 
 static inline bool this_pmu_has(struct kvm_x86_pmu_feature feature)
 {
+	u8 pmu_version;
 	u32 nr_bits;
 
 	if (feature.f.reg == KVM_CPUID_EBX) {
@@ -845,7 +846,10 @@ static inline bool this_pmu_has(struct kvm_x86_pmu_feature feature)
 
 	GUEST_ASSERT(feature.f.reg == KVM_CPUID_ECX);
 	nr_bits = this_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
-	return nr_bits > feature.f.bit || this_cpu_has(feature.f);
+	pmu_version = this_cpu_property(X86_PROPERTY_PMU_VERSION);
+
+	return nr_bits > feature.f.bit ||
+	       (pmu_version >= 5 && this_cpu_has(feature.f));
 }
 
 static __always_inline u64 this_cpu_supported_xcr0(void)
diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
index c3e784e16348..61e6fe5b6ef4 100644
--- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2023, Tencent, Inc.
  */
 #include <x86intrin.h>
+#include <linux/bitmap.h>
 
 #include "pmu.h"
 #include "processor.h"
@@ -631,25 +632,43 @@ static void __test_fixed_counters(struct kvm_vcpu *vcpu, u8 nr_fixed_counters,
 static void test_fixed_counters(u8 pmu_version, u64 perf_capabilities)
 {
 	u8 nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
+	unsigned long fixed_subset;
 	struct kvm_vcpu **vcpus;
 	struct kvm_vm *vm;
+	u32 fixed_bitmap;
 	int i = 0;
-	u32 k;
 	u8 j;
 
 	pr_info("Testing %u fixed counters, PMU version %u, perf_caps = %lx\n",
 		nr_fixed_counters, pmu_version, perf_capabilities);
 
+	fixed_bitmap = BIT(nr_fixed_counters) - 1;
+	if (pmu_version >= 5)
+		fixed_bitmap |= kvm_cpu_property(X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK);
 
-	vm = pmu_vm_create_with_vcpus((nr_fixed_counters + 1) * BIT(nr_fixed_counters),
+	/* One vCPU per subset of fixed_bitmap, plus one per legacy EDX test. */
+	vm = pmu_vm_create_with_vcpus(BIT(__builtin_popcount(fixed_bitmap)) + nr_fixed_counters,
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
 
+	for (j = 1; j <= nr_fixed_counters; j++)
+		__test_fixed_counters(vcpus[i++], j, 0);
+
 	pmu_vm_free(vm, vcpus);
 }
 
-- 
2.56.1

