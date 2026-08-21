Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE053DD51C;
	Fri, 21 Aug 2026 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351465; cv=none; b=OV85juJvihR8L9JugQv5xnegqQk5tvgLwFyrFnLYbXBu9czSpiz1KSAvJG9HQ4IhBcPSVVfucy2jUKeXyGcRXTcLbzpnHSBCVMbKsFbdeEfyJfFc+/Eg+rrMu4DhHihHkJoLJjaLCpk54zsIwEgD2tD2+xStmRhL5FAOOQFNKFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351465; c=relaxed/simple;
	bh=WKsSU+mKSkAd/apQKwRaKWY66sDZ61JN7LnSHh3XYfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqUa/FMb8RYlvQGXjx7QHs3mi9UjVbNtghsHP7rdXYhfLJdLvHM5bzpxAlYo+uR+9IpQBAQdIXfY3HK1ioergssoRF+13+HT6iaIoZNtXnVGCo10oaHRXNfLiOyPAcdoVM2hQAXbZffJ4lkQxtuthWp5taeX7KX547ky31bXAuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjZl/cD3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjZl/cD3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351464; x=1818887464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WKsSU+mKSkAd/apQKwRaKWY66sDZ61JN7LnSHh3XYfQ=;
  b=NjZl/cD3RKtGjXYeoD9SLSMoyOZRbixaXLV5ipt3kpfFCKXdN0tde5GV
   Ig7m8gh/qydAoDatiTrlpTIZDnAOWwGBTM7Fvo1V+G+bRCPtgaUf2X8bH
   aJYs1a4pmcFipr9SjCReQAjISwMMSU7n8a7NC6C0e80wYoXfyhGoMjRjF
   iYWG1D5/E12OH2OtPg/G0P+rSGsk0HCBSAp+fLMgaPptn3NcW/zf4IWmH
   r3bOma9Dmo3jFy81g0kWYrfElV3vr0XAwcbR0RG78idP0p8dWfGdgpSyZ
   a1YAtFAf898RYYpe2+dylCa1soudqhiZtauQEsviIdnvPI1424nxCPCAj
   w==;
X-CSE-ConnectionGUID: tg9SEomCQrOnbRb4CTqDUQ==
X-CSE-MsgGUID: ZfIZsMvoSRahOp4tw0vrpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032625"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032625"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:49 -0700
X-CSE-ConnectionGUID: qY8qIMuuTrm/1bKeM1AJQA==
X-CSE-MsgGUID: oVGQ18GPThiBmWcL3f9s0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679779"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:49 -0700
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
Subject: [PATCH 13/23] KVM: x86/pmu: Set up the PERFMON_MASK VMCS field
Date: Fri, 21 Aug 2026 15:19:52 -0700
Message-ID: <20260821222002.54907-14-zide.chen@intel.com>
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

Program the VMCS PERFMON_MASK field when PerfMon masking is enabled.
The field uses the same bit definitions as IA32_PERF_GLOBAL_STATUS and
can therefore be derived from ~pmu->global_status_rsvd.

Expose IA32_PERF_CAPABILITIES.PERF_METRICS_AVAILABLE[15] only when
PERFMON_MASK[48] is available to the guest.

When PerfMon masking is enabled, guest RDMSR/WRMSR accesses to PMU
global MSRs are filtered by the mask, writes outside the mask cause
an #GP(0), and RDPMC returns only guest-owned counter values.

Intentionally defer enabling PerfMon masking in VM-execution control
until the remaining PerfMon masking support is in place, so that
intermediate commits remain functional during bisection.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/include/asm/vmx.h      |  2 ++
 arch/x86/kvm/pmu.c              |  4 ++--
 arch/x86/kvm/pmu.h              |  6 ++++++
 arch/x86/kvm/vmx/pmu_intel.c    | 26 ++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c          |  6 +++++-
 6 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 262553f95793..467090bf0ab2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -582,6 +582,7 @@ struct kvm_pmu {
 	u64 eventsel_rsvd;
 	u64 raw_event_mask;
 	u64 perf_metrics;
+	u64 perfmon_mask;
 	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
 	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
 
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 3f1b3096ff04..1cb092d86955 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -275,6 +275,8 @@ enum vmcs_field {
 	SHARED_EPT_POINTER		= 0x0000203C,
 	PID_POINTER_TABLE		= 0x00002042,
 	PID_POINTER_TABLE_HIGH		= 0x00002043,
+	PERFMON_MASK			= 0x00002054,
+	PERFMON_MASK_HIGH		= 0x00002055,
 	GUEST_PHYSICAL_ADDRESS          = 0x00002400,
 	GUEST_PHYSICAL_ADDRESS_HIGH     = 0x00002401,
 	VMCS_LINK_POINTER               = 0x00002800,
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 92ff685d11b3..f944a15160cb 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1393,7 +1393,7 @@ void kvm_mediated_pmu_load(struct kvm_vcpu *vcpu)
 
 	perf_pmu_partition_preload();
 
-	perf_load_guest_context(false);
+	perf_load_guest_context(kvm_vcpu_has_perfmon_mask(vcpu));
 
 	/*
 	 * Explicitly clear PERF_GLOBAL_CTRL, as "loading" the guest's context
@@ -1466,5 +1466,5 @@ void kvm_mediated_pmu_put(struct kvm_vcpu *vcpu)
 
 	perf_put_guest_lvtpc();
 
-	perf_put_guest_context(false);
+	perf_put_guest_context(kvm_vcpu_has_perfmon_mask(vcpu));
 }
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 2dc12e3f3af0..057e3258e473 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -89,6 +89,12 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
 	return enable_mediated_pmu && vcpu_to_pmu(vcpu)->version;
 }
 
+static inline bool kvm_vcpu_has_perfmon_mask(struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_has_mediated_pmu(vcpu) &&
+	       vcpu_to_pmu(vcpu)->perfmon_mask;
+}
+
 static inline unsigned long kvm_gp_pmc_mask(struct kvm_pmu *pmu)
 {
 	return pmu->pmc_exists64 &
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 62e542eac05e..19ccc7cd319c 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -703,6 +703,21 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 			pmu->pebs_enable_rsvd = ~kvm_gp_pmc_mask(pmu);
 		}
 	}
+
+	if (kvm_vcpu_has_mediated_pmu(vcpu) && perfmon_mask) {
+		pmu->perfmon_mask = ~pmu->global_status_rsvd;
+
+		/*
+		 * The PerfMon mask for a particular guest must be a subset
+		 * of the module-wide mask. This masks out the global bits
+		 * (e.g. GLOBAL_STATUS_COND_CHG) that must be handled by the
+		 * host and were removed from global_status_rsvd without
+		 * checking perfmon_mask, and defends in depth against any
+		 * other bits inadvertently granted to the guest.
+		 */
+		pmu->perfmon_mask &= perfmon_mask;
+		vmcs_write64(PERFMON_MASK, pmu->perfmon_mask);
+	}
 }
 
 static void intel_pmu_init(struct kvm_vcpu *vcpu)
@@ -739,6 +754,7 @@ static void intel_pmu_reset(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 
 	pmu->perf_metrics = 0;
+	pmu->perfmon_mask = 0;
 	intel_pmu_release_guest_lbr_event(vcpu);
 }
 
@@ -1021,6 +1037,16 @@ void intel_pmu_perfmon_mask_setup(void)
 			perfmon_mask);
 		perfmon_mask = 0;
 	}
+
+	/*
+	 * perfmon_mask represents the maximum resources that any guest may
+	 * have. KVM chooses to expose fewer hardware resources to guests.
+	 */
+	if (perfmon_mask) {
+		kvm_pmu_cap.cntr_mask64 &= perfmon_mask;
+		kvm_pmu_cap.fixed_cntr_mask64 &=
+			(perfmon_mask >> INTEL_PMC_IDX_FIXED);
+	}
 }
 
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cdd141d22efa..1b42c9d6f168 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4294,6 +4294,9 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 	if (!cpu_has_save_perf_global_ctrl()) {
 		vm_exit_controls_bits &= ~VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL;
 
+		/* Module parameter validation should already prevent this. */
+		WARN_ON_ONCE(kvm_vcpu_has_perfmon_mask(vcpu));
+
 		if (has_mediated_pmu)
 			vmx_add_autostore_msr(vmx, MSR_CORE_PERF_GLOBAL_CTRL);
 		else
@@ -8133,7 +8136,8 @@ static __init u64 vmx_get_perf_capabilities(void)
 		perf_cap &= ~PERF_CAP_PEBS_BASELINE;
 	}
 
-	if (enable_mediated_pmu)
+	if (enable_mediated_pmu &&
+	    (!perfmon_mask || (perfmon_mask & GLOBAL_STATUS_PERF_METRICS_OVF)))
 		perf_cap |= kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS;
 
 	return perf_cap;
-- 
2.55.0

