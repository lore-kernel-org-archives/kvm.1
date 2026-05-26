Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D04A212F89
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 03:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779765436; cv=none; b=Zod5EjHHvQsHAW7FfZ72kN4aIU+pC8u2ayDUQjFc9Io/y5enlSTEUNbtdH9PPcC0BWSVTC0CgRYqZUfSEhpjG9NwLfQpSo+bcC7cOdMqNlikYpPRWjbIvZRTMID8pNyD17Tp9m7MO5L/Owl5Wad0uvxzJu+/0/5G5hqNheG3p+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779765436; c=relaxed/simple;
	bh=obDMEZS5C43MrjlccdS16jAPHwCa5nt6nZuCtEVHpCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrQJjXZfdiCQwGLkKP/6y34oO2AwvSC03nX8pKZIrYdr398Kt0VxocNditg4kWewl91ZtdZPShhwWTON4XLi1ebvSQJnOBojGS2uY+RJNFYQw1jBVXINpZsiqEdbMLQjBwL0NWd9PLSIaUsAnOyDMyb/Z8lpTy1xpC0W0oOiL/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWSbPlOe; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWSbPlOe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779765434; x=1811301434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=obDMEZS5C43MrjlccdS16jAPHwCa5nt6nZuCtEVHpCI=;
  b=QWSbPlOeVzOuwRGbGjEvb3ieZOQLXMrAkf8Oyml9WvEkyVp2eZpnKn+B
   2jlhxbWyhRx/3ubrQO6pObr85WtC2znECxweBP12iZofPAnwhHWBQ5I2W
   gq6m0StOyV5sXJTMew8FsW8f5NhlMwWhyjg90s8Ag3M55mLOA4PcZdWsl
   ITX9vR6jYI/Kpl2yBtBz72Izs0R44FAJEdo1g5eZD+1zSGFeFas4Xju7x
   jII7YgMYQD/xHX/m/UNKuLdNPyl1jqir9lljrEOH2mKK68jiWNJwcudH5
   gu0IYsXddRBnunu3k6FrVQOGtP+jBqLhqJrtkZZyvsEr8KDMLjo8RIuPZ
   g==;
X-CSE-ConnectionGUID: Z5psxVrESBeJ17M8YPtmOw==
X-CSE-MsgGUID: fNrZLnMBS+i/bEwGNMGmUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80479561"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80479561"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 20:17:14 -0700
X-CSE-ConnectionGUID: W/Eo7ItMSsaCwL6vMph5CA==
X-CSE-MsgGUID: hFqndV2zToSJvusAiMRlGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="246741752"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 20:17:13 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: kvm@vger.kernel.org
Cc: Chenyi Qiang <chenyi.qiang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [kvm-unit-tests PATCH v2 2/4] nVMX: Validate DEBUGCTLMSR_BUS_LOCK_DETECT states during VMX transitions
Date: Tue, 26 May 2026 11:16:35 +0800
Message-ID: <20260526031704.109102-3-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260526031704.109102-1-chenyi.qiang@intel.com>
References: <20260526031704.109102-1-chenyi.qiang@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests to verify that DEBUGCTLMSR_BUS_LOCK_DETECT state is correctly
handled during VMX transitions.

Wrap the VM-entry/VM-exit DEBUGCTL transition flow into a shared helper so
follow-up DEBUGCTL feature tests can reuse the same checks.

The following behaviors are verified in the helper:

1. Guest states are loaded from VMCS iff "Load debug controls" VM-Entry control is set.
2. Guest states are saved to VMCS iff "Save debug controls" VM-Exit control is set.
3. DEBUGCTL MSR is cleared after VM exits.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 lib/x86/msr.h     |  1 +
 x86/unittests.cfg |  8 ++++
 x86/vmx_tests.c   | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)

diff --git a/lib/x86/msr.h b/lib/x86/msr.h
index 7397809c..da75740d 100644
--- a/lib/x86/msr.h
+++ b/lib/x86/msr.h
@@ -103,6 +103,7 @@
 /* DEBUGCTLMSR bits (others vary by model): */
 #define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
 #define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
+#define DEBUGCTLMSR_BUS_LOCK_DETECT	(1UL <<  2)
 #define DEBUGCTLMSR_TR			(1UL <<  6)
 #define DEBUGCTLMSR_BTS			(1UL <<  7)
 #define DEBUGCTLMSR_BTINT		(1UL <<  8)
diff --git a/x86/unittests.cfg b/x86/unittests.cfg
index 48835eba..c8426770 100644
--- a/x86/unittests.cfg
+++ b/x86/unittests.cfg
@@ -471,6 +471,14 @@ arch = x86_64
 groups = vmx
 timeout = 240
 
+[vmx_bus_lock_detect_test]
+file = vmx.flat
+test_args = "vmx_bus_lock_detect_test"
+qemu_params = -cpu max,+vmx
+arch = x86_64
+groups = vmx
+timeout = 240
+
 [debug]
 file = debug.flat
 arch = x86_64
diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 91f417c6..a3e52d3b 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -11737,6 +11737,100 @@ static void vmx_cet_test(void)
 	test_set_guest_finished();
 }
 
+static struct vmx_debugctl_test_data {
+	u64 mask;
+	u64 guest_debugctl;
+} vmx_debugctl_test_data;
+
+static void vmx_debugctl_test_guest(void)
+{
+	vmx_debugctl_test_data.guest_debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
+	vmcall();
+
+	wrmsr(MSR_IA32_DEBUGCTLMSR, vmx_debugctl_test_data.mask);
+	vmcall();
+
+	vmx_debugctl_test_data.guest_debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
+	vmcall();
+
+	wrmsr(MSR_IA32_DEBUGCTLMSR, vmx_debugctl_test_data.mask);
+	vmcall();
+}
+
+static void vmx_debugctl_transition_test(const char *label, u64 mask)
+{
+	u64 debugctl;
+
+	vmx_debugctl_test_data.mask = mask;
+
+	msr_bmp_init();
+	wrmsr(MSR_IA32_DEBUGCTLMSR, mask);
+	vmcs_write(GUEST_DEBUGCTL, 0x0);
+
+	/* Validate when save/load debug controls are set */
+	vmcs_set_bits(ENT_CONTROLS, ENT_LOAD_DBGCTLS);
+	vmcs_set_bits(EXI_CONTROLS, EXI_SAVE_DBGCTLS);
+
+	test_set_guest(vmx_debugctl_test_guest);
+
+	enter_guest();
+	skip_exit_vmcall();
+	/* Validate VM-entry loads the guest DEBUGCTL value from GUEST_DEBUGCTL. */
+	report(vmx_debugctl_test_data.guest_debugctl == 0x0,
+	       "%s: Load debug controls", label);
+
+	enter_guest();
+	skip_exit_vmcall();
+	debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
+	/* Validate VM-exit clears host DEBUGCTL and saves guest DEBUGCTL into the VMCS. */
+	report(debugctl == 0x0 && vmcs_read(GUEST_DEBUGCTL) == mask,
+	       "%s: Save debug controls", label);
+
+	if (ctrl_enter_rev.set & ENT_LOAD_DBGCTLS ||
+	    ctrl_exit_rev.set & EXI_SAVE_DBGCTLS) {
+		printf("\tDebug controls are always loaded/saved\n");
+		test_set_guest_finished();
+		return;
+	}
+
+	wrmsr(MSR_IA32_DEBUGCTLMSR, mask);
+	vmcs_write(GUEST_DEBUGCTL, 0x0);
+	/* Validate when save/load debug controls are clear */
+	vmcs_clear_bits(ENT_CONTROLS, ENT_LOAD_DBGCTLS);
+	vmcs_clear_bits(EXI_CONTROLS, EXI_SAVE_DBGCTLS);
+
+	enter_guest();
+	skip_exit_vmcall();
+	/* Validate guest observes the host's DEBUGCTL value. */
+	report(vmx_debugctl_test_data.guest_debugctl == mask,
+	       "%s: Guest=host debug controls", label);
+
+	wrmsr(MSR_IA32_DEBUGCTLMSR, 0x0);
+	vmcs_write(GUEST_DEBUGCTL, 0x0);
+
+	enter_guest();
+	skip_exit_vmcall();
+	debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
+	/* Validate VM-exit clears host DEBUGCTL and does not save guest DEBUGCTL into the VMCS. */
+	report(debugctl == 0x0 && vmcs_read(GUEST_DEBUGCTL) == 0x0,
+	       "%s: Don't save debug controls", label);
+
+	enter_guest();
+}
+
+static void vmx_bus_lock_detect_test(void)
+{
+
+	if (!this_cpu_has(X86_FEATURE_BUS_LOCK_DETECT)) {
+		report_skip("%s : \"Bus Lock Detect\" not supported", __func__);
+		return;
+	}
+
+	vmx_debugctl_transition_test("DEBUGCTLMSR.BUS_LOCK_DETECT",
+					 DEBUGCTLMSR_BUS_LOCK_DETECT);
+	report_pass(__func__);
+}
+
 #define TEST(name) { #name, .v2 = name }
 
 /* name/init/guest_main/exit_handler/syscall_handler/guest_regs */
@@ -11858,5 +11952,7 @@ struct vmx_test vmx_tests[] = {
 	TEST(vmx_canonical_test),
 	/* "Load CET" VM-entry/exit controls tests. */
 	TEST(vmx_cet_test),
+	/* "debug controls VM-entry/exit controls tests" for DEBUGCTLMSR_BUS_LOCK_DETECT */
+	TEST(vmx_bus_lock_detect_test),
 	{ NULL, NULL, NULL, NULL, NULL, {0} },
 };
-- 
2.43.5

