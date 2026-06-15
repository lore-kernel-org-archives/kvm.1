Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579A63B71C0;
	Mon, 15 Jun 2026 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781565008; cv=none; b=gMOcAu966wYxWKXdfJTDdOCW99i+za1SPBHUHpBkhmdvtzFqqdZGa6Qqh7xyWJt2pKepyJPJ+1fZf9rD9wStkAwwGOaFNZJ7KQMBix8k7GyGICEfxHFcbRlQ65HiLiTfeTU4QxDj2YWO4j75kF1LU/QCH00Q/v9GUYCMyWIhu9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781565008; c=relaxed/simple;
	bh=mve+UDm/uAGJU6mpWCQ7sGp6QYzaUUSrPpRUQA4PoNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BZ8WceCxkG3zTuN4q03aqVAAbKMhfJvM7Po6NGm2e0B1sdG3+l1CqnP0AryTYv8Qhgs+WAcTBfI7uBJNNe88zBU85seImguV8IRquGt36vMJsCN87iMHwzMgkNlgv3bql6x+mcF3DVwpHEqA3kbdZ4KCllSs5dFUxPwj1JWQ3xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6w0/BH4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6w0/BH4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781565008; x=1813101008;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mve+UDm/uAGJU6mpWCQ7sGp6QYzaUUSrPpRUQA4PoNw=;
  b=W6w0/BH4KFQyd4H1OMQsF/RhPa7byVUStZvqYEO4RjWrBf68i1uWcnk/
   CxgmAuXRx7h3X/jyPn7kc37pOOwzg6IT9o+FEVb3rCMDZCeGIIOJn7LDx
   xpLvXoACjmt07aAr7YW0xHHnF8tEjIvYvhoVVQ9Ro9S6sXBmKaeolxO/z
   uEbrt2fgMWO2nWTQDQPI0vcbDlXgsNnydZRJJJ+5t4j24zEK+ICnXvW73
   R4fmb9DcXcNiv3iQbatuaG3GYhYy03vUX8VyTPzbXtRaArFa8+BZrAznK
   SOzsRZ+q80mVg6yFmNC/IadnAId6fWHgrhTlXxWulyM3vFH6YksvNQ8QD
   Q==;
X-CSE-ConnectionGUID: aGR660uETPu7yiBV5Tsmtw==
X-CSE-MsgGUID: DCd7v0FMTQyug1nmqjmD2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="99738590"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="99738590"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 16:10:07 -0700
X-CSE-ConnectionGUID: oLzplcC5R7Ozrd7+DcG0Yg==
X-CSE-MsgGUID: 8SCbXtllQfeCf9R3UjH3Sw==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 16:10:06 -0700
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
Subject: [PATCH V3 0/4] KVM: x86/pmu: Add hardware Topdown metrics support
Date: Mon, 15 Jun 2026 16:01:14 -0700
Message-ID: <20260615230118.50718-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Top-Down Microarchitecture Analysis (TMA) method is a structured
approach for identifying performance bottlenecks in out-of-order
processors.

Currently, guests support the TMA method by collecting Topdown events
using GP counters, which may trigger multiplexing.  To free up scarce
GP counters, eliminate multiplexing-induced skew, and obtain coherent
Topdown metric ratios, it is desirable to expose fixed counter 3 and
the IA32_PERF_METRICS MSR to guests.

Several attempts have been made to virtualize this under the legacy
vPMU model [1][2][3], but they were unsuccessful.  With the new mediated
vPMU, enabling TMA support in guests becomes much simpler.  It avoids
invasive changes to the perf core, eliminates CPU pinning and
fixed-counter affinity issues, and reduces the latge overhead of
trapping and emulating MSR accesses.

[1] https://lore.kernel.org/kvm/20231031090613.2872700-1-dapeng1.mi@linux.intel.com/
[2] https://lore.kernel.org/all/20230927033124.1226509-1-dapeng1.mi@linux.intel.com/T/
[3] https://lwn.net/ml/linux-kernel/20221212125844.41157-1-likexu@tencent.com/

Tested on an SPR.  Without this series, only raw topdown.*_slots events
work in the guest, and metric events (e.g. cpu/topdown-bad-spec/) are
not available.

With this series, metric events are visible in the guest.  Run this
command on both host and guest:

$ perf stat --topdown --no-metric-only -- taskset -c 2 perf bench sched messaging

Host results:

# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 10 groups == 400 processes run

     Total time: 1.500 [sec]

 Performance counter stats for 'taskset -c 2 perf bench sched messaging':

     4,266,060,558      TOPDOWN.SLOTS:u              #     32.0 %  tma_frontend_bound
                                                     #      5.2 %  tma_bad_speculation
       588,397,905      topdown-retiring:u           #     13.8 %  tma_retiring
                                                     #     49.0 %  tma_backend_bound
     1,376,283,990      topdown-fe-bound:u
     2,096,827,304      topdown-be-bound:u
       217,425,841      topdown-bad-spec:u
         5,050,520      INT_MISC.UOP_DROPPING:u

Only minor changes in v3.

Rebased to kvm-x86/next: c1f730330292

v3 changes:
- patch 2/4: Move the non-contiguous counter filter code to pmu.c (Dapeng)
- patch 3/4: Replace WARN_ON() with WARN_ON_ONCE(). (Dapeng)
- patch 4/4: Change abs() with explicit bounds (sum >= 0xfd && sum <= 0x102).
- Minor comment cleanups.

v2 changes:
- As suggested by Dapeng, implement a new selftest patch.
- Don't advertise fixed counter 3 if the host doesn't support it.
- Minor change in patch 1 to remove a magic number.

v2:
https://lore.kernel.org/kvm/20260423174639.56149-1-zide.chen@intel.com/T/#u
v1:
https://lore.kernel.org/kvm/20260226230606.146532-1-zide.chen@intel.com/T/#t
QEMU:
https://lore.kernel.org/qemu-devel/20260604025546.19378-7-zide.chen@intel.com/

Dapeng Mi (2):
  KVM: x86/pmu: Support Intel fixed counter 3 on mediated vPMU
  KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU

Zide Chen (2):
  KVM: x86/pmu: Do not map fixed counters >= 3 to generic perf events
  KVM: selftests: Add perf_metrics and fixed counter 3 tests

 arch/x86/include/asm/kvm_host.h               |  3 +-
 arch/x86/include/asm/msr-index.h              |  1 +
 arch/x86/include/asm/perf_event.h             |  1 +
 arch/x86/kvm/pmu.c                            | 18 +++++
 arch/x86/kvm/vmx/pmu_intel.c                  | 62 ++++++++++++----
 arch/x86/kvm/vmx/pmu_intel.h                  |  5 ++
 arch/x86/kvm/vmx/vmx.c                        |  6 ++
 arch/x86/kvm/x86.c                            | 10 ++-
 tools/arch/x86/include/asm/msr-index.h        |  1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |  3 +
 .../selftests/kvm/x86/pmu_counters_test.c     | 72 +++++++++++++++++--
 11 files changed, 161 insertions(+), 21 deletions(-)

-- 
2.54.0

