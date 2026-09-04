Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D55D270EDF
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481483; cv=none; b=J4nrw3ysQbuBb6Ze0BIT2wOIdoLr4hJaH2CNjaXXc5gASoWXPMJHZCJViS3AUO7b2SPIIYSLURPRYLO8cYpgjZygnCf5gorZjIRova0GmxdmpMDByYN0XqFTc1nPHo17Vo917Q1uScmELQrWNlK0DiaGXg50Qd0QK6SRkxLUB4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481483; c=relaxed/simple;
	bh=HzkKv4Q2MLa0YGb5Rcn1Fmbo1i7nWyNpJmAS6K5V44c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=flRSPhiuKpEkprGZcxiRP7Qh8pBrStuMt1JP0VN1CA+ctXBHIt0y0TZLj0zO4dCRiefTr6ePOZ1qHzy3nQb0WT+ytqlGCZ93w2V8fv3KzNe0U/7ASwQWrgPc7UMlEDazOisM2tRWPKojn7HeyzIXzLQNZbguYYUXdUGpT4Uwq7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CFfuAOve; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFfuAOve"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc435388657so746007a12.3
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788481478; x=1789086278; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4lP+McG+LuzSZSEuCYz5r9zqeKYerKG2G8XKDFbEV6M=;
        b=CFfuAOveNUvU6qfzFz7wvPg8ajbPpfpIKCNnT5skMuaCKbOaWKaY/kYMY/+C/+YYAX
         YuCXqJSjN1p2l4uKu/sFMRWkVh1OWystgGMROhyjL0mUKdKlnXjmdwr46Nmh1v2MiWdM
         v1np07m2rtpNbMFQ0/Vfe/f59+zEvX+MK4JtD8KT2eFIU+0J+s6kFEZuqBxuArk2vl9F
         eeEJ4b/ydncHI+M6bzVdwDPm0R2xmrTN/sfrVof3W58TH04EzLynlOtTtF+VJDu2J/v0
         BoCk7nxBvXA6Nfjcrivq69nA5pBxpso8RMfHOW3jILeZLOLjX2Zj/E4FY2HFrFBh+80s
         EUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788481478; x=1789086278;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4lP+McG+LuzSZSEuCYz5r9zqeKYerKG2G8XKDFbEV6M=;
        b=WfHQf3TX4CSWjWLDfJWCpKeTfqhb7/8b3nJVnykid4IfwrFvSivxKfhslrC+i+v77x
         NDxvnprFR86VoNVrD4pLb9NDHvc1wdDUqkKk689rcHVJyaTJXgYXco0SgDNmV0URE0EA
         nWXJrdaDUZC7BOHJX+kk7fvXW3PaoPswPKolMJDpIbEjmSGpGShT/MvjmhbMnn9fEC3g
         WwJqHMoWC7wguvBoFAW2NDKsxBDLqSXZDGh3pZu9jyUTGf6MY9E22S+RRZ1Gmnp4IKHh
         GYdQPPaK21sq9IUb85lqh/suCYVTOBeUpHwsZulTx6IBVigK2cET30Ne55akurs8U3jX
         9vWg==
X-Gm-Message-State: AFuF++myX+iNK6YlfroJOgAnPQrcE9o3kZKrlAHXr6uY+cGNcQwasnD3
	Kkotp6FC2ds6oD8Bxa5oynsKqL+bXe31YC8+vmqQ1ke/RS0O6Lb1vwgZiMl4lvnyX8ueL7nNBzM
	HcGziRg==
X-Received: from pgak18.prod.google.com ([2002:a05:6a02:6752:b0:cc4:33fd:a4f7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1441:b0:3c3:9070:96b3
 with SMTP id adf61e73a8af0-3da39cffff0mr3643079637.3.1788481477405; Thu, 03
 Sep 2026 17:24:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:24:16 -0700
In-Reply-To: <20260904002423.3154436-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904002423.3154436-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904002423.3154436-11-seanjc@google.com>
Subject: [PATCH v4 10/17] KVM: selftests: Drop useless return code from load_vmcs()
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
2.55.0.979.g7e5102b832-goog

