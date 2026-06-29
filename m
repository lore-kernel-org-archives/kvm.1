Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC953CF1F8;
	Mon, 29 Jun 2026 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782775728; cv=none; b=FsezX1djRAoUiU9yvOQaaP4QhnZCciRIq7pz4t+iZ+Z7JFLZQZbMHneAbJ7YNBfIQ7tRDYoyxU9vhtpsMmYnv+o4CmbTJJqgH01qdTbtHtWAPSXZwiZZwJqlRUmWBRy8hQKmBA3D3JEBgqWSfRzghJrlCiW2Vtli5U7Ado9iTmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782775728; c=relaxed/simple;
	bh=mOrQFcTJejpOhMR7FD3eugQomUm7z9KD/zEAWR0Xzlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYWeAO8LP2Y/nqJ4fb3errMY7k/HEzb/OLGyfdmE4HqiLczcKR2UPxBhxdW7PnuWqPJP1R+iGAYnp+OsJR1qTRKs+oRPk7E/J79pxtihe3oZlKXCq4py++vaXxTiD4n12ejkNcjsyOCC9zAEbbIdeGEEIzyAXvUHrbKalgiqaXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0erRMXc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0erRMXc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782775726; x=1814311726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mOrQFcTJejpOhMR7FD3eugQomUm7z9KD/zEAWR0Xzlc=;
  b=Y0erRMXc31niSWOHO/Oh/sxm/toSUnbeqgFT6Etc2NTdVHBCr25Yu0R2
   +oD0GJczvH4Qgneiat3Ey2XBuQUqnEek3YQ9Zj3PC3X5uIq58FvP5gjof
   j/5uTUqgE19s/dOVp4nXfYXqP+zY9NVMP9++EX4B4w0Fz0AkZS/qqvzG5
   aAApC8HKMeeX+yAbyIACMuvN4DHBSufOGJ0cI8ngpOTNJF2F7R+Mkz1Qt
   tDaqwPHCzqxEOhysSpKFzgQLuIYPztNcPz75fSHtXGGf4W2lWplUViyvz
   tss6/c0lKOhw0BrftqzucGvH1Q1ff1ITswDb59YidylP2wFtwjFqRUUYn
   g==;
X-CSE-ConnectionGUID: vWZ/XE/nT8+40GDv6xAFPQ==
X-CSE-MsgGUID: wY/cxGF+Rh+mY9zD9AySpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82593489"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="82593489"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 16:28:44 -0700
X-CSE-ConnectionGUID: yBG2g9/XTP6J5tqGlcqliA==
X-CSE-MsgGUID: QXSY5SISTUiGYGrn8UTdww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="290220134"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 16:28:44 -0700
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
Subject: [PATCH v6 3/8] KVM: x86/pmu: Rename and move vcpu_get_perf_capabilities() to pmu.h
Date: Mon, 29 Jun 2026 16:19:32 -0700
Message-ID: <20260629231938.15129-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629231938.15129-1-zide.chen@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
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
index f15af497d27f..e426ddc8add4 100644
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

