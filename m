Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516232;
	b=dACyIeWjrRY0+Gl247cllkt8/gsB74l+/dpQD9TimQFB8r6++cbcqZl2uxpxHqhevi+b
	 aM8QxD3pXekazTarZHcOBlSJ/8j+/W0tLs3f7Y7PqslvSB1U6RJykj0p9t02EUS6Hn8zw
	 Qyz4n28MbkJgGoHkbLeh0CTrKrS8KrlAvBgx/aAx63/FCyuADAKEMsZcVruzUO5UJi2qE
	 mb3cO56sbaLyymM/PfTKFQQxplFbvSWI0i/c/DzhvpJ3uIj8YptKli2Uhfqn2ZESlbnrl
	 9mlJMgZH6LAZURpYeKKwek87pNsGyU+IAkZElXBmw3Bjfx4pzJrkGo7+EyKfSyk8+7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516232;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kZZmTvLKPr6RDSHfLfHVICLODY7eWN+PrRHMNCqmONg=;
	b=yQHlMq/Xq1V5ctv2V7kx+1I8uSbxOR/Z7Oh5OxPO3McCL+hoHbfxH1fSsFajzFaxgtUQ
	 FQf2KTG4lylCQehbzRKILQ9YKpO0WzWzUGxwH+V7RYbDPcNuD7SYBfzT5tI5c51smfu3S
	 w9fad8teZYRpJnTIs4BdMbsCR+Uh+CkIL2lMS6Q6QpJW8UJc/VOEx6UM10OoDEMDb7jKG
	 OBLoNo6Un+xyv9q1vB/7/heNfo7//8djtG4FGAmoRNWeK1iZnUp0MOjAbud7CPGElhynV
	 EkrQmIT4Pkth9R0+3njwCfMD2ny2/IWw4Onl7MRzfzMj/T1ls+a2o+2u76aLaGy0w0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CbG5JYIZ;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A628D60A5BCC;
	Thu, 12 Nov 2026 20:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A628D60A5BCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CbG5JYIZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516232; x=1826052232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V9sNcs+cxqAurFlWbVjW4CPPNzmzPCwk6DoRhgtfR9E=;
  b=CbG5JYIZ5YPmLNHteCqrxUSOYmMF0n/e0/1JnWEtKkbVyGG0GFZ5sbX9
   lZXlFehPZpxHdqfj8fjJBSb7VBSBRT4/5+3cqvvEYC7PyWiTZP8Cz0FB7
   EJP2RbArNxg/JIu8UO8WUq8Kjlc7L+WzEMV/aTBy+hIIqNZdxIF2639h5
   Ujep+hQFEtOK4q+KAxHk9qu/k1S5LHePx1ECNrvzqcxA4D3raN4vWld39
   hw4fZj7ySE8n8RwlXP3F/6Xx2GzX/FMh5D6Hkon4NAVG9TjNLTlSx/iJH
   /WeZps6gToYg82T9okuVn5PN59iXKbzTzpre5MfnmecrsppOETgksHXng
   Q==;
X-CSE-ConnectionGUID: W162E5KgSraImyJ7Ci9yFg==
X-CSE-MsgGUID: 2yyGz7kmS0WWvMfP2/99sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192306"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192306"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:51 -0800
X-CSE-ConnectionGUID: 0bNC+Iv+ThK8TGZhPqtTTQ==
X-CSE-MsgGUID: jSI2Ie8vTY+Ej38T1ict6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087927"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:51 -0800
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
Subject: [PATCH v4 16/21] KVM: x86/pmu: Populate CPUID.0AH:ECX fixed-counter bitmap
Date: Thu, 12 Nov 2026 13:32:22 -0700
Message-ID: <20261112203227.289379-17-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261112203227.289379-1-zide.chen@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
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
This is a superset of EDX[4:0] which indicates the contiguous
counters starting from 0. For backward compatibility, it's recommended
to use the following to determine if a fixed counter is supported:

FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i);

Populate CPUID.0AH:ECX with kvm_pmu_cap.fixed_cntr_mask64 when KVM
supports PerfMon v5, and in intel_pmu_refresh(), incorporate the
guest's ECX bits into fixed_mask for PerfMon v5+ guests.

Originally-by: Yang Weijiang <weijiang.yang@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v4:
- Check pmu->version directly instead of checking both kvm_pmu_cap and
  pmu version, as pmu->version is now clamped. (Yosry, Sean)
- Merge the blanket masking into the fixed_mask assignment. (Yosry)

v3:
- Remove '&' when populating entry->ecx. (Jim)
---
 arch/x86/kvm/cpuid.c         | 5 ++++-
 arch/x86/kvm/vmx/pmu_intel.c | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 427871ec365f..2a4530d000fc 100644
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
index 0be9956810ae..d259b66abac8 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -593,7 +593,10 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 				  find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
 						      KVM_MAX_NR_FIXED_COUNTERS));
 
+	/* FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i) */
 	fixed_mask = BIT_ULL(nr_fixed_counters) - 1;
+	if (pmu->version >= 5)
+		fixed_mask |= (entry->ecx & kvm_pmu_cap.fixed_cntr_mask64);
 
 	/*
 	 * CPUID.0AH:EAX[15:8] can only enumerate contiguous counters. Clamp the
-- 
2.56.1

