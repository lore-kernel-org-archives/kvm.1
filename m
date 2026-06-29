Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27343CF200;
	Mon, 29 Jun 2026 23:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782775735; cv=none; b=itHcwCMnrbC0P1PvbBKo/mNnlb9EdAdxDcq8KpmUyoBrWg6783C+oYwnUKoAGRB5EqNRSv2IY/Da71hTWQs/kHq1SRDHcVVjKh2wMRA7GnKMa72Kf9KI21GCsvWuaFdthvajJP6tUt7/eob+9Z8plbuAQU9+DsPLLDs3SD2e5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782775735; c=relaxed/simple;
	bh=c7HHAbeJ8sAXUR0XbsiM/cq62YPD+N+Zpy7p4VdWuBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMeQZd9OyuRLPdyyaGuMxmQzwuZOmep3I66+HWye+JDneM8N42e4H+KwjwbvMzo615HXiDJKyP+7lsX+7RQLmioVMolzQpuhErScPZdysQflbg+tide0D4YphQXvTSyojgbmQnvUA4lpMjUm/21ZcTe2e2jOPSSicN21Ur8AYdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgBGrKMB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgBGrKMB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782775729; x=1814311729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c7HHAbeJ8sAXUR0XbsiM/cq62YPD+N+Zpy7p4VdWuBk=;
  b=jgBGrKMBwNdCA5Mmzj2NsuZ4KCYJWCc8NNl91WlKtYmw0QmcQ/VR4zIP
   tf6ew70d3DyfqkNEda995C6zlI61y16NlEfv/vYpRDIihA3p+9DF/Rebs
   +K1K9X3d3BMWCSSkNXimrarna1mvmlrjiygm2MSqLh0t4zV+Wzj0cH167
   45EFaLODaimTTZL+PQoG2LkGmYcssn2IONwI/gBZB5yPyIeDvCAu5gYNI
   OcMAL98SNF8F2Ts8oC8yw7Jj21i7OCJZj/4NqfB+yLzyPs1Q48esGOd84
   LPe552OLFdpQltyckeoYzkTVJCuCwWE9I+1pm8FnX7JTYpW+8G1IPgcMd
   A==;
X-CSE-ConnectionGUID: lOLxgneASJyoko77aqgeOQ==
X-CSE-MsgGUID: Jaf5xx8jREWlHYBBxJZjYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82593497"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="82593497"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 16:28:44 -0700
X-CSE-ConnectionGUID: 55pXtA1UStSpbewFQFBU1g==
X-CSE-MsgGUID: ePPW5o2PS4uoAiFdOf+mbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="290220137"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 16:28:44 -0700
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
Subject: [PATCH v6 4/8] KVM: x86/pmu: Snapshot host IA32_PERF_CAPABILITIES in kvm_host
Date: Mon, 29 Jun 2026 16:19:33 -0700
Message-ID: <20260629231938.15129-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629231938.15129-1-zide.chen@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
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
---
v5: new patch.
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/vmx/vmx.c          | 8 ++------
 arch/x86/kvm/x86.c              | 4 ++++
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index dc9e4e8bfc07..80f638588bf7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -347,6 +347,7 @@ struct kvm_host_values {
 	u64 xss;
 	u64 s_cet;
 	u64 arch_capabilities;
+	u64 perf_capabilities;
 };
 extern struct kvm_host_values kvm_host;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index aded7039bd3e..b736b9ff965b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8050,14 +8050,10 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
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
@@ -8070,11 +8066,11 @@ static __init u64 vmx_get_perf_capabilities(void)
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
index 8dbc0fa302a8..8e775855f9be 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7032,6 +7032,10 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
 		rdmsrq(MSR_IA32_ARCH_CAPABILITIES, kvm_host.arch_capabilities);
 
+	if (boot_cpu_has(X86_FEATURE_PDCM))
+		rdmsrq_safe(MSR_IA32_PERF_CAPABILITIES,
+			    &kvm_host.perf_capabilities);
+
 	WARN_ON_ONCE(kvm_nr_uret_msrs);
 
 	r = ops->hardware_setup();
-- 
2.54.0

