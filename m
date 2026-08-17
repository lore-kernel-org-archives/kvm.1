Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FCE470420;
	Mon, 17 Aug 2026 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992091; cv=none; b=ZUv0KnGdzTMaDakiCXJOEdUUcrJ7+sDFNmhfNjvZKKNxsiYudEG3NCLnjbI2GbyEfMlc3fg1Ost2RiomCBsQ/fGX/HN0KbgY1emzz03f/wmCKvg00msDtmguPY2Mnxog792lf9MsoRGc8XAhNiDtpqCLvhIXbEaoJvh0ZYyD6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992091; c=relaxed/simple;
	bh=fmZo8128F5mya0JvNtH8EI+8fwmC9ki0IKkwopRt7qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYitBlcCWsuMRjXL3mHrK16YJVn1uMkHXGlhRO4eNniAheH4Ehfev8Jy6z+qXPVD1Gto977l5AFJWShuCGlmBYhycBChky/ZteCn4c9e8UgnC0cMJbM5l47gYRloAeNmdvkBjpVzVzj0cy8OTpV5h1bS8tuAABMvq7mY2lsoRj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RT+CUZ59; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RT+CUZ59"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786992090; x=1818528090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fmZo8128F5mya0JvNtH8EI+8fwmC9ki0IKkwopRt7qs=;
  b=RT+CUZ59Zztf7PoRLCP/XduqABNKycyZi4H1z1zQX4au1u59vvrL0J6z
   7rwUOyOD2djg8L0DpEn9U0TkloFAsBKMbylNsoJP+u83WwfzX7p0XrMqY
   R2GFwKuFFcVlgKMMO0vNzI6GnO73HR5B7YftLW1mJFgbWqHzOH0s4A2xM
   Pg1BUvRnAg+o2Eb6ny5IR1fsFLOA0QvshcgyuDrJiB+FzkzUxdfmJxeRh
   RVaw0D35LxgV0nPpX9nr0WhYFS2c2W4m8hvIDJPcocMjOwGvqmhO8fU+9
   dwgakJr15juI7TPNyJ/IeOm3n1sPhdcNNWUvzA4/P5YtI7u9lY0rPxef3
   A==;
X-CSE-ConnectionGUID: B7+NOr4ARBKEJfceAeszkw==
X-CSE-MsgGUID: j2RjBSXTQryRIg5tMptLEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98066092"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="98066092"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 11:41:25 -0700
X-CSE-ConnectionGUID: 83dk3Tw2QhKoFnS4DoTgEg==
X-CSE-MsgGUID: KyGx+FjxTN+X1vqtH+O9Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="263656972"
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
Subject: [PATCH v8 6/8] KVM: x86/pmu: Move RDPMC emulation into per-vendor callbacks
Date: Mon, 17 Aug 2026 11:31:40 -0700
Message-ID: <20260817183143.226156-7-zide.chen@intel.com>
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
index 2fddcbc8924d..789624658e8f 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -768,8 +768,6 @@ static int kvm_pmu_rdpmc_vmware(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
-	struct kvm_pmc *pmc;
-	u64 mask = ~0ull;
 
 	if (!pmu->version)
 		return 1;
@@ -777,17 +775,12 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
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
index be578013ed83..eb6bbc658f5b 100644
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
index 1fd0480baf68..bbf4afcffafc 100644
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
@@ -868,7 +867,7 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
 }
 
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
-	.rdpmc_ecx_to_pmc = intel_rdpmc_ecx_to_pmc,
+	.emulate_rdpmc = intel_emulate_rdpmc,
 	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
 	.is_valid_msr = intel_is_valid_msr,
 	.get_msr = intel_pmu_get_msr,
-- 
2.55.0

