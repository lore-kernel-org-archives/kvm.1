Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676124D8DB0
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526068; cv=none; b=me0+OgpOeR2MzNd9iq2opMhj7lVpCGcjVcNHTCOKxzkR/B3uLFLMJg1zBhya6gzI/tHcJnvNwiB63tuyUeaHegKq8FlV9vd2l30dhauMNJqUGDxU0UogNDLdWTgNSAA1/b+k7MsWh92htyBimoD2LJuIiTEytANp5u1TmeqQwA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526068; c=relaxed/simple;
	bh=bYjWQS9V5yKNsX/qamnnBTvmDwesC5dEoAweBDT6DRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e9TgM/G/S3pqej3CypisQTkvc1r6P03i8JbQtgFzXXUHRRhkK7CZoQ5IEtrNdCbZAXwbAuWAtb55axwY5cmUb3mcOFKkRPeXFGK442SC//qlfMTJOZ76KKpZfK0j33Dbjepci/mRBTilPOppO4XhZsEVuidK6Bo46XSTiEJQtkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WwJgKtJh; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WwJgKtJh"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c272e532so636855ad.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 15:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780526062; x=1781130862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=lvvRiUJMqyN5FyY9xvvNaMRd83EfYY0souJYEsNdbNo=;
        b=WwJgKtJhQF0DV4SkG74nuI28GM2GfrzDFYY0PMWDUT3XZ9fFkgWrOZDrF0tVFLTNj1
         26zvjzubG96TihhtsowmkqgOa66RKnoxzDfXFM358XRCLlxGjIatNQfghF6liGLJ5L05
         yVJTKfSwE7GjRHOWOdRvrJ/y7rYeBTknOnYlSj4eN7+pbHqnvoMmAutq7KzRR+6MyXVp
         0lMU1GCWjjwq28/dJo0FaIMbEImofbjqwh3CyBf2pkDw/PL2G4qO+V3nD0VzT3HzzlEx
         MMTKefBhTiezwzUGvBKYcz0f/9M0hJlriwuNJ4Q6//2uPZaQDN7pHC2PuFiMJTQdsBgq
         tCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780526062; x=1781130862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lvvRiUJMqyN5FyY9xvvNaMRd83EfYY0souJYEsNdbNo=;
        b=PdNTwOtsEYR6hIJB24AGFml1PX0UD0PmdHGvUo7+wfV0vOKFwpY5Pg+WGWH0U0ZhHK
         6kyWflXgWQR9gfQ22fyvJMRwTL8eVibKL9ZIp1EEaDyzTJXi+phZB1PNuKmFVaRp2THt
         v72hrpX768wVoUUuZPoXnz/+hfsX9jjOgwD/y46ScvczDoS5Exng7oNfGt0cUF1PQD0w
         5VBfqoDJaZKY6+r0JL0amgRsgf6ScaEG6klXHOyGZCdawAasQJiaof0K1Oym2o9GV7+4
         2zudRCGHuiKNgGN8CVxRkLDfV0YktNlvuBpZ/c1lYUZy4TcV5cDgeC/kPXGj6raIp/Rj
         HUSQ==
X-Gm-Message-State: AOJu0YylqbPHMX5YJODL4cfgfVape85JtNbwHrrL9EF0YdriwDLxU2V0
	bJF4k3rYmbgaA40+YwpZ4j5gxrlI/oUzp0wYZAFrm8gVxNFPRaIkAgl4thiJAraQ1SDTvXZVIQP
	AqKd6Rw==
X-Received: from plbkt11.prod.google.com ([2002:a17:903:88b:b0:2bf:27ab:9cf4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37cf:b0:2c1:ef9:4516
 with SMTP id d9443c01a7336-2c1641b0f33mr56917885ad.35.1780526061843; Wed, 03
 Jun 2026 15:34:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  3 Jun 2026 15:34:17 -0700
In-Reply-To: <20260603223418.1720035-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603223418.1720035-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260603223418.1720035-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: nVMX: Move vTPR vs. TPR Threshold consistency check
 into "normal" checks
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Move the off-by-default consistency check for vmcs12.tpr_threshold vs.
the virtual APIC vTPR into the "normal" controls checks, as waiting until
KVM has loaded some amount of state is unnecessary and actively dangerous.
Specifically, failure to unwind vmcs01.GUEST_CR3 to KVM's value when EPT
is disabled results in KVM running L1 with an L1-controlled CR3, not with
KVM's CR3!

Alternatively, KVM could simply reset the MMU to force a reload of
vmcs01.GUEST_CR3, but the _only_ reason the check was shoved into a "late"
flow was to wait until the vmcs12 pages were retrieved.  Rather than build
up more crusty code, simply access vTPR using a regular guest memory access
(performance isn't a concern).  To circumvent the restrictions that led to
KVM deferring nested_get_vmcs12_pages(), (a) use a VM-scoped API to read
guest memory so that it always hits non-SMM memslots (for RSM), and (b)
skip the check (since its off-by-default anyways) when the vCPU doesn't
want to run, i.e. when userspace is restoring/stuffing state.

Fixes: 1100e4910ad2 ("KVM: nVMX: Add an off-by-default module param to WARN on missed consistency checks")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 65 +++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b2c851cc7d5c..039e234e7d2b 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -582,6 +582,8 @@ static int nested_vmx_check_msr_bitmap_controls(struct kvm_vcpu *vcpu,
 static int nested_vmx_check_tpr_shadow_controls(struct kvm_vcpu *vcpu,
 						struct vmcs12 *vmcs12)
 {
+	u32 vtpr;
+
 	if (!nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW))
 		return 0;
 
@@ -591,6 +593,32 @@ static int nested_vmx_check_tpr_shadow_controls(struct kvm_vcpu *vcpu,
 	if (CC(!nested_cpu_has_vid(vmcs12) && vmcs12->tpr_threshold >> 4))
 		return -EINVAL;
 
+	/*
+	 * Do the illegal vTPR vs. TPR Threshold consistency check if and only
+	 * if KVM is configured to WARN on missed consistency checks, otherwise
+	 * it's a waste of time.  KVM needs to rely on hardware to fully detect
+	 * an illegal combination due to the vTPR being writable by L1 at all
+	 * times (it's an in-memory value, not a VMCS field).  I.e. even if the
+	 * check passes now, it might fail at the actual VM-Enter.
+	 *
+	 * Keying off the module param also allows treating an invalid vAPIC
+	 * page as a consistency check failure without increasing the risk of
+	 * breaking a "real" VM.
+	 *
+	 * Note!  Deliberately use the VM-scoped API when reading guest memory,
+	 * to ensure the read doesn't hit SMRAM when restoring L2 state on RSM,
+	 * and only perform the check when in KVM_RUN, to avoid a false failure
+	 * if userspace hasn't yet configured memslots during state restore.
+	 */
+	if (warn_on_missed_cc && vcpu->wants_to_run &&
+	    nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW) &&
+	    !nested_cpu_has_vid(vmcs12) &&
+	    !nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES) &&
+	    (CC(kvm_read_guest(vcpu->kvm, vmcs12->virtual_apic_page_addr + APIC_TASKPRI,
+			       &vtpr, sizeof(vtpr))) ||
+	     CC((vmcs12->tpr_threshold & GENMASK(3, 0)) > ((vtpr >> 4) & GENMASK(3, 0)))))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -3115,38 +3143,6 @@ static int nested_vmx_check_controls(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-static int nested_vmx_check_controls_late(struct kvm_vcpu *vcpu,
-					  struct vmcs12 *vmcs12)
-{
-	void *vapic = to_vmx(vcpu)->nested.virtual_apic_map.hva;
-	u32 vtpr = vapic ? (*(u32 *)(vapic + APIC_TASKPRI)) >> 4 : 0;
-
-	/*
-	 * Don't bother with the consistency checks if KVM isn't configured to
-	 * WARN on missed consistency checks, as KVM needs to rely on hardware
-	 * to fully detect an illegal vTPR vs. TRP Threshold combination due to
-	 * the vTPR being writable by L1 at all times (it's an in-memory value,
-	 * not a VMCS field).  I.e. even if the check passes now, it might fail
-	 * at the actual VM-Enter.
-	 *
-	 * Keying off the module param also allows treating an invalid vAPIC
-	 * mapping as a consistency check failure without increasing the risk
-	 * of breaking a "real" VM.
-	 */
-	if (!warn_on_missed_cc)
-		return 0;
-
-	if ((exec_controls_get(to_vmx(vcpu)) & CPU_BASED_TPR_SHADOW) &&
-	    nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW) &&
-	    !nested_cpu_has_vid(vmcs12) &&
-	    !nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES) &&
-	    (CC(!vapic) ||
-	     CC((vmcs12->tpr_threshold & GENMASK(3, 0)) > (vtpr & GENMASK(3, 0)))))
-		return -EINVAL;
-
-	return 0;
-}
-
 static int nested_vmx_check_address_space_size(struct kvm_vcpu *vcpu,
 				       struct vmcs12 *vmcs12)
 {
@@ -3696,11 +3692,6 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 			return NVMX_VMENTRY_KVM_INTERNAL_ERROR;
 		}
 
-		if (nested_vmx_check_controls_late(vcpu, vmcs12)) {
-			vmx_switch_vmcs(vcpu, &vmx->vmcs01);
-			return NVMX_VMENTRY_VMFAIL;
-		}
-
 		if (nested_vmx_check_guest_state(vcpu, vmcs12,
 						 &entry_failure_code)) {
 			exit_reason.basic = EXIT_REASON_INVALID_STATE;
-- 
2.54.0.1032.g2f8565e1d1-goog

