Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024760;
	b=auS+d2Wa4mPGpI1NJJQt1KEZwtWAIsSiUlTNlPYk+bRC34IKTVFg1vts9IcSTXkMBcgV
	 vQBvLpJ06PkTVcj0zLWullrKNlAaTmDw9WiVqUtCEs1s8QrxyRxScaP0DQsS9lLjdwhci
	 OntH/XM6xQs5Wt/z5DXYMYWFOl2nGJHk1C7xw3egpXoUWdRLsbcpiRh3W9/Xgo4a61Tir
	 peentbgQ4mNmsP4lrdrBg/P0zA0jdhs0JU7KDD956mW7lNrvFi54belw3ziJ1KcQdPAX3
	 Mi7Iuj8XlcvaWekQNO46CtFzi2CjOkUZV2FfZB3rrFddPup0z500TfMPeDhgFE7i7RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024760;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=DGRSDiSiXmg1RhkyRIvJ8AN3x+kDPNGqOzyxuPI1anc=;
	b=sXUdFYLAXSi+Q1N797UmCA+4tEqT8xvQ6f14j3j9va9nQ5VsrEnLRQl+NnDF6ItmLmxO
	 EvSxkz74orhFEf7/W8urJ0VF+0yRiPSpHvh+nAOWaIovT/s2sMQa4xt9npyZKJEKWl4mM
	 7/z0OXsfX3sKR674LTA5BtjWmHfm3CBWadamRQ4ucEWxh9uifWxNeNn5t00ACvph9WumR
	 KIZ+LC+mcWA68XEdPprQoe9SOXVJXS83Ne+PvDpJdSM7SSh1dMUyFsqVT3/DDrFjEhDSG
	 0FYHPCv3ulBStKZJpvMaa8En2mum7wH54XjNlJFraUiDq9h5j6n5yh9evc++DQ5vLDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="I9TU/8B9";
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADC3606A31C;
	Wed, 18 Nov 2026 17:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ADC3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I9TU/8B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795024759; x=1826560759;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ffcSwicRThrWMuUnpWvaBeJ6yr2eC0e+27MBNjdI5Gc=;
  b=I9TU/8B96ts1xS7R1XssskU+T9Pa1frnhd3RhaZMfs01UUPrNKwbCZCu
   otODU8w4N7EtFO7pGS5WvoBjmuhCVGMBZvw/35VfE1EQnUEzmlE0cYAdT
   WrESF021p3bzL/vyct8GgymWJp0KOwf8TXRdIPgqHDtSAE6xmJoCTMa+S
   snStRmZDskMl4GP9lxi8W7GNF+Hpl8CZTGGSGxzkzNDV6JU1ejTa3FG11
   gV0nRfnor8dRR81rLgjteNHfUBwSjqG9ghDAOeUjT4G5UNt+q5nxGHTTf
   G8tCGjv/Zx/s0IsK4rc39gLtN/4GcMJJBIN1y5SLZ3JNwqtqemGCJh9NY
   g==;
X-CSE-ConnectionGUID: o05N5t8nRKSBcRXJF3eTjQ==
X-CSE-MsgGUID: bX9s41ojT1erEtPdNzf4hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3742393"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3742393"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 09:59:18 -0800
X-CSE-ConnectionGUID: tXu1y5bDQDiw0HdESxN9qA==
X-CSE-MsgGUID: EogwfLjiQc+m9qrhnWXRBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10118703"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 09:59:17 -0800
Message-ID: <349ebbdb-ae84-4145-aefa-1abb53112d23@intel.com>
Date: Wed, 18 Nov 2026 11:59:16 -0600
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
Subject: Re: [PATCH v4 13/21] KVM: x86/pmu: Emulate
 IA32_PERF_GLOBAL_STATUS_SET MSR
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-14-zide.chen@intel.com> <av3OV2p5xvGS8Mqe@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <av3OV2p5xvGS8Mqe@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/2026 10:12 AM, Yosry Ahmed wrote:
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 7ba1a3b38184..bd5954e62080 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -855,6 +855,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
>>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
>>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>>  		msr_info->data = 0;
>>  		break;
>>  	default:
>> @@ -923,6 +924,12 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  		if (!msr_info->host_initiated)
>>  			pmu->global_status &= ~data;
>>  		break;
>> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>> +		if (data & pmu->global_status_rsvd)
>> +			return 1;
>> +		if (!msr_info->host_initiated)
>> +			pmu->global_status |= data;
>> +		break;
> 
> Nit: Perhaps we should follow what MSR_CORE_PERF_GLOBAL_OVF_CTRL does
> and fallthrough, leaving the pmu->global_status update shared with
> MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET.

My bad. Since MSR_CORE_PERF_GLOBAL_STATUS_SET already rejects non-zero
reserved bits, thus 'data & ~pmu->global_status_rsvd` is an effective
no-op for Intel.

I'll update it for v5:

--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -938,10 +938,8 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct
msr_data *msr_info)
                break;
        case MSR_CORE_PERF_GLOBAL_STATUS_SET:
                if (data & pmu->global_status_rsvd)
                        return 1;
-               if (!msr_info->host_initiated)
-                       pmu->global_status |= data;
-               break;
+               fallthrough;
        case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
                if (!msr_info->host_initiated)
                        pmu->global_status |= data &
~pmu->global_status_rsvd;
