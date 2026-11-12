Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516228;
	b=mBsv9O9mB1gtoY70wZHCJeOvfU3OC7a03V0pp3eCUho8MIeSDSMlGr/XnA1dIw0UYAO4
	 YV2GiwDgPGHXc0xlEVY+CKmV/xsoIU+10CVFD1LJEQYRcpoKF73axNJEzwahIXq7tJPJV
	 KVMQvBjlTUYgxgIjY/SeX/Wt3PYT2cmLDDH1eYjRmuj2ySfGcN7paGTyzv/VpgUmUpUJX
	 V5AvEb02JU8SQHJl/uVMAWNzu/CULG83kQRwwQYtx67OHrNyYZqysyA+d9YPPj1SN043T
	 FrhMbrNUs9B+OYnfQ5NPtecYYnmnmpd5g8FesqRI4PB4DXkgu5JW1uJVtO9HDpGsRig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516228;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+XDq8f4o+SW+TSIJAMLZejYQ9W9rNih2TSs15MEwTfQ=;
	b=jkA+SMVTFPCekThymflVl5bwiQDyewpnGZhCigNt++Z8pWDxHOtfl1ptPyqDsGNGH3rQ
	 wi+s69dcKOQ0AzzQczL9jcLku6sN9SOoaoycRdKY60fwaLck/Q9Iwvn2ZAG81+e+bM+al
	 JA0IQpb5Z3oJRz3xot8p5bbQdjfLYShAAUfqMzhu5hfmfgbxYmpj3AV77soBnvFyZ2YdC
	 qS8stWLXFTXBZ+mkqmOeeVLWxihQRtmzM9f6rr+uKwZ9H3TyLckyNXJaP/wl4XNsp/PKy
	 DfmHgsC41XP44U+mAAPisQf9e9slKQgyt2EYmCbdZ08ghUuce3LHlWuV8h89L29tsxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CxjcKB15;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240D8606A339;
	Thu, 12 Nov 2026 20:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 240D8606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CxjcKB15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516228; x=1826052228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cu17jS3kkzu1jRndoaNN+VWOMIZskRAf1imQrNBOWQo=;
  b=CxjcKB15H3/Mwphpr2MXHwmozXWiWkqlvlSkjMIHPxJzHxzEyOYC4AyR
   cTnwZCZET8oTpZ6bousUrHHDZK8l6OYE0I6/94smxI7DItXU70N+1+UHY
   4mI3CH/H+sJJmZu8lewZCf/zflSJ1HYgW+3r3xAYZHWOFajjvJkeYMRy/
   4u1lBKyLq54JEeUWKFfMH25PX3QnwjJwF8wqS34qJqqvIzpTsNV9Ux8Ib
   bnhNCBqmTJy+NfvExflxko+16lMT69we6tTMDHh+Kb3mYEhRrEXvpbcZJ
   wVWJS7oa1n+lBXvD3/rEmfV9N2CYb2E/UJgmwpUMBxt7A78zLWL4wHpnT
   g==;
X-CSE-ConnectionGUID: oVhvEJAiSUaGL2e4CvvUuQ==
X-CSE-MsgGUID: /GBrN3HKSum1RFFL3tcb8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192225"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192225"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:47 -0800
X-CSE-ConnectionGUID: hF6dJ+jqShG9U7ogg4ZjVg==
X-CSE-MsgGUID: HMRUrClwSqagjC41ultgYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087871"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:47 -0800
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
Subject: [PATCH v4 03/21] KVM: x86/pmu: Rename all_valid_pmc_idx to pmc_exists
Date: Thu, 12 Nov 2026 13:32:09 -0700
Message-ID: <20261112203227.289379-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261112203227.289379-1-zide.chen@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
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
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
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
2.56.1

