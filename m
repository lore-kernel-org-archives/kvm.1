Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674527;
	b=wqyKnLO8XeKpAmL8p33FOV/Nb6ozLlq3cgzP9hI048YTEUn95jnUz/x54zho4Ayy+QEF
	 ZLfChyzuoaMS432+aI6GMG7pzoUGdWNmUdd3FD2/e1iIZ4tcZ0PC2E2fh80u/teyv/gyc
	 FPC75Li0zwW5azHokXNfxtiOKb+WbNrJdVY6lXVI4/rs+2yhTFJGPNz/vwr4n5i8a9WV+
	 j8qlaIpvIqgxywqyYg1TqqN5smDjSyq1FpzazttjDMDt67jgAeV8egT7oyBEyDwAk0kXf
	 /r8WlpVkNYLQv5THSw4USb9Rvqn/G/wCifKwR9pzPtrlwOtT10BnEwetfPZYpKhkbsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=M5qHQnLTnpdSrQUS+p19DIXqfKposMzCKXDblMJrEuU=;
	b=wh4hyrnniTYsroMfUZHDxQOIYIg1P5rj50kwypykrYHodEtoS5UqnEGDgqmkgr4SZBf1
	 kofWKwKl2/pvi0RbfVXKJi9eHZJUTjNRYX8iyXjxX5g1BWpyac6TIZ4illEck4RMBwxzN
	 eh8EntsdJKKp27Hiv6j/+f72Bns83GSHTyHWAszFed4Kr0cpEvHRU6aOD9KOd19jzQLbt
	 OrJ6dlltv4FiZ3toTOkjUMStBqP5l8DwHe95hL08onttsv1ZL61AJzuxLVAccnYmyCtHE
	 kaCWTJxJId4M5qYiPnP4v4sO3mqg3I7QXmnhOwDArqe7zaVY40B+RZro5VDr0RFeh+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Jxr7SJyG;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667F7606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 13:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 667F7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Jxr7SJyG
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so2433330a91.3
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 06:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792674527; x=1793279327; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M5qHQnLTnpdSrQUS+p19DIXqfKposMzCKXDblMJrEuU=;
        b=Jxr7SJyGAM6POkF3hdl+VbwQpCAW1/lb2u+Oo///0ZGO5d22ZDR1pNWj+vNYcz0QFr
         H37Pls2dBhHXyB5d/3wgD891lLxrEIlkD3fxvk/G88sf4Hk6HXleTjz3SQnWIQ4KEUUh
         UF2KHKa8yqQDb1xAGhqWkNpuMHjwUuXYe2kBYGUvy3Vnehynb9X3Q7Yj3nqBmvEFZDF8
         JSJkFNpHupOrLRNnS8ebA+w8sldFRQilpHx8Z9rC/rXykO+xeN0TGbmNLyFkqZSkNczi
         YbQRSrNQAIscRuNxb+BtlBwvFAPohb0XiyEyj3yT3vz3bDe3MjQFlCK2CukR4zV4t6O8
         GEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674527; x=1793279327;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M5qHQnLTnpdSrQUS+p19DIXqfKposMzCKXDblMJrEuU=;
        b=IKIoBIu1NLkvGsbG7KQ+PBSEOZnjdbVozNknv85rlcLQM32VaaXm3ZOMrkhyxqcf9B
         KFoKJNZBEqW4Vd1vkTUKFLA1YomXb2ijF5j2mf2REq6BfrXM+nJjvzFXJeMupHt89R1H
         pYofheuAvBlnoZkFX7TOhUo3sta+Dq4ZoxFlDApl1k0pXXb8UJcHoG6jsFNbhzzaFkmL
         ZZbx56dQMST14LxlqV7f5NtZ9uTfG6lrNZAh89vJpOtK+FLmxvWv+WdBz+WeMU8ra+W0
         IWfDSV+CrkWRIWjXvn0nxyCP3GJPlz7wft+Jm8VVgA1aV030+ym8w6a4VP9sbcbkQDHG
         AQWQ==
X-Gm-Message-State: AFq9FYJsv3D8U0d/s2McQ8iGo/Eai8izCYo5l8ISN7vQ5qRs7vuakPfS
	Tlce0B5HnDkyOUJRb8tMbFkk4elUHEYdW890i2Z4WPzuSSFk9D1TEHOWRaQT9omlf5Nd51dw63H
	aStCyGg==
X-Received: from pjio14.prod.google.com ([2002:a17:90a:5b0e:b0:3ab:323:94d4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55cc:b0:3a8:185:cf40
 with SMTP id 98e67ed59e1d1-3ad86f1bd64mr4549299a91.10.1792674526475; Thu, 22
 Oct 2026 06:08:46 -0700 (PDT)
Date: Thu, 22 Oct 2026 06:08:45 -0700
In-Reply-To: <sashiko-outbox-180887@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022022813.303978-1-seanjc@google.com> <20261022022813.303978-2-seanjc@google.com>
 <sashiko-outbox-180887@kernel.org>
Message-ID: <atoK3Z1hrMxwwgTY@google.com>
Subject: Re: [PATCH v2 1/2] KVM: x86: Switch to vmcs01 to update EOI exiting
 bitmap on-demand if L2 is active
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 22, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
> > index 447f0ec3e63e4..411eaf445d436 100644
> > --- a/arch/x86/kvm/regs.h
> > +++ b/arch/x86/kvm/regs.h
> > @@ -464,12 +464,6 @@ static inline void enter_guest_mode(struct kvm_vcpu *vcpu)
> >  static inline void leave_guest_mode(struct kvm_vcpu *vcpu)
> >  {
> >  	vcpu->arch.hflags &= ~HF_GUEST_MASK;
> > -
> > -	if (vcpu->arch.load_eoi_exitmap_pending) {
> > -		vcpu->arch.load_eoi_exitmap_pending = false;
> > -		kvm_make_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu);
> > -	}
> > -
> >  	vcpu->stat.guest_mode = 0;
> >  }
> >  
> 
> [Severity: Low]
> With the removal of the only reader of vcpu->arch.load_eoi_exitmap_pending in
> leave_guest_mode() (in arch/x86/kvm/regs.h) and its only writer in
> vcpu_scan_ioapic() (in arch/x86/kvm/x86.c), load_eoi_exitmap_pending in
> struct kvm_vcpu_arch has no remaining references in the tree (both at this
> commit and at the end of the series):
> 
> arch/x86/include/asm/kvm_host.h:
> struct kvm_vcpu_arch {
> 	...
> 	u64 apic_base;
> 	struct kvm_lapic *apic;    /* kernel irqchip context */
> 	bool load_eoi_exitmap_pending;
> 	DECLARE_BITMAP(ioapic_handled_vectors, 256);
> 
> Should load_eoi_exitmap_pending be removed from struct kvm_vcpu_arch as well?

/facepalm

Every. Single. Time.  I forget to remove the boolean.

> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 612ab07d4100f..5e765409398d3 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -7139,6 +7139,8 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
> >  	if (!kvm_vcpu_apicv_active(vcpu))
> >  		return;
> >  
> > +	guard(vmx_vmcs01)(vcpu);
> > +
> >  	vmcs_write64(EOI_EXIT_BITMAP0, eoi_exit_bitmap[0]);
> >  	vmcs_write64(EOI_EXIT_BITMAP1, eoi_exit_bitmap[1]);
> >  	vmcs_write64(EOI_EXIT_BITMAP2, eoi_exit_bitmap[2]);
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index aad065d035fbb..082d027ade583 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -8003,17 +8003,6 @@ static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
> >  		kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
> >  #endif
> >  
> > -	if (is_guest_mode(vcpu))
> > -		vcpu->arch.load_eoi_exitmap_pending = true;
> > -	else
> > -		kvm_make_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu);
> > -}
> > -
> > -static void vcpu_load_eoi_exitmap(struct kvm_vcpu *vcpu)
> > -{
> > -	if (!kvm_apic_hw_enabled(vcpu->arch.apic))
> > -		return;
> > -
> >  #ifdef CONFIG_KVM_HYPERV
> >  	if (to_hv_vcpu(vcpu)) {
> >  		u64 eoi_exit_bitmap[4];
> > @@ -8167,8 +8156,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> >  		}
> >  		if (kvm_check_request(KVM_REQ_SCAN_IOAPIC, vcpu))
> >  			vcpu_scan_ioapic(vcpu);
> > -		if (kvm_check_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu))
> > -			vcpu_load_eoi_exitmap(vcpu);
> >  		if (kvm_check_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu))
> >  			kvm_vcpu_reload_apic_access_page(vcpu);
> >  #ifdef CONFIG_KVM_HYPERV
> 
> [Severity: High]
> Can calling load_eoi_exitmap() directly from vcpu_scan_ioapic() while L2 is
> active leave stale EOI_EXIT_BITMAP0..3 values in vmcs01 when APICv
> transitions from inhibited to uninhibited in L2?

Huh.  This isn't an L2 vs. L1 issue, this is a pre-existing bug that doesn't have
anything to do with nested.  Sashiko found a convoluted scenario where not
deferring the EOI update would create a bigger window for the bug, but there are
much simpler scenarios that will hit this bug.  E.g. any GSI routing changes that
affect the EOI bitmap that are made while APICv is inhibited will run afoul of
this issue.

The bug has likely gone unnoticed because APICv doesn't have many inhibits, and
pretty much the only one that's likely to be toggled by a "real" guest is the
APICV_INHIBIT_REASON_HYPERV one that SynIC uses when AutoEOI is enabled.

> When APICv becomes inhibited on a vCPU (for example, when L1 or L2 modifies
> the xAPIC APIC_ID via kvm_lapic_reg_write() -> kvm_recalculate_apic_map(),
> disables the APIC via kvm_apic_set_base(), or enables Hyper-V SynIC AutoEOI),
> KVM queues both KVM_REQ_APICV_UPDATE and KVM_REQ_SCAN_IOAPIC.
> 
> In vcpu_enter_guest() in arch/x86/kvm/x86.c, KVM_REQ_SCAN_IOAPIC is serviced
> before KVM_REQ_APICV_UPDATE:
> 
> arch/x86/kvm/x86.c:vcpu_enter_guest() {
> 	...
> 		if (kvm_check_request(KVM_REQ_SCAN_IOAPIC, vcpu))
> 			vcpu_scan_ioapic(vcpu);
> 	...
> 		if (kvm_check_request(KVM_REQ_APICV_UPDATE, vcpu))
> 			kvm_vcpu_update_apicv(vcpu);
> }
> 
> During the inhibit transition, apic->apicv_active is still true when
> vcpu_scan_ioapic() runs, so vmx_load_eoi_exitmap() writes the zeroed
> ioapic_handled_vectors bitmap into vmcs01's EOI_EXIT_BITMAP0..3 before
> KVM_REQ_APICV_UPDATE sets apic->apicv_active to false. Similarly, any IOAPIC
> routes configured while APICv is inhibited are not written to vmcs01 because
> apic->apicv_active is false.
> 
> When the guest later transitions out of the inhibited state while L2 is
> active (is_guest_mode(vcpu) is true) -- for example, when L2 enables x2APIC
> via MSR_IA32_APICBASE or restores the xAPIC ID -- kvm_apic_set_base() or
> kvm_recalculate_apic_map() clears the APICv inhibit (queuing
> KVM_REQ_APICV_UPDATE) and calls kvm_make_scan_ioapic_request() (queuing
> KVM_REQ_SCAN_IOAPIC).
> 
> Previously, because is_guest_mode(vcpu) was true, vcpu_scan_ioapic() set
> vcpu->arch.load_eoi_exitmap_pending = true and deferred
> KVM_REQ_LOAD_EOI_EXITMAP until leave_guest_mode() on nested VM-Exit, after
> KVM_REQ_APICV_UPDATE had already set apic->apicv_active = true.

...

> Should KVM_REQ_APICV_UPDATE be processed before KVM_REQ_SCAN_IOAPIC in
> vcpu_enter_guest(), or should kvm_vcpu_update_apicv() reload the EOI exit
> bitmap when re-activating APICv?

Neither.  This bug was introduced by commit d62caabb41f3 ("kvm/x86: per-vcpu apicv
deactivation support").  As KVM does with device posted interrupts, where IRTEs
are kept up-to-date even if APICv is *currently* inhibited, the simple thing to
do is keep the EOI bitmap up-to-date if APICv is globally enabled, i.e.:

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b341af4c6057..d8e66d67138f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7079,7 +7079,7 @@ int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
 
 void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 {
-	if (!kvm_vcpu_apicv_active(vcpu))
+	if (!lapic_in_kernel(vcpu) || !enable_apicv)
 		return;
 
 	vmcs_write64(EOI_EXIT_BITMAP0, eoi_exit_bitmap[0]);

I'll insert a new patch in v2.
