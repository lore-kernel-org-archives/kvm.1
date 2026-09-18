Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525AC522EED;
	Fri, 18 Sep 2026 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761004; cv=none; b=mdQmceHUnxMWXjUBIfAwAQ19z5iUobGwGPnHYJosZKC9HyJMHX9j6rbqmVIBZRSN3viC6Lx6dVncf3Vrdg60IgiLiUmXm57zbwWp69YyfDTx2fM7D+0RagO44Nl/V16VQCbgTLS+5l74YCLi8pCxs+RzPCUYt9qtg4MMYTZ/ens=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761004; c=relaxed/simple;
	bh=yJ6fo0VMz24CjRyKdJuqB9loBUaxM3dZotPRuLagZq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfeeny81nIUGUa0RCWsPIy0yGVL2cUKSUMod4jMdtG8jLmuoKbi5NQQRY0Rc0UZ0XDPUpER5hWIw0NyAo9m0iQ8IM/R8oua72BZlL+/+i77ng20liL5XitnIrDQYiRmXOnaja4Q9DopEmqthBwy5z26RgELrizEDqonyN25GAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHf5CUiZ; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHf5CUiZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789761003; x=1821297003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yJ6fo0VMz24CjRyKdJuqB9loBUaxM3dZotPRuLagZq4=;
  b=QHf5CUiZ5ZTl5Z49L0gmkHTcED9xaUZy+C9oHQEa8w3ohPXjO0yI19i5
   xOOs+oElWpNw/qMzlCUTfvfxnrZDWXdaYqt9lt1ZSqp/xyrpKlhr26p5d
   5rSuSHOmdxZb6K/Tk/cXR2YzGlzdoZ8JlNumEXv2LnbBKUPFsPAGJopIJ
   g5s34h4+BPJDfG/b7AwlBnVbhvNv9T/K/+modgRGNLmwMORp+/mBlaUzy
   P3R7XV4QJfr69NfSCZ53dhnn+mIKPNmnhQAsag6kr8NjvWTzNd64lHQjb
   7CKsrARfN2leoHjS8Y9K4j99+XOWj61rzbBwXIlFx+AZQpTtcWjc8cIBa
   g==;
X-CSE-ConnectionGUID: m4XBxBORSXmCpAOWfYVdtw==
X-CSE-MsgGUID: Je12YpxDRoq+n1H1N3i00Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="790319"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="790319"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:49:59 -0700
X-CSE-ConnectionGUID: 0T/3AjiiT2ShRJlMgQlDsQ==
X-CSE-MsgGUID: tPAqy5ShRNuCMHKU6++BtQ==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:49:59 -0700
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
Subject: [PATCH v9 03/12] KVM: x86/pmu: Rename and move vcpu_get_perf_capabilities() to pmu.h
Date: Fri, 18 Sep 2026 12:39:28 -0700
Message-ID: <20260918193937.569414-4-zide.chen@intel.com>
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
v8:
- remove include "cpuid.h" from pmu_intel.h.
---
 arch/x86/kvm/pmu.h           |  8 ++++++++
 arch/x86/kvm/vmx/pmu_intel.c |  6 +++---
 arch/x86/kvm/vmx/pmu_intel.h | 12 +-----------
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 090c9bbb74f4..82f955e5a450 100644
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
index 11ad64d43e35..28c1542e5ba5 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -193,13 +193,13 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
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
@@ -554,7 +554,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 		pmu->raw_event_mask |= (HSW_IN_TX|HSW_IN_TX_CHECKPOINTED);
 	}
 
-	perf_capabilities = vcpu_get_perf_capabilities(vcpu);
+	perf_capabilities = kvm_vcpu_get_perf_caps(vcpu);
 	if (intel_pmu_lbr_is_compatible(vcpu) &&
 	    (perf_capabilities & PERF_CAP_LBR_FMT))
 		memcpy(&lbr_desc->records, &vmx_lbr_caps, sizeof(vmx_lbr_caps));
diff --git a/arch/x86/kvm/vmx/pmu_intel.h b/arch/x86/kvm/vmx/pmu_intel.h
index 5d9357640aa1..dd447d8b6fdd 100644
--- a/arch/x86/kvm/vmx/pmu_intel.h
+++ b/arch/x86/kvm/vmx/pmu_intel.h
@@ -4,19 +4,9 @@
 
 #include <linux/kvm_host.h>
 
-#include "cpuid.h"
-
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
2.55.0

