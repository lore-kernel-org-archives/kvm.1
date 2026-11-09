Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246974;
	b=NsrxmCxrwxqFW+j+L2A/wL93iWp6jPVeu0r2LT1fsOnAYCc0Lv/6bHvFfQdxH/pL0buo
	 ISV+A0s4X2w/b27YVDb5o9mmxGavHx3NJQGBS2KzSUOCM7nxM1O2KHP9L6ndMlSNDMSfZ
	 h+ROz4A0lVwD5sABizlsPxdHFPW4nx4jYGCiDFTZEpT//kZwv4tAEGt/l1xS8eh6B9jSM
	 Bo9P5QMp1/m0ffhMwPxuUP4Ie2Vkcg9xhPw1DGCBOnvbrkgWXKC8RIFNqTB9ThZaffo4h
	 2RTuFjHaYj0NdRy+OHeGotuP7RWqtWOp8oK+Jezej627yvuLRHziv/iJKe8vdBYK9FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246974;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=iTmx0r81EUOeW+G7ZIvHemmzWYbW35OLP9Cl9c4f2Wk=;
	b=btOjMJkoPBy0OJaBGEqMxie6sE0uoEcvH3gOA78eq1orQTc8U2q6vGkPou9EqRlA1b2/
	 0MBkRMHpUn8gR4ND5TWBEkfPOoXO3GHmpNWGm9k1dx2gJ8A+brphMbAceikOCeN5QvLP9
	 kIIV+KLux6TiDHIIUOVMXjVDH2HgrOkiM9tjMbbZpdIBJciOrec3q/wpn3wZ/OsqO1Wwy
	 MCt9abc7VKqbrDmumwuBKyl1NTSbuYApnEYMm6ubj/lQOXMZ78qNeRhuIgS2vZ4CmrECW
	 mYB41Hrwllh4jhYBlth83kkYGgfexvkwMGi7cfFNCObQE9h8KZ6qH+KjzsZ2ORvXFxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bcpFB+Wg;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800AB606A31C;
	Mon,  9 Nov 2026 17:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 800AB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bcpFB+Wg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794246974; x=1825782974;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iNokIAKhN+qj5LNCCEgSOCO90w6ZjTzjUxKkKV8ujyc=;
  b=bcpFB+WgejPfonEeHdqFda93e/RJ5yl2zMkdjPodNUlUZhrKwVmnzCj0
   6RTZpq7KIhv1ZRvoQsh7yKuhKDL96GukFaxb3laIu28V0zQjVe6JzTsyP
   yOFuN/OLENAoeQZNWVXqzMfXqQwkIncCWFKpTCsJOqjYwnbowuDLIOEtZ
   Y8vf497A3MsjLxDV5Q3o7eFPXNN96gRk9k7RTyHgXd5RHLk376+naSpUh
   PNuBtBKP65GAi4n3ZWEdevR9c3FyOm8n/3RUN4MI9yP9M9z23uC0mms08
   Rr6NkJxWW2+RElTAAeCRLFfEeNfd1eg/IkmVX7cfJTnDWMPOg+GAFKHVO
   A==;
X-CSE-ConnectionGUID: nWIuLS7aSAyDBBQyiOi/vw==
X-CSE-MsgGUID: vlMJEdAyQQmNIpAOpb46Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2878718"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2878718"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 09:56:14 -0800
X-CSE-ConnectionGUID: rEdqlWe8TiaPKz4X5TA2Dg==
X-CSE-MsgGUID: QHfD0ympSZac0swZMJTAUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8249114"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 09:56:13 -0800
Message-ID: <31278ce8-77ed-4bd2-a237-815cbcc5b489@intel.com>
Date: Mon, 9 Nov 2026 11:56:11 -0600
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
Subject: Re: [PATCH v3 04/18] KVM: x86/pmu: Add PMC bitmap accessor helpers
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-5-zide.chen@intel.com> <au4kyULjUYdqbfIq@google.com>
 <531bd088-dc5e-4b2e-953a-6d9d6f14b61e@intel.com>
 <CAO9r8zMs+aBPN-w7L3nZxwVV-Dr2f0tBYBjicDsdYVp_Mc2AWg@mail.gmail.com>
 <2aeaac02-368c-40b4-9b2d-feef5e9d9ea8@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <2aeaac02-368c-40b4-9b2d-feef5e9d9ea8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/9/2026 1:53 AM, Mi, Dapeng wrote:
> 
> On 11/7/2026 6:35 AM, Yosry Ahmed wrote:
>> On Fri, Nov 6, 2026 at 2:19 PM Chen, Zide <zide.chen@intel.com> wrote:
>>>
>>>
>>> On 11/6/2026 1:09 PM, Yosry Ahmed wrote:
>>>>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>>>>> index b8875ed5502c..4f192429ed93 100644
>>>>> --- a/arch/x86/include/asm/kvm_host.h
>>>>> +++ b/arch/x86/include/asm/kvm_host.h
>>>>> @@ -595,7 +595,10 @@ struct kvm_pmu {
>>>>>              DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
>>>>>              atomic64_t __reprogram_pmi;
>>>>>      };
>>>>> -    DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
>>>>> +    union {
>>>>> +            DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
>>>>> +            u64 pmc_exists64;
>>>> __pmc_exists would be more consistent with __reprogam_pmi above.
>>> I used the *64 suffix and without '__' to match the cntr_mask/cntr_mask64
>>> and fixed_cntr_mask/fixed_cntr_mask64 pattern in struct x86_pmu_capability
>>> (patch 7), whereas __reprogram_pmi used '__' because it is an atomic64_t
>>> rather than a scalar mask.
>> I don't follow why the '__' prefix is specific to atomics, but anyway,
>> I will leave this up to you and Sean.
> 
> Per my understanding, '__' prefix hints this function/variable should not
> be accessed directly, it should be accessed via some wrapper helpers. So I
> think it depends on if we hope the variable pmc_exists64 should be accessed
> directly.

Agree, I vote for pmc_exists64 over __pmc_exists.
> Thanks.
> 
