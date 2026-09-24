Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E2B2F7EF6
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 00:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209560; cv=none; b=VUzcp+z+EevUjplNuouTFZwLpr/nqh+InF/nDvS0YLrxMaSloi1ZQeU1SAwKVT+43UitzTNixjokJkoQHUVKUC5BoLC8O6Lixm2/iY74/UIl9bdbANVhy8LjHINyLbgVZsvgh41az9txnCEPhOXjAm1EK2F9wQDVmAJRmloVkG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209560; c=relaxed/simple;
	bh=W40w6Xz5WizzC2CsbKNXLo3vVFw6UxWPXABB0XtWee4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MHBzdNpA2AOTb2rE+DQxH9uQ0VQKDIS5thf8ML+ysrMgD6DFFg8viTgMZem6sC/lDnT5Dy/Pfemw0SZ2duEakr617rCfzBBi2ate9otFpnJ4l3zOp1KxWKZuZkkn8GA1KVCE9YbnvCeKUaQB/eixSrM7Z0O4v/NUhAwQDeTrKD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ASWHXTBK; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASWHXTBK"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1b6f65dacso975967a12.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 17:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790209558; x=1790814358; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pso3DvjmD9/LlPFbVvpLmkrNSJZEBDMBWUOU1ztjzQc=;
        b=ASWHXTBKQJsEEc/Q0Rs2Z8oaRByBxo87L8Z564wkcGQltzfZyU67YiBlKSVBNp5C+h
         S26ktirIMM4P+L6j35/Dw7wfHPWn2gG2f9gx6AjLoIcaCLNl8l1BylXQ6BfpDtYgkII0
         LVIcW6X8C9tPs8r8lMIri5plzU9NOiE6hRKR4Ku89Gqg5bn4EVGvLwOWS1BWSQAqbyz5
         19arxFQY6nAxEtvxRCVDUGYjXtZkAdSTpLmAd4Boxbrqrmpq7WzSqG0xX5vwx1A1sKm7
         p372VyQx6i4JVW4kTE0vXEa23vDopn/1TquMgFXTPooWFnW6TzHcuzCH93lo/p6LduFw
         umOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790209558; x=1790814358;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pso3DvjmD9/LlPFbVvpLmkrNSJZEBDMBWUOU1ztjzQc=;
        b=Qma3rnaDo/kuhfnoEbfFHnpxQkAyca0pidHsi4BNgFXHZJ3B9lng+JzSXO+2iwtboi
         ceSFjBwrs8en3j00UFAWUzQxbPQjHU3xng/TgYnlspH0GPpHjU4pwIzORczsB5967/dj
         GL2OCDr1kI/KSw2FVEL3crJAZMH3cg+2DIB2Pyh4SmAgswBdQpOGCNdnFtJHO7+8TTzz
         bwBENNn0OEBqtAc5+vBR4mVWru2Ac9W/htPGj/mr94Oly6MHbYOyH6FmGKTfdrJpnMDR
         /C/VDoXYheZ9fPjeBXMkbvR+RgTdQI/x/xQ06vfX2bi4e91K7pbek4jcCgoIsknyvw0H
         4lcg==
X-Gm-Message-State: AFuF++kVnq5hXYGIvekzLEN47PTPjP4UdzWGXgr2/gK0dpMljUSKqw0F
	dhqmP5IpCyOKhKjzSzO+KY+PfK6c4tMjB402H/wpQpuES0vgXY28th1kzuTYwTW0mBNAEHzUcvr
	R/Mu0abkTAlZLYA==
X-Received: from pgbfq8.prod.google.com ([2002:a05:6a02:2988:b0:c96:47b4:65c8])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2d07:b0:3dd:a195:dd5b with SMTP id adf61e73a8af0-3de0e93ffabmr703354637.61.1790209557724;
 Wed, 23 Sep 2026 17:25:57 -0700 (PDT)
Date: Wed, 23 Sep 2026 17:25:45 -0700
In-Reply-To: <cover.1790208413.git.jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790208413.git.jmattson@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <f0ce99261caf71e88cd0d51a4053abb77454e8bf.1790208413.git.jmattson@google.com>
Subject: [PATCH v2 4/4] KVM: selftests: Add coverage for the EFER_LMSLE_MBZ defeature
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@amd.com, 
	yosry@kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

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
---
 .../selftests/kvm/include/x86/processor.h     |   1 +
 .../selftests/kvm/x86/svm_nested_efer_test.c  | 249 +++++++++++++++++-
 2 files changed, 237 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 6e6f70035508..ba5d8b37edc1 100644
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
index 6bc301207cbc..765476c79c96 100644
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
@@ -20,31 +24,250 @@ static void l2_guest_code(void)
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
+	 * Per AMD APM vol. 2, if CPUID.80000008H:EBX[bit 20] is set, "64-bit
+	 * mode segment limit checking is not supported and attempting to set
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
 {
 	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm;
-	gva_t nested_gva = 0;
+	gva_t svm_gva;
 
-	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
+	*vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 
-	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+	vcpu_alloc_svm(*vm, &svm_gva);
+	vcpu_args_set(vcpu, 1, svm_gva);
+
+	return vcpu;
+}
+
+static void test_enumeration(void)
+{
+	bool lmsle_mbz;
 
-	vcpu_alloc_svm(vm, &nested_gva);
-	vcpu_args_set(vcpu, 1, nested_gva);
+	/*
+	 * EFER_LMSLE_MBZ, CPUID.80000008H:EBX[bit 20], is a "defeature" bit,
+	 * i.e. is set when the CPU does *not* support long mode segment
+	 * limits.  KVM enumerates the defeature if and only if KVM refuses to
+	 * set EFER.LMSLE, i.e. if the CPU doesn't support LMSLE, or if KVM
+	 * doesn't support nested SVM.  Derive the expectation from raw CPUID
+	 * and kvm_amd's "nested" module param rather than from
+	 * kvm_cpu_has(X86_FEATURE_SVM), so that the assertion doesn't simply
+	 * compare KVM's enumeration to itself.
+	 *
+	 * Note, kvm_amd's "nested" is an "int" module param, i.e. reads back
+	 * as '1'/'0' and not as 'Y'/'N'.  Query the param if and only if the
+	 * CPU supports SVM, i.e. if and only if kvm_amd is the module in
+	 * play.  Checking the vendor string wouldn't suffice, e.g. Zhaoxin
+	 * and Centaur CPUs are "GenuineIntel"-adjacent at best, but run VMX
+	 * and thus load kvm_intel.
+	 */
+	lmsle_mbz = this_cpu_has(X86_FEATURE_EFER_LMSLE_MBZ) ||
+		    !this_cpu_has(X86_FEATURE_SVM) ||
+		    !get_kvm_amd_param_integer("nested");
+
+	TEST_ASSERT_EQ(kvm_cpu_has(X86_FEATURE_EFER_LMSLE_MBZ), lmsle_mbz);
+
+	ksft_test_result_pass("KVM enumerates EFER_LMSLE_MBZ=%d\n", lmsle_mbz);
+}
+
+static void test_clear_efer_svme(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
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

