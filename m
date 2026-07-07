Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5495143F4D8;
	Tue,  7 Jul 2026 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449841; cv=none; b=cGwfdVBtUReep3k12vRoVscD32wKFsMm6aBriRr0f59imJMrHrzJbnB5qhSyacjKj4mVNKqTHOP+GtoPVfa4rfVF625rALfpI+3wDOlUfC7lZJeg3a5Rr57/FYCjfW/clUCX5OmGAAQrndZwnZlMRbT8evbaF/f2WiMwroZ1H1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449841; c=relaxed/simple;
	bh=GdSRe0Jp3cLHq/je/2gCKEFw2IGAT1TpXqoa10GMqpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1l3MKhZvEkZarFdJVNjXkPrwWyh+/NkRErXBGBynUldcJIcChSP8DwzWp8VnLeppOm3M9zKZ+UJhVFqW1lmuPDx4NPG0DeCtG/U/RXHmzStfFkf/S7k1dhhr0/LMbjuCsWq7XbRsNhY5zZTUk0UtJCOoQwvsilVbwyUPBiiuFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QD6FM65d; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QD6FM65d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783449839; x=1814985839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GdSRe0Jp3cLHq/je/2gCKEFw2IGAT1TpXqoa10GMqpw=;
  b=QD6FM65dOeFYW8PJJAl8h1tmg4+7WSL5VL5MXw8cfyFSMHlS7FPvgYb0
   Xk1CT007qtY/VS2WdLOUj6eV0CHbI9jwW12AXWhtXts9UGGFEH7xQPuDx
   wh4By/qYYpMcbqwTGMvTk+TRsxaA4eNwEVs8e+eJJPO0ermBgXkx9Xlkt
   Rj+pfXEGhBcKXkd3ezNTH6W/RCnd2k+lcWiRofvsMfFC1snjBSW/eDeFy
   FmDO6ub1CbhAI6iN8Tmk+p3XwXrKm0pSSMQfJQ8yJwX5ZkR1bgkEbKgZ3
   vjlNI8eWWHBIWfFzMUAUWQ/jzN8VGFQiWegXIO1+zxj0HZu+jIkzw1bId
   w==;
X-CSE-ConnectionGUID: sGgE8aElQ/Cq76eKJRAK7A==
X-CSE-MsgGUID: cz/y974vSfGtu/JTg3yOUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94713861"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94713861"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:57 -0700
X-CSE-ConnectionGUID: xiv9F0SYTLeCzHoZJQhpQA==
X-CSE-MsgGUID: fbOHEn+AQ5Gt75t2/Ok8wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277279289"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:56 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
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
Subject: [PATCH 04/15] KVM: x86/pmu: Add PMC bitmap accessor helpers
Date: Tue,  7 Jul 2026 11:33:54 -0700
Message-ID: <20260707183405.15571-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707183405.15571-1-zide.chen@intel.com>
References: <20260707183405.15571-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pmu->nr_arch_{gp,fixed}_counters is not able to represent that a PMU
may include non-contiguous GP or fixed counters.

pmu->all_valid_pmc_mask already holds a bitmap indicating both fixed
and general-purpose counters, and loops over valid counters can be
done via pmu->all_valid_pmc_mask alone. Extend it to a union so that
the u64 alias is available for convenient mask arithmetic operations.

Add the necessary helpers to prepare for bitmap-based PMC counter
implementation.

No functional change intended.

Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  5 ++-
 arch/x86/kvm/pmu.h              | 55 +++++++++++++++++++++++++++++----
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 395b6f20e9ac..f648dc168685 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -643,7 +643,10 @@ struct kvm_pmu {
 		DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
 		atomic64_t __reprogram_pmi;
 	};
-	DECLARE_BITMAP(all_valid_pmc_mask, X86_PMC_IDX_MAX);
+	union {
+		DECLARE_BITMAP(all_valid_pmc_mask, X86_PMC_IDX_MAX);
+		u64 all_valid_pmc_mask64;
+	};
 	DECLARE_BITMAP(pmc_in_use, X86_PMC_IDX_MAX);
 
 	DECLARE_BITMAP(pmc_counting_instructions, X86_PMC_IDX_MAX);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index cdbefda844b9..95dc95a9ae37 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -88,6 +88,32 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
 	return enable_mediated_pmu && vcpu_to_pmu(vcpu)->version;
 }
 
+static inline unsigned long kvm_gp_pmc_mask(struct kvm_pmu *pmu)
+{
+	return pmu->all_valid_pmc_mask64 &
+	       GENMASK_ULL(KVM_MAX_NR_GP_COUNTERS - 1, 0);
+}
+
+static inline unsigned long kvm_fixed_pmc_mask(struct kvm_pmu *pmu)
+{
+	return (pmu->all_valid_pmc_mask64 >> KVM_FIXED_PMC_BASE_IDX) &
+		GENMASK_ULL(KVM_MAX_NR_FIXED_COUNTERS - 1, 0);
+}
+
+static inline bool kvm_gp_pmc_supported(struct kvm_pmu *pmu, unsigned int idx)
+{
+	unsigned long bitmap = kvm_gp_pmc_mask(pmu);
+
+	return idx < KVM_MAX_NR_GP_COUNTERS && test_bit(idx, &bitmap);
+}
+
+static inline bool kvm_fixed_pmc_supported(struct kvm_pmu *pmu, unsigned int idx)
+{
+	unsigned long bitmap = kvm_fixed_pmc_mask(pmu);
+
+	return idx < KVM_MAX_NR_FIXED_COUNTERS && test_bit(idx, &bitmap);
+}
+
 /*
  * KVM tracks all counters in 64-bit bitmaps, with general purpose counters
  * mapped to bits 31:0 and fixed counters mapped to 63:32, e.g. fixed counter 0
@@ -104,11 +130,11 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
  */
 static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
 {
-	if (idx < pmu->nr_arch_gp_counters)
+	if (kvm_gp_pmc_supported(pmu, idx))
 		return &pmu->gp_counters[idx];
 
 	idx -= KVM_FIXED_PMC_BASE_IDX;
-	if (idx >= 0 && idx < pmu->nr_arch_fixed_counters)
+	if (kvm_fixed_pmc_supported(pmu, idx))
 		return &pmu->fixed_counters[idx];
 
 	return NULL;
@@ -120,6 +146,17 @@ static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
 			continue;				\
 		else						\
 
+/*
+ * @mask must be an lvalue of type unsigned long because for_each_set_bit()
+ * takes its address.
+ *
+ * @type is token-pasted into KVM_MAX_NR_##type##_COUNTERS to match one of the
+ * counter defines, e.g. GP, FIXED, AMD_GP, INTEL_GP, or INTEL_FIXED. This
+ * reflects what KVM supports, not the underlying host's PMU capabilities.
+ */
+#define kvm_for_each_set_pmc_idx(i, mask, type)		\
+	for_each_set_bit((i), &(mask), KVM_MAX_NR_##type##_COUNTERS)
+
 static inline u64 pmc_bitmask(struct kvm_pmc *pmc)
 {
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
@@ -168,9 +205,12 @@ static inline bool kvm_valid_perf_global_ctrl(struct kvm_pmu *pmu,
 static inline struct kvm_pmc *get_gp_pmc(struct kvm_pmu *pmu, u32 msr,
 					 u32 base)
 {
-	if (msr >= base && msr < base + pmu->nr_arch_gp_counters) {
+	if (msr >= base && msr < base + KVM_MAX_NR_GP_COUNTERS) {
 		u32 index = array_index_nospec(msr - base,
-					       pmu->nr_arch_gp_counters);
+					       KVM_MAX_NR_GP_COUNTERS);
+
+		if (!kvm_gp_pmc_supported(pmu, index))
+			return NULL;
 
 		return &pmu->gp_counters[index];
 	}
@@ -183,9 +223,12 @@ static inline struct kvm_pmc *get_fixed_pmc(struct kvm_pmu *pmu, u32 msr)
 {
 	int base = MSR_CORE_PERF_FIXED_CTR0;
 
-	if (msr >= base && msr < base + pmu->nr_arch_fixed_counters) {
+	if (msr >= base && msr < base + KVM_MAX_NR_FIXED_COUNTERS) {
 		u32 index = array_index_nospec(msr - base,
-					       pmu->nr_arch_fixed_counters);
+					       KVM_MAX_NR_FIXED_COUNTERS);
+
+		if (!kvm_fixed_pmc_supported(pmu, index))
+			return NULL;
 
 		return &pmu->fixed_counters[index];
 	}
-- 
2.54.0

