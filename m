Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E003CFF50;
	Mon, 29 Jun 2026 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782775745; cv=none; b=BEFAOQMv6Y5V8G/xdEAdkUZjfOplUD/hhtan3KWJGXXSSKSyNh5tSjfqjq7aZBf0dJY42ss1d3B0z7r4OqxmovjJeRoZ37R4xrdcOmcsl0xxc/oEfq2QH6VhaG45zbI9IDrSdNxXOYGBZmEyMEUFrKAy80GuqyxqNNkJKPCWfo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782775745; c=relaxed/simple;
	bh=70BiO6Je+x3B5kCMzOJGSRUYR0djZy793+zrXdScM0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBM6YdCo8a6Www5VCIvRzQ1oR3ykR84KAyjNWTU4OHPzkQSXkC+i9QI3uTHsuvExHnzkrDKWjsM3z020Y/PzsL21yA12mcymPCPrl7ZvrEIqNCEBCCyv3+ImgGbTXV78cHXJr4EYWjR+EuNiYrgdWU5TpavgFFiqyunQVS29oi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivqRmQZo; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivqRmQZo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782775736; x=1814311736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=70BiO6Je+x3B5kCMzOJGSRUYR0djZy793+zrXdScM0M=;
  b=ivqRmQZoDON75BdlQg79ymceup4fMgMlr2nxIL2XgiRmJlN8FUTEyzDS
   q6QvfDnmP8LHUQWdUdslTKpD6XXopuGczlalmz1WxWXrxCARBC+PoWsaO
   eHcOZWaGRe4xucDAKqb5VAJVZHrQA5cb1NhG+n23CUo2SZcFZdG4NFHwI
   FThqQR31sn1gmUkX+gM7egHkkbC08t3+W54Ihn48sEim1no5U6rBhJkoQ
   6f9SyjSksmjy0p5/n1vJfHbQpf6VYanKDO0u5gk5t+p10gjPIXcH63KVO
   6kybUVkVbgroAQCbg47dau4AdGPXONCekXx/aOc+waR6YvmYIHHJgNIf0
   Q==;
X-CSE-ConnectionGUID: UXuOBZ9qTEW1S4IX/ZL4gQ==
X-CSE-MsgGUID: FpoMEKn8TJyX9Kb09WBNLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82593511"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="82593511"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 16:28:44 -0700
X-CSE-ConnectionGUID: tVs0ezNjTTicVKkyvyIXkQ==
X-CSE-MsgGUID: ZkdTnCKlS4WSKVCdviIftQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="290220147"
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
Subject: [PATCH v6 7/8] KVM: x86/pmu: Emulate RDPMC on performance metrics
Date: Mon, 29 Jun 2026 16:19:36 -0700
Message-ID: <20260629231938.15129-8-zide.chen@intel.com>
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

If the host has the PERF_METRICS capability but it's not present on
the guest, RDPMC interception must be enabled and KVM should inject
an #GP when the guest attempts a PERF_METRICS RDPMC.

If the guest has PERF_METRICS but RDPMC interception is enabled for
other reasons, KVM needs to emulate RDPMC with type 2000H.

For simplicity, Metrics Clear Mode is not supported.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v6:
- Merge kvm_pmu_rdpmc_metrics() into intel_emulate_rdpmc().
- Reject non-zero index.
v5:
- new patch.
---
 arch/x86/kvm/pmu.c           |  7 +++++++
 arch/x86/kvm/vmx/pmu_intel.c | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 8ef2d4761790..04b9c840f218 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -806,6 +806,12 @@ bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
 
+static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
+{
+	return (kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS) &&
+		!kvm_vcpu_has_perf_metrics(vcpu);
+}
+
 bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -818,6 +824,7 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
 		return true;
 
 	return kvm_need_any_pmc_intercept(vcpu) ||
+	       kvm_need_perf_metrics_intercept(vcpu) ||
 	       pmu->counter_bitmask[KVM_PMC_GP] != (BIT_ULL(kvm_host_pmu.bit_width_gp) - 1) ||
 	       pmu->counter_bitmask[KVM_PMC_FIXED] != (BIT_ULL(kvm_host_pmu.bit_width_fixed) - 1);
 }
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 080677372c9b..93b5a8360377 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -30,6 +30,7 @@
  */
 #define INTEL_RDPMC_GP		0
 #define INTEL_RDPMC_FIXED	INTEL_PMC_FIXED_RDPMC_BASE
+#define INTEL_RDPMC_METRICS	INTEL_PMC_FIXED_RDPMC_METRICS
 
 #define INTEL_RDPMC_TYPE_MASK	GENMASK(31, 16)
 #define INTEL_RDPMC_INDEX_MASK	GENMASK(15, 0)
@@ -124,6 +125,19 @@ static int intel_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx,
 		counters = pmu->gp_counters;
 		num_counters = pmu->nr_arch_gp_counters;
 		break;
+	case INTEL_RDPMC_METRICS:
+		if (!kvm_vcpu_has_perf_metrics(vcpu))
+			return 1;
+
+		/*
+		 * The index in ECX[15:0] is implementation specific, but no
+		 * platform currently supports a non-zero index.
+		 */
+		if (idx)
+			return 1;
+
+		*data = pmu->perf_metrics;
+		return 0;
 	default:
 		return 1;
 	}
-- 
2.54.0

