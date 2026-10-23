Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740008;
	b=2gmXX57jcZ+MoBdH9PisqgWk7ljZszPUJBpAVSnRZ+NF09HyRb1gjbU5IVbZhmG0jf+N
	 LwfiBBLtbXncoMu8//6Y3gY9NvQuuLhgc3WuV3ma08iDubMJwy3+jXodO8TaICBl758BE
	 m3QHCr4ga3puyXnjcQUvGaWp/T1g7ei/Acg+eBMcOxw+NIYz+KckxWr4EONdmgGMD0UAn
	 l/ghfHtvZdB3m4oRRKqLcQUR5fY0haOyH+2x8SOmTfQRaR6MAXeqWFqYAZKagfKCsUFNG
	 niVLTHqJ5+AfAmyodOyiUzdxFtYAztZg2uoMiQ847G6izzTTKLGwf+weiINjzMHxFig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740008;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=DBIigRwOmB3mzDWu/BG0DQ3cCq9erW6+W+oz6DRhxbQ=;
	b=T9aKQitNFwaSdmZ76fCddElU0YpXVFv7XpZ1KEFfyU2KNrrdowtxkHI7kvkq9McXkfGH
	 Boqy52CjMU5K2u8v43sK8WuajXUb1AWA9icROiHzQL/8whD7kZoaHIa5GtHvu9YuwpFwV
	 YHfq9+Oya9AjdrWEeZtwSQ8PKGTwm9R3o5APz9964+ulXniSJ4vGmLi1C3rT4EI55DIeU
	 MZ9NipnHw2OmFvfMfQzAt8ckT+w9ClUKnu5QGpXPsz16Qc7k0ZGRGpjmzoFsYGNU+gS3g
	 i7ssEEhQeGmNrEc5C5xjqYt/NJ07x6Md0/85Lo+EZ8e80YLKctDI4GCknB0BpFbIoAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ii5evdw4;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F4E606A31A;
	Fri, 23 Oct 2026 07:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1F4E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ii5evdw4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792740007; x=1824276007;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rRh9ZEz2g8+VK7Li/T7iOfryrSAg1VQ9stT0b/ftOU8=;
  b=ii5evdw4AT95YEQREfVzy/9GUeUTLbKT6oT5VsjK7rN1k67H1tCdWwDv
   fy3SxvqFcLnuvz/Fw4GoUR3fpRwBPoqhhtbpOWFwExTENKDjTwgjRkrb9
   CZVOz7BJ/HHeRcurxLcrL4V8zGJwCWTbsIn8SVPqGonhO+Y2qj9WwfWH5
   +lZkWXup5p4WG7NON05g0AFpZqnmCnanzHBdoaHdKfpOlrq5zNesZNnW8
   9ICQ7FSZgrpn5zGk26BL6sa25wsKN4mOZ7Y6u1iIOofAgFl0v0Qrf3VbL
   /zLo0OYlzHW33TO3tPWUxD7JUNN2kDjFi7vXq0gJ/veMbeI11zBhWDkcP
   g==;
X-CSE-ConnectionGUID: BSF8oZ4UT1KAHO+cPTrQgg==
X-CSE-MsgGUID: bo8n8MHcTw6v7w3mjWFOLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1372831"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1372831"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 00:20:07 -0700
X-CSE-ConnectionGUID: VTopvUN2QhyUpAaTN2kSFg==
X-CSE-MsgGUID: 1lnYNjwSSN2J1gdWxYXDxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3516182"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 00:19:59 -0700
Message-ID: <d742f446-4632-4d15-a6ca-9d0ba144b223@linux.intel.com>
Date: Fri, 23 Oct 2026 15:19:57 +0800
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
Subject: Re: [PATCH v10 07/28] KVM: VMX: Initialize VMCS FRED fields
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
 <20260911213659.2025974-8-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-8-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> Initialize host VMCS FRED fields with host FRED MSRs' value and
> guest VMCS FRED fields to 0.
> 
> FRED CPU state is managed in 9 new FRED MSRs:
>         IA32_FRED_CONFIG,
>         IA32_FRED_STKLVLS,
>         IA32_FRED_RSP0,
>         IA32_FRED_RSP1,
>         IA32_FRED_RSP2,
>         IA32_FRED_RSP3,
>         IA32_FRED_SSP1,
>         IA32_FRED_SSP2,
>         IA32_FRED_SSP3,
> as well as a few existing CPU registers and MSRs:
>         CR4.FRED,
>         IA32_STAR,
>         IA32_KERNEL_GS_BASE,
>         IA32_PL0_SSP (also known as IA32_FRED_SSP0).
> 
> CR4, IA32_KERNEL_GS_BASE and IA32_STAR are already well managed.
> Except IA32_FRED_RSP0 and IA32_FRED_SSP0, all other FRED CPU state
> MSRs have corresponding VMCS fields in both the host-state and
> guest-state areas.  So KVM just needs to initialize them, and with
> proper VM entry/exit FRED controls, a FRED CPU will keep tracking
> host and guest FRED CPU state in VMCS automatically.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---
> v10:
>  - s/rdmsrl/rdmsrq (Chao)
>  - Remove a terse comment which doesn't help at all (Sean).
>  - Replace direct, raw use of __this_cpu_ist_top_va() with a self-
>    explanatory this_cpu_fred_rsp() helper for better readability (Sean).
>  - Add cpu_feature_enabled(X86_FEATURE_FRED) to patch out accesses to
>    VMCS FRED fields (Sean).
>  - Remove "#ifdef CONFIG_X86_64" after switching to this_cpu_fred_rsp()
>    (Sean).

[...]

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 2a2218e0983b..dc80ca5f804d 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1562,6 +1562,12 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu)
>  				    (unsigned long)(cpu_entry_stack(cpu) + 1));
>  		}
>  
> +		if (cpu_feature_enabled(X86_FEATURE_FRED) && kvm_cpu_cap_has(X86_FEATURE_FRED)) {

Nit:
I was wondering why cpu_feature_enabled(X86_FEATURE_FRED) was needed for a while.
Sorry I missed the version history :(

This seems to be the first time this cpu_feature_enabled() && kvm_cpu_cap_has() combination is used,
maybe have a mention in the changelog?

> +			vmcs_write64(HOST_IA32_FRED_RSP1, this_cpu_fred_rsp(FRED_STACK_LEVEL_1));
> +			vmcs_write64(HOST_IA32_FRED_RSP2, this_cpu_fred_rsp(FRED_STACK_LEVEL_2));
> +			vmcs_write64(HOST_IA32_FRED_RSP3, this_cpu_fred_rsp(FRED_STACK_LEVEL_3));
> +		}
> +
>  		vmx->loaded_vmcs->cpu = cpu;
>  	}
>  }
> @@ -4500,6 +4506,17 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
>  	 */
>  	vmcs_write16(HOST_DS_SELECTOR, 0);
>  	vmcs_write16(HOST_ES_SELECTOR, 0);
> +
> +	if (cpu_feature_enabled(X86_FEATURE_FRED) && kvm_cpu_cap_has(X86_FEATURE_FRED)) {
> +		/* FRED CONFIG and STKLVLS are the same on all CPUs */
> +		vmcs_write64(HOST_IA32_FRED_CONFIG, kvm_host.fred_config);
> +		vmcs_write64(HOST_IA32_FRED_STKLVLS, kvm_host.fred_stklvls);
> +
> +		/* Linux doesn't support kernel shadow stacks, thus SSPs are 0s */
> +		vmcs_write64(HOST_IA32_FRED_SSP1, 0);
> +		vmcs_write64(HOST_IA32_FRED_SSP2, 0);
> +		vmcs_write64(HOST_IA32_FRED_SSP3, 0);
> +	}
>  #else
>  	vmcs_write16(HOST_DS_SELECTOR, __KERNEL_DS);  /* 22.2.4 */
>  	vmcs_write16(HOST_ES_SELECTOR, __KERNEL_DS);  /* 22.2.4 */
> @@ -5030,6 +5047,17 @@ static void init_vmcs(struct vcpu_vmx *vmx)
>  	}
>  
>  	vmx_setup_uret_msrs(vmx);
> +
> +	if (cpu_feature_enabled(X86_FEATURE_FRED) && kvm_cpu_cap_has(X86_FEATURE_FRED)) {
> +		vmcs_write64(GUEST_IA32_FRED_CONFIG, 0);
> +		vmcs_write64(GUEST_IA32_FRED_RSP1, 0);
> +		vmcs_write64(GUEST_IA32_FRED_RSP2, 0);
> +		vmcs_write64(GUEST_IA32_FRED_RSP3, 0);
> +		vmcs_write64(GUEST_IA32_FRED_STKLVLS, 0);
> +		vmcs_write64(GUEST_IA32_FRED_SSP1, 0);
> +		vmcs_write64(GUEST_IA32_FRED_SSP2, 0);
> +		vmcs_write64(GUEST_IA32_FRED_SSP3, 0);
> +	}
>  }
>  
>  static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
> @@ -8883,6 +8911,11 @@ __init int vmx_hardware_setup(void)
>  
>  	kvm_caps.inapplicable_quirks &= ~KVM_X86_QUIRK_IGNORE_GUEST_PAT;
>  
> +	if (cpu_feature_enabled(X86_FEATURE_FRED) && kvm_cpu_cap_has(X86_FEATURE_FRED)) {
> +		rdmsrq(MSR_IA32_FRED_CONFIG, kvm_host.fred_config);
> +		rdmsrq(MSR_IA32_FRED_STKLVLS, kvm_host.fred_stklvls);
> +	}
> +
>  	return 0;
>  }
>  

