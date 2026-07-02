Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935C3390CA2
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976009; cv=none; b=uFRo6t4n695RqNGQazSeLPPE15V7aAq9vWVcQ1IYavSHKtovr2+YDZ8gr3xJWbmhE7p0qyZSWE7q8jdgQx8RM/9I30BDDHG3/pWfItxiD8uBgnBuryOpUKRZE0p3xULIYAytjApJE75qPqMiW22Z0gDeqaeDx9vH/10KvUDerqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976009; c=relaxed/simple;
	bh=11MhCYxtV/SMxiYzk/tHmzQflDkpEHtZRofqL4Bx89Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKqCYPHtkRS/m6+a8KxvDNFO6xk2PsmvbvMDz07YZZt7EHVBqjjVaB1r82KaNCu/ktZwWCJ7kbnBawDEurKXr/785O70Fk0GozQagBO1unEHo+ktYY0hErQ/bTIrd1xVh2m+yHSR3vgDINHo5WU6ChN57NAI0jdqafvtgI+azXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=sVnQtYWe; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="sVnQtYWe"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6626odVi3434951
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 1 Jul 2026 23:50:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6626odVi3434951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782975050;
	bh=zvg5ngliTxv00F6nkSE6WSI6Hv91+ojg76Z4BD7tbcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sVnQtYWe/IF+TldOVallU14m3MaqBTqrlCJTVVZm2XYJQWL5rHeDNy+TOjDZxW42r
	 VCr+Yq2QzvqCxZ0lLuF/ynO+o1g1tX5gynz2kS5FSm8mhieRImBoIuxS8Pf5em++4d
	 d7GuDZ3o+y7fhG4MXCqL25qXYuryVlXdWOESwcE+Rw5Y/zT6zJS9aU8LSalmKN2+33
	 eJGXFwYqlGcTMg16P6mHZqy/tvhAMg4Jsoy+JzSezMxzznGnuKMeuszalurUKG5mfb
	 nIDniGHKn3jRU+zmD47GV4CoPsb1MvfNQc//CSwFmavvUyOUiGT+dbbBx2B4tEZBAi
	 yFSH5vDEwqJWQ==
From: Xin Li <xin@zytor.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
        sohil.mehta@intel.com
Subject: [kvm-unit-tests PATCH v1 09/11] x86/vmx: Validate CET MSR handling during VM-Exit
Date: Wed,  1 Jul 2026 23:50:37 -0700
Message-ID: <20260702065039.3434909-10-xin@zytor.com>
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

Add tests to verify that CET MSRs are correctly handled during VM-Exit.

The following behaviors are verified:

  1. The CET MSRs are loaded with the values from VMCS host CET MSR fields
     iff the "Load CET" VM-Exit control is set.

  2. The CET MSRs are retained iff the "Load CET" VM-Exit control is cleared.

Signed-off-by: Xin Li <xin@zytor.com>
---
 x86/vmx_tests.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 8fb723bc..f50d1d21 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -12486,6 +12486,55 @@ static void vmx_exit_control_rtit_test(void)
 	test_set_guest_finished();
 }
 
+static void vmx_exit_control_cet_test_guest(void)
+{
+	wrmsr(MSR_IA32_S_CET, 2);
+
+	vmcall();
+}
+
+static void vmx_exit_control_cet_test(void)
+{
+	if (!(ctrl_exit_rev.clr & EXI_LOAD_CET)) {
+		report_skip("Load CET state exit control is not available");
+		return;
+	}
+
+	if (!(ctrl_enter_rev.clr & ENT_LOAD_CET)) {
+		report_skip("Load CET state entry control is not available");
+		return;
+	}
+
+	/* Allow the guest to read CET MSRs directly */
+	msr_bmp_init();
+
+	vmcs_set_bits(ENT_CONTROLS, ENT_LOAD_CET);
+	vmcs_write(HOST_S_CET, 6);
+	wrmsr(MSR_IA32_S_CET, 6);
+
+	/* Case 1: */
+	vmcs_clear_bits(EXI_CONTROLS, EXI_LOAD_CET);
+	vmcs_write(GUEST_S_CET, 8);
+	test_set_guest(vmx_exit_control_cet_test_guest);
+
+	enter_guest();
+	report(rdmsr(MSR_IA32_S_CET) == 2, "The IA32_S_CET MSR is retained at VM Exit");
+	report(vmcs_read(GUEST_S_CET) == 2, "VMCS guest IA32_S_CET MSR is saved at VM Exit");
+
+	wrmsr(MSR_IA32_S_CET, 6);
+
+	/* Case 2: */
+	vmcs_set_bits(EXI_CONTROLS, EXI_LOAD_CET);
+	vmcs_write(GUEST_S_CET, 8);
+	test_override_guest(vmx_exit_control_cet_test_guest);
+
+	enter_guest();
+	report(rdmsr(MSR_IA32_S_CET) == 6, "The IA32_S_CET MSR is loaded at VM Exit");
+	report(vmcs_read(GUEST_S_CET) == 2, "VMCS guest RTIT control MSR is saved at VM Exit");
+
+	test_set_guest_finished();
+}
+
 #define TEST(name) { #name, .v2 = name }
 
 /* name/init/guest_main/exit_handler/vmfail_handler */
@@ -12608,5 +12657,6 @@ struct vmx_test vmx_tests[] = {
 	TEST(vmx_exit_control_efer_test),
 	TEST(vmx_exit_control_pat_test),
 	TEST(vmx_exit_control_rtit_test),
+	TEST(vmx_exit_control_cet_test),
 	{ NULL, NULL, NULL, NULL },
 };
-- 
2.54.0

