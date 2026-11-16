Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855772;
	b=L1b686BZB+6FUGN5ox9L23lpGXhGZvbgTT6SMaWbboZCi1ONowUZBRuVQEv5J1XffmGw
	 5NldvVJwtCyEW1s9eFsabeJ4qHq4jzNlhwuhITyRwPNfzxWqeejeY/2c6XBz2JGgIH0xU
	 a5E4ldUMlYvbqOWdK+7Ga1kkqCVewU4vBNb82FURHY0SC+sWCWGOIorp0MlDkJoj4Aauu
	 g4SAEA310HQoM6Q9MdbB5PKDUokv9LBv/hAR62bUKG4tqCFh6Dx4v8/Hecm+pJBTFDIDd
	 dZSRYFQ0ixgo4DRhLMqYSQJ7nOeH7Jh6dw2L+6jY4WB4kB985HVyHlsvlwI0gqOloxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855772;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=O6UMZeXcanN8t0djn7NJ3zl4SeBIN2aE6Bswi6j2Bic=;
	b=5YHgV2k0clkXT3RvJZenmBl9X/XFNlS1NdQ5QBIUA/n5nxtzaZ/SZdTUy+4+d0wOzHuk
	 2NXmZJA4639F6uutUtJc5YMZAxiH4WTi/32TQcILzSG6KeAMLFhFqc09FPdNZpVQNLIvI
	 iCpvpCjeKQR94uUHilylk9Iy9C4bVSqrWiT7SLGOmci8YumHlMtar1CLFW+Dm1gBoCsE7
	 40sdef+YY0cJfn3rh1bLa4uftnlyFogygP8FmzsA/FzJrRqtlQihgAnVnf6GY0CYwVpv/
	 a37nZGuFayfY97WJaqCO3T2GWOAmCXjB8btP3lZ/iPpeoes1n8eRtPUJVpZ5SnZ6wnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="krLJ/zt0";
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD40606A332;
	Mon, 16 Nov 2026 19:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCD40606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=krLJ/zt0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794855771; x=1826391771;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wQE7uNnF9LUCnfBgZItftnbCHtc1uOtISxCx3nLbEHo=;
  b=krLJ/zt05/jW5akGL0FXG9cQLefBpx/gMTniW/DHPH/8run/Nxm54FbJ
   jYGHJ+1g/8uiwjZAWZb7Kuxmaj6yLay7ZOiLVHcxBmc/1Gd0K4I9vU41t
   1Z+N6WCIiyONAssi5X5RDSsODHykH6IFQGvUIQ+6xQhGKJOgrUJf4XhOV
   y/iu9UkSHb2gKO/C5NDPgLZMaC4BG4njwxsLz1yXryJZE+Ns6q9Qu6pHp
   NR9QPfFX4YmSHMVOZvqMWYJhxVEsRzcMWMBTJjWRkM9fVagj7mXyaPSE+
   mzGam0snxeS54naD4tX2mLrym9LUv3P1vlfleO3lYtXoRC9Ur/TZ+gjCC
   Q==;
X-CSE-ConnectionGUID: 7HLKsn0CS4ebtuQqc49w7A==
X-CSE-MsgGUID: mhibNnJRRCySq6mWw3s8ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3497664"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3497664"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 11:02:51 -0800
X-CSE-ConnectionGUID: keozqHRVT8qpyORtp6xvdQ==
X-CSE-MsgGUID: +3DLGtDwTFyUZyCBR1T39A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9696706"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 11:02:51 -0800
Message-ID: <553050b3-bcda-48e0-af03-754f0b697943@intel.com>
Date: Mon, 16 Nov 2026 13:02:49 -0600
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/21] KVM: SVM: Drop counter MSR checks in
 amd_is_valid_msr()
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-2-zide.chen@intel.com> <avis5Ose25IiYM2S@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <avis5Ose25IiYM2S@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/14/2026 12:49 PM, Yosry Ahmed wrote:
> On Thu, Nov 12, 2026 at 01:32:07PM -0700, Zide Chen wrote:
>> amd_msr_idx_to_pmc() accurately validates individual counter MSRs by
>> checking whether the corresponding counter is supported for the vCPU.
>> Validating counter MSRs again in amd_is_valid_msr() is redundant.
>>
>> Furthermore, validating counter MSRs using broad checks like
>> "pmu->version > 0" or "PERFCTR_CORE" is inaccurate and misleading. It
>> falsely validates unexposed counters, which then fail in
>> amd_pmu_{get,set}_msr(), injecting an errant #GP instead of taking
>> KVM's fallback (read 0, write ignored) and breaking migration for
>> unadvertised counters.
>>
>> Finally, the range check in the default case is dead code because AMD
>> CPUs currently support at most 6 Core Perf counters. Even if future AMD
>> CPUs support more than 6, counter MSRs would still be sufficiently
>> validated by amd_msr_idx_to_pmc().
>>
>> Drop the counter cases and dead range check from amd_is_valid_msr(),
>> leaving counter validation solely to amd_msr_idx_to_pmc().
>>
>> Fixes: 4a2771895ca6 ("KVM: x86/svm/pmu: Add AMD PerfMonV2 support")
>> Reported-by: Jim Mattson <jmattson@google.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
> 
> Should we also drop the get_gp_pmc(.., MSR_IA32_PERFCTR0),
> get_gp_pmc(.., MSR_P6_EVNTSEL0), and get_fixed_pmc() calls from the
> default case in intel_is_valid_msr()?
> 
> They are also covered by intel_msr_idx_to_pmc() IIUC.
It's a shame that I didn't take one step further to check the Intel code.

I completely agree that intel_is_valid_msr() should be simplified:

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 4824e7eb98d3..77ce713101a4 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -229,10 +229,7 @@ static bool intel_is_valid_msr(struct kvm_vcpu
*vcpu, u32 msr)
                        ((perf_capabilities & PERF_CAP_PEBS_FORMAT) > 3);
                break;
        default:
-               ret = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0) ||
-                       get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0) ||
-                       get_fixed_pmc(pmu, msr) || get_fw_gp_pmc(pmu,
msr) ||
-                       intel_pmu_is_valid_lbr_msr(vcpu, msr);
+               ret = intel_pmu_is_valid_lbr_msr(vcpu, msr);
                break;
        }

Additionally, intel_msr_idx_to_pmc() currently misses get_fw_gp_pmc(),
which leaves FW counter writes untracked in kvm_pmu_mark_pmc_in_use().
Moving get_fw_gp_pmc() into intel_msr_idx_to_pmc() fixes that bug and
allows dropping all counter checks from intel_is_valid_msr():

@@ -247,6 +244,7 @@ static struct kvm_pmc *intel_msr_idx_to_pmc(struct
kvm_vcpu *vcpu, u32 msr)
        pmc = get_fixed_pmc(pmu, msr);
        pmc = pmc ? pmc : get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0);
        pmc = pmc ? pmc : get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0);
+       pmc = pmc ? pmc : get_fw_gp_pmc(pmu, msr);

        return pmc;
 }

This seems a little bit too complicated in intel_msr_idx_to_pmc(),
especially once PMU v6 is introduced and more v6 specific MSRs are
available. We may do some cleanup (not in this series though)

- Fold get_fw_gp_pmc() into get_gp_pmc() and hide the base MSR from the
  API signature to keep the callers clean.
- Move these helpers from pmu.h to pmu_intel.c, since AMD already uses
  its own helpers.

@@ -245,10 +294,9 @@ static struct kvm_pmc *intel_msr_idx_to_pmc(struct
kvm_vcpu *vcpu, u32 msr)
        struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
        struct kvm_pmc *pmc;

-       pmc = get_fixed_pmc(pmu, msr);
-       pmc = pmc ? pmc : get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0);
-       pmc = pmc ? pmc : get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0);
-       pmc = pmc ? pmc : get_fw_gp_pmc(pmu, msr);
+       pmc = intel_get_fixed_pmc(pmu, msr);
+       pmc = pmc ? pmc : intel_get_gp_eventsel_pmc(pmu, msr);
+       pmc = pmc ? pmc : intel_get_gp_counter_pmc(pmu, msr);

        return pmc;
 }

@@ -419,18 +467,17 @@ static int intel_pmu_get_msr(struct kvm_vcpu
*vcpu, struct msr_data *msr_info)
                msr_info->data = pmu->pebs_data_cfg;
                break;
        default:
-               if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
-                   (pmc = get_gp_pmc(pmu, msr, MSR_IA32_PMC0))) {
+               if ((pmc = intel_get_gp_counter_pmc(pmu, msr))) {
                        u64 val = pmc_read_counter(pmc);
                        msr_info->data =
                                val & pmu->counter_bitmask[KVM_PMC_GP];

