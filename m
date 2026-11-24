Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557209;
	b=Hzeo6mjH0ex+0xlNpka0864zwwfIl54ouZKFJ1c2V/M1NZRR7pnUeTIOOigziCSgTCft
	 9LinpK0NOIq4pvagfNcA/uzil/MoLYSneWxUbzXKomCZYgae5EZaiI0vE9qxbJEFhE53e
	 82Y34NJE20DNym+72Qh4h9oB/ScNFEpkMIyVA/kJHTntjQd8HnPVU9rJJNjZ1mOZLRkD4
	 lzh9FqMdWl9uJsKDhfHQ5hq9VeA1zHFg7B3w2z4z22dvheY+6b6PuQ8V1/kWbHdyyjtnn
	 CQU15eMjTEPfyBgjqSQoBqb1yYIx/557jzWTeSDpD0nXTR/pReEtI+zR/yK6ZwBiTwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557209;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HxtNbM2jXvlgYaUawZ/NYbyzFwKkPCfnMElQzm8/jIU=;
	b=X03aVgB6S1R5LwkHfrceKntr7dIkVc793GFmpAE7/asYfyxIHgZasXV9g2YTghgCgVSi
	 HgZiDV1I1nI9nYWpvMEWCtCZymoKjOVAVFVY8gYkyI/KRii8EwwSSJ9/4EXt5Tw6E7XKe
	 DSQmYBCtkYXO8wn/ra0AWPbKA0WnWWOQYjZm7+G20wkxr6sjlytJ2ma/pkXvt8Wkh6xgk
	 ajCIckl7vKuANxznvB5roVM8SoELKvBPc1Kw/olCdd4cD9vvP5sgQZy/2QJ55WBqBtheT
	 d+4CTTzAPvz3M1HZUYzogcctlbsjRHxb1mKB+78YXD3D7Ts4Fms6PQ+RbvlxD4cdjlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eXVyVm3p;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D491B60A2617;
	Tue, 24 Nov 2026 21:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D491B60A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eXVyVm3p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557208; x=1827093208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DXFlWD2at4gbgU8maB0LiX2Ft3RCjzsefY+QqAyIlo8=;
  b=eXVyVm3pIz+T+74Vtl+fGbE1Z7MzeFqZz1auzFun4SKpHqK9RxKZcKFm
   H3V81J60oUBrT+WH+JaPkOBy7qOc4UpUkxh3kaklr/y8IPQaTniOqVMmk
   JAQSIPhs5ZwtnzqYHDGr1kHcodbGnvdcO5i29Cosz+om3A3hE63JbvQ8A
   UIaOakcPsRJx4BuHQQfsK80ZBGtCLurTb1SbJZsSS9iW4TYhv9+MhhIc9
   s+wSCxMwy03mjyuohBe4Qhv9OnGkuBdLPR3h59OQXEnYlJq+oJyI3QB1O
   ZeKNC2Xl2TphrqRjcl4d5LXzuEUyrHB1EZ9/TpUp9HcJ8uZwIeLzrYNqk
   w==;
X-CSE-ConnectionGUID: GeQf5J5lQTmDFz3LQPQ7Og==
X-CSE-MsgGUID: ipVe3uG8Su2/mEhBZZ7LWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4306028"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4306028"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:27 -0800
X-CSE-ConnectionGUID: NWfn1ZF3Q9qaqjnLyf+EAQ==
X-CSE-MsgGUID: 0pcvLXChQgGRLaCqKYz06Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271922"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:26 -0800
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
Subject: [PATCH v10 08/18] KVM: x86/pmu: Rename and move vcpu_get_perf_capabilities() to pmu.h
Date: Tue, 24 Nov 2026 14:38:51 -0700
Message-ID: <20261124213901.120572-9-zide.chen@intel.com>
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

Move vcpu_get_perf_capabilities() from vmx/pmu_intel.h to pmu.h so that
common x86 code can check whether the guest has PERF_METRICS.

Rename the helper to kvm_vcpu_get_perf_caps() to indicate that it is
part of the common API, and shorten _capabilities to _caps.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/pmu.h           | 10 ++++++++++
 arch/x86/kvm/vmx/pmu_intel.c |  6 +++---
 arch/x86/kvm/vmx/pmu_intel.h | 12 ++----------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 090c9bbb74f4..2a9c1bbe5c40 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -6,6 +6,8 @@
 
 #include <asm/kvm_host.h>
 
+#include "cpuid.h"
+
 #define vcpu_to_pmu(vcpu) (&(vcpu)->arch.pmu)
 #define pmu_to_vcpu(pmu)  (container_of((pmu), struct kvm_vcpu, arch.pmu))
 #define pmc_to_pmu(pmc)   (&(pmc)->vcpu->arch.pmu)
@@ -271,6 +273,14 @@ static inline bool kvm_pmu_is_fastpath_emulation_allowed(struct kvm_vcpu *vcpu)
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
index f916048b9c54..36a2269bbd96 100644
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
@@ -555,7 +555,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 		pmu->raw_event_mask |= (HSW_IN_TX|HSW_IN_TX_CHECKPOINTED);
 	}
 
-	perf_capabilities = vcpu_get_perf_capabilities(vcpu);
+	perf_capabilities = kvm_vcpu_get_perf_caps(vcpu);
 	if (intel_pmu_lbr_is_compatible(vcpu) &&
 	    (perf_capabilities & PERF_CAP_LBR_FMT))
 		memcpy(&lbr_desc->records, &vmx_lbr_caps, sizeof(vmx_lbr_caps));
diff --git a/arch/x86/kvm/vmx/pmu_intel.h b/arch/x86/kvm/vmx/pmu_intel.h
index 5d9357640aa1..9f4452619da5 100644
--- a/arch/x86/kvm/vmx/pmu_intel.h
+++ b/arch/x86/kvm/vmx/pmu_intel.h
@@ -4,19 +4,11 @@
 
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
+#include "pmu.h"
 
 static inline bool fw_writes_is_enabled(struct kvm_vcpu *vcpu)
 {
-	return (vcpu_get_perf_capabilities(vcpu) & PERF_CAP_FW_WRITES) != 0;
+	return (kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_FW_WRITES) != 0;
 }
 
 bool intel_pmu_lbr_is_enabled(struct kvm_vcpu *vcpu);
-- 
2.56.1

