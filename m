Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57302347FCD;
	Thu, 27 Aug 2026 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870888; cv=none; b=it0jY1LhafQO+bjTuDI9xWnfUZtF7KPqcAx97wIStqaVvUR5HFYE5Iqw1IP/VO5LKFmUjnDpiX5glLwfCzOszXdRov7pL9quNAHzSyYL4bspHfw91G1sfHXsBNo4O7qmiVlwpMk6AJG21fz40eJVFrWFXR7nQtSsUR8zUTR0Kbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870888; c=relaxed/simple;
	bh=DqBA7YljWWqWDGUJAPFUIYUvCvZqjYH9sC/tGKxQQCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOskFdoAIAUUFdL+BQ7FG2nh52cu6ti1+zC7AB2jxk8HoBcXQMVMhTdhXDVcwbF7A4vm4S1t1SP/Py4dwZC/jGuiPbJ50UNBE/0CnPUu/5u8dxPNEvi4GPwRZ9+qpVoHw6gXuH95CEgVmCl0WOOdM5Y0hz3K0XuICD3NrUHMzOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHVfM5MW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHVfM5MW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787870887; x=1819406887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DqBA7YljWWqWDGUJAPFUIYUvCvZqjYH9sC/tGKxQQCI=;
  b=XHVfM5MWLd7f0Ca+Om68JYTJcqPWwaeMqotripeWrMxOknWqS7WI2rD5
   X6ejuaqV71GWLaRryuyBEy0OcQqHs+VGmJS16Xir/vo52JUhlEi6f+s7K
   0wLvhPzsI4tH4FOsgleFR/kpn4x0coqPZsmD83y/EqtDWqD2KaZXHb0r0
   CHVurRpbSnopl2pMI81T2BY36TSnZYu800sHMHMuRd6JCcGamWvIdxUp4
   hMcNhJXNYoSIjADJxbgZhn29KTnarltFTiDzqeWHF4dpS19bTezgOavWe
   0cpLfDNn5tSu95eCPZLDjHP6G86h5JG0RhSkvlYssCrGKJFk36aeMuG5L
   A==;
X-CSE-ConnectionGUID: AEQbC7DlQxifp9W+g2F7ZQ==
X-CSE-MsgGUID: a6W8mtVpSaKIMITlQcmKJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113914826"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="113914826"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:06 -0700
X-CSE-ConnectionGUID: 6w2q7KZKRRSIJv3Am6F9cg==
X-CSE-MsgGUID: DyWpR+ygRKCigvu3X/pqHA==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:05 -0700
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
Subject: [PATCH v2 01/16] KVM: x86/pmu: Remove redundant Perf Global Status MSR bit definitions
Date: Thu, 27 Aug 2026 15:37:40 -0700
Message-ID: <20260827223755.143247-2-zide.chen@intel.com>
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

IA32_PERF_GLOBAL_STATUS and its SET/RESET counterparts share bit
definitions with perf_event.h, which is the canonical home for Intel
PMU bit definitions (e.g., PERFEVTSEL, FIXED_CTR_CTRL, GLOBAL_STATUS).
Drop the duplicate definitions from msr-index.h and update KVM code to
use the macros from perf_event.h.

Drop the comment as well, since the macros now match the MSR
naming.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/include/asm/msr-index.h |  8 --------
 arch/x86/kvm/vmx/pmu_intel.c     | 11 ++---------
 arch/x86/kvm/vmx/vmx.c           |  2 +-
 3 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 18c4be75e927..11b99d237e05 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1243,14 +1243,6 @@
 
 #define MSR_PERF_METRICS		0x00000329
 
-/* PERF_GLOBAL_OVF_CTL bits */
-#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT	55
-#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI		(1ULL << MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT)
-#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF_BIT		62
-#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF			(1ULL <<  MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF_BIT)
-#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD_BIT		63
-#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD			(1ULL << MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD_BIT)
-
 /* Geode defined MSRs */
 #define MSR_GEODE_BUSCONT_CONF0		0x00001900
 
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index bfa8612fb450..e71ddd51ae56 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -576,17 +576,10 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
 	pmu->global_ctrl_rsvd = counter_rsvd;
 
-	/*
-	 * GLOBAL_STATUS and GLOBAL_OVF_CONTROL (a.k.a. GLOBAL_STATUS_RESET)
-	 * share reserved bit definitions.  The kernel just happens to use
-	 * OVF_CTRL for the names.
-	 */
 	pmu->global_status_rsvd = pmu->global_ctrl_rsvd
-			& ~(MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF |
-			    MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD);
+			& ~(GLOBAL_STATUS_BUFFER_OVF | GLOBAL_STATUS_COND_CHG);
 	if (vmx_pt_mode_is_host_guest())
-		pmu->global_status_rsvd &=
-				~MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI;
+		pmu->global_status_rsvd &= ~GLOBAL_STATUS_TRACE_TOPAPMI;
 
 	if (perf_capabilities & PERF_CAP_PEBS_FORMAT) {
 		if (perf_capabilities & PERF_CAP_PEBS_BASELINE) {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e3bfe6aca1a0..d3789b2ee18e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8612,7 +8612,7 @@ static unsigned int vmx_handle_intel_pt_intr(void)
 		return 0;
 
 	kvm_make_request(KVM_REQ_PMI, vcpu);
-	__set_bit(MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT,
+	__set_bit(GLOBAL_STATUS_TRACE_TOPAPMI_BIT,
 		  (unsigned long *)&vcpu->arch.pmu.global_status);
 	return 1;
 }
-- 
2.55.0

