Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB72F30D3FA;
	Thu, 25 Jun 2026 03:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782359706; cv=none; b=alrUzkpcZWoVYqyZPJ1Egn0QGiY/cuDwuoU+uXrA1fMm1N4jlan+lOkiF6s0ZWn2GlGDOABahlNkd8RUi/k5dhlmERudhg1wHbO3An3UfM1anRFPMbEVUe5IZTYcYJ02bZeCdLrQlq2jztPWi0qiH0Z8KE6lXjArcUkKyPJ/wkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782359706; c=relaxed/simple;
	bh=xSmaKsKFLveVhamtENldYNuBfkU4Y+YIgIZeVW76ocE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFxShIojhYknBXjhqE61jLPGRfXrnKSm2Y82WdwU6c00dFlaYbbvcZ+B+maZuywIwJE6g/dmjTcBmy/KiSVUB9uP72wOIMRinHWX01Ee7fjbVRr9mD84pkPs4HhPz3FlhvzM6bBhm5ryMuWxCBTqccoJBZZ1lRYgx9GkP3GrxH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFm9Y5bV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFm9Y5bV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782359699; x=1813895699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xSmaKsKFLveVhamtENldYNuBfkU4Y+YIgIZeVW76ocE=;
  b=cFm9Y5bVJAFH8dk2MCD4oHg3iRFmie0u271bQeHicYk2It4vzks2E5C9
   MhWMqlOm/lYArnpRgbPqm/F1bkA2akvhdPTdJ2d+pojOdNOeqqYIfIPRQ
   GIrTIQkNDHjCYPIjVUV/wquT2yltDu+PZDSaWJV5qamAw9pIecEZ189w2
   8o8L190dvJ9DZ4wc6mPo6SONmu85EA/9Q0iuXHNyi0vR8YnZJkynALnh8
   vOwthmAxBrBdhE1NTbdW3SW/PAXw+D0N4q4Lzl51ArdSjSFpd1gEmieTn
   8sekULe1zMKWqVMtoauWlTItQ3Tlz1Qi7zsMB33eEBsaYWkIo999vQYUl
   w==;
X-CSE-ConnectionGUID: HLuh/XJHSvKrolu2fBOuMg==
X-CSE-MsgGUID: rOys4a9PQ5W0ltfMbbaLiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82901474"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="82901474"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 20:54:53 -0700
X-CSE-ConnectionGUID: WtGcdgS+S+CDlPpazrMbIQ==
X-CSE-MsgGUID: A4/h4GgvTSSbyNYHoxACWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="288396627"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 20:54:52 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
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
Subject: [PATCH V5 5/7] KVM: x86/pmu: Snapshot host IA32_PERF_CAPABILITIES in kvm_host
Date: Wed, 24 Jun 2026 20:45:53 -0700
Message-ID: <20260625034555.141453-6-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625034555.141453-1-zide.chen@intel.com>
References: <20260625034555.141453-1-zide.chen@intel.com>
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
to the guest, KVM can use it to determine that RDPMC accesses must be
intercepted.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v5: new patch.
---
 arch/x86/kvm/vmx/vmx.c | 8 ++------
 arch/x86/kvm/x86.c     | 4 ++++
 arch/x86/kvm/x86.h     | 1 +
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 82df75f91e46..40d41c83ca42 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8039,14 +8039,10 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
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
@@ -8059,11 +8055,11 @@ static __init u64 vmx_get_perf_capabilities(void)
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
index 9623f558f359..18afbf00d17b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10148,6 +10148,10 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
 		rdmsrq(MSR_IA32_ARCH_CAPABILITIES, kvm_host.arch_capabilities);
 
+	if (boot_cpu_has(X86_FEATURE_PDCM))
+		rdmsrq_safe(MSR_IA32_PERF_CAPABILITIES,
+			    &kvm_host.perf_capabilities);
+
 	WARN_ON_ONCE(kvm_nr_uret_msrs);
 
 	r = ops->hardware_setup();
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 9de577ef9c97..74487f36d099 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -52,6 +52,7 @@ struct kvm_host_values {
 	u64 xss;
 	u64 s_cet;
 	u64 arch_capabilities;
+	u64 perf_capabilities;
 };
 
 void kvm_spurious_fault(void);
-- 
2.54.0

