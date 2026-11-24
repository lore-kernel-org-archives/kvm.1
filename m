Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557207;
	b=ViDa76pU/sB5H2gD8Rz/XmjGrNwJMRcU48m7sXCJesD/sDWaQqxYjqRVEaDbe70J49t/
	 LS2FQkCGBf15kGu+Ws7yO04slLbJfgjPirDOMVI+QUdzQF/DKSsTIlX7WQXxEY/HZiQX1
	 7WLg60JtoLwQ0t6BMPDXELwN/Ukv9RQde6nVBYQ7M5ht9hXNfiE7TpzqwQyPFT8ru1IYt
	 vGKXcDJe6NQnsp+r4jeP8HIAbO9+6Hd/EQ2VYFr7GtQfC/X8gogKh5b78HxMYlDukJ7KU
	 iqdlq+aVOeTiVxYdbajS49IAKMsdsCDrmEza7qhBD2T++ncKZFgiT+4ISxrpjiSJSLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557207;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZUSUUU9UbcR6Q5hiPJXAeSx9jwpJu7NJJImRPE4IjVg=;
	b=D59L7A/svXvGtlM6EGrEyGXijdcz0jmeZTSsFC+HBZzDVVdMLrX9lHIEKcD4KesUgcEG
	 gSiLi7xwB9vPPAPE1OTnkejZxY1+24wewikBy+3QX1Ty5elHKKVjxElGfn4khldlBNhD0
	 MJOcpzJ74c4V/mMQeErg9gsvb7qahvcFQk77CtG1QqcesrDML81KX25fY1JsUxk3MiDx3
	 NXqGSsLeTFkNyrbs/CoPruO+K7CoIf+7Pebymx4pg1fQCDL1ksMcrOLdnpJ8cBRxuBgYY
	 3EXyGcva26W5RXa+Lu0fl+RTJ06/V4JigjFsEhSLpm/MrskODbmUbMqnRzAOeWmem6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eOPp2w2V;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F740606A6AB;
	Tue, 24 Nov 2026 21:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F740606A6AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eOPp2w2V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557207; x=1827093207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aMmLTpF4jMP42C5uxxxmQGu0bQqSyHij96LvuvTa1SY=;
  b=eOPp2w2VTByqAgrIP6rTXn0E0eL3GtVDN2pxCXMk9RerZj3qxyN+EEYf
   1Uo+1/haMV7Q5KG8NsNc782ov16/OHRfu2Q6226+jUuXUtF+SxBcNrRe+
   tKJJYSVLLr4+AI6z/msrsF10ODOkERSM+5ZNB4LOZwTiV73+4+Zef6IEi
   z5mrXG6vwv8h+9UoQkLrg9rXJYOD3gup3ORyCKEbbJkJyQtBWgk6kAg/u
   sBrVa8XB108UvM+X+DW+l2sIzlBLahjGaSzttBy2b12fnXoTmIdMSxG8v
   x5alVqoito+z58emVO4/WbqXbmQnacTEK7YhbhYHRChfYX9BShpYiVyZd
   g==;
X-CSE-ConnectionGUID: gWLkZJBiTwOzXr57Wn6R8w==
X-CSE-MsgGUID: ThvkGDS/SOeNPZGLzMHOqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4306013"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4306013"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:26 -0800
X-CSE-ConnectionGUID: WdL9LrDsQYWXJMENBuycmQ==
X-CSE-MsgGUID: CU4ZNal7QbeaIdP5Ea1WJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271914"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:25 -0800
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
Subject: [PATCH v10 06/18] KVM: x86/pmu: Do not map fixed counters >= 3 to generic perf events
Date: Tue, 24 Nov 2026 14:38:49 -0700
Message-ID: <20261124213901.120572-7-zide.chen@intel.com>
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

Only fixed counters 0..2 have matching generic cross-platform
hardware perf events (INSTRUCTIONS, CPU_CYCLES, REF_CPU_CYCLES).
Therefore, perf_get_hw_event_config() is only applicable to these
counters.

KVM does not intend to emulate fixed counters >= 3 on legacy
(non-mediated) vPMU, while for mediated vPMU, KVM does not care what
the fixed counter event mappings are.  Therefore, return 0 for their
eventsel.

The two BUILD_BUG_ON() checks are no longer needed, so drop them along
with __always_inline.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
v10:
- Add comment to mention event mapping is not used for mediated PMU.
v6:
- Re-arrange the code for early return. Clearer.
---
 arch/x86/kvm/vmx/pmu_intel.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 70a8c4816135..8f72a405e737 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -468,11 +468,8 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
  * different perf_event is already utilizing the requested counter, but the end
  * result is the same (ignoring the fact that using a general purpose counter
  * will likely exacerbate counter contention).
- *
- * Forcibly inlined to allow asserting on @index at build time, and there should
- * never be more than one user.
  */
-static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
+static u64 intel_get_fixed_pmc_eventsel(unsigned int index)
 {
 	const enum perf_hw_id fixed_pmc_perf_ids[] = {
 		[0] = PERF_COUNT_HW_INSTRUCTIONS,
@@ -481,8 +478,14 @@ static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
 	};
 	u64 eventsel;
 
-	BUILD_BUG_ON(ARRAY_SIZE(fixed_pmc_perf_ids) != KVM_MAX_NR_INTEL_FIXED_COUNTERS);
-	BUILD_BUG_ON(index >= KVM_MAX_NR_INTEL_FIXED_COUNTERS);
+	/*
+	 * Fixed counters 3 and above don't have a corresponding generic
+	 * hardware perf event, and KVM does not intend to emulate them on
+	 * non-mediated vPMU. For mediated vPMU, event mappings are unused
+	 * since the hardware counters are passed through directly.
+	 */
+	if (index >= ARRAY_SIZE(fixed_pmc_perf_ids))
+		return 0;
 
 	/*
 	 * Yell if perf reports support for a fixed counter but perf doesn't
-- 
2.56.1

