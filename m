Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8EF3DB313;
	Thu, 27 Aug 2026 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787831323; cv=none; b=Hc9jQCa7/HGNQyoVHAaLzRlakQzUxkRP6DuLONTEDIs5Uy3tHC3WosHwBka6Mp8xjZ8Ubwazbs1WGN4ZetdoKmLsHHjsepqNQYaM2/A5MCVp2WozB6PUVhXC1DHRzx9mHDY+4zzhF0lQhHtLFMPmzeE9IdI2RAH04oHICPE/hq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787831323; c=relaxed/simple;
	bh=mfRY+RLncwM82xrJ1GTQZpne7I2ckt2OkZTat+J5n9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5itzIJHfTQW0e6NOPF4+L/O5RxuKiwoxPHAaWKYFd4l+KliroNV44AzvjvSwsKlHwTtRsXiOJeun+/43h68fSY96R7BXVUhRazb7zs29vDr+LNf7B58AVHNqvQDIdQEV9dKlX6me7kf/uWakXz17SLwCqumLkyULgvOgsFno7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=csCPDL0P; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="csCPDL0P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787831322; x=1819367322;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mfRY+RLncwM82xrJ1GTQZpne7I2ckt2OkZTat+J5n9U=;
  b=csCPDL0P/DmRaKBgmDFl/romKBo+J4wMxvc/IGMFCfKfALlo7HetrnLg
   Nmm5g0iGn4oz77WPoM83DoEC7QRtBiiu1bwIi8GF3SWhrxqomSJlxAv9m
   ntNfOPqBw+bAorNXaOxWtMdFToQNzCiPRz+JYlIpYi3nHSG8i9mtf/eA0
   ap7uMXUUOlg20v0r0TJINwGIQvP5iqXveOev8TL2mzgNWEszbF1/lPQZ2
   ZCbqI6TQRYI3bQW7E/bcdJ9YkjKM9eYYR2KY0i5/TkIJ1cNfUBB9vP1kt
   opsj+yW//SLLE8/8KJg9a4WpsrIH2hKAwYzUdhow3gwiPacp6OFSQ2Lx1
   w==;
X-CSE-ConnectionGUID: fgviRk5MRgCS5B0hp03REg==
X-CSE-MsgGUID: AAoZEEuWTsiomLTcjfoS4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="105703399"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="105703399"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 04:48:41 -0700
X-CSE-ConnectionGUID: /HUeJ8Y/RmW5B8jba05y1g==
X-CSE-MsgGUID: nVVcraNHQA21ihIGkJi0zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="264077375"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 04:48:38 -0700
Message-ID: <b648effa-0196-4810-ab9b-d3a4d9f88552@intel.com>
Date: Thu, 27 Aug 2026 19:48:35 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] KVM: VMX: Rename EPT violation handler prefix from
 "vmx" to "vt"
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 Yan Zhao <yan.y.zhao@intel.com>
References: <20260826171246.777729-1-seanjc@google.com>
 <20260826171246.777729-6-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260826171246.777729-6-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/2026 1:12 AM, Sean Christopherson wrote:
> Rename __vmx_handle_ept_violation() to __vt_handle_ept_violation to capture
> that it is shared between VMX and TDX.

Similar nit as what for __vt_deliver_posted_interrupt() in patch 4, 
maybe just name it vt_handle_ept_violation()?

> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   arch/x86/kvm/vmx/common.h | 4 ++--
>   arch/x86/kvm/vmx/tdx.c    | 2 +-
>   arch/x86/kvm/vmx/vmx.c    | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
> index ff4f6a2b6402..35b54938a5f5 100644
> --- a/arch/x86/kvm/vmx/common.h
> +++ b/arch/x86/kvm/vmx/common.h
> @@ -86,8 +86,8 @@ static inline bool vt_is_tdx_private_gpa(struct kvm *kvm, gpa_t gpa)
>   	return !kvm_is_addr_direct(kvm, gpa);
>   }
>   
> -static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
> -					     unsigned long exit_qualification)
> +static inline int __vt_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
> +					    unsigned long exit_qualification)
>   {
>   	u64 error_code;
>   
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 36578d4c00ff..a3d6f0fb5951 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1987,7 +1987,7 @@ static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
>   	while (1) {
>   		struct kvm_memory_slot *slot;
>   
> -		ret = __vmx_handle_ept_violation(vcpu, gpa, exit_qual);
> +		ret = __vt_handle_ept_violation(vcpu, gpa, exit_qual);
>   
>   		if (ret != RET_PF_RETRY || !local_retry)
>   			break;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 506be74e3e0f..2532a9b8e92e 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5991,7 +5991,7 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
>   	if (unlikely(allow_smaller_maxphyaddr && !kvm_vcpu_is_legal_gpa(vcpu, gpa)))
>   		return kvm_emulate_instruction(vcpu, 0);
>   
> -	return __vmx_handle_ept_violation(vcpu, gpa, exit_qualification);
> +	return __vt_handle_ept_violation(vcpu, gpa, exit_qualification);
>   }
>   
>   static int handle_ept_misconfig(struct kvm_vcpu *vcpu)

