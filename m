Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFE337F8C6
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447750; cv=none; b=eM3xdgortGkhbF3Bta1ERqhCcbgqNiFSESxd+BskMW7FA+mXV+FAN6ktHIDeRrTGBzmF5zrXLcxlFhuRsVgzraUbRqQSYFyjEndfqs/WSMw/DEFk+PKFv1Z2qVAnudBZ9GonYhX244tgXjqsGALU3lGlC2z9rbnrrCRLno5UXiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447750; c=relaxed/simple;
	bh=mEOF1Totkw3nyVlBqQbjli7dq2wTuq57zgztCWlTKJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twSMzUMJ5iTd8+YKm39lGbKzcQ7bixzC+X3b8N/N9lD1s2XMKihEi5bROtHiL7uMZjQ/aSUkh5uMC7nL0UUT3BJLn0/lI7MjpFLNB/7hUxqLnrmKu6AwuRRkB1N7ZhqdkYucm61dOCNWYF9xXQIAurv/Qopzha5izAHk/lC2uts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdwNZxhv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdwNZxhv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777447749; x=1808983749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mEOF1Totkw3nyVlBqQbjli7dq2wTuq57zgztCWlTKJQ=;
  b=HdwNZxhvCuZLC9TNfmn+dHFlpR8wfMef5KiUWxVpK4kTt49d4brlgs48
   3UXPXQHUMfCkL/1b5sAh9EZ+gDteDXdfHWoCD+BN430iIL3RkgXa3/zi9
   NLyqgkIlX0/sfe0tEzp7f4/GyGeJ6qEm81Azhew7Guxp6woHrSJ1Ar8q8
   OtSu1Qi4Pq+y3+H+/BHtzf1tPa5gZYAGoJjWGbYWpttzzfbUJZ+FUb5iu
   hHLQczoZLTgK4hAEOWgNRKMb/OCTK4fZmGBXB/O4+McRXdKIo50YvnYJy
   3Gah7AyWXRs8b+qvcjbvHAOQ4ZWY7lg+xLJZ/TH3pRVw1LdcJWhXm2kCV
   Q==;
X-CSE-ConnectionGUID: 0jwIFTXGTYKNwYshD185/A==
X-CSE-MsgGUID: kZKnEMJDSYO/hMQmExBVBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78385804"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="78385804"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 00:29:09 -0700
X-CSE-ConnectionGUID: gtUbeuVLR2abwR81VXYQcA==
X-CSE-MsgGUID: cWHTlHfOSOGV7UEUkpy85g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="272324278"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 00:29:08 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Chenyi Qiang <chenyi.qiang@intel.com>,
	Jim Mattson <jmattson@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Gao Chao <chao.gao@intel.com>
Subject: [PATCH v2 2/2] KVM: x86: Fix misleading variable names and add more comments for PIR=>IRR flow
Date: Wed, 29 Apr 2026 15:28:08 +0800
Message-ID: <20260429072851.3004430-3-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260429072851.3004430-1-chenyi.qiang@intel.com>
References: <20260429072851.3004430-1-chenyi.qiang@intel.com>
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
---
 arch/x86/kvm/lapic.c   | 16 ++++++++--------
 arch/x86/kvm/vmx/vmx.c | 40 ++++++++++++++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index e9f1e5451160..3c9512d1d79a 100644
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
+	return (max_new_irr != -1) && (max_new_irr == *max_irr);
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
index 8b24e682535b..297bb6c3ecc2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7138,8 +7138,8 @@ static void vmx_set_rvi(int vector)
 int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vt *vt = to_vt(vcpu);
+	bool max_irr_is_from_pir;
 	int max_irr;
-	bool got_posted_interrupt;
 
 	if (KVM_BUG_ON(!enable_apicv, vcpu->kvm))
 		return -EIO;
@@ -7151,17 +7151,22 @@ int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
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
+	 * was already pending in the IRR, as RVI isn't updated in lockstep with
+	 * the IRR (unlike apic->irr_pending).
+	 *
+	 * For the cases where Virtual Interrupt Delivery can't be used:
 	 *
 	 * 1) If L2 is running and the vCPU has a new pending interrupt.  If L1
 	 * wants to exit on interrupts, KVM_REQ_EVENT is needed to synthesize a
@@ -7172,10 +7177,29 @@ int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
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
2.43.5

