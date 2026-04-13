Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DEE1CFBA;
	Mon, 13 Apr 2026 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776046391; cv=none; b=A6bLquo5zoj6gwPVZSh+JK1WLwI9EqQN9jgG9CU+tYd4YuD6BBvkB8WLHYmTZl3fz5ZO46S22WhPZ5wnTvvba4C8by77ywRx8DSU6oamcRt0WOK2vpDE/biujThWmRKo7nMysVCFCzR4emiYWq/dpq2c6P93Nrdw5yJ6c8P3bw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776046391; c=relaxed/simple;
	bh=er6MCQomEGTUvijVJbiOjpZfculnqBmMYI/3gcoJr3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=amotEhMCtQZbqLL/MR1M+fPAMdiqL+TYuRJTzM0eoC2QEV+M7vjPUkLTWQv9csO9meVJth7g/iwru7hmCVVr99NFksJ779enyraQzOP+GKpOWm9hp/LFXclz/lTmnFBlN2kb6ZAz3s7CzPCslb43kbdRxe+Wr7NTnWP8L22F/Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6KUZGO5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6KUZGO5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776046389; x=1807582389;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=er6MCQomEGTUvijVJbiOjpZfculnqBmMYI/3gcoJr3w=;
  b=d6KUZGO5WjBNFycm0rbqoZvW65mWzFdaJ1XSQCKdfKukMCMozzYq+d9t
   mogoxHb9/B4iQOWs3jqma3HvH3cTboo04FSd8B5g6DDJo706LsYawKelI
   yYhHY7+pXb6+8TauU7yQ7s235gmo4Lh9g3uORjBykJ8zP6dIrMb3XXxGz
   SOll5vcdjNVbdQr7RGuOLn/zQyTvAnq4OZoTSDbh1j/Cz9wGaUa6N1Rpy
   MmuZovVdN87Zo5p7CU+t0EN7rOutdPIRh6jLIjX6E+wQc1UEJV+Sao2Aw
   BrqN9uMzL/j+SAMZwP1cgOGMDaQ6guXnIXvqZ51b8doN2cy5OY+UnPxz/
   A==;
X-CSE-ConnectionGUID: Kx5VFR5yQHyEGPhUjdY4Wg==
X-CSE-MsgGUID: 5G1BaKMhSU+iAb1X9nCBjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="94368125"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="94368125"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 19:13:09 -0700
X-CSE-ConnectionGUID: gGh8P2VkTJWN0/AMeoUvog==
X-CSE-MsgGUID: J2PtEXbfTPuTFwcpq3vgTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="226952508"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 19:13:06 -0700
Message-ID: <0e7a02c6-3d54-468e-92f4-4954d4644d4b@linux.intel.com>
Date: Mon, 13 Apr 2026 10:13:04 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: TDX: Fix x2APIC MSR handling in
 tdx_has_emulated_msr()
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20260410232654.3864196-1-rick.p.edgecombe@intel.com>
Content-Language: en-US
Cc: kas@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com,
 dmaluka@chromium.org
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260410232654.3864196-1-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/11/2026 7:26 AM, Rick Edgecombe wrote:
> Rework tdx_has_emulated_msr() to explicitly enumerate the x2APIC MSRs
> that KVM can emulate, instead of trying to enumerate the MSRs that KVM
> cannot emulate. Drop the inner switch and list the emulatable x2APIC
> registers directly in the outer switch's "return true" block.
> 
> The old code had multiple bugs in the x2APIC range handling.
> X2APIC_MSR(APIC_ISR + APIC_ISR_NR) was incorrect because APIC_ISR_NR is
> 0x8, not 0x80, so the X2APIC_MSR() shift lost the lower bits, collapsing
> each range to a single MSR. IA32_X2APIC_SELF_IPI was also missing from
> the non-emulatable list.

Is it better to describe that the bug is benign for a sane guest?

> 
> KVM has no visibility into whether or not a guest has enabled #VE 
> reduction, which changes which MSRs the TDX-Module handles itself versus 
> triggering a #VE for the guest to make a TDVMCALL. So maintaining a list 
> of non-emulatable MSRs is fragile. Listing only the MSRs KVM can always 
> emulate sidesteps the problem.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Reported-by: Dmytro Maluka <dmaluka@chromium.org>
> Fixes: dd50294f3e3c ("KVM: TDX: Implement callbacks for MSR operations")
> Assisted-by: Claude:claude-opus-4-6
> [based on a diff from Sean, but added missed LVTCMCI case, log]
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One nit below.

> ---
> 
> Thanks to Dmytro for finding this. They said to feel free to take this 
> over, so here is another version with Sean's suggestions. Tested in the 
> TDX CI.
> 
> In Sean's suggestion LVTCMCI was missed, so it's added here.
> 
>  arch/x86/kvm/vmx/tdx.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 1e47c194af53..76ab6805ab29 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -2116,23 +2116,27 @@ bool tdx_has_emulated_msr(u32 index)
>  	case MSR_IA32_MC0_CTL2 ... MSR_IA32_MCx_CTL2(KVM_MAX_MCE_BANKS) - 1:
>  		/* MSR_IA32_MCx_{CTL, STATUS, ADDR, MISC, CTL2} */
>  	case MSR_KVM_POLL_CONTROL:
> +	/*
> +	 * x2APIC registers that are virtualized by the CPU can't be
> +	 * emulated, KVM doesn't have access to the virtual APIC page.
> +	 */

Nit:
The original comment explains why certain MSRs are not emulated due to
its implementation. After the change, it lists the allowed emulated MSRs,
a quick read might give the false impression that the listed MSRs are the
ones that cannot be emulated. Maybe slightly tweak the comment to clarify
that the cases listed below are the MSRs that KVM is responsible for
emulating.


> +	case X2APIC_MSR(APIC_ID):
> +	case X2APIC_MSR(APIC_LVR):
> +	case X2APIC_MSR(APIC_LDR):
> +	case X2APIC_MSR(APIC_SPIV):
> +	case X2APIC_MSR(APIC_ESR):
> +	case X2APIC_MSR(APIC_LVTCMCI):
> +	case X2APIC_MSR(APIC_ICR):
> +	case X2APIC_MSR(APIC_LVTT):
> +	case X2APIC_MSR(APIC_LVTTHMR):
> +	case X2APIC_MSR(APIC_LVTPC):
> +	case X2APIC_MSR(APIC_LVT0):
> +	case X2APIC_MSR(APIC_LVT1):
> +	case X2APIC_MSR(APIC_LVTERR):
> +	case X2APIC_MSR(APIC_TMICT):
> +	case X2APIC_MSR(APIC_TMCCT):
> +	case X2APIC_MSR(APIC_TDCR):
>  		return true;
> -	case APIC_BASE_MSR ... APIC_BASE_MSR + 0xff:
> -		/*
> -		 * x2APIC registers that are virtualized by the CPU can't be
> -		 * emulated, KVM doesn't have access to the virtual APIC page.
> -		 */
> -		switch (index) {
> -		case X2APIC_MSR(APIC_TASKPRI):
> -		case X2APIC_MSR(APIC_PROCPRI):
> -		case X2APIC_MSR(APIC_EOI):
> -		case X2APIC_MSR(APIC_ISR) ... X2APIC_MSR(APIC_ISR + APIC_ISR_NR):
> -		case X2APIC_MSR(APIC_TMR) ... X2APIC_MSR(APIC_TMR + APIC_ISR_NR):
> -		case X2APIC_MSR(APIC_IRR) ... X2APIC_MSR(APIC_IRR + APIC_ISR_NR):
> -			return false;
> -		default:
> -			return true;
> -		}
>  	default:
>  		return false;
>  	}

