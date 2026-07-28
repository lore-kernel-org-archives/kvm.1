Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A632641FC
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199441; cv=none; b=qkJ/KiYV9MgU3sbPCqNaJ4FFohw//NC4L3u5O7Xn3kHQqIotc02hNq2YEyhefgC/waIGrWH9Lm6FXPTV1kNh3Fm0Isy+A6KnPw4mzHWPTxR4oqvhwpJ/UQjRix4R2l0pZGF7G1AYUsd07kgmY4ePhbVkJDPPGl2IA2+p1kIGM/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199441; c=relaxed/simple;
	bh=HWVJOC0VodyHYeFvvYN1hgUJH9GAJSkQuUm7N4YRs/M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hczog5Zw445x20lDWrNmSUSb9yYkf825LVAIci3xfqQvg6i7VK+eUnUu3sgvMr+4Z4BJgO+YLd29y7HkWYYrjSezh9i7Gr47LxyX1Gv2EXXXRKzRXBcKs3YWVPhD+3u+vODHOi4xLYIfSYPutlSBh+PsmpD4rUOG3qZtq7TqsaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dB0rUClB; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dB0rUClB"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848662cd2a1so3737236b3a.2
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785199439; x=1785804239; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RwlwIhN+74Sbz0rw2pomKB0vZtE7NOxrfoqVFlq5+6c=;
        b=dB0rUClB8Mkfy87mU+anNjcOljWad3lYTvX94KuD1cOIJHC1euW2SJtA1zD38C+MY+
         mR2ygUvK8Z2S2SeOy7XGJt/IXkB6dDlF0IewWTOqRjYclvG9r0mJvT104mrZfydydUpJ
         Le2pM/wIsH6rFBF86hayK+IYyIbhVC8KDm0J3lqgEdJW5qxh3H8a2Kdep/QKONeDK8sW
         TYob+9XMsNoscq4P0UawdzKKhLLAs7J3AUykAu7GIp5pM1FuGu9sL6tyaH2w8MLkYXbj
         gwqH+i7ogyM0KgIWXPgTcB8lZCrdtF6jXL8aaFlcdeayv4+Jv4i5WmUJNugAtEUKhWYU
         riwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785199439; x=1785804239;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RwlwIhN+74Sbz0rw2pomKB0vZtE7NOxrfoqVFlq5+6c=;
        b=Wrph/vMl0uiJnPVwiY5NUrPO/er31oD62kuNUyzdNR91J33F8KeLG4ZExjNH0Lprli
         4KMDkgmRuB8ZuQay6gKtpCCzOJdUjtdc48/uFQZdvVfsWnHFC8TELK4lHz0kvl1TrDkv
         p1arGSgIMtkY4IsvJ82HOzl/uiSmxgBuMV4b334QR+HVanJTwEOjAILHGRkPdkg2XzL/
         jH5L5T1HxTaPhH9ZlXbvEtib2KFA+1oK0SEshWkRlKIpqo5rCepSiOyETc7XEvZVrivp
         BSDPc8ZL4ZKOJNurvUWBmfImCtMqfh5kNfKMGoOXCRiVZgE47KqbzIHr6F/V51Qk7883
         Ku9Q==
X-Gm-Message-State: AOJu0YzMr1x4i5I1Ah5toDaxLBofo2schLmVO4xPC5JelW4OVTCuy3Er
	uPi56TxPFXGhbZmvloIhZZcOvi24FZFgpxXMSlClgpVp2afLH+VQJLADIc3bsp/wthoHrBXVd3z
	9b52qrg==
X-Received: from pgmr33.prod.google.com ([2002:a63:2061:0:b0:c85:98b1:c613])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:288b:b0:848:6a95:a9d3
 with SMTP id d2e1a72fcca58-84e933e8da0mr139285b3a.40.1785199438613; Mon, 27
 Jul 2026 17:43:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 27 Jul 2026 17:43:50 -0700
In-Reply-To: <20260728004351.887076-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728004351.887076-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728004351.887076-6-seanjc@google.com>
Subject: [PATCH v4 5/6] KVM: selftests: Refactor invalid nVMX state test to
 prepare for RSM testcase
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hao Zhang <zhanghao1@kylinos.cn>
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
index fb9444ca0d7e..ab00265d6c94 100644
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
+		    "Expected IN from port %d from L2, got port %d from L%u",
+		    ARBITRARY_IO_PORT, run->io.port,
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
2.55.0.229.g6434b31f56-goog

