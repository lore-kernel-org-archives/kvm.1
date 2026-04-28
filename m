Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853132EDD62
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391447; cv=none; b=NItHKwzHrU4MiNQm2G6EsU6d6qp80gBOsIz97Zg7EteW2KHyzzAHhC6SgBLlbIDTbsWXf+mtRU6lVUiQKchtf8ZQtwGVzx2VQRUaugrzTB4h76pAwZ+8ydoTDFZxhtBY8Qv0LrqZiRlWJsmMd7A3lBj/UvUC7AvDE3fwjjTg1PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391447; c=relaxed/simple;
	bh=BKXhxGh1sTEHHhnwP/QsA2ATN16MqDi0OKRnEkmXjQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ajD/zJbj9iV/k6OoXCxL10kmYZUrN4Cc8OkBHBduCmKdmm3byb7DRrN3JbowaRzH1L2jzv5h9Wl62OjouDZpgIF0yeWM0MU8/ICjBDZfs+BggWrAJMqIhqUqxD9KObLC4hBjOtthEv5T+y4cBj4UDT/sa5wkNPmlEOlK8RqnCBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dDpj7bcR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDpj7bcR"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35d9e67f6dcso15269180a91.1
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777391445; x=1777996245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AP/DrXQFzqB8MkDCwnS7hDDmO4bhnnC+1iwK0/8Ic9U=;
        b=dDpj7bcR2jPMAmp7sKo/NsP8Q1KazcqLBgUY3HA2IUKbRPXn2MnhY3UINzy5ghR+ll
         r+CrxKSaNILVQzRHHRnrt5o5NRjEFfyV4wTpLz/q/XdCOsVWsYWjwJ+I0wR2eekkSO5G
         7o/xjdSIRGHyzDZusN2VCZWhgkfkGhQwk89/d44Pumfh/tJaKVBXdta6qOXimXWzWNeI
         8oPPhqKUek2F1gBNBtYRBa2rDOehNnEJoC6FDyD0ITkRgl5mNbN8652tVNLuvdXKGeSb
         GZAZloKCJV9eTjB2CCJvW9yMFvf0DwZagxWauYt4HTu88bWZicM0fhkivDH9se+aBLHX
         6tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777391445; x=1777996245;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AP/DrXQFzqB8MkDCwnS7hDDmO4bhnnC+1iwK0/8Ic9U=;
        b=CLMfjfM+bUgOLAizT8HN5wPzZg4odeLLX0iee/rE3qk+DKOeDQHDz8pYl5nwGbP0Os
         X8lVDznbeuG836sSIPU7e1wMzN82ExQOe963kFYknc6dnw63Mvg7/WZ1/vw9k3nhTar7
         gkceQkXhBdwnO65LUxce2zNkhfZcwUKZbBTbof6cTVGxDw9l0E86U0ZdHR/3wpiSKoD7
         nCC9OGP3tGRGdLfWOtD7urOtUryVl8rwCrHHMkpy9gj9LEnMf9sUlVnC5H1xL1Su91DZ
         YKYiE5W96q33Jhi/Y0e7NdF6J70T/P7ERvovS78ZWfeE8LEsDadEA6U7kVA4JbnEv0j7
         Ux4g==
X-Forwarded-Encrypted: i=1; AFNElJ9NTWwJp6jaT3sVjmnUdgNSrTA3JQ+S1Wfo+fnMj7vnjGl8rAkMEyyNO66BEKZCRS9zi0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAL0DUnpE6ZgEHUxU9u3bLWI4hckMS5tQCaA89pdI2TAIOvDX1
	+tZVKZGMkIOq4X9FKTWf1i9/7D90VDNf2w0UdSzFIi/I9ZkQuiR4NlLJGBUsOlAMnORIET7dHwE
	YjYswyw==
X-Received: from pjsk9.prod.google.com ([2002:a17:90a:62c9:b0:35c:e06:8f50])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c90:b0:35f:b870:9c9f
 with SMTP id 98e67ed59e1d1-36491fa1a6dmr4266624a91.12.1777391444709; Tue, 28
 Apr 2026 08:50:44 -0700 (PDT)
Date: Tue, 28 Apr 2026 08:50:43 -0700
In-Reply-To: <04c954e6-a23a-4cc8-8bd3-5882a951a8cc@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428070349.1633238-1-chenyi.qiang@intel.com>
 <3235eb76-9b28-4000-920a-491659927e67@redhat.com> <04c954e6-a23a-4cc8-8bd3-5882a951a8cc@intel.com>
Message-ID: <afDXUwq6pR7SgxIC@google.com>
Subject: Re: [PATCH] KVM: VMX: Fall back to IRR scan when PIR is empty despite
 PID.ON being set
From: Sean Christopherson <seanjc@google.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Gao Chao <chao.gao@intel.com>, 
	Farrah Chen <farrah.chen@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026, Chenyi Qiang wrote:
> On 4/28/2026 3:45 PM, Paolo Bonzini wrote:
> > On 4/28/26 09:03, Chenyi Qiang wrote:
> >> The interrupt is not lost (it resides in the IRR from the first sync a=
nd
> >> is recovered on the next vcpu_enter_guest() iteration), but the incorr=
ect
> >> max_irr causes a spurious WARNING and a wasted L2 VM-Enter/VM-Exit cyc=
le.
> >>
> >> Fixes: b41f8638b9d3 ("KVM: VMX: Isolate pure loads from atomic XCHG wh=
en processing PIR")

Cc: stable@vger.kernel.org

> >> Reported-by: Farrah Chen <farrah.chen@intel.com>
> >> Assisted-by: GitHub Copilot:Claude Opus 4.6
> >> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> >>
> >> ---
> >> There is a WARNING call trace during a nested VM stress test.

Any chance the stress test is something that can be shared?  I've seen this=
 WARN
2-3 times over the last year, but it was never reproducible, and so intermi=
ttent
that I couldn't even correlate what I was doing at the time with the WARN.

> > The analysis of the race is correct and changing the logic is the
> > right thing to do; but I would change directly __kvm_apic_update_irr,
> > either like this:
> >=20
> > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > index e3ec4d8607c1..5ee14d6bc288 100644
> > --- a/arch/x86/kvm/lapic.c
> > +++ b/arch/x86/kvm/lapic.c
> > @@ -669,12 +669,14 @@ bool __kvm_apic_update_irr(unsigned long *pir, vo=
id *regs, int *max_irr)
> > =C2=A0=C2=A0=C2=A0=C2=A0 u32 irr_val, prev_irr_val;
> > =C2=A0=C2=A0=C2=A0=C2=A0 int max_updated_irr;
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0 if (!pi_harvest_pir(pir, pir_vals)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *max_irr =3D apic_find_high=
est_vector(regs + APIC_IRR);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> > +=C2=A0=C2=A0=C2=A0 }

Holy moly, this code is all kinds of subtle.

For Paolo's suggested fix,

  Reviewed-by: Sean Christopherson <seanjc@google.com>

But this code needs some naming tweaks and more comments, because I've been=
 staring
at this for over an hour (more than two now, *sigh*), and have been _this_ =
close
to making two suggestions that were subtly very, very wrong.

First off, both irr_updated in kvm_apic_update_irr() and got_posted_interru=
pt in
vmx_sync_pir_to_irr() are misnomers.  __kvm_apic_update_irr() and thus
kvm_apic_update_irr() don't return true if a new posted IRQ was found, they=
 return
true if at least one new posted IRQ was found *and* the highest priority "n=
ew" IRQ
is also now the highest priority IRQ in the IRR.

Near-bug-suggestion #1 (in my chronological order of analysis) was to drop =
what
I _thought_ was a micro-optimization of detecting *new* IRQs in the IRR.  I=
.e. I
thought skipping KVM_REQ_EVENT was purely an optimization to avoid re-evalu=
ating
IRQs.  But it's not an optimization, it's functionally necessary, because s=
etting
KVM_REQ_EVENT if there was a pre-existing IRQ in the IRR would put the vCPU=
 into
an infinite loop if the IRQ is blocked: KVM won't move the IRQ out of the I=
RQ
until it can be injected, and so KVM would always see the pending IRQ, alwa=
ys
set KVM_REQ_EVENT, and thus never actually attempt VM-Enter.

Near-bug-suggestion #2, after realizing the functional necessity of the cod=
e, was
the thought that there's a pre-existing bug due to this behavior.  When the=
 vCPU
is running L2 or APICv is inactive, KVM needs to set KVM_REQ_EVENT if a new=
 IRQ
is found, in order to trigger the various checks that ensure KVM delivers/i=
njects
the IRQ in a timely fashion.  So of course setting KVM_REQ_EVENT only if a =
the
new IRQ is the highest IRQ must be wrong, right?

Nope.  Because if there was a pre-existing, higher priority IRQ in the IRR,=
 then
either that IRQ is already primed for injection via the VMCS, or KVM has re=
quested
an IRQ window because the higher priority IRQ is blocked.  In the latter ca=
se,
there's more obviously nothing to be done since KVM will do process pending=
 IRQs
when an IRQ window is opened.  The former case is more subtle though: KVM d=
oesn't
need to re-evaluate interrupts, because either EOI from the guest is guaran=
teed
to exit (APICv is inactive and/or L2 is running and L1 is running L2 with
exit-on-interrupt off, i.e. without nested virtual interrupt delivery), or =
the
highest IRQ is guaranteed to trigger a nested VM-Exit, (L2 is running and L=
1 is
running L2 with exit-on-interrupt on).

On top of Paolo's suggested fix:

---
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 28 Apr 2026 07:33:20 -0700
Subject: [PATCH] KVM: x86: Fix misleading variable names and add more comme=
nts
 for PIR=3D>IRR flow

Rename kvm_apic_update_irr()'s "irr_updated" and vmx_sync_pir_to_irr()'s
"got_posted_interrupt" to a more accurate "max_irr_is_from_pir", as neither
"irr_updated" nor "got_posted_interrupt" is accurate.
__kvm_apic_update_irr() and thus kvm_apic_update_irr() specifically return
true if and only if the highest priority IRQ, i.e. max_irr, is a "new"
pending IRQ from the PIR.  I.e. it's possible for the IRR to be updated,
i.e. for a posted IRQ to be "got", *without* the APIs returning true.

Expand vmx_sync_pir_to_irr()'s comment to explain why it's necessary to
set KVM_REQ_EVENT only if a "new" IRQ was found, and to explain why it's
safe to do so only if a new IRQ is also the highest priority pending IRQ.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c   | 16 ++++++++--------
 arch/x86/kvm/vmx/vmx.c | 40 ++++++++++++++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 4d4b003cf7b2..0cac6decdef9 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -667,9 +667,9 @@ bool __kvm_apic_update_irr(unsigned long *pir, void *re=
gs, int *max_irr)
 	u32 *__pir =3D (void *)pir_vals;
 	u32 i, vec;
 	u32 irr_val, prev_irr_val;
-	int max_updated_irr;
+	int max_new_irr;
=20
-	max_updated_irr =3D -1;
+	max_new_irr =3D -1;
 	*max_irr =3D -1;
=20
 	if (!pi_harvest_pir(pir, pir_vals)) {
@@ -690,25 +690,25 @@ bool __kvm_apic_update_irr(unsigned long *pir, void *=
regs, int *max_irr)
 				 !try_cmpxchg(p_irr, &prev_irr_val, irr_val));
=20
 			if (prev_irr_val !=3D irr_val)
-				max_updated_irr =3D __fls(irr_val ^ prev_irr_val) + vec;
+				max_new_irr =3D __fls(irr_val ^ prev_irr_val) + vec;
 		}
 		if (irr_val)
 			*max_irr =3D __fls(irr_val) + vec;
 	}
=20
-	return ((max_updated_irr !=3D -1) &&
-		(max_updated_irr =3D=3D *max_irr));
+	return (max_new_irr !=3D -1) && (max_new_irr =3D=3D *max_irr);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_apic_update_irr);
=20
 bool kvm_apic_update_irr(struct kvm_vcpu *vcpu, unsigned long *pir, int *m=
ax_irr)
 {
 	struct kvm_lapic *apic =3D vcpu->arch.apic;
-	bool irr_updated =3D __kvm_apic_update_irr(pir, apic->regs, max_irr);
+	bool max_irr_is_from_pir;
=20
-	if (unlikely(!apic->apicv_active && irr_updated))
+	max_irr_is_from_pir =3D __kvm_apic_update_irr(pir, apic->regs, max_irr);
+	if (unlikely(!apic->apicv_active && max_irr_is_from_pir))
 		apic->irr_pending =3D true;
-	return irr_updated;
+	return max_irr_is_from_pir;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_apic_update_irr);
=20
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a29896a9ef14..4e1aadd89c63 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7029,8 +7029,8 @@ static void vmx_set_rvi(int vector)
 int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vt *vt =3D to_vt(vcpu);
+	bool max_irr_is_from_pir;
 	int max_irr;
-	bool got_posted_interrupt;
=20
 	if (KVM_BUG_ON(!enable_apicv, vcpu->kvm))
 		return -EIO;
@@ -7042,17 +7042,22 @@ int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
 		 * But on x86 this is just a compiler barrier anyway.
 		 */
 		smp_mb__after_atomic();
-		got_posted_interrupt =3D
-			kvm_apic_update_irr(vcpu, vt->pi_desc.pir, &max_irr);
+		max_irr_is_from_pir =3D kvm_apic_update_irr(vcpu, vt->pi_desc.pir,
+							  &max_irr);
 	} else {
 		max_irr =3D kvm_lapic_find_highest_irr(vcpu);
-		got_posted_interrupt =3D false;
+		max_irr_is_from_pir =3D false;
 	}
=20
 	/*
-	 * Newly recognized interrupts are injected via either virtual interrupt
-	 * delivery (RVI) or KVM_REQ_EVENT.  Virtual interrupt delivery is
-	 * disabled in two cases:
+	 * If APICv is enabled and L2 is not active, then update the Requesting
+	 * Virtual Interrupt (RVI) portion of vmcs01.GUEST_INTR_STATUS with the
+	 * highest priority IRR to deliver the IRQ via Virtual Interrupt
+	 * Delivery.  Note, this is required even if the highest priority IRQ
+	 * was already pending in the IRR, as RVI isn't update in lockstep with
+	 * the IRR (unlike apic->irr_pending).
+	 *
+	 * For the cases where Virtual Interrupt Delivery can't be used:
 	 *
 	 * 1) If L2 is running and the vCPU has a new pending interrupt.  If L1
 	 * wants to exit on interrupts, KVM_REQ_EVENT is needed to synthesize a
@@ -7063,10 +7068,29 @@ int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
 	 * 2) If APICv is disabled for this vCPU, assigned devices may still
 	 * attempt to post interrupts.  The posted interrupt vector will cause
 	 * a VM-Exit and the subsequent entry will call sync_pir_to_irr.
+	 *
+	 * In both cases, set KVM_REQ_EVENT if and only if the highest priority
+	 * pending IRQ came from the PIR, as setting KVM_REQ_EVENT if any IRQ
+	 * is pending may put the vCPU into an infinite loop, e.g. if the IRQ
+	 * is blocked, then it will stay pending until an IRQ window is opened.
+	 *
+	 * Note!  It's possible that one or more IRQs were moved from the PIR
+	 * to the IRR _without_ max_irr_is_from_pir being true!  I.e. if there
+	 * was a higher priority IRQ already pending in the IRR.  Not setting
+	 * KVM_REQ_EVENT in this case is intentional and safe.  If APICv is
+	 * inactive, or L2 is running with exit-on-interrupt off (in vmcs12),
+	 * i.e. without nested virtual interrupt delivery, then there's no need
+	 * to request an IRQ window as the lower priority IRQ only needs to be
+	 * delivered when the higher priority IRQ is dismissed from the ISR,
+	 * i.e. on the next EOI, and EOIs are always intercepted if APICv is
+	 * disabled or if L2 is running without nested VID.  If L2 is running
+	 * exit-on-interrupt on (in vmcs12), then the higher priority IRQ will
+	 * trigger a nested VM-Exit, at which point KVM will re-evaluate L1's
+	 * pending IRQs.
 	 */
 	if (!is_guest_mode(vcpu) && kvm_vcpu_apicv_active(vcpu))
 		vmx_set_rvi(max_irr);
-	else if (got_posted_interrupt)
+	else if (max_irr_is_from_pir)
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
=20
 	return max_irr;

base-commit: a98d8321896bf010f877b5edb88d3f14627c943a
--
