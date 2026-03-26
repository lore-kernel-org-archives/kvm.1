Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37F03FE667
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536650; cv=none; b=GCyFeLV04rv9EJApiQH/4Aiwj3n1Av2GWN6g3q+7O+r0fejD7XoWJWyuz/CxKIdIbV4+GvPYXNuCXbrq+iATIM9ilLo3z3WIZjzvHzbg7B5gOCWhF6rtiitTL+mZxPgRwBnrYIQGTI1TMBB5oaH7Gy8qN1ZXbZhUTg9kShhjdn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536650; c=relaxed/simple;
	bh=YjitOjU0ywMuxg66gXbBYs0isEN68RzOY8JDU9CeRpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpAVhBCQQlp/qLWqdiT98bsCjjQjEzH3arxa8swldjw87c9xvDVHLd9d6Ai5ecWjscMbzkWUulQ4ExIShWN9LqNRyRQ/QS9blI8B0OGtjPHznrFrjNkOfGB0Uej93wUy7gNShtvSBOaFA6t68WRPithz/FMPg85qnViQRO9yzI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uv4Q7nNl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uv4Q7nNl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774536648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUBxrBVN6ln6/PZXMkPRbeMZ7NjFF/JgcOYD2kzh0R4=;
	b=Uv4Q7nNl+IJrNFtBiM63+kx3a0OubOKTWUBOyi43RSrmp182aDSrrMCeSxiWTx9trcRVFw
	l8x8kz4yo0aC8Jbrr1sqW8zNusBm5iNmX9D4+xK7CDziPp8nzhFjiA9MRX6V7xmBRazUqt
	rDghUrIITypGCnQsEfO9pl4QQuOSCrs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-j2mRpjS2NuOy6-wWomXamg-1; Thu,
 26 Mar 2026 10:50:44 -0400
X-MC-Unique: j2mRpjS2NuOy6-wWomXamg-1
X-Mimecast-MFC-AGG-ID: j2mRpjS2NuOy6-wWomXamg_1774536643
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7378C180035C;
	Thu, 26 Mar 2026 14:50:43 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.eng.rdu2.dc.redhat.com [10.6.68.74])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1BAA180075C;
	Thu, 26 Mar 2026 14:50:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH kvm-unit-tests 7/9] x86/vmx: add user execution operation to EPT access tests
Date: Thu, 26 Mar 2026 10:50:33 -0400
Message-ID: <20260326145035.119519-8-pbonzini@redhat.com>
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

Introduce a new ept_access_op, OP_EXEC_USER, to the EPT access tests to
prepare for MBEC, which allows execution of user-level code.

Since the tests do not support MBEC yet, the expected behavior is the
same as for OP_EXEC.

Co-authored-by: Jon Kohler <jon@nutanix.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/vmx_tests.c | 51 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index dbc456cb..023512e6 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -2285,6 +2285,7 @@ enum ept_access_op {
 	OP_READ,
 	OP_WRITE,
 	OP_EXEC,
+	OP_EXEC_USER,
 	OP_FLUSH_TLB,
 	OP_EXIT,
 };
@@ -2399,8 +2400,8 @@ ept_violation_at_level_mkhuge(bool mkhuge, int level, unsigned long clear,
 	orig_pte = ept_twiddle(data->gpa, mkhuge, level, clear, set);
 
 	do_ept_violation(level == 1 || mkhuge, op, expected_qual,
-			 op == OP_EXEC ? data->gpa + sizeof(unsigned long) :
-					 data->gpa);
+			 (op == OP_EXEC || op == OP_EXEC_USER
+			  ? data->gpa + sizeof(unsigned long) : data->gpa));
 
 	/* Fix the violation and resume the op loop. */
 	ept_untwiddle(data->gpa, level, orig_pte);
@@ -2589,11 +2590,13 @@ static void ept_ignored_bit(int bit)
 	ept_allowed(0, 1ul << bit, OP_READ);
 	ept_allowed(0, 1ul << bit, OP_WRITE);
 	ept_allowed(0, 1ul << bit, OP_EXEC);
+	ept_allowed(0, 1ul << bit, OP_EXEC_USER);
 
 	/* Clear the bit. */
 	ept_allowed(1ul << bit, 0, OP_READ);
 	ept_allowed(1ul << bit, 0, OP_WRITE);
 	ept_allowed(1ul << bit, 0, OP_EXEC);
+	ept_allowed(1ul << bit, 0, OP_EXEC_USER);
 }
 
 static void ept_access_allowed(unsigned long access, enum ept_access_op op)
@@ -2726,10 +2729,20 @@ static void ept_access_test_teardown(void *unused)
 	do_ept_access_op(OP_EXIT);
 }
 
+static u64 exec_user_on_gva(void)
+{
+	struct ept_access_test_data *data = &ept_access_test_data;
+	int (*code)(void) = (int (*)(void)) &data->gva[1];
+
+	return code();
+}
+
 static void ept_access_test_guest(void)
 {
 	struct ept_access_test_data *data = &ept_access_test_data;
 	int (*code)(void) = (int (*)(void)) &data->gva[1];
+	bool unused;
+	u64 ret_val;
 
 	while (true) {
 		switch (data->op) {
@@ -2744,6 +2757,11 @@ static void ept_access_test_guest(void)
 		case OP_EXEC:
 			TEST_ASSERT_EQ(42, code());
 			break;
+		case OP_EXEC_USER:
+			ret_val = run_in_user(exec_user_on_gva, DE_VECTOR, // no exceptions
+					      0, 0, 0, 0, &unused);
+			TEST_ASSERT_EQ(42, ret_val);
+			break;
 		case OP_FLUSH_TLB:
 			write_cr3(read_cr3());
 			break;
@@ -2803,6 +2821,7 @@ static void ept_access_test_not_present(void)
 	ept_access_violation(0, OP_READ, EPT_VLT_RD);
 	ept_access_violation(0, OP_WRITE, EPT_VLT_WR);
 	ept_access_violation(0, OP_EXEC, EPT_VLT_FETCH);
+	ept_access_violation(0, OP_EXEC_USER, EPT_VLT_FETCH);
 }
 
 static void ept_access_test_read_only(void)
@@ -2813,6 +2832,7 @@ static void ept_access_test_read_only(void)
 	ept_access_allowed(EPT_RA, OP_READ);
 	ept_access_violation(EPT_RA, OP_WRITE, EPT_VLT_WR | EPT_VLT_PERM_RD);
 	ept_access_violation(EPT_RA, OP_EXEC, EPT_VLT_FETCH | EPT_VLT_PERM_RD);
+	ept_access_violation(EPT_RA, OP_EXEC_USER, EPT_VLT_FETCH | EPT_VLT_PERM_RD);
 }
 
 static void ept_access_test_write_only(void)
@@ -2829,7 +2849,11 @@ static void ept_access_test_read_write(void)
 	ept_access_allowed(EPT_RA | EPT_WA, OP_READ);
 	ept_access_allowed(EPT_RA | EPT_WA, OP_WRITE);
 	ept_access_violation(EPT_RA | EPT_WA, OP_EXEC,
-			   EPT_VLT_FETCH | EPT_VLT_PERM_RD | EPT_VLT_PERM_WR);
+			     EPT_VLT_FETCH | EPT_VLT_PERM_RD |
+			     EPT_VLT_PERM_WR);
+	ept_access_violation(EPT_RA | EPT_WA, OP_EXEC_USER,
+			     EPT_VLT_FETCH | EPT_VLT_PERM_RD |
+			     EPT_VLT_PERM_WR);
 }
 
 
@@ -2843,6 +2867,7 @@ static void ept_access_test_execute_only(void)
 		ept_access_violation(EPT_EA, OP_WRITE,
 				     EPT_VLT_WR | EPT_VLT_PERM_EX);
 		ept_access_allowed(EPT_EA, OP_EXEC);
+		ept_access_allowed(EPT_EA, OP_EXEC_USER);
 	} else {
 		ept_access_misconfig(EPT_EA);
 	}
@@ -2854,8 +2879,9 @@ static void ept_access_test_read_execute(void)
 	/* r-x */
 	ept_access_allowed(EPT_RA | EPT_EA, OP_READ);
 	ept_access_violation(EPT_RA | EPT_EA, OP_WRITE,
-			   EPT_VLT_WR | EPT_VLT_PERM_RD | EPT_VLT_PERM_EX);
+			     EPT_VLT_WR | EPT_VLT_PERM_RD | EPT_VLT_PERM_EX);
 	ept_access_allowed(EPT_RA | EPT_EA, OP_EXEC);
+	ept_access_allowed(EPT_RA | EPT_EA, OP_EXEC_USER);
 }
 
 static void ept_access_test_write_execute(void)
@@ -2872,6 +2898,7 @@ static void ept_access_test_read_write_execute(void)
 	ept_access_allowed(EPT_RA | EPT_WA | EPT_EA, OP_READ);
 	ept_access_allowed(EPT_RA | EPT_WA | EPT_EA, OP_WRITE);
 	ept_access_allowed(EPT_RA | EPT_WA | EPT_EA, OP_EXEC);
+	ept_access_allowed(EPT_RA | EPT_WA | EPT_EA, OP_EXEC_USER);
 }
 
 static void ept_access_test_reserved_bits(void)
@@ -2952,6 +2979,7 @@ static void ept_access_test_paddr_not_present_ad_disabled(void)
 	ept_access_violation_paddr(0, PT_AD_MASK, OP_READ, EPT_VLT_RD);
 	ept_access_violation_paddr(0, PT_AD_MASK, OP_WRITE, EPT_VLT_RD);
 	ept_access_violation_paddr(0, PT_AD_MASK, OP_EXEC, EPT_VLT_RD);
+	ept_access_violation_paddr(0, PT_AD_MASK, OP_EXEC_USER, EPT_VLT_RD);
 }
 
 static void ept_access_test_paddr_not_present_ad_enabled(void)
@@ -2964,6 +2992,7 @@ static void ept_access_test_paddr_not_present_ad_enabled(void)
 	ept_access_violation_paddr(0, PT_AD_MASK, OP_READ, qual);
 	ept_access_violation_paddr(0, PT_AD_MASK, OP_WRITE, qual);
 	ept_access_violation_paddr(0, PT_AD_MASK, OP_EXEC, qual);
+	ept_access_violation_paddr(0, PT_AD_MASK, OP_EXEC_USER, qual);
 }
 
 static void ept_access_test_paddr_read_only_ad_disabled(void)
@@ -2983,14 +3012,17 @@ static void ept_access_test_paddr_read_only_ad_disabled(void)
 	ept_access_violation_paddr(EPT_RA, 0, OP_READ, qual);
 	ept_access_violation_paddr(EPT_RA, 0, OP_WRITE, qual);
 	ept_access_violation_paddr(EPT_RA, 0, OP_EXEC, qual);
+	ept_access_violation_paddr(EPT_RA, 0, OP_EXEC_USER, qual);
 	/* AD bits disabled, so only writes try to update the D bit. */
 	ept_access_allowed_paddr(EPT_RA, PT_ACCESSED_MASK, OP_READ);
 	ept_access_violation_paddr(EPT_RA, PT_ACCESSED_MASK, OP_WRITE, qual);
 	ept_access_allowed_paddr(EPT_RA, PT_ACCESSED_MASK, OP_EXEC);
+	ept_access_allowed_paddr(EPT_RA, PT_ACCESSED_MASK, OP_EXEC_USER);
 	/* Both A and D already set, so read-only is OK. */
 	ept_access_allowed_paddr(EPT_RA, PT_AD_MASK, OP_READ);
 	ept_access_allowed_paddr(EPT_RA, PT_AD_MASK, OP_WRITE);
 	ept_access_allowed_paddr(EPT_RA, PT_AD_MASK, OP_EXEC);
+	ept_access_allowed_paddr(EPT_RA, PT_AD_MASK, OP_EXEC_USER);
 }
 
 static void ept_access_test_paddr_read_only_ad_enabled(void)
@@ -3008,12 +3040,15 @@ static void ept_access_test_paddr_read_only_ad_enabled(void)
 	ept_access_violation_paddr(EPT_RA, 0, OP_READ, qual);
 	ept_access_violation_paddr(EPT_RA, 0, OP_WRITE, qual);
 	ept_access_violation_paddr(EPT_RA, 0, OP_EXEC, qual);
+	ept_access_violation_paddr(EPT_RA, 0, OP_EXEC_USER, qual);
 	ept_access_violation_paddr(EPT_RA, PT_ACCESSED_MASK, OP_READ, qual);
 	ept_access_violation_paddr(EPT_RA, PT_ACCESSED_MASK, OP_WRITE, qual);
 	ept_access_violation_paddr(EPT_RA, PT_ACCESSED_MASK, OP_EXEC, qual);
+	ept_access_violation_paddr(EPT_RA, PT_ACCESSED_MASK, OP_EXEC_USER, qual);
 	ept_access_violation_paddr(EPT_RA, PT_AD_MASK, OP_READ, qual);
 	ept_access_violation_paddr(EPT_RA, PT_AD_MASK, OP_WRITE, qual);
 	ept_access_violation_paddr(EPT_RA, PT_AD_MASK, OP_EXEC, qual);
+	ept_access_violation_paddr(EPT_RA, PT_AD_MASK, OP_EXEC_USER, qual);
 }
 
 static void ept_access_test_paddr_read_write(void)
@@ -3023,6 +3058,7 @@ static void ept_access_test_paddr_read_write(void)
 	ept_access_allowed_paddr(EPT_RA | EPT_WA, 0, OP_READ);
 	ept_access_allowed_paddr(EPT_RA | EPT_WA, 0, OP_WRITE);
 	ept_access_allowed_paddr(EPT_RA | EPT_WA, 0, OP_EXEC);
+	ept_access_allowed_paddr(EPT_RA | EPT_WA, 0, OP_EXEC_USER);
 }
 
 static void ept_access_test_paddr_read_write_execute(void)
@@ -3032,6 +3068,7 @@ static void ept_access_test_paddr_read_write_execute(void)
 	ept_access_allowed_paddr(EPT_RA | EPT_WA | EPT_EA, 0, OP_READ);
 	ept_access_allowed_paddr(EPT_RA | EPT_WA | EPT_EA, 0, OP_WRITE);
 	ept_access_allowed_paddr(EPT_RA | EPT_WA | EPT_EA, 0, OP_EXEC);
+	ept_access_allowed_paddr(EPT_RA | EPT_WA | EPT_EA, 0, OP_EXEC_USER);
 }
 
 static void ept_access_test_paddr_read_execute_ad_disabled(void)
@@ -3051,14 +3088,17 @@ static void ept_access_test_paddr_read_execute_ad_disabled(void)
 	ept_access_violation_paddr(EPT_RA | EPT_EA, 0, OP_READ, qual);
 	ept_access_violation_paddr(EPT_RA | EPT_EA, 0, OP_WRITE, qual);
 	ept_access_violation_paddr(EPT_RA | EPT_EA, 0, OP_EXEC, qual);
+	ept_access_violation_paddr(EPT_RA | EPT_EA, 0, OP_EXEC_USER, qual);
 	/* AD bits disabled, so only writes try to update the D bit. */
 	ept_access_allowed_paddr(EPT_RA | EPT_EA, PT_ACCESSED_MASK, OP_READ);
 	ept_access_violation_paddr(EPT_RA | EPT_EA, PT_ACCESSED_MASK, OP_WRITE, qual);
 	ept_access_allowed_paddr(EPT_RA | EPT_EA, PT_ACCESSED_MASK, OP_EXEC);
+	ept_access_allowed_paddr(EPT_RA | EPT_EA, PT_ACCESSED_MASK, OP_EXEC_USER);
 	/* Both A and D already set, so read-only is OK. */
 	ept_access_allowed_paddr(EPT_RA | EPT_EA, PT_AD_MASK, OP_READ);
 	ept_access_allowed_paddr(EPT_RA | EPT_EA, PT_AD_MASK, OP_WRITE);
 	ept_access_allowed_paddr(EPT_RA | EPT_EA, PT_AD_MASK, OP_EXEC);
+	ept_access_allowed_paddr(EPT_RA | EPT_EA, PT_AD_MASK, OP_EXEC_USER);
 }
 
 static void ept_access_test_paddr_read_execute_ad_enabled(void)
@@ -3076,12 +3116,15 @@ static void ept_access_test_paddr_read_execute_ad_enabled(void)
 	ept_access_violation_paddr(EPT_RA | EPT_EA, 0, OP_READ, qual);
 	ept_access_violation_paddr(EPT_RA | EPT_EA, 0, OP_WRITE, qual);
 	ept_access_violation_paddr(EPT_RA | EPT_EA, 0, OP_EXEC, qual);
+	ept_access_violation_paddr(EPT_RA | EPT_EA, 0, OP_EXEC_USER, qual);
 	ept_access_violation_paddr(EPT_RA | EPT_EA, PT_ACCESSED_MASK, OP_READ, qual);
 	ept_access_violation_paddr(EPT_RA | EPT_EA, PT_ACCESSED_MASK, OP_WRITE, qual);
 	ept_access_violation_paddr(EPT_RA | EPT_EA, PT_ACCESSED_MASK, OP_EXEC, qual);
+	ept_access_violation_paddr(EPT_RA | EPT_EA, PT_ACCESSED_MASK, OP_EXEC_USER, qual);
 	ept_access_violation_paddr(EPT_RA | EPT_EA, PT_AD_MASK, OP_READ, qual);
 	ept_access_violation_paddr(EPT_RA | EPT_EA, PT_AD_MASK, OP_WRITE, qual);
 	ept_access_violation_paddr(EPT_RA | EPT_EA, PT_AD_MASK, OP_EXEC, qual);
+	ept_access_violation_paddr(EPT_RA | EPT_EA, PT_AD_MASK, OP_EXEC_USER, qual);
 }
 
 static void ept_access_test_paddr_not_present_page_fault(void)
-- 
2.52.0


