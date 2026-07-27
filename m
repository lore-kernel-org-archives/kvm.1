Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA55F3D5648;
	Mon, 27 Jul 2026 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180731; cv=none; b=fm7r6Ae8CczNZIlRv+McNh0car700pY16ekSyuCOQafSRnZmLdThur7Q4J+rSHcBQvQmNX/K5TEB1GshHPiCvcF0j1HaqW0NMHAfgnEMVef1k77vcqZAzpCoKt/6zYJDkXCpzZM+iBiQz4PI9opkW6MFe8x9afQJM2V47vzmZlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180731; c=relaxed/simple;
	bh=i/653uNZ53xgirnDBWPplloRGwADGOFNxBhQW70z0Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHTZwGRsTW0ZsHFvED8FFV5FnbFFrJlFLkDR2nhYOTNTKhtQbzplD5Z1qMogcFXPIkPpSpTcOyixEB8uemalRwakxLS+4A0ip7czANIaHt3g6O+7c+fFX3wHtlE79YV5J6Kp0DdzLRwm2DiQx87pM/rRLCFzRYzs011hFCyaQ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PU1ci4vc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PU1ci4vc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785180728; x=1816716728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i/653uNZ53xgirnDBWPplloRGwADGOFNxBhQW70z0Yc=;
  b=PU1ci4vcmyKUaeIsHwjrlCFJW3VJ6Qa84sWHzMuN2x4lfCksg5jR8CSl
   lGbR8lamqCs3sL2sdLozkz3UF3TfgOH4323Fvzg33JPv0EE3T5zzmJ2Ji
   XeMn2Ffp+mzeKXm5u6ZB+zdPMtoSMbCNrj7Fc4lHjThXnDSvoAN120CnX
   0DfLy/5t4D0R3O5Gk0/20HDLMoys3f2s9y8VICk4LFHuieNmqBgC0mPKT
   BotjKA8LSEUTmCfNEprvZjnOtZ3nBM40/2hP7Qe3wcV4X/AlyJipG2m8/
   K+Kp73FjFSKBIHExdodzZD6JCgfg8yI6XQVTYqe0P8XkOqs6MwAKNMMHB
   Q==;
X-CSE-ConnectionGUID: w2gfOxSkRl6ZRu7IUUWaew==
X-CSE-MsgGUID: Z4vEB+sVThOnu/4db68x4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85876706"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="85876706"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 12:32:00 -0700
X-CSE-ConnectionGUID: UgBrciCvRriFO68M9ekIyw==
X-CSE-MsgGUID: BYqEIo24S52E1wenk7d3Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="289451038"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 12:32:00 -0700
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
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v7 4/9] KVM: x86/pmu: Snapshot host IA32_PERF_CAPABILITIES in kvm_host
Date: Mon, 27 Jul 2026 12:21:26 -0700
Message-ID: <20260727192131.582105-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727192131.582105-1-zide.chen@intel.com>
References: <20260727192131.582105-1-zide.chen@intel.com>
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
index 7ff61651ef19..e663bdfb1d02 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -292,6 +292,7 @@ struct kvm_host_values {
 	u64 xss;
 	u64 s_cet;
 	u64 arch_capabilities;
+	u64 perf_capabilities;
 };
 extern struct kvm_host_values kvm_host;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e4b9ac7fed9f..08c70f94ae39 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8051,14 +8051,10 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
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
@@ -8071,11 +8067,11 @@ static __init u64 vmx_get_perf_capabilities(void)
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
index 1f5dc685f049..005341efa259 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7071,6 +7071,10 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
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

