Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4013E315C;
	Thu, 27 Aug 2026 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870897; cv=none; b=PcLVrvdsvxp9QZjbHagqGGzLEmiNenpYCnI/qqco9mP3AVQGQjJ6FHUCfdd2zOSAnUqjg3d8FLyNyD2A70bk9qjDOkKXZkk1NQmgKdtAMzIdhrTdSpfxdK+4d76py6hSM4bPRzXmYSMj5M4Q4q7gwXpS5y/dHvdjeSf5lzTJIUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870897; c=relaxed/simple;
	bh=gVMxFDDpg15WKmPy5umkWL8g3mr+x2UXWXSN2sMCAKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFLzS4HcLP8bRnl72PSikAlH0Nt5DM8sXnj6x/zLRrIqDyTZb8PD+OkiQaBUx7p5vwlSydC/ahw6zp6sqCV9UAJf0Zxycqv1mhsjaWRNm9nOp301NIFmxrUTDu2cmgp/MxwzzQDg03JynkVuKXuZqOFwiIwCmUJ8p68CF9K9FaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ra5mb3S1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ra5mb3S1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787870895; x=1819406895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gVMxFDDpg15WKmPy5umkWL8g3mr+x2UXWXSN2sMCAKs=;
  b=Ra5mb3S1L2iVkyNJuSwGnSrS0AQEIf4eLae51xxGaJpRyQIFuexRpQJJ
   06fziyXHeOEp/DhiFMewOLG3BOQkz+syYd1l4Qmx+r6xMmPIGxJPEzwL0
   rJZxojHwFgBODaMN2gXbcR7l/kCfhOHe2iZcn/SYWaKHUbBEsWljF3/cE
   FQhRiqBs7GSLLOG9Up8kw43GmKr+kj07LELD/qJ2jrZF90jSkwd0RIR8Z
   j7bF/SnCWnq2PFYXpjemf4lNVqhgmSeiHDf2Ne3b4gD082FRn5Dqaqkiz
   xFumOQnNUzOXx8b7aYa7GRd9RmtxQkCatEVUIRzLLjIKAFieK1VmWhawZ
   w==;
X-CSE-ConnectionGUID: 1EPZO9g1SAS8vHnNIA6aAg==
X-CSE-MsgGUID: 7OkZpRK6QCCmSZYocD4FJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113914885"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="113914885"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:09 -0700
X-CSE-ConnectionGUID: ocXutl3wRZu51H6sFNmHOA==
X-CSE-MsgGUID: pTa7L5HZT26aAxvXooLF6Q==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:48:09 -0700
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
Subject: [PATCH v2 12/16] KVM: x86/pmu: Populate CPUID.0AH:ECX fixed-counter bitmap
Date: Thu, 27 Aug 2026 15:37:51 -0700
Message-ID: <20260827223755.143247-13-zide.chen@intel.com>
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
index 106e719e7aee..63201d4ea4a1 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1547,7 +1547,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 
 		entry->eax = eax.full;
 		entry->ebx = kvm_pmu_cap.events_mask;
-		entry->ecx = 0;
+		if (kvm_pmu_cap.version >= 5)
+			entry->ecx &= (u32)kvm_pmu_cap.fixed_cntr_mask64;
+		else
+			entry->ecx = 0;
 		entry->edx = edx.full;
 		break;
 	}
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index a6d2ebff7cc9..1ce69e764ae1 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -585,7 +585,10 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 				      kvm_pmu_cap.events_mask_len);
 	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
 
+	/* FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i) */
 	fixed_cntr_mask = BIT_ULL(edx.split.num_counters_fixed) - 1;
+	if (pmu->version >= 5)
+		fixed_cntr_mask |= entry->ecx;
 	fixed_cntr_mask &= kvm_pmu_cap.fixed_cntr_mask64;
 
 	/*
-- 
2.55.0

