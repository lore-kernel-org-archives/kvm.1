Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449AF3A83A9;
	Wed,  9 Sep 2026 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948063; cv=none; b=dfAItVhyHdwhnZ4YA8Bd0WcLWgvcQDg2Zib0eioiFfimpESSWfReAJB8qn2nNgEkH1N+hV0iksLPic3PRSCoyyDasf/qwWId+ugVFgWrOf3zaT94UxQsRcwXrQw5vBpctAjI3yspDvXSbbH+uZsAlRZDIMuP7OVgruMh7QikGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948063; c=relaxed/simple;
	bh=B6Qt25OuTqtkuGvzWvj8Twbkq9CimBvAvLdJgqS40FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LM6FBqEQtuQB7EMhNC4A1rQjdNGdYv0cQK5O0txnzYGwHQou/bKqntv/BFQlx+jduWvm2SjTKRQ4L581dCr0VzvWkHIN4AdBDmsaaH5iAl36l8IDuk83ovIb67tmjHcqB5U003EQaVVdSt4mWg/Ew4Ggcr5ZeJBFKrpabeFxx7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXQ1fCUc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXQ1fCUc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788948062; x=1820484062;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B6Qt25OuTqtkuGvzWvj8Twbkq9CimBvAvLdJgqS40FM=;
  b=PXQ1fCUcVX0iFx11SGn+B1B1x/PzkDXvFKFpHy7SHV+vZRq7mMDfKKdb
   AA2yBkxVsJ98wynZvKH1jMLAh74hCLItslnJebZmaYSVn/mDzqn5fTmoH
   ICwx3xtsrHamFrgjyiifPrn/F4Yl5lMUCLWwRT54GpTqMTdwxT343i+1q
   WuYi7xHQ6HIVKI/D+yLkR6FTT+PVXBwNl+jkqgpwuAal1k3q+QeEhWqZB
   GgZjQRmrzF1zHSmVA/73Ct1qEzQ1htno5lQY9VTWE5TieAnGq0RGpc54h
   5bhibWnm6TCWJ9q2mVa2sXugEZ32gVxHz1A6x03L/G9vJGgP4PLes8cAF
   A==;
X-CSE-ConnectionGUID: SvXKLweWTSagjJurKqYB/A==
X-CSE-MsgGUID: vEcryGXQQTGIsIT6CsfT3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89237242"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="89237242"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 03:01:01 -0700
X-CSE-ConnectionGUID: WRGhmTRgTD6KrriTyAUNvQ==
X-CSE-MsgGUID: QefQ/gXsSpu454ncGvo6XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="269519407"
Received: from unknown (HELO [10.238.208.122]) ([10.238.208.122])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 03:00:56 -0700
Message-ID: <07cf5761-48fe-40b7-9310-b64712f5e314@intel.com>
Date: Wed, 9 Sep 2026 18:00:53 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/22] KVM: selftests: Initialize the TDX VM
To: Ackerley Tng <ackerleytng@google.com>, Lisa Wang <wyihan@google.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>,
 Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-3-15ad654a50db@google.com>
 <c8b7a800-58ed-4ef7-91bd-31da77763717@intel.com>
 <ap_Bpe7dZm_eWsJ2@google.com>
 <CAEvNRgFHTAPYTVQ8a_PVdFLqQ8z07Uep2XhA9r_Ypw+D0WAC8w@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CAEvNRgFHTAPYTVQ8a_PVdFLqQ8z07Uep2XhA9r_Ypw+D0WAC8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/2026 2:08 AM, Ackerley Tng wrote:
> Lisa Wang <wyihan@google.com> writes:
> 
>> On Thu, Jul 23, 2026 at 04:44:08PM +0800, Xiaoyao Li wrote:
>>>> + */
>>>> +#define __tdx_vm_ioctl(vm, cmd, _flags, arg)				\
>>>
>>> sev uses the name __vm_sev_ioctl, I think we need to keep them consistent.
>>
>> While __vm_tdx_ioctl matches SEV, the TDX selftest follows a tdx_<scope>_*
>> naming convention (1. TDX prefix, 2. Scope: VM or vCPU). I named it
>> __tdx_vm_ioctl to keep the TDX codebase internally consistent.[1]
>>
>> Do you think we should align with SEV's naming convention instead of
>> sticking with the internal TDX pattern?
>>
>> [1]: https://lore.kernel.org/kvm/489f3c7b-db03-43dc-bb64-910a0fcba31e@intel.com/
>>
> 
> Given that __vm_sev_ioctl and __tdx_vm_ioctl aren't likely to appear
> next to each other, I think it's better to have the tdx prefix earlier
> to keep the TDX code consistent. To move things along, I think we could
> continue as-is and not swap to align with sev.
> 
> (The sev functions actually look kind of inconsistent in sev.h, but
> that's a discussion for another series.)

Yeah, either adjusting this patch to follow SEV or renaming existing SEV
MACROs is OK.

Keep the patch as-is and leave the SEV work to future are OK.

>>>> +({									\
>>>> +	u64 r;								\
>>>> +									\
>>>> +	union {								\
>>>> +		struct kvm_tdx_cmd c;					\
>>>> +		unsigned long raw;					\
>>>> +	} tdx_cmd = { .c = {						\
>>>> +		.id = (cmd),						\
>>>> +		.flags = (u32)(_flags),					\
>>>> +		.data = (u64)(arg),					\
>>>> +	} };								\
>>>> +									\
>>>> +	r = __vm_ioctl(vm, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
>>>> +	r ?: tdx_cmd.c.hw_error;					\
>>>
>>> I know it takes the same handling from __vm_sev_ioctl(). But I think the
>>> handling for hw_error is not correct, at least for TDX (I didn't check for
>>> SEV).
>>>
>>> the hw_error is the additional info, to tell the SEAMCALL return code, when
>>> the IOCTL fails. KVM requires hw_error to be in the input, and KVM puts the
>>> SEAMCALL return code into hw_error when the IOCTL fails due to SEAMCALL
>>> failure. That means, when r == 0, the hw_error is always 0.
>>>
>>> I think we need to provide hw_error along with r to the caller so that
>>> caller can print them together.
>>
>> I think the value of r is not important, because the ioctl failure
>> is already captured in errno.
>>
>> We only need to fix the return values for SEV and TDX and have
>> TEST_ASSERT_* print formatted error logs with errno and hw_error.
>>
>> - r ?: {tdx, sev}_cmd.c.hw_error;
>> + r ? {tdx, sev}_cmd.c.hw_error : 0;
>>

No. It is not correct because hw_error can be 0 when r != 0.

> I didn't look in detail, perhaps Lisa could look into these:
> 
> + What are the possible values of r? Is it always going to be 1 on
>   error?
> + Is r always positive or negative?
> + Is tdx_cmd.c.hw_error always positive or negative? It's probably not
>   one of the standard Linux errors, right?
> 
> Perhaps squashing hw_error together with a retval conflates the two.
> 
> In the lower-level __tdx_vm_ioctl() we could pass a hw_error and have
> the macro set hw_error? That will allow the caller to print both.

yeah. This idea can work.

>>>> +})
>>>> +
>>>> +#define tdx_vm_ioctl(vm, cmd, flags, arg)				\
>>>> +({									\
>>>> +	u64 ret = __tdx_vm_ioctl(vm, cmd, flags, arg);			\
>>>> +									\
>>>> +	if (ret) {							\
>>>> +		TEST_ASSERT(!ret,					\
>>>> +			    "%s failed, rc: 0x%llx errno: %i (%s)",	\
>>>> +			    #cmd, (unsigned long long)ret,		\
>>>> +			    errno, strerror(errno));			\
>>>
>>> The if() looks silly. Why add it? And why change it from
>>> __TEST_ASSERT_VM_VCPU_IOCTL() in the v13?
>>>
>>> Considering the suggestion of hw_error above, I think we need to introduce
>>> the TEST_ASSERT_TDX_VM_VCPU_IOCTL() which accepts additional hw_error?
>>
>> The reason we could not use __TEST_ASSERT_VM_VCPU_IOCTL() directly[2] is
>> because it formats ther return value as %i (32-bit), whereas
>> __tdx_vm_ioctl might return a u64 hardware error code.
>>

Since we cannot simply use hw_error to replace ret, there will be not 32bit
vs 64bit issue. But ...

>> I agree with your suggestion to introduce a new
>> TEST_ASSERT_TDX_VM_VCPU_IOCTL() macro to print out u64 hardware error
>> code properly.

... if we want to print hw_error as well, we still need a new macro.

>> [2]: https://lore.kernel.org/all/a58e2941-77f9-43cf-a54d-023506dd7eb0@linux.intel.com/
>>
> 
> Is tdx_vm_ioctl() the only place where TEST_ASSERT_TDX_VM_VCPU_IOCTL()
> is going to be used though? If so, maybe we should defer introducing
> TEST_ASSERT_TDX_VM_VCPU_IOCTL() till later.

I think tdx_vcpu_ioctl() will use it as well?

> I think the issue with if (ret) is just that TEST_ASSERT(!ret) already
> does that same check, and so we can drop the if (ret) part.
> 
