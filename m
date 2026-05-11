Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB2B30B50D
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513037; cv=none; b=RWSi73ZYmPqmORe1bAArhRveuzIifX0wkoO7lPlHnaluWAka+57NRJ9und3g7ePe3RQkKNCuDgp1tl8Nbait5nQecWEPa5n9h6Tj4T5HZUeuG523lNW56yDVjjhRITC/mJCmRSYIrLwBEdcKzJWyIhHjCadU9BczRn/5a8EoCzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513037; c=relaxed/simple;
	bh=s/UJ8hPzD5D9QR4hg0mEoFlzx2GCqf77Zmajfb305kg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XuYDMlcVR3nNR3R7OI3mUvOONMqkIQDHxzRawhDjl2j3BxBb5bDjYl0Dhavsv2Yhu0GyQ3tLNpg3lA/nbgnhs3pJNTlKR5EkPqkuliuigLsyvcC+vkNx0OcGowDChLbBlymSEu4/1h4ZwjxjE+MoQbo9+4j/1dqpW9T0RW944ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cXPpdHZY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXPpdHZY"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc977e6aedso18630175ad.2
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778513036; x=1779117836; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G2MLFADvnNOuv2hkdSJ3+9BTtkHlP1NDEUIePsCBd6w=;
        b=cXPpdHZY9VOYf6A+UKJRBkk7YmdwWrQYbW3LiQqWTIgAn4JLZm8sRgOCxFxg2lnBt8
         kIzgtCMRG5/aoaxvwfV4Xj1BN6xH66Tb6aqw1lJF+MnUZ0BH7hhuRdzLpV/LVkp+EFzS
         zIpcIkX+6VSDB6ufw/a0KXnvs7Z6n4ilLTRrAn94PrfW7AWA2hOHQEnaf0PsyWDNEnnz
         b3Qgkzt3M3MktXFrvobRx3uXKQ0Sdm6papQhfm3TkjYPMM6dFxk8Flpxh9MxH8UR6YUN
         9pOEaYsb3CwdwHVGDWSi5hFbWUssnND8NpCe/a+FjNH7by3kZ6/x43/Y+QjJvNHxFEO/
         sAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778513036; x=1779117836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2MLFADvnNOuv2hkdSJ3+9BTtkHlP1NDEUIePsCBd6w=;
        b=DG1KNs/XGp0zhNQoshWQzbIW43v3UvXSf60wtLPMwfos4hyh3l0UlQtosHMW6wOtVI
         KUpnn/BktpHRMdfx1zepY6fFKnpK/UMjX6CiNF6W0h8AO1xkQv3vIJEb71BcdVywLwAR
         003idYo8U+rZ2QTVUB9u/bk4CylVlb2By9dukOUVwthLXZH3upctA77Aeu3XJrKEYH99
         pGpk2gpIRpxoQV9OLWmdth69652H3rmDaaKqXChWSAsRD9hCiBj8f6x2y/DdXX726Y3P
         TBOirSs+/q0IaFUtnV0dsoEZV32k+IblQx9j4BAhfYnkpUwMbE5BkJMwS1lk9d/yIXpn
         PkgA==
X-Gm-Message-State: AOJu0YzrE0A3JyC1JgnE6LHk+T/bHnPJPlWd9C/kSjZaOs5uH3peY8uD
	7tTPlVMdfrd8SzKiT90TAOEqTOUJ3UaAywq3EPpCIqiTcqymxieiXvn+F05pbIxmXQEQgWqOTnb
	2ubuL1w==
X-Received: from plhu11.prod.google.com ([2002:a17:903:124b:b0:2ba:792a:18a7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce0e:b0:2b4:5e0f:c239
 with SMTP id d9443c01a7336-2baf0d14b48mr148681805ad.10.1778513035464; Mon, 11
 May 2026 08:23:55 -0700 (PDT)
Date: Mon, 11 May 2026 08:23:54 -0700
In-Reply-To: <9b859ab6a6b59e5ccfdac741459117996fe2da6e.1766066076.git.houwenlong.hwl@antgroup.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1766066076.git.houwenlong.hwl@antgroup.com> <9b859ab6a6b59e5ccfdac741459117996fe2da6e.1766066076.git.houwenlong.hwl@antgroup.com>
Message-ID: <agH0itaqWpc90adG@google.com>
Subject: Re: [PATCH v2 2/9] KVM: x86: Set guest DR6 by kvm_queue_exception_p()
 in instruction emulation
From: Sean Christopherson <seanjc@google.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: kvm@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Dec 18, 2025, Hou Wenlong wrote:
> Record DR6 in emulate_db() and use kvm_queue_exception_p() to set DR6
> instead of directly using kvm_set_dr6() in emulation, which keeps the
> handling of DR6 during #DB injection consistent with other code paths.
> 
> No functional change intended.
> 
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> ---
>  arch/x86/kvm/emulate.c     | 14 ++++----------
>  arch/x86/kvm/kvm_emulate.h |  6 +++++-
>  arch/x86/kvm/x86.c         |  5 ++++-
>  3 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index c8e292e9a24d..997cd6e46d90 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -540,8 +540,9 @@ static int emulate_exception(struct x86_emulate_ctxt *ctxt, int vec,
>  	return X86EMUL_PROPAGATE_FAULT;
>  }
>  
> -static int emulate_db(struct x86_emulate_ctxt *ctxt)
> +static int emulate_db(struct x86_emulate_ctxt *ctxt, unsigned long dr6)
>  {
> +	ctxt->exception.dr6 = dr6;
>  	return emulate_exception(ctxt, DB_VECTOR, 0, false);
>  }
>  
> @@ -3834,15 +3835,8 @@ static int check_dr_read(struct x86_emulate_ctxt *ctxt)
>  	if ((cr4 & X86_CR4_DE) && (dr == 4 || dr == 5))
>  		return emulate_ud(ctxt);
>  
> -	if (ctxt->ops->get_dr(ctxt, 7) & DR7_GD) {
> -		ulong dr6;
> -
> -		dr6 = ctxt->ops->get_dr(ctxt, 6);
> -		dr6 &= ~DR_TRAP_BITS;
> -		dr6 |= DR6_BD | DR6_ACTIVE_LOW;
> -		ctxt->ops->set_dr(ctxt, 6, dr6);
> -		return emulate_db(ctxt);
> -	}
> +	if (ctxt->ops->get_dr(ctxt, 7) & DR7_GD)
> +		return emulate_db(ctxt, DR6_BD);
>  
>  	return X86EMUL_CONTINUE;
>  }
> diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
> index fb3dab4b5a53..7fe38b174e18 100644
> --- a/arch/x86/kvm/kvm_emulate.h
> +++ b/arch/x86/kvm/kvm_emulate.h
> @@ -24,7 +24,11 @@ struct x86_exception {
>  	bool error_code_valid;
>  	u16 error_code;
>  	bool nested_page_fault;
> -	u64 address; /* cr2 or nested page fault gpa */
> +	union {
> +		u64 address; /* cr2 or nested page fault gpa */
> +		unsigned long dr6;
> +		u64 payload;

Please split the introduction of the union to a separate patch, mainly so that
the effectively zeroing of ctxt.exception.address in init_emulate_ctxt() is
isolated, e.g. in case it somehow causes problems.  But that will also allow
introducing the inject_emulated_exception() change separately from the
check_dr_read() change.

> +	};
>  	u8 async_page_fault;
>  	unsigned long exit_qualification;
>  };
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ab298bfa7d9f..f33ce947633e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8925,7 +8925,9 @@ static void inject_emulated_exception(struct kvm_vcpu *vcpu)
>  {
>  	struct x86_exception *ex = &vcpu->arch.emulate_ctxt->exception;
>  
> -	if (ex->vector == PF_VECTOR)
> +	if (ex->vector == DB_VECTOR)
> +		kvm_queue_exception_e(vcpu, DB_VECTOR, ex->dr6);

This should be kvm_queue_exception_p().  I also think pivoting on DB_VECTOR is
the wrong approach.  Rather than key off the vector, add payload_valid (to match
error_code_valid), and then do:

	struct x86_exception *ex = &vcpu->arch.emulate_ctxt->exception;

	WARN_ON_ONCE(ex->vector != PF_VECTOR && ex->payload_valid &&
		     ex->error_code_valid);

	if (ex->vector == PF_VECTOR)
		kvm_inject_emulated_page_fault(vcpu, ex);
	else if (ex->payload_valid)
		kvm_queue_exception_p(vcpu, DB_VECTOR, ex->payload);
	else if (ex->error_code_valid)
		kvm_queue_exception_e(vcpu, ex->vector, ex->error_code);
	else
		kvm_queue_exception(vcpu, ex->vector);

PF_VECTOR is special because it has both an error code and a payload, and because
it needs additional handling on multiple fronts.

> +	else if (ex->vector == PF_VECTOR)
>  		kvm_inject_emulated_page_fault(vcpu, ex);
>  	else if (ex->error_code_valid)
>  		kvm_queue_exception_e(vcpu, ex->vector, ex->error_code);
> @@ -8970,6 +8972,7 @@ static void init_emulate_ctxt(struct kvm_vcpu *vcpu)
>  	ctxt->interruptibility = 0;
>  	ctxt->have_exception = false;
>  	ctxt->exception.vector = -1;
> +	ctxt->exception.payload = 0;
>  	ctxt->perm_ok = false;
>  
>  	init_decode_cache(ctxt);
> -- 
> 2.31.1
> 
