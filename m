Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10CD375F6C;
	Thu, 27 Aug 2026 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870333; cv=none; b=PEqC3C7url3/0FfBbFr2ioyBNLSakiGH03EaWpQrpqsAoy6Q8G4HtMVCYzUJBvIfFpbK0HteGzTTQ30nFW9WJYdRzsetBjPnRassNYrojXRV7LaRLGvC4Hw9/h3adec5jXXe4W5FLZJEJZo1WKYoZd1FEFU/SndXvFfd1I+ZhI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870333; c=relaxed/simple;
	bh=0XuJVNPBDrKth2ZiShaZXHFOxdcS2TooJPGzNcuLGv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJSOeydxiAL6TBrP1rX2U75Q0d2jp3377qIr+4w5nEwpYbhPeZ6HmiZkLbqjXZ5kg2U57TmYiSlKEJiwhLQ8QnTw6OTbdnhZQQfcA/LUOBGyihBJbTZRcc8szCnJwzrAqNWBHtrd2+dZzAgPxOtGMcKG1k7QRO9oYGmR3jNE3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFfqnaGV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFfqnaGV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787870330; x=1819406330;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0XuJVNPBDrKth2ZiShaZXHFOxdcS2TooJPGzNcuLGv4=;
  b=SFfqnaGV9orM5CM06MSbIXG8zzNP7+gOnD6kj7wF+WnBnjZOoScMc5rK
   22TrE7w+WZWXE66R+iBnd8eX3Aw+KqXUT210qltkSmBltvCiQqr2PaGyY
   APNYMLa70O+DZRT5GBTsFjZ/cp8trQefjCs3vi2wyp7phY8MZuXhf8ENt
   kp2A3l+GEFI+/hG2jDr1J1v1gQ3AORo7puIMBdjwA2CesEzaP+1OTKxHo
   hkGUCfvY1Y0YxjuW4AI5Fhj2ixdk9tJn4ZPpcGBPXOZh08m/oClmcBERB
   bkXB4Y4m5zCNM8KOLQZ+v20mlQssi0Qf7Pex6fva2D/Oz3iiIKIMP/Xw9
   g==;
X-CSE-ConnectionGUID: 9YBdSjbsSue3ZQSq3NdNgA==
X-CSE-MsgGUID: ZKvhn1sDSdywbXoNFF0U6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99731790"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="99731790"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:38:47 -0700
X-CSE-ConnectionGUID: md151z5PQIOVf/TgFXdlPA==
X-CSE-MsgGUID: Q4TIw1KGQkWcunoN/K3iDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="268566141"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:38:46 -0700
Message-ID: <0b1afe89-8ea5-4961-8582-4e59c5e369f7@intel.com>
Date: Thu, 27 Aug 2026 17:38:44 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/23] KVM: x86/pmu: Handle FIXED_CTR_CTRL under PerfMon
 masking
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260821222002.54907-1-zide.chen@intel.com>
 <20260821222002.54907-17-zide.chen@intel.com>
 <86696454-bf73-4d06-83f6-1f85e6540259@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <86696454-bf73-4d06-83f6-1f85e6540259@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/2026 3:43 AM, Mi, Dapeng wrote:
> 
> On 8/22/2026 6:19 AM, Zide Chen wrote:
>> PerfMon masking affects reads from and writes to this MSR. The effective
>> mask is defined as bits 4n+3:4n and bits 4n+35:4n+32 being set if and
>> only if bit 32+n of the PerfMon mask is set (for 0 <= n <= 7).
>>
>> KVM doesn't support some fixed-counter features, and
>> pmu->fixed_ctr_ctrl_rsvd is a subset of the effective mask above, so the
>> existing gating in intel_pmu_set_msr() is sufficient even under PerfMon
>> masking.
>>
>> Upon guest PMU context load, OR the guest-owned bits with whatever the
>> hardware currently holds for every fixed-counter index the guest does
>> not own, before writing the result to the MSR.
>>
>> During PMU context put, host-owned fixed counters may still be scheduled
>> for system-wide host events, so the host-owned bits should remain
>> unchanged.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  arch/x86/kvm/vmx/pmu_intel.c | 40 +++++++++++++++++++++++++++++++++---
>>  1 file changed, 37 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index 19ccc7cd319c..9236bfa15c41 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> @@ -920,6 +920,33 @@ static void intel_pmu_write_global_ctrl(u64 global_ctrl)
>>  	vmcs_write64(GUEST_IA32_PERF_GLOBAL_CTRL, global_ctrl);
>>  }
>>  
>> +static u64 intel_fixed_ctrl_host_bits(struct kvm_pmu *pmu)
>> +{
>> +	unsigned long fixed_mask;
>> +	u64 fixed_ctl;
>> +	int i;
>> +
>> +	if (!kvm_vcpu_has_perfmon_mask(pmu_to_vcpu(pmu)))
>> +		return 0;
>> +
>> +	fixed_mask = kvm_fixed_pmc_mask(pmu);
>> +
>> +	rdmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, fixed_ctl);
>> +
>> +	/*
>> +	 * Use the full per-counter nibbles (bits 4n+3:4n and 4n+35:4n+32) to
>> +	 * strip all bits belonging to guest-owned counters.
>> +	 *
>> +	 * pmu->fixed_ctr_ctrl_rsvd can't be used here since it can't gate bits
>> +	 * that are not supported by KVM.
>> +	 */
>> +	kvm_for_each_fixed_counter(i, fixed_mask)
>> +		fixed_ctl &= ~intel_fixed_bits_by_idx(i, GENMASK_ULL(3, 0) |
>> +						      GENMASK_ULL(35, 32));
>> +
>> +	return fixed_ctl;
>> +}
> 
> Strictly speaking, this should be a perf/x86/intel function and then
> exposed to KVM. Perf host side may also need this function.

The code is slightly different. For example, fc0 is bit 0 in
kvm_fixed_pmc_mask(), while it is bit 32 in the host case
(x86_pmu_current_partition_mask()).

It does not seem worthwhile to refactor the code for reuse for such a
small API.
