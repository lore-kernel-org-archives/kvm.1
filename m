Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD023D9DAA
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685053; cv=none; b=eLs/BZLQezy6QdAJNMhdLaDt7VA+IUa6Jm20FcXXirK1n0FRMS0fksAubBQJ1LAKhL6YvEyWTXyamHGIeuFSAC4ksaDuj4UodVNUXInZHce4yXBaY1tXVwJ7152teHwbeL/ka4ofjcep0pB5DWCPv7n6L8hwIBbWvSba80Sz3Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685053; c=relaxed/simple;
	bh=72hT51VxRJyxkK0JYHMV74Zb0BaPjnY4ymN1gjKZSIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJtwwVhKS7yKaik6YWjqbkBcIXItdq7C8w61RMRmZGyR634xvKnZgLwk51ETEewWXXDwjqgIbAcKou1+FUj9FxRXkbqaGcP8KlfL0QFCJSnxh61ZmMECmL8eGBSUCwipXDcvlKPdTk8Jrz6mIbEfmjYqTCjV+WymgTy6UZEhsEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgoAPA4L; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgoAPA4L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773685050; x=1805221050;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=72hT51VxRJyxkK0JYHMV74Zb0BaPjnY4ymN1gjKZSIo=;
  b=NgoAPA4Lp+7BW89fJR//UqJVXYTEjSngDEMRtfnuUh+YwjuLGICIiBPH
   8Ea+hhOb5PRgVTpFh4/qTXXRzlwq9i7nKXgdqhoQa2l98d+p99ARlBeE5
   1cKaK+toInpk1933l9KMQOODSqfZebppeZiNr2bMECmwZsbrm0rFGVg6e
   uPTHV0pMoO+nEous04oDX8YGH3hs4ZMHcxe9Zfde0d7YyK9+JpQpjJlRH
   dmoVcOf4WLDRI+I94m02Jj5+/tVgreWJZuPdGgehoGnBGqd56Koatj8QT
   7j1DtPOOifDE6Zw/9RC5JlWX5x0oK/gpPLNyTGE2AHDSW2bgEKuCWjTg0
   g==;
X-CSE-ConnectionGUID: EHaLAwSaQEmd+uVDh2SxDQ==
X-CSE-MsgGUID: Pt1OfzRNTXalCCSBjdzrjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85793258"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85793258"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:17:29 -0700
X-CSE-ConnectionGUID: FEqglwq+RFm7JEAodbB96Q==
X-CSE-MsgGUID: gJEul5DvQymRKgJ3rOGn7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="216482156"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.241.241.35]) ([10.241.241.35])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:17:28 -0700
Message-ID: <12ea3e8f-a88e-48fe-9b5c-c41b9f220829@intel.com>
Date: Mon, 16 Mar 2026 11:17:28 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 12/13] target/i386: Clean up Intel Debug Store feature
 dependencies
To: Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Sandipan Das <sandipan.das@amd.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Hector Cao <hector.cao@canonical.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-13-zide.chen@intel.com>
 <9122d003-1e96-4790-ab32-3e06b0aa1148@intel.com>
 <73e47641-d3ca-4b4e-b403-20cf786adf4d@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <73e47641-d3ca-4b4e-b403-20cf786adf4d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/15/2026 11:57 PM, Xiaoyao Li wrote:
> On 3/16/2026 11:21 AM, Chenyi Qiang wrote:
>>
>>
>> On 3/5/2026 2:07 AM, Zide Chen wrote:
>>> - 64-bit DS Area (CPUID.01H:ECX[2]) depends on DS (CPUID.01H:EDX[21]).
>>> - When PMU is disabled, Debug Store must not be exposed to the guest,
>>>    which implicitly disables legacy DS-based PEBS.
>>>
>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>> ---
>>> V3:
>>> - Update title to be more accurate.
>>> - Make DTES64 depend on DS.
>>> - Mark MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL in previous patch.
>>> - Clean up the commit message.
>>>
>>> V2: New patch.
>>> ---
>>>   target/i386/cpu.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 2e1dea65d708..3ff9f76cf7da 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -1899,6 +1899,10 @@ static FeatureDep feature_dependencies[] = {
>>>           .from = { FEAT_1_ECX,             CPUID_EXT_PDCM },
>>>           .to = { FEAT_PERF_CAPABILITIES,       ~0ull },
>>>       },
>>> +    {
>>> +        .from = { FEAT_1_EDX,               CPUID_DTS},
>>> +        .to = { FEAT_1_ECX,                 CPUID_EXT_DTES64},
>>> +    },
>>>       {
>>>           .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
>>>           .to = { FEAT_VMX_PROCBASED_CTLS,    ~0ull },
>>> @@ -9471,6 +9475,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error
>>> **errp)
>>>               env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
>>>           }
>>>   +        env->features[FEAT_1_EDX] &= ~CPUID_DTS;
>>>           env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
>>
>> This change, along with the original CPUID_7_0_EDX_ARCH_LBR clear,
>> will also affect the configuration for TD VMs.
>> For a TD VM, enable_pmu controls TDX_TD_ATTRIBUTES_PERFMON, CPUID_DTS
>> is fixed to 1, and arch_lbr is controlled by XFAM[15].
>> These features' configuration do not have dependencies on each other.
>> So how about skipping the TD VM case like:
> 
> I think the dependency between enable_pmu and ARCH_LBR still applies to
> TDX. This dependency is defined by QEMU that enable_pmu controls all the
> PMU features, including ARCH_LBR. So we can enforce the rule of
> "XFAM[15] cannot be 1 when enable_pmu == 0"

Yes, when !enable_pmu, XSTATE_ARCH_LBR_MASK will be cleared in
FEAT_XSAVE_XSS_LO, and therefore the ARCH_LBR bit in XFAM will also be
cleared. As a result, CPUID_7_0_EDX_ARCH_LBR will ultimately be cleared
from the guest CPUID. However, it is better to follow the spec and leave
it unchanged here.

> For CPUID_DTS, it seems OK to expose it even when PMU is disabled?
> I sort of disagree with the statement in the changelog:
> 
>   - When PMU is disabled, Debug Store must not be exposed to the guest,
>     which implicitly disables legacy DS-based PEBS

As you mentioned, the dependencies of enable_pmu are defined by QEMU.
If the DS bit remains set when !enable_pmu, it looks inconsistent.

> If I read SDM correctly, the availability of legacy PEBS can be
> enumerated by MSR_IA32_MISC_ENABLE.PEBS_UNAVAILABLE bit. And from the
> linux code, it also proves that DTS can be 1 while PEBS is 0:
> 
>     if (boot_cpu_has(X86_FEATURE_DS)) {
>         unsigned int l1, l2;
> 
>         rdmsr(MSR_IA32_MISC_ENABLE, l1, l2);
>         if (!(l1 & MSR_IA32_MISC_ENABLE_BTS_UNAVAIL))
>             set_cpu_cap(c, X86_FEATURE_BTS);
>         if (!(l1 & MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL))
>             set_cpu_cap(c, X86_FEATURE_PEBS);
>     }

MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL are sufficient to prevent the
guest from enumerating the PEBS feature.

However, keeping CPUID_DTS set has some negative impacts. For example,
it may incorrectly determine the availability of IA32_DS_AREA.


> Since it will need nasty handling for TDX case, I would vote not
> clearing CPUID_DTS here when !PMU, unless a strong reason is provided.

The "nasty handling for TDX" code already there, adding CPUID_DTS may
not make it worse. :) Accepting Chenyi's suggested code seems reasonable
and clean.


> 
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 98e95d0842..458bfb07b9 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -9736,8 +9736,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error
>> **errp)
>>               env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
>>           }
>>
>> -        env->features[FEAT_1_EDX] &= ~CPUID_DTS;
>> -        env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
>> +        if (!is_tdx_vm()) {
>> +            env->features[FEAT_1_EDX] &= ~CPUID_DTS;
>> +            env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
>> +        }
>>       }
>>
>>       for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
>>
>>
>>
>>>       }
>>>   
>>
> 

