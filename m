Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FA93AB29B;
	Thu, 14 May 2026 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741363; cv=none; b=pn1qEf6f9vhUiXZ377lsxqzoMyfA3awMJNqOtm7uXkgw6kCxkGKAf0P67wL50XSfhoVA6/x4ml1qVGna1fO6pzGvA3YmXpb0+6I2ITJe9oblomyVILf1PFkqibYLot4Gy5PCkZsJgQrq/6wZjjcMKFXShCfO2hMEFq2ZPKoQol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741363; c=relaxed/simple;
	bh=E/ItM3kBwzhWIAVW4h6cXSQKdpekd/PLJDkWK6uT9iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rm5TxkHk+xT9BjGTVP2vjJWa2kIf15KOOBshG4mBqHxuaIj8HVVL1MbPO6xDPLOcrkCQAIffk72nNVO9ZWKuA8+4ndQAH1i8vxXwpKbe+l+skQwI1cUluVwexUSFDoJIig6O2J/SWutXDLRb36MQhYI8CbaBXwqTIPXWRYbeIF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I9wq6Hg4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9wq6Hg4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778741361; x=1810277361;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E/ItM3kBwzhWIAVW4h6cXSQKdpekd/PLJDkWK6uT9iA=;
  b=I9wq6Hg4nWdEvnoT7TEk3jcd5g8ohgqq+wXidDgOpDMtbd0c7nuN/OQx
   bTwEbl/K/uOWUsYaltKT5n+wKihbqeUGPakFT9aJ8FK8m7h0+N58VHSWR
   IPMGXTW/vjD0+QlVCZcR3hghlZxgCtvCa0QXa86hixmOqEHoh1LDFcbMA
   IXdN+0c8AC0UsL16wstGkz9Stjk/rMdDCybZGj4AchxNivPkuqaM61nyj
   lWVyLhqCIkniBiIDM5fMG2RNVDxCu+8YWQU3LDlYmeDscxszQSu6n6q9B
   ysSgBB+AeNqytGIQPpBWSB2iZNX2T6wICRlttVkEh7JSc/84J3jCFJRUf
   Q==;
X-CSE-ConnectionGUID: 7v0p8ZKvT7ehVHGBjZ1LMw==
X-CSE-MsgGUID: FTMrLNqRSu6JbKxyy9mAVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="83292447"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="83292447"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 23:49:21 -0700
X-CSE-ConnectionGUID: 8peB4fXZSbiaIFFLv8POOg==
X-CSE-MsgGUID: jEWtWEwnRgmeLjcCgPPObA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="276389119"
Received: from fanlilin-mobl.ccr.corp.intel.com (HELO [10.238.1.228]) ([10.238.1.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 23:49:17 -0700
Message-ID: <e8cbb899-efba-4996-9f51-7f025450c272@linux.intel.com>
Date: Thu, 14 May 2026 14:49:14 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
To: Ewan Hai <ewandevelop@gmail.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 cobechen@zhaoxin.com, tonywwang@zhaoxin.com, AlanSong@zhaoxin.com
References: <20260513093633.1608334-1-ewandevelop@gmail.com>
 <20260513093633.1608334-2-ewandevelop@gmail.com>
 <2e73a7c5-82db-463f-9665-94280402913a@linux.intel.com>
 <CAG2uPc7T5Tkn5RSLzrfJLEZoh0EYJvdJZkmgJNFbe4NPu0UqMA@mail.gmail.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <CAG2uPc7T5Tkn5RSLzrfJLEZoh0EYJvdJZkmgJNFbe4NPu0UqMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/14/2026 10:31 AM, Ewan Hai wrote:
> Binbin Wu <binbin.wu@linux.intel.com> 于2026年5月13日周三 18:36写道：
>>
>>
>>
>> On 5/13/2026 5:36 PM, Ewan Hai wrote:
>>> Advertise the Zhaoxin SM2 instruction support to guests via CPUID
>>> 0xC0000001 EDX bits 0 (SM2) and 1 (SM2_EN).
>>>
>>> The SM2 instruction (encoding F2 0F A6 C0) implements the SM2
>>> elliptic-curve public-key cryptography algorithm specified in
>>> GM/T 0003-2012; the hardware-level behavior is documented in the
>>> Zhaoxin GMI Instruction Set Reference, chapter 1 ("SM2"). The
>>> instruction multiplexes its sub-functions on the RDX[5:0] control
>>> word: encryption (subsection 1.1), decryption (1.2), signing (1.3),
>>> signature verification (1.4), the three key-exchange sub-operations
>>> of section 1.5 (1.5.1 SM2 key-pair generation, which the spec also
>>> uses for the initiator's ephemeral key; 1.5.2 responder shared-key
>>> derivation; 1.5.3 initiator shared-key derivation), and two
>>> preprocess steps for identity and message hashing (1.6.1 and 1.6.2).
>>>
>>> The instruction is user-mode and available in all CPU modes, with no
>>> associated MSR control. The SM2 and SM2_EN bits are redundant by
>>> hardware design (set or cleared together) and both serve purely as
>>> CPUID-level feature-presence reporting flags requiring no KVM
>>> emulation. Both bits are advertised because different software may
>>> probe either one when checking for SM2 availability.
>>>
>>> Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
>>> ---
>>>  arch/x86/kvm/cpuid.c         | 2 ++
>>>  arch/x86/kvm/reverse_cpuid.h | 4 ++++
>>>  2 files changed, 6 insertions(+)
>>>
>>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>>> index e69156b54cff..1eb4b88aaa80 100644
>>> --- a/arch/x86/kvm/cpuid.c
>>> +++ b/arch/x86/kvm/cpuid.c
>>> @@ -1272,6 +1272,8 @@ void kvm_initialize_cpu_caps(void)
>>>               kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE);
>>>
>>>       kvm_cpu_cap_init(CPUID_C000_0001_EDX,
>>> +             F(SM2),
>>> +             F(SM2_EN),
>>>               F(XSTORE),
>>>               F(XSTORE_EN),
>>>               F(XCRYPT),
>>> diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
>>> index 657f5f743ed9..7b55110cc046 100644
>>> --- a/arch/x86/kvm/reverse_cpuid.h
>>> +++ b/arch/x86/kvm/reverse_cpuid.h
>>> @@ -76,6 +76,10 @@
>>>  #define KVM_X86_FEATURE_TSA_SQ_NO    KVM_X86_FEATURE(CPUID_8000_0021_ECX, 1)
>>>  #define KVM_X86_FEATURE_TSA_L1_NO    KVM_X86_FEATURE(CPUID_8000_0021_ECX, 2)
>>>
>>> +/* Zhaoxin/Centaur sub-features, CPUID level 0xC0000001 (EDX) */
>>> +#define X86_FEATURE_SM2                      KVM_X86_FEATURE(CPUID_C000_0001_EDX, 0)
>>> +#define X86_FEATURE_SM2_EN           KVM_X86_FEATURE(CPUID_C000_0001_EDX, 1)
>>
>> Are these new bits really KVM-only feature bits?
>>
>> KVM_X86_FEATURE() is used for the features either scattered by cpufeatures.h
>> or features that are 100% KVM-only.
>>
>> Kernel already has a feature word CPUID_C000_0001_EDX defined for
>> CPUID 0xC0000001 (EDX). I think these new feature bits should be put together
>> with the existing ones (i.e. X86_FEATURE_XSTORE, ..., X86_FEATURE_PMM_EN) in
>> cpufeatures.h.
>>
>> Same for the other patches.
>>
> 
> Thanks for the review.
> 
> Some history that might help. We tried the cpufeatures.h approach
> back in April 2023:
> 
> https://lore.kernel.org/all/20230414095334.8743-1-TonyWWang-oc@zhaoxin.com/
> 
> That didn't go in. The pushback then was that cpufeatures.h
> additions should come with an in-kernel user of the feature, not
> just to expose a bit. Nothing under drivers/crypto/ or lib/crypto/
> calls these instructions, and we don't have a kernel user lined up.
> They're unprivileged, and the practical pattern is host/guest user
> space probing CPUID directly and calling them inline. OpenSSL's
> PadLock engine does exactly this today for XCRYPT/XSHA, and the new
> bits would be used the same way.
> 
> That's why we ended up in reverse_cpuid.h, reading "no in-kernel
> consumer" as the line between the two headers.
> 
> If the rule has shifted and you'd rather see these in cpufeatures.h
> next to the existing word-5 entries, we can respin as v2.

Sorry, I missed the info that these are only used in user mode.
Please ignore my previous comments.

> 
>>
>>> +
>>>  struct cpuid_reg {
>>>       u32 function;
>>>       u32 index;
>>
> 

