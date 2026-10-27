Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110346;
	b=G2ZPyQIOROpF89FJJ0jA0jjoCCUI/3WefYxXjppc1Hokvah1F4FQkT84RKRY+NLAQtPo
	 qRCBQfX/txGBh55taP9GoD1b/QGImp05ZSQIs37G06g34jycIjTzGHFj6TRBjTIPitS59
	 HuqUpzPGdchnYFXLfdWYbppSSZebewvs7Qe8mhDr24R03XKrE1aYlQcvFhs8ys8jVryG9
	 FnNeyUQ+DwZNPYVMuyY2WwBtscTu6ypy/xvZJuCEY1oHVdeShbGa2Vdlo4g6DURkP5N51
	 OnC+91ceCe2HtbDWuP+/yezQulLexV2qe4KIEnRWSuq3F6TtHRPf5Mm5JVi48irRJOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110346;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=buqBzj/EH2ynxXXk6rNzOgRfC4aGXhfLq39ArvoDr/c=;
	b=j0e3U18evSz/ClqaH6eanuaNlTYT7IkCWeZPb9lQYkIHR6AShwhETUSWaBoYdIw96jl4
	 W8XdfS5w76HzUPhOesdMWUZk1oCXSNYpDd/bKbVq+lENNoTIzHyB1LK2hYXRm5scm1foV
	 y9mUIvF2mq7Xu5vQTfC5HOOnGF5goxEWJjciSYE73fof/BMNfW4vBNeyKYQOuFCBkh1jL
	 BubYvOnjiWNUhR+c+JatgN8qXNY2u8GxjOhgm1qYBzjhwapquJBiclEhHTgCWbWj+CRQI
	 AqnntUKW0tMsgloA/zRvItPIlcLjbNKXqOnffu5+FL1Z8nKNQdeAD9/e2enETgmOAmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PoVMyEXQ;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B11606A31B;
	Tue, 27 Oct 2026 14:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5B11606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PoVMyEXQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793110345; x=1824646345;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DqPe3Y3OSnrg9LAsCJZuB9OktcRjGEKt/CME+hIdrL0=;
  b=PoVMyEXQUQ93lQDJRw8sjUhXLrLYpdSzO4QKnsRVuJAjy1sdp2SeGROF
   /msdlYSIsl0HoFhIg9wS3vm4U6Jav+Ss3BYFEQOaLmO0vBojNhstukqk/
   nvF6dIRK1/T+kM78Z7D8Z99Aw0JnYsQwub230d9yhyKq3NOXTnWjnzyl7
   FEnD0mCpLhXJClXvxcWOWJAPmyuN1dJ1G1igbkhstuDe9GaJiUAmK3UTh
   h49QdMREsoXD0hJff3Wsc/wfpiVKEPnBzSVX8QxBj4hj2EY9Cm70aMAwQ
   AImUqKGi5YD1vUyyyfn/gRWuiGbU/Zsrnc1DYsu/CemAx/iQ7PyET2x4y
   w==;
X-CSE-ConnectionGUID: 08+ipPF3TPefbH+dK2x+kg==
X-CSE-MsgGUID: hwA0n/XiTAatnQ4vC9JmqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1900272"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1900272"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 07:12:25 -0700
X-CSE-ConnectionGUID: WQc0ybFqSaWEpVJ2iK+rJA==
X-CSE-MsgGUID: ROpv/sLFSyqn2Olv3KSQWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4594940"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.140]) ([10.124.240.140])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 07:12:21 -0700
Message-ID: <6c156bb3-a04f-4d4e-8611-b1e93359e8ad@intel.com>
Date: Tue, 27 Oct 2026 22:12:18 +0800
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
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <auCvuyY7tTg7ISwR@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/2026 10:05 PM, Sean Christopherson wrote:
> On Tue, Oct 27, 2026, Xiaoyao Li wrote:
>> On 10/23/2026 5:01 AM, Sean Christopherson wrote:
>>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>>> index 271c2f94b8dd..37d088f6f7a8 100644
>>> --- a/arch/x86/kvm/vmx/tdx.c
>>> +++ b/arch/x86/kvm/vmx/tdx.c
>>> @@ -2,6 +2,7 @@
>>>  #include <linux/cleanup.h>
>>>  #include <linux/cpu.h>
>>>  #include <asm/cpufeature.h>
>>> +#include <asm/cpuid/api.h>
>>>  #include <asm/fpu/xcr.h>
>>>  #include <linux/misc_cgroup.h>
>>>  #include <linux/mmu_context.h>
>>> @@ -163,12 +164,23 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
>>>  
>>>  	entry->function = (u32)td_conf->cpuid_config_leaves[idx];
>>>  	entry->index = td_conf->cpuid_config_leaves[idx] >> 32;
>>> +	entry->flags = 0;
>>>  	entry->eax = (u32)td_conf->cpuid_config_values[idx][0];
>>>  	entry->ebx = td_conf->cpuid_config_values[idx][0] >> 32;
>>>  	entry->ecx = (u32)td_conf->cpuid_config_values[idx][1];
>>>  	entry->edx = td_conf->cpuid_config_values[idx][1] >> 32;
>>>  
>>> -	if (entry->index == KVM_TDX_CPUID_NO_SUBLEAF)
>>> +	WARN_ON_ONCE(cpuid_function_is_indexed(entry->function) !=
>>> +		     (entry->index != KVM_TDX_CPUID_NO_SUBLEAF));
>>
>> I think the WARN_ON_ONCE() is very likely to be triggered in the future when
>> people run old kernel with new TDX modules.
> 
> Then upstream patches to make that not happen.  Intel insists on treating the TDX
> Module like hardware.  So, treat new TDX Modules like new hardware.  Upstream
> support for the new "hardware" before it ships, cc'd to stable@vger.kernel.org
> if necessary.
> 
> Because IMO, the WARN is doing exactly what it's intended to do: alerting the
> admin that they are running a potentially dangerous setup.

For this specific case, does it mean every later patch to add a new leaf in
cpuid_function_is_indexed() needs to be backported to stable?

