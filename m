Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A85847ECE6
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583172; cv=none; b=MShdoBSoXLiuDKtoKwLeOgYAF7i2F6c2x6zD+MDDUPXw/iEsNCo5QwrkfC91FVQYdmL1ieoanYGJ5kKYW3LodKMYp+WFEvB6FOI/IB6blGR8SUUdADFSS/9ujB5eauH97xgO0E0JDL54ALdCFzQKabhd3uo5wM5TvhyROUmoLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583172; c=relaxed/simple;
	bh=w5Dq7uoGkE1RuW/E0O//v1oWxdPh0RbNkcub0FrsSnU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4c4GeYzfBGbAVfdjeocaTrYc61wvLD+xjWu4mCfKvyx8IAkfB17sGWXYhS4UKef/JW/hVZK+nRDmE87CJC5ukg3hIVe85N2qO2k7m7VvBBpcXIsVL+Zog8r75J32bxlXXVPEkQKmgtSvGDOF4BiPgmZ1NDTnh/CeAgxu0kV8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LTDtdupy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTDtdupy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780583170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1lpGlTNoG+Xb20Rda9SzVSWUMeXL1E92IJVCy2Yldx4=;
	b=LTDtdupyBEuXpr82IP9tKnaSuA70xuBoEZYC1yh3EPdIfG19vJIb6l2YVzQRM/zl+yEI7q
	V7QW/zdPStYlu+daOUPw/WvU1RTQ82fSqEXp9hdM2t7z0Lwsj45NFML/X2nkx7ppO1DRJq
	41hG+axyvvJ6hPnU0RJ+ti1mt2rJqh8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-k3dBiiStNF2I5m5zQ1nrlw-1; Thu,
 04 Jun 2026 10:26:03 -0400
X-MC-Unique: k3dBiiStNF2I5m5zQ1nrlw-1
X-Mimecast-MFC-AGG-ID: k3dBiiStNF2I5m5zQ1nrlw_1780583163
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06C4F19560A1
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:26:03 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B54E8180049F
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:26:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Subject: [PATCH kvm-unit-tests 2/4] vmx: add test for 32-bit non-PAE guest
Date: Thu,  4 Jun 2026 10:25:59 -0400
Message-ID: <20260604142601.7440-3-pbonzini@redhat.com>
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

VMX tests were only running 64-bit guests.  Add a test that checks
the reserved and ignored bits in CR3 for legacy 2-level page tables.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/vmx_tests.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 5f2c2ca8..16f8a648 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -262,6 +262,38 @@ static int preemption_timer_exit_handler(union exit_reason exit_reason)
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
 /*
  * Build identity-mapped page tables for a 32-bit guest covering the
  * low 4 GB using PAE pages.  Fill the four PDPTRs into the pdpt[]
@@ -5922,6 +5954,39 @@ static void vmx_pae_test(void)
 	test_set_guest_finished();
 }
 
+/*
+ * Verify that VM entry with 32-bit (non-PAE) paging succeeds and that bits
+ * 2:0 and 11:5 of CR3 are ignored.
+ */
+static void vmx_pse_test(void)
+{
+	u64 cr3;
+	int b;
+
+	test_setup_32bit();
+
+	cr3 = vmx_32bit_build_page_tables();
+
+	vmx_32bit_guest_init_common(cr3, NULL);
+	if (enter_guest_report_pass())
+		skip_exit_vmcall();
+
+	for (b = 0; b <= 11; b++) {
+		if (b == 3 || b == 4)
+			continue;
+		vmx_32bit_guest_init_common(cr3 | (1ull << b), NULL);
+		test_guest_state("CR3 ignored bit", false, (1ull << b), "bit");
+	}
+
+	for (b = cpuid_maxphyaddr(); b < 64; b++) {
+		vmx_32bit_guest_init_common(cr3 | (1ull << b), NULL);
+		test_guest_state("CR3 reserved bit", true, (1ull << b), "bit");
+	}
+
+	free_page(phys_to_virt(cr3));
+	test_set_guest_finished();
+}
+
 /*
  * Tests for VM-entry control fields
  */
@@ -12117,6 +12182,7 @@ struct vmx_test vmx_tests[] = {
 	TEST(vmx_mtf_test),
 	TEST(vmx_mtf_pdpte_test),
 	TEST(vmx_pae_test),
+	TEST(vmx_pse_test),
 	TEST(vmx_pf_exception_test),
 	TEST(vmx_pf_exception_forced_emulation_test),
 	TEST(vmx_pf_no_vpid_test),
-- 
2.52.0


