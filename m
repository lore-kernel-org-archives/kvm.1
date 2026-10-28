Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793225453;
	b=Nxkm99vsRwttsi1wQ5+nLJybu2z1386+AOgj8rqRlppMLZkOmoRMsDYmE7hkfn01Jlv1
	 +V7TTOdswlg20XBaGzUpSa/JEgeXKpEOtT87Q7hFM5w15cuxa+yZqHPuPcCQ3uW9VZSFg
	 zgoUu6GdqHAAyuSNr8oGCjnzdAgBki6OedXJ7efveixxgKNMUOFrR+/rsDHHXD5BwTR+F
	 Lyqbw43Rti9S1RdUHFzC9akem3oDd5hTfV6Z4LocitGHbKff74My+EAeSR/0+0yN+Dr+u
	 a7RitYhqaiUxewaREaxrq+MiQSWsJkPdtqbjNlsvA1bShZRJ1XnF2fqCvjS2lRcSJwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793225453;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Uw7j/zExF/c2pZRiZuVvXgNDofIIB3MSThco4c+4mV0=;
	b=RqYFiBtUr6KWyFagZw27mU4mdSPEKKOoBYEv4Z+ifY0jxbK1aJsL3kdkbWzmv0f9uKcb
	 Ib8T+qfOSGMQNXM+eV3Vazr+bN9jIfk3pI1egSW6nNn0PbkqgRBRmI1YrKd2hYtmuelkC
	 tMLC8TPUJ4mRk1iiG0HXGTw5cre97usHwdJrgbVC+Bu1ycp9hA7TyR6RdcqOOlqZY8gkd
	 C+1VTeUosePtN89BhWMuhAVBbx6zOn52REyUGPN7Er5B8LC61hQM29erlm+4flbCYx9vw
	 DAggtKR2MIP6UV8Jfb3JsvnsftXIcuZlACJOKLfJfS4TvXQ4DfRAwh5Co6EpTRy8ILg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OA78qlB7;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C15C606A31A;
	Wed, 28 Oct 2026 22:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C15C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OA78qlB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793225451; x=1824761451;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RApub2eEBqkU+xXjPQ8f3UFm0dNetKwhWeMbwHPPz0w=;
  b=OA78qlB7GWhg1wHFfrM86PwFE4v9NvjJ2gh0u0REfLWFBlEyhMlPLrbL
   hu32k0aqNruEtP8BBRpeobJOIKQOovFsxID/ZwpV3AAb1lwk38hoCtpdr
   g+mfwAV86t6j2CVyeXga7dDF3p8C94Vq+R9+Vwt10ywmiE6OIggUaFeZn
   K/oF1SK4EPYt/GxwK2kebC7ETJ1peedhLlLcorQk8E48uN5wKbAynGoII
   08vzxBVv/ETxh6o6vC7yNRp24S/1z0lHVGOuvR9oAapCDtvF5+kRFBVlu
   7MjBX7+oJ2Zi6YwHnUQsWM5y967FQpyhbMJwTv7TfDXzyCpDULyIq0fmi
   w==;
X-CSE-ConnectionGUID: GFEm/llCT1a55aXAplw3ZA==
X-CSE-MsgGUID: GjrHW/PCS1aA9Z0NQSLmhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1839584"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1839584"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 15:10:50 -0700
X-CSE-ConnectionGUID: BQaHHtQ7RUqlUCPqH8qDwA==
X-CSE-MsgGUID: jpaaIzs8SAqhjf05A8SROA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5053103"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 15:10:49 -0700
Message-ID: <2a65bf64-37bf-41e3-976b-1a51bb46935f@intel.com>
Date: Wed, 28 Oct 2026 17:10:48 -0500
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
Subject: Re: [PATCH v2 15/16] KVM: x86/pmu: Advertise PerfMon version 5 on
 Intel hosts
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-16-zide.chen@intel.com>
 <CALMp9eSvh5+PqSXVQAAMoWwvZiMCVEooxuVd-e-sM8mODoLb9A@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eSvh5+PqSXVQAAMoWwvZiMCVEooxuVd-e-sM8mODoLb9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/28/2026 4:59 PM, Jim Mattson wrote:
> On Thu, Aug 27, 2026 at 3:48 PM Zide Chen <zide.chen@intel.com> wrote:
>>
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> KVM currently caps the guest PerfMon version at 2 for all Intel
>> platforms. Now that KVM emulates the basic architectural PMU features
>> introduced in PerfMon versions 3 through 5, raise the guest PerfMon
>> version to 5. Features that require additional emulation support, e.g.
>> architectural LBR will be enabled separately.
>>
>> PerfMon versions 3 and 4 continue to be exposed as version 2 because
>> KVM cannot safely virtualize AnyThread due to cross-VM information
>> leakage. PerfMon v5 is supported because it provides the
>> AnyThread-deprecated capability, allowing KVM to indicate that
>> AnyThread is deprecated.
>>
>> When enable_mediated_pmu is disabled or in the non-Intel paths, KVM
>> retains the existing cap of version 2.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v2:
>> - Cap vPMU v3/v4 to v2, as AnyThread cannot be safely virtualized.
>>   (Sashiko)
>> ---
>>  arch/x86/kvm/pmu.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 4cb7c796daac..1a7be7d73b62 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -175,7 +175,21 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
>>         }
>>
>>         memcpy(&kvm_pmu_cap, &kvm_host_pmu, sizeof(kvm_host_pmu));
>> -       kvm_pmu_cap.version = min(kvm_pmu_cap.version, 2);
>> +
>> +       if (is_intel && enable_mediated_pmu) {
>> +               kvm_pmu_cap.version = min(kvm_pmu_cap.version, 5);
>> +
>> +               /*
>> +                * PMU v3/v4 has AnyThread support, which KVM cannot safely
>> +                * virtualize. Expose PMU v2 instead of advertising a partially
>> +                * functional PMU v3/v4 to guests.
>> +                */
>> +               if (kvm_pmu_cap.version == 3 || kvm_pmu_cap.version == 4)
>> +                       kvm_pmu_cap.version = 2;
> 
> Nit: on Intel, enable_mediated_pmu already requires host_pmu->version >= 4
> (see intel_is_mediated_pmu_supported()), so kvm_pmu_cap.version == 3 is
> impossible when (is_intel && enable_mediated_pmu) is true. Hence, I think this
> can be simplified to:
> 
>         if (is_intel && enable_mediated_pmu && kvm_pmu_cap.version >= 5)
>                 kvm_pmu_cap.version = 5;
>         else
>                 kvm_pmu_cap.version = min(kvm_pmu_cap.version, 2);


Nice simplification. You are right that version == 3 is dead code. I
will adopt this simplified code in v3.

