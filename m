Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7717B382368
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561586; cv=none; b=l9en7YmVvnhYh7U6dpkpb9X6xZk2XlZuiih3FrTUy4oDMq5GlkSVM9oyTTvt37uYbmXwx5hlNFv1pwmoACuOAh+wABvyULSGuwie+C7a7EWcBSv5jND3hU2utGvaryivakR2J73SIUljEDzX4xPCddmHMgc8iUA2C/2FXAE9mP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561586; c=relaxed/simple;
	bh=bFOUZnCm03fwd67WJRycufHufPgOpFeItWIEg7e3pXg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jLgr6WlUWt8jfFXyv+rErtltdNeKf78OUdZccsSxsSZERTbc6K7LBZDZO3KCWkT8dMwa47ZI11inISrqS9JyWHKnQAtXbmEh+NG8y5gkJDZLhHrxWvaN35Yi8PogJkYo0JA4DDPHZeaD78d8BYFWWxRUPReYRoCBDVj8ev8rTbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lk2RXWfb; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lk2RXWfb"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e7131849bso1491721a91.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 08:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784561581; x=1785166381; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ITZsAz5ie9SECUr/bXc2ZJFsoMCPDFXbIaKO0hatsYs=;
        b=Lk2RXWfbtspXS+gRq6ogkYCs3seHJ2DhdqPCm97pHjcSSiZY5OnJHtuHvSSbwhHyTX
         d2cC/If0IqPoBnl7UGm09BshR/Ulpv9QihvLhZdpA723W6nbYI4xntgJyN6mn3J1IPVx
         ekza5qDt1QIX67RR5arDmQBDJ8nWLrs0RkrXJVVNR/CT8QYc0FFLBa/pY+EI1swKfFcY
         hjegiYsMJOW1IfmcgtcfogBYVlGy1XODqfdZax8LTiqHqr73P1PkfvnNj0TfU5HnQW8k
         d/t6G30Md81rDbm9mvgd9LyYnYn9P1wwxFJUL9i3pzOX8m/MWInwJgxe3CVPROE214Zn
         YDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784561581; x=1785166381;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ITZsAz5ie9SECUr/bXc2ZJFsoMCPDFXbIaKO0hatsYs=;
        b=qXvHoteuUhlyCKoqsC94FLZSM9dm2+dEwo+/+SYsyrsVqsmGVpQ+wdCITVE6apdY0X
         LQouHN4eYoUx795HrsE0QSgSS5Rivk5Zt7qfiJdN/gElVmprZssBQXQ5xRzqk+hvm3VR
         hDvEZst/lZeJFETfeVdeI63+XMEhp/752OLpeafoiteGggJkghoxg755MVT+LSN+kFEi
         +YAs2XIuws40zlsUycfFbT1oCUooiRAzJ1FAcrzB9GBB6hPMnXjlmnRX+/pYybWTtQZ1
         FE8ukKyAnlQGmjUQa6R7Yf7iVCwZuXiGo8Dg5hX/EhOQHpn9zh4KXjs1aiq4wQ9mAb3c
         xX0w==
X-Forwarded-Encrypted: i=1; AHgh+RpYmuD/Y+WIJbT9hWLs4gLpekbF/kVg+1kfuhFTn4aMmUsXyY84wVky8k5JPOdBlEjxQxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNDOgmI68XxyL/YacblLP1KyTZ4/oJHiIKkQqlFQlA/1nG8Nwk
	PxtPfOZtKu+z6JfQLHb2wGQFJSM4BdFx1+6rBCCg3JMcUOtduQIgGXtEBSqZgWNnFoP5vW0QSVg
	DkmiQNg==
X-Received: from pjv3.prod.google.com ([2002:a17:90b:5643:b0:381:2958:c74a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d2cf:b0:38c:a59b:5189
 with SMTP id 98e67ed59e1d1-38e4b490278mr14922576a91.15.1784561580962; Mon, 20
 Jul 2026 08:33:00 -0700 (PDT)
Date: Mon, 20 Jul 2026 08:33:00 -0700
In-Reply-To: <20260717230542.3555587-3-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260717230542.3555587-1-jmattson@google.com> <20260717230542.3555587-3-jmattson@google.com>
Message-ID: <al4_rFoM4RKoi-XN@google.com>
Subject: Re: [PATCH v2 2/3] KVM: SVM: Dirty ERAPS register on all ASID TLB flushes
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: amit.shah@amd.com, kvm@vger.kernel.org, pbonzini@redhat.com, 
	venkateshs@google.com, yosry@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 17, 2026, Jim Mattson wrote:
> Per the AMD APM, ERAPS clears the Return Address Predictor (RAP/RSB) on all
> implicit TLB invalidations (e.g. modifying certain CR[04] bits).
> 
> Move kvm_register_mark_dirty(vcpu, VCPU_REG_ERAPS) into
> svm_flush_tlb_asid() so that any ASID-level TLB flush marks ERAPS dirty.

NAK, the whole point of KVM_REQ_TLB_FLUSH_GUEST is emulate TLB invalidations in
the guest's domain.  If we're missing KVM_REQ_TLB_FLUSH_GUEST requests, fix those.

I think we're missing a clear on the MOV CR3 flush when TDP is disabled?  Beyond
that, nothing jumps out.

diff --git arch/x86/kvm/x86.c arch/x86/kvm/x86.c
index 11017f49b94a..39b1e79df6c9 100644
--- arch/x86/kvm/x86.c
+++ arch/x86/kvm/x86.c
@@ -755,10 +755,16 @@ void kvm_invalidate_pcid(struct kvm_vcpu *vcpu, unsigned long pcid)
         * also via the emulator.  KVM's TDP page tables are not in the scope of
         * the invalidation, but the guest's TLB entries need to be flushed as
         * the CPU may have cached entries in its TLB for the target PCID.
+        *
+        * When ERAPS is supported, invalidating a specific PCID clears the RAP
+        * (Return Address Predicator).  KVM flushes the RAP when emulating a
+        * full guest TLB flush, so only the !TDP case needs to be handled here.
         */
        if (unlikely(tdp_enabled)) {
                kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
                return;
+       } else if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS)) {
+               kvm_register_mark_dirty(vcpu, VCPU_REG_ERAPS);
        }
 
        /*
@@ -10740,13 +10746,6 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
                        return 1;
                }
 
-               /*
-                * When ERAPS is supported, invalidating a specific PCID clears
-                * the RAP (Return Address Predicator).
-                */
-               if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS))
-                       kvm_register_mark_dirty(vcpu, VCPU_REG_ERAPS);
-
                kvm_invalidate_pcid(vcpu, operand.pcid);
                return kvm_skip_emulated_instruction(vcpu);
 
@@ -10760,11 +10759,6 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
 
                fallthrough;
        case INVPCID_TYPE_ALL_INCL_GLOBAL:
-               /*
-                * Don't bother marking VCPU_REG_ERAPS dirty, SVM will take
-                * care of doing so when emulating the full guest TLB flush
-                * (the RAP is cleared on all implicit TLB flushes).
-                */
                kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
                return kvm_skip_emulated_instruction(vcpu);
 


> Centralizing the ERAPS dirty call in svm_flush_tlb_asid() ensures that all
> ASID flushes (flush_tlb_current, flush_tlb_all, flush_tlb_guest) properly
> set ERAP_CONTROL_CLEAR_RAP on the next VMRUN.
> 
> Remove the now redundant svm_flush_tlb_guest() wrapper.
> 
> Fixes: db5e82496492 ("KVM: SVM: Virtualize and advertise support for ERAPS")
> Assisted-by: Gemini:Gemini-Next
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/svm/svm.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index bf868da14cd2..f2fdca341dac 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4171,6 +4171,8 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  
> +	kvm_register_mark_dirty(vcpu, VCPU_REG_ERAPS);
> +
>  	/*
>  	 * Unlike VMX, SVM doesn't provide a way to flush only NPT TLB entries.
>  	 * A TLB flush for the current ASID flushes both "host" and "guest" TLB
> @@ -4229,13 +4231,6 @@ static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
>  	invlpga(gva, svm->vmcb->control.asid);
>  }
>  
> -static void svm_flush_tlb_guest(struct kvm_vcpu *vcpu)
> -{
> -	kvm_register_mark_dirty(vcpu, VCPU_REG_ERAPS);
> -
> -	svm_flush_tlb_asid(vcpu);
> -}
> -
>  static inline void sync_cr8_to_lapic(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
> @@ -5383,7 +5378,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
>  	.flush_tlb_all = svm_flush_tlb_all,
>  	.flush_tlb_current = svm_flush_tlb_current,
>  	.flush_tlb_gva = svm_flush_tlb_gva,
> -	.flush_tlb_guest = svm_flush_tlb_guest,
> +	.flush_tlb_guest = svm_flush_tlb_asid,
>  
>  	.vcpu_pre_run = svm_vcpu_pre_run,
>  	.vcpu_run = svm_vcpu_run,
> -- 
> 2.55.0.229.g6434b31f56-goog
> 
