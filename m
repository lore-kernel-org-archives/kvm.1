Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D99536B91C;
	Thu, 23 Jul 2026 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824431; cv=none; b=oTb9lEEzdZSggljVeIEl6QiEDoBQVTWhL1TrYrj+B5q+hdq/AOqhN/GybgzSq4DxbBNI1497qmMkZmaBfzsPUXSYJjFiCIFGZ8r3rYapftE/RHwq/lmphYa926OKcmz+0qfnU34esoYpQhvKTHEEc7cpnZnZ2ugTT/xFcwTg1Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824431; c=relaxed/simple;
	bh=6FXoQBSP9DlYlAkmJoAfryG/NfI8m5TCRyOtSYrKACI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uG27ODGTtGIFR6wi2PgoTnakOC+I3YFG0eTb2YnjksWdVrX8iwTY6xI5sDzIljRbWy3CxsKVI5+v7ejhByLowNwuRC2bNgaeC6jbxVDHQih92+8lZl63kMam+xuST33dd6QvTlJeswfSHl7YIwivifiA6gzVO46dBA2gekvcNuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZqu5yJm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZqu5yJm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784824425; x=1816360425;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6FXoQBSP9DlYlAkmJoAfryG/NfI8m5TCRyOtSYrKACI=;
  b=eZqu5yJmgdpgcei3ckOfC625L1XTViEIMJxcNbMjByFhHiNEOU0gETrC
   zKj9aMEqDYrKE4viIfOvwrHSZ1aPi4V9tQbyg2aGdFAoRyHr2nCU/aY2L
   RyfzAOdZ5vsWVU9CmQSJmhBjrW/lPKuNkY2SLQsBxwwF7NI5qkGx3jnlh
   D92aVlfXxr4eu69mCB/G4gAJvqnwenWxKYh4iuAbCN7E9GFUjcZ6Tc2rq
   zm+pujRfUAmy3FjtWjbguGz9DD7Ya1eaGg/yk2znyWFCkAArmQsP0XIKD
   APMIwwTtyjXsEwx6O9gvxQEqTs1qhdLgihfs1yDxpRZJkh+g4mMh6TNRw
   g==;
X-CSE-ConnectionGUID: rFFPIMNURXisqe/82/LKFg==
X-CSE-MsgGUID: yd1vCKXISu24dBkQkbY9Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="89381242"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="89381242"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 09:33:43 -0700
X-CSE-ConnectionGUID: 2D2Rrtp1TEORQUTtkHLvgg==
X-CSE-MsgGUID: 2SfGEq5WRq2gT1A+4QNYWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="263428618"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 09:33:42 -0700
Message-ID: <93d6d476-ed63-4c4f-9bf6-666101708eb6@intel.com>
Date: Thu, 23 Jul 2026 11:33:41 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] KVM: x86/pmu: Emulate RDPMC on performance metrics
To: Jim Mattson <jmattson@google.com>, "Mi, Dapeng"
 <dapeng1.mi@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
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
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eTOQJ1_QMazU3v_TAXupNfZTLsYta9wi7iRBy37P8WqTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/22/2026 10:10 PM, Jim Mattson wrote:
> On Wed, Jul 22, 2026 at 7:53 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>>
>> On 7/23/2026 10:25 AM, Jim Mattson wrote:
>>> On Wed, Jul 22, 2026 at 6:44 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>>>
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
>>
>> It looks good to me. :)
> 
> On second thought, it doesn't really matter if L0 has lied to L1 about
> F/M. If the hardware supports more RDPMC types than the L1 virtual CPU
> does, L0 must intercept and emulate RDPMC for vmcs01. Even if L1
> decides to pass through RDPMC to L2, L0 will still intercept and
> emulate RDPMC for vmcs02.
> 
> So, we can drop the module parameter and just use
> intel_pmu_can_passthrough_rdpmc().

Thanks, will post a new version based on this.
> To keep the list short, I assume that any CPU with only three fixed
> counters will return true.

Will do some study on the available CPUs.
