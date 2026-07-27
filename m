Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDEF3D954C;
	Mon, 27 Jul 2026 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180734; cv=none; b=a/x8M+yIUeSK9Hl691w1zJxt92V3t2JPExrY00rw3qGuW0NuGWxSZnXL1VgMOMq/7tWrpnAwjGSND27EdvSAQpK9mHljNTbIHCq5FSlmahNSbTu6v+JyHjbVNT7sCkLq6Pp6xO1BxkrFWGqKuGVawlTl3M/elTqikau/fI/zAO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180734; c=relaxed/simple;
	bh=NAbfBh0JbfVhqyjpKSU4R5fKZ7T2k6uLBJbO4+rt5sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cr+D4WgmERDlqo+ueYtz9XRen7aWyeUPFo+pzzOTQDDsm30v3qzwQuy+3mkxceYgPh3IiS4nN9SSRytRWgvL6V03dMRX9smTq9mEZhro3K54knZBdVWnRmD9QnfhQu1wOSZXINkrMDCKkG1aPka/sUqy3elo6OVKXqYexFTvOAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hBgCj8JB; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hBgCj8JB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785180730; x=1816716730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NAbfBh0JbfVhqyjpKSU4R5fKZ7T2k6uLBJbO4+rt5sQ=;
  b=hBgCj8JBpYG+AylFoJeMSmrK96luv47YgjOWYtTn9McciA1GfA59NaZO
   4T8Yks+EHMJvcnTCHUygt1AMZL8+IJa2ddIJeNtV4TqXYqzdH2JiRClOa
   JJUq/DGeIOGkE81aU8VAIzkl2gGRsARVpoCHMpcqTpW0HUCW8/JslmOL+
   33F1FyAQuDIyjIpxGQHyE3l7Vk8HMG8VyYG/IMC9v+huGn1rcB5Yv9LPd
   +KkAWJAKE2sm1QlkrLRnzXTnGTq564zgqJD1lZS3dUA/Sw3ZudoTT0x81
   WZH0uPFnHnt0yMEAusQc7M1r/iKJHL3V9SAYhFdgxSmPAwrnOtOWyP9NE
   w==;
X-CSE-ConnectionGUID: E9m5M4KFRuWYkPO2CyMr9g==
X-CSE-MsgGUID: EbOSxWl9TemcXakkEGGmuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85876719"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="85876719"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 12:32:00 -0700
X-CSE-ConnectionGUID: cAJHk3HlQZKrnbG1rTjkJw==
X-CSE-MsgGUID: 6HSAqLgPRuWVP+ZqXouveQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="289451047"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 12:32:00 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v7 7/9] KVM: x86/pmu: Restrict RDPMC passthrough to known CPUs
Date: Mon, 27 Jul 2026 12:21:29 -0700
Message-ID: <20260727192131.582105-8-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727192131.582105-1-zide.chen@intel.com>
References: <20260727192131.582105-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RDPMC type encodings are vendor-defined and could theoretically be
extended on future CPUs. An unknown RDPMC type could leak host
PMU information to the guest through RDPMC passthrough.

Rather than assuming future CPUs are safe, explicitly permit only
reviewed CPU models and require RDPMC interception everywhere else.
This ensures RDPMC passthrough is enabled only on CPUs whose RDPMC
encodings are audited and supported by KVM.

Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v7: new patch.
---
 arch/x86/kvm/pmu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 51c6d00a485f..092809bd757d 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -77,6 +77,21 @@ static const struct x86_cpu_id vmx_pebs_pdist_cpu[] = {
 	{}
 };
 
+/*
+ * CPUs whose RDPMC encodings have been audited for KVM RDPMC
+ * passthrough support.
+ */
+static const struct x86_cpu_id kvm_rdpmc_known_cpus[] = {
+	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X, NULL),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M, NULL),
+	X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
+	X86_MATCH_VFM(INTEL_NOVALAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_R, NULL),
+	X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
+	{}
+};
+
 /* NOTE:
  * - Each perf counter is defined as "struct kvm_pmc";
  * - There are two types of perf counters: general purpose (gp) and fixed.
@@ -807,6 +822,20 @@ bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
 
+static bool kvm_rdpmc_encoding_supported(void)
+{
+	/* KVM understands all RDPMC encodings prior to PMU v6. */
+	if (kvm_host_pmu.version < 6)
+		return true;
+
+	/*
+	 * Future PMU v6 implementations and future PMU versions require RDPMC
+	 * interception until their RDPMC encodings are audited and supported
+	 * by KVM.
+	 */
+	return x86_match_cpu(kvm_rdpmc_known_cpus);
+}
+
 bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -818,6 +847,9 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
 	if (enable_vmware_backdoor)
 		return true;
 
+	if (!kvm_rdpmc_encoding_supported())
+		return true;
+
 	return kvm_need_any_pmc_intercept(vcpu) ||
 	       pmu->counter_bitmask[KVM_PMC_GP] != (BIT_ULL(kvm_host_pmu.bit_width_gp) - 1) ||
 	       pmu->counter_bitmask[KVM_PMC_FIXED] != (BIT_ULL(kvm_host_pmu.bit_width_fixed) - 1);
-- 
2.54.0

