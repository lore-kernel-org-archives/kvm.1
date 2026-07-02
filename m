Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93009390C9A
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976009; cv=none; b=X4NOjrDHWablxT648awX86NPRXwFd+Z0etQAiaRoYWzBZ1b5ITYgsPPNLJ+eCBIG5gt+afvi/2kp/P4PKnr+aGxM5RXKgNFHVkyhAV9k6YIQvOFzjHC5F+M7KanWOaHkddNXLSCYpIM5XkWuI9zfciSmmtTEON8/lSXgIWkqodA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976009; c=relaxed/simple;
	bh=vAfTTSXj1DSw8E9x2rjIdZXrCiUgtUnBLsaop7kwGTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXyrTRPDLgGmMIli/aBOAUrPIjiH9NDdmYkFRq4OYrvKpvAj+VdUMMkGuiLJB+GhCspTY8/isGShmpA5uEeS5OnbJjfpNc57BYp0eIcEXWXrebtfzAI6BDyiv2UbNxOrc08BcWAa1qnZtXIDagAjxg6OHWpc0FuxAInlkhj88bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=reh6cbxg; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="reh6cbxg"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6626odVh3434951
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 1 Jul 2026 23:50:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6626odVh3434951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782975049;
	bh=oye1wUAnJ3qZRjLTLi2c/5/6Jkaozr/SCAu/WSr2UH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=reh6cbxgnQ2k+keKYlNA4my8mzvNuGQ7mfCGSQoVYBwvq8T06n+CdbPNP88Ze/8MG
	 AXSyq5rlUCimZb9ALZ6d2ZHFtyarY5e02HLR2V0R5Xj2UEhZv6W6XeLuOI7I4T7K8S
	 7olIqpzNf8LLzauKNycLiq023a9f09GkTKXxSnHrsV6hqUNUCsMgZg1DCGLoBzidOh
	 qdYzhy8ky+wDh+dX5RHz12A2gWr79SCx43Kl2tUkcsg6QYtc/dUVZW7ub8qzPS8rat
	 wQLf7Fl05JIAuB0iUR9DKsBuzOUKW3asPvIFhoUnp52UfR6LU/uJrDWMaengOMrkWM
	 cnkAslEnbY7WQ==
From: Xin Li <xin@zytor.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
        sohil.mehta@intel.com
Subject: [kvm-unit-tests PATCH v1 08/11] x86/vmx: Validate the RTIT control MSR handling during VM-Exit
Date: Wed,  1 Jul 2026 23:50:36 -0700
Message-ID: <20260702065039.3434909-9-xin@zytor.com>
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

Add tests to verify that the RTIT control MSR is correctly handled during
VM-Exit.

The following behaviors are verified:

  1. The RTIT control MSR is cleared iff the "Clear RTIT control MSR"
     VM-Exit control is set.

  2. The RTIT control MSR is retained iff the "Clear RTIT control MSR"
     VM-Exit control is cleared.

Signed-off-by: Xin Li <xin@zytor.com>
---
 x86/vmx.h       |  3 +++
 x86/vmx_tests.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/x86/vmx.h b/x86/vmx.h
index d9126e61..e2e6df9c 100644
--- a/x86/vmx.h
+++ b/x86/vmx.h
@@ -236,6 +236,7 @@ enum Encoding {
 	GUEST_PERF_GLOBAL_CTRL	= 0x2808ul,
 	GUEST_PDPTE		= 0x280aul,
 	GUEST_BNDCFGS		= 0x2812ul,
+	GUEST_RTIT_CTL		= 0x2814ul,
 	GUEST_FRED_CONFIG	= 0x281aul,
 	GUEST_FRED_RSP1		= 0x281cul,
 	GUEST_FRED_RSP2		= 0x281eul,
@@ -448,6 +449,7 @@ enum Ctrl_exi {
 	EXI_SAVE_EFER		= 1UL << 20,
 	EXI_LOAD_EFER		= 1UL << 21,
 	EXI_SAVE_PREEMPT	= 1UL << 22,
+	EXI_CLEAR_RTIT_CTL	= 1UL << 25,
 	EXI_LOAD_CET		= 1UL << 28,
 	EXI_ACTIVATE_CTRL1	= 1UL << 31,
 };
@@ -464,6 +466,7 @@ enum Ctrl_ent {
 	ENT_LOAD_PAT		= 1UL << 14,
 	ENT_LOAD_EFER		= 1UL << 15,
 	ENT_LOAD_BNDCFGS	= 1UL << 16,
+	ENT_LOAD_RTIT_CTL	= 1UL << 18,
 	ENT_LOAD_CET		= 1UL << 20,
 	ENT_LOAD_FRED		= 1UL << 23,
 };
diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 460ed76e..8fb723bc 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -12438,6 +12438,54 @@ test_again:
 	test_set_guest_finished();
 }
 
+static void vmx_exit_control_rtit_test_guest(void)
+{
+	if (rdmsr(MSR_IA32_RTIT_CTL) == 0x4)
+		wrmsr(MSR_IA32_RTIT_CTL, 0x8);
+
+	vmcall();
+}
+
+static void vmx_exit_control_rtit_test(void)
+{
+	if (!(ctrl_exit_rev.clr & EXI_CLEAR_RTIT_CTL)) {
+		report_skip("Clear RTIT ctl MSR exit control is not available");
+		return;
+	}
+
+	if (!(ctrl_enter_rev.clr & ENT_LOAD_RTIT_CTL)) {
+		report_skip("Load RTIT ctl MSR entry control is not available");
+		return;
+	}
+
+	/* Allow the guest to read the RTIT control MSR directly */
+	msr_bmp_init();
+
+	vmcs_set_bits(ENT_CONTROLS, ENT_LOAD_RTIT_CTL);
+
+	/* Case 1: */
+	vmcs_clear_bits(EXI_CONTROLS, EXI_CLEAR_RTIT_CTL);
+	test_set_guest(vmx_exit_control_rtit_test_guest);
+	wrmsr(MSR_IA32_RTIT_CTL, 0);
+	vmcs_write(GUEST_RTIT_CTL, 0x4);
+
+	enter_guest();
+	report(rdmsr(MSR_IA32_RTIT_CTL) == 0x8, "The RTIT control MSR is retained at VM Exit");
+	report(vmcs_read(GUEST_RTIT_CTL) == 0x8, "VMCS guest RTIT control MSR is saved at VM Exit");
+
+	/* Case 2: */
+	vmcs_set_bits(EXI_CONTROLS, EXI_CLEAR_RTIT_CTL);
+	test_override_guest(vmx_exit_control_rtit_test_guest);
+	wrmsr(MSR_IA32_RTIT_CTL, 0);
+	vmcs_write(GUEST_RTIT_CTL, 0x4);
+
+	enter_guest();
+	report(rdmsr(MSR_IA32_RTIT_CTL) == 0x0, "The RTIT control MSR is cleared at VM Exit");
+	report(vmcs_read(GUEST_RTIT_CTL) == 0x8, "VMCS guest RTIT control MSR is saved at VM Exit");
+
+	test_set_guest_finished();
+}
+
 #define TEST(name) { #name, .v2 = name }
 
 /* name/init/guest_main/exit_handler/vmfail_handler */
@@ -12559,5 +12607,6 @@ struct vmx_test vmx_tests[] = {
 	TEST(vmx_exit_control_fred_test),
 	TEST(vmx_exit_control_efer_test),
 	TEST(vmx_exit_control_pat_test),
+	TEST(vmx_exit_control_rtit_test),
 	{ NULL, NULL, NULL, NULL },
 };
-- 
2.54.0

