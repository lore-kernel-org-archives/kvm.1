Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27DF42A14C;
	Fri, 21 Aug 2026 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351472; cv=none; b=mWH76Wr8Fl/dPzQ0ssWI2vNLN6VjSx3C3PsWOCMu9ojaebBqly45uL44u1QHGwJrn73JgLmpDBwNmGcrgEdicXTBsXWy89/X09ka0FZa7D89JrNxfizWfmarUDMv7ymD2hfLZn1kntdc2DdbyoNkL5yO0qSmqrPzoPnS+zHyGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351472; c=relaxed/simple;
	bh=qO5NnKZWA4TpLYrFATzvRTky4amPO5oVuQIuCNQqV0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ML5g7a4dB/QgOQnihJQeO7rycK+aEKQqinqJvOdNNGlsEmWVcXX7bKHiADyKDafEfrxBoldj64EIjVICkT9YsvXtrY+yQ3n3DmiBcpmd/Piim+ULD05uNSTwpzns2JQwfmKTmsu5h58pvBZBIRT0YJwGbwiE1HAJddDMkUgoTsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqCG00Md; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqCG00Md"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351469; x=1818887469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qO5NnKZWA4TpLYrFATzvRTky4amPO5oVuQIuCNQqV0E=;
  b=lqCG00Md+6p28HIQuQHW/g/ho70ESxxOmnY60ByDeoNwUNJrU2tHEkc2
   UU/jWaBDggXBtz6oHg+7CQqg34NQe53a3Nu8AbXqzz57SO3JVSohhEqZt
   15nIphVoqEo9nykdyUZ5+84m0KD6/lyeRyKfUDzLcugf6rkmiTcOOIbtt
   0SAnWEsWVBHmdlCImjlq+T4Dz9Usncy/zGfniUPPbuVA4cYRJw2a929k0
   QTTURHse+kspEttxwaitemTJDb4xarGn4ztEhgeJFciftUNZ3V+w5EN0G
   CgeKO0S3s47yunIQfiLuOA2xDIjN2tz/b2J67rkviMN+E75DkzKnmRuPo
   w==;
X-CSE-ConnectionGUID: vO6USbyUSM6ufyIHZBszNg==
X-CSE-MsgGUID: hFICVcVzQkqERNoTeqLXMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032667"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032667"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:53 -0700
X-CSE-ConnectionGUID: NYIsfBmQRnOJXVlMTEcgsg==
X-CSE-MsgGUID: 4zJv6leQQCGcQ0ZtgmjApw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679817"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:53 -0700
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
Subject: [PATCH 21/23] KVM: x86/pmu: Enable PerfMon masking
Date: Fri, 21 Aug 2026 15:20:00 -0700
Message-ID: <20260821222002.54907-22-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821222002.54907-1-zide.chen@intel.com>
References: <20260821222002.54907-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PerfMon masking is enumerated by bit [17] of IA32_VMX_PROCBASED_CTLS3
(MSR 0x492), and it can be enabled by the new tertiary VM-execution
control bit 17.

Add TERTIARY_EXEC_PERFMON_MASK_ENABLE to KVM's optional tertiary
VM-execution controls, allowing cpu_has_vmx_perfmon_mask() to return
true on PerfMon masking capable platforms.

With this in place, a valid perfmon_mask module parameter is no longer
forced to zero, pmu->perfmon_mask can be configured as intended, and
PerfMon masking can be enabled in hardware.

perf_create_mediated_pmu() can now pass a valid PerfMon mask to the
perf subsystem, enabling PMU partitioning aware event scheduling.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/include/asm/vmx.h         |  1 +
 arch/x86/include/asm/vmxfeatures.h |  1 +
 arch/x86/kvm/vmx/capabilities.h    |  3 ++-
 arch/x86/kvm/vmx/vmx.c             | 13 +++++++++++++
 arch/x86/kvm/vmx/vmx.h             |  2 +-
 5 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 1cb092d86955..652322163f1b 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -96,6 +96,7 @@ struct vmcs {
  * Definitions of Tertiary Processor-Based VM-Execution Controls.
  */
 #define TERTIARY_EXEC_IPI_VIRT			VMCS_CONTROL_BIT(IPI_VIRT)
+#define TERTIARY_EXEC_PERFMON_MASK_ENABLE	VMCS_CONTROL_BIT(PERFMON_MASK_ENABLE)
 
 #define PIN_BASED_EXT_INTR_MASK                 VMCS_CONTROL_BIT(INTR_EXITING)
 #define PIN_BASED_NMI_EXITING                   VMCS_CONTROL_BIT(NMI_EXITING)
diff --git a/arch/x86/include/asm/vmxfeatures.h b/arch/x86/include/asm/vmxfeatures.h
index 09b1d7e607c1..5efbd35ba5ad 100644
--- a/arch/x86/include/asm/vmxfeatures.h
+++ b/arch/x86/include/asm/vmxfeatures.h
@@ -90,4 +90,5 @@
 
 /* Tertiary Processor-Based VM-Execution Controls, word 3 */
 #define VMX_FEATURE_IPI_VIRT		( 3*32+  4) /* "ipi_virt" Enable IPI virtualization */
+#define VMX_FEATURE_PERFMON_MASK_ENABLE	( 3*32+ 17) /* "perfmon_mask_enable" Enable PERFMON_MASK */
 #endif /* _ASM_X86_VMXFEATURES_H */
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index d4c362093966..3852a4a9da88 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -298,7 +298,8 @@ static inline bool cpu_has_vmx_ipiv(void)
 
 static inline bool cpu_has_vmx_perfmon_mask(void)
 {
-	return false;
+	return vmcs_config.cpu_based_3rd_exec_ctrl &
+		TERTIARY_EXEC_PERFMON_MASK_ENABLE;
 }
 
 static inline bool cpu_has_vmx_flexpriority(void)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2bd1ffe65510..64266d94ab76 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4288,6 +4288,14 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 	bool intercept = !has_mediated_pmu;
 	int i;
 
+	/*
+	 * Keep the PerfMon masking tertiary VM-execution control in sync
+	 * regardless of enable_mediated_pmu.
+	 */
+	if (cpu_has_vmx_perfmon_mask())
+		tertiary_exec_controls_changebit(vmx, TERTIARY_EXEC_PERFMON_MASK_ENABLE,
+						 kvm_vcpu_has_perfmon_mask(vcpu));
+
 	if (!enable_mediated_pmu)
 		return;
 
@@ -4766,6 +4774,9 @@ static u64 vmx_tertiary_exec_control(struct vcpu_vmx *vmx)
 	if (!enable_ipiv || !kvm_vcpu_apicv_active(&vmx->vcpu))
 		exec_control &= ~TERTIARY_EXEC_IPI_VIRT;
 
+	if (!kvm_vcpu_has_perfmon_mask(&vmx->vcpu))
+		exec_control &= ~TERTIARY_EXEC_PERFMON_MASK_ENABLE;
+
 	return exec_control;
 }
 
@@ -6754,6 +6765,8 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
 	if (secondary_exec_control & SECONDARY_EXEC_ENABLE_VPID)
 		pr_err("Virtual processor ID = 0x%04x\n",
 		       vmcs_read16(VIRTUAL_PROCESSOR_ID));
+	if (tertiary_exec_control & TERTIARY_EXEC_PERFMON_MASK_ENABLE)
+		pr_err("PERFMON_MASK = 0x%016llx\n", vmcs_read64(PERFMON_MASK));
 	if (secondary_exec_control & SECONDARY_EXEC_EPT_VIOLATION_VE) {
 		struct vmx_ve_information *ve_info = vmx->ve_info;
 		u64 ve_info_pa = vmcs_read64(VE_INFORMATION_ADDRESS);
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index ccda5c5c8c2c..0530e0fa0076 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -577,7 +577,7 @@ static inline u8 vmx_get_rvi(void)
 
 #define KVM_REQUIRED_VMX_TERTIARY_VM_EXEC_CONTROL 0
 #define KVM_OPTIONAL_VMX_TERTIARY_VM_EXEC_CONTROL			\
-	(TERTIARY_EXEC_IPI_VIRT)
+	(TERTIARY_EXEC_IPI_VIRT | TERTIARY_EXEC_PERFMON_MASK_ENABLE)
 
 #define BUILD_CONTROLS_SHADOW(lname, uname, bits)						\
 static inline void lname##_controls_set(struct vcpu_vmx *vmx, u##bits val)			\
-- 
2.55.0

