Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8DF3DB636
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866064; cv=none; b=OORF0ipsTG31MfLFah9cQdDxPOEmGY387YgRVmJBQDdeD1YDr75MwIw0Dvheo9M68Ci++WkbLw731nKFcN2jXW7NWaGXDxxpDXs1234zNj62qvyWqTiZ5GIHU7r5BnkjhsXPGjeMN5mKZZ5oJMzd2Dmskqy1QU2PETeuNtZCJWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866064; c=relaxed/simple;
	bh=ztbVj9jcj0tojkO0DP0PcZFo5D0EeyYBvLXpfuqeav0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSnlfiioM6o2n88W418oaz7dYqpItQXE8QxEFgwNmvRlBg07S56UoBGJtYX9z+8m1AHk8Tw424N/+uDyutCprMbmRUGyoGmD3VKcTvMDkbedjRSF/yBAgcQqOc4GIo5EDzXLRT2MBH8+N8HHZVn+8jPnrU2i53cpcaoWqk9M8/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZJMb353; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZJMb353"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778866062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XuBc9cSdDzJ+G5PVkYzIJAW11zsWT+BaG7aB4LH3Wk=;
	b=FZJMb353n+0L99cy2DdnvGwxFpDKzvXDyD3IOsAOraEIEwecWNbhBc5llQcPgGzEbgs9l3
	9xnJOzTAhOWSpCSTjcg6XnyEp+vAAuNlv4RxoMn5S4wUT9RDXWJvuCJHYAN8pVp1nEQIUz
	tDxyk3NA61nSkkKsoB7p2M+eN+wE83M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-hLNAR5kyN-i5Bb7oucGulw-1; Fri,
 15 May 2026 13:27:38 -0400
X-MC-Unique: hLNAR5kyN-i5Bb7oucGulw-1
X-Mimecast-MFC-AGG-ID: hLNAR5kyN-i5Bb7oucGulw_1778866057
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51ED71956048;
	Fri, 15 May 2026 17:27:37 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BDBE530002DC;
	Fri, 15 May 2026 17:27:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH 2/3] KVM: SVM: Macrofy GPR swapping in __svm_vcpu_run()
Date: Fri, 15 May 2026 13:27:33 -0400
Message-ID: <20260515172734.745763-3-pbonzini@redhat.com>
In-Reply-To: <20260515172734.745763-1-pbonzini@redhat.com>
References: <20260515172734.745763-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: "Chang S. Bae" <chang.seok.bae@intel.com>

Convert the register save/restore sequences in the SVM entry into macros,
following the VMX code. Drop the now-redundant register offset defines.

No functional change intended.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://patch.msgid.link/20260512011502.53072-3-chang.seok.bae@intel.com/
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


