Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327163D47C5;
	Thu, 23 Jul 2026 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784833707; cv=none; b=R0GbWSWeOIU0atMAawU++bKaqx0WLBFs5N17qQv0+u47FnxsuOvAURYTowWUQCK/YdiYf4df7rLiosyOTh+EhR4OpkwtJI231VoMnFXERnLpHNTvljxCjwGgRJGUwJvrCJluNKjWeVP3hucoVQCKAT3b1F5KVLEZYRc7iAQhiS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784833707; c=relaxed/simple;
	bh=K6WZ1ineFcfbzphKTm/q5IpdiB9kmWOjGMiIbE9Il4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0AIxVvynKurlNO8GGkH7KEZG4cG7LLWORbOV661CRF9lQxS/Lv6XaqxI0jCRYIZqZqgdfzoVwXvYfhwNmh+074JNCRFK9xvfGGoYjhq58dwcw0BaT/MLCIhl6MMAbiRhmE+Rdg73TobDpimsU33DLotw6s1NwT1TxkebFwuqAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yamk/mOd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yamk/mOd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784833704; x=1816369704;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K6WZ1ineFcfbzphKTm/q5IpdiB9kmWOjGMiIbE9Il4g=;
  b=Yamk/mOdvNQnH+YQN7vB5qO3hRuKUkt/ajzfKj2iuT0tkWbDddpW1tT2
   PVQ/rU8KfEs3W7x+m0h5xiKQIkwKzc0M8QFp6jQT9fi7ve75fKRfarjxE
   ++5nt8YzCYeui1nLH1ZoEnrKr9FgMw20ehkH7HQryYeRTpDk5ou4fneY0
   JqynV8PTWdv7niO0ZISRXEQDHKnlud6RjZvH1k9KOnlcKq6m2480XyrqX
   q/tYLx9fpEEClB3/7OPXCZ7TWtaP/FqhUCVjni/NrqdCJslE17j79OFTf
   QWGKmlOLSDVtKsWXehr9cJwymZcJmJQ18tNL2lXji7xtHqQxhKgsIn+bl
   w==;
X-CSE-ConnectionGUID: kwPH6pKvR0636+U7zQCv7w==
X-CSE-MsgGUID: GQwxoNqzQOCTztmrFns4zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="89393872"
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; 
   d="scan'208";a="89393872"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 12:08:22 -0700
X-CSE-ConnectionGUID: mqFn3nn3R3+Dpd3gOGnlxg==
X-CSE-MsgGUID: 9ZH243ncTdiZ4l+6gCSAhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; 
   d="scan'208";a="281796224"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 12:08:20 -0700
Message-ID: <5a611492-52c9-4cd6-87be-4f400fa7af73@intel.com>
Date: Thu, 23 Jul 2026 14:08:19 -0500
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
> 
> To keep the list short, I assume that any CPU with only three fixed
> counters will return true.

How about this to keep the list short? To be conservative, don't assume
future PMUv6 CPUs won't introduce new RDPMC types.

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 9dc453598d06..b2351b764788 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -817,6 +817,31 @@ static bool kvm_need_perf_metrics_intercept(struct
kvm_vcpu *vcpu)
                !kvm_vcpu_has_perf_metrics(vcpu);
 }

+static bool kvm_rdpmc_encoding_supported(void)
+{
+       /* KVM understands all RDPMC encodings prior to PMUv6. */
+       if (kvm_host_pmu.version < 6)
+               return true;
+
+       /*
+        * Future PMUv6 implementations and future PMU versions require
RDPMC
+        * interception until their RDPMC encodings are audited and
supported
+        * by KVM.
+        */
+       switch (boot_cpu_data.x86_vfm) {
+       case INTEL_ATOM_DARKMONT_X:
+       case INTEL_NOVALAKE:
+       case INTEL_NOVALAKE_L:
+       case INTEL_PANTHERLAKE_L:
+       case INTEL_PANTHERLAKE_R:
+       case INTEL_WILDCATLAKE_L:
+       case INTEL_LUNARLAKE_M:
+               return true;
+       default:
+               return false;
+       }
+}
+
 bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
 {
        struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -828,6 +853,9 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
        if (enable_vmware_backdoor)
                return true;

+       if (!kvm_rdpmc_encoding_supported())
+               return true;
+
        return kvm_need_any_pmc_intercept(vcpu) ||
               kvm_need_perf_metrics_intercept(vcpu) ||
               pmu->counter_bitmask[KVM_PMC_GP] !=
(BIT_ULL(kvm_host_pmu.bit_width_gp) - 1) ||

