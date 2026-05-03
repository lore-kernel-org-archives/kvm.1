Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6678C375ADF
	for <kvm@vger.kernel.org>; Sun,  3 May 2026 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777839438; cv=none; b=crR0rbomG+t1piON6WtJzUeKXExQEvpt6aSyFMLmPgZ7JBL5ADD93jgWlHTqYTwlorWYel+gnZFK638XsLL3Esmxfx8blOvK6q+c73NKUMKiDKM4uqiA5izs665wdxkzG/3ekeJL4XMbIbodL6dy9i/oEMmHlnyrQN7TiBLddB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777839438; c=relaxed/simple;
	bh=vHGELw01CfVMPo3oS+tSKZTwU3Pk22EiGyP+znUd6d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFkiYtXnhZw1Qk2CBfp55fFtXCCxaWGJbHJlhIQ8n0jksCL3/gnZ1mVaOeHVo/tszJNVB3ZiNGpSl/cnxOcj6bG7TfFhIxg5uISrUgS1q7nYuBHBFtS4HhdYm3ACcAmIs9MZZoCKadD0g8BfknrLk8F37jl6jtlkU4zraKFk8dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0ptz5yn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWO0CdGI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0ptz5yn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWO0CdGI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777839433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qoof0QP2ICD/jTmNNrG4fkHvjJrYgerZ9Ct4SB/uRWE=;
	b=Y0ptz5ynOPQKmG8rg3f2MoaPTG3IQLPMm+1Xf3TH4tnitDrCcH9ZMOc6Rxv3GdF5DMZ0jb
	kx0qLOD/sK7U28kwiA0WbRiFWiluErft/g4wUOOCalc2ASOkZEkrTs+Rnk3m0A81WhxAso
	X8LuUYnlZ4/lTaNuPmAsMfDpJn+ryUs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-xIc2emouPvmXr-0Za44YnQ-1; Sun, 03 May 2026 16:17:12 -0400
X-MC-Unique: xIc2emouPvmXr-0Za44YnQ-1
X-Mimecast-MFC-AGG-ID: xIc2emouPvmXr-0Za44YnQ_1777839431
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4411a2c034fso2615826f8f.3
        for <kvm@vger.kernel.org>; Sun, 03 May 2026 13:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777839431; x=1778444231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoof0QP2ICD/jTmNNrG4fkHvjJrYgerZ9Ct4SB/uRWE=;
        b=FWO0CdGIKTxTmy2iOyzR8+104e73j/XCa1HZLc5av82y5EuJ1+zZdGUweT7G2Q/Cgg
         MLFYL307E4Uy2QCWOsPfsiIHf9VyedLVtdhiaDBq0oRv+lXeb8TJ6fW7DCXsz5GBawNd
         TS83+2aq9GtpqAgMb/jczGYAvpnTiDWpxsC6WSifgLvGg5Ga3DCQYfETGzMAh+Kb2zc/
         35BFwO0ZLeniVdEwaXj2aFt+DV0oxBOl0CCmGZbIuz4SQT6zNvVhf7So/2KpWLBrgP2a
         /Tcq44j1wnWCIirmxV8VHsglJvCQMJ5w8qlKyTxmZa1pEhbLOK/4SYEg0vS6LokqGmn3
         62iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777839431; x=1778444231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qoof0QP2ICD/jTmNNrG4fkHvjJrYgerZ9Ct4SB/uRWE=;
        b=MqUCxjXOu8juRB9jNwYl95uQjxKPE62TF1VrLjttV3hwcDfPpriczDAJbRwRISXkLq
         bzQRJXMGeTq3C+RCjVyYEdijRU3TkHeHesdXEVvezxvoFOuvIQIWKPBOZR0jk1QXpfe4
         hfRny/uwOmhpZ0w3sJhG9SFsLjgE5LhRGxM6yP2qsNOC3PtIMV3Zv4jQd4XT+Hxr5Q3V
         iW7OpiBgCCCS3Thyg+TQ2bC21dF2NW/ylrmILlMSlgcm4/iMhYbd5S4eTBtoQVpBmhFw
         cj787RDAC5ZCckkSQlO9V+BkjT6Z2TLJUh4egBuc4a/zUiJMAi3gU5F2rVhBLnk1Psmp
         Py3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/my5NuUbuoQW9A+cWXdBp+Mh+lgT3taOtusRAU3xMSFKyrvWEwqjdKzdyugzijUJRPs+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWYz/SGMRf9im80wpK75Lz1SI72OgXgZmNJvp0m9n0KqWMlkGO
	VT+84sk3oJW3SBoXgwcCBT+Jg3kQfEhJg21to8fSGgBovB4OQBdlgZ1NBj3LF0bRcix5WDln8GW
	iqbCmTBqhZWEjJY9UXI39GL0l7MGK7zIz33NYqZZpknIGd/yMLWs1XdCC66P3SA==
X-Gm-Gg: AeBDiescYERC9z9m9uiJBhUfbM8+xmAETZizH4QLOMBX6CJrmwZ187MkBt9SscVTKXl
	xU8F2mgNcO42T1DGndEoIiWTnUf8sLv7Yko3XBaNeoYzcUSgJkF5WbZkVgTmR4uzGhPIXzGycG6
	6pZbtMuGkIm8nRheOBm4JhlpnwZE7wDkbqXP168wOfuCpNx5YgXM0UgmCwXxvI/+3PMqsTvmujB
	dh86Nrufadb5rUVQNlle8XG3L/2dFA/jDUow9EKWJ7gQbq0xyK2Fovm0EEOZ7eG24F5OcEOeORe
	IPo8RlnKmVnWBVUY8QzHeNojnsvMfU+hNCfN1tAboCE8DJozcjYbGRibJuLbTXAFbdUzNTrpQlQ
	X2eg/7cpVsu53n4Ff/WooimaMt9cGIFFkTcvdBuLKuCm7IL3/hVxOP2kiV/rvo2oaUpJYHYWxj9
	G2i0lbb7wr/MiO7v0Oorv1jYKXRu/kF6N3v3g=
X-Received: by 2002:a5d:584a:0:b0:43d:6a0c:9571 with SMTP id ffacd0b85a97d-44bb4af8960mr11709804f8f.11.1777839430861;
        Sun, 03 May 2026 13:17:10 -0700 (PDT)
X-Received: by 2002:a5d:584a:0:b0:43d:6a0c:9571 with SMTP id ffacd0b85a97d-44bb4af8960mr11709777f8f.11.1777839430424;
        Sun, 03 May 2026 13:17:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a98b76fd0sm21881053f8f.35.2026.05.03.13.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 13:17:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: chenyi.qiang@intel.com,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 2/2] KVM: x86: Fix misleading variable names and add more comments for PIR=>IRR flow
Date: Sun,  3 May 2026 22:17:03 +0200
Message-ID: <20260503201703.108231-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260503201703.108231-1-pbonzini@redhat.com>
References: <20260503201703.108231-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/lapic.c   | 16 ++++++++--------
 arch/x86/kvm/vmx/vmx.c | 40 ++++++++++++++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 5ee14d6bc288..4078e624ca66 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -667,14 +667,14 @@ bool __kvm_apic_update_irr(unsigned long *pir, void *regs, int *max_irr)
 	u32 *__pir = (void *)pir_vals;
 	u32 i, vec;
 	u32 irr_val, prev_irr_val;
-	int max_updated_irr;
+	int max_new_irr;
 
 	if (!pi_harvest_pir(pir, pir_vals)) {
 		*max_irr = apic_find_highest_vector(regs + APIC_IRR);
 		return false;
 	}
 
-	max_updated_irr = -1;
+	max_new_irr = -1;
 	*max_irr = -1;
 
 	for (i = vec = 0; i <= 7; i++, vec += 32) {
@@ -690,25 +690,25 @@ bool __kvm_apic_update_irr(unsigned long *pir, void *regs, int *max_irr)
 				 !try_cmpxchg(p_irr, &prev_irr_val, irr_val));
 
 			if (prev_irr_val != irr_val)
-				max_updated_irr = __fls(irr_val ^ prev_irr_val) + vec;
+				max_new_irr = __fls(irr_val ^ prev_irr_val) + vec;
 		}
 		if (irr_val)
 			*max_irr = __fls(irr_val) + vec;
 	}
 
-	return ((max_updated_irr != -1) &&
-		(max_updated_irr == *max_irr));
+	return max_new_irr != -1 && max_new_irr == *max_irr;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_apic_update_irr);
 
 bool kvm_apic_update_irr(struct kvm_vcpu *vcpu, unsigned long *pir, int *max_irr)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
-	bool irr_updated = __kvm_apic_update_irr(pir, apic->regs, max_irr);
+	bool max_irr_is_from_pir;
 
-	if (unlikely(!apic->apicv_active && irr_updated))
+	max_irr_is_from_pir = __kvm_apic_update_irr(pir, apic->regs, max_irr);
+	if (unlikely(!apic->apicv_active && max_irr_is_from_pir))
 		apic->irr_pending = true;
-	return irr_updated;
+	return max_irr_is_from_pir;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_apic_update_irr);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a29896a9ef14..4e1aadd89c63 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7029,8 +7029,8 @@ static void vmx_set_rvi(int vector)
 int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vt *vt = to_vt(vcpu);
+	bool max_irr_is_from_pir;
 	int max_irr;
-	bool got_posted_interrupt;
 
 	if (KVM_BUG_ON(!enable_apicv, vcpu->kvm))
 		return -EIO;
@@ -7042,17 +7042,22 @@ int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
 		 * But on x86 this is just a compiler barrier anyway.
 		 */
 		smp_mb__after_atomic();
-		got_posted_interrupt =
-			kvm_apic_update_irr(vcpu, vt->pi_desc.pir, &max_irr);
+		max_irr_is_from_pir = kvm_apic_update_irr(vcpu, vt->pi_desc.pir,
+							  &max_irr);
 	} else {
 		max_irr = kvm_lapic_find_highest_irr(vcpu);
-		got_posted_interrupt = false;
+		max_irr_is_from_pir = false;
 	}
 
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
 
 	return max_irr;
-- 
2.54.0

