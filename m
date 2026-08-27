Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB4C3DCD95;
	Thu, 27 Aug 2026 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870894; cv=none; b=LT7Mc3SZN5vbMRBdpxGY/A4JyKGmvdNn4H7tXKHWnN1WVxvolljxqOrKBN0U9sOWSdc9y5xDmm/x+NN4KyAtmNXid+P52e/RW0j6+JAM7k+TVNQVZKv5lS3Z0boTi3wuMn9E3TaFfJvGgiXekwCzv0nhq0+HQI1LuK49Cek+IO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870894; c=relaxed/simple;
	bh=RebNirz0nqQVek2+Y95XS0cMkJKyoGFDyz2cO9yeT6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9Hkn5IQ6iITGwp+hZ6k1ba6ziOa0fG6n7hqo/BBWgeP2imVixLcrvUtWDOdayn0/XXyMGUStetYlCP/KUhLviKDoJgUDzmdyALSzIH0MZth4tevtj92DpHRhUBwziEP6W+6j9XbW+yCMPtwjzZA6HebA8L72iqmD7aeEIf9kcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EiQwc5Fl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EiQwc5Fl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787870892; x=1819406892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RebNirz0nqQVek2+Y95XS0cMkJKyoGFDyz2cO9yeT6o=;
  b=EiQwc5Fl0wjOq1EzvKK8Qk6Df1+q3rbhvP9PFMizOQXUcrCrgA2fROge
   792FUqdy3t4lsTXV7hUH59keWRU2GEaih/J3dNo3Ufk87fs05lbvs+W7i
   iF8HUvLTWWyi1NfBBA0lrmM7y4fl8KSstBnWJVp2iFWsiTSbxCchUrlGg
   xzWpC2yQBoP+u7iHa5OEcb8YJxpqkyGjYvprOQqxHnle6Lir7bmNzRSwi
   mMfxg4XVlS8V9zwpVM+zkG3SsILIDAiDo7jYPBQIe/yt9+9RM5xQSBGQA
   yoemkcxZeYshRshRuDd6ZunzUDDSFas7orT4pGdDdCRllclTbBIYDZRx2
   w==;
X-CSE-ConnectionGUID: aVVEKuCMRxGrZBY2cgC7Wg==
X-CSE-MsgGUID: QmjlotJ9SM+V+Gfrq4ZTig==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113914864"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="113914864"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:08 -0700
X-CSE-ConnectionGUID: bHxtJIkdSYu6b+eWjqqf0w==
X-CSE-MsgGUID: Qecz9v34RtaqGbcEtZ/RXg==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:07 -0700
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
Subject: [PATCH v2 08/16] perf/x86: Plumb counter bitmap from x86_pmu to x86_pmu_cap
Date: Thu, 27 Aug 2026 15:37:47 -0700
Message-ID: <20260827223755.143247-9-zide.chen@intel.com>
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
---
 arch/x86/events/core.c            | 6 ++++--
 arch/x86/include/asm/perf_event.h | 8 ++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d1af33d96d0a..3fb95090cd8f 100644
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
2.55.0

