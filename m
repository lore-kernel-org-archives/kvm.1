Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B90823392F;
	Thu, 25 Jun 2026 03:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782359697; cv=none; b=NdNEnDdbcL6chbVNFEmLh4vS98bWjRHf+Z6aHUtT2vkfFaEJcxEs9Ewfgdapgc5ORgqDh6sYGh825uaaSK4AuSiafvip8cIwLvLZ/u4Ts3864WHw4uOlhuhxH+JqnBxJuvnx6voc4tp1SyKEvtOxl7pAr2LebqAZ3lv5Y1lpOgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782359697; c=relaxed/simple;
	bh=QeO7r8xs5bjpGokPQ3hjrONxXXyTcU3Wj2GfohxKmkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jwkEvQdOheHrvANuQcbFzpIkaEWZWZQcfuhbcUEdzS+WJ9oI49EOF/mkaHwVJFUvN0jIgshPj4v90vna82/g4tRzoOArk4gTzin5mhckhs9YxhYlHoXdd4PrsblDy/qB2Jrwr81euuoeA4Kh0jqYyzRDhOfS4wropH8+h4d3aHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jknO+aOQ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jknO+aOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782359696; x=1813895696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QeO7r8xs5bjpGokPQ3hjrONxXXyTcU3Wj2GfohxKmkE=;
  b=jknO+aOQfxFztkB1eKBBfniMyBGd294gn55MKDaoQ2JlsPYMS0Aqonsm
   K7sxYxU9y7Roa8/4EAgYSICNf6085OejOf+1CbkJJyic8TTn/x8x4kZtu
   MwlQafuaSJW9/MJmymZzUx/q9DRK+TlXKWEw0FqkVJR/4BtTkaIQ8+4OQ
   YoS1JAB4dm+TmFgIkgNUOhkSKS3Q0uDXdd84rSEx9nn4urqeSN9/VoMA6
   AuKTTCqLn0OJPI3zw4XhB0bmUewRzGFYRai1Tsq5d+saG1KOEApK0dH6s
   3C6ArsXTPOI8rijqAwCtiOnb4EKdBRObrbm9106yXLnuLxHWTmE6fNcxS
   w==;
X-CSE-ConnectionGUID: UvVWc70uTliTD98WC2BJWg==
X-CSE-MsgGUID: /OIhqVIzTi65yCECRrTHXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82901449"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="82901449"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 20:54:53 -0700
X-CSE-ConnectionGUID: Vg8RAreIRNGQhMwX00YInw==
X-CSE-MsgGUID: tfqWWXBSTXSnox2AAwNcTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="288396612"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 20:54:52 -0700
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
Subject: [PATCH V5 0/7] KVM: x86/pmu: Add hardware Topdown metrics support
Date: Wed, 24 Jun 2026 20:45:48 -0700
Message-ID: <20260625034555.141453-1-zide.chen@intel.com>
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

Rebased to kvm-x86/next: 9d4853b044be

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

v4:
https://lore.kernel.org/kvm/20260623041927.178256-1-zide.chen@intel.com/
QEMU:
https://lore.kernel.org/qemu-devel/20260604025546.19378-7-zide.chen@intel.com/

Dapeng Mi (2):
  KVM: x86/pmu: Support Intel fixed counter 3 on mediated vPMU
  KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU

Mingwei Zhang (1):
  KVM: x86/pmu: Snapshot host IA32_PERF_CAPABILITIES in kvm_host

Zide Chen (4):
  KVM: x86/pmu: Do not map fixed counters >= 3 to generic perf events
  KVM: x86/pmu: Rename and move vcpu_get_perf_capabilities() to pmu.h
  KVM: x86/pmu: Emulate RDPMC on performance metrics
  KVM: selftests: Add perf_metrics and fixed counter 3 tests

 arch/x86/include/asm/kvm_host.h               |  3 +-
 arch/x86/include/asm/msr-index.h              |  1 +
 arch/x86/include/asm/perf_event.h             |  1 +
 arch/x86/kvm/pmu.c                            | 50 +++++++++++--
 arch/x86/kvm/pmu.h                            | 13 ++++
 arch/x86/kvm/vmx/pmu_intel.c                  | 61 ++++++++++++----
 arch/x86/kvm/vmx/pmu_intel.h                  | 10 +--
 arch/x86/kvm/vmx/vmx.c                        | 15 ++--
 arch/x86/kvm/x86.c                            | 14 +++-
 arch/x86/kvm/x86.h                            |  1 +
 tools/arch/x86/include/asm/msr-index.h        |  1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |  3 +
 .../selftests/kvm/x86/pmu_counters_test.c     | 72 +++++++++++++++++--
 13 files changed, 201 insertions(+), 44 deletions(-)

-- 
2.54.0

