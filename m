Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929834;
	b=VvJJSxuH3GlWMJkuY23nhQ8Ib+InaDZiYCDXcHQzJSTE8axB1Yqhs0OxNQkXERYcoMtw
	 SfNpgUkGWXjbCXMvTKGEhLYMEklyrwveWzjbXp7CbcLI5MgIs9/oeZnvKqfeF0VSC1nyH
	 GEjqce04QZTuTEizZT7sxrDa+mx821HXiqbrUhnOmLR8G2H1sk0u39fH02wPhtQNlwmsK
	 OzvT206fzVRlMWrX/+3igckCTIbNp5JW1gpzJkteJC1bF4NwlDutdIw6Tm1zHvjWqhpGJ
	 JWTT0VssW3xK9xgGt8VHGKf9cA29FyOShGook3IFXHC5sUXWlnc0l3VS7pOjuqYrFqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929834;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nLSIkuoCJn5rhHMbEg9ggMw2GppmGJlKwcSugCsQ54c=;
	b=3teCTF9hREEbLEJty18iq+Ovkz+YrC0jabZExwIgo00IYol6SezBVn1hMYgFLiuBo20i
	 +XoogvGL9uJcFt9C7B8mNpsJlGdbQMiZ8D6MkKW9esutZi1TRV4ZtAqS3WNgU4QXQ+qEl
	 qNGaymJCEdaDlDAKvc42MyQGaSADINsP5iht3qcFIYf1Namzl3KoYhDC8QqXwOh0pKZY/
	 xZ1DatWnt7REeH0uZhNzYq03POMhs+le94rmYEQFpT017tIKUUIveaPFB691w7cgwCNVg
	 9vpgSG6susmOPVZD4GqzSy4RFMPK92MbpW3jwVPvWQ16LK7pk0KhC8BdRg48t1V2G8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RhOv5zac;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799E7606A332;
	Fri,  6 Nov 2026 01:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 799E7606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RhOv5zac
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793929833; x=1825465833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hIqZ1NRYpahaEBrIllhtJ0aMrQ/IgXBWdNI9M6GjNOY=;
  b=RhOv5zac0xHJxeZnDu/VUwiblYe/CJpRoGk6LpQx4RYHgdzMM9nlVoOL
   jL6G2LebzdeKcF/8uV3aVgCrxQrH9XNWPU6+CsTc0gqU3gBz/PNtw/+GH
   5RagZqANHexvL9rJAKDDi2XU4dExxRf/4miU45WpyxAfWFpiREvYAIBDP
   wF8SYbIHQoIbgrX4b6RsnmopPj083iDR33SKV3/0SB/cYTszmNazehbie
   e55LelVtHsRzu4rwhGJjlPJ2nN6Yz0BuBUJtJPEmlObG1aei0Bk7PqsL1
   /WWKn7JQ2WUUAmbWKQ1cX6pJnGdrFYMSqCBBdoS5vu6qdPK3tOhe3bJyP
   w==;
X-CSE-ConnectionGUID: A/46LBKCQGes8IvpMh3VDA==
X-CSE-MsgGUID: ZazWXCMGQO+Y+J9i1Ex1YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740131"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2740131"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:31 -0800
X-CSE-ConnectionGUID: 3gP62zpLTruIpikloz+RWg==
X-CSE-MsgGUID: 0v0KI+ztQNq6Omyi5ofnQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067175"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:30 -0800
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
Subject: [PATCH v3 04/18] KVM: x86/pmu: Add PMC bitmap accessor helpers
Date: Thu,  5 Nov 2026 18:39:13 -0700
Message-ID: <20261106013927.166209-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106013927.166209-1-zide.chen@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
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
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
v3:
- Add BUILD_BUG_ON(). (Jim)
v2:
- Rename kvm_{gp,fixed}_pmc_supported() to kvm_is_{gp,fixed}_pmc_supported()
  and simplify them by removing the temporary bitmap. (Sean)
- Split kvm_for_each_set_pmc_idx() to kvm_for_each_gp_counter()
  and kvm_for_each_fixed_counter(). (Sean)
---
 arch/x86/include/asm/kvm_host.h |  5 +++-
 arch/x86/kvm/pmu.c              |  2 ++
 arch/x86/kvm/pmu.h              | 53 +++++++++++++++++++++++++++++----
 3 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b8875ed5502c..4f192429ed93 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -595,7 +595,10 @@ struct kvm_pmu {
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
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index cbd63329cf13..5e174d95f3b7 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1024,6 +1024,8 @@ void kvm_pmu_init(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 
+	BUILD_BUG_ON(sizeof(pmu->pmc_exists) != sizeof(pmu->pmc_exists64));
+
 	memset(pmu, 0, sizeof(*pmu));
 	kvm_pmu_call(init)(vcpu);
 }
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 090c9bbb74f4..016935c3a8ec 100644
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
+	       GENMASK_ULL(KVM_MAX_NR_FIXED_COUNTERS - 1, 0);
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
2.56.0

