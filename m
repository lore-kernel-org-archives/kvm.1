Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366B941F5CA;
	Thu, 24 Sep 2026 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236193; cv=none; b=cPC48FTR4ZJzYOBuoBFdjNF4Bs5kIeIP3RWFam/32vL9dS0eFo1iQBSgBY/YS8m913KI7VUFcHk0QrPYUR+lQ/0KqQuGQfJajW9j1UBicLG2knuy5XrxYd/ODUhr1LbDmbxvMJMTsIz7fTX+c9Pwbmjmp4j6BFhNWgab/+lY7II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236193; c=relaxed/simple;
	bh=TpkAp2xl8VUoc1MOiXnXhebcZEXL65twEmm9Rhkh8n4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRgRoVoXGShFpoEszj1/pLrl24lk5z3GfSPz+XpipYs3CNomopJUrUj0f3VXqG1AQNJRtYsMcHtMxkYCHMl1JOxw2CzKBpFQtwqHZTsBYo3kA3HESoXL0rZpG49coiel6klCCnIcHfe2RxUIGNsn7sthww06g3/h1/+IsoXKwsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1XnexKv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1XnexKv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790236191; x=1821772191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TpkAp2xl8VUoc1MOiXnXhebcZEXL65twEmm9Rhkh8n4=;
  b=H1XnexKvPRZ40sGVQH07L1FBnFbF5ZulxW2eE3xWTgb+k3Rmi8TDIHbO
   WbMglvmC62bV4UsEJRfUesRGwnlpjV94iqwjpk5RkDGTDRExWc1wM+ODz
   mUO7ofYkTYkgoggcjN93egFxGn/FXUMu4AkN3ooW/C1lYkNPNV1ydNOJj
   pnbiJ5qNfrhZCyPjXyXem93g0kdqE2Jji/WtuvX7FD6QzSVzVLP6yVO+a
   +4Goyw0oVbxsbJRBohJdUk6jJebfLIqWWMTqm/2KZlnoClJHHu9F88veX
   KhptnAJ+e1lTdEaFBYLSAEjYgd/+6t5dNTqJQAvAy28Ui6BuDwY+oEOsz
   A==;
X-CSE-ConnectionGUID: w07YFKpgTXW3qAyyWT2SrA==
X-CSE-MsgGUID: vrGrBs13Scy6Su/eftgFvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="89954810"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="89954810"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 00:49:50 -0700
X-CSE-ConnectionGUID: 0JZefgtJRYa0w/pdGw1cXA==
X-CSE-MsgGUID: KFuxz9k/TmejVKzhHLlL7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="271783705"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 00:49:48 -0700
Message-ID: <062f5365-7eb5-4e04-9c84-f5ecd566f019@linux.intel.com>
Date: Thu, 24 Sep 2026 15:49:45 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
 pbonzini@redhat.com, dave.hansen@linux.intel.com, andrew.cooper3@citrix.com,
 nik.borisov@suse.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 chao.gao@intel.com, tony.lindgren@linux.intel.com, kishen.maloor@intel.com,
 dedekind1@gmail.com
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
 <20260917072548.2314491-2-binbin.wu@linux.intel.com>
 <39047bbc-757d-4131-a25c-5a7743fd591a@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <39047bbc-757d-4131-a25c-5a7743fd591a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/2026 2:36 PM, Xiaoyao Li wrote:

Thanks a lot for the detailed review!

> On 9/17/2026 3:25 PM, Binbin Wu wrote:
>> Add tdx_cpu_cfg_caps[] to track the subset of TDX directly configurable
>> CPUID feature bits that KVM supports, and build the masks during TDX
>> hardware setup via tdx_initialize_cpu_cfg_caps().
>>
>> The TDX module reports the CPUID bits that the VMM can directly configure
>> for a TD, but KVM cannot blindly expose all reported bits to userspace.
>> Certain features imply additional architectural state, e.g. one or more
>> MSRs, that KVM must explicitly manage across host/guest transitions to
>> prevent host state corruption.  The existing hardcoded denylist cannot
>> account for new host state clobbering features introduced by future TDX
>> modules.
>>
>> Except for a few fixed-1 bits required for basic TDX support, host state
>> clobbering features are either directly configurable or gated by TD
>> ATTRIBUTES/XFAM, which KVM already validates.  Tracking only the directly
>> configurable bits to build an allowlist is therefore sufficient.
>>
>> Organize tdx_cpu_cfg_caps[] following kvm_cpu_caps[] so that the masks can
>> be built with similar feature-name based initializers.  Directly
>> configurable non-feature bits will be handled separately.
>>
>> The allowlist is prepared to be consumed by later patches to filter
>> KVM_TDX_CAPABILITIES and to reject unsupported CPUID input to
>> KVM_TDX_INIT_VM, so that newly introduced TDX directly configurable CPUID
>> feature bits stay hidden from userspace until KVM explicitly opts in.
>>
>> By default, intersect the allowlist with kvm_cpu_caps[] via TDX_CFG_F().
>> Requiring support for non-TDX VMs avoids committing to TDX-specific
>> behavior before general KVM support is established, and respects KVM's
>> logic around disabling certain features, since the reasons for disabling
>> them could apply to TDX as well.  Allow exceptions through
>> TDX_CFG_EXTRA_F() only with sufficient justification.
> 
> One name just crosses my mind. How about TDX_CFG_INDEP_F()? where INDEP stands
> for independent.
> 
> - TDX_CFG_F() for features that are dependent on kvm_cpu_caps[]
> - TDX_CFG_INDEP_F() for features not dependent on kvm_cpu_caps[]

I am not sure if it's better.
But if people prefer independent to extra, I would use TDX_CFG_INDEPENDENT_F()
instead.

> 
>> Add comments as placeholders for HLE, RTM, WAITPKG and FRED, which KVM
>> doesn't support for TDX yet.
> 
> 1. why add comments for them? Because implementation wise, they are possible to
> be supported by KVM but just current KVM doesn't have code to support them yet?
> 
> If so, are the others the features that are concluded to be impossible to be
> supported by KVM?
> 
> 2. We don't need to talk about FRED, which is even not suppported for normal VMs
> yet. Unless we are trying to enable FRED for TDs specifically.

OK, I will drop them to avoid confusion.

> 
>> Allow MWAIT, XTPR, and HT through TDX_CFG_EXTRA_F(), as these bits are
>> not advertised in kvm_cpu_caps[].  The remaining directly configurable
>> feature bits outside kvm_cpu_caps[] are left out of the allowlist:
>>
>>   - Features forced to zero when #VE is reduced, or lacking KVM support
>>     for the associated MSRs: EST, TM2, SDBG, DCA, ACPI, ACC (TM), RDT_A,
>>     RDT_M, TME, PCONFIG, and CORE_CAPABILITIES.  Handle CORE_CAPABILITIES
>>     in a subsequent patch.
> 
> why not split into two category? Because they are overlapped?
> 
>   - Features forced to zero when #VE is reduced
>   - Features lack KVM support
>

Yes, there is overlap between them.
If split into two categories, it would be:
- Features forced to zero when #VE is reduced, which also lack KVM support
- Features unrelated to #VE reduction that lack KVM support

Because the changelog was already getting quite long, I combined them into a
single category.
 
> As for "features forced to zero when #VE is reduced", do you mean when TDX
> module supports "#VE reduction" feature, the features becomes fixed0? or when
> guest enables "reduce #VE", the guest see a 0 value even though the feature is
> still configurable to host userspace and host userspace configure it to 1?


#VE is reduced means the guest reduced the related #VE, i.e. TDCS.TD_CTRL.REDUCE_VE
is 1 and the related bit in TDCS.FEATURE_PARAVIRT_CTRL is 0.

> 
>>   - Features tied to IA32_MISC_ENABLE bits that a TD cannot set when
>>     TDCS.TD_CTLS.REDUCE_VE is set: CID and PBE.
> 
> What is CID?

X86_FEATURE_CID, Context ID, more specifically, L1 CONTEXT ID

> and Is PBE related to any bit of IA32_MISC_ENABLE? Did you mean PEBS instead?

X86_FEATURE_PBE, Pending Break Enable.

Since kernel already has X86_FEATURE_XXX for them, so I use them directly without
other description.

> 
> I don't understand what this category. It talks about something when
> TDCS.TD_CTLS.REDUCE_VE is set, which depends on guest TD's behavior. So what if
> the guest TD doesn't set TDCS.TD_CTLS.REDUCE_VE?

If the guest set TDCS.TD_CTLS.REDUCE_VE, write 1 to the the related bit trigger #GP.
If the guest doesn't set TDCS.TD_CTLS.REDUCE_VE, the value is passed to KVM, and
KVM will save the value without do corresponding virtualization.

Considering TDCS.TD_CTLS.REDUCE_VE is set by the Linux guest by default, it should
not allow these features.

> 
>>   - Features that can clobber host state and lack KVM support for TDX:
>>     FRED.
>>
>>   - Unsupported features: PREFETCHWT1 (Xeon Phi only), PSN (absent from
>>     TDX-capable CPUs), AMX-TRANSPOSE (never implemented on an Intel
>>     platform), and RAO_INT (defined only for future processors).
> 
> PREFETCHWT1 (if the name is correct) is not supported by the kernel right? For
> such unknown features, it's straightforward to not support it.
> 
> AMX-TRANSPOSE has been turned into reserved, and kernel never supports it. I
> think we don't need to mention it at all.

The guest could be other OS, not just Linux.

> 
> RAO_INT is fixed 0 for TDX 1.5?

I was doing this patch series based on the latest CSV version of the CPUID
virtualization document from "Intel TDX Module ABI Definitions" updated in June 2026.
https://cdrdv2.intel.com/v1/dl/getContent/795381

> 
> At last, I think we can just classify all of the above as 3 types:
> 
> - Features that are directly configurable by TDX and in kvm_cpu_caps[].
>   use TDX_CFG_F()
> 
> - Features that are directly configurable by TDX and KVM actually supports them
>   or KVM can support them but not in kvm_cpu_caps[]. Use TDX_CFG_EXTRA_F().
>   For example, MWAIT, XTPR, and HT.
> 
> - Features that are directly configurable by TDX but KVM or kenrel doesn't
>   support them.
>   For example, RDT_A, RDT_M, PREFETCHWT1, PSN,

Because excluding some bits changes the ABI, I listed all these directly configurable
features out of kvm_cpu_caps[] to explain why we must exclude some bits.

