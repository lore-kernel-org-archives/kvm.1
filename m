Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019054502F;
	Fri, 31 Jul 2026 01:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460336; cv=none; b=FnfUPlRt/Py1pKrUgf4HTxUSEzBacszlFZaS/zq1AkmCYyxs5hehfRAHltM5EKb2+XiDS7WoSrekm48kmUJdXp3Fm1doQv4m74G3a5xO8F/u664srzpXL2PwFvD2hSTAnvLnwsLd0rZgRsxVKbaieZ85dM8S7qnVxOGFC7q/OO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460336; c=relaxed/simple;
	bh=/A/sBe8U2tBnDXUTAEyxeTMj76MLGKutst30t8p6+sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaygTlblDeQsiJc0jrKeHKx3aAD+PISrYM7vsUc8dSu5vVlDSfDy5AJJVYQROZsYudAxcQS1j/Mubq7WjAxW2vfe4QyPCWB/b3OAwW8R7fY8nXMxTFQhRe1Imqx368g9oroc4Uexj/l07X4i+Vyn+HPQKhL1pg2XlVRkd3wsEFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCGPhY1t; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCGPhY1t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785460334; x=1816996334;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/A/sBe8U2tBnDXUTAEyxeTMj76MLGKutst30t8p6+sQ=;
  b=oCGPhY1t4XukWpni/eNVrSts6dSxsdU05NgNnSOnjni1mfcXSeC18wUV
   Jy7LwaKJGtxWdSPpULOMhE9KPVCtLhaxvI9JLoa6J85LAyZX5ZZM6/Cr6
   yj9Mo8aq0TBsjNlMcXXmt1v1eGJcJk/E5paOFoYkaSgV5l0tWUHGtzsIq
   j1hqYzGKiOd98oEjrXiZjxnigRmySxWgHKjPEkK8CSZL/g0nbOKRGdjyc
   gpLNajglzxDKVoRQgCcOxp6d7+fILn1rhYePlRuQ40G6QY8ClGUMF4W+l
   4tnWs9wFoc5Jyq/CJw5QfznSOH/61Ef8Fk7ojSlRbyfOdpHGY1LJrxuJu
   Q==;
X-CSE-ConnectionGUID: jYd5YQh4SdOvLmFfOQIX9g==
X-CSE-MsgGUID: WeJxaMw5Qzi3Vrn+BanUAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96446997"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="96446997"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 18:12:13 -0700
X-CSE-ConnectionGUID: /iOTrlauQmOKMn9ewMquCg==
X-CSE-MsgGUID: t4J7j4pxTcud4yQjx7mzSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="258661137"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 18:12:10 -0700
Message-ID: <a3fd76f2-96cd-4d56-8a58-f86b2270c56e@linux.intel.com>
Date: Fri, 31 Jul 2026 09:12:09 +0800
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

Zide, it seems this list is incomplete. The
DMR/ARL(INTEL_ARROWLAKE/INTEL_ARROWLAKE_H) should be secure as well. Thanks.


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
> +		return true;
> +
> +	/*
> +	 * Future PMU v6 implementations and future PMU versions require RDPMC
> +	 * interception until their RDPMC encodings are audited and supported
> +	 * by KVM.
> +	 */
> +	return x86_match_cpu(kvm_rdpmc_known_cpus);
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
