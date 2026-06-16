Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED33339B943;
	Tue, 16 Jun 2026 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781597936; cv=none; b=L9ZVOJRBeRxyxV2B0yG6CllDTA/XhABsXTBmW14cWIbgdwRVOGbw3e4QEsD8vfOfsXP47Ek6IvGMx92KqH8/16Y4YGH0oAJ8vvLsBeACmkj/f5RwWjY2VlCWV9uIldHjBqMqWLhGx7+jxzgKtvQ0j/EVCT5dVd33Hi0c7FbfCCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781597936; c=relaxed/simple;
	bh=b/S4XdhVNUtArsIXUDT3g/vRHmlWJY3zoYJgTv0Oj3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjzpyNHv/jYpfkFkwEO3+Fo7UBocBjoAZykKC72qYGoWpt1EX/nq5z5fVET/aezMAjFe9/QJVvmaN/waWO+eLnBtRvtGSb+gajIxQW/+dFDfMlKO/ZF67uGX7Nd9dI1H0eVTYp7JGXrMSQ1Db1CmSVlW5hIsVnbWbiMJVpve7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XjmDkNqK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XjmDkNqK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781597934; x=1813133934;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b/S4XdhVNUtArsIXUDT3g/vRHmlWJY3zoYJgTv0Oj3c=;
  b=XjmDkNqKiY8A/Xmb4qoqZ0PYM3FwC6tBHpRJqbrrcuVNMxk3UV34Zlvg
   Ff0wiMQVdcTH4/aLR3JVZDWQNT9bjBtW3+vxMfgg3aH/KXEetoCsNFerp
   NAV8H2WHXlZhjMfFZ99vKIedz8uBUsMvvh6IJprwM3a5as0P0aIU6PtGQ
   V7us4GVAcpJxC4Jy3qBzhGzE/8JM3IVhS8vpO+FTlV3T+RscwJy+F7ygB
   11K1dbVwYq70J3rsPg4jm8bQ7ErlOqO2ysk+GGKgR0k4JsiyEq/B683/x
   4/YOah8fzDAGeRhhcQmzXRNDQw3cxust4Mzs0fs8D2xD094NEpsAOF7n1
   w==;
X-CSE-ConnectionGUID: siuTdatyQBGtcVK+OsT0fA==
X-CSE-MsgGUID: oXQKGX6+TqS3Vie+BpE7kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="93738590"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="93738590"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:18:53 -0700
X-CSE-ConnectionGUID: HpD0fFYzQ+G1Jg165X7/PA==
X-CSE-MsgGUID: 2eOLPBbWQBuWgpybitG6wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="243328751"
Received: from unknown (HELO [10.239.158.65]) ([10.239.158.65])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:18:51 -0700
Message-ID: <eca12c55-d23d-4b0c-8cb0-0ed6d5fc851b@intel.com>
Date: Tue, 16 Jun 2026 16:18:49 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/30] KVM: x86: Move kvm_caps and kvm_host_values to
 asm/kvm_host.h
To: Sean Christopherson <seanjc@google.com>,
 Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-7-seanjc@google.com>
 <ea5bb362-f6ff-48e1-94f0-0b413969a186@intel.com>
 <69019093-fed6-4cb1-b3b5-a62a3a46578c@linux.intel.com>
 <ajAnKleLBD411Uka@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ajAnKleLBD411Uka@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/16/2026 12:24 AM, Sean Christopherson wrote:
> On Mon, Jun 15, 2026, Binbin Wu wrote:
>> On 6/13/2026 5:01 PM, Xiaoyao Li wrote:
>>> On 6/13/2026 8:03 AM, Sean Christopherson wrote:
>>>> Relocate the kvm_caps and kvm_host_values struct definitions and their
>>>> associated global variable declarations to asm/kvm_host.h to allow for a
>>>> variety of cleanups in x86.h and mmu.h, and to establish a (hopefully)
>>>> maintainable rule that asm/kvm_host.h's role is to define common
>>>> structures (and declare any associated globals), and anything needed by
>>>> arch-neutral KVM.
>>>>
>>>> While it would be lovely to trim kvm_host.h down to the point where it
>>>> *only* holds things needed by arch-neutral and/or non-KVM code, multiple
>>>> attempts to do just that have failed miserably.  Trying to "hide" code
>>>> from arch-neutral KVM is too restrictive (and ultimately pointless), and
>>>> KVM x86 itself also needs a place to define common structures and their
>>>> globals, e.g. to avoid inconsistent header include chains and/or misplaced
>>>> helpers.
>>>>
>>>> E.g. as pointed out by Kai, it's weird that x86.h, which is a kitchen sink
>>>> of sorts, includes regs.h, but not mmu.h.  Literally the only reason that
>>>> x86.h doesn't include mmu.h is that mmu.h references kvm_host, which is
>>>> currently defined in x86.h.  As a result of odd include ordering, the
>>>> very clearly MMU-specific helper mmu_is_nested() lives in x86.h, not mmu.h
>>>>
>>>> "Fix" the kvm_host dependency so that x86.h can be the "central" include
>>>> everyone expects it to be, and set KVM x86 on the path to having somewhat
>>>> sensible "rules" for what goes where:
>>>>
>>>>     - asm/kvm_host.h holds "common" structure definitions and associated key
>>>>       global variables, and things that are referenced by arch-neutral KVM.
>>>
>>> I'm confused by the term "arch-neutral" all over the changelog. I suppose
> 
> "arch-neutral" refers to virt/kvm code and other code that isn't arch specific.
> I used arch-neutral here, e.g. instead of "common code", to differentiate between
> arch-neutral (virt/kvm) code and common x86 (arch/x86/kvm) code.

I figure out why I got confused. I read it as the "that are referenced 
by arch-neutral KVM" was explaining the whole

   "common" structure definitions and associated key global variables,
   and things

instead of only "things"

>>> include/linux/kvm_host.h is arch-neutral while asm/kvm_host.h is
>>> arch-specific but not KVM internal only.
>>
>> IIUC, it's the situation where asm/kvm_host.h for x86 provides the
>> x86-specific pieces that the generic/arch-neutral KVM depends on.
>> E.g. struct kvm_arch is defined in asm/kvm_host.h, which is x86-specific, but
>> the generic KVM embeds it in struct kvm as 'struct kvm_arch arch' in
>> include/linux/kvm_host.h, i.e. "referenced by arch-neutral KVM".
> 
> Yep, exactly.

I get it now. Thanks for the explanation!

