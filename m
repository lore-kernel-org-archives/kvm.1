Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256909;
	b=R6czCVfpR4YQBnmBg8rya1JAISA9yZwxVPIVIigYXRcNi7mwXB6KrKkJCkjgRbpNVHXx
	 iR+yfVitrjSdYKHy1EH02yKmsuiDpKFSbd3ZFjrFh9NTjVNEB8pp/l4cOQ1FLFleMwYwR
	 hig8o3l7FB9KZ4MXsPEY9/BWmZ1I4uEfrADVb7SfBj1cNZERxksEGie5OI7qhYx4nGbCL
	 r9IZvwnSzz+mLAZP7Lx9tjDHSSjVf9aO+2J0617mrBVJsuKJrNsW/dKsJOQkQxIQtIjvc
	 YI0Xv9heeMBBlFPopBfSrZkgyX2c5pfyjKuM45BPRzVp8gZXv3u1md3hARyOQrdX3Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256909;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=9dHa4AisQseH4QTZCZIFMhQMynS6vk08OeNeQonP/qs=;
	b=B3Msmn2fq+LvgyaztOWv5xr4/p6qdlkbC1raT5N1Zed+7/SXCLO6/5St5syOeB+MBnJ+
	 q3UjiyLfLtxq6/sUt6D7CpnbssdLpmAgJo8HzfQK+s9uMlxq2xtmEgjlHcWIGk/y0prk/
	 KefrMwKqrf2OgGr5bkQh+gmyqh5zkNpQ6JdSYVxM+w7mxpBCTq6YXl8EDUAteG+T1Pc5J
	 CeOLJ8UIA9kW/ZIrAzj5nPZJ82B8EmE5zWSU4RVcNnOE7+VpTppOHKTVxI46nix0cEMf0
	 OIZ10M9GcRTKDoGnGPLvSIcDZ5xSf1lZTGCTBU2tpXuE3otGRGFmvmebauv8lR9ncSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XQlD6Vjh;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8F9606A31C;
	Mon,  9 Nov 2026 20:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C8F9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XQlD6Vjh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794256907; x=1825792907;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U2wRqMTcQcswSSCOxFKCOskUaXcU/Iqc7mQbKy9lX0E=;
  b=XQlD6VjhhA7MIrFwEGHYSnXvLNhwpICcV2wjv1Z+MkVjv81BuMDEYemt
   nF79bpP11mPqGJ/dW6lrW3VOMPpp46IH3jyr1K7IqSThQI9iYgUH7ZvPL
   88kAL2hfFVvXGn4aalZq/6bpw51zJ72LXHOgqUnFcxW5NppjpQ3sHH5Jd
   lSiGnnqsSj3Ux9b7L6vijlTzlyVzR2IBN1Zjj97XLzJRajbhYz5GanZco
   ey3n+VXgGy0qPQqmqkJ3iYn5UsXUN1Vvod+8qZUvlB2mxvwzyMP/glHCE
   HMnKxm/bJAhF7DtQdJAIKytqqWhpa9IkUdHyyAkrix8H9FYuooCFOsJTJ
   A==;
X-CSE-ConnectionGUID: zr10FTG5SYGYmh2sL/isOg==
X-CSE-MsgGUID: +QwA5CgKTBiLgGoFl5k0Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2871680"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2871680"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 12:41:47 -0800
X-CSE-ConnectionGUID: c91SMu4qTiaDXrhk6x9hYA==
X-CSE-MsgGUID: AvxlREcPRJiHfekDfeNaoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8098146"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 12:41:46 -0800
Message-ID: <f20b59bb-a3c6-4129-ba61-5cec4d975601@intel.com>
Date: Mon, 9 Nov 2026 14:41:44 -0600
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
Subject: Re: [PATCH v3 13/18] KVM: x86/pmu: Populate CPUID.0AH:ECX
 fixed-counter bitmap
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-14-zide.chen@intel.com> <au491iiV7koeP0t6@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <au491iiV7koeP0t6@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/2026 3:00 PM, Yosry Ahmed wrote:
> On Thu, Nov 05, 2026 at 06:39:22PM -0700, Zide Chen wrote:
>> PerfMon v5 adds a fixed-counter support bitmap in CPUID.0AH:ECX.
>> This is the superset of EDX[4:0] which indicates the contiguous
>> counters starting from 0. For backward compatibility, it's recommended
>> to use the following to determine if a fixed counter is supported:
>>
>> FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i);
>>
>> Originally-by: Yang Weijiang <weijiang.yang@intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v3:
>> - Remove '&' when populating entry->ecx. (Jim)
>> - Gate entry->ecx on kvm_pmu_cap.version >= 5 in intel_pmu_refresh() to
>>   avoid enabling v5 fixed counters on hosts where KVM caps PMU at v2.
>> ---
>>  arch/x86/kvm/cpuid.c         | 5 ++++-
>>  arch/x86/kvm/vmx/pmu_intel.c | 8 ++++++++
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 3310c370c5fa..00a2ca6d3049 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -1554,7 +1554,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>  
>>  		entry->eax = eax.full;
>>  		entry->ebx = kvm_pmu_cap.events_mask;
>> -		entry->ecx = 0;
>> +		if (kvm_pmu_cap.version >= 5)
>> +			entry->ecx = (u32)kvm_pmu_cap.fixed_cntr_mask64;
>> +		else
>> +			entry->ecx = 0;
>>  		entry->edx = edx.full;
>>  		break;
>>  	}
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index 1372091dc1f8..37b34b588601 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> @@ -597,7 +597,15 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>  				  find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
>>  						      KVM_MAX_NR_FIXED_COUNTERS));
>>  
>> +	/* FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i) */
>>  	fixed_mask = BIT_ULL(nr_fixed_counters) - 1;
>> +	/*
>> +	 * Do not enable fixed counters via the v5 ECX bitmap if KVM caps
>> +	 * PMU version below 5 (e.g. when mediated PMU is disabled or on
>> +	 * older hosts), matching KVM's advertised CPUID.0AH:ECX capability.
>> +	 */
>> +	if (kvm_pmu_cap.version >= 5 && pmu->version >= 5)
> 
> Having to check both versions is confusing. Can they go out of sync?
> Should we clamp pmu->version to kvm_pmu_cap.version and only check the
> former?

Yes, actually, other fields (bit_width, mask_length, and
nr_{gp,fixed}_counters) in intel_pmu_refresh() are clamped to
kvm_pmu_cap as well.

pmu->version = min_t(int, eax.split.version_id, kvm_pmu_cap.version);

Without this, as more advanced PMU features are supported in KVM, we
will have to manually validate guest features, and it seems this doesn't
violate the general principles of "not policing CPUID configurations"
and using the "effective vPMU version".

> 
>> +		fixed_mask |= entry->ecx;
>>  	fixed_mask &= kvm_pmu_cap.fixed_cntr_mask64;
> 
> I see why this is needed now, to re-apply KVM's fixed counter mask after
> reading it, but if this is only needed there, it's probably clearer to
> do:
> 
> 	if (version >= 5)
> 		fixed_mask |= (entry->ecx & kvm_pmu_cap.fixed_cntr_mask64);

Agreed, this is cleaner. Will update accordingly. Thanks!
