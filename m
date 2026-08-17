Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EFF470E95;
	Mon, 17 Aug 2026 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992092; cv=none; b=fAnZq5TXyD6CMOkVOtVx7YO8u6Vca3dy1lAkckQwbFg5gxyfbYiJ+R+2pUvTuzRodXP1Pk3DR6nxRKzUIXuyizzK6Le3PEc4v6yyNHYR/On2ogfWaHDGBNENTW2mDnZk4mSFEslJSwy52Q0Fvgw5m2bay0q94DqXZ6pyHlg1gO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992092; c=relaxed/simple;
	bh=Jz1x2beAb1qK1p4LmaUmSKWX16jJTmBVaFlBSgFbNsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYO1n6XM5eES5cCY7J6nra9hYPh+AHJHw7aV4DBktBdEyuF7vtjyD1vHvUDM9sOFy/xXwQcVsCXyflocVJwgDbBxgbSvvh5jS+2j5Vs9ZVGiuhmcpkEdGh+XYGw0dZHU8VjpzOzR7pPSnSdmmxHHDNgbTJ23rE65zWn4FUb6Fhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+82761U; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+82761U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786992091; x=1818528091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jz1x2beAb1qK1p4LmaUmSKWX16jJTmBVaFlBSgFbNsE=;
  b=l+82761UjOw8SMIPNbbAsT+kHLvokYp6pGygfe4X1HbjC8nydClqvzXT
   MgEvzLf693FOAmP0wYabptCNd/3GQOa0jdx1D/wasmEsy5OXzlkrjiOnV
   leyLrwhpOoyld0tk0jDMez9Tt9XHLaFHalCyR8gG2F/+UPJEtsyqR94ay
   p8e7ToDIc12XlXr9MlvNZHxAhuirc6U/u16ClDKzsQWF996j1G4CB209v
   CYLECqxvj1CocSDAtikiViMApCg3tawy95JMFX2o3NrFlLqOSG5UWHOTH
   DmZyZveuUrT1mqOFtrh8vHqGjn0Ecv6PlqSLicywY2fvxn2rtNu27Xh/U
   A==;
X-CSE-ConnectionGUID: e+uOUCwyTJ2Zfz4+ttm9Ug==
X-CSE-MsgGUID: RdWd2vXoSLO3OrHQbKwoTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98066100"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="98066100"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 11:41:25 -0700
X-CSE-ConnectionGUID: EFxth9WKTD+kUL3XL1m4MQ==
X-CSE-MsgGUID: WGevhLLTRiC2vOC5lVc7Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="263656975"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 11:41:24 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v8 7/8] KVM: x86/pmu: Emulate RDPMC on performance metrics
Date: Mon, 17 Aug 2026 11:31:41 -0700
Message-ID: <20260817183143.226156-8-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817183143.226156-1-zide.chen@intel.com>
References: <20260817183143.226156-1-zide.chen@intel.com>
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

For simplicity, Metrics Clear Mode is not supported.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
v8:
- Move kvm_need_perf_metrics_intercept() to patch 5/9.
v6:
- Merge kvm_pmu_rdpmc_metrics() into intel_emulate_rdpmc().
- Reject non-zero index.
v5:
- new patch.
---
 arch/x86/kvm/pmu.c           |  1 +
 arch/x86/kvm/vmx/pmu_intel.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 789624658e8f..dab0bcabaa8f 100644
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
index bbf4afcffafc..3ca61e4b0ba6 100644
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

