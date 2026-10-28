Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220993;
	b=IG5Mk4WlwajUqKAzZ2++/0p0Xm5GCEay3g+h9k8X2NzyTy111qkmMfZs+hjDlew5L2nV
	 cTOxZsX6foeHs5VP72iwazUKuQOupchMXrrveel77SyNvoLCm5byt8lAoSXay4Fksu6AP
	 XUu8g3PMCE3o6OCrvFBTgBxW9wnKMHixJYIjqDngERn3gbVj/NVPr2sNrQvz9NmWAx83E
	 i31IdelpzjcrBURfdPIFVGf9LVTa2T+MMLLbV6kyrJUD0FSronqOqO7MkuILX0O98uKq0
	 HmskJl+Ib8Pmt491sir+SWdMO3hT+5Tndmjzz15A6FECdyHxPtgi/BUso5nLOqV0X4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220993;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=d0uZ7bDOtn5HW/dXtjM4vQVXca3IMlbQSm+JVQ5ewaU=;
	b=QqS8anSGcKOpAN5f49hEVSaX0nMOwYXF6goJbuP7HklRFwq419EZ3H/yCbW/lPYnBfqL
	 dyLslwkDSQu4HXBEF++MRv5ao9zC9YHXrKtvV9AMuU3iuwcrvRp2Gz9nq9HQfscb4eWUJ
	 S1QabI898YBIlEIdPeit1rP+OHML44FHBCQvBv9LomX8DM6goTE7ceZcQKYD3hr5X0hKR
	 0h4NrZG2NsePc/Th9VgpwsrrhiSMDlqiwH+ACQOmbP3vO7pkkc9My6khJSw8/W3ew54TL
	 dwsM6IkSQNrRcvdJbLUe31DRkchFwVEMleeLqCD5jm9BdhcUGwgW8znBQ7ty1VfhL1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cg1FfSW3;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AEE606A31A;
	Wed, 28 Oct 2026 20:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9AEE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cg1FfSW3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793220992; x=1824756992;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PbqW5AeZhCFft4Ougt7yyxKLq7PRF8FYmyX1CttUzeg=;
  b=cg1FfSW3trobUPjTq/2Ll7gwX0pHcu8v5SSxBWtvKrQrV3D7F8/HlW4N
   EtO5sO1IwEVBag2qcwZ1vBa1N2vkFfy9T3Y3ej/4TiRfGGnYd9vvtcLob
   uGWONkp/OIeY941pedR9m0lqUuQL17ejR60k8Qj8QMUteCGoax5YWMBG+
   IZnThOaX5q28MZCfoatr9KZw2G7CvgdU8DFhEVdwOZo/2oK71jAXSauip
   Nzyop1MJt4Ej4WaPw6vLckDeZqlA8xRlbKnQDh1hIs+hr9+Gi1mPqKqsd
   yx6Hxg74yiqwo4u1ZpqlG+twqV+pBEqVPK8m5w1dQEqL2gNBdRYXrTQx7
   w==;
X-CSE-ConnectionGUID: yuQcJzVOTrmjgXkew8l7XA==
X-CSE-MsgGUID: 5TGCz7MSQXWxzYTQLYoXfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1853947"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1853947"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 13:56:31 -0700
X-CSE-ConnectionGUID: Smk2O2gWSBCnTFdmW23Kog==
X-CSE-MsgGUID: kEEXzKb5QGWUA8py0P+KbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="4936115"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 13:56:29 -0700
Message-ID: <80a24492-5618-47c6-ae32-6d86f1153a62@intel.com>
Date: Wed, 28 Oct 2026 15:56:28 -0500
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
Subject: Re: [PATCH v2 09/16] KVM: x86/pmu: Switch to bitmask-based KVM PMU
 capabilities
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-10-zide.chen@intel.com>
 <CALMp9eSUcm3aygzDSn7qD_58AxZm6y1M58LOHXpLhcPV43L8Ow@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eSUcm3aygzDSn7qD_58AxZm6y1M58LOHXpLhcPV43L8Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/28/2026 12:57 PM, Jim Mattson wrote:
> On Thu, Aug 27, 2026 at 3:48 PM Zide Chen <zide.chen@intel.com> wrote:
>>
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Intel platforms support non-contiguous fixed counters via CPUID.0AH:ECX
>> starting with PerfMon v5, and support non-contiguous GP counters
>> through the Architectural PerfMon Extension (CPUID leaf 23H).
>>
>> struct x86_pmu_capability now exposes {,fixed_}cntr_mask64 bitmaps,
>> which may contain sparse bits representing non-contiguous counters.
>> Switch KVM's kvm_host_pmu and kvm_pmu_cap consumers over to the new
>> bitmask fields.
>>
>> CPUID.0AH:EAX[15:8] and CPUID.0AH:EDX[4:0] enumerate only contiguous
>> counters. Derive these values from kvm_pmu_cap.{,fixed_}cntr_mask64 as
>> the number of consecutive counters starting at index 0.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Co-developed-by: Zide Chen <zide.chen@intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
> [ ... ]
>> @@ -772,7 +773,8 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>>                 svm_set_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i,
>>                                           MSR_TYPE_RW, intercept);
>>
>> -       for ( ; i < kvm_pmu_cap.num_counters_gp; i++)
>> +       host_only_gp_mask = kvm_pmu_cap.cntr_mask64 & ~gp_mask;
> 
> Should kvm_pmu_cap.cntr_mask64 be kvm_host_pmu.cntr_mask64, as it is
> on the VMX side?

Yes, thank you for pointing it out.
> [ ... ]
> 
>> @@ -556,7 +557,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>          */
>>         nr_gp_counters = min_t(int, eax.split.num_counters, X86_PMC_IDX_MAX - 1);
>>         pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
>> -                           (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
>> +                           kvm_pmu_cap.cntr_mask64;
> 
> CPUID.0AH:EAX[15:8] (eax.split.num_counters) can only enumerate contiguous
> GP counters 0 .. nr_gp_counters - 1. If kvm_pmu_cap.cntr_mask64 ever had a
> hole below nr_gp_counters (when leaf 0x23 isn't exposed to the guest to
> advertise a sparse mask), masking (BIT_ULL(nr_gp_counters) - 1) with
> kvm_pmu_cap.cntr_mask64 would silently punch a hole in the guest's GP
> counters even though guest CPUID.0AH:EAX[15:8] told the guest that all
> counters 0 .. nr_gp_counters - 1 exist. Should nr_gp_counters be clamped to
> find_first_zero_bit(kvm_pmu_cap.cntr_mask, KVM_MAX_NR_GP_COUNTERS) until
> leaf 0x23 is supported?

Regardless of whether or not CPUID 0x23 is supported in KVM, I think "if
kvm_pmu_cap.cntr_mask64 ever had a hole below nr_gp_counters" would only
happen in the case of an invalid guest configuration.

Anyway, it is good to clamp nr_gp_counters to remove any theoretical
hole, keeping it semantically correct.  For example:

/*
 * CPUID.0AH:EAX[15:8] can only enumerate contiguous counters. Clamp the
 * value to the number of contiguous GP counters supported by KVM.
 */
nr_gp_counters = min_t(int, eax.split.num_counters,
                       find_first_zero_bit(kvm_pmu_cap.cntr_mask,
                                           KVM_MAX_NR_GP_COUNTERS));
pmu->pmc_exists64 = BIT_ULL(nr_gp_counters) - 1;

Thanks for the review!
