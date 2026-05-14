Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7463D3A75A7
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792715; cv=none; b=Mg61MgQZ5lodJBxZlLZ18oXpUUZTIlPfJxdtm2lXKCz+Y29L4qTUEwzg7GtGRhEJts8SGRabWzFmA1XdHp9RzwiJ7duM7Im5k9hoDmw/d7NneDS6L8WKvKlMg3H3VZfKYvRPxIF9w6SVMd/3e7xM/GLHsPlp+KcFgUaT41hK190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792715; c=relaxed/simple;
	bh=w/rdUkTBj9yVGP1nSkE/9qf2PaOzvwgRk1YXVgatrzQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lYTYh0NIwnhYHW1En9usfOEXozQ/o93RhS6hwXK7UFD4Jtc+dxugw4Rst1py32Ln2G5SLvD0uAInRbO5keHBIP3O76tz3yssIOaIg/LU1Uc7k2XfqoXg+PF9QFujhvEXCMTNTSG7f3GOM4zMvt+NPdE+vxt7OAI+6ja04TS4zSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wxe7M/hT; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wxe7M/hT"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f6b984b3aso4380624b3a.3
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792714; x=1779397514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=1w+bIJUK1280MIs2G1eyxDF99wD3XZvdmGYFNMacs+U=;
        b=Wxe7M/hTEvlb7BBYSX/psRhgs3krSBNQisGxL+Lcqx24vh69GNegFpdNrPW9BlHjC8
         63PCZ9M0E0/usulEtqPVgXkbcqYnkTVWX5rPW8CAOyZB3CRAUGrx00bQqckipDlirOub
         orxlj3XywEfglhsJ8q++MwPCCVSRfsTmMv6dUDrct6DP8w/cMV8hoYXGYdDtPY9qZ/O8
         YWDwfoIMpEDQiclKjJfB3KIq1wMGoY0z47EieUrZPJbqJI0fFtqOOoutTkhpNskeJGyy
         r4YMI+iJWMQRyLlm1HRgAgIXMPROgY1bEVD9a0fPEinDctQ0ZeTQnbjEvnRqeMUnNMZd
         cdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792714; x=1779397514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1w+bIJUK1280MIs2G1eyxDF99wD3XZvdmGYFNMacs+U=;
        b=qfQfwBZGQUVas0lggR5CYUUONSxIebJP1TXt6RlzgAuvKkNNlBD5vxY5APqdZZr2xj
         utAfS/fnz3dXgRaJtnSFWkN3iqWqkhCIKHep4KpxS9GVc7B13/zq0lAafO3zZGs6rCCV
         OTSufC3LXbfclt5Y+6frrzXrywwtzVNeLHBttb5mO567GnZMfwTftRFZXqv/JbKlHTQJ
         EdG6CcHiaVdA/ZuOnQVScj+UcwhCSKOR2T3SsZ9xqPSlwHZuX9DsJ/dH7QhGlLds84ws
         2yPv15qGLdt19SPR/ucX3UJ51PnGAPyu7k5KozqDZzwXL+6Oe1hqMhijDRLxjtb/SX/+
         +sJQ==
X-Gm-Message-State: AOJu0YxdPaDTuE/FF2iwglAysj74RjwjT7LxLl/vh2Auo6qlVCuliZ0A
	sj81VI4ptLcdmFeaoMpMaw8Cq9xdzaA1dHsfamJtLODBM6V9QsUV8kTVk6ACS/xew02QalxMZD2
	FrNDxdg==
X-Received: from pfblg2.prod.google.com ([2002:a05:6a00:7082:b0:83e:b22b:8c9a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e89:b0:837:80a:5ac7
 with SMTP id d2e1a72fcca58-83f33f0fde7mr1137001b3a.45.1778792713614; Thu, 14
 May 2026 14:05:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:50 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-11-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 10/20] x86/vmx: Track VMCS "launched" state per-CPU
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Track whether or not a VMCS has been "launched" per-CPU to play nice with
VMX tests that use multiple VMCSes.  Arguably, it would be better to add a
structure to track the current VMCS and its launched state, but there's no
immediate benefit to doing so, and practically speaking the only thing that
would be tracked (without support for e.g. eVMCS) would be the "launched"
state.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/smp.h |  4 ++++
 x86/vmx.c     | 10 +++++-----
 x86/vmx.h     |  3 ++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/x86/smp.h b/lib/x86/smp.h
index e4dc0395..7f973227 100644
--- a/lib/x86/smp.h
+++ b/lib/x86/smp.h
@@ -56,7 +56,10 @@ struct percpu_data {
 		uint32_t exception_data;
 	};
 	void *apic_ops;
+
 	struct guest_regs guest_regs;
+	/* Track whether or not the current CPU's VMCS has been "launched". */
+	bool launched;
 };
 
 #define typeof_percpu(name) typeof(((struct percpu_data *)0)->name)
@@ -109,6 +112,7 @@ BUILD_PERCPU_OP(exception_vector);
 BUILD_PERCPU_OP(exception_rflags_rf);
 BUILD_PERCPU_OP(exception_error_code);
 BUILD_PERCPU_OP(apic_ops);
+BUILD_PERCPU_OP(launched);
 
 void smp_init(void);
 
diff --git a/x86/vmx.c b/x86/vmx.c
index 7da549d1..85772cae 100644
--- a/x86/vmx.c
+++ b/x86/vmx.c
@@ -60,7 +60,6 @@ static struct test_teardown_step teardown_steps[MAX_TEST_TEARDOWN_STEPS];
 static test_guest_func v2_guest_main;
 
 u64 hypercall_field;
-bool launched;
 static int matched;
 static int guest_finished;
 static int in_guest;
@@ -1728,6 +1727,8 @@ static int exit_handler(union exit_reason exit_reason)
  */
 static noinline void vmx_enter_guest(struct vmentry_result *result)
 {
+	bool launched = this_cpu_read_launched();
+
 	memset(result, 0, sizeof(*result));
 
 	in_guest = 1;
@@ -1779,7 +1780,7 @@ static int vmx_run(void)
 			 * VMCS isn't in "launched" state if there's been any
 			 * entry failure (early or otherwise).
 			 */
-			launched = 1;
+			this_cpu_write_launched(true);
 			ret = exit_handler(result.exit_reason);
 		} else if (current->entry_failure_handler) {
 			ret = current->entry_failure_handler(&result);
@@ -1848,7 +1849,6 @@ static int test_run(struct vmx_test *test)
 	v2_guest_main = NULL;
 	test->exits = 0;
 	current = test;
-	launched = 0;
 	guest_finished = 0;
 	printf("\nTest suite: %s\n", test->name);
 
@@ -1867,7 +1867,7 @@ static int test_run(struct vmx_test *test)
 	while (teardown_count > 0)
 		run_teardown_step(&teardown_steps[--teardown_count]);
 
-	if (launched && !guest_finished)
+	if (this_cpu_read_launched() && !guest_finished)
 		report_fail("Guest didn't run to completion.");
 
 out:
@@ -1975,7 +1975,7 @@ void __enter_guest(u8 abort_flag, struct vmentry_result *result)
 		return;
 	}
 
-	launched = 1;
+	this_cpu_write_launched(true);
 	check_for_guest_termination(result->exit_reason);
 	return;
 
diff --git a/x86/vmx.h b/x86/vmx.h
index 56f37633..c1c6eba4 100644
--- a/x86/vmx.h
+++ b/x86/vmx.h
@@ -794,7 +794,6 @@ static inline bool is_mbec_supported(void)
 }
 
 extern u64 *bsp_vmxon_region;
-extern bool launched;
 
 void vmx_set_test_stage(u32 s);
 u32 vmx_get_test_stage(void);
@@ -856,6 +855,8 @@ static inline int vmcs_clear(struct vmcs *vmcs)
 	bool ret;
 	u64 rflags = read_rflags() | X86_EFLAGS_CF | X86_EFLAGS_ZF;
 
+	this_cpu_write_launched(false);
+
 	asm volatile ("push %1; popf; vmclear %2; setbe %0"
 		      : "=q" (ret) : "q" (rflags), "m" (vmcs) : "cc");
 	return ret;
-- 
2.54.0.563.g4f69b47b94-goog

