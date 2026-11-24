Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557209;
	b=EjOaMZhFz0iz5uMSOlca0ZMSvNPu/GQzOg2XZ4T5K4/6Bwx1o8spbVTG4DLU8AOqXzJv
	 1XsT+jXgyuwWWKv8NHOyHFibKD4y2NXArPwEgjflRXYiZg6LSj/megTT08bBaIAADfGXD
	 mRkDx4bOdPFD9dk48/NMKq5vz/NqnjMFTfyTnET31D33SvxNpTr20qynn6VspNYs/V6j2
	 cTyROtXzSxG+UrYW5icMh+XzLZf5lhB0kU3Cot8Gxdfn39voYuwKupyNGC+hx/p3QrkMZ
	 HOy9YlhB+kG//orGu7NwhU+D2tUzAYTfM8LK2Awugc7cE1uQgMjpklG5TLWavgr81BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557209;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aotclqhdndvK4gXJTX/iIflcOiMQyXEw3arFJij313E=;
	b=pIg/QJDNlMVPWrQYy8PZ7RYXGk3amv71dmRMZBqDUPo7VuS74c62Cvtkka09i3QOEJGJ
	 0lGl+D5JDL59Yew6/3WdjNCfJA2WuRzwaE8mGO6QawrHULdLI2C1i8xEVLfmF9PMG5FAR
	 eQFhNJlvo5/n33JtIaketADkTs7Ff/C/8pw9GHn2eVKW3XW/csdkjXzzbG37Zo51AhGbF
	 DjV5NMo/T0JUbNKVvWCN3g9QQWp0X4xx7+OZxeO+z/sEz/pXC2imyr6noXmX8xzMshweu
	 wCJglaINCkrNHgLq/KXW7re9zRISzbahkG9QCjHgibr/t+/MpDhEx+xxYUazQMSZMNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mw6avn2E;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3127B606A33C;
	Tue, 24 Nov 2026 21:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3127B606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mw6avn2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557204; x=1827093204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bvVw9joxXVs8F5YbekKVK2a5xDmW5WhfeJqqB/4/oQU=;
  b=Mw6avn2EiwTNpj9dJeP7MlfU3Xaq9DRfZIrEQM6WLWGGvXUwZ0ZC1dGO
   FnoYHPXosnHWi/CD9TLcPT08CwSTtSdk8PNp/FyelXHfEsbLyOiVWf8/F
   eGCXrrxbfWjGRjnHnopd6VDdUiUcIObyhR43oa9qYuNJGpf/W74Z/Oy3z
   O3owRylMJYqs6Xbpih7ZbNiuoR3niGpC/iGvcxKEY/w784kJc3IuibrCY
   6Wr8w6kdiiRqMu38KFCqvShXtxLRwBjf+EcfyjPDjCjhUzudkiIu0Xoto
   v9M8xrfbXQ9eUvmIuZ37rcsd8rMSYojPB9CGBxmggpm+Dazzo0NEYSAkl
   w==;
X-CSE-ConnectionGUID: YKtHnmlFTRCK8bdowKXi7g==
X-CSE-MsgGUID: mpQdy/wcQt+J6KZdgDwH0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4305973"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4305973"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:22 -0800
X-CSE-ConnectionGUID: lF618NQbR9yOy2LNHszlEQ==
X-CSE-MsgGUID: +49kGHKeRaCh6DdYjyV/cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271889"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:22 -0800
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
Subject: [PATCH v10 01/18] perf/x86: Add INTEL_TD_METRIC_FIELD_{BITS,MASK} constants
Date: Tue, 24 Nov 2026 14:38:44 -0700
Message-ID: <20261124213901.120572-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124213901.120572-1-zide.chen@intel.com>
References: <20261124213901.120572-1-zide.chen@intel.com>
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

Replace the hardcoded field width (8) and the equivalent 0xff mask
used for PERF_METRICS MSR field access with named constants
INTEL_TD_METRIC_FIELD_{BITS,MASK}.

KVM will use INTEL_TD_METRIC_FIELD_BITS to derive the reserved bits of
the PERF_METRICS MSR.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
v10:
- Keep literal 8 for umask shift in INTEL_TD_METRIC_AVAILABLE_MAX. (Sashiko)
- Sync icl_get_metrics_event_value() comment with INTEL_TD_METRIC_FIELD_MASK.
v9: new patch.
---
 arch/x86/events/intel/core.c      | 11 ++++++-----
 arch/x86/include/asm/perf_event.h |  4 ++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1ac2ca35db53..c76d9aa8e5eb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3180,15 +3180,16 @@ DEFINE_STATIC_CALL(intel_pmu_set_topdown_event_period, x86_perf_event_set_period
 
 static inline u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
 {
+	int shift = (idx - INTEL_PMC_IDX_METRIC_BASE) * INTEL_TD_METRIC_FIELD_BITS;
 	u32 val;
 
 	/*
-	 * The metric is reported as an 8bit integer fraction
-	 * summing up to 0xff.
-	 * slots-in-metric = (Metric / 0xff) * slots
+	 * The metric is reported as an integer fraction
+	 * summing up to INTEL_TD_METRIC_FIELD_MASK.
+	 * slots-in-metric = (Metric / INTEL_TD_METRIC_FIELD_MASK) * slots
 	 */
-	val = (metric >> ((idx - INTEL_PMC_IDX_METRIC_BASE) * 8)) & 0xff;
-	return  mul_u64_u32_div(slots, val, 0xff);
+	val = (metric >> shift) & INTEL_TD_METRIC_FIELD_MASK;
+	return mul_u64_u32_div(slots, val, INTEL_TD_METRIC_FIELD_MASK);
 }
 
 static u64 icl_get_topdown_value(struct perf_event *event,
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 1eb13673e889..ca630bc282fb 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -418,6 +418,10 @@ static inline bool use_fixed_pseudo_encoding(u64 code)
 #define INTEL_TD_METRIC_MAX			INTEL_TD_METRIC_MEM_BOUND
 #define INTEL_TD_METRIC_NUM			8
 
+/* Width and mask of each metric field in the PERF_METRICS MSR. */
+#define INTEL_TD_METRIC_FIELD_BITS		8
+#define INTEL_TD_METRIC_FIELD_MASK		GENMASK_ULL(INTEL_TD_METRIC_FIELD_BITS - 1, 0)
+
 #define INTEL_TD_CFG_METRIC_CLEAR_BIT		0
 #define INTEL_TD_CFG_METRIC_CLEAR		BIT_ULL(INTEL_TD_CFG_METRIC_CLEAR_BIT)
 
-- 
2.56.1

