Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E99F3F6C3C
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884014; cv=none; b=awnvGRSVESFXb6J62fgbAKiTbDXfFP++hXexSNC6dlNBwMR+47gtWe8uVfuXRji6s0uPgHFyi1qXDgLjDXe/faGQo49/uSEY4wpUl1V5igeaAB+nr8OPoGUB0mfe1FYsZCtAIT4lDmdkq0YEyi2cSBvkAn4Xi95iKcLcgWz6c1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884014; c=relaxed/simple;
	bh=c90x4WHZtR7+o6rsOgPAW2lJDgKJtgYmMh9gOe13CKU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UU7med53CxkcEPU1j+MvWZUUrm/iWh1Oxn0OxkN4DuOux+gLhulD8m6wlBnemkk0cSrehGW6B/Mf2eGxP9BGIP+fSDF4uVOYI7PDO0w5EaMUuBiDOeBo3m7rnjRBd4/GYrqtpIWx2zWqYZXdIpqwGbvA4e4VdHd9U5UYP6Wyho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AkvUy47i; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkvUy47i"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-368edd5fec4so272565a91.0
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778884005; x=1779488805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=O7BaysVjYfeQMwfIaz0v/GGnMbpQx9jR4E3VGys+xrI=;
        b=AkvUy47iTz5tzea0ZfGGq9GoyQqVe43/saEz0G4U5RplVTSOZZ95YNycsmJ/RvYPwJ
         HkS+f4sYC1hDXMgHGOyVO3dHVPXyHMPvEWVyBQ3hbvHw4Vu2bVmBy+qyY+VkBB+iL/B2
         PZUE6B95TWT4IVWg10bHVgSXnayyh0j19NSmNFDjTO5Kptyf00HCRtnMQqxu3BoQjQ5N
         hrSDBivrzpjXHcYCobZt4K6uchTJZ9kLC3bUNebjwVtacD7q8qo0thO4/amBN92/QW1x
         ZWRZTvlprr+wAEestVPF6mJ+7s91+1Aq6GmynMxIXNyDCG9fzb1R06tsslvrLBe4yljO
         Cyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884005; x=1779488805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7BaysVjYfeQMwfIaz0v/GGnMbpQx9jR4E3VGys+xrI=;
        b=VBrkszoqrG49iqN5J5SAv8hfbpqqV8WSf/PudRIcbR4HuGBr4Y7lBrHVZ02dLQCXik
         eGfkFFiISJLOoTFKTgRtNEVQUJQoPMQ1GliqDCNMhQGvc1cz55HQ/yuVZwO3tDmCTDJz
         ZarN/Hz659hdRg8hT7mU5dmeXyK/h1oeb9R0o2hfn2g1GdyCA1tlmF8DwXWW0yU+Jnl4
         Z/YHzMjG6qn1d+AKk8Mrh6EzKfJEDzaX208glwVgp2JSz7roGPbRBEdeQj6r7QclGDTK
         sFUbPZe7L7TXhzquFNFlbAqFkYjUVvl9wc0HUhRfp6Koc9OkXUexpBeLJnYURSCIDt8A
         DNMw==
X-Gm-Message-State: AOJu0YzVQ8l4rF2pidoAWAr6/1TGAuwzTLFLe00PFuQ6ROu1V9uhdD6P
	6Qq/s9qhOqpuF1HmAm0XeMeyMMRWVeLrLVMKWI/h0FcY2F9Y4iqJ/pt12GRNLpa/Pz7BMAN//LC
	C9LehsQ==
X-Received: from pjyl14.prod.google.com ([2002:a17:90a:ec0e:b0:366:4bcb:9926])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc5:b0:367:d9cb:fdb3
 with SMTP id 98e67ed59e1d1-36951b8a727mr6217367a91.24.1778884005210; Fri, 15
 May 2026 15:26:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 15:26:33 -0700
In-Reply-To: <20260515222638.1949982-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515222638.1949982-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515222638.1949982-6-seanjc@google.com>
Subject: [PATCH v3 05/10] KVM: x86: Honor KVM_GUESTDBG_USE_HW_BP when checking
 for code breakpoints in emulation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

From: Hou Wenlong <houwenlong.hwl@antgroup.com>

When KVM_GUESTDBG_USE_HW_BP is enabled, i.e. userspace is usurping the
guest's hardware debug registers, the guest's effective breakpoints are
controlled by userspace rather than by the guest itself.  Honor the
KVM_GUESTDBG_USE_HW_BP behavior when handling code #DBs in the emulator so
that userspace (and the guest) gets consistent behavior for code #DBs
regardless of whether an instruction is executed natively or emulated by
KVM.

To aid in userspace debug, don't treat code breakpoints as inhibited if
KVM_GUESTDBG_USE_HW_BP is enabled as accurately emulating x86 architecture
is obviously a non-goal of guest-debug.

Fixes: 4a1e10d5b5d8 ("KVM: x86: handle hardware breakpoints during emulation")
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8b07bd2f8310..279e2734e088 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9319,6 +9319,9 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_skip_emulated_instruction);
 
 static bool kvm_is_code_breakpoint_inhibited(struct kvm_vcpu *vcpu)
 {
+	if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP)
+		return false;
+
 	if (kvm_get_rflags(vcpu) & X86_EFLAGS_RF)
 		return true;
 
@@ -9335,6 +9338,8 @@ static bool kvm_is_code_breakpoint_inhibited(struct kvm_vcpu *vcpu)
 static bool kvm_vcpu_check_code_breakpoint(struct kvm_vcpu *vcpu,
 					   int emulation_type, int *r)
 {
+	unsigned long dr7 = kvm_get_eff_dr7(vcpu);
+
 	WARN_ON_ONCE(emulation_type & EMULTYPE_NO_DECODE);
 
 	/*
@@ -9355,34 +9360,14 @@ static bool kvm_vcpu_check_code_breakpoint(struct kvm_vcpu *vcpu,
 			      EMULTYPE_TRAP_UD | EMULTYPE_VMWARE_GP | EMULTYPE_PF))
 		return false;
 
-	if (unlikely(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) &&
-	    (vcpu->arch.guest_debug_dr7 & DR7_BP_EN_MASK)) {
-		struct kvm_run *kvm_run = vcpu->run;
-		unsigned long eip = kvm_get_linear_rip(vcpu);
-		u32 dr6 = kvm_vcpu_check_hw_bp(eip, 0,
-					   vcpu->arch.guest_debug_dr7,
-					   vcpu->arch.eff_db);
-
-		if (dr6 != 0) {
-			kvm_run->debug.arch.dr6 = dr6 | DR6_ACTIVE_LOW;
-			kvm_run->debug.arch.pc = eip;
-			kvm_run->debug.arch.exception = DB_VECTOR;
-			kvm_run->exit_reason = KVM_EXIT_DEBUG;
-			*r = 0;
-			return true;
-		}
-	}
-
-	if (unlikely(vcpu->arch.dr7 & DR7_BP_EN_MASK) &&
+	if (unlikely(dr7 & DR7_BP_EN_MASK) &&
 	    !kvm_is_code_breakpoint_inhibited(vcpu)) {
 		unsigned long eip = kvm_get_linear_rip(vcpu);
-		u32 dr6 = kvm_vcpu_check_hw_bp(eip, 0,
-					   vcpu->arch.dr7,
-					   vcpu->arch.db);
+		u32 dr6 = kvm_vcpu_check_hw_bp(eip, 0, dr7,
+					       vcpu->arch.eff_db);
 
-		if (dr6 != 0) {
-			kvm_queue_exception_p(vcpu, DB_VECTOR, dr6);
-			*r = 1;
+		if (dr6) {
+			*r = kvm_inject_emulated_db(vcpu, dr6);
 			return true;
 		}
 	}
-- 
2.54.0.563.g4f69b47b94-goog

