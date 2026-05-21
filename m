Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8820E37CD4F
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358654; cv=none; b=bJJnIinWdNPJOoz80Gf3YVwaC0TD2oCmEOwgTW+ONu7R7pD0EAw6UeI6Gz7oLhk/0boWOY5pSPPodLjMTJXRhHiJpYz1AFSn1BTAqld3nDHXbFA9HxhQpCHjPEme/gBzAm7ehDfOXQAmgufUlKel8/CdwSS3TzywV9DcCQvuXfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358654; c=relaxed/simple;
	bh=xRZ8hKdfoYtyLspRG2QkJ5ZjPBqaT7Vdbw5gPXHIrU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSfBiHrGiECWgG1aZzdAqhyNrIXUr9679dvHT8vzcVQVnczDJnNszvJ/7rTK6RgR2mrn+r0XwHDU364bVNMi3/fIhJ6yUnkeJgRbYJCbEHUgrnJPamwnKpYWukin/pjeHN55g0yTKsu+lZctj0hPcC/ZB7eL5SmDCcYsTnh2l4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QccpUui2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gmY33ETt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QccpUui2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmY33ETt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779358652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLLFencxP4QxJT1f+KzOFFvNP3JnzFzEfERgG+dYy/0=;
	b=QccpUui2bqdnxKMrl1g/zuVRZcWpQ5IDoUWD3Fnf/x15eo5ClHH+m0jKlEXlfZ/QaBWcL8
	zTXWLADZgo0SGfLG367BkSxHRcnyBOE/pjnLNWJ1rmg8v66zZGmXODd5yTrUCjYY/vOXqH
	rXRZxvuBy+m44GxsMBMJFW91Io5JdKo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-2FZdunrePImzQkDhcL93HA-1; Thu, 21 May 2026 06:17:30 -0400
X-MC-Unique: 2FZdunrePImzQkDhcL93HA-1
X-Mimecast-MFC-AGG-ID: 2FZdunrePImzQkDhcL93HA_1779358650
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-bcd55c93265so464656766b.0
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 03:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779358650; x=1779963450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLLFencxP4QxJT1f+KzOFFvNP3JnzFzEfERgG+dYy/0=;
        b=gmY33ETtziRVDASfHxLlxgc8UrjYrF5vNzdQ9VrXpLLM1/mnPcchC7VPECVZlRxH7G
         eJqbj4ak5f2QdCXpK3jUogJwEwdqP2KLQ0ttoCJOoANwJJUlWR+9vtxCm/xPzb4AXabP
         ZWSIdhuqV9F/V9cSykWit5NkQNrdGJ4LZ1Y09d8skub1kh5/shKo4QsHgPXPR+kXPjLP
         cBL6J9ZgnwiVeGaa2yut8/UBH737nDKahikeOtS7fBdiTzjYVPo5lD3E33cHWj6RBA3y
         YfveSc1eKNy0ToWlmGrtOP2vWB4hr1hbGTMNdnf8O7PjI2iESAH3LZlFCSQIPL4gb35p
         o/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779358650; x=1779963450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LLLFencxP4QxJT1f+KzOFFvNP3JnzFzEfERgG+dYy/0=;
        b=AVMbYpCsTH/5YKv4Bl1CZdXBoOpO+3OpoGXM7iB1oj83PRIpPs3WiCWtMwysPzXEmU
         GtiGHii2cO/sF6wopU754z89Q0CHlM844hZkvQcXVu+b0QsfHATdEdLelFyeUcVwHCRt
         +kFga8jt3BDZDQc3O2n7l2WKRBufRV9DsZWLKXRaHSh6BHxoEuB+VPDSSZS5Kl+rO9TK
         TUxjfE45qEJMv/YLeEUTYPDVkc9XPSs6VjDp8FnE20cSBIZ2aOW6NaTh8dY5NP6ZMuMc
         3xIae1Y3fzE1dhD+TKtpI/MYspWUUZcDVcOXiRS2RndWACnbIhZLLY8ZCVSJMO27qMvX
         erog==
X-Gm-Message-State: AOJu0YyEW6L4avsLfVSKFYsZN7zf8NP5DZ5+rBPJFjgMnZWy7Gh2yIZd
	LGrsMNDuUrw2lLL6vzdmtEp7L2ewjwF9TxhA3djNRPn/Imu+FKGR7nk6vxQpzIzV36HbYkHB3cQ
	qYP0wogi6WuBSwjXvgXX5idSWsJMqdQYyiYgsBrt2m8ghQCk3PVRvHui4d7ig1jp9Nc6V6YwZDG
	1BFgJG8behPm4t/r3//q4JB3XZ27dyj3VTaJcXeyS1
X-Gm-Gg: Acq92OE/124sORlA+wxVtzVI5oFdQK/S2y1+TtPMBYWv/ELlmblUBM0BId+7NoPXTEH
	bo/1ERsSsvtXTs1u+CpQBuoAqk1MXDT6C+y8NPboK72BshiJ0HckHAbFE2ETKHgM7eufDwKnuzA
	iPKi0PwfNp3WoLMxPCyf8tRRiCbX8Rul4+1t+u6LEiP4WpUW1UjQ/ddtkbTGSlTcOPovVZoe2s8
	XMaA021OwPgQE5gE0W5aXbtKlaAvuownHpDVtqEKraZ5WEhU11923Y3J4KjzhNVARH8jOgO0zJv
	3+1CnXJgfGccDo2D9id4l9jpr+AiYxzp5JLY0fW9ST8JxKOgpUi1541KJNCXA/OxYUj8WnPPKEq
	iatSkXmxiEqQme3rKCYjfPWsmcsgVu3AHw/5HFxt/oTWtYv7kFGKGzO33PDV0ENe9bLLjE7dkmO
	zpVwAIDJCetlZd70cIQb+zpfRpOTSZAonK0fJB
X-Received: by 2002:a17:907:97cc:b0:bd4:a839:9065 with SMTP id a640c23a62f3a-bdc1524e537mr114426166b.37.1779358649490;
        Thu, 21 May 2026 03:17:29 -0700 (PDT)
X-Received: by 2002:a17:907:97cc:b0:bd4:a839:9065 with SMTP id a640c23a62f3a-bdc1524e537mr114423666b.37.1779358648902;
        Thu, 21 May 2026 03:17:28 -0700 (PDT)
Received: from [172.101.1.88] ([185.48.102.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc87891245sm27681266b.11.2026.05.21.03.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 03:17:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: mlevitsk@redhat.com
Subject: [PATCH kvm-unit-tests 2/4] vmx: add test for 32-bit PAE guest
Date: Thu, 21 May 2026 12:17:21 +0200
Message-ID: <20260521101723.101100-3-pbonzini@redhat.com>
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
 x86/vmx_tests.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 4 deletions(-)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 18f0d8ef..5dd232e6 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -279,7 +279,7 @@ asm(".code32\n\t"
 
 /*
  * Build identity-mapped page tables for a 32-bit guest covering the
- * low 4 GB using 4GB pages, returns the value to load into GUEST_CR3.
+ * low 4 GB using 4GB pages.  Returns the value to load into GUEST_CR3.
  */
 static u64 vmx_32bit_build_page_tables(void)
 {
@@ -294,10 +294,33 @@ static u64 vmx_32bit_build_page_tables(void)
 	return virt_to_phys(pd);
 }
 
-static int vmx_32bit_guest_init_common(u64 cr3)
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
 {
 	struct guest_regs *regs = this_cpu_guest_regs();
+	bool ept = (ctrl_cpu_rev[0].clr & CPU_SECONDARY) && (ctrl_cpu_rev[1].clr & CPU_EPT);
 	u64 cr0, cr4;
+	int i;
 
 	vmx_set_test_stage(0);
 
@@ -315,11 +338,16 @@ static int vmx_32bit_guest_init_common(u64 cr3)
 
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
 	regs->rax = 0x123457678;
 
@@ -331,6 +359,20 @@ static void vmx_32bit_free_page_tables_cb(void *pd)
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
@@ -339,7 +381,28 @@ static int vmx_32bit_guest_init(struct vmcs *vmcs)
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
@@ -11925,6 +11988,10 @@ struct vmx_test vmx_tests[] = {
 		preemption_timer_exit_handler },
 	{ "32-bit guest 2-level paging", vmx_32bit_guest_init,
 		vmx_32bit_guest_main, vmx_32bit_guest_exit_handler },
+	{ "32-bit guest PAE paging", vmx_pae_guest_init,
+		vmx_32bit_guest_main, vmx_32bit_guest_exit_handler },
+	{ "32-bit guest PAE paging without EPT", vmx_pae_guest_no_ept_init,
+		vmx_32bit_guest_main, vmx_32bit_guest_exit_handler },
 	{ "control field PAT", test_ctrl_pat_init, test_ctrl_pat_main,
 		test_ctrl_pat_exit_handler },
 	{ "control field EFER", test_ctrl_efer_init, test_ctrl_efer_main,
-- 
2.54.0

