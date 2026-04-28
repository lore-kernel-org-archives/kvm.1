Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E19C3E8C45
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374320; cv=none; b=aR1YJow4LDM1E9nc67ur/yDhyN7bn+EUHqpG1txuedUjRg5QisOiiYRXH1TqWdNcIstNl7mZXrl7xVCsOlipunNZ/W60w2UD/3jyRJmUt8L6gdBWCQ2uRrqDKd0SqiVOQxFLcqP6095HPVYcjGUjNrwVI+sQLHIciwyVOZM+PPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374320; c=relaxed/simple;
	bh=auRBh63JZxS/Md8dCtYnvllxjrwNFKnUaHvxyC+s8jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0ya1M6pJ3yhutqQERkZNHDFXnMnZTX7wHC34xbJYa7TNiacsJbXyEik3Si4IFI1wr9O9h79F6P0ysy/Q22NqEqSWroNAez6eqLMzEUCLe7BcmiJdHxvD75LqmlyOaU40ITtZakxs8xs5uuZBMF/mnwWaoPA7cPezLifDZw1zrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fOXtBNTC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOXtBNTC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgGPSi7arVWiRpDPJ8V+u2Ms4i69wEtWAtSbWjbaVFY=;
	b=fOXtBNTCglqloGTSgM2G888fiA4QPL2bNQS41w1+d77LZX5yHTh0FHMW2V8MWyuZHo/8DK
	UXqQSMmFAt4a3YFDl0cjn5aMPTDKhf0QI43kVrX76nexqvpFZ0jVhbZpOvu26oKi6tfBIl
	jhhRFTtonDBf336N2UgvGItJxMDGjio=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-C8S1g5W8PDiOypEVkdBcRw-1; Tue,
 28 Apr 2026 07:05:11 -0400
X-MC-Unique: C8S1g5W8PDiOypEVkdBcRw-1
X-Mimecast-MFC-AGG-ID: C8S1g5W8PDiOypEVkdBcRw_1777374310
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 330F8195609F;
	Tue, 28 Apr 2026 11:05:10 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 311F1180047F;
	Tue, 28 Apr 2026 11:05:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 1/8] KVM: VMX: remove regs argument of __vmx_vcpu_run
Date: Tue, 28 Apr 2026 07:05:00 -0400
Message-ID: <20260428110507.11248-2-pbonzini@redhat.com>
In-Reply-To: <20260428110507.11248-1-pbonzini@redhat.com>
References: <20260428110507.11248-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Registers are reachable through vcpu_vmx, no need to pass
a separate pointer to the regs[] array.

No functional change intended.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/kvm-asm-offsets.c |  1 +
 arch/x86/kvm/vmx/vmenter.S     | 58 +++++++++++++++-------------------
 arch/x86/kvm/vmx/vmx.c         |  3 +-
 arch/x86/kvm/vmx/vmx.h         |  3 +-
 4 files changed, 28 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kvm/kvm-asm-offsets.c b/arch/x86/kvm/kvm-asm-offsets.c
index 24a710d37323..36ac61724dd7 100644
--- a/arch/x86/kvm/kvm-asm-offsets.c
+++ b/arch/x86/kvm/kvm-asm-offsets.c
@@ -24,6 +24,7 @@ static void __used common(void)
 
 	if (IS_ENABLED(CONFIG_KVM_INTEL)) {
 		BLANK();
+		OFFSET(VMX_vcpu_arch_regs, vcpu_vmx, vcpu.arch.regs);
 		OFFSET(VMX_spec_ctrl, vcpu_vmx, spec_ctrl);
 	}
 }
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 8a481dae9cae..0a09288a8d29 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -11,24 +11,24 @@
 
 #define WORD_SIZE (BITS_PER_LONG / 8)
 
-#define VCPU_RAX	__VCPU_REGS_RAX * WORD_SIZE
-#define VCPU_RCX	__VCPU_REGS_RCX * WORD_SIZE
-#define VCPU_RDX	__VCPU_REGS_RDX * WORD_SIZE
-#define VCPU_RBX	__VCPU_REGS_RBX * WORD_SIZE
+#define VCPU_RAX	(VMX_vcpu_arch_regs + __VCPU_REGS_RAX * WORD_SIZE)
+#define VCPU_RCX	(VMX_vcpu_arch_regs + __VCPU_REGS_RCX * WORD_SIZE)
+#define VCPU_RDX	(VMX_vcpu_arch_regs + __VCPU_REGS_RDX * WORD_SIZE)
+#define VCPU_RBX	(VMX_vcpu_arch_regs + __VCPU_REGS_RBX * WORD_SIZE)
 /* Intentionally omit RSP as it's context switched by hardware */
-#define VCPU_RBP	__VCPU_REGS_RBP * WORD_SIZE
-#define VCPU_RSI	__VCPU_REGS_RSI * WORD_SIZE
-#define VCPU_RDI	__VCPU_REGS_RDI * WORD_SIZE
+#define VCPU_RBP	(VMX_vcpu_arch_regs + __VCPU_REGS_RBP * WORD_SIZE)
+#define VCPU_RSI	(VMX_vcpu_arch_regs + __VCPU_REGS_RSI * WORD_SIZE)
+#define VCPU_RDI	(VMX_vcpu_arch_regs + __VCPU_REGS_RDI * WORD_SIZE)
 
 #ifdef CONFIG_X86_64
-#define VCPU_R8		__VCPU_REGS_R8  * WORD_SIZE
-#define VCPU_R9		__VCPU_REGS_R9  * WORD_SIZE
-#define VCPU_R10	__VCPU_REGS_R10 * WORD_SIZE
-#define VCPU_R11	__VCPU_REGS_R11 * WORD_SIZE
-#define VCPU_R12	__VCPU_REGS_R12 * WORD_SIZE
-#define VCPU_R13	__VCPU_REGS_R13 * WORD_SIZE
-#define VCPU_R14	__VCPU_REGS_R14 * WORD_SIZE
-#define VCPU_R15	__VCPU_REGS_R15 * WORD_SIZE
+#define VCPU_R8		(VMX_vcpu_arch_regs + __VCPU_REGS_R8  * WORD_SIZE)
+#define VCPU_R9		(VMX_vcpu_arch_regs + __VCPU_REGS_R9  * WORD_SIZE)
+#define VCPU_R10	(VMX_vcpu_arch_regs + __VCPU_REGS_R10 * WORD_SIZE)
+#define VCPU_R11	(VMX_vcpu_arch_regs + __VCPU_REGS_R11 * WORD_SIZE)
+#define VCPU_R12	(VMX_vcpu_arch_regs + __VCPU_REGS_R12 * WORD_SIZE)
+#define VCPU_R13	(VMX_vcpu_arch_regs + __VCPU_REGS_R13 * WORD_SIZE)
+#define VCPU_R14	(VMX_vcpu_arch_regs + __VCPU_REGS_R14 * WORD_SIZE)
+#define VCPU_R15	(VMX_vcpu_arch_regs + __VCPU_REGS_R15 * WORD_SIZE)
 #endif
 
 .macro VMX_DO_EVENT_IRQOFF call_insn call_target
@@ -68,7 +68,6 @@
 /**
  * __vmx_vcpu_run - Run a vCPU via a transition to VMX guest mode
  * @vmx:	struct vcpu_vmx *
- * @regs:	unsigned long * (to guest registers)
  * @flags:	VMX_RUN_VMRESUME:	use VMRESUME instead of VMLAUNCH
  *		VMX_RUN_SAVE_SPEC_CTRL: save guest SPEC_CTRL into vmx->spec_ctrl
  *		VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO: vCPU can access host MMIO
@@ -94,12 +93,6 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	push %_ASM_ARG1
 
 	/* Save @flags (used for VMLAUNCH vs. VMRESUME and mitigations). */
-	push %_ASM_ARG3
-
-	/*
-	 * Save @regs, _ASM_ARG2 may be modified by vmx_update_host_rsp() and
-	 * @regs is needed after VM-Exit to save the guest's register values.
-	 */
 	push %_ASM_ARG2
 
 	lea (%_ASM_SP), %_ASM_ARG2
@@ -107,6 +100,9 @@ SYM_FUNC_START(__vmx_vcpu_run)
 
 	ALTERNATIVE "jmp .Lspec_ctrl_done", "", X86_FEATURE_MSR_SPEC_CTRL
 
+	/* Reload @vmx, _ASM_ARG1 may be modified by vmx_update_host_rsp().  */
+	mov WORD_SIZE(%_ASM_SP), %_ASM_DI
+
 	/*
 	 * SPEC_CTRL handling: if the guest's SPEC_CTRL value differs from the
 	 * host's, write the MSR.
@@ -115,7 +111,6 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	 * there must not be any returns or indirect branches between this code
 	 * and vmentry.
 	 */
-	mov 2*WORD_SIZE(%_ASM_SP), %_ASM_DI
 #ifdef CONFIG_X86_64
 	mov VMX_spec_ctrl(%rdi), %rdx
 	cmp PER_CPU_VAR(x86_spec_ctrl_current), %rdx
@@ -142,8 +137,8 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	 * an LFENCE to stop speculation from skipping the wrmsr.
 	 */
 
-	/* Load @regs to RAX. */
-	mov (%_ASM_SP), %_ASM_AX
+	/* Load @vmx to RAX. */
+	mov WORD_SIZE(%_ASM_SP), %_ASM_AX
 
 	/* Load guest registers.  Don't clobber flags. */
 	mov VCPU_RCX(%_ASM_AX), %_ASM_CX
@@ -162,7 +157,7 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	mov VCPU_R14(%_ASM_AX), %r14
 	mov VCPU_R15(%_ASM_AX), %r15
 #endif
-	/* Load guest RAX.  This kills the @regs pointer! */
+	/* Load guest RAX.  This kills the @vmx pointer! */
 	mov VCPU_RAX(%_ASM_AX), %_ASM_AX
 
 	/*
@@ -172,7 +167,7 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	 * do VERW.  Else, do nothing (no mitigations needed/enabled).
 	 */
 	ALTERNATIVE_2 "",									  \
-		      __stringify(testl $VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO, WORD_SIZE(%_ASM_SP); \
+		      __stringify(testl $VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO, (%_ASM_SP);	  \
 				  jz .Lskip_mmio_verw;						  \
 				  VERW;								  \
 				  .Lskip_mmio_verw:),					  	  \
@@ -180,7 +175,7 @@ SYM_FUNC_START(__vmx_vcpu_run)
 		      __stringify(VERW), X86_FEATURE_CLEAR_CPU_BUF_VM
 
 	/* Check @flags to see if VMLAUNCH or VMRESUME is needed. */
-	testl $VMX_RUN_VMRESUME, WORD_SIZE(%_ASM_SP)
+	testl $VMX_RUN_VMRESUME, (%_ASM_SP)
 	jz .Lvmlaunch
 
 	/*
@@ -215,8 +210,8 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
 	/* Temporarily save guest's RAX. */
 	push %_ASM_AX
 
-	/* Reload @regs to RAX. */
-	mov WORD_SIZE(%_ASM_SP), %_ASM_AX
+	/* Reload @vmx to RAX. */
+	mov 2*WORD_SIZE(%_ASM_SP), %_ASM_AX
 
 	/* Save all guest registers, including RAX from the stack */
 	pop           VCPU_RAX(%_ASM_AX)
@@ -241,9 +236,6 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
 	xor %ebx, %ebx
 
 .Lclear_regs:
-	/* Discard @regs.  The register is irrelevant, it just can't be RBX. */
-	pop %_ASM_AX
-
 	/*
 	 * Clear all general purpose registers except RSP and RBX to prevent
 	 * speculative use of the guest's values, even those that are reloaded
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a29896a9ef14..7dd4aff29026 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7468,8 +7468,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	if (vcpu->arch.cr2 != native_read_cr2())
 		native_write_cr2(vcpu->arch.cr2);
 
-	vmx->fail = __vmx_vcpu_run(vmx, (unsigned long *)&vcpu->arch.regs,
-				   flags);
+	vmx->fail = __vmx_vcpu_run(vmx, flags);
 
 	vcpu->arch.cr2 = native_read_cr2();
 	vcpu->arch.regs_avail &= ~VMX_REGS_LAZY_LOAD_SET;
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index db84e8001da5..53793d530a69 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -370,8 +370,7 @@ void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu);
 void vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp);
 void vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx, unsigned int flags);
 unsigned int __vmx_vcpu_run_flags(struct vcpu_vmx *vmx);
-bool __vmx_vcpu_run(struct vcpu_vmx *vmx, unsigned long *regs,
-		    unsigned int flags);
+bool __vmx_vcpu_run(struct vcpu_vmx *vmx, unsigned int flags);
 void vmx_ept_load_pdptrs(struct kvm_vcpu *vcpu);
 
 void vmx_set_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type, bool set);
-- 
2.52.0


