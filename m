Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959773D9534;
	Mon, 27 Jul 2026 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180732; cv=none; b=sQFWPzRajCxO55N412HqywiQGIDPCxJ2Dz8QxBx3yAw5fmQz9CeLC2Vp/5eUzQBK8MXPTuKJQeRtG4LsBNLb9fpgOqXBRTstX4rWTcdP4Ndq+mAct8xOrItNcUk3gBvKyHSccPELHmyyCeW1cVQGZNtbCv9XYSPNxeJ7WEit+Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180732; c=relaxed/simple;
	bh=3cF+40CZN8sbCyYLVjDUNiVvBntVQ/c5eCJHkFe3b8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKfCIe6Y55VwMxFuhJsJZ/lB3fkGeNTTGXlVNMFCt+xUmo14r0DgUHIHhEH8nN3SiIXC1pl5ZvLRu1FXFddJB2n7CL2no0gRwzbBuVG3JdaHU0nHCQi3k+/Dnq6buUCn/J6iJe7hHm+2Lf0Xr2LKgW+TfmWaLs4Zu+rIxJxHkB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CHXcUhxU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHXcUhxU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785180729; x=1816716729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3cF+40CZN8sbCyYLVjDUNiVvBntVQ/c5eCJHkFe3b8g=;
  b=CHXcUhxUdp3gPR5A3Gz7wmMplsziUeDes2/YFGeguhI2TowsnVF3AsaC
   muFsfyU9D9tODHX2WYr0iPzq8wbkoV00LEiDDRU15r1ngo8LBgGvl/8zb
   qoB039CBbEwO/SmxjcViSvLvcw15z1laXo7hC8smW+UXF02PfrnG/Ndp3
   tLhSgkg/6TKMhqDoWzhIz3gcAfxiFKle3VplKwyv1kHj4dcSZ8H4SQYBP
   TeKO07+2/aN4kaC5uiQBlQSm/4BWpb7e146TRw7YAV/mW+IYjVLp5UM9K
   TVlNzY4cIVxmdsURen+6Xmt0JKYkqeQ+yXRAHhXiL3T6GIuLhLLrybG8s
   w==;
X-CSE-ConnectionGUID: Bb0GoGbNQl6rZ3n1t+1HMw==
X-CSE-MsgGUID: LxrrPlHnQs24KCzZoVQvIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85876715"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="85876715"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 12:32:00 -0700
X-CSE-ConnectionGUID: +lUMn272Qxyi64/GmQVlNg==
X-CSE-MsgGUID: zz8GYo7rTO+QpFIKDBzLiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="289451044"
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
Subject: [PATCH v7 6/9] KVM: x86/pmu: Move RDPMC emulation into per-vendor callbacks
Date: Mon, 27 Jul 2026 12:21:28 -0700
Message-ID: <20260727192131.582105-7-zide.chen@intel.com>
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

The current RDPMC emulation splits responsibility: rdpmc_ecx_to_pmc()
in each vendor returns a kvm_pmc, then common code calls
pmc_read_counter().

This design cannot support RDPMC reads that don't map to a counter,
such as PERF_METRICS on Intel platforms.

Replace rdpmc_ecx_to_pmc() with emulate_rdpmc(), which takes full
ownership of the emulation and writes the result directly into @data.

Opportunistically drop the redundant bitmask in intel_emulate_rdpmc()
since pmc_read_counter() already applies the counter's bit-width mask.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
v6: new patch.
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h |  2 +-
 arch/x86/kvm/pmu.c                     |  9 +--------
 arch/x86/kvm/pmu.h                     |  4 ++--
 arch/x86/kvm/svm/pmu.c                 | 13 +++++++++----
 arch/x86/kvm/vmx/pmu_intel.c           | 25 ++++++++++++-------------
 5 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index 4a223c2793e3..4b50ed058aed 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -13,7 +13,7 @@
  * KVM_X86_PMU_OP_OPTIONAL() can be used for those functions that can have
  * a NULL definition.
  */
-KVM_X86_PMU_OP(rdpmc_ecx_to_pmc)
+KVM_X86_PMU_OP(emulate_rdpmc)
 KVM_X86_PMU_OP(msr_idx_to_pmc)
 KVM_X86_PMU_OP_OPTIONAL(check_rdpmc_early)
 KVM_X86_PMU_OP(is_valid_msr)
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 2ae23e79d6da..51c6d00a485f 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -769,8 +769,6 @@ static int kvm_pmu_rdpmc_vmware(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
-	struct kvm_pmc *pmc;
-	u64 mask = ~0ull;
 
 	if (!pmu->version)
 		return 1;
@@ -778,17 +776,12 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 	if (is_vmware_backdoor_pmc(idx))
 		return kvm_pmu_rdpmc_vmware(vcpu, idx, data);
 
-	pmc = kvm_pmu_call(rdpmc_ecx_to_pmc)(vcpu, idx, &mask);
-	if (!pmc)
-		return 1;
-
 	if (!kvm_is_cr4_bit_set(vcpu, X86_CR4_PCE) &&
 	    (kvm_x86_call(get_cpl)(vcpu) != 0) &&
 	    kvm_is_cr0_bit_set(vcpu, X86_CR0_PE))
 		return 1;
 
-	*data = pmc_read_counter(pmc) & mask;
-	return 0;
+	return kvm_pmu_call(emulate_rdpmc)(vcpu, idx, data);
 }
 
 static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 3066cade5790..cdbefda844b9 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -24,8 +24,8 @@
 #define KVM_FIXED_PMC_BASE_IDX INTEL_PMC_IDX_FIXED
 
 struct kvm_pmu_ops {
-	struct kvm_pmc *(*rdpmc_ecx_to_pmc)(struct kvm_vcpu *vcpu,
-		unsigned int idx, u64 *mask);
+	int (*emulate_rdpmc)(struct kvm_vcpu *vcpu, unsigned int idx,
+			     u64 *data);
 	struct kvm_pmc *(*msr_idx_to_pmc)(struct kvm_vcpu *vcpu, u32 msr);
 	int (*check_rdpmc_early)(struct kvm_vcpu *vcpu, unsigned int idx);
 	bool (*is_valid_msr)(struct kvm_vcpu *vcpu, u32 msr);
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index c18286545a7a..0517fd4bbcd7 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -84,10 +84,15 @@ static int amd_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx)
 }
 
 /* idx is the ECX register of RDPMC instruction */
-static struct kvm_pmc *amd_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
-	unsigned int idx, u64 *mask)
+static int amd_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx, u64 *data)
 {
-	return amd_pmu_get_pmc(vcpu_to_pmu(vcpu), idx);
+	struct kvm_pmc *pmc = amd_pmu_get_pmc(vcpu_to_pmu(vcpu), idx);
+
+	if (!pmc)
+		return 1;
+
+	*data = pmc_read_counter(pmc);
+	return 0;
 }
 
 static struct kvm_pmc *amd_msr_idx_to_pmc(struct kvm_vcpu *vcpu, u32 msr)
@@ -302,7 +307,7 @@ static bool amd_pmc_is_disabled_in_current_mode(struct kvm_pmc *pmc)
 }
 
 struct kvm_pmu_ops amd_pmu_ops __initdata = {
-	.rdpmc_ecx_to_pmc = amd_rdpmc_ecx_to_pmc,
+	.emulate_rdpmc = amd_emulate_rdpmc,
 	.msr_idx_to_pmc = amd_msr_idx_to_pmc,
 	.check_rdpmc_early = amd_check_rdpmc_early,
 	.is_valid_msr = amd_is_valid_msr,
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index a2845d398377..8e991da08b24 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -85,14 +85,13 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 	}
 }
 
-static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
-					    unsigned int idx, u64 *mask)
+static int intel_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx,
+			       u64 *data)
 {
 	unsigned int type = idx & INTEL_RDPMC_TYPE_MASK;
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
-	struct kvm_pmc *counters;
+	struct kvm_pmc *counters, *pmc;
 	unsigned int num_counters;
-	u64 bitmask;
 
 	/*
 	 * The encoding of ECX for RDPMC is different for architectural versus
@@ -105,7 +104,9 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 	 * as KVM doesn't support such PMUs.
 	 */
 	if (WARN_ON_ONCE(!pmu->version))
-		return NULL;
+		return 1;
+
+	idx &= INTEL_RDPMC_INDEX_MASK;
 
 	/*
 	 * General Purpose (GP) PMCs are supported on all PMUs, and fixed PMCs
@@ -119,23 +120,21 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 	case INTEL_RDPMC_FIXED:
 		counters = pmu->fixed_counters;
 		num_counters = pmu->nr_arch_fixed_counters;
-		bitmask = pmu->counter_bitmask[KVM_PMC_FIXED];
 		break;
 	case INTEL_RDPMC_GP:
 		counters = pmu->gp_counters;
 		num_counters = pmu->nr_arch_gp_counters;
-		bitmask = pmu->counter_bitmask[KVM_PMC_GP];
 		break;
 	default:
-		return NULL;
+		return 1;
 	}
 
-	idx &= INTEL_RDPMC_INDEX_MASK;
 	if (idx >= num_counters)
-		return NULL;
+		return 1;
 
-	*mask &= bitmask;
-	return &counters[array_index_nospec(idx, num_counters)];
+	pmc = &counters[array_index_nospec(idx, num_counters)];
+	*data = pmc_read_counter(pmc);
+	return 0;
 }
 
 static inline struct kvm_pmc *get_fw_gp_pmc(struct kvm_pmu *pmu, u32 msr)
@@ -869,7 +868,7 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
 }
 
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
-	.rdpmc_ecx_to_pmc = intel_rdpmc_ecx_to_pmc,
+	.emulate_rdpmc = intel_emulate_rdpmc,
 	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
 	.is_valid_msr = intel_is_valid_msr,
 	.get_msr = intel_pmu_get_msr,
-- 
2.54.0

