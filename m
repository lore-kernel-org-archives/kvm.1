Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929836;
	b=wsTWcDGtNLVi57+EV9Qq3tta1yLrzI0LRzuqhb91jxe9ifrcCiWCvk31eOWzXYt/GvsU
	 D9Rq9ptxcFsCDMs5UB3ipPhq0mX5BhvesQS1k7MebmGWedH8qNmKEgZ3YhzhlxYhSLNJ1
	 XYSLTFTYgt/ZIhILuox2EmrL1UqvFv8g9zkKnZMKjD5djeGy6xpHIXaiB8C3z0jJVra0T
	 9goQvqHaf4Kw2GKt4HC6+629BYwoNcTGzDyHTosJqwi6UHNUdHwbT1C3VkGzznyIT9xCL
	 lffQgPpuQTCSHf/Z81Zbd6c+P4k1S630sUJXNFS7Aq246hxr+akyt05GKk/F6a0KCPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929836;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XYXSU5YCe9MOcEgYXUReIi0YUQ/NybvbEr6QtqQf7mY=;
	b=qIaFnJLd+hdIaA5Ia2yppli2/V9+RPjyL85vMrhrXZSldIWfXnluj9p65joTFzUVOYqM
	 WOaitk7LTI7Pnc+wMrGjbbHBV8ZtTxFflNrH5o/PfzEUbzWGbGuOFsgLnwM7fhcpWfoMZ
	 K9HhZN2hEnDOSvN8ykp//gWc1U8mO6Bm8bOpmHLcmZ7FRDtVE5IzLNTWDiXdvKe3ZSTLx
	 lZvNVBn0qE2uVqpvYv9ypyRu96UKZAq3IGhspWh1gSLqE1e9hFERtSTlnsmApYpahUH9B
	 /084YDNha2hOB95GDuQH3E8mhCiDrbkje9ld1m2F4CsUwKGIbyIKmDyTCApMOqPhsOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j3umM6pW;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195A606D805;
	Fri,  6 Nov 2026 01:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9195A606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j3umM6pW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793929834; x=1825465834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2PZ3JWtGfVKnzU3rfy0r80Kp/73BnaHumVbsdybFlsw=;
  b=j3umM6pW0irIkA4eNGHIw3qAg8pqS6HY53Fl8A/r/Fg/vNakAW7D9tgl
   twiIvV9sC3QzsbtUfeUGguo9UGYpuLvKfvGyxDlJukcq4pV0tmaFzWr4E
   MsdguJK1JCmpyl6V5hHpWWXmMsx26AHfXwffIM7DepgIzlgBmwGSGZLEb
   kbgRXyfGqNuEpoD065ymfUwbBnIP5UgDG3bVTJI2hFsL8SqzfDCnZbo6s
   FfYfSUqtJ/QVfSp7XplOhLMzHRo7WFvdfVtjxMUUBRYuK3W24EcUGexWP
   VvBVDSO7NcZPCFW24f0aTURzg3ALTR4TIxPgEkPqzfh41tK4fSEaZhlsJ
   A==;
X-CSE-ConnectionGUID: lhIxOlAcSCWJ7VsmJuxqUw==
X-CSE-MsgGUID: o6W4lgGDQweq2zRL4/c6TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740149"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2740149"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:31 -0800
X-CSE-ConnectionGUID: EszM162yQcyfBmUb6rQakw==
X-CSE-MsgGUID: FtT4vkR6TJWr5T0T2HEUdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067185"
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
Subject: [PATCH v3 07/18] perf/x86: Plumb counter bitmap from x86_pmu to x86_pmu_cap
Date: Thu,  5 Nov 2026 18:39:16 -0700
Message-ID: <20261106013927.166209-8-zide.chen@intel.com>
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

Intel PerfMon v5 introduced CPUID.0AH:ECX to support non-contiguous
fixed counters and Architectural PerfMon Extension leaf (0x23) further
supports non-contiguous general-purpose counters.

num_counters_{gp,fixed} indicates the total number of GP or fixed
counters, but cannot represent non-contiguous counters.

Add cntr_mask and fixed_cntr_mask unions so that KVM can get the
accurate counter availability directly from x86_pmu_cap. The u64
alias is convenient for mask arithmetic, while the bitmap form works
with for_each_set_bit() and friends.

num_counters_{gp,fixed} in x86_pmu_capability will be removed once
callers have been converted to the use of {,fixed_}cntr_mask.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/events/core.c            | 6 ++++--
 arch/x86/include/asm/perf_event.h | 8 ++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8b3ea0adb965..a9b86cecbc78 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3158,8 +3158,10 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
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
index 1eb13673e889..190fda412a61 100644
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
2.56.0

