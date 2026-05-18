Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CADA3D3D03
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101489; cv=none; b=sQUphE2s3J+/Oc6q7dWKIYKaa4kScsqPjBSMpLjIQZEfX2SDBPzEaUzKoMULqOzU5r6M7nuJZm0k7/HI6LhBNn91HIdG+nNn91D1TeDSXbzO28gxcYNqRHQKR3xWPHJJ74d4+mT84a+TtMIu9iLlXkra3UsYMYkdYjJTsFGXNiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101489; c=relaxed/simple;
	bh=FrSWc/Tya914aQVLMdFWM3Bj89viW36zwzOdOy4FucQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmyYaNqvpS6zPmF3tR2hMIE3RCweLk/8H7SvF/34u74G0xyVaVRRWwye305Q4vwkhSh/vz8hZA+I4P6QI9Bw43lT8NwEATp/LjxChxrdwhy+sWAbsRLLYDJcTatEMxfJRfHg87E1k753KCEvDv/sOJzKw5xA7x52RXn+5wZPUEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUqlHV7d; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUqlHV7d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779101483; x=1810637483;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FrSWc/Tya914aQVLMdFWM3Bj89viW36zwzOdOy4FucQ=;
  b=CUqlHV7daHuA3v0s8BTpFKBqQnsi4n8OVOvOSubiCW+q40HH4wAKvEeL
   wu+8pqTaExNyn78wR7DfnGTD6qD2Ncw6QLT0DxC/RQgUZy2Efa9kejI+S
   MPtiJ3giT31r1vw9kKOvfPA9s6ObYBxTg7c8qK4Vz9vADuttyYCHzlWIu
   1GvxDEfLhSIni/oPoBHMX627ckVqL8geFu5vuWftpUUMKZ8lGu0p6+liI
   iYaETtPmaxm9n0l1cWdzru2U80uRZowgW4TMardFtxxheikko6v0xDGiO
   9NMnP8CrjDk0Tkg09aBh7MsF7Cj4O9VsznMnr6uAzCAxc5x/J3k4WhUm0
   w==;
X-CSE-ConnectionGUID: KyT9CaDdRWuxGUHxUpPqXA==
X-CSE-MsgGUID: go+zkDE7RQiYUMwU0a29Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79089281"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79089281"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 03:51:20 -0700
X-CSE-ConnectionGUID: vqnkY4OyRsGJuaG2QJzAOA==
X-CSE-MsgGUID: 9ZPAKkp1Q5uSm8geXs68QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="269734578"
Received: from unknown (HELO [10.239.158.26]) ([10.239.158.26])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 03:51:18 -0700
Message-ID: <fa47d520-1de9-4ddc-94ca-6bb53ac30f10@intel.com>
Date: Mon, 18 May 2026 18:51:15 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/27] KVM: x86: Fix emulated CPUID features being
 applied to wrong sub-leaf
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com,
 rick.p.edgecombe@intel.com, chao.gao@intel.com, kai.huang@intel.com
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <20260417073610.3246316-2-binbin.wu@linux.intel.com>
 <db11b4df-d5f8-49b5-91dc-daa103f94223@intel.com>
 <d47cf3d8-0547-4246-9249-eaf56800f2da@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <d47cf3d8-0547-4246-9249-eaf56800f2da@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/18/2026 4:09 PM, Binbin Wu wrote:
> 
> 
> On 5/15/2026 5:03 PM, Xiaoyao Li wrote:
>> On 4/17/2026 3:35 PM, Binbin Wu wrote:
>>> Guard the use of cpuid_func_emulated() with a check that the CPUID
>>> sub-leaf index is 0, as cpuid_func_emulated() unconditionally returns
>>> emulated features for index 0 and does not account for indexed leaves.
>>>
>>> Without the guard, when iterating over reverse_cpuid[] entries that
>>> share the same CPUID function but have a non-zero index, e.g.
>>> CPUID_7_1_ECX (function=7, index=1), the emulated features for index 0
>>> are incorrectly OR'd into the wrong capability word.  For example,
>>> RDPID (CPUID.7.0:ECX[22]) gets erroneously applied to CPUID_7_1_ECX,
>>> which would allow userspace to set bit 22 of CPUID.7.1:ECX in the vCPU's
>>> capabilities.
>>>
>>> This is currently benign as the affected bits in the non-zero index
>>> words happen to not correspond to meaningful features, but it could
>>> cause problems as new features are defined in those positions.
>>>
>>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>>> ---
>>>    arch/x86/kvm/cpuid.c | 9 +++++----
>>>    1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>>> index e69156b54cff..25f582a8d795 100644
>>> --- a/arch/x86/kvm/cpuid.c
>>> +++ b/arch/x86/kvm/cpuid.c
>>> @@ -399,15 +399,16 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>>>            if (!entry)
>>>                continue;
>>>    -        cpuid_func_emulated(&emulated, cpuid.function, true);
>>> -
>>>            /*
>>>             * A vCPU has a feature if it's supported by KVM and is enabled
>>>             * in guest CPUID.  Note, this includes features that are
>>>             * supported by KVM but aren't advertised to userspace!
>>>             */
>>> -        vcpu->arch.cpu_caps[i] = kvm_cpu_caps[i] |
>>> -                     cpuid_get_reg_unsafe(&emulated, cpuid.reg);
>>> +        vcpu->arch.cpu_caps[i] = kvm_cpu_caps[i];
>>> +        if (!cpuid.index) {
>>
>> Instead of such a temporary fix, I would prefer adding the index parameter to cpuid_func_emulated() and split this patch separately.
> 
> I did it in this way because:
> - The index parameter was here and it was removed in commit ab8bcf649711

commit ab8bcf649711 removed index parameter for __do_cpuid_func() and 
__do_cpuid_func_emulated() because they were supposed to generate the 
whole subleafs of a specific CPUID function leaf. Please see the flow

kvm_dev_ioctl_get_cpuid()
   get_cpuid_func()
     do_cpuid_func()

Then commit ff402f56e8eb broke this purpose to make 
__do_cpuid_func_emulated() generate at most 1 subleaf for a function 
leaf, because it wants to use the extracted cpuid_func_emulated() for a 
single CPUID entry with implicit subleaf 0 to serve the usage in 
kvm_vcpu_after_set_cpuid().

> - I thought cpuid_func_emulated() probably would not be extended in the future.

I don't argue against this.

If we finally go this simple solution, I think adding some comment to 
cpuid_func_emulated() to call out something like "KVM only emulates 
CPUID leaf with a subleaf 0 or no significant subleaf" would be helpful.

>>
>>> +            cpuid_func_emulated(&emulated, cpuid.function, true);
>>> +            vcpu->arch.cpu_caps[i] |= cpuid_get_reg_unsafe(&emulated, cpuid.reg);
>>> +        }
>>>            vcpu->arch.cpu_caps[i] &= cpuid_get_reg_unsafe(entry, cpuid.reg);
>>>        }
>>>    
>>
> 

