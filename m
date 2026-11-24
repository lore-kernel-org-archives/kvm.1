Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557210;
	b=VKGcITKZYuhxj1PEpk1p+Or07n+WyqcVHJbSoP0GyS/t8ecmoDE0A1PuBYTajd2QOEim
	 VvkhuybFv2O//3A1ao25Iiskpa6c+S8BMnqZ5todHbHmNzhk4BFgBxodoY8pDIs0A9Z0r
	 h/2LNT7GKJAcDm5/QgrLs1Ohn00YplHuyww/sjLxQIGgfBGj4bDljHglHgLcHh6oT23b2
	 b7OW5UszimiXloomguxmn5ziutJtxiv73gJN0ZSgdShLkLfCY8AzWH5BK4feAQZ+sfdcV
	 +One+noTRfng/Hm5C1LlkVTEgZBAeoVWHLYdXwSowvmLa9fu/QY1cGv8UGA4I39gEaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557210;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UunifqiG3fiUVVcPdCsjEKxwkuiTHDcJhpk5SEFj7hk=;
	b=LJZKU5vDi28S7yjXkovP2R8QULMs1bSy/pPA5Up0NAG/mL2M+6C4q80RR3/E0zsMmhsn
	 X5Tnhv3dNwJc8CJmHcE4jhM/y6VNiv/Y0LC0MdqrJOVhGeRTxV/Sp/LEMvcxEA2Scd4Se
	 nkT1s4VRB7oQapTHtPksZGCiHoGm42bs67alzMyJwZoKidwy+tAhxJC626pzBgaEct9E2
	 g8xB2Zjhri2lrlIz10ifAmJ42E5p93E0AqFN0kmbIuHH2pQqwgVw9t/VurdG2YT7WAwhp
	 2LgjM0tcdNFQ2sR0URVFv+F1j/n5/OjykvnqLtLQQLLaydxolJ6uKFiQdFSScIZdsFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="H/takVHW";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807A460A2602;
	Tue, 24 Nov 2026 21:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 807A460A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H/takVHW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557210; x=1827093210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lHvUvCn7j6m+l1PxFyYpMqBqYxAOkBo6dXr/ndtgIDk=;
  b=H/takVHW4NzhEEiSRu6LBE0MbRDhmmGlDBP3PWBYHftJgr8Y0R6TKpJd
   kiBgBqV6Iw+FEcqb65Ovtgwc7IljIcoHiV3pV6Ei6+ty4XBwV0+nDcorA
   DrR6BnfQWnOOeakBZYa6EHc8zCUxkof7Jgl2UdeUCjh6ZaRTbQ2F+nBXW
   4iUv7U9uYTI6z22BJdAfZCx2r2k1JbBnPPsh1a12buBH9hcUVorNgkjLt
   tZpA9j9dhpYdPdT+17yjt00yvThqwXe6BJpdz2Hp4MOUhkqfzIj9aJn8h
   zf2Q0JdCwAOmUeqkuwuenjsgudXwjqDmd7NY5D2SDVyitm11YQk5au0dj
   g==;
X-CSE-ConnectionGUID: Gx8YVa8aQPmZEGc3WgDWAg==
X-CSE-MsgGUID: LGVuY4e3SKu50WJUt1WZZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4306043"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4306043"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:29 -0800
X-CSE-ConnectionGUID: hQSxZjqVQ/OmfyY4SzPLZw==
X-CSE-MsgGUID: QloX9KCpT0iTcm8dsgBKXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271932"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:28 -0800
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
Subject: [PATCH v10 10/18] KVM: x86/pmu: Block PMU passthrough if guest lacks PERF_METRICS
Date: Tue, 24 Nov 2026 14:38:53 -0700
Message-ID: <20261124213901.120572-11-zide.chen@intel.com>
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

On hosts supporting PERF_METRICS, if either the PERF_METRICS MSR or
fixed counter 3 is absent from the guest, keep GLOBAL_CTRL and RDPMC
intercepted so the guest cannot set GLOBAL_CTRL[48] or read metrics
via RDPMC without fixed counter 3.

KVM does not expose PERF_METRICS or fixed counter 3 to guests yet,
so this keeps GLOBAL_CTRL and RDPMC intercepted on hosts that
support PERF_METRICS until both are virtualized.

Opportunistically, rename kvm_need_any_pmc_intercept() to
kvm_pmu_incomplete_passthrough(). The function does not decide whether
a particular PMC MSR needs interception. It reports whether the guest
PMU differs from the host PMU, and the PERF_METRICS check widens that
further.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v10: new patch.
---
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/kvm/pmu.c               | 22 +++++++++++++++++-----
 arch/x86/kvm/pmu.h               |  5 +++++
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3a8e51a0c9e8..8fad944197fb 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -331,6 +331,7 @@
 #define PERF_CAP_PEBS_FORMAT		0xf00
 #define PERF_CAP_FW_WRITES		BIT_ULL(13)
 #define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
+#define PERF_CAP_PERF_METRICS		BIT_ULL(15)
 #define PERF_CAP_PEBS_TIMING_INFO	BIT_ULL(17)
 #define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
 					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index dba651d4e449..4574cac5f148 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -778,7 +778,7 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 	return 0;
 }
 
-static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
+static bool kvm_pmu_incomplete_passthrough(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 
@@ -790,13 +790,25 @@ static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
 	 * KVM's capabilities are constrained based on KVM support, i.e. KVM's
 	 * capabilities themselves may be a subset of hardware capabilities.
 	 */
-	return pmu->nr_arch_gp_counters != kvm_host_pmu.num_counters_gp ||
-	       pmu->nr_arch_fixed_counters != kvm_host_pmu.num_counters_fixed;
+	if (pmu->nr_arch_gp_counters != kvm_host_pmu.num_counters_gp ||
+	    pmu->nr_arch_fixed_counters != kvm_host_pmu.num_counters_fixed)
+		return true;
+
+	/*
+	 * RDPMC passthrough must be blocked if fixed counter 3 is missing
+	 * to avoid leaking host metrics, as IA32_PERF_METRICS is not
+	 * context-switched without it.
+	 *
+	 * That condition is already caught by the counter count check above,
+	 * so only check for PERF_METRICS here.
+	 */
+	return (kvm_host_pmu.perf_capabilities & PERF_CAP_PERF_METRICS) &&
+	       !kvm_vcpu_has_perf_metrics(vcpu);
 }
 
 bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
 {
-	return kvm_need_any_pmc_intercept(vcpu) ||
+	return kvm_pmu_incomplete_passthrough(vcpu) ||
 	       !kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu));
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
@@ -812,7 +824,7 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
 	if (enable_vmware_backdoor)
 		return true;
 
-	return kvm_need_any_pmc_intercept(vcpu) ||
+	return kvm_pmu_incomplete_passthrough(vcpu) ||
 	       pmu->counter_bitmask[KVM_PMC_GP] != (BIT_ULL(kvm_host_pmu.bit_width_gp) - 1) ||
 	       pmu->counter_bitmask[KVM_PMC_FIXED] != (BIT_ULL(kvm_host_pmu.bit_width_fixed) - 1);
 }
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 2a9c1bbe5c40..ae1e6545df40 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -281,6 +281,11 @@ static inline u64 kvm_vcpu_get_perf_caps(struct kvm_vcpu *vcpu)
 	return vcpu->arch.perf_capabilities;
 }
 
+static inline bool kvm_vcpu_has_perf_metrics(struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PERF_METRICS;
+}
+
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
 int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx);
-- 
2.56.1

