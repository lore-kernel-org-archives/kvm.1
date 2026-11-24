Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557207;
	b=nLFRLvkMyvpflDXrhvMfwq1vKXi91YcoT/UA6j09Y5Wo7/vjmA9AOy546oUbgdvUa/0Q
	 avsTJfLsBxccZsAzATF6XgLc9ZTBYhfOVsOubR98dSDfrpKg+0RTCBuSj+ymlKohjxQam
	 kCLMTbxkUr4MUgEUtxIlIe9BqSou6ezBgrflTfbXI/4lGp8MpdnjifjpY7lNGDWyZ30o7
	 cxqunTe9MpNNbEvgYB22a23+z0HwgQSSc4pSlGuSeGHD228B/I0WCHX2ENi8z1as7kDfh
	 uKycEL7S0tJZqrESf22eAb641JadZyXJTRuTlEWxBaRZLLonjnP7IAI8DQf2a6/5g3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557207;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CXLBgZD6S0buTdDbsO1X1aRIvdhK6KZqE+86n05nHI4=;
	b=hPF0x4VNYvWLSEH0C0xEgiBYOpPuacBJIJlEqxqZgcDnd0uChgBCLT6XDYcu59bRrM8K
	 3crG9T0fet/LIoZGEukM5zQeQoqkKm7yMC4UPWK8FK9oecHmp7QayLhArv8LtgthKmciI
	 us5IjsCCnMLIKi0VbCyWU5qMZDQGzYQL3nklASfCD7JHdVUVYuMZYdrNI7j9kh73WcVJS
	 f4iPkbKPnBPSmBCCQko8liA7LN6AJDW7v6YfsqOWVRCEj7MVdZ2nU8pZHym+29jz4CUR/
	 LtpBemwJkXUsYuutJaoTLDOhCVoRLhGHTuOGW9K0LATIJyGYjn9rvh6L7sDq1iLICLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CFqntcv9;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24652606A6BF;
	Tue, 24 Nov 2026 21:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24652606A6BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CFqntcv9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557208; x=1827093208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fPeRpRJI9SugLZScetWBC++eODUVKbjZmjRHh1QAHSs=;
  b=CFqntcv9UkfJDgXdwcmE25ojZ0VRdVJP890bPBv6q7Cn74c49do8OjoY
   VG5Ofvow350mGHO4IdI9HKU0WZa0i34+CBOhefLgsA5o8SzNqU5XQUlzP
   FU1u7vOUsw59mI9Y7KxinfCj9dNA2mKWSisya/tBS2hOvHs0jRNoQpmxH
   JAibS7Y4P4m4I9WuET/nco9HgnSphOrh6K9dZZU6GHWGJMez5mXXZbtxB
   M2KlEzMzkP93GwmH7eGRBJaEm8Gl1kQap7c2H3aSHXB1fl/OtrLzUoM5n
   8Bia8nBB9p7tajSzwHGVU0ASXE11nf379jiooBRE5XyHCIquBaBBgts+p
   w==;
X-CSE-ConnectionGUID: drJhIRxIQVKDOJkl9l6u/g==
X-CSE-MsgGUID: bx+THs2VT46Ypp6aSz2WMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4306020"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4306020"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:27 -0800
X-CSE-ConnectionGUID: U1WEAucJRT6xsddqp4sUiA==
X-CSE-MsgGUID: qKWHTqYUQv+NNqM1s6PV/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271917"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:25 -0800
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
Subject: [PATCH v10 07/18] KVM: x86/pmu: Query perf-reported capabilities instead of RDMSR
Date: Tue, 24 Nov 2026 14:38:50 -0700
Message-ID: <20261124213901.120572-8-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124213901.120572-1-zide.chen@intel.com>
References: <20261124213901.120572-1-zide.chen@intel.com>
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

KVM reads MSR_IA32_PERF_CAPABILITIES directly, which bypasses the
errata workarounds (e.g. RPL018) and sanitizing that perf applies to
the value.

Use the capabilities reported by perf instead. This also avoids
reading the MSR twice during VMX PMU initialization.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v10:
- Re-purposed the patch "Snapshot host IA32_PERF_CAPABILITIES"
  to simple references update.
---
 arch/x86/kvm/vmx/pmu_intel.c | 7 +------
 arch/x86/kvm/vmx/vmx.c       | 8 ++------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 8f72a405e737..f916048b9c54 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -775,16 +775,11 @@ void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
 
 static bool intel_pmu_is_mediated_pmu_supported(struct x86_pmu_capability *host_pmu)
 {
-	u64 host_perf_cap = 0;
-
-	if (boot_cpu_has(X86_FEATURE_PDCM))
-		rdmsrq(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
-
 	/*
 	 * Require v4+ for MSR_CORE_PERF_GLOBAL_STATUS_SET, and full-width
 	 * writes so that KVM can precisely load guest counter values.
 	 */
-	if (host_pmu->version < 4 || !(host_perf_cap & PERF_CAP_FW_WRITES))
+	if (host_pmu->version < 4 || !(host_pmu->perf_capabilities & PERF_CAP_FW_WRITES))
 		return false;
 
 	/*
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b341af4c6057..f04f2d3884d9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7889,14 +7889,10 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 static __init u64 vmx_get_perf_capabilities(void)
 {
 	u64 perf_cap = PERF_CAP_FW_WRITES;
-	u64 host_perf_cap = 0;
 
 	if (!enable_pmu)
 		return 0;
 
-	if (boot_cpu_has(X86_FEATURE_PDCM))
-		rdmsrq(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
-
 	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR) &&
 	    !enable_mediated_pmu) {
 		x86_perf_get_lbr(&vmx_lbr_caps);
@@ -7909,11 +7905,11 @@ static __init u64 vmx_get_perf_capabilities(void)
 		if (!vmx_lbr_caps.has_callstack)
 			memset(&vmx_lbr_caps, 0, sizeof(vmx_lbr_caps));
 		else if (vmx_lbr_caps.nr)
-			perf_cap |= host_perf_cap & PERF_CAP_LBR_FMT;
+			perf_cap |= kvm_pmu_cap.perf_capabilities & PERF_CAP_LBR_FMT;
 	}
 
 	if (vmx_pebs_supported()) {
-		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;
+		perf_cap |= kvm_pmu_cap.perf_capabilities & PERF_CAP_PEBS_MASK;
 
 		/*
 		 * Disallow adaptive PEBS as it is functionally broken, can be
-- 
2.56.1

