Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB33D0BF3
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787787576; cv=none; b=AG+pb8xJlz66b8RXQMgFZCrXLdooIPO9s6A1/DPTqipdhbfeoXdtfdfNHYf2YytKqOKXiemdY7xJ5YJMCqzNHWLiz4dDEUSdZ96TqEQjjxlQktotch96edD6pBOZ84ZpNVasfYQ3xjr6zWcpVCpfG/9DRg78X1MuQlfuVD3GrxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787787576; c=relaxed/simple;
	bh=zjW6NM1x1xx1hok7gASLPnvaE82n0q0PPZMbkb+kD7o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pd8nFI2YdNLidFay1Fx9iVADMHksdVO7T160S4Zkq0vfVZ/eh0e+lAGWtwKiBkV0Wk8LGq86Nw0guvbm7My/eHNevBinmXTtMTaJsjhwqmzmN7YvC6+HlgtHAhdAdnzUpZr84njxz7FBKA1K6U7OJlm97h7LI1itelJy0b1w7Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vXYvHDrT; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vXYvHDrT"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6f75c1219so31775535ad.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787787573; x=1788392373; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Fr6QhIOdssDlLLNG8GW8aL+V7Qrod1A2/fLhWBO4ACg=;
        b=vXYvHDrTV9PKVzrD/BrG6VjAkrlJYQ9aUghGkVCr5CGz0aqCl5URiOEsfm6E0v7osG
         /S/5dk/VXPI9lwhRsJJa382MO2R5t687NJUB5ic9tWvSLPgN5kHY9uuE5evWzPu9ShxB
         ouW2b7DQusAekjNEWE9VakO3/ySeaAFjAPKLePsu1ywQd6NHxZ3YjNEUdWxGS5WWp56k
         ruD8/j8a27rkj3ToI7nRTPoA9ZT18ysCIKF4E9ChVXpCXmk00q7NoIQd+7fhwW+DqbAP
         LuU/CsDiSYcZ+wRXZQ8Wn/TTdEgldSluU6b0fMfQGfTOyytu1T8OrGL2YOxZXVrmy0Hg
         LEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787787573; x=1788392373;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fr6QhIOdssDlLLNG8GW8aL+V7Qrod1A2/fLhWBO4ACg=;
        b=rS/MVMFWVvQFcTWuXDENCazhojqXjlKKhn+BosgFJTbCtYbAUa+IMoCjHwt+nHhkXy
         oyX52TnzF5BVR9hTThg/jbNxBvX2gfJrclnHCEByBm6xtjpJcR4u75IGP4eX7V7Mqjlm
         5qtLxKRG5ylolsC0RepqnHAIRsZqFSynoC8jpLjUGPog6Oc5IFVww7bguadkKDBJ0jNO
         SAjudDosugVKs3p1E6C0p6uBokAlgi3MZNrAubDjbMj9meOKXNgSTi1+e5zzwxlp9DP1
         S8R/2qES5Uk//PM00sbx0t7f2MF/KSZ96sqiAgexZLX8gBpnrmOtK5MrmrUKvOrTKnxK
         kwwg==
X-Gm-Message-State: AFuF++lGumJF+Wx51GnqBbXLAT+N9e6iIC/o0LvOU+iIAlKLLhvwsYBD
	Nwr5ENPvBFUU6UMcvKWRj+TWWHcH2x9xAs2hds4uzqrI/niwo1yooDUzQlZ6kPg4czid1HWadtx
	zP3v/SA==
X-Received: from plxl5.prod.google.com ([2002:a17:902:db45:b0:2d6:f794:4e76])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da92:b0:2d6:ffa1:429b
 with SMTP id d9443c01a7336-2d707a31452mr163761705ad.7.1787787572361; Wed, 26
 Aug 2026 16:39:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 16:39:16 -0700
In-Reply-To: <20260826233919.998904-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826233919.998904-11-seanjc@google.com>
Subject: [PATCH v3 10/13] KVM: selftests: Drop useless return code from load_vmcs()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Now that load_vmcs() either asserts or returns success, drop the return
code and the many asserts in its callers.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/vmx.h                 | 2 +-
 tools/testing/selftests/kvm/lib/x86/memstress.c               | 2 +-
 tools/testing/selftests/kvm/lib/x86/vmx.c                     | 4 +---
 tools/testing/selftests/kvm/x86/aperfmperf_test.c             | 2 +-
 tools/testing/selftests/kvm/x86/kvm_buslock_test.c            | 2 +-
 tools/testing/selftests/kvm/x86/nested_close_kvm_test.c       | 2 +-
 tools/testing/selftests/kvm/x86/nested_dirty_log_test.c       | 2 +-
 tools/testing/selftests/kvm/x86/nested_emulation_test.c       | 2 +-
 tools/testing/selftests/kvm/x86/nested_exceptions_test.c      | 2 +-
 tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c     | 2 +-
 tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c       | 2 +-
 tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c      | 2 +-
 tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c     | 2 +-
 tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c | 2 +-
 tools/testing/selftests/kvm/x86/smm_test.c                    | 2 +-
 tools/testing/selftests/kvm/x86/state_test.c                  | 2 +-
 tools/testing/selftests/kvm/x86/triple_fault_event_test.c     | 2 +-
 tools/testing/selftests/kvm/x86/vmx_apic_access_test.c        | 2 +-
 tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c      | 2 +-
 .../selftests/kvm/x86/vmx_invalid_nested_guest_state.c        | 2 +-
 tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c  | 2 +-
 tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c   | 2 +-
 22 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 8f004b946826..5c46ae95c4c3 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -550,7 +550,7 @@ union vmx_ctrl_msr {
 struct vmx_pages *vcpu_alloc_vmx(struct kvm_vm *vm, gva_t *p_vmx_gva);
 void prepare_for_vmx_operation(struct vmx_pages *vmx);
 void prepare_vmcs(struct vmx_pages *vmx, void *guest_rip);
-bool load_vmcs(struct vmx_pages *vmx);
+void load_vmcs(struct vmx_pages *vmx);
 
 bool ept_1g_pages_supported(void);
 
diff --git a/tools/testing/selftests/kvm/lib/x86/memstress.c b/tools/testing/selftests/kvm/lib/x86/memstress.c
index 2fa39470c1b3..207350ab6114 100644
--- a/tools/testing/selftests/kvm/lib/x86/memstress.c
+++ b/tools/testing/selftests/kvm/lib/x86/memstress.c
@@ -34,7 +34,7 @@ static void l1_vmx_code(struct vmx_pages *vmx, u64 vcpu_id)
 {
 	GUEST_ASSERT(vmx->vmcs_gpa);
 	prepare_for_vmx_operation(vmx);
-	GUEST_ASSERT(load_vmcs(vmx));
+	load_vmcs(vmx);
 	GUEST_ASSERT(ept_1g_pages_supported());
 
 	*(u64 *)vmx->stack = vcpu_id;
diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
index e65024b9ea0d..5c6cadc08405 100644
--- a/tools/testing/selftests/kvm/lib/x86/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -166,7 +166,7 @@ void prepare_for_vmx_operation(struct vmx_pages *vmx)
 	vmxon(vmx->vmxon_gpa);
 }
 
-bool load_vmcs(struct vmx_pages *vmx)
+void load_vmcs(struct vmx_pages *vmx)
 {
 	/* Load a VMCS. */
 	*(u32 *)(vmx->vmcs) = vmcs_revision();
@@ -177,8 +177,6 @@ bool load_vmcs(struct vmx_pages *vmx)
 	/* Setup shadow VMCS, do not load it yet. */
 	*(u32 *)(vmx->shadow_vmcs) = vmcs_revision() | 0x80000000ul;
 	vmclear(vmx->shadow_vmcs_gpa);
-
-	return true;
 }
 
 static bool ept_vpid_cap_supported(u64 mask)
diff --git a/tools/testing/selftests/kvm/x86/aperfmperf_test.c b/tools/testing/selftests/kvm/x86/aperfmperf_test.c
index e32131cd6ed1..11f5894d8ac7 100644
--- a/tools/testing/selftests/kvm/x86/aperfmperf_test.c
+++ b/tools/testing/selftests/kvm/x86/aperfmperf_test.c
@@ -71,7 +71,7 @@ static void l1_svm_code(struct svm_test_data *svm)
 static void l1_vmx_code(struct vmx_pages *vmx)
 {
 	prepare_for_vmx_operation(vmx);
-	GUEST_ASSERT_EQ(load_vmcs(vmx), true);
+	load_vmcs(vmx);
 
 	prepare_vmcs(vmx, NULL);
 
diff --git a/tools/testing/selftests/kvm/x86/kvm_buslock_test.c b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
index 2e006ce95896..22993ec697fa 100644
--- a/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
+++ b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
@@ -43,7 +43,7 @@ static void l1_svm_code(struct svm_test_data *svm)
 static void l1_vmx_code(struct vmx_pages *vmx)
 {
 	prepare_for_vmx_operation(vmx);
-	GUEST_ASSERT_EQ(load_vmcs(vmx), true);
+	load_vmcs(vmx);
 
 	prepare_vmcs(vmx, NULL);
 
diff --git a/tools/testing/selftests/kvm/x86/nested_close_kvm_test.c b/tools/testing/selftests/kvm/x86/nested_close_kvm_test.c
index 479e9adcc20b..309cab009929 100644
--- a/tools/testing/selftests/kvm/x86/nested_close_kvm_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_close_kvm_test.c
@@ -31,7 +31,7 @@ static void l2_guest_code(void)
 static void l1_vmx_code(struct vmx_pages *vmx_pages)
 {
 	prepare_for_vmx_operation(vmx_pages);
-	GUEST_ASSERT(load_vmcs(vmx_pages));
+	load_vmcs(vmx_pages);
 
 	/* Prepare the VMCS for L2 execution. */
 	prepare_vmcs(vmx_pages, l2_guest_code);
diff --git a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
index 57f49471f4aa..dca2bfc8b158 100644
--- a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
@@ -94,7 +94,7 @@ void l1_vmx_code(struct vmx_pages *vmx)
 
 	GUEST_ASSERT(vmx->vmcs_gpa);
 	prepare_for_vmx_operation(vmx);
-	GUEST_ASSERT(load_vmcs(vmx));
+	load_vmcs(vmx);
 
 	if (vmx->eptp_gpa)
 		l2_rip = l2_guest_code_tdp_enabled;
diff --git a/tools/testing/selftests/kvm/x86/nested_emulation_test.c b/tools/testing/selftests/kvm/x86/nested_emulation_test.c
index 6f27930bb6b5..2b38eff4f516 100644
--- a/tools/testing/selftests/kvm/x86/nested_emulation_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_emulation_test.c
@@ -67,7 +67,7 @@ static void guest_code(void *test_data)
 		vmcb->control.intercept_exceptions = 0;
 	} else {
 		prepare_for_vmx_operation(test_data);
-		GUEST_ASSERT(load_vmcs(test_data));
+		load_vmcs(test_data);
 
 		prepare_vmcs(test_data, NULL);
 		GUEST_ASSERT(!vmwrite(GUEST_IDTR_LIMIT, 0));
diff --git a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
index 6a36cf4d1eab..50c271a03692 100644
--- a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
@@ -127,7 +127,7 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 {
 	prepare_for_vmx_operation(vmx);
 
-	GUEST_ASSERT_EQ(load_vmcs(vmx), true);
+	load_vmcs(vmx);
 
 	prepare_vmcs(vmx, NULL);
 	GUEST_ASSERT_EQ(vmwrite(GUEST_IDTR_LIMIT, 0), 0);
diff --git a/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c b/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c
index 749a93c318fe..43deb3b358ea 100644
--- a/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c
@@ -41,7 +41,7 @@ static void l1_vmx_code(struct vmx_pages *vmx_pages)
 	uintptr_t save_cr3;
 
 	prepare_for_vmx_operation(vmx_pages);
-	GUEST_ASSERT(load_vmcs(vmx_pages));
+	load_vmcs(vmx_pages);
 
 	prepare_vmcs(vmx_pages, l2_guest_code);
 
diff --git a/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c b/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c
index b143ebe710e7..52df467e9c44 100644
--- a/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c
@@ -56,7 +56,7 @@ static void l1_vmx_code(struct vmx_pages *vmx, u64 expected_fault_gpa,
 
 	GUEST_ASSERT(vmx->vmcs_gpa);
 	prepare_for_vmx_operation(vmx);
-	GUEST_ASSERT(load_vmcs(vmx));
+	load_vmcs(vmx);
 
 	prepare_vmcs(vmx, l2_entry);
 
diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c
index 3d2eae848ba6..05194762ed33 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c
@@ -87,7 +87,7 @@ static void l1_guest_code(void *data)
 		u32 control;
 
 		prepare_for_vmx_operation(vmx_pages);
-		GUEST_ASSERT(load_vmcs(vmx_pages));
+		load_vmcs(vmx_pages);
 
 		prepare_vmcs(vmx_pages, l2_guest_code);
 		control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
index 584071146b69..b9fae268a9ec 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
@@ -106,7 +106,7 @@ static void l1_vmx_code(struct vmx_pages *vmx_pages)
 	check_tsc_freq(UCHECK_L1);
 
 	prepare_for_vmx_operation(vmx_pages);
-	GUEST_ASSERT(load_vmcs(vmx_pages));
+	load_vmcs(vmx_pages);
 
 	/* prepare the VMCS for L2 execution */
 	prepare_vmcs(vmx_pages, l2_guest_code);
diff --git a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
index 6ab73a0bd34a..c0e4d6e156ad 100644
--- a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
+++ b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
@@ -99,7 +99,7 @@ static void l1_svm_code(struct svm_test_data *svm)
 static void l1_vmx_code(struct vmx_pages *vmx)
 {
 	prepare_for_vmx_operation(vmx);
-	GUEST_ASSERT(load_vmcs(vmx));
+	load_vmcs(vmx);
 	prepare_vmcs(vmx, guest_access_memory);
 
 	GUEST_ASSERT(!vmwrite(EXCEPTION_BITMAP, BIT(UD_VECTOR)));
diff --git a/tools/testing/selftests/kvm/x86/smm_test.c b/tools/testing/selftests/kvm/x86/smm_test.c
index be5662792ec8..377df09e582a 100644
--- a/tools/testing/selftests/kvm/x86/smm_test.c
+++ b/tools/testing/selftests/kvm/x86/smm_test.c
@@ -79,7 +79,7 @@ static void guest_code(void *arg)
 			generic_svm_setup(svm, l2_guest_code);
 		} else {
 			prepare_for_vmx_operation(vmx_pages);
-			GUEST_ASSERT(load_vmcs(vmx_pages));
+			load_vmcs(vmx_pages);
 			prepare_vmcs(vmx_pages, l2_guest_code);
 		}
 
diff --git a/tools/testing/selftests/kvm/x86/state_test.c b/tools/testing/selftests/kvm/x86/state_test.c
index a7786f478be0..bd5e9e36b2c9 100644
--- a/tools/testing/selftests/kvm/x86/state_test.c
+++ b/tools/testing/selftests/kvm/x86/state_test.c
@@ -77,7 +77,7 @@ static void vmx_l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_ASSERT(vmx_pages->vmcs_gpa);
 	prepare_for_vmx_operation(vmx_pages);
 	GUEST_SYNC(3);
-	GUEST_ASSERT(load_vmcs(vmx_pages));
+	load_vmcs(vmx_pages);
 	GUEST_ASSERT(vmptrst() == vmx_pages->vmcs_gpa);
 
 	GUEST_SYNC(4);
diff --git a/tools/testing/selftests/kvm/x86/triple_fault_event_test.c b/tools/testing/selftests/kvm/x86/triple_fault_event_test.c
index 57e79922b16b..a9fb7046ea4f 100644
--- a/tools/testing/selftests/kvm/x86/triple_fault_event_test.c
+++ b/tools/testing/selftests/kvm/x86/triple_fault_event_test.c
@@ -26,7 +26,7 @@ void l1_guest_code_vmx(struct vmx_pages *vmx)
 
 	GUEST_ASSERT(vmx->vmcs_gpa);
 	prepare_for_vmx_operation(vmx);
-	GUEST_ASSERT(load_vmcs(vmx));
+	load_vmcs(vmx);
 
 	prepare_vmcs(vmx, l2_guest_code);
 
diff --git a/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c b/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
index 7df9ab833cb2..1793f7b02219 100644
--- a/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
@@ -39,7 +39,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages, unsigned long high_gpa)
 	u32 control;
 
 	prepare_for_vmx_operation(vmx_pages);
-	GUEST_ASSERT(load_vmcs(vmx_pages));
+	load_vmcs(vmx_pages);
 
 	/* Prepare the VMCS for L2 execution. */
 	prepare_vmcs(vmx_pages, l2_guest_code);
diff --git a/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c b/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c
index 8e4dc304533a..f7ebc9b15629 100644
--- a/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c
@@ -34,7 +34,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	u32 control;
 
 	prepare_for_vmx_operation(vmx_pages);
-	GUEST_ASSERT(load_vmcs(vmx_pages));
+	load_vmcs(vmx_pages);
 
 	/* Prepare the VMCS for L2 execution. */
 	prepare_vmcs(vmx_pages, l2_guest_code);
diff --git a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
index 8999f0458aa1..4a6445958cf4 100644
--- a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
+++ b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
@@ -42,7 +42,7 @@ static void l2_guest_code(void)
 static void l1_guest_code(struct vmx_pages *vmx_pages)
 {
 	prepare_for_vmx_operation(vmx_pages);
-	GUEST_ASSERT(load_vmcs(vmx_pages));
+	load_vmcs(vmx_pages);
 
 	/* Prepare the VMCS for L2 execution. */
 	prepare_vmcs(vmx_pages, l2_guest_code);
diff --git a/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c b/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c
index 444596ab1592..04c2d5113e84 100644
--- a/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c
@@ -38,7 +38,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 
 	GUEST_ASSERT(vmx_pages->vmcs_gpa);
 	prepare_for_vmx_operation(vmx_pages);
-	GUEST_ASSERT(load_vmcs(vmx_pages));
+	load_vmcs(vmx_pages);
 
 	prepare_vmcs(vmx_pages, l2_guest_code);
 
diff --git a/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
index 09f9686657ad..50fc9309158f 100644
--- a/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
@@ -72,7 +72,7 @@ void l1_guest_code(struct vmx_pages *vmx_pages)
 
 	GUEST_ASSERT(vmx_pages->vmcs_gpa);
 	prepare_for_vmx_operation(vmx_pages);
-	GUEST_ASSERT(load_vmcs(vmx_pages));
+	load_vmcs(vmx_pages);
 	GUEST_ASSERT(vmptrst() == vmx_pages->vmcs_gpa);
 
 	prepare_vmcs(vmx_pages, l2_guest_code);
-- 
2.55.0.887.g758fc8c411-goog

