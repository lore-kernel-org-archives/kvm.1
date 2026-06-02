Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1FB27A47F
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780394445; cv=none; b=kziVuQQj+ZA7bEjtk80qmvqNgsSGA0+CJY51uIHU4ZTKE/WP/XDMwewYkIN+9kcw31P/t64iE2Qu4VEnsYpvqiTULVi9NGpXnPTg6UNI3D2oGy1f3l4A7/sNq5EPKI2SSS7wKq17/mojfcezCo+34wpaNTL32tpP8b8hGbEzkM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780394445; c=relaxed/simple;
	bh=Atf0HQ/BkCAA1oatoUeBqRikd/u59S6s/D9FUGXHoKk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pvPcFHV3haDLtVqxxR5wNohVeM4NPtCgj1Gyta9l3+rDe/KYHNVCkUR1CbjbX9IvrIZh6bw+2pkeIijTZBplVfNMdKXwhIQD3NKxUkDzw4v+eB3BUsNWoF9WVp/oeSf13HZBPUV29vA7sJkhdZ9kS+qYq8k6c9OEZN/zXzRILJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UmBZ9Iuk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmBZ9Iuk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780394444; x=1811930444;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Atf0HQ/BkCAA1oatoUeBqRikd/u59S6s/D9FUGXHoKk=;
  b=UmBZ9IukY6UNnXvylRnS9eUajcXu8yywFLd3YjKN4SUpi0sS7Pt093xM
   xTEcROuEML6AP/IvqkB41pWd46zCFIhesW9Yrk7xFxBVN4s1DLOMM8kzx
   +WAUrKFHcrUAeWfHFNJPP6uz9OPnljQzY8kgclQhAHE7Axqny9qO/Lv1M
   2n0dLRprnDzngcFrzJS+HcYXaczZwFn4tL6glL1PWCD0xmkwPaDNBQlGm
   KnAv/CykzgeMcGXkEO/Z8GjHEzGuXkFeXaMx+i7S9jVDiYFd/LaqcOtDL
   OXgRbyBgwvs0FTmq5muRALPbUQPTWWIJ9l8VXAP41uvhaZv1irZXuQFyK
   Q==;
X-CSE-ConnectionGUID: KWnRydXJRgKbU0Or23dExg==
X-CSE-MsgGUID: 2XELJzALQ6a6qdViPn+zeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="85062434"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="85062434"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:00:44 -0700
X-CSE-ConnectionGUID: CVOZZD+TRle5FGq7Djbi4Q==
X-CSE-MsgGUID: fpYDJbs7SlCg3QosuPMiKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="243042744"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:00:42 -0700
Message-ID: <fe9d441a-91b1-4084-8e1c-71813c3c8bb2@intel.com>
Date: Tue, 2 Jun 2026 18:00:37 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH] x86/run: Use separate "-accel" option to
 configure the accelerator
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
References: <20260528071712.1407929-1-xiaoyao.li@intel.com>
 <ahg8i_Zv9TRk-UzE@google.com>
 <7987e722-4ee3-4d6c-a4b7-369cfd272dac@intel.com>
Content-Language: en-US
In-Reply-To: <7987e722-4ee3-4d6c-a4b7-369cfd272dac@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/29/2026 8:09 AM, Xiaoyao Li wrote:
> On 5/28/2026 9:00 PM, Sean Christopherson wrote:
>> On Thu, May 28, 2026, Xiaoyao Li wrote:
>>> When configuring accelerator via machine's "accel" property, it cannot
>>> pass additional ACCEL_PROPS. For example, it hits following error when
>>> configuring KVM with "notify-vmexit":
>>>
>>>    # ACCEL="kvm,notify-vmexit=internal-error" ./x86-run x86/apic.c
>>>    #   qemu-system-x86_64: Property 'pc-i440fx-11.1-machine.notify- 
>>> vmexit' not found
>>>
>>> Switch to use separate "-accel" option to configure the accelerator.
>>>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> ---
>>>   x86/run | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/x86/run b/x86/run
>>> index dd38f14c871f..a68d469dd1b8 100755
>>> --- a/x86/run
>>> +++ b/x86/run
>>> @@ -43,7 +43,7 @@ fi
>>>   pit="-global kvm-pit.lost_tick_policy=discard"
>>>   command="${qemu} --no-reboot -nodefaults $pit $pc_testdev -display 
>>> none -serial stdio $pci_testdev"
>>> -command+=" -machine accel=$ACCEL$ACCEL_PROPS"
>>> +command+=" -accel $ACCEL$ACCEL_PROPS"
>>
>> This breaks my setup for specifying kernel_irqchip=split.
>>
>>    qemu: -accel kvm,kernel_irqchip=split: Property 'kvm- 
>> accel.kernel_irqchip' not found
> 
> If you switch "kernel_irqchip" to "kernel-irqchip", it should work again.
> 
> This needs to be fixed on QEMU side. I'll look at it.

Well, I feel hard to justify a QEMU "fix" for it.

"kernel_irqchip" was a property of "machine" in old QEMU, and QEMU 
switched it to "kernel-irqchip" automatically.

Then QEMU moved it to be a property of "accel", while keeping the 
compatibility when users configure it via "machine" that QEMU internally 
setting it to accel's property in this case.

However, "kernel_irqchip" is only valid on "machine", but not on "accel".

For this KVM unit test issue, do we need to add workaround to keep your 
(work-by-accident) usage working? or just kill it?

