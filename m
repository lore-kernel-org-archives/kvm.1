Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E02D3EF645
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289122; cv=none; b=MQ7D8IntgaxrCYgkF7WqxrnpFHzWmqh2pIevIODCh3uU54rTYYAY4CdL4gLjRTq2lS7FVbkrz83bzcypVHHTJeieEjXG3cxvH5hcAiwTTVFlXsto7mkyqXKpZi/HLZKUitQavgZEOcFMJARnogOkotToB0TeSx4+Qx/9jduBYZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289122; c=relaxed/simple;
	bh=6quHKQdiLEjbiZ6Dyggqv8l8h3qSZwCQWlQ1bPJAIXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkHhZbslBI8uJiKJsJoQxkFHzXSYI7t9eXhTLMwG4gqRa6ZWtb06XwdJY1j6su+ZLJnM1P3CQIxKHe4/TX+zj/PrcohCdglrzse2BqYUZDsuQBcEaoLA9bYbYNPEQepqvB0A/LH4AcYpsa7w7+Uedac8aPJn59e8zIDkTqxXPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YbY3O4lD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdrrNXuF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbY3O4lD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdrrNXuF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779289119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cdLpsY851YiABAKfn9vnshq+d4Lt/eCEtb+GV2ay4pU=;
	b=YbY3O4lDXXuDg9cMJVsvG7lZ0xk9bIOGJOmAq8f1J518DKhK1QAwQ4/FDoMXdX2i+Vqwrb
	dRriADENkUdYAaQAakpAb81jqUb/MY/V71iUC1bPnzoVgL9/Rzd3ZGdrClXU7Ov5Sa681F
	ly96c/0kSh9Qq472PX8TCjYsywzxPnk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-SrdK48KgNYapKhgJ0DCv0A-1; Wed, 20 May 2026 10:58:35 -0400
X-MC-Unique: SrdK48KgNYapKhgJ0DCv0A-1
X-Mimecast-MFC-AGG-ID: SrdK48KgNYapKhgJ0DCv0A_1779289114
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d7b7bacddso3747494f8f.0
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779289114; x=1779893914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdLpsY851YiABAKfn9vnshq+d4Lt/eCEtb+GV2ay4pU=;
        b=KdrrNXuFrk+OBb25M3IvWlTxI7O4imdhhqHmHevTwDcSgongbdaGkYVQ+SJsJ2atao
         /N1ksJfR5CddLoQiJ8G2LkyWA3W02korltp3HYrBU1qHeqQwERcBlXqAMEbE70acPB36
         GPkDSu66qqbeGaU8ECFMEk8CD6KaABBxq6rrIVNp/WCVy0DmWGjuAs7ck0mZMFvAoUnn
         /5c/+3H9peEWqCyLGFAOUdBRMHuIbnpg+aHtPOtQNrbFNHh9BXmX3d20Vwxp41Xt3rZt
         pu1s11z4wPVDsr7NqVRSKXMJP5LJoPq/Kvlp6Tq9etXgVtci+BSFUam5vg7j21NGd5oF
         faTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779289114; x=1779893914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cdLpsY851YiABAKfn9vnshq+d4Lt/eCEtb+GV2ay4pU=;
        b=IXe8URdt4W4WCKpj7e1ew+0MlyYFDjnK+wMl3cEOkmBFP26oJfIINL8wRUhxgToYyN
         9+Ri3nhJcP7sw6tEnv+bhDHQV4JLkMF/i1ih3DteOcGexoqdFaNAW33ro4BCI8y7SttL
         +Hr0Pm2UPi8TH4e0W92bhx4P5ze6Nz0H76RAbyuACSm09Sn+DIl+D/rBVTv8oRRdrDqO
         HBDSq9mv8khB3AofJk5nX3zQ3w25piKiPqA8yQzzFOEJzQpZ22ByMkcSGK6AIs9gUm35
         PhnTBvp2YY6InMtg8elZPU3ZBwErwDqcYXzyIx664GdKviSade18B/UP/HybWtaN2izz
         tTEg==
X-Gm-Message-State: AOJu0Yw2suDQBDIwS5dFdWG/XwkpjcbTUaM9Dt7oA3C5KwraiKlzx4rA
	r9Y4z7EcEqpDTpcOhayXI+hmofViiQxjog13UzJwA93285eSoN8nRiX7O4lUarypZtCTypZ3UJW
	lFk7QdLdSLJDSxE+FjcOMRK5HDnJQmDBWV8LE6D681BpQUh2/0AVQu3bXI1V9ZyItIH1YoGEI4e
	4d5iaeG+lBi07DKcCUrlDdIZmjjVPHAVaDOwkzlvui
X-Gm-Gg: Acq92OHhDxZ/qyPT2FSPWIxf5vLsOzwXPeQPQCRfy7VUGUH32Bjwjv7Ros5o99kIKmU
	shM5DHABe7cyVRwuWIg5xnRFT9h5lnM64RTOo/xu3+o9jwhFCKn3hEP3TnyXydXZrfiRGhm6hUE
	bs5jG2ZMMzTrVKDBu6m2P8lbSd909e4DGnzEuf+CFuC9atQpNxn1PCEX3cvYEUWWjW5sC2jmPiK
	dWUBCOsgwVc5/s74hLwW4fiS1haUG0W+4deX3bqkQM8pHD+ixhulMB2dXsauPSjPnf5ZKRQZRsX
	wKdutfm+bNqBahRetlD9l1pIH28+67qo6zDDzqJ0Px8miTNf+GvTweLR6ZymKyMOQhSR3P/UyKB
	NtQcN1zDoge9phQ9sVpeIPwWGs94lRTICZGogLeT9bsMtZ5hFgYVBmE2I9X33CFv7VZirYgtnFy
	nBHSAZazvYazWnbym9dcFvCs2NF+4q0MvE6kOZ99miervT
X-Received: by 2002:a05:6000:2584:b0:43d:7783:c684 with SMTP id ffacd0b85a97d-45e5c5e6d3dmr40177407f8f.43.1779289114008;
        Wed, 20 May 2026 07:58:34 -0700 (PDT)
X-Received: by 2002:a05:6000:2584:b0:43d:7783:c684 with SMTP id ffacd0b85a97d-45e5c5e6d3dmr40177341f8f.43.1779289113504;
        Wed, 20 May 2026 07:58:33 -0700 (PDT)
Received: from [10.110.4.204] ([87.215.26.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3acf7sm55354092f8f.12.2026.05.20.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:58:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: mlevitsk@redhat.com
Subject: [PATCH kvm-unit-tests 4/5] svm: add test for 32-bit guest
Date: Wed, 20 May 2026 16:58:22 +0200
Message-ID: <20260520145823.408884-5-pbonzini@redhat.com>
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
 x86/svm_tests.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index 95d18359..3ba3b09c 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -769,6 +769,117 @@ static bool check_mode_switch(struct svm_test *test)
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
+	save->cr4 &= ~X86_CR4_PSE;
+	save->cr4 |= X86_CR4_PAE;
+	save->cr3 = cr3;
+	regs.rax = 0x123457678;
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
+		report(vmcb->save.rax == 1, "32-bit guest first VMMCALL");
+		test->scratch = 1;
+		return false;
+	case 1:
+		report(vmcb->save.rax == 2, "32-bit guest second VMMCALL");
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
@@ -3692,6 +3803,9 @@ struct svm_test svm_tests[] = {
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

