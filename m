Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC71285056;
	Tue, 24 Mar 2026 05:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774331294; cv=none; b=b9xFCbQMvEjVjbyCTjoQCAUWR9nlEVhgiMk3RscSxT0798kQANdgbxECiKoD6UqZRtqUC0x5xy0OK9FUT3KO/31xhvOZkpj7jM1GJhijsob5Euc0fBIXjUO4OnHQEEDMMkN6mrjU899FV0mtPQAFVCVxCAZ5k7+LcHtlr8ZL1/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774331294; c=relaxed/simple;
	bh=As52B80lTbmoeyy4ptzr6lYR+jRikxSQWlbVYkmWCnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBCpf7/5vmIjq1XeGXwPhkrS6sUWBKXmr1wiqfA0P3ef4X5p0b8FBwvoRdI7yl6jAuJ4XggxWC7Zn5d3TETm6ciRp7gNGnKKc/22zxpFiiCCx7HTFwOSc0PUQMzS0kGysockiMFZpdbY5ROgSpba60XP0PfbL8g9h1Za7XhhoXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4/Oka+A; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4/Oka+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774331291; x=1805867291;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=As52B80lTbmoeyy4ptzr6lYR+jRikxSQWlbVYkmWCnA=;
  b=e4/Oka+AZU525T7uLoy8yUTTvgKARakAikw4Oil8vH9IRS6geYZla6/E
   BgddgRC3Z2urAzvzQfl/20DoLwjNnDumZ/7gs7RsMFCgPQbExRx8svN8G
   AEmDMNh3gHv9ohUf5bSyTcFQ84l0NOsnIOIPtPBUhlkJX7pEyILcmz3tQ
   EBWKZLnMJr66dflSgIcdyHCegUOEYE1lzNl7fwR+fq+zE1m1gzPYVPoEN
   D2mc0a9YjctelIYWGxaJXxGoJeNhZxF66iCu/uZPgu3kMa2SUeP05nYa7
   8Y8r9IgRPCeQDTb5/kzevLcDlyU9U6Hi335+DIcns0i9UAdMrcrBcZhs9
   A==;
X-CSE-ConnectionGUID: NGUVBlW1RLOdF1Exml+eqQ==
X-CSE-MsgGUID: x26BYnhXRDyskIJM87RjCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="79196896"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="79196896"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 22:48:11 -0700
X-CSE-ConnectionGUID: qOC0pAA4QBqKUBSCkwgxNw==
X-CSE-MsgGUID: Dkl8SLbnR+6rVVCw6JrGOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="225906365"
Received: from unknown (HELO [10.238.0.74]) ([10.238.0.74])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 22:48:07 -0700
Message-ID: <e94e4b40-11e4-4dce-adc7-6a9ce4993480@linux.intel.com>
Date: Tue, 24 Mar 2026 13:48:04 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] KVM: x86/pmu: Do not map fixed counters >= 3 to
 generic perf events
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260226230606.146532-1-zide.chen@intel.com>
 <20260226230606.146532-2-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260226230606.146532-2-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/27/2026 7:06 AM, Zide Chen wrote:
> Only fixed counters 0..2 have matching generic cross-platform
> hardware perf events (INSTRUCTIONS, CPU_CYCLES, REF_CPU_CYCLES).
> Therefore, perf_get_hw_event_config() is only applicable to these
> counters.
>
> KVM does not intend to emulate fixed counters >= 3 on legacy
> (non-mediated) vPMU, while for mediated vPMU, KVM does not care what
> the fixed counter event mappings are.  Therefore, return 0 for their
> eventsel.
>
> Also remove __always_inline as BUILD_BUG_ON() is no longer needed.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 27eb76e6b6a0..4bfd16a9e6c7 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -454,28 +454,30 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   * different perf_event is already utilizing the requested counter, but the end
>   * result is the same (ignoring the fact that using a general purpose counter
>   * will likely exacerbate counter contention).
> - *
> - * Forcibly inlined to allow asserting on @index at build time, and there should
> - * never be more than one user.
>   */
> -static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
> +static u64 intel_get_fixed_pmc_eventsel(unsigned int index)
>  {
>  	const enum perf_hw_id fixed_pmc_perf_ids[] = {
>  		[0] = PERF_COUNT_HW_INSTRUCTIONS,
>  		[1] = PERF_COUNT_HW_CPU_CYCLES,
>  		[2] = PERF_COUNT_HW_REF_CPU_CYCLES,
>  	};
> -	u64 eventsel;
> -
> -	BUILD_BUG_ON(ARRAY_SIZE(fixed_pmc_perf_ids) != KVM_MAX_NR_INTEL_FIXED_COUNTERS);
> -	BUILD_BUG_ON(index >= KVM_MAX_NR_INTEL_FIXED_COUNTERS);
> +	u64 eventsel = 0;

I'm not sure if we can directly add the "slots" event support in the
perf_hw_id list. It looks more straightforward, but it need to involve perf
changes and impact all architectures. Not sure if it's worthy to do it.

Current way is fine for me if we decided not to support the fixed counter 3
for  the legacy emulated vPMU.

Maybe one minor optimization, we can directly return here and then don't
need to add so much indents, e.g.,

if (index >=3)

    return eventsel;


>  
>  	/*
> -	 * Yell if perf reports support for a fixed counter but perf doesn't
> -	 * have a known encoding for the associated general purpose event.
> +	 * Fixed counters 3 and above don't have corresponding generic hardware
> +	 * perf event, and KVM does not intend to emulate them on non-mediated
> +	 * vPMU.
>  	 */
> -	eventsel = perf_get_hw_event_config(fixed_pmc_perf_ids[index]);
> -	WARN_ON_ONCE(!eventsel && index < kvm_pmu_cap.num_counters_fixed);
> +	if (index < 3) {
> +		/*
> +		 * Yell if perf reports support for a fixed counter but perf
> +		 * doesn't have a known encoding for the associated general
> +		 * purpose event.
> +		 */
> +		eventsel = perf_get_hw_event_config(fixed_pmc_perf_ids[index]);
> +		WARN_ON_ONCE(!eventsel && index < kvm_pmu_cap.num_counters_fixed);
> +	}
>  	return eventsel;
>  }
>  
