Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795023903;
	b=G+HUbV9Ko3BZAZnDvz/bpknrLYvmbAOPVH6sNFOtz/VOaazVvbcmqluR7Nq4nfVLsOXT
	 I1UsPmIsvfcYAD/LBXDOdZdaItjBDzFkQO9CjWudJA5OlzaySYJrTaC+kB69nIPyVOHlX
	 VQdzRSb+KJHcUEd3HMZ67V0FB1iCfDTSJlDdQYQUfrLp36M8hHkXGOc+8nKE05+fMq7Qu
	 PwLjTmm5VMYVWgjUGFh1yLeK454YN3um+hQ8zJQbzPBZVPUs5+tlvx9sbnLS8umArQEcI
	 nWN9mGmL6yN1k3Jdn2uyGwQhnEWTn+vHXnB7wi5AP2P7V6t/VOh407kRFHyzwirYI+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023903;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ed4xVqmLqh0FhNmdYjMTT+rIzLH+xgbBgiWh55TzRDc=;
	b=WnhN9xIgPvEgGjbxTQYvW9BjxSd5W5cjd97pt70l+ardPOSWot4zHczzrQW35aVtKPQk
	 z+uXlVxbh6NB2VcgVJ27KdEZLXGpx08DuQLKeStyhAMCL/nOu9gGHYN6xq79eIC8MibAe
	 uvIaUg0fignCVlhKThcDq2c5K+1Ey7acirEQTpt79jhac48u/MSZBrdZ6ga3wdCPmHaEk
	 xFGGiX/I7aZP7mRpeuAK7mZP7Hd/DpgvDBUhoqp+PBfcv1sucbfEnS8/353JlxL14xnsv
	 jkumj7j7/5N711uXdJQw5jmHn4gQLAmUdBFjZFrfGlaMYdazF8YAhyxMabD7Ddg9Xew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I9n4KuRX;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71990606A31C;
	Wed, 18 Nov 2026 17:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71990606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I9n4KuRX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795023904; x=1826559904;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R+fzyJKZWVfeM44fD4H0hSYVFYgiIpP7LrshqgBod9I=;
  b=I9n4KuRX1q1gR/FPJ0m5aQyj8Vl6/Py+CST+EJi1EdtRuKrnjIlArdu/
   hPth9fL7atlpS6GxrTR2pmrkPYAl629oOqkhJrlt9cUbIbC4VS0gTJv6L
   1M5XPJ0HMyZ64B1fr4J2iLHUQ8yyEOB9OeHbJfdIxlygz4ZKNY/lqNWAU
   weibIMc6/6nFY/IfnjutkZEX8elptEmvhSIEmtNLPeR2BnjNNVGv9oeF/
   QbEp8DdbSUIb+MTnfP8/uuK8QKAVeTyT4OFZ7JwG4VYF1g2AADSSZgTpR
   mO1Lig7xG//7wMAuJwUVAjLp2cDSAszH6Jw+M7r4/M2asRLOWfHMVbvHe
   A==;
X-CSE-ConnectionGUID: XGzB1xBZR4GEUNziw6Ydeg==
X-CSE-MsgGUID: jXvDHd0fR7WCf6dDGKvHEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3850019"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3850019"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 09:45:03 -0800
X-CSE-ConnectionGUID: 5jV2dKe2Qka5LbwnLqtZ7Q==
X-CSE-MsgGUID: 5UhYUNdlROmfbTV39yFvUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="12015076"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 09:45:02 -0800
Message-ID: <704f5a24-2880-4593-9c29-63eaffdaee29@intel.com>
Date: Wed, 18 Nov 2026 11:45:01 -0600
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
Subject: Re: [PATCH v4 09/21] KVM: x86/pmu: Switch to bitmask-based KVM PMU
 capabilities
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-10-zide.chen@intel.com> <av3MeWKmCRprVNWx@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <av3MeWKmCRprVNWx@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/2026 10:05 AM, Yosry Ahmed wrote:
> On Thu, Nov 12, 2026 at 01:32:15PM -0700, Zide Chen wrote:
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Intel platforms support non-contiguous fixed counters via CPUID.0AH:ECX
>> starting with PerfMon v5, and support non-contiguous GP counters
>> through the Architectural PerfMon Extension (CPUID leaf 23H).
>>
>> struct x86_pmu_capability now exposes {,fixed_}cntr_mask64 bitmaps,
>> which may contain sparse bits representing non-contiguous counters.
>> Switch KVM's kvm_host_pmu and kvm_pmu_cap consumers over to the new
>> bitmask fields, including iterating kvm_host_pmu bitmasks directly in
>> VMX and SVM PMU MSR intercept setup.
>>
>> CPUID.0AH:EAX[15:8] and CPUID.0AH:EDX[4:0] enumerate only contiguous
>> counters. Derive these values from kvm_pmu_cap.{,fixed_}cntr_mask64 as
>> the number of consecutive counters starting at index 0.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Co-developed-by: Zide Chen <zide.chen@intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v4:
>> - Cleanly substitute kvm_pmu_cap.num_counters_{gp,fixed} with
>>   find_first_zero_bit() in intel_pmu_refresh() without throwaway
>>   code churn.
>> - Use find_first_zero_bit() instead of hweight64() for AMD CPUID
>>   0x80000022 EBX[3:0] (NumCorePmc) and svm_set_cpu_caps() to enumerate
>>   contiguous counters. (Yosry)
>> - Do not carry over Jim's Reviewed-by from v3 due to reworking counter
>>   clamping in intel_pmu_refresh().
>>
>> v3:
>> - Iterate kvm_host_pmu bitmasks directly in VMX and SVM intercept loops.
>> - Clamp nr_{gp,fixed}_counters to the number of contiguous counters
>>   supported by KVM in intel_pmu_refresh(). (Jim, Sashiko)
>> - Drop redundant !enable_mediated_pmu clamp on fixed_cntr_mask64.
>>   (Sashiko)
>> ---
>>  arch/x86/kvm/cpuid.c         | 17 ++++++++++++++---
>>  arch/x86/kvm/msrs.c          | 12 ++++++------
>>  arch/x86/kvm/pmu.c           | 17 ++++++++---------
>>  arch/x86/kvm/svm/pmu.c       |  2 +-
>>  arch/x86/kvm/svm/svm.c       |  8 ++++----
>>  arch/x86/kvm/vmx/pmu_intel.c | 18 +++++++++++++++---
>>  arch/x86/kvm/vmx/vmx.c       |  4 ++--
>>  7 files changed, 50 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index adafd6fa2c54..427871ec365f 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -1535,10 +1535,18 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>  		}
>>  
>>  		eax.split.version_id = kvm_pmu_cap.version;
>> -		eax.split.num_counters = kvm_pmu_cap.num_counters_gp;
>> +
>> +		/* Contiguous GP counters only. */
>> +		eax.split.num_counters =
>> +			find_first_zero_bit(kvm_pmu_cap.cntr_mask,
>> +					    KVM_MAX_NR_GP_COUNTERS);
> 
> Should we add helpers for the find_first_zero_bit() calls across?
> Perhaps kvm_pmu_nr_contig_gp_counters() and
> kvm_pmu_nr_contig_fixed_counters()?

Agreed, encapsulating find_first_zero_bit() makes it more readable.

static inline unsigned int kvm_pmu_nr_contig_gp_counters(void)
{
        return find_first_zero_bit(kvm_pmu_cap.cntr_mask,
                                   KVM_MAX_NR_GP_COUNTERS);
}

static inline unsigned int kvm_pmu_nr_contig_fixed_counters(void)
{
        return find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
                                   KVM_MAX_NR_FIXED_COUNTERS);
}
