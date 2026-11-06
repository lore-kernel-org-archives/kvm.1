Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929839;
	b=5Vgm//HWyHqIqtLznIU6xv/uPH5Ht6EFKZ6Y0KK5h55GurchCV4rn6cT8f6SqjrPdza6
	 dFx+OI0DXyF5o5ZS08RKy7yutmzI+T09J2clSfXICt2odfKvnzUSh6qH6rKUqIsy9ot7k
	 1tBrrWo5wzE73IBWj8nyCylpAREwgaiKJYShUDscqvUoiwytDdK5bcYeJzgagmlczjTht
	 YPsHQ0wbDIkAzlJPF4X6N75Dgd/OG2lhghgWEAZbpMlM3+1duo82fvRdyunRsrn6xZjFN
	 TCXGN+RLa4F10msahVod8Ylroe8SzSlJd10MSJnN/bJZxQAv2bvlFxsjrKDJ95tRjjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929839;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Uw3pvDeqeJctiVbObvsq89Lj1ENDX5oEffAYqV7g0bM=;
	b=RzKke//GDMrE5SIWklEk0ieMVX4Uua8tTL7dJJ7PW9TZL9hkWbOhZXHAy7gPgl4Ec4j1
	 cmRDYq7IDxFH0ePIxusfzT98HT8Doze0WDTly5o9/ugzfkKzwQwTneCNcBmdzm5SrKPmh
	 xxoe6OJe295azf6dz+gHBgHr0IohW02XBg81kdw84JlO9dv5ZSSJGvCA1kXbaHIIJH1FY
	 5uy2vw8SpZvPqopiNtW5fS7XdDyFhOpkv/AUW3586mHBg8OuOL20l3/XpdVN1QFRCfqF6
	 VYHrRqQ1MPs0HojqcE6JASKGV2WP5sw3w9EDtifeeFWXnhEL2MF4rZzd9DZQM5+SNeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="D4m/G4Nj";
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC27606D825;
	Fri,  6 Nov 2026 01:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFC27606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D4m/G4Nj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793929838; x=1825465838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J3LrKTxooHwJ3y5RVu9IcqeeTRodKazOyuyCxNpVL/s=;
  b=D4m/G4Nja/XWSM8FWwsJBIhbhUSJLZZraZPPO9EL0C8VH8rlLGuGEGgQ
   zsYtO+Ji8988tDe0vRIV7owZIESYcJhYbCV/0KiLZBW/bp+oo9UgnoYsP
   80WCaTCLrq95mfB/Q+iEC1VC4nzq2KhjVTys+CueatElSNdJDlQBLO/nQ
   QP96lk7J7cJDsRjFTmHYcSHs+vK0Ya+GZDJIOZfDAQyLccbRkP0WTw3ms
   hXzN5P7Z4D8qn2GwCuWugotc8djqS0nKya2hKg4VoE5l+bcfH66bLH5pq
   UnOk8XET4dpiCwCrqYMKIuk5pUFjg6Q2W/1J8d22ls8aULyZhVJdoU5lZ
   w==;
X-CSE-ConnectionGUID: kW/z0tDwRl23Mi1/CEah6g==
X-CSE-MsgGUID: SBxb3d61SmCBy8rYiCV4Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740181"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2740181"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:31 -0800
X-CSE-ConnectionGUID: OjSTLzjvQaiyNIwTwLSTFA==
X-CSE-MsgGUID: ncFWTI8cQ5yn3D5Dn8REeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067199"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:31 -0800
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
Subject: [PATCH v3 12/18] KVM: x86/pmu: Emulate IA32_PERF_GLOBAL_INUSE MSR
Date: Thu,  5 Nov 2026 18:39:21 -0700
Message-ID: <20261106013927.166209-13-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106013927.166209-1-zide.chen@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
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

Intel PerfMon v4 introduces IA32_PERF_GLOBAL_INUSE (0x392) to track
which counters and the PMI are currently claimed by software agents,
allowing independent software agents to check counter availability
without a shared scheduler arbitrating between them.

IA32_PERF_GLOBAL_INUSE is a read-only MSR, and any write attempt
results in a #GP. The MSR is not part of the VM state, so it does
not need to be advertised to userspace, nor saved and restored during
live migration.

Always intercept IA32_PERF_GLOBAL_INUSE to prevent the guest from
erroneously observing filtered fixed counters as idle.

Originally-by: Yang Weijiang <weijiang.yang@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3:
- Split from combined v2 patch into standalone GLOBAL_INUSE patch.
- Always intercept MSR_CORE_PERF_GLOBAL_INUSE. (Jim)
- Use '!!' for explicit boolean conversion. (Jim)
- Relocate PERF_GLOBAL_INUSE_PMI_INUSE to perf_event.h.

v2:
- Change intel_pmu_get_global_inuse() to return u64, to match the
  surrounding code style.
- Add the missing vmcs02 updates for these two MSRs.
- Change "> 3" to ">= 4" to make the "v4-gated" more obvious and match
  the existing code style.
---
 arch/x86/include/asm/msr-index.h  |  1 +
 arch/x86/include/asm/perf_event.h |  3 +++
 arch/x86/kvm/vmx/pmu_intel.c      | 36 +++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 30cd04c0ace9..25dda50fbdc1 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1242,6 +1242,7 @@
 #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x00000390
 #define MSR_CORE_PERF_GLOBAL_STATUS_SET	0x00000391
+#define MSR_CORE_PERF_GLOBAL_INUSE	0x00000392
 
 #define MSR_PERF_METRICS		0x00000329
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 17b0bc7dfce7..2937e8a27891 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -454,6 +454,9 @@ static inline bool is_topdown_idx(int idx)
 #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD	BIT_ULL(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT)
 #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT	48
 
+/* Intel IA32_PERF_GLOBAL_INUSE MSR */
+#define PERF_GLOBAL_INUSE_PMI_INUSE	BIT_ULL(63)
+
 #define GLOBAL_CTRL_EN_PERF_METRICS		BIT_ULL(48)
 /*
  * We model guest LBR event tracing as another fixed-mode PMC like BTS.
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index e81a3f8b9b02..1372091dc1f8 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -198,6 +198,7 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		return kvm_pmu_has_perf_global_ctrl(pmu);
 	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
+	case MSR_CORE_PERF_GLOBAL_INUSE:
 		return pmu->version >= 4;
 	case MSR_IA32_PEBS_ENABLE:
 		ret = vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PEBS_FORMAT;
@@ -346,6 +347,38 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static u64 intel_pmu_get_global_inuse(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
+	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
+	bool pmi_inuse = false;
+	u64 eventsel, data = 0;
+	u32 fixed_ctrl;
+	int i;
+
+	kvm_for_each_gp_counter(i, gp_mask) {
+		eventsel = pmu->gp_counters[i].eventsel;
+
+		if (eventsel & ARCH_PERFMON_EVENTSEL_EVENT)
+			data |= BIT_ULL(i);
+		pmi_inuse |= !!(eventsel & ARCH_PERFMON_EVENTSEL_INT);
+	}
+	kvm_for_each_fixed_counter(i, fixed_mask) {
+		fixed_ctrl = fixed_ctrl_field(pmu->fixed_ctr_ctrl, i);
+
+		if (fixed_ctrl & (INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER))
+			data |= BIT_ULL(KVM_FIXED_PMC_BASE_IDX + i);
+		pmi_inuse |= !!(fixed_ctrl & INTEL_FIXED_0_ENABLE_PMI);
+	}
+	pmi_inuse |= pmu->pebs_enable;
+
+	if (pmi_inuse)
+		data |= PERF_GLOBAL_INUSE_PMI_INUSE;
+
+	return data;
+}
+
 static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -356,6 +389,9 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		msr_info->data = pmu->fixed_ctr_ctrl;
 		break;
+	case MSR_CORE_PERF_GLOBAL_INUSE:
+		msr_info->data = intel_pmu_get_global_inuse(vcpu);
+		break;
 	case MSR_IA32_PEBS_ENABLE:
 		msr_info->data = pmu->pebs_enable;
 		break;
-- 
2.56.0

