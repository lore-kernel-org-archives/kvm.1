Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4538926F289
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481487; cv=none; b=eDTbgQ2XBUGr8O/3j8qTZUDTmVNxFXwvxLP/A9iQtdXlF+5E35D6l2g44wIxpy2XXjtKVnej2X3Vv/OUr/CYw+uqkKGosaCyhuYWwxxqB90uGWcOsd+ST+13vcAzXin/6q2mc6zAimW8RYvAtzgNN8Ukk47HYA91igt5tTGXpHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481487; c=relaxed/simple;
	bh=JROQpRJndZZZP209SuX2wjyaL8u5hx8u19eSloFQfmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N+tGMRluNWUtsBzyl/SYp/OaqvDBIjlDst9OKMfHAqsTw8L4P7BxuQxxN4oSlYlYoGABqmwyrH8PMinKpMAy3wBy9uYyEZgfnbnRgZvygNow3Uqv8Tw+eLL3WiNBI6M4xrrP8+cGxrKRzv/Wxo/TvgVsUhLpu/Qg7JBgkUujj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q+lYFkFE; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+lYFkFE"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so614775a12.3
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788481484; x=1789086284; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8DzzgIr+0cObo03tv5BPb8/ieIObvKNOGQaJvCJlMNs=;
        b=q+lYFkFEsK84al204dJeuuzKt0C9HVf1x8jbaG0oIm0jyVCKCi1JFxRmoh2Vbshvjq
         ZOEXxuSl/i6i9xO17WtnPoODxUI01b0meR5e8HYV/zF2A3aCsAtbpAZvCJFLmyHzQXkJ
         88THCnR7CBvegnXh2PC+xjFFXHMbFFg3N+x8GK3qXgzfnSEZZ3WrGOLi+Ybx9NzAvDgr
         O8EPuY1Lv0QBplZduDI5ab/zYNcTM4bEtw1ArANfDQJmSjhzA+xGh5ZrtKrmPXEZHT4D
         Lr+O2b8x0rsYyrCn4lsZZ8ECpVDiy73QOKo9RHGO4RLPDNrLOpMLBynRAkwgX5WFK9pR
         fvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788481484; x=1789086284;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8DzzgIr+0cObo03tv5BPb8/ieIObvKNOGQaJvCJlMNs=;
        b=kkIXFazLrYLQXHTydnuvFVRcyX/LdDn1Lm99iFr7Nc4tSN77asaL5otkGgTNDTl+Bw
         yccpsJMq3977MdrbO3hn58GcasQR8EigroQB0TYppvP4ZP6xx/JUNWmcYaJ5yA+5Sosg
         CBRQDshrCqyigHTJpJVTru7Wc99PkPhVshvYOZoJM20nX+dwF/MXUFyfMYk+TCaUAcax
         oybXy1Qk1AzZbzhh47gVOAMcFYtzJfHkFHlYeMUS7X96pxigF1pcfhYMbV1UCVwMpRtN
         WtN2uTnRjoQBYaQnofFDDCr9hyO+Hzrg4Ll6zTXW7UGFt/aE5SPVa1/FrUTrvptcTfMv
         FcIg==
X-Gm-Message-State: AFuF++kQpxdiTwiMxx9sMXDR8382L8cOWBCP8EH6ybGKfdaaKWCAnwMS
	AJ4tdsGGYNjM0FozBA43yNq1wyGSXuL15EP/qLbh+xJnm3cvTE1ndVlf9mylwm+gISYq/RdtwmO
	bI4XEvQ==
X-Received: from pgee1.prod.google.com ([2002:a63:1e01:0:b0:cc4:31fa:cb70])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:450f:b0:3d1:ae83:6fc2
 with SMTP id adf61e73a8af0-3da39d2824amr3452857637.9.1788481484209; Thu, 03
 Sep 2026 17:24:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:24:22 -0700
In-Reply-To: <20260904002423.3154436-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904002423.3154436-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904002423.3154436-17-seanjc@google.com>
Subject: [PATCH v4 16/17] KVM: selftests: Always assert that vmwrite() succeeds
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Assert that vmwrite() succeeds instead of forcing all callers to do the
same (or as is much more common, ignoring VM-Fail and likely letting the
test fail in weird ways), opportunistically provide a more verbose error
message on failure.

All usage of vmwrite() "guarantees" success, either because the field in
question is unconditionally emulated by KVM, by virtue of earlier support
checks, or by falling over (later in the test) if the VMWRITE fails.

Cc: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/vmx.h          |  5 +++--
 tools/testing/selftests/kvm/x86/aperfmperf_test.c      |  2 +-
 tools/testing/selftests/kvm/x86/kvm_buslock_test.c     |  2 +-
 .../testing/selftests/kvm/x86/nested_emulation_test.c  |  6 +++---
 .../testing/selftests/kvm/x86/nested_exceptions_test.c | 10 +++++-----
 .../selftests/kvm/x86/save_restore_pf_stress_test.c    |  2 +-
 tools/testing/selftests/kvm/x86/state_test.c           |  4 ++--
 .../selftests/kvm/x86/vmx_preemption_timer_test.c      |  8 +++-----
 8 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 40111db580a8..be10028c51b9 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -429,9 +429,10 @@ static __always_inline int __vmwrite(u64 encoding, u64 value)
 	return ret;
 }
 
-static inline int vmwrite(u64 encoding, u64 value)
+static inline void vmwrite(u64 encoding, u64 value)
 {
-	return __vmwrite(encoding, value);
+	__GUEST_ASSERT(!__vmwrite(encoding, value),
+		       "vmwrite[0x%lx] = 0x%lx hit VM-Fail", encoding, value);
 }
 
 static inline u32 vmcs_revision(void)
diff --git a/tools/testing/selftests/kvm/x86/aperfmperf_test.c b/tools/testing/selftests/kvm/x86/aperfmperf_test.c
index a082658c1e48..7761a8bdf5f6 100644
--- a/tools/testing/selftests/kvm/x86/aperfmperf_test.c
+++ b/tools/testing/selftests/kvm/x86/aperfmperf_test.c
@@ -82,7 +82,7 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 	vmwrite(CPU_BASED_VM_EXEC_CONTROL,
 		vmreadz(CPU_BASED_VM_EXEC_CONTROL) | CPU_BASED_USE_MSR_BITMAPS);
 
-	GUEST_ASSERT(!vmwrite(GUEST_RIP, (u64)l2_guest_code));
+	vmwrite(GUEST_RIP, (u64)l2_guest_code);
 	vmlaunch();
 }
 
diff --git a/tools/testing/selftests/kvm/x86/kvm_buslock_test.c b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
index 337d3c28bc6d..e1d2730b16ba 100644
--- a/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
+++ b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
@@ -47,7 +47,7 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 
 	prepare_vmcs(vmx, NULL);
 
-	GUEST_ASSERT(!vmwrite(GUEST_RIP, (u64)l2_guest_code));
+	vmwrite(GUEST_RIP, (u64)l2_guest_code);
 	vmlaunch();
 }
 
diff --git a/tools/testing/selftests/kvm/x86/nested_emulation_test.c b/tools/testing/selftests/kvm/x86/nested_emulation_test.c
index 51e2f7e386c1..009932b1604e 100644
--- a/tools/testing/selftests/kvm/x86/nested_emulation_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_emulation_test.c
@@ -70,9 +70,9 @@ static void guest_code(void *test_data)
 		load_vmcs(test_data);
 
 		prepare_vmcs(test_data, NULL);
-		GUEST_ASSERT(!vmwrite(GUEST_IDTR_LIMIT, 0));
-		GUEST_ASSERT(!vmwrite(GUEST_RIP, (u64)l2_guest_code));
-		GUEST_ASSERT(!vmwrite(EXCEPTION_BITMAP, 0));
+		vmwrite(GUEST_IDTR_LIMIT, 0);
+		vmwrite(GUEST_RIP, (u64)l2_guest_code);
+		vmwrite(EXCEPTION_BITMAP, 0);
 
 		vmwrite(CPU_BASED_VM_EXEC_CONTROL, vmreadz(CPU_BASED_VM_EXEC_CONTROL) |
 						   CPU_BASED_PAUSE_EXITING |
diff --git a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
index 031eb84229dc..d0beaa7b280b 100644
--- a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
@@ -110,7 +110,7 @@ static void l1_svm_code(struct svm_test_data *svm)
 
 static void vmx_run_l2(void *l2_code, int vector, u32 error_code)
 {
-	GUEST_ASSERT(!vmwrite(GUEST_RIP, (u64)l2_code));
+	vmwrite(GUEST_RIP, (u64)l2_code);
 
 	if (vector == SS_VECTOR)
 		vmlaunch();
@@ -133,21 +133,21 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 	load_vmcs(vmx);
 
 	prepare_vmcs(vmx, NULL);
-	GUEST_ASSERT_EQ(vmwrite(GUEST_IDTR_LIMIT, 0), 0);
+	vmwrite(GUEST_IDTR_LIMIT, 0);
 
 	/*
 	 * VMX disallows injecting an exception with error_code[31:16] != 0,
 	 * and hardware will never generate a VM-Exit with bits 31:16 set.
 	 * KVM should likewise truncate the "bad" userspace value.
 	 */
-	GUEST_ASSERT_EQ(vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS_GP_DF), 0);
+	vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS_GP_DF);
 	vmx_run_l2(l2_ss_pending_test, SS_VECTOR, (u16)SS_ERROR_CODE);
 	vmx_run_l2(l2_ss_injected_gp_test, GP_VECTOR, GP_ERROR_CODE_INTEL);
 
-	GUEST_ASSERT_EQ(vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS_DF), 0);
+	vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS_DF);
 	vmx_run_l2(l2_ss_injected_df_test, DF_VECTOR, DF_ERROR_CODE);
 
-	GUEST_ASSERT_EQ(vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS), 0);
+	vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS);
 	vmx_run_l2(l2_ss_injected_tf_test, FAKE_TRIPLE_FAULT_VECTOR, 0);
 	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_TRIPLE_FAULT);
 
diff --git a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
index f88427e925fc..e728f040916f 100644
--- a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
+++ b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
@@ -102,7 +102,7 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 	load_vmcs(vmx);
 	prepare_vmcs(vmx, guest_access_memory);
 
-	GUEST_ASSERT(!vmwrite(EXCEPTION_BITMAP, BIT(UD_VECTOR)));
+	vmwrite(EXCEPTION_BITMAP, BIT(UD_VECTOR));
 
 	vmlaunch();
 	while (1) {
diff --git a/tools/testing/selftests/kvm/x86/state_test.c b/tools/testing/selftests/kvm/x86/state_test.c
index 38c9689ac601..7cb1d160e2d9 100644
--- a/tools/testing/selftests/kvm/x86/state_test.c
+++ b/tools/testing/selftests/kvm/x86/state_test.c
@@ -62,10 +62,10 @@ void vmx_l2_guest_code(void)
 	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffee);
 	GUEST_SYNC(10);
 	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffee);
-	GUEST_ASSERT(!vmwrite(GUEST_RIP, 0xc0fffee));
+	vmwrite(GUEST_RIP, 0xc0fffee);
 	GUEST_SYNC(11);
 	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0fffee);
-	GUEST_ASSERT(!vmwrite(GUEST_RIP, 0xc0ffffee));
+	vmwrite(GUEST_RIP, 0xc0ffffee);
 	GUEST_SYNC(12);
 
 	/* Done, exit to L1 and never come back.  */
diff --git a/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
index cda53df33888..c5f9d9879f61 100644
--- a/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
@@ -97,12 +97,10 @@ void l1_guest_code(struct vmx_pages *vmx_pages)
 	/*
 	 * Turn on PIN control and resume the guest
 	 */
-	GUEST_ASSERT(!vmwrite(PIN_BASED_VM_EXEC_CONTROL,
-			      vmreadz(PIN_BASED_VM_EXEC_CONTROL) |
-			      PIN_BASED_VMX_PREEMPTION_TIMER));
+	vmwrite(PIN_BASED_VM_EXEC_CONTROL,
+		vmreadz(PIN_BASED_VM_EXEC_CONTROL) | PIN_BASED_VMX_PREEMPTION_TIMER);
 
-	GUEST_ASSERT(!vmwrite(VMX_PREEMPTION_TIMER_VALUE,
-			      PREEMPTION_TIMER_VALUE));
+	vmwrite(VMX_PREEMPTION_TIMER_VALUE, PREEMPTION_TIMER_VALUE);
 
 	vmx_pt_rate = rdmsr(MSR_IA32_VMX_MISC) & 0x1F;
 
-- 
2.55.0.979.g7e5102b832-goog

