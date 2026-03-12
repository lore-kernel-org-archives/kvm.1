Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E19401A38
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 20:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345806; cv=none; b=AyNLf1txCNvMKlImaDAqw6qrbsct1vDqpqffnCeEGz+4FSbt5ENrCJ+A+X4G1YqNy0GSe9UMYStBpkr54XYYPax2ldVZL6Ov9QdJVUSft4aUmBFELx8atBpdEK7hFV4ghmPpP0sPOOYo2w0VGHCKOyXFpslT6ptDgOLznjOvSiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345806; c=relaxed/simple;
	bh=Jdd34TaQep4JdSiy2sI68Da+xtAw61acZqaJQ9zLazM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=azxxe1BYls6VLA7K3hpx4O8QWn8oCuxlM59Z3PptkccQeUBNW/EdmDBieRvlQHbQK/+00gM25vQ8RZZ/8BWRsF/8e4Wz5vaQUEEKxAV+ajAZ/N9T9HbNdtYLIZXL/ibJI4XklgN4DqQXgzKmeWQRXiSiA+JsA11njzmBcXhS+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w0RDL0+r; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w0RDL0+r"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae49080364so13967745ad.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 13:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773345804; x=1773950604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9ctsl9bGJLNX+lJn+PX1zwUHcvm9KtaXETGCrBhl9A=;
        b=w0RDL0+re+VpsJbyM8NBEKi8Yd5YpOyUhyQIFpw7/CNGHHmjMi+DC0b4qtetK6QZsh
         n2ELgW8dXSpV1+gYnsoBPBNrguGoeoctjoeh9dX4ehdmHTXjkSSSqfftKdlsT3XTNads
         wgFRZZra91MjoHOy4aUtxwUO7F23ZgMjBHk1LkgszOknmBBTeyq7EXMcsLXzXysXrysi
         /tpauUQtBHjx8LFBDTGo1qJ/aimLzGy8mpAlzhGL1rZ4up5A9v6t68v2Xq93ZG8DJKOn
         SyBhExw/AOlITxmhxrGi2k8V4tuvY7w8L7BWT6jL6g/6mCz/wKJhCU8wfi3iJth1vy07
         KWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773345804; x=1773950604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9ctsl9bGJLNX+lJn+PX1zwUHcvm9KtaXETGCrBhl9A=;
        b=QtDBTpxqs9rHNtdc2cWAQxbFqTFckGljihVaqP6pIaVDP8LuQSoh7efAuKsZ5cwsFe
         Ei5ncDmDppLFtcRzp8zlKFd6r9FjFOpOfaSxxt6RiUrZQpQ9OwYmXmXN7DO01OydPFjc
         3cGv5ts2JlyrDsnmpPwTSANS5sWDntiP0VNsdsUedaIacnKKa1CfQSnjCATW/qRj7UQx
         Y3wgLNakD2xn1DmYTo8EtpX2+UmaX5GOAUD93wgYTmh0co7rtc4UZQxM+SFhvYM5j7dB
         fS8eXS2foWuimTqDxzTNoOn9HM065zZkayaTzYXhMQwy2Uehh5Xcnc3geHFopujLvT9e
         +K1A==
X-Gm-Message-State: AOJu0YzVWQ9KjXUyJY3TBLckaMCNKKgJOEY2sZ4k8hHv2jXzyDwCM7yL
	N5EmYqYMgG3p0APB8EXb8XvIQ8cCgkAXUQWm03iN2+6njiAnI5w1LV1z8t/cpRGCd7QOYDSS+EF
	sVUdrYwF5Z/bb4xfIYAoiAiUX0ce4LCNZG21iRBcPxQ7w6tDo/rVb46q4VXIOjqQSwrZzR7a4eE
	YQ2yviDiOKXcgyWemwgIjygGI0YCLuakp7RWWTkpSrL6s=
X-Received: from plge4.prod.google.com ([2002:a17:902:cf44:b0:2ae:3b56:7c6a])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ebc4:b0:2ae:6887:5c26 with SMTP id d9443c01a7336-2aecaafccbamr6910435ad.48.1773345803531;
 Thu, 12 Mar 2026 13:03:23 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:03:06 +0000
In-Reply-To: <20260312200308.3089379-1-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312200308.3089379-1-chengkev@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312200308.3089379-9-chengkev@google.com>
Subject: [kvm-unit-tests PATCH v3 08/10] x86/svm: Add testing for NPT
 permissions on guest page tables
From: Kevin Cheng <chengkev@google.com>
To: kvm@vger.kernel.org
Cc: yosry@kernel.org, andrew.jones@linux.dev, thuth@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

Modify permissions for NPT entries that contain guest page table
structures. Verify that NPF VM exit correctly reports fault occurred
during the guest page table walk and correctly reports the right
violation.

Signed-off-by: Kevin Cheng <chengkev@google.com>
---
 x86/svm_npt.c | 223 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 221 insertions(+), 2 deletions(-)

diff --git a/x86/svm_npt.c b/x86/svm_npt.c
index 39e8b01965f2..410c17c7b7cb 100644
--- a/x86/svm_npt.c
+++ b/x86/svm_npt.c
@@ -51,6 +51,12 @@ static void *get_1g_page(void)
 	return alloc;
 }
 
+static void do_npt_access_op(enum npt_access_op op)
+{
+	npt_access_test_data.op = op;
+	svm_vmrun();
+}
+
 static void
 diagnose_npt_violation_exit_code(u64 expected, u64 actual)
 {
@@ -115,9 +121,8 @@ static void do_npt_access(enum npt_access_op op, u64 expected_fault,
 	u64 exit_info_2;
 
 	/* Try the access and observe the violation. */
-	npt_access_test_data.op = op;
 	vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ALL_ASID;
-	svm_vmrun();
+	do_npt_access_op(op);
 
 	exit_code = vmcb->control.exit_code;
 	exit_info_1 = vmcb->control.exit_info_1;
@@ -422,6 +427,215 @@ static bool npt_rw_pfwalk_check(struct svm_test *test)
 	    && (vmcb->control.exit_info_2 == read_cr3());
 }
 
+/*
+ * This function modifies the NPT entry that maps the GPA that the guest page
+ * table entry mapping npt_access_test_data.gva resides on.
+ */
+static void npt_access_paddr(unsigned long npt_clear, unsigned long npt_set,
+			     unsigned long pte_set, enum npt_access_op op,
+			     bool expect_violation, u64 expected_fault)
+{
+	struct npt_access_test_data *data = &npt_access_test_data;
+	unsigned long *ptep;
+	unsigned long gpa;
+	unsigned long orig_npte;
+	unsigned long pte;
+	u64 orig_opt_mask = pte_opt_mask;
+	int level;
+
+	/* Modify the guest PTE mapping data->gva according to @pte_set.  */
+	ptep = get_pte_level(current_page_table(), data->gva, 1);
+	report(ptep, "Get pte for gva 0x%lx", (unsigned long)data->gva);
+	report((*ptep & PT_ADDR_MASK) == data->gpa, "gva is correctly mapped");
+	*ptep = (*ptep & ~PT_AD_MASK) | pte_set;
+	do_npt_access_op(OP_FLUSH_TLB);
+
+	/*
+	 * Now modify the access bits on the NPT entry for the GPA that the
+	 * guest PTE resides on. Note that by modifying a single NPT entry,
+	 * we're potentially affecting 512 guest PTEs. However, we've carefully
+	 * constructed our test such that those other 511 PTEs aren't used by
+	 * the guest: data->gva is at the beginning of a 1G huge page, thus the
+	 * PTE we're modifying is at the beginning of a 4K page and the
+	 * following 511 entries are also under our control (and not touched by
+	 * the guest).
+	 */
+	gpa = virt_to_phys(ptep);
+	assert((gpa & ~PAGE_MASK) == 0);
+
+	/*
+	 * Make sure the guest page table page is mapped with a 4K NPT entry,
+	 * otherwise our level=1 twiddling below will fail. We use the
+	 * identity map (gpa = gpa) since page tables are shared with the host.
+	 */
+	pte_opt_mask |= PT_USER_MASK;
+	install_pte(npt_get_pml4e(), /*level=*/1, (void *)(ulong)gpa,
+		    gpa | PT_PRESENT_MASK | PT_WRITABLE_MASK | PT_USER_MASK, 0);
+	pte_opt_mask = orig_opt_mask;
+
+	orig_npte = npt_twiddle(gpa, /*mkhuge=*/0, /*level=1*/1, npt_clear, npt_set);
+
+	if (expect_violation) {
+		do_npt_access(op, expected_fault, gpa);
+		npt_untwiddle(gpa, /*level=*/1, orig_npte);
+		do_npt_access_op(op);
+		TEST_EXPECT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	} else {
+		do_npt_access(op, 0, gpa);
+		for (level = PAGE_LEVEL; level > 0; level--) {
+			pte = *find_pte_level(npt_get_pml4e(), (void *)gpa, level).pte;
+			report(pte & PT_ACCESSED_MASK,
+			       "Access flag set. PTE val: 0x%lx",
+			       pte);
+
+			if (level == 1)
+				report(pte & PT_DIRTY_MASK,
+				       "Dirty flag set. PTE val: 0x%lx",
+				       pte);
+			else
+				report(!(pte & PT_DIRTY_MASK),
+				       "Dirty flag not set. PTE val: 0x%lx level: %d",
+				       pte, level);
+		}
+
+		npt_untwiddle(gpa, /*level=*/1, orig_npte);
+	}
+
+	report(*ptep & PT_ACCESSED_MASK, "Access flag set");
+	if ((pte_set & PT_DIRTY_MASK) || op == OP_WRITE)
+		report(*ptep & PT_DIRTY_MASK, "Dirty flag set");
+}
+
+static void npt_access_allowed_paddr(unsigned long npt_clear, unsigned long npt_set,
+				     unsigned long pte_set, enum npt_access_op op)
+{
+	npt_access_paddr(npt_clear, npt_set, pte_set, op, false, 0);
+}
+
+static void npt_access_npf_paddr(unsigned long npt_clear, unsigned long npt_set,
+				 unsigned long pte_set, enum npt_access_op op,
+				 u64 expected_fault)
+{
+	npt_access_paddr(npt_clear, npt_set, pte_set, op, true, expected_fault);
+}
+
+/*
+ * All accesses to guest paging structures are considered as writes as far as
+ * NPT translation is concerned.
+ */
+static void npt_access_paddr_not_present_test(void)
+{
+	u32 pte_set_combinations[3] = {0, PT_ACCESSED_MASK, PT_DIRTY_MASK};
+
+	npt_access_test_setup();
+
+	for (int i = 0; i < ARRAY_SIZE(pte_set_combinations); i++) {
+		npt_access_npf_paddr(PT_PRESENT_MASK, 0,
+				     pte_set_combinations[i], OP_READ,
+				     PFERR_GUEST_PAGE_MASK | PFERR_USER_MASK |
+					     PFERR_WRITE_MASK);
+		npt_access_npf_paddr(PT_PRESENT_MASK, 0,
+				     pte_set_combinations[i], OP_WRITE,
+				     PFERR_GUEST_PAGE_MASK | PFERR_USER_MASK |
+					     PFERR_WRITE_MASK);
+		npt_access_npf_paddr(PT_PRESENT_MASK, 0,
+				     pte_set_combinations[i], OP_EXEC,
+				     PFERR_GUEST_PAGE_MASK | PFERR_USER_MASK |
+					     PFERR_WRITE_MASK);
+	}
+
+	npt_access_test_cleanup();
+}
+
+static void npt_access_paddr_read_only_test(void)
+{
+	u32 pte_set_combinations[3] = {0, PT_ACCESSED_MASK, PT_DIRTY_MASK};
+
+	npt_access_test_setup();
+
+	for (int i = 0; i < ARRAY_SIZE(pte_set_combinations); i++) {
+		npt_access_npf_paddr(PT_WRITABLE_MASK, PT64_NX_MASK,
+				     pte_set_combinations[i], OP_READ,
+				     PFERR_GUEST_PAGE_MASK | PFERR_USER_MASK |
+					     PFERR_WRITE_MASK |
+					     PFERR_PRESENT_MASK);
+		npt_access_npf_paddr(PT_WRITABLE_MASK, PT64_NX_MASK,
+				     pte_set_combinations[i], OP_WRITE,
+				     PFERR_GUEST_PAGE_MASK | PFERR_USER_MASK |
+					     PFERR_WRITE_MASK |
+					     PFERR_PRESENT_MASK);
+		npt_access_npf_paddr(PT_WRITABLE_MASK, PT64_NX_MASK,
+				     pte_set_combinations[i], OP_EXEC,
+				     PFERR_GUEST_PAGE_MASK | PFERR_USER_MASK |
+					     PFERR_WRITE_MASK |
+					     PFERR_PRESENT_MASK);
+	}
+
+	npt_access_test_cleanup();
+}
+
+static void npt_access_paddr_read_execute_test(void)
+{
+	u32 pte_set_combinations[3] = {0, PT_ACCESSED_MASK, PT_DIRTY_MASK};
+
+	npt_access_test_setup();
+
+	for (int i = 0; i < ARRAY_SIZE(pte_set_combinations); i++) {
+		npt_access_npf_paddr(
+			PT_WRITABLE_MASK, 0, pte_set_combinations[i], OP_READ,
+			PFERR_GUEST_PAGE_MASK | PFERR_USER_MASK |
+				PFERR_WRITE_MASK | PFERR_PRESENT_MASK);
+		npt_access_npf_paddr(
+			PT_WRITABLE_MASK, 0, pte_set_combinations[i], OP_WRITE,
+			PFERR_GUEST_PAGE_MASK | PFERR_USER_MASK |
+				PFERR_WRITE_MASK | PFERR_PRESENT_MASK);
+		npt_access_npf_paddr(
+			PT_WRITABLE_MASK, 0, pte_set_combinations[i], OP_EXEC,
+			PFERR_GUEST_PAGE_MASK | PFERR_USER_MASK |
+				PFERR_WRITE_MASK | PFERR_PRESENT_MASK);
+	}
+
+	npt_access_test_cleanup();
+}
+
+static void npt_access_paddr_read_write_test(void)
+{
+	u32 pte_set_combinations[3] = {0, PT_ACCESSED_MASK, PT_DIRTY_MASK};
+
+	npt_access_test_setup();
+
+	/* Read-write access to paging structure. */
+	for (int i = 0; i < ARRAY_SIZE(pte_set_combinations); i++) {
+		npt_access_allowed_paddr(0, PT_WRITABLE_MASK | PT64_NX_MASK,
+					 pte_set_combinations[i], OP_READ);
+		npt_access_allowed_paddr(0, PT_WRITABLE_MASK | PT64_NX_MASK,
+					 pte_set_combinations[i], OP_WRITE);
+		npt_access_allowed_paddr(0, PT_WRITABLE_MASK | PT64_NX_MASK,
+					 pte_set_combinations[i], OP_EXEC);
+	}
+
+	npt_access_test_cleanup();
+}
+
+static void npt_access_paddr_read_write_execute_test(void)
+{
+	u32 pte_set_combinations[3] = {0, PT_ACCESSED_MASK, PT_DIRTY_MASK};
+
+	npt_access_test_setup();
+
+	/* RWX access to paging structure. */
+	for (int i = 0; i < ARRAY_SIZE(pte_set_combinations); i++) {
+		npt_access_allowed_paddr(0, PT_WRITABLE_MASK, pte_set_combinations[i],
+					 OP_READ);
+		npt_access_allowed_paddr(0, PT_WRITABLE_MASK, pte_set_combinations[i],
+					 OP_WRITE);
+		npt_access_allowed_paddr(0, PT_WRITABLE_MASK, pte_set_combinations[i],
+					 OP_EXEC);
+	}
+
+	npt_access_test_cleanup();
+}
+
 static bool was_x2apic;
 
 static void npt_apic_prepare(void)
@@ -863,6 +1077,11 @@ static struct svm_test npt_tests[] = {
 	NPT_V2_TEST(npt_rw_test),
 	NPT_V2_TEST(npt_rwx_test),
 	NPT_V2_TEST(npt_ignored_bits_test),
+	NPT_V2_TEST(npt_access_paddr_not_present_test),
+	NPT_V2_TEST(npt_access_paddr_read_only_test),
+	NPT_V2_TEST(npt_access_paddr_read_write_test),
+	NPT_V2_TEST(npt_access_paddr_read_write_execute_test),
+	NPT_V2_TEST(npt_access_paddr_read_execute_test),
 	{ NULL, NULL, NULL, NULL, NULL, NULL, NULL }
 };
 
-- 
2.53.0.851.ga537e3e6e9-goog

