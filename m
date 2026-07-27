Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A683DEFF1
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 22:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192245; cv=none; b=SNqKUFVREXfDoI7pUTV/t3C+kC9A/kTW7hT1QuWZXekOQ1HaNsIpwBcIGQrDDMDsjPDVuezdUyToOXTJ8GplavroeqNP1knHAwu/u8hirTpzXGNCv7AmOuqT4cI1D+RSxu7ovch1Pd9gcWGZGGB7w/AXrB3z7+oOmyJT8cgRutM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192245; c=relaxed/simple;
	bh=q2E4cDWE5oHcF8308SlhBiX76SQSRRPfsV8MeQKgDyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nAyhLlDNMAtCzwUNwVA7c+QfKquR2aKZagN1RlZ+kvNjFsriK1pc4STxvouBa2CQkiw2B0Fy+dahtuI2BO9iBax2mRndEEVS9Ce0Zsx3WJ6Fw3QTEEHk9c7vpMiVyhjMWMb7pz/SGT4QMbgmg2fAk0qHmy3dn53kHx61z1HLCIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+9sC9z0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+9sC9z0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785192242; x=1816728242;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q2E4cDWE5oHcF8308SlhBiX76SQSRRPfsV8MeQKgDyw=;
  b=h+9sC9z0U7oGuEvVEYiTW2713p+6rAbpvmR+oDtDdQ/ERoIadMwq5I8r
   bR98mOdkpeIAXy50Stpx5fvn2HVEfc/JKWR8dAbti0QICjAtBf8rp2yMN
   z4TdztCvhO1OlzrXjhMS9EmQBcB16Sumd41srMHnBTGr5QNThx3G+hRAD
   PF+q0QjCS3+IyFFfmk39aAhwT+SrasYuru1MWJvjPT5NJZR3JZ1damkMY
   28BdKihbniDywTSccgzJyhoEyXAOA2TRIPOX5W0AGd2oo0TSiM2fRyqX6
   2g3aaIg5Yq87+geCQ/+0DWAD2oHRRn/fCe/iJle2yrW4/LBojPcSSfA3O
   A==;
X-CSE-ConnectionGUID: zUi15f8rTuu8hvWwNX8/bg==
X-CSE-MsgGUID: heo8r3ugTmiRI2mvaXT/PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85809244"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="85809244"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:44:02 -0700
X-CSE-ConnectionGUID: Zvr2VpGJQfGoMdcd6pMTzQ==
X-CSE-MsgGUID: 31/HIy+cRdCbtmLci0z7Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="264516409"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:44:02 -0700
Message-ID: <f87ab430-61a6-43cf-87ee-b88ab58ec9ef@intel.com>
Date: Mon, 27 Jul 2026 17:44:01 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/9] KVM: x86/pmu: Support Intel fixed counter 3 on
 mediated vPMU
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260727192131.582105-1-zide.chen@intel.com>
 <20260727192131.582105-3-zide.chen@intel.com>
 <20260727195130.007701F00AC4@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260727195130.007701F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/27/2026 2:51 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The logic to filter non-contiguous fixed counters incorrectly uses CPUID.0A:EDX[4:0] instead of counting the contiguous 1-bits in the ECX bitmask. This causes KVM to expose non-existent fixed counters to the guest while hiding supported ones.
> --
> 
> --- Patch [2]: [PATCH v7 2/9] KVM: x86/pmu: Support Intel fixed counter 3 on mediated vPMU ---
> commit 7c8d5061e2216416ace2a9414a66d8b5fc0bf8bd
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> KVM: x86/pmu: Support Intel fixed counter 3 on mediated vPMU
> 
> This commit exposes Intel's fixed counter 3 to guests when mediated vPMU is
> enabled. It updates the maximum number of fixed counters and adds logic to
> filter non-contiguous fixed counters since KVM currently does not support
> them.
> 
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
> [ ... ]
>> @@ -181,6 +185,19 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
>>  	kvm_pmu_cap.num_counters_fixed = min(kvm_pmu_cap.num_counters_fixed,
>>  					     KVM_MAX_NR_FIXED_COUNTERS);
>>  
>> +	/*
>> +	 * Currently, KVM doesn't support non-contiguous fixed counters; make
>> +	 * sure only contiguous ones are retained in kvm_pmu_cap.
>> +	 */
>> +	if (kvm_host_pmu.version >= 5) {
>> +		cpuid(0xa, &eax, &ebx, &ecx, &edx.full);
>> +		if (kvm_pmu_cap.num_counters_fixed > edx.split.num_counters_fixed)
>> +			kvm_pmu_cap.num_counters_fixed = edx.split.num_counters_fixed;
> 
> [Severity: High]
> Does this logic correctly determine the number of contiguous fixed counters?
> 
> If a host supports PMU version 5 with fixed counters 0, 1, and 3, the ecx
> bitmask would be 0xB, and kvm_pmu_cap.num_counters_fixed would initially be
> populated with the weight of that mask, which is 3.
> 
> The value in edx.split.num_counters_fixed reports the maximum fixed counter
> index plus one (4 in this scenario). The condition 3 > 4 evaluates to
> false, so kvm_pmu_cap.num_counters_fixed remains 3.

I think it's a false positive.

edx.split.num_counters_fixed represents the number of contiguous fixed
counters, which is 2 in this case. The code correctly sets
kvm_pmu_cap.num_counters_fixed to 2.

> This leaves KVM exposing the first three contiguous counters (0, 1, and 2)
> to the guest. Since the host hardware does not actually support counter 2,
> KVMs attempt to back it with a host perf event will fail.
> 
> Should this instead inspect the contiguous 1-bits starting from bit 0 in the
> ecx bitmask, for example by using ffz(~ecx)?
> 
>> +	}
>> +
>> +	if (!enable_mediated_pmu && kvm_pmu_cap.num_counters_fixed > 3)
>> +		kvm_pmu_cap.num_counters_fixed = 3;
>> +
> 

