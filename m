Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF841D642
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787040880; cv=none; b=rAUGg2lZf8FIsrTrNROhie4Bxuzpykko/3TLr5r41hs4+I81161XFZGYADb88mgzw2tNvQbkpHwHUOpuPTfLZkDo1xVzti+ZHbhSwHuMqf2faf3+8Ncq5EcAVTGypu7zeOhHg7ivp46o+khUxxJYGv+y2cSb4736InkWJmIYqlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787040880; c=relaxed/simple;
	bh=3qp9RrgaoNAvrju9glZjpW+nVHb1IGbx0SiQ7b7E9BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGZhgdui4u/o+ZrI4ifg51NsxIKL2gqLa7Nzx9ZpVQeD5VzgQL4aKqwoyaZpADFYwp3/Bwoa6UwRjJwcLH2mREU7fKH6C27Im5xS0OrZ1cn6OhbswY9XDxCj1XJjvL2Hs4JY7rnI+ZCg2bL67l1V/VS95VlcVPuBEqMDHcfYkJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OgyqW/q1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OgyqW/q1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787040877; x=1818576877;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3qp9RrgaoNAvrju9glZjpW+nVHb1IGbx0SiQ7b7E9BI=;
  b=OgyqW/q1tSjfGBr9MsCagLNvYj/VBmCKIhXF9A7CaIy/se9TB2jBH2Hi
   VusubmcJpHH3eSb2UIa8/oNQNGusj+pD4Xt6xB3Rk7PXFg2M/RwbPy4wD
   Ow+5VFiBEnb2PgkfPMyeiq5WF2alHzrS9pUZx/nnyp2khF82alSW0uHfQ
   g7rImeCRu8ZYP7OHGoS89TOksa7L7fPzDy9RuDNumdUQy6nW+8DYJ+avR
   0trC5WJHNnxm1h/8d4CfdcOpeWTrivtWHBinMo723xNdZaB/zBc6j8GiT
   A3+9vrdk72jMKYrK9s//WJlWfUv6rL7i2IDjerxQxMrAWfMjuapb9kmbz
   Q==;
X-CSE-ConnectionGUID: txBDpiFjSIygFdBdoWrbaw==
X-CSE-MsgGUID: xw5OQ6UbRVKzHIEOBtnLWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="91208085"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="91208085"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 01:14:37 -0700
X-CSE-ConnectionGUID: yDNeeb3FQYutCqQabKCqwA==
X-CSE-MsgGUID: KQ5xA7tGSkaww7BeFx6QXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="258945799"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.238.208.98]) ([10.238.208.98])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 01:14:35 -0700
Message-ID: <8c121997-6673-4d5b-927e-be74b5779059@intel.com>
Date: Tue, 18 Aug 2026 16:14:33 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] KVM: TDX: Don't assume exit_reason[31:16] as all-0
 in tdx_to_vmx_exit_reason()
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
 <20260812080229.2481439-4-xiaoyao.li@intel.com>
 <20260812082306.11E8B1F000E9@smtp.kernel.org>
 <8b05ead1-ef2c-472f-a613-bcd1a65b64e1@intel.com>
 <138969948dac13369ddebd72bf523dda4dda6b85.camel@intel.com>
 <an5W5XC97HK229MX@google.com>
 <eddf28d4-c211-41fb-b0a3-586e5afde030@intel.com>
 <an8wUfZ9JxvEhtHS@google.com>
 <d67eb097-1223-4b68-92d4-1510d3d7be7c@intel.com>
 <aoNQpP-BQKiZL47O@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aoNQpP-BQKiZL47O@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/2026 2:19 AM, Sean Christopherson wrote:
> On Mon, Aug 17, 2026, Xiaoyao Li wrote:
>> On 8/14/2026 11:12 PM, Sean Christopherson wrote:
>>> On Fri, Aug 14, 2026, Xiaoyao Li wrote:
>>>> On 8/14/2026 7:44 AM, Sean Christopherson wrote:
>>>>> On Wed, Aug 12, 2026, Rick P Edgecombe wrote:
>>>>>> Side note. I really dislike how tangled this area is for something that seems
>>>>>> like it should be much more straightforward. Deriving partially I think from the
>>>>>> overloading of the TDVMCALL leafs with the exit reasons. So we have things like:
>>>>>> ...
>>>>>> 	case EXIT_REASON_EPT_VIOLATION:
>>>>>> 		return EXIT_REASON_EPT_MISCONFIG;
>>>>>> ...
>>>>>
>>>>> I peeked at that code again, and FWIW I still think swizzling the exit_reason for
>>>>> TDVMCALL is the least awful solution.  If we don't do that, then we'll have to
>>>>> update every single use of the exit_reason to demux TDVMCALL into the "real" exit
>>>>> reason, which will be a mess.
>>>>
>>>> I'm not sure if you read my idea[1]?
>>>>
>>>> I think there is only one place KVM cares about the exit_reason TDVMCALL,
>>>> just the
>>>>
>>>> 	case EXIT_REASON_TDCALL:
>>>
>>> No, the massaged exit_reason is also subtley consumed via trace_kvm_exit().
>>
>> yeah. This is exactly the one I don't like, it looks like trace_kvm_exit()
>> is tracing the wrong exit reason, though it is by intentional.
>>
>>> It's also consumed by tdx_complete_emulated_msr():
>>>
>>> 	if (vmx_get_exit_reason(vcpu).basic == EXIT_REASON_MSR_READ)
>>>
>>> and by tdx_interrupt_allowed()
>>>
>>> 	return vmx_get_exit_reason(vcpu).basic != EXIT_REASON_HLT ||
>>> 	       !to_tdx(vcpu)->vp_enter_args.r12;
>>>
>>> and by tdx_protected_apic_has_interrupt():
>>>
>>> 	if (vmx_get_exit_reason(vcpu).basic != EXIT_REASON_HLT ||
>>> 	    to_tdx(vcpu)->vp_enter_args.r12)
>>> 		return false;
>>
>> Ah, I really should have checked the code more carefully.
>>
>>>> in tdx_handle_exit().
>>>> [1]
>>>> https://lore.kernel.org/all/646f9595-459f-4224-b4e5-4ec2eecc0bc6@intel.com/
>>>>> And once we track the exit_reason separately from vp_enter_ret, IMO it all becomes
>>>>> more logical and easier to follow.  vp_enter_ret holds the information about why
>>>>> VP.ENTER returned/exited, while exit_reason holds information about why the _guest_
>>>>> exited.  Obviously it's imperfect since we're still fudging EXIT_REASON_EPT_MISCONFIG,
>>>>> but again, I think that's a better alternative than demuxing exit_reason in multiple
>>>>> locations.
>>>>
>>>> The question do we really need to swizzle EXIT_REASON_TDCALL to other exit
>>>> reasons ahead? why cannot them just be handled in the central handler for
>>>> EXIT_REASON_TDCALL?
>>>
>>> Because as above, it's not as central as you think.  If we want to not swizzle
>>> the exit_reason, then IMO the only sane way to do that is to not track exit_reason
>>> for TDX vCPUs, i.e. move vcpu_vt.exit_reason back to vcpu_vmx and force TDX to
>>> always demux vp_enter_ret every time.
>>
>> How about adding a specific field to track the TDVMCALL leaf? Full diff as
>> below (the EPT MISCONFIG part can be split into a separate one)
> 
> I like it even less than demuxing vp_enter_ret on demand.  It has all the same
> flaws as demuxing vp_enter_ret, because it's effectively just a cache of the
> result of demuxing vp_enter_ret.  And caching values on entry/exit boundaries
> adds additional risk;  I can point you at a number of bugs in the past where KVM
> consumed stale data, e.g. because some chunk of code got moved to run before a
> cached field was refreshed.  That's unlikekly to be a problem here, but anytime
> data is cached it introduces risk of consuming stale data.
> 
> And the cost of demuxing vp_enter_ret every time doesn't concern me, at all.
> What I don't like is relying on call sites to know that the exit_reason needs to
> be demuxed in the first place, because that will be brittle and error prone.

Do you mean that with my diff, the consumers of tdx_is_tdvmcall() rely 
on handle_tdcall() being called already?

If so, I get your point.

> That's why I'd be ok if vcpu_vt.exit_reason simply didn't exist: it becomes
> impossible to check the wrong exit field because there's only one such field.
> 
> I'm ok caching the fully processed vcpu_vt.exit_reason, i.e. with the code now,
> because only the TDVMCALL path needs to be aware that it may have undergone
> processing, *and* KVM can WARN if that processing didn't happen as expected.
> 
> Whereas checking the "right" exit reason requires doing so in multiple paths and
> doesn't have a natural sanity check.

I'm OK with it.

After changing to use tdx_is_exit_reason_valid() instead of checking 
(*reason != -1u) in tdx_get_exit_info(), the only issue is 
trace_kvm_exit() prints 0x0000ffff when real EPT MISCONFIG happens. But 
it can be resolved by your suggestion below. So current implementation 
can still work.

btw, below change will also be in another separate series.

@@ -964,10 +968,10 @@ static __always_inline union vmx_exit_reason 
tdx_to_vmx_exit_reason(struct kvm_v
                 break;
         case EXIT_REASON_EPT_MISCONFIG:
                 /*
-                * Defer KVM_BUG_ON() until tdx_handle_exit() because 
this is in
-                * non-instrumentable code with interrupts disabled.
+                * Actual EPT Misconfigs are KVM/kernel software bugs. 
Set the
+                * status accordingly to differentiate from emulated 
MMIO exits.
                  */
-               exit_reason.basic = TDX_INVALID_EXIT_REASON;
+               tdx->vp_enter_status = TDX_SW_ERROR;
                 break;
         default:
                 break;

