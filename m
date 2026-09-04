Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6336EAAE
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483843; cv=none; b=diW8RTy8c+c8ZB2i9AlsgzgGq++5tILNpmIVr0lrfu10Dy7soaLzEEke0+i6gvhVAQDo/832YlAl7T0u2o3s3QtIRKMmxp545ujsHEEZ/lWJaAPJPn1lkHMLQCbeD6+X8lmo8Q+SmppwSvf9iVxy1L6whOsdAHzMoOOz96UMEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483843; c=relaxed/simple;
	bh=EQ3dbwkw2ZVaT4L6zDjc0l81bhCdrmVdynWqbJE1BzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X6q6ro4ITNjSFlfXiMahU+sBjWVu6Dx1ERu9Wx2X8i2iwLoVVwQcZReXPMXydayjX0fA5VpMDUEdQE2JQX2IK4If+M7pE00P4hqVTn0Dop8ox0SD6Vw/sSiW38W1l+m1PQyvC3eygS02Uw/nuLzN3WGkkzC+rsQZMOsh7p/kSQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jejQv9jg; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jejQv9jg"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccb687f82eso5688065ad.3
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 18:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788483840; x=1789088640; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5Vh90jg/qeVICJkXqkXI15uK7I8LepvFnP71xWR+wIU=;
        b=jejQv9jg8N4Ohtl00tpw1vP/QXZGvzcrp6Z5KOQkLJy2ql6UY5wMHueKJEKX7zRs9o
         jeShEuW3eQZ620eMC5LmxiVCA5rdnpS6073rt1tHI5v0d7rUaDG/8q3pxm4Z+tvSMj0D
         zI5onLwakJ7mJp5kkAW0dQ2DfoTh7t5vRNAU3KcwBqad2DNPeJhmteZHWgeYFNFa7KS3
         +Pfok/KjgxHegEGCFdHIOPQXJm7GyhHmVnVYbwj6l5dKseEvurr9C2FIzoVNBkCmZM8P
         F/y173mhvVHjpE+fdt36b2pp34j3r4oCUQBaZkW80MYKIicwSFkUzsmAHhPDC6JLIzS0
         mlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788483840; x=1789088640;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Vh90jg/qeVICJkXqkXI15uK7I8LepvFnP71xWR+wIU=;
        b=K8iKBgaXlmy5+5cwea62tyEw34w7mrZy/QZeB3NjUuGD4b3BNf8OeQWac5pvVOgWp8
         /404lXkakzUo0ym6jFTQecZfPJ3gyXRgB5Sws7v0AmX8TQIeao3JjwG0xd2tXSogRBuV
         N/96Ecfq2v0mbRt6/fZMuuev+TzoCcOVbWPXfqdQ9Hq7l4De8YtkJkZMwVNpQgtdOTve
         ASHEjgMn87LsQRLWfPJkBC0D/IcVBj5rOVr7hiudQSBUh5IBbxOSSJEvwscsB7rz7Y3T
         Y3ztkm4763atR4tgmmF1mw0KpBgyGaIlFIvuMPE9PCWrxmtgVkPO5ruyz8dD3MI0b83b
         gD0g==
X-Gm-Message-State: AFuF++nY+QP9oIzRVdc1YnKv1b5fqkRFYDbZ7c2quval8MxwsIFUaFwp
	zqsghoLHeeNrOupj99M3F0mhgabBYiEbugXfIfYMuHpAanr71fPmMJNTSkIBSR7Dw/NP5oqCJUR
	p6tpOlQ==
X-Received: from pjbrs11.prod.google.com ([2002:a17:90b:2b8b:b0:381:27d7:fc1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c05:b0:393:288:29e3
 with SMTP id 98e67ed59e1d1-39b26106c44mr3970499a91.10.1788483839974; Thu, 03
 Sep 2026 18:03:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 18:03:49 -0700
In-Reply-To: <20260904010353.3175819-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904010353.3175819-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904010353.3175819-5-seanjc@google.com>
Subject: [PATCH v3 4/8] KVM: VMX: Rename posted interrupt prefixes from "vmx"
 to "vt"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Rename all common posted interrupt APIs that use a "vmx" prefix to instead
use a "vt" prefix to capture that they are used for both VMX and TDX vCPUs.

No functional change intended.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/common.h      |  4 ++--
 arch/x86/kvm/vmx/main.c        |  4 ++--
 arch/x86/kvm/vmx/posted_intr.c | 22 +++++++++++-----------
 arch/x86/kvm/vmx/posted_intr.h |  8 ++++----
 arch/x86/kvm/vmx/tdx.c         |  6 +++---
 arch/x86/kvm/vmx/vmx.c         |  6 +++---
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 4b1d46eafd0f..ff4f6a2b6402 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -170,8 +170,8 @@ static inline void kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu,
  * Post an interrupt to a vCPU's PIR and trigger the vCPU to process the
  * interrupt if necessary.
  */
-static inline void __vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu,
-						  struct pi_desc *pi_desc, int vector)
+static inline void __vt_deliver_posted_interrupt(struct kvm_vcpu *vcpu,
+						 struct pi_desc *pi_desc, int vector)
 {
 	if (pi_test_and_set_pir(vector, pi_desc))
 		return;
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index b1069a8e30a7..8ac6ea58b481 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -1086,8 +1086,8 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 
 	.update_cpu_dirty_logging = vt_op(update_cpu_dirty_logging),
 
-	.pi_update_irte = vmx_pi_update_irte,
-	.pi_start_bypass = vmx_pi_start_bypass,
+	.pi_update_irte = vt_pi_update_irte,
+	.pi_start_bypass = vt_pi_start_bypass,
 
 #ifdef CONFIG_X86_64
 	.set_hv_timer = vt_op(set_hv_timer),
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 24221ba553be..2644add54b76 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -56,7 +56,7 @@ static int pi_try_set_control(struct pi_desc *pi_desc, u64 *pold, u64 new)
 	return 0;
 }
 
-void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
+void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
 	struct vcpu_vt *vt = to_vt(vcpu);
@@ -146,11 +146,11 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 		pi_set_on(pi_desc);
 }
 
-static bool vmx_can_use_vtd_pi(struct kvm *kvm)
+static bool vt_can_use_vtd_pi(struct kvm *kvm)
 {
 	/*
 	 * Note, reading the number of possible bypass IRQs can race with a
-	 * bypass IRQ being attached to the VM.  vmx_pi_start_bypass() ensures
+	 * bypass IRQ being attached to the VM.  vt_pi_start_bypass() ensures
 	 * blockng vCPUs will see an elevated count or get KVM_REQ_UNBLOCK.
 	 */
 	return irqchip_in_kernel(kvm) && kvm_arch_has_irq_bypass() &&
@@ -208,7 +208,7 @@ static void pi_enable_wakeup_handler(struct kvm_vcpu *vcpu)
 		__apic_send_IPI_self(POSTED_INTR_WAKEUP_VECTOR);
 }
 
-static bool vmx_needs_pi_wakeup(struct kvm_vcpu *vcpu)
+static bool vt_needs_pi_wakeup(struct kvm_vcpu *vcpu)
 {
 	/*
 	 * The default posted interrupt vector does nothing when
@@ -219,14 +219,14 @@ static bool vmx_needs_pi_wakeup(struct kvm_vcpu *vcpu)
 	 * back to the pi_wakeup_handler() function.
 	 */
 	return (vmx_can_use_ipiv(vcpu) && !is_td_vcpu(vcpu)) ||
-		vmx_can_use_vtd_pi(vcpu->kvm);
+		vt_can_use_vtd_pi(vcpu->kvm);
 }
 
-void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu)
+void vt_vcpu_pi_put(struct kvm_vcpu *vcpu)
 {
 	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
 
-	if (!vmx_needs_pi_wakeup(vcpu))
+	if (!vt_needs_pi_wakeup(vcpu))
 		return;
 
 	/*
@@ -294,17 +294,17 @@ bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu)
 /*
  * Kick all vCPUs when the first possible bypass IRQ is attached to a VM, as
  * blocking vCPUs may scheduled out without reconfiguring PID.NV to the wakeup
- * vector, i.e. if the bypass IRQ came along after vmx_vcpu_pi_put().
+ * vector, i.e. if the bypass IRQ came along after vt_vcpu_pi_put().
  */
-void vmx_pi_start_bypass(struct kvm *kvm)
+void vt_pi_start_bypass(struct kvm *kvm)
 {
-	if (WARN_ON_ONCE(!vmx_can_use_vtd_pi(kvm)))
+	if (WARN_ON_ONCE(!vt_can_use_vtd_pi(kvm)))
 		return;
 
 	kvm_make_all_cpus_request(kvm, KVM_REQ_UNBLOCK);
 }
 
-int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
+int vt_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		       unsigned int host_irq, uint32_t guest_irq,
 		       struct kvm_vcpu *vcpu, u32 vector)
 {
diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
index a4af39948cf0..c5860ea828ae 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -8,16 +8,16 @@
 
 #include <asm/posted_intr.h>
 
-void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
-void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu);
+void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
+void vt_vcpu_pi_put(struct kvm_vcpu *vcpu);
 void pi_wakeup_handler(void);
 void __init pi_init_cpu(int cpu);
 void pi_apicv_pre_state_restore(struct kvm_vcpu *vcpu);
 bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu);
-int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
+int vt_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		       unsigned int host_irq, uint32_t guest_irq,
 		       struct kvm_vcpu *vcpu, u32 vector);
-void vmx_pi_start_bypass(struct kvm *kvm);
+void vt_pi_start_bypass(struct kvm *kvm);
 
 static inline int pi_find_highest_vector(struct pi_desc *pi_desc)
 {
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 46b0e798f8b9..36578d4c00ff 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -716,7 +716,7 @@ void tdx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 
-	vmx_vcpu_pi_load(vcpu, cpu);
+	vt_vcpu_pi_load(vcpu, cpu);
 	if (vcpu->cpu == cpu || !is_hkid_assigned(to_kvm_tdx(vcpu->kvm)))
 		return;
 
@@ -826,7 +826,7 @@ static void tdx_prepare_switch_to_host(struct kvm_vcpu *vcpu)
 
 void tdx_vcpu_put(struct kvm_vcpu *vcpu)
 {
-	vmx_vcpu_pi_put(vcpu);
+	vt_vcpu_pi_put(vcpu);
 	tdx_prepare_switch_to_host(vcpu);
 }
 
@@ -1895,7 +1895,7 @@ void tdx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 
 	/* TDX supports only posted interrupt.  No lapic emulation. */
-	__vmx_deliver_posted_interrupt(vcpu, &tdx->vt.pi_desc, vector);
+	__vt_deliver_posted_interrupt(vcpu, &tdx->vt.pi_desc, vector);
 
 	trace_kvm_apicv_accept_irq(vcpu->vcpu_id, delivery_mode, trig_mode, vector);
 }
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a06dd2d77f10..506be74e3e0f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1577,12 +1577,12 @@ void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	vmx_vcpu_load_vmcs(vcpu, cpu);
 
-	vmx_vcpu_pi_load(vcpu, cpu);
+	vt_vcpu_pi_load(vcpu, cpu);
 }
 
 void vmx_vcpu_put(struct kvm_vcpu *vcpu)
 {
-	vmx_vcpu_pi_put(vcpu);
+	vt_vcpu_pi_put(vcpu);
 
 	vmx_prepare_switch_to_host(to_vmx(vcpu));
 }
@@ -4424,7 +4424,7 @@ static int vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
 	if (!vcpu->arch.apic->apicv_active)
 		return -1;
 
-	__vmx_deliver_posted_interrupt(vcpu, &vt->pi_desc, vector);
+	__vt_deliver_posted_interrupt(vcpu, &vt->pi_desc, vector);
 	return 0;
 }
 
-- 
2.55.0.979.g7e5102b832-goog

