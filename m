Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFFD40B11F;
	Tue,  1 Sep 2026 02:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228491; cv=none; b=Ftk14gkQEBG/QvuqntRd6Fo7+Nru01z/9CGtjwcc16dqpeDoSfbJxtvNAD5MTnFmEuw0NxTSLyemTJkzhiNc/6Q3GkyTgnYBd3njT2aDdsjOyLDR2mZKfUYhYKyFOXDftmDQxn046ZqgiIzpWXsK1plnNFkID5Neq89vI+rjyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228491; c=relaxed/simple;
	bh=l/Sq94Fmu7C46abyZSECs6jHm3VumgrPDxeenxZTR0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIe5uhemhJ/KI4OoONIblo+rMYmLIeE//vxxlS95WRtm1wqPK1feumojuF54Ro+dRB6picCNu623xKoy5axJWV0mny9EHDMFeW5BZ0CtVivLR05o+9/krWfHUgGpTHXnO3yt0xHwvv8896eCjE5DmFDj53pFgcpYNjKvfEk35Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmCqe6Ih; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmCqe6Ih"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788228487; x=1819764487;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l/Sq94Fmu7C46abyZSECs6jHm3VumgrPDxeenxZTR0Y=;
  b=mmCqe6Ih9S7iJbjq77afPlMzuZYv5FmLfjr51BKmy4IGB+qGRcPkGdCY
   aqKtpuOA7vMCIyBoHYKgD0NcMaMaEo786MAos4Ih2yT87ybRK0B8K7Iea
   vj7KTAIdqsSdzGEcCScLOp1DCuqBbUr6WUZx0GBJXym/PLtzu4F2KVPoR
   IqcqDLY2LPle2q7FUZc+Io7dC89Rg4j3jBvgw7tYFz0qPkD0JTfiAo34Y
   dUWWuZK1z/3rwsZRf+P+WPZIogj8acvI5SK2L29Es99AOLvq1vY3vjngN
   UuiiCJMYTQVT6HyaKkGv9xn/ZPnBqqbF2YmtjAZZAAw3eXO8PuHlmh3jn
   Q==;
X-CSE-ConnectionGUID: /kjVW/rMTO6cKbjcU7RApQ==
X-CSE-MsgGUID: ylHZROxKT1K30sn2oowV/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88572760"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88572760"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 19:08:04 -0700
X-CSE-ConnectionGUID: Jp5FjpOZTYqTqwmQQWFBcA==
X-CSE-MsgGUID: EmvJStCQT8mpVnTECqE+JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="307172084"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 19:08:00 -0700
Message-ID: <686dc0f2-532e-4338-b7b1-4168a1b15f6a@linux.intel.com>
Date: Tue, 1 Sep 2026 10:07:57 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] KVM: x86/pmu: Remove redundant Perf Global
 Status MSR bit definitions
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-2-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260827223755.143247-2-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks for this clean-up. This was what I intended to do for long time. :)

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 8/28/2026 6:37 AM, Zide Chen wrote:
> IA32_PERF_GLOBAL_STATUS and its SET/RESET counterparts share bit
> definitions with perf_event.h, which is the canonical home for Intel
> PMU bit definitions (e.g., PERFEVTSEL, FIXED_CTR_CTRL, GLOBAL_STATUS).
> Drop the duplicate definitions from msr-index.h and update KVM code to
> use the macros from perf_event.h.
>
> Drop the comment as well, since the macros now match the MSR
> naming.
>
> No functional change intended.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/include/asm/msr-index.h |  8 --------
>  arch/x86/kvm/vmx/pmu_intel.c     | 11 ++---------
>  arch/x86/kvm/vmx/vmx.c           |  2 +-
>  3 files changed, 3 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 18c4be75e927..11b99d237e05 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1243,14 +1243,6 @@
>  
>  #define MSR_PERF_METRICS		0x00000329
>  
> -/* PERF_GLOBAL_OVF_CTL bits */
> -#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT	55
> -#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI		(1ULL << MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT)
> -#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF_BIT		62
> -#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF			(1ULL <<  MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF_BIT)
> -#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD_BIT		63
> -#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD			(1ULL << MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD_BIT)
> -
>  /* Geode defined MSRs */
>  #define MSR_GEODE_BUSCONT_CONF0		0x00001900
>  
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index bfa8612fb450..e71ddd51ae56 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -576,17 +576,10 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
>  	pmu->global_ctrl_rsvd = counter_rsvd;
>  
> -	/*
> -	 * GLOBAL_STATUS and GLOBAL_OVF_CONTROL (a.k.a. GLOBAL_STATUS_RESET)
> -	 * share reserved bit definitions.  The kernel just happens to use
> -	 * OVF_CTRL for the names.
> -	 */
>  	pmu->global_status_rsvd = pmu->global_ctrl_rsvd
> -			& ~(MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF |
> -			    MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD);
> +			& ~(GLOBAL_STATUS_BUFFER_OVF | GLOBAL_STATUS_COND_CHG);
>  	if (vmx_pt_mode_is_host_guest())
> -		pmu->global_status_rsvd &=
> -				~MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI;
> +		pmu->global_status_rsvd &= ~GLOBAL_STATUS_TRACE_TOPAPMI;
>  
>  	if (perf_capabilities & PERF_CAP_PEBS_FORMAT) {
>  		if (perf_capabilities & PERF_CAP_PEBS_BASELINE) {
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index e3bfe6aca1a0..d3789b2ee18e 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -8612,7 +8612,7 @@ static unsigned int vmx_handle_intel_pt_intr(void)
>  		return 0;
>  
>  	kvm_make_request(KVM_REQ_PMI, vcpu);
> -	__set_bit(MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT,
> +	__set_bit(GLOBAL_STATUS_TRACE_TOPAPMI_BIT,
>  		  (unsigned long *)&vcpu->arch.pmu.global_status);
>  	return 1;
>  }
