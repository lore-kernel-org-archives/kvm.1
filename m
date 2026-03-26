Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984AE3FE660
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536650; cv=none; b=n4hg/KNoSR/KiBzO5zRL6RltZpEvQoKri+OqZzT1RFBsK1/mGq/xpoSU2oxG9u5FyfU2/GWykblS8ftkuMcjNagn34j7x7FKRLO/lCtFja2wBIta2ATe5j7+/niIqHlS20+meS19J2+tfmOM4RHITEPEFT7fz4dRGUrCqsorTAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536650; c=relaxed/simple;
	bh=4SH0tUL81OqtnKAEQFZmfSzfp7qD4Ejp7r027LUei1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqeXb/Rth3Q2Zs0ipOswNSAb3m2EQO4DEOswaZuye2YsyDEKx6ZbBcq1zaG51cxZek2/atwigq2MC8JSTQNecpUIskcF4aOMopNjcckOwU+FZYxgJGbKXwTvYw06IkXN/2glletUSqtBF9iy8I81bqN/+TRFKWL/za2ymDKzVe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQKz7amb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQKz7amb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774536647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fA0FMWauda9Fpz17m5zCa4BfJK737AG5sib/q/f5ZdM=;
	b=CQKz7ambJr5uyWpc1whgD6l5vqxmvEakRr2JpjQyqoouGAORmk/V0wqmHzna+eTd1H8If3
	Ive3qrmLEPqzYwsNTs1IKdHlvTzEz1KAs9sl0LrpNlO5Jab53oS8gsecFhhkYbPkxDQa1p
	yTur2ZYGdsOKX9UpN8G1Dx8iO13R2Og=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-Sfcwwr5sObS3HvyfBqmXtA-1; Thu,
 26 Mar 2026 10:50:43 -0400
X-MC-Unique: Sfcwwr5sObS3HvyfBqmXtA-1
X-Mimecast-MFC-AGG-ID: Sfcwwr5sObS3HvyfBqmXtA_1774536641
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD0BA195609E;
	Thu, 26 Mar 2026 14:50:41 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.eng.rdu2.dc.redhat.com [10.6.68.74])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1798018001FE;
	Thu, 26 Mar 2026 14:50:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH kvm-unit-tests 5/9] x86/vmx: diagnose unexpected EPT violations
Date: Thu, 26 Mar 2026 10:50:31 -0400
Message-ID: <20260326145035.119519-6-pbonzini@redhat.com>
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

Knowing the exit qualification when a test incorrectly raises an
EPT violation greatly simplifies debugging.  This requires a tweak to
__TEST_EQ, allowing any code block instead of just a function name for
the abort code.

For this particular case, include advanced vmexit info in the diagnosis.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 lib/util.h      | 10 +++-----
 x86/vmx.h       |  8 +++---
 x86/vmx_tests.c | 65 ++++++++++++++++++++++++++++---------------------
 3 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/lib/util.h b/lib/util.h
index 00d0b47d..93f16410 100644
--- a/lib/util.h
+++ b/lib/util.h
@@ -41,17 +41,13 @@ do {											\
 			    (unsigned long) _b, _bin_b, (unsigned long) _b,		\
 			    fmt[0] == '\0' ? "" : "\n", ## args);			\
 		dump_stack();								\
-		if (assertion)								\
-			do_abort();							\
+		if (assertion) { do_abort; }						\
 	}										\
 	report_passed();								\
 } while (0)
 
-/* FIXME: Extend VMX's assert/abort framework to SVM and other environs. */
-static inline void dummy_abort(void) {}
-
-#define TEST_EXPECT_EQ(a, b) __TEST_EQ(a, b, #a, #b, 0, dummy_abort, "")
+#define TEST_EXPECT_EQ(a, b) __TEST_EQ(a, b, #a, #b, 0, , "")
 #define TEST_EXPECT_EQ_MSG(a, b, fmt, args...) \
-	__TEST_EQ(a, b, #a, #b, 0, dummy_abort fmt, ## args)
+	__TEST_EQ(a, b, #a, #b, 0, fmt, ## args)
 
 #endif
diff --git a/x86/vmx.h b/x86/vmx.h
index d9f493d3..0e29a57d 100644
--- a/x86/vmx.h
+++ b/x86/vmx.h
@@ -37,9 +37,9 @@ do {								\
 	report_passed();					\
 } while (0)
 
-#define TEST_ASSERT_EQ(a, b) __TEST_EQ(a, b, #a, #b, 1, __abort_test, "")
+#define TEST_ASSERT_EQ(a, b) __TEST_EQ(a, b, #a, #b, 1, __abort_test(), "")
 #define TEST_ASSERT_EQ_MSG(a, b, fmt, args...) \
-	__TEST_EQ(a, b, #a, #b, 1, __abort_test, fmt, ## args)
+	__TEST_EQ(a, b, #a, #b, 1, __abort_test(), fmt, ## args)
 
 struct vmcs_hdr {
 	u32 revision_id:31;
@@ -718,9 +718,9 @@ enum vm_entry_failure_code {
 #define EPT_VLT_PADDR		(1ull << 8)
 #define EPT_VLT_GUEST_USER	(1ull << 9)
 #define EPT_VLT_GUEST_RW	(1ull << 10)
-#define EPT_VLT_GUEST_EX	(1ull << 11)
+#define EPT_VLT_GUEST_NX	(1ull << 11)
 #define EPT_VLT_GUEST_MASK	(EPT_VLT_GUEST_USER | EPT_VLT_GUEST_RW | \
-				 EPT_VLT_GUEST_EX)
+				 EPT_VLT_GUEST_NX)
 
 #define MAGIC_VAL_1		0x12345678ul
 #define MAGIC_VAL_2		0x87654321ul
diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 707e8ca4..0e3dca3c 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -2157,13 +2157,46 @@ static int exit_monitor_from_l2_handler(union exit_reason exit_reason)
 	return VMX_TEST_EXIT;
 }
 
+static void
+diagnose_ept_violation_qual(u64 expected, u64 actual)
+{
+
+#define DIAGNOSE(flag)							\
+do {									\
+	if ((expected & flag) != (actual & flag))			\
+		printf(#flag " %sexpected\n",				\
+		       (expected & flag) ? "" : "un");			\
+} while (0)
+
+	DIAGNOSE(EPT_VLT_RD);
+	DIAGNOSE(EPT_VLT_WR);
+	DIAGNOSE(EPT_VLT_FETCH);
+	DIAGNOSE(EPT_VLT_PERM_RD);
+	DIAGNOSE(EPT_VLT_PERM_WR);
+	DIAGNOSE(EPT_VLT_PERM_EX);
+	DIAGNOSE(EPT_VLT_LADDR_VLD);
+	DIAGNOSE(EPT_VLT_PADDR);
+	DIAGNOSE(EPT_VLT_GUEST_USER);
+	DIAGNOSE(EPT_VLT_GUEST_RW);
+	DIAGNOSE(EPT_VLT_GUEST_NX);
+
+#undef DIAGNOSE
+}
+
 static void assert_exit_reason(u64 expected)
 {
 	u64 actual = vmcs_read(EXI_REASON);
 
-	TEST_ASSERT_EQ_MSG(expected, actual, "Expected %s, got %s.",
-			   exit_reason_description(expected),
-			   exit_reason_description(actual));
+        __TEST_EQ(expected, actual, "expected", "actual", 1, {
+		printf("guest linear address %lx\n", vmcs_read(GUEST_LINEAR_ADDRESS));
+		if (actual == VMX_EPT_VIOLATION) {
+			u64 qual = vmcs_read(EXI_QUALIFICATION);
+			diagnose_ept_violation_qual(0, qual);
+		}
+		__abort_test();
+	}, "Expected %s, got %s.",
+		   exit_reason_description(expected),
+		   exit_reason_description(actual));
 }
 
 static void skip_exit_insn(void)
@@ -2276,29 +2309,6 @@ asm(
 	"ret42_end:\n"
 );
 
-static void
-diagnose_ept_violation_qual(u64 expected, u64 actual)
-{
-
-#define DIAGNOSE(flag)							\
-do {									\
-	if ((expected & flag) != (actual & flag))			\
-		printf(#flag " %sexpected\n",				\
-		       (expected & flag) ? "" : "un");			\
-} while (0)
-
-	DIAGNOSE(EPT_VLT_RD);
-	DIAGNOSE(EPT_VLT_WR);
-	DIAGNOSE(EPT_VLT_FETCH);
-	DIAGNOSE(EPT_VLT_PERM_RD);
-	DIAGNOSE(EPT_VLT_PERM_WR);
-	DIAGNOSE(EPT_VLT_PERM_EX);
-	DIAGNOSE(EPT_VLT_LADDR_VLD);
-	DIAGNOSE(EPT_VLT_PADDR);
-
-#undef DIAGNOSE
-}
-
 static void do_ept_access_op(enum ept_access_op op)
 {
 	ept_access_test_data.op = op;
@@ -2360,8 +2370,7 @@ static void do_ept_violation(bool leaf, enum ept_access_op op,
 	qual = vmcs_read(EXI_QUALIFICATION);
 
 	/* Mask undefined bits (which may later be defined in certain cases). */
-	qual &= ~(EPT_VLT_GUEST_USER | EPT_VLT_GUEST_RW | EPT_VLT_GUEST_EX |
-		 EPT_VLT_PERM_USER_EX);
+	qual &= ~(EPT_VLT_GUEST_MASK | EPT_VLT_PERM_USER_EX);
 
 	diagnose_ept_violation_qual(expected_qual, qual);
 	TEST_EXPECT_EQ(expected_qual, qual);
-- 
2.52.0


