Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC033CF047;
	Mon, 29 Jun 2026 23:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782775726; cv=none; b=u16wR95xKHU9Ck6sUQytvrxHiNBb6eacWH51xi2Ipf5TKr9fn8Ot/IgDgogu+LIJW+KhlmxUL/x8X1Wx9wxDJfeV0NclIawHm5ynt9+r490Cva1eUXLx65gjSjG/R/ajwkCn+5vtUKY2/z8o12VNiMq1/S67it7Ki0Qcop9sFGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782775726; c=relaxed/simple;
	bh=5CsPMc8RtfBaVUAWTLnV1xU5CyRM1zNcMgeldLg7agw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFcFXxi+oh5aG/i0jMkBjSsb9bbik22dpTGJHIHhdl4CL/JxKRoRBeyRcIfVTIj4m8+p6PChv6z/NR2bYKicvX79yVHTii1R3JZtHZVZgqDTYPfwEG2pZ+fA5C/V3au0z5jCdGxYmSDatsKRSdMnvqUZPjFT9bLBQmpr9STS/GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9cael5+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9cael5+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782775724; x=1814311724;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5CsPMc8RtfBaVUAWTLnV1xU5CyRM1zNcMgeldLg7agw=;
  b=O9cael5+jkqI/WNkObrBPhUpf69HAJMD96gRXqc5kteD4d9OVtNe+C+S
   glQ4HCbvjU+5k2UYj9Yyefm/tIlBenjiTHfo7Hev2ztPU9k98vip+dDP4
   40huljwOmyguFplUpvCADJksj4AosBy2GoXrMuswHAr6ISq8T9e3gYZjw
   UxGiQIwqB/H5ueHQMHlV/5CueuMXRtoUKwkBILUYFGIWemaZV7DHWFMqw
   0R8q5ShWlPbrWAq+pdsWsfibZauNoJMlSEhv1GmBObil+Sjsoh5is0a1w
   mR5U7swJsVH/Lm8WnNWfu/X6WAXivnF+V+B+fR0L0ZRYDP/Dd2uxbabVc
   g==;
X-CSE-ConnectionGUID: yBfkrOHsSM6WE3T+Gg1smQ==
X-CSE-MsgGUID: qc5oqQrgQo6GH/zRM7Gb2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82593482"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="82593482"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 16:28:43 -0700
X-CSE-ConnectionGUID: KA35p2T4SCy19X3t35tCcg==
X-CSE-MsgGUID: KT9I+yuJTiq6zSkr2ARy2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="290220125"
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
Subject: [PATCH V6 0/8] KVM: x86/pmu: Add hardware Topdown metrics support
Date: Mon, 29 Jun 2026 16:19:29 -0700
Message-ID: <20260629231938.15129-1-zide.chen@intel.com>
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
fixed-counter affinity issues, and reduces the large overhead of
trapping and emulating MSR accesses.

[1] https://lore.kernel.org/kvm/20231031090613.2872700-1-dapeng1.mi@linux.intel.com/
[2] https://lore.kernel.org/all/20230927033124.1226509-1-dapeng1.mi@linux.intel.com/T/
[3] https://lwn.net/ml/linux-kernel/20221212125844.41157-1-likexu@tencent.com/

Tested on an Sapphire Rapids. Without this series, only raw topdown.*_slots
events work in the guest, and metric events (e.g. cpu/topdown-bad-spec/) are
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

Rebased to kvm-x86/next: 50406d35f563

v6 changes:
- patch 6/8: New patch to refactor rdpmc emulation code.
- patch 7/8: More strict handling of RDPMC ECX argument.
- patch 8/8: Move perf metrics out of test_arch_events().
- patch 2/8: Minor fix of comments.
v5 changes:
- patch 3,5,6/7: new patches to handle RDPMC on metrics.
- patch 6/7: remove host_initiated check.
v4 changes:
- patch 3/4: Remove WARN_ON_ONCE() and simply reject the guest accesses
  by checking host_initiated. (Sashiko)
- patch 3/4: Passthru MSR_PERF_METRICS only if has_mediated_pmu is
  true. (Sashiko)
v3 changes:
- patch 2/4: Move the non-contiguous counter filter code to pmu.c (Dapeng)
- patch 3/4: Replace WARN_ON() with WARN_ON_ONCE(). (Dapeng)
- patch 4/4: Change abs() with explicit bounds (sum >= 0xfd && sum <= 0x102).
- Minor comment cleanups.

v2 changes:
- As suggested by Dapeng, implement a new selftest patch.
- Don't advertise fixed counter 3 if the host doesn't support it.
- Minor change in patch 1 to remove a magic number.

v5:
https://lore.kernel.org/kvm/20260625034555.141453-1-zide.chen@intel.com/
v4:
https://lore.kernel.org/kvm/20260623041927.178256-1-zide.chen@intel.com/
QEMU:
https://lore.kernel.org/qemu-devel/20260604025546.19378-7-zide.chen@intel.com/

Dapeng Mi (2):
  KVM: x86/pmu: Support Intel fixed counter 3 on mediated vPMU
  KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU

Mingwei Zhang (1):
  KVM: x86/pmu: Snapshot host IA32_PERF_CAPABILITIES in kvm_host

Zide Chen (5):
  KVM: x86/pmu: Do not map fixed counters >= 3 to generic perf events
  KVM: x86/pmu: Rename and move vcpu_get_perf_capabilities() to pmu.h
  KVM: x86/pmu: Move RDPMC emulation into per-vendor callbacks
  KVM: x86/pmu: Emulate RDPMC on performance metrics
  KVM: selftests: Add PERF_METRICS and fixed counter 3 tests

 arch/x86/include/asm/kvm-x86-pmu-ops.h        |  2 +-
 arch/x86/include/asm/kvm_host.h               |  4 +-
 arch/x86/include/asm/msr-index.h              |  1 +
 arch/x86/include/asm/perf_event.h             |  1 +
 arch/x86/kvm/msrs.c                           | 10 +-
 arch/x86/kvm/pmu.c                            | 37 +++++--
 arch/x86/kvm/pmu.h                            | 16 ++-
 arch/x86/kvm/svm/pmu.c                        | 13 ++-
 arch/x86/kvm/vmx/pmu_intel.c                  | 99 +++++++++++++------
 arch/x86/kvm/vmx/pmu_intel.h                  | 10 +-
 arch/x86/kvm/vmx/vmx.c                        | 15 +--
 arch/x86/kvm/x86.c                            |  4 +
 tools/arch/x86/include/asm/msr-index.h        |  1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |  3 +
 .../selftests/kvm/x86/pmu_counters_test.c     | 72 +++++++++++++-
 15 files changed, 220 insertions(+), 68 deletions(-)

-- 
2.54.0

