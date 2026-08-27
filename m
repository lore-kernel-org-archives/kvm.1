Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1593E51EF;
	Thu, 27 Aug 2026 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870898; cv=none; b=bOkFk8Kab92hndhQcC5ZDKn3G5DAdjLiZsP4pZc2a8zV26UbQNFFhmsrkQ+n+RFysfFKPYsIaJtMqb/k2zfiZE/4CaEFW+dGAJL+IiAAyNNdLcglJjJPkm9r7rBuwQ95fTIbNEDzx0Cs7q8EuukVUcwx+ImvcITCJtjMh87Lgyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870898; c=relaxed/simple;
	bh=fGtIvBDROZngTFIFV6xPwvHiJZJg6HH9JV0IvZUHhnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhzWriL3jjFgIBdfScYVxW8TZVEFGtnTKqN9h8d22C1Fu+xQbfar7VHDlOPRGXwbAQ3HKZs4JtWRGBqHyz1P3gzMhjZU3xZxvm+VLfVVI6HLjVnsOxpI9cMrgWOBVwCOJk54+b4/2fio4v+oIwWeE47UIkmNo4hKjGmRyfv3XNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgJpR3Wl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgJpR3Wl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787870896; x=1819406896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fGtIvBDROZngTFIFV6xPwvHiJZJg6HH9JV0IvZUHhnM=;
  b=hgJpR3WlZ0ham6HWlgZv2g7xPAoksngyzvyn5UKb+OallXaupKdtYFqG
   +DvYFW5r1qzKLn+d1wp2xl0q+z61I8aLWOxoHyNx6wqcZ3E3S5YdfCaJF
   koyqcsOD9+bLzmRmPLq7XLJZI3U702QV+pFRkoRdHZoDgXQKGLh8tDOM9
   mFbeRhGSBomZL207ahBkZOSPRhcEfOfmpP+M5YTNLaTLeMwgaHIpYQeFP
   20cX90NUBcz1EoB7OIdLDbg10z6i+AFYULv8R0SU5JdSrKwmCl1DM22VK
   h+r9w/PqKshNPKGxrJ3tSWF7TB8uhlFF4MZExUliwgRgVk0E/UM1oE09D
   w==;
X-CSE-ConnectionGUID: r9yxhNeQSiai04Ob36XVFQ==
X-CSE-MsgGUID: fXhAZIKnQ7amjlahj+GMfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113914891"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="113914891"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:09 -0700
X-CSE-ConnectionGUID: 6JqUSehGSte0GFcQ4tUPBg==
X-CSE-MsgGUID: y7PGRFZ6QHWEcYPtIOwRpA==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:09 -0700
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
Subject: [PATCH v2 13/16] KVM: x86/pmu: Factor out fixed counter control bit calculation
Date: Thu, 27 Aug 2026 15:37:52 -0700
Message-ID: <20260827223755.143247-14-zide.chen@intel.com>
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

Rename intel_pmu_enable_fixed_counter_bits() to
intel_pmu_fixed_ctrl_bits() and have it return the computed fixed
counter control mask instead of updating fixed_ctr_ctrl_rsvd directly.

Accumulate the desired fixed counter control bits during PMU setup and
apply them once in intel_pmu_refresh().

Move the helper next to intel_pmu_set_msr() so it can also be reused
there, which will be needed for upcoming ANYTHREAD_DEPRECATION
emulation.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v2: New patch
---
 arch/x86/kvm/vmx/pmu_intel.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 1ce69e764ae1..c7472778137a 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -421,6 +421,18 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 0;
 }
 
+static u64 intel_pmu_fixed_ctrl_bits(struct kvm_pmu *pmu, u64 bits)
+{
+	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
+	u64 fixed_ctrl_bits = 0;
+	int i;
+
+	kvm_for_each_fixed_counter(i, fixed_mask)
+		fixed_ctrl_bits |= intel_fixed_bits_by_idx(i, bits);
+
+	return fixed_ctrl_bits;
+}
+
 static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -533,20 +545,12 @@ static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
 	return eventsel;
 }
 
-static void intel_pmu_enable_fixed_counter_bits(struct kvm_pmu *pmu, u64 bits)
-{
-	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
-	int i;
-
-	kvm_for_each_fixed_counter(i, fixed_mask)
-		pmu->fixed_ctr_ctrl_rsvd &= ~intel_fixed_bits_by_idx(i, bits);
-}
-
 static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct lbr_desc *lbr_desc = vcpu_to_lbr_desc(vcpu);
 	struct kvm_cpuid_entry2 *entry;
+	u64 fixed_enable_bits = 0;
 	union cpuid10_eax eax;
 	union cpuid10_edx edx;
 	u64 perf_capabilities;
@@ -625,9 +629,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 					  kvm_pmu_cap.bit_width_fixed);
 	pmu->counter_bitmask[KVM_PMC_FIXED] = BIT_ULL(edx.split.bit_width_fixed) - 1;
 
-	intel_pmu_enable_fixed_counter_bits(pmu, INTEL_FIXED_0_KERNEL |
-						 INTEL_FIXED_0_USER |
-						 INTEL_FIXED_0_ENABLE_PMI);
+	fixed_enable_bits |= INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER |
+			     INTEL_FIXED_0_ENABLE_PMI;
 
 	counter_rsvd = ~(kvm_gp_pmc_mask(pmu) |
 			((u64)kvm_fixed_pmc_mask(pmu) << KVM_FIXED_PMC_BASE_IDX));
@@ -651,11 +654,14 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 			pmu->pebs_enable_rsvd = counter_rsvd;
 			pmu->eventsel_rsvd &= ~ICL_EVENTSEL_ADAPTIVE;
 			pmu->pebs_data_cfg_rsvd = ~0xff00000full;
-			intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_0_ADAPTIVE);
+			fixed_enable_bits |= ICL_FIXED_0_ADAPTIVE;
 		} else {
 			pmu->pebs_enable_rsvd = ~kvm_gp_pmc_mask(pmu);
 		}
 	}
+
+	pmu->fixed_ctr_ctrl_rsvd &=
+		~intel_pmu_fixed_ctrl_bits(pmu, fixed_enable_bits);
 }
 
 static void intel_pmu_init(struct kvm_vcpu *vcpu)
-- 
2.55.0

