Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214342;
	b=QtJEoGJopyGdtbicoOKOjbiSnHKEkCg+YTMEkptoVSJJsiiRA4rI4OULr2Z3pdnteHtV
	 n1FDGAVUQBemlyigmKFIJHN0BgM4B2GOW46E5HryHx4E6A/OPBoh9AT6KnG+t2sDQQAdA
	 Q208UY9A91z5cHhqzXbSspOvCONC6X7FQgn+ZUmpyEQ0e8Vgx513u/MdRkCIA2Kq6xNcQ
	 FwCA03J+IuJWTS/fJqpl+Xhzz0+6AGJrjoW3UcVg8JBzeqyZKbK9y9/gwexoq6E0DATxf
	 xB49C7ciOdktZ1R9CfkvYdp1HxqHqwL5qZXdhxizC9/x46dmdl65ardHt7Jvr7csEYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214342;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=HM4GuFRiZ6os5mV6f66FJO3C+vTpjnZOmCOCbLh+NG4=;
	b=cAwRkR1QiMZ55TTYnCf5B3NCAuCBJCo+q8dFoRIV9cqxAXHhZQo79ix8A6ZtGaDX4cWt
	 GcRxD6fSp+Fb9dg2/5gFdPDSRbiV211Rb5Acv6T4qDR1yAnSfqbc49CGDC9Nv+RCWNkLR
	 IOiDsVXbZq24DmFGlHuqPWpGylOCMIkYttSYtLLL/MFrcOZ/06nciEblShUaOs79EpguU
	 ERVn31Gl4qQdrVJwCOVO5wW2RsCJpeGeFlFfsmgrPJzAlSApaVp8ccMGgGxNukfwWmhTV
	 h4DbHoErXEPh0u8TfhfZU9TkeVCz3Ia/tItjX/7pmxUAL01CPrD1loKCzwZ2gCD6rLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZJXDHGC9;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628D0606A326;
	Wed, 28 Oct 2026 19:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 628D0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZJXDHGC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793214340; x=1824750340;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V4ZwezyHpLNXEy0NLUQ0oHxywA8tuHw0wlZ8f+3lisA=;
  b=ZJXDHGC9wOi6gF032NJsfu4/SmO1f0GwgQfqCtj690JYEc8VU946+6eL
   4UvQbaj3EqFbSCA6NDCjwxmZkzQG/9zTkRPrnqMKS+B05p5XR0m4SlXRJ
   5MwcmWhAQnNRbXeF6BYNlmJ+PRmBD0uOqh4Cx6RVo/flRnomLoN1/Dan+
   cswaf7kQXBNLgTNZvqhzHoZLzxsxJ6ZlwWkC54QhhJ19zjrIgeNuyGIoz
   xvIaTXAhezhAvM7SHciVcGhChyE39V9xxjW7aP8je+aBZEa8ZKSPybcy8
   C+ztMWTT/dZvaxyYhRvG/5lKiZJ0HHBkGpdYyTS1rJXRB7L4RS0FttgIv
   g==;
X-CSE-ConnectionGUID: C36PxnTXQ7aHv3NzI3m94w==
X-CSE-MsgGUID: wQd7kIDyQHq1qTxGBV/R2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1833824"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1833824"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 12:05:39 -0700
X-CSE-ConnectionGUID: Pfru9TC5QOC3GHhSEoE4IQ==
X-CSE-MsgGUID: 9KnnJ0wjRzOkSUL5eA5+xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="4843441"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 12:05:38 -0700
Message-ID: <3eab289c-d48b-4aa3-a057-63cd3ca662dd@intel.com>
Date: Wed, 28 Oct 2026 14:05:36 -0500
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
Subject: Re: [PATCH v2 04/16] KVM: x86/pmu: Gate BUFFER_OVF reserved bit on
 guest DS
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-5-zide.chen@intel.com>
 <CALMp9eTq-yPoQwwoEFPYLqvLNc_2n-4kGbnZ=x=-ZAJjyOrvnw@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eTq-yPoQwwoEFPYLqvLNc_2n-4kGbnZ=x=-ZAJjyOrvnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/28/2026 9:25 AM, Jim Mattson wrote:
> On Thu, Aug 27, 2026 at 3:49 PM Zide Chen <zide.chen@intel.com> wrote:
>>
>> global_status_rsvd unconditionally clears GLOBAL_STATUS_BUFFER_OVF
>> (bit 62), even when the guest does not have X86_FEATURE_DS feature.
>> Clear it only when guest_cpu_cap_has(vcpu, X86_FEATURE_DS), matching
>> hardware behavior.
>>
>> Fixes: f5132b01386b ("KVM: Expose a version 2 architectural PMU to a guests")
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v2: new patch.
>> ---
>>  arch/x86/kvm/vmx/pmu_intel.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index 11c9161dc853..9fdae437e569 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> @@ -576,8 +576,16 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>                          ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
>>         pmu->global_ctrl_rsvd = counter_rsvd;
>>
>> -       pmu->global_status_rsvd = pmu->global_ctrl_rsvd
>> -                       & ~(GLOBAL_STATUS_BUFFER_OVF | GLOBAL_STATUS_COND_CHG);
>> +       /*
>> +        * Layout of bits 48:0 in IA32_PERF_GLOBAL_CTRL is identical to
>> +        * IA32_PERF_GLOBAL_STATUS, but IA32_PERF_GLOBAL_STATUS has additional
>> +        * bits.
>> +        */
>> +       pmu->global_status_rsvd = pmu->global_ctrl_rsvd;
>> +       if (guest_cpu_cap_has(vcpu, X86_FEATURE_DS))
>> +               pmu->global_status_rsvd &= ~GLOBAL_STATUS_BUFFER_OVF;
> 
> According to Intel SDM Vol. 4, Table 2-2 ("IA-32 Architectural MSRs"), bit
> 62 (OvfBuf / ClrOvfBuf) in IA32_PERF_GLOBAL_STATUS (0x38e) and
> IA32_PERF_GLOBAL_STATUS_RESET (0x390) is supported "If CPUID.0AH:EAX[7:0] >
> 0", and bit 62 (Set OvfBuf) in IA32_PERF_GLOBAL_STATUS_SET (0x391) is
> supported "If CPUID.0AH:EAX[7:0] > 3". Though it makes some sense, a
> dependency on CPUID.01H:EDX.DS[bit 21] is not documented in the SDM.
> 
> In mediated PMU mode, vmx_pebs_supported() is false, so KVM clears
> X86_FEATURE_DS for mediated PMU guests. However, when PMU global controls
> don't have to be intercepted, MSR_CORE_PERF_GLOBAL_STATUS,
> MSR_CORE_PERF_GLOBAL_OVF_CTRL, and MSR_CORE_PERF_GLOBAL_STATUS_SET are
> passed through directly to the guest. Hardware certainly allows bit 62 to
> be written to IA32_PERF_GLOBAL_OVF_CTRL or IA32_PERF_GLOBAL_STATUS_SET.
> 
> If a guest sets bit 62 in hardware via IA32_PERF_GLOBAL_STATUS_SET,
> intel_mediated_pmu_put() will save bit 62 into pmu->global_status, and
> subsequent KVM_SET_MSRS(MSR_CORE_PERF_GLOBAL_STATUS) or intercepted writes
> to MSR_CORE_PERF_GLOBAL_OVF_CTRL will fail the pmu->global_status_rsvd
> check.
> 
> Essentially, this means that we can't pass through the PMU global controls
> unless their reserved bits match hardware.

Thanks for bringing this up. This patch should be dropped.
