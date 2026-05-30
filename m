Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC45257851;
	Sat, 30 May 2026 00:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102124; cv=none; b=gId5XuxHRhu2X3m3EXKun11SoaSh2XvCLPtOzARSiPHEJG8rPR2Foa+WuDJYX9GwYKkg4CJiyFyc2IyWYvLlk1EnRCXoxubY3net9Mu3eTfhBqJTYHKwGKiseQvWBaTdIMqZXcLs2IMjytLgQdaLJ+g0LWxtqdWOxZWGhcmyQm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102124; c=relaxed/simple;
	bh=U1orjGYc9pA6oaGg92CtRpDHA8eocVLIWXwUhY3Ji7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUKfqpNwUts9lvj+RbPHuWigBMG+5i+nxrBRDuHWTmrH2AcBnMIoqXq12QyQN7q6ecU9XVYtw2DPK/a5y/4nbgsHZvNrFhGgsBsDLdc171kGx1BTBWcHzta7mcd6Or8bnGAnAkWaOa79q/BqJK0nhIB8zr9FseTClFRhHp3lhqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLw64kok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLw64kok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC071F00893;
	Sat, 30 May 2026 00:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102123;
	bh=yT1Td505mybG5VOOd7MDPwpRizo42iwQ+aVtyW+ASm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PLw64kok9R4XoV9Xb5C9ALDibAq8tNTHYE0/gXTf3cN0mQTL3TXpib+HsLaPPWpjN
	 tAm/mjWaIYLwcYO+Pu6xcdw2x+4Xvv2uE6Jz3domDjLrH+w5B3S0uaMwwsSJ4NjN/N
	 cdPSX2ZKUTILzy29XqCl4KWSZyB95huoioI+Mpn+n2fpKHlS2FeLeAHQ+OcVPqY/7W
	 4C+l4q9168ycolvNxTjmRk9VRPE5u2jEx8Qtp3ZkvSrDiFjKPMQQ8WMPsXCHJGQsWv
	 0SAXZUOFVKMorykndm7PBHic+a7OLVmSEeRMn2Fu5KHoBiky9Y3lQvao6brK9ryOYi
	 DltFPZrvGQgMA==
Date: Sat, 30 May 2026 00:48:42 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 19/40] KVM: x86: Swap the include order between x86.h
 and mmu.h
Message-ID: <ahozqrW-YUAOEZls@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-20-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-20-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:02PM -0700, Sean Christopherson wrote:
> Invert the include ordering between x86.h and mmu.h, so that x86.h is the
> "top-level" include for KVM x86.

You're also silently moving mmu_is_nested().

Aside from that, I thought top-level include means that other headers
will include it, and it will include fewer headers. Seems like this is
doing the opposite?

> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu.h | 6 +++++-
>  arch/x86/kvm/x86.h | 6 +-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index e1bb663ebbd5..28fca48dcf64 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -4,7 +4,6 @@
>  
>  #include <linux/kvm_host.h>
>  #include "regs.h"
> -#include "x86.h"
>  #include "cpuid.h"
>  
>  extern bool __read_mostly enable_mmio_caching;
> @@ -300,6 +299,11 @@ static inline void kvm_update_page_stats(struct kvm *kvm, int level, int count)
>  	atomic64_add(count, &kvm->stat.pages[level - 1]);
>  }
>  
> +static inline bool mmu_is_nested(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->arch.walk_mmu == &vcpu->arch.nested_mmu;
> +}
> +
>  static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
>  				      struct kvm_mmu *mmu,
>  				      gpa_t gpa, u64 access,
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index b7d3b54cde15..a0e68eaf1f80 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -6,6 +6,7 @@
>  #include <asm/fpu/xstate.h>
>  #include <asm/mce.h>
>  #include <asm/pvclock.h>
> +#include "mmu.h"
>  #include "regs.h"
>  #include "kvm_emulate.h"
>  #include "cpuid.h"
> @@ -210,11 +211,6 @@ static inline bool x86_exception_has_error_code(unsigned int vector)
>  	return (1U << vector) & exception_has_error_code;
>  }
>  
> -static inline bool mmu_is_nested(struct kvm_vcpu *vcpu)
> -{
> -	return vcpu->arch.walk_mmu == &vcpu->arch.nested_mmu;
> -}
> -
>  static inline u8 vcpu_virt_addr_bits(struct kvm_vcpu *vcpu)
>  {
>  	return kvm_is_cr4_bit_set(vcpu, X86_CR4_LA57) ? 57 : 48;
> -- 
> 2.54.0.823.g6e5bcc1fc9-goog
> 
