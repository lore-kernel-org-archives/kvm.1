Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793315836;
	b=12it0FtYhQ6Tuq1uPuWTxu5yuhvASCkKA4dtamKYEaSnernMgI01PT3/jiCn2J9h18M7
	 25CMULFPxKgqXZz35S+nU3aiKC+dYHad2CkifsmnvyOFxRLd96GHQDPEgOXMOZa1yXAqt
	 hJpCw8LM5S8Y8zLrr2PE5x/LXNVE6WNOwhMVInrrgkzFn6nSZ11tTmRlBWsEY6y3a+fIf
	 UODtTKOYkTfel9A3H35pSZBHLU7s46lDPUtS7zC12Zw521p05/+KSPYSup/IHYEefFXxc
	 mYAmf/ZdH6WuEtP5qAbxlQnDQ04iWojw90RP/PsMSLRm3n5Bv/wAjXyfMVGC/omhvdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793315836;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=xok/BpPd7NDadJx/SSRje3ANsPX9ZHloA237Q8eXqoQ=;
	b=Ka7BXlwlNFFDSdidLAHi44kGAAOOX7Y5/nHrcsqKxOic+MRYGzol+jITgVBPvrpjrBw0
	 x9lXwOlaciTu3MvL3Vc8xI8FPoPZHeuez8Ac2PkVpLifm8AOMONrmwGaTOgY5yBVYq4pN
	 Gx0GGX/yfhe4YL8fBCmuh1gmZNMcPgcMSbU/94pTLnFcuoWAAPq3Pn9oADCS6CmMr/QiK
	 ILwOazQytRrHxG/RR5UFCRC+Uy8ELCDiDR4Iu8ByDapn7YdEZjKaOwcH21xwJUIFg4or8
	 VVqd0PTOiVkPqRXhF4dDDpCLSnqWkdXxHeuJ7Qot+7Cl5/DXS+pbU+IASw1JuIN6ovg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="e/+p9mYr";
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6677606A31A;
	Thu, 29 Oct 2026 23:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6677606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e/+p9mYr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793315835; x=1824851835;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w9QpkakJ8Wmu0OAGZlA/j9n+NfxUs9Z12emCSoi/zHU=;
  b=e/+p9mYrOsaYOz2/nKOk8ek/V1GNs22/qL2Gl+ZbQgkdfnkdpvquLYCy
   tDN+e/mvm7qRqdpScTFqWURBFyxo9v9/8GH0bmSD/KO+32pQ4qC1NbyiJ
   JPjxeE1UkXvt+P/vadeB3RihrQJqi+MT7z87Ly/hWe4K+fyyAVkCzaIMT
   ac+WlV5ZPjXXiBLjxE2J2MHwrEdHYDyMD+t3LQVgjITWY8oNE3g4f40HH
   b1bicBL8j2p3DWhWzVbuwTEtywPXVqrbQ0jvHMSEy16YyRVivKGIzu7NR
   a72IS7bI2n5n5Spe5BRvnroEEHOnhjA+unWggmVcMtyvKtkrlcPviMrB1
   A==;
X-CSE-ConnectionGUID: Dn7VvcctRG2Y8U2Q6vcMwA==
X-CSE-MsgGUID: LAONorfQQnuAE6dLWH78PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1987475"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="1987475"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 16:17:14 -0700
X-CSE-ConnectionGUID: uXrhAEmRSNKwNh9yzvIcWw==
X-CSE-MsgGUID: YybLT/YGTxKzmqHZJmiqZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5404859"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 16:17:13 -0700
Message-ID: <e5e719ec-7012-413c-a446-86fd35aca33d@intel.com>
Date: Thu, 29 Oct 2026 18:17:12 -0500
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
Subject: Re: [PATCH v9 05/12] KVM: x86/pmu: Support PERF_METRICS MSR in
 mediated vPMU
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260918193937.569414-1-zide.chen@intel.com>
 <20260918193937.569414-6-zide.chen@intel.com>
 <CAO9r8zOY8W6s5U8O_tZ3dERA4h+mnWWjeS2GDgF=gbo+CQDNLg@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CAO9r8zOY8W6s5U8O_tZ3dERA4h+mnWWjeS2GDgF=gbo+CQDNLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/29/2026 5:06 PM, Yosry Ahmed wrote:
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 448044a2b121..f4d3801b97bc 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -806,9 +806,16 @@ static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
>>                pmu->nr_arch_fixed_counters != kvm_host_pmu.num_counters_fixed;
>>  }
>>
>> +static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
> 
> The name is confusing, this doesn't control the intercept of
> PERF_METRICS (and it wouldn't be correct to use it for that AFAICT).

Right, these two APIs do not directly determine whether the mentioned
resources need interception:

kvm_need_any_pmc_intercept()
kvm_need_perf_metrics_intercept()

This is different from kvm_need_perf_global_ctrl_intercept() and
kvm_need_rdpmc_intercept().

How about change them to something like these?

kvm_pmu_has_unexposed_pmcs()
kvm_pmu_has_unexposed_perf_metrics()

Or merge them into one single API? kvm_pmu_has_unexposed_resources()

> 
>> +{
>> +       return (kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS) &&
>> +               !kvm_vcpu_has_perf_metrics(vcpu);
>> +}
>>

