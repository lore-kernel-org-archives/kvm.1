Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA34403E9A
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095551; cv=none; b=c2x+7ZHxEzMI4XYgwrEzpgmf960RCbg5iuWDn/R1+cOVPpq7K0GpGkUYH1Yy28r/5A6uGeEH5mw/8tnwkBo3KfHYuV1gU84Sic6gh2eG0NHqz5wxe6vMcOfSLP4pTLmhCkmjD8VuLJyz2CgBqgzdKf7WZ4BpwIf2lkAv6k6IvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095551; c=relaxed/simple;
	bh=ZDtoHAg0RVYLJFl411rVT6pojkbYcRqIGwO9uqRapX0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H3VTP/jCx/WNAlpHbsdqxwC6wPzTfq9PTSHut+5jGJexDuI89v4eFVsIKwdj+1m/PW/y/APG9NkK7geM02um13rtzYCm+EB3p6lbGa2L99gFo6bTgWbiOEuMv21tpEC6CVYmm9qPgaUnbhXeS8WZSyLUDqHjftOintALndFevXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mkl1Ngmk; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mkl1Ngmk"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a2f19558so3826569a12.2
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781095549; x=1781700349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BekvPjo4s9TiFe+KHAujjPKkPO/Dd5UZ6PvZoUWkBvE=;
        b=mkl1NgmkhNuqgwdWZVc3nq3ZBi1ysas/5Wqg6bWTJwegC6db/dJo6dfeBre5XZmopu
         6DHkfmNcgXqZXLWla0yoBOzhMe6YjNWNLJOJgcZ1p2ttrfZm7aXPrllj73ZHlcgA7/Bk
         UO/FIkP6nWJ0RSNr9Wc1zKozWa6kRcgNW9457++Ab1a3EoFh8LAoaVCWhUEojFMBmKBt
         L4g8QkCMtpjwGNzUxd7K9RNHdjIjoG1i7pf+xwI+Ddvki85tk7FRLJKJKH5YKNbvaOjb
         u8DCEDAgcAsjH3mbNihey9oWl+LyOXi+HdoRMBBvREg3qi4zoOI0xy5IhVyKDkr3d5Ob
         vR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095549; x=1781700349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BekvPjo4s9TiFe+KHAujjPKkPO/Dd5UZ6PvZoUWkBvE=;
        b=rCuzlD4yS3dFLLzSIHTBhuq8l5Tq7gHIoGrm9rQ7QBBZ2pEfeLF6gqnbd6UB/5UxUf
         vipeb+hAxfkNVrJgNJwwTVtnrsr7u081bYDpuWQ3NkUCUH5c1WcEdIKd9uWYYWN4PawT
         WYqix4xiCE4NNG4wWeo1x7xLUu4DpLQJGl8s2vr8v+LA5ZPXXO7hI0UrvJnL2wCrn8h1
         MApJEJyE6hq8OaVa02f5ybJ5LZsAbB9ztjVz9+X6AKVKz+OrmqNh0/a/0UhGHkDkxaQa
         f26EkPZpYDrz1KDv1a8wC5axP6etb31NRA+rJHhuz+OtXretYcAOeYGwwsgM1UC0tBXG
         yomQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CHpxcs6IhmfNqRN5B38fdCM33qlUvj+4fAWdXz4UI+X1rUO2173hFa0owaDxgzXZmL5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YycKLk88bYu557GBap/nzKu5covL+UUT7UhpjFVDgZyeRCqGvZ9
	zsFFQ11jd+4jWWNevtChEgD3NLROSKclNwZIdEHgtNqL+Gk+koi9HyzSsKSv+EPlcPTabmicp4D
	h7OmHKQ==
X-Received: from pfms4.prod.google.com ([2002:aa7:8284:0:b0:842:6fe1:8620])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:84b:b0:842:6004:3fd5
 with SMTP id d2e1a72fcca58-842b0f4ed9dmr26896280b3a.25.1781095548452; Wed, 10
 Jun 2026 05:45:48 -0700 (PDT)
Date: Wed, 10 Jun 2026 05:45:47 -0700
In-Reply-To: <20260610070512.85463-1-m18700951735@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610070512.85463-1-m18700951735@163.com>
Message-ID: <ailce3eU59J4bv6x@google.com>
Subject: Re: [PATCH] KVM: SVM: Clear dummy V_IRQ in vmcb01 when deactivating AVIC
From: Sean Christopherson <seanjc@google.com>
To: xin guo <m18700951735@163.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 10, 2026, xin guo wrote:
> When KVM requests an IRQ window via svm_set_vintr(), it programs a
> dummy VINTR with int_vector=0 and V_IRQ=1 into the current VMCB.
> These int_ctl fields are documented to be ignored while AVIC is
> enabled, so the dummy VINTR is harmless during AVIC operation.
> 
> However, avic_deactivate_vmcb() only clears AVIC_ENABLE_MASK and
> X2APIC_MODE_MASK, and does not clear the VINTR injection state. Once
> AVIC is disabled, hardware honors V_IRQ again and injects vector 0
> into the guest on the next VMRUN. Windows guests observe this as a
> spurious interrupt and crash, e.g. with STATUS_INTEGER_DIVIDE_BY_ZERO.

Can you provide a reproducer, or at least instructions to reproduce?  This feels
like we're treating a symptom, not the underlying bug.  And while I can definitely
see KVM leaving a stale V_IRQ_MASK in vmcb01, I don't see how that can happen
while also clearing INTERCEPT_VINTR, as the only place INTERCEPT_VINTR is cleared
in vmcb01 is svm_clear_vintr(), which also purges V_IRQ_MASK.

	svm_clr_intercept(svm, INTERCEPT_VINTR);

	/* Drop int_ctl fields related to VINTR injection.  */
	svm->vmcb->control.int_ctl &= ~V_IRQ_INJECTION_BITS_MASK;

> Fix this by also clearing V_IRQ_INJECTION_BITS_MASK from vmcb01's
> int_ctl in avic_deactivate_vmcb(), so that no stale dummy VINTR is
> left behind when AVIC transitions from enabled to disabled.
> 
> Signed-off-by: xin guo <m18700951735@163.com>
> ---
>  arch/x86/kvm/svm/avic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index cdd5a6dc646f..b042c3f5f90e 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -257,7 +257,9 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
>  {
>  	struct vmcb *vmcb = svm->vmcb01.ptr;
>  
> -	vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
> +	vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK |
> +				V_IRQ_INJECTION_BITS_MASK);
> +
>  	vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
>  
>  	if (!is_sev_es_guest(&svm->vcpu))
> -- 
> 2.27.0
> 
