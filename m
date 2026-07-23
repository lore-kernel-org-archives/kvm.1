Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B718DB2A;
	Thu, 23 Jul 2026 01:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784771062; cv=none; b=phw2T7jQOBI3DQ+oqOiEWtYJQtTsmZAnu87piKqaVjtDp/IRtGxD0w1mVKWsp8ggRsGMFjmkYi51M5UJAwWipFGnyDRgOSOsOO+ZvlE3WK9wZnf0hJsbHNgkgYDLsfSIWctHHcyiJaG+1inu8ZvPcfwRfYrm497ILbmDSNbrOEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784771062; c=relaxed/simple;
	bh=mO10leO+2s9YL1I5xcOagR0ErMel4H0rAA7gkA/2X34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJzXTz5CUVFr4l+Ytdc6uNBThADKqWy0YtlGR+/WhJ0FlO5BCCcvFkxRb+k6L0UIP3EeQjNP+/C0bxaftqkj/26q9dehENQajbnlyAZoDuh8209WNWXNjVJgU5Mqi8JLZTuEFtwyH0+Go3zBvcwzVGn9SoGiFnLStCy9VQjwCzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmbtDHNA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmbtDHNA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784771061; x=1816307061;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mO10leO+2s9YL1I5xcOagR0ErMel4H0rAA7gkA/2X34=;
  b=cmbtDHNA3Ef3q0HdN7mIivvfGbnDvYhTlSj2Vc2PAVi1m7Skf075utX3
   3cEZOA+aF7LWxzOZgmKlyq1q8O5Wo2Uhymt0/zQqtVcYby2n+uBmW6w7L
   zpp7L7HDphD3L/kx/lYx6szsv1MEIiKzKNne3aOUtJAGLVxLLjdREEw8H
   oXQYblpYyA6+5VjQvkoWTFyhb2dlearHPLhERyz65698j0ARF/5ZXD4W2
   2QovU5jJhCBstCVlFaJWfoG31nIBFuLITqBPnfcgEK9L48KjerxI4ju/2
   56jkSTZeKAmjvpQn8SnVsCUblxSdPrZwVdeoROoOesPKcuEo1I4ZA/6vX
   A==;
X-CSE-ConnectionGUID: Y1PZS8otSwOMgyFSwXBoYg==
X-CSE-MsgGUID: YqTw9+QDRvuzyavQ3iKepw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="102964961"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="102964961"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 18:44:20 -0700
X-CSE-ConnectionGUID: DSdJ/uUFTVK6tEPIZneMOg==
X-CSE-MsgGUID: CM5zZxk4SPGk23fh0D191g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="281546986"
Received: from unknown (HELO [10.238.1.243]) ([10.238.1.243])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 18:44:17 -0700
Message-ID: <f16aea7f-6b5a-4980-91b4-a41931b797ec@linux.intel.com>
Date: Thu, 23 Jul 2026 09:44:15 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] KVM: x86/pmu: Emulate RDPMC on performance metrics
To: Jim Mattson <jmattson@google.com>, Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
 <20260629231938.15129-8-zide.chen@intel.com>
 <CALMp9eQyMe6MfYPkvYAZPm+6A+FK6ZYpGv5Wx+nVvi9GtumA+g@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CALMp9eQyMe6MfYPkvYAZPm+6A+FK6ZYpGv5Wx+nVvi9GtumA+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/23/2026 8:02 AM, Jim Mattson wrote:
> On Mon, Jun 29, 2026 at 4:29 PM Zide Chen <zide.chen@intel.com> wrote:
>> If the host has the PERF_METRICS capability but it's not present on
>> the guest, RDPMC interception must be enabled and KVM should inject
>> an #GP when the guest attempts a PERF_METRICS RDPMC.
>>
>> If the guest has PERF_METRICS but RDPMC interception is enabled for
>> other reasons, KVM needs to emulate RDPMC with type 2000H.
>>
>> For simplicity, Metrics Clear Mode is not supported.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v6:
>> - Merge kvm_pmu_rdpmc_metrics() into intel_emulate_rdpmc().
>> - Reject non-zero index.
>> v5:
>> - new patch.
>> ---
>>  arch/x86/kvm/pmu.c           |  7 +++++++
>>  arch/x86/kvm/vmx/pmu_intel.c | 14 ++++++++++++++
>>  2 files changed, 21 insertions(+)
>>
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 8ef2d4761790..04b9c840f218 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -806,6 +806,12 @@ bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
>>  }
>>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
>>
>> +static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
>> +{
>> +       return (kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS) &&
>> +               !kvm_vcpu_has_perf_metrics(vcpu);
>> +}
>> +
>>  bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>>  {
>>         struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> @@ -818,6 +824,7 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>>                 return true;
> I know we have a strong disagreement here, but I really feel that this
> must be secure and future-proof out of the box.
> What if we added a module parameter, enable_rdpmc_passthrough, which
> defaults to false?
>
> Then:
>
> if (!enable_rdpmc_passthrough)
>         return true;
>
> Is that a reasonable compromise?

Yes, this is an option. Another option is to add a helper to explicitly
tell which platforms are secure and can pass-through rdpmc. Maybe like this,

static bool intel_pmu_can_passthrough_rdpmc()
{
    switch (boot_cpu_data.x86_vfm) {
    case INTEL_ICELAKE_X:
    case INTEL_SAPPHIRERAPIDS_X:
    case INTEL_EMERALDRAPIDS_X:
    case INTEL_GRANITERAPIDS_X:
    ... ...
        return true;
    default:
        return false;
    }
    
    return false;
}

Then rdpmc can be passed through by default on these known secure
platforms. For any new platforms, the rdpmc would be intercepted out of 
box until we confirm it's secured and explicitly support them.

How about this? At least for me, it looks like an overkill to disable rdpmc
passthrough unconditionally on these known secure platforms. 


>
>>         return kvm_need_any_pmc_intercept(vcpu) ||
>> +              kvm_need_perf_metrics_intercept(vcpu) ||
>>                pmu->counter_bitmask[KVM_PMC_GP] != (BIT_ULL(kvm_host_pmu.bit_width_gp) - 1) ||
>>                pmu->counter_bitmask[KVM_PMC_FIXED] != (BIT_ULL(kvm_host_pmu.bit_width_fixed) - 1);
>>  }
