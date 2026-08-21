Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553842E406;
	Fri, 21 Aug 2026 22:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351473; cv=none; b=YAM/bnwG2BSOJ/lydtKVR/aUAZg2r4VGUNE9XsTXxJrE4fEOM7FKcte6ylD38p7ZaOfHaqA+GvIiPcl5PSWonJnNA8jKW6imcWNa4hroowVMrBuD5DMpLNuv96UiNZBDGAqbxDni24XBW7KesBDxzOyZatz7ks6L4/kIhaFI64M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351473; c=relaxed/simple;
	bh=qy6aW/elXTAJjGAyaqTEgmQ+RxWflIqPMox1ddyvWoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJS9r18G3fTOKgEOzGI6dYVNr6jTUCTTYwvKcUVmyPND+gZ6mxJk7/V7/uG89GU0QUnNTKwiuEsX8uTihjOTQW4i2xm7PHGjsZ11+y2L+mBq0HSK1UwMxJJSrTXRPEuypYxPTgd6cuNsOoZrQqdxn0tKkmXdbUcF6u1X9q9EkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDWdfd5R; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDWdfd5R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351471; x=1818887471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qy6aW/elXTAJjGAyaqTEgmQ+RxWflIqPMox1ddyvWoI=;
  b=YDWdfd5Rvfrw3g2LysCmbfw8pR6Yo21pEdypjGxEMm5jrn8+84oSjWfl
   0/f2VVfaZfBNP97I7XYbn3GLYFhDI+wfx0Z/bUdcwGeCvDnGzzobK4UJO
   LEFZBU2T5NCbvmYs5iAYgUAS25bsutExXP/JgdMCzAY4R+c1y+XRScRqL
   EE1kZHYJQf4FmIYJi4HmVkQ+8Omy95U20rC/0fy4JpcxqoBDmliqEjLfv
   ghC/tzGGPUkfczB6NbEn4jR9n9jODNdAmy7ydma8PavdNkEjiO0Py/P4x
   +MI5uxA5fESDelHajZXOQudIBVjta5T917/zU0U2tnjFHapY6jMBDlbdR
   A==;
X-CSE-ConnectionGUID: hRCBduTgRAOSaBHJqMOsNQ==
X-CSE-MsgGUID: vRE8rnauSyC6UgRokhroLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032672"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032672"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:54 -0700
X-CSE-ConnectionGUID: pl1G68DqSOO3grgOVDb1pw==
X-CSE-MsgGUID: jvSBvi5+Rf2+ItyPwJ6P1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679822"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:53 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Jim Mattson <jmattson@google.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH 22/23] KVM: selftests: Fix PERF_METRICS test by checking FC3 availability
Date: Fri, 21 Aug 2026 15:20:01 -0700
Message-ID: <20260821222002.54907-23-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821222002.54907-1-zide.chen@intel.com>
References: <20260821222002.54907-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IA32_PERF_CAPABILITIES.PERF_METRICS_AVAILABLE[bit 15] is not tied to
a particular PMU version, and userspace can enable it as long as it is
advertised.

On a PERF_METRICS capable host that supports fixed counter 3 through a
non-contiguous fixed counter bitmap, userspace may enable this capability
while configuring a guest PMU version lower than 5.

This scenario is unlikely on bare-metal systems, but it can occur with
PMU partitioning. For example, when kvm-intel is loaded with:

perfmon_mask=guest_fixed=1-3;perf_metrics

CPUID.0AH:ECX[4:0] is 0, and thus fixed counter 3 is not available
when the guest PMU version is below 5. Skip the test in this case.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 tools/testing/selftests/kvm/x86/pmu_counters_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
index 2797d7e0e3a3..edcd04b4111c 100644
--- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
@@ -678,7 +678,8 @@ static void __guest_test_perf_metrics(void)
 
 	if ((guest_get_pmu_version() < 2) ||	/* Does guest have GLOBAL_CTRL? */
 	    !this_cpu_has(X86_FEATURE_PDCM) ||
-	    !(rdmsr(MSR_IA32_PERF_CAPABILITIES) & PERF_CAP_PERF_METRICS))
+	    !(rdmsr(MSR_IA32_PERF_CAPABILITIES) & PERF_CAP_PERF_METRICS) ||
+	    !this_pmu_has(X86_PMU_FEATURE_TOPDOWN_SLOTS_FIXED))
 		return;
 
 	wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
-- 
2.55.0

