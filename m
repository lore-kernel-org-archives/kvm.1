Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A8A3002A9
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866064; cv=none; b=iUSvjfUh06Y515pFKq/MesQXQxmKjueIcKAq/D3PAuD2bFdXp4mnKY4poac6rGq7bOyTY/9fwO63NMd7HvSRDqZ9gyuRvtJtRsfVL+WNbOnEB+HLiQHU1zz87G2xaMR1TLahgHtSWEpJsl0riNeiFuQSqg/PS2Z1OLgWNv4JVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866064; c=relaxed/simple;
	bh=/QJkGp/cjETKkHKl0K6B3hC2HUSjCL00bgfYWeM8yNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjSSE9G7THMfuQjWbhvmW8L05hbTrk+QQHXJv7w44Jdnd1GjHJGY5IlpZeY8bloqn5D6jSCjMeYgzG5AsE9g28c2wv4nbunw70An0a6TzzmpWLz9bQXqiyzDag9Af90tCPYrBWogzARUCCc3LVyb8FONa2BoZmodZ5FJfxUENSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RaVANEMn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RaVANEMn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778866060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VLmMYhEZfbNMeR85rfYcDEoyoj1P01GvzyhLerWty0A=;
	b=RaVANEMngLm4S9DaepfmVwqWx5M7IljDJiOyMUNOgdwfPG88hwXSp7G9O9eaxP0lyNGvpJ
	2NoOf6Dn572wVRN2I+6LRTCYvkregCkql/aNIhVwjw2JmphZc9pf41mQtaipjPazezoFY2
	ifkX4vtL2um+gar32BDZ0FFqDrzRmEI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-IKzBnF2zPiuvz1diLg5b6g-1; Fri,
 15 May 2026 13:27:39 -0400
X-MC-Unique: IKzBnF2zPiuvz1diLg5b6g-1
X-Mimecast-MFC-AGG-ID: IKzBnF2zPiuvz1diLg5b6g_1778866058
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EAB11956050;
	Fri, 15 May 2026 17:27:38 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77BB630001A2;
	Fri, 15 May 2026 17:27:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH 3/3] KVM: SEV: Macrofy GPR swapping in __svm_sev_es_vcpu_run()
Date: Fri, 15 May 2026 13:27:34 -0400
Message-ID: <20260515172734.745763-4-pbonzini@redhat.com>
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

Convert the SEV-ES entry code to use macros for saving guest GPRs,
following VMX/SVM paths. Drop now-unused register offsets and
__VCPU_REGS_* defines.

No functional change intended.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://patch.msgid.link/20260512011502.53072-4-chang.seok.bae@intel.com/
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h      | 16 ++++++++--------
 arch/x86/include/asm/kvm_vcpu_regs.h | 11 -----------
 arch/x86/kvm/svm/vmenter.S           | 21 ++-------------------
 3 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8a53ca619570..53527b0550c7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -182,14 +182,14 @@ enum kvm_reg {
 	VCPU_REGS_RSI = __VCPU_REGS_RSI,
 	VCPU_REGS_RDI = __VCPU_REGS_RDI,
 #ifdef CONFIG_X86_64
-	VCPU_REGS_R8  = __VCPU_REGS_R8,
-	VCPU_REGS_R9  = __VCPU_REGS_R9,
-	VCPU_REGS_R10 = __VCPU_REGS_R10,
-	VCPU_REGS_R11 = __VCPU_REGS_R11,
-	VCPU_REGS_R12 = __VCPU_REGS_R12,
-	VCPU_REGS_R13 = __VCPU_REGS_R13,
-	VCPU_REGS_R14 = __VCPU_REGS_R14,
-	VCPU_REGS_R15 = __VCPU_REGS_R15,
+	VCPU_REGS_R8  = 8,
+	VCPU_REGS_R9,
+	VCPU_REGS_R10,
+	VCPU_REGS_R11,
+	VCPU_REGS_R12,
+	VCPU_REGS_R13,
+	VCPU_REGS_R14,
+	VCPU_REGS_R15,
 #endif
 	NR_VCPU_GENERAL_PURPOSE_REGS,
 
diff --git a/arch/x86/include/asm/kvm_vcpu_regs.h b/arch/x86/include/asm/kvm_vcpu_regs.h
index 650fabf5871d..d9f1528fab2b 100644
--- a/arch/x86/include/asm/kvm_vcpu_regs.h
+++ b/arch/x86/include/asm/kvm_vcpu_regs.h
@@ -11,17 +11,6 @@
 #define __VCPU_REGS_RSI  6
 #define __VCPU_REGS_RDI  7
 
-#ifdef CONFIG_X86_64
-#define __VCPU_REGS_R8   8
-#define __VCPU_REGS_R9   9
-#define __VCPU_REGS_R10 10
-#define __VCPU_REGS_R11 11
-#define __VCPU_REGS_R12 12
-#define __VCPU_REGS_R13 13
-#define __VCPU_REGS_R14 14
-#define __VCPU_REGS_R15 15
-#endif
-
 #ifdef __ASSEMBLER__
 
 #define REG_NUM_INVALID		100
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 06a8cb58f187..99701892f8ec 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -211,18 +211,7 @@ SYM_FUNC_END(__svm_vcpu_run)
 
 #ifdef CONFIG_KVM_AMD_SEV
 
-
-#ifdef CONFIG_X86_64
 #define SEV_ES_GPRS_BASE 0x300
-#define SEV_ES_RBX	(SEV_ES_GPRS_BASE + __VCPU_REGS_RBX * WORD_SIZE)
-#define SEV_ES_RBP	(SEV_ES_GPRS_BASE + __VCPU_REGS_RBP * WORD_SIZE)
-#define SEV_ES_RSI	(SEV_ES_GPRS_BASE + __VCPU_REGS_RSI * WORD_SIZE)
-#define SEV_ES_RDI	(SEV_ES_GPRS_BASE + __VCPU_REGS_RDI * WORD_SIZE)
-#define SEV_ES_R12	(SEV_ES_GPRS_BASE + __VCPU_REGS_R12 * WORD_SIZE)
-#define SEV_ES_R13	(SEV_ES_GPRS_BASE + __VCPU_REGS_R13 * WORD_SIZE)
-#define SEV_ES_R14	(SEV_ES_GPRS_BASE + __VCPU_REGS_R14 * WORD_SIZE)
-#define SEV_ES_R15	(SEV_ES_GPRS_BASE + __VCPU_REGS_R15 * WORD_SIZE)
-#endif
 
 /**
  * __svm_sev_es_vcpu_run - Run a SEV-ES vCPU via a transition to SVM guest mode
@@ -237,19 +226,13 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	 * Except for RAX and RSP, all GPRs are restored on #VMEXIT, but not
 	 * saved on VMRUN.
 	 */
-	mov %rbp, SEV_ES_RBP (%rdx)
-	mov %r15, SEV_ES_R15 (%rdx)
-	mov %r14, SEV_ES_R14 (%rdx)
-	mov %r13, SEV_ES_R13 (%rdx)
-	mov %r12, SEV_ES_R12 (%rdx)
-	mov %rbx, SEV_ES_RBX (%rdx)
+	STORE_REGS %rdx, SEV_ES_GPRS_BASE, %rbp, %r15, %r14, %r13, %r12, %rbx
 
 	/*
 	 * Save volatile registers that hold arguments that are needed after
 	 * #VMEXIT (RDI=@svm and RSI=@enter_flags).
 	 */
-	mov %rdi, SEV_ES_RDI (%rdx)
-	mov %rsi, SEV_ES_RSI (%rdx)
+	STORE_REGS %rdx, SEV_ES_GPRS_BASE, %rdi, %rsi
 
 	/* Clobbers RAX, RCX, and RDX (@hostsa), consumes RDI (@svm). */
 	RESTORE_GUEST_SPEC_CTRL
-- 
2.52.0

