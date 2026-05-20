Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F3931B114;
	Wed, 20 May 2026 05:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779253363; cv=none; b=srkSNvECTukEO3n5HotT2IP85cmzDvNNfwcHL1OP2nKyo0BBnzAxT7ejvr8yR/jyQOmSNVbN09dMe275IXSX9fSmffsL8vP6FvBfaIOLe62JC5LX9/KUbvaC0pE1b26PUHvZMM8MIQf3kzHcNUXVy/tN13uGf+Ty09MkbEVS1aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779253363; c=relaxed/simple;
	bh=vk+Y4qqXFyg/b/b5BuR0NkVyVGyXn6ECSZWi7zrenqs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HWk87AWGV6nJKSwTvF7B0hPbL15FVmI+TPbwNeQVqSGAF7QKts0z6N0UHtaypAAsEkT9HA40p6il6X3d8GNhYGLTanKDvQKLxZw/TOXf+yR3QwW/CA9RH7aP4pPzXNc6M4nfLk21qV0M0DQKn4Y1BmMCZB/CXnwXAzyhReSrTGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XLgGqTVP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLgGqTVP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779253362; x=1810789362;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=vk+Y4qqXFyg/b/b5BuR0NkVyVGyXn6ECSZWi7zrenqs=;
  b=XLgGqTVPsHEnBhKgtFp+toCQBnOJgta3fr9qUmAwuricLrguLARN5J/z
   08gzw7fXJu+sMfeOferKLUZGEW+4rUML+WKN7chUuFkiI+52zfzRL4ydf
   vUeauDcY9EWMW21cRuN9N+hxjwcNGDxu+TMsSuDGIhPo/isL1NK0kznwA
   e4iqWTysEemP47L+nSTY8t6bm95TV12H1+P7pa/MGjaQrVcGca16TiiHB
   g4uoiBhy9CiRijoLC0B5ps+LsbpgEDWGrgAdeCeRgXCY4M3ojTmoZLx80
   45hppgiSRI9v9tOtgdHmUqHaOxObb4RiOBcZ/GisB2EZ4nu9qYjkWvhmc
   g==;
X-CSE-ConnectionGUID: b/i78g3YTuOSYxPLE//yDA==
X-CSE-MsgGUID: ai6sKc0mQhK+SxkeIyXuGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91537433"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="91537433"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 22:02:41 -0700
X-CSE-ConnectionGUID: olqJTcuFQkmbuOfEsizLUw==
X-CSE-MsgGUID: 6dI39uEPQcmIpfMX/t+Ibg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="240282415"
Received: from fanlilin-mobl.ccr.corp.intel.com (HELO [10.238.1.228]) ([10.238.1.228])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 22:02:38 -0700
Message-ID: <3beeaf04-e4f9-44cf-a3a3-04fa12912848@linux.intel.com>
Date: Wed, 20 May 2026 13:02:35 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] KVM: x86/xen: Don't truncate RAX when handling
 hypercall from protected guest
From: Binbin Wu <binbin.wu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>,
 Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Paul Durrant <paul@xen.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
 <20260514215355.1648463-4-seanjc@google.com>
 <27ba35fd-5563-4bbd-8f95-2285b50efa7a@linux.intel.com>
 <agcXr2FP4C3I_jbQ@google.com>
 <52fdc61a-60e8-4547-8ff7-f249b4d667b9@linux.intel.com>
 <ad4934f4a663c448924aeabe6418e68ae3ef9813.camel@infradead.org>
 <868898e6-1c57-498d-848d-1df9cbeac23c@linux.intel.com>
 <d7af5a04a11432ea1878431e8b51061f19c16061.camel@infradead.org>
 <dc62e58e-b6ee-41e1-84a5-0716822fefc8@linux.intel.com>
Content-Language: en-US
In-Reply-To: <dc62e58e-b6ee-41e1-84a5-0716822fefc8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/18/2026 5:55 PM, Binbin Wu wrote:
> 
> 
> On 5/18/2026 5:50 PM, David Woodhouse wrote:
>> On Mon, 2026-05-18 at 17:43 +0800, Binbin Wu wrote:
>>>
>>>
>>> On 5/18/2026 3:15 PM, David Woodhouse wrote:
>>>> On Mon, 2026-05-18 at 10:19 +0800, Binbin Wu wrote:
>>>>>  
>>>>>>>>   	longmode = is_64_bit_hypercall(vcpu);
>>>>>>>
>>>>>>> Is the variable name misleading?
>>>>>>
>>>>>> It most definitely is.  However, @longmode is passed around quite a few locations
>>>>>> in xen.c, and so I don't want to opportunistically fix this one variable.  Though
>>>>>> I'm definitely not opposed to a separate patch to rename them all to is_64bit or
>>>>>> something.
>>>>>
>>>>> OK, I can do it.
>>>>
>>>> This one (as shown above) is clearly indicating whether this particular
>>>> vCPU is in 64-bit mode for this particular hypercall. Changing that to
>>>> is_64bit makes sense.
>>>>
>>>> However, there is a separate overall mode for the VM, which is stored
>>>> in 'kvm->arch.xen.long_mode' and accessed by userspace using the
>>>> KVM_XEN_ATTR_TYPE_LONG_MODE attribute. It affects the datatypes used by
>>>> shared memory data structures, and is also latched by the kernel when
>>>> the guest writes the MSR for the hypercall page. That one should
>>>> probably keep its name.
>>>
>>> For this one, I think the current KVM code is consistent.
>>> The format is determined by EFER.LMA, whether the guest is running in 64 bit or
>>> compatible mode doesn't change the ABI.

I still have a point of confusion.

I noticed a behavioral mismatch between KVM and Xen regarding when they switch
to the standard/compat shared info.
- In Xen: The 32-bit shared info structure is latched if the current vCPU is
  not in 64-bit mode:
  hvm_latch_shinfo_size
      d->arch.has_32bit_shinfo = hvm_guest_x86_mode(current) != X86_MODE_64BIT

- In KVM: It evaluates is_long_mode(vcpu) instead. E.g.,
  kvm_xen_write_hypercall_page
      bool lm = is_long_mode(vcpu);
      ...
      kvm->arch.xen.long_mode = lm;

In theory, these two checks could differ when the guest kernel is running in
a 32-bit compatibility mode. However, I believe this mismatch is fine in
practice for two reasons:
- Mainstream 64-bit OSes don't run in compatibility mode for kernel code after
  the early init.
- By default, HVM guests cannot issue hypercalls from userspace. The only one
  exception HVMOP_guest_request_vm_event is not related to the share info.

So the vCPU will never be in compatibility mode when a related hypercall occurs.
In this specific operational context, evaluating is_long_mode() yields the
exact same functional outcome as checking for 64-bit execution mode. Am I
missing anything here?


>>
>> Agreed. For the hypercall case you're looking at, switching the name to
>> is_64bit makes sense.
>>
>>> struct compat_shared_info is used only when the guest is running natively in a
>>> 32-bit build.
>>
>> The struct compat_shared_info is also used in !kvm->arch.xen.long_mode
>> on a 64-bit host, as that's what means the guest is considered to be a
>> 32-bit guest.
>>
>> It's somewhat orthogonal from whether any given vCPU is making any
>> given hypercall while in 64-bit mode. The 'long_mode' is *latched* at
>> certain specific times which are defined by Xen's historical behaviour.
>>
>> I'm suggesting that you clean up longmode→is_64bit for the *hypercalls*
>> but leave 'long_mode' as is.
>>
> 
> Yes, will only do it for is_64_bit_hypercall().
> 
>>
> 

