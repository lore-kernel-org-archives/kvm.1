Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6FA2F6565;
	Thu, 25 Jun 2026 03:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782359697; cv=none; b=r6bEf++fqfRqNzQ1SskoE53eTtWriflsgqFNx0rTMgFPF9FUhlAU/282/EL3OLgrazkTFJHDzA0CGIIRZn2wtVuAzlPtmb1YSoLtoerXl+M1GO/L2hcKXZCJ3/USu8E2MusX015eo/fN5V6tt+DRUccfeoPI1JoM7JUuybSfDMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782359697; c=relaxed/simple;
	bh=oHzEF5y836t9ZnEtY/3UHdunjwcsc3vIdvS56UmHQy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3GvTJTe8eH2QknYe8aZRlnTJgWfQJ2DtIjqybcLigqceJK+zbApfA9Fe5IvzNP7XSpB0FxaKsKknYBof8JQiOhNFakx70JAyW1gaU6ZW+n78ximauCO1ikMpf6Gm/te1TOOqlXm3LOT7s59FPVJkDuElQlXBsEFeIYPEl/XknI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJ6l1xzP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJ6l1xzP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782359696; x=1813895696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oHzEF5y836t9ZnEtY/3UHdunjwcsc3vIdvS56UmHQy4=;
  b=RJ6l1xzP1y7lS9OiGon+SlWr3XLnDyVnwVqbPOOKoeDQdEOQzFgc0gaJ
   xc4+zqNxYkuWsjnG+UFZN81xb90kwak4TJoRwjbDxhlP0k1UYOfF/j7F9
   tO+fyEBYmRtPVQOSB68Eal7qVeJxfACsQRS1ZTKgybzvG98OSXcnHt8Sy
   NOTkpYsbjD8eS/MbvrLdKE83/Z28b7/VA6g8p61bAgojrecz2B1pXfgPM
   HWdvtblq+2r9/L/0BaRzubDtPJzaoBi8u150CipnRFnBqkKB6DO2oRfxU
   WfAo6KCjAFMNqxJerlCgPBLCiZZWHBigYp0jIqVKc+quFt3O8x/PybUrs
   w==;
X-CSE-ConnectionGUID: OS0QlQvCR8Cj5X/UMeh/cQ==
X-CSE-MsgGUID: mRCnVw3nSu+UoIN02zSqiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82901457"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="82901457"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 20:54:53 -0700
X-CSE-ConnectionGUID: T99teRCOQDCI6+XQqrZbug==
X-CSE-MsgGUID: 52AmVRv9TCKSFZKD4Ql1vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="288396620"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 20:54:52 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH V5 3/7] KVM: x86/pmu: Rename and move vcpu_get_perf_capabilities() to pmu.h
Date: Wed, 24 Jun 2026 20:45:51 -0700
Message-ID: <20260625034555.141453-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625034555.141453-1-zide.chen@intel.com>
References: <20260625034555.141453-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is in preparation for it to be called from common x86 code, for
example kvm_need_rdpmc_intercept(), to check the guest's PERF_METRICS
capability.

Rename it to kvm_vcpu_get_perf_caps() to indicate that it's part of
the common API, and shorten _capabilities to _caps.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v5: new patch.
---
 arch/x86/kvm/pmu.h           |  8 ++++++++
 arch/x86/kvm/vmx/pmu_intel.c |  6 +++---
 arch/x86/kvm/vmx/pmu_intel.h | 10 +---------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index a5821d7c87f9..1b2f66a2e915 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -271,6 +271,14 @@ static inline bool kvm_pmu_is_fastpath_emulation_allowed(struct kvm_vcpu *vcpu)
 				  X86_PMC_IDX_MAX);
 }
 
+static inline u64 kvm_vcpu_get_perf_caps(struct kvm_vcpu *vcpu)
+{
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
+		return 0;
+
+	return vcpu->arch.perf_capabilities;
+}
+
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
 int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx);
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 60b6b83c7ced..8171265df684 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -189,13 +189,13 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		return kvm_pmu_has_perf_global_ctrl(pmu);
 	case MSR_IA32_PEBS_ENABLE:
-		ret = vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PEBS_FORMAT;
+		ret = kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PEBS_FORMAT;
 		break;
 	case MSR_IA32_DS_AREA:
 		ret = guest_cpu_cap_has(vcpu, X86_FEATURE_DS);
 		break;
 	case MSR_PEBS_DATA_CFG:
-		perf_capabilities = vcpu_get_perf_capabilities(vcpu);
+		perf_capabilities = kvm_vcpu_get_perf_caps(vcpu);
 		ret = (perf_capabilities & PERF_CAP_PEBS_BASELINE) &&
 			((perf_capabilities & PERF_CAP_PEBS_FORMAT) > 3);
 		break;
@@ -550,7 +550,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 		pmu->raw_event_mask |= (HSW_IN_TX|HSW_IN_TX_CHECKPOINTED);
 	}
 
-	perf_capabilities = vcpu_get_perf_capabilities(vcpu);
+	perf_capabilities = kvm_vcpu_get_perf_caps(vcpu);
 	if (intel_pmu_lbr_is_compatible(vcpu) &&
 	    (perf_capabilities & PERF_CAP_LBR_FMT))
 		memcpy(&lbr_desc->records, &vmx_lbr_caps, sizeof(vmx_lbr_caps));
diff --git a/arch/x86/kvm/vmx/pmu_intel.h b/arch/x86/kvm/vmx/pmu_intel.h
index 5d9357640aa1..afdbbc9991d6 100644
--- a/arch/x86/kvm/vmx/pmu_intel.h
+++ b/arch/x86/kvm/vmx/pmu_intel.h
@@ -6,17 +6,9 @@
 
 #include "cpuid.h"
 
-static inline u64 vcpu_get_perf_capabilities(struct kvm_vcpu *vcpu)
-{
-	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
-		return 0;
-
-	return vcpu->arch.perf_capabilities;
-}
-
 static inline bool fw_writes_is_enabled(struct kvm_vcpu *vcpu)
 {
-	return (vcpu_get_perf_capabilities(vcpu) & PERF_CAP_FW_WRITES) != 0;
+	return (kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_FW_WRITES) != 0;
 }
 
 bool intel_pmu_lbr_is_enabled(struct kvm_vcpu *vcpu);
-- 
2.54.0

