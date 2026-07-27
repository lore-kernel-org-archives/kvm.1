Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A383D6474;
	Mon, 27 Jul 2026 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180729; cv=none; b=XI1tSOC2RZMDwmV0iSY1mkTEikvbJlxPhR+nwWhZzRS6KcNY5fH4EfGqxtwSO9Jf8yg2dhV2m5n6DLShtE7eFmlCV408k/vuHjuRkTd8BvLJhhoLdLGliVq0EMBH/GzWQqg/lZOGL5MU0DfbaNZ9IzAVFW3C4dGZZQdZ46ocjMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180729; c=relaxed/simple;
	bh=ikuGXGCUbRUrSAzMvKI8R0R+y5P0yq8x4vPhyB2ZRXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNUtz/k0MlnpXNg5vAXWw+Clv3PhNMLCjF6KtVWWREqjuFkRv4dCsQGlpbLTj4rVIKKcHutUlyDFo0RBAzLRcphI23K8uF00G22K5SPZOVDlz/BLjk7s9FumJbdmW62aBaPjQi35/dZ0U9UCsCTvX0sx3v0TRyfaa/Vz9SXkqX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmoQV7Tr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmoQV7Tr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785180727; x=1816716727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ikuGXGCUbRUrSAzMvKI8R0R+y5P0yq8x4vPhyB2ZRXU=;
  b=QmoQV7TrDZfghWAgs6h5vbWBMpboff9NdYcrYKOaEZoyivhC7uuP6hdO
   THiQ77SYBNM7T3liqkIeP8Vf9jT/CFnehxmDk2GqUZujoNnEfzt6x/eD9
   gZTun945Uj3WPA9lGgMKkVNqboLhX6zJqNrK/neIeR7H/OPY2aO47mKXF
   ywZaY99dS2R4hxkqpuSruqTfPuZ3+SbTPTkSWAxasghFLj1vp2jGTpXv6
   awSHBsg43jfYDFT9sL42VwLT8m1xVVuedNlSFOqs9jj0bALDVN8sfufc9
   7G/LpmevYUa/rUR5BtJqlEYVia03CCx/ZzI66x5lKoLeWI+fI6EzRydJs
   g==;
X-CSE-ConnectionGUID: qsC4B0yRQcenPEjStsOZmQ==
X-CSE-MsgGUID: RUgobFyXR/e3S/pzjcFTRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85876700"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="85876700"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 12:32:00 -0700
X-CSE-ConnectionGUID: CsvF509ATMuOkvMAVPpTnw==
X-CSE-MsgGUID: 1zF2A0ycR6WXmkeP5dAvVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="289451035"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 12:32:00 -0700
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
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v7 3/9] KVM: x86/pmu: Rename and move vcpu_get_perf_capabilities() to pmu.h
Date: Mon, 27 Jul 2026 12:21:25 -0700
Message-ID: <20260727192131.582105-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727192131.582105-1-zide.chen@intel.com>
References: <20260727192131.582105-1-zide.chen@intel.com>
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
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
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
index 00865234d489..a9202737debe 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -190,13 +190,13 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
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
@@ -551,7 +551,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
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

