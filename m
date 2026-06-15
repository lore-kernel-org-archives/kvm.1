Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4503F212566;
	Mon, 15 Jun 2026 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781506200; cv=none; b=s2nsBlINikr+m73+NUPe7hHJptti6WY2p3FbgE77PNBJHo1Bv/h0qPIx7XNvEjc17oUKqq5agsIybUrn19gAuDVbOCgF3CkWsRwSE+wNKjzdttsCgT7ihHzOOTgJKJOoRPFuSc5u/KOW9ThRoOP/3BWM1zVNF4jNxhP+UyTJKus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781506200; c=relaxed/simple;
	bh=dWCDh64UBiVypwksy+4EiBQZVT9GQOMQlzTw/mvm8n4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULAv7BfA+HSt86refLnKF1nZmq81TrPRdus4t3as0QuweX5oYAqaPc0zqfx6guQm6rGBe5DzoeZhOCGV4DYnQql8QZjdVUhZOIG+KTvZaHcwzbNX1y9DxxmgpnfNPxuGx5hGY0M8c4PzWURr1HeBPTje2ucaqQjI3jLvD/sRviU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtZ6/+oM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtZ6/+oM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781506199; x=1813042199;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dWCDh64UBiVypwksy+4EiBQZVT9GQOMQlzTw/mvm8n4=;
  b=mtZ6/+oMjzIJjal+ppg4/jvT7pIBFGI4KRxGn7TG0GzOj/Rgp/245sgR
   NdVvflZEFQiynYft2XZIGZ9hjsiheo+wcwLzl5GpZ4nyRUbuWf7zEPi02
   9VXRFfWl+FjkIZ98qlgxFz3AvR7+dijpFAPJj85JRwJ0b3szhq15Bxbwl
   cmFTg6IMd+UJBRbM9vKsyqnYpPkO67CTHiTpnYvT9gX5X/5uuIECUWDVb
   9gJdB7Hv5kN4/vvYySSH85Qcl/KWvn3SKjOwC5wfdP91+F9WZoDZuzNyJ
   l462N44B6H/gZxU9p1yviV9ksMbQKKI8Q5Breh7uVHD96jTxrKv24Tcxq
   g==;
X-CSE-ConnectionGUID: PE35QzzpQIia2gBw/1B8bA==
X-CSE-MsgGUID: afH59hpBQRyu18o5R4DyLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="82345250"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="82345250"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 23:49:59 -0700
X-CSE-ConnectionGUID: +cbVIomJRjy/mtJMeJWnwA==
X-CSE-MsgGUID: zb1dUn6XRRqcOYiCJqqViQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="244480529"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 23:49:57 -0700
Message-ID: <69019093-fed6-4cb1-b3b5-a62a3a46578c@linux.intel.com>
Date: Mon, 15 Jun 2026 14:49:54 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/30] KVM: x86: Move kvm_caps and kvm_host_values to
 asm/kvm_host.h
To: Xiaoyao Li <xiaoyao.li@intel.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-7-seanjc@google.com>
 <ea5bb362-f6ff-48e1-94f0-0b413969a186@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <ea5bb362-f6ff-48e1-94f0-0b413969a186@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/13/2026 5:01 PM, Xiaoyao Li wrote:
> On 6/13/2026 8:03 AM, Sean Christopherson wrote:
>> Relocate the kvm_caps and kvm_host_values struct definitions and their
>> associated global variable declarations to asm/kvm_host.h to allow for a
>> variety of cleanups in x86.h and mmu.h, and to establish a (hopefully)
>> maintainable rule that asm/kvm_host.h's role is to define common
>> structures (and declare any associated globals), and anything needed by
>> arch-neutral KVM.
>>
>> While it would be lovely to trim kvm_host.h down to the point where it
>> *only* holds things needed by arch-neutral and/or non-KVM code, multiple
>> attempts to do just that have failed miserably.  Trying to "hide" code
>> from arch-neutral KVM is too restrictive (and ultimately pointless), and
>> KVM x86 itself also needs a place to define common structures and their
>> globals, e.g. to avoid inconsistent header include chains and/or misplaced
>> helpers.
>>
>> E.g. as pointed out by Kai, it's weird that x86.h, which is a kitchen sink
>> of sorts, includes regs.h, but not mmu.h.  Literally the only reason that
>> x86.h doesn't include mmu.h is that mmu.h references kvm_host, which is
>> currently defined in x86.h.  As a result of odd include ordering, the
>> very clearly MMU-specific helper mmu_is_nested() lives in x86.h, not mmu.h
>>
>> "Fix" the kvm_host dependency so that x86.h can be the "central" include
>> everyone expects it to be, and set KVM x86 on the path to having somewhat
>> sensible "rules" for what goes where:
>>
>>    - asm/kvm_host.h holds "common" structure definitions and associated key
>>      global variables, and things that are referenced by arch-neutral KVM.
> 
> I'm confused by the term "arch-neutral" all over the changelog. I suppose include/linux/kvm_host.h is arch-neutral while asm/kvm_host.h is arch-specific but not KVM internal only.

IIUC, it's the situation where asm/kvm_host.h for x86 provides the
x86-specific pieces that the generic/arch-neutral KVM depends on.
E.g. struct kvm_arch is defined in asm/kvm_host.h, which is x86-specific, but
the generic KVM embeds it in struct kvm as 'struct kvm_arch arch' in
include/linux/kvm_host.h, i.e. "referenced by arch-neutral KVM".

> 
>>    - <thing>.{c,h} holds relevant declarations and definitions.
>>    - x86.{c,h} is the kitchen sink for everything else.
> 

