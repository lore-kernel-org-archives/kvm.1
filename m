Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4DD4DBD97
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694602; cv=none; b=OHHmuA8EbtCIaZQ/DfLzuqd/2bWb07hObkUgO3k/1g11kutUI6Qi1gIg4nVDxUErN+rKYP25EiA5j0fkb97G1ofSBmf2B2PSiFxr/DeJwV/MVYoDHmfTryJP2JJOdCST6VMr4i+Zf3HOlNVKkv3fdht+bbu5fLZHvfA9ZelRNoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694602; c=relaxed/simple;
	bh=Asx4CbDeoQNaVBflhH/DgL7P82NBTmCMRqActH4SVDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUhczrMQUbxEkfGgsMaBiXcHp1Y/pvPqZDvq6DpEfdJqkBkf/UQAbwySUsi37BPZ4Xo1Ful+grEQ2UfByt56aFNibhggBtwT8+bXPGeF3OVp7xenY/z/AbpMKnJBnO8OkAdnu3PYRo8wgC3I92/6XRPhkeNCsTqrIcEiWb0+1gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVstTyax; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVstTyax"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778694599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btxhEf51VljzVAv8aq3fb6k/+9IZCVa7nvJNowL5EDs=;
	b=FVstTyax6w1/m+tp+w4TXeYkMkiUQZtb5MwZUfpEAE16bqKFvYQ/0ur+JoJkEYpxrBtB/H
	kDE8+5Bbn2W7xNcOTTVcMtOZnKJ5ZehPjpb2t3erysucdyU071W+wAKNo3CM2DtdbjHgp5
	kAle34GsdWsHVvj4b5wIEZ1cazCN2wg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-oyWurn_uPNG6mZ3-MklaYw-1; Wed,
 13 May 2026 13:49:54 -0400
X-MC-Unique: oyWurn_uPNG6mZ3-MklaYw-1
X-Mimecast-MFC-AGG-ID: oyWurn_uPNG6mZ3-MklaYw_1778694591
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF6E318002C9;
	Wed, 13 May 2026 17:49:50 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77FF0180034E;
	Wed, 13 May 2026 17:49:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: chang.seok.bae@intel.com
Subject: [PATCH 2/3] KVM: SVM: Macrofy GPR swapping in __svm_vcpu_run()
Date: Wed, 13 May 2026 13:49:47 -0400
Message-ID: <20260513174948.726812-3-pbonzini@redhat.com>
In-Reply-To: <20260513174948.726812-1-pbonzini@redhat.com>
References: <20260513174948.726812-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: "Chang S. Bae" <chang.seok.bae@intel.com>

Convert the register save/restore sequences in the SVM entry into macros,
following the VMX code. Drop the now-redundant register offset defines.

No functional change intended.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Message-ID: <20260512011502.53072-3-chang.seok.bae@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/vmenter.S | 83 +++++++++-----------------------------
 1 file changed, 19 insertions(+), 64 deletions(-)

diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 6a91e1383e8f..06a8cb58f187 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -8,26 +8,6 @@
 #include "kvm-asm-offsets.h"
 #include "vmenter.h"
 
-/* Intentionally omit RAX as it's context switched by hardware */
-#define VCPU_RCX	(SVM_vcpu_arch_regs + __VCPU_REGS_RCX * WORD_SIZE)
-#define VCPU_RDX	(SVM_vcpu_arch_regs + __VCPU_REGS_RDX * WORD_SIZE)
-#define VCPU_RBX	(SVM_vcpu_arch_regs + __VCPU_REGS_RBX * WORD_SIZE)
-/* Intentionally omit RSP as it's context switched by hardware */
-#define VCPU_RBP	(SVM_vcpu_arch_regs + __VCPU_REGS_RBP * WORD_SIZE)
-#define VCPU_RSI	(SVM_vcpu_arch_regs + __VCPU_REGS_RSI * WORD_SIZE)
-#define VCPU_RDI	(SVM_vcpu_arch_regs + __VCPU_REGS_RDI * WORD_SIZE)
-
-#ifdef CONFIG_X86_64
-#define VCPU_R8		(SVM_vcpu_arch_regs + __VCPU_REGS_R8  * WORD_SIZE)
-#define VCPU_R9		(SVM_vcpu_arch_regs + __VCPU_REGS_R9  * WORD_SIZE)
-#define VCPU_R10	(SVM_vcpu_arch_regs + __VCPU_REGS_R10 * WORD_SIZE)
-#define VCPU_R11	(SVM_vcpu_arch_regs + __VCPU_REGS_R11 * WORD_SIZE)
-#define VCPU_R12	(SVM_vcpu_arch_regs + __VCPU_REGS_R12 * WORD_SIZE)
-#define VCPU_R13	(SVM_vcpu_arch_regs + __VCPU_REGS_R13 * WORD_SIZE)
-#define VCPU_R14	(SVM_vcpu_arch_regs + __VCPU_REGS_R14 * WORD_SIZE)
-#define VCPU_R15	(SVM_vcpu_arch_regs + __VCPU_REGS_R15 * WORD_SIZE)
-#endif
-
 #define SVM_vmcb01_pa	(SVM_vmcb01 + KVM_VMCB_pa)
 
 .section .noinstr.text, "ax"
@@ -108,23 +88,17 @@ SYM_FUNC_START(__svm_vcpu_run)
 	mov SVM_current_vmcb(%_ASM_DI), %_ASM_AX
 	mov KVM_VMCB_pa(%_ASM_AX), %_ASM_AX
 
-	/* Load guest registers. */
-	mov VCPU_RCX(%_ASM_DI), %_ASM_CX
-	mov VCPU_RDX(%_ASM_DI), %_ASM_DX
-	mov VCPU_RBX(%_ASM_DI), %_ASM_BX
-	mov VCPU_RBP(%_ASM_DI), %_ASM_BP
-	mov VCPU_RSI(%_ASM_DI), %_ASM_SI
+	/*
+	 * Load guest registers. Intentionally omit %_ASM_AX and %_ASM_SP as
+	 * context switched by hardware
+	 */
+	LOAD_REGS %_ASM_DI, SVM_vcpu_arch_regs, \
+		  %_ASM_CX, %_ASM_DX, %_ASM_BX, %_ASM_BP, %_ASM_SI
 #ifdef CONFIG_X86_64
-	mov VCPU_R8 (%_ASM_DI),  %r8
-	mov VCPU_R9 (%_ASM_DI),  %r9
-	mov VCPU_R10(%_ASM_DI), %r10
-	mov VCPU_R11(%_ASM_DI), %r11
-	mov VCPU_R12(%_ASM_DI), %r12
-	mov VCPU_R13(%_ASM_DI), %r13
-	mov VCPU_R14(%_ASM_DI), %r14
-	mov VCPU_R15(%_ASM_DI), %r15
+	LOAD_REGS %_ASM_DI, SVM_vcpu_arch_regs, \
+		  %r8, %r9, %r10, %r11, %r12, %r13, %r14, %r15
 #endif
-	mov VCPU_RDI(%_ASM_DI), %_ASM_DI
+	LOAD_REGS %_ASM_DI, SVM_vcpu_arch_regs, %_ASM_DI
 
 	/* Clobbers EFLAGS.ZF */
 	SVM_CLEAR_CPU_BUFFERS
@@ -135,22 +109,15 @@ SYM_FUNC_START(__svm_vcpu_run)
 	/* Pop @svm to RAX while it's the only available register. */
 	pop %_ASM_AX
 
-	/* Save all guest registers.  */
-	mov %_ASM_CX,   VCPU_RCX(%_ASM_AX)
-	mov %_ASM_DX,   VCPU_RDX(%_ASM_AX)
-	mov %_ASM_BX,   VCPU_RBX(%_ASM_AX)
-	mov %_ASM_BP,   VCPU_RBP(%_ASM_AX)
-	mov %_ASM_SI,   VCPU_RSI(%_ASM_AX)
-	mov %_ASM_DI,   VCPU_RDI(%_ASM_AX)
+	/*
+	 * Save all guest registers. Intentionally omit %_ASM_AX and %_ASM_SP as
+	 * context switched by hardware
+	 */
+	STORE_REGS %_ASM_AX, SVM_vcpu_arch_regs, \
+		   %_ASM_CX, %_ASM_DX, %_ASM_BX, %_ASM_BP, %_ASM_SI, %_ASM_DI
 #ifdef CONFIG_X86_64
-	mov %r8,  VCPU_R8 (%_ASM_AX)
-	mov %r9,  VCPU_R9 (%_ASM_AX)
-	mov %r10, VCPU_R10(%_ASM_AX)
-	mov %r11, VCPU_R11(%_ASM_AX)
-	mov %r12, VCPU_R12(%_ASM_AX)
-	mov %r13, VCPU_R13(%_ASM_AX)
-	mov %r14, VCPU_R14(%_ASM_AX)
-	mov %r15, VCPU_R15(%_ASM_AX)
+	STORE_REGS %_ASM_AX, SVM_vcpu_arch_regs, \
+		   %r8, %r9, %r10, %r11, %r12, %r13, %r14, %r15
 #endif
 
 	/* @svm can stay in RDI from now on.  */
@@ -193,21 +160,9 @@ SYM_FUNC_START(__svm_vcpu_run)
 	 * free.  RSP and RAX are exempt as they are restored by hardware
 	 * during VM-Exit.
 	 */
-	xor %ecx, %ecx
-	xor %edx, %edx
-	xor %ebx, %ebx
-	xor %ebp, %ebp
-	xor %esi, %esi
-	xor %edi, %edi
+	CLEAR_REGS %ecx, %edx, %ebx, %ebp, %esi, %edi
 #ifdef CONFIG_X86_64
-	xor %r8d,  %r8d
-	xor %r9d,  %r9d
-	xor %r10d, %r10d
-	xor %r11d, %r11d
-	xor %r12d, %r12d
-	xor %r13d, %r13d
-	xor %r14d, %r14d
-	xor %r15d, %r15d
+	CLEAR_REGS %r8d, %r9d, %r10d, %r11d, %r12d, %r13d, %r14d, %r15d
 #endif
 
 	/* "Pop" @enter_flags.  */
-- 
2.52.0


