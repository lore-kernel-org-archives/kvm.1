Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1625841D219;
	Fri, 21 Aug 2026 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351467; cv=none; b=abVXEBSXQVOmGQ5RtNSoqkWLEcPntXGntdmUBPsXZ6+oC3VpBLD9oXXwVfC8mWeTa3GhPYaga6/gkbMhAdNjZIGG1IXzI8WKQu1Y3fhD1o5EaSgo5E2WhYQ42CbpTPAz/ITKGzb7TOZO0JdwneBgM6/+h14PHdG29uDspOSVL4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351467; c=relaxed/simple;
	bh=haJrgloOrjcg62sSuENdPi0zbwxKNG05E+2aDikoVRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJcFZ+8PTiPwBJjMp0EmrYroSs8gx72fiBxnq0eY2XmLv1F7jwLdtS/Jv64yrpFGniCbE/wWZFRlcZXHRJWY7M6Gyq9y8RS7Cw8+g5Ax+jap0ScvgGKEWfTsLSyjwoGgeB+0kQXD9VV1kYdjeo/KkkYkenypVLdL1dQLdDA30/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJtRss75; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJtRss75"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351466; x=1818887466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=haJrgloOrjcg62sSuENdPi0zbwxKNG05E+2aDikoVRg=;
  b=kJtRss757yKdIrzLI7KDJMDyY/6TajPkQ6+n8frr3gjWkn5oc/A39kwY
   l59GKaqi5IT3tL0XJ06sspuaYUIK06+DpDXGiwBV79EAa3Jc0T0kacz1c
   j2Em1cJP5phEyxtvyP+3cpM8K9OyQyDysXjNex0MBaKJARH7mD1mC3j+W
   YkxRgvaQ2Qq2r2nvgSAojeBmTStFYqApeK/UPA+raazDIy82cUIJBI8Fe
   0RGuG51FCrnYY5UP0OkgFJWfCmCNQH7hAyiailVxyDCs/jil2BLGl206d
   pY4nKDyUQeMZSqrCc+MVHReqtZ95vUQ+/6qVZQAU/l2yYnvwhba4VnU8g
   Q==;
X-CSE-ConnectionGUID: +OWlMQbQQWWfHzUXDR34NA==
X-CSE-MsgGUID: sCnaIES4Tue5EG31EvPs5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032640"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032640"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:51 -0700
X-CSE-ConnectionGUID: Z4IbhPezSOe82zt9qZ3ngA==
X-CSE-MsgGUID: Hx4pE9DkTqu+qGT/KvPSPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679791"
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
Subject: [PATCH 16/23] KVM: x86/pmu: Handle FIXED_CTR_CTRL under PerfMon masking
Date: Fri, 21 Aug 2026 15:19:55 -0700
Message-ID: <20260821222002.54907-17-zide.chen@intel.com>
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

PerfMon masking affects reads from and writes to this MSR. The effective
mask is defined as bits 4n+3:4n and bits 4n+35:4n+32 being set if and
only if bit 32+n of the PerfMon mask is set (for 0 <= n <= 7).

KVM doesn't support some fixed-counter features, and
pmu->fixed_ctr_ctrl_rsvd is a subset of the effective mask above, so the
existing gating in intel_pmu_set_msr() is sufficient even under PerfMon
masking.

Upon guest PMU context load, OR the guest-owned bits with whatever the
hardware currently holds for every fixed-counter index the guest does
not own, before writing the result to the MSR.

During PMU context put, host-owned fixed counters may still be scheduled
for system-wide host events, so the host-owned bits should remain
unchanged.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 40 +++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 19ccc7cd319c..9236bfa15c41 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -920,6 +920,33 @@ static void intel_pmu_write_global_ctrl(u64 global_ctrl)
 	vmcs_write64(GUEST_IA32_PERF_GLOBAL_CTRL, global_ctrl);
 }
 
+static u64 intel_fixed_ctrl_host_bits(struct kvm_pmu *pmu)
+{
+	unsigned long fixed_mask;
+	u64 fixed_ctl;
+	int i;
+
+	if (!kvm_vcpu_has_perfmon_mask(pmu_to_vcpu(pmu)))
+		return 0;
+
+	fixed_mask = kvm_fixed_pmc_mask(pmu);
+
+	rdmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, fixed_ctl);
+
+	/*
+	 * Use the full per-counter nibbles (bits 4n+3:4n and 4n+35:4n+32) to
+	 * strip all bits belonging to guest-owned counters.
+	 *
+	 * pmu->fixed_ctr_ctrl_rsvd can't be used here since it can't gate bits
+	 * that are not supported by KVM.
+	 */
+	kvm_for_each_fixed_counter(i, fixed_mask)
+		fixed_ctl &= ~intel_fixed_bits_by_idx(i, GENMASK_ULL(3, 0) |
+						      GENMASK_ULL(35, 32));
+
+	return fixed_ctl;
+}
+
 static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -935,7 +962,8 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
 	if (pmu->global_status & toggle)
 		wrmsrq(MSR_CORE_PERF_GLOBAL_STATUS_SET, pmu->global_status & toggle);
 
-	wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl_hw);
+	wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL,
+	       pmu->fixed_ctr_ctrl_hw | intel_fixed_ctrl_host_bits(pmu));
 }
 
 static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
@@ -953,9 +981,15 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
 	 * Clear hardware FIXED_CTR_CTRL MSR to avoid information leakage and
 	 * also to avoid accidentally enabling fixed counters (based on guest
 	 * state) while running in the host, e.g. when setting global ctrl.
+	 *
+	 * Keep the host-owned counters unchanged.
 	 */
-	if (pmu->fixed_ctr_ctrl_hw)
-		wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
+	if (pmu->fixed_ctr_ctrl_hw) {
+		u64 fixed_ctl = intel_fixed_ctrl_host_bits(pmu);
+
+		fixed_ctl &= ~pmu->fixed_ctr_ctrl_hw;
+		wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, fixed_ctl);
+	}
 
 	if (kvm_vcpu_has_perf_metrics(vcpu)) {
 		pmu->perf_metrics = rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS);
-- 
2.55.0

