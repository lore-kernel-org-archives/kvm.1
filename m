Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6A53EF645
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289116; cv=none; b=cFmiglXgCcuvKRte4QyK/sM/xdGdR2l/iKaXodK99o9quUYAdqxoJq9vGLzb40Uzi8jOqSBIwGResrsZWbdJ/1kHc2RTbkJrTVXgtJ6OdlW8HamN9/dqbN6dUBvFcoQJodu3s+d+Z7BtuGf9wdcdmTSvYjFV0sufH+jh6IqKIMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289116; c=relaxed/simple;
	bh=4g24/UefB1faB5h2L10Nw4XjbGnKsJDyRJ8I5RxmDWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5doAC1sx/d+dOhlUH63LdSD8K+x3FT/K1vq5YIqy0947PfIJQllS48n+Xd3uMtWgmi9M3mIDI0t3Ioh7DfcGD73Xr2A1dIYb4fM6YFZYlMRF74RCSxBJUqT93jszkIjqJTA+mAIGHJdC5798Fs9yfUnIK+ZSh7LMG+tk+e08q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDDOiRIo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUBzJTyl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDDOiRIo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUBzJTyl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779289113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=chs7fsmqsZwrc5HFusiMupLM1r5hW/d00sOOAYOU86w=;
	b=LDDOiRIo24KOoudUF2f8NsM2iZQFsr/5VWLnQMOOgwWG0NFQ4VPy6DAtIsRegHvaNhGc99
	3tAHCT0dfXi3xtDzuOo/rAntcJvtAPRUPVDXfE1ibghrPHrski5hk/slyl7e+dEDRr1ETw
	0hmnBO5pvfL7/cPzWKnRstmZVOT8Svw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-tfBx9CTfNie7aDdAi3W4Fg-1; Wed, 20 May 2026 10:58:31 -0400
X-MC-Unique: tfBx9CTfNie7aDdAi3W4Fg-1
X-Mimecast-MFC-AGG-ID: tfBx9CTfNie7aDdAi3W4Fg_1779289110
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44f65835b77so3754212f8f.2
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 07:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779289109; x=1779893909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chs7fsmqsZwrc5HFusiMupLM1r5hW/d00sOOAYOU86w=;
        b=GUBzJTyljWTFz+78cH5U2/3RvZmyl6E7fhw8ORR2XQSfUuvrWZOMKVhCJAhBh7h7tY
         ANEPPdiwdWoczQovWg0quVegx1RaUSje7NXCA+yYjcZkbtcgMvohoo0yWKkou4YwrdX/
         U4ZL+6RXs/JKstXpehKNlsZjh6a6FpSbhZUFwb3A7e+tmpewfj5fn29c5v0yiuz5wMqm
         fS97LdwEppYJsLv0TWrExkBNbchJbzD5FaBAETGoxAaRV6OFEx3XIi1JXAW0zofgNwPn
         sbPKINFa2VgOQmDaeOD+PMEHnmdGX0XA/ApSB/lYUCT7wsdqLX4y4rJE+NNrGedMBpRE
         J9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779289109; x=1779893909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=chs7fsmqsZwrc5HFusiMupLM1r5hW/d00sOOAYOU86w=;
        b=fByzarqo3Sm8zOkeusVrKYpavhKK94DQ7hTMc1RsH5zvQW4KADQcC+bCal9A+MTZ8H
         C+dXR3YlYNmQejP06qZ2iwafghBlDHiT5XRGrDPPNWlFXTVQtgiVm6CNnZvQkWOO1qvU
         KMXZ3D94XDITldK+kDASzgfImeua8bfWn0gkk5M9NpHHUzHX4QoC27XzM8ttzMufAlbd
         6HefA8dzjiEWfGNDBYrRvFpx+EOul0DhgkWUQQJIrjjj8M9i7aAXJhh+g1u7442xTrV9
         yYJAB6TZXoR7mAWmqySuL0lf0LJwkau9PyNHiLxI/wFXBAbrQOSGxDHXzeGOjKqo0kQp
         R/Hw==
X-Gm-Message-State: AOJu0YxeBj0KDbM7IfVhO7HWKBPiqZOkfUVxI6a2RXWfmi2eL4rnwnJ5
	9ZnV7qqBQ4tSU0STxRDS+lxuvq2MRNdCMR29kBivX+Be9nfIkXeGrigK1wSXPI2Rr+/flIi25tq
	JexeBLIqbwTuPQO4goDDf10pALN5GEdHcF1ALog8Zxuxmcgh9/jhM5yMxqCdJRUxmHf7A6FZalN
	HubAF+SnHamkPDLFZu+rnQDlSxqt6gWL8lsO/V4jB2
X-Gm-Gg: Acq92OHS+tJDkzG7oCK7foBmfynD4LQUoCnzViQ4ZJdo4vkWc+zzp/EXaPpEXviRaDV
	Bf19rLrGZLa7bHm6+LvqiCcn+y7BXnV1AdiW79Om7edenV1diVNCEAi5GKNCAdpn2jHkqwSADn6
	ELMbwNhVvgl1zP+IVKEzXHpnLGScuwKBz5+JaRQq0H65M4TNMQ17WK8JR3ZKl+/4fAg6/FwSoJb
	5KHrXwgNg3FLCV6AwJoTo2EQkVoAmjwjr0pinDRK00y3ZQVWqXmrgU9tBMv+eZuIZdOOVcyluTu
	o3VA/HpVZSi7g5GZ2rWL2mr9klwQ2yUv2zfur9eZ02/xnxTeFZAQQKxrxWI6FELarGXnrxJuEtC
	vEUaVuEdzZ+OIa+9I7KBPMFbH1hMz/tPm/7s2yqUEDU5/Vd/JLeWA/Gi5ZhMPHYcPFWLi4pYxsP
	Kekx4xDt4kKV0BJ+ep5gHKuLUNKnKRfc4C2A==
X-Received: by 2002:a05:6000:2489:b0:44f:da26:cbb4 with SMTP id ffacd0b85a97d-45e5c58d51cmr37260897f8f.21.1779289108636;
        Wed, 20 May 2026 07:58:28 -0700 (PDT)
X-Received: by 2002:a05:6000:2489:b0:44f:da26:cbb4 with SMTP id ffacd0b85a97d-45e5c58d51cmr37260840f8f.21.1779289108096;
        Wed, 20 May 2026 07:58:28 -0700 (PDT)
Received: from [10.110.4.204] ([87.215.26.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed30110sm59118292f8f.13.2026.05.20.07.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:58:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: mlevitsk@redhat.com
Subject: [PATCH kvm-unit-tests 2/5] vmx: add test for 32-bit PAE guest
Date: Wed, 20 May 2026 16:58:20 +0200
Message-ID: <20260520145823.408884-3-pbonzini@redhat.com>
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

Add a simple test that runs a 32-bit code segment with PAE page tables.
Check enabled and disabled EPT separately, because only the former
uses PDPTR fields in the VMCS.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/vmx_tests.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 4 deletions(-)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 8ea60235..165d4d3a 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -277,7 +277,7 @@ asm(".code32\n\t"
 
 /*
  * Build identity-mapped page tables for a 32-bit guest covering the
- * low 4 GB using 4GB pages, returns the value to load into GUEST_CR3.
+ * low 4 GB using 4GB pages.  Returns the value to load into GUEST_CR3.
  */
 static u64 vmx_32bit_build_page_tables(void)
 {
@@ -292,9 +292,32 @@ static u64 vmx_32bit_build_page_tables(void)
 	return virt_to_phys(pd);
 }
 
-static int vmx_32bit_guest_init_common(u64 cr3)
+/*
+ * Build identity-mapped page tables for a 32-bit guest covering the
+ * low 4 GB using PAE pages.  Fill the four PDPTRs into the pdpt[]
+ * array.
+ */
+static void vmx_32bit_build_pae_page_tables(u64 *pdpt)
 {
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
+	bool ept = (ctrl_cpu_rev[0].clr & CPU_SECONDARY) && (ctrl_cpu_rev[1].clr & CPU_EPT);
 	u64 cr0, cr4;
+	int i;
 
 	vmx_set_test_stage(0);
 
@@ -312,11 +335,16 @@ static int vmx_32bit_guest_init_common(u64 cr3)
 
 	cr0 = vmcs_read(GUEST_CR0) | X86_CR0_PG | X86_CR0_PE;
 	cr4 = vmcs_read(GUEST_CR4) & ~(X86_CR4_PCIDE | X86_CR4_PAE | X86_CR4_PSE);
-	cr4 |= X86_CR4_PSE;
+	cr4 |= pdpt ? X86_CR4_PAE : X86_CR4_PSE;
 	vmcs_write(GUEST_CR0, cr0);
 	vmcs_write(GUEST_CR4, cr4);
 	vmcs_write(GUEST_CR3, cr3);
 
+	if (pdpt && ept) {
+		for (i = 0; i < 4; i++)
+			vmcs_write(GUEST_PDPTE + 2 * i, pdpt[i]);
+	}
+
 	vmcs_write(GUEST_RIP, (u64)(uintptr_t)vmx_32bit_guest_begin);
 	regs.rax = 0x123457678;
 
@@ -328,6 +356,20 @@ static void vmx_32bit_free_page_tables_cb(void *pd)
 	free_page(pd);
 }
 
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
 static int vmx_32bit_guest_init(struct vmcs *vmcs)
 {
 	u64 cr3 = vmx_32bit_build_page_tables();
@@ -336,7 +378,28 @@ static int vmx_32bit_guest_init(struct vmcs *vmcs)
 		setup_ept(false);
 
 	test_add_teardown(vmx_32bit_free_page_tables_cb, phys_to_virt(cr3));
-	return vmx_32bit_guest_init_common(cr3);
+	return vmx_32bit_guest_init_common(cr3, NULL);
+}
+
+static int vmx_pae_guest_init(struct vmcs *vmcs)
+{
+	u64 pdpt[4];
+
+	if (setup_ept(false))
+		return VMX_TEST_VMSKIP;
+
+	vmx_32bit_build_pae_page_tables(pdpt);
+	test_add_teardown(vmx_pae_free_page_tables_cb, NULL);
+	return vmx_32bit_guest_init_common(0x01234560, pdpt);
+}
+
+static int vmx_pae_guest_no_ept_init(struct vmcs *vmcs)
+{
+	u64 *pdpt = memalign_pages_flags(PAGE_SIZE, PAGE_SIZE, AREA_DMA32);
+
+	vmx_32bit_build_pae_page_tables(pdpt);
+	test_add_teardown(vmx_pae_free_page_tables_cb, pdpt);
+	return vmx_32bit_guest_init_common(virt_to_phys(pdpt), pdpt);
 }
 
 static void vmx_32bit_guest_main(void)
@@ -11882,6 +11945,10 @@ struct vmx_test vmx_tests[] = {
 		preemption_timer_exit_handler, NULL, {0} },
 	{ "32-bit guest 2-level paging", vmx_32bit_guest_init,
 		vmx_32bit_guest_main, vmx_32bit_guest_exit_handler, NULL, {0} },
+	{ "32-bit guest PAE paging", vmx_pae_guest_init,
+		vmx_32bit_guest_main, vmx_32bit_guest_exit_handler, NULL, {0} },
+	{ "32-bit guest PAE paging without EPT", vmx_pae_guest_no_ept_init,
+		vmx_32bit_guest_main, vmx_32bit_guest_exit_handler, NULL, {0} },
 	{ "control field PAT", test_ctrl_pat_init, test_ctrl_pat_main,
 		test_ctrl_pat_exit_handler, NULL, {0} },
 	{ "control field EFER", test_ctrl_efer_init, test_ctrl_efer_main,
-- 
2.54.0

