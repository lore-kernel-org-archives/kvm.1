Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929832;
	b=iAgPxCx5g2ZcmAwB5a6oQWYaX4bPBr3GneR4V2RSoNtq97jG9a8D+O2FkmzB35qCzHxr
	 y3fOJdOETbD8KEeuHZ5i52C5m++JOFAMvIp8+qsoDVfFxXvB/Xjg7BPEk7oVRKfsP1xHJ
	 Wk6BqEAxWriwTVj+wO4lZ8s51S0jsogiH2gBMotnv5U6FcC51ZsEdETqEjUZBNwdMiFTG
	 cMJZuhRyy7NMgwzyY03ZYx051kbN7CgpVBKHPrJHrZSAhTldI+RuK+xXPjn2pbupWgdTI
	 jQOrIRLy3AkwvTZsUpBKgpGEOlwJl5KTD5XcUsrodbOInMQipzeC1qeawVDMbQhDatQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929832;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=B8USSZFyu9Hj6VeEKcallORNQITqWGsH464K2jGZB28=;
	b=tRTd4bRjkaRBlanY0OqfI5h17v6wxrGguFxNzP9GWY36MhngW7yVbci8newmFOwDo919
	 Ge9I/VBqHImBpje/zMrynpId+utr55lxjlVDL/1TINu4cQL3BTHxsf3Ogd4XWkgUnkcSy
	 iyJG5SF9ZTgPHRM7YfypuL91FNrAOeviNgp+8GQsZh0MPu0MX1yTuaVLDXvYGmOEPLq1U
	 O6I5/7G2bFJTtW0liM75V/0XfNQgBSwW8bLUFDFPPsUQd2Ni0HcQAkvFqUQJ+YxhyQUjE
	 1H11MyOlU+6idQdH5Qt3KmsyoHWpZPABOAEDqh6fAb4xPQjDcVZIeYs5RaAvXXa6VlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mUrs1lLX;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3934F606A31B;
	Fri,  6 Nov 2026 01:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3934F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mUrs1lLX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793929831; x=1825465831;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fyUy5rXg/JGYcclG/uQEvOB4xWoxjib40bW+2HWFUXY=;
  b=mUrs1lLXWIdb3k724HX6QKH8zND3HMrVJwS1EnsqVwCvig4GYcHUXA1d
   c9UCmR63aYazSXLpLg8eeSnDMrUqCPBXKN0CpLjEkmhK2jZzFRvUwBopd
   504+hM/3XBfytsK+min0Syc+zjk2E5kShDW1gzDQRAoiM6SXZTOgKvdTl
   XxuyG8JoldCAa1JHvITZVxa53zZ7owcNT2QUKZhteAokVJjGXGiIQYHIv
   NpIJXWf5DmEoHMnPy7ftJyycPSoUGCH2PntV7TXQ5Fb+a2EDum0/kFpHv
   /xZ0tjD4q6wDu44WhNI1ux/xS1I8KUMCELfm3pJCMCZah9Bbx8w2bg2Gp
   g==;
X-CSE-ConnectionGUID: C6bZnwbjRamEwO8oW1QeCw==
X-CSE-MsgGUID: YoS85HkpQsWFrxsJEMT5jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740107"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2740107"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:30 -0800
X-CSE-ConnectionGUID: i7tWmt0OS72c/NEoRTtOBw==
X-CSE-MsgGUID: eKCLkxC1R0q4pYTFQwHtFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067164"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:30 -0800
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
Subject: [PATCH v3 00/18] KVM: x86/pmu: Add mediated vPMU PerfMon v5 support
Date: Thu,  5 Nov 2026 18:39:09 -0700
Message-ID: <20261106013927.166209-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.0
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

KVM currently caps the guest Intel architectural PMU version at 2. This
series bumps it to PerfMon v5 and adds support for some features that
are introduced in PerfMon v3-v5.

- CPUID.0AH:ECX fixed-counter bitmap (v5): supersedes EDX[4:0] and
  lets KVM/guests represent non-contiguous fixed counters (e.g. some
  E-core server parts skip fixed counter 3).
- Support IA32_PERF_GLOBAL_STATUS_RESET (v4): inherits MSR 0x390 and its
  emulation from IA32_PERF_GLOBAL_OVF_CTRL without KVM code changes;
  document its mediated-PMU passthrough erratum in errata.rst.
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

Mutual exclusion between Intel PT and mediated vPMU, to prevent host PT
PMIs from asserting IA32_PERF_GLOBAL_STATUS.Trace_ToPA_PMI (bit 55)
while guest PMU context is loaded, as analyzed by Yosry Ahmed, is left
out of this series and will be addressed in a separate follow-up patch.

Tests are described in v2 cover letter.

Patch series summary:
patch 1-3: Code cleanups.
patch 4-9: Implement PMC bitmap support across perf and KVM.
patch 10-16: Implement PerfMon v4-v5 new features.
patch 17: Advertise PerfMon version up to v5 on Intel hosts.
patch 18: Support fixed counters bitmap in pmu_counters_test selftest.

Rebased on kvm-x86/next: commit dea4f6380f4e ("Merge branch 'vmx'")

v3 changes:
- Dropped v2 patch 4 ("Gate BUFFER_OVF reserved bit on guest DS") (Jim).
- New patch 10 to document the IA32_PERF_GLOBAL_STATUS_RESET passthrough
  erratum in errata.rst.
- New patch 15 to mask only OS/USR bits when filtering fixed counters,
  preventing AnyThread leakage into hardware and preserving METRICS_CLEAR_EN.
- Split MSR 0x391 and MSR 0x392 emulation into separate patches.
- Always intercept IA32_PERF_GLOBAL_STATUS_SET and GLOBAL_INUSE to
  prevent hardware state divergence (Jim).
- Reject bit 63 (CondChgd) writes to GLOBAL_STATUS_SET (Jim).
- Keep the AnyThread bit guest-visible while removing it from the
  hardware-visible states (Jim).
- Address other minor review comments from LKML, also some fixes
  suggested by AI tools.
- Collected Reviewed-by and Acked-by tags.

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

Previous versions:
v2: https://lore.kernel.org/kvm/20260827223755.143247-1-zide.chen@intel.com/
v1: https://lore.kernel.org/kvm/amj-5YH-LSwZOLow@google.com/T/#u

Dapeng Mi (6):
  KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters from kvm_pmu
  perf/x86: Plumb counter bitmap from x86_pmu to x86_pmu_cap
  KVM: x86/pmu: Switch to bitmask-based KVM PMU capabilities
  perf/x86: Remove num_counters_{gp,fixed} from x86_pmu_capability
  KVM: x86/pmu: Advertise PerfMon version 5 on Intel hosts
  KVM: selftests: Support fixed counters bitmap in pmu_counters_test

Zide Chen (12):
  KVM: x86/pmu: Remove redundant Perf Global Status MSR bit definitions
  KVM: x86/pmu: Rename all_valid_pmc_idx to pmc_exists
  KVM: x86/pmu: Rename reserved_bits to eventsel_rsvd in kvm_pmu
  KVM: x86/pmu: Add PMC bitmap accessor helpers
  KVM: x86/pmu: Expose kvm_host_pmu to vendor modules
  KVM: x86/pmu: Document GLOBAL_STATUS_RESET passthrough erratum
  KVM: x86/pmu: Emulate IA32_PERF_GLOBAL_STATUS_SET MSR
  KVM: x86/pmu: Emulate IA32_PERF_GLOBAL_INUSE MSR
  KVM: x86/pmu: Populate CPUID.0AH:ECX fixed-counter bitmap
  KVM: x86/pmu: Factor out fixed counter control bit calculation
  KVM: x86/pmu: Mask only OS/USR bits when filtering fixed counters
  KVM: x86/pmu: Ignore AnyThread bit if CPUID.0AH:EDX[15] is set

 Documentation/virt/kvm/x86/errata.rst         |  10 +-
 arch/x86/events/core.c                        |   8 +-
 arch/x86/include/asm/kvm_host.h               |   9 +-
 arch/x86/include/asm/msr-index.h              |   9 +-
 arch/x86/include/asm/perf_event.h             |  13 +-
 arch/x86/kvm/cpuid.c                          |  21 +-
 arch/x86/kvm/msrs.c                           |  12 +-
 arch/x86/kvm/pmu.c                            |  87 +++++---
 arch/x86/kvm/pmu.h                            |  54 ++++-
 arch/x86/kvm/svm/pmu.c                        |  37 ++--
 arch/x86/kvm/svm/svm.c                        |  18 +-
 arch/x86/kvm/vmx/nested.c                     |   6 +-
 arch/x86/kvm/vmx/pmu_intel.c                  | 196 +++++++++++++-----
 arch/x86/kvm/vmx/vmx.c                        |  28 ++-
 .../selftests/kvm/include/x86/processor.h     |   6 +-
 .../selftests/kvm/x86/pmu_counters_test.c     |  28 ++-
 16 files changed, 379 insertions(+), 164 deletions(-)

-- 
2.56.0
