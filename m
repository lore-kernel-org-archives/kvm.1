Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929833;
	b=yS9VtpBu5OdRbBPaGGolnP1RimL06D370tdMRA/9plvXZUL+JcXDY2X1IumJ/rQD57YB
	 19tgWUi6bmOGxGj2gfhoGgJryScsRqRbbniSUIr2km5k8O3NA4LldjZ8pd+vhxw4vwQP/
	 xQjfsT8W0iz83dd/VPP0Nq7J2Gs6hwp8SesqCMmw9U1qq/D3nUks4dxZ6QVdg/aFYGdTv
	 ChOiJQjgXtb7UGAtnVcH/gICxvUCWZ8xx8AX7H95yhemWrIZqb5dwB5Jc7+RHpiHzBho5
	 Y5cyq26FUY2nFUXEHSDojhb0i0t6x8aMqKJwccdVL5QMUTFBAoMZUosjjGw18xlVTKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929833;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RAewxd9+PEcCdF8Fwg2UTOtSDMqmFi0KIUl9u9FAQBw=;
	b=3T6Ab9EBlfflnz3cMvxlN+7c4E1KRh8zDinIu94jvUoPZalcQw/oG1tABNunB9JOjLl2
	 PcbBdL+uHyYfLBXWz/4BIAEH9w5zin1fJYWCaBrtEWI/daoIvLLk2gmCbnH/ZZGN1wI0Y
	 n9DryOhzK2e88mkiapNV0ThXNpRZqGwG8nBaufCJkXlqRXphGsr0kik3YI/YRhadQ7+hO
	 D7ydXhFJsjpuozsw86rcBNoPndFblVCrgodVQfYr+VXe8o35g4CrdZ7dOkKDzIlMLeztZ
	 ePlYOiWd0xWyXQxLo3phe+LVn07PmnqgS3U3UwYh5JEYA2NBDMOHPp+JqfaSa1UhpLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HYRzI7OI;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D03C606A329;
	Fri,  6 Nov 2026 01:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D03C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HYRzI7OI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793929832; x=1825465832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4qYcfZuBzVUeYYmLj7ixMFnAtydAwbCLFI3fsIcxRas=;
  b=HYRzI7OIg+J8RnSKlVdiQHQcTqRwFbw6yvXNGUkLVibAQmBklHQfujqg
   KEc1PPx68HErnXZKBE2sDrz6x8Jn5nFcpzmUj5QtA8MlCzRZ89GnjQx+n
   EhUK0cGHan0McTJpJ9S961Hx5ZrVs2cZ10EwvsPNBGZ9ong0ethreiGHq
   B06zEH1NXXxJRj1cpCF0MlLb3rsR7WJG5GcY17kwK5Z1bcIiwmh3YvB+a
   n6zJrnyTh22qel7Lh3xP7dzDkpXN6IAmUn3Mm/5aczcf+iOL1OhXkZDPb
   y4d/YH0l4ctTrjWGLEnWef0H1t+xOlaPoDILlHiPXHbufhF/RCGI3h+H8
   A==;
X-CSE-ConnectionGUID: btE+kVDHTV6a9Ro5y98zkQ==
X-CSE-MsgGUID: J/TtIeubQ8+a54lEB90/dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740114"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2740114"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:30 -0800
X-CSE-ConnectionGUID: qDT5Ui0oQwWBqHOrgQfwIQ==
X-CSE-MsgGUID: IKXhFjEEQou2kBHm94JBxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067167"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:30 -0800
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
Subject: [PATCH v3 01/18] KVM: x86/pmu: Remove redundant Perf Global Status MSR bit definitions
Date: Thu,  5 Nov 2026 18:39:10 -0700
Message-ID: <20261106013927.166209-2-zide.chen@intel.com>
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

IA32_PERF_GLOBAL_STATUS and its SET/RESET counterparts share bit
definitions with perf_event.h, which is the canonical home for Intel
PMU bit definitions (e.g., PERFEVTSEL, FIXED_CTR_CTRL, GLOBAL_STATUS).
Drop the duplicate definitions from msr-index.h and update KVM code to
use the macros from perf_event.h.

Drop the comment as well, since the macros now match the MSR
naming.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/msr-index.h |  8 --------
 arch/x86/kvm/vmx/pmu_intel.c     | 11 ++---------
 arch/x86/kvm/vmx/vmx.c           |  2 +-
 3 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3a8e51a0c9e8..30cd04c0ace9 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1245,14 +1245,6 @@
 
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
index 70a8c4816135..36d91215f42a 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -579,17 +579,10 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
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
 
 	if (perf_capabilities & PERF_CAP_PEBS_FORMAT) {
 		if (perf_capabilities & PERF_CAP_PEBS_BASELINE) {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b341af4c6057..efde96e15533 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8477,7 +8477,7 @@ static unsigned int vmx_handle_intel_pt_intr(void)
 		return 0;
 
 	kvm_make_request(KVM_REQ_PMI, vcpu);
-	__set_bit(MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT,
+	__set_bit(GLOBAL_STATUS_TRACE_TOPAPMI_BIT,
 		  (unsigned long *)&vcpu->arch.pmu.global_status);
 	return 1;
 }
-- 
2.56.0

