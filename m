Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3C13D904C;
	Mon, 27 Jul 2026 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180735; cv=none; b=StFk3bWkNDNZgfhBdDdhbVoAqCr2bHoJvTtEMKP0w44PjfMoXH+Mk8MN4Vz3GMSzpjx4D+yLpNADLcwxyc+J3ON5nOCb5HKW8g6Y/Fm705J/E7Qaemt5dK19cNzFs+rQgpdVkdG4HZGIzMY/GWmOIfe+MN9Fbvs09XdZrhj4tck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180735; c=relaxed/simple;
	bh=8PSNssSl8BeHCUJatNvAVEZK6YAPJDlmAUyjbnq4EUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAVjZgama4oIlfL5rPVs0vDyZqh3VsJjETtj7RqUuWLjtybz5Gxcm2nH8/72aVMwAlQbW1mcrXObi2iQQ2n2Vmo+VwrhfYoXXnRbA29ZV+8Jzaa3t65wRWRrM9fvwywDIuWymAABhkpAhiPFYVlYkB/VK4KfaTDDe6bA0eiseJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPt+S+/+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPt+S+/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785180732; x=1816716732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8PSNssSl8BeHCUJatNvAVEZK6YAPJDlmAUyjbnq4EUU=;
  b=aPt+S+/+X5EReLRf/WvaEcV/f4h5CGDXkotqHKrWiKsR+F4cNtZ8Xyz9
   jQcekEG+4pDe34kl2d9aA7coumW3ChxhvaXlhfFFT/qXk8mKtWDCV+vx+
   h9YM/f6Oxny7kxMSsrKco4KZZTU2RTb/6zBsToPQG9S6dWkviVFTRrHE4
   wO2PE0RdTTuf1gtLIhUs+Cn7n2yTlgeyI06QYcpDHwrbe9UDPCOHt2W1y
   8CxmW7N4WW57cavyDr9l3MGZfc+muhElQ1MKzsfDAlwo2nNMMzlmvrzjE
   U7YDQMe+eUp/D2QAvk9oZX8u2XGyTsoOO0JofTHkoP0zY1eFXppONKdoE
   A==;
X-CSE-ConnectionGUID: S/Q+ThRYQZGTe9O3COG6WQ==
X-CSE-MsgGUID: 7t1h6r8yRhOMBdkNQXIIvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85876722"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="85876722"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 12:32:00 -0700
X-CSE-ConnectionGUID: ZfZvvRrZSli7gVDuv72J5w==
X-CSE-MsgGUID: +rIiNU0vRv6uuhG3yBHDKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="289451050"
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
Subject: [PATCH v7 8/9] KVM: x86/pmu: Emulate RDPMC on performance metrics
Date: Mon, 27 Jul 2026 12:21:30 -0700
Message-ID: <20260727192131.582105-9-zide.chen@intel.com>
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

If the host has the PERF_METRICS capability but it's not present on
the guest, RDPMC interception must be enabled and KVM should inject
an #GP when the guest attempts a PERF_METRICS RDPMC.

If the guest has PERF_METRICS but RDPMC interception is enabled for
other reasons, KVM needs to emulate RDPMC with type 0x2000.

For simplicity, Metrics Clear Mode is not supported.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
index 092809bd757d..69dc95a139d9 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -822,6 +822,12 @@ bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
 
+static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
+{
+	return (kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS) &&
+		!kvm_vcpu_has_perf_metrics(vcpu);
+}
+
 static bool kvm_rdpmc_encoding_supported(void)
 {
 	/* KVM understands all RDPMC encodings prior to PMU v6. */
@@ -851,6 +857,7 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
 		return true;
 
 	return kvm_need_any_pmc_intercept(vcpu) ||
+	       kvm_need_perf_metrics_intercept(vcpu) ||
 	       pmu->counter_bitmask[KVM_PMC_GP] != (BIT_ULL(kvm_host_pmu.bit_width_gp) - 1) ||
 	       pmu->counter_bitmask[KVM_PMC_FIXED] != (BIT_ULL(kvm_host_pmu.bit_width_fixed) - 1);
 }
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 8e991da08b24..52e0e67f6a59 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -31,6 +31,7 @@
  */
 #define INTEL_RDPMC_GP		0
 #define INTEL_RDPMC_FIXED	INTEL_PMC_FIXED_RDPMC_BASE
+#define INTEL_RDPMC_METRICS	INTEL_PMC_FIXED_RDPMC_METRICS
 
 #define INTEL_RDPMC_TYPE_MASK	GENMASK(31, 16)
 #define INTEL_RDPMC_INDEX_MASK	GENMASK(15, 0)
@@ -125,6 +126,19 @@ static int intel_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx,
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

