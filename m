Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376953DD52C;
	Thu, 14 May 2026 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778748122; cv=none; b=RBIeHxG8p4i94gv7bPz585KM6NYoGCN4lVfgw8EeQwqANX5or9VrgipQrRwtihivHaKMiacblFbw35MQgApb1HgPYXVQ94M808u7kyTFKLO7gRKS6R/RHZca6lB0zLjqW17sIvq+KBBoI1xgPoWZalUoi/wMNthNV8DxMSkpbls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778748122; c=relaxed/simple;
	bh=OoUpwv5tHfEW2YRvdgWrpWI3bMUj+ZfKIi3hAnNzqAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=dffVq97B8sXlOXIZYBXj6N6vDktoWkIIOdMDYzjUgDQp4tqvgKZHkRijV8h84jCj/nyd7EFWkoP88pcaDaefTztuJfhR6E7zY+LMZpIwxJ9aXnLLLF1chdU/XgNbKHlbsw0HuEP1bfzVBUKsS7GHVM4inCZvM9vnnRYgULzlvxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CvJfIWkX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CvJfIWkX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778748120; x=1810284120;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=OoUpwv5tHfEW2YRvdgWrpWI3bMUj+ZfKIi3hAnNzqAA=;
  b=CvJfIWkXkpg7S9l4swxZEHbyakP6LiPhRVfdBJqTvafNa7tKpHC7iOMU
   LxPemYI4oAnsJrzFv1vUmgHeEPRL+1vgCbNJkQWYh3FeY1b8HlgzC+eCQ
   4XntuE2b037XQcgQpISEBXbT1FlzLoJWZ59qqYlg9k8dp+LAvTxzyN7Xs
   VOA2Wz0nPUHn4ClXBByBUD8f7H6WbqB7BPI5EWRCdo2J2KIcWSqQ35nue
   mkOyridhAnjc80x4wc0Q+2bDX18ilOloMj5ePZvt25C8XiquGXY0FOHCl
   VKzYxqmj0CPHzXmqTa3FCjI90BGv4z8+3AKKNGSvmW3xbbrpyKzhHZ0Wl
   Q==;
X-CSE-ConnectionGUID: ILGkEQujQ8GdSHAPnuVaOw==
X-CSE-MsgGUID: ofcaXVxTR+uISeNbU5Zxmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="105145291"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="105145291"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 01:41:59 -0700
X-CSE-ConnectionGUID: VHkeX5PnRNqZWN+/0kFpEA==
X-CSE-MsgGUID: t7FC4sP6TWiQHCPcI6Iv9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="237464545"
Received: from fanlilin-mobl.ccr.corp.intel.com (HELO [10.238.1.228]) ([10.238.1.228])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 01:41:55 -0700
Message-ID: <27590d74-52ef-4f69-b207-99711abea75c@linux.intel.com>
Date: Thu, 14 May 2026 16:41:52 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] KVM: x86: Consolidate CPUID fault handling for
 emulator and interception logic
To: Jim Mattson <jmattson@google.com>
References: <20260513224608.1859737-1-jmattson@google.com>
 <20260513224608.1859737-2-jmattson@google.com>
Content-Language: en-US
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, shuah@kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ctpence@google.com
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260513224608.1859737-2-jmattson@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/14/2026 6:46 AM, Jim Mattson wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Extract the logic for emulating CPUID faulting (where CPUID #GPs at CPL>0
> outside of SMM) into a dedicated helper and use the helper for both the
> full emulator and the intercepted-CPUID paths.
> 
> Opportunistically drop kvm_require_cpl(), as kvm_require_cpl() was the one
                                                     ^
Typo:

kvm_require_cpl() -> kvm_emulate_cpuid()

> and only user.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Jim Mattson <jmattson@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/include/asm/kvm_host.h |  1 -
>  arch/x86/kvm/cpuid.c            |  5 +++--
>  arch/x86/kvm/cpuid.h            |  8 ++++++++
>  arch/x86/kvm/emulate.c          |  6 +-----
>  arch/x86/kvm/kvm_emulate.h      |  1 +
>  arch/x86/kvm/x86.c              | 18 ++++++------------
>  6 files changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index c470e40a00aa..a9005c61619b 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2285,7 +2285,6 @@ void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
>  void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault);
>  void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
>  				    struct x86_exception *fault);
> -bool kvm_require_cpl(struct kvm_vcpu *vcpu, int required_cpl);
>  bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr);
>  
>  static inline int __kvm_irq_line_state(unsigned long *irq_state,
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index e69156b54cff..1c95d1fa3ead 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -2161,9 +2161,10 @@ int kvm_emulate_cpuid(struct kvm_vcpu *vcpu)
>  {
>  	u32 eax, ebx, ecx, edx;
>  
> -	if (!is_smm(vcpu) && cpuid_fault_enabled(vcpu) &&
> -	    !kvm_require_cpl(vcpu, 0))
> +	if (!kvm_is_cpuid_allowed(vcpu)) {
> +		kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
>  		return 1;
> +	}
>  
>  	eax = kvm_rax_read(vcpu);
>  	ecx = kvm_rcx_read(vcpu);
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index 039b8e6f40ba..bc4a8428b836 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -7,6 +7,8 @@
>  #include <asm/processor.h>
>  #include <uapi/asm/kvm_para.h>
>  
> +#include "smm.h"
> +
>  extern u32 kvm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
>  extern bool kvm_is_configuring_cpu_caps __read_mostly;
>  
> @@ -192,6 +194,12 @@ static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
>  		  MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
>  }
>  
> +static inline bool kvm_is_cpuid_allowed(struct kvm_vcpu *vcpu)
> +{
> +	return !cpuid_fault_enabled(vcpu) || is_smm(vcpu) ||
> +	       !kvm_x86_call(get_cpl)(vcpu);
> +}
> +
>  static __always_inline void kvm_cpu_cap_clear(unsigned int x86_feature)
>  {
>  	unsigned int x86_leaf = __feature_leaf(x86_feature);
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index c8c6cc0406d6..3ba09093b5ab 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -3593,12 +3593,8 @@ static int em_sti(struct x86_emulate_ctxt *ctxt)
>  static int em_cpuid(struct x86_emulate_ctxt *ctxt)
>  {
>  	u32 eax, ebx, ecx, edx;
> -	u64 msr = 0;
>  
> -	ctxt->ops->get_msr(ctxt, MSR_MISC_FEATURES_ENABLES, &msr);
> -	if (!ctxt->ops->is_smm(ctxt) &&
> -	    (msr & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) &&
> -	    ctxt->ops->cpl(ctxt))
> +	if (!ctxt->ops->is_cpuid_allowed(ctxt))
>  		return emulate_gp(ctxt, 0);
>  
>  	eax = reg_read(ctxt, VCPU_REGS_RAX);
> diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
> index 0abff36d0994..45d4a03b202e 100644
> --- a/arch/x86/kvm/kvm_emulate.h
> +++ b/arch/x86/kvm/kvm_emulate.h
> @@ -225,6 +225,7 @@ struct x86_emulate_ops {
>  			 struct x86_instruction_info *info,
>  			 enum x86_intercept_stage stage);
>  
> +	bool (*is_cpuid_allowed)(struct x86_emulate_ctxt *ctxt);
>  	bool (*get_cpuid)(struct x86_emulate_ctxt *ctxt, u32 *eax, u32 *ebx,
>  			  u32 *ecx, u32 *edx, bool exact_only);
>  	bool (*guest_has_movbe)(struct x86_emulate_ctxt *ctxt);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0a1b63c63d1a..01c6b18d1fe5 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1021,18 +1021,6 @@ void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code)
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_queue_exception_e);
>  
> -/*
> - * Checks if cpl <= required_cpl; if true, return true.  Otherwise queue
> - * a #GP and return false.
> - */
> -bool kvm_require_cpl(struct kvm_vcpu *vcpu, int required_cpl)
> -{
> -	if (kvm_x86_call(get_cpl)(vcpu) <= required_cpl)
> -		return true;
> -	kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
> -	return false;
> -}
> -
>  bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr)
>  {
>  	if ((dr != 4 && dr != 5) || !kvm_is_cr4_bit_set(vcpu, X86_CR4_DE))
> @@ -8819,6 +8807,11 @@ static int emulator_intercept(struct x86_emulate_ctxt *ctxt,
>  					     &ctxt->exception);
>  }
>  
> +static bool emulator_is_cpuid_allowed(struct x86_emulate_ctxt *ctxt)
> +{
> +	return kvm_is_cpuid_allowed(emul_to_vcpu(ctxt));
> +}
> +
>  static bool emulator_get_cpuid(struct x86_emulate_ctxt *ctxt,
>  			      u32 *eax, u32 *ebx, u32 *ecx, u32 *edx,
>  			      bool exact_only)
> @@ -8955,6 +8948,7 @@ static const struct x86_emulate_ops emulate_ops = {
>  	.wbinvd              = emulator_wbinvd,
>  	.fix_hypercall       = emulator_fix_hypercall,
>  	.intercept           = emulator_intercept,
> +	.is_cpuid_allowed    = emulator_is_cpuid_allowed,
>  	.get_cpuid           = emulator_get_cpuid,
>  	.guest_has_movbe     = emulator_guest_has_movbe,
>  	.guest_has_fxsr      = emulator_guest_has_fxsr,

