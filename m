Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516230;
	b=mwYNo9kdpi7FYXq/OSH9uI9VG90I0T8nqOpO9PPoOWl2EJk8K34XK12hs0g6r7Rb4aWt
	 5UB9FMuWJEdIvkRF/6ig6d8brb1YvbIj42Be2PQfH+0AVQqSDFD8J8TVYqIL5YjGd85ZC
	 +8IZ3rzSqsxxQnSwNl+GI7lKc4NpqaMkSp0BF2IPQmWWbJplsmrjlwxydFJvj/WsFdNoY
	 YRW6410nVwkSVz/hZuSR6ApFWkLEy4PNT2wUL7zvzHGUEY2aOJ3L320AeKLvOqL4V02Rs
	 OWcvfGWr5g3HEJJN720Z3UBdMEmApwn3N3Tw/S9yLjYFKRp7N7WeeJstnExhd0KotVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516230;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DpJeVq5Af3h76fC87FYMdmCsO875zyo7iv2ORJR1dp8=;
	b=cR39XYs0c3XmsYwfiOpN63colMa+5fFliya2PgrrKiNFxGqsku4OJluXYKgq2YQms4I8
	 VCwt8j1qmqAqx33MKvXCMLmSoszPeuINFiRsxXruH+Se7aGkeqUDCz8K6H63C8prgpozX
	 PzOw2Z2aW5sFbG5JhAnsp+qwS3an0OfYMSgcLC0fHi7yLEGSPRv7Cnt1/D0FFXQxhzAli
	 mG3ioPGy0/Bo+7lUdD9ahOVJMKsEz8BbaEXJEvHrmNpg9Ec9m9C+z8ffY6XYXlXC2sDVM
	 0w4tgK6bGa9WnorCD4wD2bBx42yKziirwLdh+qKynwXt1DfdaQbZf1WGAddFn6W/7LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Trn40thW;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDCA60A2607;
	Thu, 12 Nov 2026 20:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFDCA60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Trn40thW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516230; x=1826052230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QJTc4D297zDURXjoyOpF1vj7y3gLtfhEpzDS1BjmDpw=;
  b=Trn40thWAtiiFYEDJtCd1+1nrL/M+/juFw/VSah7weZNyp5eE4gB5Pij
   i439mlq4glN47AJ6O+ALT8+D1VJ2itVlO4fCF9e8ADq99Wm11rz0AfEvz
   tG8qNsFsjoWw4S1tdD9UOIjlEiePwOHr0iAjqGbNd4qL0AXQDihEOghLL
   hiqLx9SVali/QVF+0NKZF82awEf/oA21CijpaL7ryzJy71LybqlubqjD9
   /zqVGTHR/hqbFiHiy4UvCuyfqyFGkNzrWn7bsDKhmJxz05jJX5dPdxwHo
   ZQUHYp3CbGpiuXC+EX51v/YeCz46vLWUdYnfcYCpwineODO4E40W2gRC7
   g==;
X-CSE-ConnectionGUID: +QxRhFJBT/qzK4isOtFFXw==
X-CSE-MsgGUID: IzORqreEQcGSRfK0O1GvQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192270"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192270"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:49 -0800
X-CSE-ConnectionGUID: yXJA2m2bRICAIEl7pi8k2Q==
X-CSE-MsgGUID: 9+qFgqOrTtScdtPGtmMenA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087900"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:49 -0800
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
Subject: [PATCH v4 10/21] perf/x86: Remove num_counters_{gp,fixed} from x86_pmu_capability
Date: Thu, 12 Nov 2026 13:32:16 -0700
Message-ID: <20261112203227.289379-11-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261112203227.289379-1-zide.chen@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
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
2.56.1

