Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A733BED45
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182755; cv=none; b=jfzuB6f36XkcWFiPDfpxqXr2xo31f0rHR70mqEJCnc7LUgLELVfCIovzxBmeUioPzskt/AtalNzHqh9B+B+dBBIP+SOGwnrLKbqng8s1lrGmBpE2nXdvnGF/E2ivZg/ic2G51uk2vfSy8GllYfFPnkkHSUh9UUCkHGXJJ+jty5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182755; c=relaxed/simple;
	bh=FZWkyRtDd5sYp24vsvD+gZbVOVt0EAV2B3Zfqrqy1QI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qIoPezdYm8TIiMq6EsIQaJFXqcveEK1MO32Ygen5tSSkT8olc3T8W3nyp5YNhcNGMWGergVHh4JOxvSyYPpWolRam5OS2nMW3zV2Ar6yC1tKOuBxauV55hY7V+uS8i/mJYtZ1/pdfyYx30eAGJRkt8h73DfqU+RUPBSFigtKiKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oKsB0MKT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oKsB0MKT"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae57228f64so98569935ad.0
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 15:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773182753; x=1773787553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hvcwGyyqhhK+9ujMD1DpAI6luR3guQH7bK6OSfrMLVU=;
        b=oKsB0MKTMYAaEsfXUJRY59/k2J7dBzZW5a7uyLiqZftSm1n2/FDnoClcTt9Qpb4smQ
         SkAxwVrMrVy+JO+ewopSvvmMTTLt4DWbu/TpalHGtKQgOt0+Ym71U1MLQBEDABmyYpPx
         7+nxu59KpjlP+RJo5WCKNTxXwNvmViSvLibjJn2vECICmALJb2FUl5EFg3PR4TTt4Rix
         Hy3ian7fkbUPXQnmzWXV45+3dHeJSDa42r79KZ+oz+1Xz671bws3FB/el+8BRGskxWsz
         y+8I6Y5QY8bO763UsXVtdz+aQw3l3Sf1k31URK9K0ihuXo8TdZDnWmOJ6HIN9rGz1dQx
         bdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773182753; x=1773787553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvcwGyyqhhK+9ujMD1DpAI6luR3guQH7bK6OSfrMLVU=;
        b=O9uIoMJlih2KijOMRSam46LB4O2ubZCvm+iUL23QiByXTsjMo7QvdReKlm3Z4Zt1o/
         xrpg0uWnvxBU1kHKXZX8ja9EEQDgaafhW54jCLum2w/gaXin4eZXpKwte0CqzdA/dv1X
         SwUHe5AO7+2cqg/rTCu1oWvBLu/iKY9xYG02PH+LUXA2D8S6wTbYxnkEj/nCWwRaXBzD
         XqnZQR7Tsqqf57jFAxVqftjmm8vprW5GllAEU7wiePWRyPAel4UCP1nxYhUJ4ija8JM0
         darYwi0+eKwBkKonufk35QaIE4C1znKR4EAIYI3vpLkpmpfkKCK59wSeJ4LqUMrqgMlE
         k97Q==
X-Gm-Message-State: AOJu0YwtaFKgxGL7oyrCzQtCCQSU8EsR19V6ZJj6YsS05K9aK+FzJ0k4
	HCqPS/9EaWMz+Qu4utbpoyRSBt0euElG/nc/tdADZGqIzYerv7Yz1WaiYmbNYn5kbsjPQSnBkEE
	aA91vvA==
X-Received: from pgbdp14.prod.google.com ([2002:a05:6a02:f0e:b0:c73:84bb:9d81])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e888:b0:2ae:467f:11d8
 with SMTP id d9443c01a7336-2aeae891e96mr3395745ad.30.1773182753192; Tue, 10
 Mar 2026 15:45:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 15:45:46 -0700
In-Reply-To: <20260310224546.2582118-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310224546.2582118-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310224546.2582118-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: x86: Suppress WARNs on nested_run_pending after
 userspace exit
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

To end an ongoing game of whack-a-mole between KVM and syzkaller, WARN on
illegally cancelling a pending nested VM-Enter if and only if userspace
has NOT gained control of the vCPU since the nested run was initiated.  As
proven time and time again by syzkaller, userspace can clobber vCPU state
so as to force a VM-Exit that violates KVM's architectural modelling of
VMRUN/VMLAUNCH/VMRESUME.

To detect that userspace has gained control, while minimizing the risk of
operating on stale data, convert nested_run_pending from a pure boolean to
a tri-state of sorts, where '0' is still "not pending", '1' is "pending",
and '2' is "pending but untrusted".  Then on KVM_RUN, if the flag is in
the "trusted pending" state, move it to "untrusted pending".

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  8 +++++++-
 arch/x86/kvm/svm/nested.c       | 11 +++++++----
 arch/x86/kvm/svm/svm.c          |  2 +-
 arch/x86/kvm/vmx/nested.c       | 12 +++++++-----
 arch/x86/kvm/vmx/vmx.c          |  2 +-
 arch/x86/kvm/x86.c              |  7 +++++++
 arch/x86/kvm/x86.h              | 10 ++++++++++
 7 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index a1bf0aaedad8..acec03d7bb1e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1105,8 +1105,14 @@ struct kvm_vcpu_arch {
 	 * can only occur at instruction boundaries.  The only exception is
 	 * VMX's "notify" exits, which exist in large part to break the CPU out
 	 * of infinite ucode loops, but can corrupt vCPU state in the process!
+	 *
+	 * For all intents and purposes, this is a boolean, but it's tracked as
+	 * a u8 so that KVM can detect when userspace may have stuffed vCPU
+	 * state and generated an architecturally-impossible VM-Exit.
 	 */
-	bool nested_run_pending;
+#define KVM_NESTED_RUN_PENDING			1
+#define KVM_NESTED_RUN_PENDING_UNTRUSTED	2
+	u8 nested_run_pending;
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	hpa_t hv_root_tdp;
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 782d6a34d173..af741823c08c 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1131,7 +1131,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	if (!npt_enabled)
 		vmcb01->save.cr3 = kvm_read_cr3(vcpu);
 
-	vcpu->arch.nested_run_pending = 1;
+	vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING;
 
 	if (enter_svm_guest_mode(vcpu, vmcb12_gpa, true) ||
 	    !nested_svm_merge_msrpm(vcpu)) {
@@ -1277,7 +1277,8 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	/* Exit Guest-Mode */
 	leave_guest_mode(vcpu);
 	svm->nested.vmcb12_gpa = 0;
-	WARN_ON_ONCE(vcpu->arch.nested_run_pending);
+
+	kvm_warn_on_nested_run_pending(vcpu);
 
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 
@@ -1984,8 +1985,10 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 	svm_set_gif(svm, !!(kvm_state->flags & KVM_STATE_NESTED_GIF_SET));
 
-	vcpu->arch.nested_run_pending =
-		!!(kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING);
+	if (kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING)
+		vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING_UNTRUSTED;
+	else
+		vcpu->arch.nested_run_pending = 0;
 
 	svm->nested.vmcb12_gpa = kvm_state->hdr.svm.vmcb_pa;
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 112731515ee3..7de2c6621b98 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5035,7 +5035,7 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	if (ret)
 		goto unmap_save;
 
-	vcpu->arch.nested_run_pending = 1;
+	vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING;
 
 unmap_save:
 	kvm_vcpu_unmap(vcpu, &map_save);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 65e45cee871c..6a107025e7e2 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3844,7 +3844,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	 * We're finally done with prerequisite checking, and can start with
 	 * the nested entry.
 	 */
-	vcpu->arch.nested_run_pending = 1;
+	vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING;
 	vmx->nested.has_preemption_timer_deadline = false;
 	status = nested_vmx_enter_non_root_mode(vcpu, true);
 	if (unlikely(status != NVMX_VMENTRY_SUCCESS))
@@ -5056,7 +5056,7 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	vmx->nested.mtf_pending = false;
 
 	/* trying to cancel vmlaunch/vmresume is a bug */
-	WARN_ON_ONCE(vcpu->arch.nested_run_pending);
+	kvm_warn_on_nested_run_pending(vcpu);
 
 #ifdef CONFIG_KVM_HYPERV
 	if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
@@ -6679,7 +6679,7 @@ bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu)
 	unsigned long exit_qual;
 	u32 exit_intr_info;
 
-	WARN_ON_ONCE(vcpu->arch.nested_run_pending);
+	kvm_warn_on_nested_run_pending(vcpu);
 
 	/*
 	 * Late nested VM-Fail shares the same flow as nested VM-Exit since KVM
@@ -6987,8 +6987,10 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	if (!(kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE))
 		return 0;
 
-	vcpu->arch.nested_run_pending =
-		!!(kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING);
+	if (kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING)
+		vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING_UNTRUSTED;
+	else
+		vcpu->arch.nested_run_pending = 0;
 
 	vmx->nested.mtf_pending =
 		!!(kvm_state->flags & KVM_STATE_NESTED_MTF_PENDING);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0e7e0a17bb75..dbe0f234aefb 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8423,7 +8423,7 @@ int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 		if (ret)
 			return ret;
 
-		vcpu->arch.nested_run_pending = 1;
+		vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING;
 		vmx->nested.smm.guest_mode = false;
 	}
 	return 0;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 879cdeb6adde..cad16c83dcff 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12090,6 +12090,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	if (r <= 0)
 		goto out;
 
+	/*
+	 * If userspace may have modified vCPU state, mark nested_run_pending
+	 * as "untrusted" to avoid triggering false-positive WARNs.
+	 */
+	if (vcpu->arch.nested_run_pending == KVM_NESTED_RUN_PENDING)
+		vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING_UNTRUSTED;
+
 	r = vcpu_run(vcpu);
 
 out:
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 44a28d343d40..38a905fa86de 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -188,6 +188,16 @@ static inline bool kvm_can_set_cpuid_and_feature_msrs(struct kvm_vcpu *vcpu)
 	return vcpu->arch.last_vmentry_cpu == -1 && !is_guest_mode(vcpu);
 }
 
+/*
+ * WARN if a nested VM-Enter is pending completion, and userspace hasn't gained
+ * control since the nested VM-Enter was initiated (in which case, userspace
+ * may have modified vCPU state to induce an architecturally invalid VM-Exit).
+ */
+static inline void kvm_warn_on_nested_run_pending(struct kvm_vcpu *vcpu)
+{
+	WARN_ON_ONCE(vcpu->arch.nested_run_pending == KVM_NESTED_RUN_PENDING);
+}
+
 static inline void kvm_set_mp_state(struct kvm_vcpu *vcpu, int mp_state)
 {
 	vcpu->arch.mp_state = mp_state;
-- 
2.53.0.473.g4a7958ca14-goog

