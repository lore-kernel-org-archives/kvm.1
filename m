Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C1F42252E;
	Fri, 21 Aug 2026 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351469; cv=none; b=V+GvowVPGKW/SpcXSfuMAECJQ+b2txSpubNFBlxOE2ptMbO5RHdm3h7Gm/SUnDLxArS2PbK73ZjxLq3yOZRig4ytOokvFcB9nf49M9s0cfNsJazVj7W6HOMd3MuJ0qmZrpIcanKZoIaNmrroRAEANgBmF2CMYVotBSI5ezcNHFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351469; c=relaxed/simple;
	bh=smaM2JfFdybVP0X2e8f8uJOTIFZueGK+ZlvCMfauJEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRDA3s7Pk4shnSzBA1HeQBJsHsbhDLHxjItNgQSU+vvrS2RehsYkiVbtZUnwy19KMuL60oTun7bMKTyiX81iupdzHT6pgYMwSyc7EocmxovNYcdMGK9bEuJOHQuEagotBXeYCClEzN243bHAq6vsvg1wLApDHk2IZDzAIEh6yvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5b+77Ip; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5b+77Ip"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351467; x=1818887467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=smaM2JfFdybVP0X2e8f8uJOTIFZueGK+ZlvCMfauJEs=;
  b=E5b+77IpYWxLHhDdicsBeyTXq50/ctrpkCU8mN18awlBpzKl9DNxVyvS
   DBv429SvpDbUvQp1z+Y6AZWTFmt+Fgmy1Re2l6x6ODQYGsnb8CZOscs0C
   dmp4XqJ0yJ0xRDWWrXBElMrNHXA41P8N/Q+6P2l52XviFqPts3CHPGTMM
   ovdhzLQorXRd2WTJ9t7RyGWbfIrUFvQvUu7Hzbzb1j3uCQZRnKyEJCgtT
   63AgSNtGboSGcGPTVRYgpBea7CND11KhxS1Om9BxMShZMbtYdhrCYXKR3
   Lr7Lj3w3dvj9zcZG6Gb70/hqvLY30KfjaGIcw7cU4iN8W85b8frybi9zK
   Q==;
X-CSE-ConnectionGUID: QrP2tpCUSZuYbP4kBxM+Hw==
X-CSE-MsgGUID: vAzUdQ7fSkS9QmB6SpuURA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032651"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032651"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:52 -0700
X-CSE-ConnectionGUID: w4lwLNSMQ0SXtmQ5hH3/gg==
X-CSE-MsgGUID: Y3O54pfeS4+fN/2Sm1zfMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679800"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:52 -0700
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
Subject: [PATCH 18/23] KVM: x86/pmu: Handle GLOBAL_STATUS MSRs under PerfMon masking
Date: Fri, 21 Aug 2026 15:19:57 -0700
Message-ID: <20260821222002.54907-19-zide.chen@intel.com>
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

For IA32_PERF_GLOBAL_STATUS{,_SET,_RESET}, the effective mask under
PerfMon masking is perfmon_mask. Writes that set bits outside the
effective mask must #GP, so use ~perfmon_mask as the effective
reserved-bit mask instead of global_status_rsvd.

At guest context load, keep host-owned GLOBAL_STATUS bits unchanged
because system-wide events may be scheduled on host-owned resources
while running in VMX non-root mode.

Likewise, at guest context put, preserve host-owned bits and clear
only the guest-owned subset from hardware GLOBAL_STATUS, leaving
pmu->global_status containing only guest-owned bits.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/kvm/pmu.c           | 13 ++++++++-----
 arch/x86/kvm/vmx/pmu_intel.c | 17 ++++++++++++++++-
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index b051ba66edce..23177c38f286 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -922,12 +922,15 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	u32 msr = msr_info->index;
 	u64 data = msr_info->data;
-	u64 diff;
+	u64 global_status_rsvd, diff;
 
 	/*
 	 * Note, AMD ignores writes to reserved bits and read-only PMU MSRs,
 	 * whereas Intel generates #GP on attempts to write reserved/RO MSRs.
 	 */
+	global_status_rsvd = kvm_vcpu_has_perfmon_mask(vcpu) ?
+			     ~pmu->perfmon_mask : pmu->global_status_rsvd;
+
 	switch (msr) {
 	case MSR_CORE_PERF_GLOBAL_STATUS:
 		if (!msr_info->host_initiated)
@@ -938,7 +941,7 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!msr_info->host_initiated)
 			break;
 
-		if (data & pmu->global_status_rsvd)
+		if (data & global_status_rsvd)
 			return 1;
 
 		pmu->global_status = data;
@@ -967,7 +970,7 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		 * GLOBAL_OVF_CTRL, a.k.a. GLOBAL STATUS_RESET, clears bits in
 		 * GLOBAL_STATUS, and so the set of reserved bits is the same.
 		 */
-		if (data & pmu->global_status_rsvd)
+		if (data & global_status_rsvd)
 			return 1;
 		fallthrough;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
@@ -975,14 +978,14 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			pmu->global_status &= ~data;
 		break;
 	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
-		if (data & pmu->global_status_rsvd)
+		if (data & global_status_rsvd)
 			return 1;
 		if (!msr_info->host_initiated)
 			pmu->global_status |= data;
 		break;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 		if (!msr_info->host_initiated)
-			pmu->global_status |= data & ~pmu->global_status_rsvd;
+			pmu->global_status |= data & ~global_status_rsvd;
 		break;
 	default:
 		kvm_pmu_mark_pmc_in_use(vcpu, msr_info->index);
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index d0373de951d5..e43380f79c72 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -968,6 +968,14 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu, u64 host_global_ctrl)
 
 	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
 	toggle = pmu->global_status ^ global_status;
+
+	/*
+	 * Restrict OVF_CTRL/STATUS_SET writes to guest-owned bits under
+	 * PerfMon masking.
+	 */
+	if (kvm_vcpu_has_perfmon_mask(vcpu))
+		toggle &= pmu->perfmon_mask;
+
 	if (global_status & toggle)
 		wrmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, global_status & toggle);
 	if (pmu->global_status & toggle)
@@ -984,7 +992,14 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
 	/* MSR_CORE_PERF_GLOBAL_CTRL is already saved at VM-exit. */
 	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, pmu->global_status);
 
-	/* Clear hardware MSR_CORE_PERF_GLOBAL_STATUS MSR, if non-zero. */
+	/*
+	 * Clear only the guest-owned bits from the hardware GLOBAL_STATUS
+	 * if any are set. pmu->global_status is then left holding just the
+	 * guest-owned subset.
+	 */
+	if (kvm_vcpu_has_perfmon_mask(vcpu))
+		pmu->global_status &= pmu->perfmon_mask;
+
 	if (pmu->global_status)
 		wrmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, pmu->global_status);
 
-- 
2.55.0

