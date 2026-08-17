Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B5F43D50C;
	Mon, 17 Aug 2026 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992087; cv=none; b=Ie5PskaBTWhweaCu+sQo7FXlf2JXVUHpiWj9XEpYG9BF5pNvvJQx/khMWDsUAzK4fw0lhJ7jc6KA1bImYqnzGhZ1memaW0qkjjoUHFvI3flLYCCFbGeC3344Koi8NRBAtD2ANcsE5f3CVw7+qN9mA9Kd/aR+g9Hq8fP4hicFmSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992087; c=relaxed/simple;
	bh=8qJbkfoLPHP/Wk1E1Zpg+T+RmSbzacYlPpsslMuRQD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lJiICGSvap4dVMJoa2xtQOD//wu7f5gnyb04c0ZrBqDqj+QNINnHHeio9j44Fx4cFzIREYBdsN/9IVVwyQ1f0zJXjm9OJO+03oNsxPdITAXos7S5wDmlhAKTOKnFLtoK2SZVOaw17BwTiKfoUYGigIwardjBJ6RAoYC4yPTD/Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rh7Ab3ni; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rh7Ab3ni"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786992086; x=1818528086;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8qJbkfoLPHP/Wk1E1Zpg+T+RmSbzacYlPpsslMuRQD0=;
  b=Rh7Ab3nij9L3McBQJ6W6HVinifpggVKH4IM5r6cKnwQvks/smFtAaOEz
   kJyojX8B22lmhPyiCT2agMWYS1noB5IxzO3sE2FW7sE26oLX4eWiqvbZZ
   MXYCIXALuwGwhyofuc7SQbGkr4K7Ky7spoae+uvdApsrGfR5VHz+P50JD
   7TLzpmtKH5kGwfX19XdQkSxh3huZVOwZSnCcziWRJk0piQ3j61wQX3Smo
   w8T7G3NrS0R1xOpPTj928Y+Ddj+SXZ1Ug37jcLdr0gJ3gBUGy2nv/OKIG
   84rb9FW6eIpoqIfKvsyVKomStvcMbC4Bqr2aygdKJDh7EzCgB+7rLgit3
   g==;
X-CSE-ConnectionGUID: CeI5e9OeQnGhvEvLEjki3A==
X-CSE-MsgGUID: ojs6rEI+Q1mI3Q8ctfmlNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98066072"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="98066072"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 11:41:25 -0700
X-CSE-ConnectionGUID: dhsP+sYUSXyUMhJecdmuvg==
X-CSE-MsgGUID: 13LYstuXRsaCUvWf6CHVAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="263656954"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 11:41:24 -0700
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
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v8 0/8] KVM: x86/pmu: Add hardware Topdown metrics support
Date: Mon, 17 Aug 2026 11:31:34 -0700
Message-ID: <20260817183143.226156-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Topdown Microarchitecture Analysis (TMA) method is a structured
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

Tested on a Sapphire Rapids. Without this series, only raw topdown.*_slots
events work in the guest, and metric events (e.g. cpu/topdown-bad-spec/) are
not available.

With this series, metric events are visible in the guest.  Run this
command on both host and guest:

$ perf stat --topdown --no-metric-only -- taskset -c 2 perf bench sched messaging

Host results:

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

Rebased to kvm-x86/next: 1b731e5ded480bd1

v8 changes:
- patch 5/8: Intercept global ctrl MSR if host supports PerfMetrics but
  not enabled in the guest.
- patch 3/9: Remove include "cpuid.h" from pmu_intel.h.
- Drop patch v7 7/9 to audit CPU RDPMC encodings.
v7 changes:
- Add "reviewed-by" tags.
- patch 5/8: Optimize bit 48 handling in global_status_rsvd;
  document the PERF_METRICS/FC3 write-order exception;
  add nested_vmx_merge_msr_bitmaps_rw().
- patch 7/9: new patch to restrict RDPMC passthrough to known CPUs.
- patch 9/9: Use RDPMC instead of RDMSR in PERF_METRICS sanity test.
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

v7: https://lore.kernel.org/kvm/20260727192131.582105-1-zide.chen@intel.com/
v6: https://lore.kernel.org/kvm/20260629231938.15129-1-zide.chen@intel.com/T/#t
v5: https://lore.kernel.org/kvm/20260625034555.141453-1-zide.chen@intel.com/
v4: https://lore.kernel.org/kvm/20260623041927.178256-1-zide.chen@intel.com/
v3: https://lore.kernel.org/kvm/20260615230118.50718-1-zide.chen@intel.com/T/#t
v2: https://lore.kernel.org/kvm/20260423174639.56149-1-zide.chen@intel.com/T/#u
v1: https://lore.kernel.org/kvm/20260226230606.146532-1-zide.chen@intel.com/T/#t
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
 arch/x86/kvm/msrs.c                           | 10 +-
 arch/x86/kvm/pmu.c                            | 36 +++++--
 arch/x86/kvm/pmu.h                            | 17 +++-
 arch/x86/kvm/svm/pmu.c                        | 13 ++-
 arch/x86/kvm/vmx/nested.c                     |  2 +
 arch/x86/kvm/vmx/pmu_intel.c                  | 93 ++++++++++++++-----
 arch/x86/kvm/vmx/pmu_intel.h                  | 12 +--
 arch/x86/kvm/vmx/vmx.c                        | 15 +--
 arch/x86/kvm/x86.c                            |  4 +
 tools/arch/x86/include/asm/msr-index.h        |  1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |  3 +
 .../selftests/kvm/x86/pmu_counters_test.c     | 90 +++++++++++++++++-
 15 files changed, 239 insertions(+), 64 deletions(-)

-- 
2.55.0

