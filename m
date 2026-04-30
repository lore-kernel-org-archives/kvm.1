Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7AA3A5439;
	Thu, 30 Apr 2026 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580879; cv=none; b=tl1DK/8Qnjncv3aG0er6giY5drC8Otyfb0Jo1DqxPDJrUdx3Ra2ZErnRPVNSrl+MWnEZAl8bWVmpYTYLPmR6kLfnhDymG6GjLEBncc05BFuz0CaGZ41bYpSkVoWqOkPyZTuC6rSzBUoL9pHITStUUlF/zn/QgeCGX6BSeCadD8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580879; c=relaxed/simple;
	bh=hEWN4DEjj6+rNoXobuwRsoCxULeupgoiPwSbDK9HxzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iiMNlxIzwHL0Jz+LI5xtelLnrEie4foTyL6vdLN7TotwbG9ALCv0ljIVaNzwW2PgWx/AQ6sdr/WKjnB8NSjoSr1bp2Bfja3y9EqKrIceMIdJ93bDtG+T4T/g1NQCr6WfLl19eHlUEI3e125v7c1wPHaoApokoOm1YrHL3AEh1oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dc/zG+R9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc/zG+R9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D529C2BCB3;
	Thu, 30 Apr 2026 20:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777580879;
	bh=hEWN4DEjj6+rNoXobuwRsoCxULeupgoiPwSbDK9HxzE=;
	h=From:To:Cc:Subject:Date:From;
	b=Dc/zG+R9/OQQmKoQj35sbc8AmYFYvP2kTaQnZnDqRgTqaCkP1AOo1EWNHsFBtkYUA
	 fQt81C/sqrTRBYDL6ojCH4LWArZNWv6WLzST25HTtQpOd96r2LjXLJbi1m8P/Hniy5
	 mM8by8s/6+MI6MDjcniDrEJOjIW1aibwjjHxyYwsJ+WEu7RlogGBZoOemy1uxGTUpW
	 pPdcstoRGvVIqqPRabcmicMeaxOKQvE1HWNkyfdZBoK6m9hyEC87dodgzOoxwWlMqH
	 QRIcb3/v9H4Yi3tWWI5/lYAbhROupRJ0PUymLgvXoMPaAfZR3NrI0Kcz4rn60um4qj
	 +D5yTapimEpyA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v5 00/13] KVM: x86/pmu: Add support for AMD Host-Only/Guest-Only bits
Date: Thu, 30 Apr 2026 20:27:37 +0000
Message-ID: <20260430202750.3924147-1-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v5 of Jim and myself's series adding support for AMD's Host-Only and
Guest-Only performance counter eventsel bits in KVM's mediated PMU
passthrough implementation.

These bits allow an nSVM-enabled guest to configure performance counters
that count only during L1 execution (Host-Only) or only during L2 execution
(Guest-Only).

KVM updates the hardware event selector ENABLE bit at nested transitions
and EFER.SVME changes such that counters only count in the appropriate
mode.

The series grew significantly since v4, as it now includes semi-related
nSVM fixups and selftests cleanups needed for the series. I think parts
of this series can land independently (patches 1-6 and patches 10-12),
but then the remaining series would depend on both.

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

Jim Mattson (2):
  KVM: x86/pmu: Allow Host-Only/Guest-Only bits with nSVM and mediated
    PMU
  KVM: selftests: Add svm_pmu_host_guest_test for Host-Only/Guest-Only
    bits

Yosry Ahmed (11):
  KVM: nSVM: Stop leaking single-stepping on VMRUN into L2
  KVM: nSVM: Bail early out of VMRUN emulation if advancing RIP fails
  KVM: nSVM: Move VMRUN instruction retirement after entering guest mode
  KVM: x86: Move enable_pmu/enable_mediated_pmu to pmu.h and pmu.c
  KVM: x86/pmu: Rename reprogram_counters() to clarify usage
  KVM: x86/pmu: Do a single atomic OR when reprogramming counters
  KVM: x86/pmu: Disable counters based on Host-Only/Guest-Only bits in
    SVM
  KVM: x86/pmu: Reprogram Host/Guest-Only counters on nested transitions
  KVM: selftests: Refactor allocating guest stack into a helper
  KVM: selftests: Allocate a dedicated guest page for x86 L2 guest stack
  KVM: selftests: Drop L1-provided stacks for L2 guests on x86

 arch/x86/include/asm/kvm-x86-pmu-ops.h        |   1 +
 arch/x86/include/asm/kvm_host.h               |   2 +
 arch/x86/include/asm/perf_event.h             |   2 +
 arch/x86/kvm/pmu.c                            |  19 +-
 arch/x86/kvm/pmu.h                            |  28 ++-
 arch/x86/kvm/svm/nested.c                     |  43 +++-
 arch/x86/kvm/svm/pmu.c                        |  53 +++++
 arch/x86/kvm/svm/svm.c                        |   2 +
 arch/x86/kvm/svm/svm.h                        |  33 +++
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
 50 files changed, 484 insertions(+), 235 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c


base-commit: 85f871f6ba46f20d7fbc0b016b4db648c33220dd
-- 
2.54.0.545.g6539524ca2-goog

