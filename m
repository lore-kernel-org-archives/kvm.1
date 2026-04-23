Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579EA397E86;
	Thu, 23 Apr 2026 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966900; cv=none; b=EpRhFjYnYdola5patoetAQfd+iXxn1txSpYjp71eTnD95VyEzdD+8D3Se/7QPK7Hkaz/HeG9wHh38Pr8NdQPydzXZCLjkUh6xuXCg412EBHtRm5jEAVrTC0Pph2tQR1FuJ7tjH9dkmw4j4KlyAuUdIh2DCNYXcAjbjQM+bagLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966900; c=relaxed/simple;
	bh=A7eKDL1lEghbVyapeatXaaY2Zr/Dmz5cGdXXjL30QgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPj5Ye+VlVIbD2mAPaeyXiYfWB12BHPRHmaOXWZDIOf2wH5miWnyyJDLxr0/7l0mNMg4IkAJLCgEL98LJ7h/JL+jM7boO76klf0lWsH+IXsGhpigUqOIYLbB1tv6QGCkb49azic2Z7lQ0NYqF4EGnB1C+J/gOjoZVUbXfI5Bod4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WAYUvlWN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAYUvlWN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776966900; x=1808502900;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A7eKDL1lEghbVyapeatXaaY2Zr/Dmz5cGdXXjL30QgU=;
  b=WAYUvlWNhZi0D0Rgg/e9WgcnirJRlSEiJDaM+GHu5Ielou3/VsDMJI94
   Z1cidz8MDQ9192JRH85aYlmx5CPBq06/FZUBYlT4FavTenfTASh5NB4pO
   3OcRks+1hWFE9WPA2/8YG3TgeFLiME9igJ1mhbB9o4aObLsXSKhYOU4/B
   7rWscqy2S/beOdWJBqkCMrt2U3/CRX8ehbPWXjYMmw6AlgNSc+mwzEENk
   WIct2QEPzj0tUdGjyb9eYZWc7s3g92sJ/k6WO/NTtVTPWifJ72+E+aWnN
   F1bUR9MAgp2YEz+g2R5uJjM7dNYYLr8R5Aj6GLQa2BEt/pwOji+R1OEGD
   Q==;
X-CSE-ConnectionGUID: rQwGBQ7VT9ieGvn8rmMwkA==
X-CSE-MsgGUID: 1NcEubrmSu6eDgIkJW2glw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89407710"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="89407710"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 10:54:57 -0700
X-CSE-ConnectionGUID: uRH/G9Z/RyixQa4wdOFaDA==
X-CSE-MsgGUID: QmBEddkDR16mM6pWbf2BPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="236707809"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 10:54:56 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
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
Subject: [PATCH V2 0/4] KVM: x86/pmu: Add hardware Topdown metrics support
Date: Thu, 23 Apr 2026 10:46:35 -0700
Message-ID: <20260423174639.56149-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Top-Down Microarchitecture Analysis (TMA) method is a structured
approach for identifying performance bottlenecks in out-of-order
processors.

Currently, guests support the TMA method by collecting Topdown events
using GP counters, which may trigger multiplexing.  To free up scarce
GP counters, eliminate multiplexing-induced skew, and obtain coherent
Topdown metric ratios, it is desirable to expose fixed counter 3 and
the IA32_PERF_METRICS MSR to guests.

Several attempts have been made to virtualize this under the legacy
vPMU model [1][2][3], but they were unsuccessful.  With the new mediated
vPMU, enabling TMA support in guests becomes much simpler.  It avoids
invasive changes to the perf core, eliminates CPU pinning and
fixed-counter affinity issues, and reduces the latge overhead of
trapping and emulating MSR accesses.

[1] https://lore.kernel.org/kvm/20231031090613.2872700-1-dapeng1.mi@linux.intel.com/
[2] https://lore.kernel.org/all/20230927033124.1226509-1-dapeng1.mi@linux.intel.com/T/
[3] https://lwn.net/ml/linux-kernel/20221212125844.41157-1-likexu@tencent.com/

Tested on an SPR.  Without this series, only raw topdown.*_slots events
work in the guest, and metric events (e.g. cpu/topdown-bad-spec/) are
not available.

With this series, metric events are visible in the guest.  Run this
command on both host and guest:

$ perf stat --topdown --no-metric-only -- taskset -c 2 perf bench sched messaging

Host results:

# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 10 groups == 400 processes run

     Total time: 1.500 [sec]

 Performance counter stats for 'taskset -c 2 perf bench sched messaging':

     4,266,060,558      TOPDOWN.SLOTS:u              #     32.0 %  tma_frontend_bound
                                                     #      5.2 %  tma_bad_speculation
       588,397,905      topdown-retiring:u           #     13.8 %  tma_retiring
                                                     #     49.0 %  tma_backend_bound
     1,376,283,990      topdown-fe-bound:u
     2,096,827,304      topdown-be-bound:u
       217,425,841      topdown-bad-spec:u
         5,050,520      INT_MISC.UOP_DROPPING:u

Changes since V1:
- As suggested by Dapeng, implement a new selftest patch.
- Don't advertise fixed counter 3 if the host doesn't support it.
- Minor change in patch 1 to remove a magic number.

v1:
https://lore.kernel.org/kvm/20260226230606.146532-1-zide.chen@intel.com/T/#t

Dapeng Mi (2):
  KVM: x86/pmu: Support Intel fixed counter 3 on mediated vPMU
  KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU

Zide Chen (2):
  KVM: x86/pmu: Do not map fixed counters >= 3 to generic perf events
  KVM: selftests: Add perf_metrics and fixed counter 3 tests

 arch/x86/include/asm/kvm_host.h               |  3 +-
 arch/x86/include/asm/msr-index.h              |  1 +
 arch/x86/include/asm/perf_event.h             |  1 +
 arch/x86/kvm/cpuid.c                          |  8 ++-
 arch/x86/kvm/pmu.c                            |  4 ++
 arch/x86/kvm/vmx/pmu_intel.c                  | 57 +++++++++++----
 arch/x86/kvm/vmx/pmu_intel.h                  |  5 ++
 arch/x86/kvm/vmx/vmx.c                        |  6 ++
 arch/x86/kvm/x86.c                            | 10 ++-
 tools/arch/x86/include/asm/msr-index.h        |  1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |  3 +
 .../selftests/kvm/x86/pmu_counters_test.c     | 71 +++++++++++++++++--
 12 files changed, 148 insertions(+), 22 deletions(-)

-- 
2.53.0

