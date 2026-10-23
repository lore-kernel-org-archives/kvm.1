Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792742855;
	b=PYtgdK874xrF8ZpY+6JRxzl9sgVuI25r6N8IeabqlkcycusMkM8zjPEylKj4u/0r7krz
	 ogslcp6NZGFUQukfFymFmPhdObcTlf3IRCiY1YjtwHMB08K/PC3/ZqVICO+sPuXYXUkGY
	 UVqzj5aSiBZDnuXzD85JEXAftm4pz0rMkkRU0nBg/3/lMtWw9hlfD4dMtqpn7RR3yhWXy
	 N2ncs2Hn3eUXYpVtbmDiXBOFmL5BfQ3beC3Vb/VUySZ1LxK63iB7ZppYbKuJ5n8cmMQ5y
	 zGkTfrmbk8rdEMvlA/Hbsaco2uMYLH/Bu56TI38tNgaud6mwmivT4cKGwKZT4b7eyvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742855;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=jlN5MG4Fpgy30J3ONiXbjfBzcc96GEsJO9KiHqanrNc=;
	b=S/svUH1gI53Zmb9m+JmFnchTZ1u54XQU3LqVTdEInO/toFqgBdru8ancvsoVS4F7NKD1
	 jbEbVHy07r0xoDfi09Z/tmyWKeLGzM9BKnKCYQjxBtc6RQ5JFau0ILuEj49HE/NWzyLxl
	 Al+N10tHUQ5lSvLA4H9uP2qbLVRl5i93BTbvxZFBRFPNYDrAAkcdg7lHMK7GhurY2o3Em
	 E/qj/jJj4NDbX8IjTpNsKOW2cFxq0NS64/lYwurzopYon+UWOolbqnG+BV2oWjwK7OvcY
	 TN5X+yqso8L7cf3ULfuXAWour/kS8Iu2A/kOm1PkI4Nqkkb7NlpzOU6VC4t5152NCRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DpURiec6;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0A9606A31A;
	Fri, 23 Oct 2026 08:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B0A9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DpURiec6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792742855; x=1824278855;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CvtKOm7DSnSzUQs/e7a7HvEGVAGsSOGL+2qDB/eNTPA=;
  b=DpURiec67uyQ7cQlxbaIBo+Z/78rA3Ch7H8HXb2IKOh7y8EvdAt4wO6H
   7MUjIt/obXIyOO3qK/2jJofOLBGzg6+n0iJMhn4dN38wvEDZGdImHWmpb
   +fKYN6fYpX+SLYAnGyNzW/69QNaYB8VTX7K+bhqb/8lD6NN3p5zHcQf4m
   5xeUoXE0T8sAC5Wu/Muh6p7l13m/0DNgvxYmve7oqHmOCLIGMINecxzk3
   nM1PeJ2ncu32NefaLm9zKjW1G1uumM+vCo+sxidt4ScBOdvlSEXN+gz3U
   yA+SkotWihOwuiP2KeZBw2eJKgH2Wnqh9ndg6n1Rbn3hBveHO3APN0ktq
   Q==;
X-CSE-ConnectionGUID: Flfobat7TnWuGUopiArr1g==
X-CSE-MsgGUID: 7dsmwzHMROW+0TvDocVpIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1384441"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1384441"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 01:07:34 -0700
X-CSE-ConnectionGUID: 6RC7x1WoTJqwCd5/PXyqVg==
X-CSE-MsgGUID: R7R2Qnn6TimF020oZDzjDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3645708"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 01:07:29 -0700
Message-ID: <c596a758-2440-4a30-b124-07f9b978d05e@linux.intel.com>
Date: Fri, 23 Oct 2026 16:07:26 +0800
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
Subject: Re: [PATCH v10 08/28] KVM: VMX: Set FRED MSR intercepts
To: Sohil Mehta <sohil.mehta@intel.com>, kvm@vger.kernel.org, x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Shivansh Dhiman <shivansh.dhiman@amd.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>,
 David Matlack <dmatlack@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-9-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-9-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> On a userspace MSR filter change, set FRED MSR intercepts.
> 
> Because the following eight FRED MSRs,
>         MSR_IA32_FRED_RSP[123], MSR_IA32_FRED_STKLVLS,
>         MSR_IA32_FRED_SSP[123], MSR_IA32_FRED_CONFIG,
> are used by the kernel itself to take an exception at any time, they
> should be context-switched by Intel VT-x automatically in order to
> preserve the FRED architectural invariant that there should NEVER be
> a "gap" during which it is unsafe to take an exception.
> 
> KVM leverages Intel VT-x hardware to automatically context switch the
> eight FRED MSRs using:
> 
>   1) Dedicated host and guest VMCS fields for each MSR.
> 
>   2) VM-entry/exit controls to manage the automated loading and saving
>      of the eight FRED MSRs.
> 
> Consequently, passing these MSRs through to the guest would only add
                  ^
"passing" or "intercepting"?
The sentence says "... add unnecessary handling code without benefit"

> unnecessary handling code without benefit.
> 
> Both MSR_IA32_FRED_RSP0 and MSR_IA32_FRED_SSP0 (aka MSR_IA32_PL0_SSP)
> are dedicated for userspace event delivery, IOW they are NOT used in
> any kernel event delivery and the execution of ERETS.  Thus KVM can
> run safely with guest values in the two MSRs.  As a result, save and
> restore of their guest values are deferred until vCPU context switch,
> Host MSR_IA32_FRED_RSP0 is restored upon returning to userspace, and
> Host MSR_IA32_PL0_SSP is managed with XRSTORS/XSAVES.
> 
> MSR_IA32_PL0_SSP (aka MSR_IA32_FRED_SSP0) is part of CET supervisor
> state, but all four FRED SSP MSRs are architecturally visible on any
> processor that enumerates FRED.  Even if CET is absent, these MSRs
> remain accessible via RDMSR/WRMSR, though FRED transitions will not
> use them.
> 
> Intercept MSR_IA32_PL0_SSP if CET shadow stacks are unsupported (even
> with FRED present).  Since this MSR is rarely accessed and ignored by
> XSAVES in this configuration, interception avoids the overhead of
> manually context switching the hardware MSR during vcpu_load/put.
> 
> This behavior is consistent with the current setup in
> vmx_recalc_msr_intercepts(), so no change is needed to the interception
> logic for MSR_IA32_PL0_SSP.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> v10:
>  - Improve the commit message and code comment with an explanation
>    from hpa (Chao Gao and Dave Hansen).
> ---
>  arch/x86/kvm/vmx/vmx.c | 67 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index dc80ca5f804d..09bbbc680aa7 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4304,6 +4304,72 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>  				  MSR_TYPE_RW, intercept);
>  }
>  
> +static void vmx_set_intercept_for_fred_msr(struct kvm_vcpu *vcpu)

Nit:
Maybe follow the name of the function above, i.e. vmx_recalc_xxx_intercepts().
vmx_recalc_fred_msr_intercepts()?

> +{
> +	bool intercept = !guest_cpu_cap_has(vcpu, X86_FEATURE_FRED);

This assignment could be moved after the check below.

> +
> +	if (!kvm_cpu_cap_has(X86_FEATURE_FRED))
> +		return;
> +
> +	/*
> +	 * Because the following eight FRED MSRs,
> +	 * 	MSR_IA32_FRED_RSP[123], MSR_IA32_FRED_STKLVLS,
> +	 * 	MSR_IA32_FRED_SSP[123], MSR_IA32_FRED_CONFIG,
> +	 * are used by the kernel itself to take an exception at any time, they
> +	 * should be context-switched by Intel VT-x automatically in order to
> +	 * preserve the FRED architectural invariant that there should NEVER be
> +	 * a "gap" during which it is unsafe to take an exception.
> +	 *
> +	 * KVM leverages Intel VT-x hardware to automatically context switch the
> +	 * eight FRED MSRs using:
> +	 *
> +	 *   1) Dedicated host and guest VMCS fields for each MSR.
> +	 *
> +	 *   2) VM-entry/exit controls to manage the automated loading and saving
> +	 *      of the eight FRED MSRs.
> +	 *
> +	 * Consequently, passing these MSRs through to the guest would only add
                           ^
Ditto.> +	 * unnecessary handling code without benefit.
> +	 */


I am not sure whether it needs to repeats the changelog almost the same description.
But I see the version history mentions it was suggested by Dave and Chao?

Can this be just a summary instead?


> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP1, MSR_TYPE_RW, intercept);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP2, MSR_TYPE_RW, intercept);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP3, MSR_TYPE_RW, intercept);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_STKLVLS, MSR_TYPE_RW, intercept);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP1, MSR_TYPE_RW, intercept);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP2, MSR_TYPE_RW, intercept);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP3, MSR_TYPE_RW, intercept);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_CONFIG, MSR_TYPE_RW, intercept);
> +
> +	/*
> +	 * MSR_IA32_FRED_RSP0 and MSR_IA32_PL0_SSP (aka MSR_IA32_FRED_SSP0) are
> +	 * designed for event delivery while executing in userspace.  Since KVM
> +	 * operates entirely in kernel mode (CPL is always 0 after any VM exit),
> +	 * it can safely retain and operate with guest-defined values for these
> +	 * MSRs.
> +	 *
> +	 * Disabling interception of the two MSRs offers two advantages:
> +	 *   1) Simplicity: Eliminates dedicated MSR handling code.
> +	 *   2) Performance: Avoids frequent VM-exits since the two MSRs are
> +	 *      per user thread variables and frequently accessed.
> +	 *
> +	 * MSR_IA32_PL0_SSP (aka MSR_IA32_FRED_SSP0) is part of CET supervisor
> +	 * state, but all four FRED SSP MSRs are architecturally visible on any
> +	 * processor that enumerates FRED.  Even if CET is absent, these MSRs
> +	 * remain accessible via RDMSR/WRMSR, though FRED transitions will not
> +	 * use them.
> +	 *
> +	 * Intercept MSR_IA32_PL0_SSP if CET shadow stacks are unsupported (even
> +	 * with FRED present).  Since this MSR is rarely accessed and ignored by
> +	 * XSAVES in this configuration, interception avoids the overhead of
> +	 * manually context switching the hardware MSR during vcpu_load/put.
> +	 *
> +	 * This behavior is consistent with the current setup in
> +	 * vmx_recalc_msr_intercepts(), so no change is needed to the interception
> +	 * logic for MSR_IA32_PL0_SSP.
> +	 */
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP0, MSR_TYPE_RW, intercept);
> +}
> +
>  static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
>  {
>  	bool intercept;
> @@ -4371,6 +4437,7 @@ static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
>  	}
>  
>  	vmx_recalc_pmu_msr_intercepts(vcpu);
> +	vmx_set_intercept_for_fred_msr(vcpu);
>  
>  	/*
>  	 * x2APIC and LBR MSR intercepts are modified on-demand and cannot be

