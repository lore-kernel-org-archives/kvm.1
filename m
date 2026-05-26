Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F596377009;
	Tue, 26 May 2026 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824117; cv=none; b=Y+2qJfQoXrK5nNgCxBtWVFzIxl5m8akR08YkjnJTE5Gh8HzAiBWBaFnWvb7ToBE7rTxV9Nuv+lANgYu7Lwpf7nHHb29bMFUeAhZ5apvK3AwS6TdI/NyAhNaA29ZgYisN4/HauHTUUZ3Qakl70XPHvi8i20InA8pZp3pZS5AiS9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824117; c=relaxed/simple;
	bh=odo8NTIQ0dTJqfJ9cjC18K0+ZBsCnrh6snt1thkGFhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5hmDVDtOiBVNfcZKgHQ3A4tWypyC/9eVYahSQOO2Pdteyui2NsnQaxgnQ/GmNmVd8NNHgzmIEkfaYdC06+C/NzjUNu0+s6MiwwEr2goEFdLFdzz9APzlwQV/YCRUIEpNFlPypAVgIMLZDdHG3/MDdl78pR7IMx/EFT9GRr2joU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GK8EOjS/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GK8EOjS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E531F000E9;
	Tue, 26 May 2026 19:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779824116;
	bh=zCHYwAhMAGk6oeQDjijUVO8ob9Vx+9syF8qD2oS+U2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GK8EOjS/H0sQwLkoicKKMlEMegTWCcQfkdFsliLJzr1oHWvoptR3bU6ftNI8cGqqe
	 rIbSrAKjknpLjmQ+/vUceg30Igqcoc31/WYSiJoalazETQ3Fc1yZs7Bjj26OZwJuxm
	 XSx/Z6zU0o2YpxGJ/o7wHVT/6yt4yBVSOSfQ6nzAMgID6pOfp0mqxMlPTyBKGlglT0
	 LlE6v6IfhyQ6b9wUCsaT3dh6bQrLqQXD2Kjuq1r/57IzxJiMzS0L8j/htISG8C6cP7
	 r28LtUMiuCb2Z7KyiogipPXZll1EumYmjfFrSiVAR3jaACC0bn0KcsnDb3jlYMSQCF
	 IaR729Wq1lLZg==
Date: Tue, 26 May 2026 12:35:10 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	Paolo Bonzini <bonzini@redhat.com>,
	Calvin Owens <calvin@wbinvd.org>
Subject: Re: [PATCH v3 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into
 x86 core
Message-ID: <20260526193510.GA2851089@ax162>
References: <20260423155611.216805954@infradead.org>
 <20260423155936.843498069@infradead.org>
 <20260508091829.GO3126523@noisy.programming.kicks-ass.net>
 <20260520230621.GA706311@ax162>
 <20260526090631.GA4149641@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526090631.GA4149641@noisy.programming.kicks-ass.net>

On Tue, May 26, 2026 at 11:06:31AM +0200, Peter Zijlstra wrote:
> 
> Sorry, I missed this :/

No worries, I should have pinged about it elsewhere sooner.

> Subject: x86/kvm/vmx: Fix x86_64 CFI build
> 
> I missed that idt_do_interrupt_irqoff() gets compiled on x84_64; this is
> a problem for CFI builds because it includes an unadorned indirect call.
> It is however completely dead code.
> 
> Rework things to not emit this function at all.
> 
> Fixes: 0701c9e17bd9 ("x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into x86 core")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Calvin Owens <calvin@wbinvd.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 06c7c6ebd6f9..14cd43d4da6c 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -55,7 +55,7 @@ noinstr void x86_entry_from_kvm(unsigned int event_type, unsigned int vector)
>  	 * The FRED NMI context is significantly different and will not work
>  	 * right (specifically FRED fixed the NMI recursion issue).
>  	 */
> -	idt_entry_from_kvm(vector);
> +	idt_do_nmi_irqoff();
>  }
>  EXPORT_SYMBOL_FOR_KVM(x86_entry_from_kvm);
>  #endif
> diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
> index a56e043b266d..2bc217bb5475 100644
> --- a/arch/x86/entry/entry.S
> +++ b/arch/x86/entry/entry.S
> @@ -109,11 +109,13 @@ EXPORT_SYMBOL(__ref_stack_chk_guard);
>  	RET
>  .endm
>  
> +#ifndef CONFIG_X86_64
>  .pushsection .text, "ax"
>  SYM_FUNC_START(idt_do_interrupt_irqoff)
>  	IDT_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
>  SYM_FUNC_END(idt_do_interrupt_irqoff)
>  .popsection
> +#endif
>  
>  .pushsection .noinstr.text, "ax"
>  SYM_FUNC_START(idt_do_nmi_irqoff)
> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index 7bcf1decc034..90a22e24a9eb 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -268,18 +268,10 @@ void __init idt_setup_early_pf(void)
>  }
>  #endif
>  
> -#if IS_ENABLED(CONFIG_KVM_INTEL)
> -noinstr void idt_entry_from_kvm(unsigned int vector)
> +#if IS_ENABLED(CONFIG_KVM_INTEL) && !defined(CONFIG_X86_64)
> +void idt_entry_from_kvm(unsigned int vector)
>  {
> -	if (vector == NMI_VECTOR)
> -		return idt_do_nmi_irqoff();
> -
> -	/*
> -	 * Only the NMI path requires noinstr.
> -	 */
> -	instrumentation_begin();
>  	idt_do_interrupt_irqoff(gate_offset(idt_table + vector));
> -	instrumentation_end();
>  }
>  #endif
>  

-- 
Cheers,
Nathan
