Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537AF5226B9;
	Fri, 18 Sep 2026 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761001; cv=none; b=mLvVh1u1ZKej9lvHhqCr0WgcNICcAEKDUXlPLS/jrqkAsbKewTTVbj+h70tkZhCOaDMCyC81U4xyDqtKvHylYC7ORgUhr6sqBXGYTkx2q/CNStnw3+VsYf02tiPLCPtrw83W7DoG5/y8JxB5pf1fFWF/mlD0KLRmzODHMHP4RlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761001; c=relaxed/simple;
	bh=RC75b45Lnim5/GeL+W/Q3c7hum+yHqk55UdHQPdhCjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pmpln7ToYygmoMZGemQB/WfMxsyLd6m8eTjJ34Tf/gz4kGCuO4oaTqpJ0Hw26HnxcgXbtgH6Q/VGr86FQF3PcySqrDRBq/Jh8pwrTxRpAhu6yXoFGgRklq2qsowmtI5I19jadGQwWyqYI8/0F9o03u0LMKgJu6hwR9OPuIsmVT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ls6hNwC/; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ls6hNwC/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789761000; x=1821297000;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RC75b45Lnim5/GeL+W/Q3c7hum+yHqk55UdHQPdhCjk=;
  b=Ls6hNwC/qAvCVFb9xH0Wl6KRtc4IPOzkFtO+7oZqVaHeIqxYu8QZ8GL2
   V4wMxYx54wURsc/Bi1hnhaO1xL31r1MeFDyxDXpGvuPM9njkS9nHLsXq7
   5V0GT1MBSsK2GjkrkwAl8wbya2KoB04zd9Ns4B5AklpVnecPaf4oTlSEF
   TYjuo89IHAtTarwGATejz9wr9vOasMNBHVhhELzeihf4tVz9KnYowHJ7F
   YGaV4M1PZC1XBMkz6+qkawdgHBvFJmg8orAjQPeimFUgRulSJiAyDJcKj
   hx3DOfyLxIzCor6p2fIcNz+UbWntBIJ5oPIuC/LQEsC9kb8ct6XwHRxYa
   w==;
X-CSE-ConnectionGUID: ZQgwrx6kTwqO3BJnfgcoQw==
X-CSE-MsgGUID: TvEt189ORoSMxPWZ3swz2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="790315"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="790315"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:49:58 -0700
X-CSE-ConnectionGUID: FvMrcX7dRMe2OpFZqPV92A==
X-CSE-MsgGUID: aS6nQtiJQGqHkxwwK6uA1w==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:49:58 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v9 00/12] KVM: x86/pmu: Add hardware Topdown metrics support
Date: Fri, 18 Sep 2026 12:39:25 -0700
Message-ID: <20260918193937.569414-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous revisions were missing two things that are now addressed:

- A previous comment incorrectly claimed that MSR_PERF_METRICS bits
  [63:32] are ignored on hardware that only implements level-1 metrics;
  patch 10/12 fixes this by rejecting such writes.

- Patch 11/12 adds support for RDPMC Metrics Clear Mode. Without
  this feature, for user programs using RDPMC directly, the counter
  has to be reset explicitly using ioctl:

  ioctl(perf_fd, PERF_EVENT_IOC_RESET, 0);

Tests: besides the tests mentioned on v8 cover letter, tested RDPMC
Metrics Clear on a DMR machine, and tested Topdown metrics on nested
setup on top of the vPMU support series [1].

perf tool misidentifies "cpu/slots,metrics_clear=1/" as not being the
slots event, so it inserts an additional slots event into the group;
event scheduling then fails because the group needs fixed counter 3
(SLOTS) twice:

  $ perf stat -e "{cpu/slots,metrics_clear=1/,cpu/topdown-retiring/}" -- sleep 1
    WARNING: events were regrouped to match PMUs
           <not counted>      slots
         <not supported>      cpu/slots,metrics_clear=1/
           <not counted>      cpu/topdown-retiring/

A fix for this perf tool bug is posted at [2].

New patches:
patch 8/12: Add INTEL_TD_METRIC_FIELD_BITS for code cleanup.
patch 9/12: perf/x86: Expose number of Topdown metric events to KVM.
patch 10/12: Reject writes to reserved MSR_PERF_METRICS bits.
patch 11/12: Support RDPMC Metrics Clear Mode.

Minor non-logical changes to existing patches:
patch 5/12: Remove the incorrect comment about writing to PERF_METRICS.
patch 7/12: Remove references to Metrics Clear from the changelog.

Patch 11/12 could be folded into patch 5/12, but I kept them separate
because patches 1-8 were already well reviewed, and keeping them
unchanged should make reviewing v9 easier.

Rebased to kvm-x86/next: 70c944caf570fda2d79baa71435589a8db39f048

v8: https://lore.kernel.org/kvm/20260817183143.226156-1-zide.chen@intel.com/
QEMU:  https://lore.kernel.org/qemu-devel/20260604025546.19378-7-zide.chen@intel.com/

[1] https://lore.kernel.org/kvm/20260827223755.143247-1-zide.chen@intel.com/
[2] https://lore.kernel.org/linux-perf-users/20260917182525.3DE801F000FF@smtp.kernel.org/T/#t

Dapeng Mi (2):
  KVM: x86/pmu: Support Intel fixed counter 3 on mediated vPMU
  KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU

Mingwei Zhang (1):
  KVM: x86/pmu: Snapshot host IA32_PERF_CAPABILITIES in kvm_host

Zide Chen (9):
  KVM: x86/pmu: Do not map fixed counters >= 3 to generic perf events
  KVM: x86/pmu: Rename and move vcpu_get_perf_capabilities() to pmu.h
  KVM: x86/pmu: Move RDPMC emulation into per-vendor callbacks
  KVM: x86/pmu: Emulate RDPMC on performance metrics
  KVM: selftests: Add PERF_METRICS and fixed counter 3 tests
  perf/x86: Add INTEL_TD_METRIC_FIELD_{BITS,MASK} constants
  perf/x86: Expose number of Topdown metric events to KVM
  KVM: x86/pmu: Reject writes to reserved MSR_PERF_METRICS bits
  KVM: x86/pmu: Support RDPMC Metrics Clear Mode

 arch/x86/events/core.c                        |   1 +
 arch/x86/events/intel/core.c                  |   8 +-
 arch/x86/include/asm/kvm-x86-pmu-ops.h        |   2 +-
 arch/x86/include/asm/kvm_host.h               |   5 +-
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/include/asm/perf_event.h             |   5 +
 arch/x86/kvm/msrs.c                           |  10 +-
 arch/x86/kvm/pmu.c                            |  37 +++--
 arch/x86/kvm/pmu.h                            |  17 ++-
 arch/x86/kvm/svm/pmu.c                        |  13 +-
 arch/x86/kvm/vmx/nested.c                     |   2 +
 arch/x86/kvm/vmx/pmu_intel.c                  | 132 +++++++++++++++---
 arch/x86/kvm/vmx/pmu_intel.h                  |  12 +-
 arch/x86/kvm/vmx/vmx.c                        |  19 ++-
 arch/x86/kvm/x86.c                            |   4 +
 tools/arch/x86/include/asm/msr-index.h        |   1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |   3 +
 .../selftests/kvm/x86/pmu_counters_test.c     |  97 ++++++++++++-
 18 files changed, 303 insertions(+), 67 deletions(-)

-- 
2.55.0

