Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929837;
	b=l/6Q/4OpiaSee5hT8zvgtg+udOfWLWMMHJwpmMO13plCWAH+B0yXtkGUTpzkTdVrkxFh
	 Hiv00ebxPnkaxv5DED89VGTbStoaI01ktg64WrPIVeSg9OpvYaSjD8dWy76NqtsoD1mlg
	 UcAA8oRKpqV+KqaGrw65QSY1v3Fit2jTpLgmQUOqAEnInuUf41WOiG3p939PBIbl9bq/1
	 sYumKTVeKp8x+oIFSOTC71xCRO7wLIC6YWDrb/VXeyajQ6j0Zo1ZndYQ0/wX6pLE3146W
	 TepaVZMKcf7vjqrKMfANuf7xtkmWC5VmqqaHmxQ6xRW8myR2PjN5Iye+Ee64550m+yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929837;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=auAaQ5tE/or0gZlHrxldn+XgqPlfz9jhSbOxji13PNw=;
	b=ipy674YgQSkamEYUBasG524wrIBwqKdKgw9orScY4Iz7w1sI3EvzaQ7Wz/We1aPjHhra
	 V+jIV9Q0ExabqFhhefmkWTn5mPdl2ki4aO2b0DwfxDbJyHd/3fq8qE1CLhC0qyJuWbDvN
	 TxqBs/Jbnm247hVVN/nmFh0EJ9a4u6ulduog5u++9dG5ZHlQiB1P+9aar/BajUSrRv4ij
	 pNuiTXCCxF4JwCrfD81E26X7XkHzH/HE4bhQZKUc4Zog+PdSLzL3Lu65W2zUQLWhOE40C
	 HJ7upRD3lEBF/1gPkW5mDLaSLI7eHEZwNG1GECeZwAN4oXlopsyLU/clMDrQEVGmvtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ap2xX3b4;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09188606A32F;
	Fri,  6 Nov 2026 01:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09188606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ap2xX3b4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793929837; x=1825465837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AQ9OGKMv4fdIkri1AeOf1nwjyAMbRU3Lcz6ASrfEnIg=;
  b=Ap2xX3b4sD1ge3/KIfGZjYG8FBcaM3OXB4seYrtNbR4y/GqLBAyq+v1q
   Y2pBk2PJwu13oVVqUoKSUnXNp0WNM/zfWnTrLoDNprq0jjQRRzyixcQ/T
   SOYFmduWxO8xGFNhHyXfLXAMdXqhu7u9AvNFku6jWM9wpL4HIOvLP5OOv
   nYdsXdBLOWv2p7TN7zFKUxlbUO/Fsz0FijuBDFqvsmeEmqkbX8zFDvffH
   HW0h3dk/boFsuX9aQ2EisIY5w577gIt2qtNBIipFdGeCDckVSnqCEr1KK
   nerawM7c7Omlv4jJgLdSyN+m3M38aKpmZiFlgmz905fbkXBN17m9g3Kg6
   Q==;
X-CSE-ConnectionGUID: M2lPT/3/SzqSUAzB77/lWQ==
X-CSE-MsgGUID: dhVq6pspQRi0H7OCpYLDKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740177"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2740177"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:31 -0800
X-CSE-ConnectionGUID: RmLSupXKQTWYA6KBJPEJeg==
X-CSE-MsgGUID: kF4V3q85SDS8fzI7fT8WsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067197"
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
Subject: [PATCH v3 11/18] KVM: x86/pmu: Emulate IA32_PERF_GLOBAL_STATUS_SET MSR
Date: Thu,  5 Nov 2026 18:39:20 -0700
Message-ID: <20261106013927.166209-12-zide.chen@intel.com>
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

Intel PerfMon v4 introduces IA32_PERF_GLOBAL_STATUS_SET (0x391) to
allow software to set individual bits in the global status MSR. Reads
of IA32_PERF_GLOBAL_STATUS_SET always return zero.

IA32_PERF_GLOBAL_STATUS_SET is not part of the VM state, so it doesn't
need to be advertised to userspace, nor saved and restored during live
migration.

Always intercept IA32_PERF_GLOBAL_STATUS_SET to prevent the guest from
modifying status bits that are not virtualized by KVM.

Bit 63 (CondChgd) stays unreserved in pmu->global_status_rsvd to
architecturally allow the guest to write this bit on STATUS_RESET (0x390)
to clear it, and allow userspace to set it on GLOBAL_STATUS (0x38E).

However, bit 63 is architecturally reserved in STATUS_SET per the SDM.
Reject writes to bit 63, injecting #GP for guest writes. While older
processors had silicon errata that accepted writes without #GP (e.g.
SKX95), strictly enforce the architectural specification for
deterministic behavior across migrations.

Platform-specific EDS clarifies that CondChgd indicates a change to
IA32_MISC_ENABLE[7], which KVM intercepts and keeps strictly read-only
for guests. This guarantees hardware will never assert CondChgd during
guest execution.

Thus, the architectural asymmetry among these three MSRs is safe; being
unable to restore bit 63 to hardware via STATUS_SET is benign because
the guest will never legitimately observe CondChgd. Filter it out
defensively before writing to hardware in intel_mediated_pmu_load().

Originally-by: Yang Weijiang <weijiang.yang@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3:
- Split from combined v2 patch into standalone GLOBAL_STATUS_SET patch.
- Always intercept IA32_PERF_GLOBAL_STATUS_SET to prevent passthrough of
  unvirtualized status bits. (Jim)
- Reject writing bit 63 (CondChgd) to IA32_PERF_GLOBAL_STATUS_SET. (Jim)
- Filter out bit 63 before writing to hardware in intel_mediated_pmu_load().
- Move validation for MSR_CORE_PERF_GLOBAL_STATUS_SET to pmu_intel.c rather
  than common pmu.c to avoid exposing the Intel MSR on AMD.

v2:
- Add the missing vmcs02 updates for these two MSRs.
- Change "> 3" to ">= 4" to make the "v4-gated" more obvious and match
  the existing code style.
---
 arch/x86/kvm/pmu.c           | 13 +++++++++++++
 arch/x86/kvm/vmx/pmu_intel.c | 14 ++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 27d6a9169821..2cb5bccc7044 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -855,6 +855,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
+	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
 		msr_info->data = 0;
 		break;
 	default:
@@ -921,6 +922,18 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!msr_info->host_initiated)
 			pmu->global_status &= ~data;
 		break;
+	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
+		/*
+		 * Bit 63 (CondChgd) is architecturally reserved in STATUS_SET.
+		 * Older CPUs errantly accepted writes without #GP (e.g. SKX95),
+		 * but KVM strictly enforces the architectural spec to ensure
+		 * consistent behavior across migrations.
+		 */
+		if (data & (pmu->global_status_rsvd | GLOBAL_STATUS_COND_CHG))
+			return 1;
+		if (!msr_info->host_initiated)
+			pmu->global_status |= data;
+		break;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 		if (!msr_info->host_initiated)
 			pmu->global_status |= data & ~pmu->global_status_rsvd;
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index ce668ea08da5..e81a3f8b9b02 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -197,6 +197,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		return kvm_pmu_has_perf_global_ctrl(pmu);
+	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
+		return pmu->version >= 4;
 	case MSR_IA32_PEBS_ENABLE:
 		ret = vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PEBS_FORMAT;
 		break;
@@ -827,8 +829,16 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
 	toggle = pmu->global_status ^ global_status;
 	if (global_status & toggle)
 		wrmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, global_status & toggle);
-	if (pmu->global_status & toggle)
-		wrmsrq(MSR_CORE_PERF_GLOBAL_STATUS_SET, pmu->global_status & toggle);
+
+	/*
+	 * CondChgd is architecturally reserved in GLOBAL_STATUS_SET. Unless
+	 * set by malicious userspace, this bit should never be set in
+	 * pmu->global_status; filter it out defensively to protect against
+	 * a host #GP.
+	 */
+	if ((pmu->global_status & toggle) & ~GLOBAL_STATUS_COND_CHG)
+		wrmsrq(MSR_CORE_PERF_GLOBAL_STATUS_SET,
+		       (pmu->global_status & toggle) & ~GLOBAL_STATUS_COND_CHG);
 
 	wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl_hw);
 }
-- 
2.56.0

