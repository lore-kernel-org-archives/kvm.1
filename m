Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D43343F4B5;
	Tue,  7 Jul 2026 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449840; cv=none; b=p6zqF8+Xbvgw3XQwnB9ZM+k5LNq5IU75CIVBPdvEhDxsYoVtzy6GP60FXCZ23hKY07LLc5SEuwr56jWmNrP0UNAWrUhm4ZBCQox1Npw0wjXi2cjsGUuhL0/Q0HnvGfVz8kt7mpXTifbk8iWpYZIxdGMZTrAkfBPQBXWVP2qqWtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449840; c=relaxed/simple;
	bh=jBdhc40OyjaLfF3/kSVv/SsaJLPV07v1T1Kpkpiuf4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0U5lh2MlzsOUGRFBOdnk9+oPm/NlHihzVC5/Do+97TfQARKOiiulPj0p39SWi44Pgay5lDYeLjF94VQizzyZHxgUVNbZsReLBjoldBp5a9G94PZgAYvSibCFo3QnpjbLf2Wr8jm4Vcmmj6tvl0cwboPOgZTdK5VX0iaVes8Q6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKeD1V6x; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKeD1V6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783449838; x=1814985838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jBdhc40OyjaLfF3/kSVv/SsaJLPV07v1T1Kpkpiuf4A=;
  b=MKeD1V6x1liIiKhVUPBcknB5kxiZEfAQDR++GbPmYQxG/XDKQn5MAm+P
   UFEf6RVVHmMNOKVtFCqJ1dqOCtJwhzkZiCez/JeP1GEtqKIH+ZxBZE8Dk
   HOQyRyerwe03AXgldxjUZbc4pe5zj/fwWcgMD/BgCi7GOgSdZ1b5LKY8E
   JwV6omhCC3N4ipcHHthoBrFhwL3DQNYPYcSTq6dcfRSDKmpwsBnBzAH8l
   F2Ixb6XDw6NHmgtiYiKd+IZYergFV+aejCZlHYLa7uk+iIznovaNFbVlF
   x1E2tWDa8O/w2oqfcO9TYQjFbhhWem6b0nAQNIqHXlbF0v851xTcYQwWz
   g==;
X-CSE-ConnectionGUID: wVZSk9QnTKa8gfqsKIovEw==
X-CSE-MsgGUID: SIZIyw8+Qliaus8FcaT/eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94713851"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94713851"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:57 -0700
X-CSE-ConnectionGUID: 3VO5v1ltREaIvEJAkDsa9g==
X-CSE-MsgGUID: ISKJ9IMBR6K10x/TPL4+og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277279283"
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
Subject: [PATCH 02/15] KVM: x86/pmu: Rename all_valid_pmc_idx to all_valid_pmc_mask
Date: Tue,  7 Jul 2026 11:33:52 -0700
Message-ID: <20260707183405.15571-3-zide.chen@intel.com>
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

all_valid_pmc_idx is a bitmap of valid PMC indices, not an index
itself; rename it to all_valid_pmc_mask to better reflect what it
holds.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/pmu.c              | 10 +++++-----
 arch/x86/kvm/vmx/pmu_intel.c    |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 96376d8a5199..4677773cfa30 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -643,7 +643,7 @@ struct kvm_pmu {
 		DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
 		atomic64_t __reprogram_pmi;
 	};
-	DECLARE_BITMAP(all_valid_pmc_idx, X86_PMC_IDX_MAX);
+	DECLARE_BITMAP(all_valid_pmc_mask, X86_PMC_IDX_MAX);
 	DECLARE_BITMAP(pmc_in_use, X86_PMC_IDX_MAX);
 
 	DECLARE_BITMAP(pmc_counting_instructions, X86_PMC_IDX_MAX);
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 04b9c840f218..9db12c54814d 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -967,7 +967,7 @@ static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 	bitmap_zero(pmu->reprogram_pmi, X86_PMC_IDX_MAX);
 	bitmap_zero(pmu->pmc_has_mode_specific_enables, X86_PMC_IDX_MAX);
 
-	kvm_for_each_pmc(pmu, pmc, i, pmu->all_valid_pmc_idx) {
+	kvm_for_each_pmc(pmu, pmc, i, pmu->all_valid_pmc_mask) {
 		pmc_stop_counter(pmc);
 		pmc->counter = 0;
 		pmc->emulated_counter = 0;
@@ -1014,7 +1014,7 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->fixed_ctr_ctrl_rsvd = ~0ull;
 	pmu->pebs_enable_rsvd = ~0ull;
 	pmu->pebs_data_cfg_rsvd = ~0ull;
-	bitmap_zero(pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
+	bitmap_zero(pmu->all_valid_pmc_mask, X86_PMC_IDX_MAX);
 
 	if (!vcpu->kvm->arch.enable_pmu)
 		return;
@@ -1035,8 +1035,8 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	if (kvm_vcpu_has_mediated_pmu(vcpu))
 		kvm_pmu_call(write_global_ctrl)(pmu->global_ctrl);
 
-	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
-	bitmap_set(pmu->all_valid_pmc_idx, KVM_FIXED_PMC_BASE_IDX,
+	bitmap_set(pmu->all_valid_pmc_mask, 0, pmu->nr_arch_gp_counters);
+	bitmap_set(pmu->all_valid_pmc_mask, KVM_FIXED_PMC_BASE_IDX,
 		   pmu->nr_arch_fixed_counters);
 }
 
@@ -1058,7 +1058,7 @@ void kvm_pmu_cleanup(struct kvm_vcpu *vcpu)
 
 	pmu->need_cleanup = false;
 
-	bitmap_andnot(bitmask, pmu->all_valid_pmc_idx,
+	bitmap_andnot(bitmask, pmu->all_valid_pmc_mask,
 		      pmu->pmc_in_use, X86_PMC_IDX_MAX);
 
 	kvm_for_each_pmc(pmu, pmc, i, bitmask) {
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index d0e16a3211ca..5950445ebc69 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -585,7 +585,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 		lbr_desc->records.nr = 0;
 
 	if (lbr_desc->records.nr)
-		bitmap_set(pmu->all_valid_pmc_idx, INTEL_PMC_IDX_FIXED_VLBR, 1);
+		bitmap_set(pmu->all_valid_pmc_mask, INTEL_PMC_IDX_FIXED_VLBR, 1);
 
 	if (pmu->version == 1)
 		return;
-- 
2.54.0

