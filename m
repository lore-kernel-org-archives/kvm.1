Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C844738239A
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358655; cv=none; b=iWwgeyGANXspe9FKbR5V5E0JOglMMESJBWCPOGtraDkqYxlK1xjeTcpW5a5cNXFCX8r/THtdEPMpnVjZK9aa+4hodnAB8ejvrwDPxKT11CC9zv64oDAG85A5pWnrAAsYuGpycPR7ieDJiH4umGSBKKrFjtq+MPv9JlT+cdLwqLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358655; c=relaxed/simple;
	bh=26sBP25+GDgg0VCLaC81q6kAgKo+ln1inbqslyPb5WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctBwa8nGDvcZEbeHpXYW28+lUec6IhwZAK0oZ5lNFC8ECTV+XODqwME2VJWExpXM/DKHno940CULpqDTfPWjckf5XClE6gU3nY7bsjTE59c4YDazr1D2pEFj03RUoddTubnVW7bXUggXzvUbgtQfgybK8FgFDMsHoGiV/NX68Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GULuNyza; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFSBcfKX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GULuNyza";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFSBcfKX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779358653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uGrih9sXZ22HeqbNAXL4SXX+GceqfMwQUju7QK8GZBc=;
	b=GULuNyzaw37NS2MpCyPz1PmjpgAlT//Xq490v4QkPOUUV0wFnHop/psOAS86k8Ksxhkybs
	ZBhr0+lng6X+DHL3cLynTZ04qP+6EPrKRdFVgxefVq4OeM+RrollWJoG3VIL4X7fFfgoGQ
	XPWfj5aT2VU2gwcUirdgnStATSHX50A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-Kw_R-AbQN0yBhUn9OUxzsg-1; Thu, 21 May 2026 06:17:29 -0400
X-MC-Unique: Kw_R-AbQN0yBhUn9OUxzsg-1
X-Mimecast-MFC-AGG-ID: Kw_R-AbQN0yBhUn9OUxzsg_1779358648
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-bdaf3ed080dso190061066b.0
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 03:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779358648; x=1779963448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGrih9sXZ22HeqbNAXL4SXX+GceqfMwQUju7QK8GZBc=;
        b=CFSBcfKXWnvjnySMrweKDx3yvrdD1mCA8vFoi1YhQAl1ShZDzUETNyJvhby/WzrCkO
         xS+HYt3lVBy48jQwKC8cSENDy7CN29fLoTX7wIK/Hz63rD5n847GlBh7V3VwMiHGueq3
         Krz0xQGno6tz8B8EMEEy8+rvC2E0qK+vi6cImd3pteeJ9VuUgW1N0AZzhUUdIhaa/jw0
         DKnSr0FFjF4vmC9DaLuUqEJ1tpGMFnxitLqA4JqL9NhBeA6pkGKXMqzvDAYUWUWLNYDf
         lA6XRmJLgjzFpYP4xBn6WPy4vBQxOSxm3GJsNYhfsHLZIWEzxVBFW2oBPHtnkBsV2Qn5
         q66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779358648; x=1779963448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uGrih9sXZ22HeqbNAXL4SXX+GceqfMwQUju7QK8GZBc=;
        b=bW4pU+faeCHgFdaPMr1qXo+3VkxslV0seR83CPyXB9fkaR5bZQvAsyYVwW6tr67Ev9
         hGYHTRTL5hRoVXQMa5mg7KVwc8vJZ7obwlX6tdUpQYYrNhS4T0bsbQ5QtOKTVrX6fqC2
         RI6FCPEk2/fox0347ktWNj9M4Sg3u2xkFQ94THiZoWR60jofFU7DhzLZUKBhLwUYNkCJ
         kSQWvUUuOU4J1dwVp/15Z39IhljZ90cUUmz+7gaYyaFtyHkrQWoie6qhti1Ef0ohAyQT
         /2KwsfF2IyvVLNkIlSKlgjzHgzRLn09YjX9fc237qjTFojAv8erVglpbn5W7QgRASb7T
         kKLA==
X-Gm-Message-State: AOJu0YzvSDwj7dX4PCN7gP3iL2wE3W6wBGEZ/Lfi1kwc+kZTsWn9psYo
	VahZyI9IRfas24UWLo/Y7ASZPs9RnXbjImvTdMhDQMAlBRqfsov1fiERcZ8qMfCwBC9cfOYfOlm
	O3AuFbNEFgaM9VMNUukyL1pLQt5r2qCp9JaMCWInsxwKx7GInNXeFSmTqvxFCzBxWteLlCLRMFh
	xqNnhS4SkS6t8i/JiWcHXN1rTE/51kMJGn8MUEDvnR
X-Gm-Gg: Acq92OEwytzq/4bIFDNaItYAa2cuMfq/zlWMwlyHohduyFRpJb3BA0NF9zh7X8XtpEm
	Z+40kRNQUhfY4f/V6eFW8Uj4RMjolmhH9OtMm8G7LAeVwGtSWMbp9J5hfjyeWPK2yU23h4ts0og
	LPOEum8cjLrJ5oyczC3yLOfiUyg6pzshH+UZXHvOr1GxqDCLiw3+6mJfbwBWwAGrHKpr1Edgv69
	F+Jfy2+OEqLy07s9VqZqhTQEJNKOCai7LV9K2w3kKVoFB82RPrno/cCk3BcnK0CLbLYIh1zcR2n
	1usHD0xVbf5JVDmB+nRUCXQJKiU11hSzPXxGBBQeW+Wb0N4uMJ6dokO6/0GZ+WCnQqY9SI46Gwr
	GWG4N12CQL5dGYp85dLcseDAbdNxUnNYLs5VT8LeRJhOVo7qUthzMRaP4HQxV4BjwptrHSImMlE
	BpzZWe2tojT0N1ctpo2eIPVl5Btw==
X-Received: by 2002:a17:907:808:b0:bd5:40d9:c6c9 with SMTP id a640c23a62f3a-bdc100d5df8mr123192766b.0.1779358647850;
        Thu, 21 May 2026 03:17:27 -0700 (PDT)
X-Received: by 2002:a17:907:808:b0:bd5:40d9:c6c9 with SMTP id a640c23a62f3a-bdc100d5df8mr123190466b.0.1779358647352;
        Thu, 21 May 2026 03:17:27 -0700 (PDT)
Received: from [172.101.1.88] ([185.48.102.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8aa03d78sm26471566b.44.2026.05.21.03.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 03:17:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: mlevitsk@redhat.com
Subject: [PATCH kvm-unit-tests 1/4] vmx: add test for 32-bit guest
Date: Thu, 21 May 2026 12:17:20 +0200
Message-ID: <20260521101723.101100-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521101723.101100-1-pbonzini@redhat.com>
References: <20260521101723.101100-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/vmx_tests.c | 125 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index ac0250b7..18f0d8ef 100644
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
@@ -260,6 +262,127 @@ static int preemption_timer_exit_handler(union exit_reason exit_reason)
 	return VMX_TEST_VMEXIT;
 }
 
+/*
+ * 32-bit guest tests running a tiny guest in 32-bit protected mode with
+ * paging enabled.
+ */
+extern char vmx_32bit_guest_begin[];
+
+asm(".code32\n\t"
+    "vmx_32bit_guest_begin:\n\t"
+    "	mov $1, %eax\n\t"
+    "	vmcall\n\t"
+    "	mov $2, %eax\n\t"
+    "	vmcall\n\t"
+    "1:	jmp 1b\n\t"
+    ".code64\n\t");
+
+/*
+ * Build identity-mapped page tables for a 32-bit guest covering the
+ * low 4 GB using 4GB pages, returns the value to load into GUEST_CR3.
+ */
+static u64 vmx_32bit_build_page_tables(void)
+{
+	const u64 leaf_flags = PT_PRESENT_MASK | PT_WRITABLE_MASK |
+			       PT_PAGE_SIZE_MASK;
+	int i;
+
+	u32 *pd = memalign_pages_flags(PAGE_SIZE, PAGE_SIZE,
+				       AREA_DMA32);
+	for (i = 0; i < 1024; i++)
+		pd[i] = ((u32)i << 22) | leaf_flags;
+	return virt_to_phys(pd);
+}
+
+static int vmx_32bit_guest_init_common(u64 cr3)
+{
+	struct guest_regs *regs = this_cpu_guest_regs();
+	u64 cr0, cr4;
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
+	cr4 |= X86_CR4_PSE;
+	vmcs_write(GUEST_CR0, cr0);
+	vmcs_write(GUEST_CR4, cr4);
+	vmcs_write(GUEST_CR3, cr3);
+
+	vmcs_write(GUEST_RIP, (u64)(uintptr_t)vmx_32bit_guest_begin);
+	regs->rax = 0x123457678;
+
+	return VMX_TEST_START;
+}
+
+static void vmx_32bit_free_page_tables_cb(void *pd)
+{
+	free_page(pd);
+}
+
+static int vmx_32bit_guest_init(struct vmcs *vmcs)
+{
+	u64 cr3 = vmx_32bit_build_page_tables();
+
+	if ((ctrl_cpu_rev[0].clr & CPU_SECONDARY) && (ctrl_cpu_rev[1].clr & CPU_EPT))
+		setup_ept(false);
+
+	test_add_teardown(vmx_32bit_free_page_tables_cb, phys_to_virt(cr3));
+	return vmx_32bit_guest_init_common(cr3);
+}
+
+static void vmx_32bit_guest_main(void)
+{
+	/* Unused: GUEST_RIP is overridden by the init function. */
+}
+
+static int vmx_32bit_guest_exit_handler(union exit_reason exit_reason)
+{
+	struct guest_regs *regs = this_cpu_guest_regs();
+	u64 guest_rip = vmcs_read(GUEST_RIP);
+	u32 insn_len = vmcs_read(EXI_INST_LEN);
+
+	switch (exit_reason.basic) {
+	case VMX_VMCALL:
+		switch (vmx_get_test_stage()) {
+		case 0:
+			report(regs->rax == 1, "32-bit guest first VMCALL");
+			if (regs->rax != 1)
+				return VMX_TEST_VMABORT;
+
+			vmx_set_test_stage(1);
+			vmcs_write(GUEST_RIP, guest_rip + insn_len);
+			return VMX_TEST_RESUME;
+		case 1:
+			report(regs->rax == 2, "32-bit guest second VMCALL");
+			if (regs->rax != 2)
+				return VMX_TEST_VMABORT;
+			return VMX_TEST_VMEXIT;
+		default:
+			report_fail("Unexpected stage %d",
+				    vmx_get_test_stage());
+			return VMX_TEST_VMABORT;
+		}
+		break;
+	default:
+		report_fail("32-bit guest: unexpected exit reason 0x%x",
+			    exit_reason.full);
+		print_vmexit_info(exit_reason);
+		return VMX_TEST_VMABORT;
+	}
+}
+
 static void msr_bmp_init(void)
 {
 	void *msr_bitmap;
@@ -11800,6 +11923,8 @@ struct vmx_test vmx_tests[] = {
 	{ "vmenter", NULL, vmenter_main, vmenter_exit_handler, },
 	{ "preemption timer", preemption_timer_init, preemption_timer_main,
 		preemption_timer_exit_handler },
+	{ "32-bit guest 2-level paging", vmx_32bit_guest_init,
+		vmx_32bit_guest_main, vmx_32bit_guest_exit_handler },
 	{ "control field PAT", test_ctrl_pat_init, test_ctrl_pat_main,
 		test_ctrl_pat_exit_handler },
 	{ "control field EFER", test_ctrl_efer_init, test_ctrl_efer_main,
-- 
2.54.0

