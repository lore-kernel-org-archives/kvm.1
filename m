Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D6A3AC0CD;
	Mon, 21 Sep 2026 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974376; cv=none; b=WxK1+cXCljGj0+zXyMX0wfmMS/X/VDqmz5hlOTc8Hs9gWAj6umup4jJuGEi6W306DxlCga2AaonrxO+nakmRJdPTQAOri6nGtyXLB6ji1ESp7qGzMXl2i2hUdgIaJw/ZUyr9ZHRgYk5hU3eQJYOc/FRf5Z/fkLc85W4HTIC14PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974376; c=relaxed/simple;
	bh=/5m4aZ65LSN4IxjKX08SXAMvhKoumaooVWqP8+wIShc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2DD2/OlzS5FWyj2ndo5ImlBTTbnss+7aDIt2H07hyp5kLaz3EaFcxMN/fYelxjjdjR6kdnfVPZN0vu/PNjU2BEDTpzGPyni9KaRoeOAZHbyb6GUp1Q2igFt9ewD+hQzDkTI+IQqg2ElQwyx1IlfE/EvG6wKa8ca/Q33NX6kMs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eD4SlotA; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eD4SlotA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789974375; x=1821510375;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/5m4aZ65LSN4IxjKX08SXAMvhKoumaooVWqP8+wIShc=;
  b=eD4SlotA4p6rlRj8pOy1Q9fNgCr7mIljozRMAGVubNSIqxyTEC1SYYTP
   WMjOSJ/IDn+bLeS5FnlXWH678o8xWt0SUPeiA+7sHyFKaKHBbtz4CkNKd
   6xMIlx5elwV8mnD0P/lp685UIDPd0NjeEVNJj94oqq1Qexr1NUMtnmcve
   OsUodfuJCTC0g45wfSZKEHXfx4THV388pMX2Ze5MFai5ZlsxdQ1MZw+Pe
   HR2ONP1Ue82DCKrg6aJ4xMxMZ7wyNbNXDqqD508lvq2aPyTkQRGTco+Zf
   4Wp/GfxnFSMZFMlFtnajo0vK8RxZzDvlH7m0MHryJZ0vYG7S/yehrb88m
   Q==;
X-CSE-ConnectionGUID: oJv9ss7TTqCaOIiVGLNPfQ==
X-CSE-MsgGUID: WiDlbllVTgqANkrNaixB6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="90485952"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="90485952"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 00:06:14 -0700
X-CSE-ConnectionGUID: bNJQaRoSQtaGEKTvysCowQ==
X-CSE-MsgGUID: 9dwpuAJhQgSfjSLJTMuWYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3831815"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 00:06:11 -0700
Message-ID: <76c44332-2a6d-479f-aaf6-fab08e4cb60b@linux.intel.com>
Date: Mon, 21 Sep 2026 15:06:08 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/12] perf/x86: Expose number of Topdown metric events
 to KVM
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260918193937.569414-1-zide.chen@intel.com>
 <20260918193937.569414-11-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260918193937.569414-11-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 9/19/2026 3:39 AM, Zide Chen wrote:
> The number of Topdown metric events varies by CPU: ICL/TGL/RKL
> support 4, while SPR/GNR/DMR and some hybrid CPUs support 8.
>
> Add num_topdown_events to struct x86_pmu_capability and populate it
> in perf_get_x86_pmu_capability() so that KVM can determine how many
> PERF_METRICS fields are valid on the host CPU and correctly identify
> the reserved bits in IA32_PERF_METRICS.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
> v9: new patch
> ---
>  arch/x86/events/core.c            | 1 +
>  arch/x86/include/asm/perf_event.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 8b3ea0adb965..01c1c9447f30 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -3164,6 +3164,7 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
>  	cap->events_mask_len	= x86_pmu.events_mask_len;
>  	cap->pebs_ept		= x86_pmu.pebs_ept;
>  	cap->mediated		= !!(pmu.capabilities & PERF_PMU_CAP_MEDIATED_VPMU);
> +	cap->num_topdown_events	= x86_pmu.num_topdown_events;
>  }
>  EXPORT_SYMBOL_FOR_KVM(perf_get_x86_pmu_capability);
>  
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index ceb6188e5217..3c02389b2ea6 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -306,6 +306,7 @@ struct x86_pmu_capability {
>  	int		bit_width_fixed;
>  	unsigned int	events_mask;
>  	int		events_mask_len;
> +	int		num_topdown_events;
>  	unsigned int	pebs_ept	:1;
>  	unsigned int	mediated	:1;
>  };
