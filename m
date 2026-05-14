Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47783CEB9E
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792717; cv=none; b=a769l6Ew4bDm+7z1WAtT3ipzvKOF3N6OOpIreyLfINDEqtwU3TMafBW/1oYSKs3mz4RFwp3sJ7DncAYPSH368X4veaxoEQs+ea4+gaUbkmG065LB+Sj5yf7O2qFUWGilKwKc44wC7NL92gt68JGUeOVgya1Ol/w951OWnzFtkd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792717; c=relaxed/simple;
	bh=/9L1za0eSmZyXsOQB/3ms9QjhULlyfubVzDgZyipqIs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g7P5R42Neara9E8elLtz8yT62qVqYJR57AdI59PcCdCczKgyMTd9H4GHfckXaAoG+XNKEzNOkuMRhHAvBZjwIQzu1znl4vvFemcHHg8bG4Yvq6fGgCRRzfD+IrYHIHmsdxT7U92WNOKr9hhpDeaqVt+wqc7RgXc2jHXO/aGVgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r2o5IRcQ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r2o5IRcQ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83565161a6eso124584b3a.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792715; x=1779397515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3dYw+5waHGd0rqn4BKa0LMB422nyEIhsCNeHWTlNZxM=;
        b=r2o5IRcQ/qW3bG7K9KAATjFkj1LeHEp5EnqbPRWARKobC0qmtlnT530MKWt3qxPRnN
         f/RfamelwkkadEC6YUPeW2g7CrbeVy0uzrS+8+xN385x9FKZSR347EyQELsrL0Mfv8P+
         tOJAffJ7K/uMCEi5Kf8KruYNTxDen7HpaGIdIUdI26VKSkiqdbKQ67Z85nU/oE9SRxoA
         mx1yIIQinbfe8OGiS9lUi3NsbvocrMoO8/rG79in9QVxd+TrIOh0fGd1Ovh9GoOKrag8
         4p0AIhjRK/FBOxduKEIQtLiYF5laYaNhj1XXvoWsXIrU/ohxVLyRnZ7idhcBx0XnS9FK
         +o4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792715; x=1779397515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dYw+5waHGd0rqn4BKa0LMB422nyEIhsCNeHWTlNZxM=;
        b=r0mcl/F0SvMnCEsel+GYBWZVCOFezXpuGXaH6Np7WzM2/kA6J8O+X+CrnUXUMFjfEp
         K4fslBSfJNrSD6Dd591E7ohLRsyzM4pIeqBUOLQT19fjrLcEnpyn4JlX70Zu3LnOahO0
         90rTDteCA+I4zqYxRYY1ynf0HaR8gtFcT+MObxrtguUYfcJKCBQlqwFIn/pjJ4DqkT+t
         BcXHJG+Y1/11MZDEq0LTCemJL40dQQ3UzbZFkN8ys1+C64hE9nZVNWYdC+V5wHxT4WwS
         O85Nt316g2wFBNYMcOBd2h2bDkolwosX+BK9JRHAjVo7VEAHK+l0PgyxS9HcneHgL+qF
         I4mw==
X-Gm-Message-State: AOJu0YyggrOL/12toz+iWAnHJqq2hHMe/hw285Qm0xtM8VJxmKCIE5Je
	GcqlQa4CUHclMD8lhW/V0BoTmKMBRzCwcqYPZLgxd6MtmWgUyQidldOsgfwoEas7a8vu+kadad0
	4UvaMWg==
X-Received: from pfhh12.prod.google.com ([2002:a05:6a00:230c:b0:838:1469:2431])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:882:b0:82f:4725:f6d0
 with SMTP id d2e1a72fcca58-83f18ec292amr5179519b3a.29.1778792715161; Thu, 14
 May 2026 14:05:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:51 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-12-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 11/20] x86/vmx: Track "is this CPU in guest
 mode" per-CPU
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Track whether or not a CPU is in a SVM/VMX guest on a per-CPU basis to
play nice with SVM/VMX tests that run multiple vCPUs.  How the VMX tests
in particular managed to survive this long with shared state is nothing
short of amazing.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/smp.h |  3 +++
 x86/vmx.c     | 18 +++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/lib/x86/smp.h b/lib/x86/smp.h
index 7f973227..683240d8 100644
--- a/lib/x86/smp.h
+++ b/lib/x86/smp.h
@@ -60,6 +60,8 @@ struct percpu_data {
 	struct guest_regs guest_regs;
 	/* Track whether or not the current CPU's VMCS has been "launched". */
 	bool launched;
+	/* Track if this CPU is running in an SVM or VMX guest. */
+	bool in_guest;
 };
 
 #define typeof_percpu(name) typeof(((struct percpu_data *)0)->name)
@@ -113,6 +115,7 @@ BUILD_PERCPU_OP(exception_rflags_rf);
 BUILD_PERCPU_OP(exception_error_code);
 BUILD_PERCPU_OP(apic_ops);
 BUILD_PERCPU_OP(launched);
+BUILD_PERCPU_OP(in_guest);
 
 void smp_init(void);
 
diff --git a/x86/vmx.c b/x86/vmx.c
index 85772cae..12e5d449 100644
--- a/x86/vmx.c
+++ b/x86/vmx.c
@@ -62,7 +62,6 @@ static test_guest_func v2_guest_main;
 u64 hypercall_field;
 static int matched;
 static int guest_finished;
-static int in_guest;
 
 union vmx_basic_msr basic_msr;
 union vmx_ctrl_msr ctrl_pin_rev;
@@ -1672,7 +1671,7 @@ static int handle_hypercall(void)
 
 static void continue_abort(void)
 {
-	assert(!in_guest);
+	assert(!this_cpu_read_in_guest());
 	printf("Host was here when guest aborted:\n");
 	dump_stack();
 	longjmp(abort_target, 1);
@@ -1681,7 +1680,7 @@ static void continue_abort(void)
 
 void __abort_test(void)
 {
-	if (in_guest)
+	if (this_cpu_read_in_guest())
 		hypercall(HYPERCALL_VMABORT);
 	else
 		longjmp(abort_target, 1);
@@ -1690,14 +1689,17 @@ void __abort_test(void)
 
 static void continue_skip(void)
 {
-	assert(!in_guest);
+	assert(!this_cpu_read_in_guest());
 	longjmp(abort_target, 1);
 	abort();
 }
 
 void test_skip(const char *msg)
 {
+	bool in_guest = this_cpu_read_in_guest();
+
 	printf("%s skipping test: %s\n", in_guest ? "Guest" : "Host", msg);
+
 	if (in_guest)
 		hypercall(HYPERCALL_VMABORT);
 	else
@@ -1731,7 +1733,8 @@ static noinline void vmx_enter_guest(struct vmentry_result *result)
 
 	memset(result, 0, sizeof(*result));
 
-	in_guest = 1;
+	this_cpu_write_in_guest(true);
+
 	asm volatile (
 		"mov %[HOST_RSP], %%rdi\n\t"
 		"vmwrite %%rsp, %%rdi\n\t"
@@ -1758,7 +1761,8 @@ static noinline void vmx_enter_guest(struct vmentry_result *result)
 		  GUEST_REGS_OFFSETS
 		: "rdi", "memory", "cc"
 	);
-	in_guest = 0;
+
+	this_cpu_write_in_guest(false);
 
 	result->vmlaunch = !launched;
 	result->instr = launched ? "vmresume" : "vmlaunch";
@@ -1854,7 +1858,7 @@ static int test_run(struct vmx_test *test)
 
 	r = setjmp(abort_target);
 	if (r) {
-		assert(!in_guest);
+		assert(!this_cpu_read_in_guest());
 		goto out;
 	}
 
-- 
2.54.0.563.g4f69b47b94-goog

