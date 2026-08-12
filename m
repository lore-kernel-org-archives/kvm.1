Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C936B935
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525641; cv=none; b=rwYRieq4mmNBXP8zK/RsNXO2jAJ59kzfgLiGJNxGN4JHvbJN3KJCsNPUCJu+EQzyNYj9gv+aGbNQtm5+VUyeMeu+ULrC63c+D3XGZ10qm5cj9fb0dQ/TClzOpUNEZIGbYeZZQfzs8EGm6wGqzkjaEJxntg6oZwtIWIW0Nls7Ujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525641; c=relaxed/simple;
	bh=m2ODmjxodG0ujqhLJjhl7FTWxSr7IlPseEHl51oh1Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBscEHv6Q7OMkDrqv3Z/gsuu8T5flOVqNDasxCEOC8/j+HJ/6+jXdP+ljT749OiKN/d4MVTHJZLzClA+8Gl4GkA18QNkqvThQPXJt1DbDg1em8kPR9Xu1E81rNi4vfoXGPeJ2KtNzyDkZOaE2LOLJc6cmC90WC7FE39S+9F9n+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDZK1e74; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDZK1e74"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786525639; x=1818061639;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m2ODmjxodG0ujqhLJjhl7FTWxSr7IlPseEHl51oh1Kw=;
  b=MDZK1e74i7yy/NZOlt5JF/dUxOwC8SNCuoONk/vv+24gBdd51JbLI4OY
   CqbEp1ZaekUal6R2j6QGeBTClDQUBiPcCkSaGxktiWPQ+lWWql/MWkNwo
   +jgfxsYGl8td9oyxcC9RtOJxD2jpg8rTU4l9x4aGhK0vw/UJTt+8TxEiK
   LrfgjQP4WsTX3ev4K3vgqKEEjDp83pGNBkPcrqjJG0h88AYzar/LeHQcn
   mfZHI/BjKw6ERxW35hDI3F7DhuGkwtjqTYZ/V64WXuGCJiLR75jcFSJGa
   cQGFEmd37jfm/gYORjZ3xZyRm0/NWE7g1nmW+cqxWTp1NRVX1k7Nh8ef9
   g==;
X-CSE-ConnectionGUID: lPBkROD0S5udH8yJOT3HmQ==
X-CSE-MsgGUID: JF/xD+yETGqKA2621RGavw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86925131"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="86925131"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 02:07:19 -0700
X-CSE-ConnectionGUID: J+DZyl7qQMqY9pKMF+E9qw==
X-CSE-MsgGUID: 94/V+Lf0QUyCz1v3GAuCLg==
X-ExtLoop1: 1
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 02:07:17 -0700
Message-ID: <8b05ead1-ef2c-472f-a613-bcd1a65b64e1@intel.com>
Date: Wed, 12 Aug 2026 17:07:14 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] KVM: TDX: Don't assume exit_reason[31:16] as all-0
 in tdx_to_vmx_exit_reason()
To: sashiko-reviews@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
 <20260812080229.2481439-4-xiaoyao.li@intel.com>
 <20260812082306.11E8B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260812082306.11E8B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/2026 4:23 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] `tdx_get_exit_info()` incorrectly compares the full 32-bit exit reason against the 16-bit `TDX_INVALID_EXIT_REASON`, exposing meaningless/inconsistent exit qualification and interrupt info.
> 
> Pre-existing issues:
> - [High] Strict equality checks against `vp_enter_ret` in `tdx_handle_exit()` and `tdx_vcpu_run()` fail to mask the basic exit reason, bypassing critical bug checks when upper exit reason bits are set.
> --
> 
> --- Patch [3]: [PATCH v3 3/4] KVM: TDX: Don't assume exit_reason[31:16] as all-0 in tdx_to_vmx_exit_reason() ---
> commit 129e5cab6b9416a1d4e5f1f8c42f24dc1a44940c
> Author: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> KVM: TDX: Don't assume exit_reason[31:16] as all-0 in tdx_to_vmx_exit_reason()
>      
> When handling the real Exit Reason, don't assume the upper 16 bits as
> all-0 in tdx_to_vmx_exit_reason(), in preparation for enabling Bus Lock
> VM exit. Also preserve the bit 31:16 when changing the (basic) Exit
> Reason, to not lose the information in bit[31:16].
> 
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index df23db9430f06..598b85d772e37 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
> [ ... ]
>> @@ -942,23 +942,27 @@ static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
>>   		 * module never attempted to run the vCPU, i.e. the Exit
>>   		 * Reason is undefined, but this is NOT a failed VM-Enter
>>   		 */
>> -		return TDX_INVALID_EXIT_REASON;
>> +		return (union vmx_exit_reason) {
>> +			.basic = TDX_INVALID_EXIT_REASON,
>> +		};
>>   	}
>>   
>> -	exit_reason = tdx->vp_enter_ret;
>> +	exit_reason.full = (u32)tdx->vp_enter_ret;
>>   
>> -	switch (exit_reason) {
>> +	switch (exit_reason.basic) {
>>   	case EXIT_REASON_TDCALL:
>>   		if (tdvmcall_exit_type(vcpu))
>> -			return EXIT_REASON_VMCALL;
>> -
>> -		return tdcall_to_vmx_exit_reason(vcpu);
>> +			exit_reason.basic = EXIT_REASON_VMCALL;
>> +		else
>> +			exit_reason.basic = tdcall_to_vmx_exit_reason(vcpu);
>> +		break;
>>   	case EXIT_REASON_EPT_MISCONFIG:
>>   		/*
>>   		 * Defer KVM_BUG_ON() until tdx_handle_exit() because this is in
>>   		 * non-instrumentable code with interrupts disabled.
>>   		 */
>> -		return TDX_INVALID_EXIT_REASON;
>> +		exit_reason.basic = TDX_INVALID_EXIT_REASON;
>> +		break;
> 
> [Severity: Medium]
> When the basic exit reason is set to TDX_INVALID_EXIT_REASON here, but upper
> bits like Bus Lock are preserved in exit_reason.full, does this break
> tdx_get_exit_info()?
> 
> In tdx_get_exit_info(), it evaluates against the full 32-bit exit reason:
> 
>      *reason = tdx->vt.exit_reason.full;
>      if (*reason != TDX_INVALID_EXIT_REASON) {
>          *info1 = vmx_get_exit_qual(vcpu);
>          ...
> 
> Since TDX_INVALID_EXIT_REASON is the 16-bit 0xFFFF, this check will pass if
> any upper bits are set, even if the basic reason was marked invalid,
> incorrectly exposing meaningless hardware state.

Oh, I should have called it out it's intentional to check the full 32 
bits Exit Reason instead of checking the lower 16 bits .basic field as 
what it did in the v2.

The purpose here is to return zero value for info1/info2/intr_info when 
there is no real Exit Reason, i.e., no real VM-Enter has happened. "Full 
32 bits Exit Reason equals TDX_INVALID_EXIT_REASON" indicates the case 
of no real Exit Reason.

There is one exception though: when real EPT_MISCONFIG happens without 
bus_lock_detected being 1. In this case, it's a false positive and KVM 
should go to the else path to read the info1/info2/intr_info. As noted 
in patch 2 under "---", this is an pre-existing issue and it will be 
address in a future series.

For the case that Sashiko cares, the only possible one is that real 
EPT_MISCONFIG happens when bus_lock_detected. In this case, passing the 
check of (*reason != TDX_INVALID_EXIT_REASON) to read the value of 
info1/info2/intr_info happens to be what we expect. (However, the exit 
reason is 0xFFFF instead of EPT_MISCONFIG). Anyway, it won't expose 
meaningless hardware state.

So, considering that the false-positive on EPT_MISCONFIG cannot be fully 
addressed with either checking the full 32 bits or checking the 16 bits 
basic field, and checking the full 32 bits can ensure identifying the no 
real Exit Reason cases. I just leave it as-is instead of changing it to 
check the basic field.

> [Severity: High]
> This isn't a bug introduced by this patch, but by highlighting that
> vp_enter_ret can contain upper exit reason bits (like bit 26), does this
> expose a flaw in the strict equality checks for EPT misconfigurations?
> 
> In tdx_vcpu_run(), the check is strictly against the 64-bit value:
> 
>      if (unlikely(tdx->vp_enter_ret == EXIT_REASON_EPT_MISCONFIG))
>          return EXIT_FASTPATH_NONE;
> 
> Similarly, in tdx_handle_exit(), the bug check is also a strict comparison:
> 
>      if (unlikely(vp_enter_ret == EXIT_REASON_EPT_MISCONFIG)) {
>          KVM_BUG_ON(1, vcpu->kvm);
>          return -EIO;
>      }
> 
> If a hardware EPT misconfig occurs while upper bits are set in the raw
> vp_enter_ret, won't these checks fail to identify the misconfig, bypassing
> the KVM_BUG_ON() entirely?

If it happens, it bypasses the KVM_BUG_ON(). But it will finally exit to 
userspace due to invalid Exit Reason, 0xFFFF.

Indeed, it may cause behavior change. But considering the EPT_MISCONFIG 
is not supposed to happen with current KVM's code, and we want to 
backport the series to stable kernels. We don't want to handle the 
theoretical issue that cannot happen in practice with this series, to 
make the series simple. We can harden the EPT_MISCONFIG code with 
another series separately.

>>   	default:
>>   		break;
>>   	}
>>
>>   	return exit_reason;
>>   }
> 

