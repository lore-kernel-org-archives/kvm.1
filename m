Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC91175A9C;
	Mon, 18 May 2026 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098137; cv=none; b=kNRPaLWSoK9x2jLfRP0kQJNYN22Ls32qAnuq24uXfuvgje3ZTpoxDx2YjFyZr44KgQw/2AOeEX8vT+5z4dPlUfLcyeX8lgZxs09wPZYq/TcyOv4V2c3SSLSaACk7PecZSP1I5CyQFvRhivFVm+t+fkGjgvlIrvGWtPOTaGjTZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098137; c=relaxed/simple;
	bh=3pdSbUS4kgNs3wUypJ24HShS7jI0lcMA8LV+aRifl7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r248LOV4mwCgTd+x5TJVctDU/g3Fa4b9I1v4Wl7BlFTGieLHQPsiSpbQIFhyOJkMpsAUMg1LXZ9RpHFaSzkYz9YYhRncDu24QZpvS/G71NpTBqpNsYcm7HLLlUq+Fq9ph2qQqQG6eXMQDb36wy5OgXGCXPg2872RS6RzHzYSnhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTnnjTzI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dTnnjTzI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779098136; x=1810634136;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3pdSbUS4kgNs3wUypJ24HShS7jI0lcMA8LV+aRifl7g=;
  b=dTnnjTzIACWSBiFLNJ9o2uvCRgb0fUZB286QfuCgFadex566ehRo/fDE
   t9c+NNu0T4blKCezOq5K2dTdLffqvODYNPtHNE8kV3d18OJMlcAYvixT6
   mwYVOIAkx3BcckDVkkyKVDSezFC7OImmKlV8Cn4G0uvesnbD2YylSWYHC
   d25BnuDWXleaRI8U+5A5o87rzozt4r74x062+8ilVhyEhrz9I889irT/8
   1nfC5J4Fq1gobJaOx7OBAL8gdn48ra27UKL2eaNdiLKLvXx3iW0W/rvT+
   w2wDCNb4bb/Nuc+SSZOJwQyAcqD1JiB5O+2D0Kz4dok9RsSeBmNVkLFDb
   Q==;
X-CSE-ConnectionGUID: 0ggnZqenTqe/vwBYkanErA==
X-CSE-MsgGUID: LuCOhsPNRVmtQgkQNnjgvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="82512447"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="82512447"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 02:55:35 -0700
X-CSE-ConnectionGUID: xy9wScCmTvqr4wA7zD5KFQ==
X-CSE-MsgGUID: /NR3ofRBTKOBqsvoV/dcrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="238387102"
Received: from fanlilin-mobl.ccr.corp.intel.com (HELO [10.238.1.228]) ([10.238.1.228])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 02:55:32 -0700
Message-ID: <dc62e58e-b6ee-41e1-84a5-0716822fefc8@linux.intel.com>
Date: Mon, 18 May 2026 17:55:29 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] KVM: x86/xen: Don't truncate RAX when handling
 hypercall from protected guest
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Kiryl Shutsemau <kas@kernel.org>, Paul Durrant <paul@xen.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
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
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <d7af5a04a11432ea1878431e8b51061f19c16061.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/18/2026 5:50 PM, David Woodhouse wrote:
> On Mon, 2026-05-18 at 17:43 +0800, Binbin Wu wrote:
>>
>>
>> On 5/18/2026 3:15 PM, David Woodhouse wrote:
>>> On Mon, 2026-05-18 at 10:19 +0800, Binbin Wu wrote:
>>>>  
>>>>>>>   	longmode = is_64_bit_hypercall(vcpu);
>>>>>>
>>>>>> Is the variable name misleading?
>>>>>
>>>>> It most definitely is.  However, @longmode is passed around quite a few locations
>>>>> in xen.c, and so I don't want to opportunistically fix this one variable.  Though
>>>>> I'm definitely not opposed to a separate patch to rename them all to is_64bit or
>>>>> something.
>>>>
>>>> OK, I can do it.
>>>
>>> This one (as shown above) is clearly indicating whether this particular
>>> vCPU is in 64-bit mode for this particular hypercall. Changing that to
>>> is_64bit makes sense.
>>>
>>> However, there is a separate overall mode for the VM, which is stored
>>> in 'kvm->arch.xen.long_mode' and accessed by userspace using the
>>> KVM_XEN_ATTR_TYPE_LONG_MODE attribute. It affects the datatypes used by
>>> shared memory data structures, and is also latched by the kernel when
>>> the guest writes the MSR for the hypercall page. That one should
>>> probably keep its name.
>>
>> For this one, I think the current KVM code is consistent.
>> The format is determined by EFER.LMA, whether the guest is running in 64 bit or
>> compatible mode doesn't change the ABI.
> 
> Agreed. For the hypercall case you're looking at, switching the name to
> is_64bit makes sense.
> 
>> struct compat_shared_info is used only when the guest is running natively in a
>> 32-bit build.
> 
> The struct compat_shared_info is also used in !kvm->arch.xen.long_mode
> on a 64-bit host, as that's what means the guest is considered to be a
> 32-bit guest.
> 
> It's somewhat orthogonal from whether any given vCPU is making any
> given hypercall while in 64-bit mode. The 'long_mode' is *latched* at
> certain specific times which are defined by Xen's historical behaviour.
> 
> I'm suggesting that you clean up longmode→is_64bit for the *hypercalls*
> but leave 'long_mode' as is.
> 

Yes, will only do it for is_64_bit_hypercall().

> 

