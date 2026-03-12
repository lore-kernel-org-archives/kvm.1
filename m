Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7993740B6C1
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773359311; cv=none; b=Z7zuaLh9tWt8kEiwgNm1L7geacwOUrpDnvtOuotTg6RQZ7MSRwdmtmnqMisv54fLuKUU1OoIkCbs9k0aobmE+IOVOnoMDLwwDPNuN7Xe1jAVOewzjkujjwFU1Apsl38J7VWPM3S38O1HVLsT/KfoU2BC8LkAm60as/6uCtCzg4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773359311; c=relaxed/simple;
	bh=nWrNYQUXBxTm5oZPEtXJCMnGAvaVQ0Eu6aCuoYIGmWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WPTJJeCbbCSjv4SSdVUrITvTKTW5wCDMA6HUPzeZ+TG3Y6KPx0W7svtPL0SuQ+sPL5eTWf8kUK2W1dHxPbEy1OBKHedzbTGwYfmx7iqvY2zmSYVuJOUuSFfdMN5xw79gWdbY8pdK3BxFOg6N3hdij5eirEUxO2fJ1EdslB5uPdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K2KK0Ep+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2KK0Ep+"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-829ad972df6so736153b3a.3
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 16:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773359310; x=1773964110; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MYMlw2sXfHvfmX6PqA/4gbE8rSqfn6oPTQyI55AKxEE=;
        b=K2KK0Ep+b6aqxRyb1XKBaeirwRpF1Z0dzffDSiWZOTZueabU2eHq6invnnIV2sAzPk
         UdvqXlft1YnIC76jc6x/VCqUi9vfeIfA6aC1t4ltTg6qdGQRAbnqcAq7d00BQdVVVWnL
         hMzmh7t8ELRZmsgmaQD5UPfvS4ac4npIZ5Zd6VP2WOGHvLF4Gvh3mxIwGxNT4SvtuUbN
         E/yJV47c9yMwz5WHJdZVuTJpwYBK30W4T5Oh1iRKZ402QM63/1btDNuVoNF5ASRxB6Cd
         Av5FbBHAad365XArBsbV5oDN4QUQVN4fm+hRmb/vSbuHISXK67zfIYgMkwgZxQrroENs
         LBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773359310; x=1773964110;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYMlw2sXfHvfmX6PqA/4gbE8rSqfn6oPTQyI55AKxEE=;
        b=mvjPeJkp7qxNCOsWRVyKvbThxP8GgxiUg0rmFmxp++cY69BGDS4N64bQFTcLxLC+ci
         lCBYYnWc8D8CEUvjHt+DAWvZeRZe9jqRb3hUx6Cw68DujW5AGjxQCMXv4oXB7laXhnOL
         UGEIa9SNcEQq+hwGHRudJlKetDDxpIXMkmvJg//RePb2Bhskms9290B4zqnmyWN1KOu5
         W4XSFbnZdcaatYlWuk6ZSjUmi81OsZcltq4DUmew11qZZLNwuHmig9Ub4Us+wWAjUlzN
         2ApWFfIprzKq3ADiRzzKSTxdFqNFj5Y57Zuu4Hkdfd7tCdlf/wFeYceoOw36A7Y5Q28r
         vQUg==
X-Gm-Message-State: AOJu0YzXKKZJqEHGU8COFUlRSyZGt09JOcu4VwW+X7MICM+K3iXBXn6Z
	ZbGxdKHM4CPfwgAWkHAkywioeMhTr9+iZoD6DwKFNzW/p3VtNyZ1ljw4Ks2tWo6WUQLVAqa1Gck
	OC1i6rw==
X-Received: from pffk2.prod.google.com ([2002:aa7:88c2:0:b0:829:8105:53d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:22c4:b0:827:2f87:ac03
 with SMTP id d2e1a72fcca58-82a198fb8f3mr953998b3a.43.1773359309660; Thu, 12
 Mar 2026 16:48:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 12 Mar 2026 16:48:23 -0700
In-Reply-To: <20260312234823.3120658-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312234823.3120658-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312234823.3120658-3-seanjc@google.com>
Subject: [PATCH v2 2/2] KVM: x86: Suppress WARNs on nested_run_pending after
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

Note, moving the state to "untrusted" even if KVM_RUN is ultimately
rejected is a-ok, because for the "untrusted" state to matter, KVM must
get past kvm_x86_vcpu_pre_run() at some point for the vCPU.

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
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
index 45171b607cf2..c470e40a00aa 100644
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
index 1b0e0336ef11..3b6d75787f9f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1142,7 +1142,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	if (!npt_enabled)
 		vmcb01->save.cr3 = kvm_read_cr3(vcpu);
 
-	vcpu->arch.nested_run_pending = 1;
+	vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING;
 
 	if (enter_svm_guest_mode(vcpu, vmcb12_gpa, true) ||
 	    !nested_svm_merge_msrpm(vcpu)) {
@@ -1288,7 +1288,8 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	/* Exit Guest-Mode */
 	leave_guest_mode(vcpu);
 	svm->nested.vmcb12_gpa = 0;
-	WARN_ON_ONCE(vcpu->arch.nested_run_pending);
+
+	kvm_warn_on_nested_run_pending(vcpu);
 
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 
@@ -1995,8 +1996,10 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 	svm_set_gif(svm, !!(kvm_state->flags & KVM_STATE_NESTED_GIF_SET));
 
-	vcpu->arch.nested_run_pending =
-		!!(kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING);
+	if (kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING)
+		vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING_UNTRUSTED;
+	else
+		vcpu->arch.nested_run_pending = 0;
 
 	svm->nested.vmcb12_gpa = kvm_state->hdr.svm.vmcb_pa;
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ece115d47044..b4c27465bd53 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5028,7 +5028,7 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 		goto unmap_save;
 
 	ret = 0;
-	vcpu->arch.nested_run_pending = 1;
+	vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING;
 
 unmap_save:
 	kvm_vcpu_unmap(vcpu, &map_save);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index f1543a6ad524..3fe88f29be7a 100644
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
@@ -7008,8 +7008,10 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
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
index 6e4b12a5849c..a29896a9ef14 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8427,7 +8427,7 @@ int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 		if (ret != NVMX_VMENTRY_SUCCESS)
 			return 1;
 
-		vcpu->arch.nested_run_pending = 1;
+		vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING;
 		vmx->nested.smm.guest_mode = false;
 	}
 	return 0;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0b5d48e75b65..eec0bde5d3e5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11978,6 +11978,13 @@ static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
 
 static int kvm_x86_vcpu_pre_run(struct kvm_vcpu *vcpu)
 {
+	/*
+	 * Userspace may have modified vCPU state, mark nested_run_pending as
+	 * "untrusted" to avoid triggering false-positive WARNs.
+	 */
+	if (vcpu->arch.nested_run_pending == KVM_NESTED_RUN_PENDING)
+		vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING_UNTRUSTED;
+
 	/*
 	 * SIPI_RECEIVED is obsolete; KVM leaves the vCPU in Wait-For-SIPI and
 	 * tracks the pending SIPI separately.  SIPI_RECEIVED is still accepted
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
2.53.0.851.ga537e3e6e9-goog

