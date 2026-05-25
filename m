Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F342303C83
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779710851; cv=none; b=nrqwEPwrYIx2XeTw7099Wov0VCC2dRRu1pwEb7t28NPr1mZ3vpQ3mvM4UZhf8oy5Jq2I3dEDF6dmqyXhQuCLcTDg+bYRP5Fq5Twx6kDz3f0q7iOOpW3yj8MaNrTfyk0Mm0fid9MBRHpnOx7R/k6KZtnl/CACQE8zIPWkOqxz8tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779710851; c=relaxed/simple;
	bh=4CHZeOjV/PB5i3VCyI3BpHIWRw8dkqH4DKRqFHpWnXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lsrVLod0M1Uc/iPMqX2PfAY6wTwKCZbb4j4jg+6Fk5RPTCRqUtYeanBQbDOyKqumkFjk+o9LP2KfZdchTl4vkdDyeEB1v7zqeDCmk32wDj2gu7NG7Nc9KZR5hLQgI3KL5LFfZ3nMjBgvx45GSiQ5cWmfCGAetlBL7S4dK/FIPrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUncHN64; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUncHN64"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779710849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OxA+wkCeRGCMz6mVK+iQ6ixDlpZfLn5/b8lmiEYNdoY=;
	b=dUncHN64a5nTV/JMIaUHrHxfboaZbhczZ5+uiZ80olxTfcBv7+/xskybWMkmqz67xhRimc
	r8KiqvmLbA8ViIK/pWe2PVIBCBsinAt5660BmGCVcb2ZQ1G0+Np2dmdKawAYxfkIGeToru
	yrc/oJDwT2s1FbBGNWO9HFp5tJg6/Vw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-I0qRiSyqPs2raqMvXLHirQ-1; Mon,
 25 May 2026 08:07:25 -0400
X-MC-Unique: I0qRiSyqPs2raqMvXLHirQ-1
X-Mimecast-MFC-AGG-ID: I0qRiSyqPs2raqMvXLHirQ_1779710844
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9D38195608E;
	Mon, 25 May 2026 12:07:24 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5840C30002E0;
	Mon, 25 May 2026 12:07:24 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: "Aithal, Srikanth" <sraithal@amd.com>
Subject: [PATCH kvm-unit-tests] svm_tests: access rflags and rax via this_cpu_guest_regs()
Date: Mon, 25 May 2026 08:07:23 -0400
Message-ID: <20260525120723.8265-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is needed now that the VMCB save area is properly updated.

Reported-by: Aithal, Srikanth <sraithal@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/svm_tests.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index 8547e729..00552448 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -650,7 +650,7 @@ static bool msr_intercept_finished(struct svm_test *test)
 	 *      while RAX hold its lower 32 bits.
 	 */
 	if (vmcb->control.exit_info_1)
-		test->scratch = ((regs->rdx << 32) | (vmcb->save.rax & 0xffffffff));
+		test->scratch = ((regs->rdx << 32) | (regs->rax & 0xffffffff));
 	else
 		test->scratch = regs->rcx;
 
@@ -1871,9 +1871,11 @@ static bool virq_inject_check(struct svm_test *test)
 
 static void virq_inject_within_shadow_prepare(struct svm_test *test)
 {
+	struct guest_regs *regs = this_cpu_guest_regs();
+
 	virq_inject_prepare(test);
 	vmcb->control.int_state = SVM_INTERRUPT_SHADOW_MASK;
-	vmcb->save.rflags |= X86_EFLAGS_IF;
+	regs->rflags |= X86_EFLAGS_IF;
 }
 
 extern void virq_inject_within_shadow_test(struct svm_test *test);
@@ -2710,12 +2712,14 @@ asm("guest_rflags_test_guest:\n\t"
 
 static void svm_test_singlestep(void)
 {
+	struct guest_regs *regs = this_cpu_guest_regs();
+
 	handle_exception(DB_VECTOR, guest_rflags_test_db_handler);
 
 	/*
 	 * Trap expected after completion of first guest instruction
 	 */
-	vmcb->save.rflags |= X86_EFLAGS_TF;
+	regs->rflags |= X86_EFLAGS_TF;
 	report (__svm_vmrun((u64)guest_rflags_test_guest) == SVM_EXIT_VMMCALL &&
 		guest_rflags_test_trap_rip == (u64)&insn2,
 		"Test EFLAGS.TF on VMRUN: trap expected  after completion of first guest instruction");
@@ -2724,7 +2728,7 @@ static void svm_test_singlestep(void)
 	 */
 	guest_rflags_test_trap_rip = 0;
 	vmcb->save.rip += 3;
-	vmcb->save.rflags |= X86_EFLAGS_TF;
+	regs->rflags |= X86_EFLAGS_TF;
 	report (__svm_vmrun(vmcb->save.rip) == SVM_EXIT_VMMCALL &&
 		guest_rflags_test_trap_rip == 0, "Test EFLAGS.TF on VMRUN: trap not expected");
 
@@ -3319,6 +3323,7 @@ static void dummy_nmi_handler(struct ex_regs *regs)
 
 static void svm_intr_intercept_mix_run_guest(volatile int *counter, u64 expected_vmexit)
 {
+	struct guest_regs *regs = this_cpu_guest_regs();
 	if (counter)
 		*counter = 0;
 
@@ -3338,7 +3343,7 @@ static void svm_intr_intercept_mix_run_guest(volatile int *counter, u64 expected
 	report(vmcb->control.exit_code == expected_vmexit,
 	       "Wanted VM-Exit reason 0x%lx, got 0x%lx",
 	       expected_vmexit, vmcb->control.exit_code);
-	report(vmcb->save.rflags & X86_EFLAGS_IF, "Guest should have EFLAGS.IF set now");
+	report(regs->rflags & X86_EFLAGS_IF, "Guest should have EFLAGS.IF set now");
 	cli();
 }
 
@@ -3354,12 +3359,14 @@ static void svm_intr_intercept_mix_if_guest(struct svm_test *test)
 
 static void svm_intr_intercept_mix_if(void)
 {
+	struct guest_regs *regs = this_cpu_guest_regs();
+
 	// make a physical interrupt to be pending
 	handle_irq(0x55, dummy_isr);
 
 	vmcb->control.intercept |= (1 << INTERCEPT_INTR);
 	vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
-	vmcb->save.rflags &= ~X86_EFLAGS_IF;
+	regs->rflags &= ~X86_EFLAGS_IF;
 
 	test_set_guest(svm_intr_intercept_mix_if_guest);
 	cli();
@@ -3388,11 +3395,13 @@ static void svm_intr_intercept_mix_gif_guest(struct svm_test *test)
 
 static void svm_intr_intercept_mix_gif(void)
 {
+	struct guest_regs *regs = this_cpu_guest_regs();
+
 	handle_irq(0x55, dummy_isr);
 
 	vmcb->control.intercept |= (1 << INTERCEPT_INTR);
 	vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
-	vmcb->save.rflags &= ~X86_EFLAGS_IF;
+	regs->rflags &= ~X86_EFLAGS_IF;
 
 	test_set_guest(svm_intr_intercept_mix_gif_guest);
 	cli();
@@ -3418,11 +3427,13 @@ static void svm_intr_intercept_mix_gif_guest2(struct svm_test *test)
 
 static void svm_intr_intercept_mix_gif2(void)
 {
+	struct guest_regs *regs = this_cpu_guest_regs();
+
 	handle_irq(0x55, dummy_isr);
 
 	vmcb->control.intercept |= (1 << INTERCEPT_INTR);
 	vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
-	vmcb->save.rflags |= X86_EFLAGS_IF;
+	regs->rflags |= X86_EFLAGS_IF;
 
 	test_set_guest(svm_intr_intercept_mix_gif_guest2);
 	svm_intr_intercept_mix_run_guest(&dummy_isr_recevied, SVM_EXIT_INTR);
@@ -3447,11 +3458,13 @@ static void svm_intr_intercept_mix_nmi_guest(struct svm_test *test)
 
 static void svm_intr_intercept_mix_nmi(void)
 {
+	struct guest_regs *regs = this_cpu_guest_regs();
+
 	handle_exception(2, dummy_nmi_handler);
 
 	vmcb->control.intercept |= (1 << INTERCEPT_NMI);
 	vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
-	vmcb->save.rflags |= X86_EFLAGS_IF;
+	regs->rflags |= X86_EFLAGS_IF;
 
 	test_set_guest(svm_intr_intercept_mix_nmi_guest);
 	svm_intr_intercept_mix_run_guest(&nmi_recevied, SVM_EXIT_NMI);
-- 
2.52.0

