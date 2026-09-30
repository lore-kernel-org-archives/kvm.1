Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157084E73D3
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779799; cv=none; b=E6ROWqfPBanpYmuK7OdXMUyHZI6UC/pN6XTHNmrWRvZj5Z7x+6d6i85KORzUz0PIN1tVqG9eX/Lg3uUbkSuhgDS2qE1lmJ0V2PYoZ86ITQlHjlw7oRQk6r2KgEG+TYVswOWs7eyN8fViO5sCzML7QW/5CRYJ8r3/FPAwg7Z0kic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779799; c=relaxed/simple;
	bh=GN+lCNR/WgpD4suO2HiLUZK89FYi0DP50mNlzDcMs8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bL6n9BHyjyaGz1KJ6tbAAy2gIIP6aS/rSv+0QQKVqunvBMJq5StkETkiZyVc4KQ5zMQK6ksGbbsQd/qzEtNOvZw8hSUEuyUFt7s4CquRXgoO8Oxd9VoGA5lOkHbsLYKOscMXMcpQZTWUBdo+ABxq244YhFwT2EooE5hKzw5a+PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrJSKwOB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrJSKwOB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790779792; x=1822315792;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GN+lCNR/WgpD4suO2HiLUZK89FYi0DP50mNlzDcMs8Y=;
  b=BrJSKwOBnl9QpVBq3wMpmBjCSM2uhkPyyhbdpjBLHP93nlW0Mj1rpXbt
   H6TYv0GvyGtQDI8upEjdp1jyBf8MfjgzumykNkAGl4KNmlcNH2Cn25qvy
   CwnBgWtuMN79zlIr3am0Iq5Ai+In3/MQDR2vEah56yadm2/7TyTOtbx/D
   NCMRLMtMKBZ4w8PspVIfT9aNA0V076dKSO8UNNgAwzd3DC/ZsKCZLePfN
   YYZdWqCMjlP8fiO7/+G5cPHOmk43dnA+X00SdUaZf0WH789bqSaWkYjIF
   LmcfN85IgvdGc0U+QZpPURyqM1sIlz3mfvRsH180V0jLKeupu1xPrX+a+
   g==;
X-CSE-ConnectionGUID: UyidVtayQxKt73xoTfDLYw==
X-CSE-MsgGUID: mwXQXAnRRg6lCQihaVfG6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90648695"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90648695"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 07:49:46 -0700
X-CSE-ConnectionGUID: Z99PrH4VSJmhh028KRYmTg==
X-CSE-MsgGUID: i81fJ2tvTEqA9B7ihmm1gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="274825042"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 07:49:45 -0700
Message-ID: <0f19da61-4138-48e8-b08a-72b68ff2d3fe@intel.com>
Date: Wed, 30 Sep 2026 22:49:42 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2 2/2] x86/run: Use separate "-accel"
 option to configure the accelerator
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
References: <20260929202434.174501-1-xiaoyao.li@intel.com>
 <20260929202434.174501-3-xiaoyao.li@intel.com> <arxdQWchYIct3TPT@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <arxdQWchYIct3TPT@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/2026 8:52 AM, Sean Christopherson wrote:
> On Tue, Sep 29, 2026, Xiaoyao Li wrote:
>> When configuring accelerator via machine's "accel" property, it cannot
>> pass additional ACCEL_PROPS. For example, it hits following error when
>> configuring KVM with "notify-vmexit":
>>
>>   # ACCEL="kvm,notify-vmexit=internal-error" ./x86-run x86/apic.c
>>   #   qemu-system-x86_64: Property 'pc-i440fx-11.1-machine.notify-vmexit' not found
>>
>> Switch to use separate "-accel" option to configure the accelerator.
> 
> FYI, this breaks the intel_iommu test when running with ACCEL="kvm,kernel-irqchip=on"
> because that's a split-only test:
> 
>   qemu_params = -M q35,kernel-irqchip=split -device intel-iommu,intremap=on,eim=off -device edu
> 
> and QEMU doesn't munge things together:
> 
>   qemu: -device intel-iommu,intremap=on,eim=off: Interrupt Remapping cannot work with kernel-irqchip=on, please use 'split|off'.

Because before this patch, the final QEMU command with
ACCEL="kvm,kernel-irqchip=on" is

   ... -machine accel=kvm,kernel-irqchip=on -kernel x86/intel-iommu.flat -smp 4
-M q35,kernel-irqchip=split -device intel-iommu,intremap=on,eim=off -device edu

ACCEL="kvm,kernel-irqchip=on" is made into the first "-machine
accel=kvm,kernel-irqchip=on" and qemu_params is put at the end, which has "-M
q35,kernel-irqchip=split". So the later "-M q35,kernel-irqchip=split" overrides
the earlier "kernel-irqchip=on" and it actually runs with kenrnel-irqchip=split.

But after this patch, the QEMU command becomes

   ... -accel kvm,kernel-irqchip=on -kernel x86/intel-iommu.flat -smp 4 -M
q35,kernel-irqchip=split -device intel-iommu,intremap=on,eim=off -device edu

though "-M q35,kernel-irqchip=split" is put behind "-accel
kvm,kernel-irqchip=on", QEMU applies "-accel" after "machine's kernel-irqchip".
So the final kernel-irqchip=on, which leads to the failure of Interrupt Remapping.

> Given that I'm pretty sure I'm literally the only person the world that runs KUT
> with ACCEL="kvm,kernel-irqchip=on", I'm going to apply this as-is.  I can filter
> out the failures very easily, and unlike the CET/LAM issue, this doesn't cause
> problems for ACCEL="kvm,kernel-irqchip=split", i.e. there's no loss in coverage.
> 
> If this impacts someone else, or someone really wants to figure out how to splice
> all of this together, I'm happy to revisit things.  For now, I just want to
> unblock the notify-vmexit stuff.
> 
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>  x86/run | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/x86/run b/x86/run
>> index dd38f14c871f..a68d469dd1b8 100755
>> --- a/x86/run
>> +++ b/x86/run
>> @@ -43,7 +43,7 @@ fi
>>  pit="-global kvm-pit.lost_tick_policy=discard"
>>  
>>  command="${qemu} --no-reboot -nodefaults $pit $pc_testdev -display none -serial stdio $pci_testdev"
>> -command+=" -machine accel=$ACCEL$ACCEL_PROPS"
>> +command+=" -accel $ACCEL$ACCEL_PROPS"
>>  if [ "${CONFIG_EFI}" != y ]; then
>>  	command+=" -kernel"
>>  fi
>> -- 
>> 2.53.0
>>
>>

