Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCB13D5668;
	Mon, 27 Jul 2026 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180725; cv=none; b=lTp/1w/Vyy7tbqGfnvcxcvyYQujgtpVQkUIpA1j1TsaE3PZ0OvFZXF9nzCKUaEWtc69fQAAaR+k0qvgBiKJfF9DmBaLpzuhs5MoKvQzf3wQsKPV34l23eMPKmiWOtn8AXPrZ8o+eaJZmrZ3l1WYC0x/SmItITlLiU+sv/Z2Nq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180725; c=relaxed/simple;
	bh=H0f6/OmfD7FyG6JYJhJO1thjwC3lQRaotZQ/qJE6RG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GvPdLksHo3Spi5PhLYuLZK0cNMslpcvJg4yXKoT76ziS9caSG/0FosZL/zEdsAO6RaPgubuJYYLiEdL+sr2bMTrrCvfbxeb1ev6FTjWJO5pmLt4b36Ebx0W+5h4Vb5zg7Z7Haaj7sQk7k/ip9b5WC5/AgjfCJS5YIs6oQL9lkTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayzoIHc9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayzoIHc9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785180722; x=1816716722;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H0f6/OmfD7FyG6JYJhJO1thjwC3lQRaotZQ/qJE6RG4=;
  b=ayzoIHc9hfQThw+EFhTM9LYpceRDPxo8S3GlOK7BkUUNWjq8sZchcvWv
   E3+HGX90tksp4gb0HszIzFd6gonAoTv/un/TWVVOc7yZXq+MVjeH34DUF
   +w0CRe7tNQHlwrT1GtxT3oabEQL1OsAopEm+3betby8VrJjBEbJqn1vqw
   dCM51AJhFEP6Nd//N/+qeALDF7FEoH56LiSWsXJSwJSZgZIEDQZvPwx75
   qdUU18t4H+EHpISeMEaHdcaC0nhcRdM3UzDw6oAb5KiGwKZNbN81q5Vte
   4M4/rJYpq/VdpXwgBOWkP776g7dCWWkLH3FD8izCddF/4hIsdET7BZRXM
   w==;
X-CSE-ConnectionGUID: MRbdKg1GTCSIMYDd7VCXtQ==
X-CSE-MsgGUID: M57dEoSdSomg6Hq7qgc+GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85876686"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="85876686"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 12:31:59 -0700
X-CSE-ConnectionGUID: WlHhoPPVQY2ObqhISynWLg==
X-CSE-MsgGUID: qHMN0+0iRu+q4hG4uVxReQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="289451025"
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
Subject: [PATCH v7 0/9] KVM: x86/pmu: Add hardware Topdown metrics support
Date: Mon, 27 Jul 2026 12:21:22 -0700
Message-ID: <20260727192131.582105-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
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

Rebased to kvm-x86/next: 567329869b9c

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

Zide Chen (6):
  KVM: x86/pmu: Do not map fixed counters >= 3 to generic perf events
  KVM: x86/pmu: Rename and move vcpu_get_perf_capabilities() to pmu.h
  KVM: x86/pmu: Move RDPMC emulation into per-vendor callbacks
  KVM: x86/pmu: Restrict RDPMC passthrough to known CPUs
  KVM: x86/pmu: Emulate RDPMC on performance metrics
  KVM: selftests: Add PERF_METRICS and fixed counter 3 tests

 arch/x86/include/asm/kvm-x86-pmu-ops.h        |  2 +-
 arch/x86/include/asm/kvm_host.h               |  4 +-
 arch/x86/include/asm/msr-index.h              |  1 +
 arch/x86/kvm/msrs.c                           | 10 +-
 arch/x86/kvm/pmu.c                            | 71 ++++++++++++--
 arch/x86/kvm/pmu.h                            | 17 +++-
 arch/x86/kvm/svm/pmu.c                        | 13 ++-
 arch/x86/kvm/vmx/nested.c                     |  2 +
 arch/x86/kvm/vmx/pmu_intel.c                  | 93 +++++++++++++-----
 arch/x86/kvm/vmx/pmu_intel.h                  | 10 +-
 arch/x86/kvm/vmx/vmx.c                        | 15 +--
 arch/x86/kvm/x86.c                            |  4 +
 tools/arch/x86/include/asm/msr-index.h        |  1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |  3 +
 .../selftests/kvm/x86/pmu_counters_test.c     | 94 ++++++++++++++++++-
 15 files changed, 278 insertions(+), 62 deletions(-)

-- 
2.54.0

