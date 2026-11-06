Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929833;
	b=YN8MF2qQrp/7/7ZgkGuETsUTxn35fLq7WjHF3DbQ6lj8DX1kdhkx6RsgB5IKgzq9N+/0
	 nY5NHNJIakpqzlOvNE3b5pV3g2DjsaBg+iyvhm+K+SQxm0Ntac+NXLvJlPDXiGKOV0IRB
	 UXrqy6Ed2iXvMCTwp2NzskpnrUzjuoXensle98DssiAJdSqI/OAntipeVmMwzSz5Wt1Q2
	 /VpECWTk4ImnuO9fgmYQJ3+SDscV+yP5aSPK0R4AhEl+fFdHzY3+0jxTVlT6Hv78KSHpO
	 EoV9AByaciZxNLPkq1UFuMULqKWJix4HOj4aAmKHGKg88LSYZ1SumlyMMaZ9yo57xVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929833;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bUOln4U2FF/puLEf0pn993EVXbkgVqskZvfUNJSHFqU=;
	b=ByKSBbKJsGfJnQOEZBepnh3Yybg4i8zclWIIF156lUXT1Yn16Ap/PpCfA5RFlA9Y2pId
	 DDUtdWggbo5sjj62De6FrdLgnJ0ar9Ze/hbJMNduAgcPxeO4chyKeHHQsHuaAdDSl6CSW
	 eefFKCXP8awTMsyT/RHEL35DK7ypW5wYw4+adPsZHEGAG/OfrZYr+dEWUke6iwlDNohpp
	 u8f2AcGJkFc09F23dyS2oUSaUFD8NDSh1OYAnGVHg5j34cSQhXmSoVN6dgd793tR9L5UI
	 IXK+wtvdyAFnQGCcUYOGlDhW9gIaHnfIwtogNPVPCsxwDrollPze0MxNfo8wUW7YErw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lyIislUo;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E431606A32C;
	Fri,  6 Nov 2026 01:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E431606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lyIislUo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793929832; x=1825465832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VtNrPeVlgJDqgaLn1snqqrxLTe1ffW04yWpbYOCvUpY=;
  b=lyIislUoyQjuGsJW6dwz3stoWzq5slOTFM4rrbAbe+QrxYWwyLFaju53
   iBr+5z/VnlOVs6OUt26lzgsMxnZwnCPNxWtlQ6yGO14PcJjoVqWc0J8uC
   kvuAA1TUmbbDq7grwEr4Hipwf0/3QnRCXBCG22hNFP0SX8GCpEwN9R5bW
   0qgOXWhBTTG9+082ar+hlbt0oMQ45s4KhlsVqVGZh9p1KDqOPT30SwyJ2
   cHoBqsvfkMzRUEJRwPNmzn/rBeWI7EsORVfS0alkQwtXWukcIwx41QoPI
   OjVkdTyzfyKs7dm5O95xF1bodvY9oAPcRUmx/OrK/+QM1S8tWN76yzAsG
   A==;
X-CSE-ConnectionGUID: 3qgoHlnZQmSzOrvpWqKePA==
X-CSE-MsgGUID: yaSZL18VTjamIDsPuW5lKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740119"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2740119"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:30 -0800
X-CSE-ConnectionGUID: aVkHWtGAT+eY0wJsL+ZDOg==
X-CSE-MsgGUID: ALOFZDTfRwam1EXJJZEeOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067170"
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
Subject: [PATCH v3 02/18] KVM: x86/pmu: Rename all_valid_pmc_idx to pmc_exists
Date: Thu,  5 Nov 2026 18:39:11 -0700
Message-ID: <20261106013927.166209-3-zide.chen@intel.com>
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

all_valid_pmc_idx is a bitmap of valid PMC indices, not an index
itself; rename it to pmc_exists to better reflect what it holds and
keep the name consistent with other fields in the same struct.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
v2:
- Pick the name pmc_exists other than all_valid_pmc_mask. (Sean)
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/pmu.c              | 10 +++++-----
 arch/x86/kvm/vmx/pmu_intel.c    |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e2eef7057bd3..72b8fbf432a2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -595,7 +595,7 @@ struct kvm_pmu {
 		DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
 		atomic64_t __reprogram_pmi;
 	};
-	DECLARE_BITMAP(all_valid_pmc_idx, X86_PMC_IDX_MAX);
+	DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
 	DECLARE_BITMAP(pmc_in_use, X86_PMC_IDX_MAX);
 
 	DECLARE_BITMAP(pmc_counting_instructions, X86_PMC_IDX_MAX);
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index eef2f792dc9e..83883191d124 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -944,7 +944,7 @@ static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 	bitmap_zero(pmu->reprogram_pmi, X86_PMC_IDX_MAX);
 	bitmap_zero(pmu->pmc_has_mode_specific_enables, X86_PMC_IDX_MAX);
 
-	kvm_for_each_pmc(pmu, pmc, i, pmu->all_valid_pmc_idx) {
+	kvm_for_each_pmc(pmu, pmc, i, pmu->pmc_exists) {
 		pmc_stop_counter(pmc);
 		pmc->counter = 0;
 		pmc->emulated_counter = 0;
@@ -990,7 +990,7 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->fixed_ctr_ctrl_rsvd = ~0ull;
 	pmu->pebs_enable_rsvd = ~0ull;
 	pmu->pebs_data_cfg_rsvd = ~0ull;
-	bitmap_zero(pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
+	bitmap_zero(pmu->pmc_exists, X86_PMC_IDX_MAX);
 
 	if (!vcpu->kvm->arch.enable_pmu)
 		return;
@@ -1011,8 +1011,8 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	if (kvm_vcpu_has_mediated_pmu(vcpu))
 		kvm_pmu_call(write_global_ctrl)(pmu->global_ctrl);
 
-	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
-	bitmap_set(pmu->all_valid_pmc_idx, KVM_FIXED_PMC_BASE_IDX,
+	bitmap_set(pmu->pmc_exists, 0, pmu->nr_arch_gp_counters);
+	bitmap_set(pmu->pmc_exists, KVM_FIXED_PMC_BASE_IDX,
 		   pmu->nr_arch_fixed_counters);
 }
 
@@ -1034,7 +1034,7 @@ void kvm_pmu_cleanup(struct kvm_vcpu *vcpu)
 
 	pmu->need_cleanup = false;
 
-	bitmap_andnot(bitmask, pmu->all_valid_pmc_idx,
+	bitmap_andnot(bitmask, pmu->pmc_exists,
 		      pmu->pmc_in_use, X86_PMC_IDX_MAX);
 
 	kvm_for_each_pmc(pmu, pmc, i, bitmask) {
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 36d91215f42a..ee18899614a1 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -560,7 +560,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 		lbr_desc->records.nr = 0;
 
 	if (lbr_desc->records.nr)
-		bitmap_set(pmu->all_valid_pmc_idx, INTEL_PMC_IDX_FIXED_VLBR, 1);
+		bitmap_set(pmu->pmc_exists, INTEL_PMC_IDX_FIXED_VLBR, 1);
 
 	if (pmu->version == 1)
 		return;
-- 
2.56.0

