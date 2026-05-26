Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E6F3B1EE2
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 03:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779765434; cv=none; b=L4OcgWZRGqPLMZXo45p9qMHeQi4ItJH+kwlOXbvNsSJLHzgdQyjwmCZ3BOs7GKdraInPuuE65jD7HDDbhwGOg5NgNtTlzzkly0Oi362mCGuABcP3XAXTzhbTJgvAxhHu63x9TeN1gUWRx2xOWFSNGhbVy58tXS5PdoV9Mz/mEh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779765434; c=relaxed/simple;
	bh=EL1r3z4s1kS8nBZLrZrq4vs349JIDqMaVqk/z2YBZ44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUeMe98wD+ZZs1JGScPtvDEcjky23A21W89Lr1wBLl8ShKaSeokGilmD1iu+RLKXef2rHBVHmoB7AZkcILjDvE7ZYfr+MGPdObUWakQyazJbrDO84pMAKLCozAXpX/5bygC2JiboV8Rtw7RP65KTES6Rdp/nxguV7j3SrAkJ5QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+gpO5WV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+gpO5WV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779765433; x=1811301433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EL1r3z4s1kS8nBZLrZrq4vs349JIDqMaVqk/z2YBZ44=;
  b=M+gpO5WVmUwPORT72RFwvfQVfDGeXehtonZcotWQlsLhnZ0JxtmZE6hN
   FuEDy+WqnDN5TsK5Jo6rsoKTdMhfFuHUb8Wj5Hv8bX5QMeVbgGpbDtIm4
   XfgbXKCiYbtZmxubTRFAX76sXY4L3URn0nsQ4QAZRblHg1pRlSNnhAUit
   ABfBldHsh03Pm7OHwDPFWOfQ0njSQ73R3jWieDdwNP1JOOMTjLKXk3F2m
   gA/2WOuP7qd30H/ZDoWKoUw9CCaRvgdqCfowon0x86Oa+nx1X+elCb1vB
   a5ZgcOlHnzN1FrbQip2FYv71VpXpeCe7hEm33bKuriLHPaLtxjPksaZHu
   w==;
X-CSE-ConnectionGUID: xLpcjXWuQxCGk+boXNXevA==
X-CSE-MsgGUID: AdXgaGQ1R/akIU5HHSksAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80479556"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80479556"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 20:17:12 -0700
X-CSE-ConnectionGUID: L5JOXOHrRSepPC3AvWEjTQ==
X-CSE-MsgGUID: 3HrYpOCgRzmvKbW+MLD0+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="246741738"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 20:17:11 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: kvm@vger.kernel.org
Cc: Chenyi Qiang <chenyi.qiang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [kvm-unit-tests PATCH v2 1/4] nVMX: Remove the IA32_DEBUGCTLMSR access in debugctls test
Date: Tue, 26 May 2026 11:16:34 +0800
Message-ID: <20260526031704.109102-2-chenyi.qiang@intel.com>
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

"debug controls" test was added by commit dc5c01f17b1a ("VMX: Test
behavior on set and cleared save/load debug controls") to verify that
"VM-Entry load debug controls" and "VM-Exit save debug controls" are
correctly emulated by KVM for nested VMX. But due to the limitation that
KVM didn't support MSR_IA32_DEBUGCTL for guest at that time, the test
commented out all the value comparison of MSR_IA32_DEBUGCTL and leave
it to future when KVM supports the MSR.

The test doesn't check the functionality of save/restore guest
MSR_IA32_DEBUGCTL on vm-exit/entry, but it keeps the write of
MSR_IA32_DEBUGCTL. It leads to

  kvm_intel: kvm [18663]: vcpu0, guest rIP: 0x407de7 Unhandled WRMSR(0x1d9) = 0x1
  kvm_intel: kvm [18663]: vcpu0, guest rIP: 0x0 Unhandled WRMSR(0x1d9) = 0x2
  kvm_intel: kvm [18663]: vcpu0, guest rIP: 0x40936f Unhandled WRMSR(0x1d9) = 0x3
  kvm_intel: kvm [18663]: vcpu0, guest rIP: 0x40cf09 Unhandled WRMSR(0x1d9) = 0x1
  kvm_intel: kvm [18663]: vcpu0, guest rIP: 0x40940d Unhandled WRMSR(0x1d9) = 0x3

to the kernel log. Though it doesn't break the test, the log confuses
people to think something wrong happened in the test case.

Current KVM doesn't support some bits of MSR_IA32_DEBUGCTL but they
depend on the vcpu model exposed. To simplify the case and eliminate
the confusing "Unhandled WRMSR(0x1d9)" log, remove the MSR_IA32_DEBUGCTL
logic in the test and make it concentrate only on DR7. Following patch
will bring back MSR_IA32_DEBUGCTL separately.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>

---
Changes in v2:
  - Rewrite of commit message by Xiaoyao.
  - Add RB from Xiaoyao.
---
 x86/vmx_tests.c | 46 ++++++++++++++--------------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index ff387ded..91f417c6 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -1856,21 +1856,18 @@ static int nmi_hlt_exit_handler(union exit_reason exit_reason)
 }
 
 
-static int dbgctls_init(struct vmcs *vmcs)
+static int dbgctls_dr7_init(struct vmcs *vmcs)
 {
 	u64 dr7 = 0x402;
 	u64 zero = 0;
 
-	msr_bmp_init();
 	asm volatile(
 		"mov %0,%%dr0\n\t"
 		"mov %0,%%dr1\n\t"
 		"mov %0,%%dr2\n\t"
 		"mov %1,%%dr7\n\t"
 		: : "r" (zero), "r" (dr7));
-	wrmsr(MSR_IA32_DEBUGCTLMSR, 0x1);
 	vmcs_write(GUEST_DR7, 0x404);
-	vmcs_write(GUEST_DEBUGCTL, 0x2);
 
 	vmcs_write(ENT_CONTROLS, vmcs_read(ENT_CONTROLS) | ENT_LOAD_DBGCTLS);
 	vmcs_write(EXI_CONTROLS, vmcs_read(EXI_CONTROLS) | EXI_SAVE_DBGCTLS);
@@ -1878,23 +1875,19 @@ static int dbgctls_init(struct vmcs *vmcs)
 	return VMX_TEST_START;
 }
 
-static void dbgctls_main(void)
+static void dbgctls_dr7_main(void)
 {
-	u64 dr7, debugctl;
+	u64 dr7;
 
 	asm volatile("mov %%dr7,%0" : "=r" (dr7));
-	debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
-	/* Commented out: KVM does not support DEBUGCTL so far */
-	(void)debugctl;
-	report(dr7 == 0x404, "Load debug controls" /* && debugctl == 0x2 */);
+	report(dr7 == 0x404, "DR7: Load debug controls");
 
 	dr7 = 0x408;
 	asm volatile("mov %0,%%dr7" : : "r" (dr7));
-	wrmsr(MSR_IA32_DEBUGCTLMSR, 0x3);
 
 	vmx_set_test_stage(0);
 	vmcall();
-	report(vmx_get_test_stage() == 1, "Save debug controls");
+	report(vmx_get_test_stage() == 1, "DR7: Save debug controls");
 
 	if (ctrl_enter_rev.set & ENT_LOAD_DBGCTLS ||
 	    ctrl_exit_rev.set & EXI_SAVE_DBGCTLS) {
@@ -1905,46 +1898,37 @@ static void dbgctls_main(void)
 	vmcall();
 
 	asm volatile("mov %%dr7,%0" : "=r" (dr7));
-	debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
-	/* Commented out: KVM does not support DEBUGCTL so far */
-	(void)debugctl;
 	report(dr7 == 0x402,
-	       "Guest=host debug controls" /* && debugctl == 0x1 */);
+	       "DR7: Guest=host debug controls");
 
 	dr7 = 0x408;
 	asm volatile("mov %0,%%dr7" : : "r" (dr7));
-	wrmsr(MSR_IA32_DEBUGCTLMSR, 0x3);
 
 	vmx_set_test_stage(3);
 	vmcall();
-	report(vmx_get_test_stage() == 4, "Don't save debug controls");
+	report(vmx_get_test_stage() == 4, "DR7: Don't save debug controls");
 }
 
-static int dbgctls_exit_handler(union exit_reason exit_reason)
+static int dbgctls_dr7_exit_handler(union exit_reason exit_reason)
 {
 	u32 insn_len = vmcs_read(EXI_INST_LEN);
 	u64 guest_rip = vmcs_read(GUEST_RIP);
-	u64 dr7, debugctl;
+	u64 dr7;
 
 	asm volatile("mov %%dr7,%0" : "=r" (dr7));
-	debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
 
 	switch (exit_reason.basic) {
 	case VMX_VMCALL:
 		switch (vmx_get_test_stage()) {
 		case 0:
-			if (dr7 == 0x400 && debugctl == 0 &&
-			    vmcs_read(GUEST_DR7) == 0x408 /* &&
-			    Commented out: KVM does not support DEBUGCTL so far
-			    vmcs_read(GUEST_DEBUGCTL) == 0x3 */)
+			if (dr7 == 0x400 &&
+			    vmcs_read(GUEST_DR7) == 0x408)
 				vmx_inc_test_stage();
 			break;
 		case 2:
 			dr7 = 0x402;
 			asm volatile("mov %0,%%dr7" : : "r" (dr7));
-			wrmsr(MSR_IA32_DEBUGCTLMSR, 0x1);
 			vmcs_write(GUEST_DR7, 0x404);
-			vmcs_write(GUEST_DEBUGCTL, 0x2);
 
 			vmcs_write(ENT_CONTROLS,
 				vmcs_read(ENT_CONTROLS) & ~ENT_LOAD_DBGCTLS);
@@ -1952,10 +1936,8 @@ static int dbgctls_exit_handler(union exit_reason exit_reason)
 				vmcs_read(EXI_CONTROLS) & ~EXI_SAVE_DBGCTLS);
 			break;
 		case 3:
-			if (dr7 == 0x400 && debugctl == 0 &&
-			    vmcs_read(GUEST_DR7) == 0x404 /* &&
-			    Commented out: KVM does not support DEBUGCTL so far
-			    vmcs_read(GUEST_DEBUGCTL) == 0x2 */)
+			if (dr7 == 0x400 &&
+			    vmcs_read(GUEST_DR7) == 0x404)
 				vmx_inc_test_stage();
 			break;
 		}
@@ -11780,7 +11762,7 @@ struct vmx_test vmx_tests[] = {
 		interrupt_exit_handler, NULL, {0} },
 	{ "nmi_hlt", nmi_hlt_init, nmi_hlt_main,
 		nmi_hlt_exit_handler, NULL, {0} },
-	{ "debug controls", dbgctls_init, dbgctls_main, dbgctls_exit_handler,
+	{ "debug controls dr7", dbgctls_dr7_init, dbgctls_dr7_main, dbgctls_dr7_exit_handler,
 		NULL, {0} },
 	{ "MSR switch", msr_switch_init, msr_switch_main,
 		msr_switch_exit_handler, NULL, {0}, msr_switch_entry_failure },
-- 
2.43.5

