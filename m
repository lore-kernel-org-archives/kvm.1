Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135F2426ECF;
	Fri, 21 Aug 2026 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351470; cv=none; b=cHWQEq6lbGgEnOThp4SlUU0frnpOBhMAi9XMGJ2timZOAveRJIdBLBbRdCDBXU9d9skTLtEcNDNLdWJOYVrr6YGLmYcI5RDiPrVIw7VTCgOUCizo7c1pXjBpnai7K9DkzuHrGCD71oiCoMEWC3SgBEHQoxxrYr36iumkpeLGoxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351470; c=relaxed/simple;
	bh=rOim4EFwe3r/AdzOP6yl41/04MFChpsoxq6+wAmZQ0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1DjJJgAyuikusSVHJk5Rm9NEI3IbFj9z8t3FMtv9QT2ZZ5zHUO521YRNbCVlhUeHyerbX8WT80tI6W6B5REkTCr9VFU/9dubKhxe0xrcQqRXd+m/zBkVy9J3rsh3CtTWtiPuWN+wSQogXq2GfYcVRsGM+TbqFRlUknODdwSWCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHNOyxp1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHNOyxp1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351469; x=1818887469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rOim4EFwe3r/AdzOP6yl41/04MFChpsoxq6+wAmZQ0g=;
  b=FHNOyxp1svbMW4MNMGlK2K567r76yoTWUZMzm9PbHjzHwlF3y8d+Bhuk
   KZBnX7IgeuK7Ivk65O1+ZtbV1A5CrjvUwCRsMFuRcUsT1HhFkAqx5/MX9
   9OrX8KvPKvsa0oTpSH83LfsdFE0N62UIDYV0TpW5UelZWlhnRqDi0NV4C
   G0jsiT6z2TOU1Ui1WCpJXD5gANbqBLjcpirRNAF+O2Mq3V7I70YUMm8F2
   /F7eSSsxRrAClYkTVBSRylUFpdtkCpjxHwX9FXIgbUosE3eM/wIDWDguQ
   FvRlxmQvmP/TEEZKuTzlht2QnswLCNJp8EhkuzgjsK1NwUfFZwRtvZ+nZ
   w==;
X-CSE-ConnectionGUID: aG2NPJvwRmaw6mobzyr0qQ==
X-CSE-MsgGUID: sFzMvxcqTjGrH+ipLBk+yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032661"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032661"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:53 -0700
X-CSE-ConnectionGUID: 8yPWxlw4RnCH+dJT70ewFw==
X-CSE-MsgGUID: ek1tdwKnRD26YGh6fmdcCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679812"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:52 -0700
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
Subject: [PATCH 20/23] KVM: x86/pmu: Request guest PMI for guest-induced PMIs
Date: Fri, 21 Aug 2026 15:19:59 -0700
Message-ID: <20260821222002.54907-21-zide.chen@intel.com>
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

When PMU partitioning is enabled, guest-induced PMIs that occur in
guest mode may be delivered to the host perf PMI handler, resulting
in a VM-Exit.

intel_mediated_pmu_put() reads the hardware GLOBAL_STATUS MSR into
pmu->global_status and masks it to the subset owned by the guest.
Request a guest PMI when the saved status indicates a pending guest
PMI, i.e. when

- an overflow status bit (47:0) is set for a counter whose PMI-enable
  bit is enabled; or
- a miscellaneous status bit without a corresponding PMI-enable control
  is set.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/kvm/pmu.c           |  3 ++-
 arch/x86/kvm/pmu.h           |  1 +
 arch/x86/kvm/vmx/pmu_intel.c | 42 ++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 23177c38f286..f99ddd6549f7 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1112,7 +1112,7 @@ void kvm_pmu_destroy(struct kvm_vcpu *vcpu)
 	kvm_pmu_reset(vcpu);
 }
 
-static bool pmc_is_pmi_enabled(struct kvm_pmc *pmc)
+bool pmc_is_pmi_enabled(struct kvm_pmc *pmc)
 {
 	u8 fixed_ctr_ctrl;
 
@@ -1123,6 +1123,7 @@ static bool pmc_is_pmi_enabled(struct kvm_pmc *pmc)
 					  pmc->idx - KVM_FIXED_PMC_BASE_IDX);
 	return fixed_ctr_ctrl & INTEL_FIXED_0_ENABLE_PMI;
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(pmc_is_pmi_enabled);
 
 static void kvm_pmu_incr_counter(struct kvm_pmc *pmc)
 {
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 30e456302c65..4228eb49c6bf 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -336,6 +336,7 @@ static inline bool kvm_vcpu_has_perf_metrics(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PERF_METRICS;
 }
 
+bool pmc_is_pmi_enabled(struct kvm_pmc *pmc);
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
 int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx);
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index e43380f79c72..7fab735252d7 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -985,6 +985,46 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu, u64 host_global_ctrl)
 	       pmu->fixed_ctr_ctrl_hw | intel_fixed_ctrl_host_bits(pmu));
 }
 
+static void intel_perfmon_mask_request_pmi(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
+	int i;
+
+	if (!kvm_vcpu_has_perfmon_mask(vcpu) || !pmu->global_status)
+		return;
+
+	/*
+	 * pmu->global_status should never carry a bit that isn't
+	 * guest-owned per pmu->perfmon_mask; such a bit would mean a
+	 * host-owned resource is being (mis)reported to the guest.
+	 */
+	WARN_ON_ONCE(pmu->global_status & ~pmu->perfmon_mask);
+
+	/*
+	 * Bit 48 is currently the only miscellaneous status bit (63:48) that
+	 * can be guest-owned; it indicates that a PMI is triggered, regardless
+	 * of fixed counter 3's PMI-enable state.
+	 */
+	if (pmu->global_status & GLOBAL_STATUS_PERF_METRICS_OVF) {
+		kvm_make_request(KVM_REQ_PMI, vcpu);
+		return;
+	}
+
+	/*
+	 * Match bare-metal behavior for counter bits (47:0): request a guest
+	 * PMI if any overflowed counter actually has its PMI-enable bit set.
+	 */
+	for_each_set_bit(i, (unsigned long *)&pmu->global_status,
+			 GLOBAL_STATUS_PERF_METRICS_OVF_BIT) {
+		pmc = kvm_pmc_idx_to_pmc(pmu, i);
+		if (pmc && pmc_is_pmi_enabled(pmc)) {
+			kvm_make_request(KVM_REQ_PMI, vcpu);
+			break;
+		}
+	}
+}
+
 static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -1029,6 +1069,8 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
 		if (pmu->perf_metrics)
 			wrmsrq(MSR_PERF_METRICS, 0);
 	}
+
+	intel_perfmon_mask_request_pmi(vcpu);
 }
 
 static bool intel_pmu_validate_perfmon_mask(void)
-- 
2.55.0

