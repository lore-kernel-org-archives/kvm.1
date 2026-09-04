Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CD126461F
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481480; cv=none; b=rX1yQpg0iwM5PR8GqU3I1paKkZqRsdgkOc+duM1GlfwCbAwodx4CRQVEdsrv3jHzvryECmNTmW7L0CxXscke+Hii6/W5dwiLJmnEXkVgECDwobC451YZ+U6wNospxNZtWB/TJULc7jUpDAdwu/PFqc5bzHWsqFBtXcN0VaTIVRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481480; c=relaxed/simple;
	bh=tyTPuhJ59/2XjTUzKgS1GHNfk7KV+LR3F/VF3b6QuWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iJydMHD4RqJ0UZh3G421A8wEA5Y9I89WbmBfJK13aEGWrPyBldKpn8v5jrBYpMGkmtQ68zOIwy5zIGdKKGgRCgNPUUNJKUW2+ka3mJi91NpZzxEU9D/a3GAv8x/8OuOGpfw8uLxAH5yhidkGoH0Fx/Uu5VtwgK9NH/eTk8lno1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qmjo3nOh; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qmjo3nOh"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c89704da8c7so632040a12.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788481474; x=1789086274; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YnpMw4eZoFav91J38/RKkAOZr7Pc3bKjaw9owuLkN4o=;
        b=Qmjo3nOh0hiofFdi0jp/f+foR5rckpFHRUJAT7keH7zoEbseiY/byE2g3lBo17+5wB
         PWExPMG5CGDwf0J1LhHMaeBGhP4I9mQ76zS/dI/F8aYGrcptYoL5D95Che/soHDH4K1U
         JabglXkIHVE1K6msYKg7l/wj6RWLCIMDKvJltIrCgiubEaPHdJjkoWEnzbbr7um87k4b
         fCDXBTGTWS2X0Igq7+4BrrnZArPvYU5eUbEn93wpNIbR10bFpjuEvMoexJOM/oiVNpvD
         yH7UsRfN5VPuLcr8TTxkji7QV/fSuZwv1aWKMQF+5MTldx0T+drlhDOhOaUgw+G43dsD
         iOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788481474; x=1789086274;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YnpMw4eZoFav91J38/RKkAOZr7Pc3bKjaw9owuLkN4o=;
        b=G8s3ZV1wmUpOxbN/lAnkuCVMvudjzVYaqfoxS56kkz8WmILjwvcjQLizhQ18yra0e/
         zAosTc1wmJwng6eEfvPt0vbTwld7o4Ll/1bbmV2tRtFZSnxurwPyMroy4C//pa1WXPt3
         wPIgN44g2Ebzi9GbX1LQSeJpjmRc2X5kEEnbFBJtClbpKlhghSRJnqinE/WJnvuWEROy
         WBPrPvb16YK8aFcqq79WO+xzS+k75jJyJPDgVAJYkgA8tdvfQW8kFzPY+qWUV6do/1d8
         ra9FqhG+ttI7/axOCAtE1PayrRf8OEkihw2nKPMKi29cl2p5nyyVWKJbEOYJyaNWzO8w
         fJ3w==
X-Gm-Message-State: AFuF++nvGqYaFcGE7vJZFEyHTsMc4ErDQ5/J3STago6Be4nOkjsribIu
	pQAzr9ucbQQOq6LKN7OprAfR0o9iQzT4LM0jnH80r0wBQODHVhDpMee1lBp/Hi7UeRXd4nLlAhB
	CoADL2w==
X-Received: from pgbj10-n1.prod.google.com ([2002:a05:6a02:61ca:10b0:cc4:55ec:3295])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a38b:b0:3d0:9164:98a7
 with SMTP id adf61e73a8af0-3da39e830b7mr3533851637.11.1788481473933; Thu, 03
 Sep 2026 17:24:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:24:13 -0700
In-Reply-To: <20260904002423.3154436-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904002423.3154436-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904002423.3154436-8-seanjc@google.com>
Subject: [PATCH v4 07/17] KVM: selftests: Always assert that vmxon() and
 prepare_for_vmx_operation() succeed
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Assert that vmxon() succeeds, and by extension prepare_for_vmx_operation().
Forcing every caller to assert that a core preparation helper succeeds is
absurd and generates hard-to-read code.

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/vmx.h              | 6 +++---
 tools/testing/selftests/kvm/lib/x86/memstress.c            | 2 +-
 tools/testing/selftests/kvm/lib/x86/vmx.c                  | 7 ++-----
 tools/testing/selftests/kvm/x86/aperfmperf_test.c          | 2 +-
 tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c  | 2 +-
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c             | 2 +-
 tools/testing/selftests/kvm/x86/kvm_buslock_test.c         | 2 +-
 tools/testing/selftests/kvm/x86/nested_close_kvm_test.c    | 2 +-
 tools/testing/selftests/kvm/x86/nested_dirty_log_test.c    | 2 +-
 tools/testing/selftests/kvm/x86/nested_emulation_test.c    | 2 +-
 tools/testing/selftests/kvm/x86/nested_exceptions_test.c   | 2 +-
 tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c  | 2 +-
 tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c    | 2 +-
 tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c   | 2 +-
 tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c  | 2 +-
 .../selftests/kvm/x86/save_restore_pf_stress_test.c        | 2 +-
 tools/testing/selftests/kvm/x86/smm_test.c                 | 2 +-
 tools/testing/selftests/kvm/x86/state_test.c               | 2 +-
 tools/testing/selftests/kvm/x86/triple_fault_event_test.c  | 2 +-
 tools/testing/selftests/kvm/x86/vmx_apic_access_test.c     | 2 +-
 tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c   | 2 +-
 .../selftests/kvm/x86/vmx_invalid_nested_guest_state.c     | 2 +-
 .../testing/selftests/kvm/x86/vmx_nested_la57_state_test.c | 2 +-
 .../testing/selftests/kvm/x86/vmx_preemption_timer_test.c  | 2 +-
 24 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 04f638fcd3ba..f7ca6646dfbe 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -309,7 +309,7 @@ struct vmx_msr_entry {
 
 #include "evmcs.h"
 
-static inline int vmxon(u64 phys)
+static inline void vmxon(u64 phys)
 {
 	u8 ret;
 
@@ -318,7 +318,7 @@ static inline int vmxon(u64 phys)
 		: [pa]"m"(phys)
 		: "cc", "memory");
 
-	return ret;
+	__GUEST_ASSERT(!ret, "vmxon [0x%lx] failed", phys);
 }
 
 static inline void vmxoff(void)
@@ -549,7 +549,7 @@ union vmx_ctrl_msr {
 };
 
 struct vmx_pages *vcpu_alloc_vmx(struct kvm_vm *vm, gva_t *p_vmx_gva);
-bool prepare_for_vmx_operation(struct vmx_pages *vmx);
+void prepare_for_vmx_operation(struct vmx_pages *vmx);
 void prepare_vmcs(struct vmx_pages *vmx, void *guest_rip);
 bool load_vmcs(struct vmx_pages *vmx);
 
diff --git a/tools/testing/selftests/kvm/lib/x86/memstress.c b/tools/testing/selftests/kvm/lib/x86/memstress.c
index e19e8b5a09c5..2fa39470c1b3 100644
--- a/tools/testing/selftests/kvm/lib/x86/memstress.c
+++ b/tools/testing/selftests/kvm/lib/x86/memstress.c
@@ -33,7 +33,7 @@ __asm__(
 static void l1_vmx_code(struct vmx_pages *vmx, u64 vcpu_id)
 {
 	GUEST_ASSERT(vmx->vmcs_gpa);
-	GUEST_ASSERT(prepare_for_vmx_operation(vmx));
+	prepare_for_vmx_operation(vmx);
 	GUEST_ASSERT(load_vmcs(vmx));
 	GUEST_ASSERT(ept_1g_pages_supported());
 
diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
index 089e1a8af53f..03d61b1159f8 100644
--- a/tools/testing/selftests/kvm/lib/x86/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -125,7 +125,7 @@ vcpu_alloc_vmx(struct kvm_vm *vm, gva_t *p_vmx_gva)
 	return vmx;
 }
 
-bool prepare_for_vmx_operation(struct vmx_pages *vmx)
+void prepare_for_vmx_operation(struct vmx_pages *vmx)
 {
 	u64 feature_control;
 	u64 required;
@@ -163,10 +163,7 @@ bool prepare_for_vmx_operation(struct vmx_pages *vmx)
 
 	/* Enter VMX root operation. */
 	*(u32 *)(vmx->vmxon) = vmcs_revision();
-	if (vmxon(vmx->vmxon_gpa))
-		return false;
-
-	return true;
+	vmxon(vmx->vmxon_gpa);
 }
 
 bool load_vmcs(struct vmx_pages *vmx)
diff --git a/tools/testing/selftests/kvm/x86/aperfmperf_test.c b/tools/testing/selftests/kvm/x86/aperfmperf_test.c
index 845cb685f174..e32131cd6ed1 100644
--- a/tools/testing/selftests/kvm/x86/aperfmperf_test.c
+++ b/tools/testing/selftests/kvm/x86/aperfmperf_test.c
@@ -70,7 +70,7 @@ static void l1_svm_code(struct svm_test_data *svm)
 
 static void l1_vmx_code(struct vmx_pages *vmx)
 {
-	GUEST_ASSERT_EQ(prepare_for_vmx_operation(vmx), true);
+	prepare_for_vmx_operation(vmx);
 	GUEST_ASSERT_EQ(load_vmcs(vmx), true);
 
 	prepare_vmcs(vmx, NULL);
diff --git a/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c b/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
index aa7f3b405fd3..cafb58a37023 100644
--- a/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
+++ b/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
@@ -55,7 +55,7 @@ static void guest_code(struct vmx_pages *vmx_pages,
 	enable_vp_assist(hv_pages->vp_assist_gpa, hv_pages->vp_assist);
 	evmcs_enable();
 
-	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	prepare_for_vmx_operation(vmx_pages);
 	GUEST_ASSERT(load_evmcs(hv_pages));
 	prepare_vmcs(vmx_pages, l2_guest_code);
 
diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
index 0c9cf620c87d..d0e857b75a47 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
@@ -93,7 +93,7 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	enable_vp_assist(hv_pages->vp_assist_gpa, hv_pages->vp_assist);
 	evmcs_enable();
 
-	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	prepare_for_vmx_operation(vmx_pages);
 	GUEST_SYNC(3);
 	GUEST_ASSERT(load_evmcs(hv_pages));
 	/* VMPTRST returns -1 until VMLAUNCH with eVMCS ptr set */
diff --git a/tools/testing/selftests/kvm/x86/kvm_buslock_test.c b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
index 25a182be00a9..2e006ce95896 100644
--- a/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
+++ b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
@@ -42,7 +42,7 @@ static void l1_svm_code(struct svm_test_data *svm)
 
 static void l1_vmx_code(struct vmx_pages *vmx)
 {
-	GUEST_ASSERT_EQ(prepare_for_vmx_operation(vmx), true);
+	prepare_for_vmx_operation(vmx);
 	GUEST_ASSERT_EQ(load_vmcs(vmx), true);
 
 	prepare_vmcs(vmx, NULL);
diff --git a/tools/testing/selftests/kvm/x86/nested_close_kvm_test.c b/tools/testing/selftests/kvm/x86/nested_close_kvm_test.c
index b974cfb347d6..479e9adcc20b 100644
--- a/tools/testing/selftests/kvm/x86/nested_close_kvm_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_close_kvm_test.c
@@ -30,7 +30,7 @@ static void l2_guest_code(void)
 
 static void l1_vmx_code(struct vmx_pages *vmx_pages)
 {
-	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	prepare_for_vmx_operation(vmx_pages);
 	GUEST_ASSERT(load_vmcs(vmx_pages));
 
 	/* Prepare the VMCS for L2 execution. */
diff --git a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
index 26b474bf1353..57f49471f4aa 100644
--- a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
@@ -93,7 +93,7 @@ void l1_vmx_code(struct vmx_pages *vmx)
 	void *l2_rip;
 
 	GUEST_ASSERT(vmx->vmcs_gpa);
-	GUEST_ASSERT(prepare_for_vmx_operation(vmx));
+	prepare_for_vmx_operation(vmx);
 	GUEST_ASSERT(load_vmcs(vmx));
 
 	if (vmx->eptp_gpa)
diff --git a/tools/testing/selftests/kvm/x86/nested_emulation_test.c b/tools/testing/selftests/kvm/x86/nested_emulation_test.c
index e08c6b0697e5..6f27930bb6b5 100644
--- a/tools/testing/selftests/kvm/x86/nested_emulation_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_emulation_test.c
@@ -66,7 +66,7 @@ static void guest_code(void *test_data)
 					   BIT_ULL(INTERCEPT_HLT);
 		vmcb->control.intercept_exceptions = 0;
 	} else {
-		GUEST_ASSERT(prepare_for_vmx_operation(test_data));
+		prepare_for_vmx_operation(test_data);
 		GUEST_ASSERT(load_vmcs(test_data));
 
 		prepare_vmcs(test_data, NULL);
diff --git a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
index aeec3121c8e8..6a36cf4d1eab 100644
--- a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
@@ -125,7 +125,7 @@ static void vmx_run_l2(void *l2_code, int vector, u32 error_code)
 
 static void l1_vmx_code(struct vmx_pages *vmx)
 {
-	GUEST_ASSERT_EQ(prepare_for_vmx_operation(vmx), true);
+	prepare_for_vmx_operation(vmx);
 
 	GUEST_ASSERT_EQ(load_vmcs(vmx), true);
 
diff --git a/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c b/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c
index 8c2ba9674558..749a93c318fe 100644
--- a/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c
@@ -40,7 +40,7 @@ static void l1_vmx_code(struct vmx_pages *vmx_pages)
 {
 	uintptr_t save_cr3;
 
-	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	prepare_for_vmx_operation(vmx_pages);
 	GUEST_ASSERT(load_vmcs(vmx_pages));
 
 	prepare_vmcs(vmx_pages, l2_guest_code);
diff --git a/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c b/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c
index 2e04563790ff..b143ebe710e7 100644
--- a/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c
@@ -55,7 +55,7 @@ static void l1_vmx_code(struct vmx_pages *vmx, u64 expected_fault_gpa,
 	u64 exit_qual;
 
 	GUEST_ASSERT(vmx->vmcs_gpa);
-	GUEST_ASSERT(prepare_for_vmx_operation(vmx));
+	prepare_for_vmx_operation(vmx);
 	GUEST_ASSERT(load_vmcs(vmx));
 
 	prepare_vmcs(vmx, l2_entry);
diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c
index cb79d7b9619c..3d2eae848ba6 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c
@@ -86,7 +86,7 @@ static void l1_guest_code(void *data)
 		struct vmx_pages *vmx_pages = data;
 		u32 control;
 
-		GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+		prepare_for_vmx_operation(vmx_pages);
 		GUEST_ASSERT(load_vmcs(vmx_pages));
 
 		prepare_vmcs(vmx_pages, l2_guest_code);
diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
index 18f765835bf4..584071146b69 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
@@ -105,7 +105,7 @@ static void l1_vmx_code(struct vmx_pages *vmx_pages)
 	/* check that L1's frequency looks alright before launching L2 */
 	check_tsc_freq(UCHECK_L1);
 
-	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	prepare_for_vmx_operation(vmx_pages);
 	GUEST_ASSERT(load_vmcs(vmx_pages));
 
 	/* prepare the VMCS for L2 execution */
diff --git a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
index 507391ab2c93..6ab73a0bd34a 100644
--- a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
+++ b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
@@ -98,7 +98,7 @@ static void l1_svm_code(struct svm_test_data *svm)
 
 static void l1_vmx_code(struct vmx_pages *vmx)
 {
-	GUEST_ASSERT(prepare_for_vmx_operation(vmx));
+	prepare_for_vmx_operation(vmx);
 	GUEST_ASSERT(load_vmcs(vmx));
 	prepare_vmcs(vmx, guest_access_memory);
 
diff --git a/tools/testing/selftests/kvm/x86/smm_test.c b/tools/testing/selftests/kvm/x86/smm_test.c
index d1edafd5af75..be5662792ec8 100644
--- a/tools/testing/selftests/kvm/x86/smm_test.c
+++ b/tools/testing/selftests/kvm/x86/smm_test.c
@@ -78,7 +78,7 @@ static void guest_code(void *arg)
 		if (this_cpu_has(X86_FEATURE_SVM)) {
 			generic_svm_setup(svm, l2_guest_code);
 		} else {
-			GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+			prepare_for_vmx_operation(vmx_pages);
 			GUEST_ASSERT(load_vmcs(vmx_pages));
 			prepare_vmcs(vmx_pages, l2_guest_code);
 		}
diff --git a/tools/testing/selftests/kvm/x86/state_test.c b/tools/testing/selftests/kvm/x86/state_test.c
index 9d4e0c1f7c18..203584fcaf62 100644
--- a/tools/testing/selftests/kvm/x86/state_test.c
+++ b/tools/testing/selftests/kvm/x86/state_test.c
@@ -75,7 +75,7 @@ void vmx_l2_guest_code(void)
 static void vmx_l1_guest_code(struct vmx_pages *vmx_pages)
 {
 	GUEST_ASSERT(vmx_pages->vmcs_gpa);
-	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	prepare_for_vmx_operation(vmx_pages);
 	GUEST_SYNC(3);
 	GUEST_ASSERT(load_vmcs(vmx_pages));
 	GUEST_ASSERT(vmptrst() == vmx_pages->vmcs_gpa);
diff --git a/tools/testing/selftests/kvm/x86/triple_fault_event_test.c b/tools/testing/selftests/kvm/x86/triple_fault_event_test.c
index 0d83516f4bd0..57e79922b16b 100644
--- a/tools/testing/selftests/kvm/x86/triple_fault_event_test.c
+++ b/tools/testing/selftests/kvm/x86/triple_fault_event_test.c
@@ -25,7 +25,7 @@ void l1_guest_code_vmx(struct vmx_pages *vmx)
 {
 
 	GUEST_ASSERT(vmx->vmcs_gpa);
-	GUEST_ASSERT(prepare_for_vmx_operation(vmx));
+	prepare_for_vmx_operation(vmx);
 	GUEST_ASSERT(load_vmcs(vmx));
 
 	prepare_vmcs(vmx, l2_guest_code);
diff --git a/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c b/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
index 463f73aa9159..7df9ab833cb2 100644
--- a/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
@@ -38,7 +38,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages, unsigned long high_gpa)
 {
 	u32 control;
 
-	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	prepare_for_vmx_operation(vmx_pages);
 	GUEST_ASSERT(load_vmcs(vmx_pages));
 
 	/* Prepare the VMCS for L2 execution. */
diff --git a/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c b/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c
index f9b88a6f6113..8e4dc304533a 100644
--- a/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c
@@ -33,7 +33,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 {
 	u32 control;
 
-	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	prepare_for_vmx_operation(vmx_pages);
 	GUEST_ASSERT(load_vmcs(vmx_pages));
 
 	/* Prepare the VMCS for L2 execution. */
diff --git a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
index c8379124b317..8999f0458aa1 100644
--- a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
+++ b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
@@ -41,7 +41,7 @@ static void l2_guest_code(void)
 
 static void l1_guest_code(struct vmx_pages *vmx_pages)
 {
-	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	prepare_for_vmx_operation(vmx_pages);
 	GUEST_ASSERT(load_vmcs(vmx_pages));
 
 	/* Prepare the VMCS for L2 execution. */
diff --git a/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c b/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c
index 75073efa926d..444596ab1592 100644
--- a/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c
@@ -37,7 +37,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_ASSERT(rdmsr(MSR_GS_BASE) == LA57_GS_BASE);
 
 	GUEST_ASSERT(vmx_pages->vmcs_gpa);
-	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	prepare_for_vmx_operation(vmx_pages);
 	GUEST_ASSERT(load_vmcs(vmx_pages));
 
 	prepare_vmcs(vmx_pages, l2_guest_code);
diff --git a/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
index 523aab667d85..09f9686657ad 100644
--- a/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
@@ -71,7 +71,7 @@ void l1_guest_code(struct vmx_pages *vmx_pages)
 	u64 l1_tsc_deadline, l2_tsc_deadline;
 
 	GUEST_ASSERT(vmx_pages->vmcs_gpa);
-	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	prepare_for_vmx_operation(vmx_pages);
 	GUEST_ASSERT(load_vmcs(vmx_pages));
 	GUEST_ASSERT(vmptrst() == vmx_pages->vmcs_gpa);
 
-- 
2.55.0.979.g7e5102b832-goog

