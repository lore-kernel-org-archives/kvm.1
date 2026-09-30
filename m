Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68F951CF53
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803285; cv=none; b=gYM94K0V0m8rA6gesOhTJoFCJTM0JIMyvqgjtV/kV6pHG0K+7rAPXFmylgpbgKDU/XeBiOQmd6LHhikcFb3OPFd9rkKYovMjZ+oGv4mPKLwflzRnNoqex5g2B/50gdrjEeD26XKqpl9boxI+hMBoQwvD0fOok4V2uqFisUVh7U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803285; c=relaxed/simple;
	bh=+J/3xzetUlhrx8l2vV8IsLbLhogCtMKGiw+39WY0hs4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DIbd/8OKkiO6Jpxf2NzqiPmkiDyiw9UR87CH289Z+VF7UQJASgTs+FhrlmkRfpluboo+7D8gj8u1Fb++a8akiv8igs+7HoH7ktXHOJg+Sm8CWfp55bEH94TvFkSBrLncvs2EKWFlm6BAIytlecS2wfm3FtiK0Uh4INuxqqvs4uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ei6RmbEl; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ei6RmbEl"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc7695f6a30so6046777a12.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790803283; x=1791408083; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0MqVpu4C3GCmEyaVXkAFeD8tJmZIYx8EJFsjA0DnDIE=;
        b=ei6RmbElF/PaGlRb/QtqPXS6WGjdH5ehmQ8bsCg5BEULr7o1xtQyerMb9aXLI35zY3
         LKOtcNwA767rYVhaqBcgLp2wOBeGXRkxvARkTk+3qn2r5zIE/tGycdXSj0W1oh7vYcD2
         8el1GXRZMl6hKItSx+lqn/sOMlYyy5dvVpYMIQIYAUXEgCK4atI3sR8Uj/uSodROnnuH
         ZwZFesGtpmBhSAqt9koOQKf82zNKI5CfEjJCWaDPptkrUdrF9tfzPstgnbuUm6fZOFPc
         bncv8d8EnmptW6GAzDPuB7bKkh6K/n+nedI/u0Q4s2t5UidR89VXHga2bji4Ld38pVuq
         iHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803283; x=1791408083;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0MqVpu4C3GCmEyaVXkAFeD8tJmZIYx8EJFsjA0DnDIE=;
        b=ypdWKQmTrMRD8uER5hG2WqK1X6DWyr9+19tlLKx1Aswm/2pSYnYoXYU3NXbZ+oChqn
         RLcoHMy8w/qq+HsvFCeTlO5I0dCeK0abk8w15QYXoxqvYQD0ssf5HirKveUCc3282RfD
         BeqMD/U0PdhoGFde7+vu+BxcEbDrKynEeb9eoHhUFT7sWIfyZYseLnBR4ujxSQ1o3Zmh
         qhw93q3f0qqL17MGkwmcRaTbevo00hKHDk715MYsqCudc6lQ6zZzDyPqtk3TnPPHqUYj
         bx7ufoqnDt7/AmScDjDiG/2OVqwG8+rOeJ8vI2S7L6dQs+TDYkzPKCZmlwxl0N5W5Tkz
         nT7w==
X-Gm-Message-State: AFuF++nkUd+BFfn7Jn5WyHW9CJ3UEkBD4xMH6H+wwxacd0Kau/xtkQix
	TGilEcFOelxUbKj3lmNNBXXUx0q2URIdseZc8UT9pAfPi9fEMSwKoC/P8xG+/7rYVVtsw2RKg6o
	GAHoHdA==
X-Received: from pgar16.prod.google.com ([2002:a05:6a02:2e90:b0:cc4:4327:bb52])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:260a:b0:3dd:a006:55a3
 with SMTP id adf61e73a8af0-3de9e7ebbb7mr2383516637.49.1790803282689; Wed, 30
 Sep 2026 14:21:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 14:21:14 -0700
In-Reply-To: <20260930212114.3500045-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930212114.3500045-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930212114.3500045-6-seanjc@google.com>
Subject: [PATCH v4 5/5] KVM: selftests: Add coverage for the EFER_LMSLE_MBZ defeature
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

Add coverage for KVM's virtualization of EFER_LMSLE_MBZ,
CPUID.80000008H:EBX[bit 20], which is set when the CPU does *not* support long
mode segment limits.  Verify that KVM's enumeration of the defeature matches
the expectation derived from hardware plus kvm_amd's "nested" module param, so
that the assertion doesn't compare KVM's enumeration against itself, and that
WRMSR(EFER), nested VMRUN, and KVM_SET_SREGS reject EFER.LMSLE=1 if and only
if guest CPUID enumerates the defeature.  Also verify that host-initiated
KVM_SET_MSRS is exempt from the check, as host-initiated writes skip guest
CPUID checks so that userspace can set MSRs before it sets guest CPUID.

Extend svm_nested_efer_test rather than add yet another test binary for a
single CPUID bit; the test already has the L1/L2 harness needed to exercise
EFER.LMSLE.  Note, only a CPU that supports LMSLE, i.e. Rome and earlier,
exercises the emulation path; elsewhere KVM enumerates the defeature straight
from hardware.

Opportunistically drop the unnecessary #include of vmx.h.

Assisted-by: LLM
Signed-off-by: Jim Mattson <jmattson@google.com>
[sean: drop specific APM volume references, use common "nested" getter]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86/processor.h     |   1 +
 .../selftests/kvm/x86/svm_nested_efer_test.c  | 244 +++++++++++++++++-
 2 files changed, 231 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 3d3a7d9f2a95..6f110987c51a 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -216,6 +216,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_INVTSC		KVM_X86_CPU_FEATURE(0x80000007, 0, EDX, 8)
 #define	X86_FEATURE_RDPRU		KVM_X86_CPU_FEATURE(0x80000008, 0, EBX, 4)
 #define	X86_FEATURE_AMD_IBPB		KVM_X86_CPU_FEATURE(0x80000008, 0, EBX, 12)
+#define	X86_FEATURE_EFER_LMSLE_MBZ	KVM_X86_CPU_FEATURE(0x80000008, 0, EBX, 20)
 #define	X86_FEATURE_NPT			KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 0)
 #define	X86_FEATURE_LBRV		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 1)
 #define	X86_FEATURE_NRIPS		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 3)
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c b/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
index 6bc301207cbc..fa0d76a9c390 100644
--- a/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
+++ b/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
@@ -1,16 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
+ * Tests for KVM's handling of EFER bits whose behavior is tied to nested SVM.
+ *
  * Copyright (C) 2026, Google LLC.
  */
+#include "test_util.h"
 #include "kvm_util.h"
-#include "vmx.h"
+#include "processor.h"
 #include "svm_util.h"
 #include "kselftest.h"
 
+static bool l2_ran;
 
-static void l2_guest_code(void)
+static void l2_clear_efer_svme(void)
 {
-	unsigned long efer = rdmsr(MSR_EFER);
+	u64 efer = rdmsr(MSR_EFER);
 
 	/* generic_svm_setup() initializes EFER_SVME set for L2 */
 	GUEST_ASSERT(efer & EFER_SVME);
@@ -20,31 +24,243 @@ static void l2_guest_code(void)
 	GUEST_ASSERT(0);
 }
 
-static void l1_guest_code(struct svm_test_data *svm)
+static void l1_clear_efer_svme(struct svm_test_data *svm)
 {
-	generic_svm_setup(svm, l2_guest_code);
+	generic_svm_setup(svm, l2_clear_efer_svme);
 	run_guest(svm->vmcb, svm->vmcb_gpa);
 
 	/* Unreachable, L1 should be shutdown */
 	GUEST_ASSERT(0);
 }
 
-int main(int argc, char *argv[])
+static void l2_lmsle(void)
+{
+	GUEST_ASSERT(rdmsr(MSR_EFER) & EFER_LMSLE);
+	l2_ran = true;
+	vmmcall();
+}
+
+static void l1_lmsle(struct svm_test_data *svm)
+{
+	bool lmsle_mbz = this_cpu_has(X86_FEATURE_EFER_LMSLE_MBZ);
+	struct vmcb *vmcb = svm->vmcb;
+	u64 efer = rdmsr(MSR_EFER);
+
+	/*
+	 * Selftests' vCPUs are created with EFER.LMSLE clear; the sub-tests
+	 * below need to start from a clean slate.
+	 */
+	GUEST_ASSERT(!(efer & EFER_LMSLE));
+	GUEST_ASSERT(!l2_ran);
+
+	/*
+	 * Per the APM, if EFER_LMSLE_MBZ is enumerated in CPUID, "64-bit mode
+	 * segment limit checking is not supported and attempting to set
+	 * EFER.LMSLE = 1 causes a #GP exception".
+	 */
+	if (lmsle_mbz) {
+		GUEST_ASSERT_EQ(wrmsr_safe(MSR_EFER, efer | EFER_LMSLE), GP_VECTOR);
+		GUEST_ASSERT(!(rdmsr(MSR_EFER) & EFER_LMSLE));
+	} else {
+		GUEST_ASSERT_EQ(wrmsr_safe(MSR_EFER, efer | EFER_LMSLE), 0);
+		GUEST_ASSERT(rdmsr(MSR_EFER) & EFER_LMSLE);
+
+		/*
+		 * Restore EFER so that generic_svm_setup() doesn't propagate
+		 * EFER.LMSLE into vmcb12 on its own, i.e. so that the VMRUN
+		 * sub-test actually tests what it thinks it's testing.
+		 */
+		wrmsr(MSR_EFER, efer);
+	}
+
+	/*
+	 * VMRUN's consistency checks reject "any MBZ bit of EFER", i.e. a
+	 * vmcb12 with EFER.LMSLE set must generate VMEXIT_INVALID when the
+	 * defeature is enumerated.
+	 */
+	generic_svm_setup(svm, l2_lmsle);
+	vmcb->save.efer |= EFER_LMSLE;
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	if (lmsle_mbz) {
+		GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_ERR);
+		GUEST_ASSERT(!l2_ran);
+	} else {
+		GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+		GUEST_ASSERT(l2_ran);
+		GUEST_ASSERT(vmcb->save.efer & EFER_LMSLE);
+	}
+
+	GUEST_DONE();
+}
+
+static struct kvm_vcpu *create_l1_vcpu(struct kvm_vm **vm, void *l1_guest_code)
+{
+	struct kvm_vcpu *vcpu;
+	gva_t svm_gva;
+
+	*vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+
+	vcpu_alloc_svm(*vm, &svm_gva);
+	vcpu_args_set(vcpu, 1, svm_gva);
+
+	return vcpu;
+}
+
+static void test_enumeration(void)
+{
+	bool lmsle_mbz;
+
+	/*
+	 * EFER_LMSLE_MBZ, CPUID.80000008H:EBX[bit 20], is a "defeature" bit,
+	 * i.e. is set when the CPU does *not* support long mode segment
+	 * limits.  KVM enumerates the defeature if and only if KVM refuses to
+	 * set EFER.LMSLE, i.e. if the CPU doesn't support LMSLE, or if KVM
+	 * doesn't support nested SVM.  Derive the expectation from raw CPUID
+	 * and kvm_amd's "nested" module param rather than from
+	 * kvm_cpu_has(X86_FEATURE_SVM), so that the assertion doesn't simply
+	 * compare KVM's enumeration to itself.
+	 */
+	lmsle_mbz = this_cpu_has(X86_FEATURE_EFER_LMSLE_MBZ) ||
+		    !this_cpu_has(X86_FEATURE_SVM) ||
+		    !kvm_is_nested_virtualization_enabled();
+
+	TEST_ASSERT_EQ(kvm_cpu_has(X86_FEATURE_EFER_LMSLE_MBZ), lmsle_mbz);
+
+	ksft_test_result_pass("KVM enumerates EFER_LMSLE_MBZ=%d\n", lmsle_mbz);
+}
+
+static void test_clear_efer_svme(void)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
-	gva_t nested_gva = 0;
 
-	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
-
-	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
-
-	vcpu_alloc_svm(vm, &nested_gva);
-	vcpu_args_set(vcpu, 1, nested_gva);
+	vcpu = create_l1_vcpu(&vm, l1_clear_efer_svme);
 
 	vcpu_run(vcpu);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_SHUTDOWN);
 
 	kvm_vm_free(vm);
-	return 0;
+	ksft_test_result_pass("L2 clearing EFER.SVME shuts down L1\n");
+}
+
+static void test_lmsle(bool lmsle_mbz)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	vcpu = create_l1_vcpu(&vm, l1_lmsle);
+
+	vcpu_set_or_clear_cpuid_feature(vcpu, X86_FEATURE_EFER_LMSLE_MBZ,
+					lmsle_mbz);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+	case UCALL_DONE:
+		break;
+	default:
+		TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
+	}
+
+	kvm_vm_free(vm);
+	ksft_test_result_pass("Guest EFER_LMSLE_MBZ=%d\n", lmsle_mbz);
+}
+
+static void test_host_initiated_lmsle(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	u64 efer;
+
+	vm = vm_create_with_one_vcpu(&vcpu, NULL);
+	vcpu_set_cpuid_feature(vcpu, X86_FEATURE_EFER_LMSLE_MBZ);
+
+	/*
+	 * EFER_LMSLE_MBZ is a guest CPUID consistency check, not a host
+	 * capability, i.e. must not be enforced against host-initiated writes,
+	 * so that userspace can set MSRs before it sets guest CPUID.
+	 */
+	efer = vcpu_get_msr(vcpu, MSR_EFER);
+	TEST_ASSERT(!(efer & EFER_LMSLE), "EFER.LMSLE unexpectedly set");
+
+	vcpu_set_msr(vcpu, MSR_EFER, efer | EFER_LMSLE);
+	TEST_ASSERT_EQ(vcpu_get_msr(vcpu, MSR_EFER), efer | EFER_LMSLE);
+
+	kvm_vm_free(vm);
+	ksft_test_result_pass("Host-initiated EFER.LMSLE=1 is allowed\n");
+}
+
+static void test_sregs_lmsle(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_sregs sregs;
+	struct kvm_vm *vm;
+	int rc;
+
+	vm = vm_create_with_one_vcpu(&vcpu, NULL);
+	vcpu_set_cpuid_feature(vcpu, X86_FEATURE_EFER_LMSLE_MBZ);
+
+	/*
+	 * Unlike KVM_SET_MSRS, KVM_SET_SREGS runs the full set of guest CPUID
+	 * checks, i.e. rejects EFER.LMSLE even though it's host-initiated.
+	 */
+	vcpu_sregs_get(vcpu, &sregs);
+	TEST_ASSERT(!(sregs.efer & EFER_LMSLE), "EFER.LMSLE unexpectedly set");
+
+	sregs.efer |= EFER_LMSLE;
+	rc = _vcpu_sregs_set(vcpu, &sregs);
+	TEST_ASSERT(rc, "KVM allowed EFER.LMSLE with EFER_LMSLE_MBZ set");
+
+	kvm_vm_free(vm);
+	ksft_test_result_pass("KVM_SET_SREGS rejects EFER.LMSLE=1\n");
+}
+
+int main(int argc, char *argv[])
+{
+	bool has_nested_svm, has_lmsle;
+
+	ksft_print_header();
+	ksft_set_plan(6);
+
+	test_enumeration();
+
+	/*
+	 * The sub-tests below need to actually run a nested guest, and the
+	 * EFER.LMSLE sub-tests additionally need KVM to allow EFER.LMSLE.
+	 * It's KVM's view of the world, not raw CPUID, that dictates whether
+	 * EFER.LMSLE is allowed, i.e. whether the defeature is emulated.
+	 */
+	has_nested_svm = kvm_cpu_has(X86_FEATURE_SVM);
+	has_lmsle = has_nested_svm &&
+		    !kvm_cpu_has(X86_FEATURE_EFER_LMSLE_MBZ);
+
+	if (!has_nested_svm)
+		ksft_print_msg("Nested SVM unsupported\n");
+	else if (!has_lmsle)
+		ksft_print_msg("KVM doesn't support EFER.LMSLE\n");
+
+	if (has_nested_svm) {
+		test_clear_efer_svme();
+		test_lmsle(true);
+	} else {
+		ksft_test_result_skip("L2 clearing EFER.SVME shuts down L1\n");
+		ksft_test_result_skip("Guest EFER_LMSLE_MBZ=1\n");
+	}
+
+	if (has_lmsle) {
+		test_lmsle(false);
+		test_host_initiated_lmsle();
+		test_sregs_lmsle();
+	} else {
+		ksft_test_result_skip("Guest EFER_LMSLE_MBZ=0\n");
+		ksft_test_result_skip("Host-initiated EFER.LMSLE=1 is allowed\n");
+		ksft_test_result_skip("KVM_SET_SREGS rejects EFER.LMSLE=1\n");
+	}
+
+	ksft_finished();
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

