Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B478282F3A
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894757; cv=none; b=gpjc6gv1s6iQSUtsbxJrtanlIO9R2J4WDNpNlGctp+9272neoOct6cXSc4Tr5+tKwCuQty1u7LuWfLDSwu2Q8Gsu1tDrqODAIUfJZacHtK2gQKO/p+5ADL1DTSCBswjmwi6k3GBjY/tWv3s7R0+f4qBewlRI8USvuqBWWJIo97w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894757; c=relaxed/simple;
	bh=e3A1HZ41zecjYIKcdrx3x9LObBwTwqrepVPkmq4lxDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rau/AV+PmeEgpHeLFz0r7pKpa6gMJSnYB9/Aa+1N1AYQ7nk2nAtsVJtkg+gaNZErgK7sVp0ZV24/pVdo2aVC88Lx5XNUyAZIs/aWvQf6IEsISd4TLSerjUpbT4MKWGS1QDcjADQ/Fvzx3w8UDldf83/FcPqNvg4W7wISChjS1aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2mVBE5F; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2mVBE5F"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c828f0f5c23so5826798a12.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 08:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779894755; x=1780499555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BGrx7VRA0xtVri9tWNS/dieKRjaheG9j4edqs+9YJ3o=;
        b=q2mVBE5FGRBCS7qxnTRxj92/eVVvqMCZa/0cjGCsLRjcYuXKf3yUpN54oU8FjDHXqK
         6Jpl1zvFjE8tenEMv3A8R9g5BWwBBdNq4mOBuz2lMufSUmRlz4i1XM5kLudaVABSSUzO
         VS8PBsPfFGuCrampkh6nkg6y3XLPZlzDTNM33/R75JXGEhkEWGEGXK3BIb2oJ2aqFhqs
         4PT/rLtmRHwY96XI1FLo2gmnui28bf9hbMV5up2Hdad0168u8aaCYsJyF5TGMv3hXfF2
         /svVr5TBVkbS57B2C3yXkLsZE9Pa7m/usYNp7E01i2nRxkA7DVNjNp0eDwvZ4QjocxpR
         ZVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779894755; x=1780499555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGrx7VRA0xtVri9tWNS/dieKRjaheG9j4edqs+9YJ3o=;
        b=j0jUsHJPRuk1jovNz8qSIb+49wrXd1A95bKCH1i4emHQRdz7Kec1XyTXciG3ulSKGn
         jE65lGn7frrs1YLPrNH31yTJP4G8mmhYMObOt5yU27NNaa7wOhBK+ENguHbgssaT5x9l
         fUr8CQHG5PbPaC4YjUgRH0ACUUj53hbg4tsN+E/J8bs9Bvb7iHNFw0JiB/PwGhIzZvqR
         iQSQl0UTaJCy31heYLdftl1PZELgUvs+VH8BClLowELLJcbe6gKMTyiH+wMyge1HnKc0
         aKSQ0Azkp32OpVh9WLuIe+4MDwaGONg3FU+4AexAcSBrEj84CRjkYQyhYK7gZKe2dusH
         dKdw==
X-Gm-Message-State: AOJu0Yz+cAjiKgZG0kg+jzDeGgodfIrY6sZwB7wf3Y5fjdCqGx5/woVt
	4sjIOWXY/F1LoBd6NjtW+2qEZjPdS584TGR1dQBLRl1eI97Fg9H9iFGY4UH7aFSqONWqvzry0m+
	fosHLyQ==
X-Received: from pfnw5.prod.google.com ([2002:aa7:8585:0:b0:835:5b01:54e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:9a85:0:b0:836:3f6a:3e7a
 with SMTP id d2e1a72fcca58-8415f3078dfmr22452281b3a.26.1779894754842; Wed, 27
 May 2026 08:12:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 May 2026 08:12:31 -0700
In-Reply-To: <20260527151232.4058615-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527151232.4058615-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260527151232.4058615-2-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 1/2] nVMX: Remove the IA32_DEBUGCTLMSR
 access in debugctls test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Chenyi Qiang <chenyi.qiang@intel.com>

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
people to think something wrong happened in the test case, and the test
isn't actually validating anything useful.

Now that KVM supports some MSR_IA32_DEBUGCTL based features (dependent on
the underlying hardware), drop the old, half-baked code for DEBUGCTL in
anticipation of adding a dedicated functional test for DEBUTCTL.  Keep the
existing DR7 coverage, but rename the testcase to explicitly scope it to
just DR7.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
[sean: massage changelog, name testcase dbgctls_dr7]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/vmx_tests.c | 46 ++++++++++++++--------------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 7aa3194c..e1f53fbe 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -1858,21 +1858,18 @@ static int nmi_hlt_exit_handler(union exit_reason exit_reason)
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
@@ -1880,23 +1877,19 @@ static int dbgctls_init(struct vmcs *vmcs)
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
@@ -1907,46 +1900,37 @@ static void dbgctls_main(void)
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
@@ -1954,10 +1938,8 @@ static int dbgctls_exit_handler(union exit_reason exit_reason)
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
@@ -11813,7 +11795,7 @@ struct vmx_test vmx_tests[] = {
 	{ "PML", pml_init, pml_main, pml_exit_handler },
 	{ "interrupt", interrupt_init, interrupt_main, interrupt_exit_handler },
 	{ "nmi_hlt", nmi_hlt_init, nmi_hlt_main, nmi_hlt_exit_handler },
-	{ "debug controls", dbgctls_init, dbgctls_main, dbgctls_exit_handler },
+	{ "dbgctls_dr7", dbgctls_dr7_init, dbgctls_dr7_main, dbgctls_dr7_exit_handler },
 	{ "MSR switch", msr_switch_init, msr_switch_main,
 		msr_switch_exit_handler, msr_switch_entry_failure },
 	{ "vmmcall", vmmcall_init, vmmcall_main, vmmcall_exit_handler },
-- 
2.54.0.823.g6e5bcc1fc9-goog

