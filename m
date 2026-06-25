Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD02FFDEA;
	Thu, 25 Jun 2026 03:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782359698; cv=none; b=mrfBrnJIKtL0Fgg8MqtNtiJHoKWEcqr/66BxJGuhQqR5Xn02BLgC9b6gTGHdYKqPg1dTBEW7CnV8xjRLRO3QpL6ziPASnt27RwLV2f8OdeRFhcGo3DI4xM47Mo2K2xoVpfUE50vA/6kWgq3pPwUBUPUCHRCP3YjEQuxLP4aXnEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782359698; c=relaxed/simple;
	bh=SMCu47D0vFf1Wxs3XkgTPC4e0KbfXLxQj8QZCh/NcCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lc7y5vBlB3RKcuNBQ2ABRnLjeNbWrV7gxIZ4LB35w6tkcmsCC1XnZR4Y6g6PWzB8JLzU2feSWNLS6XsVTp1mCca8/wtW98Dct/hI6c/8twL8nAo5oodbR/IyOIdZS97QeDK4dZtvQj1WnMNK9BrE+k7W/l7U7CAwQ09gbIA1pAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikxzWmrd; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikxzWmrd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782359698; x=1813895698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SMCu47D0vFf1Wxs3XkgTPC4e0KbfXLxQj8QZCh/NcCI=;
  b=ikxzWmrdQRdpBxmqVBnGE0WPge+NbbnvX/E3xB1ln/3jh/IiMZZhzJMa
   7UU+Uv91WervgdeCFVoJR4lxOnE8AMnDBs8y4pA3nJvLBNdqa3HymNMw7
   1EV2E89ZEhk0/fZaDnEkcImN7XCSkbxAHaS+X4O/mlG5xNAeJbve/Kowp
   fzuBFpoBksZr/UbIPeWXz0PHYENEruqtYLfrhJGEJPH1TFH42yejaujOQ
   gMyVctrNqGBm2ThwQn7CEW431MSYHE+GQbDGbGbNCXTUjiFetQI8Tn8WY
   yFcpOFBW/1uE9eDUcaP+GzKRyzkwUoJHFq/WonPmBTFQkC4J8n/9Qn1en
   w==;
X-CSE-ConnectionGUID: YDKhPPW/TmOtqZkwqmhqLA==
X-CSE-MsgGUID: AEzQ7NkrTcGRI/1FuP05pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82901469"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="82901469"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 20:54:53 -0700
X-CSE-ConnectionGUID: 7g51sHoRTq2B0ugAqGBbsQ==
X-CSE-MsgGUID: Lz09Vj7PTJitrGR3Pbw/XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="288396630"
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
Subject: [PATCH V5 6/7] KVM: x86/pmu: Emulate RDPMC on performance metrics
Date: Wed, 24 Jun 2026 20:45:54 -0700
Message-ID: <20260625034555.141453-7-zide.chen@intel.com>
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

If the host has the PERF_METRICS capability but it's not present on
the guest, RDPMC interception must be enabled and KVM should inject
an #GP when the guest attempts to read it.

If the guest has PERF_METRICS, but RDPMC interception is enabled for
other reasons, KVM needs to emulate RDPMC with type 2000H.

For simplicity, Metrics Clear Mode is not supported.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v5: new patch.
---
 arch/x86/kvm/pmu.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 7aafc5db1346..af5b14f44e4b 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -755,6 +755,16 @@ static int kvm_pmu_rdpmc_vmware(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 	return 0;
 }
 
+static int kvm_pmu_rdpmc_metrics(struct kvm_vcpu *vcpu,
+				 unsigned idx, u64 *data)
+{
+	if (!kvm_vcpu_has_perf_metrics(vcpu))
+		return 1;
+
+	*data = vcpu_to_pmu(vcpu)->perf_metrics;
+	return 0;
+}
+
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -767,15 +777,18 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 	if (is_vmware_backdoor_pmc(idx))
 		return kvm_pmu_rdpmc_vmware(vcpu, idx, data);
 
-	pmc = kvm_pmu_call(rdpmc_ecx_to_pmc)(vcpu, idx, &mask);
-	if (!pmc)
-		return 1;
-
 	if (!kvm_is_cr4_bit_set(vcpu, X86_CR4_PCE) &&
 	    (kvm_x86_call(get_cpl)(vcpu) != 0) &&
 	    kvm_is_cr0_bit_set(vcpu, X86_CR0_PE))
 		return 1;
 
+	if (idx & INTEL_PMC_FIXED_RDPMC_METRICS)
+		return kvm_pmu_rdpmc_metrics(vcpu, idx, data);
+
+	pmc = kvm_pmu_call(rdpmc_ecx_to_pmc)(vcpu, idx, &mask);
+	if (!pmc)
+		return 1;
+
 	*data = pmc_read_counter(pmc) & mask;
 	return 0;
 }
@@ -803,6 +816,14 @@ bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
 
+static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
+{
+	if (!(kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS))
+		return false;
+
+	return !kvm_vcpu_has_perf_metrics(vcpu);
+}
+
 bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -815,6 +836,7 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
 		return true;
 
 	return kvm_need_any_pmc_intercept(vcpu) ||
+	       kvm_need_perf_metrics_intercept(vcpu) ||
 	       pmu->counter_bitmask[KVM_PMC_GP] != (BIT_ULL(kvm_host_pmu.bit_width_gp) - 1) ||
 	       pmu->counter_bitmask[KVM_PMC_FIXED] != (BIT_ULL(kvm_host_pmu.bit_width_fixed) - 1);
 }
-- 
2.54.0

