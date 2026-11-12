Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516232;
	b=YJVKcashJiKb2ZQXs5qby/zf0tRtOGsyjscGe25LrBf/OCuPFcKIfSZkSDuMfDynNrSY
	 9ELiTeQxtw4Xid+SBu/JWC4swXl5JqFLp1MUwgvEb+KGW+dgy6kGRneGjAZp9y36jTqGO
	 4AhgGNlHDSSHV4SfLMDjpD99urD3e98NdEFBHe/PFFNtwgRFl5UGm/GA+ilWorj2qAQ5n
	 qYb9FKSkSBeLi+Ig8z/X68SD2MpFwwqgzxK87stdTdEC0byib2BcCdVOfv30m+sPqgadN
	 z42yNGLQ2zb03vfwoFUoxjI4IJSKOMAQu1k1rp+r9WV7TdO8NaeTgrhtpxXyCLI6eeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516232;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=le2r4UOhVYtr1z5VWCEwjjHWmuOUxM+fb+Wke5ddQhI=;
	b=lCwR/IFPs1x759XXaPVs6wcJoaD2FhfOIJbZ2CFKFE4bvnibS78Y5WhwQqEUsj+idfk7
	 j/9FYQDIjtjlrOZyhOhj7ZrfQKqWoeXUT6fabkVpKUCi1ygeOvx83/d3qdglTkQnyv0xi
	 QujrBvBIM78bLHOlCACB3LRvVfrDYatnyZdP6M6zo/aNyMO98zi8BCHhSOmSqFN0TWY3G
	 fz0hPjQ5LR+LK7qARIBP9FFQbX9dMr8PxdpOHMULpAS0ImZqoaVjrsBKPLGRphqecjv2U
	 x0xWkBEY7sW/PTYXPtW3zL9Q/z5OMyINCCkFADEydjRNGS/5Vpyzo4vaaGjLtd0hdmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K8xbRJSt;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C3260A5BFC;
	Thu, 12 Nov 2026 20:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07C3260A5BFC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K8xbRJSt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516232; x=1826052232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NjCfPbwd6R9aFGIK54bPy4E+5tD7lpYihcITH833jJk=;
  b=K8xbRJStjwo/i1kM8XXezEOiJbRoddz/91gPyvveDEUYy9u7zd7zAeZi
   0joxEF230bK3miyzZZBWIPRwo51Jg0iErJh6wXqoEwSp1D+V3olUDPNcb
   mQdjyxD+G1Vg7AiIRl8y2NIvYFDcHGBgyQM/T2GvYYFp1TdyZ5zifvvWx
   F3rSRcqROuXbR9W9JpmzVJY6byT7DEJu9tI/KR06R56t5lCbGCfwjlx1P
   jFzLShs35LULxxiCfw5KEGk6HAjL/27CwwjsiIRYiFqeJ3MlWzs6kiVTn
   sq2wkvB0zdur+Yci+/CMIo1LlS0SmCAbhLKdArgPi1oDjvRrCbxycGvVc
   Q==;
X-CSE-ConnectionGUID: Kj9EJY+RQvOLfePz82OaDw==
X-CSE-MsgGUID: jsWLJqZ3QAu5lNfQdGLnIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192312"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192312"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:51 -0800
X-CSE-ConnectionGUID: wTx/y1/dSlCymSObDlNvHA==
X-CSE-MsgGUID: w1wLUh3nQKavE2e3d69Iag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087931"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:52 -0800
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
Subject: [PATCH v4 17/21] KVM: x86/pmu: Factor out fixed counter control bit calculation
Date: Thu, 12 Nov 2026 13:32:23 -0700
Message-ID: <20261112203227.289379-18-zide.chen@intel.com>
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

Rename intel_pmu_enable_fixed_counter_bits() to
intel_pmu_fixed_ctrl_bits() and have it return the computed fixed
counter control mask instead of updating fixed_ctr_ctrl_rsvd directly.

Accumulate the desired fixed counter control bits during PMU setup and
apply them once in intel_pmu_refresh().

Move the helper earlier in the file so it can also be reused for
upcoming ANYTHREAD_DEPRECATION emulation.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
v4:
- Pass 'pmu' directly to kvm_for_each_fixed_counter().
---
 arch/x86/kvm/vmx/pmu_intel.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index d259b66abac8..65b6f274a8f6 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -55,6 +55,17 @@ static struct x86_pmu_lbr *vcpu_to_lbr_records(struct kvm_vcpu *vcpu)
 
 #pragma GCC poison to_vmx
 
+static u64 intel_pmu_fixed_ctrl_bits(struct kvm_pmu *pmu, u64 bits)
+{
+	u64 fixed_ctrl_bits = 0;
+	int i;
+
+	kvm_for_each_fixed_counter(i, pmu)
+		fixed_ctrl_bits |= intel_fixed_bits_by_idx(i, bits);
+
+	return fixed_ctrl_bits;
+}
+
 static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 {
 	/*
@@ -534,20 +545,13 @@ static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
 	return eventsel;
 }
 
-static void intel_pmu_enable_fixed_counter_bits(struct kvm_pmu *pmu, u64 bits)
-{
-	int i;
-
-	kvm_for_each_fixed_counter(i, pmu)
-		pmu->fixed_ctr_ctrl_rsvd &= ~intel_fixed_bits_by_idx(i, bits);
-}
-
 static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct lbr_desc *lbr_desc = vcpu_to_lbr_desc(vcpu);
 	int nr_gp_counters, nr_fixed_counters;
 	struct kvm_cpuid_entry2 *entry;
+	u64 fixed_enable_bits = 0;
 	union cpuid10_eax eax;
 	union cpuid10_edx edx;
 	u64 perf_capabilities;
@@ -633,9 +637,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 					  kvm_pmu_cap.bit_width_fixed);
 	pmu->counter_bitmask[KVM_PMC_FIXED] = BIT_ULL(edx.split.bit_width_fixed) - 1;
 
-	intel_pmu_enable_fixed_counter_bits(pmu, INTEL_FIXED_0_KERNEL |
-						 INTEL_FIXED_0_USER |
-						 INTEL_FIXED_0_ENABLE_PMI);
+	fixed_enable_bits |= INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER |
+			     INTEL_FIXED_0_ENABLE_PMI;
 
 	counter_rsvd = ~(kvm_gp_pmc_mask(pmu) |
 			 (kvm_fixed_pmc_mask(pmu) << KVM_FIXED_PMC_BASE_IDX));
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
2.56.1

