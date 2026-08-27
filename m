Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1915B3D9531;
	Thu, 27 Aug 2026 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870892; cv=none; b=cfZp9lk1A7WxAUWz8dAn4ch7QzSDkG2kkR43GvUNEit0hdF/USBG3FcvmXMwc4OyreLpme4ERVObreFQJCjd+PdZnYJSma7IUNZXTjWlgYCV4rfCkWuhsTHe22+z+fKIFhYzvJuk2wfTHw0gCEFm8DnVSbVLnaA6EnDl7AkGlpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870892; c=relaxed/simple;
	bh=MjR3v+ir58ce2tUztonJitgq+S7j4/79JLBRB5k0pZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TI6pzZ6PYwwGMwZP7bANqlf9eUMmjXxiBrkIYisAju85ag65cm5UzPnjPbHePkxrRLgeAO0IBtbnnThrfvu4QMHAfyaSa4B67vqMozdo7p9iWLQqch5TmAuF7wN7gbzGZuxg7sLe/zQ8TDwyHsco2U0j3N17N6Er6yXD9IeM4Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eFCAe9Z+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eFCAe9Z+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787870890; x=1819406890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MjR3v+ir58ce2tUztonJitgq+S7j4/79JLBRB5k0pZY=;
  b=eFCAe9Z+l5Mj6kWlCGPsi0iIOr2wkk3NcXyYdF41mnFk2e4jPmkCTy8l
   i4ePLYIh8oRQvGDNVq82Cbcs/G0fyMcM+XQy78XMg+oS0x1fsXesz10Fr
   Gl8RwiZCzxD+KoVIM1ILhG/8gyNutX6BOMTurD51m1S/mNJr5vX7ILaPh
   QNkowDSDJhDJBJhhy999bHKz05E5WLaSRhbE7vfg5i/aOyE4OkGDFh5MI
   vRz2BwnQvFplw5M1rzoU5KX+KMkx/jnsZEYorKTh4KPUYYJ5/tNTF1ZHH
   vsbNTy4FoizIWJl1Ll9e1lj7hI8CmPvl9Sw+hnQ/U6YIZQkdPYl6MF/2l
   Q==;
X-CSE-ConnectionGUID: 7v/GqIb+SJWjNs5B8KsuLw==
X-CSE-MsgGUID: JzDIyJsbS5S82pLPjeAjZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113914849"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="113914849"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:07 -0700
X-CSE-ConnectionGUID: NIf4TD2ASL+zX1PavZNPVw==
X-CSE-MsgGUID: jtEkWwe/TpK2XhXKzP9CMg==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:07 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Jim Mattson <jmattson@google.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v2 05/16] KVM: x86/pmu: Add PMC bitmap accessor helpers
Date: Thu, 27 Aug 2026 15:37:44 -0700
Message-ID: <20260827223755.143247-6-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827223755.143247-1-zide.chen@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pmu->nr_arch_{gp,fixed}_counters is not able to represent that a PMU
may include non-contiguous GP or fixed counters.

pmu->pmc_exists already holds a bitmap indicating both fixed and
general-purpose counters, and loops over valid counters can be done via
pmu->pmc_exists alone. Extend it to a union so that the u64 alias is
available for convenient mask arithmetic operations.

Add the necessary helpers to prepare for bitmap-based PMC counter
implementation.

No functional change intended.

Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v2:
- Rename kvm_{gp,fixed}_pmc_supported() to kvm_is_{gp,fixed}_pmc_supported()
  and simplify them by removing the temporary bitmap. (Sean)
- Split kvm_for_each_set_pmc_idx() to kvm_for_each_gp_counter()
  and kvm_for_each_fixed_counter(). (Sean)
---
 arch/x86/include/asm/kvm_host.h |  5 +++-
 arch/x86/kvm/pmu.h              | 53 +++++++++++++++++++++++++++++----
 2 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 90d80483df7f..49a8a2e9cee0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -594,7 +594,10 @@ struct kvm_pmu {
 		DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
 		atomic64_t __reprogram_pmi;
 	};
-	DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
+	union {
+		DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
+		u64 pmc_exists64;
+	};
 	DECLARE_BITMAP(pmc_in_use, X86_PMC_IDX_MAX);
 
 	DECLARE_BITMAP(pmc_counting_instructions, X86_PMC_IDX_MAX);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 090c9bbb74f4..b7a319b1eccc 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -88,6 +88,30 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
 	return enable_mediated_pmu && vcpu_to_pmu(vcpu)->version;
 }
 
+static inline unsigned long kvm_gp_pmc_mask(struct kvm_pmu *pmu)
+{
+	return pmu->pmc_exists64 &
+	       GENMASK_ULL(KVM_MAX_NR_GP_COUNTERS - 1, 0);
+}
+
+static inline unsigned long kvm_fixed_pmc_mask(struct kvm_pmu *pmu)
+{
+	return (pmu->pmc_exists64 >> KVM_FIXED_PMC_BASE_IDX) &
+		GENMASK_ULL(KVM_MAX_NR_FIXED_COUNTERS - 1, 0);
+}
+
+static inline bool kvm_is_gp_pmc_supported(struct kvm_pmu *pmu, unsigned int idx)
+{
+	return idx < KVM_MAX_NR_GP_COUNTERS &&
+	       test_bit(idx, pmu->pmc_exists);
+}
+
+static inline bool kvm_is_fixed_pmc_supported(struct kvm_pmu *pmu, unsigned int idx)
+{
+	return idx < KVM_MAX_NR_FIXED_COUNTERS &&
+	       test_bit(KVM_FIXED_PMC_BASE_IDX + idx, pmu->pmc_exists);
+}
+
 /*
  * KVM tracks all counters in 64-bit bitmaps, with general purpose counters
  * mapped to bits 31:0 and fixed counters mapped to 63:32, e.g. fixed counter 0
@@ -104,11 +128,11 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
  */
 static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
 {
-	if (idx < pmu->nr_arch_gp_counters)
+	if (kvm_is_gp_pmc_supported(pmu, idx))
 		return &pmu->gp_counters[idx];
 
 	idx -= KVM_FIXED_PMC_BASE_IDX;
-	if (idx >= 0 && idx < pmu->nr_arch_fixed_counters)
+	if (kvm_is_fixed_pmc_supported(pmu, idx))
 		return &pmu->fixed_counters[idx];
 
 	return NULL;
@@ -120,6 +144,17 @@ static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
 			continue;				\
 		else						\
 
+/*
+ * @mask is expected to be a scalar unsigned long derived from pmu->pmc_exists,
+ * which is already constrained by KVM_MAX_NR_{AMD,INTEL}_{GP,FIXED}_COUNTERS,
+ * so iteration up to KVM's maximum counter count is safe.
+ */
+#define kvm_for_each_gp_counter(i, mask)	\
+	for_each_set_bit((i), &(mask), KVM_MAX_NR_GP_COUNTERS)
+
+#define kvm_for_each_fixed_counter(i, mask)	\
+	for_each_set_bit((i), &(mask), KVM_MAX_NR_FIXED_COUNTERS)
+
 static inline u64 pmc_bitmask(struct kvm_pmc *pmc)
 {
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
@@ -168,9 +203,12 @@ static inline bool kvm_valid_perf_global_ctrl(struct kvm_pmu *pmu,
 static inline struct kvm_pmc *get_gp_pmc(struct kvm_pmu *pmu, u32 msr,
 					 u32 base)
 {
-	if (msr >= base && msr < base + pmu->nr_arch_gp_counters) {
+	if (msr >= base && msr < base + KVM_MAX_NR_GP_COUNTERS) {
 		u32 index = array_index_nospec(msr - base,
-					       pmu->nr_arch_gp_counters);
+					       KVM_MAX_NR_GP_COUNTERS);
+
+		if (!kvm_is_gp_pmc_supported(pmu, index))
+			return NULL;
 
 		return &pmu->gp_counters[index];
 	}
@@ -183,9 +221,12 @@ static inline struct kvm_pmc *get_fixed_pmc(struct kvm_pmu *pmu, u32 msr)
 {
 	int base = MSR_CORE_PERF_FIXED_CTR0;
 
-	if (msr >= base && msr < base + pmu->nr_arch_fixed_counters) {
+	if (msr >= base && msr < base + KVM_MAX_NR_FIXED_COUNTERS) {
 		u32 index = array_index_nospec(msr - base,
-					       pmu->nr_arch_fixed_counters);
+					       KVM_MAX_NR_FIXED_COUNTERS);
+
+		if (!kvm_is_fixed_pmc_supported(pmu, index))
+			return NULL;
 
 		return &pmu->fixed_counters[index];
 	}
-- 
2.55.0

