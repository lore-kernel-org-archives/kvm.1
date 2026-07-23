Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38B839479C;
	Thu, 23 Jul 2026 05:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785670; cv=none; b=HeXMEnEswhYMeKCjtx3hFEBWEnDsgbBDSbf6RdeREoUweIeEd+n0ZQqU3+G73ls6k+W1stygy0yy0fxHLQG+IZT001k3iCQP7vZNkN+xrol34pOh8j/RwQc0CcREIJKS0YuH41wVUBGV2l77oGkJioxg1ghuE9RhX89SgVeb3e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785670; c=relaxed/simple;
	bh=l2ZkHA9K0pykDCYMOEn+FOl80yQxYBui8RoslvajFQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3O+TY7Lu25o1zFXZrLgH1+revELUYAJrCuPOYCzMvi+UU0n3Jl8bSCu/pUIcjpdBH8G57pEBu5kfOjpatLsmKSJiSWk0vojQbyaonZn0fJ6nST1P9qtKaxuPnKjS6Mr5jce2+J/LrJSyFQcIH7fBhKECwFFBDVKL+BTEPf3kzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SP8teTeg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SP8teTeg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784785669; x=1816321669;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l2ZkHA9K0pykDCYMOEn+FOl80yQxYBui8RoslvajFQc=;
  b=SP8teTegHZVc/oYdEho7x0mdGhJEByeaECSp8KeM0Rf9mE9Mn85LyDRB
   2tg3rGnd5uiFxKa30yhXX85u/4YUGsxIsvPAWUv7zDY2ixEoC8IaOTCm4
   6UqsbmP23Q0drR4mEKFrItTuYn1XLSTXDj9RLwbx+9TEF0wzi9aH7Hqsu
   q9S4KkBQT6qsVlbd7VgjRBRRyFLPof7LEPvdB4PLKmaXbsvJ8rgQfpS8D
   IfeYMHb52W38nK8uFALJce4PDqpTJOKjjLPy6SOkdbzyehpHKZsxe/M8j
   RWktfvLYaPA5PEr8rZakliXMhMGr0EQ4MYXmYeIvN9dwKw8YNSMBshT1M
   w==;
X-CSE-ConnectionGUID: WDMLCYPUTfadj8SlT7gvqA==
X-CSE-MsgGUID: 942RNFgbRHuEGVQLna5BHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="95785629"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="95785629"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 22:47:49 -0700
X-CSE-ConnectionGUID: ni3/acuxREq28QRkPjDhZg==
X-CSE-MsgGUID: UL+AY/51RGerLsYxyzoYEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="256508031"
Received: from jiahezha-mobl1.ccr.corp.intel.com (HELO [10.124.241.178]) ([10.124.241.178])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 22:47:46 -0700
Message-ID: <8d35ab5f-f88a-401d-a431-1531755068b4@linux.intel.com>
Date: Thu, 23 Jul 2026 13:47:43 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] KVM: x86/pmu: Emulate RDPMC on performance metrics
To: Jim Mattson <jmattson@google.com>
Cc: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
 <20260629231938.15129-8-zide.chen@intel.com>
 <CALMp9eQyMe6MfYPkvYAZPm+6A+FK6ZYpGv5Wx+nVvi9GtumA+g@mail.gmail.com>
 <f16aea7f-6b5a-4980-91b4-a41931b797ec@linux.intel.com>
 <CALMp9eQapUpDBd5iwvw7OVkm8oUaVcD9KQwdgyA57mNiWe9jgw@mail.gmail.com>
 <1a21ba1c-a195-43aa-9a9f-c0326a78c0a5@linux.intel.com>
 <CALMp9eTOQJ1_QMazU3v_TAXupNfZTLsYta9wi7iRBy37P8WqTA@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CALMp9eTOQJ1_QMazU3v_TAXupNfZTLsYta9wi7iRBy37P8WqTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/23/2026 11:10 AM, Jim Mattson wrote:
> On Wed, Jul 22, 2026 at 7:53 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>> On 7/23/2026 10:25 AM, Jim Mattson wrote:
>>> On Wed, Jul 22, 2026 at 6:44 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>>> On 7/23/2026 8:02 AM, Jim Mattson wrote:
>>>>> On Mon, Jun 29, 2026 at 4:29 PM Zide Chen <zide.chen@intel.com> wrote:
>>>>>> If the host has the PERF_METRICS capability but it's not present on
>>>>>> the guest, RDPMC interception must be enabled and KVM should inject
>>>>>> an #GP when the guest attempts a PERF_METRICS RDPMC.
>>>>>>
>>>>>> If the guest has PERF_METRICS but RDPMC interception is enabled for
>>>>>> other reasons, KVM needs to emulate RDPMC with type 2000H.
>>>>>>
>>>>>> For simplicity, Metrics Clear Mode is not supported.
>>>>>>
>>>>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>>>>> ---
>>>>>> v6:
>>>>>> - Merge kvm_pmu_rdpmc_metrics() into intel_emulate_rdpmc().
>>>>>> - Reject non-zero index.
>>>>>> v5:
>>>>>> - new patch.
>>>>>> ---
>>>>>>  arch/x86/kvm/pmu.c           |  7 +++++++
>>>>>>  arch/x86/kvm/vmx/pmu_intel.c | 14 ++++++++++++++
>>>>>>  2 files changed, 21 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>>>>>> index 8ef2d4761790..04b9c840f218 100644
>>>>>> --- a/arch/x86/kvm/pmu.c
>>>>>> +++ b/arch/x86/kvm/pmu.c
>>>>>> @@ -806,6 +806,12 @@ bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
>>>>>>  }
>>>>>>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
>>>>>>
>>>>>> +static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
>>>>>> +{
>>>>>> +       return (kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS) &&
>>>>>> +               !kvm_vcpu_has_perf_metrics(vcpu);
>>>>>> +}
>>>>>> +
>>>>>>  bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>>>>>>  {
>>>>>>         struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>>>>>> @@ -818,6 +824,7 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>>>>>>                 return true;
>>>>> I know we have a strong disagreement here, but I really feel that this
>>>>> must be secure and future-proof out of the box.
>>>>> What if we added a module parameter, enable_rdpmc_passthrough, which
>>>>> defaults to false?
>>>>>
>>>>> Then:
>>>>>
>>>>> if (!enable_rdpmc_passthrough)
>>>>>         return true;
>>>>>
>>>>> Is that a reasonable compromise?
>>>> Yes, this is an option. Another option is to add a helper to explicitly
>>>> tell which platforms are secure and can pass-through rdpmc. Maybe like this,
>>>>
>>>> static bool intel_pmu_can_passthrough_rdpmc()
>>>> {
>>>>     switch (boot_cpu_data.x86_vfm) {
>>>>     case INTEL_ICELAKE_X:
>>>>     case INTEL_SAPPHIRERAPIDS_X:
>>>>     case INTEL_EMERALDRAPIDS_X:
>>>>     case INTEL_GRANITERAPIDS_X:
>>>>     ... ...
>>>>         return true;
>>>>     default:
>>>>         return false;
>>>>     }
>>>>
>>>>     return false;
>>>> }
>>>>
>>>> Then rdpmc can be passed through by default on these known secure
>>>> platforms. For any new platforms, the rdpmc would be intercepted out of
>>>> box until we confirm it's secured and explicitly support them.
>>>>
>>>> How about this? At least for me, it looks like an overkill to disable rdpmc
>>>> passthrough unconditionally on these known secure platforms.
>>> The F/M match would only apply on bare metal, since you can't trust F/M in a VM.
>>>
>>> What if we combine this with the module parameter, but now the module
>>> parameter defaults to true? Somewhere in module load, we have:
>>>
>>> if (boot_cpu_has(X86_FEATURE_HYPERVISOR) || !intel_pmu_can_passthrough_rdpmc())
>>>         enable_rdpmc_passthrough = false;
>> It looks good to me. :)
> On second thought, it doesn't really matter if L0 has lied to L1 about
> F/M. If the hardware supports more RDPMC types than the L1 virtual CPU
> does, L0 must intercept and emulate RDPMC for vmcs01. Even if L1
> decides to pass through RDPMC to L2, L0 will still intercept and
> emulate RDPMC for vmcs02.
>
> So, we can drop the module parameter and just use
> intel_pmu_can_passthrough_rdpmc().
>
> To keep the list short, I assume that any CPU with only three fixed
> counters will return true.

Sounds good. 


>
