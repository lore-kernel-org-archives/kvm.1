Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F24317141;
	Tue,  3 Mar 2026 01:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772501239; cv=none; b=BcVG/TirTrXjgWOAlhD7YNeKS/cgiVQ2ZD2WXbLk5QXixVb3yS7jkCklwrBgP4a+2cFQIEGMTQU59jBI5+Y8sG7DhtlAl6IkMbUOxIGB9K3XKA0kCjkPhcK8d0w0G5515kQcH+lXwDKFLVPESuEx2DeY7YXeTYMNaaCcI6/Bxzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772501239; c=relaxed/simple;
	bh=M68Ea8+kZPl6nrDCULmcQKymW9gQgjqt2kNxgdqx9sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSbPBJkdpbRTSpwHTBcwNs35V8QXaSJAutqj8CNoKfdxB9Y9/ONn0ImXmvCixPdci8qtmbPwRRCucS2p5lMIJ+AjRxtW4L5BoDBnqpAdV4dL/QpSNo9236UjvRoo+SZ4hF+XD1DuZCc+MkpUN1bTHHHXPD3jqQKA0KPX3mXWgf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qBeC5k4h; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qBeC5k4h"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772501227; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=SH2hy434QhUqOlhevSfT8Iwl/u3pgTETceJF/Zb+GXc=;
	b=qBeC5k4hfDtCZHm8K0egvLS486MY+ZtxAjBfEcgCCf2n0KjPlRxL6pmWEFD6zjkMAj3Ev2+wQOr35yVjy68jFzlS22CYhdSjVCiOgVCY1RgfyoaZy+Nx+kFxYK5QNGfa826jmtc5SchVUdO+AQEShoY6TtLaUTDRoQjyQOFOnrI=
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com fp:SMTPD_---0X-7ntfc_1772501226 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Mar 2026 09:27:07 +0800
Date: Tue, 3 Mar 2026 09:27:06 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] KVM: x86: Immediately fail the build when possible if
 required #define is missing
Message-ID: <s2bcfi5jp4qqa5zskbpc6w34stysw7bcqwixqhechlpskza4dl@t4kw7uplhxmr>
References: <20260302212619.710873-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302212619.710873-1-seanjc@google.com>

On Mon, Mar 02, 2026 at 01:26:19PM +0800, Sean Christopherson wrote:
> Guard usage of the must-be-defined macros in KVM's multi-include headers
> with the existing #ifdefs that attempt to alert the developer to a missing
> macro, and spit out an explicit #error message if a macro is missing, as
> referencing the missing macro completely defeats the purpose of the #ifdef
> (the compiler spews a ton of error messages and buries the targeted error
> message).
>
> Suggested-by: Alexey Dobriyan <adobriyan@gmail.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm-x86-ops.h     | 10 ++++++----
>  arch/x86/include/asm/kvm-x86-pmu-ops.h |  8 +++++---
>  arch/x86/kvm/vmx/vmcs_shadow_fields.h  |  5 +++--
>  3 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index de709fb5bd76..3776cf5382a2 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -1,8 +1,9 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#if !defined(KVM_X86_OP) || !defined(KVM_X86_OP_OPTIONAL)
> -BUILD_BUG_ON(1)
> -#endif
> -
> +#if !defined(KVM_X86_OP) || \
> +    !defined(KVM_X86_OP_OPTIONAL) || \
> +    !defined(KVM_X86_OP_OPTIONAL_RET0)
> +#error Missing one or more KVM_X86_OP #defines

More clear than the BUILD_BUG_ON(1) to me.

Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>

> +#else
>  /*
>   * KVM_X86_OP() and KVM_X86_OP_OPTIONAL() are used to help generate
>   * both DECLARE/DEFINE_STATIC_CALL() invocations and
> @@ -148,6 +149,7 @@ KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
>  KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
>  KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
>  KVM_X86_OP_OPTIONAL(gmem_invalidate)
> +#endif
>
>  #undef KVM_X86_OP
>  #undef KVM_X86_OP_OPTIONAL
> diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> index f0aa6996811f..d5452b3433b7 100644
> --- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> @@ -1,7 +1,8 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#if !defined(KVM_X86_PMU_OP) || !defined(KVM_X86_PMU_OP_OPTIONAL)
> -BUILD_BUG_ON(1)
> -#endif
> +#if !defined(KVM_X86_PMU_OP) || \
> +    !defined(KVM_X86_PMU_OP_OPTIONAL)
> +#error Missing one or more KVM_X86_PMU_OP #defines
> +#else
>
>  /*
>   * KVM_X86_PMU_OP() and KVM_X86_PMU_OP_OPTIONAL() are used to help generate
> @@ -26,6 +27,7 @@ KVM_X86_PMU_OP_OPTIONAL(cleanup)
>  KVM_X86_PMU_OP_OPTIONAL(write_global_ctrl)
>  KVM_X86_PMU_OP(mediated_load)
>  KVM_X86_PMU_OP(mediated_put)
> +#endif
>
>  #undef KVM_X86_PMU_OP
>  #undef KVM_X86_PMU_OP_OPTIONAL
> diff --git a/arch/x86/kvm/vmx/vmcs_shadow_fields.h b/arch/x86/kvm/vmx/vmcs_shadow_fields.h
> index cad128d1657b..67e821c2be6d 100644
> --- a/arch/x86/kvm/vmx/vmcs_shadow_fields.h
> +++ b/arch/x86/kvm/vmx/vmcs_shadow_fields.h
> @@ -1,6 +1,6 @@
>  #if !defined(SHADOW_FIELD_RO) && !defined(SHADOW_FIELD_RW)
> -BUILD_BUG_ON(1)
> -#endif
> +#error Must #define at least one of SHADOW_FIELD_RO or SHADOW_FIELD_RW
> +#else
>
>  #ifndef SHADOW_FIELD_RO
>  #define SHADOW_FIELD_RO(x, y)
> @@ -74,6 +74,7 @@ SHADOW_FIELD_RW(HOST_GS_BASE, host_gs_base)
>  /* 64-bit */
>  SHADOW_FIELD_RO(GUEST_PHYSICAL_ADDRESS, guest_physical_address)
>  SHADOW_FIELD_RO(GUEST_PHYSICAL_ADDRESS_HIGH, guest_physical_address)
> +#endif
>
>  #undef SHADOW_FIELD_RO
>  #undef SHADOW_FIELD_RW
>
> base-commit: 183bb0ce8c77b0fd1fb25874112bc8751a461e49
> --
> 2.53.0.473.g4a7958ca14-goog
>
