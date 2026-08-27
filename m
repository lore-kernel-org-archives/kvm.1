Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEBB2D8376
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787809141; cv=none; b=u+UR4fQl09JMYUJSj+KoDZghlCfw/NnIjrtm8pY25uTP680Tkwqlvh4xucTDIgOGs43CKAyqsLpMpQaoIxpOm1Poe4QkQVzksz/M2lLaeCpDR22Y0XFRu3vbodNuCuS7Fh0DvV+SzkHJfIfYpu/jM5J7sU7EEhOPH3Gdg6SRpz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787809141; c=relaxed/simple;
	bh=yh/nuBrpJk4pdFX6syyMLd/OT8aOmFZBf6rHIVcFeV8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AJI8ZSe6gmpwu0JZfOgwpdLeNjh+Hm+Hx090U0eydOsnTG5QEaUefYZDdXZfswT0ycsRDuMbfZDu6uWuE/9SYfP2jXdTp5UaGpJpVQDObmSqN6GkjxhXGRaSgG7D76Je1VSsDHBITJfSGOY+9w/Gjw7JrLzRzkZVt6l2zJahz+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E3cksqud; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E3cksqud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=gtfcjNcZ+6EVpM4Jy2uE/u4yU4hQyET8+6Vy41L/QlU=;
	b=E3cksqudTqpZYqqgCbjQJyNIbDPmtjLQiNq86J/bAVN3rkWwcDEZmuL1wpKyZU
	jyGOG7CFQL+rhsreBnjTreXKWOQWaYFGBn/Vth2O6LSKY3GT9FlfLTjMvDbwxqyi
	SYjdbSth+0TYCXVJ1YBMDg+2d/cNSpu0Dd79CAGiZxyjk=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgC3RCFezY9qMSPdOQ--.50200S2;
	Thu, 27 Aug 2026 13:38:38 +0800 (CST)
Date: Thu, 27 Aug 2026 13:38:38 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH 2/2] selftests: kvm: Add regression test for nSVM debug
 register state
Message-ID: <ao_NXhr-3K4tMqpa@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ao_Ms5alWwKa30U8@192.168.1.215>
X-CM-TRANSID:PygvCgC3RCFezY9qMSPdOQ--.50200S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrW7Jr1kXr18Ar4rXFW8JFb_yoWrWw4kp3
	4I9w1qkr40gr93AF1xG3Z8ZFWSkFykGF18Gryag3srZFs3G3Z7Jr1IgFy5AFn5CrW0qr1r
	Aa45Ja4Ygw4UJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UDb1nUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3h4J+2qPzV4YPAAA3g

From: Hao Zhang <zhanghao1@kylinos.cn>

Add a regression test for debug register state restoration when KVM
emulates a nested SVM VM-Exit from L2 to L1.

Give L1 and L2 distinct DR6 and DR7 values, run L2 until a VMMCALL
VM-Exit, and then verify that KVM saved L2's debug register state to
vmcb12 while restoring L1's architectural DR6 and DR7 values.  Without
the fix, L1 observes stale L2 DR6 state and loses its DR7 state after
the nested VM-Exit.

Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 tools/testing/selftests/kvm/Makefile.kvm           |   1 +
 .../selftests/kvm/x86/svm_nested_debug_regs_test.c | 104 +++++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_debug_regs_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 1bde5ab306cf..65ad842eecd4 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -122,6 +122,7 @@ TEST_GEN_PROGS_x86 += x86/svm_nested_clear_efer_svme
 TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_vmcb12_gpa
+TEST_GEN_PROGS_x86 += x86/svm_nested_debug_regs_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_pat_test
 TEST_GEN_PROGS_x86 += x86/svm_lbr_nested_state
 TEST_GEN_PROGS_x86 += x86/svm_pmu_host_guest_test
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_debug_regs_test.c b/tools/testing/selftests/kvm/x86/svm_nested_debug_regs_test.c
new file mode 100644
index 000000000000..6ef29cf0a819
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/svm_nested_debug_regs_test.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Nested SVM debug register state test.
+ */
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+
+#define DR6_ACTIVE_LOW	0xffff0ff0
+#define DR6_B0		BIT(0)
+#define DR6_BS		BIT(14)
+#define DR7_FIXED_1	0x400
+#define DR7_GE		BIT(9)
+
+#define L1_DR6		(DR6_ACTIVE_LOW | DR6_BS)
+#define L2_DR6		(DR6_ACTIVE_LOW | DR6_B0)
+#define L1_DR7		(DR7_FIXED_1 | DR7_GE)
+#define L2_DR7		(DR7_FIXED_1)
+
+static inline u64 get_dr6(void)
+{
+	u64 val;
+
+	asm volatile("mov %%dr6, %0" : "=r"(val) : : "memory");
+	return val;
+}
+
+static inline u64 get_dr7(void)
+{
+	u64 val;
+
+	asm volatile("mov %%dr7, %0" : "=r"(val) : : "memory");
+	return val;
+}
+
+static inline void set_dr6(u64 val)
+{
+	asm volatile("mov %0, %%dr6" : : "r"(val) : "memory");
+}
+
+static inline void set_dr7(u64 val)
+{
+	asm volatile("mov %0, %%dr7" : : "r"(val) : "memory");
+}
+
+static void l2_guest_code(void)
+{
+	GUEST_ASSERT_EQ(get_dr6(), L2_DR6);
+	GUEST_ASSERT_EQ(get_dr7(), L2_DR7);
+	vmmcall();
+}
+
+static void l1_guest_code(struct svm_test_data *svm)
+{
+	struct vmcb *vmcb = svm->vmcb;
+
+	set_dr6(L1_DR6);
+	set_dr7(L1_DR7);
+
+	generic_svm_setup(svm, l2_guest_code);
+	vmcb->save.dr6 = L2_DR6;
+	vmcb->save.dr7 = L2_DR7;
+
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+
+	GUEST_ASSERT_EQ(vmcb->save.dr6, L2_DR6);
+	GUEST_ASSERT_EQ(vmcb->save.dr7, L2_DR7);
+	GUEST_ASSERT_EQ(get_dr6(), L1_DR6);
+	GUEST_ASSERT_EQ(get_dr7(), L1_DR7);
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
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+	vcpu_alloc_svm(vm, &svm_gva);
+	vcpu_args_set(vcpu, 1, svm_gva);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		break;
+	case UCALL_DONE:
+		break;
+	default:
+		TEST_FAIL("Unknown ucall %lu", uc.cmd);
+	}
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.15.0

