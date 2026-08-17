Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2583E36493F
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 22:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004134; cv=none; b=SCUTgqUmfIFLlfGgcDUqnLaLqwjWL5wfyO4pVYjIO7r8A2hlXKOOprjwVUuqcJNhgv4yUJ4UsCSjEMvS8TLcvFKOCX3Zh+ZWqMzRLaZcxk/1Wgcgf98CisoV20X8iS+5qZWLBb8LrseNUVvxyaiOseHEHv5A1HX/cWvDqfn2TD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004134; c=relaxed/simple;
	bh=THRwhNgoHKlx8frnlgZw6iu5m7tC2AiyOaNC8QnYzl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVp/yoT+XSZC/KX60rDTgkEs5dPq4oEXRHB24K/PKLh+9Ibc/4Tm4iMIsvK+XaTNLXfSe2WdV7rzbHwgCtnz7AKepLYq2I4wwlS5tZUIBdkKfFgM/AGjOVXrklDPB/gnGDaTV7+7E9rd4/tLelitDj2KfyOEf1aUVzM6f4aB8oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7lF9Gfh; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7lF9Gfh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787004132; x=1818540132;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=THRwhNgoHKlx8frnlgZw6iu5m7tC2AiyOaNC8QnYzl0=;
  b=O7lF9Gfhri1u0ZHK3d8H1k1FhVg4W5xrQlq2pbuxfqftiJCoB7JcDPFn
   rxwQ/y3yFnywf1XPN6Vuh96QRfPtm8HyTPtNyM45g/45zHMpnhrN9uVyg
   ttVnXc1XsWlPXLtPY+xMV9fUDGNQVsVOjfMVUOrdBR4Ju6fi727njMxX3
   aiUPgCnrwgiIKuupKA6xm2jsQk2cBwI2XZYL5+J0TWqkAzJ3VkdXD/KXd
   Uevg++3UIDXdYfm7k+qh+KP3QHjBjjngx1G5bWYlwlnSKahKuYACWnRPP
   maqVIOT492/XXmemyuhuke+Z6B/KtLyOrbdhb2lu8l2mj6Mp9phKvgCRN
   A==;
X-CSE-ConnectionGUID: 7fZTWeuXRmyUFb7FpJwnHg==
X-CSE-MsgGUID: zhQN+VzRRZWfsrWrlU5zww==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87251319"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="87251319"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 15:02:12 -0700
X-CSE-ConnectionGUID: 3cR827NKQbO/4RchCB7wcA==
X-CSE-MsgGUID: J4ciT969TripajK4DUTbyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="265072386"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 15:02:12 -0700
Message-ID: <0e1d1bd5-8cc1-4381-8a73-f14bea7789e4@intel.com>
Date: Mon, 17 Aug 2026 17:02:10 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/8] KVM: x86/pmu: Emulate RDPMC on performance metrics
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260817183143.226156-1-zide.chen@intel.com>
 <20260817183143.226156-8-zide.chen@intel.com>
 <20260817190135.4AF511F00A3A@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260817190135.4AF511F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/17/2026 2:01 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Metrics Clear Mode is not emulated, causing guest application crashes (#GP) when RDPMC is intercepted.
> --
> 
> --- Patch [7]: [PATCH v8 7/8] KVM: x86/pmu: Emulate RDPMC on performance metrics ---
> commit 5022d9b3f098d7ca5a383495c52fb9e9c119df3b
> Author: Zide Chen <zide.chen@intel.com>
> 
> KVM: x86/pmu: Emulate RDPMC on performance metrics
> 
> This commit adds emulation for RDPMC performance metrics when RDPMC
> interception is enabled. It handles type 0x2000 but skips Metrics Clear Mode
> for simplicity.
> 
> [ ... ]
> 
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index bbf4afcffafc8..3ca61e4b0ba68 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> [ ... ]
>> @@ -125,6 +126,19 @@ static int intel_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx,
>>  		counters = pmu->gp_counters;
>>  		num_counters = pmu->nr_arch_gp_counters;
>>  		break;
>> +	case INTEL_RDPMC_METRICS:
>> +		if (!kvm_vcpu_has_perf_metrics(vcpu))
>> +			return 1;
>> +
>> +		/*
>> +		 * The index in ECX[15:0] is implementation specific, but no
>> +		 * platform currently supports a non-zero index.
>> +		 */
>> +		if (idx)
>> +			return 1;
>> +
>> +		*data = pmu->perf_metrics;
>> +		return 0;
>>  	default:
>>  		return 1;
> 
> [Severity: Medium]
> The commit message notes that Metrics Clear Mode is not supported for
> simplicity. However, if a guest application uses Metrics Clear Mode (setting
> bit 16 in ECX, making the type 0x20010000), it will fall through to this
> default case since it doesn't match INTEL_RDPMC_METRICS.
> 
> Returning 1 here causes KVM to inject a #GP. Does this cause unexpected
> crashes (like a SIGSEGV) for unprivileged guest userspace applications that
> legitimately try to use this architecturally valid mode when RDPMC is
> intercepted?

This is a false positive. Setting bit 16 in ECX is not indicating
Metrics Clear mode. Whether or not clear metrics, depends on
IA32_FIXED_CTR_CTRL.METRICS_CLEAR_EN[bit 14].

BTW, IA32_PERF_CAPABILITIES.RDPMC_METRICS_CLEAR[bit 19] is not exposed.
>>  	}
> 

