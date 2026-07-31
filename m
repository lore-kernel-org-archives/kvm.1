Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6EE4503F9
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519233; cv=none; b=V3u88nTMFIzWVqe3+hjD9mAPC4ku2v/vviWH2F5Ln5m6rprrYiNbBpg9yrRwHl6MKqrMBnmt0hlt7XH24FFO505pKiYM2sjq+OnORw/WTQv+8ZFplYhxJhEmFuviKjBniNhQEs+LoBRfqm9h81NE3mBQ6TOpAVs6zTMe/KSoDZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519233; c=relaxed/simple;
	bh=FWHbA/npxvmx1aU5dy797YrSrZH0OKZmcuOLHUTxquE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tU4t8ngrfpViN3FacA51Lv8XCMIAlaCtewfrizQujzH9hexAnz3spOsT76nn3alIsFSpKvTTYHkbUqU1XylGEBJk54G/mukm+sr4hZazgPsR7vOrL2YCK4WAHUacKiTmxOuynlGSxQyEPF+tAwlkAv0jkk1BYd14PiNRWO+2m9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TXWjgnVy; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TXWjgnVy"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so1821351a91.3
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785519228; x=1786124028; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rfrz25N6FEniJQ8FbqR0gm71fG240oUTnfj7H6PgCoc=;
        b=TXWjgnVykqfo2p38V0mlgR2KsP9/HafZrQHdhnFQFXX7ZeBEpL4gaXzOPUosVeBRkV
         IRZOXpNMKAUT6iGPEASspnfkslhg1OWnR7YvYPiZCSR6sjRNL0Ih28o+swk31Meu/VuD
         qwqloHWOcq374/mEkeC5ZCc7Egy0flPiud9shzcrpSmvIwjPLyl2nJJP6mg1sFff/iOu
         CPx/pBB6uETCLXTyA5J6/K9Sj6WHWVg8t/SJHmg1CR8W8k64p/hr+vyVLn62MHK/xJVM
         n+uH+USlg5AyIU8UjYeHT2UHHOxb7oQAdCGAfLKFQlzRpcEBT66FQ7MdxIf9gFDsk5At
         WV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785519228; x=1786124028;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rfrz25N6FEniJQ8FbqR0gm71fG240oUTnfj7H6PgCoc=;
        b=bhAZ9gZbsKD82nf35yT8rwpZhIAhLJEJJYpvlvtP3rEgKBPx7WUTCRDMIzlkBae3yM
         aak+AT+mM/LybrCcZrUxaICmZdcFaKsH0H693b3TycGEI0byyAjy2/ycwpp06wfNCVKH
         Bp1RseepDxi11+doigCNp/44vhQkja8GxD2KSnXZgAQ8EVGN9wW48deYKGAQ7Lgpb8RW
         /m8t9qUpIZKO/ORvjryFrrHul293MnAdW7mragCm/OvI/fY+HTyTM8Kcwy0ZkJ+GF62x
         aelhKfQf9KRW1l/TtuIXLszQt6T4/D2fzUFuyXuHyg9HPsgKRIIXehQMmJcpiKDaUng4
         AGaw==
X-Gm-Message-State: AOJu0YyskaW8ZyFFmZfMXvKKyg1bEzleh7aLAlBemsXyLkJHLfBWw6yZ
	6YPAo+fLrRU+yKdoZCAqC2H97GNfrcyKF3vCu71oyNLS7h+iP5cMNSxxG/Tr5iFUbCt8OQej7KV
	JZXcOjw==
X-Received: from pjbay23.prod.google.com ([2002:a17:90b:317:b0:38f:5801:d550])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c4b:b0:387:e0db:3d8f
 with SMTP id 98e67ed59e1d1-38fbc560758mr613474a91.42.1785519228108; Fri, 31
 Jul 2026 10:33:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:33:39 -0700
In-Reply-To: <20260731173340.2644656-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731173340.2644656-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731173340.2644656-6-seanjc@google.com>
Subject: [PATCH v5 5/6] KVM: selftests: Refactor invalid nVMX state test to
 prepare for RSM testcase
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hao Zhang <zhanghao1@kylinos.cn>, Hao Zhang <hao_zhang_kdev@163.com>
Content-Type: text/plain; charset="UTF-8"

In the invalid nVMX guest state test, extract the creation of the VM and
initial running of the vCPU to get to L2 into helpers so that the common
code can be reused to extend the test to also cover RSM.

Eliminate the unnecessary global "vm", and opportunistically free the VM
after the testcase as there's zero reason not to.

Opportunistically assert that L2 is never resumed after the I/O exit to L1,
e.g. to guard against false passes.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/x86/vmx_invalid_nested_guest_state.c  | 61 +++++++++++++------
 1 file changed, 42 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
index fb9444ca0d7e..4b1bb190c2c6 100644
--- a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
+++ b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
@@ -11,8 +11,6 @@
 
 #define ARBITRARY_IO_PORT 0x80
 
-static struct kvm_vm *vm;
-
 static void l2_guest_code(void)
 {
 	/*
@@ -21,6 +19,7 @@ static void l2_guest_code(void)
 	 */
 	asm volatile("inb $" __stringify(ARBITRARY_IO_PORT) ", %%al"
 		     ::: "rax");
+	GUEST_FAIL("L2 resumed after stuffing invalid guest state");
 }
 
 static void l1_guest_code(struct vmx_pages *vmx_pages)
@@ -46,35 +45,50 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_DONE();
 }
 
-int main(int argc, char *argv[])
+static void vcpu_run_to_io(struct kvm_vcpu *vcpu, bool want_l2)
+{
+	struct kvm_run *run = vcpu->run;
+
+	vcpu_run(vcpu);
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	TEST_ASSERT(run->io.port == ARBITRARY_IO_PORT &&
+		    (!!(run->flags & KVM_RUN_X86_GUEST_MODE) == want_l2  ||
+		     !kvm_has_cap(KVM_CAP_X86_GUEST_MODE)),
+		    "Expected IN from port 0x%x from L%u, got port 0x%x from L%u",
+		    ARBITRARY_IO_PORT, 1 + want_l2, run->io.port,
+		    1 + !!(run->flags & KVM_RUN_X86_GUEST_MODE));
+}
+
+static struct kvm_vm *vm_create_and_run_l2(struct kvm_vcpu **vcpu)
 {
 	gva_t vmx_pages_gva;
-	struct kvm_sregs sregs;
-	struct kvm_vcpu *vcpu;
-	struct kvm_run *run;
-	struct ucall uc;
+	struct kvm_vm *vm;
 
-	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
-
-	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+	vm = vm_create_with_one_vcpu(vcpu, l1_guest_code);
 
 	/* Allocate VMX pages and shared descriptors (vmx_pages). */
 	vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	vcpu_args_set(vcpu, 1, vmx_pages_gva);
-
-	vcpu_run(vcpu);
-
-	run = vcpu->run;
+	vcpu_args_set(*vcpu, 1, vmx_pages_gva);
 
 	/*
 	 * The first exit to L0 userspace should be an I/O access from L2.
 	 * Running L1 should launch L2 without triggering an exit to userspace.
 	 */
-	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	vcpu_run_to_io(*vcpu, true);
 
-	TEST_ASSERT(run->io.port == ARBITRARY_IO_PORT,
-		    "Expected IN from port %d from L2, got port %d",
-		    ARBITRARY_IO_PORT, run->io.port);
+	return vm;
+}
+
+static void test_invalid_l2_guest_state(void)
+{
+	struct kvm_sregs sregs;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	vm = vm_create_and_run_l2(&vcpu);
 
 	/*
 	 * Stuff invalid guest state for L2 by making TR unusable.  The next
@@ -96,4 +110,13 @@ int main(int argc, char *argv[])
 	default:
 		TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
 	}
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
+
+	test_invalid_l2_guest_state();
 }
-- 
2.55.0.508.g3f0d502094-goog

