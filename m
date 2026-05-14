Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61283932DB
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785564; cv=none; b=a6WJ6cSE2it5Iy22ZJ7zcZJKOO5fATM+uTnnAblV+u9NAh7DhfEhg2sVnEnhXiAxJUzMA9e8Mq7vdoKI9x3w4JiiRAXn6IokVQdyhlaVqrnongX+TYlD4VVrhWTKJAZKMky3j+UUGiBA2W8uWZtrRQvZOnCxmj8d7htdULineOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785564; c=relaxed/simple;
	bh=06L80zTV+NdjS7sNG98AUMMAX8mgAl55ufvME5+4vRA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nb5P/RIsnhRILg9iB7nM74jlDhS8jN7U295RqnBHxzQsf3Di9iA1RHQ3HHU3PmMu2xT1AJ4LqxlQsT/geGdWlW10HKxvhPK9ri0rUoc04kiTpdOTIlfCJUUSA0QoeAQpmPDVV+IJE+D8eZpmKcKOuBsONCVPk2mVVMQe/O1Zbs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W3Z2+RcI; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W3Z2+RcI"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82c4772950so79137a12.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778785562; x=1779390362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWjyG1HkoGKtGPT13xyGbGBxQorSUcxyFUT7ogVrZaE=;
        b=W3Z2+RcIsLzPwcQtmX8w5XjuCAM2YeDT7OQAHC37c+pOtJYp0R/fD1MrWi83I4IGxg
         1ehx8cNLIfq6snfrDWX4jTu6j3m/m4pjJdROS4junx9wH1qASnZtH27msabw5N9F0ZC0
         h594aCCSktIXeA2EDGo1KTZ+QEFwVJ9ZIKarLWDbC+5wSDM0c97D/aiYFSoinrPyg+Sp
         t8SgT6ghChjj1Jf0+bee2qn0VcbIUxMxP5jEsxYGO10kZUgKf+OzRPth001rryuC/cMM
         Ao+NjhzeeGdApLXRHNtCiZBHC9PbLs3qQ5HMmlAc63qHPHotg999/gYglmkudYuwST7J
         lKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778785562; x=1779390362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWjyG1HkoGKtGPT13xyGbGBxQorSUcxyFUT7ogVrZaE=;
        b=HIKCQBr8LEBrHrhxflSnrCFg7K2dFm5VzHQJy72XS54HDpfPlWegCpEApHPv5TI4kK
         b4bGc8Gs8qkMkZZK8Mxepr25UtAHHMtKHYWjqGvxDuDts+MDzojh/ejzWE+wOxlTqI2e
         U79ZYpkaDP6kAFR0rK3y4iEpcBP95uzCbeOH9K+SqauQp/YJ7G8446PBwlQR7Zep53L8
         SF/2qNLrJIImVplkoYcmebcrnuv00DeBw1jE5b2NuLR7TrcwYYKTMtsTnQfdCET69xde
         N4X2p7bygMib7tZ4haypZ9C5s7zmXGONMlj0MHLemxDJMubVnWrHb68djw1Gx4LXEH88
         hMcQ==
X-Gm-Message-State: AOJu0YyVWr7JxoU6kMu5SAvp27WWjEstJnYDATnLFkPpt8qZx8PP91BR
	NSqLk8AgbvOi6twCpSUIWn8GxZoT9mAAcGm0JyNC57C/rkpDKN9a+WxpoAs3/VFKc16EvDYyg1J
	80Y8HhA==
X-Received: from pfr22.prod.google.com ([2002:a05:6a00:94d6:b0:82f:2a0d:b24c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a907:b0:837:f111:b70
 with SMTP id d2e1a72fcca58-83f18d5b89cmr4607372b3a.4.1778785561899; Thu, 14
 May 2026 12:06:01 -0700 (PDT)
Date: Thu, 14 May 2026 12:06:01 -0700
In-Reply-To: <5e667a338a27ef2392143962466d77432fcd5441.1766066076.git.houwenlong.hwl@antgroup.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1766066076.git.houwenlong.hwl@antgroup.com> <5e667a338a27ef2392143962466d77432fcd5441.1766066076.git.houwenlong.hwl@antgroup.com>
Message-ID: <agYdGRM6a8eKDL0b@google.com>
Subject: Re: [PATCH v2 7/9] KVM: VMX: Refresh 'PENDING_DBG_EXCEPTIONS.BS' bit
 during instruction emulation
From: Sean Christopherson <seanjc@google.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: kvm@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Dec 18, 2025, Hou Wenlong wrote:
> The VM-Entry has a consistency check that when the 'STI' or 'MOVSS'
> blocking is active, the 'PENDING_DBG_EXCEPTIONS.BS' bit must be set if
> 'RFLAGS.TF' is set; otherwise, a VM-Fail is triggered during VM-entry.
> However, when 'STI' or 'MOV SS' is emulated (e.g., using the 'force
> emulation' prefix), the emulator only refreshes interruptibility state
> but pending debug exception state is not refreshed. Since the force
> emulation prefix causes a VM-Exit due to #UD interception, which clears
> the 'PENDING_DBG_EXCEPTIONS' bits, the emulator should refresh the
> 'PENDING_DBG_EXCEPTIONS.BS' bit when the 'RFLAGS.TF' bit is set to
> ensure the success of VM-Entry.

After (way too) much thought, it's not just (forced) emulation that's flawed;
save/restore also needs similar treatment.  E.g. if userspace gains control of
the vCPU on a single-step #DB exit with STI-blocking, then KVM will save/restore
the pending #DB, RFLAGS.TF, and STI-blocking, but not PENDING_DBG_EXCEPTIONS.BS.
When the target resumes, VM-Entry will fail due to the "bad" state.

So AFAICT, we can handle both by moving the fixup logic to vmx_inject_exception()
(because it's just fixup for a consistency check, e.g. the state doesn't need to
be saved/restored).  I'm not entirely convinced this fixes *all* the flows that
can run afoul of the consistency check, but I think it gets the legimiate ones?
And if not, we can always continue playing whack-a-mole...

I'll send a v3 of the whole series, because with this approach there's no need to
commit RFLAGS before queuing the #DB in the emulator writeback path, and we can
drop kvm_vcpu_do_singlestep() entirely.

---
 arch/x86/kvm/vmx/vmx.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1701db1b2e18..a0a0ccf342d3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1909,6 +1909,24 @@ void vmx_inject_exception(struct kvm_vcpu *vcpu)
 	u32 intr_info = ex->vector | INTR_INFO_VALID_MASK;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
+	/*
+	 * When injecting a #DB, single-stepping is enabled in RFLAGS, and STI
+	 * or MOV-SS blocking is active, set vmcs.PENDING_DBG_EXCEPTIONS.BS to
+	 * prevent a false positive from VM-Entry consistency check.  VM-Entry
+	 * asserts that a single-step #DB _must_ be pending in this scenario,
+	 * as the previous instruction cannot have toggled RFLAGS.TF 0=>1
+	 * (because STI and POP/MOV don't modify RFLAGS), therefore the one
+	 * instruction delay when activating single-step breakpoints must have
+	 * already expired.  However, the CPU isn't smart enough to peek at
+	 * vmcs.VM_ENTRY_INTR_INFO_FIELD and so doesn't realize that yes, there
+	 * is indeed a #DB pending/imminent.
+	 */
+	if (ex->vector == DB_VECTOR &&
+	    (vmx_get_rflags(vcpu) & X86_EFLAGS_TF) &&
+	    vmx_get_interrupt_shadow(vcpu))
+		vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
+			    vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS) | DR6_BS);
+
 	kvm_deliver_exception_payload(vcpu, ex);
 
 	if (ex->has_error_code) {
@@ -5485,26 +5503,9 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 			 * avoid single-step #DB and MTF updates, as ICEBP is
 			 * higher priority.  Note, skipping ICEBP still clears
 			 * STI and MOVSS blocking.
-			 *
-			 * For all other #DBs, set vmcs.PENDING_DBG_EXCEPTIONS.BS
-			 * if single-step is enabled in RFLAGS and STI or MOVSS
-			 * blocking is active, as the CPU doesn't set the bit
-			 * on VM-Exit due to #DB interception.  VM-Entry has a
-			 * consistency check that a single-step #DB is pending
-			 * in this scenario as the previous instruction cannot
-			 * have toggled RFLAGS.TF 0=>1 (because STI and POP/MOV
-			 * don't modify RFLAGS), therefore the one instruction
-			 * delay when activating single-step breakpoints must
-			 * have already expired.  Note, the CPU sets/clears BS
-			 * as appropriate for all other VM-Exits types.
 			 */
 			if (is_icebp(intr_info))
 				WARN_ON(!skip_emulated_instruction(vcpu));
-			else if ((vmx_get_rflags(vcpu) & X86_EFLAGS_TF) &&
-				 (vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) &
-				  (GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS)))
-				vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
-					    vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS) | DR6_BS);
 
 			kvm_queue_exception_p(vcpu, DB_VECTOR, dr6);
 			return 1;

base-commit: b7fbe9a1bf9ee6c967ef77d366ca58c35fcf1887
-- 

> +void vmx_refresh_pending_dbg_exceptions(struct kvm_vcpu *vcpu)
> +{
> +	if ((vmx_get_rflags(vcpu) & X86_EFLAGS_TF) &&
> +	    vmx_get_interrupt_shadow(vcpu))
> +		vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
> +			    vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS) | DR6_BS);
> +}
> +
>  static int handle_tpr_below_threshold(struct kvm_vcpu *vcpu)
>  {
>  	kvm_apic_update_ppr(vcpu);
> diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
> index d09abeac2b56..2978b6506ac6 100644
> --- a/arch/x86/kvm/vmx/x86_ops.h
> +++ b/arch/x86/kvm/vmx/x86_ops.h
> @@ -74,6 +74,7 @@ void vmx_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
>  void vmx_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
>  void vmx_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
>  void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val);
> +void vmx_refresh_pending_dbg_exceptions(struct kvm_vcpu *vcpu);
>  void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu);
>  void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg);
>  unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7352c2114bab..9167393cc0cc 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9232,7 +9232,12 @@ static int kvm_vcpu_check_hw_bp(unsigned long addr, u32 type, u32 dr7,
>  
>  static int kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu)
>  {
> -	return kvm_inject_emulated_db(vcpu, DR6_BS);
> +	int r;
> +
> +	r = kvm_inject_emulated_db(vcpu, DR6_BS);
> +	if (r)
> +		kvm_x86_call(refresh_pending_dbg_exceptions)(vcpu);
> +	return r;
>  }
>  
>  int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
> -- 
> 2.31.1
> 
