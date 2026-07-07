Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F7F43F4D1;
	Tue,  7 Jul 2026 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449859; cv=none; b=ov6GCk5CozadH+Ixs0dD070tRj/nVqyKQbz8J3GhjWN5WKdf+9WW86xdnG0EK5NXltiQdDEzCarauTVmPVZQs8xBZt7mnhjOs1HHJKUvJNxZSdtsRFx46SP2/idyMYaiVfkHEWvVXSAcvDYg5yumbEosWYXHtaNl1+VLHFNrh/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449859; c=relaxed/simple;
	bh=8lCmOgyX50mecaq3qH9kzJZJdRTT0GFydYfmgTq39wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ldu+/Ry2MulrgJmzWmkh3g4Mz0Js01nPbrA4EBBsmT3gOpVhClTfId0P6tHik4x1MtTlJvvAZUNu+/iYa4gYsMKVLArFVg2M9BNHmCHTV1k80wORnhUH91uyOdi4wijA1bin9mf0O0ecJa7zW3LB1bHcF/zWFTJ6AnUV8b6HKHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ChsC4eGB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChsC4eGB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783449856; x=1814985856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8lCmOgyX50mecaq3qH9kzJZJdRTT0GFydYfmgTq39wM=;
  b=ChsC4eGBDboKkxA4oesDbrIJNfn/Nq7Z7R03Cn/EF4OmVPy3yYuzc1Vs
   aRDFfqMOViIij7+SBv1FAPVsVDk4Lwy5AjNr8wKB08Lixx1Lcv2LhdLNC
   Gw16sdAFWeZpdMbypVAk4cLj8Voant6x39AP9jFUwhM/7MRsv5sNSR2wA
   Eg7+iShX8kZT2w2XVk1Wrc9z7apzEMHUDQjW+3AkToP185Xi7ffpIxmDw
   ZtN9LSnOm4RWUDguBSs2vGUyjiz5tgH46VR8BnLM12MvJ9KOf3F5Ku72z
   F4jvKGkWl2iqzJ1I/ukWN1W7Aaobgp02HVAFQ484PrzklzI0o+DHq9OS1
   A==;
X-CSE-ConnectionGUID: Yv6W7LaFRNq0B4/gujvHWQ==
X-CSE-MsgGUID: CtTbyuLFQOaaGMW6MkJkyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94713907"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94713907"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:44:00 -0700
X-CSE-ConnectionGUID: LSLEIJYNTvqKRm0ck4LB9Q==
X-CSE-MsgGUID: nJk1XkroQnqyAVVlIW+MNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277279343"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:59 -0700
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
Subject: [PATCH 13/15] KVM: x86/pmu: Ignore AnyThread bit if CPUID.0AH:EDX[15] is not set
Date: Tue,  7 Jul 2026 11:34:03 -0700
Message-ID: <20260707183405.15571-14-zide.chen@intel.com>
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

Intel PerfMon v5 introduces the ANYTHREAD_DEPRECATION capability
(CPUID.0AH:EDX[15]) to indicate that AnyThread counting is deprecated
and that writes to the AnyThread bit in IA32_PERFEVTSELx are ignored.

When ANYTHREAD_DEPRECATION is present in the guest CPUID, emulate the
architectural behavior and silently ignore writes to the AnyThread bit
instead of injecting #GP.

Continue to inject #GP when ANYTHREAD_DEPRECATION is not present in the
guest CPUID, e.g. for PerfMon v3/v4 guests or when the capability is
not configured for a PerfMon v5+ guest.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 3f41e4916986..2c2a54ac55ad 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -508,6 +508,11 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			if (data & eventsel_rsvd)
 				return 1;
 
+			/*
+			 * On PerfMon v5+, KVM may allow writes to the AnyThread
+			 * bit and silently discard them.
+			 */
+			data &= ~ARCH_PERFMON_EVENTSEL_ANY;
 			if (data != pmc->eventsel) {
 				pmc->eventsel = data;
 				pmc->eventsel_hw = data;
@@ -627,6 +632,9 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->all_valid_pmc_mask64 = (BIT_ULL(nr_gp_counters) - 1) &
 				    kvm_pmu_cap.cntr_mask64;
 
+	if (pmu->version >= 5 && edx.split.anythread_deprecated)
+		pmu->eventsel_rsvd &= ~ARCH_PERFMON_EVENTSEL_ANY;
+
 	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
 	if (entry &&
 	    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) &&
-- 
2.54.0

