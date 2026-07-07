Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F053876C3;
	Tue,  7 Jul 2026 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449839; cv=none; b=ih9EVv55u1tHNp0EXf4qJtDQ0UxwdZeU/t+CJssVccF5liBLyuJFIKtRGJOPbT142/TqaLFBhoCGdQZvGkLeU3vfNWPsTmFUs1+tjMfsdt+wA+dPFBpLG0w3lZ6YO5ljQGJ95uy5KtdKVJbgiGteHFdNzfIOzbHOO3DV7gUB75U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449839; c=relaxed/simple;
	bh=6kQFSgVkjXQrunIrn21pRxp3ZmDXrh1jKaj5znEosJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTpzVwIL7PWlPh50QlItbR3sLSkixMqQJMJh8EVPV2/73QaoAgnL4MmAAYH+7tZKOk/g+sDSF9e8vqZjfwwkIP1nftoDPWmLZIuU/alEMg1g7t9wy1JRMs+Y6dXdt9acz5aVFLyjYKJMGoZxQPUXM8TpnR6GRjjTKARG7a3EblQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVcamO3P; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVcamO3P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783449838; x=1814985838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6kQFSgVkjXQrunIrn21pRxp3ZmDXrh1jKaj5znEosJk=;
  b=UVcamO3P65APYGw8SQdXTHzBWWeIAqsH2VhG0JDYEHaDsPtlCUrIYwyO
   Crmn1vPmunpAMIfKJn6MAFMPYntjqraD/HxG8A20dhurKVwewgvnhwl0F
   As8TQ5oIeLU/5c0wvR9ImwIsltTfugnpC+A8ilbAgjvE1IrBTJ9AIS0ZC
   WCkwhByK0wgB52C+5NBo3o2dYMUJlIXlm7cl5/V4CtA61xmdBC3Xe+EzA
   YOMfDD7jXztev1+oGm5rMrse0RDNQgfeYpdk+4AFzpbqCrqe+eqqcxlcU
   PZ/4sHXOEqnj6/K/CSRkZ0w9ZGMOzwZk4TVFmDNRCWR9sMLjmrLtPmDSi
   A==;
X-CSE-ConnectionGUID: Zjt9UH9qRJuMMO5un6wtxw==
X-CSE-MsgGUID: +TXGjFx8SaCiQbPwHQgLfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94713846"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94713846"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:56 -0700
X-CSE-ConnectionGUID: 63cmi/5DQviWXlFuzKg05g==
X-CSE-MsgGUID: aj1tyaxKSd2jAxJf17B7ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277279280"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:55 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH 01/15] KVM: x86/pmu: Remove redundant Perf Global Status MSR bit definitions
Date: Tue,  7 Jul 2026 11:33:51 -0700
Message-ID: <20260707183405.15571-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707183405.15571-1-zide.chen@intel.com>
References: <20260707183405.15571-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IA32_PERF_GLOBAL_STATUS and its SET/RESET counterparts share bit
definitions with perf_event.h, which is the canonical home for Intel
PMU bit definitions (e.g., PERFEVTSEL, FIXED_CTR_CTRL, GLOBAL_STATUS).
Drop the duplicate definitions from msr-index.h and update KVM code to
use the macros from perf_event.h.

Drop the comments as well, since the macros now match the MSR
naming.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/include/asm/msr-index.h |  8 --------
 arch/x86/kvm/vmx/pmu_intel.c     | 11 ++---------
 arch/x86/kvm/vmx/vmx.c           |  2 +-
 3 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index fdcaeb6c8352..feee92aab504 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1244,14 +1244,6 @@
 
 #define MSR_PERF_METRICS		0x00000329
 
-/* PERF_GLOBAL_OVF_CTL bits */
-#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT	55
-#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI		(1ULL << MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT)
-#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF_BIT		62
-#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF			(1ULL <<  MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF_BIT)
-#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD_BIT		63
-#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD			(1ULL << MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD_BIT)
-
 /* Geode defined MSRs */
 #define MSR_GEODE_BUSCONT_CONF0		0x00001900
 
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 93b5a8360377..d0e16a3211ca 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -604,17 +604,10 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
 	pmu->global_ctrl_rsvd = counter_rsvd;
 
-	/*
-	 * GLOBAL_STATUS and GLOBAL_OVF_CONTROL (a.k.a. GLOBAL_STATUS_RESET)
-	 * share reserved bit definitions.  The kernel just happens to use
-	 * OVF_CTRL for the names.
-	 */
 	pmu->global_status_rsvd = pmu->global_ctrl_rsvd
-			& ~(MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF |
-			    MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD);
+			& ~(GLOBAL_STATUS_BUFFER_OVF | GLOBAL_STATUS_COND_CHG);
 	if (vmx_pt_mode_is_host_guest())
-		pmu->global_status_rsvd &=
-				~MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI;
+		pmu->global_status_rsvd &= ~GLOBAL_STATUS_TRACE_TOPAPMI;
 
 	if (perf_capabilities & PERF_CAP_PERF_METRICS) {
 		pmu->global_ctrl_rsvd &= ~GLOBAL_CTRL_EN_PERF_METRICS;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 21eb4b339fa6..e54b45d9bace 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8550,7 +8550,7 @@ static unsigned int vmx_handle_intel_pt_intr(void)
 		return 0;
 
 	kvm_make_request(KVM_REQ_PMI, vcpu);
-	__set_bit(MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT,
+	__set_bit(GLOBAL_STATUS_TRACE_TOPAPMI_BIT,
 		  (unsigned long *)&vcpu->arch.pmu.global_status);
 	return 1;
 }
-- 
2.54.0

