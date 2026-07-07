Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2520343F4DB;
	Tue,  7 Jul 2026 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449846; cv=none; b=alFPIIx/IRBwqZ7Vjap1J1h2sU0wHFKnP59LxRC73RxURMWJ4iFdL169sZSjaIY1uihaX2hDGcdQgn4cWR6st98dEgHloN8RHylMTrCuP/qyFz83xU/bIx2BbLKOPdZQ4xx5MqR9Y/PXF0t9O3tAtlIEY6HLME4ztq36Y7LEhwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449846; c=relaxed/simple;
	bh=bAd7NAZB+sBi4f7OBEfbu0uuJf9f+KFUPhs11rbuBPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEkEPU2QpFSP4J8JTtZuPd9kYJJoi4nRKBJszFWxrKRxoOdkk3v0NRN/N27Y4K6jtwsS8VeawQBzU9LB5jqm4fzpw8dC3oHEubwhh6JQf04L6ee9gN4ShhFW/DcJyz9LBZ0yJ3Mp+dYuWI75E+sqFhEk6p1wqiw+ABR9VOvzRRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpxOd3EU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpxOd3EU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783449841; x=1814985841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bAd7NAZB+sBi4f7OBEfbu0uuJf9f+KFUPhs11rbuBPs=;
  b=FpxOd3EUKuqM1900hT1Sy4TUpp2BZtpwJheuqaLeEvygTw5Ld+k9W8NI
   LsLxvOVaUtu5Zj0CjvtRifq0kLtpuXhfm40ES2DbMA35+m1Hbh2vQbjhx
   IJ/CQvuL1lRbYSARYmC59oNPm5UFU7WDSHMH4Ib01h42I/jIHQX0/Hus/
   oZSGSdPcU+WkEoB76W393vORIGaEME4rQhQje2M17KzR2rbQRHw6k/K7R
   ylSU7+J1ecQgeJLsogAvg3EViM+fDsPLpa07JpR0ZDUY7ojgMWsYz526n
   vKILuQ/RIxk9YZQt1obQd8pYg0mHNooRna8n1SNGSKKZBuDYEvo5iPlCz
   w==;
X-CSE-ConnectionGUID: vUKR3gP4RBqgn5WVCeu0+w==
X-CSE-MsgGUID: By/YiR/WRqiqr24GE1PZjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94713876"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94713876"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:58 -0700
X-CSE-ConnectionGUID: 9y9CBWH1RuaPwrcNbn3zrg==
X-CSE-MsgGUID: SJx7aIUaSliQJOocRxA6Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277279298"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:57 -0700
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
Subject: [PATCH 07/15] perf/x86: Plumb counter bitmap from x86_pmu to x86_pmu_cap
Date: Tue,  7 Jul 2026 11:33:57 -0700
Message-ID: <20260707183405.15571-8-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707183405.15571-1-zide.chen@intel.com>
References: <20260707183405.15571-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Intel PerfMon v5 introduced CPUID.0AH:ECX to support non-contiguous
fixed counters and Architectural PerfMon Extension leaf (0x23) further
supports non-contiguous general-purpose counters.

num_counters_{gp,fixed} indicates the total number of GP or fixed
counters, but cannot represent non-contiguous counters.

Add cntr_mask and fixed_cntr_mask union so that KVM can get the
accurate counter availability directly from x86_pmu_cap. The u64
alias is convenient for mask arithmetic, while the bitmap form works
with for_each_set_bit() and friends.

num_counters_{gp,fixed} in x86_pmu_capability will be removed once
callers have been converted to the use of {,fixed_}cntr_mask.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/core.c            | 6 ++++--
 arch/x86/include/asm/perf_event.h | 8 ++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 4b9e105309c6..65349819ba43 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3134,8 +3134,10 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->version		= x86_pmu.version;
 	cap->num_counters_gp	= x86_pmu_num_counters(NULL);
 	cap->num_counters_fixed	= x86_pmu_num_counters_fixed(NULL);
-	cap->bit_width_gp	= cap->num_counters_gp ? x86_pmu.cntval_bits : 0;
-	cap->bit_width_fixed	= cap->num_counters_fixed ? x86_pmu.cntval_bits : 0;
+	cap->cntr_mask64	= x86_pmu.cntr_mask64;
+	cap->fixed_cntr_mask64	= x86_pmu.fixed_cntr_mask64;
+	cap->bit_width_gp	= cap->cntr_mask64 ? x86_pmu.cntval_bits : 0;
+	cap->bit_width_fixed	= cap->fixed_cntr_mask64 ? x86_pmu.cntval_bits : 0;
 	cap->events_mask	= (unsigned int)x86_pmu.events_maskl;
 	cap->events_mask_len	= x86_pmu.events_mask_len;
 	cap->pebs_ept		= x86_pmu.pebs_ept;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index bc2e1cbcd9b9..f59a3d466195 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -302,6 +302,14 @@ struct x86_pmu_capability {
 	int		version;
 	int		num_counters_gp;
 	int		num_counters_fixed;
+	union {
+		u64	cntr_mask64;
+		DECLARE_BITMAP(cntr_mask, X86_PMC_IDX_MAX);
+	};
+	union {
+		u64	fixed_cntr_mask64;
+		DECLARE_BITMAP(fixed_cntr_mask, X86_PMC_IDX_MAX);
+	};
 	int		bit_width_gp;
 	int		bit_width_fixed;
 	unsigned int	events_mask;
-- 
2.54.0

