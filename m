Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0322475E3;
	Mon, 17 Aug 2026 06:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786947323; cv=none; b=IOZbjcrB9CzNwAIp8RcmCv9+KTTG5rlNhRmUAlFuznzAaozaHkGOTN2sbp+39kurL0gK6CsMjmzzmItpyQX05NwVX1okIlNiP7NpdXp8uvphLqD3/M8v0mTpsSVSYMQNFIT2BH4DYsvTcUraStfCMH1OIYWHApGv7MHepeaJ6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786947323; c=relaxed/simple;
	bh=LoGVDpAt+i2l3MYBprhIi3Izh12BuPUlGVKSPnR6Q3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hE54/LUm2hEChNPD3JFP/w63/xawmtOI9M3imAn2Fj6AIVv5g0Yau/w9H+h8pL63uy5Rku0bSN9golcfdOZlEnIUMGxHRrI2A5xuubpJuW2uppEc/06zvJJXg4oNR6x7617kjbfEDyHacuoSTWRyAwx7MF5OifAWOhxSoppuykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+jEtH+B; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+jEtH+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786947321; x=1818483321;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LoGVDpAt+i2l3MYBprhIi3Izh12BuPUlGVKSPnR6Q3Q=;
  b=X+jEtH+B0Xjh6qGfHvKMX0gSEHjuAoiwh5TUT0Fxt4zN1+NiXFkfmtk1
   dCewxZUbBnMtWce0OT5AC32acuyktToMHh46BgVFKfpdBVmCvpr2vpdu6
   7GfM9lVGyyt/js3o5oYp9NBpVBdlbuXgh3ssutKae6Kth9HSiadZVMJZW
   LrizHOT8m1t1hwt4TM7cyxN4fcphvfecqORUd6JKQpWlgQI+piSHd7aPZ
   u19a53SWw3OO2PqZRX6CyuUla1PANCcF02AXXEVI2b375OBKcDr73dLhR
   W03b8o6KpO3vzfwigFWJ2MHYqJUhq4iu12ktCLkZ/50Pc6h/pwX+YAAN0
   Q==;
X-CSE-ConnectionGUID: mSBmQsO7TnCH0t+zqPOwKA==
X-CSE-MsgGUID: EssbsQFUSYadSHPrgKzl+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87623897"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="87623897"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 23:15:20 -0700
X-CSE-ConnectionGUID: Rku8HkVaRAW2zoyJVylJzQ==
X-CSE-MsgGUID: uY4VMZunRhqeZPLxAhrw/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="270021065"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 23:15:17 -0700
Message-ID: <7fe6b6f0-fe0a-4090-b97a-880b1e0ec13f@linux.intel.com>
Date: Mon, 17 Aug 2026 14:15:15 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] KVM: VMX: Disallowing using to_vmx() in common VT
 code
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>,
 Yan Zhao <yan.y.zhao@intel.com>
References: <20260814161129.2177118-1-seanjc@google.com>
 <20260814161129.2177118-3-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260814161129.2177118-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/2026 12:11 AM, Sean Christopherson wrote:
> Poison to_vmx() in main.c and posted_intr.c so that attempting to interpret
> the vCPU as a VMX vCPU will fail at compile time, as opposed to failing at
> runtime, or worse corrupting state without outright failing.
> 
> Note, to_tdx() is buried in tdx.c, i.e. isn't broadly reachable, and so
> doesn't need the same treatment as to_vmx().
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Nit:
About the short log, use "Disallow using" instead of "Disallowing using"?

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>> ---
>  arch/x86/kvm/vmx/main.c        | 2 ++
>  arch/x86/kvm/vmx/posted_intr.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index aa5b44bb212b..95d89d809c19 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -11,6 +11,8 @@
>  #include "tdx.h"
>  #include "tdx_arch.h"
>  
> +#pragma GCC poison to_vmx
> +
>  #ifdef CONFIG_KVM_INTEL_TDX
>  static_assert(offsetof(struct vcpu_vmx, vt) == offsetof(struct vcpu_tdx, vt));
>  
> diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
> index 4a6d9a17da23..24221ba553be 100644
> --- a/arch/x86/kvm/vmx/posted_intr.c
> +++ b/arch/x86/kvm/vmx/posted_intr.c
> @@ -14,6 +14,8 @@
>  #include "vmx.h"
>  #include "tdx.h"
>  
> +#pragma GCC poison to_vmx
> +
>  /*
>   * Maintain a per-CPU list of vCPUs that need to be awakened by wakeup_handler()
>   * when a WAKEUP_VECTOR interrupted is posted.  vCPUs are added to the list when

