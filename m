Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557214;
	b=kVQ9miaCxGeVyYss98m6dNz6ql5EK+IIxGn9A382VKuufdBUhb/8Zc9Hhm+IkHANg6/G
	 2cGhasED9jJWgEcyXnQuaVM2fyQZFDTV7Iyx+R0j//0nAdlkDW6Y4cSsa00lujxUwsABw
	 AFQQGgzDji/soPn3vjV45/MrO8VYqz4mOxcPOvsMT+I0lOSU0DMr+o1byj4uNJTWsdO3I
	 XxKsZXYtWk9YtXF0hj+xsJDI+PfRyhOZ3h6R6LkggyGpWIJnTlXGmKxDB1y2wxrGJX7KS
	 9O7GUVU0C8KEKwm1YfgCqU8xyDiO7ks7eqbjFNk3OY0o/8jU1KXtpOHofdLPGChYXcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557214;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NTgRq+o8NTT9CKG30vPpL9VWDVQk3YI5fcpRio4vniQ=;
	b=brbrZjcGWK9WvNSe7IWpfZvTH2ywtIp3gRwo+Vcc0Onla48qP73vO4pC5ckm/PF7ofqn
	 Xk7YDBNG1SR0ro7IG6k5O8dblOFS8mBZJl5Hyabls+T0dWsqwcs0F6uxjPsQnH5dYpB64
	 GDxf/VWMXNZDbylLTt/d6s5s/y0iokOaAfer7nHTIdEcqxzQBJY5RHD1VUHEcY5Y+MbCL
	 wOImDcmGtbfMf5cCPaCOuW4yZzyGBCICnx5m5Bzu65qHgDQMEHeDvYgxYqfCypXkEs/Nl
	 BMiL4wAvZppn6qqybGFBB2rkM5FbYeHwPGZAwEpCA11F8wXw/MQUCGH7YeXu+wzgApw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mo91cucY;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19587606A6A6;
	Tue, 24 Nov 2026 21:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19587606A6A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mo91cucY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557211; x=1827093211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WBlpOtIZ/ZdzpUoYbK5LShQHft3qZ71PQBZ4sGIFT3k=;
  b=mo91cucYFGfdpel3zY5gEk8ZyXbTyHuwWacmXf7UHM9ds+ZGsqMNMrLd
   JHtakIvU+S4jBb41HCIV4bfJBLZ4YO0rgCmB44W3Ytfqd/VbKsNd4BEUO
   8P04TbHQtO+aTY9VSdVWxb2FlFQ9cbmB5hdC4V1a7hhLGtHKR68SPA1cL
   kdptnQiqhOLfn7sCBDQxIyKO1fH5KdDdLARUdQKiHt7n18on0ZeZn4AG5
   m3GKhiHN+165BtSIVvBe5FrvyCREGoukvHy6cj1CDScDkzWbUci6nArHS
   y27GBL99JMxu2p/RR8xcMz2uxzZFRvH24Bwu+XFZBlKghUi8Assc9p190
   w==;
X-CSE-ConnectionGUID: lG1CiMyZSYuEumiExxHkMQ==
X-CSE-MsgGUID: jUul/UGFRwqskgA5nVj5Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4306057"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4306057"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:30 -0800
X-CSE-ConnectionGUID: yJnXrYZiSV2ABOycvV8lCQ==
X-CSE-MsgGUID: 3EkV0rvrRUaQfKlJ2YcWlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271941"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:29 -0800
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
Subject: [PATCH v10 12/18] KVM: x86/pmu: Move RDPMC emulation into per-vendor callbacks
Date: Tue, 24 Nov 2026 14:38:55 -0700
Message-ID: <20261124213901.120572-13-zide.chen@intel.com>
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

The current RDPMC emulation splits responsibility: rdpmc_ecx_to_pmc()
in each vendor returns a kvm_pmc, then common code calls
pmc_read_counter().

This design cannot support RDPMC reads that do not map to a counter,
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
 arch/x86/kvm/svm/pmu.c                 | 14 ++++++++++----
 arch/x86/kvm/vmx/pmu_intel.c           | 25 ++++++++++++-------------
 5 files changed, 26 insertions(+), 28 deletions(-)

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
index 45721c6fa92b..d4fd1d9d5d93 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -777,8 +777,6 @@ static int kvm_pmu_rdpmc_vmware(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
-	struct kvm_pmc *pmc;
-	u64 mask = ~0ull;
 
 	if (!pmu->version)
 		return 1;
@@ -786,17 +784,12 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
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
 
 static bool kvm_pmu_incomplete_passthrough(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 1d7cbe89fa95..40395d271392 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -27,8 +27,8 @@
 #define KVM_FIXED_SLOTS_IDX    (INTEL_PMC_IDX_FIXED_SLOTS - INTEL_PMC_IDX_FIXED)
 
 struct kvm_pmu_ops {
-	struct kvm_pmc *(*rdpmc_ecx_to_pmc)(struct kvm_vcpu *vcpu,
-		unsigned int idx, u64 *mask);
+	int (*emulate_rdpmc)(struct kvm_vcpu *vcpu, unsigned int idx,
+			     u64 *data);
 	struct kvm_pmc *(*msr_idx_to_pmc)(struct kvm_vcpu *vcpu, u32 msr);
 	int (*check_rdpmc_early)(struct kvm_vcpu *vcpu, unsigned int idx);
 	bool (*is_valid_msr)(struct kvm_vcpu *vcpu, u32 msr);
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index c18286545a7a..6f9a190a6905 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -84,10 +84,16 @@ static int amd_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx)
 }
 
 /* idx is the ECX register of RDPMC instruction */
-static struct kvm_pmc *amd_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
-	unsigned int idx, u64 *mask)
+static int amd_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx,
+			     u64 *data)
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
@@ -302,7 +308,7 @@ static bool amd_pmc_is_disabled_in_current_mode(struct kvm_pmc *pmc)
 }
 
 struct kvm_pmu_ops amd_pmu_ops __initdata = {
-	.rdpmc_ecx_to_pmc = amd_rdpmc_ecx_to_pmc,
+	.emulate_rdpmc = amd_emulate_rdpmc,
 	.msr_idx_to_pmc = amd_msr_idx_to_pmc,
 	.check_rdpmc_early = amd_check_rdpmc_early,
 	.is_valid_msr = amd_is_valid_msr,
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 36a2269bbd96..858737504ec1 100644
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
@@ -833,7 +832,7 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
 }
 
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
-	.rdpmc_ecx_to_pmc = intel_rdpmc_ecx_to_pmc,
+	.emulate_rdpmc = intel_emulate_rdpmc,
 	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
 	.is_valid_msr = intel_is_valid_msr,
 	.get_msr = intel_pmu_get_msr,
-- 
2.56.1

