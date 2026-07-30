Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB5037E5CD;
	Thu, 30 Jul 2026 02:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379882; cv=none; b=JUlo1pvwZWWdWQB7l7Chxbb7jKjyCHWRUSJVg89Q9n2dOSFM4mqi/94DIZ2DlKYe2lamzNOi1jpJLvWV205r+4JgN+yEskSyob+3y3CpEpV9xFLqxhd36Iz3Tf9i06yblIo5a3arjzAEjUWQtyKocQTNN4eB9ZYhimv3WMKzOOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379882; c=relaxed/simple;
	bh=58BUX/Pc9LVGX59oowWgG9SPbEbBcMJaSGaZjjJTc3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzU8bcIIQ69MEQspYRk5pRfvUPs4qUPF2kTmXdqhHssyNbQqXRmnV0vuzmIb7aEjC17oOccJSd57Pw9SiRae7SLmsdYvTo9nstuN4vQ9wbjk8dSiMTaE7M7kMxOeRsISRhgZjG3u0LUuj14fMYOB4DFKNJOing+aaCSbz/j2Eaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4rnyeYL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4rnyeYL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785379881; x=1816915881;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=58BUX/Pc9LVGX59oowWgG9SPbEbBcMJaSGaZjjJTc3A=;
  b=H4rnyeYL8f5a/Eh/mHE4hhcghKYCsF/Zhtw49d/Mcc1bhhLXvcoXeXBv
   DUyZcC8M8fjdPdFNZDXfZbTgjQVUjV2VqH+A3kEDKzNVNupjsqdh8W205
   6liXR4tBZzNpWRK/3wOu7hiCZxpLMPsEqrb8rgeTxqMz46JFiqkbwiW3Q
   z37uk5HRYRjLXbu0Cpk1SSRPSQAsg2yref/crQoqgADS502JsBnwzKH9u
   jALrJqvWSE1yRN3G5RoNNNBYPiHx1YCzWpw6vvtctLSGh+EfTtFmQI0tv
   0BQo4zcTMmSDXCna17WurJxDuKRIkIEsmNlqRa2QXsrzjza0P1JQaazVn
   Q==;
X-CSE-ConnectionGUID: t+Wa509yTHy9Ad0TRqFdjw==
X-CSE-MsgGUID: kYhGb2rQTiyGyZYy6DYWTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85848296"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="85848296"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 19:51:20 -0700
X-CSE-ConnectionGUID: MKxZhcNeSS+14YAS31UiXg==
X-CSE-MsgGUID: 6kLRLULWRIGSBKbcIQo1Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="258941269"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.178]) ([10.124.241.178])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 19:51:17 -0700
Message-ID: <a6481eb0-0480-41f2-97c3-ab5f278f7e50@linux.intel.com>
Date: Thu, 30 Jul 2026 10:51:15 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/9] KVM: x86/pmu: Restrict RDPMC passthrough to known
 CPUs
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260727192131.582105-1-zide.chen@intel.com>
 <20260727192131.582105-8-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260727192131.582105-8-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/28/2026 3:21 AM, Zide Chen wrote:
> RDPMC type encodings are vendor-defined and could theoretically be
> extended on future CPUs. An unknown RDPMC type could leak host
> PMU information to the guest through RDPMC passthrough.
>
> Rather than assuming future CPUs are safe, explicitly permit only
> reviewed CPU models and require RDPMC interception everywhere else.
> This ensures RDPMC passthrough is enabled only on CPUs whose RDPMC
> encodings are audited and supported by KVM.
>
> Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Suggested-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v7: new patch.
> ---
>  arch/x86/kvm/pmu.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 51c6d00a485f..092809bd757d 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -77,6 +77,21 @@ static const struct x86_cpu_id vmx_pebs_pdist_cpu[] = {
>  	{}
>  };
>  
> +/*
> + * CPUs whose RDPMC encodings have been audited for KVM RDPMC
> + * passthrough support.
> + */
> +static const struct x86_cpu_id kvm_rdpmc_known_cpus[] = {
> +	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X, NULL),
> +	X86_MATCH_VFM(INTEL_LUNARLAKE_M, NULL),
> +	X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
> +	X86_MATCH_VFM(INTEL_NOVALAKE_L, NULL),
> +	X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
> +	X86_MATCH_VFM(INTEL_PANTHERLAKE_R, NULL),
> +	X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
> +	{}
> +};
> +
>  /* NOTE:
>   * - Each perf counter is defined as "struct kvm_pmc";
>   * - There are two types of perf counters: general purpose (gp) and fixed.
> @@ -807,6 +822,20 @@ bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
>  
> +static bool kvm_rdpmc_encoding_supported(void)
> +{
> +	/* KVM understands all RDPMC encodings prior to PMU v6. */
> +	if (kvm_host_pmu.version < 6)

I'm not sure if this works for AMD platforms. Jim said current AMD
platforms already have security holes and I believe the PMU version of AMD
platforms are less than 6.

Need AMD guys to confirm. @Sandipan, @Manali.


> +		return true;
> +
> +	/*
> +	 * Future PMU v6 implementations and future PMU versions require RDPMC
> +	 * interception until their RDPMC encodings are audited and supported
> +	 * by KVM.
> +	 */
> +	return x86_match_cpu(kvm_rdpmc_known_cpus);

x86_match_cpu() returns structure x86_cpu_id pointer or NULL instead of a
boolean variable. Better explicitly covert it to a boolean variable.

return x86_match_cpu(kvm_rdpmc_known_cpus) != NULL;



> +}
> +
>  bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> @@ -818,6 +847,9 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>  	if (enable_vmware_backdoor)
>  		return true;
>  
> +	if (!kvm_rdpmc_encoding_supported())
> +		return true;
> +
>  	return kvm_need_any_pmc_intercept(vcpu) ||
>  	       pmu->counter_bitmask[KVM_PMC_GP] != (BIT_ULL(kvm_host_pmu.bit_width_gp) - 1) ||
>  	       pmu->counter_bitmask[KVM_PMC_FIXED] != (BIT_ULL(kvm_host_pmu.bit_width_fixed) - 1);
