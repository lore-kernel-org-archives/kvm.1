Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80F139FCBC;
	Tue, 22 Sep 2026 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044545; cv=none; b=f4heSCBJFA7Ir6dJVJQl3hE7NoCWPI1EJtkt7DXXE1ACHYrS7A6HVSSrqZscFbmNQMDA4aXnd75uYvu0GJ0DcFWrucjvf1BtGyyBQaOmMRMfIK6GMCvwTtAZPTCe8CUf5Sx8tIXGPlHLykH9wXj7c41hkDLUNskwSYDVI2WOp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044545; c=relaxed/simple;
	bh=zHkhQMfJ14DXoFQ0meau4FrX8fIWIIkTaRItBumTY7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5y/S+6bvV5u6nsxuwB0RNnXLJbKoiP8oPCkQQL7xvZQUwUDtReK4HqzA5QNMFTWHbCZrpzOLBtaxCdPMghSCEIQDkN5Hcw9xZLIlYbeW4+6zsFxey1hpC9+nqt9dF8ShHumlQh9uJ9sjKdJFF6nYDtd3TMAk8ymEFINYGRFR3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRFjxoXf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRFjxoXf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790044543; x=1821580543;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zHkhQMfJ14DXoFQ0meau4FrX8fIWIIkTaRItBumTY7g=;
  b=eRFjxoXfQEBVDT4XH1xbVqW5UIeuZNA6EKI2MeaCpe39T5AHDOmYp+x6
   nCnPXfiC2mMODtOFo2LUtlEWsJZ2LfrzdfWZAbY8WohPa68Za8BCXAcJj
   gXDEQqGmyx8Pi3uQm/+BDUuU+EKv7xgi0KKNh9iGAaVdajtB6SDESJ2/q
   d3omm7GW87tWgjCMXoz8n8hq6ZNXIl7+JVAWLslzqTT0qNO5rPseLxff2
   hdSklN1OrnPlFbKw4x/zoTIRayU+Uh1J9ToaH09EX8lcB7lstS1N6iUQp
   QqI32DzlVlRy0RT8D4EblwlaQMHP/hgVBYZ0z94Hqz/3EbeBvT4XrlB5W
   w==;
X-CSE-ConnectionGUID: MajQWMFcTnqPhMZx+2rTOA==
X-CSE-MsgGUID: tM77wgS+RP6b8mGK/MDt3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="93112576"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="93112576"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 19:35:41 -0700
X-CSE-ConnectionGUID: xikcHXJeRTS87gNe3Vp6qQ==
X-CSE-MsgGUID: aQYQv7SLSR+/RMAN3fhDwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="280990806"
Received: from unknown (HELO [10.238.208.182]) ([10.238.208.182])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 19:35:39 -0700
Message-ID: <ae797ef1-4742-4957-9e28-cb1b87b1ace2@intel.com>
Date: Tue, 22 Sep 2026 10:35:37 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: VMX: Move bus lock handler from main.c => common.h
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260922000152.1113202-1-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260922000152.1113202-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/2026 8:01 AM, Sean Christopherson wrote:
> Move the bus lock VM-Exit handler, which is basically a one-liner, from
> main.c to vmx.h now that to_vt() is usable in common.h.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> This applies on top of kvm-x86/next + Xiayao's series.  I.e. actually applying
> it will be painful for anyone but me at this point, but I'm really just posting
> for posterity.

It seems like squashing it into patch 7 of my series would be OK as well. I
guess you intended to avoid changing my series since it might require a new
version.

Anyway,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>  arch/x86/kvm/vmx/common.h | 11 ++++++++++-
>  arch/x86/kvm/vmx/main.c   | 11 -----------
>  2 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
> index e22c159c3b84..b2905335a2d2 100644
> --- a/arch/x86/kvm/vmx/common.h
> +++ b/arch/x86/kvm/vmx/common.h
> @@ -254,6 +254,15 @@ static inline int __vt_handle_notify(struct kvm_vcpu *vcpu,
>  	return 1;
>  }
>  
> -int vt_handle_bus_lock_vmexit(struct kvm_vcpu *vcpu);
> +static inline int vt_handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * Hardware may or may not set the BUS_LOCK_DETECTED flag on BUS_LOCK
> +	 * VM-Exits. Unconditionally set the flag here and leave the handling
> +	 * to .handle_exit() callback.
> +	 */
> +	to_vt(vcpu)->exit_reason.bus_lock_detected = true;
> +	return 1;
> +}
>  
>  #endif /* __KVM_X86_VMX_COMMON_H */
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index c11732cfadf0..2985742e20f1 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -872,17 +872,6 @@ static int vt_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn,
>  #define vt_op_tdx_only(name) NULL
>  #endif /* CONFIG_KVM_INTEL_TDX */
>  
> -int vt_handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
> -{
> -	/*
> -	 * Hardware may or may not set the BUS_LOCK_DETECTED flag on BUS_LOCK
> -	 * VM-Exits. Unconditionally set the flag here and leave the handling
> -	 * to .handle_exit() callback.
> -	 */
> -	to_vt(vcpu)->exit_reason.bus_lock_detected = true;
> -	return 1;
> -}
> -
>  noinstr void vt_handle_nmi(struct kvm_vcpu *vcpu)
>  {
>  	if ((u16)vt_get_exit_reason(vcpu).basic != EXIT_REASON_EXCEPTION_NMI ||
> 
> base-commit: e1d8e13452eea815042f79244bb649536e3689f5

