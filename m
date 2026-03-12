Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7F639DBC2
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348016; cv=none; b=oW0ooJmWoOl4u8DpwJXytCVqk55vFDTaTDFK0zLA7LWZwfkD0e3gAw99d7Nj7WxRk4aQi+jnp/OhSQHGO5jiqRWWQWqRvGYBSL0pQd3uSTN0sO1mCzE91FPB3l2ECDdh1mAUIl1V780lA3Jid1mGblQaLNQW6y0BmVfZvvgAVdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348016; c=relaxed/simple;
	bh=il0ad+YPJs1wmMuW7aUgh7FP2txVZBf5MnaTmaTXxPk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TsRtLSS6JQwUt2vVnSczCZIUYCbDBnIDd9tA8+mlarrUMIJVKS6nFzfTGYUYdJohpGHoAJpzdiZlo5lXhql9b7GcyNO+ftCCbui63hHB1L01R0AltTOX8dBatI6gZne1gEi3doVwCsumPwgC/GXnmEAU4bl6kjIRcBCyjHeKXj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ikVuyq5M; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikVuyq5M"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aeb90532f6so15802025ad.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 13:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773348014; x=1773952814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n12AHJWLdynO/Jqtyit0q+iqx60D6gkwxd0Z537x80w=;
        b=ikVuyq5M4JexkpueSUIYXDKPU691bYXybH2Muz+9L9ve2HegT+ObE1K+1H0CmlBUG1
         apNRN9I97RFdoYj073YOqYDTvlABe4t/EZVAFxxSpMgM/TJQRCaI5vkxXfdmuiznAKP7
         1Q0eEIRGhylOeOm2eNyZsf3aV5DF0CzAWn8/edkIqrFQW2QzGTnPz/fC/ZF0tje0SH1R
         H+4tEGgnHsZUmttvp7MDanuWDaUCXZpi1clJhWXlxt4xRRuF4pxp3leO0gQxg/zGE747
         Xn9GH8F6LvitCvfzBQB0agnG86+JI08xCZPZDPaOxgUiRqqHAK0jJfIg/hwgQhpbAbpX
         liew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773348014; x=1773952814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n12AHJWLdynO/Jqtyit0q+iqx60D6gkwxd0Z537x80w=;
        b=Xymy407iBRgXImN7RIb4gAPW4ug9y+BwdmEFZpONxbpZW25hkhayKF7ug5s4vMAcrN
         YC8s0JGu8Ua1F/vBrURkrnVXI8Mt2u03kh0G5kDMWR2syZH+8Qfr6olzJ1KECfU0/hTK
         xrefXS9f27GTEAJCEt9/PRpD/Cs2hOWc1LBcGyfV//DK8aySBIL5mwul+8JebkFl7hVj
         00owfEsOikApbKgo49xBeiDLrub5l/mRrxrSah0tKm03iJJ5uTZYKjg2oGCWam0kwM5I
         GcaUhGFinAo25QDXa3PXIZhOxRcJXEvK5qqvA9pKKovvcZb9tOL7Nc3LqlSnlPm7spnp
         94Ow==
X-Gm-Message-State: AOJu0YzY/GLE0khH9GncjQWV/TVu73TQRLDxPvjZtC4ZdYaN+hWYoFK3
	Zc/pbLZ2hgmGJDSPAZDIzUsjzE4yVRsYQlxpLyRho05j2MiPat+6QBMi7QXpQcLKn/0voyiBi/V
	ObyJ7v9MBTZuDk2yzLZZ+KLiIXHrWK454BGg/CZIe8yP3GFir1gFrLu2RSSRic3Mgw7L5hZopET
	IxYD0KhTYHxYpgkMz2XOil5njHF5GP7kscfpnoEKIWGQw=
X-Received: from plzu7.prod.google.com ([2002:a17:902:82c7:b0:2ae:5e9d:8d47])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d501:b0:2ae:bd12:f830 with SMTP id d9443c01a7336-2aecac9b8e0mr7622225ad.49.1773348013943;
 Thu, 12 Mar 2026 13:40:13 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:40:09 +0000
In-Reply-To: <20260312204009.3168871-1-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312204009.3168871-1-chengkev@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312204009.3168871-3-chengkev@google.com>
Subject: [kvm-unit-tests PATCH v4 2/2] x86/svm: Add unsupported instruction
 intercept test
From: Kevin Cheng <chengkev@google.com>
To: kvm@vger.kernel.org
Cc: yosry@kernel.org, andrew.jones@linux.dev, thuth@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

Add tests that expect a nested vm exit, due to an unsupported
instruction, to be handled by L0 even if L1 intercepts are set for that
instruction.

The new test exercises bug fixed by:
https://lore.kernel.org/all/20251205070630.4013452-1-chengkev@google.com/

Signed-off-by: Kevin Cheng <chengkev@google.com>
---
 lib/x86/processor.h |  1 +
 x86/svm.h           |  5 ++-
 x86/svm_tests.c     | 88 +++++++++++++++++++++++++++++++++++++++++++++
 x86/unittests.cfg   | 11 +++++-
 4 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/lib/x86/processor.h b/lib/x86/processor.h
index 42dd2d2a4787..7e1c562aa737 100644
--- a/lib/x86/processor.h
+++ b/lib/x86/processor.h
@@ -358,6 +358,7 @@ struct x86_cpu_feature {
  * Extended Leafs, a.k.a. AMD defined
  */
 #define X86_FEATURE_SVM			X86_CPU_FEATURE(0x80000001, 0, ECX, 2)
+#define X86_FEATURE_SKINIT		X86_CPU_FEATURE(0x80000001, 0, ECX, 12)
 #define X86_FEATURE_PERFCTR_CORE	X86_CPU_FEATURE(0x80000001, 0, ECX, 23)
 #define X86_FEATURE_NX			X86_CPU_FEATURE(0x80000001, 0, EDX, 20)
 #define X86_FEATURE_GBPAGES		X86_CPU_FEATURE(0x80000001, 0, EDX, 26)
diff --git a/x86/svm.h b/x86/svm.h
index c22c252fed00..e2158ab0622b 100644
--- a/x86/svm.h
+++ b/x86/svm.h
@@ -406,7 +406,10 @@ struct __attribute__ ((__packed__)) vmcb {
 #define SVM_EXIT_MONITOR	0x08a
 #define SVM_EXIT_MWAIT		0x08b
 #define SVM_EXIT_MWAIT_COND	0x08c
-#define SVM_EXIT_NPF  		0x400
+#define SVM_EXIT_XSETBV		0x08d
+#define SVM_EXIT_RDPRU		0x08e
+#define SVM_EXIT_INVPCID	0x0a2
+#define SVM_EXIT_NPF		0x400
 
 #define SVM_EXIT_ERR		-1
 
diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index f18f2ed16b3f..657e66179f77 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -3578,6 +3578,93 @@ static void svm_shutdown_intercept_test(void)
 	report(vmcb->control.exit_code == SVM_EXIT_SHUTDOWN, "shutdown test passed");
 }
 
+struct invpcid_desc desc;
+
+asm(
+	"insn_rdtscp: rdtscp;ret\n\t"
+	"insn_skinit: skinit;ret\n\t"
+	"insn_xsetbv: xor %eax, %eax; xor %edx, %edx; xor %ecx, %ecx; xsetbv;ret\n\t"
+	"insn_rdpru: xor %ecx, %ecx; rdpru;ret\n\t"
+	"insn_invpcid: xor %eax, %eax; invpcid desc, %rax;ret\n\t"
+);
+
+extern void insn_rdtscp(struct svm_test *test);
+extern void insn_skinit(struct svm_test *test);
+extern void insn_xsetbv(struct svm_test *test);
+extern void insn_rdpru(struct svm_test *test);
+extern void insn_invpcid(struct svm_test *test);
+
+struct insn_table {
+	const char *name;
+	u64 intercept;
+	void (*insn_func)(struct svm_test *test);
+	u32 reason;
+};
+
+static struct insn_table insn_table[] = {
+	{ "RDTSCP", INTERCEPT_RDTSCP, insn_rdtscp, SVM_EXIT_RDTSCP},
+	{ "SKINIT", INTERCEPT_SKINIT, insn_skinit, SVM_EXIT_SKINIT},
+	{ "XSETBV", INTERCEPT_XSETBV, insn_xsetbv, SVM_EXIT_XSETBV},
+	{ "RDPRU", INTERCEPT_RDPRU, insn_rdpru, SVM_EXIT_RDPRU},
+	{ "INVPCID", INTERCEPT_INVPCID, insn_invpcid, SVM_EXIT_INVPCID},
+	{ NULL },
+};
+
+static void assert_unsupported_instructions(void)
+{
+	assert(!this_cpu_has(X86_FEATURE_RDTSCP));
+	assert(!this_cpu_has(X86_FEATURE_SKINIT));
+	assert(!this_cpu_has(X86_FEATURE_XSAVE));
+	assert(!this_cpu_has(X86_FEATURE_RDPRU));
+	assert(!this_cpu_has(X86_FEATURE_INVPCID));
+}
+
+/*
+ * Test that L1 does not intercept instructions that are not advertised in
+ * guest CPUID.
+ */
+static void svm_unsupported_instruction_intercept_test(void)
+{
+	u32 cur_insn;
+	u32 exit_code;
+
+	assert_unsupported_instructions();
+
+	vmcb_set_intercept(INTERCEPT_EXCEPTION_OFFSET + UD_VECTOR);
+
+	for (cur_insn = 0; insn_table[cur_insn].name != NULL; ++cur_insn) {
+		struct insn_table insn = insn_table[cur_insn];
+
+		test_set_guest(insn.insn_func);
+		vmcb_set_intercept(insn.intercept);
+		svm_vmrun();
+		exit_code = vmcb->control.exit_code;
+
+		if (exit_code == SVM_EXIT_EXCP_BASE + UD_VECTOR)
+			report_pass("UD Exception injected");
+		else if (exit_code == insn.reason)
+			report_fail("L1 should not intercept %s when instruction is not advertised in guest CPUID",
+				    insn.name);
+		else
+			report_fail("Unknown exit reason, 0x%x", exit_code);
+
+		/*
+		 * Verify that the intercept bits are not cleared in the vmcb.
+		 * This is mainly to catch any potential bugs in the future
+		 * if we ever directly copy from the cached vmcb12 to L1's
+		 * vmcb12. KVM currently ignores the L1 intercept by
+		 * conditionally clearing intercept bits from KVM's cached
+		 * vmcb12 based on guest's CPUID table. This is only allowed as
+		 * long as the assumption that the cached vmcb12 doesn't affect
+		 * L1's vmcb12 holds true.
+		 */
+		report(test_and_clear_bit(insn.intercept,
+					  vmcb->control.intercept),
+					  "%s intercept bit not cleared by KVM",
+					  insn.name);
+	}
+}
+
 struct svm_test svm_tests[] = {
 	{ "null", default_supported, default_prepare,
 	  default_prepare_gif_clear, null_test,
@@ -3719,6 +3806,7 @@ struct svm_test svm_tests[] = {
 	TEST(svm_tsc_scale_test),
 	TEST(pause_filter_test),
 	TEST(svm_shutdown_intercept_test),
+	TEST(svm_unsupported_instruction_intercept_test),
 	{ NULL, NULL, NULL, NULL, NULL, NULL, NULL }
 };
 
diff --git a/x86/unittests.cfg b/x86/unittests.cfg
index 522318d32bf6..27a1a6810436 100644
--- a/x86/unittests.cfg
+++ b/x86/unittests.cfg
@@ -253,11 +253,20 @@ arch = x86_64
 [svm]
 file = svm.flat
 smp = 2
-test_args = "-pause_filter_test"
+test_args = "-pause_filter_test -svm_unsupported_instruction_intercept_test"
 qemu_params = -cpu max,+svm -m 4g
 arch = x86_64
 groups = svm
 
+# RDPRU feature name is not defined in Qemu so it can't be excluded here. This
+# should be okay though since KVM does not advertise RDPRU by default anyways.
+[svm_unsupported_instruction_intercept_test]
+file = svm.flat
+test_args = "svm_unsupported_instruction_intercept_test"
+qemu_params = -cpu max,+svm,-rdtscp,-xsave,-invpcid,-skinit
+arch = x86_64
+groups = svm
+
 [svm_pause_filter]
 file = svm.flat
 test_args = pause_filter_test
-- 
2.53.0.851.ga537e3e6e9-goog

