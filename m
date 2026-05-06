Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3102773CA;
	Wed,  6 May 2026 01:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032680; cv=none; b=bKJXTVqMbBKeHMk0PnGUURiHDu3sNQ7jXFksIR4cFWndyNpWlBeNpnC0bDr4KQE0Ls4c/AG37AKBUJNkqsy8MGvwSoL1PCVfNBlrA0PaYCp5TucJsEr+IuOwLESl9cGFzbVUqnN+niCLJjJN3RXtrSH0iNk7/QCHPrci44VuBbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032680; c=relaxed/simple;
	bh=yxu6nS9AUYrVkH6s9ve2LiRv7vNRnU+OLzJJBBBh1cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=chdCsAMW9+ch5NyMT2Gc3bEmwflc7LLBXkehQBSM/SPG84RLbwMwou0Ez+UyHDICvSLaCcW9b9N4xHmFxUg0K31P+/PPs006P/O3QK/HvgliQJXRD/RzD/tUHLhdKcx1gqvNlpQp+UFYUzijhofVKADJ43gsi2fFdPaU+1J6/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqPAOm/t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqPAOm/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590CDC2BCB4;
	Wed,  6 May 2026 01:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032679;
	bh=yxu6nS9AUYrVkH6s9ve2LiRv7vNRnU+OLzJJBBBh1cs=;
	h=From:To:Cc:Subject:Date:From;
	b=tqPAOm/tqUnIMplz/eAV21pXnJi0q1G34d/KQv/NioDBV96CRk71rc1YOmPV1ZRKl
	 wrVjUEZe3hKmjdIvvgacv+5WTYYztCDt4D27x9Ym31aSXprjh3vqFhnTATGwAqOcrY
	 SZTr3xLK7YzKbhSFrMJL0kKB9xDukz0CcRiSg7HhU1qRd8jN9S+Q+jvXYPyk/37JdE
	 4gi/GxpLCRHb4rjaMRWXXlZhmtc4kFtpE/Xlr3PSGAKA2wGNc7Rkm7zs/u3QQxtkH6
	 oa+SMIBh187H2GUgFWYZeoMzChnDYqgf0Iq1qejpUzBkDceBrQ9S5kiBG5v4ZK+BGl
	 B8E0yFl+P5e7g==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v6 00/16] 
Date: Wed,  6 May 2026 01:57:16 +0000
Message-ID: <20260506015733.1671124-1-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v6 of Jim and myself's series adding support for AMD's Host-Only and
Guest-Only performance counter eventsel bits in KVM's mediated PMU
passthrough implementation. The series keeps growing in size over
versions. This is Sean's fault (as usual), as he keeps finding subtle
problems and making excellent suggestions.

These bits allow an nSVM-enabled guest to configure performance counters
that count only during L1 execution (Host-Only) or only during L2 execution
(Guest-Only).

KVM updates the hardware event selector ENABLE bit at nested transitions
and EFER.SVME changes such that counters only count in the appropriate
mode.

The series grew significantly after v4, as it now includes semi-related
nSVM fixups and selftests cleanups needed for the series. I think parts
of this series can land independently (patches 1-7 and patches 13-15),
but then the remaining series would depend on both.

v5 -> v6:
- Use a per-counter PMU callback that is called from
  pmc_is_locally_enabled(), rather than a single callback for all
  counters from kvm_pmu_handle_event(). This is mainly to address the
  problem Sashiko found where kvm_pmu_recalc_pmc_emulation() does not
  capture counter disablement due to Host-Only/Guest-Only bits [Sean].
- Move the bitmap tracking counters using Host-Only/Guest-Only bits from
  SVM code to the generic PMU code (and in its own patch), as it's now a
  generic optimization for pmc_is_locally_enabled() that is reused by SVM
  code on nested transitions [Sean].

v4 -> v5:
- Dropped moving leave_guest_mode() and enter_guest_mode() definitions,
  since the calls to update the vPMU no longer happen within these
  functions.
- Add PMU helpers refactoring to facilitate SVM usage.
- Added nested SVM fixups to count VMRUN correctly in guest mode when
  Host-Only/Guest-Only support is enabled [Jim/Sean].
- Update the vPMU synchronously on nested VM-Enter/VM-Exit and EFER.SVME
  changes, such that counter enablement is reevaluated before the
  instructions are counted, as the vPMU counts based on the vCPU state
  at instruction retirement (e.g. using new EFER value when EFER.SVME
  changes) [Jim/Sean].
- Keep deferring vPMU updates using KVM_REQ_PMU in the
  svm_leave_nested() path to avoid KVM potentially consuming stale
  state [Sean].
- Use a single PMU callback for reprogramming counters instead of a
  per-counter callback [Sean].
- Move the bitmap tracking counters into SVM code. The generic vPMU code
  now only exposes an API to reprogram counters, and an SVM wrapper uses
  it on nested transitions [Sean].
- Drop the manual stack-alignment fixes in the vPMU selftest, instead
  rework L2 stack setup in all nested selftests to reuse the allocation
  and alignment logic used by L1, and completely drop L1-provided stacks
  for L2 [Sean].

v5: https://lore.kernel.org/kvm/20260430202750.3924147-1-yosry@kernel.org/
v4: https://lore.kernel.org/kvm/20260326031150.3774017-1-yosry@kernel.org/

Jim Mattson (2):
  KVM: x86/pmu: Allow Host-Only/Guest-Only bits with nSVM and mediated
    PMU
  KVM: selftests: Add svm_pmu_host_guest_test for Host-Only/Guest-Only
    bits

Yosry Ahmed (14):
  KVM: nSVM: Stop leaking single-stepping on VMRUN into L2
  KVM: nSVM: Bail early out of VMRUN emulation if advancing RIP fails
  KVM: nSVM: Move VMRUN instruction retirement after entering guest mode
  KVM: x86: Move enable_pmu/enable_mediated_pmu to pmu.h and pmu.c
  KVM: x86/pmu: Rename reprogram_counters() to clarify usage
  KVM: x86/pmu: Do a single atomic OR when reprogramming counters
  KVM: x86/pmu: Check mediated PMU counter enablement before event
    filters
  KVM: x86/pmu: Add support for KVM_X86_PMU_OP_OPTIONAL_RET0
  KVM: x86/pmu: Disable counters based on Host-Only/Guest-Only bits in
    SVM
  KVM: x86/pmu: Track mediated PMU counters with mode-specific enables
  KVM: x86/pmu: Reprogram Host/Guest-Only counters on nested transitions
  KVM: selftests: Refactor allocating guest stack into a helper
  KVM: selftests: Allocate a dedicated guest page for x86 L2 guest stack
  KVM: selftests: Drop L1-provided stacks for L2 guests on x86

 arch/x86/include/asm/kvm-x86-pmu-ops.h        |   5 +-
 arch/x86/include/asm/kvm_host.h               |   5 +-
 arch/x86/include/asm/perf_event.h             |   2 +
 arch/x86/kvm/pmu.c                            |  21 +-
 arch/x86/kvm/pmu.h                            |  44 +++-
 arch/x86/kvm/svm/nested.c                     |  43 +++-
 arch/x86/kvm/svm/pmu.c                        |  42 ++++
 arch/x86/kvm/svm/svm.c                        |   1 +
 arch/x86/kvm/svm/svm.h                        |  22 ++
 arch/x86/kvm/vmx/pmu_intel.c                  |   2 +-
 arch/x86/kvm/x86.c                            |  17 +-
 arch/x86/kvm/x86.h                            |   3 -
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |   6 +
 .../selftests/kvm/include/x86/processor.h     |   2 +
 .../selftests/kvm/include/x86/svm_util.h      |   5 +-
 tools/testing/selftests/kvm/include/x86/vmx.h |   4 +-
 .../testing/selftests/kvm/lib/x86/memstress.c |  19 +-
 .../testing/selftests/kvm/lib/x86/processor.c |  45 ++--
 tools/testing/selftests/kvm/lib/x86/svm.c     |   6 +-
 tools/testing/selftests/kvm/lib/x86/vmx.c     |   6 +-
 .../selftests/kvm/x86/aperfmperf_test.c       |   9 +-
 .../kvm/x86/evmcs_smm_controls_test.c         |   5 +-
 .../testing/selftests/kvm/x86/hyperv_evmcs.c  |   6 +-
 .../selftests/kvm/x86/hyperv_svm_test.c       |   6 +-
 .../selftests/kvm/x86/kvm_buslock_test.c      |   9 +-
 .../selftests/kvm/x86/nested_close_kvm_test.c |  12 +-
 .../selftests/kvm/x86/nested_dirty_log_test.c |   8 +-
 .../selftests/kvm/x86/nested_emulation_test.c |   4 +-
 .../kvm/x86/nested_exceptions_test.c          |   9 +-
 .../kvm/x86/nested_invalid_cr3_test.c         |  10 +-
 .../kvm/x86/nested_tsc_adjust_test.c          |  10 +-
 .../kvm/x86/nested_tsc_scaling_test.c         |  10 +-
 .../kvm/x86/nested_vmsave_vmload_test.c       |   6 +-
 tools/testing/selftests/kvm/x86/smm_test.c    |   8 +-
 tools/testing/selftests/kvm/x86/state_test.c  |  11 +-
 .../selftests/kvm/x86/svm_int_ctl_test.c      |   5 +-
 .../selftests/kvm/x86/svm_lbr_nested_state.c  |   6 +-
 .../kvm/x86/svm_nested_clear_efer_svme.c      |   7 +-
 .../kvm/x86/svm_nested_shutdown_test.c        |   5 +-
 .../kvm/x86/svm_nested_soft_inject_test.c     |   6 +-
 .../selftests/kvm/x86/svm_nested_vmcb12_gpa.c |  13 +-
 .../kvm/x86/svm_pmu_host_guest_test.c         | 216 ++++++++++++++++++
 .../selftests/kvm/x86/svm_vmcall_test.c       |   5 +-
 .../kvm/x86/triple_fault_event_test.c         |   9 +-
 .../selftests/kvm/x86/vmx_apic_access_test.c  |   5 +-
 .../kvm/x86/vmx_apicv_updates_test.c          |   4 +-
 .../kvm/x86/vmx_invalid_nested_guest_state.c  |   6 +-
 .../kvm/x86/vmx_nested_la57_state_test.c      |   5 +-
 .../kvm/x86/vmx_preemption_timer_test.c       |   5 +-
 50 files changed, 483 insertions(+), 238 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c


base-commit: 85f871f6ba46f20d7fbc0b016b4db648c33220dd
-- 
2.54.0.545.g6539524ca2-goog

