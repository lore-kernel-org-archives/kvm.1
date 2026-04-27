Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9383B6352
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287543; cv=none; b=j5J1GdHDSugQ1GRC4Apxt18bvj6Eod59pnmG52WBTN/lKN4mHoQQPrsgob2xY2M8rWpAb8TnHekeO7xCxPaM36knnjbqi06+d4tCNdd52AfIdqDk9SxdWaZ1El8WP7VlBgG9Y/wHqus7jD/OacwM8COH0N3v0uMQHeq3HnYbhQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287543; c=relaxed/simple;
	bh=uPkVfKM0zF2dhYkL5RD3hjkZp1adOwVOVYbaEYn3awQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7g1+Ovwq68FtBjsnhejSYShnMJbwCRAD+4kZahgkLA0Nv4qNN2o+XNIWxLUfZjvZciTKDcsAT1mpoPZZJUpd3I4tMQskS+FBzRtg8cQTqNFwoIyR7Led5hJfJ/h06PUljqQprXwlNCmShCsq2cgjRoptRjN1XutG3MdntDQuBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LgunQv3c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgunQv3c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777287540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5RRZp0suC0B+NEwL0qamgkZmEdjJKWwFrc5H3yQYD0=;
	b=LgunQv3ck3NJLHhxYcRBHStoDDlPwwdPTj6eLJh3M0V9AY0zyZYIQI1ywhLj3PsXUCHJSB
	A8wHDgc/IFJdkeK1c9wxE+2dT0KH3Eco0oURsYXGt9q0MbAs6uacbiGKe7VMypgdKV79TL
	efpYwSKMIDBoS9spHpsOo+q+Ye9xNGE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-NHb83-4bMXG07B7SbBBSEw-1; Mon,
 27 Apr 2026 06:58:56 -0400
X-MC-Unique: NHb83-4bMXG07B7SbBBSEw-1
X-Mimecast-MFC-AGG-ID: NHb83-4bMXG07B7SbBBSEw_1777287535
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C593180064B;
	Mon, 27 Apr 2026 10:58:55 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90F711800347;
	Mon, 27 Apr 2026 10:58:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH v2 5/7] KVM: SVM: extract RESTORE_*_SPEC_CTRL_BODY out of svm/vmenter.S
Date: Mon, 27 Apr 2026 06:58:46 -0400
Message-ID: <20260427105848.44865-6-pbonzini@redhat.com>
In-Reply-To: <20260427105848.44865-1-pbonzini@redhat.com>
References: <20260427105848.44865-1-pbonzini@redhat.com>
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
 arch/x86/kvm/svm/vmenter.S | 62 ----------------------------------
 arch/x86/kvm/vmenter.h     | 68 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 63 deletions(-)

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
index 29cdae650069..84951e186859 100644
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
+#endif /* __KVM_X86_ENTER_FLAGS_H */
-- 
2.52.0


