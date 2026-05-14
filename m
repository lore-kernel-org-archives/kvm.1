Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEABD3CC7E3
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792710; cv=none; b=ggqr0YqD0GWrwvRneY8jIINWjKQBuApkNjVQ9lGUjRYftpAY8rKWJRCwHZZ2kV8FsK4gXErBa1grYCS938YiTr5CPgLyZBcDDxp1z8ax0EkfrdH34841jxJX3qXnlg9P93rXtTvfolkpb/8dKo+b1W4rw4t1lB1blPRYMC47Iv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792710; c=relaxed/simple;
	bh=Czh8NFrVA43CV9xGLodRYfpE0ZYAExoWfIc7Q1DvB24=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JPrSjtC0yO/T2bJdeV+dkWeSwIzvhyxqnPWqFpkFqamELiNKl/IiC0/KPlTdy8M9UDt+QemTSoUBeYufS5wg9itIuSAuFgIaVw3sCFxDjDbMpAn9HaOVQR5E9/Nr57yIEr+vmYydWrlSkBcNsg+6ilh2QRzgjXmNehDyM9qWvkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mjKy0rDD; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mjKy0rDD"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-837d0d71c61so5045013b3a.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792705; x=1779397505; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/X+a8EhTdkduSD9wpi56lBr+csHXgQhqReI9IAbYx50=;
        b=mjKy0rDDofiV8Vlbu7p0y3Y8Vqaau5UkwAjqdXW5ud9nDthkBU1n2WPsI0YRaiG6ED
         5llY62U8gIY38trr2Uu72aEZoa66Q+EWYFumKzP+ZO1sEIyu4TVgAeKcfChgCt0t01uH
         wjGfEACkYerepuig1jcmbNevTogR3q30i6QY4KTw7j6Naec4DdZuOUq6BJHu6D5+LVV2
         sOzU92yxhqdnx2T12NnH1bBQnAUiYBijz/eCedgu0f2ERfnTKf5ic6VtMwPFS9B/odRO
         6y+xWMgBBpXtd6+wV8rQvq7kHx210OLXhJVA6/w/q1ISh8q1kD6KiVgi753eOZJi4F30
         i6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792705; x=1779397505;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/X+a8EhTdkduSD9wpi56lBr+csHXgQhqReI9IAbYx50=;
        b=AAl95POrb6cZRcHCvCcIScBwwoWeewLaiC5ze5opoPzgeEWaYEzallI07QW0xfEHXa
         awCBy+iVpPgywXuMTMrerKYq/fCrIQwvtXSDgy8N73/WvofTIujE92ycAxI3Z8yUht/F
         tvloGJ83vkZNsVLZMZ2hhVObGQai2lgoIOW8E4v7nGXan5uaMv3vKCtWi1wdhuQy/Cve
         DBy/KvlroJ5iC/5lQu67hAVivsk9JBtfYeoWubJ4a7xy/UFDDbgWuHwbqaX9JP125lgV
         zFZvRPGStXYDJb/NhZg+FEXlEbJl1npQs+I2yR2Gsg34rwBMCVyC3v5q9aua6BQp+f6c
         oerQ==
X-Gm-Message-State: AOJu0Yy+i+vX25AxBA4+rlQXDdFcjE2SJkpKQwPVlaUyD+0vPPJToyV7
	TBXbSCSzaKgGMz9hXmhxWADzb9TYh78KlqzIE5hFPHDNrNkmI/Y4f2zhAUtePoRZk34OFwVueBA
	/OPSJVg==
X-Received: from pfbg7.prod.google.com ([2002:a05:6a00:ae07:b0:837:c09c:9cce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d9f:b0:82f:5c3f:94c6
 with SMTP id d2e1a72fcca58-83f33d3ac7emr1119068b3a.28.1778792704636; Thu, 14
 May 2026 14:05:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:42 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-3-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 02/20] x86/vmx: Drop unused guest_regs
 "support" in nested VMX infrastructure
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Drop vmx_tests.guest_regs as no tests use the functionality, the field is
very misleading (it's only used to set the initial regs, i.e. it's not an
up-to-date snapshot), and per-test register state doesn't play nice with
tests that create and run multiple vCPUs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/vmx.c       |  3 +--
 x86/vmx.h       |  1 -
 x86/vmx_tests.c | 44 +++++++++++++++++++++-----------------------
 3 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/x86/vmx.c b/x86/vmx.c
index 2b85ef0b..44ee3697 100644
--- a/x86/vmx.c
+++ b/x86/vmx.c
@@ -1834,6 +1834,7 @@ static int test_run(struct vmx_test *test)
 		return 1;
 	}
 
+	memset(&regs, 0, sizeof(regs));
 	init_vmcs(&(test->vmcs));
 	/* Directly call test->init is ok here, init_vmcs has done
 	   vmcs init, vmclear and vmptrld*/
@@ -1843,8 +1844,6 @@ static int test_run(struct vmx_test *test)
 	v2_guest_main = NULL;
 	test->exits = 0;
 	current = test;
-	regs = test->guest_regs;
-	vmcs_write(GUEST_RFLAGS, regs.rflags | X86_EFLAGS_FIXED);
 	launched = 0;
 	guest_finished = 0;
 	printf("\nTest suite: %s\n", test->name);
diff --git a/x86/vmx.h b/x86/vmx.h
index f4ed5339..425b1c43 100644
--- a/x86/vmx.h
+++ b/x86/vmx.h
@@ -121,7 +121,6 @@ struct vmx_test {
 	int (*init)(struct vmcs *vmcs);
 	void (*guest_main)(void);
 	int (*exit_handler)(union exit_reason exit_reason);
-	struct regs guest_regs;
 	int (*entry_failure_handler)(struct vmentry_result *result);
 	struct vmcs *vmcs;
 	int exits;
diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 83d88480..e0d5e390 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -11757,37 +11757,35 @@ static void vmx_cet_test(void)
 
 #define TEST(name) { #name, .v2 = name }
 
-/* name/init/guest_main/exit_handler/guest_regs */
+/* name/init/guest_main/exit_handler/vmfail_handler */
 struct vmx_test vmx_tests[] = {
-	{ "null", NULL, basic_guest_main, basic_exit_handler, {0} },
-	{ "vmenter", NULL, vmenter_main, vmenter_exit_handler, {0} },
+	{ "null", NULL, basic_guest_main, basic_exit_handler, },
+	{ "vmenter", NULL, vmenter_main, vmenter_exit_handler, },
 	{ "preemption timer", preemption_timer_init, preemption_timer_main,
-		preemption_timer_exit_handler, {0} },
+		preemption_timer_exit_handler },
 	{ "control field PAT", test_ctrl_pat_init, test_ctrl_pat_main,
-		test_ctrl_pat_exit_handler, {0} },
+		test_ctrl_pat_exit_handler },
 	{ "control field EFER", test_ctrl_efer_init, test_ctrl_efer_main,
-		test_ctrl_efer_exit_handler, {0} },
-	{ "CR shadowing", NULL, cr_shadowing_main,
-		cr_shadowing_exit_handler, {0} },
-	{ "I/O bitmap", iobmp_init, iobmp_main, iobmp_exit_handler,
-		{0} },
+		test_ctrl_efer_exit_handler },
+	{ "CR shadowing", NULL, cr_shadowing_main, cr_shadowing_exit_handler },
+	{ "I/O bitmap", iobmp_init, iobmp_main, iobmp_exit_handler },
 	{ "instruction intercept", insn_intercept_init, insn_intercept_main,
-		insn_intercept_exit_handler, {0} },
-	{ "EPT A/D disabled", ept_init, ept_main, ept_exit_handler, {0} },
-	{ "EPT A/D enabled", eptad_init, eptad_main, eptad_exit_handler, {0} },
-	{ "PML", pml_init, pml_main, pml_exit_handler, {0} },
-	{ "interrupt", interrupt_init, interrupt_main, interrupt_exit_handler, {0} },
-	{ "nmi_hlt", nmi_hlt_init, nmi_hlt_main, nmi_hlt_exit_handler, {0} },
-	{ "debug controls", dbgctls_init, dbgctls_main, dbgctls_exit_handler, {0} },
+		insn_intercept_exit_handler },
+	{ "EPT A/D disabled", ept_init, ept_main, ept_exit_handler },
+	{ "EPT A/D enabled", eptad_init, eptad_main, eptad_exit_handler },
+	{ "PML", pml_init, pml_main, pml_exit_handler },
+	{ "interrupt", interrupt_init, interrupt_main, interrupt_exit_handler },
+	{ "nmi_hlt", nmi_hlt_init, nmi_hlt_main, nmi_hlt_exit_handler },
+	{ "debug controls", dbgctls_init, dbgctls_main, dbgctls_exit_handler },
 	{ "MSR switch", msr_switch_init, msr_switch_main,
-		msr_switch_exit_handler, {0}, msr_switch_entry_failure },
-	{ "vmmcall", vmmcall_init, vmmcall_main, vmmcall_exit_handler, {0} },
+		msr_switch_exit_handler, msr_switch_entry_failure },
+	{ "vmmcall", vmmcall_init, vmmcall_main, vmmcall_exit_handler },
 	{ "disable RDTSCP", disable_rdtscp_init, disable_rdtscp_main,
-		disable_rdtscp_exit_handler, {0} },
+		disable_rdtscp_exit_handler },
 	{ "exit_monitor_from_l2_test", NULL, exit_monitor_from_l2_main,
-		exit_monitor_from_l2_handler, {0} },
+		exit_monitor_from_l2_handler },
 	{ "invalid_msr", invalid_msr_init, invalid_msr_main,
-		invalid_msr_exit_handler, {0}, invalid_msr_entry_failure},
+		invalid_msr_exit_handler, invalid_msr_entry_failure},
 	/* Basic V2 tests. */
 	TEST(v2_null_test),
 	TEST(v2_multiple_entries_test),
@@ -11873,5 +11871,5 @@ struct vmx_test vmx_tests[] = {
 	TEST(vmx_canonical_test),
 	/* "Load CET" VM-entry/exit controls tests. */
 	TEST(vmx_cet_test),
-	{ NULL, NULL, NULL, NULL, {0} },
+	{ NULL, NULL, NULL, NULL },
 };
-- 
2.54.0.563.g4f69b47b94-goog

