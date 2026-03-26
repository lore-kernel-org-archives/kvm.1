Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35293FF8B7
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536652; cv=none; b=a1XSh762sEtxb24LkoNyOGvCEVqt6Vv2VG2ElWdghMEaxdoE7FBj/LNjXxzncsD00ZM2n35sszOHsIX3qcZu/DTY6DTXsFEGKpoBWsBU54Cc6PLkkm+GHxNU4xtY4tl4jJV4xYtcA4+3QJEnhFN2HP3DLRuAKUIblTJEMFaVyNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536652; c=relaxed/simple;
	bh=tveFxgjvS1ceEH+WecUUEccDN7IvxlUYNmR0SywTvdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brPORWrpuqtzzX/xB/FifgUG02Y3RIItYhPnghq/Slw8ANFAFOy6WibgIwQ38ommKkUXbJivV1YZbTSOo7wvO4GIhUF3n6Q0cJcmBOzCdEx/b2fkK1jGW16XIEjFAsafHc4xaDkqQ+/LRFMHcJ5WaTK0A1BWOJv/yrfJr0yV94c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZWkuR9m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZWkuR9m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774536650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+cAPI4TUfZ3Ejt9oeUJ/rXTX9JHxx+1wcZWo+sn2V4=;
	b=fZWkuR9m6YziNucXeIh8U0OtamszLU8CswI1emu7HoeHf5Sv2eJ+dFi5O/TzN3oN79329V
	2xPVBTmWRHPImaYzUtW+7KIPS2RLSwF5E85Nqk3Yqv1Mm8Kv3Zoo2mV0pw9y3Mab7y8S30
	IMczDPC1kdZ2qIX9fjjSKyhVAs8pngI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-HbGM522rOfaTUPY2jgK05A-1; Thu,
 26 Mar 2026 10:50:45 -0400
X-MC-Unique: HbGM522rOfaTUPY2jgK05A-1
X-Mimecast-MFC-AGG-ID: HbGM522rOfaTUPY2jgK05A_1774536644
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FA731800371;
	Thu, 26 Mar 2026 14:50:44 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.eng.rdu2.dc.redhat.com [10.6.68.74])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D4311800673;
	Thu, 26 Mar 2026 14:50:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH kvm-unit-tests 8/9] x86/vmx: run EPT tests with MBEC enabled when available
Date: Thu, 26 Mar 2026 10:50:34 -0400
Message-ID: <20260326145035.119519-9-pbonzini@redhat.com>
In-Reply-To: <20260326145035.119519-1-pbonzini@redhat.com>
References: <20260326145035.119519-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Check that the XS bit does not allow execution of user-mode pages
when MBEC is available (and enabled); this requires tweaking
the guest page tables to set U=0 for OP_EXEC.  Update the unit test
configuration to include a specific test case for MBEC.

Co-authored-by: Jon Kohler <jon@nutanix.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/unittests.cfg | 12 +++++-
 x86/vmx.h         |  5 ++-
 x86/vmx_tests.c   | 98 ++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 94 insertions(+), 21 deletions(-)

diff --git a/x86/unittests.cfg b/x86/unittests.cfg
index b82bbc4e..022ea52c 100644
--- a/x86/unittests.cfg
+++ b/x86/unittests.cfg
@@ -336,7 +336,17 @@ groups = vmx
 [ept]
 file = vmx.flat
 test_args = "ept_access*"
-qemu_params = -cpu max,host-phys-bits,+vmx -m 2560
+qemu_params = -cpu max,host-phys-bits,+vmx,-vmx-mbec -m 2560
+arch = x86_64
+groups = vmx
+
+# EPT is a generic test; however, mode-based execute control aka MBEC
+# is only available on Skylake and above, be specific about the CPU
+# model and test it directly.
+[ept-mbec]
+file = vmx.flat
+test_args = "ept_access*"
+qemu_params = -cpu Skylake-Server,host-phys-bits,+vmx,+vmx-mbec -m 2560
 arch = x86_64
 groups = vmx
 
diff --git a/x86/vmx.h b/x86/vmx.h
index b492ec74..7ad7672a 100644
--- a/x86/vmx.h
+++ b/x86/vmx.h
@@ -672,11 +672,14 @@ enum vm_entry_failure_code {
 #define EPT_LARGE_PAGE		(1ul << 7)
 #define EPT_ACCESS_FLAG		(1ul << 8)
 #define EPT_DIRTY_FLAG		(1ul << 9)
+#define EPT_EA_USER		(1ul << 10)
 #define EPT_MEM_TYPE_SHIFT	3ul
 #define EPT_MEM_TYPE_MASK	0x7ul
 #define EPT_SUPPRESS_VE		(1ull << 63)
 
-#define EPT_PRESENT		(EPT_RA | EPT_WA | EPT_EA)
+#define EPT_PRESENT		(is_mbec_supported() ? \
+				 (EPT_RA | EPT_WA | EPT_EA | EPT_EA_USER) : \
+				 (EPT_RA | EPT_WA | EPT_EA))
 
 #define EPT_CAP_EXEC_ONLY	(1ull << 0)
 #define EPT_CAP_PWL4		(1ull << 6)
diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 023512e6..bf03451a 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -1044,6 +1044,8 @@ static int insn_intercept_exit_handler(union exit_reason exit_reason)
  */
 static int __setup_ept(u64 hpa, bool enable_ad)
 {
+	u64 secondary;
+
 	if (!(ctrl_cpu_rev[0].clr & CPU_SECONDARY) ||
 	    !(ctrl_cpu_rev[1].clr & CPU_EPT)) {
 		printf("\tEPT is not supported\n");
@@ -1067,9 +1069,13 @@ static int __setup_ept(u64 hpa, bool enable_ad)
 	if (enable_ad)
 		eptp |= EPTP_AD_FLAG;
 
+	secondary = vmcs_read(CPU_EXEC_CTRL1) | CPU_EPT;
+	if (is_mbec_supported())
+		secondary |= CPU_MODE_BASED_EPT_EXEC;
+
 	vmcs_write(EPTP, eptp);
 	vmcs_write(CPU_EXEC_CTRL0, vmcs_read(CPU_EXEC_CTRL0)| CPU_SECONDARY);
-	vmcs_write(CPU_EXEC_CTRL1, vmcs_read(CPU_EXEC_CTRL1)| CPU_EPT);
+	vmcs_write(CPU_EXEC_CTRL1, secondary);
 
 	return 0;
 }
@@ -2174,6 +2180,7 @@ do {									\
 	DIAGNOSE(EPT_VLT_PERM_RD);
 	DIAGNOSE(EPT_VLT_PERM_WR);
 	DIAGNOSE(EPT_VLT_PERM_EX);
+	DIAGNOSE(EPT_VLT_PERM_USER_EX);
 	DIAGNOSE(EPT_VLT_LADDR_VLD);
 	DIAGNOSE(EPT_VLT_PADDR);
 	DIAGNOSE(EPT_VLT_GUEST_USER);
@@ -2326,13 +2333,36 @@ static void ept_access_test_guest_flush_tlb(void)
 	skip_exit_vmcall();
 }
 
+/*
+ * Modifies the leaf guest page table entry that maps @gva, clearing the bits
+ * in @clear then setting the bits in @set.  This is needed when testing
+ * MBEC so that the processor knows whether to observe XS or XU.
+ */
+static void guest_page_table_twiddle(unsigned long *gva, unsigned long clear, unsigned long set)
+{
+	pgd_t *cr3 = current_page_table();
+	int i;
+
+	for (i = 1; i <= PAGE_LEVEL; i++) {
+		u64 *pte = get_pte_level(cr3, gva, i);
+		if (!pte)
+			continue;
+
+		TEST_ASSERT(*pte & PT_PRESENT_MASK);
+		*pte = (*pte & ~clear) | set;
+		break;
+	}
+	invlpg((void *)gva);
+}
+
 /*
  * Modifies the EPT entry at @level in the mapping of @gpa. First clears the
  * bits in @clear then sets the bits in @set. @mkhuge transforms the entry into
  * a huge page.
  */
 static unsigned long ept_twiddle(unsigned long gpa, bool mkhuge, int level,
-				 unsigned long clear, unsigned long set)
+				 unsigned long clear, unsigned long set,
+				 enum ept_access_op op)
 {
 	struct ept_access_test_data *data = &ept_access_test_data;
 	unsigned long orig_pte;
@@ -2347,15 +2377,27 @@ static unsigned long ept_twiddle(unsigned long gpa, bool mkhuge, int level,
 		pte = orig_pte;
 	pte = (pte & ~clear) | set;
 	set_ept_pte(pml4, gpa, level, pte);
-	invept(INVEPT_SINGLE, eptp);
 
+	if (is_mbec_supported() && op == OP_EXEC)
+		guest_page_table_twiddle(data->gva, PT_USER_MASK, 0);
+
+	invept(INVEPT_SINGLE, eptp);
 	return orig_pte;
 }
 
-static void ept_untwiddle(unsigned long gpa, int level, unsigned long orig_pte)
+static void ept_untwiddle(unsigned long gpa, int level, unsigned long orig_pte,
+			  enum ept_access_op op)
 {
+	unsigned long pte;
+
+	pte = get_ept_pte(pml4, gpa, level, &pte);
 	set_ept_pte(pml4, gpa, level, orig_pte);
 	invept(INVEPT_SINGLE, eptp);
+
+	if (is_mbec_supported() && op == OP_EXEC) {
+		struct ept_access_test_data *data = &ept_access_test_data;
+		guest_page_table_twiddle(data->gva, 0, PT_USER_MASK);
+	}
 }
 
 static void do_ept_violation(bool leaf, enum ept_access_op op,
@@ -2370,8 +2412,12 @@ static void do_ept_violation(bool leaf, enum ept_access_op op,
 
 	qual = vmcs_read(EXI_QUALIFICATION);
 
-	/* Mask undefined bits (which may later be defined in certain cases). */
-	qual &= ~(EPT_VLT_GUEST_MASK | EPT_VLT_PERM_USER_EX);
+	/*
+	 * Exit-qualifications are masked not to account for advanced
+	 * VM-exit information. KVM supports this feature, so the tests
+	 * could be enhanced to cover it.
+	 */
+	qual &= ~EPT_VLT_GUEST_MASK;
 
 	diagnose_ept_violation_qual(expected_qual, qual);
 	TEST_EXPECT_EQ(expected_qual, qual);
@@ -2397,14 +2443,14 @@ ept_violation_at_level_mkhuge(bool mkhuge, int level, unsigned long clear,
 	struct ept_access_test_data *data = &ept_access_test_data;
 	unsigned long orig_pte;
 
-	orig_pte = ept_twiddle(data->gpa, mkhuge, level, clear, set);
+	orig_pte = ept_twiddle(data->gpa, mkhuge, level, clear, set, op);
 
 	do_ept_violation(level == 1 || mkhuge, op, expected_qual,
 			 (op == OP_EXEC || op == OP_EXEC_USER
 			  ? data->gpa + sizeof(unsigned long) : data->gpa));
 
 	/* Fix the violation and resume the op loop. */
-	ept_untwiddle(data->gpa, level, orig_pte);
+	ept_untwiddle(data->gpa, level, orig_pte, op);
 	enter_guest();
 	skip_exit_vmcall();
 }
@@ -2502,12 +2548,12 @@ static void ept_access_paddr(unsigned long ept_access, unsigned long pte_ad,
 	 */
 	install_ept(pml4, gpa, gpa, EPT_PRESENT);
 	orig_epte = ept_twiddle(gpa, /*mkhuge=*/0, /*level=*/1,
-				/*clear=*/EPT_PRESENT, /*set=*/ept_access);
+				/*clear=*/EPT_PRESENT, /*set=*/ept_access, op);
 
 	if (expect_violation) {
 		do_ept_violation(/*leaf=*/true, op,
 				 expected_qual | EPT_VLT_LADDR_VLD, gpa);
-		ept_untwiddle(gpa, /*level=*/1, orig_epte);
+		ept_untwiddle(gpa, /*level=*/1, orig_epte, op);
 		do_ept_access_op(op);
 	} else {
 		do_ept_access_op(op);
@@ -2522,7 +2568,7 @@ static void ept_access_paddr(unsigned long ept_access, unsigned long pte_ad,
 			}
 		}
 
-		ept_untwiddle(gpa, /*level=*/1, orig_epte);
+		ept_untwiddle(gpa, /*level=*/1, orig_epte, op);
 	}
 
 	TEST_ASSERT(*ptep & PT_ACCESSED_MASK);
@@ -2558,13 +2604,13 @@ static void ept_allowed_at_level_mkhuge(bool mkhuge, int level,
 	struct ept_access_test_data *data = &ept_access_test_data;
 	unsigned long orig_pte;
 
-	orig_pte = ept_twiddle(data->gpa, mkhuge, level, clear, set);
+	orig_pte = ept_twiddle(data->gpa, mkhuge, level, clear, set, op);
 
 	/* No violation. Should proceed to vmcall. */
 	do_ept_access_op(op);
 	skip_exit_vmcall();
 
-	ept_untwiddle(data->gpa, level, orig_pte);
+	ept_untwiddle(data->gpa, level, orig_pte, op);
 }
 
 static void ept_allowed_at_level(int level, unsigned long clear,
@@ -2613,7 +2659,7 @@ static void ept_misconfig_at_level_mkhuge_op(bool mkhuge, int level,
 	struct ept_access_test_data *data = &ept_access_test_data;
 	unsigned long orig_pte;
 
-	orig_pte = ept_twiddle(data->gpa, mkhuge, level, clear, set);
+	orig_pte = ept_twiddle(data->gpa, mkhuge, level, clear, set, op);
 
 	do_ept_access_op(op);
 	assert_exit_reason(VMX_EPT_MISCONFIG);
@@ -2637,7 +2683,7 @@ static void ept_misconfig_at_level_mkhuge_op(bool mkhuge, int level,
 	#endif
 
 	/* Fix the violation and resume the op loop. */
-	ept_untwiddle(data->gpa, level, orig_pte);
+	ept_untwiddle(data->gpa, level, orig_pte, op);
 	enter_guest();
 	skip_exit_vmcall();
 }
@@ -2867,7 +2913,12 @@ static void ept_access_test_execute_only(void)
 		ept_access_violation(EPT_EA, OP_WRITE,
 				     EPT_VLT_WR | EPT_VLT_PERM_EX);
 		ept_access_allowed(EPT_EA, OP_EXEC);
-		ept_access_allowed(EPT_EA, OP_EXEC_USER);
+		if (is_mbec_supported())
+			ept_access_violation(EPT_EA, OP_EXEC_USER,
+					     EPT_VLT_FETCH |
+					     EPT_VLT_PERM_EX);
+		else
+			ept_access_allowed(EPT_EA, OP_EXEC_USER);
 	} else {
 		ept_access_misconfig(EPT_EA);
 	}
@@ -2881,7 +2932,11 @@ static void ept_access_test_read_execute(void)
 	ept_access_violation(EPT_RA | EPT_EA, OP_WRITE,
 			     EPT_VLT_WR | EPT_VLT_PERM_RD | EPT_VLT_PERM_EX);
 	ept_access_allowed(EPT_RA | EPT_EA, OP_EXEC);
-	ept_access_allowed(EPT_RA | EPT_EA, OP_EXEC_USER);
+	if (is_mbec_supported())
+		ept_access_violation(EPT_RA | EPT_EA, OP_EXEC_USER,
+				     EPT_VLT_FETCH | EPT_VLT_PERM_RD | EPT_VLT_PERM_EX);
+	else
+		ept_access_allowed(EPT_RA | EPT_EA, OP_EXEC_USER);
 }
 
 static void ept_access_test_write_execute(void)
@@ -2898,7 +2953,11 @@ static void ept_access_test_read_write_execute(void)
 	ept_access_allowed(EPT_RA | EPT_WA | EPT_EA, OP_READ);
 	ept_access_allowed(EPT_RA | EPT_WA | EPT_EA, OP_WRITE);
 	ept_access_allowed(EPT_RA | EPT_WA | EPT_EA, OP_EXEC);
-	ept_access_allowed(EPT_RA | EPT_WA | EPT_EA, OP_EXEC_USER);
+	if (is_mbec_supported())
+		ept_access_violation(EPT_RA | EPT_WA | EPT_EA, OP_EXEC_USER,
+				     EPT_VLT_FETCH | EPT_VLT_PERM_RD | EPT_VLT_PERM_WR | EPT_VLT_PERM_EX);
+	else
+		ept_access_allowed(EPT_RA | EPT_WA | EPT_EA, OP_EXEC_USER);
 }
 
 static void ept_access_test_reserved_bits(void)
@@ -2955,7 +3014,8 @@ static void ept_access_test_ignored_bits(void)
 	 */
 	ept_ignored_bit(8);
 	ept_ignored_bit(9);
-	ept_ignored_bit(10);
+	if (!is_mbec_supported())
+		ept_ignored_bit(10);
 	ept_ignored_bit(11);
 	ept_ignored_bit(52);
 	ept_ignored_bit(53);
-- 
2.52.0


