Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4698244CF2E
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168650; cv=none; b=drcKne7qORzWBt7qDnWeBatOFp6DYvi1qv+ChJ5ToxUUlzwcYWk+LdfoIx98Ebu1F5tb2iDjKS60jK5AOqrmijb+3yc6GmndSoOUXm+mgEQ2rCxB8RQ5cFd/k5zsaawzYDxccIdWlPK0gMyuGhjMVoHJw23fa4M/6dBU2x1Sn+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168650; c=relaxed/simple;
	bh=VrVdJWtSNKPP14BRfHMrLK4mVvv761yMYL0GiaVQ990=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QSurxW5D9Rpxtee2wHcUu+j/jzCLva8qz29mr1WHFmocC9hoFrw4v9s+1WEbRt8uThYcGysLPPCEbrExtXfJX08u44gOlJZT6NARJYOa0rNjLQokIGIDLkfbMwnJwPApXFiOl0qCSLRty2POgoNiVzR1/s+SbA58U5GUpBKrFnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GCLiwK3H; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GCLiwK3H"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f9429f49cso1111858b3a.3
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778168647; x=1778773447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=65TWr3go5iy70z9FYsv2NihxFIFA0cnFSm5OBGOU7IM=;
        b=GCLiwK3H7JcCZRFXJaWgqHc9gqVsnzZqlQLWOsfavXGNpGImhCok6NEhe8TUpuarz+
         q+9zQkWqD/Ej0BVtVSca7c/wWyINd6wirFF4/XFCWMQ2rorMYJ40IpEypef/RL5G2yBM
         CqbIdl0H+MA5Q3k2Rj/6oGhMHlnc8XBrPJldK35H4FDRW7O9lbm0vh5Bz160v9nTaJNb
         dDSm8SXrv+J+2hLS/sWuEkL2W1h9UeHrVWzmLQdOfzSD3qybK3flbbJD4tBmF8dolJGw
         iCK2PVAuEWhPieeOeG6gRkLSyb/Zn+yV20aikRGKpzf7QYWI77sDAnvvYkbBf5U+ZeEv
         WxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778168647; x=1778773447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65TWr3go5iy70z9FYsv2NihxFIFA0cnFSm5OBGOU7IM=;
        b=CySIg8ExbHo9W52VvDiinYCCIuN3xIjLa883W0ztB0z7WHta0wWQ1dXrVp3LfPMv8/
         wTBSgSF3y/mEG3Gehl0jFCSlCmULxLc9SFF2ulDkg3ibO8EHdsU+gHbypVcVYcw7//HB
         pOVGDrbzBZn/LfTr8RC71IRpWcgle+mB3eUJrlJk1fI/9TYlipQUrEDC7eV+/+tP4IK1
         CZOtz72msytFBlcu2B/iIr3MyMrEqiimXCZXufqNoF5+Hx0nyeDFEVS53+uxGjnmjHfl
         09e+qvI/HZRXqjmrpxG/J1ttuB4W5bkssImHaORTwaK2ToqzNORS2w/hXlg+Rxhq6wJ8
         /MKA==
X-Forwarded-Encrypted: i=1; AFNElJ+65HGdumTIaZVeCMzHXC99nihfxSNjOpb0QyYw99D6W8LZynZNT3iQfaq9ehjVivsEvMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYUZ+7t2u24K1Fi5bV+zeMAkb8TzwPbQpDUxKlCX+S+1MlCSnV
	zAvAEz47liVAHYBOxiuNr2vBGeSzUvcKZdezlAMjGvQ77yXOAeY26kafv+p+RdUz7ZhiM+GdNdB
	0xHv7EQ==
X-Received: from pfaz2.prod.google.com ([2002:aa7:91c2:0:b0:82f:1051:621])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94ce:b0:836:3f6a:3e77
 with SMTP id d2e1a72fcca58-83a5c4bd3afmr8577198b3a.17.1778168647306; Thu, 07
 May 2026 08:44:07 -0700 (PDT)
Date: Thu, 7 May 2026 08:44:06 -0700
In-Reply-To: <afyfFRkUIHuodvG2@blrnaveerao1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506184746.2719880-1-seanjc@google.com> <20260506184746.2719880-3-seanjc@google.com>
 <afyfFRkUIHuodvG2@blrnaveerao1>
Message-ID: <afyzRvFqb19Kodej@google.com>
Subject: Re: [PATCH v2 2/5] KVM: SVM: Always intercept RDMSR for TMCCT
 (current APIC timer count)
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 07, 2026, Naveen N Rao wrote:
> On Wed, May 06, 2026 at 11:47:43AM -0700, Sean Christopherson wrote:
> > Explicitly intercept RDMSR for TMMCT, a.k.a. the current APIC timer count,
> > when x2AVIC is enabled, as TMMCT reads aren't accelerated by hardware.
> 
> s/TMMCT/TMCCT for the above two lines.
> 
> > Disabling interception is suboptimal as the RDMSR generates an
> > AVIC_UNACCELERATED_ACCESS fault #VMEXIT, which forces KVM to decode the
> > instruction to figure out what the guest was trying to access.
> > 
> > Note, the only reason this isn't a fatal bug is that the AVIC architecture
> > had the foresight to guard against buggy hypervisors.  E.g. if hardware
> > simply read from the virtual APIC page, the guest would get garbage.
> > 
> > Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
> > Cc: stable@vger.kernel.org
> > Cc: Naveen N Rao (AMD) <naveen@kernel.org>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/svm/avic.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > index 4f203e503e8e..d693c9ff9f18 100644
> > --- a/arch/x86/kvm/svm/avic.c
> > +++ b/arch/x86/kvm/svm/avic.c
> > @@ -172,6 +172,9 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
> >  		svm_set_intercept_for_msr(vcpu, APIC_BASE_MSR + i,
> >  					  MSR_TYPE_R, intercept);
> >  
> > +	if (!intercept)
> > +		svm_enable_intercept_for_msr(vcpu, X2APIC_MSR(APIC_TMCCT), MSR_TYPE_R);
> > +
> 
> Nit: I'm thinking it might be better to roll this into the previous 
> loop. That way, all MSR_TYPE_R intercepts are setup in one place and we 
> don't need to parse the if (!intercept) condition..
> 
> Something like this?
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index c5d46c0d2403..f292cba45e07 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -136,11 +136,9 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
> 
>         for_each_set_bit(i, (unsigned long *)&x2apic_readable_mask,
>                          BITS_PER_TYPE(x2apic_readable_mask))
> -               svm_set_intercept_for_msr(vcpu, APIC_BASE_MSR + i,
> -                                         MSR_TYPE_R, intercept);
> -
> -       if (!intercept)
> -               svm_enable_intercept_for_msr(vcpu, X2APIC_MSR(APIC_TMCCT), MSR_TYPE_R);
> +               if (APIC_BASE_MSR + i != X2APIC_MSR(APIC_TMCCT))
> +                       svm_set_intercept_for_msr(vcpu, APIC_BASE_MSR + i,
> +                                                 MSR_TYPE_R, intercept);

Hmm, I don't love burying the check in the for-loop, as it makes it a bit hard to
see that KVM *never* toggles the intercept for TMCCT.  And in the unlikely scenario
we need to exempt more MSRs, this will be annoying to maintain.

What about adjusting the mask straightaway?

diff --git arch/x86/kvm/lapic.h arch/x86/kvm/lapic.h
index 274885af4ebc..2842a7b70d74 100644
--- arch/x86/kvm/lapic.h
+++ arch/x86/kvm/lapic.h
@@ -156,6 +156,8 @@ int kvm_hv_vapic_msr_read(struct kvm_vcpu *vcpu, u32 msr, u64 *data);
 int kvm_lapic_set_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned long len);
 void kvm_lapic_exit(void);
 
+#define APIC_REG_MASK(reg)     (1ull << ((reg) >> 4))
+
 u64 kvm_lapic_readable_reg_mask(struct kvm_lapic *apic);
 
 static inline void kvm_lapic_set_irr(int vec, struct kvm_lapic *apic)
diff --git arch/x86/kvm/svm/avic.c arch/x86/kvm/svm/avic.c
index c5d46c0d2403..e51f468477a4 100644
--- arch/x86/kvm/svm/avic.c
+++ arch/x86/kvm/svm/avic.c
@@ -132,16 +132,14 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
        if (!x2avic_enabled)
                return;
 
-       x2apic_readable_mask = kvm_lapic_readable_reg_mask(vcpu->arch.apic);
+       x2apic_readable_mask = kvm_lapic_readable_reg_mask(vcpu->arch.apic) &
+                              ~APIC_REG_MASK(APIC_TMCCT);
 
        for_each_set_bit(i, (unsigned long *)&x2apic_readable_mask,
                         BITS_PER_TYPE(x2apic_readable_mask))
                svm_set_intercept_for_msr(vcpu, APIC_BASE_MSR + i,
                                          MSR_TYPE_R, intercept);
 
-       if (!intercept)
-               svm_enable_intercept_for_msr(vcpu, X2APIC_MSR(APIC_TMCCT), MSR_TYPE_R);
-
        svm_set_intercept_for_msr(vcpu, X2APIC_MSR(APIC_TASKPRI), MSR_TYPE_W, intercept);
        svm_set_intercept_for_msr(vcpu, X2APIC_MSR(APIC_EOI), MSR_TYPE_W, intercept);
        svm_set_intercept_for_msr(vcpu, X2APIC_MSR(APIC_SELF_IPI), MSR_TYPE_W, intercept);


Oh!  Actually, even better!  This is a great opportunity to dedup Intel vs. AMD
(and we can/should do the same for writes).

diff --git arch/x86/kvm/lapic.c arch/x86/kvm/lapic.c
index 4078e624ca66..ac57d6dbe032 100644
--- arch/x86/kvm/lapic.c
+++ arch/x86/kvm/lapic.c
@@ -1730,7 +1730,7 @@ static inline struct kvm_lapic *to_lapic(struct kvm_io_device *dev)
 #define APIC_REGS_MASK(first, count) \
        (APIC_REG_MASK(first) * ((1ull << (count)) - 1))
 
-u64 kvm_lapic_readable_reg_mask(struct kvm_lapic *apic)
+static u64 kvm_lapic_readable_reg_mask(struct kvm_lapic *apic)
 {
        /* Leave bits '0' for reserved and write-only registers. */
        u64 valid_reg_mask =
@@ -1766,7 +1766,22 @@ u64 kvm_lapic_readable_reg_mask(struct kvm_lapic *apic)
 
        return valid_reg_mask;
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_lapic_readable_reg_mask);
+
+u64 kvm_x2apic_disable_intercept_reg_mask(struct kvm_vcpu *vcpu)
+{
+       if (WARN_ON_ONCE(!lapic_in_kernel(vcpu)))
+               return 0;
+
+       /*
+        * TMMCT, a.k.a. the current APIC timer count, reads aren't accelerated
+        * by hardware (Intel or AMD), and handling the fault-like APIC-access
+        * VM-Exit is more expensive than handling a WRMSR VM-Exit (because the
+        * APIC-access path requires slow emulation of the code stream).
+        */
+       return kvm_lapic_readable_reg_mask(vcpu->arch.apic) &
+              ~APIC_REG_MASK(APIC_TMCCT);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_x2apic_disable_intercept_reg_mask);
 
 static int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
                              void *data)
diff --git arch/x86/kvm/lapic.h arch/x86/kvm/lapic.h
index 274885af4ebc..7b61167e1b5c 100644
--- arch/x86/kvm/lapic.h
+++ arch/x86/kvm/lapic.h
@@ -156,7 +156,7 @@ int kvm_hv_vapic_msr_read(struct kvm_vcpu *vcpu, u32 msr, u64 *data);
 int kvm_lapic_set_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned long len);
 void kvm_lapic_exit(void);
 
-u64 kvm_lapic_readable_reg_mask(struct kvm_lapic *apic);
+u64 kvm_x2apic_disable_intercept_reg_mask(struct kvm_vcpu *vcpu);
 
 static inline void kvm_lapic_set_irr(int vec, struct kvm_lapic *apic)
 {
diff --git arch/x86/kvm/svm/avic.c arch/x86/kvm/svm/avic.c
index c5d46c0d2403..1532bfff5686 100644
--- arch/x86/kvm/svm/avic.c
+++ arch/x86/kvm/svm/avic.c
@@ -132,16 +132,13 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
        if (!x2avic_enabled)
                return;
 
-       x2apic_readable_mask = kvm_lapic_readable_reg_mask(vcpu->arch.apic);
+       x2apic_readable_mask = kvm_x2apic_disable_intercept_reg_mask(vcpu);
 
        for_each_set_bit(i, (unsigned long *)&x2apic_readable_mask,
                         BITS_PER_TYPE(x2apic_readable_mask))
                svm_set_intercept_for_msr(vcpu, APIC_BASE_MSR + i,
                                          MSR_TYPE_R, intercept);
 
-       if (!intercept)
-               svm_enable_intercept_for_msr(vcpu, X2APIC_MSR(APIC_TMCCT), MSR_TYPE_R);
-
        svm_set_intercept_for_msr(vcpu, X2APIC_MSR(APIC_TASKPRI), MSR_TYPE_W, intercept);
        svm_set_intercept_for_msr(vcpu, X2APIC_MSR(APIC_EOI), MSR_TYPE_W, intercept);
        svm_set_intercept_for_msr(vcpu, X2APIC_MSR(APIC_SELF_IPI), MSR_TYPE_W, intercept);
diff --git arch/x86/kvm/vmx/vmx.c arch/x86/kvm/vmx/vmx.c
index 859f4bc01445..40dff50e800a 100644
--- arch/x86/kvm/vmx/vmx.c
+++ arch/x86/kvm/vmx/vmx.c
@@ -4138,7 +4138,7 @@ static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu)
         * mode, only the current timer count needs on-demand emulation by KVM.
         */
        if (mode & MSR_BITMAP_MODE_X2APIC_APICV)
-               msr_bitmap[read_idx] = ~kvm_lapic_readable_reg_mask(vcpu->arch.apic);
+               msr_bitmap[read_idx] = ~kvm_x2apic_disable_intercept_reg_mask(vcpu);
        else
                msr_bitmap[read_idx] = ~0ull;
        msr_bitmap[write_idx] = ~0ull;
@@ -4151,7 +4151,6 @@ static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu)
                                  !(mode & MSR_BITMAP_MODE_X2APIC));
 
        if (mode & MSR_BITMAP_MODE_X2APIC_APICV) {
-               vmx_enable_intercept_for_msr(vcpu, X2APIC_MSR(APIC_TMCCT), MSR_TYPE_RW);
                vmx_disable_intercept_for_msr(vcpu, X2APIC_MSR(APIC_EOI), MSR_TYPE_W);
                vmx_disable_intercept_for_msr(vcpu, X2APIC_MSR(APIC_SELF_IPI), MSR_TYPE_W);
                if (enable_ipiv)
