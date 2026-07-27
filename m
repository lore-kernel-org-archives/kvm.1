Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104303ACA65;
	Mon, 27 Jul 2026 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166498; cv=none; b=Uh4MyJYfGb+xtjTjzl8ZMdHiR6IxTcRv6z9AX9OoDuCDYYz/1K9jQQ3N6L7XIWVziQxYOaUSQ4nlKrH+vTPsxFdqMT02MKvJyK4dUgHDCGZEdKzGo5AKzgYpGsnCeT18j4Dii6+S8oK+g/MorquE8lPO/parA5tHokFbtunRdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166498; c=relaxed/simple;
	bh=T9gfrUeDMtmIh6Skq4Yw7X2kYf5us1qMxJExOAhm88I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLjwZd/UrbfV732ELVjBUDVZi2mKZZmf/FofHDY0Si+Cvgpm4o4IBTc3VLljwtRQBcLoGB+6jha6JiP22QbYTwRG8uxnHsa8jZRC1E1S0VxWub/eV0Rits9ELFO1/4y/v9fN/w2kIDkUJX7pxT4C7MKzv5PQs8/g4i/woJnk4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0hFEiVy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0hFEiVy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785166496; x=1816702496;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T9gfrUeDMtmIh6Skq4Yw7X2kYf5us1qMxJExOAhm88I=;
  b=k0hFEiVyDKINYGwuOHxn+Q3m5Mq1SF9++4RYDTF3TcmT0FMxkX4xbGKN
   KuewCfHGLAp1CfCXA7rw9V5VZ2dDbonmmro5oUyg+mA8ffSCrcupSxf1o
   6mZmNCq4fwotZ/DN87Yxye7gSECLNVR+SnpJMgcqUpDAUWwE9jorSGv7m
   X2VrOUM5EW/bRDhY4S+EQtMobObfJvuQ/knXBIdPzFv93DQe2abp3me+/
   iZR2F7pLgyoYATkcvujxMEgSnb+BkqjGoHtXNPmMAWdM+sdN98F5KOX4H
   6WHy0ORvg9AmJYE3ZkYN/FhpYQQZgOUROhZMask/7Q0PNWfHHhxhgriLT
   A==;
X-CSE-ConnectionGUID: JdB9zR4nSletMKKbqz+Gxg==
X-CSE-MsgGUID: 3vCi/5SSRJCoTo5oy7KufA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="96324615"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="96324615"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 08:34:55 -0700
X-CSE-ConnectionGUID: ZpUbiApRTTyVMyqwdDOpcQ==
X-CSE-MsgGUID: 5qQpEziyTuGgm/r9S42KwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="260085680"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 08:34:55 -0700
Message-ID: <db2f6b5a-13e9-4dd5-821a-f5d325f6d0d3@intel.com>
Date: Mon, 27 Jul 2026 10:34:53 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/8] KVM: x86/pmu: Support PERF_METRICS MSR in mediated
 vPMU
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
 <20260629231938.15129-6-zide.chen@intel.com>
 <CALMp9eTy+aO9LE7UrbgxSqbwUq=NKXVEhTNmmAA5mtnqHevepA@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eTy+aO9LE7UrbgxSqbwUq=NKXVEhTNmmAA5mtnqHevepA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/26/2026 10:49 AM, Jim Mattson wrote:
> On Mon, Jun 29, 2026 at 4:28 PM Zide Chen <zide.chen@intel.com> wrote:
>>
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Bit 15 in IA32_PERF_CAPABILITIES indicates that the CPU provides
>> built-in support for Topdown Microarchitecture Analysis (TMA) L1
>> metrics via the IA32_PERF_METRICS MSR.
>>
>> Expose this capability only when mediated vPMU is enabled, as emulating
>> IA32_PERF_METRICS in the legacy vPMU model is impractical.
>>
>> Pass IA32_PERF_METRICS through to the guest only when mediated vPMU is
>> enabled and bit 15 is set in guest IA32_PERF_CAPABILITIES.  Allow
>> kvm_pmu_{get,set}_msr() to handle this MSR for host accesses.
>>
>> Save and restore this MSR on host/guest PMU context switches so that
>> host PMU activity does not clobber the guest value, and guest state
>> is not leaked into the host.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v5:
>> - Remove host_initiated check in set/get MSR handlers.
>> v4:
>> - Remove WARN_ON_ONCE() and simply reject the guest accesses by checking
>>   host_initiated. (Sashiko)
>> - Passthru MSR_PERF_METRICS only if has_mediated_pmu is true. (Sashiko)
>> - Remove the redundant !! in vcpu_has_perf_metrics().
>> v3:
>> - Replace WARN_ON() with WARN_ON_ONCE(). (Dapeng)
>> - Add comments to explain why we don't validate writes on PERF_METRICS.
>> ---
>>  arch/x86/include/asm/kvm_host.h   |  1 +
>>  arch/x86/include/asm/msr-index.h  |  1 +
>>  arch/x86/include/asm/perf_event.h |  1 +
>>  arch/x86/kvm/msrs.c               |  6 +++++-
>>  arch/x86/kvm/pmu.h                |  5 +++++
>>  arch/x86/kvm/vmx/pmu_intel.c      | 31 +++++++++++++++++++++++++++++++
>>  arch/x86/kvm/vmx/vmx.c            |  7 +++++++
>>  7 files changed, 51 insertions(+), 1 deletion(-)
>>
>> ...
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index b736b9ff965b..21eb4b339fa6 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -4273,6 +4273,10 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>>                                   MSR_TYPE_RW, intercept);
>>         vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
>>                                   MSR_TYPE_RW, intercept);
>> +
>> +       intercept = !has_mediated_pmu || !kvm_vcpu_has_perf_metrics(vcpu);
>> +       vmx_set_intercept_for_msr(vcpu, MSR_PERF_METRICS,
>> +                                 MSR_TYPE_RW, intercept);
>>  }
> 
> Should we also update nested_vmx_merge_pmu_msr_bitmaps()?

Yes, I can include nested_vmx_merge_pmu_msr_bitmaps() in v7 and post it
today.

I just verified that Topdown works correctly, including MSR passthrough
and RDPMC passthrough in a nested Linux setup on top of the vPMU v5
series (to enable medisted vPMU on nested).

Initially, I was planning to revisit this as part of a broader effort on
nested PMU virtualization, including features such as Arch LBR. However,
I now agree that including it in this series makes sense.

