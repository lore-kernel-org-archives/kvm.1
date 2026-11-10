Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328156;
	b=obSVCqmTZ/O7+8TDfPI8x5bh8kHjAKZPf5cI2psur04wJdFVVTAzAMEQjlQ+zJVUyhNK
	 1p7ltnaKQG83e6al4pIhXByeHGmymQJeom6yRnkAtGLl1MLFdH+lnQDuB2Yc18yLdlbe9
	 BHI2gxrUXBiXiyA1yQoZU6kh03hS0Nn/dC/JGp9lBqXHIvm1rOO+5nUCNKYj0IgpRv2PP
	 buusvOW6LVGqaxZ8Ps4OAnyzv2AR8IUb+HcfO0v2RiBIs9PVQMWOZREbDZWojfN99sJMv
	 7ZN2L3AOuQJxRsTgtmnPiRXUd3f0MvrAzQeXMCXk54aotv3FbjKSgC380rzpQaTZCJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328156;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=+E9BQxBpAXcPRNo1Ybi/jYn5qRwnyAzD2avHbDcjlBQ=;
	b=DceU1oB1sQQLMYn9iK/Ekv99n5ZSnvTT5iCsIsTGemoy2bvvaDyVulXhdGXnBOruYb+W
	 Kwk3Cu4XKO/3zItwuqzVolgQ/I0m/5a4u0WsLq2HI0IDA3K0XXGBNtxOnhiSnELIrluQO
	 +2/nivVb/Z/yZiBT7BoTkaZZDwIbpNr2+cmDkIM7QgKo1OExDsIyOPfdIhowhWQRA6Pq1
	 VJ1rNwg8g/EYF9vCAGUcLAMllTm26ByKg5dawcAt+Oqmg/mL3ZYWzGcBg9ww3NeG4BJHw
	 wndXbWruocWbyjgUDa7CP/zQ9LWiUY+EIdlitDaoKXEvWSRRnX3gyKfaFN5LKwGn9wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jL6ukbKa;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CA5606A200;
	Tue, 10 Nov 2026 16:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61CA5606A200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jL6ukbKa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794328155; x=1825864155;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2gBxwoDRUGadueQkivfRE2boh1VzodrRaTQrgu4WoN4=;
  b=jL6ukbKaybNcISz/JssdOherRoXU8Ny17NszB3e65rKk4S1JoFtSIGQj
   1E4qcVZeeHAmP/PsmsKoJgNQS/ypBes4c3mSnBNFmZyCPBrbC6G+pFlpy
   7Rj32+JGKUOSrD6NFi49e7Byp3+cKAv81HTlALmemdN9pLT9CxMmv0rtm
   RFTXFhppGPlCCyzrKTD7cXXvWPaId9BU0pTXQtyJ8SMW25inFeZvgA+5x
   82E/hiloLjOCu6xCBIcgrPkoQ8l+5XhFWbgmaiKLV1vM86jKwmmWIU/wZ
   H0Hz7tHEabTGAnM/Dc6cV3t9lRSJcN0uMikfHqi4M/fmw7wVwCgmWQkVa
   g==;
X-CSE-ConnectionGUID: jt3YthWxRo2/PayLS+myXA==
X-CSE-MsgGUID: EvXTooiNSkm7vcNXd/mjzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3083025"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3083025"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:29:14 -0800
X-CSE-ConnectionGUID: AJErk0/tTzyAGpnKRhUKVg==
X-CSE-MsgGUID: 1pWss2dMQnKEDL3zKuzz+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8157400"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:29:14 -0800
Message-ID: <5f129d63-10c6-414b-86a9-a604e42038ce@intel.com>
Date: Tue, 10 Nov 2026 10:29:13 -0600
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
Subject: Re: [PATCH v3 13/18] KVM: x86/pmu: Populate CPUID.0AH:ECX
 fixed-counter bitmap
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-14-zide.chen@intel.com> <au491iiV7koeP0t6@google.com>
 <f20b59bb-a3c6-4129-ba61-5cec4d975601@intel.com>
 <f12bcb27-9c17-4b8c-b48c-c36a17e70ab6@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <f12bcb27-9c17-4b8c-b48c-c36a17e70ab6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/10/2026 12:28 AM, Mi, Dapeng wrote:
> 
> On 11/10/2026 4:41 AM, Chen, Zide wrote:
>>
>> On 11/6/2026 3:00 PM, Yosry Ahmed wrote:
>>> On Thu, Nov 05, 2026 at 06:39:22PM -0700, Zide Chen wrote:
>>>> PerfMon v5 adds a fixed-counter support bitmap in CPUID.0AH:ECX.
>>>> This is the superset of EDX[4:0] which indicates the contiguous
>>>> counters starting from 0. For backward compatibility, it's recommended
>>>> to use the following to determine if a fixed counter is supported:
>>>>
>>>> FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i);
>>>>
>>>> Originally-by: Yang Weijiang <weijiang.yang@intel.com>
>>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>>> ---
>>>> v3:
>>>> - Remove '&' when populating entry->ecx. (Jim)
>>>> - Gate entry->ecx on kvm_pmu_cap.version >= 5 in intel_pmu_refresh() to
>>>>   avoid enabling v5 fixed counters on hosts where KVM caps PMU at v2.
>>>> ---
>>>>  arch/x86/kvm/cpuid.c         | 5 ++++-
>>>>  arch/x86/kvm/vmx/pmu_intel.c | 8 ++++++++
>>>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>>>> index 3310c370c5fa..00a2ca6d3049 100644
>>>> --- a/arch/x86/kvm/cpuid.c
>>>> +++ b/arch/x86/kvm/cpuid.c
>>>> @@ -1554,7 +1554,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>>>  
>>>>  		entry->eax = eax.full;
>>>>  		entry->ebx = kvm_pmu_cap.events_mask;
>>>> -		entry->ecx = 0;
>>>> +		if (kvm_pmu_cap.version >= 5)
>>>> +			entry->ecx = (u32)kvm_pmu_cap.fixed_cntr_mask64;
>>>> +		else
>>>> +			entry->ecx = 0;
>>>>  		entry->edx = edx.full;
>>>>  		break;
>>>>  	}
>>>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>>>> index 1372091dc1f8..37b34b588601 100644
>>>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>>>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>>>> @@ -597,7 +597,15 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>>>  				  find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
>>>>  						      KVM_MAX_NR_FIXED_COUNTERS));
>>>>  
>>>> +	/* FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i) */
>>>>  	fixed_mask = BIT_ULL(nr_fixed_counters) - 1;
>>>> +	/*
>>>> +	 * Do not enable fixed counters via the v5 ECX bitmap if KVM caps
>>>> +	 * PMU version below 5 (e.g. when mediated PMU is disabled or on
>>>> +	 * older hosts), matching KVM's advertised CPUID.0AH:ECX capability.
>>>> +	 */
>>>> +	if (kvm_pmu_cap.version >= 5 && pmu->version >= 5)
>>> Having to check both versions is confusing. Can they go out of sync?
>>> Should we clamp pmu->version to kvm_pmu_cap.version and only check the
>>> former?
>> Yes, actually, other fields (bit_width, mask_length, and
>> nr_{gp,fixed}_counters) in intel_pmu_refresh() are clamped to
>> kvm_pmu_cap as well.
>>
>> pmu->version = min_t(int, eax.split.version_id, kvm_pmu_cap.version);
> 
> I'm not quite sure if we could do such clamp. I remember Sean ever said KVM
> should allow user space to set the PMU capabilities which KVM doesn't
> support, like what currently kselftest pmu_counters_test does, e.g., KVM
> only supports up to PMU version 2 in non-mediated vPMU mode, but
> pmu_counters_test can set PMU versions larger than 2.
>

KVM's principle of "not policing guest CPUID" means KVM allows userspace
to configure an arbitrary guest CPUID without rejecting the ioctl or
mutating the vCPUID entries.

However, KVM's internal vCPU state (pmu->version) tracks the "effective
PMU version" that KVM can actually virtualize.

This distinction is documented in commit 4f1bd6b16074 ("KVM: selftests:
Test Intel PMU architectural events on gp counters"):

"KVM only officially supports up to version 2, but the behavior of the
counters is backwards compatible, i.e. KVM shouldn't do something
completely different for a higher, architecturally-defined vPMU version.
Verify KVM behavior against the effective vPMU version, e.g. dvertising
vPMU 5 when KVM only supports vPMU 2 shouldn't magically unlock vPMU 5
features."

pmu_counters_test itself explicitly mentions this rule:

/*
 * Return the effective PMU version, i.e. the minimum between what KVM
 * supports and what is enumerated to the guest.  The host deliberately
 * advertises a PMU version to the guest beyond what is actually
 * supported by KVM to verify KVM doesn't freak out and do something
 * bizarre with an architecturally valid, but unsupported, version.
 */
  return min_t(u8, kvm_pmu_version,
this_cpu_property(X86_PROPERTY_PMU_VERSION));

In my understanding, clamping pmu->version perfectly reflects the above
rule, and it's similar to other KVM code, e.g.:

        eax.split.bit_width = min_t(int, eax.split.bit_width,
                                    kvm_pmu_cap.bit_width_gp);
        eax.split.mask_length = min_t(int, eax.split.mask_length,
                                      kvm_pmu_cap.events_mask_len);

Without a PMU version cap, guest resource validation could become
increasingly complicated as more advanced PMU features are supported, as
KVM would need to allow the guest to access PMU resources only when it
satisfies both the vPMU version and the KVM capability.

>>
>> Without this, as more advanced PMU features are supported in KVM, we
>> will have to manually validate guest features, and it seems this doesn't
>> violate the general principles of "not policing CPUID configurations"
>> and using the "effective vPMU version".
>>
>>>> +		fixed_mask |= entry->ecx;
>>>>  	fixed_mask &= kvm_pmu_cap.fixed_cntr_mask64;
>>> I see why this is needed now, to re-apply KVM's fixed counter mask after
>>> reading it, but if this is only needed there, it's probably clearer to
>>> do:
>>>
>>> 	if (version >= 5)
>>> 		fixed_mask |= (entry->ecx & kvm_pmu_cap.fixed_cntr_mask64);
>> Agreed, this is cleaner. Will update accordingly. Thanks!

