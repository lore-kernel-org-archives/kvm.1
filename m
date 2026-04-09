Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EB43A7829
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 23:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775779001; cv=none; b=HgN2h7DVGNMgcI4cJB5h4hetKBNG8+3VQkFcjLb6YN7wNSBpP582jYszTwaqOPbEY1EBsglkSDGoM0GV/TYZT1eiW8sMZ47XCPZtTG2chljZaFChGD85dz2c4G1Ma1rClenJxtgb7XCtYqYhCqR3OZYZtVr/Qs0MwJjNS+N9Lnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775779001; c=relaxed/simple;
	bh=+5QpnxTBwVInguL/nhjo7yXwCMf5DULJkbko4IIc/+M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gdGMjGfI+JaSoh9Vl/7d9loft65aKctfB2KpOuLTcOx9mp73KryF9sKHQHdU3VF0brDwB9dI8KM2ezESiXFf1hK1PfC2jA+zUVh4zU8+lTxjF97BFyqW7HEZ6XfYSbnKlOlGcdrtvuQmzfNGQ30z29ie9ILPAMkuPQWGCHejbK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EU/Qg8bl; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EU/Qg8bl"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35da4795b3cso3072648a91.2
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 16:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775778999; x=1776383799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ttUh2KhN7CXmhSvaYMBsDwgZt2H2PSQukJWLI3+IG4M=;
        b=EU/Qg8blGtuDkWISxbWwlkKfmaFYCJtvzkCi9Um9h7R+XtAgu00CN6V9ifkQ7VD9Df
         pe/SIpOUlN9dqali0kg10MnvGFz8d1qOCuC9yltkUqVCLYx5S3PmclJ2mZG5kiDYqwdd
         T6TqjoR93rPA9VL4yNpzZt4NeKELPCedMODPNSU8aUHFB2btwUDL1gJ60qfZpcjwTrdY
         OIx4KYUbkYiwm/wJEBGY/Tdjg26Ia0y8dVp6T+GbipEEiiSn+sBBEsmsko8lD1Ccku1V
         2UmIe94HedfogRj1WRMxvuv5m0dHz3Z01creYwSbY4nV8T4V5H1j+7p2QFChh+YweUEf
         Q8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775778999; x=1776383799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttUh2KhN7CXmhSvaYMBsDwgZt2H2PSQukJWLI3+IG4M=;
        b=HehOT9zf6rkHtQSbO7shC4oHS4P3IN+gln8UhZyycvt87RkI7aoHhLaISEKU0x6uFe
         KGH5Ihe2f8PKZ69gQxKDdigav2ZTQaDlMsgyqaoYF5oHT5gSvCF6mL0r/8EeVsEAQGyb
         YDrIDUojMbufkL8+GGxt6aWzhuW+ebCDmVzeH/2pFZ08+QZPvglua5yiBxnYhwy0hptP
         V7HExpRT7L2uP4/vxu5RM/zjU2aBH1yUAx0PQw04Jj/j9wSnV0hNHJN5eIf99AcRrZcJ
         b8eWOJ/x1GrrpUe8Qk244wUvz3sqo4RYUSJTc5xHJtFb0wmF78lqLRqDXFvv1SjWfaFh
         0M1w==
X-Gm-Message-State: AOJu0Yyeky8sZqHsJK69sJ/M+i8iYbAggau8gy8nC6xfDwWTkuMd2t0D
	W7FAM5Q7UDO8+QhS7YRnLyFUwomv3luP3Th7nifjDZI2hXMZEge0sM7koHkhcqZCvn+3uW26UXb
	AD33d+g==
X-Received: from pjbgo13.prod.google.com ([2002:a17:90b:3cd:b0:35c:2ccd:436b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c0e:b0:35d:974d:8f7
 with SMTP id 98e67ed59e1d1-35e4274696bmr932062a91.1.1775778999175; Thu, 09
 Apr 2026 16:56:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 16:56:17 -0700
In-Reply-To: <20260409235622.2052730-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409235622.2052730-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409235622.2052730-7-seanjc@google.com>
Subject: [PATCH 06/11] KVM: x86: Move kvm_<reg>_{read,write}() definitions to x86.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Move the direct GPR accessors to x86.h so that they can use
is_64_bit_mode().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/kvm_cache_regs.h | 34 ----------------------------------
 arch/x86/kvm/x86.h            | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 8ddb01191d6f..efa23ed5b5d4 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -16,34 +16,6 @@
 
 static_assert(!(KVM_POSSIBLE_CR0_GUEST_BITS & X86_CR0_PDPTR_BITS));
 
-#define BUILD_KVM_GPR_ACCESSORS(lname, uname)				      \
-static __always_inline unsigned long kvm_##lname##_read(struct kvm_vcpu *vcpu)\
-{									      \
-	return vcpu->arch.regs[VCPU_REGS_##uname];			      \
-}									      \
-static __always_inline void kvm_##lname##_write(struct kvm_vcpu *vcpu,	      \
-						unsigned long val)	      \
-{									      \
-	vcpu->arch.regs[VCPU_REGS_##uname] = val;			      \
-}
-BUILD_KVM_GPR_ACCESSORS(rax, RAX)
-BUILD_KVM_GPR_ACCESSORS(rbx, RBX)
-BUILD_KVM_GPR_ACCESSORS(rcx, RCX)
-BUILD_KVM_GPR_ACCESSORS(rdx, RDX)
-BUILD_KVM_GPR_ACCESSORS(rbp, RBP)
-BUILD_KVM_GPR_ACCESSORS(rsi, RSI)
-BUILD_KVM_GPR_ACCESSORS(rdi, RDI)
-#ifdef CONFIG_X86_64
-BUILD_KVM_GPR_ACCESSORS(r8,  R8)
-BUILD_KVM_GPR_ACCESSORS(r9,  R9)
-BUILD_KVM_GPR_ACCESSORS(r10, R10)
-BUILD_KVM_GPR_ACCESSORS(r11, R11)
-BUILD_KVM_GPR_ACCESSORS(r12, R12)
-BUILD_KVM_GPR_ACCESSORS(r13, R13)
-BUILD_KVM_GPR_ACCESSORS(r14, R14)
-BUILD_KVM_GPR_ACCESSORS(r15, R15)
-#endif
-
 /*
  * Using the register cache from interrupt context is generally not allowed, as
  * caching a register and marking it available/dirty can't be done atomically,
@@ -217,12 +189,6 @@ static inline ulong kvm_read_cr4(struct kvm_vcpu *vcpu)
 	return kvm_read_cr4_bits(vcpu, ~0UL);
 }
 
-static inline u64 kvm_read_edx_eax(struct kvm_vcpu *vcpu)
-{
-	return (kvm_rax_read(vcpu) & -1u)
-		| ((u64)(kvm_rdx_read(vcpu) & -1u) << 32);
-}
-
 static inline void enter_guest_mode(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.hflags |= HF_GUEST_MASK;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 38a905fa86de..c44154ed3f26 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -421,6 +421,40 @@ static inline bool vcpu_match_mmio_gpa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	return false;
 }
 
+#define BUILD_KVM_GPR_ACCESSORS(lname, uname)				      \
+static __always_inline unsigned long kvm_##lname##_read(struct kvm_vcpu *vcpu)\
+{									      \
+	return vcpu->arch.regs[VCPU_REGS_##uname];			      \
+}									      \
+static __always_inline void kvm_##lname##_write(struct kvm_vcpu *vcpu,	      \
+						unsigned long val)	      \
+{									      \
+	vcpu->arch.regs[VCPU_REGS_##uname] = val;			      \
+}
+BUILD_KVM_GPR_ACCESSORS(rax, RAX)
+BUILD_KVM_GPR_ACCESSORS(rbx, RBX)
+BUILD_KVM_GPR_ACCESSORS(rcx, RCX)
+BUILD_KVM_GPR_ACCESSORS(rdx, RDX)
+BUILD_KVM_GPR_ACCESSORS(rbp, RBP)
+BUILD_KVM_GPR_ACCESSORS(rsi, RSI)
+BUILD_KVM_GPR_ACCESSORS(rdi, RDI)
+#ifdef CONFIG_X86_64
+BUILD_KVM_GPR_ACCESSORS(r8,  R8)
+BUILD_KVM_GPR_ACCESSORS(r9,  R9)
+BUILD_KVM_GPR_ACCESSORS(r10, R10)
+BUILD_KVM_GPR_ACCESSORS(r11, R11)
+BUILD_KVM_GPR_ACCESSORS(r12, R12)
+BUILD_KVM_GPR_ACCESSORS(r13, R13)
+BUILD_KVM_GPR_ACCESSORS(r14, R14)
+BUILD_KVM_GPR_ACCESSORS(r15, R15)
+#endif
+
+static inline u64 kvm_read_edx_eax(struct kvm_vcpu *vcpu)
+{
+	return (kvm_rax_read(vcpu) & -1u)
+		| ((u64)(kvm_rdx_read(vcpu) & -1u) << 32);
+}
+
 static inline unsigned long kvm_register_read(struct kvm_vcpu *vcpu, int reg)
 {
 	unsigned long val = kvm_register_read_raw(vcpu, reg);
-- 
2.53.0.1213.gd9a14994de-goog

