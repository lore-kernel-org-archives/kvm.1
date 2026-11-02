Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659684;
	b=bcGD3Lb35iRbWTzK/kETuTVj6vFDyID7auZDTFbJOZTtJj3IAwRVuI4HnIjFQVwd/svM
	 oeLMhGad+Xco0vpwRzrDA5PUSM4Es00uoicI7nRLVqyvidVvCrkXoGhhkZGDX+JhbUaWC
	 h+vSAwd8A8sN2gXz7q0k53/KoG0s6EAYdpZ3Y1OB3FTJZNacgMvSUqgRcU04/xvRPVplM
	 Mgf8DpJduSrt0XewdwfsNUwPf/yGksnihq8ameeehtxdpLpk8k+c5eEXglPVEHTjFbCgU
	 /6L5X+bFCrgPjTDsByVs0KykMh+uChwZK48JJEbcVZI67YqHLOpUuMaMqVKqGAGirdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659684;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=+Lu3kwTKaYVPHV20G0lfQsoqjHr43HrvKwR6wWCwjFM=;
	b=P54RBX+CkPxfmw2dG6h8uYm/2boOPNKGYEgY8p927jSy4cfsTmXiVChcFZjdnorz5FAR
	 efjSkslex8DRpak5sB8vekWS8TjKJOK6wMODFiSfFpYjbTfDjOcSpZuGv42yA5yxprkrz
	 4pSqVI5hJIZi4X0xCY3taaqS4j86oiM6jLdpOENQwqCpxGT4QCh4je/Lixw2OOXeoqPT3
	 9xmg3XKsxwaxh+31JTjoPnhfjDb+MEDDnzftUImM6pDcFdI2247Jt+g0dPK4SqEr0tIcn
	 LWI+DWPPUD80vfPk/PInEgJQVanJosE+Kxu9ZdVXfy2q3k9hCpe/UAuJwjq2INbsPIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EajM6R6C;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD02606A326;
	Mon,  2 Nov 2026 22:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BD02606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EajM6R6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793659684; x=1825195684;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5p7gRSvtRcKGyltKTc3Y1jSG7ZGlcSLry8dTLj7X6RI=;
  b=EajM6R6C6iKD19LfVGL9E7W+8+M9G+5lLaytQOB1qigPmuAOq+dzaQMZ
   ZExY3/47sOwhm/Zq+cZdqn4QXbAfEwH1TRuBv/uBxUKmCq9lcmtnEoRUw
   blU9w/SftU2npw6spJS13pQTDzJsfk3m3yjjdHD4RYC36A7ycqgzxkRAr
   ++Zs5hwf61u3BV9CKbYFtBDZVDG8CG5PzOATChGt6An1ArYHMQq//Muu3
   d5NBq0zMgO5jrSupuA5PogMKKxlBJv9bNMis3T/cX6mD7peI0GlHG6SI/
   zaasCzc+pB/fNIXklQRoCkS7l1kaTUpyJoO9yKiEUBYu97PIHXpHd8xhs
   w==;
X-CSE-ConnectionGUID: Zs7LALIXTMqFPeS+vchR+g==
X-CSE-MsgGUID: QwYfsOJpQcqbs76wlw+lVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2365282"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2365282"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:48:03 -0800
X-CSE-ConnectionGUID: WOJ8+xgZRN+Ofb3GmyvAxQ==
X-CSE-MsgGUID: BMihwZkUQXmSaS7bEo7c7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="8023783"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:48:02 -0800
Message-ID: <f7213eba-5b61-4514-a315-bce64823fad5@intel.com>
Date: Mon, 2 Nov 2026 16:48:01 -0600
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
Subject: Re: [PATCH v2 11/16] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and
 GLOBAL_INUSE MSRs
To: Jim Mattson <jmattson@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-12-zide.chen@intel.com>
 <CALMp9eRvQ+iQdw_dWPLqZCrO7zpLut+O27pb-EPNa33hkegaBw@mail.gmail.com>
 <auUQgRVFASkWtkoK@google.com>
 <3276824d-f6a0-455a-bf0c-703fc6d52cf1@intel.com>
 <CAO9r8zMxQnRLKGrW69rX7703AatWMp6KOXMObL9baHRPs4dW8A@mail.gmail.com>
 <6c9a13c9-e6c1-4540-a8ca-1f0e800f3571@intel.com>
 <CAO9r8zOWzr61pkkF01AvEp+YSOo6bA1N=L91RYiM=ETtK5+D9w@mail.gmail.com>
 <69c428d7-239a-485e-9494-32b8aa82da05@intel.com>
 <CALMp9eRsR8xaUmQyVu5QmYx1cZ2qFGGk+31bMymhmN9_iaPuMg@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eRsR8xaUmQyVu5QmYx1cZ2qFGGk+31bMymhmN9_iaPuMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/2/2026 4:25 PM, Jim Mattson wrote:
> On Mon, Nov 2, 2026 at 2:13 PM Chen, Zide <zide.chen@intel.com> wrote:
>>
>>
>> On 11/2/2026 3:36 PM, Yosry Ahmed wrote:
>>>>>>> 1. GLOBAL_STATUS_TRACE_TOPAPMI_BIT can leak from the host into the
>>>>>>> guest. If a host PT PMI arrives while the guest context is loaded, bit
>>>>>>> 55 will be set for the guest, and the guest won't be able to clear it if
>>>>>>> OVF_CTRL is intercepted (it will #GP as it is reserved for the guest).
>>>>>>> Similarly, the value can't be restored through KVM_SET_MSRS.
>>>>>> I think mediated vPMU assumes that no host PMIs can be generated while
>>>>>> guest PMU state is loaded.
>>>>>>
>>>>>> If PT state can leak into the guest via bit 55, similar leakage can also
>>>>>> occur for other status bits, e.g. when the guest exposes fewer
>>>>>> general-purpose or fixed counters than the host.
>>>>>>
>>>>>> The scenario where both host and guest can be active simultaneously is
>>>>>> handled by the perfmon_mask case, where intel_mediated_pmu_{load,put}()
>>>>>> filter guest-owned status bits.
>>>>> Looking at the code:
>>>>>
>>>>> kvm_mediated_pmu_load() -> perf_load_guest_context() ->
>>>>> perf_ctx_disable() will iterate PMUs with for_each_epc() and disable
>>>>> them, which skips PMUs without PERF_PMU_CAP_MEDIATED_VPMU.
>>>>>
>>>>> Same for kvm_mediated_pmu_load() -> perf_load_guest_context()
>>>>> ->ctx_sched_out(), it also uses for_each_epc() to iterate PMUs and
>>>>> schedule them out.
>>>>>
>>>>> pt_init() does not set PERF_PMU_CAP_MEDIATED_VPMU on pt_pmu.pmu.capabilities
>>>>>
>>>>> Please correct me if I am wrong.
>>>> My apologies, this bug is indeed real because pt_pmu lacks the
>>>> PERF_PMU_CAP_MEDIATED_VPMU capability.
>>>>
>>>> Adding this capability to pt_pmu seems intuitive, but unlike
>>>>
>>>>                        the core PMU (which merely toggles enable bits),
>>>> Intel PT is an AUX-based PMU. Stopping and restarting it on every VM
>>>> transition is heavier, and I'm not sure whether it could introduce a
>>>> noticeable performance penalty.
>>>>
>>>> However, whether the solution is adding PERF_PMU_CAP_MEDIATED_VPMU or
>>>> some other mechanism to enforce mutual exclusion between pt_pmu and
>>>> mediated vPMU, we can address that in a separate patch.
>>>>
>>>> To immediately protect guest state and live migration in this series,
>>>> I'm thinking of adding the following defensive filter in
>>>> intel_mediated_pmu_put():
>>>>
>>>> + /*
>>>> +  * Scrub bits that are not virtualized for the guest to prevent
>>>> +  * possible host state from leaking into guest state and breaking
>>>> +  * live migration.
>>>> +  */
>>>> +  pmu->global_status &= ~pmu->global_status_rsvd;
>>> This doesn't prevent the leakage, it just clears it on the guest->host
>>> switch. So it helps live migration but I am not sure if it's better or
>>> worse if the guest sees the bit unexpectedly appear AND then
>>> unexpectedly disappear.
>> Right, as long as the GLOBAL_STATUS is passthru, the leak can't be
>> prevented.
>>> We can clear it when the MSR is read by userspace, which should fix
>>> live migration, but the guest will still see the bit, and it will
>>> still disappear unexpectedly but only during live migration.
>>>
>>> The guest still won't be able to clear it when OVF_CTRL is intercepted.
>> GLOBAL_STATUS and OVF_CTRL share the same interception policy. If they
>> are passed through, the guest can see the bit and clear it; if both are
>> intercepted, then bit 55 can't leak to the guest.
>>
>> It's not perfect, but at least the guest won't observe bit 55 and then
>> get an unexpected #GP when attempting to clear it.
> I'm not sure what imperfect solution you are referring to, but Yosry's
> proposal that the bit gets cleared on a guest->host switch is a
> non-starter. MSR bits must not vanish unpredictably.

Agree, then maybe Yosry's suggestion is what we can do for now: filter
out unsupported bits when the MSR is read by userspace.

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 38c7a4fa1007..3849b3f5234a 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -862,6 +862,8 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct
msr_data *msr_info)
        switch (msr) {
        case MSR_CORE_PERF_GLOBAL_STATUS:
        case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
+               if (msr_info->host_initiated)
+                       pmu->global_status &= ~pmu->global_status_rsvd;

The underlying issue still requires proper mutual exclusion between
Intel PT and mediated vPMU, which I think can be addressed separately.

