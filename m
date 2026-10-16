Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC24392C28;
	Fri, 16 Oct 2026 02:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116753; cv=none; b=QAi4vQXzDbWF9hkR9Ol4Y0X6dFScJIc7Y7HBnou+dI116UabmtrxIJ956f2f4A012v8jpJXPkfG5uHTjUczo+qC3tr5G92PiBeOHPQ0J7teGhIXaaXQhKHwJA7AOIVkXvVhdUYHvPc28nXl7s4ec2QUfw/jH2U3Rw/bXlmtSh5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116753; c=relaxed/simple;
	bh=yVBPVX8R/mgsnsUKu9ZYT3wyx2eecn8EzTMeM0Xjm+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fz5e7XR3xRvd5w+jgoybK7c4bk7KOYmnn+Z6sCSzj9LI7d29Mywj5MQhC30+A5hLju3FSsvtVOsitTkCjdquSKaT+xJ1Qvwu9WH3Mck+vqw6S18UySLHDKngrTwnjaFO68X6csM3cGcF0E9l4z/juqoFLdMvyhpzDc/ZwS9XNQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUbN6DfV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUbN6DfV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792116752; x=1823652752;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yVBPVX8R/mgsnsUKu9ZYT3wyx2eecn8EzTMeM0Xjm+s=;
  b=NUbN6DfVx9nzNzELHVQRZEPIkVF+krezjpwFsFtu+8oURCnYfFYeW5nU
   /wSVJ6esoEmYfQFlc+h4NWKLcPv7qn8E+TBjQBl6Uqh00KG2a5oviKRbz
   IOgCzSfXbPfMplKLWIEGXweECG8aG16gpLbgAWf6Irf3MNDwRPMPsMCpH
   iGDimXVxiJGHaA+8nm3jyyBhgua0ZMfQKjMXjg+fp/3BFhOlg4Br1+k6c
   IRRscGKV7SLMLMFssNXY0jEPTX0vAxtSP7+xJHlZpsgp6s9iiPSXlX6R6
   w7vE5g+Dy58IkoGCIjV37jwdb09qrEtf+qn9fNt5OUWQgKfTmGOO4lvtG
   w==;
X-CSE-ConnectionGUID: EDSJwTN6SjiGOT+OwsQO5Q==
X-CSE-MsgGUID: Yi/8wDDpQO6jIcZX03BgOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="900067"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="900067"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 19:12:31 -0700
X-CSE-ConnectionGUID: H49bFA3cTFKQGL0uSmGcmA==
X-CSE-MsgGUID: jxlX/bbSSTuv0lpVX7vmsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1927201"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 19:12:25 -0700
Message-ID: <86b530c0-65ea-4b9c-a020-124fa5477275@linux.intel.com>
Date: Fri, 16 Oct 2026 10:12:22 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: TDX: Set SIGNIFCANT_INDEX flag for supported CPUIDs
To: Sean Christopherson <seanjc@google.com>
Cc: Changyuan Lyu <changyuanl@google.com>, rick.p.edgecombe@intel.com,
 binbin.wu@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, isaku.yamahata@intel.com, kas@kernel.org,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, mingo@redhat.com, pbonzini@redhat.com,
 tglx@kernel.org, x86@kernel.org, xiaoyao.li@intel.com
References: <213d614fe73e183a230c8f4e0c8fa1cc3d45df39.camel@intel.com>
 <20260224212939.2081828-1-changyuanl@google.com>
 <a578b2ff-52a4-4959-832d-a84b24ccb80e@linux.intel.com>
 <atGCN656hpWzSuci@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <atGCN656hpWzSuci@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/2026 9:47 AM, Sean Christopherson wrote:
> On Tue, Oct 13, 2026, Binbin Wu wrote:
>> On 2/25/2026 5:29 AM, Changyuan Lyu wrote:
>>
>> [...]
>>
>>> -----------------------
>>>
>>> >From 18b967b718911c09872c3717d8ab083fa59c4a70 Mon Sep 17 00:00:00 2001
>>> From: Changyuan Lyu <changyuanl@google.com>
>>> Date: Fri, 20 Feb 2026 09:55:28 -0800
>>> Subject: [PATCH] KVM: TDX: Set SIGNIFCANT_INDEX flag for supported CPUIDs
>>>
>>> Set the KVM_CPUID_FLAG_SIGNIFCANT_INDEX flag in the kvm_cpuid_entry2
>>> structures returned by KVM_TDX_CAPABILITIES if the CPUID is indexed.
>>> This ensures consistency with the CPUID entries returned by
>>> KVM_GET_SUPPORTED_CPUID.
>>>
>>> Suggested-by: Sean Christopherson <seanjc@google.com>
>>> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
>>
>>
>> Hi Sean,
>>
>> When I was preparing the v5 of the TDX CPUID patch series, the internal sashiko
>> reported a issue:
>>   > @@ -2359,6 +2359,15 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
>>   >  		if (!entry)
>>   >  			continue;
>>   >  
>>   > +		/*
>>   > +		 * Reject entries whose index doesn't match the expected one.
>>   > +		 * This catches userspace passing a CPUID entry with the
>>   > +		 * KVM_CPUID_FLAG_SIGNIFCANT_INDEX flag cleared when the index
>>   > +		 * is significant.
>>   > +		 */
>>   > +		if (entry->index != tmp.index)
>>   > +			return -EINVAL;
>>   
>>   [Severity: Medium]
>>   Does this unconditional check inadvertently break userspace VMMs that provide
>>   valid CPUID entries but leave the index field uninitialized for
>>   non-significant leaves?
>>   
>>   Since kvm_find_cpuid_entry2() ignores the index field when
>>   KVM_CPUID_FLAG_SIGNIFCANT_INDEX is cleared, VMMs are not architecturally
>>   required to zero the index for non-significant leaves. This check forces
>>   the index to be exactly 0 (since tmp.index is normalized to 0) even for
>>   leaves that do not have architecturally significant subleaves.
>>
>>
>> I think the issue is valid,
> 
> Yeah, requiring the index to be a specific value without SIGNIFCANT_INDEX set
> could break usrspace.
> 
>> so it needs to know whether the entry is a subleaf or not. I think it's more
> 
> By "it", I assume you mean userspace?

I meant the code to check the index mismatch in my previous implementation when
preparing the v5 of TDX CPUID validation patch series.

But I changed the implementation, which doesn't rely on the flag.
I.e. KVM validates the unsupported features against the same subleaf that the
values are copied into.

> 
>> reliable to do it via the information reported by the TDX module. i.e. my
>> patch set will rely on this patch to set KVM_CPUID_FLAG_SIGNIFCANT_INDEX for
>> entries that are indexed.
>>
>> Will you apply this patch?
>> Or I can include this patch in my patch set. Also, 0x23 is still missing in
>> cpuid_function_is_indexed(), I can add a patch to add 0x23 as well.
>>
>>> ---
>>>  arch/x86/kvm/vmx/tdx.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>>> index 2d7a4d52ccfb4..1c039eab2f3d8 100644
>>> --- a/arch/x86/kvm/vmx/tdx.c
>>> +++ b/arch/x86/kvm/vmx/tdx.c
>>> @@ -167,6 +167,7 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
>>>
>>>  	entry->function = (u32)td_conf->cpuid_config_leaves[idx];
>>>  	entry->index = td_conf->cpuid_config_leaves[idx] >> 32;
>>> +	entry->flags = 0;
>>>  	entry->eax = (u32)td_conf->cpuid_config_values[idx][0];
>>>  	entry->ebx = td_conf->cpuid_config_values[idx][0] >> 32;
>>>  	entry->ecx = (u32)td_conf->cpuid_config_values[idx][1];
>>> @@ -174,6 +175,9 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
>>>
>>>  	if (entry->index == KVM_TDX_CPUID_NO_SUBLEAF)
>>>  		entry->index = 0;
>>> +	else
>>> +		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> 
> Hrm, I'm getting deja vu.  Oh, this is an old thread.  *sigh*  I was expecting
> a new patch/thread, but it got "posted" inline.
> 
> I'll send a small v2.

Thanks.

