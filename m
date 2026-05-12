Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33D3A63E1
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625099; cv=none; b=Aa4KMO8+JhMa9vhD9ICDhKqLmTgnx9EprEspTAeuy15607eWF73gqOt7z/sQjrh8tP3kFYoKlQ8nO11xuxYx1ktu0PbHLJzsShL0DnDMEdrBkreyZS3bioDwJW8v8K/0/i4ZZiTeMIhPihy4dLBztB8Zj6x9ye2YXMtlRWGfLrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625099; c=relaxed/simple;
	bh=bcVfxasbit4U2yzziAt1k9ONFCXfeXaWbNjOlT3ECP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hEka4eMaEqLBVbcnfVyiflo6/gtmSToGGf4bmnzvHDveAcRPAHn62z+K3y+LNHad90c1Rzhm7QN4XTsVJv0uTlgzzjSJhfU/wp47axUR0nVS3rN+aQTriP6s1fzCVBcC9j1qgxeTMhK3iI87+kJ73odQyyzDOSQQDLmwofkd0BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=joSHRhIC; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="joSHRhIC"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-367fd7b8825so3698190a91.0
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625097; x=1779229897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M7/ckcGX/26EFOsM99Da2/PEjvZTD7dt6PJubXtrn78=;
        b=joSHRhIC+/nH+3vJN0zqUJSQ4gysMKvBeXtMDR7EW93hOYfyrNVjI+W6H8wvfxEIeQ
         8rAJX7Yxyo3VXvHssz1yZzDwmnpJeS7Phoffu8mXIq192RbVHYqD/BcIWogqNqBy0sm/
         c+ts+GU7879UjxZZpXNzEjtCkltwwnm/JA2M9qq8au9qcaRTMEmF8SYuM4YZfG8GcE/w
         FXc4U6S13TyGH5NnxnFW6ac55pR0pL1+p5SgtM7R7uTx40USQ9C9vkniGDLlSKCMczZv
         aSIS3jfIsj8kDkJtZcDJ7jCJfSvRsQ5pJWCO0ASJncaO7OJ+EvfjNxm/mr5NNQ0Phdx9
         TiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625097; x=1779229897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7/ckcGX/26EFOsM99Da2/PEjvZTD7dt6PJubXtrn78=;
        b=PL72/f1Y0D52mvGxplznC8r5Fjzr21ueoel1L2D+AKCkyYhMhk0nEBQte0SSiX9bv8
         00mawdqCSZJTibF5qaBon51lBZjDkcUHmpr4ZzRmnpPnGfKvTP4MlOCeSdHFS+aKy+zE
         ceTd5zgzqr7GDuISJI3tk4Pj6ODZXGXQK2dLFUtkfdxWH5Mpbz0Sn6nvMg+/dYtd/5ht
         Pq6I1ulGIiS5NZTR3snM2F0+b4CiFV477L1GvLg5gqkvzfUxVrN1qgZeg7q5uhC2u3YX
         4eiXAko71k1+nBcsqXOfSUicMgkQmX6v6ptqQVBuShjDRQMPKYo1z8syZpSaGm27i6zP
         vLLw==
X-Forwarded-Encrypted: i=1; AFNElJ81ybea4zTIHn2FzV2KLoB9QiuaufmjPmAeSMyVoOu9GHngDmIu550no5Nq4Q5TyP5drB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvCFaHFEbn+pAIqw578/Y8msPgHdvOMsb16VFz/+/oCEWFMkXS
	faAT8KMRHbUtDqHCAyaXZoSLjB7EgLOm7Ba95QvS9IYa8qA4zCAhoF1mZv3ZSKOQVua6b7XG3YZ
	li8JtEg==
X-Received: from pjbsb13.prod.google.com ([2002:a17:90b:50cd:b0:368:a71f:a24a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c8a:b0:35d:a0b7:9608
 with SMTP id 98e67ed59e1d1-368f3aa426fmr918102a91.7.1778625096688; Tue, 12
 May 2026 15:31:36 -0700 (PDT)
Date: Tue, 12 May 2026 15:31:36 -0700
In-Reply-To: <20260508091829.GO3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423155611.216805954@infradead.org> <20260423155936.843498069@infradead.org>
 <20260508091829.GO3126523@noisy.programming.kicks-ass.net>
Message-ID: <agOqSCgHy7VSMvNl@google.com>
Subject: Re: [PATCH v3 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into
 x86 core
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Vishal L Verma <vishal.l.verma@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <bonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 08, 2026, Peter Zijlstra wrote:
> 
> Move the VMX interrupt dispatch magic into the x86 core code. This
> isolates KVM from the FRED/IDT decisions and reduces the amount of
> EXPORT_SYMBOL_FOR_KVM().
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Vishal L Verma <vishal.l.verma@intel.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

> @@ -7152,17 +7149,9 @@ static void handle_external_interrupt_ir
>  	    "unexpected VM-Exit interrupt info: 0x%x", intr_info))
>  		return;
>  
> -	/*
> -	 * Invoke the kernel's IRQ handler for the vector.  Use the FRED path
> -	 * when it's available even if FRED isn't fully enabled, e.g. even if
> -	 * FRED isn't supported in hardware, in order to avoid the indirect
> -	 * CALL in the non-FRED path.
> -	 */
> +	/* For the IRQ to the core kernel for processing. */

Forward?  Or just delete this comment entirely, either way works for me.

>  	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
> -	if (IS_ENABLED(CONFIG_X86_FRED))
> -		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
> -	else
> -		vmx_do_interrupt_irqoff(gate_offset((gate_desc *)host_idt_base + vector));
> +	x86_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
>  	kvm_after_interrupt(vcpu);
>  
>  	vcpu->arch.at_instruction_boundary = true;
