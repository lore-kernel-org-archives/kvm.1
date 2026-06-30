Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173881A683E;
	Tue, 30 Jun 2026 02:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782785976; cv=none; b=Fzua2Fny4Ts39YkQ2oGfqKtG0A0Iv/8k93nho1O4GyCJq2YAKgpoLtEXJxhQBWXuQfwKUXB6EzKghPSdE3eoGlOqkm3+hHafKJursQPkh0WHYKrNekth4tu89YMxx3OkR4RJhTakxqeaBT2yj7lad+mAM1/EZlp0Tcpb90pvKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782785976; c=relaxed/simple;
	bh=KFlbNmrHfk3XcK2LGVg7cxvrBLxjh1xfNfTIbEqDAjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haHiIqXJZ7Q5an8JVc25pL9GsZY4OCA0wZYnCQRzPeTbnd4PjSbvdSkZi1MvxlLmePpzeFnEaa0LlV+sOSysDI3USzwEAd14RASwQExEWB8/UL+wegxqmiFxrXgJ2blebNGXXr8DDNBBxA+ZRVITCAnuY5cr5Jh0DbIR0QXWeBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKreFTjI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKreFTjI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782785975; x=1814321975;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KFlbNmrHfk3XcK2LGVg7cxvrBLxjh1xfNfTIbEqDAjg=;
  b=ZKreFTjIFy/BA1x/9ReOer5pUDagXwQt9s54fa6rG96jt9MbhvpFWTbQ
   BCyhMxONjSmobGKqgc0SsbhciqH/hcTkeXHvhpsso7ZaYAjErRPa2kV2a
   wDqOB+MPN/KdPr0IlPFDenBssdhwvDwYj2KxPMnyxSk7rmYkiXf47zcBr
   mP9VQA9d09lVZr+eRZ6sIbvV42koyqbF8X6Sa+jgfDC4+nXpEcuxzpfna
   3UrhjXaNuo+gL0215Si4w/EFcUoEBsGDpSIg9qj9+1qSxDn0l/QWjfPSM
   RxkS3WcT/InN0j7anu/roemSrcWNWVU2IZa5qCVL4saSztJ0iSxHMfIOu
   g==;
X-CSE-ConnectionGUID: VPk+iYG6TSyq1F9aJPtWiQ==
X-CSE-MsgGUID: Xm3tdSD5T6es1yKVthdgZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83489357"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="83489357"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:19:34 -0700
X-CSE-ConnectionGUID: vVrurESgQJqFukjyfeyZtg==
X-CSE-MsgGUID: OeGpE3rVRC2VmxqVB1atQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="252270232"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:19:32 -0700
Message-ID: <82a6fffa-3fac-4444-806b-536b3a98c9f0@linux.intel.com>
Date: Tue, 30 Jun 2026 10:19:29 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] KVM: x86/pmu: Snapshot host IA32_PERF_CAPABILITIES
 in kvm_host
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
 <20260629231938.15129-5-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260629231938.15129-5-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 6/30/2026 7:19 AM, Zide Chen wrote:
> From: Mingwei Zhang <mizhang@google.com>
>
> Cache the unadulterated snapshot of perf_capabilities so that KVM can
> compare guest vPMU capabilities against raw hardware capabilities.
>
> For example, if the host supports PERF_METRICS but it is not configured
> for the guest, KVM can use it to determine that RDPMC accesses must be
> intercepted.
>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v5: new patch.
> ---
>  arch/x86/include/asm/kvm_host.h | 1 +
>  arch/x86/kvm/vmx/vmx.c          | 8 ++------
>  arch/x86/kvm/x86.c              | 4 ++++
>  3 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index dc9e4e8bfc07..80f638588bf7 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -347,6 +347,7 @@ struct kvm_host_values {
>  	u64 xss;
>  	u64 s_cet;
>  	u64 arch_capabilities;
> +	u64 perf_capabilities;
>  };
>  extern struct kvm_host_values kvm_host;
>  
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index aded7039bd3e..b736b9ff965b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -8050,14 +8050,10 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  static __init u64 vmx_get_perf_capabilities(void)
>  {
>  	u64 perf_cap = PERF_CAP_FW_WRITES;
> -	u64 host_perf_cap = 0;
>  
>  	if (!enable_pmu)
>  		return 0;
>  
> -	if (boot_cpu_has(X86_FEATURE_PDCM))
> -		rdmsrq(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
> -
>  	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR) &&
>  	    !enable_mediated_pmu) {
>  		x86_perf_get_lbr(&vmx_lbr_caps);
> @@ -8070,11 +8066,11 @@ static __init u64 vmx_get_perf_capabilities(void)
>  		if (!vmx_lbr_caps.has_callstack)
>  			memset(&vmx_lbr_caps, 0, sizeof(vmx_lbr_caps));
>  		else if (vmx_lbr_caps.nr)
> -			perf_cap |= host_perf_cap & PERF_CAP_LBR_FMT;
> +			perf_cap |= kvm_host.perf_capabilities & PERF_CAP_LBR_FMT;
>  	}
>  
>  	if (vmx_pebs_supported()) {
> -		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;
> +		perf_cap |= kvm_host.perf_capabilities & PERF_CAP_PEBS_MASK;
>  
>  		/*
>  		 * Disallow adaptive PEBS as it is functionally broken, can be
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 8dbc0fa302a8..8e775855f9be 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7032,6 +7032,10 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
>  	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
>  		rdmsrq(MSR_IA32_ARCH_CAPABILITIES, kvm_host.arch_capabilities);
>  
> +	if (boot_cpu_has(X86_FEATURE_PDCM))
> +		rdmsrq_safe(MSR_IA32_PERF_CAPABILITIES,
> +			    &kvm_host.perf_capabilities);
> +
>  	WARN_ON_ONCE(kvm_nr_uret_msrs);
>  
>  	r = ops->hardware_setup();
