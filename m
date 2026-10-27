Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136655;
	b=jWrvJ62QqEr5T6mbFgvgBPOI/yIQUdZNVVGPY8dPQOPnfqiHSq8W9qKaOVKx8XagXrgy
	 G0//9O81PFUQcWdgzeMa3IUdmwj+lR4k7qNyuzEeLb4Dvpjq0IDBs+NAUjorm3/N2PTa7
	 aY9EuzhGdFIFuhJ1CxGxLmR9CYIxJLrqQVa2XGMxQ4P+DdrMVSF58HX3cIFD22hNVtcw7
	 ZG2VA5cwqAmMLNOSl10NmCEqoafjz6KoIat4eoOjPvK3cRPYmz+fpB92jDFlXJXenhhtP
	 ZXNJHD/sgoN6kD4pUDq7lbepJ5iG9CITkcGGfj05Gf5LYpqvTgolN2YV2pIDLyrAEaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136655;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=5quhoV3MalScmAzYkLeJA6boRgR5AHVSu1xhAFnf4wQ=;
	b=gdOYuKvIK88u+RmyYwQ5PQwFv57/+3SP24rFEO/LyN52bfgJKT1K8oinrFaaEmDe9DEw
	 D4tyQbdrWrCcBMm/urVVfH5QuMIfjSjT+jmVR5fvRzcpVKqaCYUaJIGI+Az/f5G+zdymH
	 /+Hyt/Us6VARfsZQzTZzkdZrogbaTMzebWBn1Rmd6JfReqhw7NGIeft2XEMwjgw0XXQ/U
	 PtmqpE/0E8mOBfiyl2GM/zfvGEDUdlEZpJ8erxolfnMGzP3okkyOAayyTpDOKfQyKJWsC
	 meWz/+7X2hTJdAiC1lJIXRUkwWWxXoVzaNMfwsUb139eKucwNRgwFuKMu0EtFitf8pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bkshNFKn;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8583606A31F;
	Tue, 27 Oct 2026 21:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8583606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bkshNFKn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793136653; x=1824672653;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PXYY1ekMEv61fuPP27gXvWwAl/ofe3DPlGY7wbG+SsQ=;
  b=bkshNFKnCeklcrgCosstu9uA6Ci9X76PY1+niuqiOUwfXJHUuvlfR4/v
   /zcYu4r40vbAcqVXSqNslItGeVfE/DBGo62pC9Tl5ndBX7lFZXtQ5K4dY
   rX4pxrMQLN+r3RyetvZ1LOdxu7U5xm+UkaU3JO0wZh3gKfwGA1jq4eRtm
   IvZOXft0VvLvFbpSA0Uw9OVRsmXTIQ3ivpHJMktISn/1kfjYwkbtGALWf
   D5hzgBQ/yKd5sUaWIS11OCGo5uHqOHxdzH1ae2M1pQW+8Ko7Bx4SRefDR
   aN72aZ788qtbqkOzM9HzgYo6cALKIaBPTvQsFbUFpB2+qgEn1YrNz96eg
   g==;
X-CSE-ConnectionGUID: g5rvLizhS/2WJYqVPl2T6w==
X-CSE-MsgGUID: WaAGaEZsTi2lisX2k1NY0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1726540"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1726540"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 14:30:53 -0700
X-CSE-ConnectionGUID: yBpYtmsnRkGRaY+2QA5vKw==
X-CSE-MsgGUID: vamJhQtTQF+nKc31KwJfqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4753743"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 14:30:51 -0700
Message-ID: <98ed42e6-8c10-40f1-affa-2333188572bb@intel.com>
Date: Tue, 27 Oct 2026 16:30:50 -0500
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
Subject: Re: [PATCH v9 05/12] KVM: x86/pmu: Support PERF_METRICS MSR in
 mediated vPMU
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260918193937.569414-1-zide.chen@intel.com>
 <20260918193937.569414-6-zide.chen@intel.com>
 <20261023182743.3248481-1-jmattson@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20261023182743.3248481-1-jmattson@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/23/2026 1:27 PM, Jim Mattson wrote:
> On Fri, Sep 18, 2026 at 12:39 PM Zide Chen <zide.chen@intel.com> wrote:
>>
>> +static inline bool kvm_vcpu_has_perf_metrics(struct kvm_vcpu *vcpu)
>> +{
>> +	return kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PERF_METRICS;
>> +}
> 
> The SDM, volume 3, section 22.3.9.3, says:
> 
>> IA32_PERF_GLOBAL_CTRL. EN_PERF_METRICS[48]: If this bit is set *and*
>> fixed-function performance-monitoring counter 3 is enabled, built-in
>> performance metrics are enabled. [emphasis mine]
> 
> and
> 
>> The values in MSR_PERF_METRICS are derived from fixed-function
>> performance-monitoring counter 3.
> 
> Hence, a dependency on fixed counter 3 belongs in this predicate.
> Perhaps something like:
> 
> 	static inline bool kvm_pmu_has_fixed_counter(struct kvm_pmu *pmu,
> 						     unsigned int idx)
> 	{
> 		return idx < pmu->nr_arch_fixed_counters;
> 	}
> 
> 	static inline bool kvm_vcpu_has_perf_metrics(struct kvm_vcpu *vcpu)
> 	{
> 		return (kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PERF_METRICS) &&
> 		       kvm_pmu_has_fixed_counter(vcpu_to_pmu(vcpu),
> 						 INTEL_PMC_IDX_FIXED_SLOTS -
> 						 INTEL_PMC_IDX_FIXED);
> 	}
> 
> with intel_pmu_refresh() calling kvm_vcpu_has_perf_metrics() instead of
> testing perf_capabilities directly. (nr_arch_fixed_counters has already
> been computed at that point; all_valid_pmc_idx has not.)

Thanks for the detailed analysis. That makes total sense.

Initially I didn't gate PERF_METRICS on fixed counter 3 out of concern
about policing userspace configurations. Additionally, as in the quoted
SDM text above, it means PERF_METRICS can't function without fixed
counter 3, but strictly speaking, the SDM doesn't prevent other
operations, for example, writing the METRICS_CLEAR_EN bit.

But having IA32_PERF_CAPABILITIES[15] set in the absence of FC3 is not
going to happen natively, so I think it doesn't break any rules if KVM
chooses to gate PERF_METRICS on FC3. And as you pointed out, it's a
simple and effective way to protect KVM invariants and migration integrity.

I will add the FC3 check to kvm_vcpu_has_perf_metrics().

> 
> KVM only supports contiguous fixed counters today (see patch 2), so a
> simple comparison against nr_arch_fixed_counters suffices. However, if KVM
> ever honors the CPUID.0AH:ECX fixed counter bitmap, a separate helper
> keeps that assumption in one place.

Before the pmu v5 series is merged:
https://lore.kernel.org/kvm/20260827223755.143247-1-zide.chen@intel.com/

I have to continue use nr_arch_fixed_counters in this series.

> 
> As it stands, if userspace sets PERF_CAP_PERF_METRICS for a version 1
> vPMU, MSR_PERF_METRICS is passed through (kvm_vcpu_has_mediated_pmu()
> only requires a non-zero version), but intel_pmu_refresh() bails out
> before it gets to the PERF_METRICS code. With patch 11, that leaves
> perf_metrics_rsvd at ~0ull, so a value the guest writes directly to
> hardware can be saved with KVM_GET_MSRS, but not restored with
> KVM_SET_MSRS.
> 
> Since nr_arch_fixed_counters is 0 for a v1 vPMU, the above handles that
> case too. It also takes care of the METRICS_CLEAR_EN unmasking without
> fixed counter 3 that Sashiko flagged on patch 12, and it obviates the
> NULL pmc check in intel_emulate_rdpmc().

Yes, with FC3 gating, these issues can be easily resolved.
> [...]
> 
>> +	case MSR_PERF_METRICS:
>> +		pmu->perf_metrics = data;
>> +		break;
> 
> On a part with only four metrics (e.g. Ice Lake), userspace can stuff
> bits 63:32 into pmu->perf_metrics here, and the unchecked wrmsrq() in
> intel_mediated_pmu_load() will then #GP on every VM-entry. Patch 11
> isn't an optional follow-on; it needs to be folded into this patch.

Yes, agree.
