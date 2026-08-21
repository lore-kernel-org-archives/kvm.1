Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802F39E9AD;
	Fri, 21 Aug 2026 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351452; cv=none; b=gb86CnXcog1L7W9dIZczxTkU4rHW7uE1VYB9Q25AbC1E1AoxNUF6RsHymjbeEG1nErLRub/t365Z1Evnp9xqfjK5+ezFGGPD4eDqJMl10RKCXNZJroEuQB9o4RnQt88YhbMtahuurs9KTCQOhlmpQRpk2JgHC3XYRJ2zL8GgAOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351452; c=relaxed/simple;
	bh=PD8KctQNaLDEmCPeGcDwQh2kuLZ8ek+Ya0IhMvC76n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyyn6pPufrPZJ4cz1hhKFATcyzB5ziUY4xN1MkZ1UYpeWletskW4GlbDfoSXLuZfuQm3yj5ByguFwOxZ/k7j8xX1dvrCkaALU7fEg08oWBHK/Fw7fNTLScstRy6Lw88bQnui7kKrw/2Kvl2EpK83A3AxkatKF2RUpHuhoBiN0u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTAQ9xAr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTAQ9xAr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351448; x=1818887448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PD8KctQNaLDEmCPeGcDwQh2kuLZ8ek+Ya0IhMvC76n8=;
  b=lTAQ9xAr0kWu0sePSFFt9epX/2SZELYeDs3GyoFPgf1vcYZMQkW3O20n
   SvkEvQrJ6kpz+y5t+EVvREkCkn39/okPy0c1Udwg7jdh+mZ+qfzSjwzgX
   3K+k3kuKd4Q+xTHclhfsAJKUNTeQXPWXfnh+A6JofiYIXoGViLlU1DoWq
   +tMi6wUvVabs+p/Z2h2CWHOKlLSkVURjiyKAjq1BjrgfBcikp//iR8l5J
   NtUYNjp6HpjTsHEWGFdDBaAN86fO63ye+GR3xbUpJPX5Xvcb2ztNTV1PD
   x4IBN7elk3mBtJ65TVjSmuj6PxVkRezOcc+5f36MuNUzNWEL72mH/skfx
   w==;
X-CSE-ConnectionGUID: 3R5qtUtZRQGPmRQ8np86xA==
X-CSE-MsgGUID: fDvGhB9AQTS49jljcGtmng==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032583"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032583"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:46 -0700
X-CSE-ConnectionGUID: u6FK1YkBSyyOArQ0g39l3A==
X-CSE-MsgGUID: DOkPXannRF6L2LbOepLdbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679743"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:45 -0700
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
Subject: [PATCH 05/23] perf/x86: Allow exclude_host events to run in non-root mode
Date: Fri, 21 Aug 2026 15:19:44 -0700
Message-ID: <20260821222002.54907-6-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821222002.54907-1-zide.chen@intel.com>
References: <20260821222002.54907-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Intel, exclude_host events are prevented from running by masking
the Global Ctrl bits with ~cpuc->intel_ctrl_guest_mask.

When PMU partitioning is enabled, the host is allowed to run
exclude_host events in non-root mode, while such events still need to
be masked in root mode, since there are no other checkpoints to stop
them from being scheduled in.

Add x86_pmu_partition_loaded() to distinguish scheduling constraints
from x86_pmu_partition_nmi_active(), as PMU partitioning constraints
apply in both the _PARTITION_PRELOAD and _PARTITION_NMI states.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/core.c       | 11 +++++++++++
 arch/x86/events/intel/core.c |  6 ++++--
 arch/x86/events/perf_event.h |  1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index bbae68c49063..76af9cfaf0ad 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1813,6 +1813,17 @@ bool x86_pmu_partition_nmi_active(void)
 	       state == GUEST_PMU_PARTITION_NMI;
 }
 
+/*
+ * Skip for "fake" cpuc used during event validation, where
+ * per-CPU state like guest_pmu_state is meaningless.
+ */
+bool x86_pmu_partition_loaded(struct cpu_hw_events *cpuc)
+{
+	return !cpuc->is_fake &&
+	       pmu_partition_configured() &&
+	       this_cpu_read(guest_pmu_state) != GUEST_PMU_NONE;
+}
+
 u64 x86_pmu_current_partition_mask(void)
 {
 	return this_cpu_ptr(&cpu_hw_events)->partition_mask;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c595c86ecf90..894f98eb871a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2812,8 +2812,10 @@ static void __intel_pmu_enable_all(int added, bool pmi)
 		cpuc->active_fixed_ctrl_val = cpuc->fixed_ctrl_val;
 	}
 
-	wrmsrq(MSR_CORE_PERF_GLOBAL_CTRL,
-	       intel_ctrl & ~cpuc->intel_ctrl_guest_mask);
+	if (!x86_pmu_partition_loaded(cpuc))
+	       intel_ctrl &= ~cpuc->intel_ctrl_guest_mask;
+
+	wrmsrq(MSR_CORE_PERF_GLOBAL_CTRL, intel_ctrl);
 
 	if (test_bit(INTEL_PMC_IDX_FIXED_BTS, cpuc->active_mask)) {
 		struct perf_event *event =
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index d9875f3e6c8c..fa3023c355d5 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1610,6 +1610,7 @@ static inline int is_pebs_pt(struct perf_event *event)
 
 bool pmu_partition_configured(void);
 bool x86_pmu_partition_nmi_active(void);
+bool x86_pmu_partition_loaded(struct cpu_hw_events *cpuc);
 u64 x86_pmu_current_partition_mask(void);
 
 #ifdef CONFIG_CPU_SUP_INTEL
-- 
2.55.0

