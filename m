Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E4543F4D0;
	Tue,  7 Jul 2026 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449859; cv=none; b=snXx3R9dpRKaKvf5wclxppFIhb3v9Az+RJGU7G35qFeQcuofl0KDN7WlawcICxaruUDTroixFf5I7S/WLhfs97MQPvZXIYguu3IAqit4lPRkb1YDDdQqaO6mvWhvbww7C5uDNh3XjlvHFS6qgRTRGS7+DL23MbRVYpBnWM0vtaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449859; c=relaxed/simple;
	bh=DfZPyZ9PstV/xhOs3EW+Rhps2MeGNRujMtEuOtfmAgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpzX0FAVsma6ff5ds2+pO7/T6sNIVjcnlY06aEbyCBkunUQgFKgXTOVp4yLjhF47ZB1VfX9+6vqOJD0vtHI96DQ6bDEcpDYSrJWYUWcOcKrSTmT91nLTBMjnx2mRoEJz3GEM1RcrZTYD0UgR2ThsuFDOSDsy3Mdqrl1K1Z6yNLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nP2WUjPk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nP2WUjPk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783449856; x=1814985856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DfZPyZ9PstV/xhOs3EW+Rhps2MeGNRujMtEuOtfmAgc=;
  b=nP2WUjPk/SI8jrWp5VozGGc6sfWnMMGruQzCXu1oCfG+4Yb0xxkS7pVn
   DJTzAx/ZO0eEn/rZrYpLg91R9+u+H6mhMlsbFni/GTRCOi362E6InIrK5
   Wgy5tTb6WikAqITjSd8YTv4omLJwXS0R8LS7wXnat53MF6xarjTC3HGyo
   TrFYbCU8qrmvcKOWqMQVDNYsrChLQfgoaQtqkeGjPHCfqxYRNW4gcUHZt
   wVeEKlNF5xfBnw68Bvl2vrS12VuCrP3TlZqFWQ/eiOmaFh1YjhwrwqOzs
   Dyq2iwa8qFgNSgbjAJT+nyl8mzZcRtyLHlMOluVYIvfmgCJ5Q3JGu0dt4
   A==;
X-CSE-ConnectionGUID: hfU6WStjQ1OzqH+XzUKZ+w==
X-CSE-MsgGUID: 8xmHOB/yQ5GKOb8nQkzXHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94713902"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94713902"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:44:00 -0700
X-CSE-ConnectionGUID: U3NC78utRy2Lnq/PxnompQ==
X-CSE-MsgGUID: H1hv1zMtSgKQbMrcJbvwKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277279338"
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
	Xudong Hao <xudong.hao@intel.com>,
	Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH 12/15] KVM: x86/pmu: Populate CPUID.0AH:ECX fixed-counter bitmap
Date: Tue,  7 Jul 2026 11:34:02 -0700
Message-ID: <20260707183405.15571-13-zide.chen@intel.com>
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

PerfMon v5 adds a fixed-counter support bitmap in CPUID.0AH:ECX.
This is the superset of EDX[4:0] which indicates the contiguous
counters starting from 0. For backward compatibility, it's recommended
to use the following to determine if a fixed counter is supported:

FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i);

Originally-by: Yang Weijiang <weijiang.yang@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/kvm/cpuid.c         | 5 ++++-
 arch/x86/kvm/vmx/pmu_intel.c | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 151a4794f834..ae6176fb0a93 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1533,7 +1533,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 
 		entry->eax = eax.full;
 		entry->ebx = kvm_pmu_cap.events_mask;
-		entry->ecx = 0;
+		if (kvm_pmu_cap.version > 4)
+			entry->ecx &= (u32)kvm_pmu_cap.fixed_cntr_mask64;
+		else
+			entry->ecx = 0;
 		entry->edx = edx.full;
 		break;
 	}
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 556c119d5e91..3f41e4916986 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -613,7 +613,10 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 				      kvm_pmu_cap.events_mask_len);
 	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
 
+	/* FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i) */
 	fixed_cntr_mask = BIT_ULL(edx.split.num_counters_fixed) - 1;
+	if (pmu->version > 4)
+		fixed_cntr_mask |= entry->ecx;
 	fixed_cntr_mask &= kvm_pmu_cap.fixed_cntr_mask64;
 
 	/*
-- 
2.54.0

