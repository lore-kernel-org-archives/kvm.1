Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A0D48C3E4
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723898; cv=none; b=Oe4ROindgWsUjqXZ9QmcZeat4GWOljaURKdfaChnHJqTfKm25ZAee+ro066Gk8ROWhnjHcATAs+4bGp77Ny/Nt49UJ4qcVmj4FUoC/aj6oVLoWWlu0jfhCXYwKoiQ3xHjUtCwMTthhCorO9MRKLe1sYCkGiDMldtwqWwGJuyxYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723898; c=relaxed/simple;
	bh=Sgd9XnUUTm8lQMTzKPLc9R4iKeBuq0hzQamu72aWQkw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tDnhBJRPdKIRnq3McWduEMcn4sEzin+cQAyyA7RVxHWtMeElOdOZFjiD/Si9WrxPDUMze/UkFSjzityIBcliA7G4FLlN7A1dhfxMv9bBHsGWvrsMBgQnbpfpUKy0KLfFdn/9mJavSuAPyBJJsZOXLuwkKAxyK4FU9lhgxHxWfWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dmv3CZDx; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dmv3CZDx"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84c4cd31b51so2438282b3a.0
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 09:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786723893; x=1787328693; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1X+CoeJub4jvKxL0wB0sEMpRW5OuyV9yrXjVoPm820Q=;
        b=Dmv3CZDxb1iNFYf9MUT8YXRtomU2Xn1c5oA/cNbS9tXucfQ7i5JttHr3rGzPlhHjGy
         XVIjfBdH7450XuA776C3lkdBfrlex+kNXDqRq8RCmoDQQ7DmAm1p+9VN0/AspWQugjEm
         iS1TAn0+ClluysXLF+Hy+VxQOqNOftezyVeGy8M05PjoHDr1Ia3KmkupYjoTo4aLnqAB
         vcmc1gqiLxgI6xCMDdnG3TQrqpHqJGJn+EahebkjzA85C3EedsYiX1rAReioBl0SiOTz
         MG8z91nzkL9Vvn0WoInga/crfJY8kNZllm1w8F1Q0eouggDcZ7o7RgchyZJs0oGfUH/O
         xPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786723893; x=1787328693;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1X+CoeJub4jvKxL0wB0sEMpRW5OuyV9yrXjVoPm820Q=;
        b=ipW7ui/NqDPpkA8VFB2gWlQVBidcyxhI56ZrGE24HxsSYZp9KvmHUX2P9GMoOk9Jrp
         Nte2o+olUFhu+o3mOzHh9dCT6dGsOz1pXGa37GO/fAMz8eIpjKSgIJLlTuEUcnAlJj7o
         djJaevVF41Rwwm8IWOwdjcZ5hmJeDwsijnPY1ibIqej1RfHKP9to70karPHMOtNpXBAu
         toXsC6ru0oZDes44N4zfcACDHJc4+tmW5N7hXfZ3c9TGFzNKpKeg+fK88UDkPit9L8hd
         I6s1kn4jmPhQCTyBjElCjVTF/+hJd8yCqbsO1q670fxfLyn2vdhgC43KxJeGd4EEtTeE
         LIaA==
X-Forwarded-Encrypted: i=1; AHgh+RpT9x8rLwrgmwG6i6+pB+A/nwKF6nfVu5IctdkbJuovpO8HY5OcYpcewR8GqGlj9IWyhkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJTUJkgMLUQCJFYHMyMXSGrbHhzHrMQY3wvgqzbOV+l1wSYXq2
	OUjbTljC4Jg6Fo8doF5I5XLaiu/S1rTWkW+q+Gzvdzq8ddH7xXFiSoSBY5eRDBCxp3hMHwgwd28
	pm1mU4g==
X-Received: from pfaw13.prod.google.com ([2002:a05:6a00:ab8d:b0:84a:1163:2ad0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9f86:b0:3cc:35e1:8dd9
 with SMTP id adf61e73a8af0-3cc708b4270mr6825648637.17.1786723892552; Fri, 14
 Aug 2026 09:11:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Aug 2026 09:11:27 -0700
In-Reply-To: <20260814161129.2177118-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814161129.2177118-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814161129.2177118-2-seanjc@google.com>
Subject: [PATCH 1/3] KVM: VMX: Move the shared "IRQs off" exit handler(s) to
 common code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move vmx_handle_exit_irqoff() and its helpers to common.h / main.c to
capture that it's a common handler and to allow guarding against incorrectly
using to_vmx(), and to allow for

Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Kai Huang <kai.huang@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/common.h  |  6 ++++
 arch/x86/kvm/vmx/main.c    | 69 +++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c     | 74 --------------------------------------
 arch/x86/kvm/vmx/x86_ops.h |  1 -
 4 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 08005676702c..88f637c81353 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -74,6 +74,12 @@ static __always_inline bool is_td_vcpu(struct kvm_vcpu *vcpu) { return false; }
 
 #endif
 
+static inline bool is_xfd_nm_fault(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.guest_fpu.fpstate->xfd &&
+	       !kvm_is_cr0_bit_set(vcpu, X86_CR0_TS);
+}
+
 static inline bool vt_is_tdx_private_gpa(struct kvm *kvm, gpa_t gpa)
 {
 	/* For TDX the direct mask is the shared mask. */
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 0ff3230fd95e..aa5b44bb212b 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/entry-common.h>
 #include <linux/moduleparam.h>
 
 #include "x86_ops.h"
@@ -876,6 +877,74 @@ static int vt_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn,
 #define vt_op_tdx_only(name) NULL
 #endif /* CONFIG_KVM_INTEL_TDX */
 
+static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Save xfd_err to guest_fpu before interrupt is enabled, so the
+	 * MSR value is not clobbered by the host activity before the guest
+	 * has chance to consume it.
+	 *
+	 * Update the guest's XFD_ERR if and only if XFD is enabled, as the #NM
+	 * interception may have been caused by L1 interception.  Per the SDM,
+	 * XFD_ERR is not modified for non-XFD #NM, i.e. if CR0.TS=1.
+	 *
+	 * Note, XFD_ERR is updated _before_ the #NM interception check, i.e.
+	 * unlike CR2 and DR6, the value is not a payload that is attached to
+	 * the #NM exception.
+	 */
+	if (is_xfd_nm_fault(vcpu))
+		rdmsrq(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
+}
+
+static void handle_exception_irqoff(struct kvm_vcpu *vcpu, u32 intr_info)
+{
+	/* if exit due to PF check for async PF */
+	if (is_page_fault(intr_info))
+		vcpu->arch.apf.host_apf_flags = kvm_read_and_reset_apf_flags();
+	/* if exit due to NM, handle before interrupts are enabled */
+	else if (is_nm_fault(intr_info))
+		handle_nm_fault_irqoff(vcpu);
+	/* Handle machine checks before interrupts are enabled */
+	else if (is_machine_check(intr_info))
+		kvm_machine_check();
+}
+
+static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu,
+					     u32 intr_info)
+{
+	unsigned int vector = intr_info & INTR_INFO_VECTOR_MASK;
+
+	if (KVM_BUG(!is_external_intr(intr_info), vcpu->kvm,
+	    "unexpected VM-Exit interrupt info: 0x%x", intr_info))
+		return;
+
+	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
+	x86_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
+	kvm_after_interrupt(vcpu);
+
+	vcpu->arch.at_instruction_boundary = true;
+}
+
+static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)
+{
+	if (to_vt(vcpu)->emulation_required)
+		return;
+
+	switch (vmx_get_exit_reason(vcpu).basic) {
+	case EXIT_REASON_EXTERNAL_INTERRUPT:
+		handle_external_interrupt_irqoff(vcpu, vmx_get_intr_info(vcpu));
+		break;
+	case EXIT_REASON_EXCEPTION_NMI:
+		handle_exception_irqoff(vcpu, vmx_get_intr_info(vcpu));
+		break;
+	case EXIT_REASON_MCE_DURING_VMENTRY:
+		kvm_machine_check();
+		break;
+	default:
+		break;
+	}
+}
+
 #define VMX_REQUIRED_APICV_INHIBITS				\
 	(BIT(APICV_INHIBIT_REASON_DISABLED) |			\
 	 BIT(APICV_INHIBIT_REASON_ABSENT) |			\
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e3bfe6aca1a0..aa0098723976 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5379,12 +5379,6 @@ bool vmx_guest_inject_ac(struct kvm_vcpu *vcpu)
 	       (kvm_get_rflags(vcpu) & X86_EFLAGS_AC);
 }
 
-static bool is_xfd_nm_fault(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.guest_fpu.fpstate->xfd &&
-	       !kvm_is_cr0_bit_set(vcpu, X86_CR0_TS);
-}
-
 static int vmx_handle_page_fault(struct kvm_vcpu *vcpu, u32 error_code)
 {
 	unsigned long cr2 = vmx_get_exit_qual(vcpu);
@@ -7143,74 +7137,6 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 	vmcs_write64(EOI_EXIT_BITMAP3, eoi_exit_bitmap[3]);
 }
 
-static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
-{
-	/*
-	 * Save xfd_err to guest_fpu before interrupt is enabled, so the
-	 * MSR value is not clobbered by the host activity before the guest
-	 * has chance to consume it.
-	 *
-	 * Update the guest's XFD_ERR if and only if XFD is enabled, as the #NM
-	 * interception may have been caused by L1 interception.  Per the SDM,
-	 * XFD_ERR is not modified for non-XFD #NM, i.e. if CR0.TS=1.
-	 *
-	 * Note, XFD_ERR is updated _before_ the #NM interception check, i.e.
-	 * unlike CR2 and DR6, the value is not a payload that is attached to
-	 * the #NM exception.
-	 */
-	if (is_xfd_nm_fault(vcpu))
-		rdmsrq(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
-}
-
-static void handle_exception_irqoff(struct kvm_vcpu *vcpu, u32 intr_info)
-{
-	/* if exit due to PF check for async PF */
-	if (is_page_fault(intr_info))
-		vcpu->arch.apf.host_apf_flags = kvm_read_and_reset_apf_flags();
-	/* if exit due to NM, handle before interrupts are enabled */
-	else if (is_nm_fault(intr_info))
-		handle_nm_fault_irqoff(vcpu);
-	/* Handle machine checks before interrupts are enabled */
-	else if (is_machine_check(intr_info))
-		kvm_machine_check();
-}
-
-static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu,
-					     u32 intr_info)
-{
-	unsigned int vector = intr_info & INTR_INFO_VECTOR_MASK;
-
-	if (KVM_BUG(!is_external_intr(intr_info), vcpu->kvm,
-	    "unexpected VM-Exit interrupt info: 0x%x", intr_info))
-		return;
-
-	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
-	x86_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
-	kvm_after_interrupt(vcpu);
-
-	vcpu->arch.at_instruction_boundary = true;
-}
-
-void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)
-{
-	if (to_vt(vcpu)->emulation_required)
-		return;
-
-	switch (vmx_get_exit_reason(vcpu).basic) {
-	case EXIT_REASON_EXTERNAL_INTERRUPT:
-		handle_external_interrupt_irqoff(vcpu, vmx_get_intr_info(vcpu));
-		break;
-	case EXIT_REASON_EXCEPTION_NMI:
-		handle_exception_irqoff(vcpu, vmx_get_intr_info(vcpu));
-		break;
-	case EXIT_REASON_MCE_DURING_VMENTRY:
-		kvm_machine_check();
-		break;
-	default:
-		break;
-	}
-}
-
 /*
  * The kvm parameter can be NULL (module initialization, or invocation before
  * VM creation). Be sure to check the kvm parameter before using it.
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index cdb38d940cfb..4dcaa36bbd8c 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -27,7 +27,6 @@ void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 void vmx_vcpu_put(struct kvm_vcpu *vcpu);
 int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath);
-void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu);
 int vmx_skip_emulated_instruction(struct kvm_vcpu *vcpu);
 void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu);
 bool vmx_unhandleable_emulation_required(struct kvm_vcpu *vcpu);
-- 
2.55.0.691.gc56d675ccc-goog

