Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929840;
	b=jPfuCxlFGJQpY7BC5b4TxnRZDY7uMm9BuZMP+MKnVwOMIpTIjKCq9/3DJ5b4ptvsyxfY
	 gmHWwmXX5yhp48syr/2UKClczU71vegX96my9Tt4UkR6b9ZyKGkgOxnRMDWgIX4jEyLJW
	 oPpqcBPBWyo+Dwd80sDFAeboPaV/DxijwyGrLEU1xZu+o9NOIaLmeqjNccDnSuBnBz+Oe
	 p/IyvVNgLVJx+jQ6OULN56zpvUDoa1UV5xDwBc6M8wEAQdTZ9cAylzI6eB53FO4+xwhq6
	 p4vEgcmEZvln8knQ1wMNZzHMeVag19rL2cDBuvLPKchUpRc3RG0nFlWP7swKQDqMFWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929840;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uXYpeHGRn7wQ7xsspYNmdUVAUinAM2aQKpQNWI4nncA=;
	b=DZE1sjk0K0UNRuSMLea4mOUvKZvwd3w0ZqpSeNGGbricM8eaCy67vDSE/PaE4pyrFgBr
	 pLeXN3+syfhnFDZfSzm5YMk24P7Uy6v7w9lbHanpV/Ntu2w5RSSI6JadmgADpml6MVEuo
	 CWlYgohUd60IQSKFNbUIIYJDdrZWFESscKBbriA5XdbT7JFyjKdUTKPvuZN0jBrvEstih
	 ofjOSaVjHwNiu+y++uZgyE5NcOvSJbXW7iJczuFpjyXz42C2cniwM1Mv+LhF9GR7NPc5F
	 fI5APPAbl51XoEGI7zhwGamQ7VX8sRKvTL5JC5qZuzvPYljBvsSOfKCi7SS404nBeFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kW2nNGhF;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10921606A33D;
	Fri,  6 Nov 2026 01:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10921606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kW2nNGhF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793929839; x=1825465839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vlkUYFwGZv6L9tsESpFICo5n6dVHLA8uPTAuP4zASjk=;
  b=kW2nNGhFZZlp0q1FYf7IF+wHmN1U8qcqYMgrHtfgFwUbKtZr4tRJomNC
   KLqmONTQ60gat9oZIB+FwWVId7NoTs78iq5irSYEUt8s8PrHtKsfj+Z6G
   R4W+o6GRsLsFcHSMEp7+A2qo2SFJzx0g9ezyF1eYA/0SqlQc+tJmrZFda
   uN2UWWtC0ZakUBXcyLnzp6nxQNrq8IKnILhaYUSsFjFcF1xOTI9ezULDl
   LVKAPH6svZKmNMW7mmGGPcpuGGAj06lLhEWmVXF6LlP1oTm4wnaqk2uJK
   WDbzbiPBC4FFTiAFYk+x65iHzZ6DnmI4ibjW7muZ0ezrX8WXSL6ig3o1E
   A==;
X-CSE-ConnectionGUID: Di2ABCJpQLGjqd6xxnzTCA==
X-CSE-MsgGUID: NKpDmI1fRpWaW/iCbOIxZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740190"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2740190"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:32 -0800
X-CSE-ConnectionGUID: G1adTv1WQ5OV2/Fq+b4LnA==
X-CSE-MsgGUID: p1dFLbBjQEqkwDungYJxQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067203"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:31 -0800
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
Subject: [PATCH v3 13/18] KVM: x86/pmu: Populate CPUID.0AH:ECX fixed-counter bitmap
Date: Thu,  5 Nov 2026 18:39:22 -0700
Message-ID: <20261106013927.166209-14-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106013927.166209-1-zide.chen@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
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

PerfMon v5 adds a fixed-counter support bitmap in CPUID.0AH:ECX.
This is the superset of EDX[4:0] which indicates the contiguous
counters starting from 0. For backward compatibility, it's recommended
to use the following to determine if a fixed counter is supported:

FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i);

Originally-by: Yang Weijiang <weijiang.yang@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3:
- Remove '&' when populating entry->ecx. (Jim)
- Gate entry->ecx on kvm_pmu_cap.version >= 5 in intel_pmu_refresh() to
  avoid enabling v5 fixed counters on hosts where KVM caps PMU at v2.
---
 arch/x86/kvm/cpuid.c         | 5 ++++-
 arch/x86/kvm/vmx/pmu_intel.c | 8 ++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 3310c370c5fa..00a2ca6d3049 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1554,7 +1554,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 
 		entry->eax = eax.full;
 		entry->ebx = kvm_pmu_cap.events_mask;
-		entry->ecx = 0;
+		if (kvm_pmu_cap.version >= 5)
+			entry->ecx = (u32)kvm_pmu_cap.fixed_cntr_mask64;
+		else
+			entry->ecx = 0;
 		entry->edx = edx.full;
 		break;
 	}
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 1372091dc1f8..37b34b588601 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -597,7 +597,15 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 				  find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
 						      KVM_MAX_NR_FIXED_COUNTERS));
 
+	/* FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i) */
 	fixed_mask = BIT_ULL(nr_fixed_counters) - 1;
+	/*
+	 * Do not enable fixed counters via the v5 ECX bitmap if KVM caps
+	 * PMU version below 5 (e.g. when mediated PMU is disabled or on
+	 * older hosts), matching KVM's advertised CPUID.0AH:ECX capability.
+	 */
+	if (kvm_pmu_cap.version >= 5 && pmu->version >= 5)
+		fixed_mask |= entry->ecx;
 	fixed_mask &= kvm_pmu_cap.fixed_cntr_mask64;
 
 	/*
-- 
2.56.0

