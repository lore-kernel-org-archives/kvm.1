Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87E7480355
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583169; cv=none; b=eZfn1Yhd/1W5vhn5i/ZjOGKUQbrdov8uPkMwSKdK3yYgX/SbAnUpg7br/PTPtPJOg5Xg4UqoJxybjQiZWZUxVVUjyDzVIzUhwmIICof/m9qjiU9F4L3xTeA8ojbl0Ws3vH0hXzS54Z0u97MINx/qqYybUnnWRVnskBIzWDHHENY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583169; c=relaxed/simple;
	bh=m6tAgj+ysrOXi7581875+iQnRhJpbSgMirUg4bO3Tdw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfZS9QcgVIiwuEhChTO/rlp2hDty1U9ukAvTDEtwFoFrvtzxCR+0s7AvwAiLvY25I85kOzrExFKQfqX2iUTFUOas1A0D5qrlm6rtYBRWt9j5HSylnqSVGKbXizm1ni//nAeSGmsORmaELN2OCsYn792fCFWb/8EhMsyfob5hQjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bz+coEyx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bz+coEyx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780583167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5veQw2CYYEhiIx0/xtKp2grsd7l8etbm+EXc22qTMc=;
	b=Bz+coEyxPsC3dEWWnnHY2K4qJCitJYflwHqPDaxdJ7DXXIssGZ/+9IwQ6EvoAv4OVDUKRy
	CFC8QHa8bpmI3AaiWbR4PC5N+OOSREmXsVrB+T8azIqSphiL2jUQFxsY1B/5aVSUJgk+iD
	g8QrKWatZo7IefsIhRJlqyK9JNb0HNw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-h6UYoIuFM0KBbkJJFP1AeA-1; Thu,
 04 Jun 2026 10:26:04 -0400
X-MC-Unique: h6UYoIuFM0KBbkJJFP1AeA-1
X-Mimecast-MFC-AGG-ID: h6UYoIuFM0KBbkJJFP1AeA_1780583163
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72F6119560AA
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:26:03 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D033180049F
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:26:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Subject: [PATCH kvm-unit-tests 3/4] svm: add test for 32-bit PAE guest
Date: Thu,  4 Jun 2026 10:26:00 -0400
Message-ID: <20260604142601.7440-4-pbonzini@redhat.com>
In-Reply-To: <20260604142601.7440-1-pbonzini@redhat.com>
References: <20260604142601.7440-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

SVM tests are only running 64-bit guests.  Add a test that checks
the reserved and ignored bits in CR3 and PDPTEs for PAE mode.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/svm_tests.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index 0afdb205..f8c4d07a 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -52,6 +52,52 @@ do {							\
 	}						\
 } while (0)
 
+static void svm_32bit_build_pae_page_tables(u64 *pdpt)
+{
+	const u64 leaf_flags = PT_PRESENT_MASK | PT_WRITABLE_MASK | PT_PAGE_SIZE_MASK;
+	int i, j;
+
+	for (i = 0; i < 4; i++) {
+		u64 *pd = memalign_pages_flags(PAGE_SIZE, PAGE_SIZE,
+					       AREA_DMA32);
+		for (j = 0; j < 512; j++)
+			pd[j] = (((u64)i << 30) | ((u64)j << 21)) |
+				leaf_flags;
+		pdpt[i] = virt_to_phys(pd) | PT_PRESENT_MASK;
+	}
+}
+
+static void svm_pae_free_page_tables(u64 *pdpt)
+{
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		if (pdpt[i] & PT_PRESENT_MASK)
+			free_page(phys_to_virt(pdpt[i] & PT_ADDR_MASK));
+	}
+	free_page(pdpt);
+}
+
+static void svm_32bit_guest_init_common(u64 cr3, bool pae)
+{
+	struct guest_regs *regs = this_cpu_guest_regs();
+	struct vmcb_save_area *save = &vmcb->save;
+
+	/*
+	 * 32-bit code segment attribute:
+	 *   type=B (execute/read/accessed), S=1, DPL=0, P=1,
+	 *   L=0 (32-bit), D/B=1 (32-bit operand), G=1 (4K granularity).
+	 */
+	save->cs.attrib = 0xc9b;
+
+	save->efer &= ~(EFER_LMA | EFER_LME);
+	save->cr0 |= X86_CR0_PG | X86_CR0_PE;
+	save->cr4 &= ~(X86_CR4_PAE | X86_CR4_PSE);
+	save->cr4 |= pae ? X86_CR4_PAE : X86_CR4_PSE;
+	save->cr3 = cr3;
+	regs->rax = 0x123457678;
+}
+
 static void null_test(struct svm_test *test)
 {
 }
@@ -3676,6 +3722,144 @@ static void svm_unsupported_instruction_intercept_test(void)
 	}
 }
 
+/*
+ * 32-bit guest tests running a tiny guest in legacy 32-bit protected mode,
+ * with either 2-level (non-PAE) or 3-level (PAE) paging.  The guest code is
+ * in the low 4 GB and is identity-mapped using large pages.
+ */
+extern void hypercall_32bit_main(void);
+asm (".code32\n"
+     "hypercall_32bit_main:\n"
+     "vmmcall\n"
+     "jmp hypercall_32bit_main\n"
+     ".code64\n");
+
+static void __test_svm_guest_state(const char *test, u64 expected_exit,
+				   u64 field, const char *field_name)
+{
+	u64 got = __svm_vmrun((u64)hypercall_32bit_main);
+
+	report(got == expected_exit,
+	       "%s, %s = %lx (exit 0x%lx, wanted 0x%lx)",
+	       test, field_name, field, got, expected_exit);
+}
+
+/*
+ * xfail = false: VMRUN is expected to succeed and the guest to exit at
+ *                VMMCALL (exit code SVM_EXIT_VMMCALL).
+ * xfail = true:  VMRUN itself is expected to abort with SVM_EXIT_ERR.
+ */
+static void test_svm_guest_state(const char *test, bool xfail, u64 field,
+				 const char *field_name)
+{
+	__test_svm_guest_state(test, xfail ? SVM_EXIT_ERR : SVM_EXIT_VMMCALL,
+			       field, field_name);
+}
+
+static void test_svm_report_pass(void)
+{
+	u64 got = __svm_vmrun((u64)hypercall_32bit_main);
+
+	report(got == SVM_EXIT_VMMCALL,
+	       "VM-entry succeeded (exit 0x%lx, wanted 0x%x)",
+	       got, SVM_EXIT_VMMCALL);
+}
+/*
+ * Verify SVM's checks on guest PAE CR3 and PDPTEs.  PDPTEs are always
+ * loaded from memory at CR3, but when NPT is enabled SVM does not
+ * check PDPTE reserved bits at VMRUN and VMRUN is expected to succeed.
+ */
+static void test_svm_guest_pdptes(u64 cr3, u64 *pdpt)
+{
+	u64 orig;
+	int i, b;
+	bool npt = vmcb->control.nested_ctl & SVM_NESTED_ENABLE;
+
+	vmcb_set_intercept(INTERCEPT_EXCEPTION_OFFSET + PF_VECTOR);
+
+	/* Basic sanity: a clean PAE setup runs to VMMCALL. */
+	svm_32bit_guest_init_common(cr3, true);
+	test_svm_report_pass();
+
+	/* CR3 bits 4:0 are ignored in PAE mode. */
+	for (b = 0; b <= 4; b++) {
+		svm_32bit_guest_init_common(cr3 | (1ull << b), true);
+		test_svm_guest_state("CR3 ignored bit", false, (1ull << b), "bit");
+	}
+	for (b = cpuid_maxphyaddr(); b <= 63; b++) {
+		svm_32bit_guest_init_common(cr3 | (1ull << b), true);
+		test_svm_guest_state("CR3 reserved bit", true, (1ull << b), "bit");
+	}
+
+	for (i = 0; i < 4; i++) {
+		u64 reserved_exit;
+
+		/*
+		 * When a reserved bit is set in PDPTE0, the processor notices
+		 * but only when the guest walks through it to fetch its first
+		 * instruction.
+		 */
+		if (!npt)
+			reserved_exit = SVM_EXIT_ERR;
+		else if (i == 0)
+			reserved_exit = SVM_EXIT_EXCP_BASE + PF_VECTOR;
+		else
+			reserved_exit = SVM_EXIT_VMMCALL;
+
+		report_prefix_pushf("PDPTE%d", i);
+		orig = pdpt[i];
+
+		/*
+		 * Bits 62:52 of a PDPTE are reserved on VMX but are not
+		 * checked by SVM at VMRUN.  For PDPTE1..3 the guest does
+		 * not walk through the entry, so VMRUN succeeds and the
+		 * guest hits VMMCALL.  For PDPTE0 the guest faults at
+		 * instruction fetch and exits with #PF.
+		 */
+		for (b = 52; b <= 62; b++) {
+			pdpt[i] = orig | (1ull << b);
+			svm_32bit_guest_init_common(cr3, true);
+			__test_svm_guest_state("reserved bit", reserved_exit,
+					       (1ull << b), "bit");
+		}
+
+		/* Bits 11:9 of a PDPTE are ignored. */
+		for (b = 9; b <= 11; b++) {
+			pdpt[i] = orig | (1ull << b);
+			svm_32bit_guest_init_common(cr3, true);
+			test_svm_guest_state("ignored bit", false,
+					     (1ull << b), "bit");
+		}
+
+		pdpt[i] = orig;
+		report_prefix_pop();
+	}
+
+	vmcb_clear_intercept(INTERCEPT_EXCEPTION_OFFSET + PF_VECTOR);
+}
+
+/*
+ * Verify that VMRUN with PAE paging loads PDPTEs from memory at CR3, and
+ * that SVM does not check PDPTE reserved bits.
+ */
+static void svm_pae_test(void)
+{
+	u64 *pdpt;
+
+	vmcb_ident(vmcb);
+	pdpt = memalign_pages_flags(PAGE_SIZE, PAGE_SIZE, AREA_DMA32);
+	svm_32bit_build_pae_page_tables(pdpt);
+
+	/*
+	 * Unlike VMX (where the four PDPTEs are loaded from the VMCS when EPT is
+	 * enabled), SVM always loads the PAE PDPTEs from memory at guest CR3, so a
+	 * real PDPT is required even when NPT is enabled.
+	 */
+	test_svm_guest_pdptes(virt_to_phys(pdpt), pdpt);
+
+	svm_pae_free_page_tables(pdpt);
+}
+
 struct svm_test svm_tests[] = {
 	{ "null", default_supported, default_prepare,
 	  default_prepare_gif_clear, null_test,
@@ -3795,6 +3979,7 @@ struct svm_test svm_tests[] = {
 	{ "vgif", vgif_supported, prepare_vgif_enabled,
 	  default_prepare_gif_clear, test_vgif, vgif_finished,
 	  vgif_check },
+	TEST(svm_pae_test),
 	TEST(svm_cr4_osxsave_test),
 	TEST(svm_guest_state_test),
 	TEST(svm_vmrun_errata_test),
-- 
2.52.0


