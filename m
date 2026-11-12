Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516228;
	b=kCcb9vwS6I5ArSpJ3dBQg7dwNRmYslZBbUZuukqtV7d1h4I5OBOnlKz+BNTKVTc9P+VX
	 3yEr0jTSn/9/toYj5lLvu3powEfYMkI8qYNt4+uo+ohVEBNojJ0UkXmkPohISGqlC6efB
	 12ZP/V+cwPa25irK+Dweyxre1L7YQwe6dCqner6ieqiGtF/R9y4mu0MR9Vxk2XpvNeqw5
	 4qwGFcfAXBLVYt0KNdwRsSp3YxUM1DjaSsgsFcX2WSEyEukofOMZhuAy3DHfd+YxwI6/q
	 mgYCgXqfeAebdNqqxT0H4KDn9BUzcDbmeC5gdt4o8/nuvsvgmxnuz9MBEceKRBRkHkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516228;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+AxpR2m9z0iyIjkDHnnpgx/qBbC5JLXzTgP+09ZTh3I=;
	b=hqrDb4Qa7fgbqsh4HG1ZtRGq11Mx1sD1FKn4VP6Gedv/+on2z/8bjZlJZIO64FECCyvX
	 sPqmmP2H6k1BXV9aBB/aFIhCSTMrtBu3mC5BBiiiIcb1eaFuvldbf/yOhpN7o4eRrSAJE
	 BHOIl2lepq/sYiUEBzl7S9w0MPF2YjB6jPLiREJIbc4k1pbGjWyqyTajevXPGcTZEAJcf
	 HB/4xIgouCANb0ewTO5ZQ/nLl5UeBtjWz1a9PdYFeWxtB56RmhS14rfNke2lfW3MFqDSE
	 Kv1HA8kDIcojGaRyuYnCNyKlyS39Q7a17BlQ5dcY3rRBMzuLaezqloTZo/FfMRt1P/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CstdUHAe;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA09606A31C;
	Thu, 12 Nov 2026 20:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AA09606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CstdUHAe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516228; x=1826052228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Zg/p1EEoskhlUIs43sTvEW/ILEFWy0ZstubOgwVnYo=;
  b=CstdUHAeNKBA8Q0kWhkmZHaNWTXFekgLnm+wmqANL8017MttJWczz7jM
   KAN/uoMrnWYY6srfedgiy7ilXgKX1CC29pQPMOfSYVdM95kH9xIG1qToD
   vOGxGxxw79ycrq8FSGnaWMV5SHNqmJ0KW63z5KKNqEsn30YyPVD4au3BW
   Zxux0kt0psTT6l8fOz1455ErDFyc6loVgxlIjJxKNuHoA8S8oSBtuKTBt
   UjRftDUgZa4XE+CO28T0bpJlQaWE6V7WAadHlF5s1CTUWRYTI0cNk851m
   B3iKQjQ8dWPNzuoPMlC4W2jJs74oGnopqzVEB6NVWePbLXRmDhFosmVYR
   A==;
X-CSE-ConnectionGUID: TzVfnai0Tl+8X3U/mt05pA==
X-CSE-MsgGUID: WcpNtuU+QweCk4mnbGCZuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192219"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192219"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:46 -0800
X-CSE-ConnectionGUID: 0yVbponhQr+tBy/lCdt0hQ==
X-CSE-MsgGUID: iwr7v/fyQ9WvMzKZ+Bt7yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087868"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:46 -0800
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
Subject: [PATCH v4 02/21] KVM: x86/pmu: Remove redundant Perf Global Status MSR bit definitions
Date: Thu, 12 Nov 2026 13:32:08 -0700
Message-ID: <20261112203227.289379-3-zide.chen@intel.com>
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
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
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
2.56.1

