Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139443;
	b=cfmm1S17HlIm11LocOdcrb726XUbnqOO1fQfatLh0XWLPZQrAJJm2X/EV0j5Orbh8+6R
	 lwUZp/VvebvbwmHnE3v6owwKa00njJRetVIQr6G7oXJsz+CZ8gAvgWDrsJo/WhWDn43LU
	 KGWuCiVEZ4KkHlENYyjoLuRircc9MbhqNNMNuxDruAvIWs8n+vztlPVC/UbRzDYwv+/XF
	 htoB44ac8L9PWWJImNF/L+IUJwabT6bZdlM9wjxQHhXA4Doiw2O0GUHDv6y6FcSNcSPZL
	 3nUK+2+vA5b3yKBGUYJAmIc9/7Z7Jz1EgU9R0SMLMiJxeDKe08bzR+ts5WCtsAKHj3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139443;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=hVKAqaRTvpNfMTpi7dY5SePv1YaJkYPG09Yh8+t5E6g=;
	b=L9MP3GZ0ncWcyIOOa0Yh039jpvdJY5LnZ8fBdkYMSfvoXGdaqO5JD2ZSC/H5S140YHsE
	 lxVgitSLfm705lGcTK+qXBeOXe8GFhJkfjM4oL4jrK/zafFIdHJ6QP9VunZhRLGHSCSs7
	 ng8CXxVXa9m61V413inqhibCmJYArgmh0Ipk83QimALWbkEeOzQ7G5I/Pr4SOwk/IaCuI
	 62PEXZXU87hiVA2e2WK5AWANk434MWcUgxjElnOvtKr5aNXCXYYeLX4q71liotHrqEbEx
	 i6XOKzJIgzJOdIvOeHv9Z0EHrLAvfJRhopazMBPY0e0jnTRAcWNnnj/EF+kz/yyD5Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c5lOO0dh;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E60606A31A;
	Tue, 27 Oct 2026 22:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85E60606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c5lOO0dh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793139442; x=1824675442;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zj4/qjYqWfY/IgH0aO3Zs3Tz/TTUh9hv2a6D8fRg+z4=;
  b=c5lOO0dhoI/ez/0CztCVkRQ2D09uSoZoKV04UyICFCM7PGPnsW/L58Th
   hQPCx4vuyU6KNIDEEIyCb5CMUu9lDwebnC4+mrxjPhOCD5hFFyDgw6euU
   wa+ao8sG810I7HtC2gmz5dg9PJ5kKr2FbhZeLfP7+ihJ+7HIdjg7CIYpi
   nc2qaH2W1gTjUq6IOyergTtPwllgbUUTYVODhMt9mmG2aB4inYwhk/4JQ
   zYsVSfaK/Gp5B9JKcWrXNYR9Dhu8amDOanm43wCGALcn0RLh7aiZ8zXZg
   +z9u88d9/FiBkeZ3e4xD1SGF/6Tj97H5ANAZCdVou37ajn7Nlc7tGYYen
   w==;
X-CSE-ConnectionGUID: TFuJ3TqfRKeq+Jui27nMpg==
X-CSE-MsgGUID: /0LtJjkSROWvEJj+XxdO5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1884649"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1884649"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 15:17:21 -0700
X-CSE-ConnectionGUID: CQ0FcGTJQiqczL3CpS4CZg==
X-CSE-MsgGUID: XsUs85n8Rx6h7v+nBAZqGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="5006272"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 15:17:20 -0700
Message-ID: <48d57624-b10c-4548-b082-7fc3fcfbab10@intel.com>
Date: Tue, 27 Oct 2026 17:17:19 -0500
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
Subject: Re: [PATCH v9 12/12] KVM: x86/pmu: Support RDPMC Metrics Clear Mode
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260918193937.569414-1-zide.chen@intel.com>
 <20260918193937.569414-13-zide.chen@intel.com>
 <20261023185544.3305206-1-jmattson@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20261023185544.3305206-1-jmattson@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/23/2026 1:55 PM, Jim Mattson wrote:
> On Fri, Sep 18, 2026 at 12:39 PM Zide Chen <zide.chen@intel.com> wrote:
>>
>> +		pmc = kvm_pmc_idx_to_pmc(pmu, INTEL_PMC_IDX_FIXED_SLOTS);
>> +		if (pmc && intel_pmu_metrics_clear_enabled(pmu)) {
> 
> If kvm_vcpu_has_perf_metrics() requires fixed counter 3 (see my reply
> to 5/12), pmc can't be NULL here.

Agreed. If kvm_vcpu_has_perf_metrics() requires FC3, then the NULL check
can be dropped.

> [...]
> 
>> +	if (perf_capabilities & PERF_CAP_RDPMC_METRICS_CLEAR)
>> +		pmu->fixed_ctr_ctrl_rsvd &=
>> +			~intel_fixed_bits_by_idx(INTEL_FIXED_SLOTS_IDX,
>> +						 INTEL_FIXED_3_METRICS_CLEAR);
> 
> This should be predicated on the guest actually having fixed counter 3
> (and PERF_METRICS). intel_pmu_enable_fixed_counter_bits() only unmasks
> bits for counters below nr_arch_fixed_counters.

Yes, since now FC3 check is added to kvm_vcpu_has_perf_metrics(), then
it makes sense to gate the unmasking on it as well.

> 
> [...]
> 
>> +		if ((data & PERF_CAP_RDPMC_METRICS_CLEAR) &&
>> +		    !(data & PERF_CAP_PERF_METRICS))
>> +			return 1;
> 
> If IA32_FIXED_CTR_CTRL.METRICS_CLEAR_EN[14] is only unmasked when the
> vCPU has PERF_METRICS, is this check still necessary? KVM generally
> doesn't police userspace's feature combinations unless it has to.

Agreed, dropped this check from vmx_set_msr(). Since intel_pmu_refresh()
gates unmasking METRICS_CLEAR_EN on kvm_vcpu_has_perf_metrics(vcpu),
userspace setting RDPMC_METRICS_CLEAR without PERF_METRICS will simply
have no effect and bit 14 remains reserved for the guest.
