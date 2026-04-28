Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D068E3F54D4
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374325; cv=none; b=rF2E0nTgY93SZyeTzIvdBTDuPceXmFpJCaXX6bherV48LFclJITDN3kq0QOhnuMHIAtN16xUYcplIdOb0E4He+IoOVYhMVDrqz4YwintZoGQX+klCi5HYLm5wg7nYg+IW97Tf2sYKc+dhy4HMeYx9IjQYGbT0gO5xtqGjNWTM0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374325; c=relaxed/simple;
	bh=7Z/QcoB0quyknVpamQI7ee/ND7q601A3Yw2aUf9nN1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9YPM96MOQyE469l6CerHwbZiJpfz62JfXMZQ5Mcd8V5LP6vCYv2aBT6H5Mqsf9/y51fXgoYZwfXOD8Q6OpEVbqNTSStqa8PyFtknnnHgymXkeH/1iLgnbXk/akolnTKPw8yADuCvYfemSKX2v/9amaH9c/NTQF17hSN/Yzlqm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cJUZUJ2x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJUZUJ2x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Av4xmP7akAKu3weP+YCvPYBBTkWPaFe7RdTW3G3Kwfc=;
	b=cJUZUJ2xYz4dI7jSFm0Ty91M/xnnXcLeIKcKHX4JO/9G0/m02ZuoPNevMRwMKFGlXlmW7+
	kOmV9nD4OOMbe/phgnn5n7kxZJOCy87KKEwe8L2whT2FDw9XduIR0Y9ZwJd0fWY0EN55x3
	9AHFWyG3lLvrihld1qkrmLllubXqbp0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-TzCKab-LN8iDOgacHZ40Wg-1; Tue,
 28 Apr 2026 07:05:16 -0400
X-MC-Unique: TzCKab-LN8iDOgacHZ40Wg-1
X-Mimecast-MFC-AGG-ID: TzCKab-LN8iDOgacHZ40Wg_1777374314
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1B3E18005B6;
	Tue, 28 Apr 2026 11:05:14 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0642A180047F;
	Tue, 28 Apr 2026 11:05:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6/8] KVM: SVM: extract RESTORE_*_SPEC_CTRL_BODY out of svm/vmenter.S
Date: Tue, 28 Apr 2026 07:05:05 -0400
Message-ID: <20260428110507.11248-7-pbonzini@redhat.com>
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

Pure code movement, in preparation for using these macros for
VMX as well.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/vmenter.S | 62 -----------------------------------
 arch/x86/kvm/vmenter.h     | 66 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 62 deletions(-)

diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 2bc7ecb338a9..f523d9e49839 100644
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
-	jz 998f
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
index 29cdae650069..73f3adc301d9 100644
--- a/arch/x86/kvm/vmenter.h
+++ b/arch/x86/kvm/vmenter.h
@@ -6,4 +6,70 @@
 #define KVM_ENTER_SAVE_SPEC_CTRL		BIT(1)
 #define KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO	BIT(2)
 
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
+	jz 998f
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
 #endif /* __KVM_X86_VMENTER_H */
-- 
2.52.0


