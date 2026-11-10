Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292101;
	b=LWNo+yODGCbFcxHGIjUCFBRgK17IlPAZnpNZoz7xYnnfqyXfCnRhtnZY5Dzo3IT/vSJo
	 nOocKdx1SBZKKKHgn8qYwydCmIqNXbl5eJG1Ru8YOxWeiUiBA9baAlnFHSsAyRtN73j0q
	 a8xbu32C3ZOmwMilQNWRqv8tYIHyBO4kNRvb9D2s+4gETN10/L4QyDwO34Qo2aZbX0QRd
	 gcTotrKOnUganBPww+umwe14ffenKeF6C5omB7tc/mMjM1NZ+9LP2ZfIVFjik3VhJznEo
	 7xP/gkV4Ssx1+PYmjp92K0na3Wj7O555BRsq65CMeUvs9TpjOh9240pM3XFPZWitlTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292101;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=EhtvM2UtsJgM2DtXXlFOCOP1BCdtofulztdBunfrlhw=;
	b=AmzZDyoy0wA28dgSwDXvEcX17iWHFkB9bLcj8FfgNRYfdMcqg2GvnZjiwUtXJRZhxGaz
	 CF137sx7EFSPJfdwd4bna0S41gbMh7XU02bqIeVXJrfZuAKWl4o+xxiSdrXDIByAHlPuY
	 +YTqAS28h6PFg8voNMiJn7JY1rPPMQU2J99yqBmrxDx5LIyZ7rKTQ1UBcU/6OCwe3oaJq
	 ArkC6hrBU7ed1I3rGczbzQNrJXnCCpJozsBc3rApFRG1YrEHR8wlswK/+mdAa2N6FtMzZ
	 eJkTJ00/SMRK9tbi2VcAcCg26+DKaj2V8C3bbV151uH+t7XUz/gQgtbm3/mlnPr4qFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JQ2AlGFs;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA24606A31C;
	Tue, 10 Nov 2026 06:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEA24606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JQ2AlGFs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794292101; x=1825828101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lChLx1VhGAKCAFJLuYFvfbJimi6McVXAP8a/JWMpnJQ=;
  b=JQ2AlGFsr0PG+bOabq8nFq4AaqLa3yNb1yp3Uq3kkHiiaCT3ZIE+Blnb
   alNTyL4655l/+ga9HquXdwTgANgEYMhBE9xKpd9rtcR2V0/seG0FTrEgc
   vZgiElKFPG0jg4UuRj7tJ4Kn5l2OhB/oB1NY3JjYduANmEiWnYGjhpZtn
   GLGUf77kQ+jTfEqJ6FmCiLOmqfdm770NGZtTlAcC6MUb/8sl7sKTB3iOO
   wIHGxUdX39R9I3aCBXgqGLaUaV6dgmwuX+3TH4qNYF/4zWFs3GPL3mvIY
   kSKqMhGfD+tZz3gua1njDed10PS6EpaOY3nzHsXaGin1Y1SeIHPY4KpRE
   w==;
X-CSE-ConnectionGUID: LqmXVQitTc+31zR8vdRKrQ==
X-CSE-MsgGUID: m2Eq9mBdSEycYxnlaGLhzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2906433"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2906433"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 22:28:20 -0800
X-CSE-ConnectionGUID: dDC3FJ4HRUiZkxNdI04Jew==
X-CSE-MsgGUID: 8BuU8J+vQNWWlYTz/ZuPGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="9820730"
Received: from unknown (HELO [10.238.3.151]) ([10.238.3.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 22:28:14 -0800
Message-ID: <f12bcb27-9c17-4b8c-b48c-c36a17e70ab6@linux.intel.com>
Date: Tue, 10 Nov 2026 14:28:10 +0800
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
To: "Chen, Zide" <zide.chen@intel.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-14-zide.chen@intel.com> <au491iiV7koeP0t6@google.com>
 <f20b59bb-a3c6-4129-ba61-5cec4d975601@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <f20b59bb-a3c6-4129-ba61-5cec4d975601@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/10/2026 4:41 AM, Chen, Zide wrote:
>
> On 11/6/2026 3:00 PM, Yosry Ahmed wrote:
>> On Thu, Nov 05, 2026 at 06:39:22PM -0700, Zide Chen wrote:
>>> PerfMon v5 adds a fixed-counter support bitmap in CPUID.0AH:ECX.
>>> This is the superset of EDX[4:0] which indicates the contiguous
>>> counters starting from 0. For backward compatibility, it's recommended
>>> to use the following to determine if a fixed counter is supported:
>>>
>>> FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i);
>>>
>>> Originally-by: Yang Weijiang <weijiang.yang@intel.com>
>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>> ---
>>> v3:
>>> - Remove '&' when populating entry->ecx. (Jim)
>>> - Gate entry->ecx on kvm_pmu_cap.version >= 5 in intel_pmu_refresh() to
>>>   avoid enabling v5 fixed counters on hosts where KVM caps PMU at v2.
>>> ---
>>>  arch/x86/kvm/cpuid.c         | 5 ++++-
>>>  arch/x86/kvm/vmx/pmu_intel.c | 8 ++++++++
>>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>>> index 3310c370c5fa..00a2ca6d3049 100644
>>> --- a/arch/x86/kvm/cpuid.c
>>> +++ b/arch/x86/kvm/cpuid.c
>>> @@ -1554,7 +1554,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>>  
>>>  		entry->eax = eax.full;
>>>  		entry->ebx = kvm_pmu_cap.events_mask;
>>> -		entry->ecx = 0;
>>> +		if (kvm_pmu_cap.version >= 5)
>>> +			entry->ecx = (u32)kvm_pmu_cap.fixed_cntr_mask64;
>>> +		else
>>> +			entry->ecx = 0;
>>>  		entry->edx = edx.full;
>>>  		break;
>>>  	}
>>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>>> index 1372091dc1f8..37b34b588601 100644
>>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>>> @@ -597,7 +597,15 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>>  				  find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
>>>  						      KVM_MAX_NR_FIXED_COUNTERS));
>>>  
>>> +	/* FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i) */
>>>  	fixed_mask = BIT_ULL(nr_fixed_counters) - 1;
>>> +	/*
>>> +	 * Do not enable fixed counters via the v5 ECX bitmap if KVM caps
>>> +	 * PMU version below 5 (e.g. when mediated PMU is disabled or on
>>> +	 * older hosts), matching KVM's advertised CPUID.0AH:ECX capability.
>>> +	 */
>>> +	if (kvm_pmu_cap.version >= 5 && pmu->version >= 5)
>> Having to check both versions is confusing. Can they go out of sync?
>> Should we clamp pmu->version to kvm_pmu_cap.version and only check the
>> former?
> Yes, actually, other fields (bit_width, mask_length, and
> nr_{gp,fixed}_counters) in intel_pmu_refresh() are clamped to
> kvm_pmu_cap as well.
>
> pmu->version = min_t(int, eax.split.version_id, kvm_pmu_cap.version);

I'm not quite sure if we could do such clamp. I remember Sean ever said KVM
should allow user space to set the PMU capabilities which KVM doesn't
support, like what currently kselftest pmu_counters_test does, e.g., KVM
only supports up to PMU version 2 in non-mediated vPMU mode, but
pmu_counters_test can set PMU versions larger than 2.


>
> Without this, as more advanced PMU features are supported in KVM, we
> will have to manually validate guest features, and it seems this doesn't
> violate the general principles of "not policing CPUID configurations"
> and using the "effective vPMU version".
>
>>> +		fixed_mask |= entry->ecx;
>>>  	fixed_mask &= kvm_pmu_cap.fixed_cntr_mask64;
>> I see why this is needed now, to re-apply KVM's fixed counter mask after
>> reading it, but if this is only needed there, it's probably clearer to
>> do:
>>
>> 	if (version >= 5)
>> 		fixed_mask |= (entry->ecx & kvm_pmu_cap.fixed_cntr_mask64);
> Agreed, this is cleaner. Will update accordingly. Thanks!
