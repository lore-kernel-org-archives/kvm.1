Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202882765ED
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481486; cv=none; b=m8xM3CLgvePLcduPQm7tHzxt6TxIEaKMg/xtXY+pDjhQ1iWFrupvoqi2KOobJIzXlvZXMkFvx4yB6RAmcjiiUJRaQJQGoZEZcHSpqNRavrr7KJ+VSFM+ASzJQ4wXZ0bpEh8QnWAsB5jhbQV+7YllXz04qz1Iut0kUd2HYMzun3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481486; c=relaxed/simple;
	bh=lbe1U0KO5X5xOrefUC72Ym+R5BKPGg5F8swAkx4ngHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ebY+mOsi8iDdOr76U/uZ7lVj25orGX6o69SbHHROuiv8QKghW1sWgcRbvcJbfmOdakIaRLpSHQi9s1LO7hqcCfb29rYBalZHs3pp5VuSoJSEpuui2BnetFWzIKfvKIBECC+NOn7UW9TGCgx/uCMXySZO1QHjxYCqX36bUHKFFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NXfRDqnE; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXfRDqnE"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e375d9736so336443b3a.2
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788481482; x=1789086282; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xI8imjf1MyoiMrMAgGjWPnXngkNAlqyamDaGrAEaebk=;
        b=NXfRDqnEc8Kn5LPd19wvfN/RXpMZcVCJWoRR7u/fXucAcGjMQfEG4QXzaWhlDPKFFI
         hIvMeV7ucV7SzoOpk18TEvBtYW+kD6YOs0tmtkRsj+/gfgh0c6JYFwKDo0c8ArcXeWe6
         FNXyd3cvBj05fAm2fs+FXWspHjSR86cKcC1dT8Q8UsoOG2sg/JnlDPP0NKX2qxcvLg0a
         ORPgukm3+DyW39x8vdxE6L/ShYH7xGqtNtsjwU617jptlqASR4ii+03Xmo0camcXBHuA
         c6xtLX2pJFl3U+d4uDCWKUT6d932VcoFJO1YtsjSw+pPeMbC8FLWIQJKGk4UwXN/nV/t
         4UOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788481482; x=1789086282;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xI8imjf1MyoiMrMAgGjWPnXngkNAlqyamDaGrAEaebk=;
        b=Yp0gw6hPYM+N02vabm4k5zLQE1Pj6hC3Q+d8+mmwZ02lTNHQyczZIXaO+taHBXAsXj
         nmWTltBjYux6B9UoTfUH73C8o4DiaEm+3RCTuqrEYu/gvesT1UfgPTBJT9eWqWfif+46
         dptyw6n/Wy+q/zsB6EL7PaH4ZzqlbazG9RR2sya5B8NRL47KKexvwoQlVFuSNp2sidEk
         JCpAiWPl3y6vWttq3FcBWk4cUrHzaT3eziIdjiDA4U075ILE7UlY45RYnrr3nc6pYVWw
         kGHRRyP/vYC0l7BhFQQLPQVHxjpv8dauFOmrR3iVY7tuCSnXDLN8UtzS4gqObri6UuRB
         Xd+g==
X-Gm-Message-State: AFuF++ncw139n7ak/P+p3dT6tSWnhdKrUVXJukGitlu4eAhAjbJQoyn+
	K1XEfEgg6g6VdIgk2oN+ue8U8/sXz976mVjij0XWuiwrgbfRt53KSkrj48d/3IUkPk/E0O94wZI
	imTjn2A==
X-Received: from pfnv24.prod.google.com ([2002:aa7:8518:0:b0:84e:5c66:796c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2183:b0:857:7384:b5f9
 with SMTP id d2e1a72fcca58-86169974910mr2760774b3a.21.1788481481879; Thu, 03
 Sep 2026 17:24:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:24:20 -0700
In-Reply-To: <20260904002423.3154436-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904002423.3154436-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904002423.3154436-15-seanjc@google.com>
Subject: [PATCH v4 14/17] KVM: selftests: Assert success in vmlaunch() and vmresume()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Assert success in the "outer" APIs for VMLAUNCH and VMRESUME to dedup a
pile of code, and switch to the double-underscores versions as necessary,
to make it more obvious which paths expect VM-Enter *failure*.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/vmx.h |  8 +++----
 .../testing/selftests/kvm/lib/x86/memstress.c |  2 +-
 .../selftests/kvm/x86/aperfmperf_test.c       |  2 +-
 .../kvm/x86/evmcs_smm_controls_test.c         |  2 +-
 .../testing/selftests/kvm/x86/hyperv_evmcs.c  | 22 ++++++++---------
 .../selftests/kvm/x86/kvm_buslock_test.c      |  2 +-
 .../selftests/kvm/x86/nested_close_kvm_test.c |  2 +-
 .../selftests/kvm/x86/nested_dirty_log_test.c |  2 +-
 .../selftests/kvm/x86/nested_emulation_test.c |  5 +++-
 .../kvm/x86/nested_exceptions_test.c          |  5 +++-
 .../kvm/x86/nested_invalid_cr3_test.c         |  4 ++--
 .../selftests/kvm/x86/nested_tdp_fault_test.c |  2 +-
 .../kvm/x86/nested_tsc_adjust_test.c          |  2 +-
 .../kvm/x86/nested_tsc_scaling_test.c         |  2 +-
 .../kvm/x86/save_restore_pf_stress_test.c     |  4 ++--
 tools/testing/selftests/kvm/x86/state_test.c  | 24 +++++++++----------
 .../kvm/x86/triple_fault_event_test.c         |  2 +-
 .../selftests/kvm/x86/vmx_apic_access_test.c  |  4 ++--
 .../kvm/x86/vmx_apicv_updates_test.c          |  4 ++--
 .../kvm/x86/vmx_invalid_nested_guest_state.c  |  2 +-
 .../kvm/x86/vmx_nested_la57_state_test.c      |  2 +-
 .../kvm/x86/vmx_preemption_timer_test.c       |  4 ++--
 22 files changed, 57 insertions(+), 51 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index d0ac8e128d98..1419043b41dd 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -362,14 +362,14 @@ static inline u64 vmptrst(void)
 int __vmlaunch(void);
 int __vmresume(void);
 
-static inline int vmlaunch(void)
+static inline void vmlaunch(void)
 {
-	return __vmlaunch();
+	__GUEST_ASSERT(!__vmlaunch(), "vmlaunch hit VM-Fail");
 }
 
-static inline int vmresume(void)
+static inline void vmresume(void)
 {
-	return __vmresume();
+	__GUEST_ASSERT(!__vmresume(), "vmresume hit VM-Fail");
 }
 
 static inline void vmcall(void)
diff --git a/tools/testing/selftests/kvm/lib/x86/memstress.c b/tools/testing/selftests/kvm/lib/x86/memstress.c
index 207350ab6114..6a1815fb97e9 100644
--- a/tools/testing/selftests/kvm/lib/x86/memstress.c
+++ b/tools/testing/selftests/kvm/lib/x86/memstress.c
@@ -40,7 +40,7 @@ static void l1_vmx_code(struct vmx_pages *vmx, u64 vcpu_id)
 	*(u64 *)vmx->stack = vcpu_id;
 	prepare_vmcs(vmx, memstress_l2_guest_entry);
 
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_VMCALL);
 	GUEST_DONE();
 }
diff --git a/tools/testing/selftests/kvm/x86/aperfmperf_test.c b/tools/testing/selftests/kvm/x86/aperfmperf_test.c
index 11f5894d8ac7..a082658c1e48 100644
--- a/tools/testing/selftests/kvm/x86/aperfmperf_test.c
+++ b/tools/testing/selftests/kvm/x86/aperfmperf_test.c
@@ -83,7 +83,7 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 		vmreadz(CPU_BASED_VM_EXEC_CONTROL) | CPU_BASED_USE_MSR_BITMAPS);
 
 	GUEST_ASSERT(!vmwrite(GUEST_RIP, (u64)l2_guest_code));
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 }
 
 static void guest_code(void *nested_test_data)
diff --git a/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c b/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
index 5c0391f8a38d..4a65eb02349c 100644
--- a/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
+++ b/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
@@ -59,7 +59,7 @@ static void guest_code(struct vmx_pages *vmx_pages,
 	load_evmcs(hv_pages);
 	prepare_vmcs(vmx_pages, l2_guest_code);
 
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 
 	/* L2 exits via vmcall if test fails */
 	sync_with_host(2);
diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
index 854b86c4be8a..bb31c1aa51bf 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
@@ -105,7 +105,7 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 
 	GUEST_SYNC(5);
 	current_evmcs->revision_id = -1u;
-	GUEST_ASSERT(vmlaunch());
+	GUEST_ASSERT(__vmlaunch());
 	current_evmcs->revision_id = EVMCS_VERSION;
 	GUEST_SYNC(6);
 
@@ -120,7 +120,7 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	current_vp_assist->nested_control.features.directhypercall = 1;
 	*(u32 *)(hv_pages->partition_assist) = 0;
 
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);
 	GUEST_ASSERT_EQ((vmreadz(VM_EXIT_INTR_INFO) & 0xff), NMI_VECTOR);
 	GUEST_ASSERT(vmptrst() == hv_pages->enlightened_vmcs_gpa);
@@ -130,7 +130,7 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	 * up-to-date (RIP points where it should and not at the beginning
 	 * of l2_guest_code(). GUEST_SYNC(9) checks that.
 	 */
-	GUEST_ASSERT(!vmresume());
+	vmresume();
 
 	GUEST_SYNC(10);
 
@@ -141,13 +141,13 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	vmwrite(CPU_BASED_VM_EXEC_CONTROL, vmreadz(CPU_BASED_VM_EXEC_CONTROL) |
 		CPU_BASED_USE_MSR_BITMAPS);
 	__set_bit(MSR_FS_BASE & 0x1fff, vmx_pages->msr + 0x400);
-	GUEST_ASSERT(!vmresume());
+	vmresume();
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_MSR_READ);
 	current_evmcs->guest_rip += 2; /* rdmsr */
 
 	/* Enable enlightened MSR bitmap */
 	current_evmcs->hv_enlightenments_control.msr_bitmap = 1;
-	GUEST_ASSERT(!vmresume());
+	vmresume();
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_MSR_READ);
 	current_evmcs->guest_rip += 2; /* rdmsr */
 
@@ -155,14 +155,14 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	__set_bit(MSR_GS_BASE & 0x1fff, vmx_pages->msr + 0x400);
 	/* Make sure HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP is set */
 	current_evmcs->hv_clean_fields |= HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP;
-	GUEST_ASSERT(!vmresume());
+	vmresume();
 	/* Make sure we don't see EXIT_REASON_MSR_READ here so eMSR bitmap works */
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 	current_evmcs->guest_rip += 3; /* vmcall */
 
 	/* Now tell KVM we've changed MSR-Bitmap */
 	current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP;
-	GUEST_ASSERT(!vmresume());
+	vmresume();
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_MSR_READ);
 	current_evmcs->guest_rip += 2; /* rdmsr */
 
@@ -170,15 +170,15 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	 * L2 TLB flush test. First VMCALL should be handled directly by L0,
 	 * no VMCALL exit expected.
 	 */
-	GUEST_ASSERT(!vmresume());
+	vmresume();
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_MSR_READ);
 	current_evmcs->guest_rip += 2; /* rdmsr */
 	/* Enable synthetic vmexit */
 	*(u32 *)(hv_pages->partition_assist) = 1;
-	GUEST_ASSERT(!vmresume());
+	vmresume();
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == HV_VMX_SYNTHETIC_EXIT_REASON_TRAP_AFTER_FLUSH);
 
-	GUEST_ASSERT(!vmresume());
+	vmresume();
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 	GUEST_SYNC(11);
 
@@ -192,7 +192,7 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	 */
 	GUEST_SYNC(12);
 	evmcs_vmptrld(0xdeadbeef, hv_pages->enlightened_vmcs);
-	GUEST_ASSERT(vmlaunch());
+	GUEST_ASSERT(__vmlaunch());
 	GUEST_ASSERT(ud_count == 1);
 	GUEST_DONE();
 }
diff --git a/tools/testing/selftests/kvm/x86/kvm_buslock_test.c b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
index 22993ec697fa..337d3c28bc6d 100644
--- a/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
+++ b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
@@ -48,7 +48,7 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 	prepare_vmcs(vmx, NULL);
 
 	GUEST_ASSERT(!vmwrite(GUEST_RIP, (u64)l2_guest_code));
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 }
 
 static void guest_code(void *test_data)
diff --git a/tools/testing/selftests/kvm/x86/nested_close_kvm_test.c b/tools/testing/selftests/kvm/x86/nested_close_kvm_test.c
index 309cab009929..1f4a5e44a6ef 100644
--- a/tools/testing/selftests/kvm/x86/nested_close_kvm_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_close_kvm_test.c
@@ -36,7 +36,7 @@ static void l1_vmx_code(struct vmx_pages *vmx_pages)
 	/* Prepare the VMCS for L2 execution. */
 	prepare_vmcs(vmx_pages, l2_guest_code);
 
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 	GUEST_ASSERT(0);
 }
 
diff --git a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
index dca2bfc8b158..7987ce50c382 100644
--- a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
@@ -104,7 +104,7 @@ void l1_vmx_code(struct vmx_pages *vmx)
 	prepare_vmcs(vmx, l2_rip);
 
 	GUEST_SYNC(TEST_SYNC_NO_FAULT);
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 	GUEST_SYNC(TEST_SYNC_NO_FAULT);
 	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_VMCALL);
 	GUEST_DONE();
diff --git a/tools/testing/selftests/kvm/x86/nested_emulation_test.c b/tools/testing/selftests/kvm/x86/nested_emulation_test.c
index 2b38eff4f516..51e2f7e386c1 100644
--- a/tools/testing/selftests/kvm/x86/nested_emulation_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_emulation_test.c
@@ -102,7 +102,10 @@ static void guest_code(void *test_data)
 			exit_insn_len = vmcb->control.next_rip - vmcb->save.rip;
 			GUEST_ASSERT_EQ(vmcb->save.rip, (u64)l2_instruction);
 		} else {
-			GUEST_ASSERT_EQ(i ? vmresume() : vmlaunch(), 0);
+			if (!i)
+				vmlaunch();
+			else
+				vmresume();
 			exit_reason = vmreadz(VM_EXIT_REASON);
 			exit_insn_len = vmreadz(VM_EXIT_INSTRUCTION_LEN);
 			GUEST_ASSERT_EQ(vmreadz(GUEST_RIP), (u64)l2_instruction);
diff --git a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
index 50c271a03692..031eb84229dc 100644
--- a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
@@ -112,7 +112,10 @@ static void vmx_run_l2(void *l2_code, int vector, u32 error_code)
 {
 	GUEST_ASSERT(!vmwrite(GUEST_RIP, (u64)l2_code));
 
-	GUEST_ASSERT_EQ(vector == SS_VECTOR ? vmlaunch() : vmresume(), 0);
+	if (vector == SS_VECTOR)
+		vmlaunch();
+	else
+		vmresume();
 
 	if (vector == FAKE_TRIPLE_FAULT_VECTOR)
 		return;
diff --git a/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c b/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c
index 43deb3b358ea..101c1fe79eeb 100644
--- a/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c
@@ -48,13 +48,13 @@ static void l1_vmx_code(struct vmx_pages *vmx_pages)
 	/* Try to run L2 with invalid CR3 and make sure it fails */
 	save_cr3 = vmreadz(GUEST_CR3);
 	vmwrite(GUEST_CR3, -1ull);
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) ==
 		     (EXIT_REASON_FAILED_VMENTRY | EXIT_REASON_INVALID_STATE));
 
 	/* Now restore CR3 and make sure L2 runs successfully */
 	vmwrite(GUEST_CR3, save_cr3);
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	GUEST_DONE();
diff --git a/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c b/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c
index 52df467e9c44..d6c443e3d147 100644
--- a/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c
@@ -60,7 +60,7 @@ static void l1_vmx_code(struct vmx_pages *vmx, u64 expected_fault_gpa,
 
 	prepare_vmcs(vmx, l2_entry);
 
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 
 	/* Verify we got an EPT violation exit */
 	__GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_EPT_VIOLATION,
diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c
index 05194762ed33..c60dea899624 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c
@@ -95,7 +95,7 @@ static void l1_guest_code(void *data)
 		vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
 		vmwrite(TSC_OFFSET, TSC_OFFSET_VALUE);
 
-		GUEST_ASSERT(!vmlaunch());
+		vmlaunch();
 		GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 	} else {
 		struct svm_test_data *svm = data;
diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
index b9fae268a9ec..b2fc7f0b5b3c 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
@@ -125,7 +125,7 @@ static void l1_vmx_code(struct vmx_pages *vmx_pages)
 	vmwrite(TSC_MULTIPLIER_HIGH, TSC_MULTIPLIER_L2 >> 32);
 
 	/* launch L2 */
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	/* check that L1's frequency still looks good */
diff --git a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
index c0e4d6e156ad..f88427e925fc 100644
--- a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
+++ b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
@@ -104,11 +104,11 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 
 	GUEST_ASSERT(!vmwrite(EXCEPTION_BITMAP, BIT(UD_VECTOR)));
 
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 	while (1) {
 		GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);
 		GUEST_ASSERT_EQ(vmreadz(VM_EXIT_INTR_INFO) & 0xff, UD_VECTOR);
-		GUEST_ASSERT(!vmresume());
+		vmresume();
 	}
 }
 
diff --git a/tools/testing/selftests/kvm/x86/state_test.c b/tools/testing/selftests/kvm/x86/state_test.c
index bd5e9e36b2c9..38c9689ac601 100644
--- a/tools/testing/selftests/kvm/x86/state_test.c
+++ b/tools/testing/selftests/kvm/x86/state_test.c
@@ -87,20 +87,20 @@ static void vmx_l1_guest_code(struct vmx_pages *vmx_pages)
 
 	GUEST_SYNC(5);
 	GUEST_ASSERT(vmptrst() == vmx_pages->vmcs_gpa);
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 	GUEST_ASSERT(vmptrst() == vmx_pages->vmcs_gpa);
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	/* Check that the launched state is preserved.  */
-	GUEST_ASSERT(vmlaunch());
+	GUEST_ASSERT(__vmlaunch());
 
-	GUEST_ASSERT(!vmresume());
+	vmresume();
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	GUEST_SYNC(7);
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
-	GUEST_ASSERT(!vmresume());
+	vmresume();
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	vmwrite(GUEST_RIP, vmreadz(GUEST_RIP) + 3);
@@ -109,27 +109,27 @@ static void vmx_l1_guest_code(struct vmx_pages *vmx_pages)
 	vmwrite(VMCS_LINK_POINTER, vmx_pages->shadow_vmcs_gpa);
 
 	vmptrld(vmx_pages->shadow_vmcs_gpa);
-	GUEST_ASSERT(vmlaunch());
+	GUEST_ASSERT(__vmlaunch());
 	GUEST_SYNC(8);
-	GUEST_ASSERT(vmlaunch());
-	GUEST_ASSERT(vmresume());
+	GUEST_ASSERT(__vmlaunch());
+	GUEST_ASSERT(__vmresume());
 
 	vmwrite(GUEST_RIP, 0xc0ffee);
 	GUEST_SYNC(9);
 	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffee);
 
 	vmptrld(vmx_pages->vmcs_gpa);
-	GUEST_ASSERT(!vmresume());
+	vmresume();
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	vmptrld(vmx_pages->shadow_vmcs_gpa);
 	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffffee);
-	GUEST_ASSERT(vmlaunch());
-	GUEST_ASSERT(vmresume());
+	GUEST_ASSERT(__vmlaunch());
+	GUEST_ASSERT(__vmresume());
 	GUEST_SYNC(13);
 	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffffee);
-	GUEST_ASSERT(vmlaunch());
-	GUEST_ASSERT(vmresume());
+	GUEST_ASSERT(__vmlaunch());
+	GUEST_ASSERT(__vmresume());
 }
 
 static void __attribute__((__flatten__)) guest_code(void *arg)
diff --git a/tools/testing/selftests/kvm/x86/triple_fault_event_test.c b/tools/testing/selftests/kvm/x86/triple_fault_event_test.c
index a9fb7046ea4f..bb31a1ba8932 100644
--- a/tools/testing/selftests/kvm/x86/triple_fault_event_test.c
+++ b/tools/testing/selftests/kvm/x86/triple_fault_event_test.c
@@ -30,7 +30,7 @@ void l1_guest_code_vmx(struct vmx_pages *vmx)
 
 	prepare_vmcs(vmx, l2_guest_code);
 
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 	/* L2 should triple fault after a triple fault event injected. */
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_TRIPLE_FAULT);
 	GUEST_DONE();
diff --git a/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c b/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
index 1793f7b02219..fe29c869a235 100644
--- a/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
@@ -53,14 +53,14 @@ static void l1_guest_code(struct vmx_pages *vmx_pages, unsigned long high_gpa)
 
 	/* Try to launch L2 with the memory-backed APIC-access address. */
 	GUEST_SYNC(vmreadz(APIC_ACCESS_ADDR));
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	vmwrite(APIC_ACCESS_ADDR, high_gpa);
 
 	/* Try to resume L2 with the unbacked APIC-access address. */
 	GUEST_SYNC(vmreadz(APIC_ACCESS_ADDR));
-	GUEST_ASSERT(!vmresume());
+	vmresume();
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	GUEST_DONE();
diff --git a/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c b/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c
index f7ebc9b15629..e578221da247 100644
--- a/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c
@@ -62,7 +62,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	 * Run L2 to switch to x2APIC mode, which in turn will uninhibit APICv,
 	 * as KVM should force the APIC ID back to its default.
 	 */
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 	vmwrite(GUEST_RIP, vmreadz(GUEST_RIP) + vmreadz(VM_EXIT_INSTRUCTION_LEN));
 	GUEST_ASSERT(rdmsr(MSR_IA32_APICBASE) & MSR_IA32_APICBASE_EXTD);
@@ -90,7 +90,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	 * handles the x2APIC => xAPIC transition and inhibits APICv while L2
 	 * is active.
 	 */
-	GUEST_ASSERT(!vmresume());
+	vmresume();
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 	GUEST_ASSERT(!(rdmsr(MSR_IA32_APICBASE) & MSR_IA32_APICBASE_EXTD));
 
diff --git a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
index 4a6445958cf4..3017938fa993 100644
--- a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
+++ b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
@@ -55,7 +55,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_ASSERT(!(vmreadz(CPU_BASED_VM_EXEC_CONTROL) & CPU_BASED_ACTIVATE_SECONDARY_CONTROLS) ||
 		     !(vmreadz(SECONDARY_VM_EXEC_CONTROL) & SECONDARY_EXEC_UNRESTRICTED_GUEST));
 
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 
 	/* L2 should triple fault after main() stuffs invalid guest state. */
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_TRIPLE_FAULT);
diff --git a/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c b/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c
index 04c2d5113e84..b3651c5ab138 100644
--- a/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c
@@ -56,7 +56,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	guest_cr4 &= ~X86_CR4_LA57;
 	vmwrite(GUEST_CR4, guest_cr4);
 
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 
 	exit_reason = vmreadz(VM_EXIT_REASON);
 	GUEST_ASSERT(exit_reason == EXIT_REASON_VMCALL);
diff --git a/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
index 50fc9309158f..cda53df33888 100644
--- a/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
@@ -90,7 +90,7 @@ void l1_guest_code(struct vmx_pages *vmx_pages)
 	    !(ctrl_exit_rev.clr & VM_EXIT_SAVE_VMX_PREEMPTION_TIMER))
 		return;
 
-	GUEST_ASSERT(!vmlaunch());
+	vmlaunch();
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 	vmwrite(GUEST_RIP, vmreadz(GUEST_RIP) + vmreadz(VM_EXIT_INSTRUCTION_LEN));
 
@@ -110,7 +110,7 @@ void l1_guest_code(struct vmx_pages *vmx_pages)
 
 	l1_vmx_pt_start = (rdtsc() >> vmx_pt_rate) << vmx_pt_rate;
 
-	GUEST_ASSERT(!vmresume());
+	vmresume();
 
 	l1_vmx_pt_finish = rdtsc();
 
-- 
2.55.0.979.g7e5102b832-goog

