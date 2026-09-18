Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED782522F1F;
	Fri, 18 Sep 2026 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761018; cv=none; b=KYo/oWGcGaLJJo6uOPHmcuvCwxr09+uximY0Tc7drHjRlHHXnYJSrW17SvLmxmA8wYtgg82AlsCLPdGsSu+9wwdKxUBXiHnrmTYtoCYJCREG4BLzpEZNvke5MvitmWo6lipXILXk2CBSdZykF86NlGAnpCBVuaGqBFDHnKoKBCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761018; c=relaxed/simple;
	bh=GZuY32usYhBetUpdyv8Ff5pn9yw2EDH67ww5LOQgt1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KG67NuKfvYfTMQl0vzmXk45HZ1Y3pkN4ngSdIzuYAWTIuEdovFDaP0r0WDRC2FluGJ7fhfS4jzipsHqur6FKZnVrgSgTw4lFxra2ddJ/ERzcCZk14FdsB2JJAvXekL71JXVIFtNBW/cc9rdt2S6nLWcfOT5EheEVPOqx3khgY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWQ6MLXc; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWQ6MLXc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789761009; x=1821297009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GZuY32usYhBetUpdyv8Ff5pn9yw2EDH67ww5LOQgt1A=;
  b=AWQ6MLXcRkR/DBqDT2imQBQO8uqfPwlbtre+4nO38e/nqJ+TUvGllaqY
   0JdWO4fWD/zDT8zXP1LNpD6D+UN8yuLSJ9a711tvHxtGLQlsJTJXHPrsk
   XRM7s89L7qXhAhH4jZHuzs3ggdqiqenRR/V69HuamY9pSo52QMCiDkbm/
   mwEMAgaXejsge11+jJzwixFlu/1SHm5fFJFUBDVQyCYtrSRfJw0QYfHHD
   2a43RqDD92WLUCdqAxvFpvDHw+om6cQBObWoGrIFqDGcr3w1UAPfxliiw
   J4jCX1XrkouvtExYsfOIHUvSqow/dtGET5hN3mDXFey6Pfz1KhjujExLf
   w==;
X-CSE-ConnectionGUID: aVy/1JLrRvWasFPNeT42Yw==
X-CSE-MsgGUID: 5UamwmOdRnySoCpC7mnUig==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="790329"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="790329"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:50:01 -0700
X-CSE-ConnectionGUID: 3UAtY4YLR+WJ7pVLnV1yDQ==
X-CSE-MsgGUID: ZSTkiw0IRmWQGCF97oycdA==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:50:00 -0700
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
Subject: [PATCH v9 09/12] perf/x86: Add INTEL_TD_METRIC_FIELD_{BITS,MASK} constants
Date: Fri, 18 Sep 2026 12:39:34 -0700
Message-ID: <20260918193937.569414-10-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918193937.569414-1-zide.chen@intel.com>
References: <20260918193937.569414-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the hard coded field width (8) and the equivalent 0xff mask
used for PERF_METRICS MSR field access with named constants
INTEL_TD_METRIC_FIELD_{BITS,MASK}.

INTEL_TD_METRIC_FIELD_BITS will be used by a subsequent KVM patch to
validat reserved bits in the PERF_METRICS MSR.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
v9: new patch.
---
 arch/x86/events/intel/core.c      | 8 +++++---
 arch/x86/include/asm/perf_event.h | 4 ++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cc13164d948f..cbc9a179f2e5 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3159,6 +3159,7 @@ DEFINE_STATIC_CALL(intel_pmu_set_topdown_event_period, x86_perf_event_set_period
 
 static inline u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
 {
+	int shift = (idx - INTEL_PMC_IDX_METRIC_BASE) * INTEL_TD_METRIC_FIELD_BITS;
 	u32 val;
 
 	/*
@@ -3166,8 +3167,8 @@ static inline u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
 	 * summing up to 0xff.
 	 * slots-in-metric = (Metric / 0xff) * slots
 	 */
-	val = (metric >> ((idx - INTEL_PMC_IDX_METRIC_BASE) * 8)) & 0xff;
-	return  mul_u64_u32_div(slots, val, 0xff);
+	val = (metric >> shift) & INTEL_TD_METRIC_FIELD_MASK;
+	return mul_u64_u32_div(slots, val, INTEL_TD_METRIC_FIELD_MASK);
 }
 
 static u64 icl_get_topdown_value(struct perf_event *event,
@@ -4742,7 +4743,8 @@ static int core_pmu_hw_config(struct perf_event *event)
 }
 
 #define INTEL_TD_METRIC_AVAILABLE_MAX	(INTEL_TD_METRIC_RETIRING + \
-					 ((x86_pmu.num_topdown_events - 1) << 8))
+					 ((x86_pmu.num_topdown_events - 1) << \
+					  INTEL_TD_METRIC_FIELD_BITS))
 
 static bool is_available_metric_event(struct perf_event *event)
 {
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 1eb13673e889..ceb6188e5217 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -418,6 +418,10 @@ static inline bool use_fixed_pseudo_encoding(u64 code)
 #define INTEL_TD_METRIC_MAX			INTEL_TD_METRIC_MEM_BOUND
 #define INTEL_TD_METRIC_NUM			8
 
+/* Width, in bits, of each metric's field within the PERF_METRICS MSR. */
+#define INTEL_TD_METRIC_FIELD_BITS		8
+#define INTEL_TD_METRIC_FIELD_MASK		GENMASK_ULL(INTEL_TD_METRIC_FIELD_BITS - 1, 0)
+
 #define INTEL_TD_CFG_METRIC_CLEAR_BIT		0
 #define INTEL_TD_CFG_METRIC_CLEAR		BIT_ULL(INTEL_TD_CFG_METRIC_CLEAR_BIT)
 
-- 
2.55.0

