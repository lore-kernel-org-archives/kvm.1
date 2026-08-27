Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3483EC6A8;
	Thu, 27 Aug 2026 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870899; cv=none; b=Ho4wV8KgXEYYu0Ttxu1Z+EHyM1G70QFL+/o7tetNvM+jwQP1T5JunPL9P7rVOAQFULR4ERSRcA/QntaGSgDFDR74LXGV5OlXN+sc8NXJ8a9I+/Eqy04GVcsIDOAFtqcwhycJFGL4bvKVQamANTtIwPg2f2GOA92yigQyeLMlTzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870899; c=relaxed/simple;
	bh=cbwhMbiNXnhJwK4d0wZATxl2UZxV+zXxGFUqJiZDN1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGuKqyDOBhGCbY1LM/0zX6KL3oO7iciKox0luMJqKq60auvIt3kyXp8TiPgJZQIkeNZ64yknbdBzkiOU0z3TZjVbBot8r+dYzz/XXBl4ZmQYa7HipVXo7I3yPUxxsE6kGReY7ekfy3QkvEHJnyPO+K69oEnpbk24m9gfJ16buGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fbx3TMtH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fbx3TMtH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787870897; x=1819406897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cbwhMbiNXnhJwK4d0wZATxl2UZxV+zXxGFUqJiZDN1Q=;
  b=Fbx3TMtHrTGWYJ6yLW3Kb5qkZkiB01opTYTk8sgEDbsqPdRSDvtqZ6dS
   nrpOsJNH5nJAuqglOAWUGQ9juxkyVV/0S/ocD+pABnRB+yBFuiOkKUBle
   99UjGJ3xgWCdoIn6329GqRK8tnHbP8Sy/Ooid+kNmecjNPOQ7pgFE27In
   U7Aj74vOul5XlUNMoV250nCuiSbVCcROAEr+9A7SvKj39uWLoYsc9kOsU
   ppmYOIkA1kNIPKWzxO5IvJzE+eIRFylIEY3A2IIc8uioNQNp5JNDw5ykI
   L2nWljaIiTmAzdor9QKgdqq4LeXHZZ5rSRM1oRKSPZQN8tmBHDCdBhovQ
   w==;
X-CSE-ConnectionGUID: 90EkvnIlRDCW60lNydkJxQ==
X-CSE-MsgGUID: zqaIvz6wR92y6Ly3EUKXVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113914901"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="113914901"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:10 -0700
X-CSE-ConnectionGUID: x9mAtXTOST69SwRg52g8Dg==
X-CSE-MsgGUID: LuR7EEEYSpKhWxtuISnZKw==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:10 -0700
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
Subject: [PATCH v2 15/16] KVM: x86/pmu: Advertise PerfMon version 5 on Intel hosts
Date: Thu, 27 Aug 2026 15:37:54 -0700
Message-ID: <20260827223755.143247-16-zide.chen@intel.com>
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

KVM currently caps the guest PerfMon version at 2 for all Intel
platforms. Now that KVM emulates the basic architectural PMU features
introduced in PerfMon versions 3 through 5, raise the guest PerfMon
version to 5. Features that require additional emulation support, e.g.
architectural LBR will be enabled separately.

PerfMon versions 3 and 4 continue to be exposed as version 2 because
KVM cannot safely virtualize AnyThread due to cross-VM information
leakage. PerfMon v5 is supported because it provides the
AnyThread-deprecated capability, allowing KVM to indicate that
AnyThread is deprecated.

When enable_mediated_pmu is disabled or in the non-Intel paths, KVM
retains the existing cap of version 2.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v2:
- Cap vPMU v3/v4 to v2, as AnyThread cannot be safely virtualized.
  (Sashiko)
---
 arch/x86/kvm/pmu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 4cb7c796daac..1a7be7d73b62 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -175,7 +175,21 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
 	}
 
 	memcpy(&kvm_pmu_cap, &kvm_host_pmu, sizeof(kvm_host_pmu));
-	kvm_pmu_cap.version = min(kvm_pmu_cap.version, 2);
+
+	if (is_intel && enable_mediated_pmu) {
+		kvm_pmu_cap.version = min(kvm_pmu_cap.version, 5);
+
+		/*
+		 * PMU v3/v4 has AnyThread support, which KVM cannot safely
+		 * virtualize. Expose PMU v2 instead of advertising a partially
+		 * functional PMU v3/v4 to guests.
+		 */
+		if (kvm_pmu_cap.version == 3 || kvm_pmu_cap.version == 4)
+			kvm_pmu_cap.version = 2;
+	} else {
+		kvm_pmu_cap.version = min(kvm_pmu_cap.version, 2);
+	}
+
 	kvm_pmu_cap.cntr_mask64 &=
 		GENMASK_ULL(pmu_ops->MAX_NR_GP_COUNTERS - 1, 0);
 	kvm_pmu_cap.fixed_cntr_mask64 &=
-- 
2.55.0

