Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A758A220F2A;
	Thu, 24 Sep 2026 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250116; cv=none; b=GewFATDniF5sKii2JJlR/hlU2jxqf1zlWswXexrNwtAgAxEdkdwBUAVCZQz5q3QOE6J0PLWLoEav/TL15b6BtNCsfJZXuuja8Ia1b/MTIC91tgC3gPMDeMuY7OAXqZc59aXeUY9HLB6IkhP1G5+qyyeq2aLfXDh9gjCQM0bkeS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250116; c=relaxed/simple;
	bh=otvjFuyq6kH012fr3aOVX2Jq0X9BxSEiV72+IfUwzLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQaAUO4gPtG/6PQGvso9sQD+qAGCSTuZ4s4kWquzp3KHaKnYD3U4tkgn1/r6sk2FNID6NjslKrDOYPQYq6frxYmtZXcpHb5DeEdBVglJqeVbGc5Luk9TAS0tUAn/P59Iy5vIbx0sSNHtMYYGR+TEgWFA1sDVeWtq1UoS0+8fZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Us7BZnDr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Us7BZnDr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790250113; x=1821786113;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=otvjFuyq6kH012fr3aOVX2Jq0X9BxSEiV72+IfUwzLE=;
  b=Us7BZnDr0NjlYYmnVt1YEU+ig5cMbnZrcjMhLFRTRm+tyNqmR+BgYzqN
   UppGzU+WQYsfX+ZOQAk7Q5qyDv5jlXtRoZb0jthnwZu9BLH2SgCxn+NQx
   zDdBzbI2Uazx55RkxeoYLhSgP7kBzP9gBh2OgU4Z4Y3tH5OBFxI5q1IMW
   MTalzZ8VWNU1zMNNXUMFBDl5iNCUkzHg6Rap9vTUEgkxXxoXKI/Gc3Ql5
   OUUWHCr2UzqZ5NPB+SdkpT1y2smHVhXIDCKtDhKNtjqfaqnMF5vLYT3Qy
   +/cX9iVYxjxcuUD5qq0ba/1vxvathmsGeqB2DCYQxQySfzUBV8TGALshH
   Q==;
X-CSE-ConnectionGUID: ow4LMnjGSp6UU3x1plEqqw==
X-CSE-MsgGUID: x0I3iBLLRJihDDmdphzO6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93736186"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="93736186"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 04:41:50 -0700
X-CSE-ConnectionGUID: zBVjP67HRJetQEU5QxdfVA==
X-CSE-MsgGUID: c10untGtQmiyFPB6v5EW3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="301930706"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 04:41:47 -0700
Message-ID: <8bcba51e-2a3b-44b8-89cd-aebfd1e50cfd@linux.intel.com>
Date: Thu, 24 Sep 2026 19:41:44 +0800
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
 <062f5365-7eb5-4e04-9c84-f5ecd566f019@linux.intel.com>
 <eca53031-fd47-4471-9d05-d73295a0f57e@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <eca53031-fd47-4471-9d05-d73295a0f57e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[...]

>>>> Allow MWAIT, XTPR, and HT through TDX_CFG_EXTRA_F(), as these bits are
>>>> not advertised in kvm_cpu_caps[].  The remaining directly configurable
>>>> feature bits outside kvm_cpu_caps[] are left out of the allowlist:
>>>>
>>>>   - Features forced to zero when #VE is reduced, or lacking KVM support
>>>>     for the associated MSRs: EST, TM2, SDBG, DCA, ACPI, ACC (TM), RDT_A,
>>>>     RDT_M, TME, PCONFIG, and CORE_CAPABILITIES.  Handle CORE_CAPABILITIES
>>>>     in a subsequent patch.
>>>
>>> why not split into two category? Because they are overlapped?
>>>
>>>   - Features forced to zero when #VE is reduced
>>>   - Features lack KVM support
>>>
>>
>> Yes, there is overlap between them.
>> If split into two categories, it would be:
>> - Features forced to zero when #VE is reduced, which also lack KVM support
>> - Features unrelated to #VE reduction that lack KVM support
>>
>> Because the changelog was already getting quite long, I combined them into a
>> single category.
> 
> I think that should be OK. It only adds 2-3 lines?

OK.

> 
>>> As for "features forced to zero when #VE is reduced", do you mean when TDX
>>> module supports "#VE reduction" feature, the features becomes fixed0? or when
>>> guest enables "reduce #VE", the guest see a 0 value even though the feature is
>>> still configurable to host userspace and host userspace configure it to 1?
>>
>>
>> #VE is reduced means the guest reduced the related #VE, i.e. TDCS.TD_CTRL.REDUCE_VE
>> is 1 and the related bit in TDCS.FEATURE_PARAVIRT_CTRL is 0.
> 
> I think "features forced to zero when #VE is reduced" doesn't matter at all
> here.

I think it still matters.

If there is a feature that is virtualized by the TDX module itself, but KVM doesn't
support it for non-TDX VMs, I think it should be allowed.

These features can't be added to the allow list because neither TDX module nor
KVM do the virtualization for them.


 KVM cannot predict TD's behavior and KVM cannot make decision just based
> on one of the possibility of TD's behavior. i.e., KVM still needs to consider if
> it can support the features when TD doesn't enable reduce_ve. So what really
> matters is KVM doesn't/cannot support these features correctly.
> 
> So it's just one category: features not supported by KVM.
> We don't need to talk #VE reduction at all.
> 
>>>
>>>>   - Features tied to IA32_MISC_ENABLE bits that a TD cannot set when
>>>>     TDCS.TD_CTLS.REDUCE_VE is set: CID and PBE.
>>>
>>> What is CID?
>>
>> X86_FEATURE_CID, Context ID, more specifically, L1 CONTEXT ID
> 
> My bad. I only search 'CID' in arch/x86/kvm/cpuid.c where uses CNXT-ID instead
> of CID.
> 
>>> and Is PBE related to any bit of IA32_MISC_ENABLE? Did you mean PEBS instead?
>>
>> X86_FEATURE_PBE, Pending Break Enable.
>>
>> Since kernel already has X86_FEATURE_XXX for them, so I use them directly without
>> other description.
>>
>>>
>>> I don't understand what this category. It talks about something when
>>> TDCS.TD_CTLS.REDUCE_VE is set, which depends on guest TD's behavior. So what if
>>> the guest TD doesn't set TDCS.TD_CTLS.REDUCE_VE?
>>
>> If the guest set TDCS.TD_CTLS.REDUCE_VE, write 1 to the the related bit trigger #GP.
>> If the guest doesn't set TDCS.TD_CTLS.REDUCE_VE, the value is passed to KVM, and
>> KVM will save the value without do corresponding virtualization.
>>
>> Considering TDCS.TD_CTLS.REDUCE_VE is set by the Linux guest by default, it should
>> not allow these features.
> 
> After some search, I find that X86_FEATURE_CID (CPUID.0x1:ECX[10]) is related to
> MSR_IA32_MISC_ENABLE[24], which seems to be a model specific bit.
> 
> And on SDM, vol3. 14.5.6 L1 Data Cache Context Mode
> 
>   L1 data cache context mode is a feature of processors based on the Intel
>   NetBurst microarchitecture that support Intel Hyper-Threading Technology.
>   When CPUID.01H:ECX[10] =1, the processor supports setting L1 data cache
>   context mode using the L1 data cache context mode flag (IA32_MISC_ENABLE[bit
>   24]). Selectable modes are adaptive mode (default) and shared mode.
> 
> CPUID.0x1:ECX[10] is 0 on SPR and EMR (I didn't check more). It looks this CPUID
> bit will not show up on any TDX capable CPUs. I think we can report it to TDX
> architects and just make the bit fixed0 as a spec fix?

I think we can confirm with the TDX module team. If it will never show up on TDX
capable CPUs, then this is similar to PREFETCHWT1. 

But I am not sure we want new fixed-0 bits.

> 
> For X86_FEATURE_PBE (CPUID.0x1:EDX[31]), it's related to bit 10 of MSR
> IA32_MISC_ENABLE. The CPUID is 1 on SPR and EMR. But bit 10 of MSR
> IA32_MISC_ENABLE is always 0 and setting bit 10 to 1 fails. It seems though
> CPUID.0x1:EDX[31] is set to 1, but it's not related to bit 10 of MSR
> IA32_MISC_ENABLE?

In the ISE (319433-062, table 1-6), it says:
  PBE:
  Pending Break Enable. The processor supports the use of the FERR#/PBE# pin
  when the processor is in the stop-clock state (STPCLK# is asserted) to signal
  the processor that an interrupt is pending and that the processor should
  return to normal operation to handle the interrupt. Bit 10 (PBE enable) in the
  IA32_MISC_ENABLE MSR enables this capability.

TDX module doesn't allow IA32_MISC_ENABLE[10] to be 1 is since it's reserved
TDCS.TD_CTLS.REDUCE_VE is set, so my understanding was the CPUID bit should be 0. 

It seems bit 10 is phased out in IA32_MISC_ENABLE on modern processors like SPR
and EMR, since the bit 10 is reserved in "IA-32 Architectural MSRs" table. But
somehow, CPUID still reports PBE as supported.

I don't know why the CPUID is disconnected with the MSR.
But this bit is present on the host, I think we can add it to the allowlist.

> 
>>>
>>>>   - Features that can clobber host state and lack KVM support for TDX:
>>>>     FRED.
>>>>
>>>>   - Unsupported features: PREFETCHWT1 (Xeon Phi only), PSN (absent from
>>>>     TDX-capable CPUs), AMX-TRANSPOSE (never implemented on an Intel
>>>>     platform), and RAO_INT (defined only for future processors).
>>>
>>> PREFETCHWT1 (if the name is correct) is not supported by the kernel right? For
>>> such unknown features, it's straightforward to not support it.
>>>
>>> AMX-TRANSPOSE has been turned into reserved, and kernel never supports it. I
>>> think we don't need to mention it at all.
>>
>> The guest could be other OS, not just Linux.
> 
> why guest OS matters? Are you considering the compatibility that it will break
> the case where host userspace configures them to TDs and the TD OS (other than
> Linux) is using them? If from this perspective, other bits will be a concern as
> well.

That's the reason I explained in the commit message why other bits should not be
added to the allow list because if they are used, since they are can't be properly
virtualized, there should have been issues already before this patch series.

> 
>>>
>>> RAO_INT is fixed 0 for TDX 1.5?
>>
>> I was doing this patch series based on the latest CSV version of the CPUID
>> virtualization document from "Intel TDX Module ABI Definitions" updated in June 2026.
>> https://cdrdv2.intel.com/v1/dl/getContent/795381
> 
> I see, it might be defined for TDX 2.0/3.0.
> 
>>>
>>> At last, I think we can just classify all of the above as 3 types:
>>>
>>> - Features that are directly configurable by TDX and in kvm_cpu_caps[].
>>>   use TDX_CFG_F()
>>>
>>> - Features that are directly configurable by TDX and KVM actually supports them
>>>   or KVM can support them but not in kvm_cpu_caps[]. Use TDX_CFG_EXTRA_F().
>>>   For example, MWAIT, XTPR, and HT.
>>>
>>> - Features that are directly configurable by TDX but KVM or kenrel doesn't
>>>   support them.
>>>   For example, RDT_A, RDT_M, PREFETCHWT1, PSN,
>>
>> Because excluding some bits changes the ABI, I listed all these directly configurable
>> features out of kvm_cpu_caps[] to explain why we must exclude some bits.
> 
> I think all the bits that are directly configurable but out of kvm_cpu_caps[]
> and not supported by KVM fall into the last category. You can just list all of
> them instead of my "for example".

As I mentioned above, if there is a feature that is virtualized by the TDX module itself,
but KVM doesn't support it for non-TDX VMs, it should be allowed. Although I don't have
a concrete example. I think we still need to mention #VE reduction to some degree, but
let me see how to simplify the description.

> 
> As for the bits like FRED/RAO_INT, we don't need to consider them since they are
> not generally supported by KVM.  They are just the new features to KVM, which
> can be just treated as unknown though the TDX spec has defined the
> virtualization type of them.

