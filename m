Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C29B3B42C1
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996621; cv=none; b=F7Ep/Sm03G4S5ZlJ51jo4QgD2rn1ftvZW6VvMefbPlKl3KrDqJZzX2dWGX9XetvO/eUamSS32lELkuye/JinpOZuGwp9iFO5mBvehY8iX0peAWv2FSlBdPv964ndU14OpaIa/EjDgr2feJsLdJCG9w50U8ljXGcJKsiEPYqEkoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996621; c=relaxed/simple;
	bh=1jd9BwJE/dovM/938HwvvLhTLSE35kAoFYbuZ1SZmCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoZHKtS6K1fPCD1A9efoRELCZxXxu/+npYS53AbLDo/BMsigcLmEy7h/nP7aagiFReu79mgi7UtK/4CPVV2U4BVCTCdf0YWygEsvZENfBpe1LwuJTbrLxkE+0S69XCJx8FW0QiGh8iPfU9sMoHZAJ/YyYb2/++sZK/LrIgrcSQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftxOOU2k; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftxOOU2k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785996621; x=1817532621;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1jd9BwJE/dovM/938HwvvLhTLSE35kAoFYbuZ1SZmCE=;
  b=ftxOOU2kydzw8RXA42u8iiD8toTUFYJ58Qo5cijhj0c9kB7lxqStqK1k
   9WtciT9Tl4cBOMk0OvHW4MG09ld7ZTRrMUuRvsAF0R/2RFZMQu3pRY1Zi
   AR/7ksNZsbD13e6hf7ZVGwgfqsqwHqzE0ZB/TooSsPAbat+c5vM0ysCbo
   6BEZSlbHWm0yEqEvLK71LLEr+azqX+ZR/A5YR0MA7nu6g+pbkPs0qCB6l
   7KCbbrIhkpqhqmkX3CIiM/NWGJTr8/GKZYlJZ+gZUwvJDl7l/M0dA2iTa
   98oj5Qed0ITtttEPNYQccRFlXRtr0BOOJaSV7jHiIwf50GQ5SZmgoL4tU
   A==;
X-CSE-ConnectionGUID: muBJ1a6MRJ+VAEkCVJBp7A==
X-CSE-MsgGUID: FX1mJmUTS3SUdesJcYO2kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86591325"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="86591325"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 23:10:21 -0700
X-CSE-ConnectionGUID: WKumlatwQimPjuyY3IarrA==
X-CSE-MsgGUID: tuzEaPeFScCVrF3GJGZGPQ==
X-ExtLoop1: 1
Received: from fuxiaogu-mobl1.ccr.corp.intel.com (HELO [10.238.208.47]) ([10.238.208.47])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 23:10:18 -0700
Message-ID: <e606195a-6adf-412f-8b0b-4b3ca7b1ad0a@intel.com>
Date: Thu, 6 Aug 2026 14:10:16 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: TDX: Enable Bus Lock VM exit
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
References: <20260805031257.1844914-1-xiaoyao.li@intel.com>
 <20260805031257.1844914-3-xiaoyao.li@intel.com>
 <20260805034602.5B2BB1F000E9@smtp.kernel.org>
 <4fedcaa6-d710-48f8-84c4-de682350bb2f@intel.com>
 <anNPAXShf1gjDdeu@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <anNPAXShf1gjDdeu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/2026 10:56 PM, Sean Christopherson wrote:
> On Wed, Aug 05, 2026, Xiaoyao Li wrote:
>> On 8/5/2026 11:46 AM, sashiko-bot@kernel.org wrote:
>>> This also appears to affect tdx_to_vmx_exit_reason(), where comparing the raw
>>> exit reason directly against 16-bit constants like EXIT_REASON_TDCALL will
>>> fail to match if the bus lock bit is set, leading to incorrect emulation.
>>
>> This is valid. We need to adjust tdx_to_vmx_exit_reason().
>>
>> However, there is a more important problem. Since Bus Lock VM exit makes bit
>> 26 possible in EXIT REASON, the trick of "return -1" in
>> tdx_to_vmx_exit_reason() will introduce false-positive in the following
>> check of if(vmx_get_exit_reason(vcpu).bus_lock_detected) added by this
>> patch.
>>
>> how about something like below:
> 
> Way too subtle.  tdx_to_vmx_exit_reason() should return the actual union, not a
> raw u32, otherwise it's going to be extremely difficult to avoid reintroducing
> similar bugs.
> 
> And looking at this all again, we should change the handling of actual
> EXIT_REASON_EPT_MISCONFIG exits.  Stuffing a bogus value into the exit_reason
> is "fine", but as Sashiko points out, it's extremely brittle.  Rather than
> stuff the exit reason, we should stuff the status to signal TDX_SW_ERROR.
> 
> And to do that without introducing more fragility, we should flag the raw
> vp_enter_ret as "unsafe", and explicitly track vp_enter_status.  I.e. separate
> the status from the exit_reason immediately after VP.ENTER, instead of mixing
> and matching the two concepts.
> 
> The fastpath "handler" is also all kinds of messed up.  KVM fails to trace_kvm_exit()
> EPT misconfigs and software errors; even though the exit reason is undefined, it
> should still be captured in the trace, otherwise it's a huge blindspot.  And AFAICT,
> OPERAND_BUSY should be mutually exclusive with actual VM-Entry failures, so manually
> checking for VM-Entry failure is completely unnecessary, just handle OPERAND_BUSY.
> If TDX ever gains fastpath handlers, then we can add a true fastpath handler at
> that time.  But OPERAND_BUSY should be a "never do the fastpath", because AIUI,
> VM-Enter wasn't attempted, i.e. there's nothing to handle.
> 
> Compile tested only, and it should be chunked over several patches, but this?

Basically, it looks good except some nits.

I'll try to split into a formal sereis. Please let me know if you want 
to do if yourself.

> @@ -1053,8 +1026,8 @@ static void tdx_load_host_xsave_state(struct kvm_vcpu *vcpu)
>   
>   fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
>   {
> -	struct vcpu_tdx *tdx = to_tdx(vcpu);
>   	struct vcpu_vt *vt = to_vt(vcpu);
> +	u64 vp_enter_ret;
>   
>   	/*
>   	 * WARN if KVM wants to force an immediate exit, as the TDX module does
> @@ -1084,7 +1057,7 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
>   			kvm_wait_lapic_expire(vcpu);
>   	}
>   
> -	tdx_vcpu_enter_exit(vcpu);
> +	vp_enter_ret = tdx_vcpu_enter_exit(vcpu);

We need assign tdx->vp_enter_ret__unsafe somewhere after here. I think 
we can just drop the local vp_enter_ret and make it

	tdx->vp_enter_ret__unsafe = tdx_vcpu_enter_exit(vcpu);

>   
>   	if (vcpu->arch.host_debugctl & ~TDX_DEBUGCTL_PRESERVED)
>   		update_debugctlmsr(vcpu->arch.host_debugctl);

<...>

> -	if (unlikely(vp_enter_ret == EXIT_REASON_EPT_MISCONFIG)) {
> -		KVM_BUG_ON(1, vcpu->kvm);
> +	if (KVM_BUG_ON(exit_reason.basic == EXIT_REASON_EPT_MISCONFIG, vcpu->kvm))

We need to check tdx->vp_enter_ret__unsafe instead of exit_reason becase 
tdcall_to_vmx_exit_reason() translates 
TDVMCALL(EXIT_REASON_EPT_VIOLATION) from guest to EXIT_REASON_EPT_MISCONFIG

<...>
> diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
> index ac8323a68b16..5564617fc12a 100644
> --- a/arch/x86/kvm/vmx/tdx.h
> +++ b/arch/x86/kvm/vmx/tdx.h
> @@ -66,7 +66,12 @@ struct vcpu_tdx {
>   
>   	struct list_head cpu_list;
>   
> -	u64 vp_enter_ret;
> +	/*
> +	 * Discourage direct use of the raw VP.ENTER return value, as there are
> +	 * several subtleties that need to be accounted for when working with
> +	 * the raw value.
> +	 */
> +	u64 HINT_UNSAFE_IN_KVM(vp_enter_ret);

So the purpose is forcing people to think twice when using it because 
they see "__unsafe"? Maybe it's more for the reviewers and maintainers.

>   
>   	enum vcpu_tdx_state state;

