Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516227;
	b=tMFPZZMTSLEWdoZlPZz2BOMCpnCRFteqHkG+ZNuu5jbW1dO2Eavq/jnF8hOAuHqxwtkp
	 ihnTqWZeZLZeac9ILmBPJ8A84ZMo7/YUcnYeh+JlAZjGBpZfy4129Zo0pKDdV3ten7pGk
	 cFpt+YxIrTDjgDlojCoE4K5MrX8qPGm+7TqI/2oLuMGH+RMek93xHuK12t0JEQPYZrS5v
	 un8v1Ta1WVcODBBbm9jEGUW+dc5rZDPi83AL5gUTLVZ3lRhVWxrlus34mFPYCH7r4zM+M
	 52dOkQFYbreD+/P65vVDn8PjVFyezKsGsC/XsyQ4cEeBgMJrVWzf+akL92usr8JaO/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516227;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=LrgZbSU7skm5UOnm/aYfy1htNLm3IHcri83g/C34JqQ=;
	b=Cjt3NuY/qB67bKee9pqdZDEyqLv589xYF4ceqWbdr5USMcBQpiW1jjVU1j+QTZSdXbcF
	 focCSBvHQp5KlVGacdXWoK7xSDxjIpIjikHwQD5K+vEKrykhaAIZjOTMxF4INbiIzPeLE
	 eCJ//aG2z8AmglRnebWsVm5ogQK4Kx0XiK+8SWd0tZlAFE0lmGN2nf3kXNLRSsnOnNU/E
	 N9+q9TRbLftU5EzdVshOL60VDqnhidTCkMaH8A01/K87I62L16IeFXqIoAYAFGZ5OjcPT
	 gwW1w3wxnMmvu3uVMlty6CAutVyiP/W1pW+LBrf9t5bBHM9WMMLqglhP8e2r58r69cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="WHCtVX/U";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0D6606A321;
	Thu, 12 Nov 2026 20:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF0D6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WHCtVX/U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516227; x=1826052227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+pw7IPfoLV9aVKF+uyApi5cJBsLD+4XUm4QdKKRtGzY=;
  b=WHCtVX/UWDJR8ZXzR964Vi4uvEPN441Md4oCPGpZA7jmAalDtC3Xysn6
   AKqybQf+Y92sJVgKuoFE4rVnkFvlJKu0JapuhWoKN/RTSYeLx4HfgjODB
   0TowNPBoS9m8vE6TaGFdpTkCGDnCtTmouyxek9dEu5S8aByIb8oBiIXI9
   l62FGfiLRGMnC8Hq1iuHsARVL8ktZEKatiUWwkWn/KlZC/95jBKh7JFS7
   M8M+pzvF0ncIBvOsIAgLc5FDmA59D4q1ALMdbUIGUCghuTYZP0EFyaDDX
   XlteWwYMdAKRnqKu9XyEFgU+DxVFs7m2PEKFPI8ar+1b1LeiPUPPgUweJ
   A==;
X-CSE-ConnectionGUID: yepCWdCMSDG2t/het2ruyg==
X-CSE-MsgGUID: lyz5788QQ32ThQaiYipdzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192207"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192207"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:46 -0800
X-CSE-ConnectionGUID: ICnbhtwdQkS3sbGpmSVesw==
X-CSE-MsgGUID: /WWtYSrhSe6shRBFh4EgOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087860"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:46 -0800
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
Subject: [PATCH v4 00/21] KVM: x86/pmu: Add mediated vPMU PerfMon v5 support
Date: Thu, 12 Nov 2026 13:32:06 -0700
Message-ID: <20261112203227.289379-1-zide.chen@intel.com>
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

KVM currently caps the guest Intel architectural PMU version at 2 and
relies on counter-count fields that cannot describe sparse or
non-contiguous fixed counters.

Rework KVM's vPMU to track counters with bitmasks instead of counts, so
mediated-PMU guests can use Intel PerfMon v5 and non-contiguous fixed
counters, and lay the groundwork for non-contiguous GP counters (CPUID
leaf 0x23). This series also adds support for new features
introduced in PerfMon v3-v5.

- CPUID.0AH:ECX fixed-counter bitmap (v5): supersedes EDX[4:0] and
  lets KVM/guests represent non-contiguous fixed counters (e.g. some
  E-core server parts skip fixed counter 3).
- Support IA32_PERF_GLOBAL_STATUS_RESET (v4): inherits MSR 0x390 and its
  emulation from IA32_PERF_GLOBAL_OVF_CTRL; mark CondChgd (bit 63)
  reserved in IA32_PERF_GLOBAL_STATUS while allowing it to be cleared
  on STATUS_RESET, and document its mediated-PMU passthrough erratum in
  errata.rst.
- Add support for IA32_PERF_GLOBAL_STATUS_SET (v4): lets software set
  individual bits in the global status MSR.
- Add support for IA32_PERF_GLOBAL_INUSE (v4): reports which counters
  and PMI are currently claimed.
- Implement ANYTHREAD_DEPRECATION capability (v5).
- Clamp guest PMU version to KVM's host capabilities (pmu->version):
  ensures KVM's internal state tracks the effective PMU version that
  KVM can actually emulate, matching how bit_width, mask_length, and
  nr_{gp,fixed}_counters are clamped.

Intel PerfMon v5 doesn't support non-contiguous GP counters; however,
this series lays the groundwork for GP counter bitmap support anyway,
for consistency with the host perf API interface, and prepares for
PerfMon Masking support.

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
patch 1-4: Code cleanups and bug fixes.
patch 5-10: Implement PMC bitmap support across perf and KVM.
patch 11-19: Implement PerfMon v4-v5 new features, including PMU
             version clamping.
patch 20: Advertise PerfMon version up to v5 on Intel hosts.
patch 21: Support fixed counters bitmap in pmu_counters_test selftest.

Rebased on kvm-x86/next: commit cbe54fc3462b("Merge branch 'vmx'")

v4:
 - New patches:
   - Patch 1: Drop redundant counter MSR checks in amd_is_valid_msr().
     (Jim)
   - Patch 12: Handle CondChgd (bit 63) asymmetry: mark bit 63 reserved
     in global_status_rsvd to reject writes to GLOBAL_STATUS{,_SET},
     while allowing writes to STATUS_RESET. (Jim, Yosry)
   - Patch 15: Clamp pmu->version to kvm_pmu_cap.version. (Sean, Yosry)
 - Collected Reviewed-by tags, but did not carry Reviewed-by on patches
   5, 9, and 13 due to code changes.
 - All other changes are non-functional, including code improvements,
   coding style cleanups, and patch rearrangements.

v3:
 - https://lore.kernel.org/kvm/20261106013927.166209-1-zide.chen@intel.com/
 - Dropped v2 patch 4 ("Gate BUFFER_OVF reserved bit on guest DS").
   (Jim)
 - New patch 10 to document the IA32_PERF_GLOBAL_STATUS_RESET
   passthrough erratum in errata.rst.
 - New patch 15 to mask only OS/USR bits when filtering fixed counters,
   preventing AnyThread leakage into hardware and preserving
   METRICS_CLEAR_EN.
 - Split MSR 0x391 and MSR 0x392 emulation into separate patches.
 - Always intercept IA32_PERF_GLOBAL_STATUS_SET and GLOBAL_INUSE to
   prevent hardware state divergence. (Jim)
 - Reject bit 63 (CondChgd) writes to GLOBAL_STATUS_SET. (Jim)
 - Keep the AnyThread bit guest-visible while removing it from the
   hardware-visible states. (Jim)
 - Address other minor review comments from LKML, also some fixes
   suggested by AI tools.
 - Collected Reviewed-by and Acked-by tags.

v2:
 - https://lore.kernel.org/kvm/20260827223755.143247-1-zide.chen@intel.com/
 - Dropped v1 11/15: KVM: x86/pmu: Emulate streamlined
   Freeze-LBR-on-PMI.
 - New patch 4/15 to gate BUFFER_OVF reserved bit on guest DS feature.
 - Some renames:
   - all_valid_pmc_mask to pmc_exists;
   - add _is to kvm_{gp,fixed}_pmc_supported();
   - split kvm_for_each_set_pmc_idx() to
     kvm_for_each_{gp,fixed}_counter().
 - Add missing AnyThr handling in IA32_FIXED_CTR_CTRL and advertise
   anythread_deprecated only if kvm_pmu_cap.version >= 5.
 - Cap vPMU v3/v4 to v2, as AnyThread cannot be safely virtualized.
 - Miscellaneous updates to changelogs and some minor fixes.

v1: https://lore.kernel.org/kvm/amj-5YH-LSwZOLow@google.com/T/#u

Dapeng Mi (6):
  KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters from kvm_pmu
  perf/x86: Plumb counter bitmap from x86_pmu to x86_pmu_cap
  KVM: x86/pmu: Switch to bitmask-based KVM PMU capabilities
  perf/x86: Remove num_counters_{gp,fixed} from x86_pmu_capability
  KVM: x86/pmu: Advertise PerfMon version 5 on Intel hosts
  KVM: selftests: Support fixed counters bitmap in pmu_counters_test

Zide Chen (15):
  KVM: SVM: Drop counter MSR checks in amd_is_valid_msr()
  KVM: x86/pmu: Remove redundant Perf Global Status MSR bit definitions
  KVM: x86/pmu: Rename all_valid_pmc_idx to pmc_exists
  KVM: x86/pmu: Rename reserved_bits to eventsel_rsvd in kvm_pmu
  KVM: x86/pmu: Use pmc_exists in PMC lookup helpers
  KVM: x86/pmu: Expose kvm_host_pmu to vendor modules
  KVM: x86/pmu: Document GLOBAL_STATUS_RESET passthrough erratum
  KVM: x86/pmu: Mark CondChgd reserved in global_status_rsvd
  KVM: x86/pmu: Emulate IA32_PERF_GLOBAL_STATUS_SET MSR
  KVM: x86/pmu: Emulate IA32_PERF_GLOBAL_INUSE MSR
  KVM: x86/pmu: Clamp pmu->version to kvm_pmu_cap.version
  KVM: x86/pmu: Populate CPUID.0AH:ECX fixed-counter bitmap
  KVM: x86/pmu: Factor out fixed counter control bit calculation
  KVM: x86/pmu: Mask only OS/USR bits when filtering fixed counters
  KVM: x86/pmu: Ignore AnyThread bit if CPUID.0AH:EDX[15] is set

 Documentation/virt/kvm/x86/errata.rst         |  10 +-
 arch/x86/events/core.c                        |   8 +-
 arch/x86/include/asm/kvm_host.h               |   9 +-
 arch/x86/include/asm/msr-index.h              |   9 +-
 arch/x86/include/asm/perf_event.h             |  13 +-
 arch/x86/kvm/cpuid.c                          |  24 ++-
 arch/x86/kvm/msrs.c                           |  12 +-
 arch/x86/kvm/pmu.c                            |  85 +++++---
 arch/x86/kvm/pmu.h                            |  54 ++++-
 arch/x86/kvm/svm/pmu.c                        |  43 ++--
 arch/x86/kvm/svm/svm.c                        |  19 +-
 arch/x86/kvm/vmx/nested.c                     |   4 +-
 arch/x86/kvm/vmx/pmu_intel.c                  | 192 +++++++++++++-----
 arch/x86/kvm/vmx/vmx.c                        |  28 ++-
 .../selftests/kvm/include/x86/processor.h     |   6 +-
 .../selftests/kvm/x86/pmu_counters_test.c     |  29 ++-
 16 files changed, 366 insertions(+), 179 deletions(-)

-- 
2.56.1

