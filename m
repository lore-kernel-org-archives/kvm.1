Received: from out198-10.us.a.mail.aliyun.com (out198-10.us.a.mail.aliyun.com [47.90.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F0402422;
	Mon, 29 Jun 2026 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737883; cv=none; b=E4CwGDULeyiWl1MKZKvaNps9W0OUyDiMN3y17yttS+vcTLGJyQfEiukwS4q2Pb8LAUyjH8jFVyK8dYo29wUogpyRNJwIsKzVIvG0RpsdDZNlT7QHMyDGyI3JrCR5TQDe7TlhT4tjIVxO9xJY64i0hJ+HTIgHB96Xfht8t6NtEAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737883; c=relaxed/simple;
	bh=L+3z5OBW8Tqq5z5OhOgHrkPOoAIE8vrLsS9nHz3N0LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwAIG+AfMdCurekOBacr6lKdBoiTGbc0h04max5H1CVrSNLYmiop0HuLV1avtVIyBlbSIOwotunpRKGEOt9HDd49onNyH5C670LM6+YKH1U7Xxddph+BcI7HUxCvjKVCYDNYBhGV2VTeJGWDIsnYbJBaapiRZ+qR+gBnzwYeXSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0747187|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00377912-3.63415e-05-0.996185;FP=12594999332404137915|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.i8gsqO3_1782737537;
Received: from tina-home.taild49858.ts.net(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.i8gsqO3_1782737537 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 29 Jun 2026 20:52:18 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] KVM: selftests: Add nested SVM DecodeAssists test
Date: Mon, 29 Jun 2026 20:52:05 +0800
Message-ID: <20260629125205.52394-3-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629125205.52394-1-zhang_wei@open-hieco.net>
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest for nested SVM DecodeAssists virtualization.

Run L2 with a non-present NPT mapping to trigger a nested page fault, then
verify that L1 sees non-zero DecodeAssist state in VMCB12 and that the
reported instruction bytes match the instruction at L2's RIP.  This covers
the path that copies hardware-provided decode information from VMCB02 to
VMCB12.

Re-enter L2 at a VMMCALL after the #NPF and verify that any reported bytes
match the new RIP.  KVM reuses VMCB02 across nested runs, so the second
exit checks that DecodeAssist state from the earlier #NPF is not leaked
into an unrelated nested VM-Exit.

Also verify that KVM exposes DecodeAssists in L1's SVM CPUID leaf when the
feature is supported by the host.

Tested-by: Yongwei Xu <xuyongwei@hygon.cn>
Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/include/x86/processor.h     |  1 +
 .../kvm/x86/svm_nested_decode_assists_test.c  | 99 +++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9118a5a51b89..23bf51074392 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -114,6 +114,7 @@ TEST_GEN_PROGS_x86 += x86/vmx_preemption_timer_test
 TEST_GEN_PROGS_x86 += x86/svm_vmcall_test
 TEST_GEN_PROGS_x86 += x86/svm_int_ctl_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_clear_efer_svme
+TEST_GEN_PROGS_x86 += x86/svm_nested_decode_assists_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_vmcb12_gpa
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 77f576ee7789..ee4520ff2f89 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -201,6 +201,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_LBRV		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 1)
 #define	X86_FEATURE_NRIPS		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 3)
 #define X86_FEATURE_TSCRATEMSR          KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 4)
+#define X86_FEATURE_DECODEASSISTS       KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 7)
 #define X86_FEATURE_PAUSEFILTER         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 10)
 #define X86_FEATURE_PFTHRESHOLD         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 12)
 #define	X86_FEATURE_V_VMSAVE_VMLOAD	KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 15)
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c b/tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c
new file mode 100644
index 000000000000..6b5d38d9d36c
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+
+#define L2_GUEST_STACK_SIZE 64
+
+static uint64_t npf_target __aligned(PAGE_SIZE);
+
+static void l2_guest_code(void)
+{
+	asm volatile("mov (%0), %%rax" : : "r"(&npf_target) : "rax", "memory");
+	GUEST_FAIL("L2 access did not cause a nested page fault");
+}
+
+static void l2_vmmcall_code(void)
+{
+	asm volatile("vmmcall");
+	GUEST_FAIL("L2 did not exit on VMMCALL");
+}
+
+/*
+ * Whenever hardware reports DecodeAssist information (insn_len != 0), the bytes
+ * KVM reflects into VMCB12 must be the instruction at the current RIP, never
+ * stale bytes carried over from a previous L2 exit.
+ */
+static void assert_decode_assists_sane(struct vmcb *vmcb)
+{
+	GUEST_ASSERT(vmcb->control.insn_len <=
+		     sizeof(vmcb->control.insn_bytes));
+	if (vmcb->control.insn_len)
+		GUEST_ASSERT(!memcmp(vmcb->control.insn_bytes,
+				     (void *)vmcb->save.rip,
+				     vmcb->control.insn_len));
+}
+
+static void l1_guest_code(struct svm_test_data *svm)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb = svm->vmcb;
+
+	GUEST_ASSERT(this_cpu_has(X86_FEATURE_DECODEASSISTS));
+
+	generic_svm_setup(svm, l2_guest_code,
+			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	/* A real nested #NPF must reflect valid decode information to L1. */
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_NPF);
+	GUEST_ASSERT(vmcb->control.insn_len);
+	assert_decode_assists_sane(vmcb);
+
+	/*
+	 * Redirect L2 past the still-faulting access to a VMMCALL.  KVM reuses
+	 * its internal VMCB02, which now holds the #NPF's decode bytes, so this
+	 * exercises the path that must clear DecodeAssist state and ensures the
+	 * prior exit's bytes are not leaked into a subsequent exit.
+	 */
+	vmcb->save.rip = (u64)l2_vmmcall_code;
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	assert_decode_assists_sane(vmcb);
+
+	GUEST_DONE();
+}
+
+int main(int argc, char *argv[])
+{
+	gva_t svm_gva, npf_gva;
+	gpa_t npf_gpa;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	u64 *pte;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_NPT));
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_DECODEASSISTS));
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+	vm_enable_npt(vm);
+	vcpu_alloc_svm(vm, &svm_gva);
+	npf_gva = (gva_t)&npf_target;
+	npf_gpa = addr_gva2gpa(vm, npf_gva);
+
+	tdp_identity_map_default_memslots(vm);
+	pte = tdp_get_pte(vm, npf_gpa);
+	*pte &= ~PTE_PRESENT_MASK(&vm->stage2_mmu);
+
+	vcpu_args_set(vcpu, 1, svm_gva);
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.43.0

