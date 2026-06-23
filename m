Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A83A7F57;
	Tue, 23 Jun 2026 04:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782188933; cv=none; b=oFz2Y9mW94EC5lDyDP3FRQ1jqOS0osGJ5D0i5eohVFtnxacXx0SboT9WSgfW33Ml7F8JSjW9ryUJWu3f5527EPzbqBJhCqT7cGehAEbR0CiTfTyMXQzFJ1tGK3weVN14JQhNrDJEfVT8XZpF0Onzz0K7OkPrr37iMXH0uqo9z7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782188933; c=relaxed/simple;
	bh=M34x0ctZL0JZEEUW8slG6H2T3ex9xx7TvbTVWEg/TOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nbsJbWkfx61LbRZT7+AMQOs66YEt/SYH0IaAtWZF1EUvHCPqhOmkzVreoFZt554JRyzOhdsD1IF2OvLOKIEpSP8tn5dZ1IXN5Z8y7Fo3TGn0vPF7/W3D3t/VZR/fzLqWyw90Cb+n2D/FBRPJHO4snJmglkMmplO+JbYhzXWG4GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gf1c/1i6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gf1c/1i6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782188932; x=1813724932;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M34x0ctZL0JZEEUW8slG6H2T3ex9xx7TvbTVWEg/TOE=;
  b=Gf1c/1i6NgrpL37PHHZFsrzPnDFGWT7Wf7enkgeN4QD1Mvxeo4KxlTjd
   Z4gFI13qx6b498smX55ZmZPNE72Z6WqxVzABQhf20JqlJYt9tbHmzKG6k
   vYC80wx4zt/RObMR9tFsX7bLzeK4WT95YlGRrHJBNCALk7Q4hChwRaBVv
   KV3d9IDfQE84tF1G8EqPthUZhqJzzkSz559GzUlTv4pRfgxxYHZUG4oPz
   iBBbO8gFFLtiMG5HLW/o1jfe9b/eddP5XPWvbJFZqT2RXLOpzeCXxZaMJ
   NStQo3yRq3hae0CCzOXncX0qML3UihwDc4ysACMM8LyUxHr2NzkTvTdm8
   A==;
X-CSE-ConnectionGUID: h3Lyfl2pQQ+N5hc5QD5mUw==
X-CSE-MsgGUID: zOh1rx/CR4qhDyq/7LHNwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82809039"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82809039"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 21:28:49 -0700
X-CSE-ConnectionGUID: ALtrZhOXTCKqDRJEBCuO9A==
X-CSE-MsgGUID: hib72e+bR0SOMIM3QTe7Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="279587560"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 21:28:50 -0700
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
Subject: [PATCH V4 0/4] KVM: x86/pmu: Add hardware Topdown metrics support
Date: Mon, 22 Jun 2026 21:19:23 -0700
Message-ID: <20260623041927.178256-1-zide.chen@intel.com>
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

Rebased to kvm-x86/next: c1f730330292

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

v3:
https://lore.kernel.org/kvm/20260615230118.50718-1-zide.chen@intel.com/T/#t
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

