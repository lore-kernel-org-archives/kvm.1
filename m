Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7D1E492D;
	Tue,  7 Jul 2026 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449838; cv=none; b=mrnLWpOur7gAUgjU9UlfAq6nCi33A6LZSM+bFZ9GL7gsRTszRfjb2oPOGDQpT6En/1Oy/occId8YVCbAfudGoapWYBa2cAK1roX8c4YQco3S3FiitDJJckvAdi6+Asb+P9E3HNAOOOjAoeIFZXEfFDXzynoaWJYKAJXzFsL4lL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449838; c=relaxed/simple;
	bh=0q5QCDD31MCEgfWpZcUL0mLACaFNqTXCr5DiRT4oX1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gR4iq1EfZ+aU9PVenqjBbunBAWK9OKUBsfISprUva+2OFcDKt7UFOWVvMdgn3ropz8igSasWfmZGvsakMasj0S/fdW9NWrctIXj7EVFTnyMOZw65FmbA7MyaKm2gjmlniGV2DTag+1mTFOuOv7cGQegiiUbK4h2obGnH8WwN0sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XA1gwknX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XA1gwknX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783449837; x=1814985837;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0q5QCDD31MCEgfWpZcUL0mLACaFNqTXCr5DiRT4oX1Y=;
  b=XA1gwknXvcMZk5eNwo+DsTFFSw7F5fLPuKKKcMq8SyOZnUtgO8rrnKN6
   UaUX3qVXk3wYx4npRR6jyfQgGN6G58aj/X3lezXEwCjjXKYjjYNbVW+Tq
   HbVSlytMSu/ndNUPYN4tCNWpve9D8vnj+fmnFTAGR6iMgkjpWSfXUk01I
   ZSmjO1xBIrQ/tcUlX+/AKRWIuM3J49YUvu0WYRbEmk5INnrjbG5HsQK0q
   asjNeoHa2Mp0RJLfG2W1lqVqPf7VRcRBSGG89eLBfZxGhHVHlfJVXwu+L
   HNpzC/lYzsoGm98NPUtMdmdz5UPWQd3Pw5BLvWK5EUxANPnO39qmdKKYr
   g==;
X-CSE-ConnectionGUID: 8jzB2ZHbRnujKlZq1iKcuA==
X-CSE-MsgGUID: eVoK6hkPT4WXQhaqbpSFKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94713841"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94713841"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:56 -0700
X-CSE-ConnectionGUID: mW9GyqnLTkKD0+c5+NtQWg==
X-CSE-MsgGUID: aDHcgRzjRIWow6uy+WIRKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277279277"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:55 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH 00/15] KVM: x86/pmu: Add mediated vPMU PerfMon v5 support
Date: Tue,  7 Jul 2026 11:33:50 -0700
Message-ID: <20260707183405.15571-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
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
- Add support for streamlined Freeze_LBRs_On_PMI.
- Implement ANYTHREAD_DEPRECATION capability.

Intel PerfMon v5 doesn't support non-contiguous GP counters; however,
this series lays the groundwork for GP counter bitmap support anyway,
for consistency with the host perf API interface, and prepares for
perfmon_mask support.

Freeze_PerfMon_On_PMI virtualization is not implemented because as
commit 3daa96d67274 ("perf/intel: Remove Perfmon-v4 counter_freezing
support") states, the Freeze-on-PMI mechanism violates the perf counter
independence.

Patch series summary:
patch 1-3: Code cleanup: rename and remove redundant definitions.
patch 4-9: Implement PMC bitmap support.
patch 10-13: Implement PerfMon v3-v5 new features.
patch 14: Advertise Perfmon version up to v5.
patch 15: Fix pmu_counters_test selftests fixed counter test case.

This patchset is on top of the Topdown metrics patchset:
https://lore.kernel.org/kvm/20260629231938.15129-1-zide.chen@intel.com/T/#t

Dapeng Mi (6):
  KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters from kvm_pmu
  perf/x86: Plumb counter bitmap from x86_pmu to x86_pmu_cap
  KVM: x86/pmu: Switch to bitmask-based KVM PMU capabilities
  perf/x86: Remove num_counters_{gp,fixed} from x86_pmu_capability
  KVM: x86/pmu: Advertise PerfMon version 5 on Intel hosts
  KVM: selftests: Support fixed counters bitmap in pmu_counters_test

Zide Chen (9):
  KVM: x86/pmu: Remove redundant Perf Global Status MSR bit definitions
  KVM: x86/pmu: Rename all_valid_pmc_idx to all_valid_pmc_mask
  KVM: x86/pmu: Rename reserved_bits to eventsel_rsvd in kvm_pmu
  KVM: x86/pmu: Add PMC bitmap accessor helpers
  KVM: x86/pmu: Expose kvm_host_pmu to vendor modules
  KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and GLOBAL_INUSE MSRs
  KVM: x86/pmu: Emulate streamlined Freeze-LBR-on-PMI
  KVM: x86/pmu: Populate CPUID.0AH:ECX fixed-counter bitmap
  KVM: x86/pmu: Ignore AnyThread bit if CPUID.0AH:EDX[15] is not set

 arch/x86/events/core.c                        |   8 +-
 arch/x86/include/asm/kvm_host.h               |   9 +-
 arch/x86/include/asm/msr-index.h              |  12 +-
 arch/x86/include/asm/perf_event.h             |  10 +-
 arch/x86/kvm/cpuid.c                          |  19 +-
 arch/x86/kvm/msrs.c                           |  12 +-
 arch/x86/kvm/pmu.c                            |  86 +++++----
 arch/x86/kvm/pmu.h                            |  56 +++++-
 arch/x86/kvm/svm/pmu.c                        |  31 ++--
 arch/x86/kvm/svm/svm.c                        |  14 +-
 arch/x86/kvm/vmx/nested.c                     |   6 +-
 arch/x86/kvm/vmx/pmu_intel.c                  | 167 +++++++++++++-----
 arch/x86/kvm/vmx/vmx.c                        |  19 +-
 .../selftests/kvm/x86/pmu_counters_test.c     |  25 ++-
 14 files changed, 319 insertions(+), 155 deletions(-)

-- 
2.54.0

