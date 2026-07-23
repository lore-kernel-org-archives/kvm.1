Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B838470EAB;
	Thu, 23 Jul 2026 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784775186; cv=none; b=SHNSi4GLdfrXSiunsOfrgO2Ktu26AlO4m6gumsy8GBIcEAhmSOp8FftlTmt6tOG8hpcNUEoTUOt3rAm0mTyAdHPrvSEOAo9PaAuhbLLGOKqN0afDpzrdMUXdaVw/9dWC0NofaJZKn4EjvLDjKfoTDCix3arPYijw2006GJlhjiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784775186; c=relaxed/simple;
	bh=X93DBtzbe0r79BeyJEl/qv0pwnSRNILYe3losLv7daY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+etxJ1DOc5eGdUzdC9ofX8nXei4odM29/z56By8iILJbjRzcIUfMY1JJp0eoJiIg0U7egCu7Lh8CphdS2zB1E+2TwH5Pr8eNOkyp70c1NeEkAKhRkXUgTq0hqzZewmKNDq+Ue6Eb3bxIZ+JVkxkg0iElpn4MPKaagSf2i2FwNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lANBe3Yz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lANBe3Yz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784775184; x=1816311184;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X93DBtzbe0r79BeyJEl/qv0pwnSRNILYe3losLv7daY=;
  b=lANBe3YzdGsiHXKssdiBRAhOwq61ds5kXZVFgEo7AJ+iOkgbqgAc5VXk
   VPjMIJU3Svu7lKaiDWKKJmak8aYQqJQe20DqZCrkXF0FsRj+nbZzZ/tMh
   kt2A6mx8tEVAs7CJjRm5hV7AJuk87YEUjIBMmznokaUWv01q3ap+x+Wbd
   R11SpMsrnE/vGOARbZylm2TyarMfds1QoUwydk1t0KQdOGpNYU7iHroiQ
   VQlWIRc6qjlxIzrvk6QQzAP+l3SiqLHCLxeRuz3RYSufO+1+4tMaWyLgC
   9+vu0UvR23o85Dn/WsP/nvZT6+Yd3SyHFVZugypFiWgxZjTJRD2U5Tlvy
   g==;
X-CSE-ConnectionGUID: yED5euVwQMWpxmJ7mQMXHw==
X-CSE-MsgGUID: xNQuF9l6QU2kykGaFCYw5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85543073"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="85543073"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 19:53:03 -0700
X-CSE-ConnectionGUID: n47tkPmFQiyRzxc3m6j9XQ==
X-CSE-MsgGUID: XxKZ+/00TNuRl7FdPsV/Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="257724956"
Received: from unknown (HELO [10.238.1.243]) ([10.238.1.243])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 19:53:01 -0700
Message-ID: <1a21ba1c-a195-43aa-9a9f-c0326a78c0a5@linux.intel.com>
Date: Thu, 23 Jul 2026 10:52:58 +0800
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
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CALMp9eQapUpDBd5iwvw7OVkm8oUaVcD9KQwdgyA57mNiWe9jgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/23/2026 10:25 AM, Jim Mattson wrote:
> On Wed, Jul 22, 2026 at 6:44 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>> On 7/23/2026 8:02 AM, Jim Mattson wrote:
>>> On Mon, Jun 29, 2026 at 4:29 PM Zide Chen <zide.chen@intel.com> wrote:
>>>> If the host has the PERF_METRICS capability but it's not present on
>>>> the guest, RDPMC interception must be enabled and KVM should inject
>>>> an #GP when the guest attempts a PERF_METRICS RDPMC.
>>>>
>>>> If the guest has PERF_METRICS but RDPMC interception is enabled for
>>>> other reasons, KVM needs to emulate RDPMC with type 2000H.
>>>>
>>>> For simplicity, Metrics Clear Mode is not supported.
>>>>
>>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>>> ---
>>>> v6:
>>>> - Merge kvm_pmu_rdpmc_metrics() into intel_emulate_rdpmc().
>>>> - Reject non-zero index.
>>>> v5:
>>>> - new patch.
>>>> ---
>>>>  arch/x86/kvm/pmu.c           |  7 +++++++
>>>>  arch/x86/kvm/vmx/pmu_intel.c | 14 ++++++++++++++
>>>>  2 files changed, 21 insertions(+)
>>>>
>>>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>>>> index 8ef2d4761790..04b9c840f218 100644
>>>> --- a/arch/x86/kvm/pmu.c
>>>> +++ b/arch/x86/kvm/pmu.c
>>>> @@ -806,6 +806,12 @@ bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
>>>>  }
>>>>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
>>>>
>>>> +static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +       return (kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS) &&
>>>> +               !kvm_vcpu_has_perf_metrics(vcpu);
>>>> +}
>>>> +
>>>>  bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>>>>  {
>>>>         struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>>>> @@ -818,6 +824,7 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>>>>                 return true;
>>> I know we have a strong disagreement here, but I really feel that this
>>> must be secure and future-proof out of the box.
>>> What if we added a module parameter, enable_rdpmc_passthrough, which
>>> defaults to false?
>>>
>>> Then:
>>>
>>> if (!enable_rdpmc_passthrough)
>>>         return true;
>>>
>>> Is that a reasonable compromise?
>> Yes, this is an option. Another option is to add a helper to explicitly
>> tell which platforms are secure and can pass-through rdpmc. Maybe like this,
>>
>> static bool intel_pmu_can_passthrough_rdpmc()
>> {
>>     switch (boot_cpu_data.x86_vfm) {
>>     case INTEL_ICELAKE_X:
>>     case INTEL_SAPPHIRERAPIDS_X:
>>     case INTEL_EMERALDRAPIDS_X:
>>     case INTEL_GRANITERAPIDS_X:
>>     ... ...
>>         return true;
>>     default:
>>         return false;
>>     }
>>
>>     return false;
>> }
>>
>> Then rdpmc can be passed through by default on these known secure
>> platforms. For any new platforms, the rdpmc would be intercepted out of
>> box until we confirm it's secured and explicitly support them.
>>
>> How about this? At least for me, it looks like an overkill to disable rdpmc
>> passthrough unconditionally on these known secure platforms.
> The F/M match would only apply on bare metal, since you can't trust F/M in a VM.
>
> What if we combine this with the module parameter, but now the module
> parameter defaults to true? Somewhere in module load, we have:
>
> if (boot_cpu_has(X86_FEATURE_HYPERVISOR) || !intel_pmu_can_passthrough_rdpmc())
>         enable_rdpmc_passthrough = false;

It looks good to me. :)


