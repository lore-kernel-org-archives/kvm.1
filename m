Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8DA522EF6;
	Fri, 18 Sep 2026 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761005; cv=none; b=GqqkgspFesWMfovokrGBdCFgd6PZhEbsFWAGzMkGwRsNKGBPLuWrVVovvqnLMVRBJFdrmD8nWu/8O8mkwTTwsDDU6F9gxpjTPP8mHpyfLcg0qZxbqCPUXbY/5Pa+8d4QEbZg1MMGbKmlSgbpXfaBkXH58GH1NpBBAoN28En1nGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761005; c=relaxed/simple;
	bh=U/eRjss1nlgiCHOu3708slbgLWkBpdH42O7XFOwZvbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLNoqhDjHZIw34KsGWqPegt88aqH+OL+ROb+RWs6Sq/VZtwCuwNEEDT74XDGMr/CqUbJpgQFlaOxwiCWTInQXT3zwpKkpe0Hrek6TIt+8uJIGlyCnFUFJTHzsdiY4mZAeCzwjRPLfNadO1T9vbEm5LlXf0WMlLYCjRI8V8HoqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ca3+e2wE; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ca3+e2wE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789761003; x=1821297003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U/eRjss1nlgiCHOu3708slbgLWkBpdH42O7XFOwZvbM=;
  b=ca3+e2wEGjxB4IJQ8VTvIrzSRC+MJLF7Gsym/jxgs7bET24sedD1kIfJ
   rM7h0S1CcX39kIEUu03UmMpWylmG5TcPx9bFYN2yGg0saddBheLID2RJ/
   H14VYjnd/6zuSUv0YMriSmp10cndzcjaaeEgCVEgmlvr+0Yszoxg4PMdh
   sCMW+85fdKOSjstpAGeq5wCF8TgW1OcTEvodZJ/3lmAsp3gw64SIJ/nml
   mdnJp5jEG+KSi9MjV+hMtMeXuP+wtENcSHmrb3ECxOS/BvQBmpZe+ohPM
   /2wl7PSdzBPZRQNgRtlbT5v2csvAtFkguG/Bb04mNtD23hUFJ/7gKFZvk
   w==;
X-CSE-ConnectionGUID: 1rmS9j8eT56cxF4512pyag==
X-CSE-MsgGUID: JVxpAaPHR/GH2ugE2Z9pBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="790321"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="790321"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:49:59 -0700
X-CSE-ConnectionGUID: rDLUAc5HR5mlRYo0wvaBHw==
X-CSE-MsgGUID: eMpp+0K3T5mLxlS3WgiCYg==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:49:59 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v9 04/12] KVM: x86/pmu: Snapshot host IA32_PERF_CAPABILITIES in kvm_host
Date: Fri, 18 Sep 2026 12:39:29 -0700
Message-ID: <20260918193937.569414-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918193937.569414-1-zide.chen@intel.com>
References: <20260918193937.569414-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mingwei Zhang <mizhang@google.com>

Cache the unadulterated snapshot of perf_capabilities so that KVM can
compare guest vPMU capabilities against raw hardware capabilities.

For example, if the host supports PERF_METRICS but it is not configured
for the guest, KVM can use it to determine that RDPMC accesses must be
intercepted.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
v5: new patch.
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/vmx/vmx.c          | 8 ++------
 arch/x86/kvm/x86.c              | 4 ++++
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 00584fcffa33..d00c7cbcfa14 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -295,6 +295,7 @@ struct kvm_host_values {
 	u64 xss;
 	u64 s_cet;
 	u64 arch_capabilities;
+	u64 perf_capabilities;
 };
 extern struct kvm_host_values kvm_host;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 56b44e032395..715e44489e22 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7949,14 +7949,10 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
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
@@ -7969,11 +7965,11 @@ static __init u64 vmx_get_perf_capabilities(void)
 		if (!vmx_lbr_caps.has_callstack)
 			memset(&vmx_lbr_caps, 0, sizeof(vmx_lbr_caps));
 		else if (vmx_lbr_caps.nr)
-			perf_cap |= host_perf_cap & PERF_CAP_LBR_FMT;
+			perf_cap |= kvm_host.perf_capabilities & PERF_CAP_LBR_FMT;
 	}
 
 	if (vmx_pebs_supported()) {
-		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;
+		perf_cap |= kvm_host.perf_capabilities & PERF_CAP_PEBS_MASK;
 
 		/*
 		 * Disallow adaptive PEBS as it is functionally broken, can be
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index af3ceee714c9..83106ce72d76 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7037,6 +7037,10 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
 		rdmsrq(MSR_IA32_ARCH_CAPABILITIES, kvm_host.arch_capabilities);
 
+	if (boot_cpu_has(X86_FEATURE_PDCM))
+		rdmsrq_safe(MSR_IA32_PERF_CAPABILITIES,
+			    &kvm_host.perf_capabilities);
+
 	WARN_ON_ONCE(kvm_nr_uret_msrs);
 
 	r = ops->hardware_setup();
-- 
2.55.0

