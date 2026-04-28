Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A043D3E92A0
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374319; cv=none; b=UkUKE7jbgI/hSEhZvKXYZH905jHM0MWqhwYk/kVGUN2sLiXKo3pMFVyPcPaMe4NtRa9Gf7jjKLDSSEuqFmWE1zpC5O4vd1jLTpceQYjD2wZv1X6uF7rG6aG0eXjOcAwlefYd8JPqs10DH7hA1ngFPHt9RZGo3qvZVqg8Gjze8Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374319; c=relaxed/simple;
	bh=BPV3vT9eA04WNPHZTQqGt2+snx1/jYDEWCMTWyW1EFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHm4vjMO+OleGj9pMEgzzcQDQqlomDI2+0mHhNfMzOVSYeYNE41a4XspHwThhZMWWNHWCz7LY+Z9PpTF/8lRMxhcO7O3KjAAmkE9gj3EJf2CC+CaqFUCp3Da2zmfiNWLzw0gsoxAGu0uS87jqMGc1Lh9D5y4clFGMK9Sn6Fu77M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VM/Z5NFA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VM/Z5NFA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNmP5dFTDai7i3tVbIrBGBZA/r4qew1n0ivtF6u/XX0=;
	b=VM/Z5NFAWMHD/FStkZRgiM3TqNDAqcSsPtH3dEeZdul1pRbhm9lcBzv9UHlzqXA6MPWJaU
	u12ZcD/6zFcKFSD/JrIu5jj/cxKy6U7h+2v+N7HnD9wXFKD8a53oJbHyC1Re5qw+SIwuw7
	XKzLwa9u/aqYQz/dDNJ5L9cyUuEu2B4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-cCMpog1NOU2qp_JIWWVEPw-1; Tue,
 28 Apr 2026 07:05:12 -0400
X-MC-Unique: cCMpog1NOU2qp_JIWWVEPw-1
X-Mimecast-MFC-AGG-ID: cCMpog1NOU2qp_JIWWVEPw_1777374311
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C76518002C0;
	Tue, 28 Apr 2026 11:05:11 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46A78180047F;
	Tue, 28 Apr 2026 11:05:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 2/8] KVM: VMX: more cleanups to __vmx_vcpu_run
Date: Tue, 28 Apr 2026 07:05:01 -0400
Message-ID: <20260428110507.11248-3-pbonzini@redhat.com>
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

Slightly improve register allocation, loading vmx only once
before vmlaunch/vmresume.

This also makes the code slightly more similar to the one for
AMD processors, in that both keep the pointer to struct vcpu_vmx
or vcpu_svm in %rdi.  The code for restoring the guest value of
SPEC_CTRL is also the same for Intel and AMD.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/vmenter.S | 85 ++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 0a09288a8d29..efac31cedfde 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -98,11 +98,11 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	lea (%_ASM_SP), %_ASM_ARG2
 	call vmx_update_host_rsp
 
-	ALTERNATIVE "jmp .Lspec_ctrl_done", "", X86_FEATURE_MSR_SPEC_CTRL
-
 	/* Reload @vmx, _ASM_ARG1 may be modified by vmx_update_host_rsp().  */
 	mov WORD_SIZE(%_ASM_SP), %_ASM_DI
 
+	ALTERNATIVE "jmp .Lspec_ctrl_done", "", X86_FEATURE_MSR_SPEC_CTRL
+
 	/*
 	 * SPEC_CTRL handling: if the guest's SPEC_CTRL value differs from the
 	 * host's, write the MSR.
@@ -122,9 +122,9 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	mov PER_CPU_VAR(x86_spec_ctrl_current), %ecx
 	xor %eax, %ecx
 	mov VMX_spec_ctrl + 4(%edi), %edx
-	mov PER_CPU_VAR(x86_spec_ctrl_current + 4), %edi
-	xor %edx, %edi
-	or %edi, %ecx
+	mov PER_CPU_VAR(x86_spec_ctrl_current + 4), %esi
+	xor %edx, %esi
+	or %esi, %ecx
 	je .Lspec_ctrl_done
 #endif
 	mov $MSR_IA32_SPEC_CTRL, %ecx
@@ -137,28 +137,25 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	 * an LFENCE to stop speculation from skipping the wrmsr.
 	 */
 
-	/* Load @vmx to RAX. */
-	mov WORD_SIZE(%_ASM_SP), %_ASM_AX
-
 	/* Load guest registers.  Don't clobber flags. */
-	mov VCPU_RCX(%_ASM_AX), %_ASM_CX
-	mov VCPU_RDX(%_ASM_AX), %_ASM_DX
-	mov VCPU_RBX(%_ASM_AX), %_ASM_BX
-	mov VCPU_RBP(%_ASM_AX), %_ASM_BP
-	mov VCPU_RSI(%_ASM_AX), %_ASM_SI
-	mov VCPU_RDI(%_ASM_AX), %_ASM_DI
+	mov VCPU_RAX(%_ASM_DI), %_ASM_AX
+	mov VCPU_RCX(%_ASM_DI), %_ASM_CX
+	mov VCPU_RDX(%_ASM_DI), %_ASM_DX
+	mov VCPU_RBX(%_ASM_DI), %_ASM_BX
+	mov VCPU_RBP(%_ASM_DI), %_ASM_BP
+	mov VCPU_RSI(%_ASM_DI), %_ASM_SI
 #ifdef CONFIG_X86_64
-	mov VCPU_R8 (%_ASM_AX),  %r8
-	mov VCPU_R9 (%_ASM_AX),  %r9
-	mov VCPU_R10(%_ASM_AX), %r10
-	mov VCPU_R11(%_ASM_AX), %r11
-	mov VCPU_R12(%_ASM_AX), %r12
-	mov VCPU_R13(%_ASM_AX), %r13
-	mov VCPU_R14(%_ASM_AX), %r14
-	mov VCPU_R15(%_ASM_AX), %r15
+	mov VCPU_R8 (%_ASM_DI),  %r8
+	mov VCPU_R9 (%_ASM_DI),  %r9
+	mov VCPU_R10(%_ASM_DI), %r10
+	mov VCPU_R11(%_ASM_DI), %r11
+	mov VCPU_R12(%_ASM_DI), %r12
+	mov VCPU_R13(%_ASM_DI), %r13
+	mov VCPU_R14(%_ASM_DI), %r14
+	mov VCPU_R15(%_ASM_DI), %r15
 #endif
-	/* Load guest RAX.  This kills the @vmx pointer! */
-	mov VCPU_RAX(%_ASM_AX), %_ASM_AX
+	/* Load guest RDI.  This kills the @vmx pointer! */
+	mov VCPU_RDI(%_ASM_DI), %_ASM_DI
 
 	/*
 	 * Note, ALTERNATIVE_2 works in reverse order.  If CLEAR_CPU_BUF_VM is
@@ -207,29 +204,29 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
 	UNWIND_HINT_RESTORE
 	ENDBR
 
-	/* Temporarily save guest's RAX. */
-	push %_ASM_AX
+	/* Temporarily save guest's RDI. */
+	push %_ASM_DI
 
-	/* Reload @vmx to RAX. */
-	mov 2*WORD_SIZE(%_ASM_SP), %_ASM_AX
+	/* Reload @vmx to RDI. */
+	mov 2*WORD_SIZE(%_ASM_SP), %_ASM_DI
 
-	/* Save all guest registers, including RAX from the stack */
-	pop           VCPU_RAX(%_ASM_AX)
-	mov %_ASM_CX, VCPU_RCX(%_ASM_AX)
-	mov %_ASM_DX, VCPU_RDX(%_ASM_AX)
-	mov %_ASM_BX, VCPU_RBX(%_ASM_AX)
-	mov %_ASM_BP, VCPU_RBP(%_ASM_AX)
-	mov %_ASM_SI, VCPU_RSI(%_ASM_AX)
-	mov %_ASM_DI, VCPU_RDI(%_ASM_AX)
+	/* Save all guest registers, including RDI from the stack */
+	mov %_ASM_AX, VCPU_RAX(%_ASM_DI)
+	mov %_ASM_CX, VCPU_RCX(%_ASM_DI)
+	mov %_ASM_DX, VCPU_RDX(%_ASM_DI)
+	mov %_ASM_BX, VCPU_RBX(%_ASM_DI)
+	mov %_ASM_BP, VCPU_RBP(%_ASM_DI)
+	mov %_ASM_SI, VCPU_RSI(%_ASM_DI)
+	pop           VCPU_RDI(%_ASM_DI)
 #ifdef CONFIG_X86_64
-	mov %r8,  VCPU_R8 (%_ASM_AX)
-	mov %r9,  VCPU_R9 (%_ASM_AX)
-	mov %r10, VCPU_R10(%_ASM_AX)
-	mov %r11, VCPU_R11(%_ASM_AX)
-	mov %r12, VCPU_R12(%_ASM_AX)
-	mov %r13, VCPU_R13(%_ASM_AX)
-	mov %r14, VCPU_R14(%_ASM_AX)
-	mov %r15, VCPU_R15(%_ASM_AX)
+	mov %r8,  VCPU_R8 (%_ASM_DI)
+	mov %r9,  VCPU_R9 (%_ASM_DI)
+	mov %r10, VCPU_R10(%_ASM_DI)
+	mov %r11, VCPU_R11(%_ASM_DI)
+	mov %r12, VCPU_R12(%_ASM_DI)
+	mov %r13, VCPU_R13(%_ASM_DI)
+	mov %r14, VCPU_R14(%_ASM_DI)
+	mov %r15, VCPU_R15(%_ASM_DI)
 #endif
 
 	/* Clear return value to indicate VM-Exit (as opposed to VM-Fail). */
-- 
2.52.0


