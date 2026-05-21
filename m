Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F1239A054
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358659; cv=none; b=jysH8D0uySsgGqp8JaXIixXMeRBrfY7QoVOUQatCtcC15LqSEdXO/+u0p9IcCLc2WdOr/UAdMzrTRRLOBzbCHKLfaeIGgTl1kcvIPAMX7SID6Ky+Ay1kzfVLyXptIrDSCOWvS7vPDZZW00R+UHWddxVccCyjCwmD8x1uEE+xl60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358659; c=relaxed/simple;
	bh=H7wdoU0HZQBLGhB/Xh2krJuD4JABMsdKelJodR6lEg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8/cTC666d4NXuDkFPPcdfHAoIMa5NlwtRuhNh4uhZKdg1weVtJ/QBHFS7wzSWirYz90ETf0YdN1Thnm0wydfiu80XSU8v+p9YYpE6yz62akBaLa18az0/jjXTTpRnRhWDuApVzaHxaRXy5Pj9up3b1xlGyE0uqjyz12MWmguc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ze/g49Ui; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gX3o/tSC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ze/g49Ui";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gX3o/tSC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779358656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HQ/NGa+l8UGKu5duXWnVfJxMGlnwC1VfqfUgSOCW+Vg=;
	b=Ze/g49UiFqWdyD5HvBv/dKT7U01kXIsMVnKsq8THzv3qTv2eA3+xrbbojTPmb4N07k5yra
	mMQ5spZusV35h1Q2OXyBYaEcs7Fa08zJKEyB+tHuA9RsjI3vmneTrh0nE/lApeCnN6/9oO
	K5K7HcxqPjfWNV0t9mD9CLZARuo2M50=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-t-DYclVhPgW6si6kdD1bMA-1; Thu, 21 May 2026 06:17:32 -0400
X-MC-Unique: t-DYclVhPgW6si6kdD1bMA-1
X-Mimecast-MFC-AGG-ID: t-DYclVhPgW6si6kdD1bMA_1779358651
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-bd68244c455so426890966b.2
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779358651; x=1779963451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQ/NGa+l8UGKu5duXWnVfJxMGlnwC1VfqfUgSOCW+Vg=;
        b=gX3o/tSCQAvqGD0g8zKJdPFO5BmhvEvGRAyB3M76iw5Q4ElO4hJCtWzlkDRFnmPZ7d
         Yh/CmJaCVlQuG+3zenG3j5f+DJeAYfwcpN0hUQMfFXxtxOBTAKb4GOI1SEIteJedu5Ny
         Y/mnmMqUkIfDBAoCJBcq1amPuvUUYot8Jikf4gh3RDkVm04JxjLKbyUkuTu4omHHx7wl
         ejVt4SDr/c3UerzNrBWpm63p48o36S6PqhQ/rk7fJTNRy1ByTj/dWcDO83xYKt8sFpfm
         BpG7uEaS6l+4uWPSrwnwyEE6zgS/8W4CWE8WYmLUgbkWkDqaHGz2U3tEB7+hyrFbuMya
         oB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779358651; x=1779963451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HQ/NGa+l8UGKu5duXWnVfJxMGlnwC1VfqfUgSOCW+Vg=;
        b=IPPuSiX93IDRhBZXSXJQX4JEqJ8H7wIooXuEyQkyBOK8WI4KHZRgdnly3ww/xOlS3f
         /oF+j7topPsX88yQy0QJBCCj3aCGmfyv1I2LcneoJMTglIt1ttzI6wzxjlUMC648Mbsq
         ucvRapJw/BEmC00bWchJzqINEReXqirryIQ4ZSQndAwsSXzOnoRyCclArxRxiNCSvV1p
         ELdmZywMdfSRkaA+Y4KfQcloWdtuwbuOAfLMEdC0xkLee6XnY2UjAQNl3sZf2AqSXklB
         /9VODCQjbDXbfXKhatJMj248f0EEVO0A9gNuTq7l90wOFkiNKybQT2l77zny/MN3/xiB
         U+Xg==
X-Gm-Message-State: AOJu0YwoI8NKepQENfwbT8PaAmJ/g6NK+E33JH1Yf64j5+O0ujWPsTGR
	6rq3ST4kexZeH3Ar12iWeN7wvanT4nNA2L+Jaz9gWBLH3/vXeEjvV1d6zlYemGi9PVWmxIX3CWQ
	oLcKml0o1znA3JXd+NrwuIz4P6avxDKSia+rTVqvukywjUHwdnab/q5fm+QbvQT//VnVK4Zxl7/
	S5ySM5y9GB0Vih7aDS6dq1yDApP43Y/OYKOaPmU/WE
X-Gm-Gg: Acq92OGqXOdrdy2N9wWQPARC4syr8ZAGKUf+VH9SKkrtBDfR8wKoUZqwo5unIc90a13
	aA9yhd2lX6zBlPK1drgLqRr4uBYPRh5fOus/NFJyhLejKT3vv6bl+dZSZzeoscURkJInudHiNza
	qnq2gQ9o+lrSQlq4KqC8LrE1Qu0DAWCEm7YziSdizb6YydaU/9lLKlQRZNuMogQldvEAFK9MhGy
	/aO4gW9g+dkjmfinYCei1STOv6UErKrO243gFBpBQuIRz02VAY+IYXXdqoM+NYDy2CPEyCiT59S
	rRt3aeBRBCKbgd7JyA482iuQ7tw4WKRQMjwe5nbOhNUPfrQDxTFM6MPC1E0seRHqXBi0KoA9vpN
	C9ipnmnztOTtBfjPe9cRVNmzxZOKDU7y7peLX5uQDFisVk66EndYXcystWlYdOdvaVuvWQofyOd
	8Y9ttrph6Y8u/1QxQZKu+l8x2d1A==
X-Received: by 2002:a17:907:2daa:b0:bd4:f814:dbbe with SMTP id a640c23a62f3a-bdc1356d929mr115417466b.19.1779358651244;
        Thu, 21 May 2026 03:17:31 -0700 (PDT)
X-Received: by 2002:a17:907:2daa:b0:bd4:f814:dbbe with SMTP id a640c23a62f3a-bdc1356d929mr115415566b.19.1779358650662;
        Thu, 21 May 2026 03:17:30 -0700 (PDT)
Received: from [172.101.1.88] ([185.48.102.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8aa02ee8sm25653666b.43.2026.05.21.03.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 03:17:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: mlevitsk@redhat.com
Subject: [PATCH kvm-unit-tests 3/4] svm: add test for 32-bit guest
Date: Thu, 21 May 2026 12:17:22 +0200
Message-ID: <20260521101723.101100-4-pbonzini@redhat.com>
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
 x86/svm_tests.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index b77ef984..0afeff48 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -770,6 +770,123 @@ static bool check_mode_switch(struct svm_test *test)
 	return test->scratch == 2;
 }
 
+/*
+ * 32-bit guest tests.  These tests run a tiny guest in legacy 32-bit
+ * protected mode, with either 2-level (non-PAE) or 3-level (PAE) paging.
+ * The guest code is in the low 4 GB and is identity-mapped using large
+ * pages.  The guest issues a few VMMCALLs and then spins; since no
+ * interrupts are taken, the rest of the address space need not be mapped.
+ *
+ * Unlike VMX (where the four PDPTEs are loaded from the VMCS when EPT is
+ * enabled), SVM always loads the PAE PDPTEs from memory at guest CR3, so
+ * a real PDPT is required even when NPT is enabled.
+ */
+extern char svm_32bit_guest_begin[];
+
+asm(".code32\n\t"
+    "svm_32bit_guest_begin:\n\t"
+    "        mov $1, %eax\n\t"
+    "        vmmcall\n\t"
+    "        mov $2, %eax\n\t"
+    "        vmmcall\n\t"
+    "1:      jmp 1b\n\t"
+    ".code64\n\t");
+
+static u64 svm_32bit_build_page_tables(void)
+{
+	const u64 leaf_flags = PT_PRESENT_MASK | PT_WRITABLE_MASK | PT_PAGE_SIZE_MASK;
+	u32 *pd = memalign_pages_flags(PAGE_SIZE, PAGE_SIZE, AREA_DMA32);
+	int i;
+
+	for (i = 0; i < 1024; i++)
+		pd[i] = ((u32)i << 22) | leaf_flags;
+	return virt_to_phys(pd);
+}
+
+static void svm_32bit_guest_prepare_common(struct svm_test *test, u64 cr3)
+{
+	struct guest_regs *regs = this_cpu_guest_regs();
+	struct vmcb_save_area *save = &vmcb->save;
+
+	vmcb_ident(vmcb);
+	test->scratch = 0;
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
+	save->cr4 &= ~X86_CR4_PAE;
+	save->cr4 |= X86_CR4_PSE;
+	save->cr3 = cr3;
+	regs->rax = 0x123457678;
+}
+
+static void svm_32bit_guest_prepare(struct svm_test *test)
+{
+	u64 cr3 = svm_32bit_build_page_tables();
+
+	svm_32bit_guest_prepare_common(test, cr3);
+}
+
+static void svm_32bit_guest_prepare_gif_clear(struct svm_test *test)
+{
+	if (test->scratch == 0)
+		vmcb->save.rip = (ulong)svm_32bit_guest_begin;
+}
+
+static void svm_32bit_guest_test(struct svm_test *test)
+{
+	/* Unused: RIP is overridden in prepare_gif_clear. */
+}
+
+static bool svm_32bit_guest_finished(struct svm_test *test)
+{
+	struct guest_regs *regs = this_cpu_guest_regs();
+	if (vmcb->control.exit_code != SVM_EXIT_VMMCALL) {
+		report_fail("32-bit guest: unexpected exit code 0x%x",
+			    vmcb->control.exit_code);
+		return true;
+	}
+
+	vmcb->save.rip += 3;
+
+	switch (test->scratch) {
+	case 0:
+		report(regs->rax == 1, "32-bit guest first VMMCALL");
+		if (regs->rax != 1)
+			return true;
+		test->scratch = 1;
+		return false;
+	case 1:
+		report(regs->rax == 2, "32-bit guest second VMMCALL");
+		if (regs->rax != 2)
+			return true;
+		test->scratch = 2;
+		return true;
+	default:
+		report_fail("32-bit guest: unexpected stage %ld", test->scratch);
+		return true;
+	}
+}
+
+static void svm_32bit_free_page_tables(void)
+{
+	u64 cr3 = vmcb->save.cr3;
+
+	free_page(phys_to_virt(cr3));
+}
+
+static bool svm_32bit_guest_check(struct svm_test *test)
+{
+	svm_32bit_free_page_tables();
+	return test->scratch == 2;
+}
+
 extern u8 *io_bitmap;
 
 static void prepare_ioio(struct svm_test *test)
@@ -3693,6 +3810,9 @@ struct svm_test svm_tests[] = {
 	{ "vgif", vgif_supported, prepare_vgif_enabled,
 	  default_prepare_gif_clear, test_vgif, vgif_finished,
 	  vgif_check },
+	{ "32bit_guest", default_supported, svm_32bit_guest_prepare,
+	  svm_32bit_guest_prepare_gif_clear, svm_32bit_guest_test, svm_32bit_guest_finished,
+	  svm_32bit_guest_check },
 	TEST(svm_cr4_osxsave_test),
 	TEST(svm_guest_state_test),
 	TEST(svm_vmrun_errata_test),
-- 
2.54.0

