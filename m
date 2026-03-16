Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E391519B4
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685064; cv=none; b=kJA9x3II84APRKEFDHhwlS7AYn7IRE6doLBOuoxJR6A/7Mb6vA+Pi1R6SsOJRH/xp6YPW7FRLs1K+narJSCqoolSLrqdD8pHbif6mtXS/MsYOrnbgGxcLxUnnJQt5PV4fZmsx0XOjkgGZIVmEDgfL0YxhpRnHpkbozCrjU0+sDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685064; c=relaxed/simple;
	bh=KyPEPqesLYTOsWwjXlMYthd6Gd2uEGN/gOmmt8vtMFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UesqoXPX4ehKRtAH6rsMll9vyyLvJnl4oE6xPkhR8OA46baMo7stLCXubis9JitofLZZPlKkZM86lnn5v26qBqCAgD54ePS1gSptDsWifHi0ABpgI4SZbZI9RmlHzLfQmn8sjiFh2hgX5LGxREY8KJtLTsjkn6Vb8dIUPNoPlLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sy07jS90; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sy07jS90"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773685060; x=1805221060;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KyPEPqesLYTOsWwjXlMYthd6Gd2uEGN/gOmmt8vtMFA=;
  b=Sy07jS903Bc9uK1sOiAmirUO2wOussUeDlG2yF6iUkS89ekf0RT9mErf
   Dc94pblzZ9TRHAvQCXqYWy+fVtC0VjRtbPKfM8dKzhbyk8hrVVZ1X6M1Q
   veRv60k1EJXWO+WgEZDlAlN/m/M6Leo6Eqqd02BIzNF176QG2T4DDnk+i
   iLXqjP8G+qB2oDhgnKR2AolUEciIBIr4Nx3lwCtEaQ/QTqrv8/ZYGrmQb
   VGCxUtjmQKsZ7b4iVGYoRR6eBjovNZJL4xf7hRThX3gRBVpahaKdpQhVk
   aUnTZkpaOz1GeyZgPeJxhLPLCnEB9SwxzE3bI/9zHUsM/Z46CkYuL9tzP
   w==;
X-CSE-ConnectionGUID: WNYJS9ETSHOsxg9nTMFVeA==
X-CSE-MsgGUID: I6xNGYqMTt206AdXn1rUog==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85793274"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85793274"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:17:40 -0700
X-CSE-ConnectionGUID: fDtS/vM9SE2zpGpgmBygew==
X-CSE-MsgGUID: xRLGUM+ISQ+wIh4TzWD+Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="216482181"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.241.241.35]) ([10.241.241.35])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:17:37 -0700
Message-ID: <0e81f486-6609-4181-9b85-161c69fbb704@intel.com>
Date: Mon, 16 Mar 2026 11:17:35 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 12/13] target/i386: Clean up Intel Debug Store feature
 dependencies
To: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Sandipan Das <sandipan.das@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Hector Cao <hector.cao@canonical.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-13-zide.chen@intel.com>
 <9122d003-1e96-4790-ab32-3e06b0aa1148@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <9122d003-1e96-4790-ab32-3e06b0aa1148@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/15/2026 8:21 PM, Chenyi Qiang wrote:
> 
> 
> On 3/5/2026 2:07 AM, Zide Chen wrote:
>> - 64-bit DS Area (CPUID.01H:ECX[2]) depends on DS (CPUID.01H:EDX[21]).
>> - When PMU is disabled, Debug Store must not be exposed to the guest,
>>   which implicitly disables legacy DS-based PEBS.
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
>>  target/i386/cpu.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 2e1dea65d708..3ff9f76cf7da 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -1899,6 +1899,10 @@ static FeatureDep feature_dependencies[] = {
>>          .from = { FEAT_1_ECX,             CPUID_EXT_PDCM },
>>          .to = { FEAT_PERF_CAPABILITIES,       ~0ull },
>>      },
>> +    {
>> +        .from = { FEAT_1_EDX,               CPUID_DTS},
>> +        .to = { FEAT_1_ECX,                 CPUID_EXT_DTES64},
>> +    },
>>      {
>>          .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
>>          .to = { FEAT_VMX_PROCBASED_CTLS,    ~0ull },
>> @@ -9471,6 +9475,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>>              env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
>>          }
>>  
>> +        env->features[FEAT_1_EDX] &= ~CPUID_DTS;
>>          env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
> 
> This change, along with the original CPUID_7_0_EDX_ARCH_LBR clear, will also affect the configuration for TD VMs. 
> For a TD VM, enable_pmu controls TDX_TD_ATTRIBUTES_PERFMON, CPUID_DTS is fixed to 1, and arch_lbr is controlled by XFAM[15].

Yes, I agree. In the TDX case, neither the DTS nor the arch_lbr bit
should be cleared.


> These features' configuration do not have dependencies on each other. So how about skipping the TD VM case like:
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 98e95d0842..458bfb07b9 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -9736,8 +9736,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>              env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
>          }
> 
> -        env->features[FEAT_1_EDX] &= ~CPUID_DTS;
> -        env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
> +        if (!is_tdx_vm()) {
> +            env->features[FEAT_1_EDX] &= ~CPUID_DTS;
> +            env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
> +        }
>      }
> 
>      for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
> 
> 
> 
>>      }
>>  
> 

