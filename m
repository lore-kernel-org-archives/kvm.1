Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE926361DB5
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 00:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778806250; cv=none; b=B7HXG8baV1QhgOF4+MH6q52v6zwBpNNNkdui7jJPNBY+7WTYYrdIoXGCK36lZdjAePJI19u20PPl90fwP3X8Go5ksR937D2OE9yF5PEbciqKhpk+XAvf7v7+399YsCy2t3Z2StuCuIVvcK2U1r5S60QH8ru+SGfaDsknuWPcewo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778806250; c=relaxed/simple;
	bh=h7Upm6hanRPa8t4Q5yy6PC2p8UsW/PSB9wgvmGa0/80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ui5wVfQOla2Y7n0dVXyhj/hWZ8ASATjSFV1MuA8dBNx4e9+Z2y9cVIBxkxN1yHwv73B7NiCUDdLxQprUnbjmgvOElDTwdZ/ev2EDb7isMXA2Fs0apmW683WGlEldzmQnsWhxmgNNU/tzmLInvfJ0mX9MEEZgyc1REzIzh2xVack=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z5xqTjaF; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5xqTjaF"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-835423c69ffso5218109b3a.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 17:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778806242; x=1779411042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XHCf4Mys3KBnvWizfXSQ9VTTMoqyl00aLYdh0iKDKZg=;
        b=Z5xqTjaFxqw/lgfQO3LRdR+i7zVcBPP/RUVm8zGPwvpWVuCjK2n4/YG2FyQgWSGDQ9
         Oc0Go6hBWw0uhwWBWWzZIvHjgF+IjbRUzW80r6Or86J2Dh9dj0brumUwO7RluK1JW9ry
         NoAD6cpKy4FocBfyH4hmYwsw/B/BW/PeRyrlQSPPdzOK7egSjdVYBKyfdpt7yFr73O74
         /GSjnOYDl6R/dG5yZDaUAvOMDht7tTUJPiCfii7YL7gm9HiLzKW8omy4z3W9sHsdVTL8
         siuz9yEgFenJEc0Sz+JuMDXspRrp385YzTQSY4uoFY1RJCtV1XP4Ysp8QTN8S3qu5Ldd
         madQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778806242; x=1779411042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHCf4Mys3KBnvWizfXSQ9VTTMoqyl00aLYdh0iKDKZg=;
        b=mig7p2JbFdKEIJJsEfFu05e4gPDl0AIAfMLlJa/KY2bHCS6aNBjvVdR7lQAlnRNAQ+
         v61MOcr1gyLsiA2KMKecEtiJFNQjPHCzjGZmQUQl5CWJXr1ulVPfcKRFUWRvlbWTWxi+
         cfKDyzrmnbcT15FFraGl6oxebT0rBxndNKgNlgo8lfMCI5eXQ99M9kJpWyF5BHRpRFlM
         TcGuj5E0BEBkJaEZ5c4Mh5dNj8ifCPcoXJN03iGVqiTig8drXoWj6QrpXXQgACkAPiwR
         LbEIJZA+hhdESXYABEMhwn8dJVASUrG6Wv0XF+SvtWak5q4iA3jh5hln6CWDDOfk/ycC
         hI6w==
X-Forwarded-Encrypted: i=1; AFNElJ8ZMkeuzdFL+oN1Xt+yIrDORTj892esK7u5W2cI+eZfL3iNZYSmrSxzmuYMDQ8Lr1wpVjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaVKduM48yqF0NexpIBTaUPgPs5+B7J90fIU5/FuYGR49coBr7
	fJ4iyctR2Pm/9kEOt+zbfUXH4Krlhm7nOASB7X5sXBGHNexEemuC+PbSR6Y4SySXVXOiN4lvyXK
	o2WigjA==
X-Received: from pfmm23.prod.google.com ([2002:a05:6a00:2497:b0:82f:6a88:310b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1709:b0:82f:9aa:d63d
 with SMTP id d2e1a72fcca58-83f33d3337amr1669440b3a.49.1778806241653; Thu, 14
 May 2026 17:50:41 -0700 (PDT)
Date: Thu, 14 May 2026 17:50:41 -0700
In-Reply-To: <agUgeO5QNenQM9pT@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260107235724.28101-1-aidan@aktech.ai> <20260107235724.28101-2-aidan@aktech.ai>
 <agUgeO5QNenQM9pT@google.com>
Message-ID: <agZt4V4Ur8cQgikY@google.com>
Subject: Re: [PATCH v1 1/1] KVM: x86: Merge pending debug causes when
 vectoring #DB
From: Sean Christopherson <seanjc@google.com>
To: Aidan Khoury <aidan@aktech.ai>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Aidan Khoury <aidan@revers.engineering>, 
	Nick Peterson <everdox@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 13, 2026, Sean Christopherson wrote:
> On Wed, Jan 07, 2026, Aidan Khoury wrote:
> So while I don't exactly love the idea, I think this?  Compile tested only at
> this point, I'll try to properly test it tomorrow.

Confirmed the below works, once I remembered how to configure debug breakpoints.
I'll plan on sending a v2 on your behalf, along with a KVM-Unit-Test testcase.

> ---
>  arch/x86/include/asm/kvm-x86-ops.h | 1 +
>  arch/x86/include/asm/kvm_host.h    | 1 +
>  arch/x86/kvm/vmx/main.c            | 9 +++++++++
>  arch/x86/kvm/vmx/vmx.c             | 6 ++++++
>  arch/x86/kvm/vmx/x86_ops.h         | 1 +
>  arch/x86/kvm/x86.c                 | 8 ++++++++
>  6 files changed, 26 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index b0269325646c..3e04a7ecbb47 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -51,6 +51,7 @@ KVM_X86_OP(get_gdt)
>  KVM_X86_OP(set_gdt)
>  KVM_X86_OP(sync_dirty_debug_regs)
>  KVM_X86_OP(set_dr7)
> +KVM_X86_OP_OPTIONAL_RET0(get_pending_dbg_exceptions)
>  KVM_X86_OP(cache_reg)
>  KVM_X86_OP(get_rflags)
>  KVM_X86_OP(set_rflags)
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 271bdd109a98..eaac6ba59591 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1834,6 +1834,7 @@ struct kvm_x86_ops {
>  	void (*set_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
>  	void (*sync_dirty_debug_regs)(struct kvm_vcpu *vcpu);
>  	void (*set_dr7)(struct kvm_vcpu *vcpu, unsigned long value);
> +	unsigned long (*get_pending_dbg_exceptions)(struct kvm_vcpu *vcpu);
>  	void (*cache_reg)(struct kvm_vcpu *vcpu, enum kvm_reg reg);
>  	unsigned long (*get_rflags)(struct kvm_vcpu *vcpu);
>  	void (*set_rflags)(struct kvm_vcpu *vcpu, unsigned long rflags);
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index 83d9921277ea..a0e67471bff1 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -470,6 +470,14 @@ static void vt_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
>  	vmx_set_dr7(vcpu, val);
>  }
>  
> +static unsigned long vt_get_pending_dbg_exceptions(struct kvm_vcpu *vcpu)
> +{
> +	if (WARN_ON_ONCE(is_td_vcpu(vcpu)))
> +		return 0;
> +
> +	return vmx_get_pending_dbg_exceptions(vcpu);
> +}
> +
>  static void vt_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
>  {
>  	/*
> @@ -928,6 +936,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
>  	.get_gdt = vt_op(get_gdt),
>  	.set_gdt = vt_op(set_gdt),
>  	.set_dr7 = vt_op(set_dr7),
> +	.get_pending_dbg_exceptions = vt_op(get_pending_dbg_exceptions),
>  	.sync_dirty_debug_regs = vt_op(sync_dirty_debug_regs),
>  	.cache_reg = vt_op(cache_reg),
>  	.get_rflags = vt_op(get_rflags),
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 3a47a21dd499..7f84644a5c49 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5822,6 +5822,12 @@ void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
>  	vmcs_writel(GUEST_DR7, val);
>  }
>  
> +unsigned long vmx_get_pending_dbg_exceptions(struct kvm_vcpu *vcpu)
> +{
> +	return vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS) &
> +               (DR6_RTM | DR6_BS | DR_TRAP_BITS);
> +}
> +
>  static int handle_tpr_below_threshold(struct kvm_vcpu *vcpu)
>  {
>  	kvm_apic_update_ppr(vcpu);
> diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
> index 409858074246..5cfbd4e66f08 100644
> --- a/arch/x86/kvm/vmx/x86_ops.h
> +++ b/arch/x86/kvm/vmx/x86_ops.h
> @@ -75,6 +75,7 @@ void vmx_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
>  void vmx_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
>  void vmx_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
>  void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val);
> +unsigned long vmx_get_pending_dbg_exceptions(struct kvm_vcpu *vcpu);
>  void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu);
>  void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg);
>  unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 72ba1fc1bed2..8b32ab11f888 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -868,6 +868,14 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu, unsigned int nr,
>  		vcpu->arch.exception.vector = nr;
>  		vcpu->arch.exception.error_code = error_code;
>  		vcpu->arch.exception.has_payload = has_payload;
> +		/*
> +		 * VMX records deferred debug causes (B0-B3, enabled breakpoint,
> +		 * BS, RTM) in the vmcs.PENDING_DBG_EXCEPTIONS field.  Merge any
> +		 * pending causes into the exception payload so the guest may
> +		 * see all accumulated reasons in DR6 when the #DB is vectored.
> +		 */
> +		if (nr == DB_VECTOR && has_payload)
> +			payload |= kvm_x86_call(get_pending_dbg_exceptions)(vcpu);
>  		vcpu->arch.exception.payload = payload;
>  		return;
>  	}
> 
> base-commit: b72a08c022f2dae4bca6f4edde5fe8012a02aefa
> --
