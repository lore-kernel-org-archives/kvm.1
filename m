Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E943803F9;
	Thu, 28 May 2026 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957037; cv=none; b=dlmjCJHytCdkYxWoFn/GS17QEBT6V/WO8ZlllXThdqn4DzF7hn/fO7t/+/ik+ppucrC50jU0jysGIfbNz9CD20XUW9v+xMzBen8FPxqIMFEPaYeykxJv8LZfsnts8XciJiUmtWiwJFw7g8/nKxuYyz7wXtcVoaHjslwuXvzHD/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957037; c=relaxed/simple;
	bh=jmVM1fvK9vMRtAuF13+nhOO9fXJoAwsoMDx+6noDwxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUQl6TM5b3VpF++9Hlu6CqbgYUOPj/v6PO0hH5UrDzCEvAtadz9ThmSBV6YCDfBmt5Esuryz0rq5LmgRLjVHIZty4sIoUTgrswASZ9kL0f71vaVaiq7Dx+kNq9m9X2Duv4eYax40TN3UK1dWVnEVSv+KZDxOlqx7FI2fEEtMF/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cIyWqV6J; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cIyWqV6J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779957034; x=1811493034;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jmVM1fvK9vMRtAuF13+nhOO9fXJoAwsoMDx+6noDwxo=;
  b=cIyWqV6JeORpl6HbCooMyqHSvrfxm2pCbGWM7DAZKrU9M1ZNSW0wm/fh
   1GoJOWPtNjPWiyaPDVHsJ5QqQTVjR8YKNv+cCjB9XXIEOWP6lWril1P5z
   VQ1QbsHRvcg0fTdjz85621cDzTknO/nu1lgoi96o6zMz1cppr+fwtImGH
   lXE/UvL3hzz4nQLWi73ewCXXv4YIMpsNa3jbOgWWUhmgSz/WS87l5wucM
   grc4XvknCmD4p0Yq6a9/qhKQBkSa0WA1b4thksbe1k2o2+vRO4ay/voP7
   VbReWiB0YAgkbzyjvWNQxupgwzNpU3n+Ul1YUauIRUdNJCW6qtZ+PUTNJ
   A==;
X-CSE-ConnectionGUID: 6/C1uHNISoKZIlaDMcejPA==
X-CSE-MsgGUID: gXLTtvrQTguZ55Dsr+51Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80648671"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80648671"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:30:30 -0700
X-CSE-ConnectionGUID: oMfinP+TQJ+YK1GC7HWAtg==
X-CSE-MsgGUID: mCzVUfe4SUOK0z9jUqBBbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="246516808"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:30:27 -0700
Message-ID: <a2b2cbc1-c293-4e1b-ba8f-8f18c952e82f@linux.intel.com>
Date: Thu, 28 May 2026 16:30:24 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/17] KVM: x86/pmu: Add support for AMD
 Host-Only/Guest-Only bits
To: Yosry Ahmed <yosry@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>,
 Sandipan Das <sandipan.das@amd.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260527234711.4175166-1-yosry@kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260527234711.4175166-1-yosry@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Run below KVM PMU selftests on SPR for both mediated vPMU and legacy
emulated vPMU modes, no issue is found. 

- pmu_counters_test

- pmu_event_filter_test

- vmx_pmu_caps_test

I know the patches have been merged, so just post the test results here.
Thanks.


On 5/28/2026 7:46 AM, Yosry Ahmed wrote:
> v7 of Jim and myself's series adding support for AMD's Host-Only and
> Guest-Only performance counter eventsel bits in KVM's mediated PMU
> passthrough implementation. The series keeps growing in size over
> versions. This is Sean's fault (as usual), as he keeps finding subtle
> problems and making excellent suggestions.
>
> These bits allow an nSVM-enabled guest to configure performance counters
> that count only during L1 execution (Host-Only) or only during L2 execution
> (Guest-Only).
>
> KVM updates the hardware event selector ENABLE bit at nested transitions
> and EFER.SVME changes such that counters only count in the appropriate
> mode.
>
> The series grew significantly after v4, as it now includes semi-related
> nSVM fixups and selftests cleanups needed for the series. I think parts
> of this series can land independently (patches 1-8 and patches 14-16),
> but then the remaining series would depend on both.
>
> v6 -> v7:
> - Instead of creating __kvm_skip_emulated_instruction(), call
>   svm_skip_emulated_instruction() directly when emulating VMRUN [Sean].
> - Split bailing early on failed VMRUN into two patches, one for the
>   actual fix (patch 2) and one for the code cleanup (patch 3).
> - Add a Fixes tag for patch 3.
> - Indentation fixes and changelog updates.
>
> v5 -> v6:
> - Use a per-counter PMU callback that is called from
>   pmc_is_locally_enabled(), rather than a single callback for all
>   counters from kvm_pmu_handle_event(). This is mainly to address the
>   problem Sashiko found where kvm_pmu_recalc_pmc_emulation() does not
>   capture counter disablement due to Host-Only/Guest-Only bits [Sean].
> - Move the bitmap tracking counters using Host-Only/Guest-Only bits from
>   SVM code to the generic PMU code (and in its own patch), as it's now a
>   generic optimization for pmc_is_locally_enabled() that is reused by SVM
>   code on nested transitions [Sean].
>
> v4 -> v5:
> - Dropped moving leave_guest_mode() and enter_guest_mode() definitions,
>   since the calls to update the vPMU no longer happen within these
>   functions.
> - Add PMU helpers refactoring to facilitate SVM usage.
> - Added nested SVM fixups to count VMRUN correctly in guest mode when
>   Host-Only/Guest-Only support is enabled [Jim/Sean].
> - Update the vPMU synchronously on nested VM-Enter/VM-Exit and EFER.SVME
>   changes, such that counter enablement is reevaluated before the
>   instructions are counted, as the vPMU counts based on the vCPU state
>   at instruction retirement (e.g. using new EFER value when EFER.SVME
>   changes) [Jim/Sean].
> - Keep deferring vPMU updates using KVM_REQ_PMU in the
>   svm_leave_nested() path to avoid KVM potentially consuming stale
>   state [Sean].
> - Use a single PMU callback for reprogramming counters instead of a
>   per-counter callback [Sean].
> - Move the bitmap tracking counters into SVM code. The generic vPMU code
>   now only exposes an API to reprogram counters, and an SVM wrapper uses
>   it on nested transitions [Sean].
> - Drop the manual stack-alignment fixes in the vPMU selftest, instead
>   rework L2 stack setup in all nested selftests to reuse the allocation
>   and alignment logic used by L1, and completely drop L1-provided stacks
>   for L2 [Sean].
>
> v6: https://lore.kernel.org/kvm/20260506015733.1671124-1-yosry@kernel.org/
> v5: https://lore.kernel.org/kvm/20260430202750.3924147-1-yosry@kernel.org/
> v4: https://lore.kernel.org/kvm/20260326031150.3774017-1-yosry@kernel.org/
>
>
> Jim Mattson (2):
>   KVM: x86/pmu: Allow Host-Only/Guest-Only bits with nSVM and mediated
>     PMU
>   KVM: selftests: Add svm_pmu_host_guest_test for Host-Only/Guest-Only
>     bits
>
> Yosry Ahmed (15):
>   KVM: nSVM: Stop leaking single-stepping on VMRUN into L2
>   KVM: nSVM: Bail early out of VMRUN emulation if advancing RIP fails
>   KVM: nSVM: Unify RIP and PMU handling calls when emulating VMRUN
>   KVM: nSVM: Move VMRUN instruction retirement after entering guest mode
>   KVM: x86: Move enable_pmu/enable_mediated_pmu to pmu.h and pmu.c
>   KVM: x86/pmu: Rename reprogram_counters() to clarify usage
>   KVM: x86/pmu: Do a single atomic OR when reprogramming counters
>   KVM: x86/pmu: Check mediated PMU counter enablement before event
>     filters
>   KVM: x86/pmu: Add support for KVM_X86_PMU_OP_OPTIONAL_RET0
>   KVM: x86/pmu: Disable counters based on Host-Only/Guest-Only bits in
>     SVM
>   KVM: x86/pmu: Track mediated PMU counters with mode-specific enables
>   KVM: x86/pmu: Reprogram Host/Guest-Only counters on nested transitions
>   KVM: selftests: Refactor allocating guest stack into a helper
>   KVM: selftests: Allocate a dedicated guest page for x86 L2 guest stack
>   KVM: selftests: Drop L1-provided stacks for L2 guests on x86
>
>  arch/x86/include/asm/kvm-x86-pmu-ops.h        |   5 +-
>  arch/x86/include/asm/kvm_host.h               |   3 +-
>  arch/x86/include/asm/perf_event.h             |   2 +
>  arch/x86/kvm/pmu.c                            |  21 +-
>  arch/x86/kvm/pmu.h                            |  44 +++-
>  arch/x86/kvm/svm/nested.c                     |  43 +++-
>  arch/x86/kvm/svm/pmu.c                        |  42 ++++
>  arch/x86/kvm/svm/svm.c                        |   3 +-
>  arch/x86/kvm/svm/svm.h                        |  24 ++
>  arch/x86/kvm/vmx/pmu_intel.c                  |   2 +-
>  arch/x86/kvm/x86.c                            |   9 -
>  arch/x86/kvm/x86.h                            |   3 -
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  tools/testing/selftests/kvm/include/x86/pmu.h |   6 +
>  .../selftests/kvm/include/x86/processor.h     |   2 +
>  .../selftests/kvm/include/x86/svm_util.h      |   5 +-
>  tools/testing/selftests/kvm/include/x86/vmx.h |   4 +-
>  .../testing/selftests/kvm/lib/x86/memstress.c |  19 +-
>  .../testing/selftests/kvm/lib/x86/processor.c |  45 ++--
>  tools/testing/selftests/kvm/lib/x86/svm.c     |   6 +-
>  tools/testing/selftests/kvm/lib/x86/vmx.c     |   6 +-
>  .../selftests/kvm/x86/aperfmperf_test.c       |   9 +-
>  .../kvm/x86/evmcs_smm_controls_test.c         |   5 +-
>  .../testing/selftests/kvm/x86/hyperv_evmcs.c  |   6 +-
>  .../selftests/kvm/x86/hyperv_svm_test.c       |   6 +-
>  .../selftests/kvm/x86/kvm_buslock_test.c      |   9 +-
>  .../selftests/kvm/x86/nested_close_kvm_test.c |  12 +-
>  .../selftests/kvm/x86/nested_dirty_log_test.c |   8 +-
>  .../selftests/kvm/x86/nested_emulation_test.c |   4 +-
>  .../kvm/x86/nested_exceptions_test.c          |   9 +-
>  .../kvm/x86/nested_invalid_cr3_test.c         |  10 +-
>  .../selftests/kvm/x86/nested_tdp_fault_test.c |   9 +-
>  .../kvm/x86/nested_tsc_adjust_test.c          |  10 +-
>  .../kvm/x86/nested_tsc_scaling_test.c         |  10 +-
>  .../kvm/x86/nested_vmsave_vmload_test.c       |   6 +-
>  tools/testing/selftests/kvm/x86/smm_test.c    |   8 +-
>  tools/testing/selftests/kvm/x86/state_test.c  |  11 +-
>  .../selftests/kvm/x86/svm_int_ctl_test.c      |   5 +-
>  .../selftests/kvm/x86/svm_lbr_nested_state.c  |   6 +-
>  .../kvm/x86/svm_nested_clear_efer_svme.c      |   7 +-
>  .../kvm/x86/svm_nested_shutdown_test.c        |   5 +-
>  .../kvm/x86/svm_nested_soft_inject_test.c     |   6 +-
>  .../selftests/kvm/x86/svm_nested_vmcb12_gpa.c |  13 +-
>  .../kvm/x86/svm_pmu_host_guest_test.c         | 216 ++++++++++++++++++
>  .../selftests/kvm/x86/svm_vmcall_test.c       |   5 +-
>  .../kvm/x86/triple_fault_event_test.c         |   9 +-
>  .../selftests/kvm/x86/vmx_apic_access_test.c  |   5 +-
>  .../kvm/x86/vmx_apicv_updates_test.c          |   4 +-
>  .../kvm/x86/vmx_invalid_nested_guest_state.c  |   6 +-
>  .../kvm/x86/vmx_nested_la57_state_test.c      |   5 +-
>  .../kvm/x86/vmx_preemption_timer_test.c       |   5 +-
>  51 files changed, 479 insertions(+), 245 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c
>
>
> base-commit: 9f2a49c511cb05b85745e1578e4fd425bff87f58
