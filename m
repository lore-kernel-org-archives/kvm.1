Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113322541C
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199436; cv=none; b=XRcFGIzhWd/VujawrttJJKS4rnwGYO08GyJuaYGZLR7EUs9Eg/ZT5nIEwLCkXNiu7iOdyONZEARHrkkKGGvpQraI0ZS7alg7QcETyvyJXxvMMEx4n/GheS8BliNo0Jwmuhv0K4X1aDW29jMiNqKkv223beKREO/xW/HE1z55Qw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199436; c=relaxed/simple;
	bh=6SNl4U+qfn26QQkrIZSHw2sJCDD+Kh8WIX/o3q/orF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fMrixYbwirJ+q7Km/sjGJbeYnC4Ijo9W18UGIiMkiXqHS60GuEfyQlZuqjK5XFcc+JphrByoD/8W9KR4BSDqv0rFb1Fbt+5XIHqrJtV9TE3LHfa9e16gGGOlRvKMMvwGLLjOvU5AZ+TVeq3SaHygRkuTWjCsEmrpzzwwjFp0Y4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NbJQ0rfd; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NbJQ0rfd"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8485d853b08so8628261b3a.1
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785199434; x=1785804234; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nhn2022p8wreutm15T8HET+6w+X8oUh7j4uuntMQy/8=;
        b=NbJQ0rfdza5TsIKjwmEpVDpNGu2QsC2f6miQ4Obp4O7jWB+MdPbQ/JUD/F/9gaaySf
         Ei7hqfu2SFJtrUVqe00AxN7HlOcE6qvtm6eumv4rZg5mIYAltDu3EcHjZJqZzg0k/M0M
         oDE2IueWDsQ+XKRbKpecPmWz1M7VptJDdrvDgf4EvjIlr2oIWWBvwLIy5VnopbC5b0bE
         5vX//85elW56jxHW7AS7s0Z01EUmJmkFbrL1uMf7tmdosjVIPkUvYPe+OnJcpBgOqvRz
         x0alzR65Yxqc3L1+xmsdszla2sgtL+P28MSLL7/t7Xhv8E67IH9WWHnH6C14OmETBImB
         pjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785199434; x=1785804234;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nhn2022p8wreutm15T8HET+6w+X8oUh7j4uuntMQy/8=;
        b=WNAkEAlkCW7ch/29KdJBC1MEoeWl8bwQVo4d6l/WcXT5n3zFShyxU/DDnqUEKgBeuA
         SImRyDdwMkmCQoNGeF1WQPbNtceKsYa6TmhZQSI422xoIuCcQhFZE9Et0hWr1flslXIs
         qtI7wDVdf3zOuXFfkDNPKFk4uCyNHdXSDkd5gKsGz9kar0uXwNETpJ/o9EYW9apoLZ4j
         BGp3vIMSOhehtGfz44DqN4SO82JCGX7oNMK+qJ+BuClERt4c+1yacFgkqfHJH2XEUp3U
         /ZDFpEV354tow3i1yM7pUsp2Cq5JQ53qXTcWfnt34QQl50xgWsrV1FYa3zDORe7uRn5M
         lUyQ==
X-Gm-Message-State: AOJu0YwhV3nccMu6WPYJvlu7QPE+9RSG3y6I3UQ+aEIPxswKWc99p2Oq
	q9OtmAcg7WpNz0/TCu5I0K0hR299qM3tuu/Is4dqoktuJYUrgT64MmvoYTAnbVhJkgItfqr25wg
	Mh1Rn8A==
X-Received: from pfnf3.prod.google.com ([2002:aa7:82c3:0:b0:845:48ff:3362])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:914d:0:b0:848:2f84:72c
 with SMTP id d2e1a72fcca58-84e932d934emr153728b3a.63.1785199434112; Mon, 27
 Jul 2026 17:43:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 27 Jul 2026 17:43:46 -0700
In-Reply-To: <20260728004351.887076-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728004351.887076-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728004351.887076-2-seanjc@google.com>
Subject: [PATCH v4 1/6] KVM: x86: Extract VMX's unhandleable emulation check
 to common x86
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hao Zhang <zhanghao1@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"

Expose VMX's check for unhandleable emulation as its own kvm_x86_ops hook,
and move the actual pre-KVM_RUN check into common x86.  This will allow
sharing the core logic with KVM's RSM emulation without needed to add a
post-RSM hook, and is a step towards removing the .vcpu_pre_run() hook
entirely.

Alternatively, KVM could provide a post-RSM hook as mentioned, but pre/post
hooks tend to be unwieldy as the exact "timing" of the call often matters
greatly.  E.g. in this case, the call must slot in exactly between loading
guest state from SMRAM and the hack to force the vCPU out of L2 on SHUTDOWN.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  2 ++
 arch/x86/kvm/vmx/main.c            | 15 +++++++++++++--
 arch/x86/kvm/vmx/vmx.c             | 12 +-----------
 arch/x86/kvm/vmx/x86_ops.h         |  2 +-
 arch/x86/kvm/x86.c                 |  5 +++++
 6 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 5cb132eca3c3..e5b0458afc25 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -68,6 +68,7 @@ KVM_X86_OP(vcpu_run)
 KVM_X86_OP(handle_exit)
 KVM_X86_OP(skip_emulated_instruction)
 KVM_X86_OP_OPTIONAL(update_emulated_instruction)
+KVM_X86_OP_OPTIONAL_RET0(unhandleable_emulation_required)
 KVM_X86_OP(set_interrupt_shadow)
 KVM_X86_OP(get_interrupt_shadow)
 KVM_X86_OP(patch_hypercall)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7a258831616f..7e3cacb2df9b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1593,6 +1593,8 @@ struct kvm_x86_ops {
 		enum exit_fastpath_completion exit_fastpath);
 	int (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
 	void (*update_emulated_instruction)(struct kvm_vcpu *vcpu);
+	bool (*unhandleable_emulation_required)(struct kvm_vcpu *vcpu);
+
 	void (*set_interrupt_shadow)(struct kvm_vcpu *vcpu, int mask);
 	u32 (*get_interrupt_shadow)(struct kvm_vcpu *vcpu);
 	void (*patch_hypercall)(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 04f986e3d439..924a629c21e2 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -145,7 +145,7 @@ static int vt_vcpu_pre_run(struct kvm_vcpu *vcpu)
 	if (is_td_vcpu(vcpu))
 		return tdx_vcpu_pre_run(vcpu);
 
-	return vmx_vcpu_pre_run(vcpu);
+	return 1;
 }
 
 static fastpath_t vt_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
@@ -165,6 +165,16 @@ static int vt_handle_exit(struct kvm_vcpu *vcpu,
 	return vmx_handle_exit(vcpu, fastpath);
 }
 
+static bool vt_unhandleable_emulation_required(struct kvm_vcpu *vcpu)
+{
+	if (is_td_vcpu(vcpu)) {
+		WARN_ON_ONCE(to_vt(vcpu)->emulation_required);
+		return false;
+	}
+
+	return vmx_unhandleable_emulation_required(vcpu);
+}
+
 static int vt_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	if (unlikely(is_td_vcpu(vcpu)))
@@ -939,11 +949,12 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.flush_tlb_gva = vt_op(flush_tlb_gva),
 	.flush_tlb_guest = vt_op(flush_tlb_guest),
 
-	.vcpu_pre_run = vt_op(vcpu_pre_run),
+	.vcpu_pre_run = vt_op_tdx_only(vcpu_pre_run),
 	.vcpu_run = vt_op(vcpu_run),
 	.handle_exit = vt_op(handle_exit),
 	.skip_emulated_instruction = vmx_skip_emulated_instruction,
 	.update_emulated_instruction = vmx_update_emulated_instruction,
+	.unhandleable_emulation_required = vt_op(unhandleable_emulation_required),
 	.set_interrupt_shadow = vt_op(set_interrupt_shadow),
 	.get_interrupt_shadow = vt_op(get_interrupt_shadow),
 	.patch_hypercall = vt_op(patch_hypercall),
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e4b9ac7fed9f..76160adf8297 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6035,7 +6035,7 @@ static int handle_nmi_window(struct kvm_vcpu *vcpu)
  * with unsrestricted guest mode disabled) and KVM can't faithfully emulate the
  * current vCPU state.
  */
-static bool vmx_unhandleable_emulation_required(struct kvm_vcpu *vcpu)
+bool vmx_unhandleable_emulation_required(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -6110,16 +6110,6 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-int vmx_vcpu_pre_run(struct kvm_vcpu *vcpu)
-{
-	if (vmx_unhandleable_emulation_required(vcpu)) {
-		kvm_prepare_emulation_failure_exit(vcpu);
-		return 0;
-	}
-
-	return 1;
-}
-
 /*
  * Indicate a busy-waiting vcpu in spinlock. We do not enable the PAUSE
  * exiting, so only get here on cpu with PAUSE-Loop-Exiting.
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 409858074246..4d2dd88afe7f 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -21,7 +21,6 @@ int vmx_vm_init(struct kvm *kvm);
 void vmx_vm_destroy(struct kvm *kvm);
 int vmx_vcpu_precreate(struct kvm *kvm);
 int vmx_vcpu_create(struct kvm_vcpu *vcpu);
-int vmx_vcpu_pre_run(struct kvm_vcpu *vcpu);
 fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags);
 void vmx_vcpu_free(struct kvm_vcpu *vcpu);
 void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
@@ -31,6 +30,7 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath);
 void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu);
 int vmx_skip_emulated_instruction(struct kvm_vcpu *vcpu);
 void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu);
+bool vmx_unhandleable_emulation_required(struct kvm_vcpu *vcpu);
 int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
 #ifdef CONFIG_KVM_SMM
 int vmx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0f1a829032c0..64a13acc37be 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8867,6 +8867,11 @@ static int kvm_x86_vcpu_pre_run(struct kvm_vcpu *vcpu)
 	    !kvm_apic_init_sipi_allowed(vcpu))
 		return -EINVAL;
 
+	if (kvm_x86_call(unhandleable_emulation_required)(vcpu)) {
+		kvm_prepare_emulation_failure_exit(vcpu);
+		return 0;
+	}
+
 	return kvm_x86_call(vcpu_pre_run)(vcpu);
 }
 
-- 
2.55.0.229.g6434b31f56-goog

