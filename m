Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557204;
	b=YDtzHa99AmO7IdZbiFD7t+MYSQpf49afX/9iCbSiGcpHmVP2QTUSOX2rvOVly47n9j9t
	 tEn1fWiBRwsIxU6JGlNHF/MQwGCVa5OW52c8jRy3YCrR48+SsyeumfIO2yCCGkw1r4r6K
	 Xe/KoIcnkjQgfT+B2HXHYSDvORTRl+MeaqbVT3wXAo5j7nfn6DGj5ZI26e3oTcUJFh4x6
	 M5VNkwSrUNz2nCmIrknpy3avgZwVL8ky3aQ9CEZ4aE0xyawu2/ynJ7UPjynYf199DeqdY
	 ZdgKzyUaEQzcCq/NNo4VF4Ax47LosGXwZp8gVfMaXhKujNRiiJ3IgKnDf9S1mhfaMNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557204;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=s4KO4ShEkRM27eT1BnoGTuu5UEFD3sYPPNxzfYRauso=;
	b=1oRmm2AEqS/hSYc33sjBr3MAaR44p56H2SneiUkkh7btjRD1RUh/6rjfN7AKBOAaNznN
	 mhUtrV5TKdCCpNzrMI6u5vsc8s8fLV8nYJSnJKjLSJt2i8dB2zUoioGZwG6DsC81WyjuA
	 yTeuiI7u3CuWVhag66dC1rHRGwLoMgobm7FIiysF03nc2OGzdmMKN27Y6q5XNN9OlcIvg
	 hQRDDb0JxzHbHQfDS+jka+kuYeHNRd3v/8qovPT1cLzzrMJ6ufZwCXSKhI6nAMEIFrGNW
	 5xE3O/A2plwal/kCwiwUsCnxUjYbAgvbRqgHF+qyyPJIrhNUcJHA4OlySUFOXUDvxXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hVuNHmpi;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD67606A332;
	Tue, 24 Nov 2026 21:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FD67606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hVuNHmpi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557202; x=1827093202;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kf+ZXGgPPvoA4Fn3IiUFVfGm2RNG8r+Vv1k50Mx8NRA=;
  b=hVuNHmpi/aSJpSz3L/GcAAdys7c3+ajdeKXe21DU+0SRvtYt/oOPzx6L
   wLf/qurhLJmEyZAGGINbrRlginJh1EdNUWTxP8qeOUe9g7jQuNGcwIEAU
   Z6RGUIKU+P15ODNEPx1UKfSLi1UR7fIJ1Ofy+EWdBP1UY70GUbQ+ZF9mo
   lq+RMMMS7AoHpvwueUXx6fr56JdRmuox6fBIcuEslZtJG+hRARVzOeTqX
   Y/XWGAFtgnCqBpC/HhfJPwbgFRNvvQWMUwIJfKh2DD6zGIGGmGF5bi91t
   zXjpekRe1RXDp9/fLLBdQQ7RSIhbCD8yr4+1CGKqxQWK12kCWzgkkrEWa
   A==;
X-CSE-ConnectionGUID: ngDaINv7Qw2FFUIWlK9J5g==
X-CSE-MsgGUID: E2lnWTz1SS2XRI65d5tvlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4305966"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4305966"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:22 -0800
X-CSE-ConnectionGUID: Jyd457QnQSqmBhNzVMB9Pw==
X-CSE-MsgGUID: sgOuQxsoSjaU7tuJT2zjhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271884"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:21 -0800
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
Subject: [PATCH v10 00/18] KVM: x86/pmu: Add hardware Topdown metrics support
Date: Tue, 24 Nov 2026 14:38:43 -0700
Message-ID: <20261124213901.120572-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
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

Activation of the PERF_METRICS feature in hardware requires both
PERF_METRICS_AVAILABLE and the existence of fixed counter 3. However,
the presence of the IA32_PERF_METRICS MSR is architecturally decoupled
from it.

This version enforces the following dependencies between PERF_METRICS
and fixed counter 3 to comply with the SDM:

- Advertise PERF_METRICS and RDPMC_METRICS_CLEAR only when mediated vPMU
  is enabled and host perf reports num_topdown_events != 0.

  Gate on host Topdown events in addition to host fixed counter 3 so
  that this feature is advertised on known CPU models only.

- Gate IA32_PERF_METRICS and RDPMC existence solely on guest
  PERF_CAP_PERF_METRICS (per SDM Vol 4 Table 2-2). Without guest fixed
  counter 3, neither RDMSR nor RDPMC faults (#GP): all metric fields are
  reserved (~0ull), reads (RDMSR and RDPMC) succeed and return 0, writing
  0 succeeds, and only non-zero writes #GP.

  With fixed counter 3, valid metric fields are unmasked based on
  host-provided num_topdown_events.

- Gate IA32_PERF_METRICS, GLOBAL_CTRL, and RDPMC passthrough (and
  hardware context switching) on having both guest PERF_METRICS and fixed
  counter 3. If either is missing, metrics cannot count in hardware;
  accesses remain intercepted and handled cleanly in KVM software
  (e.g., emulated RDPMC succeeds and returns 0).

- Allow setting GLOBAL_CTRL[48] whenever PERF_METRICS is present on
  the guest, because the SDM defines bit 48 as an architectural control
  bit (not reserved) when PERF_METRICS is supported, even if fixed counter
  3 is absent.

- Require guest fixed counter 3 to unmask FIXED_CTR_CTRL[14]
  (METRICS_CLEAR_EN), as bit 14 resides in fixed counter 3's control nibble.
  Without fixed counter 3, bit 14 remains reserved; when enabled with
  fixed counter 3, RDPMC of metrics clears both PERF_METRICS and fixed
  counter 3 in hardware and emulation.

Notes:

A. If the mediated vPMU PMU v5 series [1] lands first:
- Patch 9 ("Mask only OS/USR bits when filtering fixed counters") is
  already included in the PMU v5 series and should be dropped from here.
- In patch 11, the contiguous fixed counter clamp in
  kvm_init_pmu_capability() can be removed, as PMU v5 supports bitmasks.
- The fixed counter 3 checks across the series will be updated to use
  the new PMU v5 helper:
    kvm_is_fixed_pmc_supported(pmu, KVM_FIXED_SLOTS_IDX)

B. Patch 3 only fixes perf_capabilities in the base PMU. Broader base PMU
setup on hybrid hardware running with a single core type (e.g., P/E-core only
SKUs or firmware configs) is orthogonal and left for separate patches.

Patch series summary:
patch 1-5: Prerequisites in host perf
patch 6-9: KVM preparations
patch 10-15: Intel Topdown feature virtualization
patch 16-18: Topdown PERF_METRICS selftests.

Tests: Tested Topdown metrics on ICX (4 metrics), and SPR (8
metrics). Tested RDPMC Metrics Clear on DMR. Tested nested.

Rebased on kvm-x86/next: commit 6bd2905303c5 ("Merge branch 'vmx'")

v10:
- Implement the above dependency policies to comply with the SDM.
- Re-order, consolidation, and new patches:
  * patch 2: do not inflate capabilities under hypervisors.
  * patch 3: refine broken perf capabilities handling in host perf.
  * patch 4: export perf_capabilities from host perf to KVM.
  * patch 7: use host-reported perf_capabilities in VMX instead of rdmsrq().
  * patch 9: move fixed counter filter mask fix into preparation group. (Dapeng)
  * patch 10: intercept unexposed PERF_METRICS before fixed counter 3
    (patch 11) to avoid premature hardware passthrough.
  * Re-order RDPMC emulation (patches 12-13) before PERF_METRICS MSR support
    (patch 14) to eliminate a bisection gap before advertising the capability.
  * Fold v9 patch 11 (reserved bit validation) into patch 14. (Jim)
- Selftests:
  * Moved Topdown metrics tests to a separate test file to avoid bloating
    pmu_counters_test.c.
  * Added coverage for RDPMC Metrics Clear Mode, host MSR access, and
    capability permutations.

v9:
- Reject writes to reserved MSR_PERF_METRICS bits (bits [63:32]).
- Support RDPMC Metrics Clear Mode.
- perf/x86: Add INTEL_TD_METRIC_FIELD_{BITS,MASK} constants.
- perf/x86: Expose number of Topdown metric events to KVM.
- Remove the incorrect comment about writing to PERF_METRICS.
- Remove references to Metrics Clear from the changelog of patch 7.

v9: https://lore.kernel.org/kvm/20260918193937.569414-1-zide.chen@intel.com/
v8: https://lore.kernel.org/kvm/20260817183143.226156-1-zide.chen@intel.com/
QEMU: https://lore.kernel.org/qemu-devel/20260604025546.19378-7-zide.chen@intel.com/

[1] https://lore.kernel.org/kvm/20261112203227.289379-1-zide.chen@intel.com/

Dapeng Mi (2):
  KVM: x86/pmu: Support Intel fixed counter 3 on mediated vPMU
  KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU

Zide Chen (16):
  perf/x86: Add INTEL_TD_METRIC_FIELD_{BITS,MASK} constants
  perf/x86/intel: Do not inflate capabilities for guests
  perf/x86/intel: Track common hybrid capabilities
  perf/x86: Expose perf_capabilities to KVM
  perf/x86: Expose number of Topdown metric events to KVM
  KVM: x86/pmu: Do not map fixed counters >= 3 to generic perf events
  KVM: x86/pmu: Query perf-reported capabilities instead of RDMSR
  KVM: x86/pmu: Rename and move vcpu_get_perf_capabilities() to pmu.h
  KVM: x86/pmu: Mask only OS/USR bits when filtering fixed counters
  KVM: x86/pmu: Block PMU passthrough if guest lacks PERF_METRICS
  KVM: x86/pmu: Move RDPMC emulation into per-vendor callbacks
  KVM: x86/pmu: Emulate RDPMC on performance metrics
  KVM: x86/pmu: Support RDPMC Metrics Clear Mode
  KVM: selftests: Rework PMU guest measurement asm operands
  KVM: selftests: Move and generalize PMU guest measurement helpers
  KVM: selftests: Add Topdown PERF_METRICS test

 arch/x86/events/core.c                        |   3 +
 arch/x86/events/intel/core.c                  |  39 +-
 arch/x86/include/asm/kvm-x86-pmu-ops.h        |   2 +-
 arch/x86/include/asm/kvm_host.h               |   4 +-
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/include/asm/perf_event.h             |   6 +
 arch/x86/kvm/msrs.c                           |  10 +-
 arch/x86/kvm/pmu.c                            |  60 ++-
 arch/x86/kvm/pmu.h                            |  33 +-
 arch/x86/kvm/svm/pmu.c                        |  14 +-
 arch/x86/kvm/vmx/nested.c                     |   2 +
 arch/x86/kvm/vmx/pmu_intel.c                  | 159 +++++--
 arch/x86/kvm/vmx/pmu_intel.h                  |  12 +-
 arch/x86/kvm/vmx/vmx.c                        |  21 +-
 tools/arch/x86/include/asm/msr-index.h        |   2 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |  60 +++
 .../selftests/kvm/x86/pmu_counters_test.c     |  52 +--
 .../selftests/kvm/x86/pmu_perf_metrics_test.c | 391 ++++++++++++++++++
 19 files changed, 741 insertions(+), 132 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/pmu_perf_metrics_test.c

--
2.56.1

