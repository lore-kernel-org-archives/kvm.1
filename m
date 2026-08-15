Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC023B813C;
	Sat, 15 Aug 2026 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786800541; cv=none; b=nb3vXmDY/VyWxIhjYfyzKD0CWgpEf94Y4gk4nQsvEG5/tlqBOhx5ImEapIkArvZTbPdECWgoOxYPbmjPasF/GZEkRdyHLxjafAuNw8Of8FAn8rLBPHwSrRU7pgsU5a2sJko84nNrySMVBhvptuXDNjGKQcCAY95wx7q4UiGMbI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786800541; c=relaxed/simple;
	bh=THvHm6nPWyf6op2qdpKJnFAD6ZpAhw95hd9KdLocYS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grOgP5cJ6XmykGVzvlZ7hAIKogIrRnrA/1SNO0+dWY4f+TBO3u4aRfOeFJjQZblFYNrZN/KTVJenkD+nkOHkUJv96cz0APshFYchhuOCfRXzU5i/4ZkhKcQk2WPoagZlJC7snq7SJ3CoQOXA8jhK9NOQQGyN37gfdd7oM4bwz6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYHEHVOI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYHEHVOI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786800538; x=1818336538;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=THvHm6nPWyf6op2qdpKJnFAD6ZpAhw95hd9KdLocYS4=;
  b=lYHEHVOI3aVGzktdPbNDW4nFsIH1oqfCVMLAvQtRSqxGbuYsaQ0fscfH
   kw1uBJILJd7azmJZZTiPtthBU84YJM8SXJxAaT8O9iao1EXDkWYNl8/Dz
   JD5StyT7kikiboGYjkm/UikcP8/XHYLq5VedQtaWwTtOeg1ESbNhDNwMP
   A66r8x/NL9NtNNhAZUGZMChCxiZvuQ5qwr+TJt9e+u/Oup/VqQcH4lKS5
   8vIW42MPSDHStjYVpQv5yuG03+LM3D6kyYAa60017PCKnma6El0HvoRnQ
   rf8BumQoFGmNM821CqI6jYFFvRTlscSYMqs5XENaZEWPO3EHO2ZFHaoYK
   A==;
X-CSE-ConnectionGUID: LfqfCo6FSNGd5mCw1dYqdQ==
X-CSE-MsgGUID: zHa9mcmVR+KH6LEiF+0IAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="87479581"
X-IronPort-AV: E=Sophos;i="6.25,225,1779174000"; 
   d="scan'208";a="87479581"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 06:28:57 -0700
X-CSE-ConnectionGUID: fsbUrLpkT7eUTEWuaedeXw==
X-CSE-MsgGUID: uH/+Gt5+QtCVKPsDcFxFXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,225,1779174000"; 
   d="scan'208";a="266471729"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 06:28:55 -0700
Message-ID: <1dcbf1b2-dc89-4624-b98e-d34f40558cfb@intel.com>
Date: Sat, 15 Aug 2026 21:28:53 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] KVM: TDX: Enable Bus Lock VM exit
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kas@kernel.org" <kas@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
 <20260812080229.2481439-5-xiaoyao.li@intel.com>
 <868c0d3c792d789347c767031612977c31cc227f.camel@intel.com>
 <1cf47118-2a19-44d5-ab74-b4c7ffa8890c@intel.com>
 <an3YFiDbjRs3PUwn@google.com>
 <77567574-d26c-4d2c-b5ce-5da28a7178d6@intel.com>
 <an84cenJjf7EqhVM@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <an84cenJjf7EqhVM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/2026 11:46 PM, Sean Christopherson wrote:
> On Fri, Aug 14, 2026, Xiaoyao Li wrote:
>> On 8/13/2026 10:43 PM, Sean Christopherson wrote:
>>> On Thu, Aug 13, 2026, Xiaoyao Li wrote:
>>>> On 8/13/2026 6:58 AM, Edgecombe, Rick P wrote:
> 
> ...
> 
>>> The more I look at this, the more I'm against shoving garbage into vt->exit_reasons.
>>> With tdx_is_exit_reason_valid(), this is trivially easy to handle, *and* explicitly
>>> captures the logic instead of subtly rerouting KVM away from meaningful handling.
>>
>> tdx_is_exit_reason_valid() doesn't work unless we update the vp_enter_ret to
>> one that isn't one of the status code with valid Exit Reason. See below.
> 
> Correct.
> 
>> About the idea, isn't the purpose of setting the Exit Reason to a synthesized
>> one is to avoid the undefined Exit Reason causing false-positives when it
>> happens to match one of the existing ones?
> 
> Yes.  The nuance is that I'm against clobbering the *full* exit reason.  I am
> not against setting exit_reason.basic to something like EXIT_REASON_INVALID_STATE.

I'm not sure why you are not OK with setting the bit[31:16] to 0 ...

>> If we are going to use tdx_is_exit_reason_valid(), does it mean we can drop
>> the synthesized Exit Reason entirely and check tdx_is_exit_reason_valid()
>> everywhere when KVM is going to consume Exit Reason?  e.g., for this initial
>> bus_lock_detected bit handling here. we can avoid it by below. (Which makes
>> it different for VMX, and somehow prevents consolidating the code between VMX
>> and TDX around the exit handlers that we plan to do after series)
> 
> I'd rather not, as it would make checking for tdx_is_exit_reason_valid() much
> more load bearing.  I.e. I want to minimize the number of flows that *need* to
> check tdx_is_exit_reason_valid(), and an easy way to help on that front is to
> ensure that exit_reason[31:16] is accurate with respect to what to the last
> (attempted) entry to the guest.

... and why bit[31:16] need to be preserved (as much as possible) to 
what to the last (attempted) entry to the guest.

Here KVM is emulating an EXIT without really Entering the guest, and the 
emulated EXIT is different to the previous handled one. If KVM preserves 
the bit[31:16] of the previous EXIT, wouldn't it be likely to cause the 
bit being counted twice? I think KVM needs to clear the bit[31:16] 
unless the specific EMULATED EXIT requires them to be preserved.

>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index b6c30c4c6b84..52360313dd82 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
>> @@ -2169,7 +2169,8 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t
>> fastpath)
>>          int ret = __tdx_handle_exit(vcpu, fastpath);
>>
>>          /* Exit to user space when bus lock was detected */
>> -       if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
>> +       if (tdx_is_exit_reason_valid(vcpu) &&
>> +           vmx_get_exit_reason(vcpu).bus_lock_detected) {
>>                  if (ret > 0) {
>>                          vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
>>                          ret = 0;
>>
>>> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
>>> index 95d89d809c19..a1f5b5dc1fa3 100644
>>> --- a/arch/x86/kvm/vmx/main.c
>>> +++ b/arch/x86/kvm/vmx/main.c
>>> @@ -157,6 +157,14 @@ static fastpath_t vt_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
>>>           return vmx_vcpu_run(vcpu, run_flags);
>>>    }
>>> +static void vt_handle_exit_irqoff(struct kvm_vcpu *vcpu)
>>> +{
>>> +       if (is_td_vcpu(vcpu) && !tdx_is_exit_reason_valid(vcpu))
>>
>> No, this doesn't work.
>>
>> The previous vp_enter_ret was TDX_SUCCESS with
>> EXIT_REASON_EXTERNAL_INTERRUPT. KVM handled it and is going to re-enter the
>> TD. But wait_for_sept_zap is set by other vCPU thread, KVM decides to return
>> directly but the vp_entere_ret isn't updated.
> 
> Oh, right, it really is the same situation as emulation_required, sort of.  The
> key difference is that wait_for_sept_zap is per-VM, not per-VM, and so if it's
> *cleared* between tdx_vcpu_run() and vt_handle_exit_irqoff(), then KVM would get
> a false negative and again synthesize a duplicate IRQ.
> 
> Actually, can't we just do this?  Logically it's sound: if the exit was handled,
> then there's nothing to be done.

yeah. This looks good to me.

> diff --git arch/x86/kvm/x86.c arch/x86/kvm/x86.c
> index 0626e835e9eb..6cace57e45fd 100644
> --- arch/x86/kvm/x86.c
> +++ arch/x86/kvm/x86.c
> @@ -8374,7 +8374,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>          if (vcpu->arch.xfd_no_write_intercept)
>                  fpu_sync_guest_vmexit_xfd_state();
>   
> -       kvm_x86_call(handle_exit_irqoff)(vcpu);
> +       if (exit_fastpath != EXIT_FASTPATH_EXIT_HANDLED)
> +               kvm_x86_call(handle_exit_irqoff)(vcpu);
>   
>          if (vcpu->arch.guest_fpu.xfd_err)
>                  wrmsrq(MSR_IA32_XFD_ERR, 0);

