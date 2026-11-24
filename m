Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557211;
	b=nIV15UxS9RXwlvY6CQtvAmdxK+UREN2ZSFqrk92vxgr9dEHKDlloduoVID9vvWGPFEs0
	 omvcw+9cO/AXaf8K7O3ELwmg20vv7LnrR9pkx8s9ax9PPaiiUmQna1lxlTtQlO5n3IZWs
	 eaPVESSbpOL7HoeULCDpQN8qqydIxXePS3XCHIJZa2TVSHSrOD+hGQiyV46/H8I+v/R4F
	 TnrB26wwOeFC2fv3IrvSKK0pr6svuoG+8pkh1qb4J2SfTc/Kn8KKkSOJVdK0OVwSQFyp6
	 dCECZLiPahPbd1DUPJ86/hOtbyCnmFZ0pec88rr9L8GpdYXlSwwy1/X5z8p1WBMAw8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557211;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SgwyB4v1x91FfXTzW/7cJXmTaEh5EnMrlH3ku+wNQa8=;
	b=rNhGnQCLLNmvkVCWe1V3VH9KqpCF/WiP9H+9Un60ddbWF5qrP9QNX8xKVim9O9EfFKOH
	 HEDIvrAqURd9x3juxDtBovQeABoAv1T6uuEa0g24QlpTiuzjRVN5TLEWIaKX5xo03+Rdm
	 3iv0Q7fQJ/697pwpliv5J2FRAdvkfuOKqUfsMBquyWoj95ShPJ7RoyZ96S7o6gReQfjbE
	 iZkC45fLLDteDYoKZz7VxQBh7z0j4Hg7MEuDFlSMI2AYVe2fSt62cDw500VUErC2qCByC
	 ZjP1z82kIccrBZr6+BtkMS6VsOFCbLsC87nKoY4TeMFvKuHtdfQJAxlpwc2+6kF51fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KOUAMKUs;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864960A380D;
	Tue, 24 Nov 2026 21:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3864960A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KOUAMKUs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557211; x=1827093211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EG4H+f7+ZAL5E7ep3NCuNtNknqsymVrxnq3FYZS6uOc=;
  b=KOUAMKUsKGR3Ufukf1ySsLpWo3VsduLXkCxyUgWN0YEN4wNzQ8nAyjAh
   zcane63MX6hzBMRwrZ4rtpn8FqrtDg9Hv4VU8h430QRHfj8YoBYbirJOd
   xyojS5Pq/Xe0F2Zw41KDuHg89BbSLaLRSrlPsuqnTN7X+wozrMuY4BxRV
   W/p2Ozxj98NtvCoMBQljIyDLuUdzPoNhHd0a4O4NYlhprGGbec5UFMlKB
   Suhh3R7PLmuxxNJl4VLp2idibbAMGHfzNv+N9yQwK5G8bzQ4FDMhXOjuy
   mjmxBhLkkEIcVIV6xH2ZftICTsnrMXwb+AF6O2x5P2Yu16sYON9FdZnPN
   w==;
X-CSE-ConnectionGUID: GGZr+/qORnaQx7dwCZyhTA==
X-CSE-MsgGUID: smqfjGmhRRSxIHjACMvM4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4306063"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4306063"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:30 -0800
X-CSE-ConnectionGUID: zGWOF+dCRV6GB8M/wnrg0g==
X-CSE-MsgGUID: GqNwysBWRpWy4x3hJh+M6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271945"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:29 -0800
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v10 13/18] KVM: x86/pmu: Emulate RDPMC on performance metrics
Date: Tue, 24 Nov 2026 14:38:56 -0700
Message-ID: <20261124213901.120572-14-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124213901.120572-1-zide.chen@intel.com>
References: <20261124213901.120572-1-zide.chen@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the host has the PERF_METRICS capability but it is not present on
the guest, RDPMC interception must be enabled and KVM should inject
a #GP when the guest attempts a PERF_METRICS RDPMC.

If the guest has PERF_METRICS but RDPMC interception is enabled for
other reasons, KVM needs to emulate RDPMC with type INTEL_RDPMC_METRICS.

Add perf_metrics to struct kvm_pmu to store the guest's metrics value.
RDPMC reads will return 0 until MSR_PERF_METRICS is virtualized and
context switched.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
v10:
- Drop kvm_need_rdpmc_intercept() hunk as it's included in previous
  patch already after patch re-order.
- Updated comments to mention Topdown metric type is not rejected.
v9:
- Remove references to Metrics Clear from the changelog.
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/vmx/pmu_intel.c    | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index aad835338759..1261f8302dc8 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -583,6 +583,7 @@ struct kvm_pmu {
 	u64 global_status_rsvd;
 	u64 reserved_bits;
 	u64 raw_event_mask;
+	u64 perf_metrics;
 	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
 	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
 
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 858737504ec1..cb7db4784545 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -31,6 +31,7 @@
  */
 #define INTEL_RDPMC_GP		0
 #define INTEL_RDPMC_FIXED	INTEL_PMC_FIXED_RDPMC_BASE
+#define INTEL_RDPMC_METRICS	INTEL_PMC_FIXED_RDPMC_METRICS
 
 #define INTEL_RDPMC_TYPE_MASK	GENMASK(31, 16)
 #define INTEL_RDPMC_INDEX_MASK	GENMASK(15, 0)
@@ -113,8 +114,10 @@ static int intel_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx,
 	 * are supported on all architectural PMUs, i.e. on all virtual PMUs
 	 * supported by KVM.  Note, KVM only emulates fixed PMCs for PMU v2+,
 	 * but the type itself is still valid, i.e. let RDPMC fail due to
-	 * accessing a non-existent counter.  Reject attempts to read all other
-	 * types, which are unknown/unsupported.
+	 * accessing a non-existent counter.
+	 *
+	 * Topdown metrics are supported only when the guest has PERF_METRICS.
+	 * Reject attempts to read all other types, which are unknown/unsupported.
 	 */
 	switch (type) {
 	case INTEL_RDPMC_FIXED:
@@ -125,6 +128,19 @@ static int intel_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx,
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
2.56.1

