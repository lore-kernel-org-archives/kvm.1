Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80373890F3
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712394; cv=none; b=Rmtd44/PeFBQBDvtaYcUfy9cQAbC5pdcFE+zgb8fSDqpR8gMGo/0vw6Jbk5Ph77GXC2gBY0iY3Di7yLJBdLoZ4N2ORtajYYPUVrwjje/p3DKyrGHSQ5u9+KK0W0qfogupGop3N+hJpEoXF5CssGP0lDCHMgNG0mhr156I6ZazSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712394; c=relaxed/simple;
	bh=TsWC0ET4/TTTZpeKufKAYDUSKiijDOZz/NUXPah0mYs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h9rQk10GVi6gWW8W/2Go5V/WZo5Qrw/O8OTKBIBco3n2hlwSRC3AEmRBfFV3kqB75/fp/89W4dCLOk/AgNd9QOKZCJ74Y6isw5E84EzcYV6pVJ6aM2yiTbgPRSkpBh4hoemHoyp2LtyRU51aSBGFhyTElqQ5HyX/TEroSE1o3ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mLr5p90l; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mLr5p90l"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba6fe41283so82892585ad.1
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 15:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778712391; x=1779317191; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3g3SaFXHY3K+SPEAZURdBPeWggmHxUXUovXGkSt9CYM=;
        b=mLr5p90lBGE8k5u1pb2IiJzyoQJ3/UDThu4YlyjUXM3yz3pM+hfetLwso4H1IHuWY4
         27E59erQWoXIcL+8bEXUygVdN6hHAZABwGIVkqCeSTcXok3i00FYIxmV7yq5F5Gkl4ox
         yYaNdTS5SAHpS0SENDybTKXuw5U0b0O7ZEeos8J7cEExNBCc2kzpyjtN39ICWm7p+Srx
         lNoHyhUF5tF85DJQmahgSV50kzjV4366OLSEQO8lTgBoIXfZTzatX41VLJ58f/9yBju0
         zgYf30tNUZcwg6s1FAy9nY97SIVuAHvhlrydnGqJ4tI4lYjVAni2LVjLwJxGwdrN4YFr
         dcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778712391; x=1779317191;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3g3SaFXHY3K+SPEAZURdBPeWggmHxUXUovXGkSt9CYM=;
        b=S8LE1VTL1mXwJneNIZ6rJIYhKWy6uNx7rEO1+MPeWeVGVuqQ7v24V2G9lrol0gjCB9
         dOGN/M5/DzE8fDqYI9fPR3Tf1A7gmiYd5j7DfVUeuj2tBIZiO/rSEZ4Qx+jmQ0T838fN
         bLFfevtvwTDUwQZSfSOE+QEWDZdC6XuY7uVyzVvnkjglD0gWMDtYJOkSfjvnDqbA3Dhs
         96F08YE6IfYiuo2hHauE3BEVCFQVjmNvm/FF0UM6yo3s1SW4fv4sBJ05F5fTp4DraD1E
         AgMj0l8FX+FOtYeK049KBSvyKKndYcF5G8Ukcqhlgiq9lwK/BD5oQHUlcDrg/14XegOC
         VgQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+H2JHK0ChJLUjF+BrC27fxcXLiLZVzpSaQRnVTYvuwBYYgPGeZAQzYWHJGVWVRqWTFn4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YztGvL/3LPMQC3L82BaqFbksnhsqlDDJrTnuvXrabZfhOIpTop3
	7qPGjjY06cLnY40Ob6iU4QFIMyjOClUGndPH/gwPm65W/Rfm6svRbjAhhSRv1WYbdt4e8Fq+u7T
	bKAFMK8aX5MBavg==
X-Received: from plbjw10.prod.google.com ([2002:a17:903:278a:b0:2bd:2c15:348])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:9cf:b0:2b4:65d8:6a20 with SMTP id d9443c01a7336-2bd2f4cc122mr46800755ad.2.1778712390818;
 Wed, 13 May 2026 15:46:30 -0700 (PDT)
Date: Wed, 13 May 2026 15:46:04 -0700
In-Reply-To: <20260513224608.1859737-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513224608.1859737-1-jmattson@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260513224608.1859737-2-jmattson@google.com>
Subject: [PATCH v3 1/4] KVM: x86: Consolidate CPUID fault handling for
 emulator and interception logic
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ctpence@google.com
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Extract the logic for emulating CPUID faulting (where CPUID #GPs at CPL>0
outside of SMM) into a dedicated helper and use the helper for both the
full emulator and the intercepted-CPUID paths.

Opportunistically drop kvm_require_cpl(), as kvm_require_cpl() was the one
and only user.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/cpuid.c            |  5 +++--
 arch/x86/kvm/cpuid.h            |  8 ++++++++
 arch/x86/kvm/emulate.c          |  6 +-----
 arch/x86/kvm/kvm_emulate.h      |  1 +
 arch/x86/kvm/x86.c              | 18 ++++++------------
 6 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c470e40a00aa..a9005c61619b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2285,7 +2285,6 @@ void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault);
 void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 				    struct x86_exception *fault);
-bool kvm_require_cpl(struct kvm_vcpu *vcpu, int required_cpl);
 bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr);
 
 static inline int __kvm_irq_line_state(unsigned long *irq_state,
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e69156b54cff..1c95d1fa3ead 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -2161,9 +2161,10 @@ int kvm_emulate_cpuid(struct kvm_vcpu *vcpu)
 {
 	u32 eax, ebx, ecx, edx;
 
-	if (!is_smm(vcpu) && cpuid_fault_enabled(vcpu) &&
-	    !kvm_require_cpl(vcpu, 0))
+	if (!kvm_is_cpuid_allowed(vcpu)) {
+		kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
 		return 1;
+	}
 
 	eax = kvm_rax_read(vcpu);
 	ecx = kvm_rcx_read(vcpu);
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 039b8e6f40ba..bc4a8428b836 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -7,6 +7,8 @@
 #include <asm/processor.h>
 #include <uapi/asm/kvm_para.h>
 
+#include "smm.h"
+
 extern u32 kvm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
 extern bool kvm_is_configuring_cpu_caps __read_mostly;
 
@@ -192,6 +194,12 @@ static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
 		  MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
 }
 
+static inline bool kvm_is_cpuid_allowed(struct kvm_vcpu *vcpu)
+{
+	return !cpuid_fault_enabled(vcpu) || is_smm(vcpu) ||
+	       !kvm_x86_call(get_cpl)(vcpu);
+}
+
 static __always_inline void kvm_cpu_cap_clear(unsigned int x86_feature)
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c8c6cc0406d6..3ba09093b5ab 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3593,12 +3593,8 @@ static int em_sti(struct x86_emulate_ctxt *ctxt)
 static int em_cpuid(struct x86_emulate_ctxt *ctxt)
 {
 	u32 eax, ebx, ecx, edx;
-	u64 msr = 0;
 
-	ctxt->ops->get_msr(ctxt, MSR_MISC_FEATURES_ENABLES, &msr);
-	if (!ctxt->ops->is_smm(ctxt) &&
-	    (msr & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) &&
-	    ctxt->ops->cpl(ctxt))
+	if (!ctxt->ops->is_cpuid_allowed(ctxt))
 		return emulate_gp(ctxt, 0);
 
 	eax = reg_read(ctxt, VCPU_REGS_RAX);
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 0abff36d0994..45d4a03b202e 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -225,6 +225,7 @@ struct x86_emulate_ops {
 			 struct x86_instruction_info *info,
 			 enum x86_intercept_stage stage);
 
+	bool (*is_cpuid_allowed)(struct x86_emulate_ctxt *ctxt);
 	bool (*get_cpuid)(struct x86_emulate_ctxt *ctxt, u32 *eax, u32 *ebx,
 			  u32 *ecx, u32 *edx, bool exact_only);
 	bool (*guest_has_movbe)(struct x86_emulate_ctxt *ctxt);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..01c6b18d1fe5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1021,18 +1021,6 @@ void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_queue_exception_e);
 
-/*
- * Checks if cpl <= required_cpl; if true, return true.  Otherwise queue
- * a #GP and return false.
- */
-bool kvm_require_cpl(struct kvm_vcpu *vcpu, int required_cpl)
-{
-	if (kvm_x86_call(get_cpl)(vcpu) <= required_cpl)
-		return true;
-	kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
-	return false;
-}
-
 bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr)
 {
 	if ((dr != 4 && dr != 5) || !kvm_is_cr4_bit_set(vcpu, X86_CR4_DE))
@@ -8819,6 +8807,11 @@ static int emulator_intercept(struct x86_emulate_ctxt *ctxt,
 					     &ctxt->exception);
 }
 
+static bool emulator_is_cpuid_allowed(struct x86_emulate_ctxt *ctxt)
+{
+	return kvm_is_cpuid_allowed(emul_to_vcpu(ctxt));
+}
+
 static bool emulator_get_cpuid(struct x86_emulate_ctxt *ctxt,
 			      u32 *eax, u32 *ebx, u32 *ecx, u32 *edx,
 			      bool exact_only)
@@ -8955,6 +8948,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.wbinvd              = emulator_wbinvd,
 	.fix_hypercall       = emulator_fix_hypercall,
 	.intercept           = emulator_intercept,
+	.is_cpuid_allowed    = emulator_is_cpuid_allowed,
 	.get_cpuid           = emulator_get_cpuid,
 	.guest_has_movbe     = emulator_guest_has_movbe,
 	.guest_has_fxsr      = emulator_guest_has_fxsr,
-- 
2.54.0.631.ge1b05301d1-goog

