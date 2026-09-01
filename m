Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D793D9DC0;
	Tue,  1 Sep 2026 03:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232137; cv=none; b=Awf2CQVdZjAm22IZGWxW7J7lFhr2HxgjgngMe7Yn1zw1OLA3PKZSSrN62mL55GHPCo1jwmMH9INbIUrW7u7Sg6Z7hViWqirgEOstwEubyylm8iXn/AvJy+azjCHa1GdIGwTvImoPjb772MdhTdymvYc7Q+uV3scmIlfOHV/tH4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232137; c=relaxed/simple;
	bh=iDjZBzHdOIEWE3US+miz1BbbH4gQX386+ehW6sw4idk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCutf6aJ+aH8eemCMaFjyQ+NMzkFDdeB/Wg8l3LCoQsf5VO4t6FkGLg8xB9A0M4okIDdLdP8UUInlMptmhI8yvBC9jkTXFHq6+6NPoZhJ/qsmVUJsDFJVHpNc6JAHCHIO4qP/mCbp/5lP72AQGEp7zqhvuDKwHfHBYSe35PmpK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJhgk1ni; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJhgk1ni"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788232137; x=1819768137;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iDjZBzHdOIEWE3US+miz1BbbH4gQX386+ehW6sw4idk=;
  b=oJhgk1nikTOQesOZx3aV4OMPUZoDspbabJZdI97OVInvD2DoIlApYjpe
   309Tgfoda6b/LWQqCTlb3/SqMWM9r4y0/fLnwBqGF/JI0Z9506Es1y2Qo
   mcP1vpodlnEFqbS9OkQ/ZJJR1bjb3ARK9iBAjye2JhDBP1pvfpNt6ei9v
   +syVEfRUAqUs+n78UIXzg/fCkvGFTp6tePCqTDc7KlNaCmhKbm7FkALJZ
   KesokF1d+q3uRwkJGOeWYciPsW9BGOPXJZBxR52fB/fM2ToWF+xfPrc3r
   R7G6l/+CqwGOlG+lhv7yNet/tNp/3aELDiqJF2Ra8IXnGbL+WQh1GCjdz
   w==;
X-CSE-ConnectionGUID: GFTKTQDSSAGOOVhVUSb55w==
X-CSE-MsgGUID: +xZdgaPpQmmbRJrDnGj7cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88853371"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88853371"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 20:08:56 -0700
X-CSE-ConnectionGUID: pC+PsqAhR7OgyKYzcQSe6w==
X-CSE-MsgGUID: 3IEHxcTdSvCew1oNSRrksg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="267161422"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 20:08:52 -0700
Message-ID: <c5471c76-e4bc-43fb-a2f2-b362fb439b05@linux.intel.com>
Date: Tue, 1 Sep 2026 11:08:50 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] KVM: x86/pmu: Expose kvm_host_pmu to vendor
 modules
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-8-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260827223755.143247-8-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 8/28/2026 6:37 AM, Zide Chen wrote:
> kvm_host_pmu holds the unadulterated host PMU capabilities, which
> can be used to compare against guest capabilities to determine whether
> certain MSRs should be intercepted by KVM.
>
> Exposing it directly avoids the need to introduce per-field accessors,
> which would add boilerplate without hiding any implementation detail
> worth encapsulating.
>
> Opportunistically, fix typo "Unadultered" in the comment.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/kvm/pmu.c | 5 +++--
>  arch/x86/kvm/pmu.h | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index b0fcd0a538d2..7837e2e1af98 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -27,8 +27,9 @@
>  /* This is enough to filter the vast majority of currently defined events. */
>  #define KVM_PMU_EVENT_FILTER_MAX_EVENTS 300
>  
> -/* Unadultered PMU capabilities of the host, i.e. of hardware. */
> -static struct x86_pmu_capability __read_mostly kvm_host_pmu;
> +/* Unadulterated PMU capabilities of the host, i.e. of hardware. */
> +struct x86_pmu_capability __read_mostly kvm_host_pmu;
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_host_pmu);
>  
>  /* KVM's PMU capabilities, i.e. the intersection of KVM and hardware support. */
>  struct x86_pmu_capability __read_mostly kvm_pmu_cap;
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index b7a319b1eccc..9a658ae5b268 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -252,6 +252,7 @@ static inline bool pmc_is_locally_enabled(struct kvm_pmc *pmc)
>  	return !kvm_pmu_call(pmc_is_disabled_in_current_mode)(pmc);
>  }
>  
> +extern struct x86_pmu_capability kvm_host_pmu;
>  extern struct x86_pmu_capability kvm_pmu_cap;
>  
>  void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops);
