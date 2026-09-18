Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384A15226B0;
	Fri, 18 Sep 2026 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761008; cv=none; b=iV1yf1fOk/Fx7wji7vi/YXBC8yrO+zuD8wQoVwClalF7bwOrWTYpjdgWvZlfiGYA7ZKaJayz147Mwjd11fx7SQkEwfAXynL0qfWMSAla+R59GkyjUfMvl7ySUxmr/KdI2pivT6AIFuMT2XiKzEka1sWRhQmGIGa8BctWWUsXVag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761008; c=relaxed/simple;
	bh=rBfRUZm8Eb7GqpxdD41Ip7IrTdLvCwBx9I6cSUIbjnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsD/KIaCblru/vLImmL60NpJSOaoq1YXYwTJagNq9mIZ1GO9TniwJDXNst7Bv3eYS2FRy5oZaRyPBte8NuPiFRu57NTuDNw68ZZg1VI+c91uBzSJAzNWapb4rfdyhLO/IbosfBYfpFjx40++HuTnSTGTGy6nsV4PZsQUff7jDj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqwhAWbY; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqwhAWbY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789761006; x=1821297006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rBfRUZm8Eb7GqpxdD41Ip7IrTdLvCwBx9I6cSUIbjnY=;
  b=nqwhAWbYBJdY0OpMsDn6RWWm0MABtQgZdZCsOu6Vi+rGs+5/7qHISA00
   QY/vZgaGG6W1d6hl6hK4IQ/ApVCK7Rvq+uR/DUrX24I5FobKgMiaHskRf
   lLl39d9pZeUhSRVo+u3mlSNoiMqcCAjV77ZdzQzuEf0Mrnpzp5WXgNKFc
   MwsJY0acnGc4rZ3B2wwoRy07tXpzVBdvcmXq7/F1Hy4CENUfdgfzd3JCO
   alpgaJOlBzKk7JEjr1x+jJXorgtxt+ENm+0p4l1i5YCMWcyFQ3oW2PGH8
   z1O1HjycQm/+I7IcrdlGtFmpl+9Oxex02ohks+NrRZpYoYML4xLqYRG1g
   A==;
X-CSE-ConnectionGUID: DfAWtY9RRUmAlKep0jNfFw==
X-CSE-MsgGUID: zTmXUL7DTYWR/NerHj15Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="790325"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="790325"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:50:00 -0700
X-CSE-ConnectionGUID: DvvbYwsrTxG/CpoCr1FI/g==
X-CSE-MsgGUID: 558t4aIoQCWnQ9bpe6hHIQ==
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
Subject: [PATCH v9 07/12] KVM: x86/pmu: Emulate RDPMC on performance metrics
Date: Fri, 18 Sep 2026 12:39:32 -0700
Message-ID: <20260918193937.569414-8-zide.chen@intel.com>
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

If the host has the PERF_METRICS capability but it's not present on
the guest, RDPMC interception must be enabled and KVM should inject
an #GP when the guest attempts a PERF_METRICS RDPMC.

If the guest has PERF_METRICS but RDPMC interception is enabled for
other reasons, KVM needs to emulate RDPMC with type 0x2000.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
v9:
- Remove references to Metrics Clear from the changelog.
v8:
- Move kvm_need_perf_metrics_intercept() to patch 5/9.
---
 arch/x86/kvm/pmu.c           |  1 +
 arch/x86/kvm/vmx/pmu_intel.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 897c1428b650..0df283a169b6 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -825,6 +825,7 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
 		return true;
 
 	return kvm_need_any_pmc_intercept(vcpu) ||
+	       kvm_need_perf_metrics_intercept(vcpu) ||
 	       pmu->counter_bitmask[KVM_PMC_GP] != (BIT_ULL(kvm_host_pmu.bit_width_gp) - 1) ||
 	       pmu->counter_bitmask[KVM_PMC_FIXED] != (BIT_ULL(kvm_host_pmu.bit_width_fixed) - 1);
 }
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 2eb1bff75e60..fab0891ad46a 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -31,6 +31,7 @@
  */
 #define INTEL_RDPMC_GP		0
 #define INTEL_RDPMC_FIXED	INTEL_PMC_FIXED_RDPMC_BASE
+#define INTEL_RDPMC_METRICS	INTEL_PMC_FIXED_RDPMC_METRICS
 
 #define INTEL_RDPMC_TYPE_MASK	GENMASK(31, 16)
 #define INTEL_RDPMC_INDEX_MASK	GENMASK(15, 0)
@@ -125,6 +126,19 @@ static int intel_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx,
 		counters = pmu->gp_counters;
 		num_counters = pmu->nr_arch_gp_counters;
 		break;
+	case INTEL_RDPMC_METRICS:
+		if (!kvm_vcpu_has_perf_metrics(vcpu))
+			return 1;
+
+		/*
+		 * The index in ECX[15:0] is implementation specific, but no
+		 * platform currently supports a non-zero index.
+		 */
+		if (idx)
+			return 1;
+
+		*data = pmu->perf_metrics;
+		return 0;
 	default:
 		return 1;
 	}
-- 
2.55.0

