Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F232D9ECA;
	Fri, 31 Jul 2026 01:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459831; cv=none; b=lkrqUJb8MH/5eLwK8pIKhFFSrCsvE8qXPU6CzqJKWrjMlK7rsf5i43p4ZDkz9Gz36Cf0A7aPwsbf63ZV+TNe6mrZowcMFd47Z5TBoer0O78j+/zTWp15LYy0lhPEjGg61aFMa951kZke/PzBPprZLEPwIMulaVwlV7vJ7p6C5eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459831; c=relaxed/simple;
	bh=pfaEPMCGkEm0ZouT+5BS3tubGs7AtOpkadTIpetEfzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNw80ERWBtRi+Wutyq6tXgdAYM78EmhTn4Y70M1FmtzjDFXvdsH3D2RAe5vkIYHn2lZtsGC53g7i1WOOcp8pJPT2ZUWwudu/JiCs4iz0LTIeu39u3b4qIVaKX/IjF6GEExrV0aFupUxo4W4k475FnO1KsTpjO64fbet9suvdwQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFORxzrF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFORxzrF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785459828; x=1816995828;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pfaEPMCGkEm0ZouT+5BS3tubGs7AtOpkadTIpetEfzc=;
  b=JFORxzrFA97eDwfqb9l3J5ujU9Rmt3iTjqLbCa8MYl2n2ciZESowSdGh
   +yWl7AgaybcsTMayWl95Zl8Nxza0rybkyxlqTxTgitcFveCHFEc02E/Yx
   G/TCTbv4Jjg4e1Gc1rKMJ9hJb2d3sHMfLKzFR5PjdprssZz7eWm6KswWk
   fzeb9mCj98QDfrhB6mtzbWQ94aaeFF0MucT880YvtxxgEgzIwmi1VpPRh
   cx4oBfCqHKgGd18P8bJAaQw6SZjUICcxUv4M9Gn4eaBxEde0KxMwAMCVm
   kX7FMfutSkdQsk7ciCG5gy1QKCEV5vPEvu9WXOZKB1mX7O26kwQSnxYKS
   Q==;
X-CSE-ConnectionGUID: 4Iogq+UKTjaBgShU23ZEsg==
X-CSE-MsgGUID: QngGjNhORM6yqVZHvu8gpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96446558"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="96446558"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 18:03:45 -0700
X-CSE-ConnectionGUID: 84Fm9vXqQQC24iLRui0cdA==
X-CSE-MsgGUID: Pykj9sEhQMWSj6DKuPrvAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="258660109"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 18:03:43 -0700
Message-ID: <b270208f-e346-4d0e-9245-dd3c2b9a9676@linux.intel.com>
Date: Fri, 31 Jul 2026 09:03:39 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/9] KVM: x86/pmu: Restrict RDPMC passthrough to known
 CPUs
To: Jim Mattson <jmattson@google.com>
Cc: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260727192131.582105-1-zide.chen@intel.com>
 <20260727192131.582105-8-zide.chen@intel.com>
 <a6481eb0-0480-41f2-97c3-ab5f278f7e50@linux.intel.com>
 <CALMp9eTgxvqMYMr4+mGS0BwAE++Z0KW+Sb22r1QFwR-TdkUZMQ@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CALMp9eTgxvqMYMr4+mGS0BwAE++Z0KW+Sb22r1QFwR-TdkUZMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/30/2026 11:11 PM, Jim Mattson wrote:
> On Wed, Jul 29, 2026 at 7:51 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>> On 7/28/2026 3:21 AM, Zide Chen wrote:
>>> RDPMC type encodings are vendor-defined and could theoretically be
>>> extended on future CPUs. An unknown RDPMC type could leak host
>>> PMU information to the guest through RDPMC passthrough.
>>>
>>> Rather than assuming future CPUs are safe, explicitly permit only
>>> reviewed CPU models and require RDPMC interception everywhere else.
>>> This ensures RDPMC passthrough is enabled only on CPUs whose RDPMC
>>> encodings are audited and supported by KVM.
>>>
>>> Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> Suggested-by: Jim Mattson <jmattson@google.com>
>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>> ---
>>> v7: new patch.
>>> ---
>>>  arch/x86/kvm/pmu.c | 32 ++++++++++++++++++++++++++++++++
>>>  1 file changed, 32 insertions(+)
>>>
>>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>>> index 51c6d00a485f..092809bd757d 100644
>>> --- a/arch/x86/kvm/pmu.c
>>> +++ b/arch/x86/kvm/pmu.c
>>> @@ -77,6 +77,21 @@ static const struct x86_cpu_id vmx_pebs_pdist_cpu[] = {
>>>       {}
>>>  };
>>>
>>> +/*
>>> + * CPUs whose RDPMC encodings have been audited for KVM RDPMC
>>> + * passthrough support.
>>> + */
>>> +static const struct x86_cpu_id kvm_rdpmc_known_cpus[] = {
>>> +     X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X, NULL),
>>> +     X86_MATCH_VFM(INTEL_LUNARLAKE_M, NULL),
>>> +     X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
>>> +     X86_MATCH_VFM(INTEL_NOVALAKE_L, NULL),
>>> +     X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
>>> +     X86_MATCH_VFM(INTEL_PANTHERLAKE_R, NULL),
>>> +     X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
>>> +     {}
>>> +};
>>> +
>>>  /* NOTE:
>>>   * - Each perf counter is defined as "struct kvm_pmc";
>>>   * - There are two types of perf counters: general purpose (gp) and fixed.
>>> @@ -807,6 +822,20 @@ bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
>>>  }
>>>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
>>>
>>> +static bool kvm_rdpmc_encoding_supported(void)
>>> +{
>>> +     /* KVM understands all RDPMC encodings prior to PMU v6. */
>>> +     if (kvm_host_pmu.version < 6)
>> I'm not sure if this works for AMD platforms. Jim said current AMD
>> platforms already have security holes and I believe the PMU version of AMD
>> platforms are less than 6.
> Let's not be pejorative! I said that AMD's RDPMC allows access to
> counters that KVM does not (yet) virtualize, such as the data fabric
> and L3 counters. The APM, volume 3, indicates that up to 28 counters
> are supported today. KVM only virtualizes 6.

I see. Thanks for clarifying this. My words were too arbitrary :(

Anyway, need @Sandipan and @Manali to double confirm this. If current
checks are not available for AMD platforms, we could need to introduce new
PMU vendor callbacks but not sure if it's worthy.

Thanks.


>
>> Need AMD guys to confirm. @Sandipan, @Manali.
