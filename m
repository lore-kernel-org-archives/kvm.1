Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263208;
	b=kXQxbXlAzAT/lT2iKqNmHe463RFsTN0Rlx7sqkv1azy2Y8NVJrTPO4qD6F07chPYK20N
	 grzQBkCVdmRVze397cfEM7zHDd0M4auDsMx5m3+gmH+VnYNs003IeAJIm8/RQq3whzJew
	 FPoTrecAHcnsns8dTVrDazafyM5pfUR0gYe4PFnDNpGnoVja44JuyOIFXiO8IsoSg7FAd
	 j7wE88Cjc2ad8f1mnUR3NUAdSSRYX4P8iDZhiIScd4LH0o1YQxGmdwU0DkhI2EDFyWxek
	 4oISqQsNfHK0V6N92YH/armxFAV71/KIGrCxplkaMsFiMr5hv2e3nnIDtAp/bfOjcow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263208;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=PdhZVJ35e1yvYgd8EnN3cd2MQYABoG5oOep3xIAlNOc=;
	b=qUK7VLt1mU8NVGqoW836kZruby+KUFVRhKRZ80BoB9k3+4aJrY4bEaWPIkTNIjqfnm7U
	 TIbGbocXeNThBtEWtfxkYdL39FIt4RyAnFpJxsjKlo4ufqNUZLtGnMxblhIBBhbz7PkOj
	 71voM352cQKFNJXeTW5YtHVvnpPg6RF0nXSFe0lKYFnIIJefTC2P3ZNKXRgymywlHD3vg
	 eL2+vmvIfq6mQOc/BLNsrcZ13G2g1kCmTzTxC62dnWLrSfFrbvWFUXJMeJL3e3UYqb99m
	 FG8IBbSAD5wQzRfoM+2WfVi8FBgFAL+av/r4dA3ayHu4T8ZHDbOqWW4I/NGKxL1NMCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="KymL0+f/";
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235FD606A31C;
	Mon,  9 Nov 2026 22:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 235FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KymL0+f/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794263208; x=1825799208;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EZm1h+In5FWzs9ZQ+bw01RH8TBgZjiUuuMTr53gtZvw=;
  b=KymL0+f/RqzWoOHaEufvQfzcuO/fFPCs/N3pFLAXqZOO7bKUfrWMCSML
   3EAPdd8mj01QhfPZXaKachFfm2JtF40vqNiOSJ6ZsGzNaHumcmhQP2+wR
   IqrTNNQRFrJXrFY3d0yhX/yZs7a9BlUUXyEMAAN97KOXLZf73p/0Icrq7
   DJVkUvmb7ADXxa1VvcfzkA2gQhCvivYFOWGhSwLE8syXBCh6E4BxkpMwu
   /0MuVSGvoRRl/OIlvcb5o1+62/mIvavK9J3yIURzz3r4Bl6VjOyZzDZLB
   8ogU/Ahx9/bRgvsQ2WWoa498hqLwSdc5auhx7IHMsIvwIIXvTkIkVJDiN
   Q==;
X-CSE-ConnectionGUID: NxDTZGZDQoGxsCqsgHjiBw==
X-CSE-MsgGUID: 0N+mBCWVSXylK8soCnLHeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2897566"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2897566"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:26:47 -0800
X-CSE-ConnectionGUID: tGxZs7R9Q+SDXEiSkatuYQ==
X-CSE-MsgGUID: pscAEEH6Qx+gWiRHc/zblw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7994863"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:26:47 -0800
Message-ID: <e9c31732-f0c9-4fa0-92ca-28d5e7d81a46@intel.com>
Date: Mon, 9 Nov 2026 16:26:45 -0600
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
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-5-zide.chen@intel.com> <au4kyULjUYdqbfIq@google.com>
 <531bd088-dc5e-4b2e-953a-6d9d6f14b61e@intel.com>
 <CAO9r8zMs+aBPN-w7L3nZxwVV-Dr2f0tBYBjicDsdYVp_Mc2AWg@mail.gmail.com>
 <e977b107-7762-46d3-ba31-832eb9ae609c@intel.com>
 <CAO9r8zPVt++jgZD3-Jd-DYKMjYyAfUuQkvEXD4pKqe0bdYE29A@mail.gmail.com>
 <c2844568-f8f6-450e-a718-1e9e3b7b3e4b@intel.com>
 <avI20tEzyvIshy2f@google.com>
 <650a864a-2f20-4864-b29f-7cbe822e894a@intel.com>
 <CAO9r8zOOub+rY-6twk8jBkKJZJsvQnJGMqXBo-eEEyD5+1rang@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CAO9r8zOOub+rY-6twk8jBkKJZJsvQnJGMqXBo-eEEyD5+1rang@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/9/2026 4:07 PM, Yosry Ahmed wrote:
>>> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
>>> index 98e6f2443b82e..37a6664fdb9c9 100644
>>> --- a/arch/x86/kvm/pmu.h
>>> +++ b/arch/x86/kvm/pmu.h
>>> @@ -149,11 +149,11 @@ static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
>>>   * which is already constrained by KVM_MAX_NR_{AMD,INTEL}_{GP,FIXED}_COUNTERS,
>>>   * so iteration up to KVM's maximum counter count is safe.
>>>   */
>>> -#define kvm_for_each_gp_counter(i, mask)     \
>>> -     for_each_set_bit((i), &(mask), KVM_MAX_NR_GP_COUNTERS)
>>> +#define kvm_for_each_gp_counter(i, pmu)      \
>>> +     for_each_set_bit((i), &(unsigned long){ kvm_gp_pmc_mask(pmu) }, KVM_MAX_NR_GP_COUNTERS)
>>>
>>> -#define kvm_for_each_fixed_counter(i, mask)  \
>>> -     for_each_set_bit((i), &(mask), KVM_MAX_NR_FIXED_COUNTERS)
>>> +#define kvm_for_each_fixed_counter(i, pmu)   \
>>> +     for_each_set_bit((i), &(unsigned long){ kvm_fixed_pmc_mask(pmu) }, KVM_MAX_NR_FIXED_COUNTERS)
>>
>> Right, I didn't realize C99 compound literals could be used here.
>>
>> However, with this suggested code, kvm_gp_pmc_mask() would be
>> re-evaluated on every iteration. It seems this “expression with side
>> effects evaluated more than once” is not encouraged by the coding style,
>> is it?
> 
> kvm_gp_pmc_mask() and kvm_fixed_pmc_mask() have no side effects, right?

Right, you are completely right—they are pure functions with no side
effects at all.

I was just curious whether re-evaluating the compound literal on every
iteration might introduce any subtle overhead, given they could be
called in the pmu context switch. I'm very happy to go with
your approach!

Thanks again!

