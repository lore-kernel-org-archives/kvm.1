Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516228;
	b=vXiQbaj8/a+SqD086YC4fohZW2IJ48ZaYf9MGX9QLl0z/Oz2iLfqUPRDBe4PuIFzR2J5
	 mb5PfbVqAtASTrvkZU3zP63njcZEEwlgcmNmaiGetUkuvqf/b+GbAlM2Q+KpuVXb5WToy
	 zFrqSy8KQRfq/4Hd0Z/xkhm5rsy6d+mlI5mExynNKB9z2pCbf9cOGxTZNk2kiExqp2zTV
	 4Q/rJmMsyF4xhi/mCE0cjlTiH/EVVOQQxFQ5kMO6P29tm2G8JpWYcEAFlYJLoxwD+gK93
	 Qrkmq40AXhecfyXskiNelwvC7o0DRaRGiNVUYK4fwRrKkExhssn5VXz+dwAcMbd31OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516228;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q+1796m/f659RHbeT3BlZBv1aJQ1Dt/esPKM3W0KmvQ=;
	b=hI6KFLafZrmX46md19tzDCtWJcK5FmkKwj1GYzxyvO97DGmBA2/MIJ11ubU7ZQI9quLJ
	 5F1uT/Vsbzb02VerzkivyT6Ypchk+zaFdqJi8Es5lclEOhf/S11jw3DKN7gYOwnqvVnZV
	 d7uEiqbNt/lKvqaA2Juw79a870k9o+cebRxO3UryxUVr4Jg2Ubbkn0cAJqviJXfhaCJj+
	 uxcSNE/cyGmjqxYRmmxCOVxCpcDP7B4/hOpLCNVjDBUa8SlEzKK8gzVUK3uvMM5V8Tgrn
	 eHT1+CPzG58nL9ENjIxILsyu5A10ybRctgReTg/WIkxD4PX6ypbRhKXgJ1wqtGHLYWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cIsS9lkI;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0B6606A32A;
	Thu, 12 Nov 2026 20:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E0B6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cIsS9lkI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516227; x=1826052227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7jKBTIumxZzcDao58h8B8q16Q7JZ8X9u9E0l454HUgI=;
  b=cIsS9lkI4s1XN5eIKASkUj7G7t5cm7u+ljezVmxLZtufkK89+dcakeku
   zXfylgdUXHbNb2wUXng5KmqWA4ibbuuaTGa6FVKtePiv9JOb32FydYbvW
   Z5PKTFXWcctHcfCqRE4jzIkniZXYxMHVewZFypDBuahr+gBSCvQXwayz+
   KoNUU8EoS/TQe3kgQ2bE9svTmbeBWaFFoDcvt+T08EW6loLKlcjDv8iZ6
   Zybo5udOgpdguoT251S9fcTQnUpEGW0qN0MTXSZEe2JEKH/nCeo84dcB/
   dTn1IBNu1tcnjhv20CFyzzOno6Np+fsxjAdjHm9HYlvieYT7wAWSm+6q6
   Q==;
X-CSE-ConnectionGUID: baPSLueRQoSgszsFImx38Q==
X-CSE-MsgGUID: CEM9G0lKRJCfSZHndARIOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192213"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192213"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:46 -0800
X-CSE-ConnectionGUID: 76BTwQRxSB+3qzCBHlO+0w==
X-CSE-MsgGUID: VhBnh9NcT4alq15rPbYF6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087864"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:46 -0800
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
Subject: [PATCH v4 01/21] KVM: SVM: Drop counter MSR checks in amd_is_valid_msr()
Date: Thu, 12 Nov 2026 13:32:07 -0700
Message-ID: <20261112203227.289379-2-zide.chen@intel.com>
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

amd_msr_idx_to_pmc() accurately validates individual counter MSRs by
checking whether the corresponding counter is supported for the vCPU.
Validating counter MSRs again in amd_is_valid_msr() is redundant.

Furthermore, validating counter MSRs using broad checks like
"pmu->version > 0" or "PERFCTR_CORE" is inaccurate and misleading. It
falsely validates unexposed counters, which then fail in
amd_pmu_{get,set}_msr(), injecting an errant #GP instead of taking
KVM's fallback (read 0, write ignored) and breaking migration for
unadvertised counters.

Finally, the range check in the default case is dead code because AMD
CPUs currently support at most 6 Core Perf counters. Even if future AMD
CPUs support more than 6, counter MSRs would still be sufficiently
validated by amd_msr_idx_to_pmc().

Drop the counter cases and dead range check from amd_is_valid_msr(),
leaving counter validation solely to amd_msr_idx_to_pmc().

Fixes: 4a2771895ca6 ("KVM: x86/svm/pmu: Add AMD PerfMonV2 support")
Reported-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v4:
- New patch. (Jim)
---
 arch/x86/kvm/svm/pmu.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index c18286545a7a..bf2f23c30afc 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -106,23 +106,16 @@ static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 
 	switch (msr) {
-	case MSR_K7_EVNTSEL0 ... MSR_K7_PERFCTR3:
-		return pmu->version > 0;
-	case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTR5:
-		return guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_CORE);
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 		return pmu->version > 1;
 	default:
-		if (msr > MSR_F15H_PERF_CTR5 &&
-		    msr < MSR_F15H_PERF_CTL0 + 2 * pmu->nr_arch_gp_counters)
-			return pmu->version > 1;
 		break;
 	}
 
-	return amd_msr_idx_to_pmc(vcpu, msr);
+	return false;
 }
 
 static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
-- 
2.56.1

