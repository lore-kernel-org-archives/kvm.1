Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253663AE18C
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374323; cv=none; b=FrM+kb4P5dS8zd7pmgcLciWtJen1WxQVedD2b/ZR28O7jDqzU+kVde2jl8KL5ZF7Qa5rzQouUwmXjRawz2pAAp+5bjnyBCLPQNBih7BW1+c+RAC2Lv0z25PcD14nRcE7ddc44RHrzFeDirwqTY8vA6VDTpZ5o+Zjo0Yk4dazVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374323; c=relaxed/simple;
	bh=TaYpCTETe11C3Yfg/FrIsNKEV43YWUGQn1eYB47uKmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIfT+wdiF9M+/3RD1RhVUKksdHD3F3YrWNSbsxmzuJiLuIig42XjGxR+hzm4HpEBdWHwbd/6f7G189+CGN1/vm3zVLakpK6H0dELHRuHiz2C9BFl2BmIzXJOhHaOercsI16Pb63yXBmJNpg9XBbzOxJ7WQO2yVx9x8QsO+131bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dii56Y3/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dii56Y3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbFMocHNKjLLQkLK9ZyuZA3bwif9NnNEuCbZf7qi6Yo=;
	b=Dii56Y3/h5V1U7DjyusaEwL+hLP0+CXQfez43sxZrujOiel4ce82zDBe6ep5zlq17co4BD
	g3NVw21SyC32+mlqhb0cH287Y/wyyEC0TnZbJwVK4SucIAW9BtMDDWMBO06j0RTuPAbD/r
	dA7KL+I6783Tj/21C2CsYnYgE250Go4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-g8tAIWebMLOc3_7d60GCdw-1; Tue,
 28 Apr 2026 07:05:13 -0400
X-MC-Unique: g8tAIWebMLOc3_7d60GCdw-1
X-Mimecast-MFC-AGG-ID: g8tAIWebMLOc3_7d60GCdw_1777374312
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E70411956056;
	Tue, 28 Apr 2026 11:05:11 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 345F1180047F;
	Tue, 28 Apr 2026 11:05:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 3/8] KVM: SVM: prepare for making SPEC_CTRL switch common with VMX
Date: Tue, 28 Apr 2026 07:05:02 -0400
Message-ID: <20260428110507.11248-4-pbonzini@redhat.com>
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

Remove the local labels and restrict RESTORE_*_BODY to just
the restore code itself.  Since the alternatives are different
between VMX and SVM, having labels in the per-vendor file and
jumps in another would be too confusing.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/vmenter.S | 54 +++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index d47c5c93c991..aa655b519fe0 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -39,10 +39,8 @@
 	ALTERNATIVE_2 "", \
 		"jmp 800f", X86_FEATURE_MSR_SPEC_CTRL, \
 		"", X86_FEATURE_V_SPEC_CTRL
-801:
 .endm
-.macro RESTORE_GUEST_SPEC_CTRL_BODY
-800:
+.macro RESTORE_GUEST_SPEC_CTRL_BODY guest_spec_ctrl:req, label:req
 	/*
 	 * SPEC_CTRL handling: if the guest's SPEC_CTRL value differs from the
 	 * host's, write the MSR.  This is kept out-of-line so that the common
@@ -53,24 +51,23 @@
 	 * and vmentry.
 	 */
 #ifdef CONFIG_X86_64
-	mov SVM_spec_ctrl(%rdi), %rdx
+	mov \guest_spec_ctrl, %rdx
 	cmp PER_CPU_VAR(x86_spec_ctrl_current), %rdx
-	je 801b
+	je \label
 	movl %edx, %eax
 	shr $32, %rdx
 #else
-	mov SVM_spec_ctrl(%edi), %eax
+	mov \guest_spec_ctrl, %eax
 	mov PER_CPU_VAR(x86_spec_ctrl_current), %ecx
 	xor %eax, %ecx
-	mov SVM_spec_ctrl + 4(%edi), %edx
+	mov 4 + \guest_spec_ctrl, %edx
 	mov PER_CPU_VAR(x86_spec_ctrl_current + 4), %esi
 	xor %edx, %esi
 	or %esi, %ecx
-	je 801b
+	je \label
 #endif
 	mov $MSR_IA32_SPEC_CTRL, %ecx
 	wrmsr
-	jmp 801b
 .endm
 
 .macro RESTORE_HOST_SPEC_CTRL
@@ -78,10 +75,8 @@
 	ALTERNATIVE_2 "", \
 		"jmp 900f", X86_FEATURE_MSR_SPEC_CTRL, \
 		"", X86_FEATURE_V_SPEC_CTRL
-901:
 .endm
-.macro RESTORE_HOST_SPEC_CTRL_BODY spec_ctrl_intercepted:req
-900:
+.macro RESTORE_HOST_SPEC_CTRL_BODY guest_spec_ctrl:req, spec_ctrl_intercepted:req, label:req
 	/* Same for after vmexit.  */
 	mov $MSR_IA32_SPEC_CTRL, %ecx
 
@@ -92,28 +87,27 @@
 	cmpb $0, \spec_ctrl_intercepted
 	jnz 998f
 	rdmsr
-	movl %eax, SVM_spec_ctrl(%_ASM_DI)
-	movl %edx, SVM_spec_ctrl + 4(%_ASM_DI)
+	movl %eax, \guest_spec_ctrl
+	movl %edx, 4 + \guest_spec_ctrl
 998:
 	/* Now restore the host value of the MSR if different from the guest's.  */
 #ifdef CONFIG_X86_64
 	mov PER_CPU_VAR(x86_spec_ctrl_current), %rdx
-	cmp SVM_spec_ctrl(%rdi), %rdx
-	je 901b
+	cmp \guest_spec_ctrl, %rdx
+	je \label
 	movl %edx, %eax
 	shr $32, %rdx
 #else
 	mov PER_CPU_VAR(x86_spec_ctrl_current), %eax
-	mov SVM_spec_ctrl(%edi), %esi
+	mov \guest_spec_ctrl, %esi
 	xor %eax, %esi
 	mov PER_CPU_VAR(x86_spec_ctrl_current + 4), %edx
-	mov SVM_spec_ctrl + 4(%edi), %edi
+	mov 4 + \guest_spec_ctrl, %edi
 	xor %edx, %edi
 	or %edi, %esi
-	je 901b
+	je \label
 #endif
 	wrmsr
-	jmp 901b
 .endm
 
 #define SVM_CLEAR_CPU_BUFFERS \
@@ -162,6 +156,7 @@ SYM_FUNC_START(__svm_vcpu_run)
 
 	/* Clobbers RAX, RCX, RDX (and ESI on 32-bit), consumes RDI (@svm). */
 	RESTORE_GUEST_SPEC_CTRL
+801:
 
 	/*
 	 * Use a single vmcb (vmcb01 because it's always valid) for
@@ -242,6 +237,7 @@ SYM_FUNC_START(__svm_vcpu_run)
 	 * and RSP (pointer to @spec_ctrl_intercepted).
 	 */
 	RESTORE_HOST_SPEC_CTRL
+901:
 
 	/*
 	 * Mitigate RETBleed for AMD/Hygon Zen uarch. RET should be
@@ -295,8 +291,12 @@ SYM_FUNC_START(__svm_vcpu_run)
 	pop %_ASM_BP
 	RET
 
-	RESTORE_GUEST_SPEC_CTRL_BODY
-	RESTORE_HOST_SPEC_CTRL_BODY (%_ASM_SP)
+800:
+	RESTORE_GUEST_SPEC_CTRL_BODY SVM_spec_ctrl(%_ASM_DI), 801b
+	jmp 801b
+900:
+	RESTORE_HOST_SPEC_CTRL_BODY SVM_spec_ctrl(%_ASM_DI), (%_ASM_SP), 901b
+	jmp 901b
 
 10:	cmpb $0, _ASM_RIP(virt_rebooting)
 	jne 2b
@@ -362,6 +362,7 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 
 	/* Clobbers RAX, RCX, and RDX (@hostsa), consumes RDI (@svm). */
 	RESTORE_GUEST_SPEC_CTRL
+801:
 
 	/* Get svm->current_vmcb->pa into RAX. */
 	mov SVM_current_vmcb(%rdi), %rax
@@ -378,6 +379,7 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 
 	/* Clobbers RAX, RCX, RDX, consumes RDI (@svm) and RSI (@spec_ctrl_intercepted). */
 	RESTORE_HOST_SPEC_CTRL
+901:
 
 	/*
 	 * Mitigate RETBleed for AMD/Hygon Zen uarch. RET should be
@@ -391,8 +393,12 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	FRAME_END
 	RET
 
-	RESTORE_GUEST_SPEC_CTRL_BODY
-	RESTORE_HOST_SPEC_CTRL_BODY %sil
+800:
+	RESTORE_GUEST_SPEC_CTRL_BODY SVM_spec_ctrl(%_ASM_DI), 801b
+	jmp 801b
+900:
+	RESTORE_HOST_SPEC_CTRL_BODY SVM_spec_ctrl(%_ASM_DI), %sil, 901b
+	jmp 901b
 
 3:	cmpb $0, virt_rebooting(%rip)
 	jne 2b
-- 
2.52.0


