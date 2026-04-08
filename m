Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3833D522C
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672546; cv=none; b=fr/3SJmhqHPa7cLqP65JV8FUZ56yGqk7tKXUigda6z/O/canb0hS5Gj+RV8/XiH91UbArADIIgQtVGgDwNgOWQUKKSJrAV51mX16KnzUrn4Ez1UL76QhmshxcyZBJaeHCFdc65CFHJNo6vBPGmLTahzLujwiH27jVhrMRmmyE8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672546; c=relaxed/simple;
	bh=nUqrBWeXfG9HLCddqvAosufgQMY5yXV/dnUFQRz3KUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hg7OReMBHtPJsg77xPOvKEbw/isS+3GgIV/AeGps1f8yfIru0YKjpITNHVcJ1tEjwAQ69QUE31wVnMtyMqXow9t16AE7dfNGanXZG0czheA2hcMuVQ1L+m145fU8vzH/LnrfII/udWvdPLi5CkJ4zJW+q57sEtHsWtRe5OYjsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=adbeuhfL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adbeuhfL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775672544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utRJDEDUt40XYoA1dmLdZdoz1BpbTCbac6tFrHskUNg=;
	b=adbeuhfL15MwURRMeu9bOeTxPZqfR6hsAp8/fp5ZLyIXUt6jEubPgsdW9qw4dJ+M+TDw7w
	Caw6SlMbZYo0P6e2URGXVrmne4jKsWi9RZmSRAxIxRas6ZXygbGHafwqvpUJXbAsY+Phqu
	scj+dYYafUePPwu9xyLG1CyjiYP2em4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-1_wbkni1PXm0sS_WpeI5bw-1; Wed,
 08 Apr 2026 14:22:21 -0400
X-MC-Unique: 1_wbkni1PXm0sS_WpeI5bw-1
X-Mimecast-MFC-AGG-ID: 1_wbkni1PXm0sS_WpeI5bw_1775672539
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F04EA1955DE3;
	Wed,  8 Apr 2026 18:22:18 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 697231955D6C;
	Wed,  8 Apr 2026 18:22:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH 5/7] KVM: SVM: extract RESTORE_*_SPEC_CTRL_BODY out of svm/vmenter.S
Date: Wed,  8 Apr 2026 14:22:11 -0400
Message-ID: <20260408182213.522713-6-pbonzini@redhat.com>
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

Pure code movement, in preparation for using these macros for
VMX as well.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/vmenter.S | 62 ----------------------------------
 arch/x86/kvm/vmenter.h     | 68 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 63 deletions(-)

diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 545dc55582bf..67a05fe9827e 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -41,35 +41,6 @@
 		"jmp 800f", X86_FEATURE_MSR_SPEC_CTRL, \
 		"", X86_FEATURE_V_SPEC_CTRL
 .endm
-.macro RESTORE_GUEST_SPEC_CTRL_BODY guest_spec_ctrl:req, label:req
-	/*
-	 * SPEC_CTRL handling: if the guest's SPEC_CTRL value differs from the
-	 * host's, write the MSR.  This is kept out-of-line so that the common
-	 * case does not have to jump.
-	 *
-	 * IMPORTANT: To avoid RSB underflow attacks and any other nastiness,
-	 * there must not be any returns or indirect branches between this code
-	 * and vmentry.
-	 */
-#ifdef CONFIG_X86_64
-	mov \guest_spec_ctrl, %rdx
-	cmp PER_CPU_VAR(x86_spec_ctrl_current), %rdx
-	je \label
-	movl %edx, %eax
-	shr $32, %rdx
-#else
-	mov \guest_spec_ctrl, %eax
-	mov PER_CPU_VAR(x86_spec_ctrl_current), %ecx
-	xor %eax, %ecx
-	mov 4 + \guest_spec_ctrl, %edx
-	mov PER_CPU_VAR(x86_spec_ctrl_current + 4), %esi
-	xor %edx, %esi
-	or %esi, %ecx
-	je \label
-#endif
-	mov $MSR_IA32_SPEC_CTRL, %ecx
-	wrmsr
-.endm
 
 .macro RESTORE_HOST_SPEC_CTRL
 	/* No need to do anything if SPEC_CTRL is unset or V_SPEC_CTRL is set */
@@ -77,39 +48,6 @@
 		"jmp 900f", X86_FEATURE_MSR_SPEC_CTRL, \
 		"", X86_FEATURE_V_SPEC_CTRL
 .endm
-.macro RESTORE_HOST_SPEC_CTRL_BODY guest_spec_ctrl:req, enter_flags:req, label:req
-	/* Same for after vmexit.  */
-	mov $MSR_IA32_SPEC_CTRL, %ecx
-
-	/*
-	 * Load the value that the guest had written into MSR_IA32_SPEC_CTRL,
-	 * if it was not intercepted during guest execution.
-	 */
-	testl $KVM_ENTER_SAVE_SPEC_CTRL, \enter_flags
-	jnz 998f
-	rdmsr
-	movl %eax, \guest_spec_ctrl
-	movl %edx, 4 + \guest_spec_ctrl
-998:
-	/* Now restore the host value of the MSR if different from the guest's.  */
-#ifdef CONFIG_X86_64
-	mov PER_CPU_VAR(x86_spec_ctrl_current), %rdx
-	cmp \guest_spec_ctrl, %rdx
-	je \label
-	movl %edx, %eax
-	shr $32, %rdx
-#else
-	mov PER_CPU_VAR(x86_spec_ctrl_current), %eax
-	mov \guest_spec_ctrl, %esi
-	xor %eax, %esi
-	mov PER_CPU_VAR(x86_spec_ctrl_current + 4), %edx
-	mov 4 + \guest_spec_ctrl, %edi
-	xor %edx, %edi
-	or %edi, %esi
-	je \label
-#endif
-	wrmsr
-.endm
 
 #define SVM_CLEAR_CPU_BUFFERS \
 	ALTERNATIVE "", __CLEAR_CPU_BUFFERS, X86_FEATURE_CLEAR_CPU_BUF_VM
diff --git a/arch/x86/kvm/vmenter.h b/arch/x86/kvm/vmenter.h
index 29cdae650069..e746e1328d3f 100644
--- a/arch/x86/kvm/vmenter.h
+++ b/arch/x86/kvm/vmenter.h
@@ -6,4 +6,70 @@
 #define KVM_ENTER_SAVE_SPEC_CTRL		BIT(1)
 #define KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO	BIT(2)
 
-#endif /* __KVM_X86_VMENTER_H */
+#ifdef __ASSEMBLER__
+.macro RESTORE_GUEST_SPEC_CTRL_BODY guest_spec_ctrl:req, label:req
+	/*
+	 * SPEC_CTRL handling: if the guest's SPEC_CTRL value differs from the
+	 * host's, write the MSR.  This is kept out-of-line so that the common
+	 * case does not have to jump.
+	 *
+	 * IMPORTANT: To avoid RSB underflow attacks and any other nastiness,
+	 * there must not be any returns or indirect branches between this code
+	 * and vmentry.
+	 */
+#ifdef CONFIG_X86_64
+	mov \guest_spec_ctrl, %rdx
+	cmp PER_CPU_VAR(x86_spec_ctrl_current), %rdx
+	je \label
+	movl %edx, %eax
+	shr $32, %rdx
+#else
+	mov \guest_spec_ctrl, %eax
+	mov PER_CPU_VAR(x86_spec_ctrl_current), %ecx
+	xor %eax, %ecx
+	mov 4 + \guest_spec_ctrl, %edx
+	mov PER_CPU_VAR(x86_spec_ctrl_current + 4), %esi
+	xor %edx, %esi
+	or %esi, %ecx
+	je \label
+#endif
+	mov $MSR_IA32_SPEC_CTRL, %ecx
+	wrmsr
+.endm
+
+.macro RESTORE_HOST_SPEC_CTRL_BODY guest_spec_ctrl:req, enter_flags:req, label:req
+	/* Same for after vmexit.  */
+	mov $MSR_IA32_SPEC_CTRL, %ecx
+
+	/*
+	 * Load the value that the guest had written into MSR_IA32_SPEC_CTRL,
+	 * if it was not intercepted during guest execution.
+	 */
+	testl $KVM_ENTER_SAVE_SPEC_CTRL, \enter_flags
+	jnz 998f
+	rdmsr
+	movl %eax, \guest_spec_ctrl
+	movl %edx, 4 + \guest_spec_ctrl
+998:
+	/* Now restore the host value of the MSR if different from the guest's.  */
+#ifdef CONFIG_X86_64
+	mov PER_CPU_VAR(x86_spec_ctrl_current), %rdx
+	cmp \guest_spec_ctrl, %rdx
+	je \label
+	movl %edx, %eax
+	shr $32, %rdx
+#else
+	mov PER_CPU_VAR(x86_spec_ctrl_current), %eax
+	mov \guest_spec_ctrl, %esi
+	xor %eax, %esi
+	mov PER_CPU_VAR(x86_spec_ctrl_current + 4), %edx
+	mov 4 + \guest_spec_ctrl, %edi
+	xor %edx, %edi
+	or %edi, %esi
+	je \label
+#endif
+	wrmsr
+.endm
+
+#endif /* __ASSEMBLER__ */
+#endif /* __KVM_X86_ENTER_FLAGS_H */
-- 
2.52.0


