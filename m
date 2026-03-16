Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18AB233721
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644245; cv=none; b=GTJMrLwKVES0cjrmVoOIA1RSJaJlbZvY07zoaQK+K0IA61F0SsCUO95Y5efDtxOehKIyAcAlrnktvrzhpWzUZQ2KgpsHs/6Mo6DTCpmVrwAkQxSiU8UpaHs6v6RRorovXepVael/XHDDmYOL6D7QsPh6pPvA078fbJaeVlQ9lCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644245; c=relaxed/simple;
	bh=ikjjQFWIO9CXQ3I3SabG0ENTuv5ofEzCswItIvFSxdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shO8sRRxgvbZr6Cits1iiHAFbHX0oYZ4EG9XIOwREPXAN4Ij5nqEUC8DjTKv2AcpLTIGbqsXA4xmJNr+s5U+QjKX4kXFwObhDmtdrhANF7rj1rI1jMAJkoLyXpM2HhA4zx6JFHuMdBZsDRpmJieO0mPTpj637xOTfva2iD3ujnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSS1YwnW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSS1YwnW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773644243; x=1805180243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ikjjQFWIO9CXQ3I3SabG0ENTuv5ofEzCswItIvFSxdE=;
  b=JSS1YwnWOHVRZSQnaSgFUH3lJm9bRs6M1Ve9KG3dRpPsDzNb6abGHllP
   T+THI8RyRmuqZp8Hrpg+KdaT2aZzVLKLFALNkb8cAkUEtL6hC6f0uqAKH
   ChclEfQJKvXZmsjn1gorSXFBeh+kG11xGMncThlZGSyK4e799euljwBIQ
   u5jFBUQEu2vSjCwbZntdcJxQmAO+45MLq/DAtr77QaAdF/V2SN0HGYyy8
   BmHgdmKAI2gb4ftPdms38DdY3mtVERFtRIwWb7dM2aUNMYZAEyCAzJ/qp
   mNsPQub4diCy+Q8JOaXJ9RXVHWb2RxjPWdSqS+X8cv8QeBqtRaAMxQ2bk
   g==;
X-CSE-ConnectionGUID: XlLdDTuQSEuHbCKNeiIJQQ==
X-CSE-MsgGUID: KYrIj5LeRfuISLB7hQdaZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="78546559"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="78546559"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 23:57:22 -0700
X-CSE-ConnectionGUID: gmVwYDiKTZO8spHn2Ci5jA==
X-CSE-MsgGUID: kmXb2FXAQfaKu2yu6UKCPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="216381476"
Received: from unknown (HELO [10.238.1.107]) ([10.238.1.107])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 23:57:20 -0700
Message-ID: <73e47641-d3ca-4b4e-b403-20cf786adf4d@intel.com>
Date: Mon, 16 Mar 2026 14:57:18 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 12/13] target/i386: Clean up Intel Debug Store feature
 dependencies
To: Chenyi Qiang <chenyi.qiang@intel.com>, Zide Chen <zide.chen@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Sandipan Das <sandipan.das@amd.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-13-zide.chen@intel.com>
 <9122d003-1e96-4790-ab32-3e06b0aa1148@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <9122d003-1e96-4790-ab32-3e06b0aa1148@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/16/2026 11:21 AM, Chenyi Qiang wrote:
> 
> 
> On 3/5/2026 2:07 AM, Zide Chen wrote:
>> - 64-bit DS Area (CPUID.01H:ECX[2]) depends on DS (CPUID.01H:EDX[21]).
>> - When PMU is disabled, Debug Store must not be exposed to the guest,
>>    which implicitly disables legacy DS-based PEBS.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> V3:
>> - Update title to be more accurate.
>> - Make DTES64 depend on DS.
>> - Mark MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL in previous patch.
>> - Clean up the commit message.
>>
>> V2: New patch.
>> ---
>>   target/i386/cpu.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 2e1dea65d708..3ff9f76cf7da 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -1899,6 +1899,10 @@ static FeatureDep feature_dependencies[] = {
>>           .from = { FEAT_1_ECX,             CPUID_EXT_PDCM },
>>           .to = { FEAT_PERF_CAPABILITIES,       ~0ull },
>>       },
>> +    {
>> +        .from = { FEAT_1_EDX,               CPUID_DTS},
>> +        .to = { FEAT_1_ECX,                 CPUID_EXT_DTES64},
>> +    },
>>       {
>>           .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
>>           .to = { FEAT_VMX_PROCBASED_CTLS,    ~0ull },
>> @@ -9471,6 +9475,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>>               env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
>>           }
>>   
>> +        env->features[FEAT_1_EDX] &= ~CPUID_DTS;
>>           env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
> 
> This change, along with the original CPUID_7_0_EDX_ARCH_LBR clear, will also affect the configuration for TD VMs.
> For a TD VM, enable_pmu controls TDX_TD_ATTRIBUTES_PERFMON, CPUID_DTS is fixed to 1, and arch_lbr is controlled by XFAM[15].
> These features' configuration do not have dependencies on each other. So how about skipping the TD VM case like:

I think the dependency between enable_pmu and ARCH_LBR still applies to 
TDX. This dependency is defined by QEMU that enable_pmu controls all the 
PMU features, including ARCH_LBR. So we can enforce the rule of 
"XFAM[15] cannot be 1 when enable_pmu == 0"

For CPUID_DTS, it seems OK to expose it even when PMU is disabled?
I sort of disagree with the statement in the changelog:

   - When PMU is disabled, Debug Store must not be exposed to the guest,
     which implicitly disables legacy DS-based PEBS

If I read SDM correctly, the availability of legacy PEBS can be 
enumerated by MSR_IA32_MISC_ENABLE.PEBS_UNAVAILABLE bit. And from the 
linux code, it also proves that DTS can be 1 while PEBS is 0:

	if (boot_cpu_has(X86_FEATURE_DS)) {
		unsigned int l1, l2;

		rdmsr(MSR_IA32_MISC_ENABLE, l1, l2);
		if (!(l1 & MSR_IA32_MISC_ENABLE_BTS_UNAVAIL))
			set_cpu_cap(c, X86_FEATURE_BTS);
		if (!(l1 & MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL))
			set_cpu_cap(c, X86_FEATURE_PEBS);
	}

Since it will need nasty handling for TDX case, I would vote not 
clearing CPUID_DTS here when !PMU, unless a strong reason is provided.

> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 98e95d0842..458bfb07b9 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -9736,8 +9736,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>               env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
>           }
> 
> -        env->features[FEAT_1_EDX] &= ~CPUID_DTS;
> -        env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
> +        if (!is_tdx_vm()) {
> +            env->features[FEAT_1_EDX] &= ~CPUID_DTS;
> +            env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
> +        }
>       }
> 
>       for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
> 
> 
> 
>>       }
>>   
> 

