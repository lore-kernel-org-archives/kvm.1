Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3828836A341;
	Thu, 27 Aug 2026 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870890; cv=none; b=q9bGxd6qms/aOg/32jAycaVqLs2XRasIbSUxbK2dM1XNkEwQ4zes0bakpiPEqgV3GTRnh2uaKK3Jksrz17fbm3bp1WdQwagCdkNOU/dhM/NpLTBQ09bafnH1y3ukOTAvXC7M8XBGef1yYfeGAKQETrlVgF9NbUEVaaTkLVI7Pn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870890; c=relaxed/simple;
	bh=dR6/TseUjMA614wcJ9i0eM7k/gwiYKHzw6soXdZ7q1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4/lQdKcPcGaCPvzOZCBZc/hN+9y8Fk+7y8EoBln4YcD4jRTWnhjLYP7RTVpm/t34yYR0zXF72s5Fr554pqLA8LkDJzkSbOFbYs2vdjOJupo+QJ39WVYFpKhGEQx3OaRajW0qF99+RzyGV816waaMtwaZbEgLaUeEsEaHof8C4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mp2hNcTR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mp2hNcTR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787870888; x=1819406888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dR6/TseUjMA614wcJ9i0eM7k/gwiYKHzw6soXdZ7q1w=;
  b=mp2hNcTRcHGGC7jt0BYhFLNkaSDjzwjy90F92W4nYfKIP+ywikSCYP9E
   L6T90nlWX5lR0sSP4hMncI2rDbdKFK9gyf73ULfh6o5wbGlRylGm5ddLG
   5uEnMsC0qza/viLNqUvNxNgVKX968df9/jlyWyxRIBcx3P/rpMN1m3Vaf
   4AbEm7wDtNo6K60o4hMVjwBQTxXTXp59fbW263c4ECdDC1XSGq6Lr3CWX
   7B7W1qlvOLTUfZFJVxksnlrpcEEj7w0THXNgC00sO6/T7r3a4YolxvXK3
   w6HCxoFTdzSysvhezg/r8Ge/EW4faY6hVofodXmXNuWfAMellgmK2uQo0
   Q==;
X-CSE-ConnectionGUID: ew0RGY3YQHK5fqGPbjsA/A==
X-CSE-MsgGUID: SeLmBBuNQKq++G7dcP25bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113914831"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="113914831"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:06 -0700
X-CSE-ConnectionGUID: 2EJ8s0IZQjijn6FrnhW5dg==
X-CSE-MsgGUID: 29U8QPAVTpuARLZyy6Gb1w==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:06 -0700
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
Subject: [PATCH v2 02/16] KVM: x86/pmu: Rename all_valid_pmc_idx to pmc_exists
Date: Thu, 27 Aug 2026 15:37:41 -0700
Message-ID: <20260827223755.143247-3-zide.chen@intel.com>
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

all_valid_pmc_idx is a bitmap of valid PMC indices, not an index
itself; rename it to pmc_exists to better reflect what it holds and
keep the name consistent with other fields in the same struct.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v2:
- Pick the name pmc_exists other than all_valid_pmc_mask. (Sean)
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/pmu.c              | 10 +++++-----
 arch/x86/kvm/vmx/pmu_intel.c    |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 283847619ff8..e473796da7d9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -594,7 +594,7 @@ struct kvm_pmu {
 		DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
 		atomic64_t __reprogram_pmi;
 	};
-	DECLARE_BITMAP(all_valid_pmc_idx, X86_PMC_IDX_MAX);
+	DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
 	DECLARE_BITMAP(pmc_in_use, X86_PMC_IDX_MAX);
 
 	DECLARE_BITMAP(pmc_counting_instructions, X86_PMC_IDX_MAX);
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index a7d60c8785cd..8f2effee3b7b 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -950,7 +950,7 @@ static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 	bitmap_zero(pmu->reprogram_pmi, X86_PMC_IDX_MAX);
 	bitmap_zero(pmu->pmc_has_mode_specific_enables, X86_PMC_IDX_MAX);
 
-	kvm_for_each_pmc(pmu, pmc, i, pmu->all_valid_pmc_idx) {
+	kvm_for_each_pmc(pmu, pmc, i, pmu->pmc_exists) {
 		pmc_stop_counter(pmc);
 		pmc->counter = 0;
 		pmc->emulated_counter = 0;
@@ -996,7 +996,7 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->fixed_ctr_ctrl_rsvd = ~0ull;
 	pmu->pebs_enable_rsvd = ~0ull;
 	pmu->pebs_data_cfg_rsvd = ~0ull;
-	bitmap_zero(pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
+	bitmap_zero(pmu->pmc_exists, X86_PMC_IDX_MAX);
 
 	if (!vcpu->kvm->arch.enable_pmu)
 		return;
@@ -1017,8 +1017,8 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	if (kvm_vcpu_has_mediated_pmu(vcpu))
 		kvm_pmu_call(write_global_ctrl)(pmu->global_ctrl);
 
-	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
-	bitmap_set(pmu->all_valid_pmc_idx, KVM_FIXED_PMC_BASE_IDX,
+	bitmap_set(pmu->pmc_exists, 0, pmu->nr_arch_gp_counters);
+	bitmap_set(pmu->pmc_exists, KVM_FIXED_PMC_BASE_IDX,
 		   pmu->nr_arch_fixed_counters);
 }
 
@@ -1040,7 +1040,7 @@ void kvm_pmu_cleanup(struct kvm_vcpu *vcpu)
 
 	pmu->need_cleanup = false;
 
-	bitmap_andnot(bitmask, pmu->all_valid_pmc_idx,
+	bitmap_andnot(bitmask, pmu->pmc_exists,
 		      pmu->pmc_in_use, X86_PMC_IDX_MAX);
 
 	kvm_for_each_pmc(pmu, pmc, i, bitmask) {
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index e71ddd51ae56..322a3ad580dd 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -557,7 +557,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 		lbr_desc->records.nr = 0;
 
 	if (lbr_desc->records.nr)
-		bitmap_set(pmu->all_valid_pmc_idx, INTEL_PMC_IDX_FIXED_VLBR, 1);
+		bitmap_set(pmu->pmc_exists, INTEL_PMC_IDX_FIXED_VLBR, 1);
 
 	if (pmu->version == 1)
 		return;
-- 
2.55.0

