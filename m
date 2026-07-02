Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E07390C88
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976007; cv=none; b=W3fIdSrFcjNQUzdxm4yO0LqDAZuLcNfmOumx8n7ZC8kXUNuS6QZ55wk8+bxIBEBmVaycLu188b2bvbcioTAqgGvZHP0hfzR0tM/M8ekPUjXMz/WXBA51n37Tk+IwLgwjCvDI1bvxLeaYcQS1BV3kuXtCM2F3fihuFt/k0+CztJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976007; c=relaxed/simple;
	bh=fUujUiJ3HqFSBuR0TBeh6VZdGafSyTvt8n0DWhaxho4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obf0Ng78M/l3ywjIstgvYAqfrWvZPvRnZrXWT5wDtTCYdZTWQlK5wdghEu8Rw5m0wiaPRWFGWUP/Ogt55zKR599y1d8RPGVG0gbLfYYcOj7yg69T2hilKIQ4WWlgDd9XX5Ii5EaC3AUnYzLRVhJwN9ZrqUV6sB4QbBjvo2PzNPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=FbFsj5+z; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FbFsj5+z"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6626odVe3434951
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 1 Jul 2026 23:50:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6626odVe3434951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782975048;
	bh=DMwEUt1tRaodsv/gS49t6JuDu8n8oGxixvl0FOxKC0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FbFsj5+zRBRJurHu822i9gBYkzKEUB7caPBNlL/VPqCrevACa03/s5QKBF7bPKLZX
	 XL1EVtBSS3lWwup5TKTIkssLIMnhAQWxYMbt6csjSet6rzeBVWi3nuIe4eAiqZmYE2
	 rnYG0W0ZaM69kV5+UOOyVE9KNQfTuLcHNPBQK5MnE+O913jpuPq3fp+ZDWhWW6odwV
	 kwUxNkL7+OH9N8ebT70RAYYZUtcS05vBuapfAihLvg53mY2v4hyQj7UtVlD1xu2KI8
	 TW0bPNJkX4Yyhs0jm1Ti45uMRhKhWvJBXaz0VSIGpWJpBk0aJWSyc6Fszndgu3VLDz
	 OQnFtDUzLFaIg==
From: Xin Li <xin@zytor.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
        sohil.mehta@intel.com
Subject: [kvm-unit-tests PATCH v1 05/11] x86/vmx: Validate FRED MSR handling during VM-Exit
Date: Wed,  1 Jul 2026 23:50:33 -0700
Message-ID: <20260702065039.3434909-6-xin@zytor.com>
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

Add tests to verify that FRED MSRs are correctly handled during VM-Exit.

The following behaviors are verified:

  1. FRED MSRs are saved to VMCS during VM exit iff the "Save FRED"
     VM-Exit control is set.

  2. FRED MSRs are not saved to VMCS during VM exit iff the "Save FRED"
     VM-Exit control is cleared.

  3. FRED MSRs are loaded with values from VMCS host FRED MSR fields
     iff the "Load FRED" VM-Exit control is set.

  4. FRED MSRs are retained iff the "Load FRED" VM-Exit control is
     cleared.

Signed-off-by: Xin Li <xin@zytor.com>
---
 lib/x86/msr.h   |  13 ++++++
 x86/vmx.h       |  25 +++++++++-
 x86/vmx_tests.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/lib/x86/msr.h b/lib/x86/msr.h
index 97f52bb5..fdfce4e4 100644
--- a/lib/x86/msr.h
+++ b/lib/x86/msr.h
@@ -302,9 +302,22 @@
 #define MSR_IA32_TSC_ADJUST		0x0000003b
 #define MSR_IA32_U_CET                  0x000006a0
 #define MSR_IA32_S_CET                  0x000006a2
+#define MSR_IA32_PL0_SSP                0x000006a4
 #define MSR_IA32_PL3_SSP                0x000006a7
 #define MSR_IA32_PKRS			0x000006e1
 
+/* FRED MSRs */
+#define MSR_IA32_FRED_RSP0		0x000001cc
+#define MSR_IA32_FRED_RSP1		0x000001cd
+#define MSR_IA32_FRED_RSP2		0x000001ce
+#define MSR_IA32_FRED_RSP3		0x000001cf
+#define MSR_IA32_FRED_STKLVLS		0x000001d0
+#define MSR_IA32_FRED_SSP0		MSR_IA32_PL0_SSP
+#define MSR_IA32_FRED_SSP1		0x000001d1
+#define MSR_IA32_FRED_SSP2		0x000001d2
+#define MSR_IA32_FRED_SSP3		0x000001d3
+#define MSR_IA32_FRED_CONFIG		0x000001d4
+
 #define FEATURE_CONTROL_LOCKED				(1<<0)
 #define FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX	(1<<1)
 #define FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX	(1<<2)
diff --git a/x86/vmx.h b/x86/vmx.h
index d9b500f6..d9126e61 100644
--- a/x86/vmx.h
+++ b/x86/vmx.h
@@ -221,7 +221,7 @@ enum Encoding {
 	EOI_EXIT_BITMAP3	= 0x2022ul,
 	PMLADDR                 = 0x200eul,
 	PMLADDR_HI              = 0x200ful,
-
+	EXI_CTRL1		= 0x2044ul,
 
 	/* 64-Bit Readonly Data Field */
 	INFO_PHYS_ADDR		= 0x2400ul,
@@ -236,11 +236,27 @@ enum Encoding {
 	GUEST_PERF_GLOBAL_CTRL	= 0x2808ul,
 	GUEST_PDPTE		= 0x280aul,
 	GUEST_BNDCFGS		= 0x2812ul,
+	GUEST_FRED_CONFIG	= 0x281aul,
+	GUEST_FRED_RSP1		= 0x281cul,
+	GUEST_FRED_RSP2		= 0x281eul,
+	GUEST_FRED_RSP3		= 0x2820ul,
+	GUEST_FRED_STKLVLS	= 0x2822ul,
+	GUEST_FRED_SSP1		= 0x2824ul,
+	GUEST_FRED_SSP2		= 0x2826ul,
+	GUEST_FRED_SSP3		= 0x2828ul,
 
 	/* 64-Bit Host State */
 	HOST_PAT		= 0x2c00ul,
 	HOST_EFER		= 0x2c02ul,
 	HOST_PERF_GLOBAL_CTRL	= 0x2c04ul,
+	HOST_FRED_CONFIG	= 0x2c08ul,
+	HOST_FRED_RSP1		= 0x2c0aul,
+	HOST_FRED_RSP2		= 0x2c0cul,
+	HOST_FRED_RSP3		= 0x2c0eul,
+	HOST_FRED_STKLVLS	= 0x2c10ul,
+	HOST_FRED_SSP1		= 0x2c12ul,
+	HOST_FRED_SSP2		= 0x2c14ul,
+	HOST_FRED_SSP3		= 0x2c16ul,
 
 	/* 32-Bit Control Fields */
 	PIN_CONTROLS		= 0x4000ul,
@@ -433,6 +449,12 @@ enum Ctrl_exi {
 	EXI_LOAD_EFER		= 1UL << 21,
 	EXI_SAVE_PREEMPT	= 1UL << 22,
 	EXI_LOAD_CET		= 1UL << 28,
+	EXI_ACTIVATE_CTRL1	= 1UL << 31,
+};
+
+enum Ctrl1_exi {
+	EXI_SAVE_FRED		= 1UL << 0,
+	EXI_LOAD_FRED		= 1UL << 1,
 };
 
 enum Ctrl_ent {
@@ -443,6 +465,7 @@ enum Ctrl_ent {
 	ENT_LOAD_EFER		= 1UL << 15,
 	ENT_LOAD_BNDCFGS	= 1UL << 16,
 	ENT_LOAD_CET		= 1UL << 20,
+	ENT_LOAD_FRED		= 1UL << 23,
 };
 
 enum Ctrl_pin {
diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index a1f52749..2b6814ef 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -12077,6 +12077,124 @@ static void vmx_cet_test(void)
 	test_set_guest_finished();
 }
 
+static void vmx_exit_control_fred_test_guest(void)
+{
+	u64 fred_config = rdmsr(MSR_IA32_FRED_CONFIG);
+
+	if (fred_config == 0x100000)
+		wrmsr(MSR_IA32_FRED_CONFIG, 0x150000);
+	if (fred_config == 0x200000)
+		wrmsr(MSR_IA32_FRED_CONFIG, 0x250000);
+	if (fred_config == 0x300000)
+		wrmsr(MSR_IA32_FRED_CONFIG, 0x350000);
+	if (fred_config == 0x400000)
+		wrmsr(MSR_IA32_FRED_CONFIG, 0x450000);
+
+	vmcall();
+}
+
+static void vmx_exit_control_fred_test(void)
+{
+	if (!(ctrl_enter_rev.clr & ENT_LOAD_FRED)) {
+		report_skip("Load FRED state entry control is not available");
+		return;
+	}
+
+	/* Allow the guest to read FRED MSRs directly */
+	msr_bmp_init();
+
+	vmcs_set_bits(ENT_CONTROLS, ENT_LOAD_FRED);
+	vmcs_set_bits(EXI_CONTROLS, EXI_ACTIVATE_CTRL1);
+
+	/*
+	 * Case 1:
+	 *
+	 * FRED MSRs are retained if the "Load FRED" VM-Exit control is cleared.
+	 *
+	 * FRED MSRs are not saved to VMCS during VM exit if the "Save FRED"
+	 * VM-Exit control is cleared.
+	 */
+	vmcs_clear_bits(EXI_CTRL1, EXI_SAVE_FRED | EXI_LOAD_FRED);
+	wrmsr(MSR_IA32_FRED_CONFIG, 0x1000);
+	vmcs_write(HOST_FRED_CONFIG, 0x1000);
+	vmcs_write(GUEST_FRED_CONFIG, 0x100000);
+	test_set_guest(vmx_exit_control_fred_test_guest);
+
+	enter_guest();
+	report(rdmsr(MSR_IA32_FRED_CONFIG) == 0x150000, "FRED MSRs are retained at VM Exit");
+	report(vmcs_read(GUEST_FRED_CONFIG) == 0x100000, "VMCS guest FRED MSRs are not saved at VM Exit");
+	report(vmcs_read(HOST_FRED_CONFIG) == 0x1000 &&
+	       vmcs_read(HOST_FRED_CONFIG) != rdmsr(MSR_IA32_FRED_CONFIG),
+	       "VMCS host FRED MSRs are NOT loaded at VM Exit");
+
+	/*
+	 * Case 2:
+	 *
+	 * FRED MSRs are loaded with values from VMCS host FRED MSR fields
+	 * if the "Load FRED" VM-Exit control is set.
+	 *
+	 * FRED MSRs are not saved to VMCS during VM exit if the "Save FRED"
+	 * VM-Exit control is cleared.
+	 */
+	vmcs_clear_bits(EXI_CTRL1, EXI_SAVE_FRED);
+	vmcs_set_bits(EXI_CTRL1, EXI_LOAD_FRED);
+	wrmsr(MSR_IA32_FRED_CONFIG, 0x2000);
+	vmcs_write(HOST_FRED_CONFIG, 0x2000);
+	vmcs_write(GUEST_FRED_CONFIG, 0x200000);
+	test_override_guest(vmx_exit_control_fred_test_guest);
+
+	enter_guest();
+	report(vmcs_read(GUEST_FRED_CONFIG) == 0x200000, "VMCS guest FRED MSRs are not saved at VM Exit");
+	report(vmcs_read(HOST_FRED_CONFIG) == 0x2000 &&
+	       vmcs_read(HOST_FRED_CONFIG) == rdmsr(MSR_IA32_FRED_CONFIG),
+	       "VMCS host FRED MSRs are loaded at VM Exit");
+
+	/*
+	 * Case 3:
+	 *
+	 * FRED MSRs are retained if the "Load FRED" VM-Exit control is cleared.
+	 *
+	 * FRED MSRs are saved to VMCS during VM exit if the "Save FRED"
+	 * VM-Exit control is set.
+	 */
+	vmcs_set_bits(EXI_CTRL1, EXI_SAVE_FRED);
+	vmcs_clear_bits(EXI_CTRL1, EXI_LOAD_FRED);
+	wrmsr(MSR_IA32_FRED_CONFIG, 0x3000);
+	vmcs_write(HOST_FRED_CONFIG, 0x3000);
+	vmcs_write(GUEST_FRED_CONFIG, 0x300000);
+	test_override_guest(vmx_exit_control_fred_test_guest);
+
+	enter_guest();
+	report(rdmsr(MSR_IA32_FRED_CONFIG) == 0x350000, "FRED MSRs are retained at VM Exit");
+	report(vmcs_read(GUEST_FRED_CONFIG) == 0x350000, "VMCS guest FRED MSRs are saved at VM Exit");
+	report(vmcs_read(HOST_FRED_CONFIG) == 0x3000 &&
+	       vmcs_read(HOST_FRED_CONFIG) != rdmsr(MSR_IA32_FRED_CONFIG),
+	       "VMCS host FRED MSRs are NOT loaded at VM Exit");
+
+	/*
+	 * Case 4:
+	 *
+	 * FRED MSRs are loaded with values from VMCS host FRED MSR fields
+	 * if the "Load FRED" VM-Exit control is set.
+	 *
+	 * FRED MSRs are saved to VMCS during VM exit if the "Save FRED"
+	 * VM-Exit control is set.
+	 */
+	vmcs_set_bits(EXI_CTRL1, EXI_SAVE_FRED | EXI_LOAD_FRED);
+	wrmsr(MSR_IA32_FRED_CONFIG, 0x4000);
+	vmcs_write(HOST_FRED_CONFIG, 0x4000);
+	vmcs_write(GUEST_FRED_CONFIG, 0x400000);
+	test_override_guest(vmx_exit_control_fred_test_guest);
+
+	enter_guest();
+	report(vmcs_read(GUEST_FRED_CONFIG) == 0x450000, "VMCS guest FRED MSRs are saved at VM exit");
+	report(vmcs_read(HOST_FRED_CONFIG) == 0x4000 &&
+	       vmcs_read(HOST_FRED_CONFIG) == rdmsr(MSR_IA32_FRED_CONFIG),
+	       "VMCS host FRED MSRs are loaded at VM Exit");
+
+	test_set_guest_finished();
+}
+
 #define TEST(name) { #name, .v2 = name }
 
 /* name/init/guest_main/exit_handler/vmfail_handler */
@@ -12195,5 +12313,6 @@ struct vmx_test vmx_tests[] = {
 	TEST(vmx_canonical_test),
 	/* "Load CET" VM-entry/exit controls tests. */
 	TEST(vmx_cet_test),
+	TEST(vmx_exit_control_fred_test),
 	{ NULL, NULL, NULL, NULL },
 };
-- 
2.54.0

