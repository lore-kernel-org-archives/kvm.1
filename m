Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24B343890
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790400786; cv=none; b=axtM18wNzN8NMnfNiNHAevSwHtuhK4c+HT/ZGJA1I+42G7ZHY9fhqg2bAyOKkQjlFUpjExIW0Zj7xB5n/jeww59X+X3FM1HNIjPs8SeacJxjAFiQTg9QGUlLY9Cl9KmwiClzQwbhdbFwTWw9pJL7+AQH40HlemOTLLVh3DYXGT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790400786; c=relaxed/simple;
	bh=S8EZYgauiYFGQ9JdXTv5WC4V68ER6Xnsxqb7Sup94oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/JqwAKtqEAb4ysGJ49XcZ2ourMruxl7OrNxh/VlKHWdBFzrRlCnJE+giSQT6FnR6z6vdZVeLwSFLqJBgditGBk+2KrgYrOGXRTwZq72trt/dx+Azy92kClJGzs59mw05tBBgN0DC1GutDRUlhowCcO1px7LMpNAt0qdrPRPTVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwwLSiom; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwwLSiom"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790400783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PvG6JfLRei+3n5VEQinhCbuwjjnvMWnn+dcs8A1vLHo=;
	b=cwwLSiom8SfHBlTgwK7OYiDcAKTT+ODYoQeBU8i/osYWx9PjVyAg++Ymq/y9hU0HfcCQ4b
	waVrR69OpPyNLqlYUgkgE6CxNuh92nRZrhXAdM2vy87nMrt9vKt78zgZhVVwRKmY1u1kGk
	/AWqJ+uzlQ34LgM3z6ee/mPcMwWjsZk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-_ZwttMyIMPeEfwBIcZdk7Q-1; Sat,
 26 Sep 2026 01:33:01 -0400
X-MC-Unique: _ZwttMyIMPeEfwBIcZdk7Q-1
X-Mimecast-MFC-AGG-ID: _ZwttMyIMPeEfwBIcZdk7Q_1790400780
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BA761954B24;
	Sat, 26 Sep 2026 05:33:00 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC8111956086;
	Sat, 26 Sep 2026 05:32:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH 07/11] KVM: selftests: Add x2APIC MSR test for inhibiting APICv while nested
Date: Sat, 26 Sep 2026 01:32:49 -0400
Message-ID: <20260926053253.195597-8-pbonzini@redhat.com>
In-Reply-To: <20260926053253.195597-1-pbonzini@redhat.com>
References: <20260926053253.195597-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Sean Christopherson <seanjc@google.com>

Add a selftest to verify that KVM intercepts x2APIC MSR accesses for L1
after APICv is inhibited while L2 is active.  This is a regression test for
an AVIC bug where KVM would skip updating x2APIC MSR intercepts while L2
is active, thus giving L1 access to a wide swath of L0's x2APIC surface.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260710162052.2188574-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/nested_x2apic_test.c    | 117 ++++++++++++++++++
 2 files changed, 118 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_x2apic_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 6a1482e3a286..752f81b070fa 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -103,6 +103,7 @@ TEST_GEN_PROGS_x86 += x86/nested_tdp_fault_test
 TEST_GEN_PROGS_x86 += x86/nested_tsc_adjust_test
 TEST_GEN_PROGS_x86 += x86/nested_tsc_scaling_test
 TEST_GEN_PROGS_x86 += x86/nested_vmsave_vmload_test
+TEST_GEN_PROGS_x86 += x86/nested_x2apic_test
 TEST_GEN_PROGS_x86 += x86/platform_info_test
 TEST_GEN_PROGS_x86 += x86/pmu_counters_test
 TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
diff --git a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c b/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
new file mode 100644
index 000000000000..e77b4c347272
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "vmx.h"
+#include "svm_util.h"
+
+/*
+ * Use the kernel's posted interrupt vectors to minimize the risk of crashing
+ * the host if KVM is buggy.  Note, the vectors aren't set in stone, ideally
+ * these will be kept up-to-date if the kernel vectors change, but it's "fine"
+ * if they are stale.
+ */
+#define POSTED_INTR_VECTOR		0xf2
+#define POSTED_INTR_WAKEUP_VECTOR	0xf1
+#define POSTED_INTR_NESTED_VECTOR	0xf0
+
+static volatile unsigned int nr_irqs;
+
+static void guest_irq_handler(struct ex_regs *regs)
+{
+	nr_irqs++;
+	x2apic_write_reg(APIC_EOI, 0);
+}
+
+static void l2_guest_code(void)
+{
+	wrmsr(MSR_IA32_APICBASE, rdmsr(MSR_IA32_APICBASE) & GENMASK_ULL(11, 0));
+	asm volatile("cpuid" ::: "eax", "ebx", "ecx", "edx");
+}
+
+static void l1_svm_code(struct svm_test_data *svm)
+{
+	struct vmcb_control_area *ctrl = &svm->vmcb->control;
+
+	generic_svm_setup(svm, l2_guest_code);
+	ctrl->intercept |= BIT_ULL(INTERCEPT_CPUID) | BIT_ULL(INTERCEPT_MSR_PROT);
+
+	run_guest(svm->vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(ctrl->exit_code, SVM_EXIT_CPUID);
+
+	stgi();
+}
+
+static void l1_vmx_code(struct vmx_pages *vmx)
+{
+	u64 control;
+
+	GUEST_ASSERT_EQ(prepare_for_vmx_operation(vmx), true);
+	GUEST_ASSERT_EQ(load_vmcs(vmx), true);
+
+	prepare_vmcs(vmx, NULL);
+	GUEST_ASSERT_EQ(vmwrite(GUEST_RIP, (unsigned long)l2_guest_code), 0);
+
+	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
+	control |= CPU_BASED_USE_MSR_BITMAPS;
+	GUEST_ASSERT_EQ(vmwrite(CPU_BASED_VM_EXEC_CONTROL, control), 0);
+
+	GUEST_ASSERT(!vmlaunch());
+	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_CPUID);
+}
+
+static void l1_guest_code(void *test_data)
+{
+	x2apic_enable();
+
+	if (this_cpu_has(X86_FEATURE_SVM))
+		l1_svm_code(test_data);
+	else
+		l1_vmx_code(test_data);
+
+	sti_nop();
+
+	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT | POSTED_INTR_VECTOR);
+	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT | POSTED_INTR_WAKEUP_VECTOR);
+	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT | POSTED_INTR_NESTED_VECTOR);
+	GUEST_ASSERT_EQ(nr_irqs, 3);
+	GUEST_DONE();
+}
+
+int main(int argc, char *argv[])
+{
+	gva_t nested_test_data_gva;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_has(X86_FEATURE_VMX));
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+	vm_install_exception_handler(vm, POSTED_INTR_VECTOR, guest_irq_handler);
+	vm_install_exception_handler(vm, POSTED_INTR_WAKEUP_VECTOR, guest_irq_handler);
+	vm_install_exception_handler(vm, POSTED_INTR_NESTED_VECTOR, guest_irq_handler);
+
+	if (kvm_cpu_has(X86_FEATURE_SVM))
+		vcpu_alloc_svm(vm, &nested_test_data_gva);
+	else
+		vcpu_alloc_vmx(vm, &nested_test_data_gva);
+
+	vcpu_args_set(vcpu, 1, nested_test_data_gva);
+
+	vcpu_run(vcpu);
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_DONE:
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		break;
+	default:
+		TEST_FAIL("Expected DONE, got unexpected ucall %lu", uc.cmd);
+	}
+
+	kvm_vm_free(vm);
+}
-- 
2.52.0


