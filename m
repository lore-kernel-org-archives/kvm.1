Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6C5442138;
	Tue,  7 Jul 2026 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449858; cv=none; b=Hlglr5dGNMUH/vV0BM4m+bOVAHYxjC6sPJfFUrkf7wUoWa5zDfzNY/YXXMAR5/z2TZhHsBgmj8FoyehnHuIdaaktvSYUlpcch+Y8jaXIOlrPgMlXANF6BEESXtxAhEoBeDLqMuarExuvCzvjZo0yeCWrhQd3nTOwAsqSoIBPVvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449858; c=relaxed/simple;
	bh=bxU746eWx/L84J2bcMF6ZmgITpfJYe1A8Gir1rc37wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cL1w5C3aNEkBcuuHU2K5X0a16QanlMbOofESb7GKIz6dnmU2vgh1xUxxVV62fZnJ3cNrgz9MfAuA3L+Au+6GBvHbGTu4afs2jQldK/aYyopVlILLCQCoMdnQNqO4IdBE+Qe4y9gF21KoiAmz8ALXM9HXm48N8RtDjS1a8SUAJ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecCf7051; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecCf7051"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783449847; x=1814985847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bxU746eWx/L84J2bcMF6ZmgITpfJYe1A8Gir1rc37wY=;
  b=ecCf7051+jM09WYrKO5DSH4bzjbrJHplfWzHpIkUFAY33smD+cCWpp4j
   THjmkVzmlTLRR80eGXQel5ocDoBDF/yZBB+VwzIC+xWCakrYUOMEW3qSx
   r3f4Y+Uoa9op6EnyXwzLFnSqjiSj5O5Jm+2LaNKAYDZaJpp93/i1RFk1E
   QuMuj45wQlKIZXYI/HRwaSTaVzUDTyv63vF33UTaxzG+sI4oFpiPRfib4
   gDRey4pirhMpMkQcHivqYw5xIF/0cDamzIEwX+LHqQeb93y8bNHZuGg98
   V960+rA6DIQ+ic9pTARhagIDalI5YHNTg1wDDi1RlkQGkSDVwqt/FM+LX
   w==;
X-CSE-ConnectionGUID: 6phAq8NISa25KVFGi/MsIQ==
X-CSE-MsgGUID: 8rhjjufES7Cf9YzJax+xxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94713892"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94713892"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:59 -0700
X-CSE-ConnectionGUID: j0FDrT7QRHSHUNc1ibPEgw==
X-CSE-MsgGUID: puZtNLKYRbGmVoyFRVPJOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277279319"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:58 -0700
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
	Xudong Hao <xudong.hao@intel.com>,
	Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH 10/15] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and GLOBAL_INUSE MSRs
Date: Tue,  7 Jul 2026 11:34:00 -0700
Message-ID: <20260707183405.15571-11-zide.chen@intel.com>
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

Intel PerfMon v4 introduces IA32_PERF_GLOBAL_STATUS_SET (0x391) to
allow software to set individual bits in the global status MSR. Reads
of IA32_PERF_GLOBAL_STATUS_SET always return zero.

IA32_PERF_GLOBAL_INUSE (0x392) is also introduced in v4, to track
which counters and the PMI are currently claimed by other agents,
allowing independent software agents to check counter availability
without a shared scheduler arbitrating between them.

IA32_PERF_GLOBAL_INUSE is an R/O MSR, and any write attempt results
in a #GP.

Neither MSR is part of the VM state, so they don't need to be
advertised to userspace, nor saved and restored during live
migration.

Originally-by: Yang Weijiang <weijiang.yang@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/include/asm/msr-index.h |  4 ++++
 arch/x86/kvm/pmu.c               |  9 ++++++++
 arch/x86/kvm/vmx/pmu_intel.c     | 38 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c           |  4 ++++
 4 files changed, 55 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index feee92aab504..46ca6b56628b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1241,6 +1241,10 @@
 #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x00000390
 #define MSR_CORE_PERF_GLOBAL_STATUS_SET	0x00000391
+#define MSR_CORE_PERF_GLOBAL_INUSE	0x00000392
+
+/* Intel IA32_PERF_GLOBAL_INUSE MSR */
+#define PERF_GLOBAL_INUSE_PMI_INUSE	BIT_ULL(63)
 
 #define MSR_PERF_METRICS		0x00000329
 
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index bc2ca60114e9..7d58f7a2a2db 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -834,6 +834,8 @@ bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	case MSR_CORE_PERF_GLOBAL_CTRL:
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
 		return kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu));
+	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
+		return vcpu_to_pmu(vcpu)->version > 3;
 	default:
 		break;
 	}
@@ -867,6 +869,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
+	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
 		msr_info->data = 0;
 		break;
 	default:
@@ -933,6 +936,12 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!msr_info->host_initiated)
 			pmu->global_status &= ~data;
 		break;
+	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
+		if (data & pmu->global_status_rsvd)
+			return 1;
+		if (!msr_info->host_initiated)
+			pmu->global_status |= data;
+		break;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 		if (!msr_info->host_initiated)
 			pmu->global_status |= data & ~pmu->global_status_rsvd;
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 425f17aa9be2..cb6f9c272e03 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -205,6 +205,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	switch (msr) {
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		return kvm_pmu_has_perf_global_ctrl(pmu);
+	case MSR_CORE_PERF_GLOBAL_INUSE:
+		return pmu->version > 3;
 	case MSR_PERF_METRICS:
 		return kvm_vcpu_has_perf_metrics(vcpu);
 	case MSR_IA32_PEBS_ENABLE:
@@ -354,6 +356,40 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static int intel_pmu_get_global_inuse(struct kvm_vcpu *vcpu,
+				      struct msr_data *msr_info)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
+	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
+	bool pmi_inuse = false;
+	u32 fixed_ctrl;
+	u64 eventsel;
+	int i;
+
+	msr_info->data = 0;
+	kvm_for_each_set_pmc_idx(i, gp_mask, INTEL_GP) {
+		eventsel = pmu->gp_counters[i].eventsel;
+
+		if (eventsel & ARCH_PERFMON_EVENTSEL_EVENT)
+			msr_info->data |= BIT_ULL(i);
+		pmi_inuse |= eventsel & ARCH_PERFMON_EVENTSEL_INT;
+	}
+	kvm_for_each_set_pmc_idx(i, fixed_mask, INTEL_FIXED) {
+		fixed_ctrl = fixed_ctrl_field(pmu->fixed_ctr_ctrl, i);
+
+		if (fixed_ctrl & (INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER))
+			msr_info->data |= BIT_ULL(KVM_FIXED_PMC_BASE_IDX + i);
+		pmi_inuse |= fixed_ctrl & INTEL_FIXED_0_ENABLE_PMI;
+	}
+	pmi_inuse |= pmu->pebs_enable;
+
+	if (pmi_inuse)
+		msr_info->data |= PERF_GLOBAL_INUSE_PMI_INUSE;
+
+	return 0;
+}
+
 static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -364,6 +400,8 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		msr_info->data = pmu->fixed_ctr_ctrl;
 		break;
+	case MSR_CORE_PERF_GLOBAL_INUSE:
+		return intel_pmu_get_global_inuse(vcpu, msr_info);
 	case MSR_PERF_METRICS:
 		msr_info->data = pmu->perf_metrics;
 		break;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2a59bbe52bd8..c69cda5bb898 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4278,6 +4278,10 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 				  MSR_TYPE_RW, intercept);
 	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
 				  MSR_TYPE_RW, intercept);
+	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_STATUS_SET,
+				  MSR_TYPE_RW, intercept || pmu->version < 4);
+	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_INUSE,
+				  MSR_TYPE_RW, intercept || pmu->version < 4);
 
 	intercept = !has_mediated_pmu || !kvm_vcpu_has_perf_metrics(vcpu);
 	vmx_set_intercept_for_msr(vcpu, MSR_PERF_METRICS,
-- 
2.54.0

