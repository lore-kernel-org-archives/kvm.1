Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD403B5306;
	Thu, 27 Aug 2026 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870890; cv=none; b=n2MJANRxJykVpo0manY8IY4D+h8o2ZFc3/vevHAWHM/eOn9GjnHeqQ903HiljOoydPYnT42RrIBL6c5qoi4e11AYymu/ff0EmHhEVO4OsPk8H63VAUlfEdOklSnDyuyIXxwWnaQAT4YyByMdwKvVsZzC0ZfpRwRNovq2r3POnHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870890; c=relaxed/simple;
	bh=HW5GyvSjxr7uHRNVIlhXAqmoy/8uLfJUH95draD6xkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnlCp/LoKe/HW3e89kCeGzPigJSZ6o0Ph4ttMN38CupL3EDsL2bmCH56n71YB0BypH5UWypkLOqD2rLsRlvJdjkKJyjiw9aMUv50ChBPFNOg57TkT1W8CyLr3iZyR/C6S2nhYHBtH8VEQWAwT7IGaWmUDJyI9vR6sj8cWBn8l/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uy15L4qb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uy15L4qb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787870889; x=1819406889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HW5GyvSjxr7uHRNVIlhXAqmoy/8uLfJUH95draD6xkQ=;
  b=Uy15L4qb5N94A34QzeGOkLxGC5J/mX0s2eRuIUKT1yVxt+jR/6hqwiIz
   3mjXmir+mBoEblK9TW//KhEyFxG0TfMSDlRSnTlhoobZL5mGjFmUm3dL7
   uU7reesPg4seskwA1wmHigThhPJBNWB8fGL6Ka4t53CzDASWSRtPvxl2k
   FIRgZdezi+7KIruM0Sq0gBgF4edDE8tHaMCA8x1uANggsxjqGWHPq2WN7
   krrxUv5ocncR43OfIHQyTZtL7rwduG/y9IOjLFYq3uXn7elPNqlN5k2uh
   ny6ZzdIjJC8kl7rgNX9kcZMKQzR1L/tx0NIJgyLmrizYWjWl9YAnssEQo
   g==;
X-CSE-ConnectionGUID: uUXTbxIWRdiQ2FPAtbVx7g==
X-CSE-MsgGUID: m6H2dxWpSTG41Il6KdFKbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113914843"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="113914843"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:07 -0700
X-CSE-ConnectionGUID: ChZrm5ZoTjy+i5c+VS803Q==
X-CSE-MsgGUID: Ixxdlu/STkqK6Q/A4qatfA==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:06 -0700
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
Subject: [PATCH v2 04/16] KVM: x86/pmu: Gate BUFFER_OVF reserved bit on guest DS
Date: Thu, 27 Aug 2026 15:37:43 -0700
Message-ID: <20260827223755.143247-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827223755.143247-1-zide.chen@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

global_status_rsvd unconditionally clears GLOBAL_STATUS_BUFFER_OVF
(bit 62), even when the guest does not have X86_FEATURE_DS feature.
Clear it only when guest_cpu_cap_has(vcpu, X86_FEATURE_DS), matching
hardware behavior.

Fixes: f5132b01386b ("KVM: Expose a version 2 architectural PMU to a guests")
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v2: new patch.
---
 arch/x86/kvm/vmx/pmu_intel.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 11c9161dc853..9fdae437e569 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -576,8 +576,16 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
 	pmu->global_ctrl_rsvd = counter_rsvd;
 
-	pmu->global_status_rsvd = pmu->global_ctrl_rsvd
-			& ~(GLOBAL_STATUS_BUFFER_OVF | GLOBAL_STATUS_COND_CHG);
+	/*
+	 * Layout of bits 48:0 in IA32_PERF_GLOBAL_CTRL is identical to
+	 * IA32_PERF_GLOBAL_STATUS, but IA32_PERF_GLOBAL_STATUS has additional
+	 * bits.
+	 */
+	pmu->global_status_rsvd = pmu->global_ctrl_rsvd;
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_DS))
+		pmu->global_status_rsvd &= ~GLOBAL_STATUS_BUFFER_OVF;
+	pmu->global_status_rsvd &= ~GLOBAL_STATUS_COND_CHG;
+
 	if (vmx_pt_mode_is_host_guest())
 		pmu->global_status_rsvd &= ~GLOBAL_STATUS_TRACE_TOPAPMI;
 
-- 
2.55.0

