Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029579;
	b=4PYZZl0moJbfa1zwpPBTcQeo1YgJYvaVVvdWL2fpv8cSlCxwNW14e0TmRRaIbgcVdDZ5
	 /KHaHvRkB+vyyRQ57Bxxx7fX8DehS8lwKBkJyCUKgmzM8w9bB52SUaJ3ELzAHECrdXgDP
	 4kU7nd7fJIj1DqVK6HDMkqiQVkbiXySFfSdqh12ny6ZJE1WoiSklL0PhfHy9HjbtJaadG
	 tcPUOqjKxQ/5t/Cxxxnq8u+ctlWOXAUHZfGInc4nYgt77gGeae2FV6sjHYmJxNCVmp7J2
	 j+yV6U+GUcZIjStEMzRTZHf5gpabYQ1bmbfSL7HXX9NhbuzFLvHM9J5aTEZxpN+w3Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029579;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=KDSF58kHkSIbsYCQIK1AczLB0eVwfvZrZK40Mx9MmFM=;
	b=wSfDtBx0vvOszLUTP80n0Rwi3iJOUMCgJSQ1ixlQo2eo783A6AoFa7hCQNlYVg0HHtwc
	 kC9AICD4LoAAlKvPsm2KpHFRKFhTRmGkwDjB4vrvHZkbMUqGtL0KH/TlVatwnoqHIYbZW
	 08+8mzTgZUQVMOsqlRDn+XaFqfl5NpFUlCss9NMKWAKeA9pmnHwKHu6mf1Mu08TLyrIgp
	 DStMb5BuINDoN86N0tm7teDZY1Wghht3o87tGzLZrVeX133l5OdH5voOhrgV3vqAmPLLQ
	 4AVuulrP4l+Vnxxv/DSqy4S5OIpuoknbNlcfaZQKjeN31NYzaPJr/lpyCXtyeRwhiAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MTWiXcuq;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE1606A31C;
	Wed, 18 Nov 2026 19:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68DE1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MTWiXcuq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795029578; x=1826565578;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xJGr+q0wlcpZbuQDFLy5F9jrPtSc5hn9ulVyu3uL5Io=;
  b=MTWiXcuq8qf0OMdhcZd7BIS6JNOk7uzMf1e2r3d/EwtyxR0zlpR0+Aij
   jEv6AbbHAdOuPx4d+ajWXPuvnHiokDrU7w0VBw8U0PaV4/3fRUF1xz19p
   x/iYisWzSISztm/l9A3SlEdFF3a2GZSDqaTn0kEiAIrDKCEv7ylskJ48G
   VZtmidGHeED+34sll7vHfgsxnXQCFlVwAy3UcEbNLttmMYgCj5Te9Fak2
   MiiiO5xFBJwjtdx5haiD2CR3HxB3MImP996SJ5WRkH7VqKmx2BmC8OYSu
   +frnJFO5ETp/8f0GX6i7EqLuPwxVzF4agwBL2vR21hal4DbY0fLsOKMD+
   g==;
X-CSE-ConnectionGUID: +LbWx/SbRQ2ZpRL2vx1dvg==
X-CSE-MsgGUID: gsd+Q3uuR0aIkUbHXiXj3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3859831"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3859831"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 11:19:38 -0800
X-CSE-ConnectionGUID: fv5QBsuURVmiAxEe1RM5Uw==
X-CSE-MsgGUID: 6V+fZcXVS/uPtpD62EDHAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10618702"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 11:19:37 -0800
Message-ID: <bf360695-18f4-4fa1-8030-6df2471dae60@intel.com>
Date: Wed, 18 Nov 2026 13:19:36 -0600
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
Subject: Re: [PATCH v4 15/21] KVM: x86/pmu: Clamp pmu->version to
 kvm_pmu_cap.version
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-16-zide.chen@intel.com> <av3O9YqD6iW4UT9c@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <av3O9YqD6iW4UT9c@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/2026 10:17 AM, Yosry Ahmed wrote:
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index 5eac64ba8832..0be9956810ae 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> @@ -574,7 +574,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>  	eax.full = entry->eax;
>>  	edx.full = entry->edx;
>>  
>> -	pmu->version = eax.split.version_id;
>> +	pmu->version = min_t(int, eax.split.version_id, kvm_pmu_cap.version);
> 
> Why not AMD too?

On AMD, seems pmu->version is already constrained to kvm_pmu_cap.version:

1. When vPMU is enabled, AMD has no CPUID version field. KVM sets
version to 1, or 2 if guest_cpu_cap_has(PERFMON_V2). Userspace cannot
force version 2 on a v1 host because svm_set_cpu_caps() clears
PERFMON_V2 from kvm_cpu_caps whenever kvm_pmu_cap.version != 2.

2. When vPMU is disabled, kvm_pmu_refresh() sets pmu->version = 0 and
returns before vendor refresh() is called (!vcpu->kvm->arch.enable_pmu).

> 
>>  	if (!pmu->version)
>>  		return;
>>  
>> -- 
>> 2.56.1
>>

