Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64843D994
	for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248376; cv=none; b=M92f7KAA8F7lKh693aQVEke5DTRzqZcnQV1h5XSLHKU6cKL6qsuxYWIS5hrEXQGXOCiPBWAeKAaOxVDWs/SmLQTRkRQRROghfZGk7qYKSuxPP1iVIkTL/vc7yh5di4LPDtfMwe14r3wlPdA278vJQN0g/j7AMv++LX39PvCOkIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248376; c=relaxed/simple;
	bh=cPr1Huwe/LeQ+kju7chDpmHbf+xQPpv7XwkCXW2T5Ow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WzthsnSXFdDXySw3FJj63WgwkdBtGkJfibX2o3dRc3vyTj50aR2bu5UFaniKWzOBFIDBsBK52Re1tyvlLVttADgjYeBcsJK6rkajxMhWirTchCc8Vgsue2MCKV2reIyY+6bdtbP/5DA2ucPpxxqOb3uTuV2RGNXw9+Reck7oK20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jRfqCyW1; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jRfqCyW1"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd6532dbd7bso678507a12.2
        for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 07:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792248374; x=1792853174; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5YjTyKWZuH05/ZhTwWgCJdu9/Y1Qp2hvgkotUhyJ1PQ=;
        b=jRfqCyW1OrEjS4TG+OS/vRc6VpzCBFjDORhc0aVzr0Mn/SoWimk4qdvlkvtBZmhr59
         ZbNB9PnXOoVoXYrvSlwxzMzJmBaI+tYsFrcGQQSOj6Xu2kJ0kgcQUNQty+jXyWekGWs2
         QZTbUYdlT53w7Mm6INO4t3s7elegaCI0O/w/5aGR3Xkz0RLm0MtX+7uD6lr8QlXDuZtA
         LYb2LuFDvZhbY/5GREZycRfn7gUBoGwcj7BZtmllkXKnfaPlPxxNuY4FIuyTNHJEcavg
         Mlbs5X23jfKncn/JTyy9ZftAg00olUH8HBi+FaTQ6U7T6an8nZb6vN51FaqOQUR/69kR
         DMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792248374; x=1792853174;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5YjTyKWZuH05/ZhTwWgCJdu9/Y1Qp2hvgkotUhyJ1PQ=;
        b=BW7B/NJQcJ12uUjx1ikg+ZXfT3yvmLUq6PabVzo97wJrh+f7wZiTKHk80I6fhcSTzy
         8+n/oafK3ACPkkmfJoteLJrMpSqom4q5VQRUYxcqhbdPFC94rLDOnmWK3YUxMl9oU1yW
         4KbUGGfBcsqYt5cXju2Fu9UDTFvTPKgvyEbrIw+ZdIWeicVkjscyhfJkwkTTwsCPBVJb
         E2cise4uKpc1hB9YCrB2GjNWbqQE9FmyR/yqAKW05JEPvcPlpKbAg0Vzf3HQslGN3Ulx
         u2pa5fv1Zkr3QHnzConB/YLCb1BXKCWGYa6umRjZ7dHME/Tb08EBulHTdlPkbCbG29xo
         Y7PQ==
X-Forwarded-Encrypted: i=1; AKwUvByEtRu2Bq1xLP955G1V7n92V8xBzMc7f1ld2H3fVP4OjBfYpDnCjRqkGeXVovh2sztcwac=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnOC2BZ7FML5OQDUMJ73HDr01YJFiyGnboFtoj3YEdiOE9Ojs7
	oPV1SpT80SIoq72KJZsyjBR4gt2r1f5b/JB7wvEg+rMB0ZKrNiah+iUtIBLWBYZqCjqvYdNPo0U
	7CnqAng==
X-Received: from pgbm1-n1.prod.google.com ([2002:a05:6a02:6181:10b0:cca:bb35:aa7b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:62c3:b0:3e1:a7df:3756
 with SMTP id adf61e73a8af0-3e225fcc626mr1919269637.48.1792248373818; Sat, 17
 Oct 2026 07:46:13 -0700 (PDT)
Date: Sat, 17 Oct 2026 07:46:13 -0700
In-Reply-To: <sashiko-outbox-175447@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261017093016.32348-2-amirmohammad.eftekhar@cispa.de> <sashiko-outbox-175447@kernel.org>
Message-ID: <atOKNaeDY7UkIYJH@google.com>
Subject: Re: [PATCH] KVM: VMX: Load the EOI-exit bitmap into vmcs01, not the
 active VMCS
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Oct 17, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] KVM: VMX: vmx_load_eoi_exitmap() comment mismatch and deferred L2 update
> --
> 
> commit b2b472dc800418ff9ed851c85722ed6e99a11a91
> Author: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
> 
> KVM: VMX: Load the EOI-exit bitmap into vmcs01, not the active VMCS
> 
> This commit adds guard(vmx_vmcs01) to vmx_load_eoi_exitmap() so that updates
> to EOI_EXIT_BITMAP0..3 target vmcs01 rather than whichever VMCS happens to be
> loaded on the CPU.
> 
> >     KVM: VMX: Load the EOI-exit bitmap into vmcs01, not the active VMCS
> >     
> >     vmx_load_eoi_exitmap() writes EOI_EXIT_BITMAP0..3 directly with
> >     vmcs_write64() and, unlike its siblings vmx_hwapic_isr_update() and
> >     vmx_sync_pir_to_irr(),
> >     does not take guard(vmx_vmcs01).  The EOI-exit bitmap belongs to L1's APIC,
> >     but with nested virtual-interrupt-delivery an L2 can be active when KVM
> >     refreshes it (e.g. via kvm_vcpu_reload_apic_access_page() /
> >     vcpu_scan_ioapic()), so the writes land in vmcs02 instead of vmcs01: L2's
> >     EOI-exit bitmap is corrupted and vmcs01's is left stale until the next L1
> >     refresh.
> >     
> >     Add guard(vmx_vmcs01), matching the sibling APICv callbacks.
> >     
> >     Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
> 
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 612ab07d4100f..ec2ea3e1d14d8 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -7139,6 +7139,13 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
> >  	if (!kvm_vcpu_apicv_active(vcpu))
> >  		return;
> >  
> > +	/*
> > +	 * The EOI-exit bitmap tracks L1's APIC, so it must land in vmcs01, not
> > +	 * whichever VMCS is currently loaded; a nested VID L2 can be active
> > +	 * here.  Mirror vmx_hwapic_isr_update()/vmx_sync_pir_to_irr().
> > +	 */
> > +	guard(vmx_vmcs01)(vcpu);
> > +
> >  	vmcs_write64(EOI_EXIT_BITMAP0, eoi_exit_bitmap[0]);
> >  	vmcs_write64(EOI_EXIT_BITMAP1, eoi_exit_bitmap[1]);
> >  	vmcs_write64(EOI_EXIT_BITMAP2, eoi_exit_bitmap[2]);
> 
> [Severity: Medium]
> Can vcpu_scan_ioapic() or kvm_vcpu_reload_apic_access_page() actually trigger
> vmx_load_eoi_exitmap() while L2 is active, as described in the commit message
> and comment?

Not in normal operation, no.  Maybe if userspace does something bizarre and forces
the vCPU back into L2 after the exit, but before KVM_RUN?  Regardless, we should
rip out the deferred update, I simply missed it when removing all the others,
probably because it was buring in kvm_vcpu_arch instead of vcpu_vmx.

Not yet tested...

---
From: Sean Christopherson <seanjc@google.com>
Date: Sat, 17 Oct 2026 07:33:11 -0700
Subject: [PATCH] KVM: x86: Switch to vmcs01 to update EOIT exiting bitmap
 on-demand if L2 is active

If KVM needs to update the EOI bitmap while L2 is running, temporarily load
vmcs01 and immediately refresh the bitmap in vmcs01 instead of deferring
the update until the next nested VM-Exit.  I.e. give the EOI bitmap the
same treatment as the many other updates that were previously deferred.

Reported-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Closes: https://lore.kernel.org/all/20261017093016.32348-2-amirmohammad.eftekhar@cispa.de
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/regs.h             |  6 ------
 arch/x86/kvm/vmx/vmx.c          |  2 ++
 arch/x86/kvm/x86.c              | 13 -------------
 4 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e2eef7057bd3..9583bde5c848 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -108,7 +108,7 @@
 #define KVM_REQ_HV_RESET		KVM_ARCH_REQ(20)
 #define KVM_REQ_HV_EXIT			KVM_ARCH_REQ(21)
 #define KVM_REQ_HV_STIMER		KVM_ARCH_REQ(22)
-#define KVM_REQ_LOAD_EOI_EXITMAP	KVM_ARCH_REQ(23)
+/*#define FREE!!!  USE ME!!!		KVM_ARCH_REQ(23) */
 #define KVM_REQ_GET_NESTED_STATE_PAGES	KVM_ARCH_REQ(24)
 #define KVM_REQ_APICV_UPDATE \
 	KVM_ARCH_REQ_FLAGS(25, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 97c17b120a57..04d047f46753 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -463,12 +463,6 @@ static inline void enter_guest_mode(struct kvm_vcpu *vcpu)
 static inline void leave_guest_mode(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.hflags &= ~HF_GUEST_MASK;
-
-	if (vcpu->arch.load_eoi_exitmap_pending) {
-		vcpu->arch.load_eoi_exitmap_pending = false;
-		kvm_make_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu);
-	}
-
 	vcpu->stat.guest_mode = 0;
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b341af4c6057..59b48d959ee0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7082,6 +7082,8 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 	if (!kvm_vcpu_apicv_active(vcpu))
 		return;
 
+	guard(vmx_vmcs01)(vcpu);
+
 	vmcs_write64(EOI_EXIT_BITMAP0, eoi_exit_bitmap[0]);
 	vmcs_write64(EOI_EXIT_BITMAP1, eoi_exit_bitmap[1]);
 	vmcs_write64(EOI_EXIT_BITMAP2, eoi_exit_bitmap[2]);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba9..0028d57e964a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8062,17 +8062,6 @@ static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 		kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
 #endif
 
-	if (is_guest_mode(vcpu))
-		vcpu->arch.load_eoi_exitmap_pending = true;
-	else
-		kvm_make_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu);
-}
-
-static void vcpu_load_eoi_exitmap(struct kvm_vcpu *vcpu)
-{
-	if (!kvm_apic_hw_enabled(vcpu->arch.apic))
-		return;
-
 #ifdef CONFIG_KVM_HYPERV
 	if (to_hv_vcpu(vcpu)) {
 		u64 eoi_exit_bitmap[4];
@@ -8240,8 +8229,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 		if (kvm_check_request(KVM_REQ_SCAN_IOAPIC, vcpu))
 			vcpu_scan_ioapic(vcpu);
-		if (kvm_check_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu))
-			vcpu_load_eoi_exitmap(vcpu);
 		if (kvm_check_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu))
 			kvm_vcpu_reload_apic_access_page(vcpu);
 #ifdef CONFIG_KVM_HYPERV

base-commit: dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4
-- 
