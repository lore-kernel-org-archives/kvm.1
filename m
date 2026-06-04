Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA374478E39
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583167; cv=none; b=MYniuIMwLQZZH3BWVbb1a9MQ1OmLIwf5kxHhXYSFTFP6Cexyasl1kRHTAD3FOWGeUP4m9aW9AAbahGjT80cCK3QjqjAY/4QOo4paiYAUW0FsgXZIedV/obmXZc2fIKe5xLhus2L3nQwH1zJc0Pok6dUXbKHsIcefVnTG49AliPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583167; c=relaxed/simple;
	bh=QBabDb90ax4Am18/wU4W19GBXpKn4ysRfumImVN9GUA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvTUUKa9QzWqPdfsR952L80W81XUeUqFUfgdUSfQ8bHv8GVeHlYkl+/F3IGi+l2sIExf8mKt9l5JiUqpSDjX+JpoTK4Xqsao1x2miXX6IlisgZQwmk4fkww6vloKtaQs882JTL14GGGmrmNZgzBc8Nwj4l4xz5/qBXzdb2PBtqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXweVLa5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXweVLa5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780583165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H31dJ7SGMepuhopQJ8Gudj2TDcGi7o/eaCTL9QEYCAw=;
	b=ZXweVLa5enD2FNDGmoE3tbSk7nrFJByDNW6Z+JE5doo5Zw42Fq3ZpZVEFfJxieAwo/YDID
	LCUcT9xH1Vqfy8GlYDWb/DvRyx5RUQpwj+0+IXQIcz2bQ2Q/nydEVoBWqH1dz64OTsl/kw
	LN/wRQgbCNIhb6IKeiO5hnrplym4NoY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-kz3CVsyUOIOnSVQFa-je7w-1; Thu,
 04 Jun 2026 10:26:03 -0400
X-MC-Unique: kz3CVsyUOIOnSVQFa-je7w-1
X-Mimecast-MFC-AGG-ID: kz3CVsyUOIOnSVQFa-je7w_1780583162
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EB6A195608E
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:26:02 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 49C27180049F
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:26:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Subject: [PATCH kvm-unit-tests 1/4] vmx: add a test for 32-bit guest PAE paging PDPTEs
Date: Thu,  4 Jun 2026 10:25:58 -0400
Message-ID: <20260604142601.7440-2-pbonzini@redhat.com>
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

VMX tests are only running 64-bit guests.  Add a test that checks
the reserved and ignored bits in CR3 and PDPTEs for PAE mode.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/vmx.c       |  10 +++
 x86/vmx.h       |   1 +
 x86/vmx_tests.c | 186 +++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 194 insertions(+), 3 deletions(-)

diff --git a/x86/vmx.c b/x86/vmx.c
index 6a808d9e..99fc99e5 100644
--- a/x86/vmx.c
+++ b/x86/vmx.c
@@ -2016,6 +2016,16 @@ void enter_guest_with_bad_controls(void)
 	       VMXERR_ENTRY_INVALID_CONTROL_FIELD);
 }
 
+bool enter_guest_report_pass(void)
+{
+	struct vmentry_result result;
+
+	__enter_guest(ABORT_ON_EARLY_VMENTRY_FAIL |
+		      ABORT_ON_INVALID_GUEST_STATE, &result);
+	report(!result.vm_fail, "VM-entry succeeded");
+	return !result.vm_fail;
+}
+
 void enter_guest(void)
 {
 	struct vmentry_result result;
diff --git a/x86/vmx.h b/x86/vmx.h
index 098a5ef4..f27ecd72 100644
--- a/x86/vmx.h
+++ b/x86/vmx.h
@@ -991,6 +991,7 @@ void clear_ept_ad(unsigned long *pml4, u64 guest_cr3,
 
 void __enter_guest(u8 abort_flag, struct vmentry_result *result);
 void enter_guest(void);
+bool enter_guest_report_pass(void);
 void enter_guest_with_bad_controls(void);
 void hypercall(u32 hypercall_no);
 
diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index b018edee..5f2c2ca8 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -47,6 +47,8 @@ phys_addr_t pci_physaddr;
 void *pml_log;
 #define PML_INDEX 512
 
+static int setup_ept(bool enable_ad);
+
 static inline unsigned ffs(unsigned x)
 {
 	int pos = -1;
@@ -260,6 +262,79 @@ static int preemption_timer_exit_handler(union exit_reason exit_reason)
 	return VMX_TEST_VMEXIT;
 }
 
+/*
+ * Build identity-mapped page tables for a 32-bit guest covering the
+ * low 4 GB using PAE pages.  Fill the four PDPTRs into the pdpt[]
+ * array.
+ */
+static void vmx_32bit_build_pae_page_tables(u64 *pdpt)
+{
+	const u64 leaf_flags = PT_PRESENT_MASK | PT_WRITABLE_MASK |
+			       PT_PAGE_SIZE_MASK;
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
+static int vmx_32bit_guest_init_common(u64 cr3, u64 *pdpt)
+{
+	struct guest_regs *regs = this_cpu_guest_regs();
+	bool ept = (ctrl_cpu_rev[0].clr & CPU_SECONDARY) && (ctrl_cpu_rev[1].clr & CPU_EPT);
+	u64 cr0, cr4;
+	int i;
+
+	vmx_set_test_stage(0);
+
+	/* Disable IA-32e mode for the guest. */
+	vmcs_write(ENT_CONTROLS, vmcs_read(ENT_CONTROLS) & ~ENT_GUEST_64);
+	vmcs_write(GUEST_EFER,
+		   vmcs_read(GUEST_EFER) & ~(EFER_LMA | EFER_LME));
+
+	/*
+	 * 32-bit code segment access rights:
+	 *   type=B (execute/read/accessed), S=1, DPL=0, P=1,
+	 *   L=0 (32-bit), D/B=1 (32-bit operand), G=1 (4K granularity).
+	 */
+	vmcs_write(GUEST_AR_CS, 0xc09b);
+
+	cr0 = vmcs_read(GUEST_CR0) | X86_CR0_PG | X86_CR0_PE;
+	cr4 = vmcs_read(GUEST_CR4) & ~(X86_CR4_PCIDE | X86_CR4_PAE | X86_CR4_PSE);
+	cr4 |= pdpt ? X86_CR4_PAE : X86_CR4_PSE;
+	vmcs_write(GUEST_CR0, cr0);
+	vmcs_write(GUEST_CR4, cr4);
+	vmcs_write(GUEST_CR3, cr3);
+
+	if (pdpt && ept) {
+		for (i = 0; i < 4; i++)
+			vmcs_write(GUEST_PDPTE + 2 * i, pdpt[i]);
+	}
+
+	regs->rax = 0x123457678;
+
+	return VMX_TEST_START;
+}
+
+static void vmx_pae_free_page_tables_cb(void *pdpt_)
+{
+	u64 *pdpt = pdpt_;
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		u64 pdpte = pdpt ? pdpt[i] : vmcs_read(GUEST_PDPTE + 2 * i);
+		if (pdpte & PT_PRESENT_MASK)
+			free_page(phys_to_virt(pdpte & PT_ADDR_MASK));
+	}
+	if (pdpt)
+		free_page(pdpt);
+}
+
 static void msr_bmp_init(void)
 {
 	void *msr_bitmap;
@@ -5721,8 +5796,8 @@ static void guest_state_test_main(void)
 	asm volatile("fnop");
 }
 
-static void test_guest_state(const char *test, bool xfail, u64 field,
-			     const char * field_name)
+static void __test_guest_state(const char *test, bool xfail, u64 field,
+			       const char *field_name, u64 expected_qual)
 {
 	struct vmentry_result result;
 	u8 abort_flags;
@@ -5736,13 +5811,117 @@ static void test_guest_state(const char *test, bool xfail, u64 field,
 	report(result.exit_reason.failed_vmentry == xfail &&
 	       ((xfail && result.exit_reason.basic == VMX_FAIL_STATE) ||
 	        (!xfail && result.exit_reason.basic == VMX_VMCALL)) &&
-		(!xfail || vmcs_read(EXI_QUALIFICATION) == ENTRY_FAIL_DEFAULT),
+		(!xfail || vmcs_read(EXI_QUALIFICATION) == expected_qual),
 	        "%s, %s = %lx", test, field_name, field);
 
 	if (!result.exit_reason.failed_vmentry)
 		skip_exit_insn();
 }
 
+static void test_guest_state(const char *test, bool xfail, u64 field,
+			     const char *field_name)
+{
+	__test_guest_state(test, xfail, field, field_name, ENTRY_FAIL_DEFAULT);
+}
+
+extern void hypercall_32bit_main(void);
+asm (".code32\n"
+	"hypercall_32bit_main:\n"
+	"vmcall\n"
+	"jmp hypercall_32bit_main\n"
+	".code64\n");
+
+static void v2_hypercall_test_guest(void)
+{
+	/* Enter until the first vmcall, then RIP will move to 32-bit code.  */
+	vmcall();
+}
+
+static void test_setup_32bit(void)
+{
+	test_set_guest(v2_hypercall_test_guest);
+	enter_guest();
+	skip_exit_vmcall();
+	vmcs_write(GUEST_RIP, (unsigned long)hypercall_32bit_main);
+}
+
+/*
+ * Verify that VM entry with PAE paging checks the PDPTEs.
+ */
+static void test_vmx_guest_pdptes(u64 cr3, u64 *pdpt)
+{
+	u64 guest_efer = vmcs_read(GUEST_EFER);
+	u64 orig;
+	int i, b;
+
+	vmx_32bit_guest_init_common(cr3, pdpt);
+	if (enter_guest_report_pass())
+		skip_exit_vmcall();
+
+	for (b = 0; b <= 4; b++) {
+		vmx_32bit_guest_init_common(cr3 | (1ull << b), pdpt);
+		test_guest_state("CR3 ignored bit", false, (1ull << b), "bit");
+	}
+
+	for (b = cpuid_maxphyaddr(); b < 64; b++) {
+		vmx_32bit_guest_init_common(cr3 | (1ull << b), pdpt);
+		test_guest_state("CR3 reserved bit", true, (1ull << b), "bit");
+	}
+
+	for (i = 0; i < 4; i++) {
+		report_prefix_pushf("PDPTE%d", i);
+		orig = pdpt[i];
+		for (b = 52; b <= 63; b++) {
+			if (b == 63)
+				vmcs_write(GUEST_EFER, guest_efer & ~EFER_NX);
+			pdpt[i] = orig | (1ull << b);
+			vmx_32bit_guest_init_common(cr3, pdpt);
+			__test_guest_state("reserved bit", true, (1ull << b), "bit",
+					   ENTRY_FAIL_PDPTE);
+			if (b == 63)
+				vmcs_write(GUEST_EFER, guest_efer);
+		}
+		for (b = 9; b <= 11; b++) {
+			pdpt[i] = orig | (1ull << b);
+			vmx_32bit_guest_init_common(cr3, pdpt);
+			test_guest_state("ignored bit", false, (1ull << b), "bit");
+		}
+		pdpt[i] = orig;
+
+		report_prefix_pop();
+	}
+}
+
+static void vmx_pae_test(void)
+{
+	u64 pdpt[4];
+	u64 *pdpt_mem;
+
+	test_setup_32bit();
+
+	/* EPT disabled: PDPTEs are loaded from memory pointed to by CR3. */
+	report_prefix_push("PDPTEs from CR3");
+	pdpt_mem = memalign_pages_flags(PAGE_SIZE, PAGE_SIZE, AREA_DMA32);
+	vmx_32bit_build_pae_page_tables(pdpt_mem);
+	test_vmx_guest_pdptes(virt_to_phys(pdpt_mem), pdpt_mem);
+	vmx_pae_free_page_tables_cb(pdpt_mem);
+	report_prefix_pop();
+
+	/* EPT enabled: PDPTEs are loaded from the VMCS. */
+	if (!(ctrl_cpu_rev[0].clr & CPU_SECONDARY) ||
+	    !(ctrl_cpu_rev[1].clr & CPU_EPT) || setup_ept(false)) {
+		report_skip("EPT not supported, skipping PDPTEs from VMCS test");
+	} else {
+		report_prefix_push("PDPTEs from VMCS");
+		vmx_32bit_build_pae_page_tables(pdpt);
+		test_vmx_guest_pdptes(0x01234560, pdpt);
+		vmx_pae_free_page_tables_cb(NULL);
+		report_prefix_pop();
+	}
+
+	test_set_guest_finished();
+}
+
 /*
  * Tests for VM-entry control fields
  */
@@ -11937,6 +12116,7 @@ struct vmx_test vmx_tests[] = {
 	TEST(rdtsc_vmexit_diff_test),
 	TEST(vmx_mtf_test),
 	TEST(vmx_mtf_pdpte_test),
+	TEST(vmx_pae_test),
 	TEST(vmx_pf_exception_test),
 	TEST(vmx_pf_exception_forced_emulation_test),
 	TEST(vmx_pf_no_vpid_test),
-- 
2.52.0


