Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE83222A4EE;
	Thu, 24 Sep 2026 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242243; cv=none; b=puZ2ilhXYWVMtyoAMsU1VvuROEts6d0am2vVlCeib707LNVTP8YVatFLKXpQYZY4iIymEItNJXxXCOzO6t3jjaT7uLNZw25FxJkMlfVHPD+8yA57d6808DKUmuaosUlgGvcW/OEbEcr883EWUlGqexM1YMP7MaKvWiyYAhLFnEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242243; c=relaxed/simple;
	bh=uRbXECVa57tm4T6YlvH/CitT0T3Ec9bEFz84rOg1SE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VyBiQWzhlRKp29IJ1SIYJRXnFEUg0aciSeBXZA18Gx1IHASfsBkbWjV760het3cw1IRFt3lh6qjCbLDFIP0LM5tXocxMCdolk/jHKouXRLY+jXN5DjL2YDuKdKiRobeJaGkmeofrZVEvQ6jdqW+24sUOgiom0BmNhtAr0kLRcgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLGRqKCS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLGRqKCS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790242240; x=1821778240;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uRbXECVa57tm4T6YlvH/CitT0T3Ec9bEFz84rOg1SE0=;
  b=dLGRqKCS8Y7I5p9Lj2NmnFE4nLKC0yY41AVTJpoYI/j/YaMYQ4Ul1306
   o5X3i+GU0/Ja55cDcAxPB1ODD9T0+JMre5UoPk/ib9x3F8TaBPoW+q778
   tpOydfho5buc9DbCACkYg/QK9/54v1MGcCWWwvdVgIndGO5gS7PGs6YFI
   e/nwnZtBsM+Cstx3rPLhYqeZ+0DiQE6hIvNUtkpl7yNgE/brzRGVpJKk0
   NurWRZOAXNGBXNuzmoNPcmrFyMS7dv8xBqHZir4RQcitqr5Uqq6P2ydAR
   XJuxfOrhLsgq5MXs/xh0zLvzMYVphAcl88OuvqqMdX7wrbkihRDsXo3AI
   A==;
X-CSE-ConnectionGUID: laGEd5KrS6qBqDbFhc4ZTA==
X-CSE-MsgGUID: 7yfRFE3fRFmokcuv+zRi7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90129802"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90129802"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 02:30:38 -0700
X-CSE-ConnectionGUID: dgpsANy8RXy5X5fss4cD1g==
X-CSE-MsgGUID: ljf8FQFCRIqWSWaaEWqmAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="272565765"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 02:30:35 -0700
Message-ID: <eca53031-fd47-4471-9d05-d73295a0f57e@intel.com>
Date: Thu, 24 Sep 2026 17:30:32 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
 pbonzini@redhat.com, dave.hansen@linux.intel.com, andrew.cooper3@citrix.com,
 nik.borisov@suse.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 chao.gao@intel.com, tony.lindgren@linux.intel.com, kishen.maloor@intel.com,
 dedekind1@gmail.com
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
 <20260917072548.2314491-2-binbin.wu@linux.intel.com>
 <39047bbc-757d-4131-a25c-5a7743fd591a@intel.com>
 <062f5365-7eb5-4e04-9c84-f5ecd566f019@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <062f5365-7eb5-4e04-9c84-f5ecd566f019@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/2026 3:49 PM, Binbin Wu wrote:
> On 9/24/2026 2:36 PM, Xiaoyao Li wrote:
> 
> Thanks a lot for the detailed review!
> 
>> On 9/17/2026 3:25 PM, Binbin Wu wrote:
>>> Add tdx_cpu_cfg_caps[] to track the subset of TDX directly configurable
>>> CPUID feature bits that KVM supports, and build the masks during TDX
>>> hardware setup via tdx_initialize_cpu_cfg_caps().
>>>
>>> The TDX module reports the CPUID bits that the VMM can directly configure
>>> for a TD, but KVM cannot blindly expose all reported bits to userspace.
>>> Certain features imply additional architectural state, e.g. one or more
>>> MSRs, that KVM must explicitly manage across host/guest transitions to
>>> prevent host state corruption.  The existing hardcoded denylist cannot
>>> account for new host state clobbering features introduced by future TDX
>>> modules.
>>>
>>> Except for a few fixed-1 bits required for basic TDX support, host state
>>> clobbering features are either directly configurable or gated by TD
>>> ATTRIBUTES/XFAM, which KVM already validates.  Tracking only the directly
>>> configurable bits to build an allowlist is therefore sufficient.
>>>
>>> Organize tdx_cpu_cfg_caps[] following kvm_cpu_caps[] so that the masks can
>>> be built with similar feature-name based initializers.  Directly
>>> configurable non-feature bits will be handled separately.
>>>
>>> The allowlist is prepared to be consumed by later patches to filter
>>> KVM_TDX_CAPABILITIES and to reject unsupported CPUID input to
>>> KVM_TDX_INIT_VM, so that newly introduced TDX directly configurable CPUID
>>> feature bits stay hidden from userspace until KVM explicitly opts in.
>>>
>>> By default, intersect the allowlist with kvm_cpu_caps[] via TDX_CFG_F().
>>> Requiring support for non-TDX VMs avoids committing to TDX-specific
>>> behavior before general KVM support is established, and respects KVM's
>>> logic around disabling certain features, since the reasons for disabling
>>> them could apply to TDX as well.  Allow exceptions through
>>> TDX_CFG_EXTRA_F() only with sufficient justification.
>>
>> One name just crosses my mind. How about TDX_CFG_INDEP_F()? where INDEP stands
>> for independent.
>>
>> - TDX_CFG_F() for features that are dependent on kvm_cpu_caps[]
>> - TDX_CFG_INDEP_F() for features not dependent on kvm_cpu_caps[]
> 
> I am not sure if it's better.
> But if people prefer independent to extra, I would use TDX_CFG_INDEPENDENT_F()
> instead.
> 
>>
>>> Add comments as placeholders for HLE, RTM, WAITPKG and FRED, which KVM
>>> doesn't support for TDX yet.
>>
>> 1. why add comments for them? Because implementation wise, they are possible to
>> be supported by KVM but just current KVM doesn't have code to support them yet?
>>
>> If so, are the others the features that are concluded to be impossible to be
>> supported by KVM?
>>
>> 2. We don't need to talk about FRED, which is even not suppported for normal VMs
>> yet. Unless we are trying to enable FRED for TDs specifically.
> 
> OK, I will drop them to avoid confusion.
> 
>>
>>> Allow MWAIT, XTPR, and HT through TDX_CFG_EXTRA_F(), as these bits are
>>> not advertised in kvm_cpu_caps[].  The remaining directly configurable
>>> feature bits outside kvm_cpu_caps[] are left out of the allowlist:
>>>
>>>   - Features forced to zero when #VE is reduced, or lacking KVM support
>>>     for the associated MSRs: EST, TM2, SDBG, DCA, ACPI, ACC (TM), RDT_A,
>>>     RDT_M, TME, PCONFIG, and CORE_CAPABILITIES.  Handle CORE_CAPABILITIES
>>>     in a subsequent patch.
>>
>> why not split into two category? Because they are overlapped?
>>
>>   - Features forced to zero when #VE is reduced
>>   - Features lack KVM support
>>
> 
> Yes, there is overlap between them.
> If split into two categories, it would be:
> - Features forced to zero when #VE is reduced, which also lack KVM support
> - Features unrelated to #VE reduction that lack KVM support
> 
> Because the changelog was already getting quite long, I combined them into a
> single category.

I think that should be OK. It only adds 2-3 lines?

>> As for "features forced to zero when #VE is reduced", do you mean when TDX
>> module supports "#VE reduction" feature, the features becomes fixed0? or when
>> guest enables "reduce #VE", the guest see a 0 value even though the feature is
>> still configurable to host userspace and host userspace configure it to 1?
> 
> 
> #VE is reduced means the guest reduced the related #VE, i.e. TDCS.TD_CTRL.REDUCE_VE
> is 1 and the related bit in TDCS.FEATURE_PARAVIRT_CTRL is 0.

I think "features forced to zero when #VE is reduced" doesn't matter at all
here. KVM cannot predict TD's behavior and KVM cannot make decision just based
on one of the possibility of TD's behavior. i.e., KVM still needs to consider if
it can support the features when TD doesn't enable reduce_ve. So what really
matters is KVM doesn't/cannot support these features correctly.

So it's just one category: features not supported by KVM.
We don't need to talk #VE reduction at all.

>>
>>>   - Features tied to IA32_MISC_ENABLE bits that a TD cannot set when
>>>     TDCS.TD_CTLS.REDUCE_VE is set: CID and PBE.
>>
>> What is CID?
> 
> X86_FEATURE_CID, Context ID, more specifically, L1 CONTEXT ID

My bad. I only search 'CID' in arch/x86/kvm/cpuid.c where uses CNXT-ID instead
of CID.

>> and Is PBE related to any bit of IA32_MISC_ENABLE? Did you mean PEBS instead?
> 
> X86_FEATURE_PBE, Pending Break Enable.
> 
> Since kernel already has X86_FEATURE_XXX for them, so I use them directly without
> other description.
> 
>>
>> I don't understand what this category. It talks about something when
>> TDCS.TD_CTLS.REDUCE_VE is set, which depends on guest TD's behavior. So what if
>> the guest TD doesn't set TDCS.TD_CTLS.REDUCE_VE?
> 
> If the guest set TDCS.TD_CTLS.REDUCE_VE, write 1 to the the related bit trigger #GP.
> If the guest doesn't set TDCS.TD_CTLS.REDUCE_VE, the value is passed to KVM, and
> KVM will save the value without do corresponding virtualization.
> 
> Considering TDCS.TD_CTLS.REDUCE_VE is set by the Linux guest by default, it should
> not allow these features.

After some search, I find that X86_FEATURE_CID (CPUID.0x1:ECX[10]) is related to
MSR_IA32_MISC_ENABLE[24], which seems to be a model specific bit.

And on SDM, vol3. 14.5.6 L1 Data Cache Context Mode

  L1 data cache context mode is a feature of processors based on the Intel
  NetBurst microarchitecture that support Intel Hyper-Threading Technology.
  When CPUID.01H:ECX[10] =1, the processor supports setting L1 data cache
  context mode using the L1 data cache context mode flag (IA32_MISC_ENABLE[bit
  24]). Selectable modes are adaptive mode (default) and shared mode.

CPUID.0x1:ECX[10] is 0 on SPR and EMR (I didn't check more). It looks this CPUID
bit will not show up on any TDX capable CPUs. I think we can report it to TDX
architects and just make the bit fixed0 as a spec fix?

For X86_FEATURE_PBE (CPUID.0x1:EDX[31]), it's related to bit 10 of MSR
IA32_MISC_ENABLE. The CPUID is 1 on SPR and EMR. But bit 10 of MSR
IA32_MISC_ENABLE is always 0 and setting bit 10 to 1 fails. It seems though
CPUID.0x1:EDX[31] is set to 1, but it's not related to bit 10 of MSR
IA32_MISC_ENABLE?

>>
>>>   - Features that can clobber host state and lack KVM support for TDX:
>>>     FRED.
>>>
>>>   - Unsupported features: PREFETCHWT1 (Xeon Phi only), PSN (absent from
>>>     TDX-capable CPUs), AMX-TRANSPOSE (never implemented on an Intel
>>>     platform), and RAO_INT (defined only for future processors).
>>
>> PREFETCHWT1 (if the name is correct) is not supported by the kernel right? For
>> such unknown features, it's straightforward to not support it.
>>
>> AMX-TRANSPOSE has been turned into reserved, and kernel never supports it. I
>> think we don't need to mention it at all.
> 
> The guest could be other OS, not just Linux.

why guest OS matters? Are you considering the compatibility that it will break
the case where host userspace configures them to TDs and the TD OS (other than
Linux) is using them? If from this perspective, other bits will be a concern as
well.

>>
>> RAO_INT is fixed 0 for TDX 1.5?
> 
> I was doing this patch series based on the latest CSV version of the CPUID
> virtualization document from "Intel TDX Module ABI Definitions" updated in June 2026.
> https://cdrdv2.intel.com/v1/dl/getContent/795381

I see, it might be defined for TDX 2.0/3.0.

>>
>> At last, I think we can just classify all of the above as 3 types:
>>
>> - Features that are directly configurable by TDX and in kvm_cpu_caps[].
>>   use TDX_CFG_F()
>>
>> - Features that are directly configurable by TDX and KVM actually supports them
>>   or KVM can support them but not in kvm_cpu_caps[]. Use TDX_CFG_EXTRA_F().
>>   For example, MWAIT, XTPR, and HT.
>>
>> - Features that are directly configurable by TDX but KVM or kenrel doesn't
>>   support them.
>>   For example, RDT_A, RDT_M, PREFETCHWT1, PSN,
> 
> Because excluding some bits changes the ABI, I listed all these directly configurable
> features out of kvm_cpu_caps[] to explain why we must exclude some bits.

I think all the bits that are directly configurable but out of kvm_cpu_caps[]
and not supported by KVM fall into the last category. You can just list all of
them instead of my "for example".

As for the bits like FRED/RAO_INT, we don't need to consider them since they are
not generally supported by KVM.  They are just the new features to KVM, which
can be just treated as unknown though the TDX spec has defined the
virtualization type of them.
