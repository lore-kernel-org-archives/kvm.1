Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075EB41F5E6;
	Fri, 21 Aug 2026 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351468; cv=none; b=MWFbfvp21gDyXLvGqgVbbohr6No7Zrc9V7a6O2NwPnu36kibwBODx/sZBBTHkwStgF7+1wHJyJFoEN+Xb4bYg/TuAjXWBEdX6BXMWTHclrBEYxULoFWUdn3/IdQtEfQoKW3pINwKC8SvTdXll4/jlrny4icY+upxlMd8v5fzrt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351468; c=relaxed/simple;
	bh=UZ/4Kh7H7JDkZum6F6HO8FcDjNgzgqfvdwo2qKh24Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kptHQf3AD/U8zuJwUKCTaQ1LuiAZUhYFkiQBBJ7w5xtuGg5zOsClu+Y/7e3fPV4QkE33YuHua8k5+XnsoK7qkvFZNeSYwcLU24kgc/Is0h3kSq8RVrxzqnKUm4UThr3LRDfU2LpaKDZxhaNfwtAoI5ZPm7HTUH2Y2/MnVAzIgZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgFjHxg4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgFjHxg4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351467; x=1818887467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UZ/4Kh7H7JDkZum6F6HO8FcDjNgzgqfvdwo2qKh24Sg=;
  b=FgFjHxg4OYMJ8SeQW0q/vBn7np3KDb81oIsVtPH4PxB0ttWPuWqJt6uR
   7Kl6hF0mww3XoH2CLuMSGsGDJYrzO+wwhbtLwQaYis8crlFz2LQDQeHwa
   KYC5exEgW35Q6Gc4T9RuToKTntA9qAYJQPguCJxaS9kA2ZHcuZcrZN2oK
   +Wmysk78MM0NC1wgMBE6Zroj/b2q4p236QJryy/Fv46LtaNZC9x+tGSCo
   gfwsli5nCfSuleSScCVGBq5TOvJVPciFDpzxRjEsmlodoBTMKLYAUFisi
   7ISuz96j7OQ0QHvwOUrn5rYV+V5U76jVpKL4gsn3JFDsMTeEBpEYElHPH
   w==;
X-CSE-ConnectionGUID: M+I3+Pt7SlShN0YQ+8QmfA==
X-CSE-MsgGUID: OiS8yfjiQ+ST7AQOZgRkRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032645"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032645"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:51 -0700
X-CSE-ConnectionGUID: O2SqviZTTwyVxIlGJLuSPA==
X-CSE-MsgGUID: ZaWQ3kc4Q1Se9V13pbqemg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679796"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:51 -0700
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
Subject: [PATCH 17/23] KVM: x86/pmu: Handle GLOBAL_CTRL under PerfMon masking
Date: Fri, 21 Aug 2026 15:19:56 -0700
Message-ID: <20260821222002.54907-18-zide.chen@intel.com>
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

Guest writes must be gated, and guest reads masked, with
pmu->global_ctrl_rsvd rather than pmu->perfmon_mask, because bits
63:52 in global_ctrl_rsvd are guaranteed to be cleared, and bits 51:0
are the complement between the two masks.

Since the host could schedule !exclude_guest events on host-owned
resources in non-root mode, OR the host-owned bits into
GUEST_IA32_PERF_GLOBAL_CTRL when loading guest PMU state. The host-
owned bits are supposed to be set during perf_load_guest_context().

Add a host_global_ctrl parameter to the mediated_load() callback so
that the host value can be available before the register is cleared.
This allows intel_mediated_pmu_load() to preserve host-owned bits.

When caching pmu->global_ctrl at VM exit, mask the guest value with
pmu->global_ctrl_rsvd to retain guest-owned bits only.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/kvm/pmu.c           |  7 ++++++-
 arch/x86/kvm/pmu.h           |  2 +-
 arch/x86/kvm/svm/pmu.c       |  2 +-
 arch/x86/kvm/vmx/pmu_intel.c | 13 ++++++++++++-
 arch/x86/kvm/vmx/vmx.c       |  4 ++++
 5 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 337d2f55a216..b051ba66edce 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1406,6 +1406,8 @@ static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
 
 void kvm_mediated_pmu_load(struct kvm_vcpu *vcpu)
 {
+	u64 host_global_ctrl = 0;
+
 	if (!kvm_vcpu_has_mediated_pmu(vcpu) ||
 	    KVM_BUG_ON(!lapic_in_kernel(vcpu), vcpu->kvm))
 		return;
@@ -1429,13 +1431,16 @@ void kvm_mediated_pmu_load(struct kvm_vcpu *vcpu)
 	 * even for SVM to minimize the damage if a perf event is left enabled,
 	 * and to ensure a consistent starting state.
 	 */
+	if (kvm_vcpu_has_perfmon_mask(vcpu))
+		rdmsrq(kvm_pmu_ops.PERF_GLOBAL_CTRL, host_global_ctrl);
+
 	wrmsrq(kvm_pmu_ops.PERF_GLOBAL_CTRL, 0);
 
 	perf_load_guest_lvtpc(kvm_lapic_get_reg(vcpu->arch.apic, APIC_LVTPC));
 
 	kvm_pmu_load_guest_pmcs(vcpu);
 
-	kvm_pmu_call(mediated_load)(vcpu);
+	kvm_pmu_call(mediated_load)(vcpu, host_global_ctrl);
 }
 
 static void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index c5feeb60bcf6..30e456302c65 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -39,7 +39,7 @@ struct kvm_pmu_ops {
 	bool (*pmc_is_disabled_in_current_mode)(struct kvm_pmc *pmc);
 
 	bool (*is_mediated_pmu_supported)(struct x86_pmu_capability *host_pmu);
-	void (*mediated_load)(struct kvm_vcpu *vcpu);
+	void (*mediated_load)(struct kvm_vcpu *vcpu, u64 host_global_ctrl);
 	void (*mediated_put)(struct kvm_vcpu *vcpu);
 	void (*write_global_ctrl)(u64 global_ctrl);
 
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index f81817606baa..d9cd2a5ab411 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -246,7 +246,7 @@ static bool amd_pmu_is_mediated_pmu_supported(struct x86_pmu_capability *host_pm
 	return host_pmu->version >= 2;
 }
 
-static void amd_mediated_pmu_load(struct kvm_vcpu *vcpu)
+static void amd_mediated_pmu_load(struct kvm_vcpu *vcpu, u64 host_global_ctrl)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	u64 global_status;
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 9236bfa15c41..d0373de951d5 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -947,11 +947,22 @@ static u64 intel_fixed_ctrl_host_bits(struct kvm_pmu *pmu)
 	return fixed_ctl;
 }
 
-static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
+static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu, u64 host_global_ctrl)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	u64 global_status, toggle;
 
+	/*
+	 * Preserve host-owned bits: perf may schedule !exclude_guest events on
+	 * host-owned counters in non-root mode.
+	 * PerfMon masking requires VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL, so the
+	 * MSR-store/load path does not apply here.
+	 */
+	if (kvm_vcpu_has_perfmon_mask(vcpu)) {
+		host_global_ctrl &= pmu->global_ctrl_rsvd;
+		intel_pmu_write_global_ctrl(pmu->global_ctrl | host_global_ctrl);
+	}
+
 	if (kvm_vcpu_has_perf_metrics(vcpu))
 		wrmsrq(MSR_PERF_METRICS, pmu->perf_metrics);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1b42c9d6f168..a241efb99b3d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7467,6 +7467,10 @@ static void vmx_refresh_guest_perf_global_control(struct kvm_vcpu *vcpu)
 	}
 
 	pmu->global_ctrl = vmcs_read64(GUEST_IA32_PERF_GLOBAL_CTRL);
+
+	/* Strip host-owned bits that were ORed into the VMCS on VMX entry. */
+	if (kvm_vcpu_has_perfmon_mask(vcpu))
+		pmu->global_ctrl &= ~pmu->global_ctrl_rsvd;
 }
 
 void noinstr vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp)
-- 
2.55.0

