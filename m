Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B9335BA
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781051435; cv=none; b=O0QaHCdX1XI+ob8Xswh6JFkMd+2g2/hNTKoA8boYDzlfMr7yavgFvxrr5sjcCOT49+szsHsHgMyoP7/46WgHqs7nr/zc5EyhB4+iTDM82sqKLtmtsV97NQOq4uIEJFpi5wQoRjK+APju5/sm0U8KqDN+YXHw/0pZsSM3lK4Je0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781051435; c=relaxed/simple;
	bh=JhITAjbEXL61jBsabwwqBTvuTP7jx4PZiaHnLoKzjsY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h/+UQd+wbbh+5Eu4GknTLdFqvGnrt/ixSf3EAZpH2ljBdY2iIVnGqeC9ZjTA0agRBBObjB9JDyMBf1ssdyeMVdMnLr6Cl4mjcNAvgaj+Zy5LtJ9M/K8D39Uaz09nGA5ThYUcl6PLrKFZ5z3zT1eSAyt0b3ypuv17hVDGgEHXaxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jp+CKQGc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jp+CKQGc"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c10cd7df22so81939355ad.2
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 17:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781051434; x=1781656234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=aaCRfVH8CKZcSVl6mmM7CvGswcE0rcOuOdeUfo9Cnrw=;
        b=jp+CKQGcX0YCEn8LHuc4pq3GYuB9zlnddezbdmI8xRI5gL7Cdhs/X8d3bJOfUlnrmK
         qWmQ39cJKsMxUYqyRfML+y3v6Ptgz2dHJt86b2wyVBdrcTSCLsGBtycOrhYJE2y+rhaz
         f0zKICpWlp/OYRW4iCz/6+Cnm0doOds5SnlCyMfRssgr9teQH1tkqxB0O6w5E12hxnjX
         a1dI3rGcxewe6sk/AYlmSIIg/eB0cdW/cLFQkjDabn24d5ow6J5sC0Jnk7ttdQZSCi+u
         FwtIisZ0tAHxtEK3oe0JGA7DV0psa/+GWAHV7If6udFr8nAzl/5HTQrrJO/r7XV3YVAA
         QAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781051434; x=1781656234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaCRfVH8CKZcSVl6mmM7CvGswcE0rcOuOdeUfo9Cnrw=;
        b=HZQEu36Q1+dYnCXid39xvUYy3Gz+av7dZKWcBxTHBmtSDZgtxSy9RCD6IZlLEbzI94
         j8zm27MiGa3oC8AiuUr8X55Jn8RY+k7kotrnF20SYJ1a9cnjUKR0ONfAQOXqvtx2OX3p
         eIAIL1ITI52e0giafHHeAwmM9dD/qJDAthJxDPz5OwDPRduOzvDxGc0610hvc/IySV7F
         i+8ZvfTEG3GdkI4ConZMNhL4R33rNaZfv5VT3LVsCEmZTmKqDGkKBglxJGZ5KYOYgdSC
         xagAA2k6DrkrwDS4dt7hAUIaR8uoy9vvbTTBn4Dr8hH3pk32NWWfzaqGETKMJLdC0nEV
         8gcA==
X-Gm-Message-State: AOJu0YwdQVvn1VilpsHF+jXu6EL9d1exxvIeGxtCN1Vv8qM5MuhTXflO
	/qMuJlvZ5Xg5nOraGKb5PIc05mP2x9e7vRk7Ubu0E//cAZ3NRPW3hPmeH+rHs+OPQjzvvogd9rM
	nsu8Lkw==
X-Received: from plbkv13.prod.google.com ([2002:a17:903:28cd:b0:2bd:55dc:a132])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5d2:b0:2c0:cb90:1dfc
 with SMTP id d9443c01a7336-2c1e8219fccmr270263525ad.12.1781051433467; Tue, 09
 Jun 2026 17:30:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jun 2026 17:30:26 -0700
In-Reply-To: <20260610003030.2957261-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610003030.2957261-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610003030.2957261-2-seanjc@google.com>
Subject: [PATCH v8 1/5] KVM: selftests: Refactor allocating guest stack into a helper
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Yosry Ahmed <yosry@kernel.org>

In preparation for reusing the logic to allocate stacks for nested
guests, refactoring allocating a guest stack and aligning RSP into a
helper.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/lib/x86/processor.c | 45 ++++++++++---------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 4ca48de7a926..9393bb580a58 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -778,6 +778,30 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 		REPORT_GUEST_ASSERT(uc);
 }
 
+static gva_t vm_alloc_stack(struct kvm_vm *vm, int nr_pages)
+{
+	int size = nr_pages * getpagesize();
+	gva_t stack_gva;
+
+	stack_gva = __vm_alloc(vm, size, DEFAULT_GUEST_STACK_VADDR_MIN, MEM_REGION_DATA);
+	stack_gva += size;
+
+	/*
+	 * Align stack to match calling sequence requirements in section "The
+	 * Stack Frame" of the System V ABI AMD64 Architecture Processor
+	 * Supplement, which requires the value (%rsp + 8) to be a multiple of
+	 * 16 when control is transferred to the function entry point.
+	 *
+	 * If this code is ever used to launch a vCPU with 32-bit entry point it
+	 * may need to subtract 4 bytes instead of 8 bytes.
+	 */
+	TEST_ASSERT(IS_ALIGNED(stack_gva, PAGE_SIZE),
+		    "__vm_alloc() did not provide a page-aligned address");
+	stack_gva -= 8;
+
+	return stack_gva;
+}
+
 void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
 {
 	int r;
@@ -820,27 +844,8 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 {
 	struct kvm_mp_state mp_state;
 	struct kvm_regs regs;
-	gva_t stack_gva;
 	struct kvm_vcpu *vcpu;
 
-	stack_gva = __vm_alloc(vm, DEFAULT_STACK_PGS * getpagesize(),
-			       DEFAULT_GUEST_STACK_VADDR_MIN, MEM_REGION_DATA);
-
-	stack_gva += DEFAULT_STACK_PGS * getpagesize();
-
-	/*
-	 * Align stack to match calling sequence requirements in section "The
-	 * Stack Frame" of the System V ABI AMD64 Architecture Processor
-	 * Supplement, which requires the value (%rsp + 8) to be a multiple of
-	 * 16 when control is transferred to the function entry point.
-	 *
-	 * If this code is ever used to launch a vCPU with 32-bit entry point it
-	 * may need to subtract 4 bytes instead of 8 bytes.
-	 */
-	TEST_ASSERT(IS_ALIGNED(stack_gva, PAGE_SIZE),
-		    "__vm_alloc() did not provide a page-aligned address");
-	stack_gva -= 8;
-
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
 	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
 	vcpu_init_sregs(vm, vcpu);
@@ -849,7 +854,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
 	regs.rflags = regs.rflags | X86_EFLAGS_FIXED;
-	regs.rsp = stack_gva;
+	regs.rsp = vm_alloc_stack(vm, DEFAULT_STACK_PGS);
 	vcpu_regs_set(vcpu, &regs);
 
 	/* Setup the MP state */
-- 
2.54.0.1099.g489fc7bff1-goog

