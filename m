Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14311799F
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 00:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780013396; cv=none; b=aiVrhuWEj+mrWvYLpXd3jXAFKTZtl51MqfoP4DKh85mcE06DSQR337MBxHcD71MTYhlQkBPewKP3lZ8phkgCVfqJa/gwqMURyJ5+Nz6y2/siyfY9L99qo47l0qWy/TyQPYeiMaaNr+ZnlhioNS6iksavkf89kSl9QPKlgAMF4rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780013396; c=relaxed/simple;
	bh=Zn5eZWVQ4KFpeEib3mR5P803h2YNwZRyvrSP/AFLBXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhkeQurVgFkyHVKxt39moKSIze2VWzd7/ib+RtGJPipgOd5T2BysdtDhuSH+I+yKNOqZ2oO8OFvSjyDK7gjbgLt8Kj+zM1JX46GN5IsTChySPKCyzaHjoUvAJOPNv1J3cjpj5QMW1w9I4hpBhMN1dw48pbq6Uj8OUQR+AO9Y5AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UBO2izH5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UBO2izH5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780013393; x=1811549393;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zn5eZWVQ4KFpeEib3mR5P803h2YNwZRyvrSP/AFLBXo=;
  b=UBO2izH5fZ/IeyBYO99Fp/YdoiBUuz80LrbqaGdPw2J/5HtTcTVxDsaX
   7NbfkZ6fKMIlSuC6qzZ9BxpL4E8b59AiuPbNghjg7yC6yIWRzwvfxi3uJ
   x3oTZh2iTUkpltQIRXV4jRlS9pNk4aP1D2dHj9Dxhh/K4jgfmiQSMHJsD
   5wVeXWSRgToszI5o0B5NggcE8UqnA3SF2trzEkn63+6dLzWAb5PtnVwF1
   UwhOaJkWSdVSDu46yXWbQ4hjj+Ui/CgKqc0zdAHPL5aRdUPCQq8aTDNI+
   ywzJDw046S+zR4enHGYRj0fIs3BwF168/o2l/cwr/UgOHAcFGo1cPLSKz
   w==;
X-CSE-ConnectionGUID: OqTo6tODQfe369wp+WiLcg==
X-CSE-MsgGUID: 262xR5/nRk6//FsLwOM/Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="92340964"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="92340964"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 17:09:53 -0700
X-CSE-ConnectionGUID: 845DbLNoRsm+/bYO0ZLxLw==
X-CSE-MsgGUID: 4Nh1XpNkR6i5PXOwPNaRqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="238509762"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 17:09:51 -0700
Message-ID: <7987e722-4ee3-4d6c-a4b7-369cfd272dac@intel.com>
Date: Fri, 29 May 2026 08:09:48 +0800
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
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ahg8i_Zv9TRk-UzE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/2026 9:00 PM, Sean Christopherson wrote:
> On Thu, May 28, 2026, Xiaoyao Li wrote:
>> When configuring accelerator via machine's "accel" property, it cannot
>> pass additional ACCEL_PROPS. For example, it hits following error when
>> configuring KVM with "notify-vmexit":
>>
>>    # ACCEL="kvm,notify-vmexit=internal-error" ./x86-run x86/apic.c
>>    #   qemu-system-x86_64: Property 'pc-i440fx-11.1-machine.notify-vmexit' not found
>>
>> Switch to use separate "-accel" option to configure the accelerator.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   x86/run | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/x86/run b/x86/run
>> index dd38f14c871f..a68d469dd1b8 100755
>> --- a/x86/run
>> +++ b/x86/run
>> @@ -43,7 +43,7 @@ fi
>>   pit="-global kvm-pit.lost_tick_policy=discard"
>>   
>>   command="${qemu} --no-reboot -nodefaults $pit $pc_testdev -display none -serial stdio $pci_testdev"
>> -command+=" -machine accel=$ACCEL$ACCEL_PROPS"
>> +command+=" -accel $ACCEL$ACCEL_PROPS"
> 
> This breaks my setup for specifying kernel_irqchip=split.
> 
>    qemu: -accel kvm,kernel_irqchip=split: Property 'kvm-accel.kernel_irqchip' not found

If you switch "kernel_irqchip" to "kernel-irqchip", it should work again.

This needs to be fixed on QEMU side. I'll look at it.

