Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929840;
	b=n3FwoNKpnNpAhhZ3+NWA2TzfSxurwvC5xEHLC3Tu3HIBEguS8OtMij5bLNMfYHngZEB4
	 nm8giFxLkfOcTH1dtxVzM9BpHfgfNP0vW9cjGvaRopyXuH7TmhP32SHQOXtGInZl4tXAH
	 zvwSCfgi60d1VRHJ/Nt/lmUsRkkEqWnaoRDQMou5p/B9bhEGZto5+Uu1mio1grJk9OMH6
	 OIUdei87Os55eSmdfmCBEri5ISsdyZr7qNpqhPiHZjxSONKZVsR/TIz9i88KOaz6/hCcY
	 qPKEHoO+rkFaZJh5STZtvHJpTQe74HiWc0y6d4IfXqtdgBdKN6RV21zygPsDe8oyPVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929840;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WpXbhV6dgIekXIp68xxRfBkF7EVHcp0PgMCVjk1KBhY=;
	b=YV0sVXBwUcTOFFZxB1IJBjNb0FvMgkFjjEf5hRLmpn9jGP/7W3E38R8t0OtF61weblu+
	 aIPa50jLnTRytKGSneHGy52p65Wxs7a+OzAC0ygBIWLp63EEk+jYAnfLH5xMFKzn5i5jB
	 qetVT+AykNWcanP5wX+GFPCLYHOzw1+6lZY7LQ+DDfRHVd53Vfct7wUz0yX69pJ+N7CMR
	 qDw30q3d+YwbUF2wFzn+6IPvGqIoJ4DxCYYJ24J531ECcCcaukmNkBjKx/p1YfkrMOHOS
	 gN1v/jhOTZ21SXFig7cwkgNKlWRwi71sI5UTzJoPm5OhhJDVxzfqXF4w+Q97OcJzqpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="ZIAzOiI/";
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D99606A33C;
	Fri,  6 Nov 2026 01:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5D99606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZIAzOiI/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793929840; x=1825465840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jsLVoTmoo8dCjPYSEn1fAOqAvSefpK3VybltluqKH94=;
  b=ZIAzOiI/zcTm5MGRq2JZIVsC2zNdXKuNEoq90xLYkqbkzc93+aBzdF0R
   gvf6ZVjKqMaQ+0hDlAjMuuu3BKUHpg8yVuHbUDNdJb4J/K5H+J+ojNHyP
   WyZjkBzWQifBfuEwZdCSL3VnfHIIuAslvRxRnNmB88yDA7jHeSBSHEE+O
   1RdUglZ3q3gY15dXOPnUU8R8lvOjrECpmlKSyEfy0XIDkAgQrRbDDN86Z
   QVeLb4Q1FJy85XbdLaZ5qcL3Lc9Vb2tPwwmvDhCjWO6lDy9tE/IbsXAeM
   Fhis2P7U/THu092Kn6f+2TZMq7oY2WvGqKuGiDrwdrn2Hn730NSHdNRwv
   A==;
X-CSE-ConnectionGUID: LX7B99VhTW+oX1h/hXYhnA==
X-CSE-MsgGUID: S/IosDJIR5WmykLOl5MmUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740202"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2740202"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:32 -0800
X-CSE-ConnectionGUID: GIO8SfQORr6edrZ4UeTkXA==
X-CSE-MsgGUID: eHEYFhc1QTCIF1lpbgYcqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067209"
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
Subject: [PATCH v3 15/18] KVM: x86/pmu: Mask only OS/USR bits when filtering fixed counters
Date: Thu,  5 Nov 2026 18:39:24 -0700
Message-ID: <20261106013927.166209-16-zide.chen@intel.com>
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

In preparation for supporting AnyThread deprecation and Fixed Counter 3,
mask only INTEL_FIXED_0_KERNEL and INTEL_FIXED_0_USER when updating
fixed_ctr_ctrl_hw in kvm_mediated_pmu_refresh_event_filter().

Masking the full 0xf nibble would cause two issues:

1. AnyThread for Fixed Counters 0-2: When a counter is allowed, copying
   the full nibble from guest-visible pmu->fixed_ctr_ctrl back into
   hardware-visible pmu->fixed_ctr_ctrl_hw would resurrect AnyThread in
   hardware, defeating SMT cross-VM isolation.

2. Metrics Clear for Fixed Counter 3: If an event filter denies Fixed
   Counter 3, clearing 0xf inadvertently strips METRICS_CLEAR_EN from
   hardware. If the guest sets METRICS_CLEAR_EN and executes native RDPMC,
   metrics will remain un-cleared, returning stale data.

This gates hardware counting without clobbering other control bits,
matching general-purpose counter filtering which only masks the event
ENABLE bit.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3:
- New patch.
---
 arch/x86/kvm/pmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 2cb5bccc7044..afb3e18a9879 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -557,7 +557,9 @@ static void kvm_mediated_pmu_refresh_event_filter(struct kvm_pmc *pmc)
 			pmc->eventsel_hw |= pmc->eventsel &
 					    ARCH_PERFMON_EVENTSEL_ENABLE;
 	} else {
-		u64 mask = intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX, 0xf);
+		u64 mask = intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX,
+						    INTEL_FIXED_0_KERNEL |
+						    INTEL_FIXED_0_USER);
 
 		pmu->fixed_ctr_ctrl_hw &= ~mask;
 		if (allowed)
-- 
2.56.0

