Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E35237A1;
	Fri, 18 Sep 2026 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761016; cv=none; b=i1yzX5sJ7s2aik/5ob/AgP2ksH4E6Q+U34SrmuvsJX6vpSixlkOHk1Pj4LKx59MdbD/y0baK5GQZAhcFIAyHo9jd4VzHuUlxTSmutc8oNAG9OsAiy+6kA3pK0E5FxwkvRE26iYjNMH/Rnw4MuN+9aBjvqUoYsplGr32XUryffVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761016; c=relaxed/simple;
	bh=YeQrnXm/MpIrm1eB//WMGKQys/HDtcFhaBFrGisfMgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBddIOWo9Tx/91KQkUkahsjfdIq8tB3a4Ez2pD6nKzUhWLSuIa9PPLQMBeXw8B3xiuMnZ9AgNdwULmNxycqn+7qSLaUVE2xk/I6mbzBbjbj+M3QtWOAP0RZT5WOQK84HleGtkg9sAZbXom9xclmsC3G3Eem+Y0hPpzIcV6AAEBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S332o+C7; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S332o+C7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789761005; x=1821297005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YeQrnXm/MpIrm1eB//WMGKQys/HDtcFhaBFrGisfMgs=;
  b=S332o+C7IeItsj0T8aSS+O1XjPF/iNPbfwKlIHDDyfDPTPERzpF/99ZA
   4ohCSh6POw5+5cBhSlfcoVBsvcP6DuSPK19QTW4kvUgRyWITaar543+sL
   Hxts+y5ZvgRKiQRbHmOIzbfNHKzMgJ4nCe1eauzCxgADJQGE/aBlAJvpx
   ilgm/rusiPJ8DsVBt8539K1bMKp0QVLp7BT/0rMflss6GmC95teKdj0IJ
   jhvjAUpZW5bgae3Gt6XmBGuIYBmlKSV6vIf1gFEhC8avIevdT3qhil5Bo
   xngTmg8HR3JbTHnYgYN4bFJkBWjiWjLrWvA2WD0kOY/5scS189RpDrTV9
   Q==;
X-CSE-ConnectionGUID: zYBOJH0sSDCGqTxpCtNhbg==
X-CSE-MsgGUID: 9gtHUyMqSDO0WoUfFGgXsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="790323"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="790323"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:50:00 -0700
X-CSE-ConnectionGUID: YaIpM4s5QYKEPpg2rV7GEg==
X-CSE-MsgGUID: 68etZKu0TVmakTEdLgXDrA==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:50:00 -0700
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
Subject: [PATCH v9 06/12] KVM: x86/pmu: Move RDPMC emulation into per-vendor callbacks
Date: Fri, 18 Sep 2026 12:39:31 -0700
Message-ID: <20260918193937.569414-7-zide.chen@intel.com>
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
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
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
index f4d3801b97bc..897c1428b650 100644
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
index fe66f03b006b..2eb1bff75e60 100644
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
@@ -866,7 +865,7 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
 }
 
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
-	.rdpmc_ecx_to_pmc = intel_rdpmc_ecx_to_pmc,
+	.emulate_rdpmc = intel_emulate_rdpmc,
 	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
 	.is_valid_msr = intel_is_valid_msr,
 	.get_msr = intel_pmu_get_msr,
-- 
2.55.0

