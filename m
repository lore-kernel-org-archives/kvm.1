Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525934503B;
	Sat, 30 May 2026 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102377; cv=none; b=HULEKkXCNgrmHGrSIdxdzcntG7GIZpNAtX0buRpNdduQLkfr/+ietB1pshfHVd/gi2EjTpmXty2nfVf9B7LIdn4dRBNcUmFNBpS2MBISxrFRSaqw8KtBJG8nk4zq8DZ3IWdyO1DmWGLzALq65BURAKDNqDI9tM4Xv92l5fSec0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102377; c=relaxed/simple;
	bh=oq4Z0lHB7EKa/ORvNRSWH2LdwfLF4VIDRoE3hFrlsFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BH4tuuDkDPLNIoGG0U+OVdH/j95RbJmd9/kaj4Nh2cr/7foTVVjvr7Em6bVejQY60pUyjfMyTsFNfoOk7xNJ51oiiqCgsduFoPgy9GEKa38y8n4HGH0C0wFmjAUdjr3fmL84SOdVLhPRAm2jOoth2uuPDXjpXj75mGBXltfZ1ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFSob8uN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFSob8uN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FC41F00893;
	Sat, 30 May 2026 00:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102376;
	bh=1GLV6mWkmB9veuiBRRujo03El95ESsXRTiuIZiCAxkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SFSob8uNsgT+jtD/24fp/b3k+oc4frnF9YYStSYYQETMPRatX6m2rCZNuwSnPjh2/
	 rQaEDNzOOmB2TJ9lJEFJcWptm2qzVhqM1oX2yiYmJVDuR6qjmTvjNGe5ZoQKoKhReK
	 N6DYAxpBybeLnD8ghUzDyjRParYga9bfHiRGMO6J39fAOZ3oNmckdyrjCKv1hm32X1
	 olqC6SthEAn+hActQTkyS6NPpcng5M0wPff2vUcSTY9v7ZiXQYAJ9nRPf1VsrWJHOl
	 4QB8FYwEwDKqSZfp2Kit0MIRurynXcdECPAAJudcIDBh1aANHDmEeKWdHxi6dAxIYD
	 /THwDR6cSVLGQ==
Date: Sat, 30 May 2026 00:52:54 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 23/40] KVM: x86: Move kvm_{load,put}_guest_fpu() to
 fpu.h
Message-ID: <aho0u2Yw4hrzpfJH@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-24-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-24-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:06PM -0700, Sean Christopherson wrote:
> Move the kvm_{load,put}_guest_fpu() helpers to fpu.h in anticipation of
> moving the bulk of KVM's register specific code out of x86.c.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>

> ---
>  arch/x86/kvm/fpu.h | 26 ++++++++++++++++++++++++++
>  arch/x86/kvm/x86.c | 24 ------------------------
>  2 files changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/kvm/fpu.h b/arch/x86/kvm/fpu.h
> index f898781b6a06..6b7b628f530d 100644
> --- a/arch/x86/kvm/fpu.h
> +++ b/arch/x86/kvm/fpu.h
> @@ -3,8 +3,34 @@
>  #ifndef __KVM_FPU_H_
>  #define __KVM_FPU_H_
>  
> +#include <linux/kvm_host.h>
> +
> +#include <trace/events/kvm.h>
> +
>  #include <asm/fpu/api.h>
>  
> +/* Swap (qemu) user FPU context for the guest FPU context. */

I didn't know KVM was allowed to break the fourth wall like this?

> +static inline void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
> +{
> +	if (KVM_BUG_ON(vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm))
> +		return;
> +
> +	/* Exclude PKRU, it's restored separately immediately after VM-Exit. */
> +	fpu_swap_kvm_fpstate(&vcpu->arch.guest_fpu, true);
> +	trace_kvm_fpu(1);
> +}
