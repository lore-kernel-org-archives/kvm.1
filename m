Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D2E39D6D4
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536649; cv=none; b=ABkSVA7hxKWg2JEbJou6aFRWH523YJD/cbdqLz5q16J8n732i7UuQ3EitPBHOH6LcS2Mzqp/wsZjxKit49pfN/3qMN74+KxM4vgPUZlbZcL7x+Hl/2cVO4ogNfKyXKlAwo2mgv1RDMboXjmLWhPUE3IKnQXWgnd2FODZ4qIOaIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536649; c=relaxed/simple;
	bh=7ukQYmSDa7tI02PDc9mH5B/nRfC9xmEO7FtyKiP7Hr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlydI903gx51xIdlYdxBy+WX+Is110Buufm1tdOXxu5Ovg2QzryE+Ch3nJrJpCqCL7m2FH8mh72CPpP8CwemwOgZj8d8HjqBYnkkiypQeZmE40a/sZv7dQXUX7Ic0B5YQnsZKL07jYLpAoPx+pswODVI8iGgByfump4ttAIwtcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QC4qwIdR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QC4qwIdR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774536647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8A33S7zM4JP6choVLSyjNDm+YLEdbpOizGwKKY408Qs=;
	b=QC4qwIdRiT8ONvBZ4fJc8FVNGHwXPGDCpPiixylrp8YNbn31QQ1d0efxEFiYWHnBwvNC0T
	ML/ro8hJ2JBaun9XbatmLHYATJRfy7Pm0JRcrokEDwf7spCqve9WBcoDXl1YvmMaHQFyij
	U8K5sCg9HHZSIAo5Q3xMbCh2cRTrJ4E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-epNxmPyiPZSkckhybPv3mA-1; Thu,
 26 Mar 2026 10:50:43 -0400
X-MC-Unique: epNxmPyiPZSkckhybPv3mA-1
X-Mimecast-MFC-AGG-ID: epNxmPyiPZSkckhybPv3mA_1774536642
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9798318005B6;
	Thu, 26 Mar 2026 14:50:42 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.eng.rdu2.dc.redhat.com [10.6.68.74])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E6EB518001FE;
	Thu, 26 Mar 2026 14:50:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH kvm-unit-tests 6/9] x86/vmx: add mode-based execute control test for Skylake and above
Date: Thu, 26 Mar 2026 10:50:32 -0400
Message-ID: <20260326145035.119519-7-pbonzini@redhat.com>
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

Introduce a new test for mode-based execute control (MBEC) in the VMX
controls, validating the dependency between MBEC and EPT VM-execution
controls. The test ensures that VM entry fails when MBEC is enabled
without EPT, and succeeds in valid combinations.

Update the unit test configuration to include a specific test case for
MBEC on Skylake-Server CPU model, as that was the first CPU series to
have MBEC.

Passing test result
Test suite: vmx_controls_test_mbec
PASS: MBEC disabled, EPT disabled (valid combination): vmlaunch succeeds
PASS: MBEC enabled, EPT disabled (invalid combination): vmlaunch fails
PASS: MBEC enabled, EPT disabled (invalid combination): VMX inst error is 7 (actual 7)
PASS: MBEC enabled, EPT enabled (valid combination): vmlaunch succeeds
PASS: MBEC disabled, EPT enabled (valid combination): vmlaunch succeeds

Test ran with "-vmx-mbec":
Test suite: vmx_controls_test_mbec
SKIP: test_mode_based_execute_control : "Secondary execution" or
"enable EPT" or "enable mode-based execute control" control not supported

Co-authored-by: Jon Kohler <jon@nutanix.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/unittests.cfg |  9 +++++++
 x86/vmx.h         |  8 ++++++
 x86/vmx_tests.c   | 64 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/x86/unittests.cfg b/x86/unittests.cfg
index 522318d3..b82bbc4e 100644
--- a/x86/unittests.cfg
+++ b/x86/unittests.cfg
@@ -324,6 +324,15 @@ qemu_params = -cpu max,+vmx
 arch = x86_64
 groups = vmx
 
+# VMX controls is a generic test; however, mode-based execute control
+# aka MBEC is only available on Skylake and above, be specific about
+# the CPU model and test it directly.
+[vmx_controls_test_mbec]
+file = vmx.flat
+extra_params = -cpu Skylake-Server,+vmx,+vmx-mbec -append "vmx_controls_test_mbec"
+arch = x86_64
+groups = vmx
+
 [ept]
 file = vmx.flat
 test_args = "ept_access*"
diff --git a/x86/vmx.h b/x86/vmx.h
index 0e29a57d..b492ec74 100644
--- a/x86/vmx.h
+++ b/x86/vmx.h
@@ -510,6 +510,7 @@ enum Ctrl1 {
 	CPU_SHADOW_VMCS		= 1ul << 14,
 	CPU_RDSEED		= 1ul << 16,
 	CPU_PML                 = 1ul << 17,
+	CPU_MODE_BASED_EPT_EXEC = 1ul << 22,
 	CPU_USE_TSC_SCALING	= 1ul << 25,
 };
 
@@ -843,6 +844,13 @@ static inline bool is_invvpid_type_supported(unsigned long type)
 	return ept_vpid.val & (VPID_CAP_INVVPID_ADDR << (type - INVVPID_ADDR));
 }
 
+static inline bool is_mbec_supported(void)
+{
+	return (ctrl_cpu_rev[0].clr & CPU_SECONDARY) &&
+	       (ctrl_cpu_rev[1].clr & CPU_EPT) &&
+	       (ctrl_cpu_rev[1].clr & CPU_MODE_BASED_EPT_EXEC);
+}
+
 extern u64 *bsp_vmxon_region;
 extern bool launched;
 
diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 0e3dca3c..dbc456cb 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -4876,6 +4876,69 @@ skip_unrestricted_guest:
 	vmcs_write(EPTP, eptp_saved);
 }
 
+/*
+ * Test the dependency between mode-based execute control for EPT (MBEC) and
+ * enable EPT VM-execution controls.
+ *
+ * When MBEC (bit 22 of secondary processor-based VM-execution controls) is enabled,
+ * it allows separate execute permissions for supervisor-mode and user-mode linear
+ * addresses in EPT paging structures. However, per Intel SDM requirement:
+ *
+ * "If the 'mode-based execute control for EPT' VM-execution control is 1,
+ * the 'enable EPT' VM-execution control must also be 1."
+ *
+ * This test validates that VM entry fails when MBEC is enabled without EPT,
+ * and succeeds in all other valid combinations.
+ *
+ * [Intel SDM Vol. 3C, Section 26.6.2, Table 26-7]
+ */
+static void test_mode_based_execute_control(void)
+{
+	u32 primary_saved = vmcs_read(CPU_EXEC_CTRL0);
+	u32 secondary_saved = vmcs_read(CPU_EXEC_CTRL1);
+	u32 primary = primary_saved;
+	u32 secondary = secondary_saved;
+
+	/* Skip test if required VM-execution controls are not supported */
+	if (!is_mbec_supported()) {
+		report_skip("MBEC not supported");
+		return;
+	}
+
+	/* Test case 1: MBEC disabled, EPT disabled - should be valid */
+	primary |= CPU_SECONDARY;
+	vmcs_write(CPU_EXEC_CTRL0, primary);
+	secondary &= ~(CPU_MODE_BASED_EPT_EXEC | CPU_EPT);
+	vmcs_write(CPU_EXEC_CTRL1, secondary);
+	report_prefix_pushf("MBEC disabled, EPT disabled (valid combination)");
+	test_vmx_valid_controls();
+	report_prefix_pop();
+
+	/* Test case 2: MBEC enabled, EPT disabled - should be invalid per SDM */
+	secondary |= CPU_MODE_BASED_EPT_EXEC;
+	vmcs_write(CPU_EXEC_CTRL1, secondary);
+	report_prefix_pushf("MBEC enabled, EPT disabled (invalid combination)");
+	test_vmx_invalid_controls();
+	report_prefix_pop();
+
+	/* Test case 3: MBEC enabled, EPT enabled - should be valid */
+	secondary |= CPU_EPT;
+	setup_dummy_ept();
+	report_prefix_pushf("MBEC enabled, EPT enabled (valid combination)");
+	test_vmx_valid_controls();
+	report_prefix_pop();
+
+	/* Test case 4: MBEC disabled, EPT enabled - should be valid */
+	secondary &= ~CPU_MODE_BASED_EPT_EXEC;
+	vmcs_write(CPU_EXEC_CTRL1, secondary);
+	report_prefix_pushf("MBEC disabled, EPT enabled (valid combination)");
+	test_vmx_valid_controls();
+	report_prefix_pop();
+
+	vmcs_write(CPU_EXEC_CTRL0, primary_saved);
+	vmcs_write(CPU_EXEC_CTRL1, secondary_saved);
+}
+
 /*
  * If the 'enable PML' VM-execution control is 1, the 'enable EPT'
  * VM-execution control must also be 1. In addition, the PML address
@@ -5336,6 +5399,7 @@ static void test_vm_execution_ctls(void)
 	test_pml();
 	test_vpid();
 	test_ept_eptp();
+	test_mode_based_execute_control();
 	test_vmx_preemption_timer();
 }
 
-- 
2.52.0


