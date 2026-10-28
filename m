Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149385;
	b=cpEta3Ggs2gzLf1zoukEWpDgLP0WBuc4tw9zWhOpPQNIDlq3Y8135aCBnvcJJMlzMvBO
	 OB3tq8AXwK60YIfaV2xYYkVPeDcnDdTMXUvZziwZfGX7XNjlTDRf82SxMmqOZoOtbB9ZN
	 FIybxTx0Xob23R5zXwljyu6vmjy4nODY8AItEhQeR4zflpeWFt1rLk64GplfYRiimjTEy
	 GluYCh4bIo1DwEyTRzbYxiaWfW8jQWe4CeJTupknExUEoCMjRghJSMrDIJfR0X3o9/11V
	 UffykbVD6Ox6NbOq82TNIBZX1XjKUbuTbPXoLcHxQH8RP5F8mDlox/S91sZPC7YK8+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149385;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Wz0YdSXpDNLtx4h2tQAhqJuxX/dyH0wnWDd/jbL8Pcw=;
	b=ERabQbEk5H9C1MLxnXIH7hbpwUdmlj+IiQfHyW1t9PmWA8N5DGb6xGjOIgyVsVkVY9Zh
	 XO+8tPBMCtjFiuzxYZM6VsyYu+eW45dEgwdVSMkgfKeCPepudseKdVUalChRf6z8h8sd7
	 j+OERfCLQuTzQbI0JpaO+3AYmiEaRn/7OOvUZD9UEuzWlinu4//Qr5vqbgtirZrtgiX1O
	 RNggqsCEc70Ph4wdR+Lomvyyfim1QPz3ph7YznNoSH/829EDlPICeZakkn45t5Do8Isgb
	 ULMAW2aiflPiDmGYxOk5DlWlIlAabyUKfzmwbnNDfHtGj37OeNRi2IpNI9rX8A1bvGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I9Ogjadc;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E036606A31A;
	Wed, 28 Oct 2026 01:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E036606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I9Ogjadc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793149384; x=1824685384;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q95QLA+NSKuPNR1/2vjDJmWj3Qoa9GjSZPLsndq/7GU=;
  b=I9OgjadcflOIEJuY+BWynIz9XySUregJmsVhYFGCZ5VvF7EoQg3+wwXx
   IOdoi/WsESX294m1g2OZRS20/dgtToHTAIamM2cVbzEq6oCTDMQpd+iQH
   OwJ3n/A/RoHXXw26fjCJxuIG7oosePk3IcJTBnd3w0za2EnsnhlI4HJFp
   wv1HLxIMCAKMsWsno29t6YrFE/pIEAPElDtWoC7XR7Km/jINTaqBFNVyD
   C/LB9qsqq6ID1babl+uGA7BcmlGxkfutOtQXomipUSgZbnyjZO2rIurqM
   upNPfiqz9YA5EN2fwBLRe9FJCHnFcp+c+axLoD38IxhhCQwuFrgKsvj/t
   w==;
X-CSE-ConnectionGUID: rO+3iJrmSIKKivAW4ftaGg==
X-CSE-MsgGUID: u3HRFzmARgWUXQysV2zCVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1875950"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1875950"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 18:03:03 -0700
X-CSE-ConnectionGUID: Eo5wCF0tQMajE70H94A1iw==
X-CSE-MsgGUID: nbva6OtmRcuqPm6GU7vzOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4646981"
Received: from unknown (HELO [10.238.0.97]) ([10.238.0.97])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 18:02:59 -0700
Message-ID: <f81cb4a0-2d36-4743-9c4a-22987c50d237@intel.com>
Date: Wed, 28 Oct 2026 09:02:56 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] KVM: TDX: Set SIGNIFCANT_INDEX flag as appropriate
 when filling CPUID entries
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, Binbin Wu <binbin.wu@linux.intel.com>,
 Changyuan Lyu <changyuanl@google.com>, Sashiko <sashiko-bot@kernel.org>
References: <20261022210134.612848-1-seanjc@google.com>
 <20261022210134.612848-3-seanjc@google.com>
 <741bfe7c-5d21-4c6b-98c0-95b01a2a21f3@intel.com>
 <auCvuyY7tTg7ISwR@google.com>
 <6c156bb3-a04f-4d4e-8611-b1e93359e8ad@intel.com>
 <auC7VoynSWStxCg3@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <auC7VoynSWStxCg3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/2026 10:55 PM, Sean Christopherson wrote:
> On Tue, Oct 27, 2026, Xiaoyao Li wrote:
>> On 10/27/2026 10:05 PM, Sean Christopherson wrote:
>>> On Tue, Oct 27, 2026, Xiaoyao Li wrote:
>>>> On 10/23/2026 5:01 AM, Sean Christopherson wrote:
>>>>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>>>>> index 271c2f94b8dd..37d088f6f7a8 100644
>>>>> --- a/arch/x86/kvm/vmx/tdx.c
>>>>> +++ b/arch/x86/kvm/vmx/tdx.c
>>>>> @@ -2,6 +2,7 @@
>>>>>  #include <linux/cleanup.h>
>>>>>  #include <linux/cpu.h>
>>>>>  #include <asm/cpufeature.h>
>>>>> +#include <asm/cpuid/api.h>
>>>>>  #include <asm/fpu/xcr.h>
>>>>>  #include <linux/misc_cgroup.h>
>>>>>  #include <linux/mmu_context.h>
>>>>> @@ -163,12 +164,23 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
>>>>>  
>>>>>  	entry->function = (u32)td_conf->cpuid_config_leaves[idx];
>>>>>  	entry->index = td_conf->cpuid_config_leaves[idx] >> 32;
>>>>> +	entry->flags = 0;
>>>>>  	entry->eax = (u32)td_conf->cpuid_config_values[idx][0];
>>>>>  	entry->ebx = td_conf->cpuid_config_values[idx][0] >> 32;
>>>>>  	entry->ecx = (u32)td_conf->cpuid_config_values[idx][1];
>>>>>  	entry->edx = td_conf->cpuid_config_values[idx][1] >> 32;
>>>>>  
>>>>> -	if (entry->index == KVM_TDX_CPUID_NO_SUBLEAF)
>>>>> +	WARN_ON_ONCE(cpuid_function_is_indexed(entry->function) !=
>>>>> +		     (entry->index != KVM_TDX_CPUID_NO_SUBLEAF));
>>>>
>>>> I think the WARN_ON_ONCE() is very likely to be triggered in the future when
>>>> people run old kernel with new TDX modules.
>>>
>>> Then upstream patches to make that not happen.  Intel insists on treating the TDX
>>> Module like hardware.  So, treat new TDX Modules like new hardware.  Upstream
>>> support for the new "hardware" before it ships, cc'd to stable@vger.kernel.org
>>> if necessary.
>>>
>>> Because IMO, the WARN is doing exactly what it's intended to do: alerting the
>>> admin that they are running a potentially dangerous setup.
>>
>> For this specific case, does it mean every later patch to add a new leaf in
>> cpuid_function_is_indexed() needs to be backported to stable?
> 
> If you want to ship a new TDX Module that enumerates features in those leaves and
> works as-is on older kernels, yes.  Again, this isn't really any different than
> enabling new hardware.  E.g. a kernel from 2024 generally doesn't work flawlessly
> on a CPU being released in 2026.

OK. Fair enough.
