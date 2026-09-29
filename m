Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806A241A92C
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687347; cv=none; b=sBwBWPSzUkVIGyI2JI/QxDJgBLLeSCNK0m1eu3H7nO8f4ECAqS8rSs9TZ1gWcxFsWJO3z0yCLQT0LaALmwjsSGhzhu4wmeRVQ3eNLojhLqB85DOe+fpmK56DymFM9i+/3TPkpNUn/GUjL7fzOE6uN2zFpqXN+9SWPqILVTSzqRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687347; c=relaxed/simple;
	bh=pMl+8QYd2Lz5x4ZfIFFrqKfkCgEJJ7MdB2xi0xnzCRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxOkjZ3hVe372/brLKBU5zTFwHMJZ2HtO2h2eygkxnv3MrsR1BTBCExb4kjOasufNmy6IAbVpNijeptT2lbZ9Hm/CRM6oG0RgenD/74LZp2YmjclxV0uJ2V1cx4kQ4PfC9EUL7tjCx2JqJG/agF0SHHBKAesQVbt4t8kxRCaRms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHSU42fp; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHSU42fp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790687345; x=1822223345;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pMl+8QYd2Lz5x4ZfIFFrqKfkCgEJJ7MdB2xi0xnzCRo=;
  b=fHSU42fpeL9WoyTnJxLCxX5p6eU/x7n8CeFdfoDSEOMWCGXlPgwvzr/D
   zeMvT+5nFYeetRU3/cZlnyWEwJ0EAkYgOafOq1U4J3lqg2Qe2kfrlt28S
   nhhzGiq88kGYwqRHeZyceIw8o1AQXKU7uMdJ3n17NS0oEIkzRgtYLtZq7
   MHFLiUtqV/q534kZ7kaBv9uTPh4kcRBTLzO7qG/aZ4abjdj+Y0nK3o0x2
   uFmAys5fYqFxsInGg2nTWUJKal2soJXIUeXSHvDO3uT84t/pYF/HK7wxf
   11RZwX8TR0cIPNiDZJZjUhd3bjp9cLfLvf3mATlJGlMkyNhGvv+tclv/D
   Q==;
X-CSE-ConnectionGUID: tQlXgTUoRmaNtWxkvD8wuw==
X-CSE-MsgGUID: orVuswfUQs6JJuNtpuWM7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="95216991"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="95216991"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 06:09:04 -0700
X-CSE-ConnectionGUID: QW1ff3QHTeWSlRXYVLnHGA==
X-CSE-MsgGUID: +1bLjB0CS6upBCrmshkmBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="280101375"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 06:09:03 -0700
Message-ID: <36b42923-21ee-4cac-b050-781770824037@intel.com>
Date: Tue, 29 Sep 2026 21:09:01 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH] x86/run: Use separate "-accel" option to
 configure the accelerator
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
References: <20260528071712.1407929-1-xiaoyao.li@intel.com>
 <ahg8i_Zv9TRk-UzE@google.com>
 <7987e722-4ee3-4d6c-a4b7-369cfd272dac@intel.com>
 <fe9d441a-91b1-4084-8e1c-71813c3c8bb2@intel.com>
 <ah7mxim83BLuF-Ia@google.com> <ah87cbm6mxt0aWWk@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ah87cbm6mxt0aWWk@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/3/2026 4:22 AM, Sean Christopherson wrote:
> On Tue, Jun 02, 2026, Sean Christopherson wrote:
>> On Tue, Jun 02, 2026, Xiaoyao Li wrote:
>>> On 5/29/2026 8:09 AM, Xiaoyao Li wrote:
>>>> On 5/28/2026 9:00 PM, Sean Christopherson wrote:
>>>>> On Thu, May 28, 2026, Xiaoyao Li wrote:
>>>>>> When configuring accelerator via machine's "accel" property, it cannot
>>>>>> pass additional ACCEL_PROPS. For example, it hits following error when
>>>>>> configuring KVM with "notify-vmexit":
>>>>>>
>>>>>>    # ACCEL="kvm,notify-vmexit=internal-error" ./x86-run x86/apic.c
>>>>>>    #   qemu-system-x86_64: Property
>>>>>> 'pc-i440fx-11.1-machine.notify- vmexit' not found
>>>>>>
>>>>>> Switch to use separate "-accel" option to configure the accelerator.
>>>>>>
>>>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>>>> ---
>>>>>>   x86/run | 2 +-
>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/x86/run b/x86/run
>>>>>> index dd38f14c871f..a68d469dd1b8 100755
>>>>>> --- a/x86/run
>>>>>> +++ b/x86/run
>>>>>> @@ -43,7 +43,7 @@ fi
>>>>>>   pit="-global kvm-pit.lost_tick_policy=discard"
>>>>>>   command="${qemu} --no-reboot -nodefaults $pit $pc_testdev
>>>>>> -display none -serial stdio $pci_testdev"
>>>>>> -command+=" -machine accel=$ACCEL$ACCEL_PROPS"
>>>>>> +command+=" -accel $ACCEL$ACCEL_PROPS"
>>>>>
>>>>> This breaks my setup for specifying kernel_irqchip=split.
>>>>>
>>>>>    qemu: -accel kvm,kernel_irqchip=split: Property 'kvm-
>>>>> accel.kernel_irqchip' not found
>>>>
>>>> If you switch "kernel_irqchip" to "kernel-irqchip", it should work again.
>>>>
>>>> This needs to be fixed on QEMU side. I'll look at it.
>>>
>>> Well, I feel hard to justify a QEMU "fix" for it.
>>>
>>> "kernel_irqchip" was a property of "machine" in old QEMU, and QEMU switched
>>> it to "kernel-irqchip" automatically.
>>>
>>> Then QEMU moved it to be a property of "accel", while keeping the
>>> compatibility when users configure it via "machine" that QEMU internally
>>> setting it to accel's property in this case.
>>>
>>> However, "kernel_irqchip" is only valid on "machine", but not on "accel".
>>>
>>> For this KVM unit test issue, do we need to add workaround to keep your
>>> (work-by-accident) usage working? or just kill it?
>>
>> Nah, just switch to "accel" and call it good.  I'm likely the one and only user
>> of kernel_irqchip.
> 
> There's another problem: the CET and LAM tests force -enable-kvm:
> 
>   [cet]
>   file = cet.flat
>   arch = x86_64
>   smp = 2
>   qemu_params = -enable-kvm -m 2048 -cpu host
> 
>   [lam]
>   file = lam.flat
>   arch = x86_64
>   qemu_params = -enable-kvm -cpu max
> 
> Which apparently is wired up to "-machine accel=" under the hood, because they
> get skipped with:
> 
>   SKIP cet (qemu: The -accel and "-machine accel=" options are incompatible)
>   SKIP lam (qemu: The -accel and "-machine accel=" options are incompatible)

Oh, sorry for not respond. I didn't see this mail until I decided to ping you
for this patch after I noticed you were queuing kvm-unit-test patches.

I just sent a v2, which adds one patch to handle cet and lam tests:

https://lore.kernel.org/all/20260929202434.174501-1-xiaoyao.li@intel.com/
