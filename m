Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083B6390C8B
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976009; cv=none; b=qj0BXvEDrfsDUQ0KGGB12gUFWc9g8/H5GZA46fxAKjAUm1O4WqA9KdW4zmN67UblUSMcYCPR+VynW/dPbjMURHluSEAS03DQ/qFn0m/4mQ18tiCPGjAhNA4MI2b7DWTvQkHEJhhDh0LaMBxtrcNTGcmrc32J7BDjGb9KJBne0yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976009; c=relaxed/simple;
	bh=iXZPRk4QrK8BgxHpQUjq+Ha1xAHMYALLtVgAkvb+6g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCPcWwIKO5lccvMBuoZTGXt+a0duUquwMI28nZcsSMvT9fT7ZBzEONiQ9UDZlfkq0yqZxlVXi12s1OtYV/dX76Xog3Fg4wVeBeEEGxwJ4vDpwPaYU6h53uLoUv6B2/wXOaRc5TbaoFPqvjdMe6VVwKBstbrrEzKK4087dyKBGTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=yX7OvkBC; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="yX7OvkBC"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6626odVf3434951
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 1 Jul 2026 23:50:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6626odVf3434951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782975048;
	bh=eWVHk0p39LcpKgpX/giTr6nwPOtgqy8r9Md7Kpk24MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yX7OvkBCPnGfemkD6ZoGbKv2OB737F76Pg8HEldqdf5EMOr75DvWY2jylqmaDVXqM
	 Qqz3XhIVaOsD0B3sQHuGjnkOJZqHvU63qhqRY3O337pX5e6d5lGlI4N4spd85Rcwor
	 lIyoRJd3cCuOru2gCZh+CJdPC//+Cl/4u5mCyWwu49gOzN8muoV6GL1yqL1tLv0GRI
	 /eqT46xm/Z6xRNNi5F0D40RGMm07AFZMhKFzN8S8ZrO6L7iBXVV2XYwElyR8MA8zNy
	 aF6Sc832bWC9Yy9dd6BdaU1bE6f5YXF6R+deprYplEqEDO3I7T/3hE9qsHIJhzKeeh
	 ZhxxvIKJMZT2Q==
From: Xin Li <xin@zytor.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
        sohil.mehta@intel.com
Subject: [kvm-unit-tests PATCH v1 06/11] x86/vmx: Validate the EFER MSR handling during VM-Exit
Date: Wed,  1 Jul 2026 23:50:34 -0700
Message-ID: <20260702065039.3434909-7-xin@zytor.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702065039.3434909-1-xin@zytor.com>
References: <20260702065039.3434909-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests to verify that the EFER MSR is correctly handled during VM-Exit.

The following behaviors are verified:

  1. The EFER MSR is saved to VMCS during VM-Exit iff the "Save EFER"
     VM-Exit control is set.

  2. The EFER MSR is not saved to VMCS during VM-Exit iff the "Save EFER"
     VM-Exit control is cleared.

  3. The EFER MSR is loaded with the value from VMCS host EFER MSR field
     iff the "Load EFER" VM-Exit control is set.

  4. The EFER MSR is retained iff the "Load EFER" VM-Exit control is
     cleared.

Signed-off-by: Xin Li <xin@zytor.com>
---
 x86/vmx_tests.c | 126 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 2b6814ef..daa1504c 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -12195,6 +12195,131 @@ static void vmx_exit_control_fred_test(void)
 	test_set_guest_finished();
 }
 
+#define GUEST_INIT_EFER	(EFER_SCE | EFER_LME | EFER_LMA)
+#define GUEST_SET_EFER	(EFER_LME | EFER_LMA | EFER_NX)
+
+static void vmx_exit_control_efer_test_guest(void)
+{
+	wrmsr(MSR_EFER, GUEST_SET_EFER);
+
+	vmcall();
+}
+
+static void vmx_exit_control_efer_test(void)
+{
+	bool entry_not_load_efer_tested = false;
+	u64 host_efer = rdmsr(MSR_EFER);
+
+	if (!(ctrl_exit_rev.clr & EXI_SAVE_EFER)) {
+		report_skip("Save EFER exit control is not available");
+		return;
+	}
+
+	if (!(ctrl_exit_rev.clr & EXI_LOAD_EFER)) {
+		report_skip("Load EFER exit control is not available");
+		return;
+	}
+
+	if (!(ctrl_enter_rev.clr & ENT_LOAD_EFER)) {
+		report_skip("Load EFER entry control is not available");
+		return;
+	}
+
+	/* Allow the guest to read the EFER MSR directly */
+	msr_bmp_init();
+
+	vmcs_set_bits(ENT_CONTROLS, ENT_LOAD_EFER);
+	vmcs_write(HOST_EFER, host_efer);
+
+test_again:
+	/*
+	 * Case 1:
+	 *
+	 * The EFER MSR is not saved to VMCS during VM-Exit if the "Save EFER"
+	 * VM-Exit control is cleared.
+	 *
+	 * The EFER MSR is retained if the "Load EFER" VM-Exit control is
+	 * cleared.
+	 */
+	vmcs_clear_bits(EXI_CONTROLS, EXI_SAVE_EFER | EXI_LOAD_EFER);
+	if (entry_not_load_efer_tested)
+		test_override_guest(vmx_exit_control_efer_test_guest);
+	else
+		test_set_guest(vmx_exit_control_efer_test_guest);
+	vmcs_write(GUEST_EFER, GUEST_INIT_EFER);
+
+	enter_guest();
+	report(rdmsr(MSR_EFER) == GUEST_SET_EFER, "The EFER MSR is retained at VM Exit");
+	report(vmcs_read(GUEST_EFER) == GUEST_INIT_EFER, "VMCS guest EFER is not saved at VM Exit");
+
+	wrmsr(MSR_EFER, host_efer);
+
+	/*
+	 * Case 2:
+	 *
+	 * The EFER MSR is not saved to VMCS during VM-Exit if the "Save EFER"
+	 * VM-Exit control is cleared.
+	 *
+	 * The EFER MSR is loaded with the value from VMCS host EFER MSR field
+	 * if the "Load EFER" VM-Exit control is set.
+	 */
+	vmcs_clear_bits(EXI_CONTROLS, EXI_SAVE_EFER);
+	vmcs_set_bits(EXI_CONTROLS, EXI_LOAD_EFER);
+	test_override_guest(vmx_exit_control_efer_test_guest);
+	vmcs_write(GUEST_EFER, GUEST_INIT_EFER);
+
+	enter_guest();
+	report(rdmsr(MSR_EFER) == host_efer, "VMCS host EFER is loaded at VM Exit");
+	report(vmcs_read(GUEST_EFER) == GUEST_INIT_EFER, "VMCS guest EFER is not saved at VM Exit");
+
+	/*
+	 * Case 3:
+	 *
+	 * The EFER MSR is saved to VMCS during VM-Exit if the "Save EFER"
+	 * VM-Exit control is set.
+	 *
+	 * The EFER MSR is retained if the "Load EFER" VM-Exit control is
+	 * cleared.
+	 */
+	vmcs_set_bits(EXI_CONTROLS, EXI_SAVE_EFER);
+	vmcs_clear_bits(EXI_CONTROLS, EXI_LOAD_EFER);
+	test_override_guest(vmx_exit_control_efer_test_guest);
+	vmcs_write(GUEST_EFER, GUEST_INIT_EFER);
+
+	enter_guest();
+	report(rdmsr(MSR_EFER) == GUEST_SET_EFER, "The EFER MSR is retained at VM Exit");
+	report(vmcs_read(GUEST_EFER) == GUEST_SET_EFER, "VMCS guest EFER is saved at VM Exit");
+
+	wrmsr(MSR_EFER, host_efer);
+
+	/*
+	 * Case 4:
+	 *
+	 * The EFER MSR is saved to VMCS during VM-Exit if the "Save EFER"
+	 * VM-Exit control is set.
+	 *
+	 * The EFER MSR is loaded with the value from VMCS host EFER MSR field
+	 * if the "Load EFER" VM-Exit control is set.
+	 */
+	vmcs_set_bits(EXI_CONTROLS, EXI_SAVE_EFER | EXI_LOAD_EFER);
+	test_override_guest(vmx_exit_control_efer_test_guest);
+	vmcs_write(GUEST_EFER, GUEST_INIT_EFER);
+
+	enter_guest();
+	report(rdmsr(MSR_EFER) == host_efer, "VMCS host EFER is loaded at VM Exit");
+	report(vmcs_read(GUEST_EFER) == GUEST_SET_EFER, "VMCS guest EFER is saved at VM Exit");
+
+	if (!entry_not_load_efer_tested) {
+		entry_not_load_efer_tested = true;
+
+		/* Clear ENT_LOAD_EFER and run tests again */
+		vmcs_clear_bits(ENT_CONTROLS, ENT_LOAD_EFER);
+		goto test_again;
+	}
+
+	test_set_guest_finished();
+}
+
 #define TEST(name) { #name, .v2 = name }
 
 /* name/init/guest_main/exit_handler/vmfail_handler */
@@ -12314,5 +12439,6 @@ struct vmx_test vmx_tests[] = {
 	/* "Load CET" VM-entry/exit controls tests. */
 	TEST(vmx_cet_test),
 	TEST(vmx_exit_control_fred_test),
+	TEST(vmx_exit_control_efer_test),
 	{ NULL, NULL, NULL, NULL },
 };
-- 
2.54.0

