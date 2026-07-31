Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383754503EC
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519228; cv=none; b=DxPG7bGTYqW2q9zqlhjVXp2aVC+NYRGYfYgyyBBcxf+P/PI8gm4GAeB9Z9spgrdsh0SExcfQTDTGzYxOUCT3n9X66Yq4EnS7MStTunjpsspmMMRyPxiBHD3EC/IenbQVwC2nk3QyAzE0hYfqfqrXn9zgXyUlBfqHT5vrMxF4Yh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519228; c=relaxed/simple;
	bh=5/bWgPygioIqyXafHXY0g1HD0/B9s0wgc+X6hvzcTMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i3NNqXe1njAmKbXyi4RG4kjplDcAdI1Y75L5z26M+mQ7bvnHar9u5SpwuGv77vVf8k9ZkxKlwkKjAmONw9qKqV+M2S0TNlA+o37bcc9+L2yM9L5R30DxKHRxv1Z5r+iVBv4UxkwYAj5eMbPTu3nZk/UbGyolX8tTJibKlaNXHjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HX4cn4RQ; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HX4cn4RQ"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so1942140a91.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785519224; x=1786124024; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CoH/ougIGF6yi6WPwn21nwpYwq87thgO5YofxYPMUck=;
        b=HX4cn4RQ4H8mnHJ6W0/x6HP9QlAFtJzU6J2kuJ0lQ9TU9wQ97Rv8ZQcoevROGUFlEY
         MYakoLh0ED6uS3YcltSZgtS9Ksg4+i/bIQVY7JQuo49LaRbo8lyO7ICxvoL2vg6xUQtS
         mwpni94b5K6HxKMgn6tDoQ+VNYkokVuec2MVjEptogY7bPfA5+HBS9OZ4LVX7KuMP0aL
         r5qmy7PyktO5tn5u42wLmc1wSeP54rTgfrrpMQ7W10luOL+7rm8VSYe6tRGKi66Mnl7O
         PVIXJcOrKYrtZsmIIFB8CNrO5/vVU1RDwz6gjmRmQmDMg3svpQXSecPy8O93tZwEVBSk
         ke/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785519224; x=1786124024;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CoH/ougIGF6yi6WPwn21nwpYwq87thgO5YofxYPMUck=;
        b=jXcljsCf31F3m1/jj5KQ1x38eOmpghv1JnZX2X2e3X/PO1BcjWq9OLdguoubA234ts
         SY11hr+8pmklev6JWhqIieJoRoS+gEzU2mKyDf/78RP9Z5OvkUsiQ7PU4gESd8k83Ozo
         ppujxpDNdPOjcJklyNnALUpRZbnDe1LswZ6MwYcsonieda+uaJ2oRj6oyZgH/RTVpwao
         kCm2fELFumB6rSVASKzSy7a2ViIMpVcm3eVDsMDvbELn+1dR/0zjZtp+eVbWatC2Dajp
         GIP5HmBoGM5aeu1fCU9BpVVa83wIi7aIP4dyaliCVl2wQ6LRCJEVY9Yol/FxQeREqELY
         KuOQ==
X-Gm-Message-State: AOJu0YwDoQZlmzbF9NIca22yr/t4W70nEU6WjxhdM4wGwY0gsmcreckd
	/DOHyPDYAGvI1Y7Swnjs/8Fg3JWdjpAlBl/mM20WHwC59O5emDvI4tw3YI87JPUKkFTSnghSxOF
	wOL1FMw==
X-Received: from pjbnp18.prod.google.com ([2002:a17:90b:4c52:b0:38f:245:21b7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d445:b0:38e:5717:9cc8
 with SMTP id 98e67ed59e1d1-38fbc56c639mr595891a91.31.1785519223409; Fri, 31
 Jul 2026 10:33:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:33:35 -0700
In-Reply-To: <20260731173340.2644656-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731173340.2644656-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731173340.2644656-2-seanjc@google.com>
Subject: [PATCH v5 1/6] KVM: x86: Extract VMX's unhandleable emulation check
 to common x86
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hao Zhang <zhanghao1@kylinos.cn>, Hao Zhang <hao_zhang_kdev@163.com>
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
 arch/x86/kvm/vmx/main.c            | 11 +++++++++++
 arch/x86/kvm/vmx/vmx.c             |  7 +------
 arch/x86/kvm/vmx/x86_ops.h         |  1 +
 arch/x86/kvm/x86.c                 |  5 +++++
 6 files changed, 21 insertions(+), 6 deletions(-)

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
index 04f986e3d439..2a69dc3ac690 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
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
@@ -944,6 +954,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.handle_exit = vt_op(handle_exit),
 	.skip_emulated_instruction = vmx_skip_emulated_instruction,
 	.update_emulated_instruction = vmx_update_emulated_instruction,
+	.unhandleable_emulation_required = vt_op(unhandleable_emulation_required),
 	.set_interrupt_shadow = vt_op(set_interrupt_shadow),
 	.get_interrupt_shadow = vt_op(get_interrupt_shadow),
 	.patch_hypercall = vt_op(patch_hypercall),
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e4b9ac7fed9f..2337b7ede290 100644
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
 
@@ -6112,11 +6112,6 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 
 int vmx_vcpu_pre_run(struct kvm_vcpu *vcpu)
 {
-	if (vmx_unhandleable_emulation_required(vcpu)) {
-		kvm_prepare_emulation_failure_exit(vcpu);
-		return 0;
-	}
-
 	return 1;
 }
 
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 409858074246..551b4195bc1b 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -31,6 +31,7 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath);
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
2.55.0.508.g3f0d502094-goog

