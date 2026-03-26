Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBC63FBEAF
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536652; cv=none; b=uPZIACh4WGLJWm3pjzX4XHbaIUaY4capxaobG60BvouDNi0Mv/p8/rKtVfF+ImgVPipiEF4daD1cwnH81OVlI2JdnGryVEI9N6STCX7dSKSAwRUMR72VmQCIXK+CnjH6esq6f/us/zJVuXu1+RKeEwlXFSDC24ZmlcVE90XNA30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536652; c=relaxed/simple;
	bh=QJoaflTQbWyAwWrg5GsEtNIOZFVMY5I26gBKvQ6NZUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTVLPi4RAEmncifhWjvekCUnWWv+EwiPxzVuM2BrhdDuHTyf1MgWq56UW4SlBf1lBSYHHQU5ZK8/WyW02TRV+KacnXOf+oZvF2v2SInvU5HB/1m0g0loriRrw1koXpGPz5Ih2hHy//lgGRpjrroQ+ohx1HMC/LviunNg/H69hjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6xUyoOi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6xUyoOi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774536649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJKwuv/l0D2EnoL02tADQhh8k56LjgfLUpSEEC9fuEg=;
	b=f6xUyoOiDsmi/R+dkbSNd1zWQWOG7/zzxn97SIwrvpTMj8IcEXJFSpuB5qMKnEXco08xK0
	R6M1FGjvXHo4OhoxoxwSOLOd+Hr6BOlzon/ffz9vYZ2yBX2AucuwTsrdldudJLCfm//o4s
	It/bgOt9t3CzBsxwRLiIU6OcqUBCc7E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-JddhxOh-NYeWuwRUrNi3SQ-1; Thu,
 26 Mar 2026 10:50:46 -0400
X-MC-Unique: JddhxOh-NYeWuwRUrNi3SQ-1
X-Mimecast-MFC-AGG-ID: JddhxOh-NYeWuwRUrNi3SQ_1774536645
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28C3E18005BB;
	Thu, 26 Mar 2026 14:50:45 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.eng.rdu2.dc.redhat.com [10.6.68.74])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 794F3180036E;
	Thu, 26 Mar 2026 14:50:44 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH kvm-unit-tests 9/9] x86/vmx: add EPT tests covering XU permission
Date: Thu, 26 Mar 2026 10:50:35 -0400
Message-ID: <20260326145035.119519-10-pbonzini@redhat.com>
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

Add tests to validate MBEC execute access when XU=1, with and without XS=1.

Co-authored-by: Jon Kohler <jon@nutanix.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/vmx_tests.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index bf03451a..a47e8470 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -2924,6 +2924,52 @@ static void ept_access_test_execute_only(void)
 	}
 }
 
+static void ept_access_test_execute_user_only(void)
+{
+	if (!is_mbec_supported()) {
+		report_skip("MBEC not supported");
+		return;
+	}
+
+	ept_access_test_setup();
+	/* --x (exec user only) */
+	if (ept_execute_only_supported()) {
+		ept_access_violation(EPT_EA_USER, OP_READ,
+				     EPT_VLT_RD |
+				     EPT_VLT_PERM_USER_EX);
+		ept_access_violation(EPT_EA_USER, OP_WRITE,
+				     EPT_VLT_WR |
+				     EPT_VLT_PERM_USER_EX);
+		ept_access_violation(EPT_EA_USER, OP_EXEC,
+				     EPT_VLT_FETCH |
+				     EPT_VLT_PERM_USER_EX);
+		ept_access_allowed(EPT_EA_USER, OP_EXEC_USER);
+	} else {
+		ept_access_misconfig(EPT_EA_USER);
+	}
+}
+
+static void ept_access_test_execute_both(void)
+{
+	if (!is_mbec_supported()) {
+		report_skip("MBEC not supported");
+		return;
+	}
+
+	ept_access_test_setup();
+	/* --x (both XS and XU) */
+	if (ept_execute_only_supported()) {
+		ept_access_violation(EPT_EA | EPT_EA_USER, OP_READ,
+				     EPT_VLT_RD | EPT_VLT_PERM_EX | EPT_VLT_PERM_USER_EX);
+		ept_access_violation(EPT_EA | EPT_EA_USER, OP_WRITE,
+				     EPT_VLT_WR | EPT_VLT_PERM_EX | EPT_VLT_PERM_USER_EX);
+		ept_access_allowed(EPT_EA | EPT_EA_USER, OP_EXEC);
+		ept_access_allowed(EPT_EA | EPT_EA_USER, OP_EXEC_USER);
+	} else {
+		ept_access_misconfig(EPT_EA | EPT_EA_USER);
+	}
+}
+
 static void ept_access_test_read_execute(void)
 {
 	ept_access_test_setup();
@@ -2939,6 +2985,43 @@ static void ept_access_test_read_execute(void)
 		ept_access_allowed(EPT_RA | EPT_EA, OP_EXEC_USER);
 }
 
+static void ept_access_test_read_execute_user_only(void)
+{
+	if (!is_mbec_supported()) {
+		report_skip("MBEC not supported");
+		return;
+	}
+
+	ept_access_test_setup();
+	/* r-x (exec user only) */
+	ept_access_allowed(EPT_RA | EPT_EA_USER, OP_READ);
+	ept_access_violation(EPT_RA | EPT_EA_USER, OP_WRITE,
+			     EPT_VLT_WR | EPT_VLT_PERM_RD |
+			     EPT_VLT_PERM_USER_EX);
+	ept_access_violation(EPT_RA | EPT_EA_USER, OP_EXEC,
+			     EPT_VLT_FETCH | EPT_VLT_PERM_RD |
+			     EPT_VLT_PERM_USER_EX);
+	ept_access_allowed(EPT_RA | EPT_EA_USER, OP_EXEC_USER);
+}
+
+static void ept_access_test_read_execute_both(void)
+{
+	if (!is_mbec_supported()) {
+		report_skip("MBEC not supported");
+		return;
+	}
+
+	ept_access_test_setup();
+	/* r-x (both XS and XU) */
+	ept_access_allowed(EPT_RA | EPT_EA | EPT_EA_USER, OP_READ);
+	ept_access_violation(EPT_RA | EPT_EA | EPT_EA_USER, OP_WRITE,
+			     EPT_VLT_WR | EPT_VLT_PERM_RD |
+			     EPT_VLT_PERM_EX | EPT_VLT_PERM_USER_EX);
+	ept_access_allowed(EPT_RA | EPT_EA | EPT_EA_USER, OP_EXEC);
+	ept_access_allowed(EPT_RA | EPT_EA | EPT_EA_USER, OP_EXEC_USER);
+}
+
+
 static void ept_access_test_write_execute(void)
 {
 	ept_access_test_setup();
@@ -2960,6 +3043,37 @@ static void ept_access_test_read_write_execute(void)
 		ept_access_allowed(EPT_RA | EPT_WA | EPT_EA, OP_EXEC_USER);
 }
 
+static void ept_access_test_read_write_execute_user_only(void)
+{
+	if (!is_mbec_supported()) {
+		report_skip("MBEC not supported");
+		return;
+	}
+
+	ept_access_test_setup();
+	/* rwx (exec user only) */
+	ept_access_allowed(EPT_RA | EPT_WA | EPT_EA_USER, OP_READ);
+	ept_access_allowed(EPT_RA | EPT_WA | EPT_EA_USER, OP_WRITE);
+	ept_access_violation(EPT_RA | EPT_WA | EPT_EA_USER, OP_EXEC,
+			     EPT_VLT_FETCH | EPT_VLT_PERM_RD | EPT_VLT_PERM_WR | EPT_VLT_PERM_USER_EX);
+	ept_access_allowed(EPT_RA | EPT_WA | EPT_EA_USER, OP_EXEC_USER);
+}
+
+static void ept_access_test_read_write_execute_both(void)
+{
+	if (!is_mbec_supported()) {
+		report_skip("MBEC not supported");
+		return;
+	}
+
+	ept_access_test_setup();
+	/* rwx (both XS and XU) */
+	ept_access_allowed(EPT_RA | EPT_WA | EPT_EA | EPT_EA_USER, OP_READ);
+	ept_access_allowed(EPT_RA | EPT_WA | EPT_EA | EPT_EA_USER, OP_WRITE);
+	ept_access_allowed(EPT_RA | EPT_WA | EPT_EA | EPT_EA_USER, OP_EXEC);
+	ept_access_allowed(EPT_RA | EPT_WA | EPT_EA | EPT_EA_USER, OP_EXEC_USER);
+}
+
 static void ept_access_test_reserved_bits(void)
 {
 	int i;
@@ -11722,9 +11836,15 @@ struct vmx_test vmx_tests[] = {
 	TEST(ept_access_test_write_only),
 	TEST(ept_access_test_read_write),
 	TEST(ept_access_test_execute_only),
+	TEST(ept_access_test_execute_user_only),
+	TEST(ept_access_test_execute_both),
 	TEST(ept_access_test_read_execute),
+	TEST(ept_access_test_read_execute_user_only),
+	TEST(ept_access_test_read_execute_both),
 	TEST(ept_access_test_write_execute),
 	TEST(ept_access_test_read_write_execute),
+	TEST(ept_access_test_read_write_execute_user_only),
+	TEST(ept_access_test_read_write_execute_both),
 	TEST(ept_access_test_reserved_bits),
 	TEST(ept_access_test_ignored_bits),
 	TEST(ept_access_test_paddr_not_present_ad_disabled),
-- 
2.52.0

