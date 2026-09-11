Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53002418340
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122074; cv=none; b=KEFTAJFznYvr0pCgm8v1WwMcETaewwwtIhjL4nsi+Rju5ygNPexTRR+gCSC6srtoKgdAFoLZ+CwEv7r52JHLI4ChT8Jjhgh489AinE2g6p15i20deE3p/gGHx2RVmHhvtyQ5IKAQGBXo0M0/djZ/Px6xScjKTPKTDvm8qQrotPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122074; c=relaxed/simple;
	bh=FkCvNJqJXXmtGAj46QLbuYrsBVXeQMeFMH3sDZF2BDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SmSENkkXXCFE/v4DTV10PYUIHRdDJFoVnobXT351uYe7FNDgm4vPLfxqeVYGYu1Fah4OvN65kt4K9BE4AI3ecuQkq3gCHYUSPV5eapBeg6JQX4wGRFfMcYRmyOjQIEGSPIn0CZGSfzpbqQk7yTx4u61fUmqCAG0XXOkQP/homzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0OrzQ6r; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0OrzQ6r"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so713730a91.2
        for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 03:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789122072; x=1789726872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VO8IwKriiEzsim6wTkrEMStqXoab8WUQmDv+TV1yfBA=;
        b=A0OrzQ6rLNdzfVBqLn/hCiNtHTbEwL/LwdupTZjqlX1vf7ssrrYWovE5l0v5dIIzjO
         h3OTibcAM4V79d388Pl+n3GxZ7Jgg6/fI6fQKvzwIyk+A+caSnynneyGn5cvtPeTHGL+
         NviYSf4OM6NmCIfXBnCKop/EkHEIQLcb6uH0iaQDyX6ufSa8u3hL4MiQTft/1Yyk/ug4
         fnciKhELhOKaIETRBM8z7X3M9IIA6Geh3pMMf/N/m0RDzU0Nrzf1qciHfk02nM07LDST
         pONrqtXBnAjpfZyw6HlaKYoiRArsJ/r+uh9Ou8mG71rmLv6auZIhWM18PFYM804QWmn4
         Fl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789122072; x=1789726872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VO8IwKriiEzsim6wTkrEMStqXoab8WUQmDv+TV1yfBA=;
        b=b6n4IcBqbJl5S0zpQ8qigPqN62R2hWlodHCUTPGw6SvFwrQL41vkg5g+yEKH/cSit0
         W8ln2+zCjDcC2CXQGbzjzNkqP7OM4UAtts9ML/EJneaVcqLLQVi/MG1ZGqpfJfJ90M9M
         NVLrwUlo2oMVpzwoqT+0M9q6lqUCJaQB2dNTiaV8XWei7BSV33xc+IH8uMzF/n1rQqQv
         vafFPMeROrfecRdTCNpFPAHl8JFKSj6YGC5GbPvUXBj8XSUMP8qLsQanHPRh4Yp6XeYZ
         Jnj7wK32l7Zi7ykxET2r7Gkm/k3r2UqvBaRTbLo1KJdRXGfgN2jXRpo8/BIdysU3hehK
         ZBnw==
X-Gm-Message-State: AFuF++n+jZW8lRfHC44GbxU4kTsLZF+fzg4z/mtIGWy8WPIjzciKIuD5
	Y1Cp3wwNgD0M54nUkj3ASN9dTE73/yxZIWPX+mux4Alieci/5gJRf1yd
X-Gm-Gg: AYBFou0cFB1jsz/fwmGyCd8UieXZ4lo+1pfBcLO9/hYnRh+ynjn8sVZW/Soru76llcv
	HKcxLcxuuNZShF68otSeZMWGp5O+9p9Q5HqIAO82/k6jxD8Zbk92NlocXBvDL4bsZI/lumlptMK
	EjPgwGfW57+0tWXqZfQ6imthpet2t2S+6doTFF+p+ICxHcNKvxfNTALh+1wKjR3NDBZUf43CyjU
	sJcI04CnfOMt7OLmQdCWU0T8DQ46f8SBZDPSJgLS7PPFWvkHq6LtG3S3xBVP7g5s4ItdPcR+K93
	SST7hnVlCrYu1dM8+OLpMzJMfmvREAbVpTslpUuYBoiBM7QkU4sALRuXdKaGxxS59pVWR6t04Pw
	GBuDRcjiTU9oY8TBKSboCyyxl1c1dxxTJOgRkr68iAovByn33H0INJ3a3x/AmZZI3tjeczz5dxF
	ibNM/qHM92kHxoRvDVYH8iaTipP2UU4VKq0XcieOGx08xOaSVrOlE/ztnmaZziuHtvBBLgmYmpv
	dBjmpKth8zcFmQq0YZHUkHjQg==
X-Received: by 2002:a17:90b:1651:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-39d9bbf93c5mr4745006a91.2.1789122071437;
        Fri, 11 Sep 2026 03:21:11 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8ead8sm5701294c88.10.2026.09.11.03.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:21:10 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Add a test for nested virtual NMI support
Date: Fri, 11 Sep 2026 15:51:05 +0530
Message-ID: <20260911102105.1927773-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
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

Tested on an AMD EPYC system with vNMI supported and enabled.  The test
passes consistently (50 consecutive runs, no failures).

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
No regressions in the other nested SVM selftests.

 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   1 +
 tools/testing/selftests/kvm/include/x86/svm.h |   9 ++
 .../selftests/kvm/x86/svm_nested_vnmi_test.c  | 129 ++++++++++++++++++
 4 files changed, 140 insertions(+)
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
index 000000000000..4e9916a837dd
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/svm_nested_vnmi_test.c
@@ -0,0 +1,129 @@
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
+	 */
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

