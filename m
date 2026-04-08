Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EAA3D9034
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672555; cv=none; b=siZwOuatHcWNF1BqgAdcOKgV16d+8lO9Y4N31Lgqhxjjs1otnEYAM5VDXwH0Er2/fOgBCBUrAJGGv+VbhSPNX1w2AbzcQI7nGGD+erD6kQgf4xQwIrPZlVI7A2gKtZcJmoknUMo653J3gS5W3xYUtsMeR8RWqXAczQm5IC9JjTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672555; c=relaxed/simple;
	bh=XAXsoS89VcrRSkgM4uTrvlppPDRWHMLFH/06oqTfBF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lncmWlsj8nwc5tEzcixm1wimRTX5T1akGrNx4+Nbujk7c/GqqWKkdHG6znKcavDVbeVWyPw7I+Hah+Xh4XJN0Tv46b6odcDPl5dLPXEA01a/Zak9sJmu3gxzED9BeCrfG1HHZti2AVLOWpJc7jUG1xBVyt9LvIMqLSzKWCOX6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBLaM5Rp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBLaM5Rp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775672552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JsFVBcKynKpBm3OxqTNh9hV/BVX0i5eBbcHwpUj5DE=;
	b=VBLaM5Rp211uzMvKbRALnBywUdwjSMysA3+QgJ12Zbt0gsXUqBhAuHL19nWuXoo6A214CM
	vtS21MdguPf019UApq1BG2NGcyg6f8miBKDED8apjyZUe2RYSQfFa4GexYE5LGXE2zlaRN
	yyi3Fc1UTPfNwF4e+dyCEAbCfX2L1i0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-Nj265khYN8KmPMXXItxuxA-1; Wed,
 08 Apr 2026 14:22:22 -0400
X-MC-Unique: Nj265khYN8KmPMXXItxuxA-1
X-Mimecast-MFC-AGG-ID: Nj265khYN8KmPMXXItxuxA_1775672538
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C3D81956096;
	Wed,  8 Apr 2026 18:22:18 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF0361955F2B;
	Wed,  8 Apr 2026 18:22:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH 4/7] KVM: SVM: adopt the same VMX_RUN_* flags as VMX
Date: Wed,  8 Apr 2026 14:22:10 -0400
Message-ID: <20260408182213.522713-5-pbonzini@redhat.com>
In-Reply-To: <20260408182213.522713-1-pbonzini@redhat.com>
References: <20260408182213.522713-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Rename VMX_RUN_* to KVM_ENTER_* (to not confuse with KVM_RUN_* that
already exists) and replace SVM's spec_ctrl_intercepted with that
same bitmask.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c       | 14 +++++++++-----
 arch/x86/kvm/svm/vmenter.S   | 21 +++++++++++----------
 arch/x86/kvm/vmenter.h       |  9 +++++++++
 arch/x86/kvm/vmx/run_flags.h |  9 ---------
 arch/x86/kvm/vmx/vmenter.S   | 12 ++++++------
 arch/x86/kvm/vmx/vmx.c       | 13 +++++++------
 arch/x86/kvm/vmx/vmx.h       |  3 +--
 7 files changed, 43 insertions(+), 38 deletions(-)
 create mode 100644 arch/x86/kvm/vmenter.h
 delete mode 100644 arch/x86/kvm/vmx/run_flags.h

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e6477affac9a..19808eee43de 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -49,6 +49,7 @@
 
 #include "trace.h"
 
+#include "vmenter.h"
 #include "svm.h"
 #include "svm_ops.h"
 
@@ -4253,7 +4254,7 @@ static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 	return EXIT_FASTPATH_NONE;
 }
 
-static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_intercepted)
+static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, unsigned enter_flags)
 {
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, vcpu->cpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -4275,10 +4276,10 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
 	amd_clear_divider();
 
 	if (sev_es_guest(vcpu->kvm))
-		__svm_sev_es_vcpu_run(svm, spec_ctrl_intercepted,
+		__svm_sev_es_vcpu_run(svm, enter_flags,
 				      sev_es_host_save_area(sd));
 	else
-		__svm_vcpu_run(svm, spec_ctrl_intercepted);
+		__svm_vcpu_run(svm, enter_flags);
 
 	raw_local_irq_disable();
 
@@ -4289,7 +4290,10 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 {
 	bool force_immediate_exit = run_flags & KVM_RUN_FORCE_IMMEDIATE_EXIT;
 	struct vcpu_svm *svm = to_svm(vcpu);
-	bool spec_ctrl_intercepted = msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL);
+	unsigned enter_flags = 0;
+
+	if (msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
+		enter_flags |= KVM_ENTER_SAVE_SPEC_CTRL;
 
 	trace_kvm_entry(vcpu, force_immediate_exit);
 
@@ -4370,7 +4374,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	if (!static_cpu_has(X86_FEATURE_V_SPEC_CTRL))
 		x86_spec_ctrl_set_guest(svm->virt_spec_ctrl);
 
-	svm_vcpu_enter_exit(vcpu, spec_ctrl_intercepted);
+	svm_vcpu_enter_exit(vcpu, enter_flags);
 
 	if (!static_cpu_has(X86_FEATURE_V_SPEC_CTRL))
 		x86_spec_ctrl_restore_host(svm->virt_spec_ctrl);
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index f4ea862652d8..545dc55582bf 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -7,6 +7,7 @@
 #include <asm/kvm_vcpu_regs.h>
 #include <asm/nospec-branch.h>
 #include "kvm-asm-offsets.h"
+#include "vmenter.h"
 
 #define WORD_SIZE (BITS_PER_LONG / 8)
 
@@ -76,7 +77,7 @@
 		"jmp 900f", X86_FEATURE_MSR_SPEC_CTRL, \
 		"", X86_FEATURE_V_SPEC_CTRL
 .endm
-.macro RESTORE_HOST_SPEC_CTRL_BODY guest_spec_ctrl:req, spec_ctrl_intercepted:req, label:req
+.macro RESTORE_HOST_SPEC_CTRL_BODY guest_spec_ctrl:req, enter_flags:req, label:req
 	/* Same for after vmexit.  */
 	mov $MSR_IA32_SPEC_CTRL, %ecx
 
@@ -84,7 +85,7 @@
 	 * Load the value that the guest had written into MSR_IA32_SPEC_CTRL,
 	 * if it was not intercepted during guest execution.
 	 */
-	cmpb $0, \spec_ctrl_intercepted
+	testl $KVM_ENTER_SAVE_SPEC_CTRL, \enter_flags
 	jnz 998f
 	rdmsr
 	movl %eax, \guest_spec_ctrl
@@ -115,8 +116,8 @@
 
 /**
  * __svm_vcpu_run - Run a vCPU via a transition to SVM guest mode
- * @svm:	struct vcpu_svm *
- * @spec_ctrl_intercepted: bool
+ * @svm:	 struct vcpu_svm *
+ * @enter_flags: u32
  */
 SYM_FUNC_START(__svm_vcpu_run)
 	push %_ASM_BP
@@ -274,7 +275,7 @@ SYM_FUNC_START(__svm_vcpu_run)
 	xor %r15d, %r15d
 #endif
 
-	/* "Pop" @spec_ctrl_intercepted.  */
+	/* "Pop" @enter_flags.  */
 	pop %_ASM_BX
 
 	pop %_ASM_BX
@@ -335,8 +336,8 @@ SYM_FUNC_END(__svm_vcpu_run)
 
 /**
  * __svm_sev_es_vcpu_run - Run a SEV-ES vCPU via a transition to SVM guest mode
- * @svm:	struct vcpu_svm *
- * @spec_ctrl_intercepted: bool
+ * @svm:	 struct vcpu_svm *
+ * @enter_flags: u32
  */
 SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	FRAME_BEGIN
@@ -355,7 +356,7 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 
 	/*
 	 * Save volatile registers that hold arguments that are needed after
-	 * #VMEXIT (RDI=@svm and RSI=@spec_ctrl_intercepted).
+	 * #VMEXIT (RDI=@svm and RSI=@enter_flags).
 	 */
 	mov %rdi, SEV_ES_RDI (%rdx)
 	mov %rsi, SEV_ES_RSI (%rdx)
@@ -377,7 +378,7 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	/* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET! */
 	FILL_RETURN_BUFFER %rax, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_VMEXIT
 
-	/* Clobbers RAX, RCX, RDX, consumes RDI (@svm) and RSI (@spec_ctrl_intercepted). */
+	/* Clobbers RAX, RCX, RDX, consumes RDI (@svm) and RSI (@enter_flags). */
 	RESTORE_HOST_SPEC_CTRL
 901:
 
@@ -397,7 +398,7 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	RESTORE_GUEST_SPEC_CTRL_BODY SVM_spec_ctrl(%_ASM_DI), 801b
 	jmp 801b
 900:
-	RESTORE_HOST_SPEC_CTRL_BODY SVM_spec_ctrl(%_ASM_DI), %sil, 901b
+	RESTORE_HOST_SPEC_CTRL_BODY SVM_spec_ctrl(%_ASM_DI), %esi, 901b
 	jmp 901b
 
 3:	cmpb $0, kvm_rebooting(%rip)
diff --git a/arch/x86/kvm/vmenter.h b/arch/x86/kvm/vmenter.h
new file mode 100644
index 000000000000..29cdae650069
--- /dev/null
+++ b/arch/x86/kvm/vmenter.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __KVM_X86_VMENTER_H
+#define __KVM_X86_VMENTER_H
+
+#define KVM_ENTER_VMRESUME			BIT(0)
+#define KVM_ENTER_SAVE_SPEC_CTRL		BIT(1)
+#define KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO	BIT(2)
+
+#endif /* __KVM_X86_VMENTER_H */
diff --git a/arch/x86/kvm/vmx/run_flags.h b/arch/x86/kvm/vmx/run_flags.h
deleted file mode 100644
index 6a87a12135fb..000000000000
--- a/arch/x86/kvm/vmx/run_flags.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __KVM_X86_VMX_RUN_FLAGS_H
-#define __KVM_X86_VMX_RUN_FLAGS_H
-
-#define VMX_RUN_VMRESUME			BIT(0)
-#define VMX_RUN_SAVE_SPEC_CTRL			BIT(1)
-#define VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO	BIT(2)
-
-#endif /* __KVM_X86_VMX_RUN_FLAGS_H */
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index babafd7dfa5b..bed5a753166b 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -7,7 +7,7 @@
 #include <asm/percpu.h>
 #include <asm/segment.h>
 #include "kvm-asm-offsets.h"
-#include "run_flags.h"
+#include "vmenter.h"
 
 #define WORD_SIZE (BITS_PER_LONG / 8)
 
@@ -68,9 +68,9 @@
 /**
  * __vmx_vcpu_run - Run a vCPU via a transition to VMX guest mode
  * @vmx:	struct vcpu_vmx *
- * @flags:	VMX_RUN_VMRESUME:	use VMRESUME instead of VMLAUNCH
- *		VMX_RUN_SAVE_SPEC_CTRL: save guest SPEC_CTRL into vmx->spec_ctrl
- *		VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO: vCPU can access host MMIO
+ * @flags:	KVM_ENTER_RUN_VMRESUME:	use VMRESUME instead of VMLAUNCH
+ *		KVM_ENTER_RUN_SAVE_SPEC_CTRL: save guest SPEC_CTRL into vmx->spec_ctrl
+ *		KVM_ENTER_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO: vCPU can access host MMIO
  *
  * Returns:
  *	0 on VM-Exit, 1 on VM-Fail
@@ -164,7 +164,7 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	 * do VERW.  Else, do nothing (no mitigations needed/enabled).
 	 */
 	ALTERNATIVE_2 "",									  \
-		      __stringify(testl $VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO, (%_ASM_SP);	  \
+		      __stringify(testl $KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO, (%_ASM_SP);	  \
 				  jz .Lskip_mmio_verw;						  \
 				  VERW;								  \
 				  .Lskip_mmio_verw:),					  	  \
@@ -172,7 +172,7 @@ SYM_FUNC_START(__vmx_vcpu_run)
 		      __stringify(VERW), X86_FEATURE_CLEAR_CPU_BUF_VM
 
 	/* Check @flags to see if VMLAUNCH or VMRESUME is needed. */
-	testl $VMX_RUN_VMRESUME, (%_ASM_SP)
+	testl $KVM_ENTER_VMRESUME, (%_ASM_SP)
 	jz .Lvmlaunch
 
 	/*
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 054542ff0d02..ef0de3cc0bc2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -72,6 +72,7 @@
 #include "x86_ops.h"
 #include "smm.h"
 #include "vmx_onhyperv.h"
+#include "vmenter.h"
 #include "posted_intr.h"
 
 #include "mmu/spte.h"
@@ -1000,12 +1001,12 @@ static bool msr_write_intercepted(struct vcpu_vmx *vmx, u32 msr)
 	return vmx_test_msr_bitmap_write(vmx->loaded_vmcs->msr_bitmap, msr);
 }
 
-unsigned int __vmx_vcpu_run_flags(struct vcpu_vmx *vmx)
+unsigned int __vmx_vcpu_enter_flags(struct vcpu_vmx *vmx)
 {
 	unsigned int flags = 0;
 
 	if (vmx->loaded_vmcs->launched)
-		flags |= VMX_RUN_VMRESUME;
+		flags |= KVM_ENTER_VMRESUME;
 
 	/*
 	 * If writes to the SPEC_CTRL MSR aren't intercepted, the guest is free
@@ -1013,11 +1014,11 @@ unsigned int __vmx_vcpu_run_flags(struct vcpu_vmx *vmx)
 	 * it after vmexit and store it in vmx->spec_ctrl.
 	 */
 	if (!msr_write_intercepted(vmx, MSR_IA32_SPEC_CTRL))
-		flags |= VMX_RUN_SAVE_SPEC_CTRL;
+		flags |= KVM_ENTER_SAVE_SPEC_CTRL;
 
 	if (cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF_VM_MMIO) &&
 	    kvm_vcpu_can_access_host_mmio(&vmx->vcpu))
-		flags |= VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO;
+		flags |= KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO;
 
 	return flags;
 }
@@ -7504,7 +7505,7 @@ void noinstr vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx,
 	if (!cpu_feature_enabled(X86_FEATURE_MSR_SPEC_CTRL))
 		return;
 
-	if (flags & VMX_RUN_SAVE_SPEC_CTRL)
+	if (flags & KVM_ENTER_SAVE_SPEC_CTRL)
 		vmx->spec_ctrl = native_rdmsrq(MSR_IA32_SPEC_CTRL);
 
 	/*
@@ -7695,7 +7696,7 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	kvm_wait_lapic_expire(vcpu);
 
 	/* The actual VMENTER/EXIT is in the .noinstr.text section. */
-	vmx_vcpu_enter_exit(vcpu, __vmx_vcpu_run_flags(vmx));
+	vmx_vcpu_enter_exit(vcpu, __vmx_vcpu_enter_flags(vmx));
 
 	/* All fields are clean at this point */
 	if (kvm_is_using_evmcs()) {
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index f963cb2982c9..9cb5a205f19d 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -15,7 +15,6 @@
 #include "vmcs.h"
 #include "vmx_ops.h"
 #include "../cpuid.h"
-#include "run_flags.h"
 #include "../mmu.h"
 #include "common.h"
 
@@ -372,7 +371,7 @@ struct vmx_uret_msr *vmx_find_uret_msr(struct vcpu_vmx *vmx, u32 msr);
 void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu);
 void vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp);
 void vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx, unsigned int flags);
-unsigned int __vmx_vcpu_run_flags(struct vcpu_vmx *vmx);
+unsigned int __vmx_vcpu_enter_flags(struct vcpu_vmx *vmx);
 bool __vmx_vcpu_run(struct vcpu_vmx *vmx, unsigned int flags);
 void vmx_ept_load_pdptrs(struct kvm_vcpu *vcpu);
 
-- 
2.52.0


