Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516229;
	b=CufITJqgUxITccho9c7pHhS+VrzqfoymOpMAbvqPQ/I9h5uNos/y6csmcvV/30np1PtF
	 xeYfjI3jxjL14RqYi8h7wVVjE6uMFr1VfVRp7J348aZfaCHFD6TaGs65Xboz8okh/2cQV
	 HrG/k7dD7MuO/f9b8eqiCwCqhOTxpntrgD1XPQqwnTpYR7z4mtiovpSPopJaphoOkBTqf
	 s0l9dvhZWCQdHBeOMEhUxYT8vARD8JCv8HTaF6/XkK7C3/+eowqam3HWq/8/8cz7URoPe
	 hMse+6OvtWbewWvPmEZghCjnyOPCe4nb9ubOHCbcfrZDBTgPwN7JhP8WxuCZfVAWUMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516229;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oO++TsSgpQa22s3gsmScjB2TBT1sLfzNV06R6uY2DL0=;
	b=13d3tYK6CJmLxaZR4Ap9uHhqCB6LXOUCIYpKY9v8b2KB8maMLMr9ACJtoeGcMb3zHhNZ
	 JecZEDtkVR5ui6dadEWWHK71qdxRcK/4RL768itF9r8uFIa+1OJcsOwMcDXONiAqjuTsq
	 M+ZS8b1UuX76rvdE8+Vwq98milpMbxLFC4TpXRuYffrAiPI6qV4a2BPxDDNH9o5Sk9sag
	 j9oAv4eOoncUcT+bA0mUuBmoElHr62xMkYMlULNFBPfUuXkf/mXLaiIDCq1OO5Nb/uII8
	 hxYInWPFr9JsuC5aP8e0BHN9m8G55wQ1pFPe2j39+kylQ3mloJl27dZGDXEhOOTKekQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="eXTavG/b";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A541606A8B4;
	Thu, 12 Nov 2026 20:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A541606A8B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eXTavG/b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516229; x=1826052229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MGfK4DgDnuAPxugz4+k9oeh3WpqVq8jNgS0Q1lugqd8=;
  b=eXTavG/bGj6+xPudITUBbW9SiKWz2RRy6hz0fHAB7pWUYHQLm7dALMlm
   sHP2XS73y7H+jO8qeacxQBW4GVs0YHETsSZu68hP98bL/k8YzNagPjeVC
   fTKhZK9CzpRZaJQemJ+oOelSwtncUc2MNDlk4aDk1Jo0HzhPplg1x8wRH
   tEFIo5Svr9VIuyDmthMPbNoTjFyFdPjrUskNWvlqJ0wHQAw19nI+5A1QB
   8u+j4fkb/q/Xxz+tHhwFF8gEOmUNO4hZwpzYtc9hn2jPptRMT8B16TgxR
   7wENYC3KRIQufIawmRDEde9tbfmBwcQp529705pK5nh8yAft+164Dr04P
   A==;
X-CSE-ConnectionGUID: DIUfNqKrQWORejHWxmbwYQ==
X-CSE-MsgGUID: xxGL8narS8ee9wzB+l8W6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192256"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192256"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:48 -0800
X-CSE-ConnectionGUID: YIJ1LVclQUuMGWczIoomiA==
X-CSE-MsgGUID: Md2eua42RmCC4j3WR7vwJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087892"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:48 -0800
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
Subject: [PATCH v4 08/21] perf/x86: Plumb counter bitmap from x86_pmu to x86_pmu_cap
Date: Thu, 12 Nov 2026 13:32:14 -0700
Message-ID: <20261112203227.289379-9-zide.chen@intel.com>
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
2.56.1

