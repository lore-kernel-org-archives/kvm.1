Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4D92D5A01;
	Thu, 27 Aug 2026 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870887; cv=none; b=VJ3+58WlVBiegoV2nLVSfUYnpfnqkS217skzEuoPB+NpjsEM8OxUmiyIm/cNJbuNlBLhCR5nPgGFTWYBlkJoU5YfEWSHqQvvno3SMvE+v9+IKqqTvJPKEdXHw3FV8P0d7MwtenhErMg4w8ecfe4FzlJhKnU6ITS6vflUJVQ64TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870887; c=relaxed/simple;
	bh=HMu93XjB7n//m2T+1l9PuPPs63Fmr/gQ9S6b+3PMMqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uF0yId0hHHKAI9qsOYBATHHVyCotDAYDCOPYo9r/s5UtwO1dFUnHwupWTUdyQY1CP67z6Fktj9UcVNNIyl/WNy/HvPH7mTbwcOBqvHVXUihLS0MJFN9J7/PU9rXxu8hywO9EHOC8VZJEtTGaT26DuoDVNPz8/GScvDj8hLgX66A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhMA0NK7; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhMA0NK7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787870886; x=1819406886;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HMu93XjB7n//m2T+1l9PuPPs63Fmr/gQ9S6b+3PMMqw=;
  b=XhMA0NK70M7XvvCrfDwBrSnnzLdT0DGcn7IN3L9DMIanIwUTErIHbYC2
   KuBup69+jxFbMzAkgWSikWbazrm+Plq0eW/6r7/AMiqozqqA9UIVxNuuk
   uOu/TeeS17UAwL4JlbOmTXgU9aQ68PGqtops4ZeIMLndUA7kmUeG3IIVr
   E5nHY0GFLyEBBtE4M3rKzun1JjIQKbuwjfDzNM+wsEQ8fx8d1l8OEAAqc
   ojP5WkOIDPNsfWSuGQby4g0BAy4B8Jt+TQEWGzPgeyUpolvccoDfTe9Dw
   LT+SZiNYpCb5DNlJ5D6htYGV9a0T9zPZsLk/LVqjL1Ch7QbxJx7O4MFn4
   w==;
X-CSE-ConnectionGUID: sAWxfm5DT26fIj73Mcl+dQ==
X-CSE-MsgGUID: 9frM5kQ/TsG8Ebl8AeXOGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113914821"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="113914821"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:05 -0700
X-CSE-ConnectionGUID: uWLddpHRSgCjdBdpDK+Q7Q==
X-CSE-MsgGUID: 3gOwaGs1SnqM8xnDiKUVSw==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:05 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Jim Mattson <jmattson@google.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH] KVM: x86/pmu: Add mediated vPMU PerfMon v5 support
Date: Thu, 27 Aug 2026 15:37:39 -0700
Message-ID: <20260827223755.143247-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM currently caps the guest Intel architectural PMU version at 2. This
series bumps it to PerfMon v5 and adds support for some features that
are introduced in PerfMon v3-v5.

- CPUID.0AH:ECX fixed-counter bitmap (v5): supersedes EDX[4:0] and
  lets KVM/guests represent non-contiguous fixed counters (e.g. some
  E-core server parts skip fixed counter 3).
- Add support for IA32_PERF_GLOBAL_STATUS_SET (v4): lets software set
  individual bits in the global status MSR.
- Add support for IA32_PERF_GLOBAL_INUSE (v4): reports which counters
  and PMI are currently claimed.
- Implement ANYTHREAD_DEPRECATION capability.

Intel PerfMon v5 doesn't support non-contiguous GP counters; however,
this series lays the groundwork for GP counter bitmap support anyway,
for consistency with the host perf API interface, and prepares for
Perfmon Masking support.

Freeze_PerfMon_On_PMI virtualization is not implemented because, as
commit 3daa96d67274 ("perf/intel: Remove Perfmon-v4 counter_freezing
support") states, the Freeze-on-PMI mechanism violates the perf counter
independence.

Streamlined Freeze_LBRs_On_PMI is not implemented because LBR is not
yet supported on mediated vPMU.

Tested on SPR and CWF:

- Ran "perf test" on both L0 and L1; no issues attributable to this
  series have been observed so far.

- Ran KVM selftests on both L0 and L1.

- Passed AnyThread tests on both fixed and gp counters:
  $ perf stat -e r20003c,r2000c4,r2000c0 -- sleep 1

- Tested various guest fixed-counter configurations:
      CPUID.0AH:ECX = 0x7   CPUID.0AH:EDX[4:0]=3
      CPUID.0AH:ECX = 0x2   CPUID.0AH:EDX[4:0]=0
      CPUID.0AH:ECX = 0x6   CPUID.0AH:EDX[4:0]=0
      CPUID.0AH:ECX = 0x5   CPUID.0AH:EDX[4:0]=1
      CPUID.0AH:ECX = 0x0   CPUID.0AH:EDX[4:0]=0

  Verified that the guest PMU reflected the configured fixed-counter
  and that the following command used fixed or general-purpose counters
  as expected:

  $ perf stat -e instructions,cpu-cycles,ref-cycles -- sleep 1

- Manually tested IA32_PERF_GLOBAL_INUSE.

- Ran some additional perf tests on both L0 and L1.

- Sanity testing on nested VMs.

Patch series summary:
patch 1-4: Code cleanup and a fix.
patch 5-10: Implement PMC bitmap support.
patch 11-14: Implement PerfMon v3-v5 new features.
patch 15: Advertise PerfMon version up to v5.
patch 16: Fix pmu_counters_test selftests fixed counter test case.

Rebased to kvm-x86/next: 76671054f9a1

v2 changes:
- Dropped v1 11/15: KVM: x86/pmu: Emulate streamlined Freeze-LBR-on-PMI
- New patch 4/15 to gate BUFFER_OVF reserved bit on guest DS feature.
- Some renames:
  - all_valid_pmc_mask to pmc_exists;
  - add _is to kvm_{gp,fixed}_pmc_supported();
  - split kvm_for_each_set_pmc_idx() to kvm_for_each_{gp,fixed}_counter().
- Add missing AnyThr handling in IA32_FIXED_CTR_CTRL and advertise
  anythread_deprecated only if kvm_pmu_cap.version >= 5.
- Cap vPMU v3/v4 to v2, as AnyThread cannot be safely virtualized.
- Miscellaneous updates to changelogs and some minor fixes.

Dapeng Mi (6):
  KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters from kvm_pmu
  perf/x86: Plumb counter bitmap from x86_pmu to x86_pmu_cap
  KVM: x86/pmu: Switch to bitmask-based KVM PMU capabilities
  perf/x86: Remove num_counters_{gp,fixed} from x86_pmu_capability
  KVM: x86/pmu: Advertise PerfMon version 5 on Intel hosts
  KVM: selftests: Support fixed counters bitmap in pmu_counters_test

Zide Chen (10):
  KVM: x86/pmu: Remove redundant Perf Global Status MSR bit definitions
  KVM: x86/pmu: Rename all_valid_pmc_idx to pmc_exists
  KVM: x86/pmu: Rename reserved_bits to eventsel_rsvd in kvm_pmu
  KVM: x86/pmu: Gate BUFFER_OVF reserved bit on guest DS
  KVM: x86/pmu: Add PMC bitmap accessor helpers
  KVM: x86/pmu: Expose kvm_host_pmu to vendor modules
  KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and GLOBAL_INUSE MSRs
  KVM: x86/pmu: Populate CPUID.0AH:ECX fixed-counter bitmap
  KVM: x86/pmu: Factor out fixed counter control bit calculation
  KVM: x86/pmu: Ignore AnyThread bit if CPUID.0AH:EDX[15] is set

 arch/x86/events/core.c                        |   8 +-
 arch/x86/include/asm/kvm_host.h               |   9 +-
 arch/x86/include/asm/msr-index.h              |  12 +-
 arch/x86/include/asm/perf_event.h             |  10 +-
 arch/x86/kvm/cpuid.c                          |  21 ++-
 arch/x86/kvm/msrs.c                           |  12 +-
 arch/x86/kvm/pmu.c                            |  85 ++++++---
 arch/x86/kvm/pmu.h                            |  54 +++++-
 arch/x86/kvm/svm/pmu.c                        |  37 ++--
 arch/x86/kvm/svm/svm.c                        |  17 +-
 arch/x86/kvm/vmx/nested.c                     |   8 +-
 arch/x86/kvm/vmx/pmu_intel.c                  | 167 +++++++++++++-----
 arch/x86/kvm/vmx/vmx.c                        |  19 +-
 .../selftests/kvm/include/x86/processor.h     |   6 +-
 .../selftests/kvm/x86/pmu_counters_test.c     |  26 ++-
 15 files changed, 349 insertions(+), 142 deletions(-)

-- 
2.55.0

