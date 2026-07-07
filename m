Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FD54534B4;
	Tue,  7 Jul 2026 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449861; cv=none; b=oHujjPxZrRzcsTVFZtoaAV4LrBxEGpDax0AvZmeBI7jrvlU3CRXEVcTXgP+LT5FgCXqr7NQjj8G7rro2RntK1PY3MNEh36s/8A5D7Rk3OQyGD5T+WoJoVQl04PfeKbt9UidH9Hq1RCbXsJSz3fOxWHt1v8yjSmDVIiFYwYNFMrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449861; c=relaxed/simple;
	bh=tdZ+zHfjupjg9xcsMuE7Hm1Zn17y/djzFwOgOpiSRUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkvE8EGxA3AbD4PlP2QIAI8fW9trkb6r68e2fnmCcRzedatJbXT111nIWimwRjJ4GAHZ1L8794yMVApk8Zh3K0Zdsmc6NQ05TnIVPN4Gk/BH4+3iH8JW4JkhEihIyUhXPJB85Ock2Y3BYGMS3ioovLoOevBKgjCGF2xhG4PXLJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DN4pW9xM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DN4pW9xM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783449860; x=1814985860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tdZ+zHfjupjg9xcsMuE7Hm1Zn17y/djzFwOgOpiSRUk=;
  b=DN4pW9xMnDFOgalYdLwirXMIfOL2gLZClNMhXmeBUtq8/fLXz2T9mR90
   WBIDMz6tiBVPEIADJMpDWnmLUeC2ATb/DQOChAO70B4Npk3Ugwv4f5xv8
   blraa9kd5O1H7yu67cnhlAMiBWuk5Gbe+zdVNL7qpqBLHgZvBicfl0jHP
   w88gosDdxVC0BXPbH7KlXaL/Y368sFsVIIQDA1J6BgBtfvMo6U5/YLZ+C
   J72SBcIe6l7KCtFZPxcg29gWdsU6vt8ivOyLG7+p9pVJJZTKSBSGrXV5i
   2gkE2aiHCUM/SlWYvQo4jjTjamVMDr2luMq66cyPJiTF9kTApUJqBpp5/
   Q==;
X-CSE-ConnectionGUID: qjUzuqZ0SO2jb7eJIH9HJA==
X-CSE-MsgGUID: WzPQFp7rTZi5nu4KlsYmsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94713917"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94713917"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:44:01 -0700
X-CSE-ConnectionGUID: X0X1ZKnyQf+qhrnk1RDWIg==
X-CSE-MsgGUID: IAnPSrv9SbK5656i5smaKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277279351"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:44:00 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
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
Subject: [PATCH 15/15] KVM: selftests: Support fixed counters bitmap in pmu_counters_test
Date: Tue,  7 Jul 2026 11:34:05 -0700
Message-ID: <20260707183405.15571-16-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707183405.15571-1-zide.chen@intel.com>
References: <20260707183405.15571-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

On PerfMon v5, CPUID.0AH:ECX represents the fixed counter bitmask,
while EDX[4:0] represents the number of contiguous fixed counters
starting from 0.

pmu_counters_test does not correctly set up these two fixed counter
fields. For example, it may set EDX[4:0] to 0x0 while setting ECX to
0x1. It assumes that fixed counter 0 is available by checking:

FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i).

However, this is an invalid setup because EDX[4:0] should not be zero
when the number of contiguous fixed counters is 1.

Correct the setting of EDX[4:0] when the fixed counter bitmask is
present, and also handle the non-contiguous fixed counter case.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 .../selftests/kvm/x86/pmu_counters_test.c     | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
index 38057754e024..6f38a35a4ea7 100644
--- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2023, Tencent, Inc.
  */
 #include <x86intrin.h>
+#include <linux/bitmap.h>
 
 #include "pmu.h"
 #include "processor.h"
@@ -659,6 +660,8 @@ static void test_intel_counters(void)
 	u8 nr_gp_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
 	u8 pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
 	u64 advertised_perf_caps = kvm_get_feature_msr(MSR_IA32_PERF_CAPABILITIES);
+	unsigned long fixed_subset;
+	u32 fixed_bitmap = 0;
 	unsigned int i;
 	u8 v, j;
 	u32 k;
@@ -696,6 +699,12 @@ static void test_intel_counters(void)
 	 */
 	u8 max_pmu_version = max_t(typeof(pmu_version), pmu_version, 5);
 
+	if (nr_fixed_counters)
+		fixed_bitmap = GENMASK(nr_fixed_counters - 1, 0);
+
+	if (pmu_version > 4)
+		fixed_bitmap |= kvm_cpu_property(X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK);
+
 	/*
 	 * Detect the existence of events that aren't supported by selftests.
 	 * This will (obviously) fail any time hardware adds support for a new
@@ -750,9 +759,19 @@ static void test_intel_counters(void)
 
 			pr_info("Testing fixed counters, PMU version %u, perf_caps = %lx\n",
 				v, perf_caps[i]);
-			for (j = 0; j <= nr_fixed_counters; j++) {
-				for (k = 0; k <= (BIT(nr_fixed_counters) - 1); k++)
-					test_fixed_counters(v, perf_caps[i], j, k);
+			for (fixed_subset = 0; fixed_subset <= fixed_bitmap; fixed_subset++) {
+				u32 nr_contiguous;
+
+				/*
+				 * The loop walks all values from 0 to fixed_bitmap, so skip any
+				 * value that is not a true subset of fixed_bitmap.
+				 */
+				if (fixed_subset & ~fixed_bitmap)
+					continue;
+
+				nr_contiguous = find_first_zero_bit(&fixed_subset,
+								    MAX_NR_FIXED_COUNTERS);
+				test_fixed_counters(v, perf_caps[i], nr_contiguous, fixed_subset);
 			}
 
 			pr_info("Testing Perf Metrics, PMU version %u, perf_caps = %lx\n",
-- 
2.54.0

