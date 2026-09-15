Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599A343F8AE
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 05:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789451222; cv=none; b=Jeo3MpJm9OzrbCp3f0FHg0XwSfZoi9JWrk7haX/VlNawC54FChMDSE82AnCnPfHTn/5IRUNAr7YaXaGFKssS5lybYnqPe2B4AMrUellc+q0hxWjcY24mN/5hNkV75n2FH52icpWmVgh29sDc48ipTfr1qq3C7s0rxUZjoGRr89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789451222; c=relaxed/simple;
	bh=AZG3iR9wcf3utrA5wuxhKWvFiHMmo63opwAJYxLjKpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ko1Z8lUJdEJtf8EbUzhQeP+WTtaXkCOrHuR4ZM5nLJleGIUTn7zx8mX5bU6zMrkWXmH74KJru5kfZyu1+7bcIpC9p4Z9WY1fPAMxhcR062Q8HUkY8jFFO4k1ZbnSkeJu5r6U267tu8zHPEA+5oweu6JLjLAftKcmng2gvlHvqXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcGhOqjI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcGhOqjI"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so4172917a91.2
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 22:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789451219; x=1790056019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R2iqQEA0P5F3XhuV+R4n4igK6yI3Yfdu5e82KuFRih0=;
        b=ZcGhOqjI8UgEWA3b2PK60VNZN6v9DI++dFQQdd/cNNupUcdgqEVS6WRlb3NEe/UGjc
         /e+uLjGiR2THB5XWUsbPY5dz/jed2ZTyTaqKWYIA62oKikrv0OBIkbvijgNfvSnrP+OJ
         ii16L46XNgazFrs8Wm+24FLDLQSYmrhHRp0ZYFMmdtpjkZD0BBlM+ZOTzc7ZN9L9AjKA
         pQv2EDl6yM4JWaFeFTreHe2BEvTTxCR1UvlH9dwNQhLoqEpdwkpn7Ty5MRZaQOASVehN
         tZrrNFTmhvFsi8DyS/AegrfrAqgMe0qCDkGyQC+W1Ipcpg51dSmGW6cufyyM8ikxG6Fi
         2s7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789451219; x=1790056019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R2iqQEA0P5F3XhuV+R4n4igK6yI3Yfdu5e82KuFRih0=;
        b=zPxhJKOUz7VePIK/8sYqQrASJJlIUrGlwhuHh4WOqE/PUoPo9CR69WtVyBWQwy2LSs
         vmKBv3gD67aYiL7o1hfr4aL5iO2uvI/SVVpri1C+mizN1oE0F4vEw6/Rc3CQFgVAdI4A
         3EPeJ3ebNTy/bc4GqAq9jPK4A6ybypwbpK++d4M8C4hkxyoiwgWMasZNMxHV9lTo+O4l
         5B82pCEHfGH0Q4x5GVLYrZZxaReQLCdrJg5e0tYQvRostKEluGN3f9MXD8lz0cUXZGvv
         jazAAaALUvXgkmW+1qYWlV/Zayrepi/T4jvEKXr5lP2DDfQ6pEO2wAYRi/WJoPiFdhFx
         mF3A==
X-Gm-Message-State: AFuF++mhHJspEqdtqD0anlrsg645FHD96klHUp1SPkmqUidJOWjFIMwN
	BbzeWtiQF4hp4oHJ3iH2ZGg2eEBLDaM4loLQNykIrJvLgz5I41IN9nID
X-Gm-Gg: AYBFou1S5veVSVApnRbYv9K7iPGtfHaxzP8StrnTztCUuAgr4WqTSkW347zpc/mC/JX
	5HODQIjClYv460fmKVDdsID3JHAPf327qbwcj7C+gXPIog9dYQV9Fyzm7YWbJbmpIAO7+w34gBx
	PWKEjR0Gl09gGPqd7fErt5pucaC2+LKQSj2AAgkjFF7Mz33XI7Mqt+pIUNQygKG8/K4PQg8jL+9
	ugpqbHGcr/Q3ugW+e8I5zvk23I+bWGaTSfZF5qgnhBOtZ+4/KinPv9qPS96UlWbVc7MXaovijs+
	dGjxX4qIiiFA/O2PtTEZP803fL3VOFmqgZb9Y4o8XUmjqyiEsMRj2u0BYYf1FWTx56FeSMlRYsz
	p7huN0SnNEwsGPTUc+GKY4h99ksF9CWqdIajr9mCosPsU6OU0QDxpwhLR0PFAkYXRVIj7Fhhty4
	9uOsxe6hupwvX6kz9V3QOE5kCBTUKhRQk+hNxbtiuF4l0Xz5q/IUwQo6BG3gyv4S9FSU8cxge4k
	8s9j0YZj2VHY0HBhJ+Es7kXfA==
X-Received: by 2002:a17:90b:4c4b:b0:39e:4fb:fdcf with SMTP id 98e67ed59e1d1-39e050b7e5cmr2306437a91.14.1789451219209;
        Mon, 14 Sep 2026 22:46:59 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365ba729dsm47594159c88.14.2026.09.14.22.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 22:46:58 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] KVM: selftests: Add a test for nested virtual NMI support
Date: Tue, 15 Sep 2026 11:16:53 +0530
Message-ID: <20260915054653.227359-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260911102105.1927773-1-hemanth.selam@gmail.com>
References: <20260911102105.1927773-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM's virtual NMI support for nested guests has no test coverage; "V_NMI"
doesn't appear anywhere under tools/testing/selftests/kvm/.

Add a test that covers the vNMI controls L1 provides in vmcb12:

 - With vNMI enabled but no NMI requested, L2 runs without taking an NMI,
   and neither V_NMI_PENDING nor V_NMI_BLOCKING is set on exit.

 - With V_NMI_PENDING set, L2 takes the NMI on VMRUN.  Exiting to L1 from
   the NMI handler, i.e. before its IRET, shows the bits hardware wrote:
   V_NMI_PENDING cleared and V_NMI_BLOCKING set.  Once the handler IRETs,
   V_NMI_BLOCKING is cleared.  Repeat to verify NMIs can be delivered
   back to back.

 - Enabling vNMI without intercepting NMIs fails VMRUN with SVM_EXIT_ERR,
   per the consistency check in nested_vmcb_check_controls().

Add the V_NMI_{PENDING,BLOCKING,ENABLE} masks and X86_FEATURE_VNMI to the
selftest headers, which didn't define them.

Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---

v2:
 - Keep the update to nmi_fired ahead of the exit to L1 with barrier(),
   as vmmcall() doesn't clobber memory and so nothing stops the compiler
   from sinking the store past the VM-Exit (Sashiko AI review).  Note
   that vmmcall() not clobbering memory affects any test that hands data
   to L1 in a global; svm_nested_soft_inject_test.c works around it with
   atomics.  Happy to fix the helper instead if that's preferred.

v1: https://lore.kernel.org/all/20260911102105.1927773-1-hemanth.selam@gmail.com/

Tested on an AMD EPYC system with vNMI supported and enabled.  The test
passes consistently (50 consecutive runs, no failures), and the other
nested SVM selftests are unaffected.

The int_ctl values L1 observes across a delivered virtual NMI are:

  before VMRUN              V_NMI_ENABLE | V_NMI_PENDING
  exit from the NMI handler V_NMI_ENABLE | V_NMI_BLOCKING
  after the handler IRETs   V_NMI_ENABLE

To check the assertions aren't vacuous, each was inverted in turn and
confirmed to fail against actual behaviour:

  - Not requesting V_NMI_PENDING, so no NMI is delivered:
      nmi_fired == i
      0x0 != 0x1 (nmi_fired != i)

  - Asserting V_NMI_BLOCKING is clear while the NMI is in service:
      !(vmcb->control.int_ctl & (1 << 12))

  - Expecting VMRUN to succeed with V_NMI_ENABLE set and INTERCEPT_NMI
    cleared:
      vmcb->control.exit_code == SVM_EXIT_VMMCALL
      0xffffffffffffffff != 0x81

Where vNMI isn't available the test exits KSFT_SKIP rather than failing.

 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   1 +
 tools/testing/selftests/kvm/include/x86/svm.h |   9 ++
 .../selftests/kvm/x86/svm_nested_vnmi_test.c  | 132 ++++++++++++++++++
 4 files changed, 143 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_vnmi_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 96bab7002d39..92e1018e9c8a 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -121,6 +121,7 @@ TEST_GEN_PROGS_x86 += x86/svm_nested_clear_efer_svme
 TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_vmcb12_gpa
+TEST_GEN_PROGS_x86 += x86/svm_nested_vnmi_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_pat_test
 TEST_GEN_PROGS_x86 += x86/svm_lbr_nested_state
 TEST_GEN_PROGS_x86 += x86/svm_pmu_host_guest_test
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 6e6f70035508..71697a1d5b86 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -224,6 +224,7 @@ struct kvm_x86_cpu_feature {
 #define X86_FEATURE_PFTHRESHOLD         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 12)
 #define	X86_FEATURE_V_VMSAVE_VMLOAD	KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 15)
 #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
+#define X86_FEATURE_VNMI		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 25)
 #define X86_FEATURE_IDLE_HLT		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 30)
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
diff --git a/tools/testing/selftests/kvm/include/x86/svm.h b/tools/testing/selftests/kvm/include/x86/svm.h
index c8539166270e..5779fb285d79 100644
--- a/tools/testing/selftests/kvm/include/x86/svm.h
+++ b/tools/testing/selftests/kvm/include/x86/svm.h
@@ -140,6 +140,12 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define V_GIF_SHIFT 9
 #define V_GIF_MASK (1 << V_GIF_SHIFT)
 
+#define V_NMI_PENDING_SHIFT 11
+#define V_NMI_PENDING_MASK (1 << V_NMI_PENDING_SHIFT)
+
+#define V_NMI_BLOCKING_SHIFT 12
+#define V_NMI_BLOCKING_MASK (1 << V_NMI_BLOCKING_SHIFT)
+
 #define V_INTR_PRIO_SHIFT 16
 #define V_INTR_PRIO_MASK (0x0f << V_INTR_PRIO_SHIFT)
 
@@ -152,6 +158,9 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define V_GIF_ENABLE_SHIFT 25
 #define V_GIF_ENABLE_MASK (1 << V_GIF_ENABLE_SHIFT)
 
+#define V_NMI_ENABLE_SHIFT 26
+#define V_NMI_ENABLE_MASK (1 << V_NMI_ENABLE_SHIFT)
+
 #define AVIC_ENABLE_SHIFT 31
 #define AVIC_ENABLE_MASK (1 << AVIC_ENABLE_SHIFT)
 
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_vnmi_test.c b/tools/testing/selftests/kvm/x86/svm_nested_vnmi_test.c
new file mode 100644
index 000000000000..b4bde81a4e54
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/svm_nested_vnmi_test.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test KVM's virtual NMI (vNMI) support for nested guests: the consistency
+ * check on the vNMI controls in vmcb12, delivery of a virtual NMI to L2, and
+ * the V_NMI_PENDING/V_NMI_BLOCKING state L1 observes across the NMI.
+ *
+ * Copyright (C) 2026 Hemanth Selam <hemanth.selam@gmail.com>
+ */
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+#include "test_util.h"
+
+/* Number of virtual NMIs to deliver; more than one to prove it's repeatable. */
+#define NR_VNMIS	3
+
+static unsigned int nmi_fired;
+
+static void guest_nmi_handler(struct ex_regs *regs)
+{
+	nmi_fired++;
+
+	/*
+	 * Exit to L1 from NMI context, i.e. before this handler's IRET, so
+	 * that L1 can observe V_NMI_BLOCKING while the NMI is in service.
+	 * Keep the update to nmi_fired ahead of the exit, as vmmcall() doesn't
+	 * clobber memory and L1 reads nmi_fired as soon as L2 exits.
+	 */
+	barrier();
+	vmmcall();
+}
+
+static void l2_guest_code(void)
+{
+	vmmcall();
+}
+
+static void l1_vnmi_setup(struct svm_test_data *svm)
+{
+	struct vmcb *vmcb = svm->vmcb;
+
+	generic_svm_setup(svm, l2_guest_code);
+
+	/* KVM requires L1 to intercept NMIs in order to enable vNMI. */
+	vmcb->control.intercept |= BIT(INTERCEPT_NMI);
+	vmcb->control.int_ctl |= V_NMI_ENABLE_MASK;
+}
+
+static void l1_guest_code(struct svm_test_data *svm)
+{
+	struct vmcb *vmcb = svm->vmcb;
+	unsigned int i;
+
+	/* Without a pending virtual NMI, L2 runs to its VMMCALL untouched. */
+	l1_vnmi_setup(svm);
+
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	GUEST_ASSERT_EQ(nmi_fired, 0);
+	GUEST_ASSERT(!(vmcb->control.int_ctl & V_NMI_PENDING_MASK));
+	GUEST_ASSERT(!(vmcb->control.int_ctl & V_NMI_BLOCKING_MASK));
+
+	for (i = 1; i <= NR_VNMIS; i++) {
+		/* Request a virtual NMI; L2 must take it on VMRUN. */
+		l1_vnmi_setup(svm);
+		vmcb->control.int_ctl |= V_NMI_PENDING_MASK;
+
+		run_guest(vmcb, svm->vmcb_gpa);
+
+		/*
+		 * The NMI was delivered and L2 exited from the handler, so
+		 * hardware has consumed the request and blocked further NMIs.
+		 */
+		GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+		GUEST_ASSERT_EQ(nmi_fired, i);
+		GUEST_ASSERT(!(vmcb->control.int_ctl & V_NMI_PENDING_MASK));
+		GUEST_ASSERT(vmcb->control.int_ctl & V_NMI_BLOCKING_MASK);
+
+		/* Resume L2 so the handler can IRET, which unblocks NMIs. */
+		vmcb->save.rip = vmcb->control.next_rip;
+
+		run_guest(vmcb, svm->vmcb_gpa);
+		GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+		GUEST_ASSERT_EQ(nmi_fired, i);
+		GUEST_ASSERT(!(vmcb->control.int_ctl & V_NMI_BLOCKING_MASK));
+	}
+
+	/*
+	 * Enabling vNMI without intercepting NMIs is illegal, as L1 would have
+	 * no way of observing the NMIs it is nominally responsible for.
+	 */
+	vmcb->control.intercept &= ~BIT(INTERCEPT_NMI);
+
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_ERR);
+
+	GUEST_DONE();
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	gva_t svm_gva;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VNMI));
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+
+	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
+
+	vcpu_alloc_svm(vm, &svm_gva);
+	vcpu_args_set(vcpu, 1, svm_gva);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		/* NOT REACHED */
+	case UCALL_DONE:
+		break;
+	default:
+		TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
+	}
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.48.1

