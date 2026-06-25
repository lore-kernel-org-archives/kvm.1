Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC4A3009E2;
	Thu, 25 Jun 2026 03:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782359698; cv=none; b=E88pdjqaot4qio8fnM+O2FIrf97pJDXfXFF0bTZFG0sySuGB9s01JYJPdbdTpJ+MyaqMtzpnKQp3R+6G2wEqfaoCRT+LM+KJN8Y2DpiyMXnPKe8NTJs8AGgKMkpjpCF9gJbcfOnbN7cCUA3hy+QclrBpEDuf3TuiRZqn4UxGh8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782359698; c=relaxed/simple;
	bh=puCDH4WsP4mWq3LsIsLbpLPW95o/D9mp8mEh8nHLZRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0obls5CAbTXx23rFo8qRB1keExL+RBh1EzJOPwJBRV4loPe47RflHaTen8itbIX+z31IbXaeUmdk8U00ZYUNGNxMZOjqDIbiRPwRW6omP8K4QauVcI4dvAHFM7lFoorFXGRrcW215mHnL7nkcAmYOmLmoUiDYSRa39KjMrYG+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqaZmmOy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqaZmmOy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782359698; x=1813895698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=puCDH4WsP4mWq3LsIsLbpLPW95o/D9mp8mEh8nHLZRQ=;
  b=AqaZmmOyOBC74c4QwIrpD1Jc+pZbliIL79AII2tSpUXpXpw41qBU+IgZ
   i3hPHSHpM9O1udIeptxap/tmWgwqHfBW0o1ntOJZOkar7k1UkttGW+10M
   24joUHhTzYt16VjhpurB0gcXlrv2bKwmBVj4LCsbYMMHXOq81FfbkawiZ
   hruD29HY/SWZoj6Ak4AJFFDPqMxuQPN1UdrrktIflGaS7najmmvM7fShs
   KtYplcX4PDlGU/624ujAnAZaw+Y2Fhl8k6oUfejv4YTrCaKQcc+M5wYKX
   HmyNfng38OuzyOsLjEghP5pP5G8k+cG9vN7ybed/FBO9kvy2oH26LcvOb
   g==;
X-CSE-ConnectionGUID: 33Mm74G+QWK+KU4pd/aPWg==
X-CSE-MsgGUID: fwNItLMcS6SA+gpvpj+8wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82901461"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="82901461"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 20:54:53 -0700
X-CSE-ConnectionGUID: QkIM1vTERzuC99JthBmkNw==
X-CSE-MsgGUID: vCs2VBUdTcyc8JrbwxeN8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="288396618"
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
Subject: [PATCH V5 2/7] KVM: x86/pmu: Support Intel fixed counter 3 on mediated vPMU
Date: Wed, 24 Jun 2026 20:45:50 -0700
Message-ID: <20260625034555.141453-3-zide.chen@intel.com>
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Starting with Ice Lake, Intel introduced fixed counter 3, which counts
TOPDOWN.SLOTS - the number of available slots for an unhalted logical
processor.  It serves as the denominator for top-level metrics in the
Top-down Microarchitecture Analysis method.

Emulating this counter on legacy vPMU would require introducing a new
generic perf encoding for the Intel-specific TOPDOWN.SLOTS event in
order to call perf_get_hw_event_config().  This is undesirable as it
would pollute the generic perf event encoding.

Moreover, KVM does not intend to emulate IA32_PERF_METRICS in the
legacy vPMU model, and without IA32_PERF_METRICS, emulating this
counter has little practical value.  Therefore, expose fixed counter
3 to guests only when mediated vPMU is enabled.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3:
- Move the non-contiguous counter filter code to pmu.c
v2:
- Don't advertise fixed counter 3 to userspace if the host doesn't
  support it.
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/pmu.c              | 18 ++++++++++++++++++
 arch/x86/kvm/x86.c              |  4 ++--
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index eee473717c0e..edd414f8ee95 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -574,7 +574,7 @@ struct kvm_pmc {
 #define KVM_MAX_NR_GP_COUNTERS		KVM_MAX(KVM_MAX_NR_INTEL_GP_COUNTERS, \
 						KVM_MAX_NR_AMD_GP_COUNTERS)
 
-#define KVM_MAX_NR_INTEL_FIXED_COUNTERS	3
+#define KVM_MAX_NR_INTEL_FIXED_COUNTERS	4
 #define KVM_MAX_NR_AMD_FIXED_COUNTERS	0
 #define KVM_MAX_NR_FIXED_COUNTERS	KVM_MAX(KVM_MAX_NR_INTEL_FIXED_COUNTERS, \
 						KVM_MAX_NR_AMD_FIXED_COUNTERS)
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index b92dd2e58335..7aafc5db1346 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -122,6 +122,8 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
 {
 	bool is_intel = boot_cpu_data.x86_vendor == X86_VENDOR_INTEL;
 	int min_nr_gp_ctrs = pmu_ops->MIN_NR_GP_COUNTERS;
+	union cpuid10_edx edx;
+	u32 eax, ebx, ecx;
 
 	/*
 	 * Hybrid PMUs don't play nice with virtualization without careful
@@ -169,6 +171,22 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
 	kvm_pmu_cap.num_counters_fixed = min(kvm_pmu_cap.num_counters_fixed,
 					     KVM_MAX_NR_FIXED_COUNTERS);
 
+	/*
+	 * Intel platforms may support non-contiguous fixed counters, e.g., some
+	 * E-core based server processors don't implement fixed counter 3.
+	 *
+	 * Before KVM supports non-contiguous fixed counters, make sure only
+	 * contiguous ones are retained in kvm_pmu_cap.
+	 */
+	if (kvm_host_pmu.version >= 5) {
+		cpuid(0xa, &eax, &ebx, &ecx, &edx.full);
+		if (kvm_pmu_cap.num_counters_fixed > edx.split.num_counters_fixed)
+			kvm_pmu_cap.num_counters_fixed = edx.split.num_counters_fixed;
+	}
+
+	if (!enable_mediated_pmu && kvm_pmu_cap.num_counters_fixed > 3)
+		kvm_pmu_cap.num_counters_fixed = 3;
+
 	kvm_pmu_eventsel.INSTRUCTIONS_RETIRED =
 		perf_get_hw_event_config(PERF_COUNT_HW_INSTRUCTIONS);
 	kvm_pmu_eventsel.BRANCH_INSTRUCTIONS_RETIRED =
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d9d51803b7b2..e872398c12fc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -350,7 +350,7 @@ static const u32 msrs_to_save_base[] = {
 
 static const u32 msrs_to_save_pmu[] = {
 	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
-	MSR_ARCH_PERFMON_FIXED_CTR0 + 2,
+	MSR_ARCH_PERFMON_FIXED_CTR2, MSR_ARCH_PERFMON_FIXED_CTR3,
 	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
 	MSR_CORE_PERF_GLOBAL_CTRL,
 	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
@@ -7742,7 +7742,7 @@ static void kvm_init_msr_lists(void)
 {
 	unsigned i;
 
-	BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 3,
+	BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 4,
 			 "Please update the fixed PMCs in msrs_to_save_pmu[]");
 
 	num_msrs_to_save = 0;
-- 
2.54.0

