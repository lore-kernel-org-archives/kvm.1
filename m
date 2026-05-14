Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9B023C516
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 01:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720892; cv=none; b=jJvc4TE0o2sV1IT4FnMA2PQKR/xvzp/xH0NkGe7668FScyuP9Yl4h0fAqi6eRAHt3eWP7yR0o7BHpF0Ww0c17ZXwVC3XyZ+tdHLIEdS1JIJUN4fOBYm6fMOjsHrw1PyCbiG87huvNMaolvvnY7DDQbQ/kKUnMXRXyB2WDxQ7LFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720892; c=relaxed/simple;
	bh=NF4hCliR9EaleeSzdCewL/L194kNPkEflCkHl/Vd6uU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hD19zExpb5qvtbaMx3l3lY1BjJjPomkUnyYJX0i0f38eUSenVrx7swy0buezX8NDSW76V97jVCNm120y0T6cjqGmkZ6iydBOn4pxvCNkXEcWF0043Z5ZsMeldRL9nqmBVoFLdo3drFKcGv1PycaQnIxN4nPvxa91PPc6NVJOzgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C3P1JJaX; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C3P1JJaX"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-365e70c39d0so9278145a91.0
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 18:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778720889; x=1779325689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cmGPQQpI5YMO2nGNFfSvQ9Z5/5UzmiC4LcMYWd6WHeo=;
        b=C3P1JJaXIou8uFCO7H67kksAwTno44v1dy5ApwQMDLZx25MzhCENW9YGhwNpOgte+N
         Byt3jJqM7FgAyYH+JxTqzimAMjM6ZKURbO9M5VrjoOyPSdNB6kfVYTYLush6vrtumNTo
         S0BrZEP7tLcJOPDrHf/VLytLlEstRScrRh8US11COKkmy0zRQN/gBIaoXkg77zSa4mfZ
         A4ilKMj++SCEvawNuGRaRYK2ZPKBAQIeWpxYCH0L5VALv5rsUb1/3kbaRg/++Krw41ho
         3SzK4t9Dmr5N0Ff1TR4qmDlYxGVlt9TKr6gpaMbUqIwaX1smMdSSq9zEkyyC2M/ZmBjl
         N9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778720889; x=1779325689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmGPQQpI5YMO2nGNFfSvQ9Z5/5UzmiC4LcMYWd6WHeo=;
        b=Lvp3Y5Bz3G5s+OBBfhccxLziBegJHzQf1/C5Dm8kiiR2RI6YcS4LRbQZDnasZFfRCt
         tyCdWL9DpGOmu45Gmjqt9BsDGxADjXTYtE+4rWY+2+p60Ar7wLm/J8AqRgFQGie1MYor
         LMCZ5rruCaV9JYbNuWtu+8WRXraaeOIdYYJ4g+1THJKTxD0oHVz9zKpCmL/U20C/utHm
         l0aHH+4Nk9+dGp0dJ79shWQX+aXZlU52qlswvNhc4LMuksOBqIMCe/Kg/vSWTzSR76YU
         mR178mUskXKwkN2ceKHDtQduf0epTDgroHQaAxvQNZME9Id4qlPnl3TVV3wV4rticEPj
         M1rA==
X-Forwarded-Encrypted: i=1; AFNElJ/pRlPdBvFRZwPPTpGOiuvrEWx1JKPVfnqeG0abfwpD+iyrvmZXQnfP0m2Hqr5laJxfXfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE1g1YIeeZ1N5WViGpo7YaUru8eg5Ehcn3fRzUiU69lnXd6XUL
	wg5jC6GgcoPebz5Nuezpq7sz8MuyzT5Nvy93RNZqP1/eHY0gQBiNPa8qXJO7ftr8PYYmK0CAGIa
	9FydTag==
X-Received: from pjbta4.prod.google.com ([2002:a17:90b:4ec4:b0:368:edd5:fe57])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f0d:b0:368:83e6:ca95
 with SMTP id 98e67ed59e1d1-368f76656e0mr5411241a91.0.1778720888939; Wed, 13
 May 2026 18:08:08 -0700 (PDT)
Date: Wed, 13 May 2026 18:08:08 -0700
In-Reply-To: <20260107235724.28101-2-aidan@aktech.ai>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260107235724.28101-1-aidan@aktech.ai> <20260107235724.28101-2-aidan@aktech.ai>
Message-ID: <agUgeO5QNenQM9pT@google.com>
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

On Wed, Jan 07, 2026, Aidan Khoury wrote:
>  static void vt_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
>  {
>  	/*
> @@ -907,6 +915,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
>  	.get_gdt = vt_op(get_gdt),
>  	.set_gdt = vt_op(set_gdt),
>  	.set_dr7 = vt_op(set_dr7),
> +	.get_pending_dbg_exceptions = vt_op(get_pending_dbg_exceptions),
>  	.sync_dirty_debug_regs = vt_op(sync_dirty_debug_regs),
>  	.cache_reg = vt_op(cache_reg),
>  	.get_rflags = vt_op(get_rflags),
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 91b6f2f3edc2..1b2e274fe317 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5300,13 +5300,13 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
>  			 * have already expired.  Note, the CPU sets/clears BS
>  			 * as appropriate for all other VM-Exits types.
>  			 */
> +			if ((vmx_get_rflags(vcpu) & X86_EFLAGS_TF) &&
> +			    (vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) &
> +			     (GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS)))
> +				vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
> +				 vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS) | DR6_BS);

This is wrong.  Per the SDM, and confirmed on bare metal (and for giggles, in a
VM with #DB interception disabled) by generating a coincident single-step + INT1
#DB:

  The INT1 instruction also uses a one-byte opcode (F1) and generates a
  debug exception (#DB) without setting any bits in DR6.

>  			if (is_icebp(intr_info))
>  				WARN_ON(!skip_emulated_instruction(vcpu));
> -			else if ((vmx_get_rflags(vcpu) & X86_EFLAGS_TF) &&
> -				 (vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) &
> -				  (GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS)))
> -				vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
> -					    vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS) | DR6_BS);
>  
>  			kvm_queue_exception_p(vcpu, DB_VECTOR, dr6);
>  			return 1;
> @@ -5613,6 +5613,12 @@ void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
>  	vmcs_writel(GUEST_DR7, val);
>  }
>  
> +unsigned long vmx_get_pending_dbg_exceptions(struct kvm_vcpu *vcpu)
> +{
> +	return vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS) &
> +		(DR6_RTM | DR6_BS | BIT(12) /*Enabled breakpoint*/ | DR_TRAP_BITS);

Propagating bit 12 is wrong.  It's "Enabled Breakpoint" in PENDING_DBG_EXCEPTIONS,
but it's a reserved bit in DR6, and we have no idea what it might be used for on
modern hardware (probably nothing to avoid confusion with VMX).  For giggles,
before I realized where you were pulling the bit 12 documentation from, it did
used to have meaning in DR6.  Per an SDM from 2007:

  It is not possible to write a 1 to reserved bit 12 in debug status register
  DR6 on the P6 family and Pentium processors; however, it is possible to write
  a 1 in this bit on the Intel486 processor. See Table 9-1 for the different
  setting of this register following a power-up or hardware reset.

AFAIK, bit 12 hasn't (yet) been repurposed, and so shouldn't be touched by KVM.

> diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
> index 9697368d65b3..365682799d05 100644
> --- a/arch/x86/kvm/vmx/x86_ops.h
> +++ b/arch/x86/kvm/vmx/x86_ops.h
> @@ -75,6 +75,7 @@ void vmx_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
>  void vmx_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
>  void vmx_set_dr6(struct kvm_vcpu *vcpu, unsigned long val);
>  void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val);
> +unsigned long vmx_get_pending_dbg_exceptions(struct kvm_vcpu *vcpu);
>  void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu);
>  void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg);
>  unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 19d2d6d9e64a..c889dffe4e59 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -765,11 +765,23 @@ static int exception_type(int vector)
>  void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu,
>  				   struct kvm_queued_exception *ex)
>  {
> +	unsigned long pending_dbg;
> +
>  	if (!ex->has_payload)
>  		return;
>  
>  	switch (ex->vector) {
>  	case DB_VECTOR:
> +		/*
> +		 * VMX records deferred debug causes (B0-B3, enabled breakpoint,
> +		 * BS, RTM) in the vmcs.PENDING_DBG_EXCEPTIONS field.  Merge any
> +		 * pending causes into the exception payload so the guest may
> +		 * see all accumulated reasons in DR6 when the #DB is vectored.
> +		 */
> +		pending_dbg = kvm_x86_call(get_pending_dbg_exceptions)(vcpu);

Ugh.  This isn't going to work (and right now I hate myself for realizing this).
If userspace initiates a save/restore while there is effectively-unsaved state
in GUEST_PENDING_DBG_EXCEPTIONS, then it will be lost if exception_payload_enabled
is enabled because KVM (correctly) migrates the raw payload, and waits to shove
it into DR6 until the exception is actually delivered (likely after restore).

> +		if (pending_dbg)
> +			ex->payload |= pending_dbg;

This is rather silly, a bitwise-OR with 0 is cheaper.

So while I don't exactly love the idea, I think this?  Compile tested only at
this point, I'll try to properly test it tomorrow.

---
 arch/x86/include/asm/kvm-x86-ops.h | 1 +
 arch/x86/include/asm/kvm_host.h    | 1 +
 arch/x86/kvm/vmx/main.c            | 9 +++++++++
 arch/x86/kvm/vmx/vmx.c             | 6 ++++++
 arch/x86/kvm/vmx/x86_ops.h         | 1 +
 arch/x86/kvm/x86.c                 | 8 ++++++++
 6 files changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index b0269325646c..3e04a7ecbb47 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -51,6 +51,7 @@ KVM_X86_OP(get_gdt)
 KVM_X86_OP(set_gdt)
 KVM_X86_OP(sync_dirty_debug_regs)
 KVM_X86_OP(set_dr7)
+KVM_X86_OP_OPTIONAL_RET0(get_pending_dbg_exceptions)
 KVM_X86_OP(cache_reg)
 KVM_X86_OP(get_rflags)
 KVM_X86_OP(set_rflags)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 271bdd109a98..eaac6ba59591 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1834,6 +1834,7 @@ struct kvm_x86_ops {
 	void (*set_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*sync_dirty_debug_regs)(struct kvm_vcpu *vcpu);
 	void (*set_dr7)(struct kvm_vcpu *vcpu, unsigned long value);
+	unsigned long (*get_pending_dbg_exceptions)(struct kvm_vcpu *vcpu);
 	void (*cache_reg)(struct kvm_vcpu *vcpu, enum kvm_reg reg);
 	unsigned long (*get_rflags)(struct kvm_vcpu *vcpu);
 	void (*set_rflags)(struct kvm_vcpu *vcpu, unsigned long rflags);
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 83d9921277ea..a0e67471bff1 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -470,6 +470,14 @@ static void vt_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
 	vmx_set_dr7(vcpu, val);
 }
 
+static unsigned long vt_get_pending_dbg_exceptions(struct kvm_vcpu *vcpu)
+{
+	if (WARN_ON_ONCE(is_td_vcpu(vcpu)))
+		return 0;
+
+	return vmx_get_pending_dbg_exceptions(vcpu);
+}
+
 static void vt_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 {
 	/*
@@ -928,6 +936,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.get_gdt = vt_op(get_gdt),
 	.set_gdt = vt_op(set_gdt),
 	.set_dr7 = vt_op(set_dr7),
+	.get_pending_dbg_exceptions = vt_op(get_pending_dbg_exceptions),
 	.sync_dirty_debug_regs = vt_op(sync_dirty_debug_regs),
 	.cache_reg = vt_op(cache_reg),
 	.get_rflags = vt_op(get_rflags),
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3a47a21dd499..7f84644a5c49 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5822,6 +5822,12 @@ void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
 	vmcs_writel(GUEST_DR7, val);
 }
 
+unsigned long vmx_get_pending_dbg_exceptions(struct kvm_vcpu *vcpu)
+{
+	return vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS) &
+               (DR6_RTM | DR6_BS | DR_TRAP_BITS);
+}
+
 static int handle_tpr_below_threshold(struct kvm_vcpu *vcpu)
 {
 	kvm_apic_update_ppr(vcpu);
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 409858074246..5cfbd4e66f08 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -75,6 +75,7 @@ void vmx_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 void vmx_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 void vmx_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val);
+unsigned long vmx_get_pending_dbg_exceptions(struct kvm_vcpu *vcpu);
 void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu);
 void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg);
 unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 72ba1fc1bed2..8b32ab11f888 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -868,6 +868,14 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 		vcpu->arch.exception.vector = nr;
 		vcpu->arch.exception.error_code = error_code;
 		vcpu->arch.exception.has_payload = has_payload;
+		/*
+		 * VMX records deferred debug causes (B0-B3, enabled breakpoint,
+		 * BS, RTM) in the vmcs.PENDING_DBG_EXCEPTIONS field.  Merge any
+		 * pending causes into the exception payload so the guest may
+		 * see all accumulated reasons in DR6 when the #DB is vectored.
+		 */
+		if (nr == DB_VECTOR && has_payload)
+			payload |= kvm_x86_call(get_pending_dbg_exceptions)(vcpu);
 		vcpu->arch.exception.payload = payload;
 		return;
 	}

base-commit: b72a08c022f2dae4bca6f4edde5fe8012a02aefa
--
