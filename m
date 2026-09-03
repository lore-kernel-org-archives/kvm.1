Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DD446AA6F;
	Thu,  3 Sep 2026 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425884; cv=none; b=QgbC0rGu6t1DSYa/ZZB7yUsoshKo0KWCpWeQJKLYJPfzE2TCjN9ZflUwtfBMQ1CYTekgZDBvxUn/VuQjPXMQ4ASTaKrJWmr+rjKKUqviPCjvuYIyMkYtbeFiYAY+RsZCU8m5Y2wJNucz6dallSiFZc/8rSzG9xF0NrFE+fuzLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425884; c=relaxed/simple;
	bh=hWrHSLg2+zvpVGSCVwAgQ5OuJxx8UpO1Y6HDmLAvLOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKz8RuWZuLaCjF3uD08wUalIExipJxC1vDUKechdeMQzeSo7PRe/jMa/dxeiKlLP51+RXAKXaFvIeIbXrOvyBWQERcU1Jdb4n7WmDEC3qS7KX1xXyVWeeLFUOg3Q63wDAMteJSQcBiZgeLifEYrsAuXG/bCdCtbLNBljKA/y454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cn/y/JCb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cn/y/JCb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788425882; x=1819961882;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hWrHSLg2+zvpVGSCVwAgQ5OuJxx8UpO1Y6HDmLAvLOk=;
  b=cn/y/JCbP84Xpc6Ceh58aulf7KE7Kwllum7d8PQwM9DE5E1JtjneN3VX
   0oX3Vc61AtXVgGDWrtuwiZmmAqkuAmQtlz0C82ftLcekGHW7Fzn/PVs9K
   XJdTlXBwDD6q+n7mZdBmq44L6+13LbQqSNZPYD6w18EZKHRFTk0heIlXW
   7xO5NdHrPlTHzfm6ARFb2HXLO0crUAA8x2k+rNfAl68KZz1eQDphseTBU
   e7cqJ+R7byBTLBigC5ea3jXJmbzP1RM7A4dpd+5NwYShb9F2fqVaxaqs4
   /amrcWQvXjA8We7nj1iYnfEFLnTsnjIKZYmu/txA4FDHFXhWgNKJeVt+O
   Q==;
X-CSE-ConnectionGUID: dH2vFOoST9eTAhGuHIKMAQ==
X-CSE-MsgGUID: hf2fYllHTDyM+KxXdbffWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92723077"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92723077"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:58:01 -0700
X-CSE-ConnectionGUID: wQseLNpHQtOVGDp1vfWXEA==
X-CSE-MsgGUID: JGJgAno4SF6lbgT9QG7aZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="267902903"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:57:59 -0700
Message-ID: <f9c47078-ff9d-4a87-a1ea-44245a511d81@linux.intel.com>
Date: Thu, 3 Sep 2026 16:57:56 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: Xiaoyao Li <xiaoyao.li@intel.com>, seanjc@google.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, dave.hansen@linux.intel.com,
 andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org,
 rick.p.edgecombe@intel.com, chao.gao@intel.com
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-2-binbin.wu@linux.intel.com>
 <55488b92-66a8-45e5-ad0f-8fed63ce1187@intel.com>
 <a30741f8-b99b-4f36-80a5-4688c2578d99@linux.intel.com>
 <6b565572-b316-4e86-906d-f150c896fe21@intel.com>
 <84891108-55be-48c1-9993-c730a5334d5b@linux.intel.com>
 <cfe57e67-49ce-47d7-b20b-a29e23fe16d4@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <cfe57e67-49ce-47d7-b20b-a29e23fe16d4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/3/2026 3:28 PM, Xiaoyao Li wrote:
> On 9/3/2026 12:19 AM, Binbin Wu wrote:
>> On 9/2/2026 11:09 PM, Xiaoyao Li wrote:
>>> On 9/2/2026 8:33 AM, Binbin Wu wrote:
>>>>>> +static void __init tdx_initialize_cpu_cfg_caps(void)
>>>>>> +{
>>>>>> +    tdx_cpu_cfg_cap_init(CPUID_1_ECX,
>>>>>> +        TDX_CFG_EXTRA_F(MWAIT),
>>>>>> +        TDX_CFG_F(TSC_DEADLINE_TIMER),
>>>>>> +        TDX_CFG_F(AVX),
>>>>>> +        TDX_CFG_F(F16C),
>>>>>> +    );
>>>>> TDX 1.5.24 on SPR report configurable bits of CPUID_1_ECX as
>>>>> 0x31044988, which have
>>>>>
>>>>> - bit 3        MWAIT
>>>>> - bit 7        EST
>>>>> - bit 8        TM2
>>>>> - bit 11    SDBG
>>>>> - bit 14    XTPR
>>>>> - bit 18    DCA
>>>>> - bit 24    TSC_DEADLINE_TIMER
>>>>> - bit 28    AVX
>>>>> - bit 29    F16C
>>>>>
>>>>> but EST/TM2/SDBG/XTPR/DCA are not list here. I guess the reason is kvm_cpu_cap[] doesn't support it. If so, it seems to guard twice:
>>>>> 1. mentally/manually check if it a feature is supported in kvm_cpu_caps[]
>>>>>
>>>>> 2. kvm_cpu_caps guarding in tdx_cpu_cfg_cap_init().
>>>>>
>>>>> I think 1) is not necessary, we can rely on 2)
>>>> In general, if a feature is not supported by the common KVM CPU caps, 
>>> For kvm-intel.ko, kvm_cpu_caps[] just means the supported CPUID features
>>> for VMX VMs. Treat it as the common KVM CPU caps is a bit arguable.
>>>
>>>> I prefer not
>>>> to add it to the list to save a few lines of code, which probably is dead code,
>>> I don't think it's dead code. It shows that these features are
>>> virtualizable to TDs from the POV. of TDX.
>> It depends on whether KVM allows userspace to set features for TDs that are not support
>> for non-TDX VMs (,except for a few exceptions).
>>
>> In this version, TDX_CFG_F() already check against kvm_cpu_caps[], if these features
>> are not in kvm_cpu_caps[], it will not be exposed to userspace anyway.
>>
> 
> I still think the reasoning that we omit them because they are not
> contained in kvm_cpu_caps[] sounds not right. 

TBH,I omitted these bits for simplicity.
It's not just adding a TDX_CFG_F(XXX) for a feature, but also need to
add new X86_FEATURE_XXX definitions sometimes.
E.g. CPUID.7.0.ECX[0] (PREFETCHWT1), which is directly configurable and not
supported by KVM. It has no definition in <asm/cpufeatures.h>.

I am not sure that's worth it.

> Based on it, so when we are
> going to add a new feature for TDX, we need to first manually check the KVM
> code to see if that feature is contained in kvm_cpu_caps[] already. If not,
> we just don't add it to TDX's list. Then why need to cap the result
> kvm_cpu_caps[] for TDX_CFG_F() again? 

This is due to "generally speaking, KVM shouldn't allow features that KVM doesn't
support for non-TDX VMs".

I'm hoping Sean can weigh in on whether KVM should restrict TDX's CPU capabilities
in this way.

> Just for safety in case human make
> mistake and misread the code of kvm_cpu_caps[]?
> 
> I think they are two independent steps:
> 1. list the CPUID features that KVM can support for TDs.
> 2. apply additional restrictions, e.g., if a feature is not allowed for
> non-TDX VMs, it cannot be allowed for TDs.
> 
>>> In the end, they might be disallowed to be configured to TDs because KVM
>>> doesn't allow them for VMX VMs. This is also the point I want to discuss.
>>> Do we really want to make such restriction that KVM cannot enable/allow a
>>> feature for TDs unless KVM first enables/allows it for VMX VMs? What's
>>> reason behind it?
>> Sean mentioned it that "generally speaking, KVM shouldn't allow features
>> that KVM doesn't support for non-TDX VMs" in
>> https://lore.kernel.org/kvm/aj1fi_0SBxMK5WOB@google.com/
> 
> For existing features, it might make some sense. But for new features, I
> don't think so. It defines the enabling order for new features that we must
> enable a feature for non-TDX VMs first and then TDs. And people might want
> to bypass this rule by abusing the TDX_CFG_EXTRA_F() when only one line of
> TDX_CFG_EXTRA_F() is enough to enable a feature for TDs but more effort
> required to enable it for non-TDX VMs.

Oh, you just remind me that I should add comment for TDX_CFG_EXTRA_F() that
it must be used with a strong justification.

> 
> Maybe I miss somthing. I would like to see stronger reasons for such decision.

