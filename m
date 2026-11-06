Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929838;
	b=m3ySHn6FU89SMYM6mcLok1XUx4kISvNcIadz+IFn3LayaUH5bim3TuSUcsAYtTWj+hBy
	 O2u/j2LnNc0gJV/XF5dDKRD3oNm51z0JHJRN/vbZ5vQviYkf/PU/L5BsPQJfwsquXctO4
	 NSnDKbtd7YFsJxTsgbiY3GtV/YF4iMJg/MaC67LY2AMw3Z5rdRiHzbDgKhrCbnXAtQaEA
	 YKLZhmMNp0AYfUr6CRw78bAKyKKO/11rM5KipAGFaOr4C5cJgmhdqQEKZrpNUyUX0T/Tq
	 Mql+Tu+hnkVMgqve2IoMAx2j9PYhRTg+j2Ocwb4xLMk9J/yI2mn36vcetubEOrrnmPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929838;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4jZpPc3Twsd4wAMcCxc6ikAlk1z7T1HH+IesXoO7C1A=;
	b=whCNmTrSDPOqlZVP7IS9Sca3jRqivBclLwlrX0cL42F9lQS3x9Bux0h9uTLp4vBT2DqK
	 bUWTc1pL/b0YXPVtM6AkZeV/UgXIAEwaR+ojNnVUc7Dwqc89I/pJ+WsuwDIqfT+qtxLLI
	 uAx0R9LKBkdVpmdaL8B724htJQjUs+E9brxwqOia2q+NHo6vc6ZKIeLPevCBQhiDpEGGa
	 +heEaHgEbKO9MiBBlLob3jS/9KP1OjfqJAO95WSjimHSJyHArr1oskJBfsOEIHCxyJOb1
	 huahOq+S/OeBW3qEthxTN0yBSWD2GnGqyFPMmzM65ipIbQQPLSYTCLalXca5U4kazGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mYY3w0yP;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834AD606D823;
	Fri,  6 Nov 2026 01:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 834AD606D823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mYY3w0yP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793929836; x=1825465836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r5qKIA7uZgbkgy5XPfpCBooISiECLswmCwtki0TnTy8=;
  b=mYY3w0yPlhmB1ma90e0TeEJntejVuye38HU5BpavLZZhmejSa8SwnTkq
   4vv1T1N22N06kxp4bj+z03dms1uNo+MDwV0ZN/k9tr8arG7nFLbDqhWhq
   6Kh38pmcoQJ5SAWcxQhLAdmVADzal86gNdBw2tkKZfZrIN70sUpY/ExXj
   DZce3JKupZAWTxY2/JR2SMfpT+ZaKM6MCbKf86qeyXhJ4ryIcGICqnobu
   g+dzorCmyOiR9DlYa8QV9qmuaOgyV7jSVRV/RYYw06zl+UboxiQiNPbu5
   vGJ5mtwDhSgS/5DafZ8ZTpGq6tf8guV12e2jfdcSanBpKgvstL/D/XQgS
   Q==;
X-CSE-ConnectionGUID: WszNx2vGRbu4jFJ3USHmeg==
X-CSE-MsgGUID: dizsrJlURRmwfMJ+dqONSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740168"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2740168"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:31 -0800
X-CSE-ConnectionGUID: ZUqNM1zuQ7uDQZqlzzSdGQ==
X-CSE-MsgGUID: DoomfsTuSVONjpK5zgLxNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067191"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:31 -0800
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
Subject: [PATCH v3 09/18] perf/x86: Remove num_counters_{gp,fixed} from x86_pmu_capability
Date: Thu,  5 Nov 2026 18:39:18 -0700
Message-ID: <20261106013927.166209-10-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106013927.166209-1-zide.chen@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Now that KVM has switched to bitmap-based PMU capabilities,
num_counters_{gp,fixed} can be removed from x86_pmu_capability.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/events/core.c            | 2 --
 arch/x86/include/asm/perf_event.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a9b86cecbc78..990d3be5a07f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3156,8 +3156,6 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	 * base PMU holds the correct number of counters for P-cores.
 	 */
 	cap->version		= x86_pmu.version;
-	cap->num_counters_gp	= x86_pmu_num_counters(NULL);
-	cap->num_counters_fixed	= x86_pmu_num_counters_fixed(NULL);
 	cap->cntr_mask64	= x86_pmu.cntr_mask64;
 	cap->fixed_cntr_mask64	= x86_pmu.fixed_cntr_mask64;
 	cap->bit_width_gp	= cap->cntr_mask64 ? x86_pmu.cntval_bits : 0;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 190fda412a61..17b0bc7dfce7 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -300,8 +300,6 @@ union cpuid_0x80000022_ebx {
 
 struct x86_pmu_capability {
 	int		version;
-	int		num_counters_gp;
-	int		num_counters_fixed;
 	union {
 		u64	cntr_mask64;
 		DECLARE_BITMAP(cntr_mask, X86_PMC_IDX_MAX);
-- 
2.56.0

