Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB738D3EC
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276209; cv=none; b=GK96BJwe7gVQ4QUn6aca8LKcUSoTrdMznKqoXfY6Qf2V3SDax873HIkQeu5g0uFlPeYgIQiRSK4uOJjokhG0hxL8E9ixr5WI+0TuKapkKtrLxUy/yLbwPJrz6x91QmJmIFolOhQLCmSzHbaXLgPxET9D5iPHg+qS6OuFS8DMqsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276209; c=relaxed/simple;
	bh=CQSyiNELmAVcZguOJ8qIvBKrS4HH0Ac9n24t8OvPMAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=let+yXBdKl9diwej2L623FZRFu5x9dsZ78QRvxqD+j+KfVGtB6subYL60+ACLtaGvuQ1ivA3SXXufiLt4hFqafjGxNOrLRRyRVHK50bqWuYWyaht8at5ud9mQ9y8c68MQbYVplbOrhYh398zL1ERWR/dsOsX+viR1s/NllpwV4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OIJcActQ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OIJcActQ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-842b0dd8107so723080b3a.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781276208; x=1781881008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZOA2+nwmZjebLKHieU1zn7O6IsAiY1j0sKPEnGk7Rw=;
        b=OIJcActQEoJQGlGV16rPEZT1Hq405RzQwuRSEEo//m/hYcF955dOr668JtVt8X3+Ua
         hu6QhI/wFima5UFBKoPrISoSj9SCgvJD2E8jPUGxA4wgGqgMtDq4Pv08NE6sa0CC4fuR
         Jo0VLoDn/ZuF+Ow9Ux2gCkjPvHe9KyF9M5W6FA4RDp2rb1yGEfs2WpdolnM31Ua5gNaQ
         NralYVI5iUCUvNqzain8Oc80EfCU/VTHztka+UsmEw5viFFR4juIZdD7JKhKjf/Y91pB
         7aivjoP2x8v0Z0P5zhS1vlKLONh7PXxbE1ca3nd8zEFjytQTz5J7z7Ei18mGObOczoF+
         6bpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781276208; x=1781881008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZOA2+nwmZjebLKHieU1zn7O6IsAiY1j0sKPEnGk7Rw=;
        b=oyoNvQviFiu82niDpQ8idFybmvUdYvjasB94jNxFAXkvzKhi06jEm7/asiIIotU2Pf
         0pB0DESQ2/Q6oxsyHl8pCozpHkhNsin5aNMCDh7VMsg0SFZGRIEtGpgF23PwGu95H9O9
         ERDRQ6gzH2QvLIOvV2OAmCII7+pIaFfp1WHq2Qhfibdx+TYRQ/JmFlEnipgi9oVScXIb
         ylgoAnnlQLn5ktcOuE7dilX7+hZ3wNJCUvCKaIn2rPibA6g/d/L2cs1NBop/7ypm8G6V
         CqUS7MQHEwf72Lyudu7x/A9uSCNLN+9DybRomexg3sAMaZxVoa6x1ZlUojtF0/Xk7Vh6
         q9CQ==
X-Gm-Message-State: AOJu0YyuyryvV6LJSA13YXhuc9JeylvQNoB29nQnmgi5xt/diTXlEsd5
	+nhm8/MaaA5mauLGf6GPoBVcVBgws6BY2KqmL2hWT8WcTxuadq9PDu4NX4nEGF3ysyMXdx6/22u
	40nF0Xg==
X-Received: from pfbho5.prod.google.com ([2002:a05:6a00:8805:b0:842:7548:51e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ad4:b0:834:e882:3280
 with SMTP id d2e1a72fcca58-8434cf449ddmr3496678b3a.31.1781276207353; Fri, 12
 Jun 2026 07:56:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 07:56:41 -0700
In-Reply-To: <20260612145642.452392-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612145642.452392-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612145642.452392-2-seanjc@google.com>
Subject: [PATCH v2 1/2] KVM: nVMX: Move vTPR vs. TPR Threshold consistency
 check into "normal" checks
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

If reading guest memory fails, simply skip the consistency check, as KVM's
de facto ABI is that VMX instruction accesses to non-existent memory get
PCI Bus Error semantics, where reads return 0xFFs.  And if vTPR=0xFF, then
the vTPR is guaranteed to be greater than or equal to TPR_THRESHOLD.

Fixes: 1100e4910ad2 ("KVM: nVMX: Add an off-by-default module param to WARN on missed consistency checks")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 66 +++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b2c851cc7d5c..199b866072c0 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -582,6 +582,9 @@ static int nested_vmx_check_msr_bitmap_controls(struct kvm_vcpu *vcpu,
 static int nested_vmx_check_tpr_shadow_controls(struct kvm_vcpu *vcpu,
 						struct vmcs12 *vmcs12)
 {
+	gpa_t vtpr_gpa = vmcs12->virtual_apic_page_addr + APIC_TASKPRI;
+	u32 vtpr;
+
 	if (!nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW))
 		return 0;
 
@@ -591,6 +594,32 @@ static int nested_vmx_check_tpr_shadow_controls(struct kvm_vcpu *vcpu,
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
+	 * If reading guest memory fails, skip the check as KVM's de facto ABI
+	 * for VMX instruction accesses to non-existent memory is to provide
+	 * PCI Bus Error semantics (reads return 0xFFs), in which case the vTPR
+	 * is guaranteed to greater than or equal to the threshold.
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
+	    !kvm_read_guest(vcpu->kvm, vtpr_gpa, &vtpr, sizeof(vtpr)) &&
+	    CC((vmcs12->tpr_threshold & GENMASK(3, 0)) > ((vtpr >> 4) & GENMASK(3, 0))))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -3115,38 +3144,6 @@ static int nested_vmx_check_controls(struct kvm_vcpu *vcpu,
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
@@ -3696,11 +3693,6 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
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
2.54.0.1136.gdb2ca164c4-goog

