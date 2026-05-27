Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6A2330337;
	Wed, 27 May 2026 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925640; cv=none; b=GiSUyw9imqcLakFqhwnDsGYm2shgBIn6bCPN2WKoPs2mb7h1EPjDFuHp4D8ltXHG/yHr50YXICpV3dS2WyQyTo2/8et7d1kTztWFHa0v1v3FjGEh184Gu28uo9gfs+qvtxqY/saa+4QA8zUKh6VSpSSfTL+YNFZHKZTILfdS+eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925640; c=relaxed/simple;
	bh=nwCMNKVZeR868aL7gSVcNWCpcSNuQ6idRav/hCqkUb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q9IryAb+9Ib4CZHLqWK6Y2T0yZ991faaSzjXJ0Dud2xjkAO5m7fvOIn2f9YH2FsmirhU2XjKeRYGBul+eREfiGYv4RyTFZkCUfNWp3q/l8QpxpNUGG7IDaWoRBUjXvxyh7JdvleIn97kCR3XPN+ViSFh8EWjSjaRX+LEiFiMWIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkziNZGa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkziNZGa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288231F000E9;
	Wed, 27 May 2026 23:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779925638;
	bh=lnfmKchHrBbtPtoBQu/oo/EL2ocExeDcRfCFNAlwDzY=;
	h=From:To:Cc:Subject:Date;
	b=NkziNZGamDIg4NYVDjfJAEqSuUnYDWSAzXiduM7CCfNViO3NJznWtzKEZR5/8SXqc
	 9fZxCo0guLBkIalLx9cqGZKmWinsWrftLNttw7eKLHDm5bgx+bxu1pJvWpMTv3KOuq
	 q3ImG53uQ4+jeBEYGO5O4Wc4NCcS0uzERPQjtI+igBMGpIrvS/isG1FlRs1ULUgJsb
	 FO7Nr/5joh7fjH6+X4U7MJ0kiOqGNPg5lGeypzP89DCus5Ovy+zkMK8NpfKm+qp8Ug
	 udIdUM+RGiPZxmH9pqa/ybBF/6oLN/LeZ68/a4HauOgiG87P8sQhSzltl1/uPffyAH
	 p/U/Im5ua1Oag==
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
Subject: [PATCH v7 00/17] KVM: x86/pmu: Add support for AMD Host-Only/Guest-Only bits
Date: Wed, 27 May 2026 23:46:54 +0000
Message-ID: <20260527234711.4175166-1-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v7 of Jim and myself's series adding support for AMD's Host-Only and
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
of this series can land independently (patches 1-8 and patches 14-16),
but then the remaining series would depend on both.

v6 -> v7:
- Instead of creating __kvm_skip_emulated_instruction(), call
  svm_skip_emulated_instruction() directly when emulating VMRUN [Sean].
- Split bailing early on failed VMRUN into two patches, one for the
  actual fix (patch 2) and one for the code cleanup (patch 3).
- Add a Fixes tag for patch 3.
- Indentation fixes and changelog updates.

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

v6: https://lore.kernel.org/kvm/20260506015733.1671124-1-yosry@kernel.org/
v5: https://lore.kernel.org/kvm/20260430202750.3924147-1-yosry@kernel.org/
v4: https://lore.kernel.org/kvm/20260326031150.3774017-1-yosry@kernel.org/


Jim Mattson (2):
  KVM: x86/pmu: Allow Host-Only/Guest-Only bits with nSVM and mediated
    PMU
  KVM: selftests: Add svm_pmu_host_guest_test for Host-Only/Guest-Only
    bits

Yosry Ahmed (15):
  KVM: nSVM: Stop leaking single-stepping on VMRUN into L2
  KVM: nSVM: Bail early out of VMRUN emulation if advancing RIP fails
  KVM: nSVM: Unify RIP and PMU handling calls when emulating VMRUN
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
 arch/x86/include/asm/kvm_host.h               |   3 +-
 arch/x86/include/asm/perf_event.h             |   2 +
 arch/x86/kvm/pmu.c                            |  21 +-
 arch/x86/kvm/pmu.h                            |  44 +++-
 arch/x86/kvm/svm/nested.c                     |  43 +++-
 arch/x86/kvm/svm/pmu.c                        |  42 ++++
 arch/x86/kvm/svm/svm.c                        |   3 +-
 arch/x86/kvm/svm/svm.h                        |  24 ++
 arch/x86/kvm/vmx/pmu_intel.c                  |   2 +-
 arch/x86/kvm/x86.c                            |   9 -
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
 .../selftests/kvm/x86/nested_tdp_fault_test.c |   9 +-
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
 51 files changed, 479 insertions(+), 245 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c


base-commit: 9f2a49c511cb05b85745e1578e4fd425bff87f58
-- 
2.54.0.794.g4f17f83d09-goog

