Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B853DEAC8;
	Thu, 27 Aug 2026 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870895; cv=none; b=AvsYiBaXM9H2sBQY+HL+BD9dMRGIIryD+StYC0XkJDCrLboYf24f4BuFLPVrr1+zVetsLxaKzI+dcbqia9E2Joouh1ZiXgxQZYhUiCM78d92hX3lrQI6alJO2n7YO5XtO00ld4dks+EAk6XJSCEpodVUPiF+h+P6CjSjfDIvY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870895; c=relaxed/simple;
	bh=pdQgtwbm7kwg34EBjPezIBxvaf/T8RNjPDPaXxgaEiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXG46+EI9LpyY1zfQfGkQsHXA2Gm9EI9nueT88E/FuHjwda5acRMqLfSZ2Yd4TTYxFum0EFHoCdl4ErfD5rlWQ4bj56UBy2Adskba428be/NVI64xu+Q5L1YvAMWulXGZnygLvuG5UxY4fxd/zDj2++MRuwx/6fY4HJWFzFPTks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoowsMMw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoowsMMw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787870893; x=1819406893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pdQgtwbm7kwg34EBjPezIBxvaf/T8RNjPDPaXxgaEiU=;
  b=eoowsMMwcfWW81zAS9UQTtv39Tg3kb1z3q5L5Xq0tOy9pFtKfnIZLVSG
   0MF2sRhMee9f8xVUWoRLFfM9xOtNEFGMGor844DAnAjIw/1PJVJK1lXHf
   1qeMqp5Bs8Un8o2ZhEL36IEpG0Hf+1vfktT1K0jDxhSHyKWOFr86QUNbr
   Gf0irnohdeoFfAjmZu5gozUVsKZX8RXA3c39eZzmbcwy3xkUCUH/nijEm
   oqvUib7ZqohBcY6K+n9W8dNVTi+fGWUwgMC1kunAGKZ29FxxTRiaCPq2V
   quEOAH2W1xnUQeeN63nhqEHmIqRZwqZxni3dav3vw9PrSdDHVtvthQY30
   A==;
X-CSE-ConnectionGUID: Am1CI3P9RjmmhL4pt/xHlQ==
X-CSE-MsgGUID: qV9VgLq1S2OGMflQsNwYvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113914875"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="113914875"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:08 -0700
X-CSE-ConnectionGUID: BzXLXko1TcaytLEV7L3b6Q==
X-CSE-MsgGUID: e3DXrF6LTJ+5yoREdeM5Kg==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:08 -0700
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
Subject: [PATCH v2 10/16] perf/x86: Remove num_counters_{gp,fixed} from x86_pmu_capability
Date: Thu, 27 Aug 2026 15:37:49 -0700
Message-ID: <20260827223755.143247-11-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827223755.143247-1-zide.chen@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Now that KVM has switched to bitmap-based PMU capabilities,
num_counters_{gp,fixed} can be removed from x86_pmu_capability.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/core.c            | 2 --
 arch/x86/include/asm/perf_event.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3fb95090cd8f..9b6df8bc9059 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3132,8 +3132,6 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
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
2.55.0

