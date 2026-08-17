Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892AB470125;
	Mon, 17 Aug 2026 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992091; cv=none; b=IVKTl2wJBQ/AqfayH/ujOMHCdeKK9nE/5jsMDWiat1jSrfAg8xh+eqSqIdzef2ffuFzZdZthJY+2VFQVqr8H+KIuyejtLkZSZJnMeDz4CsPdQtF1mkiyUED7gtmg1h5PJExE7e+NVFiaihrcNAt2V2DU5c68vVhnLCCDZxGk4u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992091; c=relaxed/simple;
	bh=s7qmEIh6BTSzvB8kHFd3pxa7drzucQTpbxqF5pglosw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbNmQJ6eTCY45m5g7faJzQCHtCCe3yPJL8KR5rBo9hSP7vcjJ+d2BD6oIv7xx9/U/M8fWCuZoaiU6GZZRf2TdvTXeY0Ynuj6veBuxW6wfEbsmBS1Ob3ZOv9LC1PEf823KUrvc61TaTsqM5IGcxSsW8PAaxPNIT3nsL3wKdn13u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ox4N41SE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ox4N41SE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786992090; x=1818528090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s7qmEIh6BTSzvB8kHFd3pxa7drzucQTpbxqF5pglosw=;
  b=Ox4N41SElCYVFOctHe7BDNgZzTpa41nw+WuOjaCXfoR0dR7QCxTs6FWT
   qW/K3tHPTqAonau20h7zgGLJl6iRKERpPtGMTUbHDHr0yh28wHcNvu2fl
   Y8OglUZyPWt/hG3PKpU+/g6fdneS5mrKkune4BTLzd9AJfl+Mwq+MWZ2w
   Qxqd+H0sdX4O8D8xyoakuaDvk+Pf+zZxprwSoKDJ1O5u6eWku/M4PjPCD
   +mpsj88m0VQw3xGzcmwR8XPURCoskiWNay5Z7KeoVkPWDKj/9VhqgS5fV
   c0epNOnQIDaTXDd1Su2chRWZOfS5D8/yUqTeBzuHwOScuwWLmen5qDYis
   A==;
X-CSE-ConnectionGUID: XuUDIcCZSxOw1B7Is2SqOQ==
X-CSE-MsgGUID: az1Z3xhbT1+bdcgXsdoLnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98066088"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="98066088"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 11:41:25 -0700
X-CSE-ConnectionGUID: 4BbITAnWTkiPZ6zLRjD1SQ==
X-CSE-MsgGUID: gXMATm2JShiDNIGDoiNT1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="263656965"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 11:41:24 -0700
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
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v8 4/8] KVM: x86/pmu: Snapshot host IA32_PERF_CAPABILITIES in kvm_host
Date: Mon, 17 Aug 2026 11:31:38 -0700
Message-ID: <20260817183143.226156-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817183143.226156-1-zide.chen@intel.com>
References: <20260817183143.226156-1-zide.chen@intel.com>
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
index 8a4e542218a7..d893fa5be838 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -294,6 +294,7 @@ struct kvm_host_values {
 	u64 xss;
 	u64 s_cet;
 	u64 arch_capabilities;
+	u64 perf_capabilities;
 };
 extern struct kvm_host_values kvm_host;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e3bfe6aca1a0..6e9d197982b7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8023,14 +8023,10 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
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
@@ -8043,11 +8039,11 @@ static __init u64 vmx_get_perf_capabilities(void)
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
index d94b59140c45..d349224d2734 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7083,6 +7083,10 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
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

