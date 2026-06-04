Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94BE47DFB5
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583168; cv=none; b=dViHRMCuhbtb3MoeVwFjvanIsXPGRASRMKVzkJZHmRp6k0wH27Dk5vbT1rdu51U0b5kg/Xk8BEXXlSqPfaybiTdS107nUzgubsPJ9QhuBnE2piJSY1W6LNZYjV6J443C+mXF5p5F4cbUWLWw+/a0bx28ZAqMSJFSWfaVBpYEWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583168; c=relaxed/simple;
	bh=s1GgNqcyZllLT7KM+9rXKi6GrEWOg6LovTmYclhHSoc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjTok6UwLk776/zd5O+HQO+v+IqFwLfv3DueEekZIdWtYbtfjfiUcKEa9PVEJrKPeiD7ObA/Cd3b5FWX1Qp2rbAJ4Gqso8eCr/dNvH1ryZ4q/IZ0ycechQrPScFkjHyBOn8nxVRppd2hYY+CkKyCM3Nib+7yDrRAIr+vwN6YwM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0QD2NiM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0QD2NiM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780583166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YDl8rCPg+y8jLz+slwB1newopaKbQKez0IYtay1AV4s=;
	b=R0QD2NiMhjjSjHRU5o000+0q4d13tP3iIOLsoQoMSescix4yh6Dxv2EjW4u//FQCn2zLx/
	17r3+nPghXSKOYZVrKWioqWyqUA8FXFSQMq56uxAsO4uVRgf4k53wkUTF51N1M/wG1skC9
	zHzHyKND2kg9y+FtKpBQVVhNtpaeX4M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-lYkqrt_FNbKekNb3qru6cw-1; Thu,
 04 Jun 2026 10:26:04 -0400
X-MC-Unique: lYkqrt_FNbKekNb3qru6cw-1
X-Mimecast-MFC-AGG-ID: lYkqrt_FNbKekNb3qru6cw_1780583164
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF1271956094
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:26:03 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 992A6180049F
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:26:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Subject: [PATCH kvm-unit-tests 4/4] svm: add test for 32-bit non-PAE guest
Date: Thu,  4 Jun 2026 10:26:01 -0400
Message-ID: <20260604142601.7440-5-pbonzini@redhat.com>
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
the reserved and ignored bits in CR3 for legacy two-level paging.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/svm_tests.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index f8c4d07a..06eba51b 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -52,6 +52,17 @@ do {							\
 	}						\
 } while (0)
 
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
 static void svm_32bit_build_pae_page_tables(u64 *pdpt)
 {
 	const u64 leaf_flags = PT_PRESENT_MASK | PT_WRITABLE_MASK | PT_PAGE_SIZE_MASK;
@@ -3860,6 +3871,35 @@ static void svm_pae_test(void)
 	svm_pae_free_page_tables(pdpt);
 }
 
+/*
+ * Verify that VMRUN with 32-bit (non-PAE) paging succeeds and that bits
+ * 2:0 and 11:5 of CR3 are ignored.
+ */
+static void svm_pse_test(void)
+{
+	u64 cr3;
+	int b;
+
+	vmcb_ident(vmcb);
+	cr3 = svm_32bit_build_page_tables();
+
+	svm_32bit_guest_init_common(cr3, false);
+	test_svm_report_pass();
+
+	for (b = 0; b <= 11; b++) {
+		if (b == 3 || b == 4)
+			continue;
+		svm_32bit_guest_init_common(cr3 | (1ull << b), false);
+		test_svm_guest_state("CR3 ignored bit", false, (1ull << b), "bit");
+	}
+	for (b = cpuid_maxphyaddr(); b <= 63; b++) {
+		svm_32bit_guest_init_common(cr3 | (1ull << b), false);
+		test_svm_guest_state("CR3 reserved bit", true, (1ull << b), "bit");
+	}
+
+	free_page(phys_to_virt(cr3));
+}
+
 struct svm_test svm_tests[] = {
 	{ "null", default_supported, default_prepare,
 	  default_prepare_gif_clear, null_test,
@@ -3980,6 +4020,7 @@ struct svm_test svm_tests[] = {
 	  default_prepare_gif_clear, test_vgif, vgif_finished,
 	  vgif_check },
 	TEST(svm_pae_test),
+	TEST(svm_pse_test),
 	TEST(svm_cr4_osxsave_test),
 	TEST(svm_guest_state_test),
 	TEST(svm_vmrun_errata_test),
-- 
2.52.0

