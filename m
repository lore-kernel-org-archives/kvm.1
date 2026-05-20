Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BEF3EEAF2
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289114; cv=none; b=jedO6ECCHv2auKFhBLOgqlCbhk8l5gLSJ3kqOeRQ8nokXxS1UhPbv9sUF4HHfSNRS5tC9b6YPRVROZzUxSmqZ1qQ2a2Rf2xVG0oI3lB+8tsoPt2RO0uMxj2++h5NRhjlqiAMG70dpHsRk2OAPQHdiCUre67oJBsnTD82wWlYnuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289114; c=relaxed/simple;
	bh=fJR9pvmVxBaW8YLdPrfJembPym1hAXQKAPLyotjW2LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgtRTjVdpifPXeEBS2XljLiZdYLI9oq8grXrRjdfJd8pNRw3rG0hdIpyy0IldKGf8XNhL6Ui2lQf/LWjK7MGIzVMM8oJXLRkRV8R3Mw1VoU6s/JaaIP4PLmcHWI+sHqYuTQd2xy8JfEg+3LDRswwISIxzo8SYMN0G377S39eYGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NI21OKmw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQLn9h9U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NI21OKmw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQLn9h9U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779289112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WAdC0vm4gDjwplgt2fep5ZW8VMhuUZMrG3InZRb9IrA=;
	b=NI21OKmwRIMezqjSaPgEgSebIuNxZjYE8yyTxQJTslIFwHaEkZAUVrEvN4W7yf4Ec2nadt
	Nrl6lxOy5tXGM77kkPoH6GW8RRcvrDK5T0C+mqOacSF56wUJgiR1KTVGNPoUrpkyi27F+n
	ucY3vzClBOfzKk+eKxI/mg8snSBTm7c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-epIVRGxMMm2eDXUd7lUcrg-1; Wed, 20 May 2026 10:58:29 -0400
X-MC-Unique: epIVRGxMMm2eDXUd7lUcrg-1
X-Mimecast-MFC-AGG-ID: epIVRGxMMm2eDXUd7lUcrg_1779289108
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45e78dd7baaso3721693f8f.0
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 07:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779289107; x=1779893907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAdC0vm4gDjwplgt2fep5ZW8VMhuUZMrG3InZRb9IrA=;
        b=RQLn9h9UJpTEEydN8DE/CGuyYnHDr+SJs09nvbUVtEwrt/QRN4+kbDJdFIoDRlqMo5
         GgSnQwSDJyWjVxHSkslY801snR+EaOP57e17oPlrGCKhKDlermfi0ELQ85panV7JAoDV
         RTpyD6W+TpgSXxKIDZdrDE/ZUEDwIysSJ5A6ViE04W1SWc8HoZZosD54I8JnVfnNVorh
         GTq4ZksSL6bcLHZcUBQakdAxvGeP5sYZ+vCxo0iwjwkLImFlaihi1NUKc6V3Vo0F/W2E
         onuFMTCgGeW3231KW4jAROBPoIe2SqgRdt+D31GPQcgevQS+ecy1X8IzM5aq0h+48QKb
         pxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779289107; x=1779893907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WAdC0vm4gDjwplgt2fep5ZW8VMhuUZMrG3InZRb9IrA=;
        b=V/t41zFE1fbkjaQnSrTyXLbnCIWE2BB0YYj9WXC1ct2QVuWf5O24cWhqlXtY/nqMjp
         IpQegj3aC7C3LtHRvjSw3+AM9gBDGDjz8LjTEoPFMr0itgUFAYwVl65HloJKA3kq0mXs
         rEE4xRDPuTuYrCHt6X6fo596HCHfJVjeBLhbp1twdZJT0O10OelStWtaEVw9LLDfREPa
         hErxJilXIbCy92f2vptlSPoDPcMfPD+9GZtZEHdfPRkmM4NDdclTOSTWo7uKkXPauZzs
         hucfGa6Nl0W88FbbphBfo6k97xRTz28uDPBA46lcDXbf/OLR15MEq1lURrnZI04PizXD
         kcyQ==
X-Gm-Message-State: AOJu0YxrWFJkjuS6r9YYUft5YOZxkUhtXJDJQBU/hpysboJKg2oUn/SJ
	OrWioxE29ka+VOAm7FTxS11CCPK6DHasEsOm+e22qv43kvduNTHT6LsLqLicXcObeQCGZusagSF
	0FoGGlq7sGqlj5oPYiVQDRkv8g43ZVPXrX9Xy5BWMGMNqDukKp8BCWYRS5CnOO9urhNfFiO2btZ
	10WOu60jY0YEr30GFCIlu3HNB4ZvdoPyP0fnL7sZDj
X-Gm-Gg: Acq92OGk4pWs/xXWJPOtBzX8YKdc2Pm0Po1i2Mjp/pgYVkRtlBw0kw1OqBHpJZSp1Ha
	NxMJbMDym66MhCw7xVjINoT+uBPnILH3FxfhHgHeayv2d1b4d4FTvcJ3k49w7+boeneoEZ0wuNt
	L1kK75/yX+8NOD82wBVR/fHLgbWPzfLi7FvlrmFr/vVWbvo6FEfjJTkPoNxyHVvt97ojbB8/8Q7
	lb8VuZuuUv1s7mjhO13A1qXVB3/UUuFLJoaelveLUeL4Aaki9y6DLGioxHI8LePqpOSWLJrOQQN
	fGWuIbuD1YN6vcFaLSijxKSSfsQ2bE+F7hxWM95O5otISmZq0q/laQ5cnztqZ5f+VJUP1CsjkzR
	kZyORm+iTFAHaU9GtTDHxr0kMViR5kpFSWqhfG/qeukVc8enJSD8zKJqNlJL6h8qnvhw6W4cvZf
	1ATLa27yMh2AbaIPa/Vtd5dHfN5r4UETVDhA==
X-Received: by 2002:a05:6000:2304:b0:448:e182:b7ae with SMTP id ffacd0b85a97d-45e5c5b391cmr40128506f8f.7.1779289107432;
        Wed, 20 May 2026 07:58:27 -0700 (PDT)
X-Received: by 2002:a05:6000:2304:b0:448:e182:b7ae with SMTP id ffacd0b85a97d-45e5c5b391cmr40128447f8f.7.1779289106837;
        Wed, 20 May 2026 07:58:26 -0700 (PDT)
Received: from [10.110.4.204] ([87.215.26.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe2464sm55609206f8f.32.2026.05.20.07.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:58:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: mlevitsk@redhat.com
Subject: [PATCH kvm-unit-tests 1/5] vmx: add test for 32-bit guest
Date: Wed, 20 May 2026 16:58:19 +0200
Message-ID: <20260520145823.408884-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520145823.408884-1-pbonzini@redhat.com>
References: <20260520145823.408884-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple test that runs a 32-bit code segment with two-level page tables.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/vmx_tests.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index ff387ded..8ea60235 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -46,6 +46,8 @@ phys_addr_t pci_physaddr;
 void *pml_log;
 #define PML_INDEX 512
 
+static int setup_ept(bool enable_ad);
+
 static inline unsigned ffs(unsigned x)
 {
 	int pos = -1;
@@ -258,6 +260,121 @@ static int preemption_timer_exit_handler(union exit_reason exit_reason)
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
+	regs.rax = 0x123457678;
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
+	u64 guest_rip = vmcs_read(GUEST_RIP);
+	u32 insn_len = vmcs_read(EXI_INST_LEN);
+
+	switch (exit_reason.basic) {
+	case VMX_VMCALL:
+		switch (vmx_get_test_stage()) {
+		case 0:
+			report(regs.rax == 1, "32-bit guest first VMCALL");
+			vmx_set_test_stage(1);
+			vmcs_write(GUEST_RIP, guest_rip + insn_len);
+			return VMX_TEST_RESUME;
+		case 1:
+			report(regs.rax == 2, "32-bit guest second VMCALL");
+			return VMX_TEST_VMEXIT;
+		default:
+			report_fail("Unexpected stage %d",
+				    vmx_get_test_stage());
+			break;
+		}
+		break;
+	default:
+		report_fail("32-bit guest: unexpected exit reason 0x%x",
+			    exit_reason.full);
+		print_vmexit_info(exit_reason);
+		break;
+	}
+	return VMX_TEST_VMEXIT;
+}
+
 static void msr_bmp_init(void)
 {
 	void *msr_bitmap;
@@ -11763,6 +11880,8 @@ struct vmx_test vmx_tests[] = {
 	{ "vmenter", NULL, vmenter_main, vmenter_exit_handler, NULL, {0} },
 	{ "preemption timer", preemption_timer_init, preemption_timer_main,
 		preemption_timer_exit_handler, NULL, {0} },
+	{ "32-bit guest 2-level paging", vmx_32bit_guest_init,
+		vmx_32bit_guest_main, vmx_32bit_guest_exit_handler, NULL, {0} },
 	{ "control field PAT", test_ctrl_pat_init, test_ctrl_pat_main,
 		test_ctrl_pat_exit_handler, NULL, {0} },
 	{ "control field EFER", test_ctrl_efer_init, test_ctrl_efer_main,
-- 
2.54.0

