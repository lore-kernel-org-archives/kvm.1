Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8310486403;
	Thu, 24 Sep 2026 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262657; cv=none; b=KbAQCGsUEZrceMGm5tc88IkJwVHAPbPe/LUD3UIlyV4T8l/J4nzta/yEkAhJF8NOMqi7SnWjvKdoubpvl2pQE8UPaXR3w+FJs6zX7azsdo6hU9UID3VYNQKVcGqM461in77EMyWUPncjtOKwFpoB2OF7kLYx+Yi3U4SO7JLc6f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262657; c=relaxed/simple;
	bh=J4PxJwYUM5sMYfdjBgCo523m5WgcPASuSDSGoxhe1HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4uV6WBR0pNOPR93jszm/lzuxZ//WCUwAGLHn7/TCW+2jkWfCqzCfGqKUzL3XVod4KRIToe1XPTG44uWR2BDE7t9kgdF6vjQpBrujyuygOXE6QsZrwZUko787vmhuQQv/D/dd05mYYJ9N/n7tqb4y0YiyGcAu8mhR1p59xN3TSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evUEc3vH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evUEc3vH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790262655; x=1821798655;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J4PxJwYUM5sMYfdjBgCo523m5WgcPASuSDSGoxhe1HY=;
  b=evUEc3vHTwwJk2u0LZwBRGHT1Pjt256BMk4f0fomvqfUBKe8cxmnNqOv
   zwcR34+62kk0JtCk4VwsBKvIzFO8emnTi5OAVx70aFZ5rZDRbCr0Lo3kC
   i8uMocfFv3NcWclT3yC0V6OCYzDf6BkDBRrJRWmRYMSxe6q5cjp9KLqUA
   WdG1LWlwXQst2Gg7nib81yYEFvXT+v/afztvywXuAH2EmbvzQZ+GxcVEp
   IydYUeqgrVeduHAVvQHZSmOQl46WHQVwYDwxFaPqeGjI0Oui6rmSRxNMX
   ldIrkJJnmj2ndYE5mcKLH068CQ3utYbhoFyKoSGG+1j605C42Qy4Iqj97
   A==;
X-CSE-ConnectionGUID: IhnBU3gSTYS7PZEfA2YOGg==
X-CSE-MsgGUID: zPhxQ6GTQB6xJuGbQZfymw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="116562128"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="116562128"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:10:44 -0700
X-CSE-ConnectionGUID: uPsVsKU0STuuqSjjvzZ6ew==
X-CSE-MsgGUID: hNBp8MSmRou0dNPoNn1JgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="273622964"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:10:42 -0700
Message-ID: <b4111d9e-197d-4d94-a87f-676ca91b0646@linux.intel.com>
Date: Thu, 24 Sep 2026 23:10:39 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
 pbonzini@redhat.com, dave.hansen@linux.intel.com, andrew.cooper3@citrix.com,
 nik.borisov@suse.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 chao.gao@intel.com, tony.lindgren@linux.intel.com, kishen.maloor@intel.com,
 dedekind1@gmail.com
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
 <20260917072548.2314491-2-binbin.wu@linux.intel.com>
 <39047bbc-757d-4131-a25c-5a7743fd591a@intel.com>
 <062f5365-7eb5-4e04-9c84-f5ecd566f019@linux.intel.com>
 <eca53031-fd47-4471-9d05-d73295a0f57e@intel.com>
 <8bcba51e-2a3b-44b8-89cd-aebfd1e50cfd@linux.intel.com>
 <3278bae0-1a30-478f-8488-c762ac0246fa@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <3278bae0-1a30-478f-8488-c762ac0246fa@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/2026 9:55 PM, Xiaoyao Li wrote:
> On 9/24/2026 7:41 PM, Binbin Wu wrote:
> ...
>>>>> As for "features forced to zero when #VE is reduced", do you mean when TDX
>>>>> module supports "#VE reduction" feature, the features becomes fixed0? or when
>>>>> guest enables "reduce #VE", the guest see a 0 value even though the feature is
>>>>> still configurable to host userspace and host userspace configure it to 1?
>>>>
>>>>
>>>> #VE is reduced means the guest reduced the related #VE, i.e. TDCS.TD_CTRL.REDUCE_VE
>>>> is 1 and the related bit in TDCS.FEATURE_PARAVIRT_CTRL is 0.
>>>
>>> I think "features forced to zero when #VE is reduced" doesn't matter at all
>>> here.
>>
>> I think it still matters.
>>
>> If there is a feature that is virtualized by the TDX module itself, but KVM doesn't
>> support it for non-TDX VMs, I think it should be allowed.
>>
>> These features can't be added to the allow list because neither TDX module nor
>> KVM do the virtualization for them.
> 
> ... <snip>
>>> I think all the bits that are directly configurable but out of kvm_cpu_caps[]
>>> and not supported by KVM fall into the last category. You can just list all of
>>> them instead of my "for example".
>>
>> As I mentioned above, if there is a feature that is virtualized by the TDX module itself,
>> but KVM doesn't support it for non-TDX VMs, it should be allowed. Although I don't have
>> a concrete example. I think we still need to mention #VE reduction to some degree, but
>> let me see how to simplify the description.
> 
> (This reply only concentrates on the discussion of "if there is a feature that
> is virtualized by the TDX module itself")
> 
> If you are talking about the features related to #VE, I think there is no.
> Because if TDX module itself can virtualize the feature, then it shouldn't be
> #VE at all. #VE means it needs para-virt support from host VMM.

I was thinking a hypothetical scenario, but this #VE reduction thing is already
complicated enough, I shouldn't not muddy the waters with a hypothetical scenario.

Anyway, I will try to simplify the commit message without mentioning #VE reduction.

> 
> If you are talking about the features unrelated to #VE. I think it's just the
> case I argued for in previous v3, that we can support a feature for TDX first
> before non-TDX VMs. I think we all agreed that such case can happen and we
> decided to support such case when there is a real case.

Yep.
