Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAFF40B6F9;
	Tue, 16 Jun 2026 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781595834; cv=none; b=CSpWLS0WPvMNWW6QD+4wLUEKhEd0QIAaY83IpP/pR+OrSkN7QQWmb/USWtDw15cRqwCi3kDjOUdiL0Dh0YivmuWNDUuH4c2uteXtDrI2oek/TLm6ORNCzFMrk0U0L848BcuqwhTMET86PNCHu8RVeIXjUfcoTQ4GeagAdNy6+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781595834; c=relaxed/simple;
	bh=q6MCCPKJyAJYn+nva52g2vTV1IR7qH7zx8YtL6pZxHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KcQLp5MR0iJipbW/mOtYv7nEXrQoz5xU3ESSL0+QXuRQjyWrxAc5+K+NBuOPAO9eMqWg32COH9vE+vcicpvcFykKnCknprZUWNBFF7EOY8hM/uGfAa2GVznzLGJIk+Mpz8iX9TM6wuQHORvQ5CN/6gGbxX1EONOJDUaPUhWFTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dl/j38Tx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dl/j38Tx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781595833; x=1813131833;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q6MCCPKJyAJYn+nva52g2vTV1IR7qH7zx8YtL6pZxHo=;
  b=dl/j38TxVldU6NziGILEKY4pv8s0IQxSTaYXgsc4y2osFv+HfARmUh3b
   OLncAbT6ao2ldaJ0Rej5etzfj82MTDSXIx2TlsC5zfX+w4V3q7jbZLiZQ
   HwpzIjiAucJVsPXSzBoK40c/puE6a19iXyD0V/8C5EVOb1PjvbqWpDQd4
   hDQivEfvZKWEiR0gU1dtop+UMjddc/+2mgM5KoiTV/HueWBZoC6HcMbXo
   PL4neVhA4oSs8Mo+Yj2wHBQbgx88ooFqoK/DNsRJ/6IlkHjFx7oNvjNLg
   vWJlOvF1nenn+QPtld7Je6yFAeY6WAL8UeP3OihzH6/5QIE0U/JLZjPAI
   A==;
X-CSE-ConnectionGUID: ehhaLepxT/ufTAleQCAVKw==
X-CSE-MsgGUID: 7idMX7uDQ1+MSEGopZJmXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="84916517"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="84916517"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:43:52 -0700
X-CSE-ConnectionGUID: yhV/xRbDT02m5sHH4gJkrQ==
X-CSE-MsgGUID: W2OL1pEjRWW9MQMjlJt9kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="285810441"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:43:49 -0700
Message-ID: <144cfc22-10fb-46db-a42e-f4ea8986d353@linux.intel.com>
Date: Tue, 16 Jun 2026 15:43:47 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/30] KVM: x86: Move "struct kvm_x86_msr_filter"
 definition to msrs.c
To: "Huang, Kai" <kai.huang@intel.com>, "seanjc@google.com"
 <seanjc@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "yosry@kernel.org" <yosry@kernel.org>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-19-seanjc@google.com>
 <906e9797-08d4-4ebe-aed3-34002aa1f917@linux.intel.com>
 <3be528f30351ae8744276107fe1060cb222077ca.camel@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <3be528f30351ae8744276107fe1060cb222077ca.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/16/2026 3:29 PM, Huang, Kai wrote:
> On Tue, 2026-06-16 at 14:29 +0800, Binbin Wu wrote:
>> On 6/13/2026 8:03 AM, Sean Christopherson wrote:
>>> Move the definition of "struct kvm_x86_msr_filter" and its associate,
>>> "struct msr_bitmap_range", to msrs.c, as the details of the filters are
>>> very much implementation details that can and should be buried in msrs.c.
>>> While the _existence_ of filters is public knowledge, almost by definition,
>>> the contents don't need to be exposed outside of the MSR code as the filter
>>> data is provided by userspace, i.e. it pretty much has to be dynamically
>>> allocated, and thus never should be fully embedded in a globally visible
>>> structure.
>>>
>>> Note, this creates a discrepancy with the PMU event filter structure; that
>>> will be remedied shortly.
>>>
>>> No functional change intended.
>>>
>>> Suggested-by: Kai Huang <kai.huang@intel.com>
>>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>>> ---
>>>  arch/x86/include/asm/kvm_host.h | 15 ++-------------
>>>  arch/x86/kvm/msrs.c             | 13 +++++++++++++
>>>  2 files changed, 15 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>>> index 09e437c947a9..4ff6304c02d0 100644
>>> --- a/arch/x86/include/asm/kvm_host.h
>>> +++ b/arch/x86/include/asm/kvm_host.h
>>> @@ -315,6 +315,8 @@ enum x86_intercept_stage;
>>>  struct kvm_kernel_irqfd;
>>>  struct kvm_kernel_irq_routing_entry;
>>>  
>>> +struct kvm_x86_msr_filter;
>>
>>
>> Just FYI, the code failed to build on my desktop with an old gcc version v9.4.
>> Due to dereferencing pointer to incomplete type ‘struct kvm_x86_msr_filter' via
>> typeof().
>>
>> It's not the fault of the patch, the issue was fixed for GCC 10+ according to
>> the link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44257
> 
> This issue was reported at:
> 
> 	rusty 2010-05-24 00:29:46 UTC
> 
> But only got fixed at:
> 
> 	Drea Pinski 2021-09-20 02:14:38 UTC
> 
> Amazing :-)
> 
>>
>> But the minimal tool version got for gcc is still v8.1.0, not sure if it needs
>> to bump the version in scripts/min-tool-version.sh?
>>
> 
> Bumping the version would have global impact, so I don't think we should do.
> 
> However, does moving the structure definition to "msrs.h" fix the problem?

Yes, it does.

Similar issue for struct kvm_x86_pmu_event_filter also could be resolved
by moving the structure definition to "pmu.h"


